-- Format the entire file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Open Packers config
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/baphled/packer.lua<CR>")

-- Make it rain
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
