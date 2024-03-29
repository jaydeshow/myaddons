--[[

ARL-Enchant.lua

Enchanting data for all of AckisRecipeList

$Date: 2008-08-25 14:36:26 +0000 (Mon, 25 Aug 2008) $
$Rev: 824 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BBOSS		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitEnchanting()

	-- Trainer Recipes
	self:addTradeSkillSpell(7418, 1, L["Trainer"], 1)
	self:addTradeSkillSpell(7428, 1, L["Trainer"], 1)
	self:addTradeSkillSpell(7421, 1, L["Trainer"], 1)
	self:addTradeSkillSpell(7420, 15, L["Trainer"], 1)
	self:addTradeSkillSpell(14293, 15, L["Trainer"], 1)
	self:addTradeSkillSpell(7426, 40, L["Trainer"], 1)
	self:addTradeSkillSpell(7454, 45, L["Trainer"], 1)
	self:addTradeSkillSpell(7457, 50, L["Trainer"], 1)
	self:addTradeSkillSpell(7748, 60, L["Trainer"], 1)
	self:addTradeSkillSpell(7771, 70, L["Trainer"], 1)
	self:addTradeSkillSpell(14807, 70, L["Trainer"], 1)
	self:addTradeSkillSpell(7779, 80, L["Trainer"], 1)
	self:addTradeSkillSpell(7788, 90, L["Trainer"], 1)
	self:addTradeSkillSpell(7745, 100, L["Trainer"], 1)
	self:addTradeSkillSpell(7795, 100, L["Trainer"], 1)
	self:addTradeSkillSpell(13378, 105, L["Trainer"], 1)
	self:addTradeSkillSpell(13421, 115, L["Trainer"], 1)
	self:addTradeSkillSpell(7857, 120, L["Trainer"], 1)
	self:addTradeSkillSpell(7861, 125, L["Trainer"], 1)
	self:addTradeSkillSpell(7863, 125, L["Trainer"], 1)
	self:addTradeSkillSpell(13501, 130, L["Trainer"], 1)
	self:addTradeSkillSpell(13485, 130, L["Trainer"], 1)
	self:addTradeSkillSpell(13503, 140, L["Trainer"], 1)
	self:addTradeSkillSpell(13538, 140, L["Trainer"], 1)
	self:addTradeSkillSpell(13529, 145, L["Trainer"], 1)
	self:addTradeSkillSpell(13607, 145, L["Trainer"], 1)
	self:addTradeSkillSpell(13626, 150, L["Trainer"], 1)
	self:addTradeSkillSpell(13628, 150, L["Trainer"], 1)
	self:addTradeSkillSpell(14809, 155, L["Trainer"], 1)
	self:addTradeSkillSpell(13622, 150, L["Trainer"], 1)
	self:addTradeSkillSpell(13631, 155, L["Trainer"], 1)
	self:addTradeSkillSpell(13635, 155, L["Trainer"], 1)
	self:addTradeSkillSpell(13637, 160, L["Trainer"], 1)
	self:addTradeSkillSpell(13640, 160, L["Trainer"], 1)
	self:addTradeSkillSpell(13642, 165, L["Trainer"], 1)
	self:addTradeSkillSpell(13644, 170, L["Trainer"], 1)
	self:addTradeSkillSpell(13648, 170, L["Trainer"], 1)
	self:addTradeSkillSpell(13657, 175, L["Trainer"], 1)
	self:addTradeSkillSpell(14810, 175, L["Trainer"], 1)
	self:addTradeSkillSpell(13659, 180, L["Trainer"], 1)
	self:addTradeSkillSpell(13661, 180, L["Trainer"], 1)
	self:addTradeSkillSpell(13663, 185, L["Trainer"], 1)
	self:addTradeSkillSpell(13693, 195, L["Trainer"], 1)
	self:addTradeSkillSpell(13695, 200, L["Trainer"], 1)
	self:addTradeSkillSpell(13700, 200, L["Trainer"], 1)
	self:addTradeSkillSpell(13702, 200, L["Trainer"], 1)
	self:addTradeSkillSpell(13746, 205, L["Trainer"], 1)
	self:addTradeSkillSpell(13794, 205, L["Trainer"], 1)
	self:addTradeSkillSpell(13822, 210, L["Trainer"], 1)
	self:addTradeSkillSpell(13815, 210, L["Trainer"], 1)
	self:addTradeSkillSpell(13836, 215, L["Trainer"], 1)
	self:addTradeSkillSpell(13858, 220, L["Trainer"], 1)
	self:addTradeSkillSpell(13887, 225, L["Trainer"], 1)
	self:addTradeSkillSpell(13890, 225, L["Trainer"], 1)
	self:addTradeSkillSpell(13905, 230, L["Trainer"], 1)
	self:addTradeSkillSpell(13917, 230, L["Trainer"], 1)
	self:addTradeSkillSpell(13935, 235, L["Trainer"], 1)
	self:addTradeSkillSpell(13937, 240, L["Trainer"], 1)
	self:addTradeSkillSpell(13939, 240, L["Trainer"], 1)
	self:addTradeSkillSpell(13941, 245, L["Trainer"], 1)
	self:addTradeSkillSpell(13943, 245, L["Trainer"], 1)
	self:addTradeSkillSpell(13948, 250, L["Trainer"], 1)
	self:addTradeSkillSpell(17181, 250, L["Trainer"], 1)
	self:addTradeSkillSpell(17180, 250, L["Trainer"], 1)
	self:addTradeSkillSpell(20008, 255, L["Trainer"], 1)
	self:addTradeSkillSpell(20014, 265, L["Trainer"], 1)
	self:addTradeSkillSpell(20012, 270, L["Trainer"], 1)
	self:addTradeSkillSpell(20016, 280, L["Trainer"], 1)
	self:addTradeSkillSpell(20028, 290, L["Trainer"], 1)
	self:addTradeSkillSpell(20013, 295, L["Trainer"], 1)
	self:addTradeSkillSpell(20023, 295, L["Trainer"], 1)
	self:addTradeSkillSpell(32664, 300, L["Trainer"], 1)
	self:addTradeSkillSpell(33991, 300, L["Trainer"], 1)
	self:addTradeSkillSpell(34002, 300, L["Trainer"], 1)
	self:addTradeSkillSpell(33993, 305, L["Trainer"], 1)
	self:addTradeSkillSpell(27899, 305, L["Trainer"], 1)
	self:addTradeSkillSpell(34001, 305, L["Trainer"], 1)
	self:addTradeSkillSpell(33996, 310, L["Trainer"], 1)
	self:addTradeSkillSpell(27944, 310, L["Trainer"], 1)
	self:addTradeSkillSpell(34004, 310, L["Trainer"], 1)
	self:addTradeSkillSpell(27961, 310, L["Trainer"], 1)
	self:addTradeSkillSpell(27905, 315, L["Trainer"], 1)
	self:addTradeSkillSpell(27957, 315, L["Trainer"], 1)
	self:addTradeSkillSpell(44383, 330, L["Trainer"], 1)
	self:addTradeSkillSpell(33990, 320, L["Trainer"], 1)
	self:addTradeSkillSpell(28027, 325, L["Trainer"], 1)
	self:addTradeSkillSpell(42615, 335, L["Trainer"], 1)
	self:addTradeSkillSpell(33995, 340, L["Trainer"], 1)
	self:addTradeSkillSpell(28028, 350, L["Trainer"], 1)
	self:addTradeSkillSpell(42613, 350, L["Trainer"], 1)
	
	-- Vendor Recipes
	self:addTradeSkillSpell(7443, 20, self:CombineVendors(32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 48, false),2)
	self:addTradeSkillSpell(25124, 45, self:CombineVendors(32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 48, false),2)
	self:addTradeSkillSpell(7776, 80, self:CombineVendors(40, 42, false), BFAC["Horde"],2)
	self:addTradeSkillSpell(7793, 100, self:CombineVendors(40, 41, 45, 47, false),2)
	self:addTradeSkillSpell(13419, 110, self:CombineVendors(195, 196, false),2)
	self:addTradeSkillSpell(7867, 125, self:CombineVendors(45, 19, false),2)
	self:addTradeSkillSpell(13536, 140, self:CombineVendors(195, 196, false),2)
	self:addTradeSkillSpell(20015, 285, self:CombineVendors(56, false),2)
	self:addTradeSkillSpell(25125, 150, self:CombineVendors(32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 48, false),2)
	self:addTradeSkillSpell(13646, 170, self:CombineVendors(113, 29, false),2)
	self:addTradeSkillSpell(25126, 200, self:CombineVendors(32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 48, false),2)
	self:addTradeSkillSpell(13931, 235, self:CombineVendors(197, 193, false),2)
	self:addTradeSkillSpell(25127, 250, self:CombineVendors(39, false),2)
	self:addTradeSkillSpell(20017, 265, self:CombineVendors(191, 193, false),2)
	self:addTradeSkillSpell(20026, 275, self:CombineVendors(53, false),2)
	self:addTradeSkillSpell(25128, 275, self:CombineVendors(39, false),2)
	self:addTradeSkillSpell(20051, 290, self:CombineVendors(56, false),2)
	self:addTradeSkillSpell(28016, 310, self:CombineVendors(34, 43, 44, false),2)
	self:addTradeSkillSpell(27945, 325, self:CombineVendors(204, false),2)
	self:addTradeSkillSpell(34009, 325, self:CombineVendors(44, false),2)
	self:addTradeSkillSpell(28022, 335, self:CombineVendors(34, 43, 44, false),2)
	self:addTradeSkillSpell(28019, 340, self:CombineVendors(34, 43, 44, false),2)
	self:addTradeSkillSpell(32665, 350, self:CombineVendors(198, 199, false),2)
	self:addTradeSkillSpell(32667, 375, self:CombineVendors(44, false),2)

	-- World Drops
	self:addTradeSkillSpell(7766, 60, L["UWD"],3)
	self:addTradeSkillSpell(7782, 80, L["UWD"],3)
	self:addTradeSkillSpell(7786, 90, L["UWD"],3)
	self:addTradeSkillSpell(13380, 110, L["UWD"],3)
	self:addTradeSkillSpell(13464, 115, L["UWD"],3)
	self:addTradeSkillSpell(7859, 120, L["UWD"],3)
	self:addTradeSkillSpell(13522, 135, L["UWD"],3)
	self:addTradeSkillSpell(13653, 175, L["UWD"],3)
	self:addTradeSkillSpell(13655, 175, L["UWD"],3)
	self:addTradeSkillSpell(13687, 190, L["UWD"],3)
	self:addTradeSkillSpell(13689, 195, L["UWD"],3)
	self:addTradeSkillSpell(13817, 210, L["UWD"],3)
	self:addTradeSkillSpell(13846, 220, L["UWD"],3)
	self:addTradeSkillSpell(13915, 230, L["UWD"],3)
	self:addTradeSkillSpell(13933, 235, L["UWD"],3)
	self:addTradeSkillSpell(13945, 245, L["UWD"],3)
	self:addTradeSkillSpell(13947, 250, L["UWD"],3)
	self:addTradeSkillSpell(20020, 255, L["UWD"],3)
	self:addTradeSkillSpell(20009, 270, L["UWD"],3)
	self:addTradeSkillSpell(20024, 275, L["UWD"],3)
	self:addTradeSkillSpell(20011, 300, L["UWD"],3)
	self:addTradeSkillSpell(20025, 300, L["UWD"],3)
	self:addTradeSkillSpell(27948, 305, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(27962, 330, L["UWD"],3)
	self:addTradeSkillSpell(27913, 335, L["UWD"],3)
	self:addTradeSkillSpell(27946, 340, L["UWD"],3)
	self:addTradeSkillSpell(33992, 345, L["UWD"],3)
	self:addTradeSkillSpell(27972, 350, L["UWD"],3)
	self:addTradeSkillSpell(27947, 360, L["UWD"],3)
	self:addTradeSkillSpell(28003, 360, L["UWD"],3)
	self:addTradeSkillSpell(28004, 360, L["UWD"],3)
	self:addTradeSkillSpell(34007, 360, L["RWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(34008, 360, L["RWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)

	-- Specific Drops
	self:addTradeSkillSpell(13612, 145, self:CombineMobs(true,L["Enchant Gloves - Mining Obt"],BZONE["Wetlands"]),3)
	self:addTradeSkillSpell(13617, 145, self:CombineMobs(true,L["Enchant Gloves - Herbalism Obt"],BZONE["Ashenvale"]) .. addon.br .. self:CombineMobs(true,L["Enchant Gloves - Herbalism Obt1"],BZONE["Stonetalon Mountains"]),3)
	self:addTradeSkillSpell(13620, 145, self:CombineMobs(true,L["Enchant Gloves - Fishing Obt"],BZONE["Hillsbrad Foothills"]),3)
	self:addTradeSkillSpell(13698, 200, self:CombineMobs(true,L["Enchant Gloves - Skinning Obt"],BZONE["Arathi Highlands"]),3)
	self:addTradeSkillSpell(13841, 215, self:CombineMobs(true,L["Enchant Gloves - Advanced Mining Obt"],BZONE["Stranglethorn Vale"]),3)
	self:addTradeSkillSpell(13868, 225, self:CombineMobs(true,L["Enchant Gloves - Advanced Herbalism Obt"],BZONE["Swamp of Sorrows"]),3)
	self:addTradeSkillSpell(13882, 225, self:CombineMobs(true,L["Enchant Cloak - Lesser Agility Obt"],BZONE["Alterac Mountains"]) .. addon.br .. self:CombineMobs(true,L["Enchant Cloak - Lesser Agility Obt1"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(13898, 265, self:CombineMobs(true,L["Enchant Weapon - Fiery Weapon Obt"],BZONE["Blackrock Depths"]),3,5)
	self:addTradeSkillSpell(15596, 265, self:CombineMobs(true,L["Smoking Heart of the Mountain Obt"],BZONE["Blackrock Depths"]),3,5)
	self:addTradeSkillSpell(20029, 285, self:CombineMobs(true,L["Enchant Weapon - Icy Chill Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(20010, 295, self:CombineMobs(true,L["Enchant Bracer - Superior Strength Obt"],BZONE["Deadwind Pass"]),3)
	self:addTradeSkillSpell(20030, 295, self:CombineMobs(true,L["Enchant 2H Weapon - Superior Impact Obt"],BZONE["Upper Blackrock Spire"]),3,5)
	self:addTradeSkillSpell(20033, 295, self:CombineMobs(true,L["Enchant Weapon - Unholy Weapon Obt"],BZONE["Stratholme"]),3,5)
	self:addTradeSkillSpell(20036, 300, self:CombineMobs(true,L["Enchant 2H Weapon - Major Intellect Obt"],BZONE["Stratholme"]),3,5)
	self:addTradeSkillSpell(20031, 300, self:CombineMobs(true,L["Enchant Weapon - Superior Striking Obt"],BZONE["Lower Blackrock Spire"]),3,5)
	self:addTradeSkillSpell(20034, 300, self:CombineMobs(true,L["Enchant Weapon - Crusader Obt"],BZONE["Western Plaguelands"]) .. addon.br ..  self:CombineMobs(true,L["Enchant Weapon - Crusader Obt1"],BZONE["Eastern Plaguelands"]),3)
	self:addTradeSkillSpell(20032, 300, self:CombineMobs(true,L["Enchant Weapon - Lifestealing Obt"],BZONE["Scholomance"]),3,5)
	self:addTradeSkillSpell(20035, 300, self:CombineMobs(true,L["Enchant 2H Weapon - Major Spirit Obt"],BZONE["Scholomance"]),3,5)
	self:addTradeSkillSpell(27906, 320, self:CombineMobs(false,L["Enchant Bracer - Major Defense Obt"],BZONE["Netherstorm"]),4)
	self:addTradeSkillSpell(27950, 320, self:CombineMobs(false,L["Enchant Boots - Fortitude Obt"],BZONE["Mana-Tombs"]),4,5)
	self:addTradeSkillSpell(27951, 340, self:CombineMobs(false,L["Enchant Boots - Dexterity Obt"],BZONE["Auchenai Crypts"]),4,5)
	self:addTradeSkillSpell(27968, 340, self:CombineMobs(false,L["Enchant Weapon - Major Intellect Obt"],BZONE["Netherstorm"]),4)
	self:addTradeSkillSpell(27914, 350, self:CombineMobs(false,L["Enchant Bracer - Fortitude Obt"],BZONE["The Steamvault"]),4,5)
	self:addTradeSkillSpell(27971, 350, self:CombineMobs(false,L["Enchant 2H Weapon - Savagery Obt"],BZONE["The Shattered Halls"]),4,5)
	self:addTradeSkillSpell(27975, 350, self:CombineMobs(false,L["Enchant Weapon - Major Spellpower Obt"],BZONE["Blade's Edge Mountains"]),4)
	self:addTradeSkillSpell(34005, 350, self:CombineMobs(false,L["Enchant Cloak - Greater Arcane Resistance Obt"],BZONE["Shadowmoon Valley"]),4)
	self:addTradeSkillSpell(34006, 350, self:CombineMobs(false,L["Enchant Cloak - Greater Shadow Resistance Obt"],BZONE["Netherstorm"]),4)
	self:addTradeSkillSpell(27917, 360, self:CombineMobs(false,L["Enchant Bracer - Spellpower Obt"],BZONE["Blade's Edge Mountains"]),4)
	self:addTradeSkillSpell(27977, 360, self:CombineMobs(false,L["Enchant 2H Weapon - Major Agility Obt"],BZONE["The Arcatraz"]),4,5)
	self:addTradeSkillSpell(47051, 375, self:CombineMobs(false,BBOSS["Priestess Delrissa"],BZONE["Magisters' Terrace"]),4,5)

	-- Seasonal
	self:addTradeSkillSpell(21931, 190, L["WintersVeil"],7)
	self:addTradeSkillSpell(46578, 375, self:CombineMobs(false,L["Enchant Weapon - Deathfrost Obt"],BZONE["The Slave Pens"]),7)

	-- Reputations
	self:addTradeSkillSpell(23799, 290, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23803, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23804, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23800, 290, self:AddSingleReputation(2, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(23801, 290, self:AddSingleReputation(2, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])
	self:addTradeSkillSpell(27837, 290, self:AddSingleReputation(1, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(23802, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])
	self:addTradeSkillSpell(25081, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(25082, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(25129, 300, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(25130, 300, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(25080, 300, L["AQ20/AQ40"] .. addon.br .. self:AddSingleReputation(4, BFAC["Keepers of Time"]), BFAC["Keepers of Time"])
	self:addTradeSkillSpell(25072, 300, L["AQ20/AQ40"] .. addon.br .. self:AddSingleReputation(4, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(25083, 300, L["AQ20/AQ40"] .. addon.br .. self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(25084, 300, L["AQ20/AQ40"] .. addon.br .. self:AddDoubleReputation(4, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(25086, 300, L["AQ20/AQ40"] .. addon.br .. self:AddSingleReputation(4, BFAC["Lower City"]), BFAC["Lower City"])
	self:addTradeSkillSpell(27911, 325, self:AddDoubleReputation(1, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(34003, 325, self:AddSingleReputation(1, BFAC["The Consortium"]), BFAC["The Consortium"])
	self:addTradeSkillSpell(27967, 340, self:AddSingleReputation(2, BFAC["The Consortium"]), BFAC["The Consortium"])
	self:addTradeSkillSpell(27960, 345, self:AddDoubleReputation(3, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(33999, 350, self:AddSingleReputation(2, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(42620, 350, self:AddSingleReputation(4, BFAC["The Violet Eye"]), BFAC["The Violet Eye"], 6)
	self:addTradeSkillSpell(34010, 350, self:AddSingleReputation(3, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(27920, 360, self:AddSingleReputation(3, BFAC["The Consortium"]), BFAC["The Consortium"], 6)
	self:addTradeSkillSpell(27924, 360, self:AddSingleReputation(2, BFAC["Keepers of Time"]), BFAC["Keepers of Time"])
	self:addTradeSkillSpell(33994, 360, self:AddSingleReputation(3, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(33997, 360, self:AddSingleReputation(2, BFAC["Keepers of Time"]), BFAC["Keepers of Time"])
	self:addTradeSkillSpell(27926, 370, self:AddSingleReputation(3, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(27927, 375, self:AddSingleReputation(2, BFAC["Lower City"]), BFAC["Lower City"])
	self:addTradeSkillSpell(46594, 360, self:AddSingleReputation(2, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"])
	self:addTradeSkillSpell(45765, 375, self:AddSingleReputation(2, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"])

	-- Raid Drops
	self:addTradeSkillSpell(22749, 300, L["MOLTENCORE"], 6)
	self:addTradeSkillSpell(22750, 300, L["MOLTENCORE"], 6)
	self:addTradeSkillSpell(25073, 300, L["AQ20/AQ40"], 6)
	self:addTradeSkillSpell(25074, 300, L["AQ20/AQ40"], 6)
	self:addTradeSkillSpell(25078, 300, L["AQ20/AQ40"], 6)
	self:addTradeSkillSpell(25079, 300, L["AQ20/AQ40"], 6)
	self:addTradeSkillSpell(27954, 370, self:CombineMobs(false,L["Enchant Boots - Surefooted Obt"],BZONE["Karazhan"]), 6)
	self:addTradeSkillSpell(27981, 375, self:CombineMobs(false,BBOSS["Shade of Aran"],BZONE["Karazhan"]), 6)
	self:addTradeSkillSpell(27982, 375, self:CombineMobs(false,BBOSS["Terestian Illhoof"],BZONE["Karazhan"]), 6)
	self:addTradeSkillSpell(27984, 375, self:CombineMobs(false,BBOSS["Moroes"],BZONE["Karazhan"]), 6)
	self:addTradeSkillSpell(42974, 375, L["ZA"], 6)

	if (addon.wrath) then
		self:addTradeSkillSpell(27958, 355, L["Trainer"], 1) -- Exceptional mana
		self:addTradeSkillSpell(44484, 365, L["Trainer"], 1) -- Expertise
		self:addTradeSkillSpell(44506, 375, L["Trainer"], 1) -- Gatherer
		self:addTradeSkillSpell(44508, 355, L["Trainer"], 1) -- Spirit
		self:addTradeSkillSpell(44509, 375, L["Trainer"], 1) -- Greater mana restoration
		self:addTradeSkillSpell(44555, 375, L["Trainer"], 1) -- Exceptional intellect
		self:addTradeSkillSpell(44584, 365, L["Trainer"], 1) -- Greater vitality
		self:addTradeSkillSpell(47672, 355, L["Trainer"], 1) -- Mighty armor
		self:addTradeSkillSpell(44528, 385, L["Trainer"], 1) -- Greater fort
		self:addTradeSkillSpell(44488, 385, L["Trainer"], 1) -- Greater Spell strike
		self:addTradeSkillSpell(44582, 395, L["Trainer"], 1) -- Spell piercing
	end

end
