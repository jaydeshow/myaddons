local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 59974 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

if GetLocale() == "zhTW" then
	local L = _G.DogTag__L
	
	-- races
	L["Blood Elf"] = "血精靈"
	L["Draenei"] = "德萊尼"
	L["Dwarf"] = "矮人"
	L["Gnome"] = "地精"
	L["Human"] = "人類"
	L["Night Elf"] = "夜精靈"
	L["Orc"] = "獸人"
	L["Tauren"] = "牛頭人"
	L["Troll"] = "食人妖"
	L["Undead"] = "不死族"

	-- short races
	L["Blood Elf_short"] = "血"
	L["Draenei_short"] = "萊"
	L["Dwarf_short"] = "矮"
	L["Gnome_short"] = "地"
	L["Human_short"] = "人"
	L["Night Elf_short"] = "夜"
	L["Orc_short"] = "獸"
	L["Tauren_short"] = "牛"
	L["Troll_short"] = "食"
	L["Undead_short"] = "不"

	-- classes
	L["Warrior"] = "戰士"
	L["Priest"] = "牧師"
	L["Mage"] = "法師"
	L["Shaman"] = "薩滿"
	L["Paladin"] = "聖騎士"
	L["Warlock"] = "術士"
	L["Druid"] = "德魯伊"
	L["Rogue"] = "盜賊"
	L["Hunter"] = "獵人"

	-- short classes
	L["Warrior_short"] = "戰"
	L["Priest_short"] = "牧"
	L["Mage_short"] = "法"
	L["Shaman_short"] = "薩"
	L["Paladin_short"] = "聖"
	L["Warlock_short"] = "術"
	L["Druid_short"] = "德"
	L["Rogue_short"] = "賊"
	L["Hunter_short"] = "獵"

	L["Player"] = PLAYER
	L["Target"] = TARGET
	L["Focus-target"] = FOCUSTARGET
	L["Mouse-over"] = "滑鼠目標"
	L["%s's pet"] = "%s的寵物"
	L["%s's target"] = "%s的目標"
	L["Party member #%d"] = "隊伍成員#%d"
	L["Raid member #%d"] = "團隊成員#%d"

	-- classifications
	L["Rare"] = "稀有"
	L["Rare-Elite"] = "稀有" .. "-" .. ELITE
	L["Elite"] = ELITE
	L["Boss"] = BOSS
	-- short classifications
	L["Rare_short"] = "稀"
	L["Rare-Elite_short"] = "稀+"
	L["Elite_short"] = "+"
	L["Boss_short"] = "首"

	L["Feigned Death"] = "假死"
	L["Stealthed"] = "潛行"
	L["Soulstoned"] = "靈魂被保存"

	L["Dead"] = DEAD
	L["Ghost"] = "鬼魂"
	L["Offline"] = PLAYER_OFFLINE
	L["Online"] = "上線"
	L["Combat"] = "戰鬥"
	L["Resting"] = "休息"
	L["Tapped"] = "選取"
	L["AFK"] = "暫離"
	L["DND"] = "勿擾"

	L["True"] = "真"

	L["Rage"] = RAGE
	L["Focus"] = FOCUS
	L["Energy"] = ENERGY
	L["Mana"] = MANA

	L["PvP"] = PVP
	L["FFA"] = PVPFFA

	-- genders
	L["Male"] = MALE
	L["Female"] = FEMALE

	-- forms
	L["Bear"] = "熊"
	L["Cat"] = "獵豹"
	L["Moonkin"] = "梟獸"
	L["Aquatic"] = "水棲"
	L["Flight"] = "飛行"
	L["Travel"] = "旅行"
	L["Tree"] = "樹"

	L["Bear_short"] = "熊"
	L["Cat_short"] = "豹"
	L["Moonkin_short"] = "梟"
	L["Aquatic_short"] = "水"
	L["Flight_short"] = "飛"
	L["Travel_short"] = "旅"
	L["Tree_short"] = "樹"

	-- shortgenders
	L["Male_short"] = "男"
	L["Female_short"] = "女"

	L["Leader"] = "隊長"

	-- spell trees
	L["Hybrid"] = "混合" -- for all 3 trees
	L["Druid_Tree_1"] = "平衡"
	L["Druid_Tree_2"] = "野性戰鬥"
	L["Druid_Tree_3"] = "恢復"
	L["Hunter_Tree_1"] = "野獸控制"
	L["Hunter_Tree_2"] = "射擊"
	L["Hunter_Tree_3"] = "生存"
	L["Mage_Tree_1"] = "秘法"
	L["Mage_Tree_2"] = "火焰"
	L["Mage_Tree_3"] = "冰霜"
	L["Paladin_Tree_1"] = "神聖"
	L["Paladin_Tree_2"] = "防護"
	L["Paladin_Tree_3"] = "懲戒"
	L["Priest_Tree_1"] = "戒律"
	L["Priest_Tree_2"] = "神聖"
	L["Priest_Tree_3"] = "暗影"
	L["Rogue_Tree_1"] = "刺殺"
	L["Rogue_Tree_2"] = "戰鬥"
	L["Rogue_Tree_3"] = "敏銳"
	L["Shaman_Tree_1"] = "元素"
	L["Shaman_Tree_2"] = "增強"
	L["Shaman_Tree_3"] = "恢復"
	L["Warrior_Tree_1"] = "武器"
	L["Warrior_Tree_2"] = "狂怒"
	L["Warrior_Tree_3"] = "防護"
	L["Warlock_Tree_1"] = "痛苦"
	L["Warlock_Tree_2"] = "惡魔學識"
	L["Warlock_Tree_3"] = "毀滅"
end

end