--[[
	JewelTips 0.5.6
]]--

local BTS = AceLibrary("Babble-Tradeskill-2.2")
local L = AceLibrary("AceLocale-2.2"):new("JewelTips")

L:RegisterTranslations("enUS", function() return {
	["[Unknown Enchant: %d]"] = true,
	["[Unsafe Link: %d]"] = true,
	["Enchant"] = true,
	["Purple"] = true,
	["Orange"] = true,
	["Green"] = true,
} end)
L:RegisterTranslations("deDE", function() return {
	["[Unknown Enchant: %d]"] = "[unbekannt Verzaubern: %d]",
	["[Unsafe Link: %d]"] = "[Unsichere Verbindung: %d]",
	["Enchant"] = "Verzaubern",
	["Purple"] = "Violett",
	["Orange"] = "Orange",
	["Green"] = "Gr\195\188n",
} end)
L:RegisterTranslations("koKR", function() return {
	["[Unknown Enchant: %d]"] = "[알 수 없는 마법부여: %d]",
	["[Unsafe Link: %d]"] = "[안전하지 않은 링크: %d]",
	["Enchant"] = "마법부여",
	["Purple"] = "보라색 (붉은+푸른)",
	["Orange"] = "주황색 (노란+붉은)",
	["Green"] = "녹색 (노란+푸른)",
} end)
L:RegisterTranslations("zhCN", function() return {
	["[Unknown Enchant: %d]"] = "[未知附魔: %d]",
	["[Unsafe Link: %d]"] = "[不安全链接: %d]",
	["Enchant"] = "附魔",
	["Purple"] = "紫色",
	["Orange"] = "橙色",
	["Green"] = "绿色",
} end)
L:RegisterTranslations("zhTW", function() return {
	["[Unknown Enchant: %d]"] = "[未知附魔: %d]",
	["[Unsafe Link: %d]"] = "[不安全鏈接: %d]",
	["Enchant"] = "附魔",
	["Purple"] = "紫色",
	["Orange"] = "橙色",
	["Green"] = "綠色",
} end)

--Create Jeweltips frame
JewelTips = {}
local JewelTips = JewelTips

--Localize functions
local tonumber, GetItemInfo, GetItemGem, select = tonumber, GetItemInfo, GetItemGem, select
local RED_GEM, YELLOW_GEM, BLUE_GEM, META_GEM = RED_GEM, YELLOW_GEM, BLUE_GEM, META_GEM
--local INVTYPE_FEET INVTYPE_WRIST INVTYPE_CLOAK INVTYPE_SHIELD = INVTYPE_FEET INVTYPE_WRIST INVTYPE_CLOAK INVTYPE_SHIELD
local strgsub = string.gsub
local strmatch = string.match
--Localize tooltips
local ItemRefTooltip, GameTooltip = ItemRefTooltip, GameTooltip
local currentGemLinkTable = {}
local currentGemTextureTable = {}
local icon
local lastlink = "None"

JewelTips.BUTTON_SIZE = 30
--if IDCard then
	JewelTips.BUTTON_OFFSETY = -40
