local which_key = require("which-key")

which_key.add({
  mode = "n",
  {
    "<leader>zz",
    "<cmd>ZenMode<cr>",
    desc = "Toggle Zen Mode",
    nowait = false,
    remap = false
  },
})
