--[[
Default Locale is English, those providing translations, just add it to the appropiate lua file
]]
local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate","enUS",true)
-- Spell names for Collector module
L["Mining"] = true
L["Fishing"] = true
L["Herb Gathering"] = true
L["Extract Gas"] = true
L["Herbalism"] = true
L["Engineering"] = true
L["Opening"] = true
L["Pick Lock"] = true
-- Display module
L["GatherMate Pin Options"] = true
L["Delete: "] = true
L["Add this location to Cartographer_Waypoints"] = true
L["Add this location to TomTom waypoints"] = true

L["Always show"] = true
L["Only with profession"] = true
L["Only while tracking"] = true
L["Never show"] = true


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
L["Show Treasure Nodes"]=true
L["Toggle showing treasure nodes."]=true
L["Icons"] = true
L["Control various aspects of node icons on both the World Map and Minimap."] = true
L["Show Minimap Icons"]=true
L["Toggle showing Minimap icons."] = true
L["Show World Map Icons"] = true
L["Toggle showing World Map icons."] = true
L["Keybind to toggle Minimap Icons"] = true
L["Icon Scale"] = true
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = true
L["Icon Alpha"] = true
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = true
L["Miscellaneous"] = true
-- Cleanup subtree (now Database Maintenance)
L["Database Maintenance"] = true
L["Cleanup_Desc"] = "Over time, your database might become crowded. Cleaning up your database involves looking for nodes of the same profession type that are near each other and determining if they can be collapsed into a single node."
L["Cleanup radius"] = true
L["CLEANUP_RADIUS_DESC"] = "The radius in yards where duplicate nodes should be removed. The default is |cffffd20050|r yards for Extract Gas and |cffffd20015|r yards for everything else. These settings are also followed when adding nodes."
L["Cleanup Database"] = true
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = true
L["Processing "] = true
L["Cleanup Complete."] = true
L["Delete Specific Nodes"] = true
L["DELETE_SPECIFIC_DESC"] = "Remove all of the selected node from the selected zone. You must disable Database Locking for this to work."
L["Select Database"] = true
L["Select Node"] = true
L["Select Zone"] = true
L["Delete"] = true
L["Delete selected node from selected zone"] = true
L["Are you sure you want to delete all of the selected node from the selected zone?"] = true
L["Delete Entire Database"] = true
L["DELETE_ENTIRE_DESC"] = "This will ignore Database Locking and remove all nodes from all zones from the selected database."
L["Are you sure you want to delete all nodes from this database?"] = true
L["Database Locking"] = true
L["DATABASE_LOCKING_DESC"] = "The database locking feature allows you to freeze a database state. Once locked you will no longer be able to add, delete or modify the database. This includes cleanup and imports."
L["Database locking"] = true

-- Tracking options
L["Tracking Circle Color"] = true
L["Color of the tracking circle."] = true
L["Tracking Distance"] = true
L["The distance in yards to a node before it turns into a tracking circle"] = true
L["Show Tracking Circle"] = true
L["Toggle showing the tracking circle."] = true
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
L["Treasure filter"] = true
L["Select the treasure you wish to display."] = true
L["Select All"] = true
L["Select all nodes"] = true
L["Clear node selections"] = true
L["Select None"] = true
L["Gas Clouds"]= true
L["Fishes"] = true
L["Mineral Veins"] = true
L["Herb Bushes"] = true
L["Treasure"] = true
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
L["BC Data Only"] = true
L["Only import Burning Crusade data from WoWHead"] = true
--- profile settings
L["Default"] = true
L["Char:"] = true
L["Realm:"] = true
L["Class:"] = true
L["Profiles"] = true
L["Manage Profiles"] = true
L["You can change the active database profile of GatherMate, so you can have different settings and filters for every character, which will allow a very flexible configuration for everyones needs."] = true
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = true
L["You can create a new profile by entering a new name in the editbox, or choosing one of the already exisiting profiles."] = true
L["Reset Profile"] = true
L["Reset the current profile to the default"] = true
L["New"] = true
L["Create a new empty profile."] = true
L["Current"] = true
L["Select one of your currently available profiles."] = true
L["Copy the settings from one existing profile into the currently active profile."] = true
L["Copy From"] = true
L["Copy the settings from another profile into the active profile."] = true
L["Delete existing and unused profiles from the database to save space, and cleanup the GatherMate SavedVariables file."] = true
L["Delete a Profile"] = true
L["Deletes a profile from the database."] = true
L["Are you sure you want to delete the selected profile?"] = true
-- FAQ
L["FAQ"] = true
L["Frequently Asked Questions"] = true
L["FAQ_TEXT"] = [[
|cffffd200
I just installed GatherMate, but I see no nodes on my maps. What am I doing wrong?
|r
GatherMate does not come with any data by itself. When you gather herbs, mine ore, collect gas or fish, GatherMate will then add and update your map accordingly. Also, check your Display Settings.

|cffffd200
I am seeing nodes on my World Map but not on my Minimap! What am I doing wrong now?
|r
|cffffff78Minimap Button Bag|r (and possibly other similar addons) likes to eat all the buttons we put on the Minimap. Disable them.

|cffffd200
How or where can I get existing data?
|r
You can import existing data into GatherMate in these ways:

1. |cffffff78GatherMate_Data|r - This LoD addon contains a WowHead datamined copy of all the nodes and is updated weekly. There are auto-updating options

2. |cffffff78GatherMate_CartImport|r - This addon allows you to import your existing databases in |cffffff78Cartographer_<Profession>|r modules into GatherMate. For this to work, both your |cffffff78Cartographer_<Profession>|r modules and GatherMate_CartImport must be loaded and active.

Note that importing data into GatherMate is not an automatic process. You must actively go to the Import Data section and click on the "Import" button.

This differs from |cffffff78Cartographer_Data|r in that the user is given the choice in how and when you want your data to be modified, |cffffff78Cartographer_Data|r when loaded will simply overwrite your existing databases without warning and destroy all new nodes that you have found.

|cffffd200
Can you add support for showing the locations of things like mailboxes and flightmasters?
|r
The answer is no. However, another addon author could create an addon or module for this purpose, the core GatherMate addon will not do this.

|cffffd200
I've found a bug! Where do I report it?
|r
You can report bugs or give suggestions at |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

Alternatively, you can also find us on |cffffff78irc://irc.freenode.org/wowace|r

When reporting a bug, make sure you include the |cffffff78steps on how to reproduce the bug|r, supply any |cffffff78error messages|r with stack traces if possible, give the |cffffff78revision number|r of GatherMate the problem occured in and state whether you are using an |cffffff78English client or otherwise|r.

|cffffd200
Who wrote this cool addon?
|r
Kagaro, Xinhuan, Nevcairiel and Ammo
]]

