--[[
Spanish
]]
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","esES")
if not L then return end
-- Spell names

L["Mining"] = "Miner\195\173a"
L["Fishing"] = "Pesca"
L["Herb Gathering"] = "Recolectar hierbas"
L["Extract Gas"] = "Extraer gas"
L["Herbalism"] = "Bot\195\161nica"
L["Engineering"] = "Engineering"
L["Opening"] = "Apertura"
L["Pick Lock"] = "Forzar cerradura"

-- Display module
L["GatherMate Pin Options"] = true
L["Delete: "] = true

--L["Always show"] = true
--L["Only with profession"] = true
--L["Only while tracking"] = true
--L["Never show"] = true

-- Config modules
L["GatherMate"]=true
L["gathermate"]=true -- slash command
---- Display Filters tree
L["Display Settings"] = true
------ General subtree
L["General"] = true
L["Show Databases"] = true
L["Selected databases are shown on both the World Map and Minimap."] = true
L["Show Mining Nodes"]=true
L["Toggle showing mining nodes."]=true
L["Show Herbalism Nodes"]=true
L["Toggle showing herbalism nodes."]=true
L["Show Fishing Nodes"]=true
L["Toggle showing fishing nodes."]=true
L["Show Gas Clouds"]=true
L["Toggle showing gas clouds."]=true
L["Icons"] = true
L["Control various aspects of node icons on both the World Map and Minimap."] = true
L["Show Minimap Icons"]=true
L["Toggle showing Minimap icons."] = true
L["Show World Map Icons"] = true
L["Toggle showing World Map icons."] = true
L["Icon Scale"] = true
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = true
L["Icon Alpha"] = true
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = true
L["Miscellaneous"] = true
L["Cleanup_Desc"] = "Over time, your database might become crowded. Cleaning up your database involves looking for nodes of the same profession type that are near each other and determining if they can be collapsed into a single node."
L["Cleanup Database"] = true
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = true
L["Processing "] = true
L["Cleanup Complete."] = true
L["Tracking Circle Color"] = true
L["Color of the tracking circle."] = true
L["Show Nodes on Minimap Border"] = true
L["Shows more Nodes that are currently out of range on the minimap's border."] = true
------ Filters subtree
L["Filters"] = true
L["Herb filter"] = true
L["Select the herb nodes you wish to display."]=true
L["Mine filter"] = true
L["Select the mining nodes you wish to display."] = true
L["Fish filter"] = true
L["Select the fish nodes you wish to display."] = true
L["Gas filter"] = true
L["Select the gas clouds you wish to display."] = true
L["Select All"] = true
L["Select all nodes"] = true
L["Clear node selections"] = true
L["Select None"] = true
L["Gas Clouds"]= true
L["Fishes"] = true
L["Mineral Veins"] = true
L["Herb Bushes"] = true
L["Filter_Desc"] = "Select node types that you want displayed in the World and Minimap. Unselected node types will still be recorded in the database."
---- Import tree
L["Import Data"] = true
L["Import GatherMateData"] = true
L["Importing_Desc"] = "Importing allows GatherMate to get node data from other sources apart from what you find yourself in the game world. After importing data, you may need to perform a database cleanup."
L["Load GatherMateData and import the data to your database."] = true
L["GatherMateData has been imported."] = true
L["Failed to load GatherMateData due to "] = true
L["Merge"] = true
L["Overwrite"] = true
L["Import Style"] = true
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = true
L["Databases to Import"] = true
L["Databases you wish to import"] = true
L["Auto Import"] = true
L["Automatically import when ever you update your data module, your current import choice will be used."] = true
L["Auto import complete for addon "] = true

local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","esES")
if not NL then return end
-- fish schools
NL["Floating Wreckage"] = "Restos de un naufragio"
NL["Patch of Elemental Water"] = "Patch of Elemental Water"   -- fix
NL["Floating Debris"] = "Restos flotando"   
NL["Oil Spill"] = "Vertido de petr\195\179leo" 
NL["Firefin Snapper School"] = "Banco de pargos de fuego"
NL["Greater Sagefish School"] = "Banco de sabiolas superiores"
NL["Oily Blackmouth School"] = "banco de bocanegra graso"
NL["Sagefish School"] = "Banco de sabiolas"
NL["School of Deviate Fish"] = "Banco de peces descarriados"
NL["Stonescale Eel Swarm"] = "Banco de anguilas Escama Tormentosa"
--NL["Muddy Churning Water"] = "Muddy Churning Water"  -- fix
NL["Highland Mixed School"] = "Banco mezclado de las Tierras Altas"  -- check  
NL["Pure Water"] = "Agua pura"
NL["Bluefish School"] = "Banco de pezazules"  
NL["Feltail School"] = "Banco de colaviles"
NL["Mudfish School"] = "Banco de peces barro"  
NL["School of Darter"] = "Banco de dardos" -- check
NL["Sporefish School"] = "Sporefish School"  -- fix
NL["Steam Pump Flotsam"] = "Restos flotantes de bomba de vapor"
NL["School of Tastyfish"] = "Banco de pezricos"

