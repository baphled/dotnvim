local which_key = require("which-key")

which_key.add({
  {
    "<leader>sp",
    "<cmd>set spell!<cr>",
    desc = "Spell",
    nowait = false,
    mode = "n",
    remap = false
  },
  {
    "]s",
    "<cmd>normal! ]s<cr>",
    desc = "Next misspelled word",
    nowait = false,
    mode = "n",
    remap = false
  },
  {
    "[s",
    "<cmd>normal! [s<cr>",
    desc = "Previous misspelled word",
    mode = "n",
    nowait = false,
    remap = false
  },
})
