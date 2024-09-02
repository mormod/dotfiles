local ok, lualine = pcall(require, 'lualine')
if not ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = false,
		section_separators = { left = '', right = ''}, -- make the line blocky
	},
	disabled_filetypes = {
		statusline = { "dashboard" }
	},
	extensions = {
		'nvim-tree'
	}
})
