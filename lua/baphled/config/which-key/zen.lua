local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local zen_mode_mapping = {
  ['<leader>'] = {
    zz = { "<cmd>ZenMode<cr>", "Toggle Zen Mode" },
  }
}

which_key.register(zen_mode_mapping, normal_opts)
