function leighzermods.utils.deleteAutoplaceControlFromDefaultMapGenPresets(autoplaceControlName)
    for k,v in pairs(data.raw["map-gen-presets"]["default"]) do
        if v.basic_settings and v.basic_settings.autoplace_controls then
            if v.basic_settings.autoplace_controls[autoplaceControlName] then
                v.basic_settings.autoplace_controls[autoplaceControlName] = nil
            end            
        end
    end
end