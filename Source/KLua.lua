local utf8 = require("utf8char")

local merge = function(tbl)
    local returnString
    
    assert(#tbl >= 1 and #tbl <= 3, "merge needs 1~3 jamoeums")

    for k,v in pairs(tbl) do
        local byte = utf8.byte(v)

        if k == 1 or k == 3 then
            assert(byte >= 12593 and byte <= 12622, "merge needs korean jaeums as first, third arguments.")
        else
            assert(byte >= 12623 and byte <= 12643, "merge needs korean moeums as second arguments.")
        end
    end

    if(#tbl == 1) then
        returnString = tbl[1]
    elseif(#tbl == 2) then
        local first = utf8.byte(tbl[1]) - 8241
        local second = utf8.byte(tbl[2]) - 8174
        local indexFirst = first - 4352
        local indexSecond = second - 4449

        local c = 44032 + 21*28*indexFirst + 28*indexSecond
        returnString = utf8.char(44032 + 21*28*indexFirst + 28*indexSecond)
    elseif(#tbl == 3) then
        local first = utf8.byte(tbl[1]) - 8241
        local second = utf8.byte(tbl[2]) - 8174
        local third = utf8.byte(tbl[3]) - 8241

        local indexFirst = first - 4352
        local indexSecond = second - 4449
        local indexThird = third - 4352
        if(indexThird < 8) then
            indexThird = indexThird + 1
        elseif(indexThird < 18) then
            indexThird = indexThird
        elseif(indexThird < 22) then
            indexThird = indexThird - 1
        else
            indexThird = indexThird - 2
        end
        local c = 44032 + (21*indexFirst + indexSecond)*28 + indexThird
        returnString = utf8.char(c)
    end
    
    return returnString
end

local chosungs = {"ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"}
for k,v in pairs(chosungs) do
    chosungs[v] = k
end
for k,v in ipairs(chosungs) do
    chosungs[k] = nil
end

local exists = function(origStr, toFind)
    local byteToFind = utf8.byte(toFind)
    if byteToFind < 12593 or byteToFind > 12622 then
        return utf8.find(origStr, toFind) ~= nil
    end
    local indexToFind = chosungs[toFind] - 1
    if(indexToFind == nil) then
        return utf8.find(origStr, toFind) ~= nil
    end
    
    for ik = 1, utf8.len(origStr) do
        local var = utf8.sub(origStr, ik, ik)
        local base = utf8.byte(var)
        
        local indexFirst = math.floor(((((base-44032) - (base-44032)%28))/28) / 21)
        
        if(indexFirst == indexToFind) then
            return true
        end
    end

    return false
end

local returnTable = {}
for k,v in pairs(utf8) do
    returnTable[k] = v
end
returnTable.merge = merge
returnTable.exists = exists

return returnTable