local which_key = require("which-key")

which_key.add({
  mode = "n",
  {
    "<C-p>",
    "<cmd>NvimTreeToggle<CR>",
    desc = "File Browser",
    nowait = false,
    remap = false
  },
})
