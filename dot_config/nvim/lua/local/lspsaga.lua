local ok, lspsaga = pcall(require, 'lspsaga')
if not ok then
	return
end

lspsaga.setup({
	code_action_lightbulb = {
		enable = false, -- disable hints on code actions
	},
	rename_action_quit = "<Esc>" -- escape the rename with esc instead of <C-c>
})
