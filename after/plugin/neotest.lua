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

-- run `run jest --watch` when running tests
vim.keymap.set("n", "<leader>tw", function()
  -- if we've not saved the file, save it
  if vim.bo.modified then
    vim.cmd("w")
  end
  require("neotest").run.run({ jestCommand = "npm run test:watch" })
end, { noremap = true, silent = true })

-- run test suite
vim.keymap.set("n", "<leader>a", function()
  -- if we've not saved the file, save it
  if vim.bo.modified then
    vim.cmd("w")
  end
  require("neotest").run.run({ suite = true })
end, { noremap = true, silent = true })

-- run tests for file
vim.keymap.set("n", "<leader>t", function()
  -- if we've not saved the file, save it
  if vim.bo.modified then
    vim.cmd("w")
  end
  require("neotest").run.run(vim.fn.expand("%"))
end, { noremap = true, silent = true })

-- run test under cursor
vim.keymap.set("n", "<leader>T", function()
  -- if we've not saved the file, save it
  if vim.bo.modified then
    vim.cmd("w")
  end
  require("neotest").run.run({ nearest = true })
end, { noremap = true, silent = true })

-- stop running tests
vim.keymap.set("n", "<leader>tx", function()
  -- if we're running tests, stop them
  if require("neotest").state.is_running() then
    require("neotest").run.stop()
  else
    -- otherwise, clear the results
    require("neotest").results.clear()
  end
end, { noremap = true, silent = true })

-- toggle test summary
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>",
  { noremap = true, silent = true })

-- open output for failing tests in the same way that we open the LSP signature helper
vim.keymap.set("n", "<C-t>", "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
  { noremap = true, silent = true })
