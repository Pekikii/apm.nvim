local key_press_times = {}

_G.calculate_apm = function()

    if not key_press_times then
        return 0
    end

    local current_time = vim.loop.hrtime()

    local filtered_times = {}
    for _, timestamp in ipairs(key_press_times) do
        if timestamp >= current_time - 5 * 1e9 then
            table.insert(filtered_times, timestamp)
        end
    end

    key_press_times = filtered_times

    if #key_press_times == 0 then
        return 0
    end

    local apm = #key_press_times * 12
    return string.format("%d", apm)

end

vim.on_key(function()
    local current_time = vim.loop.hrtime()

    table.insert(key_press_times, current_time)
end)

vim.loop.new_timer():start(0, 10, function()
    _G.calculate_apm()
    vim.schedule(function()
            vim.cmd("redrawstatus")
        end)
end)

local current_statusline = vim.o.statusline
vim.o.statusline = current_statusline ..  "APM:%{v:lua.calculate_apm()} "
