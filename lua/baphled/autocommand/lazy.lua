vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "plugins.lua",
  callback = function()
    -- Source the file
    vim.api.nvim_command("source %")
  end
})
