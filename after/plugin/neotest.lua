-- Config for neotest
require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
})

require("neotest-rspec")({
  rspec_cmd = function()
    return vim.tbl_flatten({
      "bundle",
      "exec",
      "rspec",
    })
  end
})

require("neotest-jest")({
  jestCommand = "npx vue-cli-service test:unit",
  jestConfig = "jest.config.js",
  env = { CI = true },
  cwd = function(path)
    return vim.fn.getcwd()
  end,
})
