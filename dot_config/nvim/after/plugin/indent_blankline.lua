local ok, blankline = pcall(require, 'ibl')
if not ok then
	return
end

blankline.setup {
    scope = {
        show_start = false,
        show_end = false,
    }
}
