local which_scheme = "catppuccin"

vim.opt.termguicolors = true -- always true
vim.opt.background = 'dark' -- default

if which_scheme == 'gruvbox-material' then
    vim.opt.background = 'dark'
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_bold = 1

    vim.cmd([[colorscheme gruvbox-material]])
elseif which_scheme == 'gruvbox' then
    local ok, gruvbox = pcall(require, "gruvbox")
    if not ok then
        return
    end
    gruvbox.setup({
        contrast = "hard",
    })
    vim.cmd("colorscheme gruvbox")
elseif which_scheme == 'onedark' then
    local ok, onedark = pcall(require, "onedark")
    if not ok then
        return
    end
    onedark.setup({
        style = 'warm',
    })
    onedark.load()
elseif which_scheme == "kanagawa" then
    local ok, kana = pcall(require, "kanagawa")
    if not ok then
        return
    end
    kana.setup({
        background = {
            dark = "dragon",
            light = "lotus"
        }
    })
    vim.cmd("colorscheme kanagawa")
elseif which_scheme == "catppuccin" then
    vim.opt.background = 'light'
    local ok, cat = pcall(require, "catppuccin")
    if not ok then
        return
    end
    cat.setup({
        background = {
            light = "latte",
            dark = "latte",
        },
        integrations = {
            notify = true
        }
    })
    vim.cmd("colorscheme catppuccin")
end

-- Needs to be at end to override the settings by the colorschemes
-- if transparent then
--     vim.api.nvim_set_hl(0, "Normal", {bg = nil, guibg=nil, ctermbg = nil})
-- end

