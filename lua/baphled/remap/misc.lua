-- Format the entire file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Open Packers config
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/baphled/packer.lua<CR>")

-- Make it rain
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Format json
--
-- We constantly have to deal with json files that are not formatted correctly.
--
-- This is a quick way to format them.
vim.keymap.set('n', '<leader>jt', [[<cmd>%!python -m json.tool<CR><cmd>set filetype=json<CR>gg=G]],
  { noremap = true, silent = true })

