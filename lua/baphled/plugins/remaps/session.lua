local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local session_mapping = {
  ['<leader>'] = {
    c = {
      b = { "<cmd>%bd|e#<cr>", "Clear Buffers" },
    },
    s = {
      v = { "<cmd>source ~/.config/nvim/init.lua<CR>", "Source Config" },
    },
    ['<leader>'] = {
      function()
        vim.cmd("so")
      end, "Source Current File"
    },
  }
}

which_key.register(session_mapping, normal_opts)

