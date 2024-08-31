local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, _)
end)

vim.diagnostic.config({
  virtual_text = true
})

lsp_zero.extend_lspconfig({
  sign_text = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = true,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

require('baphled.config.cmp')

lsp_zero.setup()

lsp_zero.format_on_save()
