local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.config('rubocop', {
  commands = {
    RubocopAutocorrect = {
      function()
        vim.lsp.buf.execute_command({
          command = "rubocop",
          arguments = {
            "--auto-correct",
            vim.api.nvim_buf_get_name(0),
          },
          title = "",
        })
      end,
      description = "Rubocop autocorrect",
    },
  },
})
vim.lsp.enable('rubocop')

