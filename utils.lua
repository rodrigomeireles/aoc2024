-- utils.lua
local utils = {}

-- Function to print table contents
function utils.printTable(tbl, name)
	if not verbose then
		return
	end
	print(name .. ":")
	for _, v in ipairs(tbl) do
		print(v)
	end
end

-- Open file f and get text content
function utils.read_file(f)
	local file_handle = io.open(f, "r")
	if not file_handle then
		error("Could not open file " .. f)
	end
	local file_text = file_handle:read("*a")
	file_handle:close()
	return file_text
end

--[[
    This function searches for a pattern in a string, starting from the beginning, 
    and captures everything between the start of the string and the pattern.

    Parameters:
    s (string): The string in which to search for the pattern.
    pattern (string): The Lua pattern to search for.

    Returns:
    number, number, string:
        1. The starting position of the match (inclusive).
        2. The ending position of the match (inclusive).
        3. The captured substring, which contains all characters from the start 
           of the string up to (but not including) the match of the given pattern.
        Returns `nil` if no match is found.

    Notes:
    - The function uses the pattern "^(.-)" .. pattern to match lazily up to the given pattern.
      The `.-` ensures non-greedy matching of everything up to the pattern.

    Example:
    local s = "abc123"
    local pattern = "%d" -- matches digits
    local start_pos, end_pos, captured = find_until(s, pattern)
    -- start_pos = 1 (position of 'a')
    -- end_pos = 3 (position of 'c')
    -- captured = "abc"
--]]
function utils.find_until(s, pattern)
	return string.find(s, "^(.-)" .. pattern)
end

--[[
    This function searches for a substring that lies between two specified patterns in a given string.
    
    Parameters:
    s (string): The string in which to search for the patterns.
    start_pattern (string): The Lua pattern that marks the start of the desired substring.
    end_pattern (string): The Lua pattern that marks the end of the desired substring.

    Returns:
    number, number, string:
        1. The starting position of the match (inclusive).
        2. The ending position of the match (inclusive).
        3. The captured substring that lies between the `start_pattern` and `end_pattern`.
        Returns `nil` if no match is found.

    Notes:
    - The function uses the pattern `start_pattern .. "(.-)" .. end_pattern`.
      - `start_pattern` and `end_pattern` are treated as the boundaries of the desired substring.
      - `.-` ensures non-greedy matching of the smallest possible substring between the patterns.

    Example:
    local s = "This is the start--middle--and the end."
    local start_pattern = "start--"
    local end_pattern = "--and"
    local start_pos, end_pos, captured = find_between(s, start_pattern, end_pattern)
    -- start_pos = 9 (position of "start--")
    -- end_pos = 28 (position of "--and")
    -- captured = "middle"
--]]
function utils.find_between(s, start_pattern, end_pattern)
	return string.find(s, start_pattern .. "(.-)" .. end_pattern)
end

return utils
