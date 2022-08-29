-- activate focus mode
-- TODO: deactivate bar on enter, reactivate on exit
vim.api.nvim_set_keymap('n', '<C-g>', ':Goyo<CR>', {silent = true})

-- file opening without tree or :{e,split,vsplit} ...
vim.api.nvim_set_keymap('n', '<leader>o', ':GFiles<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-o>', ':Files<CR>', {silent = true})

-- nvim-tree --
-- close on buffer open
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter" }, { pattern = {"*.*"}, command = "NvimTreeClose" })
-- toggle tree
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { silent = true })

