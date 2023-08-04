-- Desc: Markdown settings

vim.api.nvim_create_augroup("_editing", { clear = true })

-- Prevent IndentLine from hiding ``` in markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "_editing",
  pattern = { "markdown" },
  callback = function()
    vim.g["indentLine_enabled"] = 0
    vim.g["markdown_syntax_conceal"] = 0
  end,
})