--[[
We have a second translation list to handle just nodes, this needs to be in REVERSE translation order since AceLocale-3.0 no longer supports reverse translations
]]
local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes","enUS",true)
-- fish schools
NL["Floating Wreckage"] = true
NL["Patch of Elemental Water"] = true
NL["Floating Debris"] = true
NL["Oil Spill"] = true
NL["Firefin Snapper School"] = true
NL["Greater Sagefish School"] = true
NL["Oily Blackmouth School"] = true
NL["Sagefish School"] = true
NL["School of Deviate Fish"] = true
NL["Stonescale Eel Swarm"] = true
--NL["Muddy Churning Water"] = true ZG only
NL["Highland Mixed School"] = true  
NL["Pure Water"] = true            
NL["Bluefish School"] = true
NL["Feltail School"] = true 
NL["Brackish Mixed School"] = true
NL["Mudfish School"] = true
NL["School of Darter"] = true 
NL["Sporefish School"] = true 
NL["Steam Pump Flotsam"] = true 
NL["School of Tastyfish"] = true

NL["Borean Man O' War School"] = true
NL["Deep Sea Monsterbelly School"] = true
NL["Dragonfin Angelfish School"] = true
NL["Fangtooth Herring School"] = true
NL["Floating Wreckage Pool"] = true
NL["Glacial Salmon School"] = true
NL["Glassfin Minnow School"] = true
NL["Imperial Manta Ray School"] = true
NL["Moonglow Cuttlefish School"] = true
NL["Musselback Sculpin School"] = true
NL["Nettlefish School"] = true
NL["Strange Pool"] = true
NL["Schooner Wreckage"] = true
NL["Waterlogged Wreckage"] = true
NL["Bloodsail Wreckage"] = true
NL["Lesser Sagefish School"] = true
NL["Lesser Oily Blackmouth School"] = true
NL["Sparse Oily Blackmouth School"] = true
NL["Abundant Oily Blackmouth School"] = true
NL["Teeming Oily Blackmouth School"] = true
NL["Lesser Firefin Snapper School"] = true
NL["Sparse Firefin Snapper School"] = true
NL["Abundant Firefin Snapper School"] = true
NL["Teeming Firefin Snapper School"] = true
NL["Lesser Floating Debris"] = true
NL["Sparse Schooner Wreckage"] = true
NL["Abundant Bloodsail Wreckage"] = true
NL["Teeming Floating Wreckage"] = true


