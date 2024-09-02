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
