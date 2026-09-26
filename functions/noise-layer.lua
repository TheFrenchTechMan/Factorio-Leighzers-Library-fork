function leighzermods.utils.createNoiseLayer(noiseLayerName)
    data:extend({
        {
            type = "noise-layer",
            name = noiseLayerName,
        }
    }) 
end

function leighzermods.utils.deleteNoiseLayer(noiseLayerName)
    if data.raw["noise-layer"][noiseLayerName] then
        data.raw["noise-layer"][noiseLayerName] = nil
    end
end