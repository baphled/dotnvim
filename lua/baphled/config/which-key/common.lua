local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local common_mapping = {
  ["<cr>"] = { "<cmd>nohlsearch<CR>", "Disable Highlighting" },
  ['<leader>'] = {
    t = {
      name = "Line Numbers",
      c = { "<cmd>set cursorline!<CR>", "Cursorline" },
      h = { "<cmd>set hlsearch!<CR>", "Highlight" },
      n = { "<cmd>set number!<CR>", "Number" },
      r = { "<cmd>set relativenumber!<CR>", "Relative Number" },
    },
  },
}

which_key.register(common_mapping, normal_opts)
