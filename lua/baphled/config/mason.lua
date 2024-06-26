require("mason").setup({})
require('lspconfig-bundler').setup()

local lsp_zero = require('lsp-zero')
local util = require("lspconfig.util")

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

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
    'solargraph',
    'tsserver',
    'volar',
    'vuels',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

    --- Ruby

    solargraph = function()
      require('lspconfig').solargraph.setup({
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
    end,

    ruby_lsp = function()
      require('lspconfig').ruby_lsp.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities,
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
    end,

    --- Vue
    vuels = function()
      require('lspconfig').vuels.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities,
        filetypes = { "vue", "javascript" },
        init_options = {
          config = {
            vetur = {
              completion = {
                autoImport = true,
                tagCasing = "kebab",
              },
              useWorkspaceDependencies = true,
              validation = {
                template = true,
                style = true,
                script = true,
              },
              format = {
                defaultFormatter = {
                  js = "prettier",
                  ts = "prettier",
                },
              },
              script = {
                indent = {
                  base = 0,
                },
              },
            },
          },
        },
      })
    end,

    --- TypeScript
    tsserver = function()
      require('lspconfig').tsserver.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact" },
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative",
          },
          format = {
            enable = true,
            options = {
              tabSize = 2,
              insertSpaces = true,
              singleQuote = true,
              trailingComma = "all",
            },
          },
        },
      })
    end,

    --- JavaScript
    eslint = function()
      require('lspconfig').eslint.setup({
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
    end,

    clangd = function()
      require('lspconfig').clangd.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities,
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = util.root_pattern("compile_commands.json", ".git"),
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
    end,

    pyright = function()
      require("lspconfig")["pyright"].setup({
        on_attach = lsp_zero.on_attach,
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
    end
  }
})
