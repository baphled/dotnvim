local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- check if firenvim is active
local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

require("lazy").setup({
    -- Core Enhancements

    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            vim.opt_local.foldenable = false
          end,
        })
      end,
      config = function()
        require("baphled.config.snacks")
      end
    },

    -- Highlighting
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      priority = 1001, -- this plugin needs to run before anything else
      build = ":TSUpdate",
      config = function()
        require("baphled.config.treesitter")
      end
    },

    -- text objects
    { "tpope/vim-surround", },
    { "kana/vim-textobj-user", },
    { "michaeljsmith/vim-indent-object", },

    --- Enhanced searching
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        "sindrets/diffview.nvim",
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-telescope/telescope-media-files.nvim',
        "nvim-tree/nvim-web-devicons",
        "debugloop/telescope-undo.nvim", -- Visualise undotree
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.telescope")
      end

    },

    ---- Improved quickfix window
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.trouble")
      end
    },

    -- Undo Tree
    --
    -- Used to navigate undo history
    {
      "mbbill/undotree",
      event = 'VeryLazy',
    },

    -- UI


    {
      "3rd/diagram.nvim",
      dependencies = {
        "3rd/image.nvim",
      },
      config = function()
        require("baphled.config.diagram")
      end
    },
    ---
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.noice")
      end
    },

    {
      "folke/edgy.nvim", -- Create predefined window layouts
      event = "VeryLazy",
      init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
      end,
      config = function()
        require("baphled.config.edgy")
      end
    },

    {
      'akinsho/bufferline.nvim',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("baphled.config.bufferline")
      end
    },

    --- Used to handle our statusline
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("baphled.config.lualine")
      end
    },

    --- Notifications
    {
      'stevearc/dressing.nvim',
      event = 'VeryLazy',
      config = function()
        require("baphled.config.dressing")
      end
    },

    -- Fuzzy find commands, search and help
    {
      "gelguy/wilder.nvim",
      keys = {
        ":",
        "/",
        "?",
      },
      dependencies = {
        "catppuccin/nvim",
      },
      config = function()
        require("baphled.config.wilder")
      end,
    },

    --- Search and Replace
    {
      "nvim-pack/nvim-spectre",
      lazy = true,
      cmd = { "Spectre" },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "catppuccin/nvim",
      },
      config = function()
        require("baphled.config.spectre")
      end,
    },

    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
    },

    --- Colour schemes
    {
      "catppuccin/nvim",
      config = function()
        require("baphled.config.colors/catppuccin")
        require("baphled.config.colors")
      end
    },

    --- File navigation
    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("baphled.config.oil")
      end
    },

    -- File mapping
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { { "nvim-lua/plenary.nvim" } },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.harpoon")
      end
    },

    --- which-key
    --
    -- Used to centralise key bindings
    --
    -- Also used to show key bindings in real-time
    {
      "folke/which-key.nvim",
      event = 'VeryLazy',
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "echasnovski/mini.icons"
      },
      config = function()
        require("baphled.config.which-key")
      end
    },

    -- AI
    {
      "yetone/avante.nvim",
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      -- ⚠️ must add this setting! ! !
      build = "make",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      config = function()
        require("baphled.config.avante")
      end,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },

    {
      "ravitemer/mcphub.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      cmd = "MCPHub",                          -- lazy load
      build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
      config = function()
        require("baphled.config.mcphub")
      end
    },

    -- PDE

    --- Colour highlighting
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require("baphled.config.colorizer")
      end
    },

    -- AI powered autocompletion
    {
      "github/copilot.vim",
      config = function()
        require("baphled.config.copilot")
      end
    },

    --- Used to hide environment variables
    {
      "laytan/cloak.nvim",
      event = 'VeryLazy',
      config = function()
        require("baphled.config.cloak")
      end
    },

    --- Switching between files quickly
    {
      "rgroli/other.nvim",
      event = 'VeryLazy',
      config = function()
        require("baphled.config.other")
      end
    },

    --- The Refactoring library based off the Refactoring book by Martin Fowler
    {
      "theprimeagen/refactoring.nvim",
      event = 'VeryLazy',
      config = function()
        require("baphled.config.refactoring")
      end
    },

    {
      "folke/zen-mode.nvim",
      config = function()
        require("baphled.config.zen-mode")
      end
    },

    {
      'jakewvincent/mkdnflow.nvim',
      config = function()
        require('mkdnflow').setup()
      end
    },
    --- Markdown Preview
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = "cd app && npm install && git restore .",
    },

    {
      "vhyrro/luarocks.nvim",
      priority = 1001, -- this plugin needs to run before anything else
      opts = {
        rocks = { "magick" },
      },
    },
    {
      "3rd/image.nvim",
      version = "*", -- recommended, use latest release instead of latest commit
      dependencies = { "luarocks.nvim" },
      config = function()
        require("baphled.config.image")
      end
    },

    {
      "epwalsh/obsidian.nvim",
      version = "*", -- recommended, use latest release instead of latest commit
      dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("baphled.config.obsidian")
      end,
    },

    --- Git
    {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
        "nvim-lua/plenary.nvim",
      },
    },

    -- Doesn't really need to be explained
    { "tpope/vim-fugitive" },

    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
        require("baphled.config.gitsigns")
      end,
    },

    --- documentation

    --- Comments
    {
      "tpope/vim-commentary",
      event = 'VeryLazy',
    },

    --- CSV
    {
      'cameron-wags/rainbow_csv.nvim',
      config = true,
      module = {
        'rainbow_csv',
        'rainbow_csv.fns'
      },
      ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
      }
    },

    --- LSP

    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Autocompletion
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-emoji' },

        --- Beautification of the autocomplete menu
        { "onsails/lspkind.nvim" },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
      },
    },


    {
      "ravibrock/spellwarn.nvim",
      event = "VeryLazy",
      config = true,
    },

    ---- Mason
    {
      'williamboman/mason.nvim',
      dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
      },
      config = function()
        require("baphled.config.mason")
        require("baphled.config.lsp")
      end
    },

    ---- Testing
    {
      "nvim-neotest/neotest",
      dependencies = {
        "olimorris/neotest-rspec",
        "nvim-neotest/neotest-jest",
        "alfaix/neotest-gtest",
        "nvim-contrib/nvim-ginkgo",
        "nvim-lua/plenary.nvim",
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.neotest")
      end,
    },

    ---- Code Coverage
    {
      "andythigpen/nvim-coverage",
      dependencies = "nvim-lua/plenary.nvim",
      event = 'VeryLazy',
      config = function()
        require("baphled.config.coverage")
      end
    },

    --- Language Specific

    ---- Ruby
    {
      'mihyaeru21/nvim-lspconfig-bundler',
      dependencies = 'neovim/nvim-lspconfig',
      lazy = true
    },

    ---- Rails
    { "tpope/vim-rails",   lazy = true },

    --- Debugging (DAP)
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "folke/neodev.nvim"
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.nvim-dap")
      end
    },

    --- ENV
    { "tpope/vim-dotenv",          lazy = true },

    --- Database
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-completion",
      },
      event = 'VeryLazy',
    },

    --- Telescope integration
    {
      "nvim-telescope/telescope-dap.nvim",
      dependencies = { "mfussenegger/nvim-dap" },
      event = 'VeryLazy',
    },

    --- Virtual text

    {
      "theHamsta/nvim-dap-virtual-text",
      dependencies = { "mfussenegger/nvim-dap" },
      lazy = true
    },

    --- UI
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
      lazy = true
    },

    ---- Language Specific

    { "suketa/nvim-dap-ruby",      lazy = true },
    { "mxsdev/nvim-dap-vscode-js", lazy = true },
    {
      "microsoft/vscode-js-debug",
      opt = true,
      run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },

    ---- Jupyter Notepad

    {
      "benlubas/molten-nvim",
      dependencies = { "3rd/image.nvim" },
      build = ":UpdateRemotePlugins",
      config = function()
        require("baphled.config.molten")
      end
    },
    {
      "quarto-dev/quarto-nvim",
      dependencies = {
        'jmbuhr/otter.nvim',
      },
      config = function()
        require("baphled.config.quarto")
      end
    },
    {
      "GCBallesteros/jupytext.nvim",
      config = function()
        require("baphled.config.jupytext")
      end
    },
    {
      "nvimtools/hydra.nvim",
      config = function()
        require("baphled.config.hydra")
      end
    },

    --- Security
    { 'mrjones2014/op.nvim',             run = 'make install' },

    --- Novelty

    ---- Silly little visual games
    { "eandrju/cellular-automaton.nvim", lazy = true },
  },
  {
    change_detection = {
      enable = true,
      notify = true,
    }
  }
)
