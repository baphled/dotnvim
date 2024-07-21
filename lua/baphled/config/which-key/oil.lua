local which_key = require("which-key")

which_key.add({
  mode = "n",
  {
    "<leader>np",
    "<cmd>Oil --float<CR>",
    desc = "Open Current Directory",
    nowait = false,
    remap = false
  },
})
