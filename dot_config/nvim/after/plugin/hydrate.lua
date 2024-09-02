
local ok, hydrate = pcall(require, "hydrate")
if not ok then
    return
end

hydrate.setup({
    msg_hydrated = "Timer reset!",
    msg_hydrate_now = "Time for a drink!",
    minute_interval = 30,
})
