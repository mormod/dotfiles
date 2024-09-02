
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
	use 'wbthomason/packer.nvim' -- this manager
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- highlighting
	use 'junegunn/limelight.vim' -- focus
	use 'junegunn/goyo.vim' -- focus
	use 'neovim/nvim-lspconfig' -- the lsp
	use 'hrsh7th/nvim-cmp' -- completion engine
	-- use {'hrsh7th/cmp-buffer', after = "hrsh7th/nvim-cmp", requires = "hrsh7th/nvim-cmp" } -- completion from buffer
	use 'hrsh7th/cmp-nvim-lsp' -- completion in lsp
	use 'hrsh7th/cmp-path' -- completion of paths
	use 'hrsh7th/cmp-cmdline' -- completion in command line
	use 'hrsh7th/cmp-git' -- git completion
	use 'nvim-lualine/lualine.nvim' -- status line
	use 'ntpeters/vim-better-whitespace' -- highlight whitespaces
	-- use 'morhetz/gruvbox' -- color
    use 'ellisonleao/gruvbox.nvim' -- another gruvbox
	use 'sainnhe/gruvbox-material' -- color
	use 'lervag/vimtex' -- easier tex in nvim
	use 'lukas-reineke/indent-blankline.nvim' -- vertical lines in indents
	use 'windwp/nvim-autopairs' -- auto match (, [, {
	use 'williamboman/mason.nvim'
	use 'nvim-lua/plenary.nvim'
	use {'goolord/alpha-nvim', requires = 'kyazdani42/nvim-web-devicons' } -- greeter
	use 'kyazdani42/nvim-tree.lua' -- tree
    use 'nvim-telescope/telescope.nvim' -- very cool pop ups
    use 'lewis6991/gitsigns.nvim' -- git inline annotations
    use 'L3MON4D3/LuaSnip' -- snippet manager
    use {'folke/trouble.nvim', requires = 'nvim-tree/nvim-web-devicons'} -- show errors in window
    use 'rcarriga/nvim-notify' -- notification manager
    use '~/src/hydrate.nvim' -- my hydration fork
    use 'navarasu/onedark.nvim' -- color
    use "rebelot/kanagawa.nvim" -- color
    use { "catppuccin/nvim", as = "catppuccin" } -- color
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    use({ -- progress of lsp
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    })
    use "mrcjkb/rustaceanvim"
    use { -- notes
        'renerocksai/telekasten.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }
    use ({
        'nvimdev/lspsaga.nvim',
        after = 'nvim-lspconfig',
        config = function()
            require('lspsaga').setup({})
        end,
    })
    use({
       "aserowy/tmux.nvim",
        config = function() return require("tmux").setup({
            resize = {
                enable_default_keybinding = false
            }
       }) end
    })
    use "folke/zen-mode.nvim"
end)

