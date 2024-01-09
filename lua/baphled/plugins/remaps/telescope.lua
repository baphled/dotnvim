local which_key = require("which-key")
local builtin = require('telescope.builtin')

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local telescope_mappings = {
  f = {
    name = "Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "help", },
    g = {
      function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end,
      "Find Grep"
    },
    i = {
      function()
        vim.lsp.buf.implementation()
      end,
      "Find Implementation"
    },
    k = { "<cmd>Telescope keymaps<cr>", "Find Keymap" },
    l = {
      "<cmd>Trouble loclist<cr>",
      "Find Diagnostics"
    },
    o = { "<cmd>Telescope oldfiles<cr>", "Find Old File" },
    r = {
      "<cmd>Trouble lsp_references<cr>",
      "Find References"
    },
    w = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      "Find String"
    },
    x = { "<cmd>Telescope commands<cr>", "Find Command" },
  },
}

which_key.register(telescope_mappings, normal_opts)
