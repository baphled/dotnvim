local which_key = require("which-key")

which_key.add({
  {
    "<leader>x",
    group = "Trouble",
  },
  {
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)",
  },
  {
    "<leader>xd",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)",
  },
  {
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false  win = { type = split, position=right, bo = { filetype = trouble_lsp }}<cr>",
    desc = "LSP Definitions / references / ... (Trouble)",
  },
  {
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false  win = { type = split, position=right, bo = { filetype = trouble_symbols }}<cr>",
    desc = "Symbols (Trouble)",
  },
  {
    "<leader>xl",
    "<cmd>Trouble loclist toggle win.type=float<cr>",
    desc = "Location List (Trouble)",
  },
  {
  },
  {
    "<leader>xq",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Quickfix List (Trouble)",
  },
})
