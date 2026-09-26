function leighzermods.utils.createTechnology(techName,icons,enabled,effects,unit,prereqs,order, localised_name, localised_description)
    data:extend({
        {
            type = "technology",
            name = techName,
            icons = icons,
            enabled = enabled,
            effects = effects,
            unit = unit,
            prerequisites = prereqs,
            order = order,
            localised_name = localised_name,
            localised_description = localised_description,
        }
    })
end

function leighzermods.utils.disableTechnology(techName)
    local tech = data.raw.technology[techName]
    tech.enabled = false
    tech.hidden = true
end

function leighzermods.utils.disableAllTechnologies()
    for _,tech in pairs(data.raw.technology) do
        leighzermods.utils.disableTechnology(tech.name)
    end
end

function leighzermods.utils.enableTechnology(techName)
    local tech = data.raw.technology[techName]
    tech.enabled = true
    tech.hidden = false
end

function leighzermods.utils.enableAllTechnologies()
    for _,tech in pairs(data.raw.technology) do
        leighzermods.utils.enableTechnology(tech.name)
    end
end

function leighzermods.utils.addPrerequisite(techName,prereq)    
    table.insert(data.raw.technology[techName].prerequisites,prereq)
end

function leighzermods.utils.removePrerequisite(techName,prereq)
    local tech = data.raw.technology[techName]
    for _,v in pairs(tech.prerequisites) do
        if v == prereq then 
            table.remove(tech.prerequisites,_)
        end
    end
end

function leighzermods.utils.removeAllPrerequisites(techName)
    local tech = data.raw.technology[techName]
    tech.prerequisites = {}
end

function leighzermods.utils.setPrerequisites(techName,prereqs)
    local tech = data.raw.technology[techName]
    tech.prerequisites = prereqs
end

function leighzermods.utils.addEffect(techName,effect)
    table.insert(data.raw.technology[techName].effects,effect)
end

function leighzermods.utils.removeEffect(techName, effect)
    local tech = data.raw.technology[techName]
    for _,v in pairs(tech.effects) do
        if v == effect then 
            table.remove(tech.effects,v)
        end
    end
end

function leighzermods.utils.removeAllEffects(techName)
    local tech = data.raw.technology[techName]
    tech.effects = {}
end

function leighzermods.utils.addSciencePack(techName,sciencePack)
    local tech = data.raw.technology[techName]
    for _,ingredient in pairs(tech.unit.ingredients) do
        if ingredient[1] == sciencePack then
            return
        end
    end
    table.insert(tech.unit.ingredients, {sciencePack, 1} )
end

function leighzermods.utils.removeSciencePack(techName,sciencePack)
    local tech = data.raw.technology[techName]
    for _,ingredient in pairs(tech.unit.ingredients) do
        if ingredient[1] == sciencePack then 
            table.remove(tech.unit.ingredients,_)
        end
    end
end

function leighzermods.utils.removeAllSciencePacks(techName)
    local tech = data.raw.technology[techName]
    for _,ingredient in pairs(tech.unit.ingredients) do
        table.remove(tech.unit.ingredients,_)
    end
end

--get a clean start with the tech tree
function leighzermods.utils.wipeAllTechnologies()
    for _,tech in pairs(data.raw.technology) do
        leighzermods.utils.removeAllPrerequisites(tech.name)
        leighzermods.utils.removeAllEffects(tech.name)
        leighzermods.utils.removeAllSciencePacks(tech.name)
        leighzermods.utils.disableTechnology(tech.name)
    end
end