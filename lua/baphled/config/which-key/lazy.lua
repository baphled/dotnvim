local which_key = require("which-key")

which_key.add({
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
  {
    "<C-w>i",
    "<cmd>Lazy<CR>",
    desc = "Plugins Manager",
    nowait = false,
    remap = false
  },
  {
    "vpp",
    "<cmd>e ~/.config/nvim/lua/baphled/plugins.lua<CR>",
    desc = "Plugins Config",
    nowait = false,
    remap = false
  },
})
