-- the whole point of this file is to get a recipe's ROUGH total raw count

-- see getRawIngredientsTable for more notes and details

-- returns array of recipe results with FULL definitions (converts result to results table..) {
-- 	{name="result1",amount=1,type="item"},
--  ...
-- }
-- note this isn't actually the results table, if recipe is probabilistic we do the math to calculate what will come out on average
local function getResultsTable(recipe, useExpensive)
	local resultsTable = {}
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
	if (rec.results) then		
		for i,result in ipairs(rec.results) do
			local resultName = result.name or result[1]
			local resultAmount = 0
			if result.probability then
				if result.amount then
					resultAmount = result.amount * result.probability
				elseif result.amount_min and result.amount_max then
					resultAmount = ((result.amount_min + result.amount_max)/2) * result.probability
				end
			else
				if (result.amount) then
					resultAmount = result.amount
				elseif (result.amount_min and result.amount_max) then
					resultAmount = ((result.amount_min + result.amount_max)/2)
				else
					resultAmount = result[2]
				end
			end			
			local resultType = result.type or "item"
			table.insert(resultsTable, {name=resultName,amount=resultAmount,type=resultType})
		end
	elseif (rec.result) then
		local amount = rec.result_count or 1
		table.insert(resultsTable,{name=rec.result,amount=amount,type="item"})		
	end	
	return resultsTable
end

-- returns array of recipe ingredients with FULL definitions {
-- 	{name="ing1",amount=1,type="item"}
--  ...
-- }
local function getIngredientsTable(recipe, useExpensive)
	if (not recipe.normal) and (not recipe.expensive) then
		if recipe.ingredients then
			local ingTable = {}
			for i,ing in ipairs(recipe.ingredients) do 
				local ingName = ing.name or ing[1]
				local ingAmount = ing.amount or ing[2]
				local ingType = ing.type or "item"
				table.insert(ingTable, {name=ingName,amount=ingAmount,type=ingType})
			end
			return ingTable
		else
			return nil
		end
	else	
		if useExpensive and recipe.expensive then			
			return getIngredientsTable(recipe.expensive, useExpensive)
		elseif recipe.normal then			
			return getIngredientsTable(recipe.normal, useExpensive)
		end
	end
end

local function getRecipes(itemName, useExpensive)
	local recipes = {}
	for k,recipe in pairs(data.raw.recipe) do
		local resultsTable = getResultsTable(recipe, useExpensive)		
		for i,result in ipairs(resultsTable) do
			local resultName = result.name or result[1]
			if (resultName == itemName) then
				table.insert(recipes, recipe)
			end
		end
	end
	return recipes
end

local function IsResource(possibleResourceName)
	if data.raw.resource[possibleResourceName] or (possibleResourceName == "water")  then
		return true
	else
		return false
	end
end

-- inspiration taken from https://forums.factorio.com/viewtopic.php?t=4397

