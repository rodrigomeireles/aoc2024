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
    for _, v in ipairs(tbl) do
        print(v)
    end
end

-- printTable(x, "That was x")
-- printTable(y, "That was y")

table.sort(x)
table.sort(y)

-- printTable(x, "That was sorted x")
-- printTable(y, "That was sorted y")

local res = {}
for i = 1, #x do
    res[i] = math.abs(x[i] - y[i])
end

local function sum(tbl)
    local acc = 0
    for _, el in ipairs(tbl) do
        acc = acc + el
    end
    return acc
end

printTable(res, "Those are the distances")
print("This the answer:", sum(res))
