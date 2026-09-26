function leighzermods.utils.createFluid(fluidName,baseColor,flowColor,icons,autoBarrel,subgroup,order, localised_name)
    data:extend({
        {
            type = "fluid",
            name = fluidName,
            default_temperature = 25,
            heat_capacity = "0.1KJ",
            base_color = baseColor,
            flow_color = flowColor,
            max_temperature = 100,
            icons = icons,
            auto_barrel = autoBarrel,      
            subgroup = subgroup,
            order = order,
            localised_name = localised_name,
          }
    })
end