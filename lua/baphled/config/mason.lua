require("baphled.config.cmp")
require("mason").setup({})
require('lspconfig-bundler').setup()

local util = require("lspconfig.util")

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path() ..
"/node_modules/@vue/language-server"

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
    'ts_ls',
    'volar',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup {
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
      }
    end,

    --- Ruby

    solargraph = function()
      require('lspconfig').solargraph.setup({
        capabilities = capabilities,
        root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
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
    end,

    rubocop = function()
      require('lspconfig').rubocop.setup({
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
    end,

    ruby_lsp = function()
      require('lspconfig').ruby_lsp.setup({
        capabilities = capabilities,
        init_options = {
          enabledFeatures = {
            codeActions = true,
            codeLens = true,
            completion = true,
            definition = true,
            diagnostics = true,
            documentHighlights = true,
            documentLink = true,
            documentSymbols = true,
            foldingRanges = true,
            formatting = 'auto',
            hover = true,
            inlayHint = true,
            onTypeFormatting = true,
            selectionRanges = true,
            semanticHighlighting = true,
            signatureHelp = true,
            typeHierarchy = true,
            workspaceSymbol = true,
          },
        },
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
        root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
      })
    end,

    sorbet = function()
      require('lspconfig').sorbet.setup({
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
        init_options = {
          definitions = false,
          hover = false,
          signatureHelp = false,
        },
        rootPatterns = { "sorbet/config" },
        filetypes = { "ruby" },
        root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
      })
    end,

    --- Vue
    volar = function()
      require('lspconfig').volar.setup({
        capabilities = capabilities,
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      })
    end,

    --- TypeScript
    ts_ls = function()
      require('lspconfig').ts_ls.setup({
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
