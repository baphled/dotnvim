local which_key = require("which-key")
local utils = require("baphled.utils")

which_key.add({
  mode = "n",
  {
    "<leader>g",
    group = "Git",
    nowait = false,
    remap = false
  },
  {
    "<leader>gb",
    function()
      vim.cmd.Git('blame')
    end,
    desc = "Git Blame",
    nowait = false,
    remap = false
  },
  {
    "<leader>gc",
    group = "Commit",
    nowait = false,
    remap = false
  },
  {
    "<leader>gca",
    function()
      vim.cmd.Git('commit --amend')
    end,
    desc = "Git Commit Amend",
    nowait = false,
    remap = false
  },
  {
    "<leader>gcf",
    function()
      vim.cmd.Git('checkout -- %')
    end,
    desc = "Git Checkout File",
    nowait = false,
    remap = false
  },
  {
    "<leader>gco",
    function()
      vim.notify("Checking out unstaged commits", vim.log.levels.INFO, { title = "Git" })
      vim.cmd.Git('checkout -- .')
      vim.notify("Commits checked out", vim.log.levels.INFO, { title = "Git" })
    end,
    desc = "Git Checkout All",
    nowait = false,
    remap = false
  },
  {
    "<leader>gcr",
    function()
      local branch = vim.fn.input('Reset Hash: ')
      vim.cmd.Git('reset ' .. branch)
    end,
    desc = "Git Commit Reset",
    nowait = false,
    remap = false
  },
  {
    "<leader>gcs",
    function()
      vim.cmd.Git('commit -s')
    end,
    desc = "Git Commit Sign",
    nowait = false,
    remap = false
  },
  {
    "<leader>gg",
    group = "LazyGit",
    nowait = false,
    remap = false
  },
  {
    "<leader>gd",
    group = "Diff",
    nowait = false,
    remap = false
  },
  {
    "<leader>gda",
    function()
      local branch = vim.fn.input('Branch: ')
      vim.cmd.Git('diff ' .. branch)

      utils.move_window_in_tab()
    end,
    desc = "Git Diff Working Branch vs Branch",
    nowait = false,
    remap = false
  },
  {
    "<leader>gdb",
    function()
      vim.cmd.Git("diff -- origin/$(git rev-parse --abbrev-ref HEAD)")

      utils.move_window_in_tab()
    end,
    desc = "Git Diff Working Branch",
    nowait = false,
    remap = false
  },
  {
    "<leader>gdc",
    function()
      vim.cmd.Git('diff --cached')

      utils.move_window_in_tab()
    end,
    desc = "Git Diff Cached",
    nowait = false,
    remap = false
  },
  {
    "<leader>gdd",
    function()
      vim.cmd.Git('diff')

      utils.move_window_in_tab()
    end,
    desc = "Git Diff",
    nowait = false,
    remap = false
  },
  {
    "<leader>gdg",
    function()
      vim.cmd.Git("diff origin/$(git rev-parse --abbrev-ref HEAD)")

      utils.move_window_in_tab()
    end,
    desc = "Git Diff Working Branch vs Main",
    nowait = false,
    remap = false
  },
  {
    "<leader>gdm",
    function()
      vim.cmd.Git('diff origin/main')

      utils.move_window_in_tab()
    end,
    desc = "Git Diff main",
    nowait = false,
    remap = false
  },
  {
    "<leader>gf",
    group = "Find",
    nowait = false,
    remap = false
  },
  { "<leader>gfb", "<cmd>Telescope git_branches<cr>", desc = "Find Branch", nowait = false, remap = false },
  { "<leader>gfc", "<cmd>Telescope git_commits<cr>",  desc = "Find Commit", nowait = false, remap = false },
  { "<leader>gff", "<cmd>Telescope git_files<cr>",    desc = "Find File",   nowait = false, remap = false },
  {
    "<leader>gl",
    function()
      vim.diagnostic.open_float()
    end,
    desc = "Open Floating Window",
    nowait = false,
    remap = false
  },
  { "<leader>gp", desc = "Push",    nowait = false, remap = false },
  {
    "<leader>gpf",
    function()
      vim.notify("Force Pushing to origin", vim.log.levels.INFO)
      vim.cmd.Git('push --force')
      vim.notify("Force Pushed to origin", vim.log.levels.INFO)
    end,
    desc = "Git Push Force",
    nowait = false,
    remap = false
  },
  {
    "<leader>gpo",
    function()
      vim.notify("Pushing to origin", vim.log.levels.INFO)
      vim.cmd.Git('push origin')
      vim.notify("Pushed to origin", vim.log.levels.INFO)
    end,
    desc = "Git Push Origin",
    nowait = false,
    remap = false
  },
  {
    "<leader>gpp",
    function()
      vim.notify("Pushing to origin", vim.log.levels.INFO)
      vim.cmd.Git('push')
      vim.notify("Pushed to origin", vim.log.levels.INFO)
    end,
    desc = "Git Push",
    nowait = false,
    remap = false
  },
  { "<leader>gr", group = "Rebase", nowait = false, remap = false },
  {
    "<leader>gra",
    function()
      vim.notify("Pushing to origin", vim.log.levels.INFO)
      vim.cmd.Git('push')
      vim.notify("Pushed to origin", vim.log.levels.INFO)
    end,
    desc = "Rebase Abort",
    nowait = false,
    remap = false
  },
  {
    "<leader>grc",
    function()
      vim.cmd.Git('rebase --continue')
    end,
    desc = "Rebase Continue",
    nowait = false,
    remap = false
  },
  {
    "<leader>gri",
    function()
      vim.notify("Starting interactive Rebase", vim.log.levels.INFO)

      local branch = vim.fn.input('Rebase Branch: ')
      vim.cmd.Git('rebase -i ' .. branch)

      vim.notify("Interactive Rebase Ended", vim.log.levels.INFO)
    end,
    desc = "interactive Rebase",
    nowait = false,
    remap = false
  },
  { "<leader>gs", group = "Status", nowait = false, remap = false },
  {
    "<leader>gst",
    function()
      vim.cmd.Git()
    end,
    desc = "Git Status",
    nowait = false,
    remap = false
  }
})
