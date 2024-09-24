local which_key = require("which-key")

which_key.add({
  {
    "<leader>/",
    "<cmd>Commentary<CR>",
    desc = "Comment Toggle",
    nowait = false,
    remap = false
  },
})
