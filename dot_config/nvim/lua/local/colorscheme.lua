
local which_scheme = 'gruvbox'

vim.opt.termguicolors = true -- always true
vim.opt.background = 'dark' -- dark or light

if which_scheme == 'gruvbox' then
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_bold = 1

    vim.cmd([[colorscheme gruvbox-material]])
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
    local ok, cat = pcall(require, "catppuccin")
    if not ok then
        return
    end
    cat.setup({
        background = {
            light = "latte",
            dark = "macchiato",
        },
        integrations = {
            notify = true
        }
    })
    vim.cmd("colorscheme catppuccin")
end

