local filename = arg[1] -- read argument from stdin
local x, y = {}, {}
for line in io.lines(filename) do
    local a, b = string.match(line, "(%S+)%s+(%S+)")
    table.insert(x, tonumber(a))
    table.insert(y, tonumber(b))
end


-- Function to print table contents
local function printTable(tbl, name)
    print(name .. ":")
    for k, v in pairs(tbl) do
        print(k, v)
    end
end

local seen = {}

printTable(x, "This is x")
printTable(y, "This is y")

for _, el in ipairs(x) do
    if seen[el] then
        goto continue
    end
    seen[el] = 0
    for _, v in ipairs(y) do
        if el == v then
            seen[el] = seen[el] + 1
        end
    end
    ::continue::
end

printTable(seen, "Scores!")

local similarity = 0

for i = 1, #x do
    similarity = similarity + seen[x[i]] * x[i]
end

print(similarity)
