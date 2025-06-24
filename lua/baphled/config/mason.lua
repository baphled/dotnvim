require("baphled.config.cmp")
require("mason").setup({})
require('lspconfig-bundler').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'arduino_language_server',
    'bashls',
    'clangd',
    'cssls',
    'eslint',
    'gopls',
    'jsonls',
    'lua_ls',
    'mutt_ls',
    'rubocop',
    'ruby_lsp',
    'rust_analyzer',
    'sorbet',
    'ts_ls',
    'vue_ls',
  },
})