--end
JewelTips.QUESTIONMARK_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
JewelTips.ENCHANT_ICON = "Interface\\Icons\\Spell_Holy_GreaterHeal"
JewelTips.Jewels = {
--		[] = "0",
	[15] = 2304, --Light Armor Kit
	[16] = 2313, --Medium Armor Kit
	[17] = 4265, --Heavy Armor Kit
	[18] = 8173, --Thick Armor Kit
	[30] = 4405, --Crude Scope
	[32] = 4406, --Standard Scope
	[33] = 4407, --Accurate Scope
	[34] = 6043, --Iron Counterweight
	[36] = 5421, --Fiery Blaze Enchantment
	[37] = 6041, --Steel Weapon Chain
	[41] = {BTS["Enchant Chest - Minor Health"], ":7418"}, --+5 Health
	[43] = 6042, --Iron Shield Spike
	[65] = {BTS["Enchant Cloak - Minor Resistance"], 7454},
	[66] = { --+1 Stamina
		multi = true,
		INVTYPE_WRIST = {BTS["Enchant Bracer - Minor Stamina"], 7457},
		INVTYPE_FEET = {BTS["Enchant Boots - Minor Stamina"], 7863},
	},
	[241] = {BTS["Enchant 2H Weapon - Minor Impact"], 7745},
	[247] = {BTS["Enchant Cloak - Minor Agility"], 13419},
	[255] = {BTS["Enchant 2H Weapon - Lesser Spirit"], 13380},
	[256] = {BTS["Enchant Cloak - Lesser Fire Resistance"], 7861},
	[368] = {BTS["Enchant Cloak - Greater Agility"], 34004},
	[369] = {BTS["Enchant Bracer - Major Intellect"], 34001},
	[464] = 7969, --Mithril Spurs
	[663] = 10546, --Deadly Scope
	[664] = 10548, --Sniper Scope
	[684] = {BTS["Enchant Gloves - Major Strength"], 33995},
	[723] = {BTS["Enchant 2H Weapon - Lesser Intellect"], 7793}, --+3 Intellect
	[724] = {BTS["Enchant Boots - Lesser Stamina"], 13644}, --+3 Stamina
	[744] = {BTS["Enchant Cloak - Lesser Protection"], 13421},
	[783] = {BTS["Enchant Cloak - Minor Protection"], 7771}, --+10 Armor
	[803] = {BTS["Enchant Weapon - Fiery Weapon"], 13898},
	[804] = {BTS["Enchant Cloak - Lesser Shadow Resistance"], 13522},
	[805] = {BTS["Enchant Weapon - Greater Striking"], 13943}, --+4 Weapon Damage
	[844] = {BTS["Enchant Gloves - Mining"], 13612},
	[845] = {BTS["Enchant Gloves - Herbalism"], 13617},
	[846] = {BTS["Enchant Gloves - Fishing"], 13620},
	[848] = {BTS["Enchant Cloak - Defense"], 13635},
	[849] = {BTS["Enchant Cloak - Lesser Agility"], 13882},
	[851] = {BTS["Enchant Boots - Spirit"], 20024},
	[852] = {
		multi = true,
		INVTYPE_FEET = {BTS["Enchant Boots - Stamina"], 13836},
		INVTYPE_SHIELD = {BTS["Enchant Shield - Stamina"], 13817},
	},
	[856] = {BTS["Enchant Gloves - Strength"], 13887},
	[857] = {BTS["Enchant Chest - Greater Mana"], 13663},	--+50 Mana
	[865] = {BTS["Enchant Gloves - Skinning"], 13698},
	[884] = {BTS["Enchant Cloak - Greater Defense"], 13746},
	[903] = {BTS["Enchant Cloak - Resistance"], 13794},
	[904] = {BTS["Enchant Gloves - Agility"], 13815},
	[905] = {BTS["Enchant Bracer - Intellect"], 13822},
	[906] = {BTS["Enchant Gloves - Advanced Mining"], 13841},
	[908] = {BTS["Enchant Chest - Superior Health"], 13858},
	[909] = {BTS["Enchant Gloves - Advanced Herbalism"], 13868},
	[910] = {BTS["Enchant Cloak - Stealth"], 25083},
	[911] = {BTS["Enchant Boots - Minor Speed"], 13890},
	[912] = {BTS["Enchant Weapon - Demonslaying"], 13915},
	[913] = {BTS["Enchant Chest - Superior Mana"], 13917},
	[923] = {BTS["Enchant Bracer - Deflection"], 13931}, --+5 Defense Rating
	[926] = {BTS["Enchant Shield - Frost Resistance"], 13933},
	[928] = {BTS["Enchant Chest - Stats"], 13941},
	[929] = {
		multi = true,
		INVTYPE_SHIELD = {BTS["Enchant Shield - Greater Stamina"], 20017},
		INVTYPE_FEET = {BTS["Enchant Boots - Greater Stamina"], 20020},
		INVTYPE_WRIST = {BTS["Enchant Bracer - Greater Stamina"], 13945},
	},
	[930] = {BTS["Enchant Gloves - Riding Skill"], 13947},
	[931] = {BTS["Enchant Gloves - Minor Haste"], 13948},
	[943] = {BTS["Enchant 2H Weapon - Lesser Impact"], 13529},
	[963] = {BTS["Enchant 2H Weapon - Greater Impact"], 13937},
	[1071] = {BTS["Enchant Shield - Major Stamina"], 34009},
	[1144] = {BTS["Enchant Chest - Major Spirit"], 33990}, -- +15 Spirit
	[1257] = {BTS["Enchant Cloak - Greater Arcane Resistance"], 34005}, --+15 Arcane Resistance
	[1441] = {BTS["Enchant Cloak - Greater Shadow Resistance"], 34006},
	[1483] = 11622, --Lesser Arcanum of Rumination
	[1503] = 11642, --Lesser Arcanum of Constitution
	[1504] = 11643, --Lesser Arcanum of Tenacity
	[1505] = 11644, --Lesser Arcanum of Resilience
	[1506] = 11645, --Lesser Arcanum of Voracity
	[1507] = 11646, --Lesser Arcanum of Voracity
	[1508] = 11647, --Lesser Arcanum of Voracity
	[1509] = 11648, --Lesser Arcanum of Voracity
	[1510] = 11649, --Lesser Arcanum of Voracity
	[1593] = {BTS["Enchant Bracer - Assault"], 34002},-- +24 Attack Power
	[1594] = {BTS["Enchant Gloves - Assault"], 33996},-- +26 Attack Power
	[1704] = 12645, --Thorium Spike (20-30)
	[1843] = 15564, --Rugged Armor Kit
	[1883] = {BTS["Enchant Bracer - Greater Intellect"], 20008},
	[1884] = {BTS["Enchant Bracer - Superior Spirit"], 20009},
	[1886] = {BTS["Enchant Bracer - Superior Stamina"], 20011}, -- +9 Stamina
	[1887] = {BTS["Enchant Gloves - Greater Agility"], 20012}, -- +7 Agility
	[1888] = {
		multi = true,
		INVTYPE_CLOAK = {BTS["Enchant Cloak - Greater Resistance"], 20014}, --+5 All Resistances
		INVTYPE_SHIELD = {BTS["Enchant Shield - Resistance"], 27947},
	},
	[1889] = {BTS["Enchant Cloak - Superior Defense"], 20015},
	[1891] = {BTS["Enchant Bracer - Stats"], 27905},--+4 All Stats
	[1892] = {BTS["Enchant Chest - Major Health"], 20026},-- +100 Health
	[1893] = {BTS["Enchant Chest - Major Mana"], 20028},--+100 Mana
	[1894] = {BTS["Enchant Weapon - Icy Chill"], 20029}, --Icy Weapon
	[1896] = {BTS["Enchant 2H Weapon - Superior Impact"], 20030},
	[1897] = {BTS["Enchant 2H Weapon - Impact"], 13695}, --+5 Weapon Damage
	[1899] = {BTS["Enchant Weapon - Unholy Weapon"], 20033},--Unholy Weapon
	[1900] = {BTS["Enchant Weapon - Crusader"], 20034}, -- Crusader
	[1903] = {BTS["Enchant 2H Weapon - Major Spirit"], 20035},
	[1904] = {BTS["Enchant 2H Weapon - Major Intellect"], 20036},
	[2322] = {BTS["Enchant Gloves - Major Healing"], 33999},
	[2343] = {BTS["Enchant Weapon - Major Healing"], 34010},
	[2376] = {BTS["Enchant Chest - Restore Mana Prime"], 33991}, -- changed?
	[2443] = {BTS["Enchant Weapon - Winter's Might"], 21931},
	[2463] = {BTS["Enchant Cloak - Fire Resistance"], 13657},
	[2483] = 18169, --Flame Mantle of the Dawn
	[2484] = 18170, --Frost Mantle of the Dawn
	[2485] = 18171, --Arcane Mantle of the Dawn
	[2486] = 18172, --Nature Mantle of the Dawn
	[2487] = 18173, --Shadow Mantle of the Dawn
	[2488] = 18182, --Chromatic Mantle of the Dawn
	[2503] = 18251, --Core Armor Kit
	[2504] = {BTS["Enchant Weapon - Spell Power"], 22749},
	[2505] = {BTS["Enchant Weapon - Healing Power"], 22750}, -- +55 Healing
	[2523] = 18283, --Biznicks 247x128 Accurascope
	[2543] = 18329, --Arcanum of Rapidity
	[2544] = 18330, --Arcanum of Focus
	[2545] = 18331, --Arcanum of Protection
	[2563] = {BTS["Enchant Weapon - Strength"], 23799}, -- +15 Strength
	[2564] = {BTS["Enchant Weapon - Agility"], 23800}, -- +15 Agility
	[2565] = {BTS["Enchant Bracer - Mana Regeneration"], 23801}, -- Mana Regen 4 per 5 sec.
	[2566] = {BTS["Enchant Bracer - Healing Power"], 23802}, -- +24 Healing
	[2567] = {BTS["Enchant Weapon - Mighty Spirit"], 23803}, -- +20 Spirit
	[2568] = {BTS["Enchant Weapon - Mighty Intellect"], 23804}, -- +22 Intellect
	[2583] = 19782, --Presence of Might
	[2584] = 19783, --Syncretist's Sigil
	[2585] = 19784, --Death's Embrace
	[2586] = 19785, --Falcon's Call
	[2587] = 19786, --Vodouisant's Vigilant Embrace
	[2588] = 19787, --Presence of Sight
	[2589] = 19788, --Hoodoo Hex
	[2590] = 19789, --Prophetic Aura
	[2591] = 19790, --Animist's Caress
	[2603] = 19971, --High Test Eternium Fishing Line
	[2604] = 20078,--Zandalar Signet of Serenity
	[2605] = 20076,--Zandalar Signet of Mojo
	[2606] = 20077,--Zandalar Signet of Might
	[2613] = {BTS["Enchant Gloves - Threat"], 25072}, --+2% Threat
	[2614] = {BTS["Enchant Gloves - Shadow Power"], 25073},
	[2615] = {BTS["Enchant Gloves - Frost Power"], 25074},
	[2616] = {BTS["Enchant Gloves - Fire Power"], 25078},
	[2617] = {BTS["Enchant Bracer - Superior Healing"], 27911},
	[2619] = {BTS["Enchant Cloak - Greater Fire Resistance"], 25081},-- +15 Fire Resistance
	[2620] = {BTS["Enchant Cloak - Greater Nature Resistance"], 25082}, -- +15 Nature Resistance
	[2621] = {BTS["Enchant Cloak - Subtlety"], 25084},
	[2622] = {BTS["Enchant Cloak - Dodge"], 25086},
	[2646] = {BTS["Enchant 2H Weapon - Agility"], 27837},
	[2647] = {BTS["Enchant Bracer - Brawn"], 27899},
	[2648] = {BTS["Enchant Bracer - Major Defense"], 27906}, -- +12 Defense Rating
	[2649] = {
		multi = true,
		INVTYPE_FEET = {BTS["Enchant Boots - Fortitude"], 27950}, -- +12 Stamina
		INVTYPE_WRIST = {BTS["Enchant Bracer - Fortitude"], 27914}, -- +12 Stamina
	},
	[2650] = {BTS["Enchant Bracer - Spellpower"], 27917},--+15 Spell Damage
	[2653] = {BTS["Enchant Shield - Tough Shield"], 27944}, --+18 Block Value
	[2654] = {BTS["Enchant Shield - Intellect"], 27945}, -- +12 Intellect
	[2655] = {BTS["Enchant Shield - Shield Block"], 27946}, --+15 Shield Block Rating
	[2656] = {BTS["Enchant Boots - Vitality"], 27948},
	[2657] = {BTS["Enchant Boots - Dexterity"], 27951},
	[2658] = {BTS["Enchant Boots - Surefooted"], 27954},
	[2659] = {BTS["Enchant Chest - Exceptional Health"], 27957}, -- +150 Health
	[2660] = {BTS["Enchant Chest - Superior Mana"], 27958}, -- +150 Mana
	[2661] = {BTS["Enchant Chest - Exceptional Stats"], 27960}, -- +6 All Stats
	[2662] = {BTS["Enchant Cloak - Major Armor"], 27961},
	[2664] = {BTS["Enchant Cloak - Major Resistance"], 27962},
	[2665] = {BTS["Enchant 2H Weapon - Major Spirit"], 27964}, -- +35 Spirit (NYI)
	[2666] = {BTS["Enchant Weapon - Major Intellect"], 27968},
	[2667] = {BTS["Enchant 2H Weapon - Savagery"], 27971},
	[2668] = {BTS["Enchant Weapon - Potency"], 27972},
	[2669] = {BTS["Enchant Weapon - Major Spellpower"], 27975},
	[2670] = {BTS["Enchant 2H Weapon - Major Agility"], 27977},
	[2671] = {BTS["Enchant Weapon - Sunfire"], 27981},
	[2672] = {BTS["Enchant Weapon - Soulfrost"], 27982},
	[2673] = {BTS["Enchant Weapon - Mongoose"], 27984}, -- Mongoose
	[2674] = {BTS["Enchant Weapon - Spellsurge"], 28003},
	[2675] = {BTS["Enchant Weapon - Battlemaster"], 28004},
	[2679] = {BTS["Enchant Bracer - Restore Mana Prime"], 27913},
	[2681] = 22635, --Savage Guard
	[2682] = 22636, --Ice Guard
	[2683] = 22638, --Shadow Guard
	[2684] = 23122, --Consecrated Sharpening Stone
	[2685] = 23123, --Blessed Wizard Oil
	[2712] = 23528,--Fel Sharpening Stone
	[2713] = 23529, --Adamantite Sharpening Stone
	[2714] = 23530, --Felsteel Shield Spike
	[2715] = 23547, --Resilience of the Scourge
	[2716] = 23549, --Fortitude of the Scourge
	[2717] = 23548, --Might of the Scourge
	[2718] = 23559, --Lesser Rune of Warding
	[2719] = 23575, --Lesser Rune of Shielding
	[2720] = 23576, --Greater Rune of Shielding
	[2721] = 23545, --Power of the Scourge
	[2722] = 23764, --Adamantite Scope
	[2723] = 23765, --Khorium Scope
	[2724] = 23766, --Stabilized Eternium Scope
	[2745] = 24275, --Silver Spellthread
	[2746] = 24276, --Golden Spellthread
	[2747] = 24273, --Mystic Spellthread
	[2748] = 24274, --Runic Spellthread
	[2791] = 25521, --Greater Rune of Warding
	[2792] = 25650, --Knothide Armor Kit
	[2793] = 25651, --Vindicator's Armor Kit
	[2794] = 25652, --Magister's Armor Kit
	[2795] = 25679, --Comfortable Insoles
	[2836] = 25652, --Magister's Armor Kit??
	[2841] = 34330, --+10 Stamina (Heavy Knothide Armor Kit)
	[2928] = {BTS["Enchant Ring - Spellpower"], 27924},--+12 Spell Damage
	[2929] = {BTS["Enchant Ring - Striking"], 27920},--+2 Weapon Damage
	[2930] = {BTS["Enchant Ring - Healing Power"], 27926},--+20 Healing
	[2931] = {BTS["Enchant Ring - Stats"], 27927},--+20 Healing
	[2933] = {BTS["Enchant Chest - Major Resilience"], 33992},
	[2934] = {BTS["Enchant Gloves - Blasting"], 33993},
	[2935] = {BTS["Enchant Gloves - Spell Strike"], 33994},
	[2937] = {BTS["Enchant Gloves - Major Spellpower"], 33997},
	[2938] = {BTS["Enchant Cloak - Spell Penetration"], 34003},
	[2939] = {BTS["Enchant Boots - Cat's Swiftness"], 34007},
	[2940] = {BTS["Enchant Boots - Boar's Speed"], 34008},
	[2954] = 28420, --Fel Weightstone
	[2955] = 28421, --Adamantite Weightstone
	[2977] = 28882, --Inscription of Warding (Aldor)
	[2978] = 28889, --Greater Inscription of Warding (Aldor)
	[2979] = 28878, --Inscription of Faith (Aldor)
	[2980] = 28887, --Greater Inscription of Faith (Aldor)
	[2981] = 28881, --Inscription of Discipline (Aldor)
	[2982] = 28886, --Greater Inscription of Discipline (Aldor)
	[2983] = 28885, --Inscription of Vengeance (Aldor)
	[2984] = 29483, --Shadow Armor Kit
	[2985] = 29485, --Flame Armor Kit
	[2986] = 28888, --Greater Inscription of Vengeance
	[2987] = 29486, --Frost Armor Kit
	[2988] = 29487, --Nature Armor Kit
	[2989] = 29488, --Arcane Armor Kit
	[2990] = 28908, --Inscription of the Knight
	[2991] = 28911, --Greater Inscription of the Knight
	[2992] = 28904, --Inscription of the Oracle
	[2993] = 28912, --Greater Inscription of the Oracle
	[2994] = 28903, --Inscription of the Orb
	[2995] = 28909, --Greater Inscription of the Orb
	[2996] = 28907, --Inscription of the Blade
	[2997] = 28910, --Greater Inscription of the Blade
	[2998] = 29187, --Inscription of Endurance
	[2999] = 29186, --Glyph of the Defender
	[3001] = 29189, --Glyph of Renewal
	[3002] = 29191, --Glyph of Power
	[3003] = 29192, --Glyph of Ferocity
	[3005] = 29194, --Glyph of Nature Warding
	[3006] = 29195, --Glyph of Arcane Warding
	[3007] = 29196, --Glyph of Fire Warding
	[3008] = 29198, --Glyph of Frost Warding
	[3009] = 29199, --Glyph of Shadow Warding
	[3010] = 29533, --Cobrahide Leg Armor
	[3011] = 29534, --Clefthide Leg Armor
	[3012] = 29535, --Nethercobra Leg Armor
	[3013] = 29536, --Nethercleft Leg Armor
	[3096] = 30846, --Glyph of the Outcast
	[3150] = {BTS["Enchant Chest - Restore Mana Prime"], 33991}, --New enchant id?
	[3222] = {BTS["Enchant Weapon - Greater Agility"], 42620}, --+20 Agility
	[3223] = 33185,--Adamantite Weapon Chain
	[3225] = {BTS["Enchant Weapon - Executioner"], 42974},	--Executioner
	[3229] = {BTS["Enchant Shield - Resilience"], 44383}, --+12 Resilience Rating
	[3260] = 34207,--Glove Reinforcements

	[5000] = 0
}

