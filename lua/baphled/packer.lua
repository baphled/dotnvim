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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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

  -- Enhanced searching
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

  -- Startup screen
  use({
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  })

  -- Color schemes
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.cmd('colorscheme catppuccin')
    end
  }

  use({
    "EdenEast/nightfox.nvim",
  })

  -- Improved quickfix window
  use({
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        icons = true,
        use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
        auto_close = true,           -- close the list when you open a file
      }
    end
  })

  -- navigation and file management

  -- Navigation AST
  use("nvim-treesitter/playground")

  -- Navigation
  use("theprimeagen/harpoon")

  -- The Refactoring library based off the Refactoring book by Martin Fowler
  use("theprimeagen/refactoring.nvim")

  -- Undo Tree
  --
  -- Used to navigate undo history
  use("mbbill/undotree")

  -- Git
  --
  -- Doesn't really need to be explained
  use("tpope/vim-fugitive")

  -- Markdown Preview
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }

  -- Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end, }

  use("nvim-treesitter/nvim-treesitter-context");

  -- UI
  --
  -- Used to handle our statusline
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  use { 'norcalli/nvim-colorizer.lua' }

  -- LSP and Autocompletion
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

      { "onsails/lspkind.nvim" },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use { 'mihyaeru21/nvim-lspconfig-bundler', requires = 'neovim/nvim-lspconfig' }

  -- AI powered autocompletion
  use("github/copilot.vim")

  -- Silly little visual games
  use("eandrju/cellular-automaton.nvim")

  -- Used to hide environment variables
  use("laytan/cloak.nvim")

  -- text objects
  use("tpope/vim-surround")
  use("kana/vim-textobj-user")
  use("michaeljsmith/vim-indent-object")

  -- Switching between files quickly
  use("rgroli/other.nvim")

  -- Ruby
  use("bronson/vim-ruby-block-conv")
  use("ecomba/vim-ruby-refactoring")
  use { "nelstrom/vim-textobj-rubyblock", requires = "kana/vim-textobj-user" }

  -- Rails
  use("tpope/vim-rails")

  -- File navigation
  use("nvim-tree/nvim-tree.lua")

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  }

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    requires = {
      "nvim-telescope/telescope.nvim",
      "folke/neodev.nvim"
    }
  }
  -- DAP telescope integration
  use { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } }
  -- Virtual text for DAP
  use { "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } }
  -- DAP UI
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  -- Ruby debugging
  use("suketa/nvim-dap-ruby")

  -- Testing
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

  -- Code Coverage
  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
  })
end)
