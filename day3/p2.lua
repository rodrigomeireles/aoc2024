package.path = package.path .. ";../?.lua"
local utils = require("utils")
local filename = arg[1]

local function mult_and_sum(text)
	local res = 0
	for x, y in string.gmatch(text, "mul%((%d%d?%d?),(%d%d?%d?)%)") do
		res = res + tonumber(x) * tonumber(y)
	end
	return res
end

local file_text = utils.read_file(filename)
local to_compute = ""
local start_pattern = "do%(%)"
local end_pattern = "don't%(%)"
local _, e, text = utils.find_until(file_text, end_pattern)
to_compute = to_compute .. text
file_text = string.sub(file_text, e + #end_pattern)
while true do
	local s, e, x = utils.find_between(file_text, start_pattern, end_pattern)
	if not s then
		s, e, x = utils.find_between(file_text, start_pattern, "$")
		if not s then
			break
		end
	end
	print("Pattern found at idx: " .. s)
	to_compute = to_compute .. x
	file_text = string.sub(file_text, e + #end_pattern)
end
print("Result " .. mult_and_sum(to_compute))
-- pt1 is just a call to `mult_and_sum(file_text)`
