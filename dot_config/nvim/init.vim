call plug#begin()
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/gruvbox-material'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua require("nvim-tree").setup()
lua require("indent_blankline").setup()

" Disable all backup files
set nobackup
set nowritebackup

" filetype detection
set filetype=on

" spellchecking 
set spell
set spelllang=de_de,en

" Activate mouse support
set mouse=nvi

" Offset from cursor to top and bottom
set scrolloff=10

" case insensitive searching
set ignorecase

" Activate line numbers
set number

" relative line numbers in normal mode, absolute line numbers in input mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Expand all tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Reduce from 4000
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" activate highlighting of current line
set cursorline

" folding
set foldenable
set foldlevelstart=0   " close all folds by default
set foldnestmax=3
set foldmethod=indent
nnoremap <silent> <space> za <bar> :IndentBlanklineRefresh<cr>

" highlight the current surrounding indent line of the cursor 
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_space_char_blankline = " "
autocmd CursorMoved * IndentBlanklineRefresh

" i have no idea
set runtimepath+=~/.config/nvim/syntax

" remap leader from \ to , 
let mapleader=","

" Goyo and limelight
nnoremap <C-g> :Goyo<CR>
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

nnoremap <silent> <c-Up> :resize -1<CR>
nnoremap <silent> <c-Down> :resize +1<CR>
nnoremap <silent> <c-left> :vertical resize -1<CR>
nnoremap <silent> <c-right> :vertical resize +1<CR>

" UltiSnips configuration
let &runtimepath.=',~/.vim' " Append parent of 'ulti-snips' to runtimepath
let g:UltiSnipsExpandTrigger="<c-cr>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsSnippetDirectories=["ulti-snips"]

" nvimTree Config 
nnoremap <C-n> :NvimTreeFocus<CR>
nnoremap <C-t> :NvimTreeToggle<CR>

" vim airline powerline fonts
let g:airline_powerline_fonts=1

" Styling
set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

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

" Jump to last position in opened file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <C-a>  :<C-u>CocFzfList diagnostics<cr>
" Find symbol of current document
nnoremap <silent><nowait> <C-o>  :<C-u>Files<cr>
" Find symbol of current document
nnoremap <silent><nowait> <C-space>  :<C-u>Rg<cr>
" Search available sub commands.
nnoremap <silent><nowait> <C-d>  :<C-u>CocFzfList symbols<cr>
" Search workspace symbols
nnoremap <silent><nowait> <C-A-l>  :<C-u>CocFzfList<cr>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" add cocstatus into lightline
let g:lightline = {
	\ 'colorscheme': 'gruvbox_material',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status'
	\ },
	\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
