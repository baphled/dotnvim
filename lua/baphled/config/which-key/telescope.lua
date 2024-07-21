local which_key = require("which-key")
local builtin = require('telescope.builtin')

which_key.add({
  mode = "n",
  noremap = true,
  nowait = false,
  { "f",  group = "Find" },
  { "fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
  {
    "ff",
    function()
      require("telescope.builtin").find_files({
        find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
      })
    end,
    desc = "Find File"
  },
  {
    "fg",
    function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end,
    desc = "Find Grep"
  },
  { "fh", "<cmd>Telescope help_tags<cr>",    desc = "help" },
  {
    "fi",
    function()
      vim.lsp.buf.implementation()
    end,
    desc = "Find Implementation"
  },
  { "fk", "<cmd>Telescope keymaps<cr>",      desc = "Find Keymap" },
  { "fl", "<cmd>Trouble loclist<cr>",        desc = "Find Diagnostics" },
  { "fo", "<cmd>Telescope oldfiles<cr>",     desc = "Find Old File" },
  { "fr", "<cmd>Trouble lsp_references<cr>", desc = "Find References" },
  {
    "fw",
    function()
      require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
    end,
    desc = "Find String"
  },
  { "fx", "<cmd>Telescope commands<cr>", desc = "Find Command" }
})
