local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)


vim.lsp.config('ruby_lsp', {
  capabilities = capabilities,
  init_options = {
    formatter = 'auto',
    linters = { 'standard' },
  },
  settings = {
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = false,
      definition = false,
      diagnostics = false,
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

local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
      local params = vim.lsp.util.make_text_document_params()
      local showAll = opts.args == "all"

      client.request("rubyLsp/workspace/dependencies", params, function(error, result)
        if error then
          print("Error showing deps: " .. error)
          return
        end

        local qf_list = {}
        for _, item in ipairs(result) do
          if showAll or item.dependency then
            table.insert(qf_list, {
              text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
              filename = item.path
            })
          end
        end

        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
      end, bufnr)
    end,
    { nargs = "?", complete = function() return { "all" } end })
end

require("lspconfig").ruby_lsp.setup({
  on_attach = function(client, buffer)
    add_ruby_deps_command(client, buffer)
  end,
})
