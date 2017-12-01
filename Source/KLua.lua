local returnTable = {}

local utf8 = require("utf8char")

local merge = function(tbl)
    local returnString
    local indexLast
    if(#tbl == 1) then
        return tbl[1]
    elseif(#tbl == 2) then
        local first = utf8.byte(tbl[1]) - 8241
        local second = utf8.byte(tbl[2]) - 8174
        local indexFirst = first - 4352
        local indexMid = second - 4449
        local c = 0xAC00 + 21*28*indexFirst + 28*indexMid
        returnString = utf8.char(0xAC00 + 21*28*indexFirst + 28*indexMid)
    elseif(#tbl == 3) then
        local first = utf8.byte(tbl[1]) - 8241
        local second = utf8.byte(tbl[2]) - 8174
        local third = utf8.byte(tbl[3]) - 4519
        local indexFirst = first - 4352
        local indexMid = second - 4449
        local indexLast = second - 4449
        local c = 0xAC00 + 21*28*indexFirst + 28*indexMid
        returnString = utf8.char(0xAC00 + (21*indexFirst)*28 + 28*indexMid + third)
    end

    return returnString
end

print(merge({"ㄱ", "ㅏ", "ㅇ"}))

return returnTable