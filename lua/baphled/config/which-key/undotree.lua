local which_key = require("which-key")

which_key.add({
  {
    "<leader>u",
    vim.cmd.UndotreeToggle,
    group = "UndoTree",
    desc = "Toggle UndoTree",
    nowait = false,
    remap = false
  },
})
