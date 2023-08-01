-- Move between quickfix and location list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Move down the page
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move up the page
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move line under the cursor up
vim.keymap.set("n", "J", "mzJ`z")

-- Move the line below the current line
vim.keymap.set("n", "J", "mzJ`z")

-- Move around page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move around search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move between buffers
vim.keymap.set("n", "<C-E>", "<cmd>b#<CR>")

-- Move highlighted line up
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")

-- Move highlighted line down
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

-- Creates a new line below the current line
vim.keymap.set("n", "]<space>", function()
  -- Insert a new line below the current line
  vim.cmd("normal! o")
end)

-- Creates a new line above the current line
vim.keymap.set("n", "[<space>", function()
  -- Insert a new line above the current line
  vim.cmd("normal! O")
end)

-- Find the next occurrence of the search term and centre the screen
vim.keymap.set("n", "n", "nzzzv")

-- Find the previous occurrence of the search term and centre the screen
vim.keymap.set("n", "N", "Nzzzv")
