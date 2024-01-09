local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local cloak_mapping = {
  ['<leader>'] = {
    c = {
      e = { "<cmd>lua require('cloak').enable()<CR>", "Cloak Enable" },
      t = { "<cmd>lua require('cloak').toggle()<CR>", "Cloak Toggle" },
      d = { "<cmd>lua require('cloak').disable()<CR>", "Edit Disable" },
    },
  },
}