function JewelTips.enchantIDtoLink(JewelID, equipLoc)
	local index = tonumber(JewelID)
	if not index then return nil end

	local item = JewelTips.Jewels[index]
	if type(item) == "table" and item.multi == true then
		item = item[equipLoc]
	end

	if item and item ~= 0 then
		if type(item) == "number" then
			return select(2, GetItemInfo(item)) or item
		else
--			return strgsub(item, "(.+):(%d+)", "|cffffd000|Henchant:%2|h[%1]|h|r")
			return "|cffffd000|Henchant:"..item[2].."|h["..item[1].."]|h|r"
		end
	else
		return -1 * index --index is negated to show that the number is the original enchantID
	end
end

function JewelTips.JewelColor(itemLink)
	local subtype = select(7,GetItemInfo( itemLink ))
	local colorString

	if subtype == BLUE_GEM then
		colorString = "0000ff"
	elseif subtype == RED_GEM then
		colorString = "ff0000"
	elseif subtype == YELLOW_GEM then
		colorString = "ffff00"
	elseif subtype == L["Purple"] then
		colorString = "8000ff"
	elseif subtype == L["Orange"] then
		colorString = "ff8040"
	elseif subtype == L["Green"] then
		colorString = "00ff00"
	elseif subtype == META_GEM then
		colorString = "aaaaaa"
	else
		colorString = "ffffff"
	end

	return " (|cff"..colorString..subtype.."|r)"
