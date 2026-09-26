function leighzermods.utils.createFishFromGeneric(displayName,fishName,subgroup,craftingMenuOrder,stack_size)

    local baseName = displayName or fishName

    local item = {}
    item.type = "item"
    item.name = baseName
    
    item.icons = {{icon="__leighzerlib__/graphics/icons/oceanicprocessing/"..fishName..".png",icon_size=64}}        
    item.icon_mipmaps = 4
    item.subgroup = subgroup    
    item.order = craftingMenuOrder
    item.stack_size = stack_size
    item.localised_name = leighzermods.utils.toNiceName(item.name)

    data:extend({        
        item
    })
end

