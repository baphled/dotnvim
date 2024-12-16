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
    open = function()
      vim.cmd("Trouble quickfix")
    end,
  },
  adapters = {
    require("neotest-rspec")({
      rspec_cmd = function()
        return vim.iter({
          "bundle",
          "exec",
          "rspec",
        }):flatten():totable()
      end,
    }),
    require('neotest-jest')({
      jestCommand = jestCommand,
      jestConfig = "jest.config.js",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})
