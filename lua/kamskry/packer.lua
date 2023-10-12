-- Only required if you have packer configured as `opt`
local lsp = require("lsp-zero")
lsp.nvim_workspace()
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      "nvim-telescope/telescope.nvim",
      requires = {
          { 'nvim-lua/plenary.nvim' },
          { "nvim-telescope/telescope-live-grep-args.nvim" },
      },
      config = function()
          require("telescope").load_extension("live_grep_args")
      end
  }

  use("nvim-telescope/telescope-fzy-native.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")

  use({
	  'marko-cerovac/material.nvim',
	  as = 'material',
	  config = function()
		  vim.cmd('colorscheme material')
	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");
  -- Tree view like in most editors
  use("nvim-tree/nvim-tree.lua");
  -- Icons for the tree view
  use("nvim-tree/nvim-web-devicons");
  -- This is for the "powerline"?
  use("nvim-lualine/lualine.nvim");
  --snippets
  use("hrsh7th/vim-vsnip");
  use("hrsh7th/vim-vsnip-integ");
  use("Neevash/awesome-flutter-snippets");
  use("RobertBrunhage/flutter-riverpod-snippets")
  -- global search and replace
  use("nvim-pack/nvim-spectre");

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use("github/copilot.vim")

  use {
      'akinsho/flutter-tools.nvim',
      requires = {
          'nvim-lua/plenary.nvim',
          'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
  }

  use("dart-lang/dart-vim-plugin")
end)
