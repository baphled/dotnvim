local cmp = require('cmp')

local lspkind = require('lspkind')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = "path" },
    { name = "emoji", insert = true },
    { name = "neorg" },
    { name = "orgmode" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Disable <Tab> and <S-Tab>, as they conflict with GitHub Copilot
    -- It is still possible to navigate with Arrow Up and Arrow Down
    ['<Tab>'] = cmp.config.disable,
    ['<S-Tab>'] = cmp.config.disable,
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = function()
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
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
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
      before = function(_, vim_item)
        return vim_item
      end
    })
  },
})
