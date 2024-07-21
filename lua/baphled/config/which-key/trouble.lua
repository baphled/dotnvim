local which_key = require("which-key")

which_key.add({
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
  group = "Trouble",
  {
    "<leader>xd",
    "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
    desc = "Find Document Diagnostics",
  },
  {
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Toggle Trouble",
  },
})
