local builtin = require('telescope.builtin')
local which_key = require("which-key")
local utils = require("baphled.utils")

which_key.setup()

which_key.register({
  ["<C-h>"] = {
    function()
      vim.lsp.buf.signature_help()
    end,
    "Signature Help"
  },
}, {
  mode = "i",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

local opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mappings = {
  ["<F7>"] = { "<cmd>lua require('dap').continue()<cr>", "DAP Continue" },
  ["<F8>"] = { "<cmd>lua require('dap').step_over()<cr>", "DAP Step Over" },
  ["<F9>"] = { "<cmd>lua require('dap').step_into()<cr>", "DAP Step Into" },
  ["<F10>"] = { "<cmd>lua require('dap').step_out()<cr>", "DAP Step Out" },
  ["<C-b>"] = { "<cmd>%bd|e#<cr>", "Clear Buffers" },
  ["<C-k>"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  ["C-D"] = {
    function()
      require('dap').continue()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
    end,
    "Start"
  },
  ["v?"] = { "<cmd>Telescope help_tags<cr>", "help", },
  ["k?"] = { "<cmd>Telescope keymaps<cr>", "Find Keymap" },
  ["<cr>"] = { "<cmd>nohlsearch<CR>", "Disable highlighting" },
  ['<C-w>i'] = { "<cmd>PackerSync<cr>", "Packer Sync" },
  ['<C-p>'] = { "<cmd>NvimTreeToggle<cr>", "File Browser" },
  ['<leader>'] = {
    b = {
      "<cmd>lua require('dap').toggle_breakpoint()<cr>",
      "Toggle Breakpoint"
    },
    f = {
      function()
        vim.lsp.buf.format()
      end,
      "Format"
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
        o = {
          function()
            vim.notify("Checking out unstaged commits", "info", { title = "Git" })
            vim.cmd.Git('checkout -- .')
            vim.notify("Commits checked out", "success", { title = "Git" })
          end,
          "Git Checkout All"
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
            vim.cmd.Git("diff -- origin/$(git rev-parse --abbrev-ref HEAD)")

            utils.move_window_in_tab()
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
            vim.cmd.Git("diff origin/$(git rev-parse --abbrev-ref HEAD)")

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
      l = {
        function()
          vim.diagnostic.open_float()
        end,
        "Open Floating Window"
      },
      p = {
        "Push",
        f = {
          function()
            vim.notify("Force Pushing to origin", "info")
            vim.cmd.Git('push --force')
            vim.notify("Force Pushed to origin", "info")
          end,
          "Git Push Force"
        },
        o = {
          function()
            vim.notify("Pushing to origin", "info")
            vim.cmd.Git('push origin')
            vim.notify("Pushed to origin", "info")
          end,
          "Git Push Origin"
        },
        p = {
          function()
            vim.notify("Pushing to origin", "info")
            vim.cmd.Git('push')
            vim.notify("Pushed to origin", "info")
          end,
          "Git Push"
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

            vim.notify("Rebase Aborted", "warn")
          end,
          "Rebase Abort"
        },
        i = {
          function()
            vim.notify("Starting interactive Rebase", "info")

            local branch = vim.fn.input('Rebase Branch: ')
            vim.cmd.Git('rebase -i ' .. branch)

            vim.notify("Interactive Rebase Ended", "done")
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
    x = {
      d = { "<cmd>Trouble document_diagnostics<cr>", "Find Document Diagnostics" },
      l = { "<cmd>Telescope loclist<cr>", "Find Loclist" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Find Workspace Diagnostics" },
      q = { "<cmd>Telescope quickfix<cr>", "Find Quickfix" },
      x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    },
    B = {
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Set Breakpoint"
    },
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
  -- Finder
  f = {
    name = "Finder",
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    c = {
      a = {
        name = "Actions",
        r = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Find Code Actions" },
      },
    },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = {
      function ()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end,
      "Find Grep"
    },
    i = {
      function()
        vim.lsp.buf.implementation()
      end,
      "Find Implementation"
    },
    l = {
      "<cmd>Trouble loclist<cr>",
      "Find Diagnostics"
    },
    o = { "<cmd>Telescope oldfiles<cr>", "Find Old File" },
    r = {
      "<cmd>Trouble lsp_references<cr>",
      "Find References"
    },
    w = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      "Find String"
    },
    x = { "<cmd>Telescope commands<cr>", "Find Command" },
  },
  g = {
    d = {
      "<cmd>Telescope lsp_definitions<cr>", "Find Definition"
    },
    r = {
      "<cmd>Telescope lsp_references<cr>", "Find Declaration"
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
        require("neotest").run.run({ jestCommand = "npx vue-cli-service test:watch" })
      end,
      "Watch",
    },
  },
  r = {
    name = "Rename",
    b = {
      name = "Buffer",
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    },
  },
}

which_key.register(mappings, opts)
