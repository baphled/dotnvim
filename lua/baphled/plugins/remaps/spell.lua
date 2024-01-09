local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local spell_mapping = {
  ['<leader>'] = {
    s = {
      p = { "<cmd>set spell!<cr>", "Spell" },
    },
  },
}

which_key.register(spell_mapping, normal_opts)

