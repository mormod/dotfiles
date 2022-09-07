local ok, mason = pcall(require, 'mason')
if not ok then
	vim.notify('Config: Did not find mason!')
	return
end

mason.setup({})
