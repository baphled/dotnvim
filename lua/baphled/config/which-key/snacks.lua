local which_key = require("which-key")

local Snacks = require("snacks")

which_key.add({
  mode = "n",
  noremap = true,
  nowait = false,
  {
    "<leader>.",
    function() Snacks.scratch() end,
    desc = "Toggle Scratch Buffer"
  },
  { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
  { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
  { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
  { "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse" },
  { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line" },
  { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Current File History" },
  { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
  { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
  { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
  {
    "<leader>tx",
    function()
      Snacks.toggle("quickfix")
    end,
    desc = "Toggle Quickfix"
  },
  {
    "<leader>uT",
    function()
      Snacks.toggle.treesitter():map("<leader>uT")
    end,
    desc = "Toggle Treesitter"
  }
})