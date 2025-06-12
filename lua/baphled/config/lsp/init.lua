local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = " " })
sign({ name = 'DiagnosticSignWarn', text = " " })
sign({ name = 'DiagnosticSignHint', text = " " })
sign({ name = 'DiagnosticSignInfo', text = " " })

vim.diagnostic.config({
  signs = true,
  virtual_text = {
    prefix = '»',
    spacing = 0,
  },
  severity_sort = true,
  update_in_insert = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.buf.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.buf.signature_help,
  { border = 'rounded' }
)

require('baphled.config.lsp.cplusplus')
require('baphled.config.lsp.javascript')
require('baphled.config.lsp.lua')
require('baphled.config.lsp.ruby')
