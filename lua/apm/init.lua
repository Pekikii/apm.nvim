local M = {}

local key_press_times = {}

function M.calculate_apm()
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

function M.on_key_press()
    local current_time = vim.loop.hrtime()
    table.insert(key_press_times, current_time)
end

function M.start_apm_timer()
    vim.loop.new_timer():start(0, 1000, function()
        M.calculate_apm()
        vim.schedule(function()
            vim.cmd("redrawstatus")
        end)
    end)
end

function M.setup_statusline()
    local current_statusline = vim.o.statusline
    vim.o.statusline = current_statusline .. " APM:%{v:lua.require'apm'.calculate_apm()} "
end

function M.setup()
    vim.on_key(M.on_key_press)

    M.start_apm_timer()

    M.setup_statusline()
end

return M
