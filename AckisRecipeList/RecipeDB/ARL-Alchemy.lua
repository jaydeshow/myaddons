--[[

ARL-Alchemy.lua

Alchemy data for all of AckisRecipeList

$Date: 2008-08-26 19:24:55 +0000 (Tue, 26 Aug 2008) $
$Rev: 827 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BBOSS		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitAlchemy()

	-- Trainer Recipes
	self:addTradeSkillSpell(2330, 1, L["Trainer"],1)
	self:addTradeSkillSpell(2329, 1, L["Trainer"],1)
	self:addTradeSkillSpell(7183, 1, L["Trainer"],1)
	self:addTradeSkillSpell(3170, 15, L["Trainer"],1)
	self:addTradeSkillSpell(2331, 25, L["Trainer"],1)
	self:addTradeSkillSpell(2332, 40, L["Trainer"],1)
	self:addTradeSkillSpell(2334, 50, L["Trainer"],1)
	self:addTradeSkillSpell(2337, 55, L["Trainer"],1)
	self:addTradeSkillSpell(7836, 80, L["Trainer"],1)
	self:addTradeSkillSpell(3171, 90, L["Trainer"],1)
	self:addTradeSkillSpell(7179, 90, L["Trainer"],1)
	self:addTradeSkillSpell(7841, 100, L["Trainer"],1)
	self:addTradeSkillSpell(3447, 110, L["Trainer"],1)
	self:addTradeSkillSpell(3173, 120, L["Trainer"],1)
	self:addTradeSkillSpell(3176, 125, L["Trainer"],1)
	self:addTradeSkillSpell(3177, 130, L["Trainer"],1)
	self:addTradeSkillSpell(7837, 130, L["Trainer"],1)
	self:addTradeSkillSpell(7845, 140, L["Trainer"],1)
	self:addTradeSkillSpell(7181, 155, L["Trainer"],1)
	self:addTradeSkillSpell(3452, 160, L["Trainer"],1)
	self:addTradeSkillSpell(3448, 165, L["Trainer"],1)
	self:addTradeSkillSpell(11449, 185, L["Trainer"],1)
	self:addTradeSkillSpell(11450, 195, L["Trainer"],1)
	self:addTradeSkillSpell(12609, 200, L["Trainer"],1)
	self:addTradeSkillSpell(11451, 205, L["Trainer"],1)
	self:addTradeSkillSpell(11448, 205, L["Trainer"],1)
	self:addTradeSkillSpell(11457, 215, L["Trainer"],1)
	self:addTradeSkillSpell(22808, 215, L["Trainer"],1)
	self:addTradeSkillSpell(11460, 230, L["Trainer"],1)
	self:addTradeSkillSpell(15833, 230, L["Trainer"],1)
	self:addTradeSkillSpell(11461, 235, L["Trainer"],1)
	self:addTradeSkillSpell(11465, 235, L["Trainer"],1)
	self:addTradeSkillSpell(11467, 240, L["Trainer"],1)
	self:addTradeSkillSpell(11478, 250, L["Trainer"],1)
	self:addTradeSkillSpell(17551, 250, L["Trainer"],1)
	self:addTradeSkillSpell(17553, 260, L["Trainer"],1)
	self:addTradeSkillSpell(17556, 275, L["Trainer"],1)
	self:addTradeSkillSpell(17573, 285, L["Trainer"],1)
	self:addTradeSkillSpell(33740, 300, L["Trainer"],1)
	self:addTradeSkillSpell(33738, 300, L["Trainer"],1)
	self:addTradeSkillSpell(33732, 300, L["Trainer"],1)
	self:addTradeSkillSpell(28544, 305, L["Trainer"],1)
	self:addTradeSkillSpell(28545, 310, L["Trainer"],1)
	self:addTradeSkillSpell(39636, 310, L["Trainer"],1)
	self:addTradeSkillSpell(33733, 310, L["Trainer"],1)
	self:addTradeSkillSpell(45061, 325, L["Trainer"],1)
	self:addTradeSkillSpell(33741, 315, L["Trainer"],1)
	self:addTradeSkillSpell(39638, 320, L["Trainer"],1)
	self:addTradeSkillSpell(38070, 325, L["Trainer"],1)
	self:addTradeSkillSpell(28551, 325, L["Trainer"],1)

	-- Vendor Recipes
	self:addTradeSkillSpell(6617, 60, self:CombineVendors(130, 131, 12, 132, false),2)
	self:addTradeSkillSpell(7255, 100, self:CombineVendors(133, 76, 132, false),2)
	self:addTradeSkillSpell(7256, 135, self:CombineVendors(110, 135, false),2)
	self:addTradeSkillSpell(6624, 150, self:CombineVendors(136, 137, 134, false),2)
	self:addTradeSkillSpell(3449, 165, self:CombineVendors(138, 140, false),2)
	self:addTradeSkillSpell(7257, 165, self:CombineVendors(141, 142, false),2)
	self:addTradeSkillSpell(6618, 175, self:CombineVendors(131, 134, false),2)
	self:addTradeSkillSpell(7258, 190, self:CombineVendors(143, 144, false),2)
	self:addTradeSkillSpell(7259, 190, self:CombineVendors(145, 146, 147, 144, false),2)
	self:addTradeSkillSpell(3454, 200, self:CombineVendors(148, false),2)
	self:addTradeSkillSpell(11459, 200, self:CombineVendors(145, false),2)
	self:addTradeSkillSpell(11479, 225, self:CombineVendors(145, false),2)
	self:addTradeSkillSpell(11480, 225, self:CombineVendors(145, false),2)
	self:addTradeSkillSpell(11473, 245, self:CombineVendors(146, 147, false),2)
	self:addTradeSkillSpell(11476, 250, self:CombineVendors(149, 150, false),2)
	self:addTradeSkillSpell(11477, 250, self:CombineVendors(151, 152, false),2)
	self:addTradeSkillSpell(17554, 265, self:CombineVendors(136, 137, false),2)
	self:addTradeSkillSpell(17187, 275, self:CombineVendors(145, false),2)
	self:addTradeSkillSpell(17560, 275, self:CombineVendors(123, false),2)
	self:addTradeSkillSpell(28543, 305, self:CombineVendors(154, 155, 156, 157, 158, false),2)
	self:addTradeSkillSpell(28546, 315, self:CombineVendors(159, 160, false),2)
	self:addTradeSkillSpell(28549, 320, self:CombineVendors(161, 160, false),2)
	self:addTradeSkillSpell(39639, 330, self:CombineVendors(162, 163, false),2,9)
	self:addTradeSkillSpell(28555, 340, self:CombineVendors(157, 161, false),2)
	self:addTradeSkillSpell(28557, 345, self:CombineVendors(157, 161, false),2)
	self:addTradeSkillSpell(28562, 350, self:CombineVendors(157, 159, false),2)
	self:addTradeSkillSpell(29688, 350, self:CombineVendors(155, 158, 164, false),2)

	-- World Drops
	self:addTradeSkillSpell(3230, 50, L["UWD"],3)
	self:addTradeSkillSpell(2335, 60, L["UWD"],3)
	self:addTradeSkillSpell(8240, 90, L["UWD"],3)
	self:addTradeSkillSpell(3172, 110, L["UWD"],3)
	self:addTradeSkillSpell(3174, 120, L["UWD"],3)
	self:addTradeSkillSpell(2333, 140, L["UWD"],3)
	self:addTradeSkillSpell(3188, 150, L["UWD"],3)
	self:addTradeSkillSpell(3450, 175, L["UWD"],3)
	self:addTradeSkillSpell(3453, 195, L["UWD"],3)
	self:addTradeSkillSpell(11453, 210, L["UWD"],3)
	self:addTradeSkillSpell(11464, 235, L["UWD"],3)
	self:addTradeSkillSpell(11468, 240, L["UWD"],3)
	self:addTradeSkillSpell(11472, 245, L["UWD"],3)
	self:addTradeSkillSpell(3175, 250, L["UWD"],3)
	self:addTradeSkillSpell(17566, 275, L["UWD"],3)
	self:addTradeSkillSpell(17563, 275, L["UWD"],3)
	self:addTradeSkillSpell(17564, 275, L["UWD"],3)
	self:addTradeSkillSpell(17565, 275, L["UWD"],3)
	self:addTradeSkillSpell(17570, 280, L["UWD"],3)
	self:addTradeSkillSpell(17572, 285, L["UWD"],3)
	self:addTradeSkillSpell(17634, 300, L["UWD"],3)
	self:addTradeSkillSpell(28550, 320, L["UWD"],3)
	self:addTradeSkillSpell(28552, 325, L["UWD"],3)
	self:addTradeSkillSpell(28563, 350, L["UWD"],3)
	self:addTradeSkillSpell(28564, 350, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)
	self:addTradeSkillSpell(28565, 350, L["UWD"],3)
	self:addTradeSkillSpell(28570, 355, L["UWD"],3)
	self:addTradeSkillSpell(28578, 365, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]),3,5)

	-- Specific Drops
	self:addTradeSkillSpell(4508, 50, self:CombineQuests(L["Discolored Healing Potion Obt"],2,BZONE["Silverpine Forest"]), BFAC["Horde"],8)
	self:addTradeSkillSpell(3451, 180, L["CWD"] .. addon.br .. L["Mighty Trolls Blood Potion Obt"] .. BZONE["Razorfen Downs"],1,3)
	self:addTradeSkillSpell(11456, 210, L["Goblin Rocket Fuel Obt"])
	self:addTradeSkillSpell(4942, 215, self:CombineQuests(L["Lesser Stoneshield Potion Obt"],0,BZONE["Badlands"]),8)
	self:addTradeSkillSpell(11452, 215, self:CombineQuests(L["Restorative Potion Obt"],2,BZONE["Badlands"],L["Restorative Potion Obt"],1,BZONE["Loch Modan"]),8)
	self:addTradeSkillSpell(11458, 225, self:CombineMobs(true,L["Wildvine Potion Obt"],BZONE["Stranglethorn Vale"]) .. addon.br .. self:CombineMobs(true,L["Wildvine Potion Obt"],BZONE["The Hinterlands"]),3)
	self:addTradeSkillSpell(11466, 240, self:CombineMobs(true,L["Gift of Arthas Obt"],BZONE["Western Plaguelands"]),3)
	self:addTradeSkillSpell(26277, 250, self:CombineMobs(true,L["Elixir of Greater Firepower Obt"],BZONE["Searing Gorge"]),3)
	self:addTradeSkillSpell(17552, 255, self:CombineMobs(true,L["Mighty Rage Potion Obt"],BZONE["Burning Steppes"]),3)
	self:addTradeSkillSpell(17555, 270, self:CombineMobs(true,L["Elixir of the Sages Obt"],BZONE["Eastern Plaguelands"]),3)
	self:addTradeSkillSpell(17557, 275, self:CombineQuests(L["Elixir of Brute Force Obt"],0,BZONE["Un'Goro Crater"]),8)
	self:addTradeSkillSpell(17562, 275, self:CombineQuests(L["Spectral Essence Obt"],0,BZONE["Western Plaguelands"]),8)
	self:addTradeSkillSpell(17571, 280, self:CombineMobs(true,L["Elixir of the Mongoose Obt"],BZONE["Azshara"]),3)
	self:addTradeSkillSpell(17574, 290, self:CombineMobs(true,L["Greater Fire Protection Potion Obt"],BZONE["Lower Blackrock Spire"]),3)
	self:addTradeSkillSpell(17575, 290, self:CombineMobs(true,L["Greater Frost Protection Potion Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(17576, 290, self:CombineMobs(true,L["Greater Nature Protection Potion Obt"],BZONE["Western Plaguelands"]),3)
	self:addTradeSkillSpell(17577, 290, self:CombineMobs(true,L["Greater Arcane Protection Potion Obt"],BZONE["Winterspring"]),3)
	self:addTradeSkillSpell(17578, 290, self:CombineMobs(true,L["Greater Shadow Protection Potion Obt"],BZONE["Eastern Plaguelands"]),3)
	self:addTradeSkillSpell(17580, 295, self:CombineMobs(false,BBOSS["Darkmaster Gandling"],BZONE["Scholomance"]) .. addon.br .. L["Spectral Essence Obt"],4,5,8)
	self:addTradeSkillSpell(17635, 300, self:CombineMobs(true,BBOSS["General Drakkisath"],BZONE["Upper Blackrock Spire"]) .. addon.br .. self:AddSingleReputation(4, BFAC["The Sha'tar"]), BFAC["The Sha'tar"],3,5)
	self:addTradeSkillSpell(17636, 300, self:CombineMobs(true,BBOSS["Balnazzar"],BZONE["Stratholme"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"],3,5)
	self:addTradeSkillSpell(17637, 300, self:CombineMobs(true,BBOSS["Ras Frostwhisper"],BZONE["Scholomance"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Keepers of Time"]), BFAC["Keepers of Time"],3,5)
	self:addTradeSkillSpell(17638, 300, self:CombineMobs(true,BBOSS["Gyth"],BZONE["Upper Blackrock Spire"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Lower City"]), BFAC["Lower City"],3,5)
	self:addTradeSkillSpell(38960, 335, self:CombineMobs(false,L["Fel Strength Elixir Obt"],BZONE["Shadowmoon Valley"]),4)
	self:addTradeSkillSpell(38962, 345, self:CombineMobs(false,L["Fel Regeneration Potion Obt"],BZONE["Shadowmoon Valley"]),4)
	self:addTradeSkillSpell(28575, 360, self:CombineMobs(false,L["Major Arcane Protection Potion Obt"],BZONE["Nagrand"]),4)
	self:addTradeSkillSpell(28571, 360, self:CombineMobs(false,L["Major Fire Protection Potion Obt"],BZONE["The Mechanar"]),4,5)
	self:addTradeSkillSpell(28572, 360, self:CombineMobs(false,BBOSS["Nexus-Prince Shaffar"],BZONE["Mana-Tombs"]),4,5)
	self:addTradeSkillSpell(28577, 360, self:CombineMobs(false,L["Major Holy Protection Potion Obt"],BZONE["Blade's Edge Mountains"]),4)
	self:addTradeSkillSpell(28576, 360, self:CombineMobs(false,L["Major Shadow Protection Potion Obt"],BZONE["Shadowmoon Valley"]),4)
	self:addTradeSkillSpell(38961, 360, self:CombineMobs(false,L["Fel Mana Potion Obt"],BZONE["Shadowmoon Valley"]),4)
	self:addTradeSkillSpell(28579, 365, self:CombineMobs(false,BBOSS["Captain Skarloc"],BZONE["Old Hillsbrad Foothills"]),4,5)

	-- Seasonal
	self:addTradeSkillSpell(21923, 190, L["WintersVeil"], 7)

	-- Reputations
	self:addTradeSkillSpell(17559, 275, self:AddSingleReputation(2, BFAC["Argent Dawn"]), BFAC["Argent Dawn"])
	self:addTradeSkillSpell(17561, 275, self:AddSingleReputation(1, BFAC["Timbermaw Hold"]), BFAC["Timbermaw Hold"])
	self:addTradeSkillSpell(24365, 275, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24366, 275, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24367, 285, self:AddSingleReputation(4, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(24368, 290, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), BFAC["Zandalar Tribe"], 6)
	self:addTradeSkillSpell(25146, 300, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), BFAC["Thorium Brotherhood"])
	self:addTradeSkillSpell(17632, 350, self:AddSingleReputation(3, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(28556, 345, self:AddSingleReputation(3, BFAC["The Scryers"]), BFAC["The Scryers"])
	self:addTradeSkillSpell(28558, 350, self:AddSingleReputation(3, BFAC["Lower City"]), BFAC["Lower City"])
	self:addTradeSkillSpell(28566, 350, self:AddSingleReputation(3, BFAC["The Sha'tar"]), BFAC["The Sha'tar"])
	self:addTradeSkillSpell(28567, 350, self:AddSingleReputation(3, BFAC["Sporeggar"]), BFAC["Sporeggar"])
	self:addTradeSkillSpell(28568, 350, self:AddDoubleReputation(3, BFAC["Kurenai"], BFAC["The Mag'har"]), BFAC["The Mag'har"])
	self:addTradeSkillSpell(28569, 350, self:AddSingleReputation(3, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32765, 350, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(32766, 350, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(28573, 360, self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(42736, 375, self:AddSingleReputation(2, BFAC["The Violet Eye"]), BFAC["The Violet Eye"], 6)
	self:addTradeSkillSpell(39637, 320, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), BFAC["Cenarion Expedition"])
	self:addTradeSkillSpell(28553, 330, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), BFAC["Thrallmar"])
	self:addTradeSkillSpell(28554, 335, self:AddSingleReputation(4, BFAC["Sporeggar"]), BFAC["Sporeggar"])
	self:addTradeSkillSpell(47046, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"], 15)
	self:addTradeSkillSpell(47048, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"], 17)
	self:addTradeSkillSpell(47049, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"], 16)
	self:addTradeSkillSpell(47050, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), BFAC["Shattered Sun Offensive"], 14)

	-- Raid Drops
	self:addTradeSkillSpell(22732, 300, L["MOLTENCORE"], 6)
	self:addTradeSkillSpell(24266, 300, L["Gurubashi Mojo Madness Obt"], 6)

	-- Discovery Recipes
	self:addTradeSkillSpell(28583, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28580, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28584, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28585, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28582, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28581, 350, L["Discovery - Transmutes"], L["Discovery"])
	self:addTradeSkillSpell(28587, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(28588, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(28589, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(28590, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(28591, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(28586, 360, L["Discovery - Flasks/Potions"], L["Discovery"])
	self:addTradeSkillSpell(41458, 375, L["Discovery - Protection Potions"], L["Discovery"])
	self:addTradeSkillSpell(41500, 375, L["Discovery - Protection Potions"], L["Discovery"])
	self:addTradeSkillSpell(41501, 375, L["Discovery - Protection Potions"], L["Discovery"])
	self:addTradeSkillSpell(41502, 375, L["Discovery - Protection Potions"], L["Discovery"])
	self:addTradeSkillSpell(41503, 375, L["Discovery - Protection Potions"], L["Discovery"])

	if (addon.wrath) then
		--self:addTradeSkillSpell(54213, 355, L["Trainer"],1) -- Flask of mojo
	end

end
