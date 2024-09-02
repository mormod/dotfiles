local options = {
	backup = false,
    colorcolumn = '120',
	writebackup = false,
	swapfile = false,
	splitright = true,
	splitbelow = true,
	filetype = 'on',
	spell = false,
	spelllang = 'de_de,en',
	mouse = 'a',
	scrolloff = 10,
	number = true,
	ignorecase = true,
	tabstop = 4,
	softtabstop = 0,
	shiftwidth = 0,
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
    textwidth = 0,
    wrapmargin = 0,
}

-- set selection mode
vim.opt.completeopt = 'menuone,noinsert,noselect'
-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

vim.opt.shortmess:append('c')
vim.opt.iskeyword:append('-')
vim.opt.whichwrap:append('<,>,[,],h,l')
vim.cmd("set nowrap")

for k,v in pairs(options) do
	vim.opt[k] = v
end

vim.opt["clipboard"] = "unnamedplus"
vim.opt["formatoptions"]:remove{"l"}
-- vim.opt["formatoptions"]:append{"t"}


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

vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
vim.api.nvim_create_autocmd("FileType", { pattern = "tex", command = [[setlocal spell spelllang=de]] })
