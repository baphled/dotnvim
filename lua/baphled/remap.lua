vim.g.mapleader = ","

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletes the contents of the current line while preserving leading whitespace.
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Stop the damn flashing
vim.keymap.set("n", "Q", "<nop>")

-- Format the entire file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Search for the word under the cursor and replace it
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Open Packers config
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/baphled/packer.lua<CR>")

-- Make it rain
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- Toggle spell checker
vim.keymap.set("n", "<leader>sp", "<cmd>set spell!<CR>")

-- Disable highlighting
vim.keymap.set("n", "<cr>", "<cmd>nohlsearch<CR>")

local utils = require("baphled.utils")

-- Take current buffer, open it in a new tab and close the current buffer
vim.keymap.set("n", "<leader>tb", function()
  utils.move_window_in_tab()
end)

-- Source neovim config
vim.keymap.set("n", "<leader>sv", "<cmd>source ~/.config/nvim/init.lua<CR>")
