local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}


local nvimtree_mapping = {
  ['<C-p>'] = { "<cmd>NvimTreeToggle<CR>", "File Browser" },
  ['<leader>'] = {
    np = { "<cmd>NvimTreeFindFile!<CR>", "NvimTree Find File" },
  }
}

which_key.register(nvimtree_mapping, normal_opts)