-- mine nodes
NL["Copper Vein"] = true
NL["Tin Vein"] = true
NL["Iron Deposit"] = true
NL["Silver Vein"] = true
NL["Gold Vein"] = true
NL["Mithril Deposit"] = true
NL["Ooze Covered Mithril Deposit"] = true
NL["Truesilver Deposit"] = true
NL["Ooze Covered Silver Vein"] = true
NL["Ooze Covered Gold Vein"] = true
NL["Ooze Covered Truesilver Deposit"] = true
NL["Ooze Covered Rich Thorium Vein"] = true
NL["Ooze Covered Thorium Vein"] = true
NL["Small Thorium Vein"] = true
NL["Rich Thorium Vein"] = true
--NL["Hakkari Thorium Vein"] = true ZG only
NL["Dark Iron Deposit"] = true
NL["Lesser Bloodstone Deposit"] = true
NL["Incendicite Mineral Vein"] = true
NL["Indurium Mineral Vein"] = true
NL["Fel Iron Deposit"] = true
NL["Adamantite Deposit"] = true
NL["Rich Adamantite Deposit"] = true
NL["Khorium Vein"] = true
--NL["Large Obsidian Chunk"] = true AQ 40
--NL["Small Obsidian Chunk"] = true AQ 20/40
NL["Nethercite Deposit"] = true
NL["Cobalt Node"] = true
NL["Rich Cobalt Node"] = true
NL["Titanium Node"] = true
NL["Saronite Node"] = true
NL["Rich Saronite Node"] = true


-- gas clouds
NL["Windy Cloud"] = true
NL["Swamp Gas"] = true
NL["Arcane Vortex"] = true
NL["Felmist"] = true
NL["Steam Cloud"] = true
NL["Cinder Cloud"] = true
NL["Arctic Cloud"] = true

-- herb bushes
NL["Peacebloom"] = true
NL["Silverleaf"] = true
NL["Earthroot"] = true
NL["Mageroyal"] = true
NL["Briarthorn"] = true
--NL["Swiftthistle"] = true found in other sources
NL["Stranglekelp"] = true
NL["Bruiseweed"] = true
NL["Wild Steelbloom"] = true
NL["Grave Moss"] = true
NL["Kingsblood"] = true
NL["Liferoot"] = true
NL["Fadeleaf"] = true
NL["Goldthorn"] = true
NL["Khadgar's Whisker"] = true
NL["Wintersbite"] = true
NL["Firebloom"] = true
NL["Purple Lotus"] = true
--NL["Wildvine"] = true found in purple lotus
NL["Arthas' Tears"] = true
NL["Sungrass"] = true
NL["Blindweed"] = true
NL["Ghost Mushroom"] = true
NL["Gromsblood"] = true
NL["Golden Sansam"] = true
NL["Dreamfoil"] = true
NL["Mountain Silversage"] = true
NL["Plaguebloom"] = true
NL["Icecap"] = true
--NL["Bloodvine"] = true ZG only not needed atm
NL["Black Lotus"] = true
NL["Felweed"] = true
NL["Dreaming Glory"] = true
NL["Terocone"] = true
--NL["Ancient Lichen"] = true instance only
NL["Bloodthistle"] = true
NL["Mana Thistle"] = true
NL["Netherbloom"] = true
NL["Nightmare Vine"] = true
NL["Ragveil"] = true
NL["Flame Cap"] = true
NL["Netherdust Bush"] = true
NL["Adder's Tongue"] = true
NL["Constrictor Grass"] = true
NL["Deadnettle"] = true
NL["Goldclover"] = true
NL["Icethorn"] = true
NL["Lichbloom"] = true
NL["Talandra's Rose"] = true
NL["Tiger Lily"] = true
NL["Firethorn"] = true
NL["Frozen Herb"] = true
-- Treasure
NL["Giant Clam"] = true
NL["Battered Chest"] = true
NL["Tattered Chest"] = true
NL["Solid Chest"] = true
NL["Large Iron Bound Chest"] = true
NL["Large Solid Chest"] = true
NL["Large Battered Chest"] = true
NL["Buccaneer's Strongbox"] = true
NL["Large Mithril Bound Chest"] = true
NL["Large Darkwood Chest"] = true
NL["Un'Goro Dirt Pile"] = true
NL["Bloodpetal Sprout"] = true
NL["Blood of Heroes"] = true
NL["Practice Lockbox"] = true
NL["Battered Footlocker"] = true
NL["Waterlogged Footlocker"] = true
NL["Dented Footlocker"] = true
NL["Mossy Footlocker"] = true
NL["Scarlet Footlocker"] = true
NL["Burial Chest"] = true
NL["Fel Iron Chest"] = true
NL["Heavy Fel Iron Chest"] = true
NL["Adamantite Bound Chest"] = true
NL["Felsteel Chest"] = true
NL["Glowcap"] = true
NL["Wicker Chest"] = true
NL["Primitive Chest"] = true
NL["Solid Fel Iron Chest"] = true
NL["Bound Fel Iron Chest"] = true
--NL["Bound Adamantite Chest"] = true -- Only appears in instances, also has conflicting reverse lookup issues
NL["Netherwing Egg"] = true
