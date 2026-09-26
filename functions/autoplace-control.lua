function leighzermods.utils.createAutoplaceControl(autoplaceControlName, richness, mainMenuOrder, category, localised_name)
    data:extend({
        {
            type = "autoplace-control",
            name = autoplaceControlName,
            richness = richness,
            order = mainMenuOrder,
            category=category,
            localised_name = localised_name
        }
    })
end

function leighzermods.utils.deleteAutoplaceControl(autoplaceControlName)
    if data.raw["autoplace-control"][autoplaceControlName] then
        data.raw["autoplace-control"][autoplaceControlName] = nil
    end
end