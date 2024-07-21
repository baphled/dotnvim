local which_key = require("which-key")

which_key.add({
  {
    "<leader>st",
    "<cmd>lua require('spectre').toggle()<CR>",
    desc = "Spectre Toggle",
    nowait = false,
    remap = false
  },
  {
    "<leader>sw",
    "<cmd>lua require('spectre').open_visual({ select_word = true })<CR>",
    desc = "Search current word",
    nowait = false,
    remap = false
  },
})
