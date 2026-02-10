-- Custom neotest adapter for godog (Go BDD/Cucumber)
local lib = require("neotest.lib")

local M = {}

---@class neotest.Adapter
---@field name string
M.Adapter = { name = "neotest-godog" }

---Find the project root directory
---@param dir string @Directory to start searching from
---@return string | nil @Absolute root dir path or nil
function M.Adapter.root(dir)
  local gomod = lib.files.match_root_pattern("go.mod")(dir)
  if gomod then
    -- Check if there are feature files in the project
    local features = vim.fn.globpath(gomod, "**/*.feature", false, true)
    if #features > 0 then
      return gomod
    end
  end
  return nil
end

---Filter directories when searching for test files
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function M.Adapter.filter_dir(name, rel_path, root)
  -- Skip common non-test directories
  local dominated = { "vendor", "node_modules", ".git", ".cache" }
  for _, dom in ipairs(dominated) do
    if name == dom then
      return false
    end
  end
  return true
end

---Check if a file is a test file
---@param file_path string
---@return boolean
function M.Adapter.is_test_file(file_path)
  return vim.endswith(file_path, ".feature")
end

---Parse feature file to extract scenarios
---@param path string
---@return table
local function parse_feature_file(path)
  local content = lib.files.read(path)
  local positions = {}

  local lines = vim.split(content, "\n")
  local feature_name = nil
  local feature_line = nil

  for line_num, line in ipairs(lines) do
    -- Match Feature:
    local feature_match = line:match("^%s*Feature:%s*(.+)$")
    if feature_match then
      feature_name = vim.trim(feature_match)
      feature_line = line_num
    end

    -- Match Scenario: or Scenario Outline:
    local scenario_match = line:match("^%s*Scenario:%s*(.+)$")
        or line:match("^%s*Scenario Outline:%s*(.+)$")
    if scenario_match then
      table.insert(positions, {
        type = "test",
        name = vim.trim(scenario_match),
        line = line_num,
        col = 1,
      })
    end
  end

  return {
    feature_name = feature_name,
    feature_line = feature_line,
    scenarios = positions,
  }
end

---Given a file path, parse all the tests within it.
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function M.Adapter.discover_positions(file_path)
  local parsed = parse_feature_file(file_path)

  if not parsed.feature_name then
    return nil
  end

  local feature_line = (parsed.feature_line or 1) - 1
  local content = lib.files.read(file_path)
  local lines = vim.split(content, "\n")
  local last_line = math.max(0, #lines - 1)

  -- Build a flat list of positions, sorted by range (file first, then tests)
  -- parse_tree expects: { file_pos, test_pos1, test_pos2, ... }
  -- and builds the tree based on range containment
  local positions = {
    {
      id = file_path,
      name = parsed.feature_name,
      path = file_path,
      range = { feature_line, 0, last_line, 0 },
      type = "file",
    },
  }

  for _, scenario in ipairs(parsed.scenarios) do
    local scenario_line = scenario.line - 1
    table.insert(positions, {
      id = file_path .. "::" .. scenario.name,
      name = scenario.name,
      path = file_path,
      range = { scenario_line, 0, scenario_line, 0 },
      type = "test",
    })
  end

  return lib.positions.parse_tree(positions)
end

---Build the godog command using go test with *testing.T
---@param args neotest.RunArgs
---@return neotest.RunSpec | nil
function M.Adapter.build_spec(args)
  local position = args.tree:data()
  local root = M.Adapter.root(position.path)

  if not root then
    return nil
  end

  -- Use go test to run godog tests (modern approach)
  local command = { "go", "test", "-v" }
  
  -- Add test package path
  table.insert(command, "./features")

  -- Determine what to run based on position type
  if position.type == "test" then
    -- Run specific scenario by converting scenario name to Go test name format
    -- Go test names replace spaces with underscores
    local test_name = position.name:gsub(" ", "_")
    -- Use -run flag to filter specific test
    table.insert(command, "-run")
    table.insert(command, "TestFeatures/" .. test_name)
  elseif position.type == "file" then
    -- Run entire feature file using godog.paths
    local feature_rel_path = position.path:gsub("^" .. vim.pesc(root .. "/"), "")
    table.insert(command, "-godog.paths=" .. feature_rel_path)
  end
  
  -- Use progress format for less verbose output
  table.insert(command, "-godog.format=progress")

  return {
    command = command,
    context = {
      file = position.path,
      position = position,
    },
    cwd = root,
  }
end

---Parse go test output to determine test results
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function M.Adapter.results(spec, result, tree)
  local results = {}
  local position = spec.context.position

  -- Read output (stdout/stderr)
  local output = result.output
  local success, output_data = pcall(lib.files.read, output)
  
  if not success then
    output_data = ""
  end
  
  -- Determine status based on exit code
  local status = result.code == 0 and "passed" or "failed"

  -- Parse go test -v output
  -- Format: --- PASS: TestFeatures/Scenario_name (0.12s)
  --     or: --- FAIL: TestFeatures/Scenario_name (0.12s)
  local lines = vim.split(output_data, "\n")
  
  for _, line in ipairs(lines) do
    -- Match test result lines
    local test_status, test_name = line:match("^%s*%-%-%-% (PASS|FAIL):%s*TestFeatures/(.+)%s*%(")
    
    if test_status and test_name then
      -- Convert Go test name back to scenario name
      -- Go replaces spaces with underscores and special chars
      local scenario_name = test_name:gsub("_", " ")
      local scenario_id = spec.context.file .. "::" .. scenario_name
      
      -- Determine status
      local scenario_status = test_status == "PASS" and "passed" or "failed"
      
      results[scenario_id] = {
        status = scenario_status,
        output = output,
      }
    end
  end

  -- Fallback: if no parsed results, use exit code and match against tree
  if vim.tbl_isempty(results) then
    if position.type == "test" then
      results[position.id] = {
        status = status,
        output = output,
      }
    elseif position.type == "file" then
      -- Mark all tests in file with same status
      for _, node in tree:iter_nodes() do
        local data = node:data()
        if data and data.type == "test" then
          results[data.id] = {
            status = status,
            output = output,
          }
        end
      end
      results[position.id] = {
        status = status,
        output = output,
      }
    end
  end

  return results
end

---Create the adapter
---@param opts table|nil
---@return neotest.Adapter
function M.setup(opts)
  opts = opts or {}

  if opts.godog_cmd then
    M.godog_cmd = opts.godog_cmd
  end

  return M.Adapter
end

setmetatable(M, {
  __call = function(_, opts)
    return M.setup(opts)
  end,
})

return M
