local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.config('clangd', {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  settings = {
    clangd = {
      fileStatus = true,
      semanticHighlighting = true,
      fallbackFlags = {
        "-std=c++17",
        "-stdlib=libc++",
        "-I/usr/include/c++/v1",
        "-I/usr/local/include",
        "-I/usr/include",
      },
    },
  },
})
vim.lsp.enable('clangd')
