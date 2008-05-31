--[[

ARL-Alchemy.lua

Alchemy data for all of AckisRecipeList

$Date: 2008-05-29 13:12:20 -0400 (Thu, 29 May 2008) $
$Rev: 75475 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("AckisRecipeList")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BBOSS		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitAlchemy()

	-- Trainer Recipes
	self:addTradeSkillSpell(2330, 1, L["Trainer"])
	self:addTradeSkillSpell(2329, 1, L["Trainer"])
	self:addTradeSkillSpell(7183, 1, L["Trainer"])
	self:addTradeSkillSpell(3170, 15, L["Trainer"])
	self:addTradeSkillSpell(2331, 25, L["Trainer"])
	self:addTradeSkillSpell(2332, 40, L["Trainer"])
	self:addTradeSkillSpell(2334, 50, L["Trainer"])
	self:addTradeSkillSpell(2337, 55, L["Trainer"])
	self:addTradeSkillSpell(7836, 80, L["Trainer"])
	self:addTradeSkillSpell(3171, 90, L["Trainer"])
	self:addTradeSkillSpell(7179, 90, L["Trainer"])
	self:addTradeSkillSpell(7841, 100, L["Trainer"])
	self:addTradeSkillSpell(3447, 110, L["Trainer"])
	self:addTradeSkillSpell(3173, 120, L["Trainer"])
	self:addTradeSkillSpell(3176, 125, L["Trainer"])
	self:addTradeSkillSpell(3177, 130, L["Trainer"])
	self:addTradeSkillSpell(7837, 130, L["Trainer"])
	self:addTradeSkillSpell(7845, 140, L["Trainer"])
	self:addTradeSkillSpell(7181, 155, L["Trainer"])
	self:addTradeSkillSpell(3452, 160, L["Trainer"])
	self:addTradeSkillSpell(3448, 165, L["Trainer"])
	self:addTradeSkillSpell(11449, 185, L["Trainer"])
	self:addTradeSkillSpell(11450, 195, L["Trainer"])
	self:addTradeSkillSpell(12609, 200, L["Trainer"])
	self:addTradeSkillSpell(11451, 205, L["Trainer"])
	self:addTradeSkillSpell(11448, 205, L["Trainer"])
	self:addTradeSkillSpell(11457, 215, L["Trainer"])
	self:addTradeSkillSpell(22808, 215, L["Trainer"])
	self:addTradeSkillSpell(11460, 230, L["Trainer"])
	self:addTradeSkillSpell(15833, 230, L["Trainer"])
	self:addTradeSkillSpell(11461, 235, L["Trainer"])
	self:addTradeSkillSpell(11465, 235, L["Trainer"])
	self:addTradeSkillSpell(11467, 240, L["Trainer"])
	self:addTradeSkillSpell(11478, 250, L["Trainer"])
	self:addTradeSkillSpell(17551, 250, L["Trainer"])
	self:addTradeSkillSpell(17553, 260, L["Trainer"] .. addon.br .. self:CombineVendors(134, false))
	self:addTradeSkillSpell(17556, 275, L["Trainer"])
	self:addTradeSkillSpell(17573, 285, L["Trainer"])
	self:addTradeSkillSpell(33740, 300, L["Trainer"])
	self:addTradeSkillSpell(33738, 300, L["Trainer"])
	self:addTradeSkillSpell(33732, 300, L["Trainer"])
	self:addTradeSkillSpell(28544, 305, L["Trainer"])
	self:addTradeSkillSpell(28545, 310, L["Trainer"])
	self:addTradeSkillSpell(39636, 310, L["Trainer"])
	self:addTradeSkillSpell(33733, 310, L["Trainer"])
	self:addTradeSkillSpell(45061, 325, L["Trainer"])
	self:addTradeSkillSpell(33741, 315, L["Trainer"])
	self:addTradeSkillSpell(39638, 320, L["Trainer"])
	self:addTradeSkillSpell(38070, 325, L["Trainer"])
	self:addTradeSkillSpell(28551, 325, L["Trainer"])

	-- Vendor Recipes
	self:addTradeSkillSpell(6617, 60, self:CombineVendors(130, 131, 12, 132, false))
	self:addTradeSkillSpell(7255, 100, self:CombineVendors(133, 76, 132, false))
	self:addTradeSkillSpell(7256, 135, self:CombineVendors(110, 135, false))
	self:addTradeSkillSpell(6624, 150, self:CombineVendors(136, 137, 134, false))
	self:addTradeSkillSpell(3449, 165, self:CombineVendors(138, 140, false))
	self:addTradeSkillSpell(7257, 165, self:CombineVendors(141, 142, false))
	self:addTradeSkillSpell(6618, 175, self:CombineVendors(131, 134, false))
	self:addTradeSkillSpell(7258, 190, self:CombineVendors(143, 144, false))
	self:addTradeSkillSpell(7259, 190, self:CombineVendors(145, 146, 147, 144, false))
	self:addTradeSkillSpell(3454, 200, self:CombineVendors(148, false))
	self:addTradeSkillSpell(11459, 225, self:CombineVendors(145, false))
	self:addTradeSkillSpell(11479, 225, self:CombineVendors(145, false))
	self:addTradeSkillSpell(11480, 225, self:CombineVendors(145, false))
	self:addTradeSkillSpell(11473, 245, self:CombineVendors(146, 147, false))
	self:addTradeSkillSpell(11476, 250, self:CombineVendors(149, 150, false))
	self:addTradeSkillSpell(11477, 250, self:CombineVendors(151, 152, false))
	self:addTradeSkillSpell(17554, 265, self:CombineVendors(136, 137, false))
	self:addTradeSkillSpell(17187, 275, self:CombineVendors(145, false))
	self:addTradeSkillSpell(17560, 275, self:CombineVendors(123, false))
	self:addTradeSkillSpell(28543, 305, self:CombineVendors(154, 155, 156, 157, 158, false))
	self:addTradeSkillSpell(28546, 315, self:CombineVendors(159, 160, false))
	self:addTradeSkillSpell(28549, 320, self:CombineVendors(161, 160, false))
	self:addTradeSkillSpell(39639, 330, self:CombineVendors(162, 163, false), {L["PVP"]})
	self:addTradeSkillSpell(28555, 340, self:CombineVendors(157, 161, false))
	self:addTradeSkillSpell(28557, 345, self:CombineVendors(157, 161, false))
	self:addTradeSkillSpell(28562, 350, self:CombineVendors(157, 159, false))
	self:addTradeSkillSpell(29688, 350, self:CombineVendors(155, 158, 164, false))

	-- World Drops
	self:addTradeSkillSpell(3230, 50, L["UWD"])
	self:addTradeSkillSpell(2335, 60, L["UWD"])
	self:addTradeSkillSpell(8240, 90, L["UWD"])
	self:addTradeSkillSpell(3172, 110, L["UWD"])
	self:addTradeSkillSpell(3174, 120, L["UWD"])
	self:addTradeSkillSpell(2333, 140, L["UWD"])
	self:addTradeSkillSpell(3188, 150, L["UWD"])
	self:addTradeSkillSpell(3450, 175, L["UWD"])
	self:addTradeSkillSpell(3453, 195, L["UWD"])
	self:addTradeSkillSpell(11453, 210, L["UWD"])
	self:addTradeSkillSpell(11464, 235, L["UWD"])
	self:addTradeSkillSpell(11468, 240, L["UWD"])
	self:addTradeSkillSpell(11472, 245, L["UWD"])
	self:addTradeSkillSpell(3175, 250, L["UWD"])
	self:addTradeSkillSpell(17566, 275, L["UWD"])
	self:addTradeSkillSpell(17563, 275, L["UWD"])
	self:addTradeSkillSpell(17564, 275, L["UWD"])
	self:addTradeSkillSpell(17565, 275, L["UWD"])
	self:addTradeSkillSpell(17570, 280, L["UWD"])
	self:addTradeSkillSpell(17572, 285, L["UWD"])
	self:addTradeSkillSpell(17634, 300, L["UWD"])
	self:addTradeSkillSpell(28550, 320, L["UWD"])
	self:addTradeSkillSpell(28552, 325, L["UWD"])
	self:addTradeSkillSpell(28563, 350, L["UWD"])
	self:addTradeSkillSpell(28564, 350, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]))
	self:addTradeSkillSpell(28565, 350, L["UWD"])
	self:addTradeSkillSpell(28570, 355, L["UWD"])
	self:addTradeSkillSpell(28578, 365, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]))

	-- Specific Drops
	self:addTradeSkillSpell(4508, 50, self:CombineQuests(L["Discolored Healing Potion Obt"],2,BZONE["Silverpine Forest"]), {BFAC["Horde"]})
	self:addTradeSkillSpell(3451, 180, L["CWD"] .. addon.br .. L["Mighty Trolls Blood Potion Obt"] .. BZONE["Razorfen Downs"])
	self:addTradeSkillSpell(11456, 210, L["Goblin Rocket Fuel Obt"])
	self:addTradeSkillSpell(4942, 215, self:CombineQuests(L["Lesser Stoneshield Potion Obt"],0,BZONE["Badlands"]))
	self:addTradeSkillSpell(11452, 215, self:CombineQuests(L["Restorative Potion Obt"],0,BZONE["Badlands"]))
	self:addTradeSkillSpell(11458, 225, L["Wildvine Potion Obt"])
	self:addTradeSkillSpell(11466, 240, L["Gift of Arthas Obt"])
	self:addTradeSkillSpell(26277, 250, self:CombineMobs(true,L["Elixir of Greater Firepower Obt"],BZONE["Searing Gorge"]))
	self:addTradeSkillSpell(17552, 255, L["Mighty Rage Potion Obt"])
	self:addTradeSkillSpell(17555, 270, L["Elixir of the Sages Obt"])
	self:addTradeSkillSpell(17557, 275, self:CombineQuests(L["Elixir of Brute Force Obt"],0,BZONE["Un'Goro Crater"]))
	self:addTradeSkillSpell(17562, 275, L["Spectral Essence Obt"])
	self:addTradeSkillSpell(17571, 280, L["Elixir of the Mongoose Obt"])
	self:addTradeSkillSpell(17574, 290, L["Greater Fire Protection Potion Obt"])
	self:addTradeSkillSpell(17575, 290, L["Greater Frost Protection Potion Obt"])
	self:addTradeSkillSpell(17576, 290, L["Greater Nature Protection Potion Obt"])
	self:addTradeSkillSpell(17577, 290, L["Greater Arcane Protection Potion Obt"])
	self:addTradeSkillSpell(17578, 290, L["Greater Shadow Protection Potion Obt"])
	self:addTradeSkillSpell(17580, 295, self:CombineMobs(true,BBOSS["Darkmaster Gandling"],BZONE["Scholomance"]) .. addon.br .. L["Spectral Essence Obt"])
	self:addTradeSkillSpell(17635, 300, self:CombineMobs(false,BBOSS["General Drakkisath"],BZONE["Upper Blackrock Spire"]) .. addon.br .. self:AddSingleReputation(4, BFAC["The Sha'tar"]), {BFAC["The Sha'tar"]})
	self:addTradeSkillSpell(17636, 300, self:CombineMobs(false,BBOSS["Balnazzar"],BZONE["Stratholme"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(17637, 300, self:CombineMobs(false,BBOSS["Ras Frostwhisper"],BZONE["Scholomance"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Keepers of Time"]), {BFAC["Keepers of Time"]})
	self:addTradeSkillSpell(17638, 300, self:CombineMobs(false,BBOSS["Gyth"],BZONE["Upper Blackrock Spire"]) .. addon.br .. self:AddSingleReputation(4, BFAC["Lower City"]), {BFAC["Lower City"]})
	self:addTradeSkillSpell(38960, 335, L["Fel Strength Elixir Obt"])
	self:addTradeSkillSpell(38962, 345, L["Fel Regeneration Potion Obt"])
	self:addTradeSkillSpell(28575, 360, L["Major Arcane Protection Potion Obt"])
	self:addTradeSkillSpell(28571, 360, L["Major Fire Protection Potion Obt"])
	self:addTradeSkillSpell(28572, 360, L["Major Frost Protection Potion Obt"])
	self:addTradeSkillSpell(28577, 360, L["Major Holy Protection Potion Obt"])
	self:addTradeSkillSpell(28576, 360, L["Major Shadow Protection Potion Obt"])
	self:addTradeSkillSpell(38961, 360, L["Fel Mana Potion Obt"])
	self:addTradeSkillSpell(28579, 365, self:CombineMobs(true,BBOSS["Captain Skarloc"],BZONE["Old Hillsbrad Foothills"]))

	-- Seasonal
	self:addTradeSkillSpell(21923, 190, L["WintersVeil"], {L["Seasonal"]})

	-- Reputations
	self:addTradeSkillSpell(17559, 275, self:AddSingleReputation(2, BFAC["Argent Dawn"]), {BFAC["Argent Dawn"]})
	self:addTradeSkillSpell(17561, 275, self:AddSingleReputation(1, BFAC["Timbermaw Hold"]), {BFAC["Timbermaw Hold"]})
	self:addTradeSkillSpell(24365, 275, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24366, 275, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24367, 285, self:AddSingleReputation(4, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24368, 290, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(25146, 300, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(17632, 350, self:AddSingleReputation(3, BFAC["The Sha'tar"]), {BFAC["The Sha'tar"]})
	self:addTradeSkillSpell(28556, 345, self:AddSingleReputation(3, BFAC["The Scryers"]), {BFAC["The Scryers"]})
	self:addTradeSkillSpell(28558, 350, self:AddSingleReputation(3, BFAC["Lower City"]), {BFAC["Lower City"]})
	self:addTradeSkillSpell(28566, 350, self:AddSingleReputation(3, BFAC["The Sha'tar"]), {BFAC["The Sha'tar"]})
	self:addTradeSkillSpell(28567, 350, self:AddSingleReputation(3, BFAC["Sporeggar"]), {BFAC["Sporeggar"]})
	self:addTradeSkillSpell(28568, 350, self:AddDoubleReputation(3, BFAC["Kurenai"], BFAC["The Mag'har"]), {BFAC["The Mag'har"]})
	self:addTradeSkillSpell(28569, 350, self:AddSingleReputation(3, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(32765, 350, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(32766, 350, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), {BFAC["Thrallmar"]})
	self:addTradeSkillSpell(28573, 360, self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(42736, 375, self:AddSingleReputation(2, BFAC["The Violet Eye"]), {BFAC["The Violet Eye"], L["Raid"]})
	self:addTradeSkillSpell(39637, 320, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(28553, 330, self:AddDoubleReputation(2, BFAC["Honor Hold"], BFAC["Thrallmar"]), {BFAC["Thrallmar"]})
	self:addTradeSkillSpell(28554, 335, self:AddSingleReputation(4, BFAC["Sporeggar"]), {BFAC["Sporeggar"]})
	self:addTradeSkillSpell(47046, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), {BFAC["Shattered Sun Offensive"]})
	self:addTradeSkillSpell(47048, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), {BFAC["Shattered Sun Offensive"]})
	self:addTradeSkillSpell(47049, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), {BFAC["Shattered Sun Offensive"]})
	self:addTradeSkillSpell(47050, 375, self:AddSingleReputation(4, BFAC["Shattered Sun Offensive"]), {BFAC["Shattered Sun Offensive"]})

	-- Raid Drops
	self:addTradeSkillSpell(22732, 300, L["MOLTENCORE"], {L["Raid"]})
	self:addTradeSkillSpell(24266, 300, L["Gurubashi Mojo Madness Obt"], {L["Raid"]})

	-- Discovery Recipes
	self:addTradeSkillSpell(28583, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28580, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28584, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28585, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28582, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28581, 350, L["Discovery - Transmutes"], {L["Discovery"]})
	self:addTradeSkillSpell(28587, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(28588, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(28589, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(28590, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(28591, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(28586, 360, L["Discovery - Flasks/Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(41458, 375, L["Discovery - Protection Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(41500, 375, L["Discovery - Protection Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(41501, 375, L["Discovery - Protection Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(41502, 375, L["Discovery - Protection Potions"], {L["Discovery"]})
	self:addTradeSkillSpell(41503, 375, L["Discovery - Protection Potions"], {L["Discovery"]})

end
