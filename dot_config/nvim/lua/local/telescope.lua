local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify("Config: Did not find telescope!")
    return
end

telescope.setup({
    defaults = {
        scroll_strategz = "limit",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        selection_caret = " ",
        prompt_prefix = " ",
        entry_prefix = " ",
        file_ignore_patterns = { "node_modules", ".git" },
    },
    path_display = "smart",
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- path_display = { "truncate" },
    pickers = {
        find_files = {
            hidden = true,
        },
        lsp_references = {
            initial_mode = "normal",
        }
    },
})

-- make the highlight lines the same as a visual selection
vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })

-- keymaps
vim.api.nvim_set_keymap('n', '<leader>o', ':Telescope find_files<CR>', { noremap = true, silent = true })
