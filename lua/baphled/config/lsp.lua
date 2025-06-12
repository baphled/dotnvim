local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = " " })
sign({ name = 'DiagnosticSignWarn', text = " " })
sign({ name = 'DiagnosticSignHint', text = " " })
sign({ name = 'DiagnosticSignInfo', text = " " })

vim.diagnostic.config({
  signs = true,
  virtual_text = {
    prefix = '»',
    spacing = 0,
  },
  severity_sort = true,
  update_in_insert = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

local util = require("lspconfig.util")

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local vue_language_server_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

local lspconfig = require('lspconfig')

--- Lua

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable('lua_ls')

--- Ruby

vim.lsp.config('solargraph', {
  capabilities = capabilities,
  settings = {
    solargraph = {
      ignore = {
        "node_modules/**",
        "vendor/**",
        "tmp/**",
        ".bundle/**",
      },
      autocomplete = true,
      autoformat = true,
      completion = true,
      hover = true,
      definitions = true,
      diagnostic = true,
      folding = true,
      formatting = true,
      references = true,
      rename = true,
      symbols = true,
      useBundler = true,
    }
  }
})
vim.lsp.enable('solargraph')

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

vim.lsp.config('ruby_lsp', {
  capabilities = capabilities,
  settings = {
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = true,
      definition = false,
      diagnostics = true,
      documentHighlights = true,
      documentLink = true,
      documentSymbols = true,
      foldingRanges = true,
      formatting = 'auto',
      hover = false,
      inlayHint = true,
      onTypeFormatting = true,
      selectionRanges = true,
      semanticHighlighting = true,
      signatureHelp = true,
      typeHierarchy = true,
      workspaceSymbol = true,
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
})
vim.lsp.enable('ruby_lsp')

vim.lsp.config('sorbet',{
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
    definitions = false,
    hover = false,
    signatureHelp = false,
  },
  rootPatterns = { "sorbet/config" },
})
vim.lsp.enable('sorbet')

--- Vue.js

vim.lsp.config('vuels', {
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
})
vim.lsp.enable('vuels')

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})
vim.lsp.enable('ts_ls')

--- JavaScript

vim.lsp.config('eslint', {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = false,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
    }
  }
})
vim.lsp.enable('eslint')

vim.lsp.config('pyright', {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnusedExpression = "none",
        },
      },
    },
  },
})
vim.lsp.enable('pyright')

--- C/C++

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
