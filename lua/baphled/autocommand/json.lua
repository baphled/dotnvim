-- Desc: JSON related settings
--

-- Format json
--
-- We constantly have to deal with json files that are not formatted correctly.
--
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "json",
  desc = "JSON formatting",
  callback = function()
    local opts = { noremap = true, silent = true }

    -- This is a quick way to format them.
    vim.keymap.set('n', '<leader>jt', [[<cmd>%!python3 -m json.tool<CR><cmd>set filetype=json<CR>gg=G]],
      opts)
  end,
})
