local ok, telekasten = pcall(require, "telekasten")
if not ok then
    print("Telekasten fucked.")
    return
end

telekasten.setup({
    home = vim.fn.expand("~/sciebo/notizen"),
})

vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
