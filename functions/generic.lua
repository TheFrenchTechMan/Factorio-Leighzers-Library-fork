--functions to create new ores and items and fluids from generic gray scaled graphics provided in this library

local resource_autoplace = require("resource-autoplace")

--list of supported generic types
leighzermods.utils.supportedGenericItemTypes = {
    "bar",
    "brick",
    "cable",
    "coconut",
    "coin",
    "crystal",
    "cube",
    "electronic-circuit",
    "fish",    
    "gear-wheel",
    "nugget",
    "ore",
    "plate",
    "rocket-part",
    "sand",
    "science-pack",
    "slab",
    "steel-plate",
    "stick",
    "wood"    
}

function leighzermods.utils.createItemFromGeneric(materialName, tintName, genericTypeName,subgroup,craftingMenuOrder,stack_size)
    local baseName = materialName or tintName

    --make sure provided genericType is supported, otherwise make a fish
    local properGenericTypeName = false
    local isFactoricon = false
    for _,v in pairs(leighzermods.utils.supportedGenericItemTypes) do
      if genericTypeName == v then
        properGenericTypeName = true
        break
      end
    end
    if not properGenericTypeName then
      for _,v in pairs(leighzermods.leighzerfactoricons.factoriconNames) do
        if genericTypeName == v then
          properGenericTypeName = true
          isFactoricon = true
          break
        end
      end
    end
    if not properGenericTypeName then
      genericTypeName = "fish"
    end

    local item = {}
    item.tint = leighzermods.tints[tintName]
    item.type = "item"
    
    item.name = baseName .. "-" .. genericTypeName
    
    if isFactoricon then
      item.icons = {{icon="__leighzerlib__/graphics/icons/factoricons/"..genericTypeName..".png",tint=item.tint,icon_size=32}}    
    else 
      item.icons = {{icon="__leighzerlib__/graphics/icons/generic/generic-"..genericTypeName..".png",tint=item.tint,icon_size=64}}    
    end
    item.icon_mipmaps = 4

    -- for certain items, add top layer img to make them look bit better
    if genericTypeName == "electronic-circuit" then
      table.insert(item.icons, {icon="__leighzerlib__/graphics/icons/generic/circuit-traces.png",icon_size=64})
    elseif genericTypeName == "rocket-part" then
      table.insert(item.icons, {icon="__leighzerlib__/graphics/icons/generic/rocket-part-flairs.png",icon_size=64})
    elseif genericTypeName == "science-pack" then
      table.insert(item.icons, {icon="__leighzerlib__/graphics/icons/generic/science-pack-flask.png",icon_size=64})
    elseif genericTypeName == "fish" then
      table.insert(item.icons, {icon="__leighzerlib__/graphics/icons/generic/fish-stripes.png",icon_size=64})    
    elseif genericTypeName == "crystal" then
      table.insert(item.icons, {icon="__leighzerlib__/graphics/icons/generic/crystal-highlights.png",icon_size=64})    
    end
    
    if genericTypeName == "ore" then
        item.pictures = {
            { size = 64, filename = "__leighzerlib__/graphics/icons/generic/generic-ore.png",   scale = 0.25, mipmap_count = 4, tint = item.tint },
            { size = 64, filename = "__leighzerlib__/graphics/icons/generic/generic-ore-1.png", scale = 0.25, mipmap_count = 4, tint = item.tint },
            { size = 64, filename = "__leighzerlib__/graphics/icons/generic/generic-ore-2.png", scale = 0.25, mipmap_count = 4, tint = item.tint },
            { size = 64, filename = "__leighzerlib__/graphics/icons/generic/generic-ore-3.png", scale = 0.25, mipmap_count = 4, tint = item.tint },
          }
    end
    item.subgroup = subgroup    
    item.order = craftingMenuOrder
    item.stack_size = stack_size
    item.localised_name = leighzermods.utils.toNiceName(item.name)

    data:extend({        
        item
    })
end