-- mine nodes
NL["Copper Vein"] = "Fil\195\179n de cobre"
NL["Tin Vein"] = "Fil\195\179n de esta\195\177o"
NL["Iron Deposit"] = "Dep\195\179sito de hierro"
NL["Silver Vein"] = "Fil\195\179n de plata"
NL["Gold Vein"] = "Fil\195\179n de oro"
NL["Mithril Deposit"] = "Dep\195\179sito de mitril"
NL["Ooze Covered Mithril Deposit"] = "Fil\195\179n de mitril cubierto de moco"  -- check
NL["Truesilver Deposit"] = "Dep\195\179sito de veraplata"
NL["Ooze Covered Silver Vein"] = "Fil\195\179n de plata cubierto de moco"  -- check
NL["Ooze Covered Gold Vein"] = "Fil\195\179n de oro cubierto de moco"  -- check
NL["Ooze Covered Truesilver Deposit"] = "Fil\195\179n de veraplata cubierta de moco"  -- check
NL["Ooze Covered Rich Thorium Vein"] = "Fil\195\179n de torio enriquecido cubierto de moco"  -- check
NL["Ooze Covered Thorium Vein"] = "Fil\195\179n de torio cubierto de moco"  -- check
NL["Small Thorium Vein"] = "Fil\195\179n peque\195\177o de torio" -- check
NL["Rich Thorium Vein"] = "Fil\195\179n de torio enriquecido"
--NL["Hakkari Thorium Vein"] = "Fil\195\179n de torio hakkari"  -- check
NL["Dark Iron Deposit"] = "Dep\195\179sito de hierro negro"
NL["Lesser Bloodstone Deposit"] = "Dep\195\179sito desangrita inferior"
NL["Incendicite Mineral Vein"] = "Fil\195\179n de mineral de incendicita" --check
NL["Indurium Mineral Vein"] = "Fil\195\179n de mineral de indurio"   -- check
NL["Fel Iron Deposit"] = "Dep\195\179sito de hierro vil"
NL["Adamantite Deposit"] = "Dep\195\179sito de adamantita"
NL["Rich Adamantite Deposit"] = "Dep\195\179sito de adamantita enriquecida"
NL["Khorium Vein"] = "Fil\195\179n de korio"
--NL["Large Obsidian Chunk"] = "Pedazo obsidiano grande"  -- check
--NL["Small Obsidian Chunk"] = "Pedazo obsidiano peque\195\177o"  -- check
NL["Nethercite Deposit"] = "Depósito de abisalita"

-- gas clouds
NL["Windy Cloud"] = "Nube Ventosa" -- check me
NL["Swamp Gas"] = "Gas de pantano" -- fix
NL["Arcane Vortex"] = "Vórtice arcano" -- fix
NL["Felmist"] = "Niebla vil" -- fix

-- herb bushes
NL["Peacebloom"] = "Flor de paz"
NL["Silverleaf"] = "Hojaplata"
NL["Earthroot"] = "Raíz de tierra"
NL["Mageroyal"] = "Marregal"
NL["Briarthorn"] = "Brezospina"
--NL["Swiftthistle"] = "Cardoveloz"
NL["Stranglekelp"] = "Alga estranguladora"
NL["Bruiseweed"] = "Hierba cardenal"
NL["Wild Steelbloom"] = "Acérita salvaje"
NL["Grave Moss"] = "Musgo de tumba"
NL["Kingsblood"] = "Sangrerregia"
NL["Liferoot"] = "Vidarraíz"
NL["Fadeleaf"] = "Pálida"
NL["Goldthorn"] = "Espina de oro"
NL["Khadgar's Whisker"] = "Mostacho de Khadgar"
NL["Wintersbite"] = "Ivernalia"
NL["Firebloom"] = "Flor de Fuego"
NL["Purple Lotus"] = "Loto cárdeno"
--NL["Wildvine"] = "Atriplex salvaje"
NL["Arthas' Tears"] = "Lágrimas de Arthas"
NL["Sungrass"] = "Solea"
NL["Blindweed"] = "Carolina"
NL["Ghost Mushroom"] = "Champiñón fantasma"
NL["Gromsblood"] = "Gromsanguina"
NL["Golden Sansam"] = "Sansam dorado"
NL["Dreamfoil"] = "Hojasueño"
NL["Mountain Silversage"] = "Salviargenta de montaña"
NL["Plaguebloom"] = "Flor de peste"
NL["Icecap"] = "Setelo"
NL["Bloodvine"] = "Vid de sangre"
NL["Black Lotus"] = "Loto negro"
NL["Felweed"] = "Hierba vil"
NL["Dreaming Glory"] = "Gloria de ensueño"
NL["Terocone"] = "Teropiña"
--NL["Ancient Lichen"] = "Liquen antiguo"
NL["Bloodthistle"] = "Cardo de sangre"
NL["Mana Thistle"] = "Cardo de maná"  
NL["Netherbloom"] = "Flor abisal"  
NL["Nightmare Vine"] = "Vid Pesadilla" 
NL["Ragveil"] = "Velada"
NL["Flame Cap"] = "Seta flamígera"
NL["Netherdust Bush"] = "Arbusto de polvo abisal"
