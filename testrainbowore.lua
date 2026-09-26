leighzermods.utils.createAutoplaceControl("rainbow-ore", true, "a", "resource", "Rainbow ore")
leighzermods.utils.createNoiseLayer("rainbow-ore")
local itemPictures = {
    { size = 64, filename = "__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore.png",   scale = 0.25, mipmap_count = 4 },
    { size = 64, filename = "__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore-1.png", scale = 0.25, mipmap_count = 4 },
    { size = 64, filename = "__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore-2.png", scale = 0.25, mipmap_count = 4 },
    { size = 64, filename = "__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore-3.png", scale = 0.25, mipmap_count = 4 },
  }
leighzermods.utils.createItem("rainbow-ore","__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore.png",64,"raw-resource","a",50,itemPictures, "Rainbow ore")

data:extend({    
    --ore
    {
        type="resource",
        name="rainbow-ore",
        icons={{icon="__leighzerlib__/graphics/icons/rainbow-ore/rainbow-ore.png",icon_size=64}},
        order="a",
        map_color = leighzermods.tints.light_blue,
        minable = {
            mining_particle = "rainbow-ore-particle",
            mining_time = 1,
            result = "rainbow-ore"
        },
        collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
        selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
        autoplace = resource_autoplace.resource_autoplace_settings{
            name = "rainbow-ore",
            order = "h",
            base_density = 10,
            has_starting_area_placement = true,
            regular_rq_factor_multiplier = 1.1,
            starting_rq_factor_multiplier = 1.5,
        },
        stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
        stages = {
            sheet =
            {
              filename = "__leighzerlib__/graphics/entity/rainbow-ore/rainbow-ore.png",              
              priority = "extra-high",      
              size = 64,
              frame_count = 8,
              variation_count = 8,
              hr_version =
              {
                filename = "__leighzerlib__/graphics/entity/rainbow-ore/hr-rainbow-ore.png",                
                priority = "extra-high",
                size = 128,
                frame_count = 8,
                variation_count = 8,
                scale = 0.5
              }
            }
           },
        localised_name = "Rainbow ore"
    },
    --particle
    {
    type = "optimized-particle",
    name = "rainbow-ore-particle",    
    life_time = 180,
    pictures =
    {
      {
        filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/rainbow-ore-particle-1.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-1.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/rainbow-ore-particle-2.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-2.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/rainbow-ore-particle-3.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-3.png",
            tint=tint,
            priority = "extra-high",
            width = 32,
            height = 32,
            frame_count = 1,
            scale = 0.5
        }
      },
      {
        filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/rainbow-ore-particle-4.png",
        tint=tint,
        priority = "extra-high",
        width = 16,
        height = 16,
        frame_count = 1,
        hr_version =
        {
            filename = "__leighzerlib__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-4.png",
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
  },    
})