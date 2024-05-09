local lsp_zero = require('lsp-zero')
local util = require("lspconfig.util")

lsp_zero.on_attach(function(_, _)
end)

lsp_zero.set_sign_icons({
  error = " ",
  warn = " ",
  hint = " ",
  info = " ",
})

vim.diagnostic.config({
  virtual_text = true
})

lsp_zero.preset({
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