end

-- Shared Button Functions
local function gemButton_OnClick(self)
	if IsShiftKeyDown() then
		if WIM_EditBoxInFocus then
			WIM_EditBoxInFocus:Insert(self.link);
		elseif ChatFrameEditBox:IsVisible() then
			ChatFrameEditBox:Insert(self.link);
		end
	end
end

--This function is only used for gemButtons not used for the enchantButton
local function gemButton_OnEnter(self)
	if self.link then
		local linknum = tonumber(self.link)
		if (not linknum) then
			--self.link is an itemLink
			GameTooltip:SetOwner(self, JewelTips.TOOLTIP_ANCHOR, JewelTips.TOOLTIP_ANCHOR_OFFSETX, JewelTips.TOOLTIP_ANCHOR_OFFSETY)
			GameTooltip:SetHyperlink(self.link)
			GameTooltip:Show()
		elseif (linknum > 0) then
			--self.link is an itemID
			GameTooltip:SetOwner(self, JewelTips.TOOLTIP_ANCHOR, JewelTips.TOOLTIP_ANCHOR_OFFSETX, JewelTips.TOOLTIP_ANCHOR_OFFSETY)
			GameTooltip:SetHyperlink("item:"..self.link)
			GameTooltip:Show()
		end
	end
end
--/script JewelTips.MoveButtons("top")
local enchantButton = CreateFrame("Button",nil,ItemRefTooltip)
local gem1Button = CreateFrame("Button",nil,ItemRefTooltip)
local gem2Button = CreateFrame("Button",nil,ItemRefTooltip)
local gem3Button = CreateFrame("Button",nil,ItemRefTooltip)

