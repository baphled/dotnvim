vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*",
  desc = "Format on save",
  callback = function()
    vim.lsp.buf.format()
  end
})
