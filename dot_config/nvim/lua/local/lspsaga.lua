local ok, lspsaga = pcall(require, 'lspsaga')
if not ok then
	vim.notify('Config: Did not find lspsaga!')
	return
end

lspsaga.init_lsp_saga({
	code_action_lightbulb = {
		enable = false, -- disable hints on code actions
	},
	rename_action_quit = "<Esc>" -- escape the rename with esc instead of <C-c>
})
