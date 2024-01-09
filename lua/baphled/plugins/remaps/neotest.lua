local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local testing_mappings = {
  t = {
    name = "Testing",
    a = {
      function()
        -- if we've not saved the file, save it
        if vim.bo.modified then
          vim.cmd("w")
        end

        require("neotest").run.run({ suite = true })
      end,
      "Test Suite",
    },
    d = {
      "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
      "Display Test Output",
    },
    c = {
      s = {
        "<cmd>CoverageSummary<cr>",
        "Coverage Summary",
      },
      name = "Coverage",
    },
    n = {
      function()
        -- if we've not saved the file, save it
        if vim.bo.modified then
          vim.cmd("w")
        end
        require("neotest").run.run({ nearest = true })
      end,
      "Test Nearest",
    },
    k = {
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
      "Watch"
    },
    s = {
      "<cmd>lua require('neotest').summary.toggle()<cr>",
      "Test Suite",
    },
    t = {
      function()
        if vim.bo.modified then
          vim.cmd("w")
        end
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      "Test File",
    },
    w = {
      function()
        -- if we've not saved the file, save it
        if vim.bo.modified then
          vim.cmd("w")
        end
        require("neotest").run.run({ jestCommand = "npx vue-cli-service test:unit --watch" })
      end,
      "Watch",
    },
  },
}

which_key.register(testing_mappings, normal_opts)
