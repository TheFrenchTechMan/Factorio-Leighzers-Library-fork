--just string utils for now
function leighzermods.utils.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function leighzermods.utils.dashAndUnderscoreToSpace(str)
    local dashesToSpace = (str:gsub("-", " "))
    local underscoreToSpace = (dashesToSpace:gsub("_"," "))

    return underscoreToSpace
end

function leighzermods.utils.toNiceName(str)
    local temp = leighzermods.utils.dashAndUnderscoreToSpace(str)

    return leighzermods.utils.firstToUpper(temp)
end