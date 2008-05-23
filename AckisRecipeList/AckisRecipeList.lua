--[[
****************************************************************************************
AckisRecipeList v0.84
$Date: 2008-05-21 19:23:56 -0400 (Wed, 21 May 2008) $
$Rev: 74721 $

Author: Ackis on Illidan US Horde
****************************************************************************************

Please see Wowace.com for more information.

****************************************************************************************
]]

--/dump GetMouseFocus()
local Crayon	= LibStub("LibCrayon-3.0")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local L			= LibStub("AceLocale-3.0"):GetLocale("AckisRecipeList")

AckisRecipeList = LibStub("AceAddon-3.0"):NewAddon("AckisRecipeList", "AceConsole-3.0", "AceEvent-3.0")

local addon = AckisRecipeList

-- Global variables
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

-- Frame variables
addon.ScanButton = nil
addon.Frame = nil

-- Constants which are used everytime the add-on is loaded
local addonversion = GetAddOnMetadata("AckisRecipeList", "Version")
local addonwiki = GetAddOnMetadata("AckisRecipeList", "X-Website")
local addoncredits = GetAddOnMetadata("AckisRecipeList", "X-Credits")
local addonwebsite = GetAddOnMetadata("AckisRecipeList", "X-Feedback")
local addonlocals = GetAddOnMetadata("AckisRecipeList", "X-Localizations")
addon.ARLTitle = "Ackis Recipe List v." .. addonversion
addon.br = "\n    - "
local nagrandfac = BFAC["Kurenai"] .. "\\" .. BFAC["The Mag'har"]
local hellfirefac = BFAC["Honor Hold"] .. "\\" .. BFAC["Thrallmar"]

-- Local variables
-- Make global API calls local to speed things up
local GetNumCrafts = GetNumCrafts
local GetSpellInfo = GetSpellInfo
local GetCraftInfo = GetCraftInfo
local GetTradeSkillInfo = GetTradeSkillInfo
local select = select

local playerFaction = UnitFactionGroup("player")

--[[

	Configuration Options

]]--

