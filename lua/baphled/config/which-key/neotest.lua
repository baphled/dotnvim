local which_key = require("which-key")

which_key.add({
  {
    "t",
    group = "Testing",
    nowait = false,
    remap = false
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
    group = "Coverage",
    nowait = false,
    remap = false
  },
  {
    "tcs",
    "<cmd>CoverageSummary<cr>",
    desc = "Coverage Summary",
    nowait = false,
    remap = false
  },
  {
    "td",
    "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
    desc = "Display Test Output",
    nowait = false,
    remap = false
  },
  {
    "tk",
    function()
      -- if we're running tests, stop them
      if require("neotest").state.is_running() then
        require("neotest").run.stop()
        vim.notify("Stopped running tests")
      else
        -- otherwise, clear the results
        require("neotest").results.clear()
        vim.notify("Cleared test results")
      end
    end,
    desc = "Watch",
    nowait = false,
    remap = false
  },
  {
    "tn",
    function()
      -- if we've not saved the file, save it
      if vim.bo.modified then
        vim.cmd("w")
      end
      require("neotest").run.run({ nearest = true })
    end,
    desc = "Test Nearest",
    nowait = false,
    remap = false
  },
  {
    "ts",
    "<cmd>lua require('neotest').summary.toggle()<cr>",
    desc = "Test Suite",
    nowait = false,
    remap = false
  },
  {
    "tt",
    function()
      if vim.bo.modified then
        vim.cmd("w")
      end
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    desc = "Test File",
    nowait = false,
    remap = false
  },
  {
    "tw",
    function()
      -- if we've not saved the file, save it
      if vim.bo.modified then
        vim.cmd("w")
      end
      require("neotest").run.run({ jestCommand = "npx vue-cli-service test:unit --watch" })
    end,
    desc = "Watch",
    nowait = false,
    remap = false
  },
})
