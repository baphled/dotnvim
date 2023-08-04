-- Desc: search and replace
--

-- Search for the word under the cursor and replace it
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Disable highlighting
vim.keymap.set("n", "<cr>", "<cmd>nohlsearch<CR>")

