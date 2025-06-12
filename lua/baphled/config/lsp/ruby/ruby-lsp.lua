local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)


vim.lsp.config('ruby_lsp', {
  capabilities = capabilities,
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
  },
  settings = {
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = false,
      definition = false,
      diagnostics = true,
      documentHighlights = false,
      documentLink = false,
      documentSymbols = false,
      foldingRanges = false,
      hover = false,
      inlayHint = false,
      onTypeFormatting = false,
      selectionRanges = false,
      semanticHighlighting = false,
      signatureHelp = false,
      typeHierarchy = false,
      workspaceSymbol = false,
    },
  },
  filetypes = { "ruby" },
  commands = {
    FormatRuby = {
      function()
        vim.lsp.buf.format({
          name = "ruby_lsp",
          async = true,
        })
      end,
      description = "Format using ruby-lsp",
    },
  },
  addonSettings = {
    ["Ruby LSP Rails"] = {
      enablePendingMigrationsPrompt = true,
    },
  },
})
vim.lsp.enable('ruby_lsp')

