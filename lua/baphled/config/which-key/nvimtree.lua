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
}

which_key.register(nvimtree_mapping, normal_opts)
