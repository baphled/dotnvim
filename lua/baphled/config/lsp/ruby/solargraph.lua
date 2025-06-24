local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)


vim.lsp.config('solargraph', {
  capabilities = capabilities,
  settings = {
    init_options = {
      formatting = true,
      useBundler = true,
      logLevel = "debug",
      ignore = { "node_modules/**", "vendor/**", "tmp/**", ".bundle/**" },
    },
    solargraph = {
      autocomplete = false,
      autoformat = false,
      completion = false,
      definitions = false,
      diagnostics = false,
      folding = false,
      formatting = false,
      hover = false,
      references = true,
      rename = true,
      symbols = true,
    }
  }
})
vim.lsp.enable('solargraph')
