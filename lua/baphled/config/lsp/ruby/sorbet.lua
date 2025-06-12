local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)


vim.lsp.config('sorbet', {
  capabilities = capabilities,
  cmd = {
    "bundle",
    "exec",
    "srb",
    "tc",
    "--lsp",
    "--disable-watchman",
    "--enable-all-experimental-lsp-features",
  },
  settings = {
    autocomplete = true,
    autoformat = true,
    completions = true,
    hover = true,
    definitions = true,
    diagnostic = true,
    folding = true,
    formatting = true,
    references = true,
    rename = true,
    symbols = true,
    useBundler = true,
  },
  rootPatterns = { "sorbet/config" },
})
vim.lsp.enable('sorbet')

