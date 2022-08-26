require('plugins')

vim.g.mapleader = ","

vim.cmd([[
	so ~/.config/nvim/legacy.vim
]])

-- lsp_signature.nvim
require('lsp_signature').setup({
	bind = false,
    hint_prefix = "",
	handler_opts = {
		border ="single",
	}
})

-- inlcude neovim LSP and autocomplete configurations
require('lsp_custom')
require('cmp_custom')

require('keymaps')
require('lualine').setup({
	options = {
		section_separators = { left = '', right = ''}, -- make the line blocky
	}
})
require('nvim-autopairs').setup({})

require('lspsaga').init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
	},
	rename_action_quit = "<Esc>"
})

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
	ensure_installed = {
		"c", "rust", "lua", "toml", "latex"
	},
	auto_install = true,
	indent = {
		enable = true,
	},
}

require('indent_blankline').setup {
	show_current_context = true,
}

require("mason").setup({})
require('fzf_lsp').setup({})

