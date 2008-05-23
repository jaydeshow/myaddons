local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BC = LibStub("LibBabble-Class-3.0"):GetLookupTable()
local BO = AceLibrary("Babble-Ore-2.2")
local L  = AceLibrary("AceLocale-2.2"):new("Mendeleev")

MENDELEEV_SETS = {
	{
		name = L["Gathering skills"],
		setindex = "Tradeskill.Gather",
		colour = "|cff8470FF",
		header = L["Gathering skills"],
		quality = 1,
		sets = {
			["Tradeskill.Gather.Fishing"] = GetSpellInfo(13615),
			["Tradeskill.Gather.Disenchant"] = GetSpellInfo(13262),
			["Tradeskill.Gather.Herbalism"] = GetSpellInfo(9134),
			["Tradeskill.Gather.Mining"] = GetSpellInfo(12560),
			["Tradeskill.Gather.Skinning"] = GetSpellInfo(13697),
			["Tradeskill.Gather.Pickpocketing"] = GetSpellInfo(5167),
			["Tradeskill.Gather.Prospecting"] = GetSpellInfo(32177),
		},
	},
	{
		name = L["Crafted by"],
		setindex = "Tradeskill.Crafted",
		colour = "|cff8470ff",
		header = L["Crafted by"],
		useval = function (v) return " ("..v..")" end,
		quality = 1,
		sets = {
			["Tradeskill.Crafted.Alchemy"] = GetSpellInfo(2259),
			["Tradeskill.Crafted.Blacksmithing.Basic"] = GetSpellInfo(2018),
			["Tradeskill.Crafted.Blacksmithing.Armorsmith"] = GetSpellInfo(9788),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Axesmith"] = GetSpellInfo(17041),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Hammersmith"] = GetSpellInfo(17040),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Swordsmith"] = GetSpellInfo(17039),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Basic"] = GetSpellInfo(9787),
			["Tradeskill.Crafted.Cooking"] = GetSpellInfo(2550),
			["Tradeskill.Crafted.Engineering.Basic"] = GetSpellInfo(4036),
			["Tradeskill.Crafted.Engineering.Gnomish"] = GetSpellInfo(20220),
			["Tradeskill.Crafted.Engineering.Goblin"] = GetSpellInfo(20221),
			["Tradeskill.Crafted.First Aid"] = GetSpellInfo(3273),
			["Tradeskill.Crafted.Jewelcrafting"] = GetSpellInfo(25229),
			["Tradeskill.Crafted.Leatherworking.Basic"] = GetSpellInfo(2108),
			["Tradeskill.Crafted.Leatherworking.Dragonscale"] = GetSpellInfo(10657),
			["Tradeskill.Crafted.Leatherworking.Elemental"] = GetSpellInfo(10659),
			["Tradeskill.Crafted.Leatherworking.Tribal"] = GetSpellInfo(10661),
			["Tradeskill.Crafted.Tailoring"] = GetSpellInfo(3908),
		},
	},
	{
		name = L["Mine Gems"],
		setindex = "Tradeskill.Gather.GemsInNodes",
		colour = "|cffB0C4DE",
		header = L["Found in"],
		quality = 1,
		sets = {
			["Tradeskill.Gather.GemsInNodes.Copper Vein"] = BO["Copper Vein"],
			["Tradeskill.Gather.GemsInNodes.Tin Vein"] = BO["Tin Vein"],
			["Tradeskill.Gather.GemsInNodes.Silver Vein"] = BO["Silver Vein"],
			["Tradeskill.Gather.GemsInNodes.Iron Deposit"] = BO["Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Gold Vein"] = BO["Gold Vein"],
			["Tradeskill.Gather.GemsInNodes.Mithril Deposit"] = BO["Mithril Deposit"],
			["Tradeskill.Gather.GemsInNodes.Truesilver Deposit"] = BO["Truesilver Deposit"],
			["Tradeskill.Gather.GemsInNodes.Small Thorium Vein"] = BO["Small Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Hakkari Thorium Vein"] = BO["Hakkari Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Rich Thorium Vein"] = BO["Rich Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Dark Iron Deposit"] = BO["Dark Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Adamantite Deposit"] = BO["Adamantite Deposit"],
			["Tradeskill.Gather.GemsInNodes.Fel Iron Deposit"] = BO["Fel Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Khorium Vein"] = BO["Khorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Rich Adamantite Deposit"] = BO["Rich Adamantite Deposit"],
		},
	},
	{
		name = L["Trade skills"],
		setindex = "Tradeskill.Mat.ByProfession",
		colour = "|cffF5DEB3",
		header = L["Component in"],
		quality = 1,
		descfunc = function(skill, reagent) return Mendeleev:GetLinesForTradeskillReagent(skill, reagent) end,
		sets = {
			["Tradeskill.Mat.ByProfession.Alchemy"] = "Alchemy",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Armorsmith"] = "Blacksmithing.Armorsmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Basic"] = "Blacksmithing.Basic",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Axesmith"] = "Blacksmithing.Weaponsmith.Axesmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Basic"] = "Blacksmithing.Weaponsmith.Basic",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Hammersmith"]	= "Blacksmithing.Weaponsmith.Hammersmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Swordsmith"] = "Blacksmithing.Weaponsmith.Swordsmith",
			["Tradeskill.Mat.ByProfession.Cooking"] = "Cooking",
			["Tradeskill.Mat.ByProfession.Enchanting"] = "Enchanting",
			["Tradeskill.Mat.ByProfession.Engineering.Basic"] = "Engineering.Basic",
			["Tradeskill.Mat.ByProfession.Engineering.Gnomish"] = "Engineering.Gnomish",
			["Tradeskill.Mat.ByProfession.Engineering.Goblin"] = "Engineering.Goblin",
			["Tradeskill.Mat.ByProfession.First Aid"] = "First Aid",
			["Tradeskill.Mat.ByProfession.Jewelcrafting"] = "Jewelcrafting",
			["Tradeskill.Mat.ByProfession.Leatherworking.Basic"] = "Leatherworking.Basic",
			["Tradeskill.Mat.ByProfession.Leatherworking.Dragonscale"] = "Leatherworking.Dragonscale",
			["Tradeskill.Mat.ByProfession.Leatherworking.Elemental"] = "Leatherworking.Elemental",
			["Tradeskill.Mat.ByProfession.Leatherworking.Tribal"] = "Leatherworking.Tribal",
			["Tradeskill.Mat.ByProfession.Poisons"] = "Poisons",
			["Tradeskill.Mat.ByProfession.Smelting"] = "Smelting",
			["Tradeskill.Mat.ByProfession.Tailoring"] = "Tailoring",
			["TradeskillResultMats.Reverse.Tailoring.Basic"] = "Tailoring.Basic",
			["TradeskillResultMats.Reverse.Tailoring.Mooncloth"] = "Tailoring.Mooncloth",
			["TradeskillResultMats.Reverse.Tailoring.Shadoweave"] = "Tailoring.Shadoweave",
			["TradeskillResultMats.Reverse.Tailoring.Spellfire"] = "Tailoring.Spellfire",
		},
	},
	{
		name = L["Class Reagents"],
		setindex = "Reagent.Class",
		colour = "|cffff00ff",
		header = L["Classes"],
		quality = 1,
		sets = {
			["Reagent.Class.Paladin"] = BC["Paladin"],
			["Reagent.Class.Druid"] = BC["Druid"],
			["Reagent.Class.Mage"] = BC["Mage"],
			["Reagent.Class.Priest"] = BC["Priest"],
			["Reagent.Class.Rogue"] = BC["Rogue"],
			["Reagent.Class.Shaman"] = BC["Shaman"],
			["Reagent.Class.Warlock"] = BC["Warlock"],
		},
	},
	{
		name = L["Food type"],
		setindex = "Consumable.Food",
		colour = "|cff87CEFA",
		header = L["Food type"],
		quality = 1,
		sets = {
			["Consumable.Food.Bread"] = L["Bread"],
			["Consumable.Food.Fish"] = L["Fish"],
			["Consumable.Food.Meat"] = L["Meat"],
			["Consumable.Food.Cheese"] = L["Cheese"],
			["Consumable.Food.Fruit"] = L["Fruit"],
			["Consumable.Food.Fungus"] = L["Fungus"],
			["Consumable.Food.Misc"] = L["Misc"],
		},
	},
	{
		name = L["Recipe source"],
		setindex = "Tradeskill.Recipe",
		colour = "|cff8470FF",
		header = L["Recipe source"],
		useval = function (v) return " ("..v..")" end,
		--PT3's value is minimum skill and not price
		--[[useval = function (v)
			v = math.floor(v)
			if v == 0 then return "" end
			local g = v > 9999 and floor(v/10000) or 0
			v = v-(g*10000)
			local s = v > 99 and floor(v/100) or 0
			v = v-(s*100)
			local c = v
			return " ("..(g>0 and (g.."g ") or "").. (((g+s)>0) and (s.."s ") or "").. c.. "c)"
		end, ]]
		quality = 1,
		sets = {
			["Tradeskill.Recipe.Vendor"] = L["Vendor"],
			["Tradeskill.Recipe.Drop"] = L["Drop"],
			["Tradeskill.Recipe.Quest"] = L["Quest"],
			["Tradeskill.Recipe.Crafted"] = L["Crafted"],
		},
	},
	{
		name = L["Booze"],
		setindex = "Misc",
		colour = "|cffB0C4DE",
		header = " ",
		useval = function (v) return string.format(L["%d%% alc/vol (%d proof)"], v, v*2) end,
		quality = 1,
		sets = {
			["Misc.Booze"] = L["Booze"],
		},
	},
	{
		name = L["Darkmoon Faire"],
		setindex = "QuestMats.Darkmoon Faire.Turnin",
		colour = "|cffFFFF00",
		header = L["Darkmoon Faire"],
		useval = function (v) return string.format(L[" (%d tickets)"], v) end,
		quality = 1,
		sets = {
			["QuestMats.Darkmoon Faire.Turnin.Engineering"] = GetSpellInfo(4036),
			["QuestMats.Darkmoon Faire.Turnin.Greys"] = L["Junk Items"],
			["QuestMats.Darkmoon Faire.Turnin.Leather"] = L["Leather"],
			["QuestMats.Darkmoon Faire.Turnin.Blacksmithing"] = GetSpellInfo(2018),
		},
	},
	{
		name = L["Darkmoon Faire Card"],
		setindex = "QuestMats.Darkmoon Faire.Deck",
		colour = "|cffFFFF00",
		header = L["Darkmoon Faire Card"],
		quality = 1,
		sets = {
			["QuestMats.Darkmoon Faire.Deck.Beasts"] = L["Blue Dragon Card"],
			["QuestMats.Darkmoon Faire.Deck.Warlords"] = L["Heroism Card"],
			["QuestMats.Darkmoon Faire.Deck.Portals"] = L["Twisting Nether Card"],
			["QuestMats.Darkmoon Faire.Deck.Elementals"] = L["Maelstrom Card"],
			["QuestMats.Darkmoon Faire.Deck.Blessings"] = L["Crusade Card"],
			["QuestMats.Darkmoon Faire.Deck.Furies"] = L["Vengeance Card"],
			["QuestMats.Darkmoon Faire.Deck.Lunacy"] = L["Madness Card"],
			["QuestMats.Darkmoon Faire.Deck.Storms"] = L["Wrath Card"],
		},
	},
	{
		name = L["Lockpicking"],
		setindex = "Misc",
		colour = "|cffFFFF00",
		header = " ",
		useval = function (v) return string.format(" (%d)", v) end,
		quality = 1,
		sets = {
			["Misc.Unlock.Skeleton Keys"] = L["Lockpicking"],
			["Misc.Lockboxes"] = L["Lockpicking"],
			["Misc.Unlock.Seaforium Charges"] = L["Lockpicking"],
		}
	},
}

