local which_key = require("which-key")

which_key.add({
  {
    "<leader><leader>",
    function()
      vim.cmd("so")
    end,
    desc = "Source Current File",
    nowait = false,
    remap = false
  },
  {
    "<leader>cb",
    "<cmd>%bd|e#<cr>",
    desc = "Clear Buffers",
    nowait = false,
    remap = false
  },
  {
    "<leader>sv",
    "<cmd>source ~/.config/nvim/init.lua<CR>",
    desc = "Source Config",
    nowait = false,
    remap = false
  },
})
