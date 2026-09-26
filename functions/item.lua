function leighzermods.utils.hideItem(itemName)
    local item = data.raw.item[itemName]
    item.hidden = true
end

function leighzermods.utils.showItem(itemName)
    local item = data.raw.item[itemName]
    item.hidden = false
end

function leighzermods.utils.setItemSubgroup(itemName, subgroup)
    local item = data.raw.item[itemName]
    item.subgroup = subgroup
end

function leighzermods.utils.setItemOrder(itemName, order)
    local item = data.raw.item[itemName]
    item.order = order
end

--simple item create function (not doing anything fancy with multiple images for icon)
--pictures is really not required unless you are adding an ore item and want the different variations
function leighzermods.utils.createItem(itemName,iconPath,iconSize,subgroup,order,stackSize,pictures, localised_name)
    data:extend({
        {
            type = "item",
            name = itemName,
            icon = iconPath,
            icon_size = iconSize,
            icon_mipmaps = 4,            
            subgroup = subgroup,
            order = order,
            stack_size = stackSize,
            pictures = pictures,
            localised_name = localised_name,
        }
    })
end

function leighzermods.utils.createItemComplex(itemName,icons,subgroup,order,stackSize,pictures, localised_name)
    data:extend({
        {
            type = "item",
            name = itemName,
            icons = icons,
            subgroup = subgroup,
            order = order,
            stack_size = stackSize,
            pictures = pictures,
            localised_name = localised_name,
        }
    })
end