local which_key = require("which-key")

which_key.add({
  {
    "<leader>cd",
    "<cmd>lua require('cloak').disable()<CR>",
    desc = "Edit Disable",
    mode = "n",
    nowait = false,
    remap = false
  },
  {
    "<leader>ce",
    "<cmd>lua require('cloak').enable()<CR>",
    desc = "Cloak Enable",
    mode = "n",
    nowait = false,
    remap = false
  },
  {
    "<leader>ct",
    "<cmd>lua require('cloak').toggle()<CR>",
    desc = "Cloak Toggle",
    mode = "n",
    nowait = false,
    remap = false
  },
})