function leighzermods.utils.createFluidFromGeneric(materialName,tintName,includeLiquidPrefix,subgroup,craftingMenuOrder)

  local baseName = materialName or tintName

  local fluid = {}
  fluid.tint = leighzermods.tints[tintName]
  fluid.type = "fluid"
  fluid.name = baseName
  fluid.icons = {{icon="__leighzerlib__/graphics/icons/generic/generic-liquid.png",tint=fluid.tint,icon_size=64}}    
  if includeLiquidPrefix then
    fluid.name = "liquid-"..fluid.name
  end
  fluid.default_temperature = 25
  fluid.heat_capacity = "0.1KJ"
  fluid.base_color = fluid.tint
  fluid.flow_color = fluid.tint
  fluid.max_temperature = 100    
  fluid.subgroup = subgroup    
  fluid.order = craftingMenuOrder
  fluid.localised_name = leighzermods.utils.toNiceName(fluid.name)

  data:extend({
    fluid
  })
end

function leighzermods.utils.createOreParticleFromGeneric(materialName, tintName)
    local baseName = materialName or tintName

    local tint = leighzermods.tints[tintName]

    data:extend({
    {--prototype for particles that fly out when you hand mine the ore in the ground    
    type = "optimized-particle",
    name = baseName .. "-ore-particle",    
    life_time = 180,
    pictures =
    {
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/generic-ore-particle-1.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-1.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/generic-ore-particle-2.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-2.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/generic-ore-particle-3.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-3.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/generic-ore-particle-4.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-4.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      }
    },
    shadows =
    {
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-1.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-1.png",
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-2.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-2.png",
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-3.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-3.png",
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-4.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-4.png",
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      }
    }
  }
})
end

function leighzermods.utils.createOreAutoplaceFromGeneric(materialName, tintName, mainMenuOrder)
  local baseName = materialName or tintName

  local autoplaceName = baseName .. "-ore"
  local localised_name = leighzermods.utils.toNiceName(autoplaceName)
  
  data:extend({
      {
          type = "autoplace-control",
          name = autoplaceName,
          richness = true,
          order = mainMenuOrder,
          category="resource",
          localised_name = localised_name
      }
  })
end

function leighzermods.utils.createOreNoiseLayerFromGeneric(materialName, tintName)
  local baseName = materialName or tintName

  local noiseLayerName = baseName .. "-ore"

  data:extend({
    {
        type = "noise-layer",
        name = noiseLayerName
        }
  }) 
end

function leighzermods.utils.createOreFromGeneric(materialName, tintName, miningTime, autoplaceSettings, resourcesMenuOrder)
    local baseName = materialName or tintName
  
    local ore = {} -- adding entity for ore in the ground
    ore.type = "resource"
    ore.name = baseName .. "-ore"
    ore.tint = leighzermods.tints[tintName]
    ore.icons = {{icon="__leighzerlib__/graphics/icons/generic/generic-ore.png",tint=ore.tint,icon_size=64}}    
    --ore.icon_size = 64
    ore.order = resourcesMenuOrder
    ore.map_color = ore.tint
    ore.minable = {
        mining_particle = ore.name .. "-particle",
        mining_time = miningTime,
        result = ore.name
    }
    ore.collision_box = {{ -0.1, -0.1}, {0.1, 0.1}}
    ore.selection_box = {{ -0.5, -0.5}, {0.5, 0.5}}
    ore.autoplace = resource_autoplace.resource_autoplace_settings{
        name = ore.name,
        order = autoplaceSettings.order,
        base_density = autoplaceSettings.base_density,
        has_starting_area_placement = autoplaceSettings.has_starting_area_placement,    
        regular_rq_factor_multiplier = autoplaceSettings.regular_rq_factor_multiplier,
        starting_rq_factor_multiplier = autoplaceSettings.starting_rq_factor_multiplier
    }
    ore.stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80}
    ore.stages = {
        sheet =
        {
          filename = "__leighzerlib__/graphics/entity/generic-ore/generic-ore.png",
          tint = ore.tint,
          priority = "extra-high",      
          size = 64,
          frame_count = 8,
          variation_count = 8,
          hr_version =
          {
            filename = "__leighzerlib__/graphics/entity/generic-ore/hr-generic-ore.png",
            tint = ore.tint,
            priority = "extra-high",
            size = 128,
            frame_count = 8,
            variation_count = 8,
            scale = 0.5
          }
        }
       }
    ore.localised_name = leighzermods.utils.toNiceName(ore.name)    

    data:extend({
        ore
    })    
end