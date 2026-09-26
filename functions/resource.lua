function leighzermods.utils.deleteResourceAutoplace(resourceName)
    if data.raw.resource[resourceName] then
        if data.raw.resource[resourceName].autoplace then
            data.raw.resource[resourceName].autoplace = nil
        end
    end
end