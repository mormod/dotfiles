local ok, lsp_signature = pcall(require, 'lsp_signature')
if not ok then
	vim.notify('Config: Did not find lsp_signature!')
	return
end

lsp_signature.setup({
	bind = false,
    hint_prefix = "",
	handler_opts = {
		border ="single",
	}
})
