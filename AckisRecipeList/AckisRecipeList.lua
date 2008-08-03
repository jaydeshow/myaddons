﻿--[[
****************************************************************************************
AckisRecipeList
$Date: 2008-08-02 16:44:33 -0400 (Sat, 02 Aug 2008) $
$Rev: 79686 $

Author: Ackis on Illidan US Horde

****************************************************************************************

Please see Wowace.com for more information.

****************************************************************************************

Documentation:

The mod is segmented into different files, based on what they do.

Localization:

All the localization files are located in the "Locals" sub-directory.  Feel free to edit locals in any
language, make the enUS more effecient, correct typos, etc.  All I would ask is if you do edit something,
check in-game first to make sure the change works.

Graphical Interface:

All the graphical interface functions are located in ARLFrame.lua  This file contains all the functions
needed for the GUI.  If you have enhancements, know how to fix an issue, etc please feel free to
contribute.  Just leave a detailed commit note.  If it's a new feature please run it by me first before
adding anything.

Text Based Interface:

The text based interface is located in the ARLText.lua file.  This hasn't really been touched since initial
releases as people are using the GUI.

Recipe Database:

The recipe database (for professions, and beast skills) as well as the vendor data base are all located in
the RecipeDB folder.  The basic format for the function to add recipes is:
Spell ID, Skill Level, Obtain Information, Flags

Spell ID is the IDsof the spell that creates the item.  For example, Robe of Winter Night is item ID
14136 (http://www.wowdb.com/item.aspx?id=14136).  It's created by spell ID 18436
(http://www.wowdb.com/spell.aspx?id=18436).

Skill level is the level of the profession in which you  can learn the specified pattern.

Obtain information is how the recipe is learnt.  For world drops, it's as simple as listing the type of
world drop, same for trainers.  However, for monster drops, quest rewards, faction rewards, there is a 
function which will add the information in an easy to read format.

Flags are different flags which allow me to filter out the recipes.  These flags are defined as:
		-- ALLIANCE= Alliance faction only
		-- HORDE = Horde faction only
		-- 1 = Trainer
		-- 2 = Vendor
		-- 3 = Item BoE
		-- 4 = Item BoP
		-- 5 = Instance
		-- 6 = Raid
		-- 7 = Seasonal
		-- 8 = Quest
		-- 9 = PVP
		-- 10 = cloth
		-- 11 = leather
		-- 12 = mail
		-- 13 = plate
		-- 14 = physical dps (melee/hunters)
		-- 15 = tanking
		-- 16 = healing
		-- 17 = caster DPS
		-- 18 = world drop
		-- 19 = Recipe BoE
		-- 20 = Recipe BoP

There are additional flags based off of which faction reputation you can obtain the recipe from.

Feel free to update any recipes with flags, new recipes, correcting the obtain information, etc.  Just
please ensure you leave a detailed commit note.

I'm hoping to one day have a dataminer which will automate this process but until that happens, I will
have to do things manually.  If you know how to do this and want to help me out, feel free to contact me.

****************************************************************************************
]]

local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")

AckisRecipeList = LibStub("AceAddon-3.0"):NewAddon("Ackis Recipe List", "AceConsole-3.0", "AceEvent-3.0")

local addon = AckisRecipeList

-- Global variables which are used between multiple files
addon.RecipeListing = nil
addon.MissingRecipeListing = nil
addon.VendorList = nil
addon.PetList = nil
addon.SkillType = nil
addon.FoundRecipes = nil
addon.FilteredRecipes = nil
addon.NumberOfRecipes = nil
addon.ResetOkayBlizz = nil
addon.ResetOkayARL = nil
-- To make tabbing between professions easier
addon.KnowProfession = {
	["Alchemy"] = false,
	["Blacksmithing"] = false,
	["Cooking"] = false,
	["Engineering"] = false,
	["Enchanting"] = false,
	["First Aid"] = false,
	["Leatherworking"] = false,
	["Poisons"] = false,
	["Smelting"] = false,
	["Tailoring"] = false,
	["Jewelcrafting"] = false,
	["Beast Training"] = false,
	["Inscription"] = false,
	}
addon.wrath = false

-- Frame variables
addon.ScanButton = nil
addon.Frame = nil

-- Make global API calls local to speed things up
local GetNumCrafts = GetNumCrafts
local GetNumTradeSkills = GetNumTradeSkills
local GetSpellInfo = GetSpellInfo
local GetSpellName = GetSpellName
local GetCraftInfo = GetCraftInfo
local GetCraftName = GetCraftName
local GetTradeSkillLine = GetTradeSkillLine
local GetTradeSkillInfo = GetTradeSkillInfo
local CraftIsPetTraining = CraftIsPetTraining
local GetDifficultyColor= GetDifficultyColor
local select = select
local format = format
local string = string
local tostring = tostring
local tonumber = tonumber
local pairs = pairs
local table = table
local next = next
local UnitLevel = UnitLevel
local UnitClass = UnitClass
local InterfaceOptionsFrame_OpenToFrame = InterfaceOptionsFrame_OpenToFrame
local BOOKTYPE_SPELL = BOOKTYPE_SPELL

-- Constants which are used everytime the add-on is loaded
local addonversion = GetAddOnMetadata("AckisRecipeList", "Version") .. " v." .. string.sub(GetAddOnMetadata("AckisRecipeList", "X-Revision"):gsub("$Rev:", ""),1,-2) -- No spaces because GetAddOnMetadata doesn't like it
local nagrandfac = BFAC["Kurenai"] .. "\\" .. BFAC["The Mag'har"]
local hellfirefac = BFAC["Honor Hold"] .. "\\" .. BFAC["Thrallmar"]
local factionlevels = {}

-- Global constants which are used between multiple files
addon.ARLTitle = "Ackis Recipe List v." .. addonversion
addon.br = "\n    - "

local playerFaction = UnitFactionGroup("player")

--[[

	Configuration Options

]]--

-- Returns configuration options for ARL
local function giveARLOptions()

	local command_options = {
	    type = "group",
	    args =
		{
			header1 =
			{
				order = 5,
				type = "header",
				name = "",
			},
			version =
			{
				order = 5,
				type = "description",
				name = L["Version"] .. addonversion .. "\n",
			},
			run = 
			{
				type = "execute",
				name = "Scan Recipes",
				desc = "Scans an open tradeskill for missing recipes.",
				func = function(info) addon:AckisRecipeList_Command() end,
				order = 50,
			},
		}
	}

	return command_options

end

-- Returns configuration options for profiling
local function giveProfiles()

	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
	return profiles

end

-- Returns configuration options for display
local function giveDisplay()

	local display =
	{
		type = "group",
		name = L["Display"],
		desc = L["DISPLAY_OPTIONS"],
		order = 1,
		args =
		{
			desc =
			{
				order = 1,
				type = "description",
				name = L["DISPLAY_OPTIONS"] .. "\n",
			},
			longdesc = 
			{
				order = 2,
				type = "description",
				name = L["DISPLAY_OPTIONS_LONG"] .. "\n",
			},
			usegui =
			{
				name	= L["Use GUI"],
				desc	= L["GUI_TOGGLE"],
				type	= "toggle",
				get		= function() return addon.db.profile.usegui end,
				set		= function() addon.db.profile.usegui = not addon.db.profile.usegui end,
				order	= 3,
			},
			testgui =
			{
				name	= "Test GUI",
				desc	= "New test GUI don't use this please.",
				type	= "toggle",
				get		= function() return addon.db.profile.testgui end,
				set		= function() addon.db.profile.testgui = not addon.db.profile.testgui end,
				order	= 6,
			},
			includefiltered =
			{
				name	= L["Include Filtered"],
				desc	= L["FILTERCOUNT_TOGGLE"],
				type	= "toggle",
				get		= function() return addon.db.profile.includefiltered end,
				set		= function() addon.db.profile.includefiltered = not addon.db.profile.includefiltered end,
				order	= 4,
			},
			closegui =
			{
				name	= L["Close GUI"],
				desc	= L["CLOSEGUI_TOGGLE"],
				type	= "toggle",
				get		= function() return addon.db.profile.closeguionskillclose end,
				set		= function() addon.db.profile.closeguionskillclose = not addon.db.profile.closeguionskillclose end,
				order	= 5,
			},
		}
	}

	return display

end

-- Returns configuraion options for filter
local function giveFilter()

	local filter =
	{
		type = "group",
		name = L["Filter"],
		desc = L["FILTER_OPTIONS"],
		order = 2,
		args =
		{
			desc =
			{
				order = 1,
				type = "description",
				name = L["FILTER_OPTIONS"] .. "\n",
			},
			longdesc = 
			{
				order = 2,
				type = "description",
				name = L["FILTER_OPTIONS_LONG"] .. "\n",
			},
			factions =
			{
				name	= L["Faction"],
				desc	= L["FACTION_TOGGLE"],
				type	= "toggle",
				get		= function() return addon.db.profile.faction end,
				set		= function() addon.db.profile.faction = not addon.db.profile.faction end,
				order	= 5,
			},
			classes =
			{
				name      = L["Classes"],
				desc      = L["CLASS_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.classes end,
				set       = function() addon.db.profile.classes = not addon.db.profile.classes end,
				order     = 10,
			},
			specialities =
			{
				name      = L["Specialities"],
				desc      = L["SPECIALITY_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.specialities end,
				set       = function() addon.db.profile.specialities = not addon.db.profile.specialities end,
				order     = 15,
			},
			skill =
			{
				name      = L["Skill"],
				desc      = L["SKILL_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.skill end,
				set       = function() addon.db.profile.skill = not addon.db.profile.skill end,
				order     = 20,
			},
			armour =
			{
				type = "group",
				name = L["Armour"],
				desc = L["ARMOUR_OPTIONS"],
				order = 29,
				args =
				{
					desc =
					{
						order = 1,
						type = "description",
						name = L["ARMOUR_OPTIONS"] .. "\n",
					},
					longdesc = 
					{
						order = 2,
						type = "description",
						name = L["ARMOUR_OPTIONS_LONG"] .. "\n",
					},
					cloth =
					{
						name      = L["Cloth"],
						desc      = L["CLOTH_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.cloth end,
						set       = function() addon.db.profile.cloth = not addon.db.profile.cloth end,
						order     = 90,
					},
					leather =
					{
						name      = L["Leather"],
						desc      = L["LEATHER_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.leather end,
						set       = function() addon.db.profile.leather = not addon.db.profile.leather end,
						order     = 91,
					},
					mail =
					{
						name      = L["Mail"],
						desc      = L["MAIL_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.mail end,
						set       = function() addon.db.profile.mail = not addon.db.profile.mail end,
						order     = 92,
					},
					plate =
					{
						name      = L["Plate"],
						desc      = L["PLATE_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.plate end,
						set       = function() addon.db.profile.plate = not addon.db.profile.plate end,
						order     = 93,
					},
				}
			},
			binding =
			{
				type = "group",
				name = L["Binding"],
				desc = L["BINDING_OPTIONS"],
				order = 30,
				args =
				{
					desc =
					{
						order = 1,
						type = "description",
						name = L["BINDING_OPTIONS"] .. "\n",
					},
					longdesc = 
					{
						order = 2,
						type = "description",
						name = L["BINDING_OPTIONS_LONG"] .. "\n",
					},
					BOE =
					{
						name	= L["BOEFilter"],
						desc	= L["BOE_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.boe end,
						set		= function() addon.db.profile.boe = not addon.db.profile.boe end,
						order	= 5,
					},
					BOP =
					{
						name	= L["BOPFilter"],
						desc	= L["BOP_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.bop end,
						set		= function() addon.db.profile.bop = not addon.db.profile.bop end,
						order	= 6,
					},
					RecipeBOE =
					{
						name	= L["RecipeBOEFilter"],
						desc	= L["RECIPE_BOE_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.recipeboe end,
						set		= function() addon.db.profile.recipeboe = not addon.db.profile.recipeboe end,
						order	= 7,
					},
					RecipeBOP =
					{
						name	= L["RecipeBOPFilter"],
						desc	= L["RECIPE_BOP_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.recipebop end,
						set		= function() addon.db.profile.recipebop = not addon.db.profile.recipebop end,
						order	= 8,
					},
				}
			},
			crafting =
			{
				type = "group",
				name = L["Crafting"],
				desc = L["CRAFTING_OPTIONS"],
				order = 35,
				args =
				{
					desc =
					{
						order = 1,
						type = "description",
						name = L["CRAFTING_OPTIONS"] .. "\n",
					},
					longdesc = 
					{
						order = 2,
						type = "description",
						name = L["CRAFTING_OPTIONS_LONG"] .. "\n",
					},
					melee =
					{
						name      = L["Melee"],
						desc      = L["MELEE_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.melee end,
						set       = function() addon.db.profile.melee = not addon.db.profile.melee end,
						order     = 5,
					},
					tanking =
					{
						name      = L["Tanking"],
						desc      = L["TANKING_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.tanking end,
						set       = function() addon.db.profile.tanking = not addon.db.profile.tanking end,
						order     = 10,
					},
					casterdps =
					{
						name      = L["Caster DPS"],
						desc      = L["CASTERDPS_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.casterdps end,
						set       = function() addon.db.profile.casterdps = not addon.db.profile.casterdps end,
						order     = 15,
					},
					healing =
					{
						name      = L["Healing"],
						desc      = L["HEALING_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.healing end,
						set       = function() addon.db.profile.healing = not addon.db.profile.healing end,
						order     = 20,
					},
				}
			},
			obtain =
			{
				type = "group",
				name = L["Obtain"],
				desc = L["OBTAIN_OPTIONS"],
				order = 40,
				args =
				{
					desc =
					{
						order = 1,
						type = "description",
						name = L["OBTAIN_OPTIONS"] .. "\n",
					},
					longdesc = 
					{
						order = 2,
						type = "description",
						name = L["OBTAIN_OPTIONS_LONG"] .. "\n",
					},
					instance =
					{
						name	= L["Instance"],
						desc	= L["INSTANCE_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.instance end,
						set		= function() addon.db.profile.instance = not addon.db.profile.instance end,
						order	= 10,
					},
					raid =
					{
						name      = L["Raid"],
						desc      = L["RAID_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.raid end,
						set       = function() addon.db.profile.raid = not addon.db.profile.raid end,
						order     = 11,
					},
					PVP =
					{
						name	= L["PVP"],
						desc	= L["PVP_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.pvp end,
						set		= function() addon.db.profile.pvp = not addon.db.profile.pvp end,
						order	= 20,
					},
					quest =
					{
						name	= L["Quest"],
						desc	= L["QUEST_TOGGLE"],
						type	= "toggle",
						get		= function() return addon.db.profile.quest end,
						set		= function() addon.db.profile.quest = not addon.db.profile.quest end,
						order	= 30,
					},
					trainer =
					{
						name      = L["Trainer"],
						desc      = L["TRAINER_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.trainer end,
						set       = function() addon.db.profile.trainer = not addon.db.profile.trainer end,
						order     = 60,
					},
					vendor =
					{
						name      = L["Vendor"],
						desc      = L["VENDOR_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.vendor end,
						set       = function() addon.db.profile.vendor = not addon.db.profile.vendor end,
						order     = 70,
					},
					seasonal =
					{
						name      = L["Seasonal"],
						desc      = L["SEASONAL_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.seasonal end,
						set       = function() addon.db.profile.seasonal = not addon.db.profile.seasonal end,
						order     = 80,
					},
					worlddrop =
					{
						name      = L["World Drop"],
						desc      = L["WORLD_DROP_TOGGLE"],
						type      = "toggle",
						get       = function() return addon.db.profile.worlddrop end,
						set       = function() addon.db.profile.worlddrop = not addon.db.profile.worlddrop end,
						order     = 81,
					},
				}
			},
			reputations =
			{
				type = "group",
				name = L["Reputation"],
				desc = L["REP_OPTIONS"],
				order = 45,
				args =
				{
					desc =
					{
						order = 1,
						type = "description",
						name = L["REP_OPTIONS"] .. "\n",
					},
					longdesc = 
					{
						order = 2,
						type = "description",
						name = L["REP_OPTIONS_LONG"] .. "\n",
					},
					oldworld =
					{
						type = "group",
						name = L["Old World"],
						desc = L["OLDWORLD_OPTIONS"],
						order = 5,
						args =
						{
							desc =
							{
								order = 1,
								type = "description",
								name = L["OLDWORLD_OPTIONS"] .. "\n",
							},
							longdesc = 
							{
								order = 2,
								type = "description",
								name = L["OLDWORLD_OPTIONS_LONG"] .. "\n",
							},
							ArgentDawn =
							{
								name	= BFAC["Argent Dawn"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Argent Dawn"]),
								type	= "toggle",
								get		= function() return addon.db.profile.argentdawn end,
								set		= function() addon.db.profile.argentdawn = not addon.db.profile.argentdawn end,
								order	= 3,
							},
							CenarionCircle =
							{
								name	= BFAC["Cenarion Circle"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Cenarion Circle"]),
								type	= "toggle",
								get		= function() return addon.db.profile.cenarioncircle end,
								set		= function() addon.db.profile.cenarioncircle = not addon.db.profile.cenarioncircle end,
								order	= 15,
							},
							TB =
							{
								name	= BFAC["Thorium Brotherhood"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Thorium Brotherhood"]),
								type	= "toggle",
								get		= function() return addon.db.profile.thoriumbrotherhood end,
								set		= function() addon.db.profile.thoriumbrotherhood = not addon.db.profile.thoriumbrotherhood end,
								order	= 75,
							},
							Timbermaw =
							{
								name	= BFAC["Timbermaw Hold"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Timbermaw Hold"]),
								type	= "toggle",
								get		= function() return addon.db.profile.timbermaw end,
								set		= function() addon.db.profile.timbermaw = not addon.db.profile.timbermaw end,
								order	= 80,
							},
							Zandalar =
							{
								name	= BFAC["Zandalar Tribe"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Zandalar Tribe"]),
								type	= "toggle",
								get		= function() return addon.db.profile.zandalar end,
								set		= function() addon.db.profile.zandalar = not addon.db.profile.zandalar end,
								order	= 90,
							},
						},
					},
					BC =
					{
						type = "group",
						name = L["Burning Crusade"],
						desc = L["BC_OPTIONS"],
						order = 10,
						args =
						{
							desc =
							{
								order = 1,
								type = "description",
								name = L["BC_OPTIONS"] .. "\n",
							},
							longdesc = 
							{
								order = 2,
								type = "description",
								name = L["BC_OPTIONS_LONG"] .. "\n",
							},
							Aldor =
							{
								name	= BFAC["The Aldor"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Aldor"]),
								type	= "toggle",
								get		= function() return addon.db.profile.aldor end,
								set		= function() addon.db.profile.aldor = not addon.db.profile.aldor end,
								order	= 3,
							},
							Ashtongue =
							{
								name	= BFAC["Ashtongue Deathsworn"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Ashtongue Deathsworn"]),
								type	= "toggle",
								get		= function() return addon.db.profile.ashtonguedeathsworn end,
								set		= function() addon.db.profile.ashtonguedeathsworn = not addon.db.profile.ashtonguedeathsworn end,
								order	= 10,
							},
							CenarionExpidition =
							{
								name	= BFAC["Cenarion Expedition"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Cenarion Expedition"]),
								type	= "toggle",
								get		= function() return addon.db.profile.cenarionexpidition end,
								set		= function() addon.db.profile.cenarionexpidition = not addon.db.profile.cenarionexpidition end,
								order	= 20,
							},
							Consortium =
							{
								name	= BFAC["The Consortium"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Consortium"]),
								type	= "toggle",
								get		= function() return addon.db.profile.consortium end,
								set		= function() addon.db.profile.consortium = not addon.db.profile.consortium end,
								order	= 25,
							},
							HellfireFactions =
							{
								name	= hellfirefac,
								desc	= format(L["SPECIFIC_REP_TOGGLE"],hellfirefac),
								type	= "toggle",
								get		= function() return addon.db.profile.hellfirefac end,
								set		= function() addon.db.profile.hellfirefac = not addon.db.profile.hellfirefac end,
								order	= 30,
							},
							KoT =
							{
								name	= BFAC["Keepers of Time"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Keepers of Time"]),
								type	= "toggle",
								get		= function() return addon.db.profile.kot end,
								set		= function() addon.db.profile.kot = not addon.db.profile.kot end,
								order	= 35,
							},
							NagrandFactions =
							{
								name	= nagrandfac,
								desc	= format(L["SPECIFIC_REP_TOGGLE"],nagrandfac),
								type	= "toggle",
								get		= function() return addon.db.profile.nagrandfac end,
								set		= function() addon.db.profile.nagrandfac = not addon.db.profile.nagrandfac end,
								order	= 40,
							},
							LowerCity =
							{
								name	= BFAC["Lower City"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Lower City"]),
								type	= "toggle",
								get		= function() return addon.db.profile.lowercity end,
								set		= function() addon.db.profile.lowercity = not addon.db.profile.lowercity end,
								order	= 45,
							},
							Scale =
							{
								name	= BFAC["The Scale of the Sands"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Scale of the Sands"]),
								type	= "toggle",
								get		= function() return addon.db.profile.scaleofsands end,
								set		= function() addon.db.profile.scaleofsands = not addon.db.profile.scaleofsands end,
								order	= 50,
							},
							Scryer =
							{
								name	= BFAC["The Scryers"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Scryers"]),
								type	= "toggle",
								get		= function() return addon.db.profile.scryer end,
								set		= function() addon.db.profile.scryer = not addon.db.profile.scryer end,
								order	= 55,
							},
							Shatar =
							{
								name	= BFAC["The Sha'tar"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Sha'tar"]),
								type	= "toggle",
								get		= function() return addon.db.profile.shatar end,
								set		= function() addon.db.profile.shatar = not addon.db.profile.shatar end,
								order	= 60,
							},
							SSO =
							{
								name	= BFAC["Shattered Sun Offensive"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Shattered Sun Offensive"]),
								type	= "toggle",
								get		= function() return addon.db.profile.sso end,
								set		= function() addon.db.profile.sso = not addon.db.profile.sso end,
								order	= 65,
							},
							Sporeggar =
							{
								name	= BFAC["Sporeggar"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Sporeggar"]),
								type	= "toggle",
								get		= function() return addon.db.profile.sporeggar end,
								set		= function() addon.db.profile.sporeggar = not addon.db.profile.sporeggar end,
								order	= 70,
							},
							Violeteye =
							{
								name	= BFAC["The Violet Eye"],
								desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Violet Eye"]),
								type	= "toggle",
								get		= function() return addon.db.profile.violeteye end,
								set		= function() addon.db.profile.violeteye = not addon.db.profile.violeteye end,
								order	= 85,
							},
						}
					},
					WotLK =
					{
						type = "group",
						name = L["Wrath of the Lich King"],
						desc = L["WOTLK_OPTIONS"],
						order = 15,
						args =
						{
							desc =
							{
								order = 1,
								type = "description",
								name = L["WOTLK_OPTIONS"] .. "\n",
							},
							longdesc = 
							{
								order = 2,
								type = "description",
								name = L["WOTLK_OPTIONS_LONG"] .. "\n",
							},
						}
					},
				}
			},
		}
	}

	return filter

end

-- Returns configuraion options for sorintg
local function giveSorting()

	local sorting =
	{
		type = "group",
		name = L["Sort"],
		desc = L["SORT_OPTIONS"],
		order = 2,
		args =
		{
			desc =
			{
				order = 1,
				type = "description",
				name = L["SORT_OPTIONS"] .. "\n",
			},
			longdesc =
			{
				order = 2,
				type = "description",
				name = L["SORT_OPTIONS_LONG"] .. "\n",
			},
			sorting = {
				name	= L["Sort"],
				desc	= L["SORT_OPTIONS"],
				type	= "select",
				values	= function() return {Name = L["Name"], Skill = L["Skill"], Aquisition = L["Aquisition"]} end,
				get		= function() return addon.db.profile.sorting end,
				-- This will probably cause people in multiple locals to have issues
				set		= function(info,name) addon.db.profile.sorting = name end,
				order	= 3,
				},
		},
	}

	return sorting

end

--[[

	Saved variables functions

]]--


--[[

	Reset functions

]]--

-- Reset all variables

function addon:ResetVariables()

	addon.RecipeListing = nil
	addon.MissingRecipeListing = nil

	addon.SkillType = nil
	addon.FoundRecipes = nil
	addon.NumberOfRecipes = nil
	addon.FilteredRecipes = nil

end

-- Initializes the initial recipe array, reseting it completely.

function addon:InitializeRecipeArray()

	-- Reset namespace to be empty
	addon.RecipeListing = {}
	addon.MissingRecipeListing = {}

	-- Sets the total number of recipes to 0.
	addon.NumberOfRecipes = 0

	-- Sets the number of found recipes to 0.
	addon.FoundRecipes = 0

	-- Sets number of filtered recipes to 0
	addon.FilteredRecipes = 0

end

--[[

	Initialization functions

]]--

-- Register slash commands and profile defaults

function addon:OnInitialize()

	local AceConfigReg = LibStub("AceConfigRegistry-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")

	self.db = LibStub("AceDB-3.0"):New("AckisRecipeListDB", defaults, "char")

	-- Create the options with Ace3
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Ackis Recipe List",giveARLOptions,"Ackis Recipe List")
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Display",giveDisplay)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Sorting",giveSorting)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Filter",giveFilter)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Profile",giveProfiles)

	-- Add the options to blizzard frame (add them backwards so they show up in the proper order
	self.optionsFrame = AceConfigDialog:AddToBlizOptions("Ackis Recipe List","Ackis Recipe List")
	self.optionsFrame[L["About"]] = LibStub("LibAboutPanel").new("Ackis Recipe List", "Ackis Recipe List")
	self.optionsFrame[L["Display"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Display", L["Display"], "Ackis Recipe List")
	self.optionsFrame[L["Filter"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Filter", L["Filter"], "Ackis Recipe List")
	self.optionsFrame[L["Sort"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Sorting", L["Sort"], "Ackis Recipe List")
	self.optionsFrame[L["Profile"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Profile", L["Profile"], "Ackis Recipe List")

	-- Register slash commands
	self:RegisterChatCommand("arl", "ChatCommand")

	-- Set default options, which are to include everything in the scan
	self.db:RegisterDefaults(
		{ profile =
			{
			-- Filter Options
		    faction = true,
			classes = false,
			specialities = false,
			skill = true,

			-- Sorting Options
			sorting = "Skill",

			-- Display Options
			usegui = true,
			includefiltered = false,
			closeguionskillclose = false,
			testgui = false,

			-- Obtain Options
			trainer = true,
			vendor = true,
			boe = true,
			bop = true,
			instance = true,
			raid = true,
			seasonal = true,
			quest = true,
			pvp = true,
			worlddrop = true,
			cloth = true,
			leather = true,
			mail = true,
			plate = true,
			melee = true,
			tank = true,
			healer = true,
			casterdps = true,
			recipebop = true,
			recipeboe = true,
			
			-- Reputation Options
			aldor = true,
			scryer = true,
			argentdawn = true,
			ashtonguedeathsworn = true,
			cenarioncircle = true,
			cenarionexpidition = true,
			consortium = true,
			hellfirefac = true,
			kot = true,
			nagrandfac = true,
			lowercity = true,
			scaleofsands = true,
			shatar = true,
			sso = true,
			sporeggar = true,
			thoriumbrotherhood = true,
			timbermaw = true,
			violeteye = true,
			zandalar = true,

			-- Filtered recipe list
			filteredrecipes = {}
			}
		}
	)

	-- Populate the repuatation level
	self:GetFactionLevels()
	-- Populate the known professions
	--self:GetKnownProfessions()

end

-- Register events and create the scan button on enable

function addon:OnEnable()

	-- Make addon respond to the tradeskill and crafting windows being shown
	self:RegisterEvent("TRADE_SKILL_SHOW")
	self:RegisterEvent("CRAFT_SHOW")

	-- Addon responds to tradeskill and crafting windows being closed.
	self:RegisterEvent("CRAFT_CLOSE")
	self:RegisterEvent("TRADE_SKILL_CLOSE")

	-- Add an option so that ARL will work with Manufac
	if Manufac then
		Manufac.options.args.ARLScan = {
			type = 'execute',
			name = L["Scan Skills"],
			desc = L["Scan Skills Long"],
			func = function() addon:AckisRecipeList_Command() end,
			order = 550,
		}
	end

	local _, _, _, ver = GetBuildInfo()
	if ver >= 30000 then
		self:Print("Enabling WotLK compatibility")
		addon.wrath = true
	end

	--Create the button now for later use
	self:CreateScanButton()

end

-- Hides the frame if the mod gets disabled

function addon:OnDisable()

	self:ResetVariables()
	addon.VendorList = nil
	addon.PetList = nil

	if addon.Frame then
		addon.Frame:Hide()
	end

	-- Remove the option from Manufac
	if Manufac then
		Manufac.options.args.ARLScan = nil
	end

end

-- Watch for the trade skill window to be shown, add all specific trade skills to an array, then scan the trade skill window for all recipes.

function addon:TRADE_SKILL_SHOW()

	-- If we don't have a skill window open already
	if (Skillet and Skillet:IsActive()) or (ATSWFrame) or (addon.SkillType == nil or addon.SkillType == "Trade") then

		addon.SkillType = "Trade"
		addon.ResetOkayBlizz = false

		if (addon.ScanButton and not Skillet) then
			self:ShowScanButton()
		end

	else

		self:Print(L["TwoCraftingWindows"])

	end

end

-- Clean up tables from memory when trade skill window is closed

function addon:TRADE_SKILL_CLOSE()

	addon.ResetOkayBlizz = true
	addon.SkillType = nil

	if (addon.ResetOkayBlizz and addon.ResetOkayARL) then
		self:ResetVariables()
	end

	if (addon.db.profile.closeguionskillclose and addon.Frame) then
		self:CloseWindow()
	end

	if (addon.ScanButton and not Skillet) then
		addon.ScanButton:Hide()
	end

end

-- Watch for the craft skill window to be shown, add all specific trade skills to an array, then scan the craft skill window for all recipes.

function addon:CRAFT_SHOW()

	-- If we don't have a skill window open already
	if (Skillet and Skillet:IsActive()) or (ATSWFrame) or (addon.SkillType == nil or addon.SkillType == "Craft") then

		addon.SkillType = "Craft"
		addon.ResetOkayBlizz = false

		if (addon.ScanButton and (not Skillet or CraftIsPetTraining())) then
			self:ShowScanButton()
		end

	else

		self:Print(L["TwoCraftingWindows"])

	end

end

-- Clean up tables from memory when craft window is closed

function addon:CRAFT_CLOSE()

	addon.ResetOkayBlizz = true
	addon.SkillType = nil

	if (addon.ResetOkayBlizz and addon.ResetOkayARL) then
		self:ResetVariables()
	end

	if (addon.db.profile.closeguionskillclose and addon.Frame) then
		self:CloseWindow()
	end

	if (addon.ScanButton and not Skillet) then
		addon.ScanButton:Hide()
	end

end

-- Slash command handler

function addon:ChatCommand(input)

	if (addon.wrath) then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["About"]])
	else

		if (not input) or (input and input:trim() == "") or (input == string.lower(L["About"])) then
			-- Open About panel if there's no parameters
			InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["About"]])
			--InterfaceOptionsFrame_OpenToFrame(self.optionsFrame)
		elseif (input == string.lower(L["Sort"])) then
			InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Sort"]])
		elseif (input == string.lower(L["Filter"])) then
			InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Filter"]])
		elseif (input == string.lower(L["Display"])) then
			InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Display"]])
		elseif (input == string.lower(L["Profile"])) then
			InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Profile"]])
		else
			LibStub("AceConfigCmd-3.0"):HandleCommand("arl", "Ackis Recipe List", input)
		end

	end

end


--[[

	Tradeskill functions

]]--

-- Adds a specifc recipe to the recipe list array. 

function addon:addTradeSkill(RecipeName, RecipeLevel, RecipeAquire, RecipeLink, ...)

	-- Creates a table in the addon.RecipeListing table storing all information about a recipe
	addon.RecipeListing[RecipeName] = {}
	-- Set the name and aquire information
	addon.RecipeListing[RecipeName]["Level"] = RecipeLevel
	addon.RecipeListing[RecipeName]["Acquire"] = RecipeAquire
	addon.RecipeListing[RecipeName]["RecipeLink"] = RecipeLink

	-- All recipes are unknown until scan occurs
	addon.RecipeListing[RecipeName]["Known"] = false

	-- Increment the total number of recipes added to the list
	addon.NumberOfRecipes = addon.NumberOfRecipes + 1

	-- Create the speciality space
	addon.RecipeListing[RecipeName]["Speciality"] = {}
	-- Parse all extra variables and add them to the speciality table
	local numvars = select('#',...)
	for i=1,numvars,1 do
		local temp = select(i,...)
		tinsert(addon.RecipeListing[RecipeName]["Speciality"],temp)
	end

	-- Do we display this recipe?  Used for specific hiding of a recipe, or search filter results
	addon.RecipeListing[RecipeName]["Display"] = true

end

-- Same as previous function but uses spell ID to get recipe name

function addon:addTradeSkillSpell(RecipeName, RecipeLevel, RecipeAquire, ...)

	if (GetSpellInfo(RecipeName) ~= nil) then
		local spelllink = GetSpellLink(RecipeName)
		self:addTradeSkill(GetSpellInfo(RecipeName), RecipeLevel, RecipeAquire, spelllink, ...)
	else
		self:addTradeSkill(tostring(RecipeName), RecipeLevel, RecipeAquire, nil, ...)
		self:Print(format(L["SpellIDCache"],RecipeName))
	end

end

-- Same as previous but combines spell rank for beast training

function addon:addTradeSkillBeast(RecipeName, RecipeLevel, RecipeAquire, ...)

	-- Variables named after friends on an old server because they both really wanted to be in my mod :P
	local Jimo,Megadopolous = GetSpellInfo(RecipeName)

	if (Jimo ~= nil) then
		local TempHunterSkill = Jimo .. " (" .. Megadopolous .. ")"
		local spelllink = GetSpellLink(RecipeName)
		self:addTradeSkill(TempHunterSkill, RecipeLevel, RecipeAquire, spelllink, ...)
	else
		self:addTradeSkill(tostring(RecipeName), RecipeLevel, RecipeAquire, nil, ...)
		self:Print(format(L["SpellIDCache"],RecipeName))
	end

end

-- Adds vendor information to the vendor list array.

function addon:addVendorList(VendorID, VendorName, VendorFaction, VendorLoc, VendorCoords)

	addon.VendorList[VendorID] = {}
	addon.VendorList[VendorID]["Name"] = VendorName
	addon.VendorList[VendorID]["Faction"] = VendorFaction
	addon.VendorList[VendorID]["Location"] = VendorLoc
	addon.VendorList[VendorID]["Coords"] = VendorCoords

end

-- Adds pet information to the pet list array

function addon:addPetList(PetID, PetName, PetLocation, PetLevelMin, PetLevelMax, isElite, isRare)

	addon.PetList[PetID] = {}
	addon.PetList[PetID]["Name"] = PetName
	addon.PetList[PetID]["Location"] = PetLocation
	addon.PetList[PetID]["MinLvl"] = PetLevelMin
	addon.PetList[PetID]["MaxLvl"] = PetLevelMax
	addon.PetList[PetID]["Elite"] = isElite
	addon.PetList[PetID]["Rare"] = isRare

end

-- Modifies recipe array if a recipe is found, setting the Known flag as true.

function addon:foundTradeSkill(RecipeName)

	addon.RecipeListing[RecipeName]["Known"] = true

	-- Increase found count
	addon.FoundRecipes = addon.FoundRecipes + 1

end

--[[

	Recipe Filtering Functions

]]--

-- Toggles the filtering of a specific recipe, including it or preventing it from being displayed in the results

function addon:ToggleFilterRecipe(RecipeName)

	-- Remove the recipe name from the saved variables
	if (addon.RecipeListing[RecipeName]["Display"] == false) then
		tremove(addon.db.profile.filteredrecipes,RecipeName)
	-- Add recipe name to the saved variables
	else
		tinsert(addon.db.profile.filteredrecipes,RecipeName)	
	end

	addon.RecipeListing[RecipeName]["Display"] = not addon.RecipeListing[RecipeName]["Display"]

end

-- Parses through the filtered recipe list, marking the ones which appear in the list to not display

function addon:MarkFilteredRecipes()

	-- Parse the filtered recipes saved variables
	for i,k in pairs(addon.db.profile.filteredrecipes) do
		-- If the recipe is in our current database mark it to not be displayed
		if (addon.RecipeListing[k]) then
			addon.RecipeListing[k]["Display"] = false
		end
	end

end

-- Checks to see if a recipe is known or not.  If the recipe is not in the database, output it to chat.

function addon:CheckRecipe(RecipeName)

	if (addon.RecipeListing[RecipeName]) then
		-- Update array that recipe was found
		self:foundTradeSkill(RecipeName)
	else
		-- Notify users in chat that skill is missing from the database.
		self:printMissingSkill(RecipeName)
	end

end

do

	-- Class table for class checks to make them go faster
	local ClassTable = {
		["WARLOCK"] = true,
		["WARRIOR"] = true,
		["HUNTER"] = true,
		["MAGE"] = true,
		["PRIEST"] = true,
		["DRUID"] = true,
		["PALADIN"] = true,
		["SHAMAN"] = true,
		["ROGUE"] = true,
		--["DEATHKNIGHT"] = true,
	}

	-- Rep table space which wil lbe used to check if a recipe is displayed or not
	local RepTable = nil

	-- All Alchemy Specialities
	local AlchemySpec = {
		[GetSpellInfo(28674)] = true,
		[GetSpellInfo(28678)] = true,
		[GetSpellInfo(28676)] = true,
	}

	-- All Blacksmithing Specialities
	local BlacksmithSpec = {
		[GetSpellInfo(9788)] = true, -- Armorsmith
		[GetSpellInfo(17041)] = true, -- Master Axesmith
		[GetSpellInfo(17040)] = true, -- Master Hammersmith
		[GetSpellInfo(17039)] = true, -- Master Swordsmith
		[GetSpellInfo(9787)] = true, -- Weaponsmith
	}

	-- All Engineering Specialities
	local EngineeringSpec = {
		[GetSpellInfo(20219)] = true, -- Gnomish
		[GetSpellInfo(20222)] = true, -- Goblin
	}

	-- All Leatherworking Specialities
	local LeatherworkSpec = {
		[GetSpellInfo(10657)] = true, -- Dragonscale
		[GetSpellInfo(10659)] = true, -- Elemental
		[GetSpellInfo(10661)] = true, -- Tribal
	}

	-- All Tailoring Specialities
	local TailorSpec = {
		[GetSpellInfo(26797)] = true, -- Spellfire
		[GetSpellInfo(26801)] = true, -- Shadoweave
		[GetSpellInfo(26798)] = true, -- Primal Mooncloth
	}

	-- List of classes which have specialities
	local SpecialtyTable = {
		[GetSpellInfo(2259)] = AlchemySpec,
		[GetSpellInfo(2018)] = BlacksmithSpec,
		[GetSpellInfo(4036)] = EngineeringSpec,
		[GetSpellInfo(2108)] = LeatherworkSpec,
		[GetSpellInfo(3908)] = TailorSpec,
	}

	-- List containing all possible specialities
	local AllSpecialitiesTable = {
	}

	-- Populate the speciality table with all specialities, not adding alchemy because no recipes have alchemy filters
	for i in pairs(BlacksmithSpec) do AllSpecialitiesTable[i] = true end
	for i in pairs(EngineeringSpec) do AllSpecialitiesTable[i] = true end
	for i in pairs(LeatherworkSpec) do AllSpecialitiesTable[i] = true end
	for i in pairs(TailorSpec) do AllSpecialitiesTable[i] = true end

	-- Toggles the value in the rep table when the profile is updated
	function addon:UpdateReptable(rep)
		RepTable[rep] = not RepTable[rep]
	end

	-- Creates the reputation table 
	local function PopulateReptable()

		if (RepTable == nil) then
			RepTable = {}
		end

		RepTable[BFAC["The Scryers"]] = addon.db.profile.scryer
		RepTable[BFAC["The Aldor"]] = addon.db.profile.aldor
		RepTable[BFAC["Argent Dawn"]] = addon.db.profile.argentdawn
		RepTable[BFAC["Ashtongue Deathsworn"]] = addon.db.profile.ashtonguedeathsworn
		RepTable[BFAC["Cenarion Circle"]] = addon.db.profile.cenarioncircle
		RepTable[BFAC["Cenarion Expedition"]] = addon.db.profile.cenarionexpidition
		RepTable[BFAC["The Consortium"]] = addon.db.profile.consortium
		RepTable[BFAC["Honor Hold"]] = addon.db.profile.hellfirefac
		RepTable[BFAC["Thrallmar"]] = addon.db.profile.hellfirefac
		RepTable[BFAC["Keepers of Time"]] = addon.db.profile.kot
		RepTable[BFAC["Kurenai"]] = addon.db.profile.nagrandfac
		RepTable[BFAC["The Mag'har"]] = addon.db.profile.nagrandfac
		RepTable[BFAC["Lower City"]] = addon.db.profile.lowercity
		RepTable[BFAC["The Scale of the Sands"]] = addon.db.profile.scaleofsands
		RepTable[BFAC["The Sha'tar"]] = addon.db.profile.shatar
		RepTable[BFAC["Shattered Sun Offensive"]] = addon.db.profile.sso
		RepTable[BFAC["Sporeggar"]] = addon.db.profile.sporeggar
		RepTable[BFAC["Thorium Brotherhood"]] = addon.db.profile.thoriumbrotherhood
		RepTable[BFAC["Timbermaw Hold"]] = addon.db.profile.timbermaw
		RepTable[BFAC["The Violet Eye"]] = addon.db.profile.violeteye
		RepTable[BFAC["Zandalar Tribe"]] = addon.db.profile.zandalar

	end

	-- Get the players class
	local _, playerClass = UnitClass("player")

	-- Internal function to determine if a specific faction is to be displayed or not

	local function CheckDisplayFaction(CurrentCheck)

		return RepTable[CurrentCheck]

	end

	-- Check to see if recipe should be displayed or not

	function addon:CheckDisplayRecipe(RecipeName, CurrentProfessionLevel, CurrentProfession, CurrentSpeciality)

		-- ALLIANCE= Alliance faction only
		-- HORDE = Horde faction only
		-- 1 = Trainer
		-- 2 = Vendor
		-- 3 = Item BoE
		-- 4 = Item BoP
		-- 5 = Instance
		-- 6 = Raid
		-- 7 = Seasonal
		-- 8 = Quest
		-- 9 = PVP
		-- 10 = cloth
		-- 11 = leather
		-- 12 = mail
		-- 13 = plate
		-- 14 = physical dps (melee/hunters)
		-- 15 = tanking
		-- 16 = healing
		-- 17 = caster DPS
		-- 18 = world drop
		-- 19 = Recipe BoE
		-- 20 = Recipe BoP


		-- Update the rep table with appropiate flags
		PopulateReptable()

		-- Check to see if we're filtering this recipe due to search results or as a specific filter
		if (not addon.RecipeListing[RecipeName]["Display"]) then
			addon.FilteredRecipes = addon.FilteredRecipes + 1
			return false
		end

		-- Display all skill levels
		if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) and (not addon.db.profile.skill) then
			addon.FilteredRecipes = addon.FilteredRecipes + 1
			return false
		end

		local classcheck = false
		local classoccur = false
		local displaycheck = true

		if (addon.MissingRecipeListing[RecipeName]["Speciality"] ~= nil) then

			for i, CurrentCheck in pairs(addon.MissingRecipeListing[RecipeName]["Speciality"]) do

				-- Display trainer recipes
				if (not addon.db.profile.trainer) and (CurrentCheck == 1) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display vendor recipes
				if (not addon.db.profile.vendor) and (CurrentCheck == 2) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display BoE recipes
				if (not addon.db.profile.boe) and (CurrentCheck == 3) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display BoP recipes
				if (not addon.db.profile.bop) and (CurrentCheck == 4) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display instance recipes
				if (not addon.db.profile.instance) and (CurrentCheck == 5) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display hard to obtain raid recipes
				if (not addon.db.profile.raid) and (CurrentCheck == 6) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display seasonal recipes
				if (not addon.db.profile.seasonal) and (CurrentCheck == 7) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display pvp recipes
				if (not addon.db.profile.pvp) and (CurrentCheck == 8) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display quest recipes
				if (not addon.db.profile.quest) and (CurrentCheck == 9) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display cloth recipes
				if (not addon.db.profile.cloth) and (CurrentCheck == 10) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display leather recipes
				if (not addon.db.profile.leather) and (CurrentCheck == 11) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display mail recipes
				if (not addon.db.profile.mail) and (CurrentCheck == 12) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display plate recipes
				if (not addon.db.profile.plate) and (CurrentCheck == 13) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display melee dps recipes
				if (not addon.db.profile.melee) and (CurrentCheck == 14) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display tanking recipes
				if (not addon.db.profile.tanking) and (CurrentCheck == 15) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display healer recipes
				if (not addon.db.profile.healer) and (CurrentCheck == 16) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display caster dps recipes
				if (not addon.db.profile.casterdps) and (CurrentCheck == 17) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end
				
				-- Display world drop recipes
				if (not addon.db.profile.worlddrop) and (CurrentCheck == 18) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display recipe bop recipes
				if (not addon.db.profile.recipebop) and (CurrentCheck == 19) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display recipe boe recipes
				if (not addon.db.profile.recipeboe) and (CurrentCheck == 20) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display all faction recipes -and make sure the check is Horde or Alliance
				if (not addon.db.profile.faction) and ((CurrentCheck == BFAC["Horde"]) or (CurrentCheck == BFAC["Alliance"])) and (CurrentCheck ~= playerFaction) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Reputation check
				local ReputationCheck = CheckDisplayFaction(CurrentCheck)
				if (ReputationCheck ~= nil) and (ReputationCheck == false) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
					return false
				end

				-- Display all specialities (ie: Primal Mooncloth, Spellcloth, etc.)
				if (not addon.db.profile.specialities) then
					-- Are we looking at a speciality and is the current profession a profession that has a speciality?
					if (SpecialtyTable[CurrentProfession]) and (AllSpecialitiesTable[CurrentCheck]) then
						if (CurrentSpeciality ~= CurrentCheck) then
							addon.FilteredRecipes = addon.FilteredRecipes + 1
							return false
						end
					end
				end

				-- Display all class type recipes
				if (not addon.db.profile.classes) and (ClassTable[CurrentCheck]) then
					-- Set that a class check has occured in the case of multiple classes.
					classoccur = true
					if (CurrentCheck == playerClass) then
						classcheck = true
					end
				end

			end

		end

		if (displaycheck == true) then
			if (classoccur == true) then
				if (classcheck == false) then
					addon.FilteredRecipes = addon.FilteredRecipes + 1
				end
				return classcheck
			else
				return true
			end
		else
			addon.FilteredRecipes = addon.FilteredRecipes + 1
			return false
		end

	end

	-- Scans the first 24 entries in the spellbook to find which profession speciality someone is (assumption is that it will be within the first 24 because of the general tab)

	function addon:GetTradeSpeciality(CurrentProfession)

		-- Don't use the main speciality table, create our own copy so we can add alchemy to it
		local specialitytable = SpecialtyTable
		specialitytable[GetSpellInfo(3908)] = TailorSpec

		for index=1,25,1 do
			local spellName = GetSpellName(index, BOOKTYPE_SPELL)

			-- Nothing found
			if (not spellName) or (index == 25) or (not specialitytable[CurrentProfession]) then
				return ""
			end

			if (specialitytable[CurrentProfession][spellName]) then
				return spellName
			end
		end

	end

end

--[[

	RecipeAquisition Functions

]]--

-- Combines all monster information into a single string for output

function addon:CombineMobs(BoE, MobNames, MobLoc)

	if (BoE == true) then
		-- BoE drop from a mob
		return format("%s%s (%s)",L["BoE"],MobNames,MobLoc)
	else
		-- BoP drop from a mob
		return format("%s%s (%s)",L["BoP"],MobNames,MobLoc)
	end

end

do
	-- Table to store string components in
	local t = {}

	-- Combines all quest information into a single string for output

	function addon:CombineQuests(...)
	-- Ackis: If you'd just like to show the tooltip, `GameTooltip:SetHyperlink("quest:"..uid)`
		-- Reset the table
		for k in pairs(t) do t[k] = nil end

		--local questlinkformat = "\124Hquest:%s:%s\124h%s\124h" -- quest ID, quest level, quest name

		local numvars = select('#',...)

		-- Parse through the list
		for i=1,numvars,3 do
			local QuestName, QuestFaction, QuestLoc = select(i,...)
			if (QuestFaction == 1) then
				if (addon.db.profile.faction or playerFaction == BFAC["Alliance"]) then
					table.insert(t,self:Cyan(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
				end
			elseif (QuestFaction == 2) then
				if (addon.db.profile.faction or playerFaction == BFAC["Horde"]) then
					table.insert(t,self:Red(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
				end
			elseif (QuestFaction == 0) then
				table.insert(t,self:Gold(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
			end
		end

		return table.concat(t,addon.br)

	end

	-- Combines all pet information into a single string for output

	function addon:CombinePets(...)
		-- Reset the table
		for k in pairs(t) do t[k] = nil end

		local numvars = select('#',...)

		for i=1,numvars,1 do
	        local CurrentCheck = select(i, ...)
			local temp = GetDifficultyColor(tonumber(addon.PetList[CurrentCheck]["MinLvl"]))
			local ColourMin = self:Colourize(self:RGBtoHEX(temp.r,temp.g,temp.b),addon.PetList[CurrentCheck]["MinLvl"])
			temp = GetDifficultyColor(tonumber(addon.PetList[CurrentCheck]["MaxLvl"]))
			local ColourMax = self:Colourize(self:RGBtoHEX(temp.r,temp.g,temp.b),addon.PetList[CurrentCheck]["MaxLvl"])
				-- Normal
			if (not addon.PetList[CurrentCheck]["Rare"] and not addon.PetList[CurrentCheck]["Elite"]) then
				if (addon.PetList[CurrentCheck]["MinLvl"] == addon.PetList[CurrentCheck]["MaxLvl"]) then
					table.insert(t,format("%s: (%s): %s",addon.PetList[CurrentCheck]["Name"], ColourMin, addon.PetList[CurrentCheck]["Location"]))
				else
					table.insert(t,format("%s: (%s - %s): %s",addon.PetList[CurrentCheck]["Name"], ColourMin, ColourMax, addon.PetList[CurrentCheck]["Location"]))
				end
			-- Rare only
			elseif (addon.PetList[CurrentCheck]["Rare"] and not addon.PetList[CurrentCheck]["Elite"]) then
				if (addon.PetList[CurrentCheck]["MinLvl"] == addon.PetList[CurrentCheck]["MaxLvl"]) then
					table.insert(t,format("%s: %s (%s): %s", L["Rare"],addon.PetList[CurrentCheck]["Name"], ColourMin, addon.PetList[CurrentCheck]["Location"]))
				else
					table.insert(t,format("%s: %s (%s - %s): %s", L["Rare"],addon.PetList[CurrentCheck]["Name"], ColourMin, ColourMax, addon.PetList[CurrentCheck]["Location"]))
				end
			-- Elite only
			elseif (not addon.PetList[CurrentCheck]["Rare"] and addon.PetList[CurrentCheck]["Elite"]) then
				if (addon.PetList[CurrentCheck]["MinLvl"] == addon.PetList[CurrentCheck]["MaxLvl"]) then
					table.insert(t,format("%s: %s (%s): %s", L["Elite"],addon.PetList[CurrentCheck]["Name"], ColourMin, addon.PetList[CurrentCheck]["Location"]))
				else
					table.insert(t,format("%s: %s (%s - %s): %s", L["Elite"],addon.PetList[CurrentCheck]["Name"], ColourMin, ColourMax, addon.PetList[CurrentCheck]["Location"]))
				end
			-- Rare elite
			else
				if (addon.PetList[CurrentCheck]["MinLvl"] == addon.PetList[CurrentCheck]["MaxLvl"]) then
					table.insert(t,format("%s %s: %s (%s): %s", L["Rare"],L["Elite"],addon.PetList[CurrentCheck]["Name"], ColourMin, addon.PetList[CurrentCheck]["Location"]))
				else
					table.insert(t,format("%s %s: %s (%s - %s): %s", L["Rare"],L["Elite"],addon.PetList[CurrentCheck]["Name"], ColourMin, ColourMax, addon.PetList[CurrentCheck]["Location"]))
				end
			end
		end

		return table.concat(t, addon.br)

	end

	-- Combines Vendor name, location, faction into a single string.  A list of Vendor IDs is provided, along with if the recipe is limited supply.

	function addon:CombineVendors(...)
		-- Reset the table
		for k in pairs(t) do t[k] = nil end

		local numvars = select('#',...)

		-- Add type of vendor to string
		if (select(numvars, ...) == false) then
			table.insert(t,L["Vendor"])
		else
			table.insert(t,L["LimitedSupply"])
		end

		for i=1,(numvars-1),1 do
			local CurrentCheck = select(i, ...)
			if (addon.VendorList[CurrentCheck]["Faction"] == BFAC["Alliance"]) then
				if (addon.db.profile.faction or playerFaction == BFAC["Alliance"]) then
					table.insert(t,self:Cyan(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
				end
			elseif (addon.VendorList[CurrentCheck]["Faction"] == BFAC["Horde"]) then
				if (addon.db.profile.faction or playerFaction == BFAC["Horde"]) then
					table.insert(t,self:Red(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
				end
			elseif (addon.VendorList[CurrentCheck]["Faction"] == BFAC["Neutral"]) then
				table.insert(t,self:Gold(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
			else
				table.insert(t,format("%s - %s: %s",  addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"]))
			end
		end

		return table.concat(t, addon.br)

	end

end

-- Combines repuation level and faction name into a single string.

function addon:AddSingleReputation(RepLevel, Faction)

	local newfaction

	if (not factionlevels[Faction] or factionlevels[Faction] <= RepLevel) then
		newfaction = format("%s: %s -",self:Red(L["Reputation"]),self:Red(Faction))
	else
		newfaction = format("%s: %s -",L["Reputation"],Faction)
	end

	if (RepLevel == 1) then
		return format("%s %s",newfaction,self:Friendly(BFAC["Friendly"]))
	elseif (RepLevel == 2) then
		return format("%s %s",newfaction,self:Honored(BFAC["Honored"]))
	elseif (RepLevel == 3) then
		return format("%s %s",newfaction,self:Revered(BFAC["Revered"]))
	elseif (RepLevel == 4) then
		return format("%s %s",newfaction,self:Exalted(BFAC["Exalted"]))
	else
		self:Print(format(L["FactionError"],RepLevel))
		return format("%s %s",newfaction,RepLevel)
	end
end

-- Combines reputation level and faction name of two factions into a single string.

function addon:AddDoubleReputation(RepLevel, Faction1, Faction2)

	if (not addon.db.profile.faction) then
		local tempfac = ""
		-- Only return Alliance specific factions
		if (playerFaction == BFAC["Alliance"]) then
			tempfac = Faction1
		-- Only return Horde speficic factions
		elseif (playerFaction == BFAC["Horde"]) then
			tempfac = Faction2
		end
		-- Return the single faction
		return(self:AddSingleReputation(RepLevel,tempfac))
	else
		-- Return both factions reputations
		return self:AddSingleReputation(RepLevel,Faction1) .. addon.br .. self:AddSingleReputation(RepLevel,Faction2)
	end

end

--[[

	Searching Functions

]]--

-- Searches through the recipe name and aquisition information, setting the display flag to false if the search string does not appear

function addon:SearchRecipeDB(searchstring)

	for i in pairs(addon.RecipeListing) do
		if (not string.find(i,searchstring)) and (not string.find(addon.RecipeListing[i]["Acquire"],searchstring)) then
			addon.RecipeListing[i]["Display"] = false
		end
	end

end

-- Resets the display flags of all recipes in the database

function addon:ResetSearch()

	for i in pairs(addon.RecipeListing) do
		addon.RecipeListing[i]["Display"] = true
	end

end

--[[

	Sorting Functions

]]--

-- Returns true if a Recipe1 has a lower skill level than Recipe2

local function SortMissingSkill(Recipe1, Recipe2)

	return addon.MissingRecipeListing[Recipe1]["Level"] < addon.MissingRecipeListing[Recipe2]["Level"]

end

-- Returns true if a Recipe1 come before Recipe2 in the alphabet

local function SortMissingName(Recipe1, Recipe2)

	return Recipe1 < Recipe2

end

-- Returns true if a Recipe1 come before Recipe2 in the alphabet

local function SortMissingAquisition(Recipe1, Recipe2)

	return addon.RecipeListing[Recipe1]["Acquire"] < addon.RecipeListing[Recipe2]["Acquire"]

end

-- Sorts the addon.MissingRecipeListing with the given sorting function

function addon:SortMissingRecipes(SortFunction)

	local TempRecipeSort = {}

	-- Get all the indexes of the addon.MissingRecipeListing
	for n in pairs(addon.MissingRecipeListing) do
		table.insert(TempRecipeSort, n)
	end

	-- Sort the indexes according to the function
	table.sort(TempRecipeSort, SortFunction)

	return TempRecipeSort
end

--[[
	Recipe Array Functions

]]--

-- Initialize the profession tables depending on which skill window is opened.

local function InitializeTradeRecipes(CurrentProfession)

	-- Table of all possible professions with init functions
	local professiontable =
	{
		[GetSpellInfo(2259)] = addon.InitAlchemy,
		[GetSpellInfo(2018)] = addon.InitBlackSmith,
		[GetSpellInfo(2550)] = addon.InitCooking,
		[GetSpellInfo(4036)] = addon.InitEngineering,
		-- Use first aid spell of applying bandages to fix issues with other localizations
		[GetSpellInfo(746)] = addon.InitFirstAid,
		-- Hack to get first aid working on frFR since I can't seem to get a proper spell ID :P
		["Premiers soins"] = addon.InitFirstAid,
		--[GetSpellInfo(3273)] = addon.InitFirstAid,
		[GetSpellInfo(2108)] = addon.InitLeatherWorking,
		[GetSpellInfo(2842)] = addon.InitRoguePoison,
		[GetSpellInfo(2575)] = addon.InitSmelting,
		[GetSpellInfo(3908)] = addon.InitTailoring,
		[GetSpellInfo(25229)] = addon.InitJewelcrafting,
		--[GetSpellInfo()] = addon.InitInscription,
	}

	-- Thanks to sylvanaar/xinhuan for the code snippet
	local a = professiontable[CurrentProfession]

	if a then
		a(addon)
	else
		addon:Print(L["UnknownTradeSkill"]:format(CurrentProfession))
	end

end

-- Initialize the profession tables depending on which skill window is opened.

local function InitializeCraftRecipes(CurrentProfession)

	local CurrentProfessionLevel

	if (CurrentProfession == GetSpellInfo(7411)) then
		-- Get the current level of the craft.
		CurrentProfessionLevel = _G["CraftRankFrame"]:GetValue() --Better way to do this?
		-- Add all enchanting recipes to the table
		addon:InitEnchanting()

	elseif (CurrentProfession == GetSpellInfo(5149)) then

		-- Player level = profession level for beast training
		CurrentProfessionLevel = UnitLevel("player")
		-- Create a table to store all possible pets
		addon.PetList = {}
		-- Add all beast training recipes to the table
		addon:InitBeastTraining()

	else

		CurrentProfessionLevel = 0
		addon:Print(L["UnknownTradeSkill"]:format(CurrentProfession))

	end

	return CurrentProfessionLevel

end

-- Gets all the factions the player knows and their rep levels

function addon:GetFactionLevels()

	for i=1,GetNumFactions(),1 do
		local name,_,replevel = GetFactionInfo(i)
		-- If the rep is greater than neutral
		if (replevel > 4) then
			-- We use levels of 0, 1, 2, 3, 4 internally for reputation levels, make it corrospond here
			factionlevels[name] = replevel - 4
		end
	end

end

-- Scans the first 24 entries in the spellbook to find out which professions you know.

function addon:GetKnownProfessions()

	for index=1,25,1 do
		local spellName = GetSpellName(index, BOOKTYPE_SPELL)

		-- Nothing found
		if (not spellName) or (index == 25) then
			break
		end

		if (addon.KnowProfession[spellName] == false) then
			addon.KnowProfession[spellName] = true
		end
	end

end

--[[

	Scanning functions

]]--

-- Scans your recipe book for Trade Skill Recipes

function addon:ScanTradeSkills()

	-- Clear the "Have Materials" check box
	if not Skillet and TradeSkillFrameAvailableFilterCheckButton:GetChecked() then
		TradeSkillFrameAvailableFilterCheckButton:SetChecked(false)
		TradeSkillOnlyShowMakeable(false)
	end

	-- Clear the sub-classes filters
	SetTradeSkillSubClassFilter(0, 1, 1)
	UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1)

	-- Clear the inventory slot filter
	SetTradeSkillInvSlotFilter(0, 1, 1);
	UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1)

	-- Expand all headers
	for i = GetNumTradeSkills(), 1, -1 do
		local _, tradeType = GetTradeSkillInfo(i)
		if tradeType == "header" then
			ExpandTradeSkillSubClass(i)
		end
	end

	-- Scan through all recipes
	for i = 1, GetNumTradeSkills() do
		local skillName, tradeType = GetTradeSkillInfo(i)
		-- Ignore all trade skill headers
		if (tradeType ~= "header") then
			self:CheckRecipe(skillName)
		end
	end

end

-- Scans the addon.RecipeListing adding all missing recipes to the addon.MissingRecipeListing

function addon:ScanMissingRecipes()

	-- Parse the recipe listing table, adding entries to the addon.MissingRecipeListing table
	if (addon.RecipeListing ~= nil) then
		local RecipeName = next(addon.RecipeListing, nil)
			while (RecipeName ~= nil) do
				-- If the recipe is not known then print out the info
				if (addon.RecipeListing[RecipeName]["Known"] == false) then
					addon.MissingRecipeListing[RecipeName] = {}
					addon.MissingRecipeListing[RecipeName]["Level"] = addon.RecipeListing[RecipeName]["Level"]
					addon.MissingRecipeListing[RecipeName]["Acquire"] = addon.RecipeListing[RecipeName]["Acquire"]
					addon.MissingRecipeListing[RecipeName]["Speciality"] = addon.RecipeListing[RecipeName]["Speciality"]
				end
				-- Move on to the next entry in the table
				RecipeName = next(addon.RecipeListing, RecipeName)
			end
	end
end

-- Scans your recipe book for Craft Skill Recipes (enchanting and beast training are handled differently than other trade skills)

function addon:ScanCraftSkills()

	-- Beast Training
	if CraftIsPetTraining() then
		for i = 1, GetNumCrafts() do
			local skillName, skillRank = GetCraftInfo(i)
			local FullSkillName = format("%s (%s)",skillName, skillRank)
			self:CheckRecipe(FullSkillName)
		end
	-- Enchanting and any other craft
	else
		-- Clear the "Have Materials" check box
		if not Skillet and CraftFrameAvailableFilterCheckButton:GetChecked() then
			CraftFrameAvailableFilterCheckButton:SetChecked(false)
			CraftOnlyShowMakeable(false)
		end

		-- Clear the inventory slots filter
		UIDropDownMenu_SetSelectedID(CraftFrameFilterDropDown, 1)
		SetCraftFilter(1)
		CraftFrame.selected = 1

		-- Scans crafting recipes in opened window, expanding all headers
		for i = GetNumCrafts(), 1, -1 do
			local _, _, craftType = GetCraftInfo(i)
			if craftType == "header" then
				ExpandCraftSkillLine(i)
			end
		end

		-- Scan through all recipes
		for i = 1, GetNumCrafts() do
			local skillName, _, craftType = GetCraftInfo(i)
			-- Ignore all trade skill headers
			if (craftType ~= "header") then
				self:CheckRecipe(skillName)
			end
		end
	end
end

-- Main logic for add-on, will call all sub-functions

function addon:AckisRecipeList_Command()

	local CurrentProfession, CurrentProfessionLevel, CurrentSpeciality, SortedRecipeIndex

	-- Initializes the vendor list
	if (addon.VendorList == nil) then
		addon.VendorList = {}
		self:InitVendor()
	end

	self:InitializeRecipeArray()

	if (addon.SkillType == nil) then

		self:Print(L["OpenTradeSkillWindow"])

	-- Trade type skills
	elseif (addon.SkillType == "Trade") then

		-- Get the name of the current trade skill opened, along with the current level of the skill.
		CurrentProfession, CurrentProfessionLevel = GetTradeSkillLine()
		CurrentSpeciality = self:GetTradeSpeciality(CurrentProfession)
		InitializeTradeRecipes(CurrentProfession)

		if (CurrentProfession == GetSpellInfo(2842)) then
			-- Player level = profession level for rogue poisons
			CurrentProfessionLevel = UnitLevel("player")
		end

		self:ScanTradeSkills()
		self:ScanMissingRecipes()

		local sorttype = addon.db.profile.sorting

		if (sorttype == "Skill") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingSkill)
		elseif (sorttype == "Name") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingName)
		elseif (sorttype == "Aquisition") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingAquisition)
		end

		if (addon.db.profile.usegui) then
			self:CreateFrame(CurrentProfession, CurrentProfessionLevel, SortedRecipeIndex, CurrentSpeciality)
		else
			self:InitiateScan(CurrentProfession, CurrentProfessionLevel, CurrentSpeciality)
			self:DisplayRecipeResults(CurrentProfessionLevel, SortedRecipeIndex, CurrentProfession, CurrentSpeciality)
		end

	-- Craft type skills
	elseif (addon.SkillType == "Craft") then

		-- Get the name of the current craft.
		CurrentProfession = GetCraftName()
		CurrentProfessionLevel = InitializeCraftRecipes(CurrentProfession)
		CurrentSpeciality = self:GetTradeSpeciality(CurrentProfession)
		self:ScanCraftSkills()
		self:ScanMissingRecipes()

		local sorttype = addon.db.profile.sorting

		if (sorttype == "Skill") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingSkill)
		elseif (sorttype == "Name") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingName)
		elseif (sorttype == "Aquisition") then
			SortedRecipeIndex = self:SortMissingRecipes(SortMissingAquisition)
		end
		if (addon.db.profile.usegui) then
			self:CreateFrame(CurrentProfession, CurrentProfessionLevel, SortedRecipeIndex, CurrentSpeciality)
		else
			self:InitiateScan(CurrentProfession, CurrentProfessionLevel, CurrentSpeciality)
			self:DisplayRecipeResults(CurrentProfessionLevel, SortedRecipeIndex, CurrentProfession, CurrentSpeciality)
		end

	end

end
