local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    print("lsp-zero missing")
    return
end

local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp then
	return
end

local ok_luasnip, luasnip = pcall(require, 'luasnip')
if not ok_luasnip then
    print("luasnip missing")
    return
end

local ok_mason, mason = pcall(require, 'cmp')
if not ok_mason then
	return
end

local ok_mason_lsp, mason_lsp = pcall(require, 'cmp')
if not ok_mason_lsp then
	return
end

mason.setup({})
mason_lsp.setup({
  handlers = {
    lsp.default_setup,
    rust_analyzer = lsp.noop,
  }
})

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    vim.keymap.set("n", "<leader>qf", "<cmd>Lspsaga code_action<cr>", {buffer = bufnr})
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
end)

lsp.ensure_installed({
    'rust_analyzer',
    'clangd',
    'bashls',
    'zls',
})

-- Fix Undefined global 'vim'

local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
	filetypes = {"c", "cpp", "objc", "objcpp"},
})

lspconfig.ols.setup({})

lspconfig.texlab.setup({})

lspconfig.pylsp.setup({})

lspconfig.bashls.setup({})

lspconfig.zls.setup({
    enable_autofix = false,
})

lspconfig.lua_ls.setup(
    lsp.nvim_lua_ls()
)

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            end
            end, {
                "i",
                "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
            end, {
                "i",
                "s",
        }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    },
    sources = cmp.config.sources({
        { name = 'omni' },
        { name = 'nvim_lsp',
            entry_filter = function(entry)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end },		{ name = 'buffer' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
    }),
    experimental = {
        ghost_text = true,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})
