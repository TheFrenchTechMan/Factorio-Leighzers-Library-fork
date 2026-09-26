if not leighzermods then --generic mod variable to store information that may be needed later
    leighzermods = {}        
end

if not leighzermods.leighzerfactoricons then
    leighzermods.leighzerfactoricons = {}
end

if not leighzermods.productivityEnabledRecipes then --list of recipe names that are going to get productivity modules enabled in data-final-fixes.lua
    leighzermods.productivityEnabledRecipes = {}
end

--populate leighzermods.constants
leighzermods.constants = {}
require("constants")

--populate leighzermods.utils
leighzermods.utils = {}
require("functions.autoplace-control")
require("functions.factoricon")
require("functions.fluid")
require("functions.generic")
require("functions.item-group-subgroup")
require("functions.item")
require("functions.map-gen-preset")
require("functions.misc")
require("functions.noise-layer")
require("functions.oceanicprocessing")
require("functions.recipe")
require("functions.resource")
require("functions.technology")
require("functions.total-raw")

--populate leighzermods.tints, leighzermods.factorioCheetSheetTints
require("tints")

-- require("testgenerics")
-- require("testrainbowore")