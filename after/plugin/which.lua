which_key = require("which-key")

which_key.setup()

local opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mappings = {
  ['<leader'] = {
    t = {
      name = "toggle",
      c = { "<cmd>set cursorline!<cr>", "Cursorline" },
      h = { "<cmd>set hlsearch!<cr>", "Highlight" },
      l = { "<cmd>set list!<cr>", "List" },
      n = { "<cmd>set number!<cr>", "Number" },
      r = { "<cmd>set relativenumber!<cr>", "Relative Number" },
      s = { "<cmd>set spell!<cr>", "Spell" },
      w = { "<cmd>set wrap!<cr>", "Wrap" },
    },
  },
  -- Testing
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
      "Display Failure",
    },
    c = {
      s = {
        "<cmd>CoverageSummary<cr>",
        "Coverage Summary",
      },
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
        else
          -- otherwise, clear the results
          require("neotest").results.clear()
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
        require('neotest').toggle()
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
        require("neotest").run.run({ jestCommand = "npx vue-cli-service test:watch" })
      end,
      "Watch",
    },
  },
  -- Debugging
  d = {
    name = "debug",
    b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint" },
    c = {
      function()
        require('dapui').toggle({})
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
      end,
      "Continue"
    },
    O = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
    i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
    r = { "<cmd>lua require('dap').repl.open()<cr>", "Open REPL" },
    l = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
    s = {
      function()
        require('dapui').toggle({})
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
      end,
      "Start"
    },
    t = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test" },
    x = {
      function()
        -- Close debugger and clear breakpoints
        require("dap").clear_breakpoints()
        require("dapui").toggle({})
        require("dap").terminate()
        require("vim").api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
        -- require("notify")("Debugger session ended", "warn")
      end,
      "Close Debugger"
    }
  },
  -- File
  f = {
    name = "file",
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      "Find String"
    },
    o = { "<cmd>Telescope oldfiles<cr>", "Find Old File" },
    s = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      "Find String"
    },
  },
  -- Help
  hf = {
    c = { "<cmd>Telescope commands<cr>", "Find Command" },
    k = { "<cmd>Telescope keymaps<cr>", "Find Keymap" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  },
  -- Git
  g = {
    name = "Git",
    f = {
      name = "Find",
      c = {
        "<cmd>Telescope git_commits<cr>",
        "Find Commit"
      },
      b = {
        "<cmd>Telescope git_branches<cr>",
        "Find Branch"
      },
      f = {
        "<cmd>Telescope git_files<cr>",
        "Find File"
      },
    },
    b = {
      function()
        vim.cmd.Git('blame')
      end,
      "Git Blame"
    },
    c = {
      name = "Commit",
      a = {
        function()
          vim.cmd.Git('commit --amend')
        end,
        "Git Commit Amend"
      },
      f = {
        function()
          vim.cmd.Git('checkout -- %')
        end,
        "Git Checkout File"
      },
      r = {
        function()
          local branch = vim.fn.input('Reset Hash: ')
          vim.cmd.Git('reset ' .. branch)
        end,
        "Git Commit Reset"
      },
      s = {
        function()
          vim.cmd.Git('commit -s')
        end,
        "Git Commit Sign"
      },
    },
    d = {
      name = "Diff",
      d = {
        function()
          local utils = require('baphled.utils')
          vim.cmd.Git('diff')

          utils.move_window_in_tab()
        end,
        "Git Diff"
      },
      c = {
        function()
          local utils = require('baphled.utils')
          vim.cmd.Git('diff --cached')

          utils.move_window_in_tab()
        end,
        "Git Diff Cached"
      },
    },
    s = {
      name = "Status",
      t = {
        function()
          vim.cmd.Git()
          -- trigger new tab
        end,
        "Git Status"
      }
    },
    r = {
      name = "Rebase",
      a = {
        function()
          vim.cmd.Git('rebase --abort')
        end,
        "Rebase Abort"
      },
      i = {
        function()
          local branch = vim.fn.input('Rebase Branch: ')
          vim.cmd.Git('rebase -i ' .. branch)
        end,
        "interactive Rebase"
      },
      c = {
        function()
          vim.cmd.Git('rebase --continue')
        end,
        "Rebase Continue"
      },
    },
  },
  -- LSP
  lsp = {
    name = "LSP",
    a = {
      name = "Actions",
      a = { "<cmd>Telescope lsp_code_actions<cr>", "Find Code Actions" },
      r = { "<cmd>Telescope lsp_range_code_actions<cr>", "Find Range Code Actions" },
    },
    b = {
      name = "Buffer",
      c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    },
    d = {
      name = "Diagnostics",
      d = { "<cmd>Telescope document_diagnostics<cr>", "Find Document Diagnostics" },
      c = {
        function()
          vim.lsp.diagnostic.set_loclist({ open_loclist = false })
        end,
        "Close Diagnostics"
      },
      f = {
        function()
          vim.diagnostic.open_float()
        end,
        "Open Diagnostics Float"
      },
      j = {
        function()
          vim.diagnostic.goto_next()
        end,
        "Next Diagnostic"
      },
      k = {
        function()
          vim.diagnostic.goto_prev()
        end,
        "Previous Diagnostic"
      },
      o = {
        function()
          vim.lsp.diagnostic.set_loclist({ open_loclist = true })
        end,
        "Open Diagnostics"
      },
      w = { "<cmd>Telescope workspace_diagnostics<cr>", "Find Workspace Diagnostics" },
    },
    f = {
      name = "Formatting",
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    },
    r = {
      name = "References",
      d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definition" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "Find Implementation" },
      r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
    },
    s = {
      name = "Symbols",
      d = { "<cmd>Telescope lsp_document_symbols<cr>", "Find Document Symbols" },
      w = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Find Workspace Symbols" },
    },
  }
}

which_key.register(mappings, opts)