local gemButtonTable = {enchantButton, gem1Button, gem2Button, gem3Button}

for index, gemButton in pairs(gemButtonTable) do
	gemButton:SetWidth(JewelTips.BUTTON_SIZE)
	gemButton:SetHeight(JewelTips.BUTTON_SIZE)
	gemButton:SetScript("OnClick", gemButton_OnClick)
	gemButton:SetScript("OnEnter", gemButton_OnEnter)
	gemButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
	gemButton.gemIndex = index - 1
	gemButton:Hide()
end

local function ClearButtons()
	for _, gemButton in pairs(gemButtonTable) do
		gemButton:Hide()
	end
end

function JewelTips:MoveButtons(side)
	if side == "top" then
		self.TOOLTIP_ANCHOR = "ANCHOR_TOPLEFT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = 0
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("BOTTOMLEFT", ItemRefTooltip, "TOPLEFT", 2+(self.BUTTON_SIZE * (index-1)), 0 )
		end
	elseif side == "bottom" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMRIGHT"
		self.TOOLTIP_ANCHOR_OFFSETX = -1*(self.BUTTON_SIZE+2)
		self.TOOLTIP_ANCHOR_OFFSETY = 0
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPLEFT", ItemRefTooltip, "BOTTOMLEFT", 2+(self.BUTTON_SIZE * (index-1)), 0 )
		end
	elseif side == "left" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMLEFT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = self.BUTTON_SIZE+2
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPRIGHT", ItemRefTooltip, "TOPLEFT", 0, self.BUTTON_OFFSETY - (self.BUTTON_SIZE * (index-1)) )
		end
	elseif side == "right" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMRIGHT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = self.BUTTON_SIZE+2
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPLEFT", ItemRefTooltip, "TOPRIGHT", 0, self.BUTTON_OFFSETY - (self.BUTTON_SIZE *(index-1)) )
		end
	end
