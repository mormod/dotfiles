local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp then
	return
end

local ok_luasnip, luasnip = pcall(require, 'luasnip')
if not ok_luasnip then
    return
end

local ok_luasnip_extra, extras = pcall(require, 'luasnip.extras')
if not ok_luasnip_extra then
    return
end

luasnip.config.set_config({
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
})

local s = luasnip.snippet
local sn = luasnip.snippet_node
local isn = luasnip.indent_snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local r = luasnip.restore_node
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta

function format_headline(title_string, parent, user_args)
    local lower_title = string.lower(tostring(title_string[1][1]))
    local only_alphnum_title = string.gsub(lower_title, "[^%w+]", "-")
    local dashed_title_many = string.gsub(only_alphnum_title, "(%s+)", "-")
    local dashed_title = string.gsub(dashed_title_many, "(-+)", "-")
    return dashed_title
end

luasnip.add_snippets("tex", {
    s(
        { trig = "\\(%w+)", trigEngine="pattern" },
        {
            f(function(_, snip)
		    	return "\\" .. snip.captures[1] .. "{"
		    end),
            i(1, "argument"), t("}"), i(2)
        }
    ),
    s({trig = "\\sec", snippetType="autosnippet"},
        fmta(
            [[
            \section{<>}
            \label{sec:<>}
            ]],
            {
                i(1),
                f(format_headline, {1}, {}),
            }
        )
    ),
    s({trig = "\\ssec", snippetType="autosnippet"},
        fmta(
            [[
            \subsection{<>}
            \label{ssec:<>}
            ]],
            {
                i(1),
                f(format_headline, {1}, {}),
            }
        )
    ),
    s({trig = "\\sssec", snippetType="autosnippet"},
        fmta(
            [[
            \subsubsection{<>}
            \label{sssec:<>}
            ]],
            {
                i(0),
                f(format_headline, {0}, {}),
            }
        )
    ),
    s({trig = "\\beg", snippetType="autosnippet"},
        fmta(
            [[
            \begin{<>}
                <>
            \end{<>}
            ]],
            {
                i(1),
                i(0),
                f(format_headline, {1}, {}),
            }
        )
    ),
    s({trig = "\\enum", snippetType="autosnippet"},
        fmta(
            [[
            \begin{enumerate}[label=(\arabic*)]
                \item <>
            \end{enumerate}
            ]],
            {
                i(0),
            }
        )
    ),
    s({trig = "\\itemize", snippetType="autosnippet"},
        fmta(
            [[
            \begin{itemize}
                \item <>
            \end{itemize}
            ]],
            {
                i(0),
            }
        )
    ),
    s({trig = "\\figure", snippetType="autosnippet"},
        fmta(
            [[
            \begin{figure}
                \centering
                \includegraphics[width=\textwidth, keepaspectratio]{<>}
                \caption{<>}
                \label{<>}
            \end{figure}
            ]],
            {
                i(1), i(2), f(format_headline, {1}, {})
            }
        )
    ),
    s({trig="\\tit", snippetType="autosnippet"}, {
        t("\\textit{"), i(0), t("}")
    }),
    s({trig="\\ttt", snippetType="autosnippet"}, {
        t("\\texttt{"), i(0), t("}")
    }),
    s({trig="\\tbf", snippetType="autosnippet"}, {
        t("\\textbf{"), i(0), t("}")
    }),
    s({trig="$", snippetType="autosnippet"}, {
        t("\\( "), i(1), t(" \\)"), i(0)
    }),
})

-- set selection mode
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

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
		ghost_text = false,
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

