-- Desc: Copy and paste with vim
--

-- Paste and retain the previous register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletes the contents of the current line while preserving leading whitespace.
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