end

JewelTips:MoveButtons("left")

--Main Routine------------------------------------------
local function addEnchantLines(tooltip, link)
	--For some tooltips, this Main function will be called continuously. This code keeps us from doing unnecessary work after the first time.
	if link ~= lastlink then--Reuse data from the last call since the tooltip link is the same
		currentGemLinkTable[1], currentGemLinkTable[2], currentGemLinkTable[3], currentGemLinkTable[4] = string.match(link, "item:%d+:(%d+):(%d+):(%d+):(%d+):")

		for index, gemLink in pairs(currentGemLinkTable) do
			if gemLink == "0" then
				currentGemLinkTable[index] = nil
			else
				--Check for an item corresponding to the enchantID
				if index == 1 then
					currentGemLinkTable[1] = JewelTips.enchantIDtoLink(gemLink, select(9, GetItemInfo(link)))
				else
					local newGemLink = select(2,GetItemGem(link, gemButtonTable[index].gemIndex))
					if newGemLink then
						currentGemLinkTable[index] = newGemLink
						currentGemTextureTable[index] = select(10, GetItemInfo( currentGemLinkTable[index] ))
					else
						currentGemLinkTable[index] = gemLink
						currentGemTextureTable[index] = JewelTips.QUESTIONMARK_ICON
					end
				end
			end
		end
		lastlink = link
	end

	--Add tooltip lines
	for index, gemLink in pairs(currentGemLinkTable) do
		if index == 1 then
			if type(gemLink) == "number" then
				if gemLink < 0 then
					tooltip:AddLine( string.format(L["[Unknown Enchant: %d]"].." (|cffffffff"..L["Enchant"].."|r)", -1 * gemLink) )
				else
					tooltip:AddLine( string.format(L["[Unsafe Link: %d]"].." (|cffffffff"..L["Enchant"].."|r)", gemLink) )
					lastlink = "None"
				end
				tooltip:AddTexture(JewelTips.QUESTIONMARK_ICON)
			else
				tooltip:AddLine( gemLink .. " (|cffffffff"..L["Enchant"].."|r)")
				if strmatch( gemLink, "Henchant:" ) then
					tooltip:AddTexture(JewelTips.ENCHANT_ICON)
				else
					tooltip:AddTexture(select(10,GetItemInfo(gemLink)) or JewelTips.QUESTIONMARK_ICON)
				end
			end
		else
			if tonumber(gemLink) then
				lastlink = "None"
			else
				tooltip:AddLine(gemLink .. JewelTips.JewelColor(gemLink))
				tooltip:AddTexture(currentGemTextureTable[index])
			end
		end
	end

	tooltip:Show()
