local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)


vim.lsp.config('solargraph', {
  capabilities = capabilities,
  settings = {
    solargraph = {
      autocomplete = false,
      autoformat = false,
      completion = false,
      definitions = false,
      diagnostic = false,
      diagnostics = false,
      folding = false,
      formatting = false,
      hover = false,
      ignore = { "node_modules/**", "vendor/**", "tmp/**", ".bundle/**" },
      references = true,
      rename = true,
      symbols = true,
      useBundler = true
    }
  }
})
vim.lsp.enable('solargraph')

