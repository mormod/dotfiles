local ok, tree = pcall(require, 'nvim-tree')
if not ok then
    return
end

tree.setup({
    view = {
        adaptive_size = true,
    },
})

-- close tree on buffer open
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter" }, { pattern = {"*.*"}, command = "NvimTreeClose" })
