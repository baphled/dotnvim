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
    "<leader>xl",
    "<cmd>Trouble loclist toggle win.type=float<cr>",
    desc = "Location List (Trouble)",
  },
  {
  },
  {
    "<leader>xq",
    "<cmd>Trouble qflist toggle win = { bo = { filetype = trouble_quickfix } }<cr>",
    desc = "Quickfix List (Trouble)",
  },
})
