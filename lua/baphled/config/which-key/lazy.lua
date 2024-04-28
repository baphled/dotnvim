local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local lazy_mapping = {
  ['<C-w>i'] = { "<cmd>Lazy<CR>", "Plugins Manager" },
  vpp = { "<cmd>e ~/.config/nvim/lua/baphled/plugins.lua<CR>", "Plugins Config" },
}

which_key.register(lazy_mapping, normal_opts)
