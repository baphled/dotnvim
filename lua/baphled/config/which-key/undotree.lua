local which_key = require("which-key")

which_key.add({
  {
    "<leader>u",
    "<cmd>Telescope undo<cr>",
    group = "UndoTree",
    desc = "Toggle UndoTree",
    nowait = false,
    remap = false
  },
})
