local which_key = require("which-key")
local neotest = require("neotest")

which_key.add({
  {
    "t",
    group = "Test",
  },
  {
    "ta",
    function()
      -- if we've not saved the file, save it
      if vim.bo.modified then
        vim.cmd("w")
      end

      require("neotest").run.run({ suite = true })
    end,
    desc = "Test Suite",
    nowait = false,
    remap = false
  },
  {
    "tc",
    group = "Test Coverage",
  },
  {
    "tcs",
    "<cmd>CoverageSummary<cr>",
    desc = "Coverage Summary",
  },
  {
    "td",
    "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
    desc = "Display Test Output",
  },
  {
    "tk",
    function()
      -- if we're running tests, stop them
      if neotest.state.is_running() then
        neotest.run.stop()
        vim.notify("Stopped running tests")
      else
        -- otherwise, clear the results
        neotest.results.clear()
        vim.notify("Cleared test results")
      end
    end,
    desc = "Test Kill",
  },
  {
    "tn",
    function()
      -- if we've not saved the file, save it
      if vim.bo.modified then
        vim.cmd("w")
      end
      neotest.run.run({ nearest = true })
    end,
    desc = "Test Nearest",
  },
  {
    "ts",
    "<cmd>lua require('neotest').summary.toggle()<cr>",
    desc = "Test Suite",
  },
  {
    "tt",
    function()
      if vim.bo.modified then
        vim.cmd("w")
      end
      neotest.run.run(vim.fn.expand("%"))
    end,
    desc = "Test File",
  },
  {
    "tw",
    function()
      -- if we've not saved the file, save it
      if vim.bo.modified then
        vim.cmd("w")
      end
      neotest.run.run({ jestCommand = "npx vue-cli-service test:unit --watch" })
    end,
    desc = "Test Watch",
  },
})
