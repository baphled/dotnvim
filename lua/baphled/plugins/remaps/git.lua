local which_key = require("which-key")
local utils = require("baphled.utils")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local git_mappings = {
  ["<leader>"] = {
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
  },
}

which_key.register(git_mappings, normal_opts)
