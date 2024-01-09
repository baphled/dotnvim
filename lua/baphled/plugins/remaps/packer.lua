local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local packer_mapping = {
  ['<C-w>i'] = { "<cmd>PackerSync<CR>", "Packer Sync" },
  vpp = { "<cmd>e ~/.config/nvim/lua/baphled/packer.lua<CR>", "Packer Config" },
}

which_key.register(packer_mapping, normal_opts)
