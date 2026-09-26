--simple recipe create function with one result
function leighzermods.utils.createRecipe(recipeName,energyRequired,enabled,category,ingredients,result,resultCount,subgroup,order,isProductivityEnabled)
    
    local recipe = {
                        type = "recipe",
                        name = recipeName,
                        energy_required = energyRequired,
                        enabled = enabled,
                        category = category,
                        ingredients = ingredients,
                        result = result,
                        result_count = resultCount,
                        subgroup = subgroup,
                        order = order,
                    }
    data:extend({
        recipe
    })

    if isProductivityEnabled then
        table.insert(leighzermods.productivityEnabledRecipes,recipe.name)
    end
end

-- for most cases leave mainProduct alone
function leighzermods.utils.createRecipeComplex(recipeName,energyRequired,enabled,category,ingredients,icons,results,subgroup,order,mainProduct,isProductivityEnabled, localised_name)
    
    local recipe = {
                        type = "recipe",
                        name = recipeName,
                        energy_required = energyRequired,
                        enabled = enabled,
                        category = category,
                        ingredients = ingredients,
                        icons = icons,
                        results = results,            
                        subgroup = subgroup,
                        order = order,
                        main_product = mainProduct,
                        localised_name = localised_name
                    }

    data:extend({
        recipe
    })

    if isProductivityEnabled then
        table.insert(leighzermods.productivityEnabledRecipes,recipe.name)
    end
end

function leighzermods.utils.disableRecipe(recipeName)
    local recipe = data.raw.recipe[recipeName]
    recipe.enabled = false
end

function leighzermods.utils.enableRecipe(recipeName)
    local recipe = data.raw.recipe[recipeName]
    recipe.enabled = true
end

function leighzermods.utils.hideRecipe(recipeName)
    local recipe = data.raw.recipe[recipeName]
    recipe.hidden = true
end

function leighzermods.utils.showRecipe(recipeName)
    local recipe = data.raw.recipe[recipeName]
    recipe.hidden = false
end

function leighzermods.utils.addIngredientToRecipe(recipeName,ingredient)
    local recipe = data.raw.recipe[recipeName]
    -- check if ingredient is already a part of the recipe
    for _,ing in pairs(recipe.ingredients) do
        if (ing.name and ing.name == ingredient.name) or (ing[1] == ingredient.name) then 
            return -- if so, do not add it
        end
    end
    table.insert(recipe.ingredients,ingredient)
end

function leighzermods.utils.removeIngredientFromRecipe(recipeName,ingredientName)
    local recipe = data.raw.recipe[recipeName]
    for _,ingredient in pairs(recipe.ingredients) do
        if (ingredient.name and ingredient.name == ingredientName) or (ingredient[1] == ingredientName) then 
            table.remove(recipe.ingredients,_)
        end
    end
end

