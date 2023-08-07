vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "packer.lua",
  callback = function()
    -- Source the file
    vim.api.nvim_command("source %")
  end
})
