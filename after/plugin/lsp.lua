local lsp_zero = require('lsp-zero')
local lspkind = require('lspkind')

require("luasnip.loaders.from_vscode").lazy_load()

lsp_zero.ensure_installed({
  'rust_analyzer',
  'clangd',
  'arduino_language_server',
  'solargraph',
  'lua_ls',
  'ruby_ls',
})

-- Fix Undefined global 'vim'
lsp_zero.nvim_workspace()

local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

lsp_zero.set_sign_icons({
  error = " ",
  warn = " ",
  hint = " ",
  info = " ",
})

local lspconfig = require('lspconfig')

require('lspconfig-bundler').setup()

vim.diagnostic.config({
  virtual_text = true
})

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.solargraph.setup({
  on_attach = lsp_zero.on_attach,
  capabilities = capabilities,
  settings = {
    solargraph = {
      ignore = {
        "node_modules/**",
        "vendor/**",
        "tmp/**",
        ".bundle/**",
      },
      definitions = true,
      diagnostics = true,
      completion = true,
      formatting = true,
      rename = true,
      useBundler = true,
      autoformat = false,
      autocomplete = true,
    }
  }
})

if not configs.ruby_lsp then
  local enabled_features = {
    "documentSymbols",
    "foldingRanges",
    "selectionRanges",
    "codeActions",
  }

  configs.ruby_ls = {
    default_config = {
      cmd = { "ruby-lsp" },
      filetypes = { "ruby" },
      root_dir = util.root_pattern("Gemfile", ".git"),
      init_options = {
        enabledFeatures = enabled_features,
      },
      settings = {},
    },
    commands = {
      FormatRuby = {
        function()
          vim.lsp.buf.format({
            name = "ruby_ls",
            async = true,
          })
        end,
        description = "Format using ruby-lsp",
      },
    },
  }
end

lspconfig.ruby_ls.setup({
  on_attach = lsp_zero.on_attach,
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  on_attach = lsp_zero.on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
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

lsp_zero.setup()

local cmp_mappings = {
  -- Disable <Tab> and <S-Tab>, as they conflict with GitHub Copilot
  -- It is still possible to navigate with Arrow Up and Arrow Down
  ["<Tab>"] = cmp.config.disable,
  ["<S-Tab>"] = cmp.config.disable,
  ["<Enter>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete()
    end
  end,
  ['<Esc>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete()
    end
    vim.cmd('stopinsert')
  end),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<C-p>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item(cmp_select_opts)
    else
      cmp.complete()
    end
  end),
  ['<C-n>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item(cmp_select_opts)
    else
      cmp.complete()
    end
  end),
}

cmp.setup({
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
    { name = "emoji" },
    { name = "neorg" },
    { name = "orgmode" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp_mappings,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    -- mix format with lspkind icons and cmp kind labels
    format = lspkind.cmp_format({
      with_text = true, -- show text along icon
      menu = ({
        luasnip = "[Snip]",
        nvim_lsp = "[LSP]",
        vim_dadbod_completion = "[DB]",
        buffer = "[buf]",
        nvim_lua = "[API]",
        path = "[path]",
      }),
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
})

lspconfig["volar"].setup {
  on_attach = lsp_zero.on_attach,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "vue",
    "json",
  },
  settings = {
    volar = {
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
    },
  },
}

lsp_zero.format_on_save()
