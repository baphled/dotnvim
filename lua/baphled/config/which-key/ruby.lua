local which_key = require("which-key")

which_key.add({
  {
    "<leader>bi",
    "<cmd>!bundle install<cr>",
    desc = "Bundle Install",
    nowait = false,
    mode = "n",
    remap = false
  },
})
