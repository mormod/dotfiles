local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
    return
end

-- better syntax highlighting
treesitter.setup {
    highlight = {
        enable = true,
        disable = {"latex", "tex"},
    },
    ensure_installed = {"regex", "markdown_inline"},
	auto_install = true, -- install new syntax files for unknown file types on demand
	indent = {
		enable = true,
	},
}
