local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local commentary_mapping = {
  ["<leader>"] = {
    ["/"] = {
      "<cmd>Commentary<CR>", "Comment Toggle",
    },
  },
}

which_key.register(commentary_mapping, normal_opts)
