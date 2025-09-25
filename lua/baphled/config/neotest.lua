-- Config for neotest
require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
})

-- Project directory
local file_path = vim.fn.expand("%:p:h")

-- Check whether vue-cli-service is available
-- If not, then search for jest
local npm_bin_path = file_path .. "/node_modules/.bin/"
local vue_cli_available = vim.fn.executable(npm_bin_path .. "vue-cli-service")
local jest_available = vim.fn.executable(npm_bin_path .. "jest")
local jestCommand = ""

if vue_cli_available == 1 then
  jestCommand = "npx vue-cli-service test:unit --detectOpenHandles"
elseif jest_available == 1 then
  jestCommand = "npx jest --detectOpenHandles"
else
  print("No test runner found")
end

require("neotest").setup({
  quickfix = {
    enable = true,
  },
  floating = {
    border = "rounded",
    max_height = 0.8,
    max_width = 0.8,
    options = {}
  },
  adapters = {
    require("nvim-ginkgo"),
    require("neotest-plenary"),
    require("neotest-rspec")({
      rspec_cmd = function()
        return vim.iter({
          "bundle",
          "exec",
          "rspec",
        }):flatten():totable()
      end,
    }),
    require("neotest-jest")({
      -- Run jest directly, not via npm
      jestCommand = "npx jest",
      -- Always start from your project root
      cwd = function(_) return vim.fn.getcwd() end,
      -- Be explicit about the config file
      jestConfigFile = "jest.config.js",
      -- Keep stdout clean so the JSON is parseable
      jestArguments = function(args)
        table.insert(args, "--ci")        -- non-interactive, stable output
        table.insert(args, "--coverage")        -- non-interactive, stable output
        table.insert(args, "--runInBand") -- (optional) avoids worker interleave noise
        table.insert(args, "--silent")    -- suppress console.log/error that can corrupt JSON parsing
        return args
      end,
    }),
  },
})
