function leighzermods.utils.createItemGroup(itemGroupName,craftingTabOrder,inventoryOrder, icons, localised_name)
    data:extend({
        {
            type = "item-group",
            name = itemGroupName,
            order = craftingTabOrder,
            inventory_order = inventoryOrder,
            icons = icons,
            localised_name = localised_name,
          }
    })
end

function leighzermods.utils.deleteItemGroup(itemGroupName)
    if data.raw["item-group"][itemGroupName] then
        data.raw["item-group"][itemGroupName] = nil
    end
end

function leighzermods.utils.createItemSubgroup(itemSubgroupName,itemGroupName,rowOrder)
    data:extend({
        {
            type = "item-subgroup",
            name = itemSubgroupName,
            group = itemGroupName,
            order = rowOrder,
        }
    })
end

function leighzermods.utils.deleteItemSubgroup(itemSubgroupName)
    if data.raw["item-subgroup"][itemSubgroupName] then
        data.raw["item-subgroup"][itemSubgroupName] = nil
    end
end