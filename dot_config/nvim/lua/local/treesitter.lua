local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
	vim.notify('Config: Did not find treesitter!')
    return
end

-- better syntax highlighting
treesitter.setup {
    highlight = {
        enable = true,
    },
	auto_install = true, -- install new syntax files for unknown file types on demand
	indent = {
		enable = true,
	},
}
