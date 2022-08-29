-- include all plugins
require('plugins')

-- set the leader to komma
vim.g.mapleader = " "

-- include everything that i am too lazy to port to lua
vim.cmd([[
	so ~/.config/nvim/legacy.vim
]])

require('lsp_signature').setup({
	bind = false,
    hint_prefix = "",
	handler_opts = {
		border ="single",
	}
})

-- inlcude neovim LSP and autocomplete configurations, as well as other custom keymaps
require('lsp_custom')
require('cmp_custom')

require('lualine').setup({
	options = {
		icons_enabled = false,
		section_separators = { left = '', right = ''}, -- make the line blocky
	},
	disabled_filetypes = {
		statusline = { "dashboard" }
	}
})

-- set up nice bracket matching
require('nvim-autopairs').setup({})

-- nice popups and stuff for the lsp
require('lspsaga').init_lsp_saga({
	code_action_lightbulb = {
		enable = false, -- disable hints on code actions
	},
	rename_action_quit = "<Esc>" -- escape the rename with esc instead of <C-c>
})

-- best syntax highlighting
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
	auto_install = true, -- install new syntax files for unknown file types on demand
	indent = {
		enable = true,
	},
}

require('indent_blankline').setup {
	show_current_context = true, -- highlight the current relevant indent
}

-- package manager for LSPs
require("mason").setup({})

-- enhancement of FZF to display references and so on
require('fzf_lsp').setup({})

require('alpha').setup(require('alpha.themes.startify').config)

require("nvim-tree").setup({
  view = {
    adaptive_size = true,
  },
})

require('keymaps')

