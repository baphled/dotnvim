local which_key = require("which-key")
local utils = require("baphled.utils")

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
  ["<cr>"] = { "<cmd>nohlsearch<CR>", "Disable highlighting" },
  ['<C-w>i'] = { "<cmd>PackerSync<cr>", "Packer Sync" },
  ['<leader>'] = {
    ct = { "<cmd>lua require('cloak').toggle()<CR>", "Cloak Toggle" },
    tc = { "<cmd>set cursorline!<cr>", "Cursorline" },
    mr = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it Rain" },
    np = { "<cmd>NvimTreeFindFile<cr>", "NvimTree Find File" },
    nt = { "<cmd>NvimTreeOpen<cr>", "NvimTree" },
    th = { "<cmd>set hlsearch!<cr>", "Highlight" },
    tn = { "<cmd>set number!<cr>", "Number" },
    tr = { "<cmd>set relativenumber!<cr>", "Relative Number" },
    tb = {
      function()
        utils.move_window_in_tab()
      end,
      "Move to New Tab"
    },
    sp = { "<cmd>set spell!<cr>", "Spell" },
    sv = { "<cmd>source ~/.config/nvim/init.lua<CR>", "Source Config" },
    ['<leader>'] = {
      function()
        vim.cmd("so")
      end,
      "Source Config" },
    vpp = { "<cmd>e ~/.config/nvim/lua/baphled/packer.lua<CR>", "Packer Config" },
  },
  cmd = { "<cmd>Telescope commands<cr>", "Find Command" },
  -- Debugging
  debug = {
    name = "debug",
    b = {
      "<cmd>lua require('dap').toggle_breakpoint()<cr>",
      "Toggle Breakpoint"
    },
    B = {
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Set Breakpoint"
    },
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

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)

        require("notify")("Debugger session ended", "warn")
      end,
      "Close Debugger"
    }
  },
  -- Finder
  f = {
    name = "Finder",
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      "Search String"
    },
    o = { "<cmd>Telescope oldfiles<cr>", "Find Old File" },
    s = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      "Find String"
    },
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
      a = {
        function()
          local branch = vim.fn.input('Branch: ')
          vim.cmd.Git('diff ' .. branch)

          utils.move_window_in_tab()
        end,
        "Git Diff Working Branch vs Branch"
      },
      b = {
        function()
          vim.cmd.Git('diff origin/$(git rev-parse --abbrev-ref HEAD)')
        end,
        "Git Diff Working Branch"
      },
      c = {
        function()
          vim.cmd.Git('diff --cached')

          utils.move_window_in_tab()
        end,
        "Git Diff Cached"
      },
      d = {
        function()
          vim.cmd.Git('diff')

          utils.move_window_in_tab()
        end,
        "Git Diff"
      },
      g = {
        function()
          vim.cmd.Git('diff origin/$(git rev-parse --abbrev-ref HEAD) origin/main')

          utils.move_window_in_tab()
        end,
        "Git Diff Working Branch vs Main"
      },
      m = {
        function()
          vim.cmd.Git('diff origin/main')

          utils.move_window_in_tab()
        end,
        "Git Diff main"
      },
    },
    s = {
      name = "Status",
      t = {
        function()
          vim.cmd.Git()
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
  help = { "<cmd>Telescope help_tags<cr>", "help", },
  keymaps = { "<cmd>Telescope keymaps<cr>", "Find Keymap" },
  -- LSP
  -- TODO: Remove default LSP mappings
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
      h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    },
    d = {
      name = "Diagnostics",
      d = {
        "<cmd>Trouble document_diagnostics<cr>",
        "Find Document Diagnostics"
      },
      l = {
        "<cmd>Trouble loclist<cr>",
        "Find Diagnostics"
      },
      D = {
        function()
          vim.lsp.buf.declaration()
        end,
        "Declaration"
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
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Find Workspace Diagnostics" },
    },
    r = {
      name = "References",
      d = {
        function()
          vim.lsp.buf.declaration()
        end,
        "Find Declaration"
      },
      D = {
        "<cmd>Telescope lsp_definitions<cr>",
        "Find Definition"
      },
      i = {
        function()
          vim.lsp.buf.implementation()
        end,
        "Find Implementation"
      },
      r = {
        "<cmd>Trouble lsp_references<cr>",
        "Find References"
      },
    },
    s = {
      name = "Symbols",
      d = { "<cmd>Telescope lsp_document_symbols<cr>", "Find Document Symbols" },
      w = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Find Workspace Symbols" },
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
          require("notify")(string.format("Saved %s", vim.fn.expand("%:t")))
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
    },
    n = {
      function()
        -- if we've not saved the file, save it
        if vim.bo.modified then
          vim.cmd("w")
        end
        require("neotest").run.run({ nearest = true })
        require("notify")("Running nearest test")
      end,
      "Test Nearest",
    },
    k = {
      function()
        -- if we're running tests, stop them
        if require("neotest").state.is_running() then
          require("neotest").run.stop()
          require("notify")("Stopped running tests")
        else
          -- otherwise, clear the results
          require("neotest").results.clear()
          require("notify")("Cleared test results")
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
        require("notify")("Running test in " .. vim.fn.expand("%:t") .. "...")
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
        require("notify")("Running tests in watch mode")
      end,
      "Watch",
    },
  },
  loclist = { "<cmd>Telescope loclist<cr>", "Find Loclist" },
  quickfix = { "<cmd>Telescope quickfix<cr>", "Find Quickfix" },
  trouble = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
}

which_key.register(mappings, opts)
