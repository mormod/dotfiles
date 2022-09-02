return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'tpope/vim-commentary'
	use 'tpope/vim-dispatch'
	use 'tpope/vim-fugitive'
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	use 'junegunn/limelight.vim'
	use 'junegunn/goyo.vim'
	use 'neovim/nvim-lspconfig'
	use 'glepnir/lspsaga.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-git'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
	use 'hrsh7th/nvim-cmp'
	use 'nvim-lualine/lualine.nvim'
	use 'ntpeters/vim-better-whitespace'
	use 'zefei/vim-colortuner'
	use 'morhetz/gruvbox'
	use 'sainnhe/gruvbox-material'
	use 'lervag/vimtex'
	use 'SirVer/ultisnips'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'ray-x/lsp_signature.nvim'
	use 'windwp/nvim-autopairs'
	use 'simrat39/rust-tools.nvim'
	use 'williamboman/mason.nvim'
	use 'gfanto/fzf-lsp.nvim'
	use 'nvim-lua/plenary.nvim'
	use {'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }}
	use 'kyazdani42/nvim-tree.lua'
	use 'mhinz/vim-signify'
	use 'akinsho/bufferline.nvim'
	use 'moll/vim-bbye'
end)
