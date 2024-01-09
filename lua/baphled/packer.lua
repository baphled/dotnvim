-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

if packer_bootstrap then
  require('packer').sync()
end

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Core Enhancements

  -- Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use("nvim-treesitter/nvim-treesitter-context");

  -- text objects
  use("tpope/vim-surround")
  use("kana/vim-textobj-user")
  use("michaeljsmith/vim-indent-object")

  --- Enhanced searching
  use {
    'nvim-telescope/telescope.nvim',
    -- or                            , branch = '0.1.x',
    requires = {
      {
        'nvim-lua/plenary.nvim',
        "sindrets/diffview.nvim",
        'nvim-telescope/telescope-fzy-native.nvim',
        'nvim-telescope/telescope-media-files.nvim',
        "nvim-tree/nvim-web-devicons"
      }
    }
  }

  ---- Improved quickfix window
  use({
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        stages = "fade_in_slide_out",
        icons = {
          spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
        },
        background_colour = "#000000",
        use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
        auto_close = true,           -- close the list when you open a file
      }
    end
  })

  -- Undo Tree
  --
  -- Used to navigate undo history
  use("mbbill/undotree")

  -- UI

  --- Startup screen
  use({
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  })

  --- Used to handle our statusline
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  --- Notifications
  use { 'stevearc/dressing.nvim' }

  --- Colour schemes
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.cmd('colorscheme catppuccin')
    end
  }

  --- File navigation
  use("nvim-tree/nvim-tree.lua")

  --- which-key
  --
  -- Used to centralise key bindings
  --
  -- Also used to show key bindings in real-time
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  }

  -- PDE

  --- Colour highlighting
  use { 'norcalli/nvim-colorizer.lua' }

  -- AI powered autocompletion
  use("github/copilot.vim")

  --- Used to hide environment variables
  use("laytan/cloak.nvim")

  --- Switching between files quickly
  use("rgroli/other.nvim")

  --- The Refactoring library based off the Refactoring book by Martin Fowler
  use("theprimeagen/refactoring.nvim")

  --- Navigation AST
  use("nvim-treesitter/playground")

  --- Markdown Preview
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }

  --- Git

  -- Doesn't really need to be explained
  use("tpope/vim-fugitive")

  use {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
  }

  --- documentation

  --- CSV
  use {
    'cameron-wags/rainbow_csv.nvim',
    config = function()
      require 'rainbow_csv'.setup()
    end,
    -- optional lazy-loading below
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
  }

  use {
    'godlygeek/tabular',
  }

  --- Markdown
  use({
    'jakewvincent/mkdnflow.nvim',
    rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
    config = function()
      require('mkdnflow').setup()
    end
  })

  --- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
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

      --- Beautification of the autocomplete menu
      { "onsails/lspkind.nvim" },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  ---- Notifications
  use { 'rcarriga/nvim-notify' }

  ---- Testing
  use({
    "nvim-neotest/neotest",
    requires = {
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-jest",
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec"),
          require('neotest-jest'),
        }
      })
    end
  })

  ---- Code Coverage
  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
  })

  --- Language Specific

  ---- Dart
  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }

  ---- Ruby
  use { 'mihyaeru21/nvim-lspconfig-bundler', requires = 'neovim/nvim-lspconfig' }
  use("bronson/vim-ruby-block-conv")
  use("ecomba/vim-ruby-refactoring")
  use { "nelstrom/vim-textobj-rubyblock", requires = "kana/vim-textobj-user" }

  ---- Rails
  use("tpope/vim-rails")

  --- Debugging (DAP)
  use {
    "mfussenegger/nvim-dap",
    requires = {
      "nvim-telescope/telescope.nvim",
      "folke/neodev.nvim"
    }
  }

  --- ENV
  use("tpope/vim-dotenv")

  --- Database
  use {
    "kristijanhusak/vim-dadbod-ui",
    requires = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    }
  }

  --- Telescope integration
  use { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } }

  --- Virtual text
  use { "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } }

  --- UI
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  ---- Language Specific

  use("suketa/nvim-dap-ruby")

  --- Novelty

  ---- Silly little visual games
  use("eandrju/cellular-automaton.nvim")
end)
