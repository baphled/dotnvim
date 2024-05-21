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

    -- Highlighting
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
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
        "nvim-tree/nvim-web-devicons"
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
      config = function()
        require("baphled.config.undotree")
      end
    },

    -- UI

    --- Startup screen
    {
      "startup-nvim/startup.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      config = function()
        require("baphled.config.startup")
      end
    },

    ---
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.noice")
      end
    },

    {
      'akinsho/bufferline.nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("baphled.config.bufferline")
      end
    },

    --- Used to handle our statusline
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      event = 'VeryLazy',
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

    --- Colour schemes
    {
      "catppuccin/nvim",
      as = "catppuccin",
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

    -- File tree
    {
      "nvim-tree/nvim-tree.lua",
      event = 'VeryLazy',
      config = function()
        require("baphled.config.nvim-tree")
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
      config = function()
        require("baphled.config.which-key")
      end
    },

    -- AI
    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function()
        require("baphled.config.chatgpt")
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
      }
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
      build = function() vim.fn["mkdp#util#install"]() end,
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

    -- Doesn't really need to be explained
    { "tpope/vim-fugitive" },

    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
        require("baphled.config.gitsigns")
      end,
    },

    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",        -- optional
      },
      event = 'VeryLazy',
      config = function()
        require("baphled.config.neogit")
      end
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
      'VonHeikemen/lsp-zero.nvim',
      dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
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
      event = 'VeryLazy',
      config = function()
        require("baphled.config.lsp-zero")
      end
    },


    ---- Mason
    {
      'williamboman/mason.nvim',
      lazy = true,
      config = function()
        require("baphled.config.mason")
      end
    },

    ---- Notifications
    {
      'rcarriga/nvim-notify',
      event = 'VeryLazy',
      config = function()
        require("baphled.config.notify")
      end
    },

    ---- Testing
    {
      "nvim-neotest/neotest",
      dependencies = {
        "olimorris/neotest-rspec",
        "nvim-neotest/neotest-jest",
        "alfaix/neotest-gtest",
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

    ---- Dart
    {
      'akinsho/flutter-tools.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
      event = 'VeryLazy',
    },

    ---- Ruby
    {
      'mihyaeru21/nvim-lspconfig-bundler',
      dependencies = 'neovim/nvim-lspconfig',
      lazy = true
    },
    { "bronson/vim-ruby-block-conv",    lazy = true },
    { "ecomba/vim-ruby-refactoring",    lazy = true },
    { "nelstrom/vim-textobj-rubyblock", lazy = true, dependencies = "kana/vim-textobj-user" },

    ---- Rails
    { "tpope/vim-rails",                lazy = true },

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
