local filename = arg[1]
local INCREASING, DECREASING = 1, 0

-- Although O(n) is possible here, O(n²) is much easier to implement
local function is_line_safe(line)
    for value in line then
        if 1 < value < 3 then
            -- safe
        end
    end

end

local function line_to_int(line)
    local int_line = {}
    for _level in string.gmatch(line, "%S+") do
        table.insert(int_line, tonumber(_level))
    end
    return int_line
end

local safe_lines = 0
for line in io.lines(filename) do
    local iline = line_to_int(line)
    if is_line_safe(iline) then
        safe_lines = safe_lines + 1
    else
       for i=1,#iline do
            local _line = vim.deepcopy(iline)
            table.remove(_line, i)
            if is_line_safe(_line) then
                safe_lines = safe_lines + 1
                break
            end
        end
    end
end
