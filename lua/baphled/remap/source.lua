-- Desc: sourcing files
--

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- Source neovim config
vim.keymap.set("n", "<leader>sv", "<cmd>source ~/.config/nvim/init.lua<CR>")
