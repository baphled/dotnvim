local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local oil_mapping = {
  ['<leader>'] = {
    np = { "<cmd>Oil --float<CR>", "Open Current Directory" },
  }
}

which_key.register(oil_mapping, normal_opts)
