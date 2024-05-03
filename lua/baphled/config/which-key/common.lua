local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local visual_opts = {
  mode = "v",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local ex_opts = {
  mode = "x",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local delete_mapping = {
  ["<leader>"] = {
    d = { '"_d', "Delete Line" },
  },
}

local edit_mapping = {
  ["<leader>"] = {
    Y = { '[["+Y]]', "Copy Line to System Clipboard" },
    y = { '[["+y]]', "System to Clipboard" },
  },
}

local paste_mappings = {
  ["<leader>"] = {
    p = { '"_dP', "Paste and retain previous register" },
  },
}

local copy_line_mapping = {
  ["<leader>"] = {
    Y = { '"+Y', "Copy Line to System Clipboard" },
  },
}

local copy_mapping = {
  ["<leader>"] = {
    y = { '"+y', "System to Clipboard" },
  },
}

local common_mapping = {
  ["<cr>"] = { "<cmd>nohlsearch<CR>", "Disable Highlighting" },
  ['<leader>'] = {
    s = {
      s = {
        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        "Search and Replace",
      }
    },
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

which_key.register(delete_mapping, normal_opts)
which_key.register(delete_mapping, visual_opts)

which_key.register(copy_mapping, normal_opts)
which_key.register(copy_line_mapping, visual_opts)

which_key.register(paste_mappings, ex_opts)
