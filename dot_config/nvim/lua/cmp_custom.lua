-- Setup nvim-cmp.
local cmp = require('cmp')

vim.opt.completeopt = 'menuone,noselect'

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["UltiSnips#CanJumpForwards"]() then
				vim.fn["UltiSnips#ExpandSnippetOrJump"]()
			elseif vim.fn["UltiSnips#CanExpandSnippet"]() then
				vim.fn["UltiSnips#ExpandSnippet"]()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
			end, {
				"i",
				"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["UltiSnips#CanJumpBackwards"]() then
				vim.fn["UltiSnips#JumpBackwards"]()
			else
			fallback()
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
		{ name = 'nvim_lsp', keyword_length = 2},
		{ name = 'ultisnips', keyword_length = 2 },
		{ name = 'path', keyword_length = 2 },
		{ name = 'buffer', keyword_length = 2 },
	}),
	experimental = {
		ghost_text = true,
	}
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