-- Returns configuration options for ARL
local function giveARLOptions()

	command_options = {
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
			author = 
			{
				order = 10,
				type = "description",
				name = L["Author"] .. "\n",
			},
			wiki = 
			{
				order = 15,
				type = "description",
				name = L["Wiki"] .. addonwiki .. "\n",
			},
			website = 
			{
				order = 20,
				type = "description",
				name = L["Website"] .. addonwebsite .. "\n",
			},
			locals = 
			{
				order = 25,
				type = "description",
				name = L["Locals"] .. addonlocals .. "\n",
			},
			credits = 
			{
				order = 30,
				type = "description",
				name = L["Credits"] .. addoncredits .. "\n",
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

		display =
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
					order	= 3,
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
	filter =
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
				order	= 3,
			},
			PVP =
			{
				name	= L["PVP"],
				desc	= L["PVP_TOGGLE"],
				type	= "toggle",
				get		= function() return addon.db.profile.pvp end,
				set		= function() addon.db.profile.pvp = not addon.db.profile.pvp end,
				order	= 4,
			},
			classes =
			{
				name      = L["Classes"],
				desc      = L["CLASS_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.classes end,
				set       = function() addon.db.profile.classes = not addon.db.profile.classes end,
				order     = 5,
			},
			specialities =
			{
				name      = L["Specialities"],
				desc      = L["SPECIALITY_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.specialities end,
				set       = function() addon.db.profile.specialities = not addon.db.profile.specialities end,
				order     = 6,
			},
			raid =
			{
				name      = L["Raid"],
				desc      = L["RAID_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.raid end,
				set       = function() addon.db.profile.raid = not addon.db.profile.raid end,
				order     = 7,
			},
			skill =
			{
				name      = L["Skill"],
				desc      = L["SKILL_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.skill end,
				set       = function() addon.db.profile.skill = not addon.db.profile.skill end,
				order     = 8,
			},
			seasonal =
			{
				name      = L["Seasonal"],
				desc      = L["SEASONAL_TOGGLE"],
				type      = "toggle",
				get       = function() return addon.db.profile.seasonal end,
				set       = function() addon.db.profile.seasonal = not addon.db.profile.seasonal end,
				order     = 9,
			},
			reputations =
			{
				type = "group",
				name = L["Reputation"],
				desc = L["REP_OPTIONS"],
				order = 50,
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
					Aldor =
					{
						name	= BFAC["The Aldor"],
						desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Aldor"]),
						type	= "toggle",
						get		= function() return addon.db.profile.aldor end,
						set		= function() addon.db.profile.aldor = not addon.db.profile.aldor end,
						order	= 3,
					},
					ArgentDawn =
					{
						name	= BFAC["Argent Dawn"],
						desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Argent Dawn"]),
						type	= "toggle",
						get		= function() return addon.db.profile.argentdawn end,
						set		= function() addon.db.profile.argentdawn = not addon.db.profile.argentdawn end,
						order	= 5,
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
					CenarionCircle =
					{
						name	= BFAC["Cenarion Circle"],
						desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["Cenarion Circle"]),
						type	= "toggle",
						get		= function() return addon.db.profile.cenarioncircle end,
						set		= function() addon.db.profile.cenarioncircle = not addon.db.profile.cenarioncircle end,
						order	= 15,
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
					Violeteye =
					{
						name	= BFAC["The Violet Eye"],
						desc	= format(L["SPECIFIC_REP_TOGGLE"],BFAC["The Violet Eye"]),
						type	= "toggle",
						get		= function() return addon.db.profile.violeteye end,
						set		= function() addon.db.profile.violeteye = not addon.db.profile.violeteye end,
						order	= 85,
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
				}
			},
		}
	}

	return filter
end

-- Returns configuraion options for sorintg
local function giveSorting()
	sorting =
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

	self.db = LibStub("AceDB-3.0"):New("AckisRecipeListDB",defaults,"Default")

	-- Create the options with Ace3
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Ackis Recipe List",giveARLOptions,"Ackis Recipe List")
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Display",giveDisplay)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Sorting",giveSorting)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Filter",giveFilter)
	AceConfigReg:RegisterOptionsTable("Ackis Recipe List Profile",giveProfiles)

	-- Add the options to blizzard frame (add them backwards so they show up in the proper order
	self.optionsFrame = AceConfigDialog:AddToBlizOptions("Ackis Recipe List","Ackis Recipe List")
	self.optionsFrame[L["Profile"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Profile", L["Profile"], "Ackis Recipe List")
	self.optionsFrame[L["Sort"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Sorting", L["Sort"], "Ackis Recipe List")
	self.optionsFrame[L["Filter"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Filter", L["Filter"], "Ackis Recipe List")
	self.optionsFrame[L["Display"]] = AceConfigDialog:AddToBlizOptions("Ackis Recipe List Display", L["Display"], "Ackis Recipe List")


	-- Register slash commands
	self:RegisterChatCommand("arl", "ChatCommand")

	-- Set default options, which are to include everything in the scan
	self.db:RegisterDefaults(
		{ profile =
			{
			-- Filter Options
		    faction = true,
			classes = false,
			pvp = true,
			specialities = false,
			raid = true,
			skill = true,
			seasonal = true,

			-- Sorting Options
			sorting = "Skill",

			-- Display Options
			usegui = true,
			includefiltered = false,
			closeguionskillclose = false,
			testgui = false,

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
			}
		}
	)

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

	addon.SkillType = "Trade"
	addon.ResetOkayBlizz = false
	if (not Skillet) then
		self:ShowScanButton()
	end

end

-- Clean up tables from memory when trade skill window is closed

function addon:TRADE_SKILL_CLOSE()

	addon.ResetOkayBlizz = true
	if (addon.ResetOkayBlizz and addon.ResetOkayARL) then
		self:ResetVariables()
	end
	if (addon.db.profile.closeguionskillclose) then
		if (addon.Frame) then
			self:CloseWindow()
		end
	end
	if (not Skillet) then
		addon.ScanButton:Hide()
	end

end

-- Watch for the craft skill window to be shown, add all specific trade skills to an array, then scan the craft skill window for all recipes.

function addon:CRAFT_SHOW()

	addon.SkillType = "Craft"
	addon.ResetOkayBlizz = false
	if (not Skillet or CraftIsPetTraining()) then
		self:ShowScanButton()
	end

end

-- Clean up tables from memory when craft window is closed

function addon:CRAFT_CLOSE()

	addon.ResetOkayBlizz = true
	if (addon.ResetOkayBlizz and addon.ResetOkayARL) then
		self:ResetVariables()
	end
	if (addon.db.profile.closeguionskillclose) then
		if (addon.Frame) then
			self:CloseWindow()
		end
	end
	if (not Skillet) then
		addon.ScanButton:Hide()
	end

end

-- Slash command handler

function addon:ChatCommand(input)
	if (not input) or (input:trim() == "") then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame)
	elseif (input == string.lower(L["Sort"])) then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Sort"]])
	elseif (input == string.lower(L["Filter"])) then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Filter"]])
	elseif (input == string.lower(L["Display"])) then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Display"]])
	elseif (input == string.lower(L["Profile"])) then
		InterfaceOptionsFrame_OpenToFrame(self.optionsFrame[L["Profile"]])
	else
		LibStub("AceConfigCmd-3.0"):HandleCommand("arl", "AckisRecipeList", input)
	end
end


--[[

	Tradeskill functions

]]--

-- Adds a specifc recipe to the recipe list array.  Also provides information regarding recipe level, if there is any trade skill recipe speciality, how to aquire the recipe, and if the recipe is known or not.

function addon:addTradeSkill(RecipeName, RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)

	-- Creates a table in the addon.RecipeListing table storing all information about a recipe
	addon.RecipeListing[RecipeName] = {}
	addon.RecipeListing[RecipeName]["Level"] = RecipeLevel
	addon.RecipeListing[RecipeName]["Acquire"] = RecipeAquire

	if (RecipeSpeciality == nil) then
		addon.RecipeListing[RecipeName]["Speciality"] = {}
	else
		addon.RecipeListing[RecipeName]["Speciality"] = RecipeSpeciality
	end

	if (VendorInfo == nil) then
		addon.RecipeListing[RecipeName]["VendorInfo"] = {}
	else
		addon.RecipeListing[RecipeName]["VendorInfo"] = VendorInfo
	end

	if (RecipeKnown == nil) then
		addon.RecipeListing[RecipeName]["Known"] = false
	else
		addon.RecipeListing[RecipeName]["Known"] = RecipeKnown
	end

	-- Increment the total number of recipes added to the list
	addon.NumberOfRecipes = addon.NumberOfRecipes + 1

end

-- Same as previous function but uses spell ID to get recipe name

function addon:addTradeSkillSpell(RecipeName, RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)

	if (GetSpellInfo(RecipeName) ~= nil) then
		self:addTradeSkill(GetSpellInfo(RecipeName), RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)
	else
		self:addTradeSkill(tostring(RecipeName), RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)
		self:Print("Spell ID: " .. RecipeName .. " is not in your local cache.")
	end

end

-- Same as previous but combines spell rank for beast training

function addon:addTradeSkillBeast(RecipeName, RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)

	-- Variables named after friends on an old server because they both really wanted to be in my mod :P
	local Jimo,Megadopolous = GetSpellInfo(RecipeName)

	if (Jimo ~= nil) then
		local TempHunterSkill = Jimo .. " (" .. Megadopolous .. ")"
		self:addTradeSkill(TempHunterSkill, RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)
	else
		self:addTradeSkill(tostring(RecipeName), RecipeLevel, RecipeAquire, RecipeSpeciality, VendorInfo, RecipeKnown)
		self:Print("Spell ID: " .. RecipeName .. " is not in your local cache.")
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

-- Internal function to determine if a specific faction is to be displayed or not

local function CheckDisplayFaction(CurrentCheck)

	-- Create the rep table in the function so that if there's an update we have accurate information
	local RepTable = {
		[BFAC["The Scryers"]] = addon.db.profile.scryer,
		[BFAC["The Aldor"]] = addon.db.profile.aldor,
		[BFAC["Argent Dawn"]] = addon.db.profile.argentdawn,
		[BFAC["Ashtongue Deathsworn"]] = addon.db.profile.ashtonguedeathsworn,
		[BFAC["Cenarion Circle"]] = addon.db.profile.cenarioncircle,
		[BFAC["Cenarion Expedition"]] = addon.db.profile.cenarionexpidition,
		[BFAC["The Consortium"]] = addon.db.profile.consortium,
		[BFAC["Honor Hold"]] = addon.db.profile.hellfirefac,
		[BFAC["Thrallmar"]] = addon.db.profile.hellfirefac,
		[BFAC["Keepers of Time"]] = addon.db.profile.kot,
		[BFAC["Kurenai"]] = addon.db.profile.nagrandfac,
		[BFAC["The Mag'har"]] = addon.db.profile.nagrandfac,
		[BFAC["Lower City"]] = addon.db.profile.lowercity,
		[BFAC["The Scale of the Sands"]] = addon.db.profile.scaleofsands,
		[BFAC["The Sha'tar"]] = addon.db.profile.shatar,
		[BFAC["Shattered Sun Offensive"]] = addon.db.profile.sso,
		[BFAC["Sporeggar"]] = addon.db.profile.sporeggar,
		[BFAC["Thorium Brotherhood"]] = addon.db.profile.thoriumbrotherhood,
		[BFAC["Timbermaw Hold"]] = addon.db.profile.timbermaw,
		[BFAC["The Violet Eye"]] = addon.db.profile.violeteye,
		[BFAC["Zandalar Tribe"]] = addon.db.profile.zandalar,
	}

	return RepTable[CurrentCheck]

end

-- Check to see if recipe should be displayed or not

function addon:CheckDisplayRecipe(RecipeName, CurrentProfessionLevel, CurrentProfession, CurrentSpeciality)

	-- Display all skill levels
	if (addon.MissingRecipeListing[RecipeName]["Level"] > CurrentProfessionLevel) then

		if (not addon.db.profile.skill) then

			addon.FilteredRecipes = addon.FilteredRecipes + 1
			return false

		end

	end

	local classcheck = false
	local classoccur = false
	local displaycheck = true

	if (addon.MissingRecipeListing[RecipeName]["Speciality"] ~= nil) then

		for i, CurrentCheck in pairs(addon.MissingRecipeListing[RecipeName]["Speciality"]) do

			-- Display hard to obtain raid recipes
			if (not addon.db.profile.raid) then
				if (CurrentCheck == L["Raid"]) then
					displaycheck = false
				end
			end

			-- Display hard to obtain raid recipes
			if (not addon.db.profile.seasonal) then
				if (CurrentCheck == L["Seasonal"]) then
					displaycheck = false
				end
			end

			-- Display skillups you haven't obtained
			--if (CurrentCheck == L["Journeyman"]) and () then
				--
			--end

			-- Display all faction recipes
			if (not addon.db.profile.faction) then
				-- Make sure the check is Horde or Alliance
				if (CurrentCheck == BFAC["Horde"]) or (CurrentCheck == BFAC["Alliance"]) then
					-- If the current check isn't the same as the player faction, don't display it
					if (CurrentCheck ~= playerFaction) then
						displaycheck = false
					end
				end
			end

			-- NEED TO FIX LOGIC HERE
			-- Display all class type recipes
			if (not addon.db.profile.classes) then
				local _, playerClass = UnitClass("player")
				-- Make sure it's a class
				if (CurrentCheck == "WARLOCK") or
				(CurrentCheck == "WARRIOR") or
				(CurrentCheck == "HUNTER") or
				(CurrentCheck == "MAGE") or
				(CurrentCheck == "PRIEST") or
				(CurrentCheck == "DRUID") or
				(CurrentCheck == "PALADIN") or
				(CurrentCheck == "SHAMAN") or
				(CurrentCheck == "ROGUE") then
				-- Set that a class check has occured in the case of multiple classes.
				classoccur = true
					if (CurrentCheck == playerClass) then
						classcheck = true
					end
				end

			end

			-- Reputation check
			local ReputationCheck = CheckDisplayFaction(CurrentCheck)
			if (ReputationCheck ~= nil) then
				displaycheck = ReputationCheck
			end

			-- Display all specialities (ie: Primal Mooncloth, Spellcloth, etc.)
			if (not addon.db.profile.specialities) then

				-- Blacksmithing
				if (CurrentProfession == GetSpellInfo(2018)) then

					if (CurrentCheck == GetSpellInfo(9788)) or -- Armorsmith
						(CurrentCheck == GetSpellInfo(17041)) or -- Master Axesmith
						(CurrentCheck == GetSpellInfo(17040)) or -- Master Hammersmith
						(CurrentCheck == GetSpellInfo(17039)) or -- Master Swordsmith
						(CurrentCheck == GetSpellInfo(9787)) then -- Weaponsmith

							if (CurrentCheck ~= CurrentSpeciality) then

								displaycheck = false

							end

					end

				-- Engineering
				elseif (CurrentProfession == GetSpellInfo(4036)) then

					if (CurrentCheck == GetSpellInfo(20219)) or -- Gnomish Engineering
						(CurrentCheck == GetSpellInfo(20222)) then -- Goblin Engineering

							if (CurrentCheck ~= CurrentSpeciality) then

								displaycheck = false

							end

					end

				-- Leatherworking
				elseif (CurrentProfession == GetSpellInfo(2108)) then

					if (CurrentCheck == GetSpellInfo(10657)) or -- Dragonscale
						(CurrentCheck == GetSpellInfo(10659)) or -- Elemental
						(CurrentCheck == GetSpellInfo(10661)) then -- Tribal

							if (CurrentCheck ~= CurrentSpeciality) then

								displaycheck = false

							end

					end

				-- Tailoring
				elseif (CurrentProfession == GetSpellInfo(3908)) then

					if (CurrentCheck == GetSpellInfo(26797)) or -- Spellfire
						(CurrentCheck == GetSpellInfo(26801)) or -- Shadoweave
						(CurrentCheck == GetSpellInfo(26798)) then -- Primal Mooncloth

							if (CurrentCheck ~= CurrentSpeciality) then

								displaycheck = false

							end

					end

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

	for index=1,25,1 do

		local spellName = GetSpellName(index, BOOKTYPE_SPELL)

		-- Nothing found
		if (not spellName) or (index == 25) then
			return ""
		end

		-- Alchemy
		if (CurrentProfession == GetSpellInfo(2259)) then
			if (spellName == GetSpellInfo(28674)) or (spellName == GetSpellInfo(28678)) or (spellName == GetSpellInfo(28676)) then
				return spellName
			end
		-- Blacksmithing
		elseif (CurrentProfession == GetSpellInfo(2018)) then
			if (spellName == GetSpellInfo(9787)) or	(spellName == GetSpellInfo(9788)) or (spellName == GetSpellInfo(17039)) or (spellName == GetSpellInfo(17040)) or (spellName == GetSpellInfo(17041)) then
				return spellName
			end
		-- Engineering
		elseif (CurrentProfession == GetSpellInfo(4036)) then
			if (spellName == GetSpellInfo(20219)) or (spellName == GetSpellInfo(20222)) then
				return spellName
			end
		-- Leatherworking
		elseif (CurrentProfession == GetSpellInfo(2108)) then
			if (spellName == GetSpellInfo(10657)) or (spellName == GetSpellInfo(10659)) or (spellName == GetSpellInfo(10661)) then
				return spellName
			end
		-- Tailoring
		elseif (CurrentProfession == GetSpellInfo(3980)) then
			if (spellName == GetSpellInfo(26797)) or (spellName == GetSpellInfo(26798)) or (spellName == GetSpellInfo(26801)) then
				return spellName
			end
		end

	end

end

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

		-- Reset the table
		for k in pairs(t) do t[k] = nil end

		local numvars = select('#',...)

		-- Parse through the list
		for i=1,numvars,3 do
			local QuestName, QuestFaction, QuestLoc = select(i,...)
			if (QuestFaction == BFAC["Alliance"]) then
				if (AckisRecipeList.db.profile.faction or playerFaction == BFAC["Alliance"]) then
					if (i+2 == numvars) then
						table.insert(t,Crayon:Cyan(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
					else
						table.insert(t,Crayon:Cyan(format("%s%s (%s)%s",L["QuestReward"],QuestName,QuestLoc,addon.br)))
					end
				end
			elseif (QuestFaction == BFAC["Horde"]) then
				if (AckisRecipeList.db.profile.faction or playerFaction == BFAC["Horde"]) then
					if (i+2 == numvars) then
						table.insert(t,Crayon:Red(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
					else
						table.insert(t,Crayon:Red(format("%s%s (%s)%s",L["QuestReward"],QuestName,QuestLoc,addon.br)))
					end
				end
			elseif (QuestFaction == BFAC["Neutral"]) then
				if (i+2 == numvars) then
					table.insert(t,Crayon:Gold(format("%s%s (%s)",L["QuestReward"],QuestName,QuestLoc)))
				else
					table.insert(t,Crayon:Gold(format("%s%s (%s)%s",L["QuestReward"],QuestName,QuestLoc,addon.br)))
				end
			end
		end

		return table.concat(t)

	end

	-- Combines all pet information into a single string for output

	function addon:CombinePets(...)
		-- Reset the table
		for k in pairs(t) do t[k] = nil end

		local numvars = select('#',...)

		for i=1,numvars,1 do
	        local CurrentCheck = select(i, ...)
			if (i == numvars) then
				-- Rare mob
				if (addon.PetList[CurrentCheck]["Rare"]) then
					-- Rare elite
					if (addon.PetList[CurrentCheck]["Elite"]) then
						table.insert(t,format("%s %s %s (%s - %s): %s", L["Rare"],L["Elite"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"]))
					else
						table.insert(t,format("%s %s (%s - %s): %s", L["Rare"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"]))
					end
				-- Elite mob
				elseif (addon.PetList[CurrentCheck]["Elite"]) then
					table.insert(t,format("%s %s (%s - %s): %s", L["Elite"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"]))
				end
			else
				-- Rare mob
				if (addon.PetList[CurrentCheck]["Rare"]) then
					-- Rare elite
					if (addon.PetList[CurrentCheck]["Elite"]) then
						table.insert(t,format("%s %s %s (%s - %s): %s%s", L["Rare"],L["Elite"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"], addon.br))
					else
						table.insert(t,format("%s %s (%s - %s): %s%s", L["Rare"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"], addon.br))
					end
				-- Elite mob
				elseif (addon.PetList[CurrentCheck]["Elite"]) then
					table.insert(t,format("%s %s (%s - %s): %s%s", L["Elite"],addon.PetList[CurrentCheck]["Name"], addon.PetList[CurrentCheck]["MinLvl"], addon.PetList[CurrentCheck]["MaxLvl"], addon.PetList[CurrentCheck]["Location"], addon.br))
				end
			end
		end

		return table.concat(t)

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
				if (AckisRecipeList.db.profile.faction or playerFaction == BFAC["Alliance"]) then
					table.insert(t,Crayon:Cyan(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
				end
			elseif (addon.VendorList[CurrentCheck]["Faction"] == BFAC["Horde"]) then
				if (AckisRecipeList.db.profile.faction or playerFaction == BFAC["Horde"]) then
					table.insert(t,Crayon:Red(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
				end
			elseif (addon.VendorList[CurrentCheck]["Faction"] == BFAC["Neutral"]) then
				table.insert(t,Crayon:Gold(format("%s - %s: %s", addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"])))
			else
				table.insert(t,format("%s - %s: %s",  addon.VendorList[CurrentCheck]["Name"], addon.VendorList[CurrentCheck]["Location"], addon.VendorList[CurrentCheck]["Coords"]))
			end
		end

		return table.concat(t, addon.br)

	end

end

-- Combines repuation level and faction name into a single string.

function addon:AddSingleReputation(RepLevel, Faction)
	if (RepLevel == BFAC["Friendly"]) then
		return format("%s: %s - %s",L["Reputation"],Faction,Crayon:White(RepLevel))
	elseif (RepLevel == BFAC["Honored"]) then
		return format("%s: %s - %s",L["Reputation"],Faction,Crayon:Green(RepLevel))
	elseif (RepLevel == BFAC["Revered"]) then
		return format("%s: %s - %s",L["Reputation"],Faction,Crayon:Blue(RepLevel))
	elseif (RepLevel == BFAC["Exalted"]) then
		return format("%s: %s - %s",L["Reputation"],Faction,Crayon:Purple(RepLevel))
	else
		return format("%s: %s - %s",L["Reputation"],Faction,RepLevel)
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

	-- Table of all possible professions
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
		self:Print(L["UnknownTradeSkill"]:format(CurrentProfession))

	end

	return CurrentProfessionLevel

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

		if (AckisRecipeList.db.profile.usegui) then
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
		if (AckisRecipeList.db.profile.usegui) then
			self:CreateFrame(CurrentProfession, CurrentProfessionLevel, SortedRecipeIndex, CurrentSpeciality)
		else
			self:InitiateScan(CurrentProfession, CurrentProfessionLevel, CurrentSpeciality)
			self:DisplayRecipeResults(CurrentProfessionLevel, SortedRecipeIndex, CurrentProfession, CurrentSpeciality)
		end

	end

end

