
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'tpope/vim-commentary'
	use 'tpope/vim-dispatch'
	use 'tpope/vim-fugitive'
	use 'junegunn/limelight.vim'
	use 'junegunn/goyo.vim'
	use 'neovim/nvim-lspconfig'
	use 'glepnir/lspsaga.nvim'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-git'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
	use 'nvim-lualine/lualine.nvim'
	use 'ntpeters/vim-better-whitespace'
	use 'morhetz/gruvbox'
	use 'sainnhe/gruvbox-material'
	use 'lervag/vimtex'
	use 'SirVer/ultisnips'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'ray-x/lsp_signature.nvim'
	use 'windwp/nvim-autopairs'
	use 'simrat39/rust-tools.nvim'
	use 'williamboman/mason.nvim'
	use 'nvim-lua/plenary.nvim'
	use {'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }}
	use 'kyazdani42/nvim-tree.lua'
	use 'moll/vim-bbye'
    use 'nvim-telescope/telescope.nvim'
    use 'akinsho/toggleterm.nvim'
    use 'lewis6991/gitsigns.nvim'
end)

