vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "startup" },
  desc = "Disable some defaults",
  callback = function()
    -- set local foldmethod to manual
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.colorcolumn = "0"
  end,
})
