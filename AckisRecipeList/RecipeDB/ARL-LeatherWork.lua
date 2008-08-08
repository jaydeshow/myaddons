--[[

ARL-LeatherWork.lua

LeatherWorking data for all of AckisRecipeList

$Date: 2008-08-06 20:55:52 -0400 (Wed, 06 Aug 2008) $
$Rev: 79904 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BBOSS		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitLeatherWorking()

	-- Trainer Recipes
	self:addTradeSkillSpell(2149, 1, L["Trainer"],1)
	self:addTradeSkillSpell(2152, 1, L["Trainer"],1)
	self:addTradeSkillSpell(2881, 1, L["Trainer"],1)
	self:addTradeSkillSpell(7126, 1, L["Trainer"],1)
	self:addTradeSkillSpell(9058, 1, L["Trainer"],1)
	self:addTradeSkillSpell(9059, 1, L["Trainer"],1)
	self:addTradeSkillSpell(2153, 15, L["Trainer"],1)
	self:addTradeSkillSpell(3753, 25, L["Trainer"],1)
	self:addTradeSkillSpell(9060, 30, L["Trainer"],1)
	self:addTradeSkillSpell(9062, 30, L["Trainer"],1)
	self:addTradeSkillSpell(3816, 35, L["Trainer"],1)
	self:addTradeSkillSpell(2160, 40, L["Trainer"],1)
	self:addTradeSkillSpell(3756, 55, L["Trainer"],1)
	self:addTradeSkillSpell(2161, 55, L["Trainer"],1)
	self:addTradeSkillSpell(2162, 60, L["Trainer"],1)
	self:addTradeSkillSpell(3759, 75, L["Trainer"],1)
	self:addTradeSkillSpell(3763, 80, L["Trainer"],1)
	self:addTradeSkillSpell(2159, 85, L["Trainer"],1)
	self:addTradeSkillSpell(3761, 85, L["Trainer"],1)
	self:addTradeSkillSpell(9065, 70, L["Trainer"],1)
	self:addTradeSkillSpell(9068, 95, L["Trainer"],1)
	self:addTradeSkillSpell(3817, 100, L["Trainer"],1)
	self:addTradeSkillSpell(20648, 100, L["Trainer"],1)
	self:addTradeSkillSpell(2165, 100, L["Trainer"],1)
	self:addTradeSkillSpell(2167, 100, L["Trainer"],1)
	self:addTradeSkillSpell(2168, 110, L["Trainer"],1)
	self:addTradeSkillSpell(7135, 115, L["Trainer"],1)
	self:addTradeSkillSpell(9074, 120, L["Trainer"],1)
	self:addTradeSkillSpell(2166, 120, L["Trainer"],1)
	self:addTradeSkillSpell(3766, 125, L["Trainer"],1)
	self:addTradeSkillSpell(9145, 125, L["Trainer"],1)
	self:addTradeSkillSpell(3768, 130, L["Trainer"],1)
	self:addTradeSkillSpell(3770, 135, L["Trainer"],1)
	self:addTradeSkillSpell(3764, 145, L["Trainer"],1)
	self:addTradeSkillSpell(3760, 150, L["Trainer"],1)
	self:addTradeSkillSpell(3818, 150, L["Trainer"],1)
	self:addTradeSkillSpell(3780, 150, L["Trainer"],1)
	self:addTradeSkillSpell(9193, 150, L["Trainer"],1)
	self:addTradeSkillSpell(9194, 150, L["Trainer"],1)
	self:addTradeSkillSpell(20649, 150, L["Trainer"],1)
	self:addTradeSkillSpell(3774, 160, L["Trainer"],1)
	self:addTradeSkillSpell(7147, 160, L["Trainer"],1)
	self:addTradeSkillSpell(7151, 175, L["Trainer"],1)
	self:addTradeSkillSpell(9196, 175, L["Trainer"],1)
	self:addTradeSkillSpell(3776, 180, L["Trainer"],1)
	self:addTradeSkillSpell(9198, 180, L["Trainer"],1)
	self:addTradeSkillSpell(9201, 185, L["Trainer"],1)
	self:addTradeSkillSpell(6661, 190, L["Trainer"],1)
	self:addTradeSkillSpell(7156, 190, L["Trainer"],1)	
	self:addTradeSkillSpell(9206, 195, L["Trainer"],1)
	self:addTradeSkillSpell(10482, 200, L["Trainer"],1)
	self:addTradeSkillSpell(10487, 200, L["Trainer"],1)
	self:addTradeSkillSpell(20650, 200, L["Trainer"],1)
	self:addTradeSkillSpell(10499, 205, L["Trainer"],1)
	self:addTradeSkillSpell(10507, 205, L["Trainer"],1)
	self:addTradeSkillSpell(10511, 210, L["Trainer"],1)
	self:addTradeSkillSpell(10518, 210, L["Trainer"],1)
	self:addTradeSkillSpell(14930, 225, L["Trainer"],1)
	self:addTradeSkillSpell(14932, 225, L["Trainer"],1)
	self:addTradeSkillSpell(10619, 225, L["Trainer"],1)
	self:addTradeSkillSpell(10548, 230, L["Trainer"],1)
	self:addTradeSkillSpell(10552, 230, L["Trainer"],1)
	self:addTradeSkillSpell(10556, 235, L["Trainer"],1)
	self:addTradeSkillSpell(10558, 235, L["Trainer"],1)
	self:addTradeSkillSpell(19047, 250, L["Trainer"],1)
	self:addTradeSkillSpell(19058, 250, L["Trainer"],1)
	self:addTradeSkillSpell(22331, 250, L["Trainer"],1)
	self:addTradeSkillSpell(10650, 255, L["Trainer"],1)
	self:addTradeSkillSpell(19052, 265, L["Trainer"],1)
	self:addTradeSkillSpell(19065, 275, L["Trainer"],1)
	self:addTradeSkillSpell(19071, 280, L["Trainer"],1)
	self:addTradeSkillSpell(24655, 280, L["Trainer"],1)
	self:addTradeSkillSpell(19082, 290, L["Trainer"],1)
	self:addTradeSkillSpell(19092, 300, L["Trainer"],1)
	self:addTradeSkillSpell(19102, 300, L["Trainer"],1)
	self:addTradeSkillSpell(19098, 300, L["Trainer"],1)
	self:addTradeSkillSpell(19103, 300, L["Trainer"],1)
	self:addTradeSkillSpell(24654, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32470, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32462, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32456, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32454, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32466, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32471, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32478, 300, L["Trainer"],1)
	self:addTradeSkillSpell(32463, 310, L["Trainer"],1)
	self:addTradeSkillSpell(32467, 310, L["Trainer"],1)
	self:addTradeSkillSpell(32479, 310, L["Trainer"],1)
	self:addTradeSkillSpell(32471, 315, L["Trainer"],1)
	self:addTradeSkillSpell(32464, 320, L["Trainer"],1)
	self:addTradeSkillSpell(32472, 320, L["Trainer"],1)
	self:addTradeSkillSpell(32480, 320, L["Trainer"],1)
	self:addTradeSkillSpell(32468, 325, L["Trainer"],1)
	self:addTradeSkillSpell(32473, 330, L["Trainer"],1)
	self:addTradeSkillSpell(32481, 330, L["Trainer"],1)
	self:addTradeSkillSpell(32465, 335, L["Trainer"],1)
	self:addTradeSkillSpell(32469, 335, L["Trainer"],1)
	self:addTradeSkillSpell(35540, 340, L["Trainer"],1)
	self:addTradeSkillSpell(44344, 315, L["Trainer"],1) -- was 305, confirm?
	self:addTradeSkillSpell(44343, 315, L["Trainer"],1) -- wsa 305, confirm?
	self:addTradeSkillSpell(45100, 290, L["Trainer"],1)
	self:addTradeSkillSpell(44970, 350, L["Trainer"],1)
	self:addTradeSkillSpell(44770, 350, L["Trainer"],1)

	-- Vendor Recipes
	self:addTradeSkillSpell(6702, 190, self:CombineVendors(6, 7, 96, false),2)
	self:addTradeSkillSpell(7953, 90, self:CombineVendors(97, false),2)
	self:addTradeSkillSpell(6703, 95, self:CombineVendors(6, 7, 96, false),2)
	self:addTradeSkillSpell(9070, 100, self:CombineVendors(98, false), BFAC["Alliance"],2)
	self:addTradeSkillSpell(24940, 100, self:CombineVendors(13, false), BFAC["Alliance"],2)
	self:addTradeSkillSpell(7954, 105, self:CombineVendors(97, false),2)
	self:addTradeSkillSpell(9072, 120, self:CombineVendors(25, false), BFAC["Alliance"],2)
	self:addTradeSkillSpell(9146, 135, self:CombineVendors(99, false), BFAC["Alliance"],2)
	self:addTradeSkillSpell(9147, 135, self:CombineVendors(19, false),2)
	self:addTradeSkillSpell(23190, 150, self:CombineVendors(100, 101, false),2)
	self:addTradeSkillSpell(3772, 155, self:CombineVendors(102, 25, false),2)
	self:addTradeSkillSpell(23399, 155, self:CombineVendors(103, 104, false),2)
	self:addTradeSkillSpell(4097, 165, self:CombineVendors(107, false), BFAC["Alliance"],2)
	self:addTradeSkillSpell(4096, 165, self:CombineVendors(108, false), BFAC["Horde"],2)
	self:addTradeSkillSpell(6704, 170, self:CombineVendors(109, 110, 29, false),2)
	self:addTradeSkillSpell(7149, 170, self:CombineVendors(111, 112, 113, 114, false),2)
	self:addTradeSkillSpell(3778, 185, self:CombineVendors(115, false),2)
	self:addTradeSkillSpell(6705, 190, self:CombineVendors(109, 116, false),2)
	self:addTradeSkillSpell(9202, 190, self:CombineVendors(103, 104, 105, 106, false),2)
	self:addTradeSkillSpell(22711, 200, self:CombineVendors(115, false),2)
	self:addTradeSkillSpell(10509, 205, self:CombineVendors(105, 106, false),2)
	self:addTradeSkillSpell(10516, 210, self:CombineVendors(105, 117, false),2)
	self:addTradeSkillSpell(19048, 255, self:CombineVendors(118, false),2)
	self:addTradeSkillSpell(19049, 260, self:CombineVendors(119, 120, false),2)
	self:addTradeSkillSpell(19088, 295, self:CombineVendors(118, false),2)
	self:addTradeSkillSpell(19050, 260, self:CombineVendors(121, false),2)
	self:addTradeSkillSpell(19077, 285, self:CombineVendors(122, true),2)
	self:addTradeSkillSpell(19085, 290, self:CombineVendors(123, false),2)
	self:addTradeSkillSpell(19061, 270, self:CombineVendors(105, 106, false),2)
	self:addTradeSkillSpell(19067, 275, self:CombineVendors(119, 120, false),2)
	self:addTradeSkillSpell(19053, 265, self:CombineVendors(122, true),2)
	self:addTradeSkillSpell(19062, 270, self:CombineVendors(124, true),2)
	self:addTradeSkillSpell(19066, 275, self:CombineVendors(53, false),2)
	self:addTradeSkillSpell(19084, 290, self:CombineVendors(125, false),2)
	self:addTradeSkillSpell(32482, 300, self:CombineVendors(126, 127, false),2)
	self:addTradeSkillSpell(32455, 325, self:CombineVendors(126, 127, 128, false),2)
	self:addTradeSkillSpell(32461, 350, self:CombineVendors(129, false),2)

	-- World Drops
	self:addTradeSkillSpell(9064, 35, L["UWD"],3)
	self:addTradeSkillSpell(2163, 60, L["UWD"],3)
	self:addTradeSkillSpell(2164, 75, L["UWD"],3)
	self:addTradeSkillSpell(2158, 90, L["UWD"],3)
	self:addTradeSkillSpell(3762, 100, L["UWD"],3)
	self:addTradeSkillSpell(2169, 100, L["UWD"],3)
	self:addTradeSkillSpell(7133, 105, L["UWD"],3)
	self:addTradeSkillSpell(3765, 120, L["UWD"],3)
	self:addTradeSkillSpell(3767, 120, L["UWD"],3)
	self:addTradeSkillSpell(3769, 140, L["UWD"],3)
	self:addTradeSkillSpell(9148, 140, L["UWD"],3)
	self:addTradeSkillSpell(9149, 145, L["UWD"],3)
	self:addTradeSkillSpell(3771, 150, L["UWD"],3)
	self:addTradeSkillSpell(9195, 165, L["UWD"],3)
	self:addTradeSkillSpell(3775, 170, L["RWD"],3)
	self:addTradeSkillSpell(3773, 175, L["UWD"],3)
	self:addTradeSkillSpell(9197, 175, L["UWD"],3)
	self:addTradeSkillSpell(7153, 185, L["UWD"],3)
	self:addTradeSkillSpell(3777, 195, L["UWD"],3)
	self:addTradeSkillSpell(3779, 200, L["RWD"],3)
	self:addTradeSkillSpell(9207, 200, L["UWD"],3)
	self:addTradeSkillSpell(9208, 200, L["UWD"],3)
	self:addTradeSkillSpell(10490, 200, L["UWD"],3)
	self:addTradeSkillSpell(10520, 215, L["UWD"],3)
	self:addTradeSkillSpell(10531, 220, L["UWD"],3)
	self:addTradeSkillSpell(10560, 240, L["UWD"],3)
	self:addTradeSkillSpell(10562, 240, L["UWD"],3)
	self:addTradeSkillSpell(19055, 270, L["UWD"],3)
	self:addTradeSkillSpell(19064, 275, L["UWD"],3)
	self:addTradeSkillSpell(19070, 280, L["UWD"],3)
	self:addTradeSkillSpell(19072, 280, L["UWD"],3)
	self:addTradeSkillSpell(19083, 290, L["UWD"],3)
	self:addTradeSkillSpell(19091, 300, L["UWD"],3)
	self:addTradeSkillSpell(19063, 275, L["UWD"],3)
	self:addTradeSkillSpell(19073, 280, L["UWD"],3)
	self:addTradeSkillSpell(19081, 290, L["UWD"],3)
	self:addTradeSkillSpell(35559, 365, L["EWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(35558, 365, L["EWD"],3)
	self:addTradeSkillSpell(35567, 365, L["EWD"],3)
	self:addTradeSkillSpell(35562, 365, L["EWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(35561, 365, L["EWD"],3)
	self:addTradeSkillSpell(35564, 365, L["EWD"],3)
	self:addTradeSkillSpell(35573, 365, L["EWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(35572, 365, L["EWD"],3)
	self:addTradeSkillSpell(35574, 365, L["EWD"],3)
	self:addTradeSkillSpell(35563, 365, L["EWD"],3)
	self:addTradeSkillSpell(35560, 365, L["EWD"],3)
	self:addTradeSkillSpell(35568, 365, L["EWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)

	-- Specific Drops
	self:addTradeSkillSpell(5244, 40, self:CombineQuests(L["Kodo Hide Bag Obt"],2,BZONE["The Barrens"]), BFAC["Horde"],8)
	self:addTradeSkillSpell(8322, 90, self:CombineQuests(L["Moonglow Vest Obt"],1,BZONE["Darnassus"]), BFAC["Alliance"],8)
	self:addTradeSkillSpell(7955, 115,  self:CombineQuests(L["Deviate Scale Belt Obt"],0,BZONE["Wailing Caverns"]),8)
	self:addTradeSkillSpell(10525, 220, self:CombineMobs(true,L["Tough Scorpid Breastplate Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10529, 220, self:CombineQuests(L["Wild Leather Shoulders Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(10533, 220, self:CombineMobs(true,L["Tough Scorpid Bracers Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10542, 225, self:CombineMobs(true,L["Tough Scorpid Gloves Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10544, 225, self:CombineQuests(L["Wild Leather Vest Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(10546, 225, self:CombineQuests(L["Wild Leather Helmet Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(10554, 235, self:CombineMobs(true,L["Tough Scorpid Boots Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10564, 240, self:CombineMobs(true,L["Tough Scorpid Helm Obt"],BZONE["Tanaris"]),3) -- shoulders have same drop as helm
	self:addTradeSkillSpell(10566, 245, self:CombineQuests(L["Wild Leather Boots Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(10568, 245, self:CombineMobs(true,L["Tough Scorpid Leggings Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10570, 250, self:CombineMobs(true,L["Tough Scorpid Helm Obt"],BZONE["Tanaris"]),3)
	self:addTradeSkillSpell(10572, 250, self:CombineQuests(L["Wild Leather Leggings Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(10574, 250, self:CombineQuests(L["Wild Leather Cloak Obt"],0,BZONE["Feralas"]),8)
	self:addTradeSkillSpell(19051, 265, self:CombineMobs(true,L["Heavy Scorpid Vest Obt"],BZONE["Blasted Lands"]),3)
	self:addTradeSkillSpell(19075, 285, self:CombineMobs(true,L["Heavy Scorpid Leggings Obt"],BZONE["Burning Steppes"]),3)
	self:addTradeSkillSpell(19100, 300, self:CombineMobs(true,L["Heavy Scorpid Shoulders Obt"],BZONE["Burning Steppes"]),3)
	self:addTradeSkillSpell(22921, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(22922, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(22923, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(22815, 300, self:CombineQuests(L["Gordok Ogre Suit Obt"],0,BZONE["Dire Maul"]),5)
	self:addTradeSkillSpell(19060, 270, self:CombineMobs(true,L["Green Dragonscale Leggings Obt"],BZONE["The Temple of Atal'Hakkar"]),3,5)
	self:addTradeSkillSpell(19089, 295, self:CombineMobs(true,L["Blue Dragonscale Shoulders Obt"],BZONE["Azshara"]),3)
	self:addTradeSkillSpell(19054, 300, self:CombineMobs(false,BBOSS["General Drakkisath"],BZONE["Upper Blackrock Spire"]),3,5)
	self:addTradeSkillSpell(19107, 300, self:CombineMobs(true,L["Anvilrage Captain"],BZONE["Blackrock Depths"]),3,5)
	self:addTradeSkillSpell(19094, 300, self:CombineMobs(true,L["Anvilrage Captain"],BZONE["Blackrock Depths"]),3,5)
	self:addTradeSkillSpell(22926, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(19059, 270, self:CombineMobs(true,L["Volcanic Leggings Obt"],BZONE["Burning Steppes"]),3)
	self:addTradeSkillSpell(19076, 285, self:CombineMobs(true,L["Volcanic Breastplate Obt"],BZONE["Lower Blackrock Spire"]),3,5)
	self:addTradeSkillSpell(19078, 285, self:CombineMobs(true,L["Living Leggings Obt"],BZONE["Felwood"]),3)
	self:addTradeSkillSpell(19079, 285, self:CombineMobs(true,L["Stormshroud Armor Obt"],BZONE["Azshara"]),3)
	self:addTradeSkillSpell(19090, 295, self:CombineMobs(true,L["Stormshroud Shoulders Obt"],BZONE["Azshara"]),3)
	self:addTradeSkillSpell(26279, 300, self:CombineMobs(true,L["Stormshroud Gloves Obt"],BZONE["Silithus"]) .. addon.br .. self:CombineMobs(true,L["Stormshroud Gloves Obt1"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(19095, 300, self:CombineMobs(true,L["Living Breastplate Obt"],BZONE["Western Plaguelands"]),3)
	self:addTradeSkillSpell(19101, 300, self:CombineMobs(true,L["Volcanic Shoulders Obt"],BZONE["Lower Blackrock Spire"]),3,5)
	self:addTradeSkillSpell(22928, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(19074, 285, self:CombineMobs(true,L["Frostsaber Leggings Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(19086, 290, self:CombineMobs(true,L["Ironfeather Breastplate Obt"],BZONE["The Hinterlands"]),3)
	self:addTradeSkillSpell(19087, 295, self:CombineMobs(true,L["Frostsaber Gloves Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(19097, 300, self:CombineMobs(true,L["Devilsaur Leggings Obt"],BZONE["Un'Goro Crater"]),3)
	self:addTradeSkillSpell(19104, 300, self:CombineMobs(true,L["Frostsaber Tunic Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(22927, 300, self:CombineMobs(false,L["DMCACHE"],BZONE["Dire Maul"]),4,5)
	self:addTradeSkillSpell(35520, 340, self:CombineMobs(false,L["Shadow Armor Kit Obt"],BZONE["Sethekk Halls"]),4,5)
	self:addTradeSkillSpell(35521, 340, self:CombineMobs(false,L["Flame Armor Kit Obt"],BZONE["The Arcatraz"]),4,5)
	self:addTradeSkillSpell(35523, 340, self:CombineMobs(false,BBOSS["Mennu the Betrayer"],BZONE["The Slave Pens"]),4,5)
	self:addTradeSkillSpell(35524, 340, self:CombineMobs(false,BBOSS["Chrono Lord Deja"],BZONE["The Black Morass"]),4,5)
	self:addTradeSkillSpell(35522, 340, self:CombineMobs(false,BBOSS["Hydromancer Thespia"],BZONE["The Steamvault"]),4,5)
	self:addTradeSkillSpell(32485, 350, self:CombineMobs(false,BBOSS["Blackheart the Inciter"],BZONE["Shadow Labyrinth"]),4,5)
	self:addTradeSkillSpell(32487, 350, self:CombineMobs(false,L["Stylin' Adventure Hat Obt"],BZONE["Old Hillsbrad Foothills"]),4,5)
	self:addTradeSkillSpell(32489, 350, self:CombineMobs(false,L["Stylin' Jungle Hat Obt"],BZONE["The Black Morass"]),4,5)
	self:addTradeSkillSpell(32488, 350, self:CombineMobs(false,L["Stylin' Crimson Hat Obt"],BZONE["Sethekk Halls"]),4,5)
	self:addTradeSkillSpell(45117, 360, self:CombineMobs(false,L["Bag of Many Hides Obt"],BZONE["Terokkar Forest"]),4)

	-- Seasonal
	self:addTradeSkillSpell(21943, 190, L["WintersVeil"], 7)
	self:addTradeSkillSpell(44953, 285, L["WintersVeil"], 7)

	-- Reputations
	self:addTradeSkillSpell(23703, 290, self:AddSingleReputation(2, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(23705, 290, self:AddSingleReputation(2, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])
	self:addTradeSkillSpell(23704, 300, self:AddSingleReputation(3, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(23706, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])
	self:addTradeSkillSpell(23707, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(24124, 300, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24125, 300, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24123, 300, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24122, 300, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24121, 300, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24846, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(24847, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(24848, 300, self:AddSingleReputation(3, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(24849, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(24850, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(24851, 300, self:AddSingleReputation(3, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(28224, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28222, 300, self:AddSingleReputation(4, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28223, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28221, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28220, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28219, 300, self:AddSingleReputation(4, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], BFAC["Argent Dawn"], 6)
	self:addTradeSkillSpell(28474, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(28473, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(28472, 300, self:AddSingleReputation(3, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(20855, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23708, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(24703, 300, self:AddSingleReputation(4, BFAC["Cenarion Circle"]), BFAC["Cenarion Circle"])
	self:addTradeSkillSpell(20854, 300, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23710, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(19068, 275, self:AddSingleReputation(1, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(19080, 285, self:AddSingleReputation(1, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(20853, 295, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(23709, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(32457, 325, self:AddSingleReputation(3, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(32458, 325, self:AddSingleReputation(3, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35530, 325, self:AddDoubleReputation(2, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(35549, 335, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(35555, 335, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32490, 340, self:AddSingleReputation(1, BFAC["The Consortium"]), BFAC["The Consortium"])
	self:addTradeSkillSpell(32501, 340, self:AddDoubleReputation(1, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(32502, 340, self:AddDoubleReputation(2, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(35544, 345, self:AddDoubleReputation(2, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(32493, 350, self:AddSingleReputation(2, BFAC["The Consortium"]), BFAC["The Consortium"])
	self:addTradeSkillSpell(32494, 350, self:AddSingleReputation(3, BFAC["The Consortium"]), BFAC["The Consortium"])
	self:addTradeSkillSpell(32498, 350, self:AddDoubleReputation(1, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(32503, 350, self:AddDoubleReputation(3, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(35527, 350, self:AddSingleReputation(3, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35526, 350, self:AddSingleReputation(2, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35525, 350, self:AddSingleReputation(4, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35531, 350, self:AddSingleReputation(2, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(35528, 350, self:AddSingleReputation(3, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(35529, 350, self:AddSingleReputation(4, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(35534, 350, self:AddSingleReputation(2, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35533, 350, self:AddSingleReputation(3, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35532, 350, self:AddSingleReputation(4, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(35537, 350, self:AddSingleReputation(2, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(35536, 350, self:AddSingleReputation(3, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(35535, 350, self:AddSingleReputation(4, BFAC["The Aldor"]), BFAC["The Aldor"])
	self:addTradeSkillSpell(44359, 340, self:AddSingleReputation(3, BFAC["Lower City"]), BFAC["Lower City"])
	self:addTradeSkillSpell(44768, 340, self:AddDoubleReputation(3, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(35539, 350, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(32496, 355, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32497, 355, self:AddSingleReputation(1, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32495, 360, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32499, 360, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(32500, 360, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(35543, 365, self:AddSingleReputation(2, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(35554, 365, self:AddDoubleReputation(4, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(35557, 365, self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(35538, 370, self:AddSingleReputation(2, BFAC["Keepers of Time"]), BFAC["Keepers of Time"])
	self:addTradeSkillSpell(39997, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40000, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40002, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40001, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(42546, 350, self:AddSingleReputation(4, BFAC["The Violet Eye"]), 6, BFAC["The Violet Eye"])
	self:addTradeSkillSpell(40006, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40005, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40003, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(40004, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), 6, BFAC["Ashtongue Deathsworn"])
	self:addTradeSkillSpell(42731, 355, self:AddSingleReputation(3, BFAC["The Violet Eye"]), 6, BFAC["The Violet Eye"])

	-- Raid Drops
	self:addTradeSkillSpell(22727, 300, L["MOLTENCORE"], 6)
	self:addTradeSkillSpell(19093, 300, self:CombineQuests(L["Onyxia Scale Cloak Obt"],0,BZONE["Onyxia's Lair"]),6,8)
	self:addTradeSkillSpell(41162, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(36359, 375, L["SSC/TKBoE"], 6)
	self:addTradeSkillSpell(36353, 375, L["SSC/TKBoP"], 6)
	self:addTradeSkillSpell(36351, 375, L["SSC/TKBoP"], 6)
	self:addTradeSkillSpell(36349, 375, L["SSC/TKBoP"], 6)
	self:addTradeSkillSpell(36352, 375, L["SSC/TKBoP"], 6)
	self:addTradeSkillSpell(36355, 375, L["SSC/TKBoE"], 6)
	self:addTradeSkillSpell(36358, 375, L["SSC/TKBoE"], 6)
	self:addTradeSkillSpell(36357, 375, L["SSC/TKBoE"], 6)
	self:addTradeSkillSpell(41156, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(41157, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(41164, 375, L["BT/HYJALBoE"], 6)
	self:addTradeSkillSpell(41163, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(41162, 375, L["BT/HYJALBoE"], 6)
	self:addTradeSkillSpell(41161, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(41158, 375, L["BT/HYJALBoP"], 6)
	self:addTradeSkillSpell(41160, 375, L["BT/HYJALBoE"], 6)
	self:addTradeSkillSpell(46132, 365, L["SunwellBoE"], 6)
	self:addTradeSkillSpell(46136, 365, L["SunwellBoE"], 6)
	self:addTradeSkillSpell(46137, 365, L["SunwellBoE"], 6)
	self:addTradeSkillSpell(46133, 365, L["SunwellBoP"], 6)
	self:addTradeSkillSpell(46139, 365, L["SunwellBoE"], 6)
	self:addTradeSkillSpell(46135, 365, L["SunwellBoP"], 6)
	self:addTradeSkillSpell(46134, 365, L["SunwellBoP"], 6)
	self:addTradeSkillSpell(46138, 365, L["SunwellBoE"], 6)

	-- Dragonscale Leatherworking
	self:addTradeSkillSpell(36076, 260, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(36079, 330, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35576, 375, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35577, 375, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35575, 375, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35582, 375, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35584, 375, L["Trainer"],GetSpellInfo(10657),1)
	self:addTradeSkillSpell(35580, 375, L["Trainer"],GetSpellInfo(10657),1)

	-- Elemental Leatherworking
	self:addTradeSkillSpell(10630, 230, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(10632, 250, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(36074, 260, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(36077, 330, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(35590, 375, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(35591, 375, L["Trainer"],GetSpellInfo(10659),1)
	self:addTradeSkillSpell(35589, 375, L["Trainer"],GetSpellInfo(10659),1)

	-- Tribal Leatherworking
	self:addTradeSkillSpell(10621, 225, L["Trainer"],1)
	self:addTradeSkillSpell(10647, 250, L["Trainer"],1)
	self:addTradeSkillSpell(36075, 260, L["Trainer"],GetSpellInfo(10661),1)
	self:addTradeSkillSpell(36078, 330, L["Trainer"],GetSpellInfo(10661),1)
	self:addTradeSkillSpell(35587, 375, L["Trainer"],GetSpellInfo(10661),1)
	self:addTradeSkillSpell(35588, 375, L["Trainer"],GetSpellInfo(10661),1)
	self:addTradeSkillSpell(35585, 375, L["Trainer"],GetSpellInfo(10661),1)

end
