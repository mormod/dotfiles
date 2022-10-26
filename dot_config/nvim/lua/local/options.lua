local options = {
	backup = false,
	writebackup = false,
	swapfile = false,
	wrap = false,
	splitright = true,
	splitbelow = true,
	filetype = 'on',
	spell = false,
	spelllang = 'de_de,en',
	mouse = 'a',
	clipboard = 'unnamedplus',
	scrolloff = 10,
	number = true,
	ignorecase = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	signcolumn = 'yes',
	updatetime = 100,
	timeoutlen = 500,
	cursorline = true,
	foldenable = true,
	foldlevelstart = 99,
	foldnestmax = 3,
	foldmethod = 'indent',
	conceallevel = 0,
}

vim.opt.shortmess:append('c')
vim.opt.iskeyword:append('-')
vim.opt.whichwrap:append('<,>,[,],h,l')

for k,v in pairs(options) do
	vim.opt[k] = v
end


-- relative line numbers in normal, absolut in insert mode
vim.cmd([[
	augroup numbertoggle
	  autocmd!
	  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	augroup END
]])

-- jump to last position in file
vim.cmd([[
	if has("autocmd")
	  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
	endif
]])
