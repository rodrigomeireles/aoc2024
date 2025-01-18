local filename = arg[1]
local verbose = arg[2]

local function mult_and_sum(text)
	local res = 0
	for x, y in string.gmatch(text, "mul%((%d%d?%d?),(%d%d?%d?)%)") do
		res = res + tonumber(x) * tonumber(y)
	end
	return res
end

local file_handle = io.open(filename, "r")
if not file_handle then
	error("Could not open file " .. filename)
end

local file_text = file_handle:read("*a")
file_handle:close()
print("Result " .. mult_and_sum(file_text))
-- pt1 is just a call to `mult_and_sum(file_text)`
