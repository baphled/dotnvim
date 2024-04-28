local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local spectre_mapping = {
  ['<leader>'] = {
    s = {
      t = { "<cmd>lua require('spectre').toggle()<CR>", "Spectre Toggle" }
    },
  },

  s = {
    w = { "<cmd>lua require('spectre').open_visual({ select_word = true })<CR>", "Search current word" },
  }
}

which_key.register(spectre_mapping, normal_opts)
