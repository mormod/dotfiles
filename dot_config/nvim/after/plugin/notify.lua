local ok, notify = pcall(require, "notify")
if not ok then
    return
end

notify.setup({
    render = "compact",
    minimum_width = 40,
    fps = 60,
    stages = "fade",
})
