
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


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
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f',    '<cmd>lua vim.lsp.buf.format()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r',    '<cmd>Lspsaga rename<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qf',   '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d',    '<cmd>Lspsaga hover_doc<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s',    '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>O',    '<cmd>Telescope lsp_document_symbols<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end


-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"
local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = {
		"clangd",
        "--query-driver=/usr/bin/arm-none-eabi-*",
		"--background-index",
		"--pch-storage=memory",
		"--clang-tidy",
		"--header-insertion=never",
		"-j=8",
		"--header-insertion-decorators",
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
	init_option = { fallbackFlags = {  "-std=c++2a"  } },
	capabilities = capabilities,
})

local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

-- lspconfig.rust_analyzer.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
--     settings = {
--         ["rust-analyzer"] = {
--             imports = {
--                 granularity = {
--                     group = "module",
--                 },
--                 prefix = "self",
--             },
--             cargo = {
--                 buildScripts = {
--                     enable = true,
--                 },
--             },
--             procMacro = {
--                 enable = true
--             },
--         }
--     }
-- })

lspconfig.texlab.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.pylsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
    settings = {
        configurationSources = {"flake8"},
        formatCommand = {"black"},
        pylsp = {
        plugins = {
        -- jedi_completion = {fuzzy = true},
        -- jedi_completion = {eager=true},
            jedi_completion = {
                include_params = true,
            },
            jedi_signature_help = {
                enabled = true
            },
            pyflakes = {
                enabled=true
            },
            pylint = {
                args = {'--ignore=E501,E231', '-'},
                enabled=true,
                debounce=200
            },
            pylsp_mypy={enabled=false},
            pycodestyle={
                enabled=true,
                ignore={'E501', 'E231'},
                maxLineLength=120},
                yapf={enabled=true}
            }
        }
    }
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
