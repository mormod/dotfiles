-- TODO: check, that vimtex is loaded
-- latex configuration

vim.cmd([[
    let g:vimtex_matchparen_enable = 0
    let g:tex_flavor = 'latex'
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_quickfix_mode = 0
    let g:vimtex_compiler_latexmk_engines = { '_' : '-xelatex', }
    let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : './aux',
        \ 'out_dir' : './out',
    \ }
]])