-- this is a recursive total raw calculator
-- it is very approximate - for ingredients that have multiple recipes, the first recipe in array is chosen (essentially a random one) (this could be improved with doing some comparison between all possible recipes)
-- stupidFuckingRecipes is where we store recipe names and be able to tell if we are in a cycle or not (kind of, don't think it works sometimes?)
-- barreling recipes were messing this up too, but IsResource check seems to have fixed that

-- this will never be perfectly accurate, recipes with loops and stuff mess this up a bit
-- things got more complicated when I added a cache lookup
-- but as long as we get some sort of numbers out fuck it

-- the basic logic is
-- take a recipe
-- get its ingredients
-- for each ingredient
-- if the ingredient has a recipe, is not a resource, and the recipe is non-looping or the ingredient terminates (returns raw mats)
-- get the ingredients total raw (try to check in cache, if not in cache calc it then cache it)
-- do some math to sum total raw (factor in ratios 2 in 3 out etc.)
-- add the total raw to the master table
-- else the ingredient has no recipe, is a raw resource, or has a looping recipe
-- count the ingredient as a raw ingredient
-- add the ingredient to the total raw master table
-- mark the ingredient as a terminating ingredient
-- end for
-- return the master table

function leighzermods.utils.getRawIngredientsTable(recipe, useExpensive, cache, stupidFuckingRecipes)
	local rawIngredientsTable = {}		
	local ingredientsTable = getIngredientsTable(recipe, useExpensive)	
	for i, ing in ipairs(ingredientsTable) do
		local ingRecipes = nil
		if (cache.recipes[ing.name]) then
			ingRecipes = util.table.deepcopy(cache.recipes[ing.name])
		else
			ingRecipes = getRecipes(ing.name, useExpensive)
			cache.recipes[ing.name] = util.table.deepcopy(ingRecipes)
		end		
		if ingRecipes and #ingRecipes > 0 and (not IsResource(ing.name)) and (not stupidFuckingRecipes[ingRecipes[1].name] or cache.terminatingIngredients[ingRecipes[1].name]) then
			-- get the ingredient's rawIngs and count them
			stupidFuckingRecipes[ingRecipes[1].name] = true
			local ingRecipe = ingRecipes[1] -- use the first recipe by default, we just want rough raw ing counts for now
			local ingRecipeResultsTable = getResultsTable(ingRecipe, useExpensive)
			local multiple = 1
			for j,result in ipairs(ingRecipeResultsTable) do
				if (result.name == ing.name) then
					multiple = result.amount
					break
				end
			end
			local rawIngs = nil
			if (cache.rawIngredientsTableLookup[ingRecipe.name]) then
				rawIngs = util.table.deepcopy(cache.rawIngredientsTableLookup[ingRecipe.name])
			else
				rawIngs = leighzermods.utils.getRawIngredientsTable(ingRecipe, useExpensive, cache, util.table.deepcopy(stupidFuckingRecipes))
				cache.rawIngredientsTableLookup[ingRecipe.name] = util.table.deepcopy(rawIngs)
			end
			for j, rawIng in ipairs(rawIngs) do
				local preexistingRawIng = nil
				for k, rawIngTableElem in ipairs(rawIngredientsTable) do -- find the raw ingredient if it already exists
					if (rawIngTableElem.name == rawIng.name) then
						preexistingRawIng = rawIngTableElem
						break
					end
				end
				if preexistingRawIng then						
					preexistingRawIng.amount = (preexistingRawIng.amount) + (rawIng.amount * ing.amount / multiple) -- add to total
				else
					preexistingRawIng = {name=rawIng.name,amount=(rawIng.amount * ing.amount / multiple),type=rawIng.type} 
					table.insert(rawIngredientsTable,preexistingRawIng) -- add new entry
				end
			end
		else
			-- else no recipe, raw resource or we are in a cycle having already seen the recipe,
			-- add the ingredient as raw
			local preexistingRawIng = nil
			for i,rawIngTableElem in ipairs(rawIngredientsTable) do -- find the raw ingredient if it already exists
				if (rawIngTableElem.name == ing.name) then
					preexistingRawIng = rawIngTableElem
					break
				end
			end
			if preexistingRawIng then
				preexistingRawIng.amount = preexistingRawIng.amount + ing.amount -- add to total
			else
				preexistingRawIng = {name=ing.name,amount=ing.amount,type=ing.type}
				table.insert(rawIngredientsTable,preexistingRawIng) -- add new entry
			end
		end		
		cache.terminatingIngredients[ing.name] = true
	end
	return rawIngredientsTable
end

function leighzermods.utils.getTotalRawCacheTemplate()
	return {
		terminatingIngredients = {},
		rawIngredientsTableLookup = {},
		recipes = {}
	}
end

-- calcs total raw of a recipe, normalizes fluid amount, and adds up all the values
function leighzermods.utils.getTotalRawSum(recipe, useExpensive)
	local rawIngredientsTable = leighzermods.utils.getRawIngredientsTable(recipe, useExpensive, leighzermods.utils.getTotalRawCacheTemplate(), {})

	local totalRawSum = 0

	for i, rawIng in pairs(rawIngredientsTable) do
		local amountToAdd = rawIng.amount
		if (rawIng.type == "fluid") then -- 10 fluid approx. = 1 item so divide by 10
			amountToAdd = amountToAdd / 10
		end
		totalRawSum = totalRawSum + amountToAdd
	end

	return totalRawSum
end