-- replaces one ingredient with another
function leighzermods.utils.replaceIngredientFromRecipe(recipeName,oldIngredientTable,newIngredientTable)    
    local recipe = data.raw.recipe[recipeName]

    local oldIngredientName = oldIngredientTable.name
    local oldIngredientType = oldIngredientTable.type

    local newIngredientName = newIngredientTable.name
    local newIngredientType = newIngredientTable.type
    
    local newIng = nil
    if recipe.ingredients then        
        for k,v in pairs(recipe.ingredients) do
            local typ = v.type or "item"
            local nam = v.name or v[1]
            if typ == newIngredientType and nam == newIngredientName then
                newIng = v
            end
        end

        if not newIng then            
            for k,v in pairs(recipe.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    if v.name then
                        v.name = newIngredientName
                    else
                        v[1] = newIngredientName
                    end
                end
            end
        else
            for k,v in pairs(recipe.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    local amountToAdd = v.amount or v[2]
                    if newIng.amount then
                        newIng.amount = newIng.amount + amountToAdd
                    else
                        newIng[2] = newIng[2] + amountToAdd
                    end
                    table.remove(recipe.ingredients,k)            
                end
            end
        end
    end
    newIng = nil

    if recipe.normal and recipe.normal.ingredients then
        for k,v in pairs(recipe.normal.ingredients) do
            local typ = v.type or "item"
            local nam = v.name or v[1]
            if typ == newIngredientType and nam == newIngredientName then
                newIng = v
            end
        end

        if not newIng then            
            for k,v in pairs(recipe.normal.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    if v.name then
                        v.name = newIngredientName
                    else
                        v[1] = newIngredientName
                    end
                end
            end
        else
            for k,v in pairs(recipe.normal.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    local amountToAdd = v.amount or v[2]
                    if newIng.amount then
                        newIng.amount = newIng.amount + amountToAdd
                    else
                        newIng[2] = newIng[2] + amountToAdd
                    end
                    table.remove(recipe.normal.ingredients,k)            
                end
            end
        end
    end
    newIng = nil

    if recipe.expensive and recipe.expensive.ingredients then
        for k,v in pairs(recipe.expensive.ingredients) do
            local typ = v.type or "item"
            local nam = v.name or v[1]
            if typ == newIngredientType and nam == newIngredientName then
                newIng = v
            end
        end

        if not newIng then            
            for k,v in pairs(recipe.expensive.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    if v.name then
                        v.name = newIngredientName
                    else
                        v[1] = newIngredientName
                    end
                end
            end
        else
            for k,v in pairs(recipe.expensive.ingredients) do
                local typ = v.type or "item"
                local nam = v.name or v[1]
                if typ == oldIngredientType and nam == oldIngredientName then
                    local amountToAdd = v.amount or v[2]
                    if newIng.amount then
                        newIng.amount = newIng.amount + amountToAdd
                    else
                        newIng[2] = newIng[2] + amountToAdd
                    end
                    table.remove(recipe.expensive.ingredients,k)            
                end
            end
        end
    end
    
end

function leighzermods.utils.setRecipeCraftingCategory(recipeName,craftingCategoryName)
    local recipe = data.raw.recipe[recipeName]
    recipe.category = craftingCategoryName
end

function leighzermods.utils.setRecipeSubgroup(recipeName,subgroup)
    local recipe = data.raw.recipe[recipeName]
    recip.subgroup = subgroup
end

function leighzermods.utils.setRecipeOrder(recipeName,order)
    local recipe = data.raw.recipe[recipeName]
    recip.order = order
end

--function name says it all lol
function leighzermods.utils.setRecipeToCraftingWithFluidCategoryIfHasFluidIngredient(recipeName)
    local recipe = data.raw.recipe[recipeName]
    for _,ingredient in pairs(recipe.ingredients) do
        if (ingredient.type and ingredient.type == "fluid") then 
            recipe.category = "crafting-with-fluid"
        end
        break
    end
end

-- returns a table not array
function leighzermods.utils.getRecipesThatContainProduct(productName, useExpensive)

    local recipeDict = {}

    for k,recipe in pairs(data.raw.recipe) do
        local rec = {}

        if (not recipe.normal) and (not recipe.expensive) then
            rec = recipe
        else
            if useExpensive and recipe.expensive then
                rec = recipe.expensive
            elseif recipe.normal then
                rec = recipe.normal
            end
        end

        if rec.results then
            for i,res in ipairs(rec.results) do
                local resultName = res.name or res[1]
                if(resultName == productName) then
                    recipeDict[k] = recipe
                    break
                end
            end
        elseif rec.result and rec.result == productName then
            recipeDict[k] = recipe
        end

    end

    return recipeDict
end

-- returns a table not array
function leighzermods.utils.getRecipesThatOnlyContainProduct(productName, useExpensive)

    local recipeDict = {}

    for k,recipe in pairs(data.raw.recipe) do
        local rec = {}

        if (not recipe.normal) and (not recipe.expensive) then
            rec = recipe
        else
            if useExpensive and recipe.expensive then
                rec = recipe.expensive
            elseif recipe.normal then
                rec = recipe.normal
            end
        end

        if rec.results and (#rec.results == 1) then
            for i,res in ipairs(rec.results) do
                local resultName = res.name or res[1]
                if(resultName == productName) then
                    recipeDict[k] = recipe
                    break
                end
            end
        elseif rec.result and rec.result == productName then
            recipeDict[k] = recipe
        end
        
    end

    return recipeDict
end