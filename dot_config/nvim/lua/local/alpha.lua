local ok, alpha = pcall(require, 'alpha')
if not ok then
	vim.notify('Config: Did not find alpha!')
	return
end

alpha.setup(require('alpha.themes.startify').config)
