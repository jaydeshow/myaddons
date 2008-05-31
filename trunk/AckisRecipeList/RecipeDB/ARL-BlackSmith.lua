--[[

ARLBlackSmith-.lua

Blacksmithing data for all of AckisRecipeList

$Date: 2008-05-29 13:12:20 -0400 (Thu, 29 May 2008) $
$Rev: 75475 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("AckisRecipeList")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BBOSS		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitBlackSmith()

	-- Trainer Recipes
	self:addTradeSkillSpell(2660, 1, L["Trainer"])
	self:addTradeSkillSpell(2663, 1, L["Trainer"])
	self:addTradeSkillSpell(12260, 1, L["Trainer"])
	self:addTradeSkillSpell(2662, 1, L["Trainer"])
	self:addTradeSkillSpell(2737, 15, L["Trainer"])
	self:addTradeSkillSpell(3319, 20, L["Trainer"])
	self:addTradeSkillSpell(2738, 20, L["Trainer"])
	self:addTradeSkillSpell(3115, 25, L["Trainer"])
	self:addTradeSkillSpell(3320, 25, L["Trainer"])
	self:addTradeSkillSpell(2739, 25, L["Trainer"])
	self:addTradeSkillSpell(8880, 30, L["Trainer"])
	self:addTradeSkillSpell(9983, 30, L["Trainer"])
	self:addTradeSkillSpell(3293, 35, L["Trainer"])
	self:addTradeSkillSpell(2661, 35, L["Trainer"])
	self:addTradeSkillSpell(3323, 40, L["Trainer"])
	self:addTradeSkillSpell(3324, 45, L["Trainer"])
	self:addTradeSkillSpell(3116, 65, L["Trainer"])
	self:addTradeSkillSpell(7408, 65, L["Trainer"])
	self:addTradeSkillSpell(2665, 65, L["Trainer"])
	self:addTradeSkillSpell(3326, 75, L["Trainer"])
	self:addTradeSkillSpell(2664, 90, L["Trainer"])
	self:addTradeSkillSpell(3294, 90, L["Trainer"])
	self:addTradeSkillSpell(2666, 90, L["Trainer"])
	self:addTradeSkillSpell(3292, 95, L["Trainer"])
	self:addTradeSkillSpell(7817, 95, L["Trainer"])
	self:addTradeSkillSpell(3491, 105, L["Trainer"])
	self:addTradeSkillSpell(7818, 100, L["Trainer"])
	self:addTradeSkillSpell(19666, 100, L["Trainer"])
	self:addTradeSkillSpell(34979, 100, L["Trainer"])
	self:addTradeSkillSpell(2668, 105, L["Trainer"])
	self:addTradeSkillSpell(2670, 105, L["Trainer"])
	self:addTradeSkillSpell(3328, 110, L["Trainer"])
	self:addTradeSkillSpell(2740, 110, L["Trainer"])
	self:addTradeSkillSpell(6517, 115, L["Trainer"])
	self:addTradeSkillSpell(2741, 115, L["Trainer"])
	self:addTradeSkillSpell(2742, 120, L["Trainer"])
	self:addTradeSkillSpell(2672, 120, L["Trainer"])
	self:addTradeSkillSpell(3117, 125, L["Trainer"])
	self:addTradeSkillSpell(3337, 125, L["Trainer"])
	self:addTradeSkillSpell(9985, 125, L["Trainer"])
	self:addTradeSkillSpell(2674, 125, L["Trainer"])
	self:addTradeSkillSpell(3296, 130, L["Trainer"])
	self:addTradeSkillSpell(3331, 130, L["Trainer"])
	self:addTradeSkillSpell(9986, 130, L["Trainer"])
	self:addTradeSkillSpell(3333, 135, L["Trainer"])
	self:addTradeSkillSpell(9987, 135, L["Trainer"])
	self:addTradeSkillSpell(2675, 145, L["Trainer"])
	self:addTradeSkillSpell(8768, 150, L["Trainer"])
	self:addTradeSkillSpell(14379, 150, L["Trainer"])
	self:addTradeSkillSpell(19667, 150, L["Trainer"])
	self:addTradeSkillSpell(3506, 155, L["Trainer"])
	self:addTradeSkillSpell(3501, 165, L["Trainer"])
	self:addTradeSkillSpell(3502, 170, L["Trainer"])
	self:addTradeSkillSpell(3508, 180, L["Trainer"])
	self:addTradeSkillSpell(15972, 180, L["Trainer"])
	self:addTradeSkillSpell(7223, 185, L["Trainer"])
	self:addTradeSkillSpell(9916, 200, L["Trainer"])
	self:addTradeSkillSpell(9918, 200, L["Trainer"])
	self:addTradeSkillSpell(9921, 200, L["Trainer"])
	self:addTradeSkillSpell(9920, 200, L["Trainer"])
	self:addTradeSkillSpell(14380, 200, L["Trainer"])
	self:addTradeSkillSpell(19668, 200, L["Trainer"])
	self:addTradeSkillSpell(34981, 200, L["Trainer"])
	self:addTradeSkillSpell(9926, 205, L["Trainer"])
	self:addTradeSkillSpell(9928, 205, L["Trainer"])
	self:addTradeSkillSpell(9931, 210, L["Trainer"])
	self:addTradeSkillSpell(9993, 210, L["Trainer"])
	self:addTradeSkillSpell(9935, 215, L["Trainer"])
	self:addTradeSkillSpell(9959, 230, L["Trainer"])
	self:addTradeSkillSpell(9961, 230, L["Trainer"])
	self:addTradeSkillSpell(10001, 230, L["Trainer"])
	self:addTradeSkillSpell(9968, 235, L["Trainer"])
	self:addTradeSkillSpell(9972, 235, L["Trainer"])
	self:addTradeSkillSpell(9979, 240, L["Trainer"])
	self:addTradeSkillSpell(16641, 250, L["Trainer"])
	self:addTradeSkillSpell(16640, 250, L["Trainer"])
	self:addTradeSkillSpell(16639, 250, L["Trainer"])
	self:addTradeSkillSpell(19669, 275, L["Trainer"])
	self:addTradeSkillSpell(20201, 275, L["Trainer"])
	self:addTradeSkillSpell(34982, 300, L["Trainer"])
	self:addTradeSkillSpell(10003, 235 , L["Trainer"])
	self:addTradeSkillSpell(10007, 245, L["Trainer"])
	self:addTradeSkillSpell(10011, 250, L["Trainer"])
	self:addTradeSkillSpell(10015, 260, L["Trainer"])
  	self:addTradeSkillSpell(9954, 225, L["Trainer"])
	self:addTradeSkillSpell(9974, 245, L["Trainer"])
	self:addTradeSkillSpell(29654, 300, L["Trainer"])
	self:addTradeSkillSpell(34607, 300, L["Trainer"])
	self:addTradeSkillSpell(32655, 300, L["Trainer"])
	self:addTradeSkillSpell(29551, 300, L["Trainer"])
	self:addTradeSkillSpell(29545, 300, L["Trainer"])
	self:addTradeSkillSpell(29547, 305, L["Trainer"])
	self:addTradeSkillSpell(29557, 310, L["Trainer"])
	self:addTradeSkillSpell(29552, 310, L["Trainer"])
	self:addTradeSkillSpell(29548, 315, L["Trainer"])
	self:addTradeSkillSpell(29549, 315, L["Trainer"])
	self:addTradeSkillSpell(29553, 315, L["Trainer"])
	self:addTradeSkillSpell(29558, 315, L["Trainer"])
	self:addTradeSkillSpell(29565, 320, L["Trainer"])
	self:addTradeSkillSpell(29556, 320, L["Trainer"])
	self:addTradeSkillSpell(29550, 325, L["Trainer"])
	self:addTradeSkillSpell(32284, 325, L["Trainer"])
	self:addTradeSkillSpell(34983, 350, L["Trainer"])

	-- Vendor Recipes
	self:addTradeSkillSpell(3494, 155, self:CombineVendors(171, 172, 173, false))
	self:addTradeSkillSpell(3492, 160, self:CombineVendors(174, 175, 176, false))
	self:addTradeSkillSpell(3496, 180, self:CombineVendors(177, false))
	self:addTradeSkillSpell(3498, 185, self:CombineVendors(178, 179, false))
	self:addTradeSkillSpell(3503, 190, self:CombineVendors(180, false))
	self:addTradeSkillSpell(9937, 215, self:CombineVendors(181, 182, false))
	self:addTradeSkillSpell(29566, 325, self:CombineVendors(183, 184, 185, false))
	self:addTradeSkillSpell(29568, 330, self:CombineVendors(183, 184, 185, false))
	self:addTradeSkillSpell(29569, 330, self:CombineVendors(183, 184, 185, false))
	self:addTradeSkillSpell(29571, 335, self:CombineVendors(183, 184, 185, false))
	self:addTradeSkillSpell(29603, 335, self:CombineVendors(186, 187, false))
	self:addTradeSkillSpell(29605, 335, self:CombineVendors(186, 187, false))
	self:addTradeSkillSpell(29728, 340, self:CombineVendors(188, 189, false))
	self:addTradeSkillSpell(29606, 340, self:CombineVendors(186, 187, false))
	self:addTradeSkillSpell(32656, 350, self:CombineVendors(183, false))
	self:addTradeSkillSpell(32657, 375, self:CombineVendors(188, 189, false))

	-- World Drops
	self:addTradeSkillSpell(3321, 35, L["UWD"])
	self:addTradeSkillSpell(3325, 60, L["UWD"])
	self:addTradeSkillSpell(2667, 80, L["UWD"])
	self:addTradeSkillSpell(3295, 125, L["UWD"])
	self:addTradeSkillSpell(3330, 125, L["UWD"])
	self:addTradeSkillSpell(2673, 130, L["UWD"])
	self:addTradeSkillSpell(6518, 140, L["UWD"])
	self:addTradeSkillSpell(3297, 145, L["UWD"])
	self:addTradeSkillSpell(3334, 145, L["UWD"])
	self:addTradeSkillSpell(3336, 150, L["UWD"])
	self:addTradeSkillSpell(7221, 150, L["UWD"])
	self:addTradeSkillSpell(12259, 155, L["UWD"])
	self:addTradeSkillSpell(3504, 160, L["UWD"])
	self:addTradeSkillSpell(7222, 165, L["UWD"])
	self:addTradeSkillSpell(3495, 170, L["UWD"])
	self:addTradeSkillSpell(3507, 170, L["UWD"])
	self:addTradeSkillSpell(3493, 175, L["UWD"])
	self:addTradeSkillSpell(3505, 175, L["UWD"])
	self:addTradeSkillSpell(3513, 185, L["UWD"])
	self:addTradeSkillSpell(7224, 190, L["UWD"])
	self:addTradeSkillSpell(15973, 190, L["UWD"])
	self:addTradeSkillSpell(3511, 195, L["UWD"])
	self:addTradeSkillSpell(3497, 200, L["UWD"])
	self:addTradeSkillSpell(3500, 200, L["UWD"])
	self:addTradeSkillSpell(3515, 200, L["UWD"])
	self:addTradeSkillSpell(9933, 210, L["UWD"])
	self:addTradeSkillSpell(9939, 215, L["UWD"])
	self:addTradeSkillSpell(9995, 220, L["UWD"])
	self:addTradeSkillSpell(9997, 225, L["UWD"])
	self:addTradeSkillSpell(9964, 235, L["UWD"])
	self:addTradeSkillSpell(9966, 235, L["UWD"])
	self:addTradeSkillSpell(10005, 240, L["UWD"])
	self:addTradeSkillSpell(9970, 245, L["UWD"])
	self:addTradeSkillSpell(10009, 245, L["UWD"])
	self:addTradeSkillSpell(16642, 250, L["UWD"])
	self:addTradeSkillSpell(16643, 250, L["UWD"])
	self:addTradeSkillSpell(16644, 255, L["UWD"])
	self:addTradeSkillSpell(16645, 260, L["UWD"])
	self:addTradeSkillSpell(16648, 270, L["UWD"])
	self:addTradeSkillSpell(16651, 275, L["UWD"])
	self:addTradeSkillSpell(16652, 280, L["UWD"])
	self:addTradeSkillSpell(16653, 280, L["UWD"])
	self:addTradeSkillSpell(16654, 285, L["UWD"])
	self:addTradeSkillSpell(16656, 290, L["UWD"])
	self:addTradeSkillSpell(16659, 295, L["UWD"])
	self:addTradeSkillSpell(16662, 300, L["UWD"])
	self:addTradeSkillSpell(16725, 300, L["UWD"])
	self:addTradeSkillSpell(16650, 270, L["UWD"])
	self:addTradeSkillSpell(16660, 290, L["UWD"])
	self:addTradeSkillSpell(16724, 300, L["UWD"])
	self:addTradeSkillSpell(16728, 300, L["RWD"])
	self:addTradeSkillSpell(16729, 300, L["EWD"])
	self:addTradeSkillSpell(16741, 300, L["EWD"])
	self:addTradeSkillSpell(27829, 300, L["EWD"])
	self:addTradeSkillSpell(27832, 300, L["EWD"])
	self:addTradeSkillSpell(27830, 300, L["EWD"])
	self:addTradeSkillSpell(42688, 335, L["UWD"] .. addon.br .. self:CombineMobs(false,BBOSS["Kael'thas Sunstrider"],BZONE["Magisters' Terrace"]))
	self:addTradeSkillSpell(29622, 365, L["EWD"])
	self:addTradeSkillSpell(29658, 365, L["EWD"])
	self:addTradeSkillSpell(29662, 365, L["EWD"])
	self:addTradeSkillSpell(29663, 365, L["EWD"])
	self:addTradeSkillSpell(29664, 365, L["EWD"])
	self:addTradeSkillSpell(29668, 365, L["EWD"])
	self:addTradeSkillSpell(29669, 365, L["EWD"])
	self:addTradeSkillSpell(29671, 365, L["EWD"])
	self:addTradeSkillSpell(29672, 365, L["EWD"])
	self:addTradeSkillSpell(29692, 365, L["EWD"])
	self:addTradeSkillSpell(29693, 365, L["EWD"])
	self:addTradeSkillSpell(29694, 365, L["EWD"])
	self:addTradeSkillSpell(29695, 365, L["EWD"])
	self:addTradeSkillSpell(29696, 365, L["EWD"])
	self:addTradeSkillSpell(29697, 365, L["EWD"])
	self:addTradeSkillSpell(29698, 365, L["EWD"])
	self:addTradeSkillSpell(43846, 365, L["EWD"])
	self:addTradeSkillSpell(29699, 365, L["EWD"])
	self:addTradeSkillSpell(29700, 365, L["EWD"])

	-- Specific Drops
	self:addTradeSkillSpell(43549, 35, L["UWD"] .. addon.br .. L["Heavy Copper Longsword Obt"])
	self:addTradeSkillSpell(8367, 100, L["Ironforge Breastplate Obt"], {BFAC["Alliance"]})
	self:addTradeSkillSpell(9811, 160, L["Barbaric Iron Shoulders Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(9813, 160, L["Barbaric Iron Breastplate Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(9814, 175, L["Barbaric Iron Helm Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(9818, 180, L["Barbaric Iron Boots Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(9820, 185, L["Barbaric Iron Gloves Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(11454, 200, L["Inlaid Mithril Cylinder Obt"])
	self:addTradeSkillSpell(11643, 205, L["Golden Scale Gauntlets Obt"], {BFAC["Alliance"]})
	self:addTradeSkillSpell(9945, 220, L["Ornate Mithril Pants Obt"])
	self:addTradeSkillSpell(9950, 220, L["Ornate Mithril Gloves Obt"])
	self:addTradeSkillSpell(9952, 225, L["Ornate Mithril Shoulder Obt"])
	self:addTradeSkillSpell(9980, 245, L["Ornate Mithril Helm Obt"])
	self:addTradeSkillSpell(9957, 210, L["Orcish War Leggings Obt"], {BFAC["Horde"]})
	self:addTradeSkillSpell(16646, 265, L["Imperial Plate Shoulders Obt"])
	self:addTradeSkillSpell(16647, 265, L["Imperial Plate Belt Obt"])
	self:addTradeSkillSpell(15293, 270, L["Blacksmithing Plans"])
	self:addTradeSkillSpell(16649, 270, L["Imperial Plate Bracers Obt"])
	self:addTradeSkillSpell(10013, 255, L["Spectral Essence Obt"])
	self:addTradeSkillSpell(16971, 280, L["Spectral Essence Obt"])
	self:addTradeSkillSpell(16661, 295, L["Spectral Essence Obt"])
	self:addTradeSkillSpell(16969, 275, L["Spectral Essence Obt"])
	self:addTradeSkillSpell(15295, 280, L["Blacksmithing Plans"])
	self:addTradeSkillSpell(16657, 295, L["Imperial Plate Boots Obt"])
	self:addTradeSkillSpell(16658, 295, L["Imperial Plate Helm Obt"])
	self:addTradeSkillSpell(16663, 300, L["Imperial Plate Chest Obt"])
	self:addTradeSkillSpell(16664, 300, L["Runic Plate Shoulders Obt"])
	self:addTradeSkillSpell(16665, 300, L["Runic Plate Boots Obt"])
	self:addTradeSkillSpell(16726, 300, L["Runic Plate Helm Obt"])
	self:addTradeSkillSpell(16730, 300, L["Imperial Plate Leggings Obt"])
	self:addTradeSkillSpell(16731, 300, L["Runic Breastplate Obt"])
	self:addTradeSkillSpell(16732, 300, L["Runic Plate Leggings Obt"])
	self:addTradeSkillSpell(21161, 300, L["Sulfuron Hammer Obt"], {L["Raid"]})
	self:addTradeSkillSpell(24914, 300, L["TrueBelieverQuest"])
	self:addTradeSkillSpell(24912, 300, L["TrueBelieverQuest"])
	self:addTradeSkillSpell(24913, 300, L["TrueBelieverQuest"])
	self:addTradeSkillSpell(16984, 290, L["Volcanic Hammer Obt"])
	self:addTradeSkillSpell(15294, 275, L["Dark Iron Sunderer Obt"])
	self:addTradeSkillSpell(16995, 300, L["Heartseeker Obt"])
	self:addTradeSkillSpell(15296, 285, L["Dark Iron Plate Obt"])
	self:addTradeSkillSpell(16667, 285, L["Demon Forged Breastplate Obt"])
	self:addTradeSkillSpell(16655, 290, L["Fiery Plate Gauntlets Obt"])
	self:addTradeSkillSpell(16742, 300, L["Enchanted Thorium Helm Obt"])
	self:addTradeSkillSpell(16744, 300, L["Enchanted Thorium Leggings Obt"])
	self:addTradeSkillSpell(16745, 300, L["Enchanted Thorium Breastplate Obt"])
	self:addTradeSkillSpell(16746, 300, L["EWD"] .. addon.br .. L["Invulnerable Mail Obt"])
	self:addTradeSkillSpell(16990, 300, L["Arcanite Champion Obt"])
	self:addTradeSkillSpell(16992, 300, L["Frostguard Obt"])
	self:addTradeSkillSpell(16985, 290, L["Blacksmithing Plans"])
	self:addTradeSkillSpell(16983, 285, L["Blacksmithing Plans"])
	self:addTradeSkillSpell(16988, 300, L["Hammer of the Titans Obt"])
	self:addTradeSkillSpell(16993, 300, L["Masterwork Stormhammer Obt"])
	self:addTradeSkillSpell(16991, 300, L["Annihilator Obt"])
	self:addTradeSkillSpell(16994, 300, L["Arcanite Reaper Obt"])
	self:addTradeSkillSpell(29619, 360, L["Felsteel Gloves Obt"])
	self:addTradeSkillSpell(29620, 360, L["Felsteel Leggings Obt"])
	self:addTradeSkillSpell(29628, 360, L["Khorium Belt Obt"])
	self:addTradeSkillSpell(29629, 360, L["Khorium Pants Obt"])
	self:addTradeSkillSpell(29621, 365, L["Felsteel Helm Obt"])
	self:addTradeSkillSpell(29630, 365, L["Khorium Boots Obt"])
	self:addTradeSkillSpell(29642, 365, L["Ragesteel Gloves Obt"])
	self:addTradeSkillSpell(29643, 365, L["Ragesteel Helm Obt"])
	self:addTradeSkillSpell(29645, 370, L["Ragesteel Breastplate Obt"])
	self:addTradeSkillSpell(29648, 370, L["Swiftsteel Gloves Obt"])
 	self:addTradeSkillSpell(29649, 370, L["Earthpeace Breastplate Obt"])
	self:addTradeSkillSpell(29729, 375, L["Greater Ward of Shielding Obt"])
	self:addTradeSkillSpell(42662, 365, L["Ragesteel Shoulders Obt"])

	-- Seasonal
	self:addTradeSkillSpell(21913, 190, L["WintersVeil"], {L["Seasonal"]})

	-- Reputations
	self:addTradeSkillSpell(23628, 290, self:AddSingleReputation(2, BFAC["Timbermaw Hold"]), {BFAC["Timbermaw Hold"]})
	self:addTradeSkillSpell(23632, 290, self:AddSingleReputation(2, BFAC["Argent Dawn"]), {BFAC["Argent Dawn"]})
	self:addTradeSkillSpell(23629, 300, self:AddSingleReputation(3, BFAC["Timbermaw Hold"]), {BFAC["Timbermaw Hold"]})
	self:addTradeSkillSpell(23633, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]), {BFAC["Argent Dawn"]})
	self:addTradeSkillSpell(24136, 300, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24138, 300, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24137, 300, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24139, 300, self:AddSingleReputation(3, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24140, 300, self:AddSingleReputation(2, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(24141, 300, self:AddSingleReputation(1, BFAC["Zandalar Tribe"]), {BFAC["Zandalar Tribe"], L["Raid"]})
	self:addTradeSkillSpell(27585, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(27588, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(27586, 300, self:AddSingleReputation(3, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(20897, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23653, 300, self:AddSingleReputation(4, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(28244, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], {BFAC["Argent Dawn"], L["Raid"]})
	self:addTradeSkillSpell(28243, 300, self:AddSingleReputation(3, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], {BFAC["Argent Dawn"], L["Raid"]})
	self:addTradeSkillSpell(28242, 300, self:AddSingleReputation(4, BFAC["Argent Dawn"]) .. addon.br .. L["ADNaxx"], {BFAC["Argent Dawn"], L["Raid"]})
	self:addTradeSkillSpell(23650, 300, self:AddSingleReputation(4, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(20890, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23652, 300, self:AddSingleReputation(4, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(20876, 300, self:AddSingleReputation(4, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(20873, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23636, 300, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23637, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(24399, 300, self:AddSingleReputation(4, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(20874, 295, self:AddSingleReputation(1, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(20872, 295, self:AddSingleReputation(2, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23638, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(23639, 300, self:AddSingleReputation(3, BFAC["Thorium Brotherhood"]), {BFAC["Thorium Brotherhood"]})
	self:addTradeSkillSpell(28461, 300, self:AddSingleReputation(3, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(28462, 300, self:AddSingleReputation(2, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(28463, 300, self:AddSingleReputation(1, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(27590, 300, self:AddSingleReputation(4, BFAC["Cenarion Circle"]), {BFAC["Cenarion Circle"]})
	self:addTradeSkillSpell(29656, 350, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(32285, 350, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(34608, 350, self:AddSingleReputation(2, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(29614, 350, self:AddSingleReputation(1, BFAC["The Aldor"]), {BFAC["The Aldor"]})
	self:addTradeSkillSpell(29608, 355, self:AddSingleReputation(1, BFAC["The Scryers"]), {BFAC["The Scryers"]})
	self:addTradeSkillSpell(29611, 355, self:AddSingleReputation(2, BFAC["The Scryers"]), {BFAC["The Scryers"]})
	self:addTradeSkillSpell(29615, 355, self:AddSingleReputation(4, BFAC["The Aldor"]), {BFAC["The Aldor"]})
	self:addTradeSkillSpell(29610, 360, self:AddSingleReputation(3, BFAC["The Scryers"]), {BFAC["The Scryers"]})
	self:addTradeSkillSpell(29616, 360, self:AddSingleReputation(2, BFAC["The Aldor"]), {BFAC["The Aldor"]})
	self:addTradeSkillSpell(29657, 360, self:AddDoubleReputation(4, BFAC["Honor Hold"], BFAC["Thrallmar"]), {BFAC["Thrallmar"]})
	self:addTradeSkillSpell(29613, 365, self:AddSingleReputation(4, BFAC["The Scryers"]), {BFAC["The Scryers"]})
	self:addTradeSkillSpell(29617, 365, self:AddSingleReputation(3, BFAC["The Aldor"]), {BFAC["The Aldor"]})
	self:addTradeSkillSpell(38473, 375, self:AddSingleReputation(4, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(38475, 375, self:AddSingleReputation(3, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(38476, 375, self:AddSingleReputation(3, BFAC["Cenarion Expedition"]), {BFAC["Cenarion Expedition"]})
	self:addTradeSkillSpell(38477, 375, self:AddSingleReputation(2, BFAC["The Violet Eye"]), {L["Raid"]})
	self:addTradeSkillSpell(38478, 375, self:AddSingleReputation(3, BFAC["The Violet Eye"]), {L["Raid"]})
	self:addTradeSkillSpell(38479, 375, self:AddSingleReputation(2, BFAC["The Violet Eye"]), {L["Raid"]})
 	self:addTradeSkillSpell(40034, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), {BFAC["Ashtongue Deathsworn"], L["Raid"]})
	self:addTradeSkillSpell(40036, 375, self:AddSingleReputation(1, BFAC["Ashtongue Deathsworn"]), {BFAC["Ashtongue Deathsworn"], L["Raid"]})
	self:addTradeSkillSpell(40035, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), {BFAC["Ashtongue Deathsworn"], L["Raid"]})
	self:addTradeSkillSpell(40033, 375, self:AddSingleReputation(2, BFAC["Ashtongue Deathsworn"]), {BFAC["Ashtongue Deathsworn"], L["Raid"]})

	-- Raid Drops
	self:addTradeSkillSpell(22757, 300, L["MOLTENCORE"], {L["Raid"]})
	self:addTradeSkillSpell(27589, 300, L["Black Grasp of the Destroyer Obt"], {L["Raid"]})
	self:addTradeSkillSpell(27587, 300, L["Thick Obsidian Breastplate Obt"], {L["Raid"]})
	self:addTradeSkillSpell(36392, 375, L["SSC/TKBoE"], {L["Raid"]})
	self:addTradeSkillSpell(36389, 375, L["SSC/TKBoP"], {L["Raid"]})
	self:addTradeSkillSpell(36390, 375, L["SSC/TKBoP"], {L["Raid"]})
	self:addTradeSkillSpell(36391, 375, L["SSC/TKBoE"], {L["Raid"]})
	self:addTradeSkillSpell(41134, 375, L["BT/HYJALBoP"], {L["Raid"]})
	self:addTradeSkillSpell(41135, 375, L["BT/HYJALBoE"], {L["Raid"]})
	self:addTradeSkillSpell(41132, 375, L["BT/HYJALBoP"], {L["Raid"]})
	self:addTradeSkillSpell(41133, 375, L["BT/HYJALBoE"], {L["Raid"]})
	self:addTradeSkillSpell(46140, 365, L["SunwellBoP"])
	self:addTradeSkillSpell(46141, 365, L["SunwellBoP"])
	self:addTradeSkillSpell(46142, 365, L["SunwellBoE"])
	self:addTradeSkillSpell(46144, 365, L["SunwellBoE"])

	-- Weaponsmith
	self:addTradeSkillSpell(36125, 260, L["Trainer"], {GetSpellInfo(9787)})
	self:addTradeSkillSpell(36128, 260, L["Trainer"], {GetSpellInfo(9787)})
	self:addTradeSkillSpell(36126, 260, L["Trainer"], {GetSpellInfo(9787)})
	self:addTradeSkillSpell(15292, 265, L["Dark Iron Pulverizer Obt"], {GetSpellInfo(9787)})

	-- Armorsmith
	self:addTradeSkillSpell(36122, 260, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(36124, 260, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(36129, 330, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(36130, 330, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(34529, 350, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(34533, 350, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(34530, 375, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(36256, 375, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(34534, 375, L["Trainer"], {GetSpellInfo(9788)})
	self:addTradeSkillSpell(36257, 375, L["Trainer"], {GetSpellInfo(9788)})
	
	-- Master Swordsmith
	self:addTradeSkillSpell(16978, 280, L["Blazing Rapier Obt"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(36131, 330, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(36133, 330, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(34535, 350, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(34538, 350, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(36258, 375, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(34537, 375, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(34540, 375, L["Trainer"], {GetSpellInfo(17039)})
	self:addTradeSkillSpell(36259, 375, L["Trainer"], {GetSpellInfo(17039)})

	-- Master Hammersmith
	self:addTradeSkillSpell(16973, 280, L["Enchanted Battlehammer Obt"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(36137, 330, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(36136, 330, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(34545, 350, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(34547, 350, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(34548, 375, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(34546, 375, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(36262, 375, L["Trainer"], {GetSpellInfo(17040)})
	self:addTradeSkillSpell(36263, 375, L["Trainer"], {GetSpellInfo(17040)})

	-- Master Axesmith
	self:addTradeSkillSpell(16970, 275, L["Dawn's Edge Obt"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(36135, 330, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(36134, 330, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(34541, 350, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(34543, 350, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(34542, 375, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(36261, 375, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(34544, 375, L["Trainer"], {GetSpellInfo(17041)})
	self:addTradeSkillSpell(36260, 375, L["Trainer"], {GetSpellInfo(17041)})
	
end
