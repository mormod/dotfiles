" disable all backup files
set nobackup
set nowritebackup

" file type detection
set filetype=on

" spell checking, but disable by default
set nospell
set spelllang=de_de,en

" activate mouse support
set mouse=nvi

" offset from cursor to top and bottom
set scrolloff=10

" case insensitive searching
set ignorecase

" activate line numbers
set number

" expand all tabs to spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent

" Set time until plugin triggering
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" activate highlighting of current line
set cursorline

" syntax highlighting files
set runtimepath+=~/.config/nvim/syntax

" colorscheme
set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_bold = 1

" set colorscheme
colorscheme gruvbox-material

" folding
set foldenable
set foldlevelstart=0   " close all folds by default
set foldnestmax=3
set foldmethod=indent
nnoremap <silent> f za <bar> :IndentBlanklineRefresh<cr>

" set jump-forward/backwards to Alt left right
nnoremap <A-l> <C-I>
nnoremap <A-h> <C-O>

" Disable arrow keys to get used to vim bindings
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

" Easily resize buffers
nnoremap <silent> <c-Up> :resize -1<CR>
nnoremap <silent> <c-Down> :resize +1<CR>
nnoremap <silent> <c-left> :vertical resize -1<CR>
nnoremap <silent> <c-right> :vertical resize +1<CR>

" Goyo and limelight
nnoremap <C-g> :Goyo<CR>
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:goyo_linenr=1
let g:goyo_width=140

" latex configuration
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \}

" UltiSnips configuration
let &runtimepath.=',~/.vim' " Append parent of 'ulti-snips' to runtimepath
let g:UltiSnipsExpandTrigger="<c-cr>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["ulti-snips"]

" Jump to last position in opened file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" relative line numbers in normal mode, absolute line numbers in input mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