end

local function updateItemRefButtons(link)
	--Show/Hide the Buttons for each Gem
	for index, gemButton in pairs(gemButtonTable) do
		gemButton.link = currentGemLinkTable[index]
		if gemButton.link then
			if type(gemButton.link) == "number" then
				gemButton:SetNormalTexture(JewelTips.QUESTIONMARK_ICON)
			else
				icon = select( 10, GetItemInfo( gemButton.link ) )
				gemButton:SetNormalTexture(icon or JewelTips.ENCHANT_ICON)
			end
			gemButton:Show()
		else
			gemButton:Hide()
		end
	end
end

--Thanks to Tekkub for his beautifully simple tekKompare code from which some of this is borrowed
local Orig_GameTooltip_OnTooltipSetItem = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	assert(tooltip, "arg 1 is nil, someone isn't hooking correctly")

	local _, link = tooltip:GetItem()

	--Check if the tooltip is one of our Jewel tooltips
	for _, gemButton in pairs(gemButtonTable) do
		if tooltip:IsOwned(gemButton) then
			-- If we're setting the link for our enchantbutton, check that the icon is good
			local linknum = tonumber(gemButton.link)
			if (linknum and linknum > 0) then
				local _, itemRefItem = ItemRefTooltip:GetItem()
				ItemRefTooltip:ClearLines()
				SetItemRef(itemRefItem)
				addEnchantLines(ItemRefTooltip, link)
				ItemRefTooltip:Show()
				_, gemButton.link, _, _, _, _, _, _, _, icon = GetItemInfo( linknum )
				gemButton:SetNormalTexture(icon)
			end
			return Orig_GameTooltip_OnTooltipSetItem(tooltip, ...)
		end
	end

--	if not ShoppingTooltip1:IsVisible() then SetTips(link, frame, ShoppingTooltip1, ShoppingTooltip2) end
	if link then
		addEnchantLines(tooltip, link)
	end
	if Orig_GameTooltip_OnTooltipSetItem then return Orig_GameTooltip_OnTooltipSetItem(tooltip, ...) end
end)

local Orig_ItemRefTooltip_OnTooltipSetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
ItemRefTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	assert(tooltip, "arg 1 is nil, someone isn't hooking correctly")

 	local _, link = tooltip:GetItem()
	if link then
		addEnchantLines(tooltip, link)
		updateItemRefButtons(link)
--	else
--		ClearButtons()
	end
	if Orig_ItemRefTooltip_OnTooltipSetItem then return Orig_ItemRefTooltip_OnTooltipSetItem(tooltip, ...) end
end)

local Orig_ItemRefTooltip_OnTooltipCleared = ItemRefTooltip:GetScript("OnTooltipCleared")
ItemRefTooltip:SetScript("OnTooltipCleared", function(...)
	ClearButtons()

	if Orig_ItemRefTooltip_OnTooltipCleared then return Orig_ItemRefTooltip_OnTooltipCleared(...) end
end)
