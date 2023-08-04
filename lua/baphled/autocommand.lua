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

-- Enable spell check and word wrap for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "_editing",
  pattern = { "gitcommit", "markdown", "txt" },
  desc = "Enable spell checking and text wrapping for certain filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Exit git diff buffer with ESC or q
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "git" },
  desc = "Exit git diff buffer with ESC",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":bd!<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":bd!<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "startup" },
  desc = "Disable some defaults",
  callback = function()
    -- set local foldmethod to manual
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.colorcolumn = "0"
  end,
})
