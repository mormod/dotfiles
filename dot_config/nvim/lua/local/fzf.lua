local ok, fzf_lsp = pcall(require, 'fzf_lsp')
if not ok then
	return
end

fzf_lsp.setup({})

-- vim.api.nvim_set_var('fzf_preview_window', "['up:50%']")

-- file opening without tree or :{e,split,vsplit} ...
vim.api.nvim_set_keymap('n', '<leader>o', ':GFiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-o>', ':Files<CR>', { noremap = true, silent = true })
