local filename = arg[1]
local verbose = arg[2]

-- Function to print table contents
local function printTable(tbl, name)
	if not verbose then
		return
	end
	print(name .. ":")
	for _, v in ipairs(tbl) do
		print(v)
	end
end

local function get_diff_array(tbl)
	local diff = {}
	printTable(tbl, "Array")
	for index, _ in ipairs(tbl) do
		if index < #tbl then
			table.insert(diff, index, tbl[index + 1] - tbl[index])
		end
	end
	printTable(diff, "Array diff")
	return diff
end

-- Although O(n) is possible here, O(n²) is much easier to implement
local function is_line_safe(line)
	local increasingSafe = true
	local decreasingSafe = true
	local diff = get_diff_array(line)
	-- INCREASING CHECK
	for _, value in pairs(diff) do
		if value < 1 or 3 < value then
			increasingSafe = false
			break
		end
	end
	-- DECREASING CHECK
	for _, value in pairs(diff) do
		if value > -1 or -3 > value then
			decreasingSafe = false
			break
		end
	end
	local safe = increasingSafe or decreasingSafe
	-- print("Line is safe: " .. tostring(safe))
	return safe
end

local function line_to_int_array(line)
	local int_line = {}
	for _level in string.gmatch(line, "%S+") do
		table.insert(int_line, tonumber(_level))
	end
	return int_line
end

local safe_lines = 0
for line in io.lines(filename) do
	local iline = line_to_int_array(line)
	if is_line_safe(iline) then
		safe_lines = safe_lines + 1
	else
		for i = 1, #iline do
			local _line = vim.deepcopy(iline)
			table.remove(_line, i)
			if is_line_safe(_line) then
				safe_lines = safe_lines + 1
				break
			end
		end
	end
end
print("Safe lines: " .. safe_lines)
