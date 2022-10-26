
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',           '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',           '<cmd>Telescope lsp_references<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r',    '<cmd>Lspsaga rename<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qf',   '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d',    '<cmd>Lspsaga hover_doc<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s',    '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>O',    '<cmd>Telescope lsp_document_symbols<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f',    '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end


-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
-- 	vim.lsp.handlers.hover,
-- 	{border = 'rounded'}
-- )

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 	vim.lsp.diagnostic.on_publish_diagnostics,
-- 	{}
-- )

local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"--pch-storage=memory",
		"--clang-tidy",
		"--all-scopes-completion",
		"--header-insertion=never",
		"-j=8",
		"--header-insertion-decorators",
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	init_option = { fallbackFlags = {  "-std=c++2a"  } },
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.fn.stdpath('data') .. "/site/pack/packer/opt/emmylua-nvim",
					vim.fn.stdpath('config'),
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		}
	},
	capabilities = capabilities,
})

lspconfig.texlab.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.jdtls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
