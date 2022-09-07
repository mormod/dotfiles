local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
	vim.notify('Config: Did not find nvim-autopairs!')
	return
end

autopairs.setup({})
