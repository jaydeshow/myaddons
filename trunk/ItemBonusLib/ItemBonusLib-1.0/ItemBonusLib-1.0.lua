--[[
Name: ItemBonusLib-1.0
Revision: $Rev: 67662 $
Author(s): Jerry
Documentation: http://wiki.wowace.com/index.php/ItemBonusLib-1.0
SVN: http://svn.wowace.com/root/trunk/ItemBonusLib/ItemBonusLib-1.0
Description:Scans your Equipment for cumulative item bonuses and sums them up
Dependencies: AceLibrary, AceConsole-2.0, AceDebug-2.0, AceEvent-2.0, Deformat-2.0, Gratuity-2.0
]]

local select = select
local type = type
local pairs = pairs
local ipairs = ipairs
local assert = assert
local strtrim = strtrim
local MAJOR_VERSION = "ItemBonusLib-1.0"
local MINOR_VERSION = "$Revision: 67662 $"

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("Gratuity-2.0") then error(MAJOR_VERSION .. " requires Gratuity-2.0") end
if not AceLibrary:HasInstance("Deformat-2.0") then error(MAJOR_VERSION .. " requires Deformat-2.0") end

local DEBUG = DEBUG_ItemBonusLib

local ItemBonusLib = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDebug-2.0")
ItemBonusLib:SetDebugging(DEBUG)

local GetBonus
do
	local CombatRatingMap = {
		CR_WEAPON = 2.5,
		CR_WEAPON_DAGGER = 2.5,
		CR_WEAPON_SWORD = 2.5,
		CR_WEAPON_SWORD_2H = 2.5,
		CR_WEAPON_AXE = 2.5,
		CR_WEAPON_AXE_2H = 2.5,
		CR_WEAPON_MACE = 2.5,
		CR_WEAPON_MACE_2H = 2.5,
		CR_WEAPON_BOW = 2.5,
		CR_WEAPON_XBOW = 2.5,
		CR_WEAPON_GUN = 2.5,
		CR_WEAPON_FIST = 2.5,
		CR_WEAPON_STAFF = 2.5,
		CR_WEAPON_POLEARM = 2.5,

		CR_DEFENSE = 1.5,
		CR_DODGE = 12,
		CR_PARRY = 15,
		CR_BLOCK = 5,
		CR_HIT = 10,
		CR_CRIT = 14,
		CR_RANGEDHIT = 10,
		CR_RANGEDCRIT = 14,
		CR_HASTE = 10,
		CR_RANGEDHASTE = 10,
		CR_SPELLHIT = 8,
		CR_SPELLCRIT = 14,
		CR_SPELLHASTE = 10,
		CR_RESILIENCE = 25,
		CR_HIT_TAKEN = 10,
		CR_RANGEDHIT_TAKEN = 10,
		CR_SPELLHIT_TAKEN = 8,
		CR_EXPERTISE = 2.5,
	}

	local BonusRatingMap = {
		DEFENSE = "CR_DEFENSE",
		DODGE = "CR_DODGE",
		PARRY = "CR_PARRY",
		TOHIT = "CR_HIT",
		CRIT = "CR_CRIT",
		SPELLTOHIT = "CR_SPELLHIT",
		SPELLCRIT = "CR_SPELLCRIT",
		BLOCK = "CR_BLOCK",
	}

	local InverseBonusRatingMap = {}
	for k, v in pairs(BonusRatingMap) do
		InverseBonusRatingMap[v] = k
	end

	--[[
	The following calculations are based on Whitetooth's calculations:
	http://www.wowinterface.com/downloads/info5819-Rating_Buster.html
	]]
	local function GetRatingMultiplier(level)
		level = level or UnitLevel("player")
		if level < 10 then
			return 26
		elseif level <= 60 then
			return 52 / (level - 8)
		elseif level <= 70 then
			-- return 1 - (level - 60) * 3 / 82
			return 3.1951219512195124 - 0.036585365853658534 * level
		end
	end

	function ItemBonusLib:GetRatingBonus(type, value, level)
		local F = CombatRatingMap[type]
		if not F then
			return nil
		end
		return value / F * GetRatingMultiplier(level)
	end

	function GetBonus(type, map, level)
		local value = map[type]
		if not value then
			local rating = BonusRatingMap[type]
			if rating then
				value = map[rating]
				if value then
					value = ItemBonusLib:GetRatingBonus(rating, value, level)
				end
			elseif type == "ARMOR" then
				return GetBonus("BASE_ARMOR", map, level) + GetBonus("ARMOR_BONUS", map, level)
			end
		end
		return value or 0
	end

	function ItemBonusLib:GetFriendlyBonus(type, map, level)
		local rev = InverseBonusRatingMap[type]
		if not rev then
			return type, map[type]
		end
		return rev, self:GetRatingBonus(type, map[type], level)
	end
end

local Gratuity = AceLibrary("Gratuity-2.0")
local Deformat = AceLibrary("Deformat-2.0")

local CHAT_COMMANDS = { "/ibonus" }
local ABOUT_ADDON = "An addon to get information about bonus from equipped items"
local SHOW_CMD = "show"
local SHOW_ABOUT = "Show all bonuses from the current equipment"
local SHOW_INFO = "Current equipment bonuses:"
local DETAILS_CMD = "details"
local DETAILS_ABOUT = "Shows bonuses with slot distribution"
local DETAILS_INFO = "Current equipment bonus details:"
local ITEM_CMD = "item"
local ITEM_ABOUT = "show bonuses of given itemlink"
local ITEM_USAGE = "<itemlink>"
local ITEM_INFO = "Bonuses for %s:"
local ITEM_SET = "Item is part of set [%s]"
local SET_BONUS = " %sBonus for %d pieces :"
local SLOT_CMD = "slot"
local SLOT_ABOUT = "show bonuses of given slot"
local SLOT_USAGE = "<slotname>"
local SLOT_INFO = "Bonuses of slot %s:"
local INSPECT_CMD = "inspect"
local INSPECT_ABOUT = "show bonuses of the equipment of the given unit (must be able to inspect the unit)"
local INSPECT_USAGE = "<unit>"
local INSPECT_ERROR = "Unable to inspect unit \"%s\""
local INSPECT_INFO = "Bonuses of \"%s\":"
local L
local get_speed
do
	local locale = GetLocale()
	if locale == "frFR" then
		-- CHAT_COMMANDS = { "/ibonus" }
		ABOUT_ADDON = "Un addon pour obtenir les bonus concernant les items équipés"
		-- SHOW_CMD = "show"
		SHOW_ABOUT = "Afficher tous les bonus de l'équipement actuel"
		SHOW_INFO = "Bonus de l'équipement actuel :"
		-- DETAILS_CMD = "details"
		DETAILS_ABOUT = "Afficher les détails des bonus par emplacement d'inventaire"
		DETAILS_INFO = "Détails des bonus de l'équipement :"
		-- ITEM_CMD = "item"
		 ITEM_ABOUT = "Afficher les bonus détectés sur l'objet donnée"
		-- ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Bonus de %s :"
		ITEM_SET = "L'objet fait partie du set [%s]"
		SET_BONUS = " %sBonus pour %d pièces :"
		-- SLOT_CMD = "slot"
		SLOT_ABOUT = "Afficher les bonus de l'emplacement spécifié"
		SLOT_USAGE = "<emplacement>"
		SLOT_INFO = "Bonus de l'emplacement %s:"
		-- INSPECT_CMD = "inspect"
		INSPECT_ABOUT = "Afficher les bonus de l'équipement de l'unité donnée (vous devez être en mesure d'inspecter l'unité"
		INSPECT_USAGE = "<unité>"
		INSPECT_ERROR = "Impossible d'inspecter l'unité \"%s\""
		INSPECT_INFO = "Bonus de \"%s\" :"
		get_speed = function (s)
			return tonumber(s:sub(9):gsub(",", "."), nil)
		end
	elseif locale == "zhTW" then
		CHAT_COMMANDS = { "/ibonus" }

		ABOUT_ADDON = "一個用來取得裝備屬性加成訊息的插件"
		SHOW_CMD = "顯示"
		SHOW_ABOUT = "顯示所有現在所穿的裝備屬性加成"
		SHOW_INFO = "現在所穿的裝備屬性加成:"
		DETAILS_CMD = "詳細數據"
		DETAILS_ABOUT = "顯示屬性加成的位置分佈"

		DETAILS_INFO = "現在所穿的裝備屬性加成詳細數據:"
		ITEM_CMD = "物品"
		ITEM_ABOUT = "顯示屬性加成的物品連結"--"show bonuses of given itemlink"
		ITEM_USAGE = "<物品連結>"
		ITEM_INFO = "屬性加成 %s:"
		ITEM_SET = "Item is part of set [%s]"

		SET_BONUS = " %sBonus for %d pieces :"
		SLOT_CMD = "位置"
		SLOT_ABOUT = "顯示屬性加成的位置"--"show bonuses of given slot"
		SLOT_USAGE = "<位置名稱>"
		SLOT_INFO = "屬性加成的位置 %s:"
		INSPECT_CMD = "觀察"

		INSPECT_ABOUT = "顯示目標現在所穿的裝備屬性加成 (必須對目標點擊觀察)"
		INSPECT_USAGE = "<查詢目標>"
		INSPECT_ERROR = "目標不能觀察 \"%s\""
		INSPECT_INFO = "屬性加成 \"%s\":"
	elseif locale == "zhCN" then
		CHAT_COMMANDS = { "/ibonus" }

		ABOUT_ADDON = "一个用来取得装备属性加成信息的插件"
		SHOW_CMD = "显示"
		SHOW_ABOUT = "显示所有现在所穿的装备属性加成"
		SHOW_INFO = "现在所穿的装备属性加成："
		DETAILS_CMD = "详细数据"
		DETAILS_ABOUT = "显示属性加成的位置分布"

		DETAILS_INFO = "现在所穿的装备属性加成详细数据"
		ITEM_CMD = "物品"
		ITEM_ABOUT = "显示属性加成的物品连接"--"show bonuses of given itemlink"
		ITEM_USAGE = "<物品连接>"
		ITEM_INFO = "属性加成 %s:"
		ITEM_SET = "Item is part of set [%s]"

		SET_BONUS = " %sBonus for %d pieces :"
		SLOT_CMD = "位置"
		SLOT_ABOUT = "显示属性加成的位置"--"show bonuses of given slot"
		SLOT_USAGE = "<位置名称>"
 		SLOT_INFO = "属性加成的位置 %s:"
		INSPECT_CMD = "观察"

		INSPECT_ABOUT = "显示目标现在所穿的装备属性加成 (必须对目标点击观察)"
		INSPECT_USAGE = "<查询目标>"
		INSPECT_ERROR = "目标不能观察 \"%s\""
		INSPECT_INFO = "属性加成 \"%s\":"
	elseif locale == "deDE" then
		CHAT_COMMANDS = { "/ibonus" }
		ABOUT_ADDON = "Ein Addon um Item-Boni-Informationen deiner Ausr\195\188stung aufzulisten"
		SHOW_CMD = "Auflisten"
		SHOW_ABOUT = "Zeige alle Boni der aktuellen Ausr\195\188stung"
		SHOW_INFO = "Derzeitige Ausr\195\188stungs-Boni:"
		DETAILS_CMD = "Details"
		DETAILS_ABOUT = "Zeige Boni nach Slot-Verteilung"
		DETAILS_INFO = "Derzeitige Ausr\195\188stungs-Boni Details:"
		ITEM_CMD = "Item"
		ITEM_ABOUT = "zeige Boni eines Item-Links"
		ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Boni f\195\188r %s:"
		ITEM_SET = "Item ist Teil des [%s] Sets"
		SET_BONUS = " %sBonus f\195\188r %d Teile :"
		SLOT_CMD = "Slot"
		SLOT_ABOUT = "zeige Boni f\195\188r bestimten Slot"
		SLOT_USAGE = "<slotname>"
		SLOT_INFO = "Boni f\195\188r Slot %s:"
		INSPECT_CMD = "Inspizieren"
		INSPECT_ABOUT = "zeige Boni der Ausr\195\188stung eines anderen Spielers"
		INSPECT_USAGE = "<unit>"
		INSPECT_ERROR = "Kann die Ausr\195\188stung von \"%s\" nicht einsehen"
		INSPECT_INFO = "Boni von \"%s\":"
		get_speed = function (s)
			return tonumber(s:sub(7):gsub(",", "."), nil)
		end
	elseif locale == "koKR" then
		ABOUT_ADDON = "착용 장비의 보너스 효과에 대한 정보를 작성하는 애드온입니다"
		SHOW_CMD = "표시"
		SHOW_ABOUT = "현재 착용 장비의 모든 보너스 표시"
		SHOW_INFO = "현재 착용 장비 보너스:"
		DETAILS_CMD = "상세정보"
		DETAILS_ABOUT = "슬롯 부위별 보너스를 표시합니다"
		DETAILS_INFO = "현재 착용 보너스 상세정보:"
		ITEM_CMD = "아이템"
		ITEM_ABOUT = "주어진 아이템 링크에 대한 보너스를 표시합니다."
		ITEM_USAGE = "<아이템링크>"
		ITEM_INFO = "%s의 보너스 효과:"
		ITEM_SET = "[%s] 세트의 부분 아이템"
		SET_BONUS = "%d 피스 %s 보너스 효과"
		SLOT_CMD = "슬롯"
		SLOT_ABOUT = "주어진 슬롯에 대한 보너스 효과 표시"
		SLOT_USAGE = "<슬롯명칭>"
		SLOT_INFO = "%s 슬롯의 보너스 효과:"
		INSPECT_CMD = "살펴보기"
		INSPECT_ABOUT = "주어진 대상의 장비에 대한 보너스 효과 표시(대상 살펴보기가 가능해야 합니다)"
		INSPECT_USAGE = "<대상>"
		INSPECT_ERROR = "\"%s\" 대상을 조사할 수 없습니다."
		INSPECT_INFO = "\"%s\"의 보너스 효과:"
	elseif locale == "esES" then
		-- CHAT_COMMANDS = { "/ibonus" }
		ABOUT_ADDON = "Un addon para obtener los bonus de los items equipados"
		-- SHOW_CMD = "show"
		SHOW_ABOUT = "Muestra los bonus de los items equipados"
		SHOW_INFO = "Bonus del equipo actual :"
		-- DETAILS_CMD = "details"
		DETAILS_ABOUT = "Muestra los bonus de cada posici\195\179n"
		DETAILS_INFO = "Detalles de los bonus del equipo actual :"
		-- ITEM_CMD = "item"
		 ITEM_ABOUT = "Muesra los bonus del objeto indicado"
		-- ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Bonus de %s :"
		ITEM_SET = "El objeto forma parte del conjunto [%s]"
		SET_BONUS = " %sBonus por %d partes :"
		-- SLOT_CMD = "slot"
		SLOT_ABOUT = "Muestra los bonus de la posici\195\179n indicada"
		SLOT_USAGE = "<posici\195\179n>"
		SLOT_INFO = "Bonus de la posici\195\179n %s:"
		-- INSPECT_CMD = "inspect"
		INSPECT_ABOUT = "Muestra los bonus del equipo del personaje especificado (debe ser un personaje que se pueda inspeccionar)"
		INSPECT_USAGE = "<personaje>"
		INSPECT_ERROR = "Imposible inspaeccionar \"%s\""
		INSPECT_INFO = "Bonus de \"%s\" :"
		get_speed = function (s)
			return tonumber(s:sub(8))
		end
	end
end
if not get_speed then
	local l = WEAPON_SPEED:len() + 2
	get_speed = function (s)
		return tonumber(s:sub(l))
	end
end

-- bonuses[BONUS] = VALUE
local bonuses = {}

-- details[BONUS][SLOT] = VALUE
local details = {}

-- items[LINK].bonuses[BONUS] = VALUE
-- items[LINK].set = SETNAME
-- items[LINK].set_line = number
local items = {}

-- sets[SETNAME].bonuses[NUM][BONUS] = VALUE
-- sets[SETNAME].scan_count = COUNT
-- sets[SETNAME].scan_bonuses = COUNT
local sets = {}

local slots = {
	["Head"] = true,
	["Neck"] = true,
	["Shoulder"] = true,
	["Shirt"] = true,
	["Chest"] = true,
	["Waist"] = true,
	["Legs"] = true,
	["Feet"] = true,
	["Wrist"] = true,
	["Hands"] = true,
	["Finger0"] = true,
	["Finger1"] = true,
	["Trinket0"] = true,
	["Trinket1"] = true,
	["Back"] = true,
	["MainHand"] = true,
	["SecondaryHand"] = true,
	["Ranged"] = true,
	["Tabard"] = true,
}

local discard_on_add = {
	WEAPON_MIN = true,
	WEAPON_MAX = true,
	WEAPON_SPEED = true,
}
do
	local options = {
		type = "group",
		desc = ABOUT_ADDON,
		args = {
			show = {
				type = "execute",
				name = SHOW_CMD,
				desc = SHOW_ABOUT,
				func = function ()
					ItemBonusLib:Print(SHOW_INFO)
					for bonus in pairs(bonuses) do
						local type, value = ItemBonusLib:GetFriendlyBonus(bonus, bonuses)
						ItemBonusLib:Print("%s : %f", ItemBonusLib:GetBonusFriendlyName(type), value)
					end
				end
			},
			details = {
				type = "execute",
				name = DETAILS_CMD,
				desc = DETAILS_ABOUT,
				func = function ()
					ItemBonusLib:Print(DETAILS_INFO)
					for bonus, detail in pairs(details) do
						local s = {}
						for slot, value in pairs(detail) do
							table.insert(s, string.format("%s : %d", slot, value))
						end
						local type, value = ItemBonusLib:GetFriendlyBonus(bonus, bonuses)
						if type ~= bonus then
							value = string.format("%s (%s : %d)", tostring(bonuses[bonus]), ItemBonusLib:GetBonusFriendlyName(type), value)
						else
							value = tostring(bonuses[bonus])
						end
						ItemBonusLib:Print("%s : %s (%s)", ItemBonusLib:GetBonusFriendlyName(bonus), value, table.concat(s, ", "))
					end
				end
			},
			item = {
				type = "text",
				name = ITEM_CMD,
				desc = ITEM_ABOUT,
				usage = ITEM_USAGE,
				get = false,
				set = function (link)
					local info = ItemBonusLib:ScanItemLink(link)
					ItemBonusLib:Print(ITEM_INFO, link)
					for bonus, value in pairs(info.bonuses) do
						ItemBonusLib:Print("%s : %d", ItemBonusLib:GetBonusFriendlyName(bonus), value)
					end
					if info.set then
						ItemBonusLib:Print(ITEM_SET, info.set)
						local set = sets[info.set]
						for number, bonuses in pairs(set.bonuses) do
							local has_bonus = number <= set.count and "*" or " "
							ItemBonusLib:Print(SET_BONUS, has_bonus, number)
							for bonus, value in pairs(bonuses) do
								ItemBonusLib:Print(" %s : %d", ItemBonusLib:GetBonusFriendlyName(bonus), value)
							end
						end
					end
				end
			},
			slot = {
				type = "text",
				name = SLOT_CMD,
				desc = SLOT_ABOUT,
				usage = SLOT_USAGE,
				get = false,
				set = function (slot)
					ItemBonusLib:Print(SLOT_INFO, slot)
					for bonus, detail in pairs(details) do
						if detail[slot] then
							ItemBonusLib:Print("%s : %d", ItemBonusLib:GetBonusFriendlyName(bonus), detail[slot])
						end
					end
				end
			},
			inspect = {
				type = "text",
				name = INSPECT_CMD,
				desc = INSPECT_ABOUT,
				usage = INSPECT_USAGE,
				get = false,
				set = function (unit)
					local eq = ItemBonusLib:GetUnitEquipment(unit)
					if not eq then
						ItemBonusLib:Print(string.format(INSPECT_ERROR, unit))
						return
					end
					local b = ItemBonusLib:MergeDetails(ItemBonusLib:BuildBonusSet(eq))
					local n = UnitName(unit)
					local level = UnitLevel(unit)
					if n then
						n = string.format("|Hplayer:%s|h[%s]|h", n, n)
					else
						n = unit
					end
					ItemBonusLib:Print(string.format(INSPECT_INFO, n))
					for bonus in pairs(b) do
						local type, value = ItemBonusLib:GetFriendlyBonus(bonus, b, level)
						ItemBonusLib:Print("%s : %d", ItemBonusLib:GetBonusFriendlyName(type), value)
					end
				end
			},
		},
	}

	function ItemBonusLib:OnInitialize()
		for s in pairs(slots) do
			slots[s] = GetInventorySlotInfo (s.."Slot")
		end

		self:RegisterChatCommand(CHAT_COMMANDS, options)
	end
end

function ItemBonusLib:OnEnable()
	self:RegisterBucketEvent("UNIT_INVENTORY_CHANGED", 0.5)
	self:ScheduleEvent(function() self:ScanEquipment() end, 1)
end

function ItemBonusLib:OnDisable()
	self:ClearCache()
end

function ItemBonusLib:UNIT_INVENTORY_CHANGED(units)
	if units.player then
		self:ScanEquipment()
	end
end

local cleanItemLink
do -- AddValue & line scanning
	local trim = function (str)
		return strtrim (str, "\t \194\160"):gsub("%.$", "")
	end

	local equip = ITEM_SPELL_TRIGGER_ONEQUIP
	local l_equip = equip:len()

	function cleanItemLink(itemLink)
		local link = itemLink:match("|H(item[%d:]*)|")
		return link or itemLink
	end

	function ItemBonusLib:AddValue(bonuses, effect, value)
		if type(effect) == "string" then
			bonuses[effect] = (bonuses[effect] or 0) + value
		elseif type(value) == "table" then
			for i, e in ipairs(effect) do
				self:AddValue (bonuses, e, value[i])
			end
		else
			for _, e in ipairs(effect) do
				self:AddValue (bonuses, e, value)
			end
		end
	end

	function ItemBonusLib:AddValueMultiple(bonuses, effect, ...)
		if not ... then return end
		local n = select("#", ...)
		if n > 1 then
			assert(type(effect) == "table" and #effect == n)
			for i, e in ipairs(effect) do
				self:AddValue(bonuses, e, select(i, ...))
			end
		else
			self:AddValue(bonuses, effect, ...)
		end
		return true
	end
	function ItemBonusLib:CheckPassive(bonuses, line)
		for _, p in pairs(L.PATTERNS_PASSIVE) do
			local r = self:AddValueMultiple(bonuses, p.effect, line:match(p.pattern))
			if r then return r end
		end
	end

	function ItemBonusLib:CheckToken(bonuses, token, value)
		local t = L.PATTERNS_GENERIC_LOOKUP[token:lower()]
		if t then
			self:AddValue (bonuses, t, value)
			return true
		else
			local s1, s2

			for _, p in ipairs(L.PATTERNS_GENERIC_STAGE1) do
				if token:find (p.pattern, 1, 1) then
					s1 = p.effect
					break
				end
			end
			for _, p in ipairs(L.PATTERNS_GENERIC_STAGE2) do
				if token:find(p.pattern, 1, 1) then
					s2 = p.effect
					break
				end
			end
			if s1 and s2 then
				self:Debug("Detected %q as a generic %s%s", token, s1, s2)
				self:AddValue (bonuses, s1..s2, value)
				return true
			end
		end
		self:Debug("CheckToken failed for \"%s\" (%s)", token, value)
	end


	function ItemBonusLib:CheckSingleGeneric(bonuses, line)
		line = trim (line)
		if self:CheckSkillRating(bonuses, line) then
			return true
		end
		for pattern, invert in pairs(L.HEAL_AND_DMG_PATTERNS) do
			local heal, dmg = line:match(pattern)
			if heal and dmg then
				if invert then
					heal, dmg = dmg, heal
				end
				self:AddValue (bonuses, "HEAL", heal)
				self:AddValue (bonuses, "DMG", dmg)
				return true
			end
		end
		for pattern, invert in pairs(L.GENERIC_PATTERNS) do
			local token, value = line:match(pattern)
			if token and value then
				if invert then
					token, value = value, token
				end
				token, value = trim(token), trim(value)
				if self:CheckToken(bonuses, token, value) then
					return true
				end
			end
		end
	end

	function ItemBonusLib:CheckGeneric(bonuses, line)
		local found = self:CheckSingleGeneric(bonuses, line)

		if not found then
			while line:len() > 0 do
				local tmpStr
				for _, sep in ipairs(L.SEPARATORS) do
					local lstart, lend  = line:find(sep, 1, true)
					if lstart then
						tmpStr = line:sub(1, lstart - 1)
						line = line:sub(lend + 1)
						break
					end
				end
				if tmpStr then
					found = self:CheckSingleGeneric(bonuses, tmpStr) or found
				else
					found = self:CheckSingleGeneric(bonuses, line) or found
					break
				end
			end
		end
		return found
	end

	function ItemBonusLib:CheckOther(bonuses, line)
		for _, p in ipairs(L.PATTERNS_OTHER) do
			local start, _, value = line:find (p.pattern)
			if start then
				if p.value then
					self:AddValue(bonuses, p.effect, p.value)
				elseif value then
					self:AddValue (bonuses, p.effect, value)
				end
				return true
			end
		end
	end

	function ItemBonusLib:CheckSkillRating(bonuses, line)
		self:Debug("CheckSkillRating(%q)", line)
		for _, p in ipairs(L.PATTERNS_SKILL_RATING) do
			local rating, value = line:match(p.pattern)
			if p.invert then
				value, rating = rating, value
			end
			if rating then
				local bonus = L.SKILL_NAMES[rating]
				if bonus then
					self:AddValue(bonuses, bonus, value)
					return true
				else
					self:Debug("Unknown rating \"%s\"", rating)
					return
				end
			end
		end
	end

	function ItemBonusLib:AddBonusInfo(bonuses, line)
		local found
		line = strtrim(line)
		if line:sub(0, 2) == "|c" then
			-- fix for white enchants
			line = strtrim(line:sub(11, -3))
		end
		if line:sub(0, l_equip) == equip then
			line = strtrim(line:sub(l_equip + 2))
		end
		if
			not self:CheckPassive (bonuses, line) and
			not self:CheckGeneric(bonuses, line) and
			not self:CheckOther(bonuses, line)
		then
			self:Debug("Unmatched bonus line \"%s\"", line)
		end
	end
end

do -- Item scanning
	local ITEM_SET_NAME = ITEM_SET_NAME
	local ITEM_SET_BONUS = ITEM_SET_BONUS
	local ITEM_SET_BONUS_GRAY = ITEM_SET_BONUS_GRAY
	local ITEM_SOCKET_BONUS = ITEM_SOCKET_BONUS
	local DAMAGE_TEMPLATE = DAMAGE_TEMPLATE
	local DAMAGE_TEMPLATE_WITH_SCHOOL = DAMAGE_TEMPLATE_WITH_SCHOOL

	function ItemBonusLib:ScanItemLink(link, no_cache)
		link = cleanItemLink(link)
		local info = not no_cache and items[link]
		local scan_set
		local set_name, set_count, set_total
		if not info then
			info = { bonuses = {} }
			Gratuity:SetHyperlink(link)
			for i = 2, Gratuity:NumLines() do
				local line = Gratuity:GetLine(i)

				-- The following is needed after 2.2 because meta-gem
				-- requirements are appened after the bonus. (thanks Lerkur)
				if line:find("\n", nil, true) then
					line = strsplit("\n", line)
				end

				set_name, set_count, set_total = Deformat(line, ITEM_SET_NAME)
				if set_name then
					info.set = set_name
					info.set_line = i
					local set = sets[set_name]
					if not set or set.scan_count > set_count and set.scan_bonuses > 1 then
						scan_set = true
					end
					break
				end
				local bonus = Deformat(line, ITEM_SOCKET_BONUS)
				if bonus then
					-- evil hack, I need to check the color of the string to know
					-- if the bonus is active or not.
					local frame = Gratuity.vars.Llines[i]
					local r, g, b = frame:GetTextColor()
					self:Debug("Found Gem Bonus line \"%s\" : color = %f, %f, %f", bonus, r, g, b)
					if r <= 0.1 and g >= 0.9 and b <= 0.1 then
						self:AddBonusInfo(info.bonuses, bonus)
					else
						local b = info.inactive_gem_bonus
						if not b then
							b = {}
							info.inactive_gem_bonus = b
						end
						self:AddBonusInfo(b, bonus)
					end
				else
					local dmg_min, dmg_max = Deformat(line, DAMAGE_TEMPLATE)
					if not dmg_min then
						dmg_min, dmg_max = Deformat(line, DAMAGE_TEMPLATE_WITH_SCHOOL)
					end
					if not dmg_min then
						self:AddBonusInfo(info.bonuses, line)
					else
						local b = info.bonuses
						b.WEAPON_MIN = dmg_min
						b.WEAPON_MAX = dmg_max
						b.WEAPON_SPEED = get_speed(Gratuity:GetLine(i, true))
					end
				end
			end
			if not no_cache then
				items[link] = info
			end
		elseif info.set then
			local set = sets[info.set]
			if set.scan_count > 2 then
				Gratuity:SetHyperlink(link)
				set_name, set_count, set_total = Deformat(Gratuity:GetLine(info.set_line), ITEM_SET_NAME)
				if set.scan_count > set_count and set.scan_bonuses > 1 then
					scan_set = true
				end
			end
		end
		if scan_set then
			self:Debug("Scanning set \"%s\"", set_name)
			local set = { count = 0, bonuses = {}, scan_count = set_count, scan_bonuses = 0 }
			for i = info.set_line + set_total + 2, Gratuity:NumLines() do
				local line = Gratuity:GetLine(i)
				local count, bonus
				local bonus = Deformat(line, ITEM_SET_BONUS)
				if bonus then
					set.scan_bonuses = set.scan_bonuses + 1
					count = set_count
				else
					count, bonus = Deformat(line, ITEM_SET_BONUS_GRAY)
				end
				if not bonus then
					self:Debug("Invalid set line \"%s\"", line)
					-- break
				else
					local bonuses = set.bonuses[count] or {}
					self:AddBonusInfo(bonuses, bonus, true)
					set.bonuses[count] = bonuses
				end
			end
			sets[set_name] = set
		end
		return info
	end
end

function ItemBonusLib:GetUnitEquipment(unit)
	local inspect
	if unit ~= "player" and (unit ~= "target" or not InspectFrame:IsShown()) then
		if not CheckInteractDistance(unit, 1) or
				not CanInspect(unit, true) then
			return nil
		end
		HideUIPanel(InspectFrame)
		NotifyInspect(unit)
		inspect = true
	end
	local eq = {}
	for slot, id in pairs(slots) do
		eq[slot] = GetInventoryItemLink(unit, id)
	end
	if inspect then
		ClearInspectPlayer()
	end
	return eq
end

local function mergeBonusTable(result, operand)
	for k, v in pairs(operand) do
		result[k] = (result[k] or 0) + v
	end
end

function ItemBonusLib:BuildBonusSet(eq)
	local details = {}
	local set_count = {}
	for slot, link in pairs(eq) do
		local info = self:ScanItemLink(link)
		local set = info.set
		if set then
			set_count[set] = (set_count[set] or 0) + 1
		end
		for bonus, value in pairs(info.bonuses) do
			local b = details[bonus]
			if not b then
				b = {}
				details[bonus] = b
			end
			b[slot] = value
		end
	end
	for set, count in pairs(set_count) do
		local info = sets[set]
		for i = 2, count do
			local bonuses = info.bonuses[i]
			if bonuses then
				for bonus, value in pairs(bonuses) do
					local b = details[bonus]
					if not b then
						b = {}
						details[bonus] = b
					end
					b.Set = (b.Set or 0) + value
				end
			end
		end
	end
	return details, set_count
end

function ItemBonusLib:MergeDetails(details)
	local bonuses = {}
	for bonus, slots in pairs(details) do
		if not discard_on_add[bonus] then
			for slot, value in pairs(slots) do
				bonuses[bonus] = (bonuses[bonus] or 0) + value
			end
		end
	end
	return bonuses
end

function ItemBonusLib:ScanEquipment()
	local eq = self:GetUnitEquipment("player")
	details = self:BuildBonusSet(eq)
	bonuses = self:MergeDetails(details)

	self:TriggerEvent("ItemBonusLib_Update")
end

-- DEBUG
if DEBUG then
	ItemBonusLib.patterns = L

	if DevTools_Dump then
		function ItemBonusLib:DumpCachedItems(clear)
			DevTools_Dump(items)
		end

		function ItemBonusLib:DumpCachedSets(clear)
			DevTools_Dump(sets)
		end

		function ItemBonusLib:DumpBonuses()
			DevTools_Dump(bonuses)
		end

		function ItemBonusLib:DumpDetails()
			DevTools_Dump(details)
		end
	end
end

function ItemBonusLib:Reload()
	self:ClearCache()
	self:ScanEquipment()
end

function ItemBonusLib:ClearCache()
	items, sets = {}, {}
end

function ItemBonusLib:GetSetBonuses(set)
	local info = sets[set]
	if info then
		return info.bonuses
	end
end

-- BonusScanner compatible API
function ItemBonusLib:GetBonus(bonus, table, level)
	return GetBonus(bonus, table or bonuses, level)
end

function ItemBonusLib:GetSlotBonuses (slotname)
	local bonuses = {}
	for bonus, detail in pairs(details) do
		if detail[slotname] then
			bonuses[bonus] = detail[slotname]
		end
	end
	return bonuses
end

function ItemBonusLib:GetBonusDetails (bonus)
	return details[bonus] or {}
end

function ItemBonusLib:GetSlotBonus (bonus, slotname)
	local detail = details[bonus]
	return detail and detail[slotname] or 0
end

function ItemBonusLib:GetBonusFriendlyName (bonus)
	return L.NAMES[bonus] or bonus
end

function ItemBonusLib:IsActive ()
	return true
end

function ItemBonusLib:ScanItem (itemlink, excludeSet, no_cache)
	if not excludeSet then
		self:error("excludeSet can't be false on BonusScanner compatible API")
	end
	local name, link = GetItemInfo(itemlink)
	if not name then
		return
	end
	return self:ScanItemLink(link, no_cache).bonuses
end

function ItemBonusLib:ScanTooltipFrame (frame, excludeSet)
	self:error("BonusScanner:ScanTooltipFrame() is not available")
end

do -- localisation of regexp
	local ALL_RESISTS = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}
	local ALL_STATS = {"STR", "AGI", "STA", "INT", "SPI"}
	local HEAL_AND_DMG = {"HEAL", "DMG"}
	local locale = GetLocale()
	if locale == "enUS" or locale == "enGB" then
		L = {
			NAMES = {
				STR = "Strength",
				AGI = "Agility",
				STA = "Stamina",
				INT = "Intellect",
				SPI = "Spirit",
				ARMOR = "Armor",
				BASE_ARMOR = "Base Armor",
				ARMOR_BONUS = "Armor Bonus",

				ARCANERES = "Arcane Resistance",
				FIRERES = "Fire Resistance",
				NATURERES = "Nature Resistance",
				FROSTRES = "Frost Resistance",
				SHADOWRES = "Shadow Resistance",

				FISHING = "Fishing",
				MINING = "Mining",
				HERBALISM = "Herbalism",
				SKINNING = "Skinning",
				DEFENSE = "Defense",

				BLOCK = "Chance to Block",
				BLOCKVALUE = "Block value",
				DODGE = "Dodge",
				PARRY = "Parry",
				ATTACKPOWER = "Attack Power",
				ATTACKPOWERUNDEAD = "Attack Power against Undead",
				ATTACKPOWERBEAST = "Attack Power against Beasts",
				ATTACKPOWERFERAL = "Attack Power in feral form",
				CRIT = "Crit. hits",
				RANGEDATTACKPOWER = "Ranged Attack Power",
				RANGEDCRIT = "Crit. Shots",
				TOHIT = "Chance to Hit",
				IGNOREARMOR = "Ignore Armor",
				THREATREDUCTION = "Reduced Threat",

				DMG = "Spell Damage",
				DMGUNDEAD = "Spell Damage against Undead",
				ARCANEDMG = "Arcane Damage",
				FIREDMG = "Fire Damage",
				FROSTDMG = "Frost Damage",
				HOLYDMG = "Holy Damage",
				NATUREDMG = "Nature Damage",
				SHADOWDMG = "Shadow Damage",
				SPELLCRIT = "Crit. Spell",
				SPELLTOHIT = "Chance to Hit with spells",
				SPELLPEN = "Spell Penetration",
				HEAL = "Healing",
				HOLYCRIT = "Crit. Holy Spell",

				HEALTHREG = "Life Regeneration",
				MANAREG = "Mana Regeneration",
				HEALTH = "Life Points",
				MANA = "Mana Points",

				CR_WEAPON = "Weapon rating",
				CR_DEFENSE = "Defense rating",
				CR_DODGE = "Dodge rating",
				CR_PARRY = "Parry rating",
				CR_BLOCK = "Block rating",
				CR_HIT = "Hit rating",
				CR_CRIT = "Critical strike rating",
				CR_HASTE = "Haste rating",
				CR_SPELLHIT = "Hit with spell rating",
				CR_SPELLCRIT = "Critical strike with spell rating",
				CR_SPELLHASTE = "Spell haste rating",
				CR_RESILIENCE = "Resilience",
				CR_WEAPON_AXE = "Axe skill rating",
				CR_WEAPON_DAGGER = "Dagger skill rating",
				CR_WEAPON_MACE = "Mace skill rating",
				CR_WEAPON_SWORD = "Sword skill rating",
				CR_WEAPON_SWORD_2H = "Two-Handed Swords skill rating",
				SNARERES = "Snare and Root effects Resistance",
			},

			PATTERNS_SKILL_RATING = {
				{ pattern = "Increases your (.*) rating by (%d+)" },
				{ pattern = "Increases (.*) rating by (%d+)" },
				{ pattern = "Improves your (.*) rating by (%d+)" },
				{ pattern = "Improves (.*) rating by (%d+)" },
			},

			SKILL_NAMES = {
				["hit"] = "CR_HIT",
				["critical strike"] = "CR_CRIT",
				["ranged critical strike"] = "CR_RANGEDCRIT",
				["defense"] = "CR_DEFENSE",
				["spell critical strike"] = "CR_SPELLCRIT",
				["resilience"] = "CR_RESILIENCE",
				["spell hit"] = "CR_SPELLHIT",
				["dodge"] = "CR_DODGE",
				["block"] = "CR_BLOCK",
				["parry"] = "CR_PARRY",
				["axe skill"] = "CR_WEAPON_AXE",
				["dagger skill"] = "CR_WEAPON_DAGGER",
				["mace skill"] = "CR_WEAPON_MACE",
				["sword skill"] = "CR_WEAPON_SWORD",
				["two-handed sword skill"] = "CR_WEAPON_SWORD_2H",
				["feral combat skill"] = "CR_WEAPON_FERAL",
				["shield block"] = "CR_BLOCK",
				["haste"] = "CR_HASTE",
				["spell haste"] = "CR_SPELLHASTE",
				["unarmed skill"] = "CR_WEAPON_FIST",
				["fist skill"] = "CR_WEAPON_FIST",
				["crossbow skill"] = "CR_WEAPON_CROSSBOW",
				["gun skill"] = "CR_WEAPON_GUN",
				["bow skill"] = "CR_WEAPON_BOW",
				["staff skill"] = "CR_WEAPON_STAFF",
				["two-handed maces skill"] = "CR_WEAPON_MACE_2H",
				["two-handed axes skill"] = "CR_WEAPON_AXE_2H",
				["expertise"] = "CR_EXPERTISE",
			},


			PATTERNS_PASSIVE = {
				{ pattern = "Increases ranged attack power by (%d+)%.", effect = "RANGEDATTACKPOWER" },
				{ pattern = "Increases the block value of your shield by (%d+)%.", effect = "BLOCKVALUE" },
				{ pattern = "Increases damage done by Arcane spells and effects by up to (%d+)%.", effect = "ARCANEDMG" },
				{ pattern = "Increases damage done by Fire spells and effects by up to (%d+)%.", effect = "FIREDMG" },
				{ pattern = "Increases damage done by Frost spells and effects by up to (%d+)%.", effect = "FROSTDMG" },
				{ pattern = "Increases damage done by Holy spells and effects by up to (%d+)%.", effect = "HOLYDMG" },
				{ pattern = "Increases damage done by Nature spells and effects by up to (%d+)%.", effect = "NATUREDMG" },
				{ pattern = "Increases damage done by Shadow spells and effects by up to (%d+)%.", effect = "SHADOWDMG" },
				{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
				{ pattern = "Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.", effect = HEAL_AND_DMG },
				{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
				{ pattern = "Increases damage done to Demons by magical spells and effects by up to (%d+)%.", effect = "DMGDEMON" },
				{ pattern = "Increases damage done to Undead and Demons by magical spells and effects by up to (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
				{ pattern = "Increases attack power by (%d+) when fighting Undead%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
				{ pattern = "Increases attack power by (%d+) when fighting Beasts%.", effect = "ATTACKPOWERBEAST" },
				{ pattern = "Increases attack power by (%d+) when fighting Demons%.", effect = "ATTACKPOWERDEMON" },
				{ pattern = "Increases attack power by (%d+) when fighting Elementals%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
				{ pattern = "Increases attack power by (%d+) when fighting Dragonkin%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
				{ pattern = "Increases attack power by (%d+) when fighting Undead and Demons%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
				{ pattern = "Restores (%d+) health per 5 sec%.", effect = "HEALTHREG" },
				{ pattern = "Restores (%d+) health every 5 sec%.", effect = "HEALTHREG" }, -- 833, 17743
				{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
				{ pattern = "Your attacks ignore (%d+) of your opponent's armor.", effect = "IGNOREARMOR" },

				-- Atiesh related patterns
				{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG", "HEAL"} },
				{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = "HEAL" },
				{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
				{ pattern = "Increases the spell critical chance of all party members within %d+ yards by (%d+)%%%.", effect = "SPELLCRIT" },

				-- Added for HealPoints
				{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
				{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
				{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
				{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
				{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
				{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
				{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
				{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
				{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
				{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
				{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
				{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
				{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
				{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
				{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
				{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
				{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
				{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

				{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },
				{ pattern = "Increases attack power by (%d+)%.", effect = "ATTACKPOWER" },
				{ pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
				{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
				{ pattern = "Increases your effective stealth level by (%d+)%.", effect = "STEALTH" },
				{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
				{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
				{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
				{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
				{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
				{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
				{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
				{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
				{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
				{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
				{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
				{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
				{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CR_RANGEDCRIT" },

				-- metagem bonuses (thanks Lerkur)
				{ pattern = "%+(%d+) Agility & (%d+)%% Increased Critical Damage", effect = {"AGI", "CRITDMG"} },
				{ pattern = "%+(%d+) Spell Critical & (%d+)%% Increased Critical Damage", effect = {"CR_SPELLCRIT", "SPELLCRITDMG"} },
				{ pattern = "%+(%d+) Spell Damage & %+(%d+)%% Intellect", effect = {HEAL_AND_DMG, "MOD_INT"} },
				{ pattern = "%+(%d+) Defense Rating & %+(%d+)%% Shield Block Value", effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"} },
			},

			SEPARATORS = { "/", ",", "&", " and " },
			
			HEAL_AND_DMG_PATTERNS = {
				["%+(%d+) Healing and %+(%d+) Spell Damage"] = false,
				["%+(%d+) Healing Spells and %+(%d+) Damage Spells"] = false,
				["%+(%d+) Healing %+(%d+) Spell Damage"] = false,
			},

			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["All Stats"] = ALL_STATS,
				["Strength"] = "STR",
				["Agility"] = "AGI",
				["Stamina"] = "STA",
				["Intellect"] = "INT",
				["Spirit"] = "SPI",

				["All Resistances"] = ALL_RESISTS,

				["Fishing"] = "FISHING",
				["Fishing Lure"] = "FISHING",
				["Increased Fishing"] = "FISHING",
				["Mining"] = "MINING",
				["Herbalism"] = "HERBALISM",
				["Skinning"] = "SKINNING",
				["Defense"] = "CR_DEFENSE",
				["Increased Defense"] = "DEFENSE",

				["Attack Power"] = "ATTACKPOWER",
				["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",

				["Dodge"] = "DODGE",
				["Block"] = "BLOCKVALUE",
				["Block Value"] = "BLOCKVALUE",
				["Hit"] = "TOHIT",
				["Spell Hit"] = "SPELLTOHIT",
				["Blocking"] = "BLOCK",
				["Ranged Attack Power"] = "RANGEDATTACKPOWER",
				["health every 5 sec"] = "HEALTHREG",
				["Healing Spells"] = "HEAL",
				["Increases Healing"] = "HEAL",
				["Healing"] = "HEAL",
				["healing Spells"] = "HEAL",
				["Healing and Spell Damage"] = HEAL_AND_DMG,
				["Damage and Healing Spells"] = HEAL_AND_DMG,
				["Spell Damage and Healing"] = HEAL_AND_DMG,
				["Spell Power"] = HEAL_AND_DMG,
				["Spell Damage"] = HEAL_AND_DMG,
				["Critical"] = "CRIT",
				["Critical Hit"] = "CRIT",
				["Health"] = "HEALTH",
				["HP"] = "HEALTH",
				["Mana"] = "MANA",
				["Armor"] = "BASE_ARMOR",
				["Reinforced Armor"] = "ARMOR_BONUS",
				["Resilience"] = "CR_RESILIENCE",
				["Spell Critical strike rating"] = "CR_SPELLCRIT",
				["Spell Penetration"] = "SPELLPEN",
				["Hit Rating"] = "CR_HIT",
				["Defense Rating"] = "CR_DEFENSE",
				["Resilience Rating"] = "CR_RESILIENCE",
				["Crit Rating"] = "CR_CRIT",
				["Critical Rating"] = "CR_CRIT",
				["Critical Strike Rating"] = "CR_CRIT",
				["Dodge Rating"] = "CR_DODGE",
				["Parry Rating"] = "CR_PARRY",
				["Spell Critical Strike Rating"] = "CR_SPELLCRIT",
				["Spell Critical Rating"] = "CR_SPELLCRIT",
				["Spell Critical"] = "CR_SPELLCRIT",
				["Spell Crit Rating"] = "CR_SPELLCRIT",
				["Spell Hit Rating"] = "CR_SPELLHIT",
				["Spell Haste Rating"] = "CR_SPELLHASTE",
				["Haste Rating"] = "CR_HASTE",
				["Mana every 5 Sec"] = "MANAREG",
				["Mana per 5 Seconds"] = "MANAREG",
				["Mana every 5 seconds"] = "MANAREG",
				["Mana Per 5 sec"] = "MANAREG",
				["mana per 5 sec"] = "MANAREG",
				["mana every 5 sec"] = "MANAREG",
				["Mana Regen"] = "MANAREG",
				["Melee Damage"] = "MELEEDMG",
				["Weapon Damage"] = "MELEEDMG",
				["Resist All"] = ALL_RESISTS,
				["Reduced Threat"] = "THREATREDUCTION",
				["Two-Handed Axe Skill Rating"] = "CR_WEAPON_AXE_2H",
				["Stun Resistance"] = "STUNRESIST",
			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "Arcane", 	effect = "ARCANE" },
				{ pattern = "Fire", 	effect = "FIRE" },
				{ pattern = "Frost", 	effect = "FROST" },
				{ pattern = "Holy", 	effect = "HOLY" },
				{ pattern = "Shadow",	effect = "SHADOW" },
				{ pattern = "Nature", 	effect = "NATURE" }
			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "Resist", 	effect = "RES" },
				{ pattern = "Damage", 	effect = "DMG" },
				{ pattern = "Effects", 	effect = "DMG" },
			},

			PATTERNS_OTHER = {
				{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR_BONUS" },
				{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },

				{ pattern = "Minor Wizard Oil", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "Lesser Wizard Oil", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "Wizard Oil", effect = HEAL_AND_DMG, value = 24 },
				{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

				{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
				{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
				{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

				{ pattern = "Eternium Line", effect = "FISHING", value = 5 },
				{ pattern = "Vitality", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
				{ pattern = "Soulfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
				{ pattern = "Sunfire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
				{ pattern = "Savagery", effect = "ATTACKPOWER", value = 70 },
				{ pattern = "Surefooted", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
				{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
				{ pattern = "%+2%% Threat", effect = "THREATREDUCTION", value = -2 },
				{ pattern = "Subtlety", effect = "THREATREDUCTION", value = 2 },

				{ pattern = "Allows underwater breathing%.", effect = "UNDERWATER", value = 1 }, -- 10506
				{ pattern = "Increases your lockpicking skill slightly%.", effect = "LOCKPICK", value = 1 },
				{ pattern = "Moderately increases your stealth detection%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
				{ pattern = "Slightly increases your stealth detection%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
				{ pattern = "Immune to Disarm%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
				{ pattern = "Minor increase to running and swimming speed%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
				{ pattern = "Reduces damage from falling%.", effect = "SLOWFALL", value = 1 }, -- 19982
				{ pattern = "Increases movement speed and life regeneration rate%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
				{ pattern = "Run speed increased slightly%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
				{ pattern = "Increases your stealth slightly%.", effect = "STEALTH", value = 3 }, -- 21758
				{ pattern = "Increases your effective stealth level%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
				{ pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

--				{ pattern = "Impress others with your fashion sense%.", effect = "IMPRESS", value = 1 }, -- 10036
--				{ pattern = "Increases your Mojo%.", effect = "MOJO", value = 1 }, -- 23717
			},
		}
	elseif locale == "frFR" then
		L = {
			NAMES = {
				STR = "Force",
				AGI = "Agilité",
				STA = "Endurance",
				INT = "Intelligence",
				SPI = "Esprit",
				ARMOR = "Armure",

				ARCANERES = "Arcane",
				FIRERES = "Feu",
				NATURERES = "Nature",
				FROSTRES = "Givre",
				SHADOWRES = "Ombre",

				FISHING = "Pêche",
				MINING = "Minage",
				HERBALISM = "Herborisme",
				SKINNING = "Dépeçage",
				DEFENSE = "Défense",

				BLOCK = "Chance de Bloquer",
				BLOCKVALUE = "Valeur de blocage",
				DODGE = "Esquive",
				PARRY = "Parade",
				ATTACKPOWER = "Puissance d'attaque",
				ATTACKPOWERUNDEAD = "Puissance d'attaque contre les morts-vivants",
				ATTACKPOWERFERAL = "Puissance d'attaque en forme férale",
				CRIT = "Coups Critiques",
				RANGEDATTACKPOWER = "Puissance d'attaque à distance",
				RANGEDCRIT = "Tirs Critiques",
				TOHIT = "Chances de toucher",

				DMG = "Dégâts",
				DMGUNDEAD = "Dégâts des sorts contre les morts-vivants",
				ARCANEDMG = "Dégâts d'Arcanes",
				FIREDMG = "Dégâts de Feu",
				FROSTDMG = "Dégâts de Givre",
				HOLYDMG = "Dégâts Sacrés",
				NATUREDMG = "Dégâts de Nature",
				SHADOWDMG = "Dégâts des Ombres",
				SPELLCRIT = "Chance de Coups Critiques des sorts",
				HEAL = "Soins",
				HOLYCRIT = "Chance de Coups Critiques des sorts du sacré",
				SPELLTOHIT = "Chance de toucher des sorts",
				SPELLPEN = "Diminue les résistances",

				HEALTHREG = "Régeneration Vie",
				MANAREG = "Régeneration Mana",
				HEALTH = "Points de Vie",
				MANA = "Points de Mana",

				CR_WEAPON = "Score d'arme",
				CR_DEFENSE = "Score de défense",
				CR_DODGE = "Score d'esquive",
				CR_PARRY = "Score de parade",
				CR_BLOCK = "Score de blocage",
				CR_HIT = "Score de toucher",
				CR_CRIT = "Score de coups critiques",
				CR_HASTE = "Score de hâte",
				CR_SPELLHIT = "Score de toucher des sorts",
				CR_SPELLCRIT = "Score de coups critiques des sorts",
				CR_SPELLHASTE = "Score de hâte des sorts",
				CR_RESILIENCE = "Résilience",
				CR_EXPERTISE = "Score d'expertise",

			},

			PATTERNS_SKILL_RATING = {
				{ pattern = "Augmente le score d[e'] ?(.*) de (%d+)" },
				{ pattern = "Score d[e'] ?(.*) augmenté de (%d+)" },
				{ pattern = "Augmente votre score d[e'] ?(.*) de (%d+)" },
				{ pattern = "Augmente de (%d+) le score d[e'] ?(.*)", invert = true },
				{ pattern = "%+(%d+) au score d[e'] ?(.*)", invert = true },
			},
			SKILL_NAMES = {
				["toucher"] = "CR_HIT",
				["coup critique"] = "CR_CRIT",
				["coup critique à distance"] = "CR_RANGEDCRIT",
				["défense"] = "CR_DEFENSE",
				["coup critique des sorts"] = "CR_SPELLCRIT",
				["critique des sorts"] = "CR_SPELLCRIT",
				["résilience"] = "CR_RESILIENCE",
				["toucher des sorts"] = "CR_SPELLHIT",
				["esquive"] = "CR_DODGE",
				["blocage"] = "CR_BLOCK",
				["parade"] = "CR_PARRY",
				["la compétence Mains nues"] = "CR_WEAPON_FIST",
				["la compétence Haches à deux mains"] = "CR_WEAPON_AXE_2H",
				["la compétence Arbalètes"] = "CR_WEAPON_CROSSBOW",
				["la compétence Armes à feu"] = "CR_WEAPON_GUN",
				["la compétence Arcs"] = "CR_WEAPON_BOW",
				["la compétence Bâton"] = "CR_WEAPON_STAFF",
				["la compétence Armes de pugilat"] = "CR_WEAPON_FIST",
				["la compétence Epées"] = "CR_WEAPON_SWORD",
				["la compétence Masses"] = "CR_WEAPON_MACE",
				["la compétence Dagues"] = "CR_WEAPON_DAGGER",
				["la compétence Haches"] = "CR_WEAPON_AXE",
				["la compétence Epées à deux mains"] = "CR_WEAPON_SWORD_2H",
				["la compétence Masses à deux mains"] = "CR_WEAPON_MACE_2H",
				["compétence Combat farouche"] = "CR_WEAPON_FERAL",
				["hâte"] = "CR_HASTE",
				["hâte des sorts"] = "CR_SPELLHASTE",
				["expertise"] = "CR_EXPERTISE",
			},

			PATTERNS_PASSIVE = {
				{ pattern = "Augmente de (%d+) la puissance d'attaque%.", effect = "ATTACKPOWER" },
				{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez [dl]es morts%-vivants%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
				{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des bêtes%.", effect = "ATTACKPOWERBEAST" },
				{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des démons%.", effect = "ATTACKPOWERDEMON" },
				{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des élémentaires%.", effect = "ATTACKPOWERELEMENTAL" },
				{ pattern = "Augmente de (%d+) la puissance d'attaque lorsque vous combattez des draconiens%.", effect = "ATTACKPOWERDRAGON" },
				{ pattern = "Augmente la puissance des attaques à distance de (%d+)%.", effect = "RANGEDATTACKPOWER" },
				{ pattern = "Augmente la valeur de blocage de votre bouclier de (%d+)%.", effect = "BLOCKVALUE" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets des Arcanes de (%d+) au maximum%.", effect = "ARCANEDMG" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets de Feu de (%d+) au maximum%.", effect = "FIREDMG" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets de Givre de (%d+) au maximum%.", effect = "FROSTDMG" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets de Nature de (%d+) au maximum%.", effect = "NATUREDMG" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets d'Ombre de (%d+) au maximum%.", effect = "SHADOWDMG" },
				{ pattern = "Augmente les dégâts infligés par les sorts et effets du Sacré de (%d+) au maximum%.", effect = "HOLYDMG" },
				{ pattern = "Augmente de (%d+) au maximum les dégâts infligés par les sorts et effets du Sacré%.", effect = "HOLYDMG" },
				{ pattern = "(%d+)% aux dégâts des sorts d'ombres%.", effect = "SHADOWDMG" },
				{ pattern = "Augmente les soins prodigués par les sorts et effets de (%d+) au maximum%.", effect = "HEAL"},
				{ pattern = "Augmente les soins prodigués par les sorts et effets d’un maximum de (%d+)%.", effect = "HEAL"}, -- 30134 
				{ pattern = "Augmente les soins prodigués d'un maximum de (%d+) et les dégâts d'un maximum de (%d+) pour tous les sorts et effets magiques%.", effect = HEAL_AND_DMG },
				{ pattern = "Augmente les dégâts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", effect = HEAL_AND_DMG},
				{ pattern = "Augmente les dégâts infligés aux morts%-vivants par les sorts et effets magiques de (%d+) au maximum%.", effect = "DMGUNDEAD" },
				{ pattern = "Augmente les dégâts infligés aux morts%-vivants par les sorts et effets magiques d'un maximum de (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
				{ pattern = "Augmente les dégâts infligés aux démons par les sorts et effets magiques d'un maximum de (%d+)%.", effect = "DMGDEMON" },
				{ pattern = "Augmente les dégâts infligés aux morts%-vivants et aux démons par les sorts et effets magiques d'un maximum de (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
				{ pattern = "Rend (%d+) points de vie toutes les 5 sec%.", effect = "HEALTHREG" },
				{ pattern = "Rend (%d+) points de vie toutes les 4 sec%.", effect = "HEALTHREG" },
				{ pattern = "Rend (%d+) points de mana toutes les 5 secondes%.", effect = "MANAREG" },
				{ pattern = "Rend (%d+) points de mana toutes les 5 sec%.", effect = "MANAREG" },
				{ pattern = "Pêche augmentée de (%d+).", effect = "FISHING" },
				{ pattern = "Augmente de +(%d+) la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement%.", effect = "ATTACKPOWERFERAL"},
				{ pattern = "Augmente les dégâts infligés par vos sorts d'un maximum de (%d+) et vos soins d'un maximum de (%d+).", effect = {"DMG", "HEAL"} },
				{ pattern = "Augmente de (%d+) au maximum les soins prodigués par les sorts et effets magiques de tous les membres du groupe situés à moins de %d+ mètres%.", effect = "HEAL" },
				{ pattern = "Augmente de (%d+) au maximum les dégâts et les soins produits par les sorts et effets magiques de tous les membres du groupe situés à moins de %d+ mètres%.", effect = HEAL_AND_DMG },
				{ pattern = "Rend (%d)+ points de mana toutes les 5 secondes à tous les membres du groupe situés à moins de %d+ mètres.", effect = "MANAREG" },
				{ pattern = "Augmente de (%d+) le score de critique des sorts de tous les membres du groupe se trouvant à moins de %d+ mètres%.", effect = "CR_SPELLCRIT" },

				-- Added
				{ pattern = "Vous confère (%d+)%% de votre vitesse de récupération du mana normale pendant l'incantation%.", effect = "CASTINGREG"},
				{ pattern = "Augmente vos chances d'infliger un coup critique avec les sorts de Nature de (%d+)%%%.", effect = "NATURECRIT"},
				{ pattern = "Réduit le temps d'incantation de votre sort Rétablissement de 0.(%d+) sec%.", effect = "CASTINGREGROWTH"},
				{ pattern = "Réduit le temps d'incantation de votre sort Lumière sacrée de 0.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
				{ pattern = "-0.(%d+) sec. au temps d'incantation de votre sort Soins rapides%.", effect = "CASTINGFLASHHEAL"},
				{ pattern = "-0.(%d+) secondes au temps d'incantation de votre sort Salve de guérison%.", effect = "CASTINGCHAINHEAL"},
				{ pattern = "Réduit le temps de lancement de Toucher Guérisseur de 0.(%d+) secondes%.", effect = "CASTINGHEALINGTOUCH"},
				{ pattern = "Augmente la durée de votre sort Récupération de (%d+) sec%.", effect = "DURATIONREJUV"},
				{ pattern = "Augmente la durée de votre sort Rénovation de (%d+) sec%.", effect = "DURATIONRENEW"},
				{ pattern = "Augmente la régénération des points de vie et de mana de (%d+)%.", effect = "MANAREGNORMAL"},
				{ pattern = "Augmente de (%d+)%% le montant de points de vie rendus par Salve de guérison aux cibles qui suivent la première%.", effect = "IMPCHAINHEAL"},
				{ pattern = "Augmente les soins prodigués par Récupération de (%d+) au maximum%.", effect = "IMPREJUVENATION"},
				{ pattern = "Augmente les soins prodigués par votre Vague de Soins Inférieurs de (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
				{ pattern = "Augmente les soins prodigués par votre Eclair lumineux de (%d+)%.", effect = "IMPFLASHOFLIGHT"},
				{ pattern = "Après avoir lancé un sort de Vague de soins ou de Vague de soins inférieurs, vous avez 25%% de chances de gagner un nombre de points de mana égal à (%d+)%% du coût de base du sort%.", effect = "REFUNDHEALINGWAVE"},
				{ pattern = "Votre Vague de soins soigne aussi des cibles proches supplémentaires. Chaque nouveau soin perd (%d+)%% d'efficacité, et le sort soigne jusqu'à deux cibles supplémentaires%.", effect = "JUMPHEALINGWAVE"},
				{ pattern = "Réduit de (%d+)%% le coût en mana de vos sorts Toucher guérisseur% Rétablissement% Récupération et Tranquillité%.", effect = "CHEAPERDRUID"},
				{ pattern = "En cas de réussite critique sur un Toucher guérisseur, vous récupérez (%d+)%% du coût en mana du sort%.", effect = "REFUNDHTCRIT"},
				{ pattern = "Reduit le coût en mana de votre sort Rénovation de (%d+)%%%.", effect = "CHEAPERRENEW"},

 				{ pattern = "Augmente la pénétration de vos sorts de (%d+)%.", effect = "SPELLPEN" },
				{ pattern = "Augmente de (%d+) la puissance d'attaque%.", effect = "ATTACKPOWER" },
				{ pattern = "Augmente la vitesse des attaques à distance de (%d+)%%%.", effect = "RANGED_SPEED_BONUS" },
				{ pattern = "Réduit vos chances de parer une attaque de (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
				{ pattern = "Augmente la vitesse de nage de (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
				{ pattern = "Augmente la vitesse de course de (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
				{ pattern = "Augmente de (%d+) votre niveau de Camouflage actuel%.", effect = "STEALTH" },
				{ pattern = "Vitesse de monture augmentée de (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
				{ pattern = "Les dégâts des sorts subis sont diminués de (%d+)%.", effect = "DMGTAKEN" }, -- 22191
				{ pattern = "Augmente vos chances de résister aux effets de peur de (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
				{ pattern = "Augmente de (%d+)%% vos chances de résister aux effets d'étourdissement et de désorientation%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
				{ pattern = "Augmente vos chances de résister aux effets d'étourdissement et de peur de (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 23839
				{ pattern = "Vos attaques ignorent (%d)+ points de l'armure de votre adversaire%.", effect = "IGNOREARMOR" },
				{ pattern = "Réduit les dégâts subis en mêlée de (%d+)%.", effect = "MELEETAKEN" }, -- 31154
				{ pattern = "Lunette %(%+(%d+) au score de coup critique%)", effect = "CR_RANGEDCRIT" },
			},

			SEPARATORS = { "/", ",", "&", " et " },

			HEAL_AND_DMG_PATTERNS = {
			},
			
			GENERIC_PATTERNS = {
				["^%+?(%d+) (.*)$"]	= true,
				["^%+(%d+)%% (.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["Toutes les caractéristiques"] = ALL_STATS,
				["Force"] = "STR",
				["en Force"] = "STR",
				["Agilité"] = "AGI",
				["en Agilité"] = "AGI",
				["Endurance"] = "STA",
				["en Endurance"] = "STA",
				["Intelligence"] = "INT",
				["en Intelligence"] = "INT",
				["Esprit"] = "SPI",
				["à toutes les résistances"] = ALL_RESISTS,
				["Pêche"] = "FISHING",
				["Minage"] = "MINING",
				["Herborisme"] = "HERBALISM",
				["Herboristerie"] = "HERBALISM",
				["Dépeçage"] = "SKINNING",
				["Défense"] = "DEFENSE",
				["puissance d'Attaque"] = "ATTACKPOWER",
				["à la puissance d'attaque"] = "ATTACKPOWER",
				["Puissance d'attaque contre les morts%-vivants"] = "ATTACKPOWERUNDEAD",
				["Esquive"] = "DODGE",
				["Blocage"] = "BLOCK",
				["Score de blocage"] = "BLOCKVALUE",
				["à la puissance d'attaque à distance"] = "RANGEDATTACKPOWER",
				["Puissance d'Attaque à distance"] = "RANGEDATTACKPOWER",
				["Soins chaque 5 sec."] = "HEALTHREG",
				["Sorts de Soins"] = "HEAL",
				["Sorts de soin"] = "HEAL",
				["Sorts de soins"] = "HEAL",
				["aux sorts de soins"] = "HEAL",
				["aux soins"] = "HEAL",
				["Soins"] = "HEAL", -- leg piece enchant
				["Mana chaque 5 sec."] = "MANAREG",
				["à la puissance des sorts"] = "DMG",
				["aux dégâts des sorts"] = "DMG",
				["aux dégâts des sorts et aux soins"] = HEAL_AND_DMG,
				["points de mana toutes les 5 sec"] = "MANAREG",
				["Armure"] = "BASE_ARMOR",
				["Bloquer"] = "BLOCKVALUE",
				["Coup Critique"] = "CRIT",
				["Dommage"] = "DMG",
				["points de vie"] = "HEALTH",
				["points de mana"] = "MANA",
				["Mana"] = "MANA",
				["à l'Armure"] = "ARMOR_BONUS",
				["à la résilience"] = "RESILIENCE",
				["Armure renforcée"] = "ARMOR_BONUS",
				["aux dégâts des armes"] = "MELEEDMG",
				["à la résistance aux étourdissements"] = "STUNRESIST",
			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "Arcane", effect = "ARCANE" },
				{ pattern = "Feu", effect = "FIRE" },
				{ pattern = "Givre", effect = "FROST" },
				{ pattern = "Sacré", effect = "HOLY" },
				{ pattern = "Ombre", effect = "SHADOW" },
				{ pattern = "Nature", effect = "NATURE" },
				{ pattern = "arcanes", effect = "ARCANE" },
				{ pattern = "Arcanes", effect = "ARCANE" },
				{ pattern = "feu", effect = "FIRE" },
				{ pattern = "givre", effect = "FROST" },
				{ pattern = "ombre", effect = "SHADOW" },
				{ pattern = "nature", effect = "NATURE" }
			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "résistance", effect = "RES" },
				{ pattern = "dégâts", effect = "DMG" },
				{ pattern = "effets", effect = "DMG" }
			},

			PATTERNS_OTHER = {
				{ pattern = "Renforcé %(%+(%d+) Armure%)", effect = "ARMOR_BONUS" },
				{ pattern = "(%d+) Mana chaque 5 sec%.", effect = "MANAREG" },
				{ pattern = "Récup. mana (%d+)/5 sec%.", effect = "MANAREG" },
				{ pattern = "Cachet de mojo zandalar", effect = "HEAL", value = 18 },
				{ pattern = "Cachet de sérénité zandalar", effect = "HEAL", value = 33 },

				{ pattern = "Huile de sorcier mineure", effect = "HEAL", value = 8 },
				{ pattern = "Huile de sorcier inférieure", effect = "HEAL", value = 16 },
				{ pattern = "Huile de sorcier", effect = "HEAL", value = 24 },
				{ pattern = "Huile de sorcier brillante", effect = {"HEAL", "SPELLCRIT"}, value = {36, 1} },

				{ pattern = "Huile de mana mineure", effect = "MANAREG", value = 4 },
				{ pattern = "Huile de mana inférieure", effect = "MANAREG", value = 8 },
				{ pattern = "Huile de mana brillante", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
				{ pattern = "Vitalité", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
				{ pattern = "Âme de givre", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
				{ pattern = "Feu solaire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
				{ pattern = "Sauvagerie", effect = "ATTACKPOWER", value = 70 },
				{ pattern = "Pied sûr", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
				{ pattern = "Augmente le score de défense de 5, la résistance à l'Ombre de 10 et votre régénération des points de vie normale de 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
				{ pattern = "%+2%% Menace", effect = "THREATREDUCTION", value = -2 },
				{ pattern = "Subtilité", effect = "THREATREDUCTION", value = 2 },
				{ pattern = "Augmente légèrement votre compétence de Crochetage%.", effect = "LOCKPICK", value = 1 },
				{ pattern = "Augmente modérément votre détection du camouflage%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
				{ pattern = "Permet de respirer sous l'eau%.", effect = "UNDERWATER", value = 1 }, -- 10506
				{ pattern = "Insensible au désarmement%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
				{ pattern = "Augmente la vitesse de déplacement et de récupération des points de vie%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
				{ pattern = "Augmente légèrement votre détection du camouflage%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
				{ pattern = "Légère augmentation de la vitesse de course et de nage%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
				{ pattern = "Réduit les dégâts dus aux chutes%.", effect = "SLOWFALL", value = 1 }, -- 19982
				{ pattern = "Augmente légèrement votre camouflage%.", effect = "STEALTH", value = 3 }, -- 21758
				{ pattern = "Augmente votre niveau de Camouflage actuel%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
				{ pattern = "La vitesse de course augmente légèrement%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
				{ pattern = "Augmente légèrement les dégâts et les soins produits par les sorts et effets magiques%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

--				{ pattern = "Votre goût prononcé pour la mode impressionne les autres%.", effect = "IMPRESS", value = 1 }, -- 10036
			}
		}
	elseif locale == "zhTW" then
		L = {
			NAMES = {
				STR = "力量",
				AGI = "敏捷",
				STA = "耐力",

				INT = "智力",
				SPI = "精神",
				ARMOR = "強化護甲",

				ARCANERES = "秘法抗性",
				FIRERES = "火焰抗性",
				NATURERES = "自然抗性",

				FROSTRES = "冰霜抗性",
				SHADOWRES = "暗影抗性",

				FISHING = "釣魚技能",
				MINING = "採礦",
				HERBALISM = "草藥學",
				SKINNING = "剝皮",

				DEFENSE = "防禦",

				BLOCK = "格擋",
				BLOCKVALUE = "格擋值",
				DODGE = "躲避",
				PARRY = "招架",
				ATTACKPOWER = "攻擊強度",

				ATTACKPOWERUNDEAD = "對不死生物的攻擊強度",
				ATTACKPOWERFERAL = "野性戰鬥強度",
				CRIT = "近戰致命等級",
				RANGEDATTACKPOWER = "遠程攻擊強度",
				RANGEDCRIT = "遠程攻擊致命一擊等級",
				TOHIT = "命中等級",

				ATTACKPOWEREVIL = "對惡魔的攻擊強度";
				DMG = "法術傷害",
				DMGUNDEAD = "對不死生物的法術傷害",
				ARCANEDMG = "秘法傷害",
				FIREDMG = "火焰傷害",
				FROSTDMG = "冰霜傷害",

				HOLYDMG = "神聖傷害",
				NATUREDMG = "自然傷害",
				SHADOWDMG = "暗影傷害",
				SPELLCRIT = "法術致命等級",
				SPELLTOHIT = "法術命中等級",
				SPELLPEN = "法術穿透",

				HEAL = "治療量",
				HOLYCRIT = "神聖爆擊等級",

				HEALTHREG = "生命回復",
				MANAREG = "法力回復",
				HEALTH = "生命值",
				MANA = "法力值",


				CR_WEAPON = "武器等級",
				CR_DEFENSE = "防禦等級",
				CR_DODGE = "躲避等級",
				CR_PARRY = "招架等級",
				CR_BLOCK = "格擋機率等級",

				CR_HIT = "命中等級",
				CR_CRIT = "致命一擊等級",
				CR_HASTE = "攻擊速度等級",
				CR_SPELLHIT = "法術命中等級",
				CR_SPELLCRIT = "法術致命一擊等級",
				CR_SPELLHASTE = "法術加速等級",

				CR_RESILIENCE = "韌性",

				CR_RANGEDHASTE = "遠程攻擊加速等級",
				CR_RANGEDHIT = "遠程命中等級",
				CR_WEAPON_DAGGER = "匕首類技能",
				CR_WEAPON_SWORD = "單手劍類技能",
				CR_WEAPON_SWORD_2H = "雙手劍技能",

				CR_WEAPON_AXE = "單手斧技能",
				CR_WEAPON_AXE_2H = "雙手斧技能",
				CR_WEAPON_MACE = "單手錘技能",
				CR_WEAPON_MACE_2H = "雙手錘技能",
				CR_WEAPON_BOW = "弓箭類技能",
				CR_WEAPON_XBOW = "十字弓技能",

				CR_WEAPON_GUN = "槍械類技能",
				CR_WEAPON_FIST = "拳套類技能",
				CR_WEAPON_STAFF = "法杖類技能",
				CR_WEAPON_POLEARM = "長柄武器技能",
			},

			PATTERNS_SKILL_RATING = {},
			SKILL_NAMES = {},

			PATTERNS_PASSIVE = {
				{ pattern = "使釣魚技能%+(%d+)點", effect = "FISHING" },
				{ pattern = "剝皮技能提高(%d+)點", effect = "SKINNING" },
				{ pattern = "使攻擊強度提高(%d+)點", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
				{ pattern = "+(%d+)攻擊強度", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
				{ pattern = "+(%d+)遠程攻擊強度", effect = "RANGEDATTACKPOWER" },

				{ pattern = "遠程攻擊強度提高(%d+)點", effect = "RANGEDATTACKPOWER" },
				{ pattern = "使你的格擋等級提高(%d+)點", effect = "BLOCK" },
				{ pattern = "提高你的盾牌格擋等級(%d+)", effect = "BLOCK" },
				{ pattern = "使你的閃躲等級提高(%d+)", effect = "DODGE" },
				{ pattern = "使你的韌性等級提高(%d+)", effect = "RESILIENCE" },
				{ pattern = "使你的招架等級提高(%d+)點", effect = "PARRY" },

				{ pattern = "法術致命一擊等級提高(%d+)", effect = "SPELLCRIT" },
				{ pattern = "使你的法術致命一擊等級提高(%d+)點", effect = "SPELLCRIT" },
				{ pattern = "使你的致命一擊等級提高(%d+)點", effect = {"CRIT","RANGEDCRIT"} },
				{ pattern = "致命一擊等級提高(%d+)", effect = {"CRIT","RANGEDCRIT"} },
				{ pattern = "使你的法術穿透提高(%d+)點", effect = "PENETRATION" },
				{ pattern = "使你的神聖系法術的致命一擊和極效治療機率提高(%d+)%%", effect = "HEALCRIT" },

				{ pattern = "使你的神聖系法術的致命一擊和極效治療機率提高(%d+)%%", effect = "HOLYCRIT" },
				{ pattern = "使你的神聖法術的致命一擊的機率提高(%d+)%%", effect = "HOLYCRIT" },
				{ pattern = "提高秘法法術和效果所造成的傷害，最多(%d+)點", effect = "ARCANEDMG" },
				{ pattern = "提高秘法法術和效果所造成的傷害，最多(%d+)點", effect = "ARCANEDMG" },
				{ pattern = "提高火焰法術和效果所造成的傷害，最多(%d+)點", effect = "FIREDMG" },
				{ pattern = "提高冰霜法術和效果所造成的傷害，最多(%d+)點", effect = "FROSTDMG" },

				{ pattern = "提高神聖法術和效果所造成的傷害，最多(%d+)點", effect = "HOLYDMG" },
				{ pattern = "提高自然法術和效果所造成的傷害，最多(%d+)點", effect = "NATUREDMG" },
				{ pattern = "提高暗影法術和效果所造成的傷害，最多(%d+)點", effect = "SHADOWDMG" },
				{ pattern = "使秘法法術和效果所造成的傷害提高最多(%d+)點", effect = "ARCANEDMG" },
				{ pattern = "使秘法法術所造成的傷害提高最多(%d+)點", effect = "ARCANEDMG" },
				{ pattern = "使火焰法術和效果所造成的傷害提高最多(%d+)點", effect = "FIREDMG" },

				{ pattern = "使火焰法術所造成的傷害提高最多(%d+)點", effect = "FIREDMG" },
				{ pattern = "使冰霜法術和效果所造成的傷害提高最多(%d+)點", effect = "FROSTDMG" },
				{ pattern = "使冰霜法術所造成的傷害提高最多(%d+)點", effect = "FROSTDMG" },
				{ pattern = "使神聖法術和效果所造成的傷害提高最多(%d+)點", effect = "HOLYDMG" },
				{ pattern = "使神聖法術所造成的傷害提高最多(%d+)點", effect = "HOLYDMG" },
				{ pattern = "使自然法術和效果所造成的傷害提高最多(%d+)點", effect = "NATUREDMG" },

				{ pattern = "使自然法術所造成的傷害提高最多(%d+)點", effect = "NATUREDMG" },
				{ pattern = "使暗影法術和效果所造成的傷害提高最多(%d+)點", effect = "SHADOWDMG" },
				{ pattern = "使暗影法術所造成的傷害提高最多(%d+)點", effect = "SHADOWDMG" },
				{ pattern = "使治療法術和效果所回復的生命值提高(%d+)點", effect = "HEAL" },
				{ pattern = "使治療法術和效果所回復的生命力提高(%d+)點", effect = "HEAL" },
				{ pattern = "使法術所造成的治療效果提高最多(%d+)點", effect = "HEAL" },

				{ pattern = "提高法術和魔法效果所造成的治療效果，最多(%d+)點", effect = "HEAL" },
				{ pattern = "使所有法術和魔法效果所造成的傷害和治療效果提高最多(%d+)點", effect = "DMG" },
				{ pattern = "使所有法術和魔法效果所造成的傷害和治療效果提高最多(%d+)點", effect = "HEAL" },
				{ pattern = "每+%d+秒恢復(%d+)點生命力", effect = "HEALTHREG" },
				{ pattern = "每+%d+秒回復(%d+)點生命力", effect = "HEALTHREG" },
				{ pattern = "每+%d+秒%+(%d+)生命力", effect = "HEALTHREG" },

				{ pattern = "每+%d+秒恢復(%d+)點法力", effect = "MANAREG" },
				{ pattern = "每+%d+秒回復(%d+)點法力", effect = "MANAREG" },
				{ pattern = "每+%d+秒%+(%d+)法力", effect = "MANAREG" },
				{ pattern = "使你的命中等級提高(%d+)點", effect = "TOHIT" },
				{ pattern = "提高命中等級(%d+)", effect = "TOHIT" },
				{ pattern = "使你的生命值和法力值回復提高(%d+)點", effect = {"HEALTHREG", "MANAREG"} },

				{ pattern = "使你的生命力和法力回復提高(%d+)點", effect = {"HEALTHREG", "MANAREG"} },
				{ pattern = "防禦等級提高(%d+)", effect = "DEFENSE" },
				{ pattern = "使防禦等級提高(%d+)點", effect = "DEFENSE" },
				{ pattern = "使你的法術命中等級提高(%d+)點", effect = "SPELLTOHITLV" },
				{ pattern = "使你的盾牌格擋值提高(%d+)點", effect = "BLOCKAMT" },
				{ pattern = "使你盾牌的格擋值提高(%d+)點", effect = "BLOCKAMT" },

				{ pattern = "擊中目標後有(%d+)%%的機率獲得1次額外的攻擊機會", effect = "XTRAHIT" },
				{ pattern = "使目標遭到重創，對其造成(%d+)點傷害", effect = "HIT_WOUND" },
				{ pattern = "向目標射出一支暗影箭，對其造成%d+到(%d+)點暗影傷害", effect = "HIT_SHADOW" },
				{ pattern = "向敵人發射一支暗影箭，對其造成(%d+)點暗影傷害", effect = "HIT_SHADOW" },
				{ pattern = "發射一枚火球攻擊目標，對其造成%d+到(%d+)點火焰傷害，並在%d+秒內造成額外的%d+點傷害", effect = "HIT_FIRE" },
				{ pattern = "發射一枚火球攻擊目標，對其造成%d+到%d+點火焰傷害，並在%d+秒內造成額外的(%d+)點傷害", effect = "HIT_FIRE_EX" },

				{ pattern = "對不死生物的攻擊強度提高(%d+)點", effect = "UNDEADAP" },
				{ pattern = "攻擊不死生物時+(%d+)點攻擊強度", effect = "UNDEADAP" },
				{ pattern = "提高法術和魔法效果對不死生物所造成的傷害，最多(%d+)點", effect = "UNDEADDMG" },
				{ pattern = "法術和魔法效果對亡靈造成的傷害提高最多(%d+)點", effect = "UNDEADDMG" },
				{ pattern = "使魔法和法術效果對亡靈造成的傷害提高最多(%d+)點", effect = "UNDEADDMG" },
				{ pattern = "對惡魔的攻擊強度提高(%d+) 點", effect = "ATTACKPOWEREVIL" },

			},

			SEPARATORS = { "/", "和", ",", "。", " 持續 ", "&", "及", "並", "，", },

			HEAL_AND_DMG_PATTERNS = {
			},
			
			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["所有屬性"] = ALL_STATS,
				["力量"] = "STR",

				["敏捷"] = "AGI",
				["耐力"] = "STA",
				["智力"] = "INT",
				["精神"] = "SPI",
				["所有抗性"] = ALL_RESISTS,
				["釣魚技能"] = "FISHING",

				["釣魚技能提高"] = "FISHING",
				["採礦"] = "MINING",
				["草藥學"] = "HERBALISM",
				["剝皮"] = "SKINNING",
				["防禦等級"] = "DEFENSE",
				["攻擊強度"] = "ATTACKPOWER",

				["對不死生物的攻擊強度"] = "ATTACKPOWERUNDEAD",
				["閃躲等級"] = "DODGE",
				["格擋機率等級"] = "BLOCK",
				["盾牌格擋"] = "BLOCKVALUE",
				["格擋值"] = "BLOCKVALUE",
				["命中等級"] = "TOHIT",

				["法術命中等級"] = "SPELLTOHIT",
				["遠程攻擊強度"] = "RANGEDATTACKPOWER",
				["治療法術"] = "HEAL",
				["治療"] = "HEAL",
				["治療和法術傷害"] = HEAL_AND_DMG,
				["法術治療和傷害"] = HEAL_AND_DMG,

				["法術傷害和治療"] = HEAL_AND_DMG,
				["傷害及治療法術"] = HEAL_AND_DMG,
				["法術傷害及治療"] = HEAL_AND_DMG,
				["法術傷害"] = "DMG",
				["致命一擊"] = "CRIT",
				["致命一擊等級"] = "CRIT",

				["生命力"] = "HEALTH",
				["法力"] = "MANA",
				["護甲"] = "BASE_ARMOR",
				["韌性等級"] = "CR_RESILIENCE",
				["法術穿透等級"] = "SPELLPEN",
				["法力恢復"] = "MANAREG",

				["武器傷害"] = "WEPDMG",

			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "秘法", 	effect = "ARCANE" },
				{ pattern = "秘法", 	effect = "ARCANE" },

				{ pattern = "火焰", 	effect = "FIRE" },
				{ pattern = "冰霜", 	effect = "FROST" },
				{ pattern = "神聖", 	effect = "HOLY" },
				{ pattern = "暗影",	effect = "SHADOW" },
				{ pattern = "陰影",	effect = "SHADOW" },
				{ pattern = "自然", 	effect = "NATURE" }

			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "抗性", 	effect = "RES" },
				{ pattern = "傷害", 	effect = "DMG" }
			},


			PATTERNS_OTHER = {
				{ pattern = "強化%(%+(%d+)護甲%)", effect = "ARMOR_BONUS" },
				{ pattern = "每%d秒回復(%d+)點法力", effect = "MANAREG" },

				{ pattern = "初級巫師之油", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "次級巫師之油", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "巫師之油", effect = HEAL_AND_DMG, value = 24 },

				{ pattern = "卓越巫師之油", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

				{ pattern = "初級法力之油", effect = "MANAREG", value = 4 },
				{ pattern = "次級法力之油", effect = "MANAREG", value = 8 },
				{ pattern = "卓越法力之油", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

				{ pattern = "每%d秒恢復(%d+)點法力", effect = "MANAREG" },

				{ pattern = "魚餌 %+(%d+)（%d分鐘）", effect = "FISHING" },
				{ pattern = "每%d秒回復(%d+)點生命力", effect = "HEALTHREG" },
				{ pattern = "每%d秒恢復(%d+)點生命力", effect = "HEALTHREG" },
				{ pattern = "贊達拉力量徽記", effect = "ATTACKPOWER", value = 30 },
				{ pattern = "贊達拉魔精徽記", effect = {"DMG", "HEAL"}, value = 18 },
				{ pattern = "贊達拉寧靜徽記", effect = "HEAL", value = 33 },

				{ pattern = "瞄準鏡（%+(%d+) 傷害）", effect = "RANDMG" },
				{ pattern = "對不死族%+(%d+)法術傷害（%d分鐘）", effect = "UNDEADDMG"},
				{ pattern = "%+(%d+) 命中等級", effect = "HIT"},
				{ pattern = "%+30 遠程命中等級", effect = "CR_RANGEDHIT", value = 30 },
			},
		}
		elseif locale == "zhCN" then
		L = {
			NAMES = {
				STR = "力量",
				AGI = "敏捷",
				STA = "耐力",

				INT = "智力",
				SPI = "精神",
				ARMOR = "护甲",

				ARCANERES = "奥术抗性",
				FIRERES = "火焰抗性",
				NATURERES = "自然抗性",

				FROSTRES = "冰霜抗性",
				SHADOWRES = "暗影抗性",

				FISHING = "钓鱼技能",
				MINING = "采矿",
				HERBALISM = "草药学",
				SKINNING = "剥皮",

				DEFENSE = "防御",

				BLOCK = "格挡",
				BLOCKVALUE = "格挡值",
				DODGE = "躲避",
				PARRY = "招架",
				ATTACKPOWER = "攻击强度",

				ATTACKPOWERUNDEAD = "对亡灵生物的攻击强度",
				ATTACKPOWERFERAL = "野性战斗强度",
				CRIT = "近战致命等级",
				RANGEDATTACKPOWER = "远程攻击强度",
				RANGEDCRIT = "远程攻击致命等级",
				TOHIT = "命中等级",

				ATTACKPOWEREVIL = "对恶魔的攻击强度";
				DMG = "法术伤害",
				DMGUNDEAD = "对亡灵生物的法术伤害",
				ARCANEDMG = "奥术伤害",
				FIREDMG = "火焰伤害",
				FROSTDMG = "冰霜伤害",

				HOLYDMG = "神圣伤害",
				NATUREDMG = "自然伤害",
				SHADOWDMG = "暗影伤害",
				SPELLCRIT = "法术致命等级",
				SPELLTOHIT = "法术命中等级",
				SPELLPEN = "法术穿透",

				HEAL = "治疗量",
				HOLYCRIT = "神圣暴击等级",

				HEALTHREG = "生命恢复",
				MANAREG = "法力恢复",
				HEALTH = "生命值",
				MANA = "法力值",


				CR_WEAPON = "武器等级",
				CR_DEFENSE = "防御等级",
				CR_DODGE = "躲避等级",
				CR_PARRY = "招架等级",
				CR_BLOCK = "格挡等级",

				CR_HIT = "命中等级",
				CR_CRIT = "致命一击等级",
				CR_HASTE = "攻击速度等级",
				CR_SPELLHIT = "法术命中等级",
				CR_SPELLCRIT = "法术致命一击等级",
				CR_SPELLHASTE = "法术加速等级",

				CR_RESILIENCE = "韧性",

				CR_RANGEDHASTE = "远程攻击加速等级",
				CR_RANGEDHIT = "远程命中等级",
				CR_WEAPON_DAGGER = "匕首技能",
				CR_WEAPON_SWORD = "单手剑技能",
				CR_WEAPON_SWORD_2H = "双手剑技能",

				CR_WEAPON_AXE = "单手斧技能",
				CR_WEAPON_AXE_2H = "双手斧技能",
				CR_WEAPON_MACE = "单手锤技能",
				CR_WEAPON_MACE_2H = "双手锤技能",
				CR_WEAPON_BOW = "弓技能",
				CR_WEAPON_XBOW = "弩技能",

				CR_WEAPON_GUN = "枪械技能",
				CR_WEAPON_FIST = "拳套技能",
				CR_WEAPON_STAFF = "法杖技能",
				CR_WEAPON_POLEARM = "长柄武器技能",
			},

			PATTERNS_SKILL_RATING = {},
			SKILL_NAMES = {},

			PATTERNS_PASSIVE = {
				{ pattern = "使钓鱼技能%+(%d+)点", effect = "FISHING" },
				{ pattern = "剥皮技能提高(%d+)点", effect = "SKINNING" },
				{ pattern = "使攻击强度提高(%d+)点", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
				{ pattern = "+(%d+)攻击强度", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} },
				{ pattern = "+(%d+)远程攻击强度", effect = "RANGEDATTACKPOWER" },

				{ pattern = "远程攻击强度提高(%d+)点", effect = "RANGEDATTACKPOWER" },
				{ pattern = "使你的格挡等级提高(%d+)点", effect = "BLOCK" },
				{ pattern = "提高你的盾牌格挡等级(%d+)", effect = "BLOCK" },
				{ pattern = "使你的闪躲等级提高(%d+)", effect = "DODGE" },
				{ pattern = "使你的韧性等级提高(%d+)", effect = "RESILIENCE" },
				{ pattern = "使你的招架等级提高(%d+)点", effect = "PARRY" },

				{ pattern = "法术爆击等级提高(%d+)", effect = "SPELLCRIT" },
				{ pattern = "使你的法术爆击等级提高(%d+)点", effect = "SPELLCRIT" },
				{ pattern = "使你的爆击等级提高(%d+)点", effect = {"CRIT","RANGEDCRIT"} },
				{ pattern = "爆击等级提高(%d+)", effect = {"CRIT","RANGEDCRIT"} },
				{ pattern = "使你的法术穿透提高(%d+)点", effect = "PENETRATION" },
				{ pattern = "使你的神圣系法术的爆击机率提高(%d+)%%", effect = "HEALCRIT" },

				{ pattern = "使你的神圣系法术的爆击机率提高(%d+)%%", effect = "HOLYCRIT" },
				{ pattern = "使你的神圣法术的爆击的机率提高(%d+)%%", effect = "HOLYCRIT" },
				{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点", effect = "ARCANEDMG" },
				{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点", effect = "ARCANEDMG" },
				{ pattern = "提高火焰法术和效果所造成的伤害，最多(%d+)点", effect = "FIREDMG" },
				{ pattern = "提高冰霜法术和效果所造成的伤害，最多(%d+)点", effect = "FROSTDMG" },

				{ pattern = "提高神圣法术和效果所造成的伤害，最多(%d+)点", effect = "HOLYDMG" },
				{ pattern = "提高自然法术和效果所造成的伤害，最多(%d+)点", effect = "NATUREDMG" },
				{ pattern = "提高暗影法术和效果所造成的伤害，最多(%d+)点", effect = "SHADOWDMG" },
				{ pattern = "使奥术法术和效果所造成的伤害提高最多(%d+)点", effect = "ARCANEDMG" },
				{ pattern = "使奥术法术所造成的伤害提高最多(%d+)点", effect = "ARCANEDMG" },
				{ pattern = "使火焰法术和效果所造成的伤害提高最多(%d+)点", effect = "FIREDMG" },

				{ pattern = "使火焰法术所造成的伤害提高最多(%d+)点", effect = "FIREDMG" },
				{ pattern = "使冰霜法术和效果所造成的伤害提高最多(%d+)点", effect = "FROSTDMG" },
				{ pattern = "使冰霜法术所造成的伤害提高最多(%d+)点", effect = "FROSTDMG" },
				{ pattern = "使神圣法术和效果所造成的伤害提高最多(%d+)点", effect = "HOLYDMG" },
				{ pattern = "使神圣法术所造成的伤害提高最多(%d+)点", effect = "HOLYDMG" },
				{ pattern = "使自然法术和效果所造成的伤害提高最多(%d+)点", effect = "NATUREDMG" },

				{ pattern = "使自然法术所造成的伤害提高最多(%d+)点", effect = "NATUREDMG" },
				{ pattern = "使暗影法术和效果所造成的伤害提高最多(%d+)点", effect = "SHADOWDMG" },
				{ pattern = "使暗影法术所造成的伤害提高最多(%d+)点", effect = "SHADOWDMG" },
				{ pattern = "使治疗法术和效果所回复的生命值提高(%d+)点", effect = "HEAL" },
				{ pattern = "使治疗法术和效果所回复的生命力提高(%d+)点", effect = "HEAL" },
				{ pattern = "使法术所造成的治疗效果提高最多(%d+)点", effect = "HEAL" },

				{ pattern = "提高法术和魔法效果所造成的治疗效果，最多(%d+)点", effect = "HEAL" },
				{ pattern = "使所有法术和魔法效果所造成的伤害和治疗效果提高最多(%d+)点", effect = "DMG" },
				{ pattern = "使所有法术和魔法效果所造成的伤害和治疗效果提高最多(%d+)点", effect = "HEAL" },
				{ pattern = "每+%d+秒恢复(%d+)点生命值", effect = "HEALTHREG" },
				{ pattern = "每+%d+秒回复(%d+)点生命值", effect = "HEALTHREG" },
				{ pattern = "每+%d+秒%+(%d+)生命值", effect = "HEALTHREG" },

				{ pattern = "每+%d+秒恢复(%d+)点法力值", effect = "MANAREG" },
				{ pattern = "每+%d+秒回复(%d+)点法力值", effect = "MANAREG" },
				{ pattern = "每+%d+秒%+(%d+)法力值", effect = "MANAREG" },
				{ pattern = "使你的命中等级提高(%d+)点", effect = "TOHIT" },
				{ pattern = "提高命中等级(%d+)", effect = "TOHIT" },
				{ pattern = "使你的生命值和法力值回复提高(%d+)点", effect = {"HEALTHREG", "MANAREG"} },

				{ pattern = "使你的生命值和法力值回复提高(%d+)点", effect = {"HEALTHREG", "MANAREG"} },
				{ pattern = "防御等级提高(%d+)", effect = "DEFENSE" },
				{ pattern = "使防御等级提高(%d+)点", effect = "DEFENSE" },
				{ pattern = "使你的法术命中等级提高(%d+)点", effect = "SPELLTOHITLV" },
				{ pattern = "使你的盾牌格挡值提高(%d+)点", effect = "BLOCKAMT" },
				{ pattern = "使你盾牌的格挡值提高(%d+)点", effect = "BLOCKAMT" },

				{ pattern = "击中目标后有(%d+)%%的机率获得1次额外的攻击机会", effect = "XTRAHIT" },
				{ pattern = "使目标遭到重创，对其造成(%d+)点伤害", effect = "HIT_WOUND" },
				{ pattern = "向目标射出一支暗影箭，对其造成%d+到(%d+)点暗影伤害", effect = "HIT_SHADOW" },
				{ pattern = "向敌人发射一支暗影箭，对其造成(%d+)点暗影伤害", effect = "HIT_SHADOW" },
				{ pattern = "发射一枚火球攻击目标，对其造成%d+到(%d+)点火焰伤害，并在%d+秒内造成额外的%d+点伤害", effect = "HIT_FIRE" },
				{ pattern = "发射一枚火球攻击目标，对其造成%d+到%d+点火焰伤害，并在%d+秒内造成额外的(%d+)点伤害", effect = "HIT_FIRE_EX" },

				{ pattern = "对亡灵生物的攻击强度提高(%d+)点", effect = "UNDEADAP" },
				{ pattern = "攻击亡灵生物时+(%d+)点攻击强度", effect = "UNDEADAP" },
				{ pattern = "提高法术和魔法效果对亡灵生物所造成的伤害，最多(%d+)点", effect = "UNDEADDMG" },
				{ pattern = "法术和魔法效果对亡灵造成的伤害提高最多(%d+)点", effect = "UNDEADDMG" },
				{ pattern = "使魔法和法术效果对亡灵造成的伤害提高最多(%d+)点", effect = "UNDEADDMG" },
				{ pattern = "对恶魔的攻击强度提高(%d+) 点", effect = "ATTACKPOWEREVIL" },

			},

			SEPARATORS = { "/", "和", ",", "。", " 持续 ", "&", "及", "并", "，", },

			HEAL_AND_DMG_PATTERNS = {
			},
			
			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["所有属性"] = ALL_STATS,
				["力量"] = "STR",

				["敏捷"] = "AGI",
				["耐力"] = "STA",
				["智力"] = "INT",
				["精神"] = "SPI",
				["所有抗性"] = ALL_RESISTS,
				["钓鱼技能"] = "FISHING",

				["钓鱼技能提高"] = "FISHING",
				["採矿"] = "MINING",
				["草药学"] = "HERBALISM",
				["剥皮"] = "SKINNING",
				["防御等级"] = "DEFENSE",
				["攻击强度"] = "ATTACKPOWER",

				["对亡灵生物的攻击强度"] = "ATTACKPOWERUNDEAD",
				["闪躲等级"] = "DODGE",
				["格挡机率等级"] = "BLOCK",
				["盾牌格挡"] = "BLOCKVALUE",
				["格挡值"] = "BLOCKVALUE",
				["命中等级"] = "TOHIT",

				["法术命中等级"] = "SPELLTOHIT",
				["远程攻击强度"] = "RANGEDATTACKPOWER",
				["治疗法术"] = "HEAL",
				["治疗"] = "HEAL",
				["治疗和法术伤害"] = HEAL_AND_DMG,
				["法术治疗和伤害"] = HEAL_AND_DMG,

				["法术伤害和治疗"] = HEAL_AND_DMG,
				["伤害及治疗法术"] = HEAL_AND_DMG,
				["法术伤害及治疗"] = HEAL_AND_DMG,
				["法术伤害"] = "DMG",
				["爆击"] = "CRIT",
				["爆击等级"] = "CRIT",

				["生命值"] = "HEALTH",
				["法力值"] = "MANA",
				["护甲"] = "BASE_ARMOR",
				["韧性等级"] = "CR_RESILIENCE",
				["法术穿透等级"] = "SPELLPEN",
				["法力值恢复"] = "MANAREG",

				["武器伤害"] = "WEPDMG",

			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "奥术", 	effect = "ARCANE" },
				{ pattern = "奥术", 	effect = "ARCANE" },

				{ pattern = "火焰", 	effect = "FIRE" },
				{ pattern = "冰霜", 	effect = "FROST" },
				{ pattern = "神圣", 	effect = "HOLY" },
				{ pattern = "暗影",	effect = "SHADOW" },
				{ pattern = "阴影",	effect = "SHADOW" },
				{ pattern = "自然", 	effect = "NATURE" }

			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "抗性", 	effect = "RES" },
				{ pattern = "伤害", 	effect = "DMG" }
			},


			PATTERNS_OTHER = {
				{ pattern = "强化%(%+(%d+)护甲%)", effect = "ARMOR_BONUS" },
				{ pattern = "每%d秒回复(%d+)点法力值", effect = "MANAREG" },

				{ pattern = "初级巫师之油", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "次级巫师之油", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "巫师之油", effect = HEAL_AND_DMG, value = 24 },

				{ pattern = "卓越巫师之油", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

				{ pattern = "初级法力值之油", effect = "MANAREG", value = 4 },
				{ pattern = "次级法力值之油", effect = "MANAREG", value = 8 },
				{ pattern = "卓越法力值之油", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

				{ pattern = "每%d秒恢复(%d+)点法力值", effect = "MANAREG" },

				{ pattern = "鱼饵 %+(%d+)（%d分钟）", effect = "FISHING" },
				{ pattern = "每%d秒回复(%d+)点生命值", effect = "HEALTHREG" },
				{ pattern = "每%d秒恢复(%d+)点生命值", effect = "HEALTHREG" },
				{ pattern = "赞达拉力量徽记", effect = "ATTACKPOWER", value = 30 },
				{ pattern = "赞达拉魔精徽记", effect = {"DMG", "HEAL"}, value = 18 },
				{ pattern = "赞达拉宁静徽记", effect = "HEAL", value = 33 },

				{ pattern = "瞄准镜（%+(%d+) 伤害）", effect = "RANDMG" },
				{ pattern = "对亡灵%+(%d+)法术伤害（%d分钟）", effect = "UNDEADDMG"},
				{ pattern = "%+(%d+) 命中等级", effect = "HIT"},
				{ pattern = "%+30 远程命中等级", effect = "CR_RANGEDHIT", value = 30 },
			},
		}
	elseif locale == "deDE" then
		L = {
			NAMES = {
				STR = "Stärke",
				AGI = "Beweglichkeit",
				STA = "Ausdauer",
				INT = "Intelligenz",
				SPI = "Willenskraft",
				ARMOR = "Rüstung",
				BASE_ARMOR = "Rüstung",
				ARMOR_BONUS = "Verstärkte Rüstung",

				ARCANERES = "Arkanwiderstand",
				FIRERES = "Feuerwiderstand",
				NATURERES = "Naturwiderstand",
				FROSTRES = "Frostwiderstand",
				SHADOWRES = "Schattenwiderstand",

				FISHING = "Angeln",
				MINING = "Bergbau",
				HERBALISM = "Kräuterkunde",
				SKINNING = "Kürschnerei",
				DEFENSE = "Verteidigung",

				BLOCK = "Blockchance",
				BLOCKVALUE = "Blockwert",
				DODGE = "Ausweichen",
				PARRY = "Parieren",
				ATTACKPOWER = "Angriffskraft",
				ATTACKPOWERUNDEAD = "Angriffskraft gegen Untote",
				ATTACKPOWERFERAL = "Angriffskraft in Tierform",
				CRIT = "krit. Treffer",
				RANGEDATTACKPOWER = "Distanzangriffskraft",
				RANGEDCRIT = "krit. Schuss",
				TOHIT = "Trefferchance",
				IGNOREARMOR = "Ignorierte Rüstung",
				THREATREDUCTION = "Reduzierte Bedrohung",
				
				DMG = "Zauberschaden",
				DMGUNDEAD = "Zauberschaden gegen Untote",
				ARCANEDMG = "Arkanschaden",
				FIREDMG = "Feuerschaden",
				FROSTDMG = "Frostschaden",
				HOLYDMG = "Heiligschaden",
				NATUREDMG = "Naturschaden",
				SHADOWDMG = "Schattenschaden",
				HOLYCRIT = "krit. Heiligzauber",
				SPELLCRIT = "krit. Zauber",
				SPELLTOHIT = "Zaubertrefferchance",
				SPELLPEN = "Zauberdurchschlag",
				HEAL = "Heilung",
				HEALTHREG = "Lebensregeneration",
				MANAREG = "Manaregeneration",
				HEALTH = "Lebenspunkte",
				MANA = "Manapunkte",

				CR_WEAPON = "Waffenwertung",
				CR_DEFENSE = "Verteidigungswertung",
				CR_DODGE = "Ausweichwertung",
				CR_PARRY = "Parrierwertung",
				CR_BLOCK = "Blockwertung",
				CR_HIT = "Trefferwertung",
				CR_RANGEDHIT = "Distanztrefferwertung",
				CR_CRIT = "kritische Trefferwertung",
				CR_HASTE = "Angriffsgeschwindigkeit",
				CR_SPELLHIT = "Zaubertrefferwertung",
				CR_SPELLCRIT = "kritische Zaubertrefferwertung",
				CR_SPELLHASTE = "Zaubergeschwindigkeit",
				CR_RANGEDHASTE = "Fernkampfgeschwindigkeit",
				CR_RESILIENCE = "Abhärtungswertung",
			},

			PATTERNS_SKILL_RATING = {},
			SKILL_NAMES = {},

			PATTERNS_PASSIVE = {
				{ pattern = "%+(%d+) bei allen Widerstandsarten%.", effect = ALL_RESISTS },
				{ pattern = "+(%d+) Distanzangriffskraft.", effect = "RANGEDATTACKPOWER" },
				{ pattern = "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um (%d+)%%%.", effect = "BLOCK" },
				{ pattern = "Erhöht den Blockwert Eures Schildes um (%d+)%.", effect = "BLOCKVALUE" },
				{ pattern = "Erhöht Eure Chance, einem Angriff auszuweichen, um (%d+)%%%.", effect = "DODGE" },
				{ pattern = "Erhöht Eure Chance, einen Angriff zu parieren, um (%d+)%%%.", effect = "PARRY" },
				{ pattern = "Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um (%d+)%%%.", effect = "SPELLCRIT" },
				{ pattern = "Erhöht Eure Chance, einen kritischen Treffer durch Heiligzauber zu erzielen, um (%d+)%%%.", effect = "HOLYCRIT" },
				{ pattern = "Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um (%d+)%%%.", effect = "CRIT" },
				{ pattern = "Erhöht Eure Chance, mit Fernkampfwaffen einen kritischen Treffer zu erzielen, um (%d+)%.", effect = "RANGEDCRIT" },
				{ pattern = "Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "ARCANEDMG" },
				{ pattern = "Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FIREDMG" },
				{ pattern = "Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FROSTDMG" },
				{ pattern = "Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu (%d+)%.", effect = "HOLYDMG" },
				{ pattern = "Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu (%d+)%.", effect = "NATUREDMG" },
				{ pattern = "Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "SHADOWDMG" },
				{ pattern = "Erhöht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
				{ pattern = "Erhöht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu (%d+) und den verursachten Schaden um bis zu (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung um bis zu (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Erhöht den durch magische Zauber und magische Effekte zugefügten Schaden gegen Untote um bis zu (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
				{ pattern = "Erhöht die Angriffskraft im Kampf gegen Untote um (%d+)%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
				{ pattern = "Erhöht die Angriffskraft im Kampf gegen Untote um (%d+)%. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Agentumdämmerung", effect = "ATTACKPOWERUNDEAD" },
				{ pattern = "Stellt alle 5 Sek%. (%d+) Gesundheit wieder her%.", effect = "HEALTHREG" },
				{ pattern = "Stellt alle 5 Sek%. (%d+) Mana wieder her%.", effect = "MANAREG" },
				{ pattern = "Verbessert Eure Trefferchance um (%d+)%%%.", effect = "TOHIT" },
				{ pattern = "Reduziert die Magiewiderstände der Ziele Eurer Zauber um (%d+)%.", effect = "SPELLPEN" },

				{ pattern = ".+ Angriffstempowertung um (%d+)", effect = "CR_HASTE"},
				{ pattern = "Erhöht Eure Angriffstempowertung %d Sek%. lang um (%d+)%.", effect = "CR_HASTE"},
				{ pattern = ".+ Zaubertempowertung um (%d+)", effect = "CR_SPELLHASTE"},
				{ pattern = ".+ Distanztempowertung um (%d+)%.", effect = "CR_RANGEDHASTE"},
				{ pattern = "Eure Angriffe ignorieren (%d+) R\195\188stung Eures Gegners%.", effect = "IGNOREARMOR"},
				{ pattern = "Erhöht Tempowertung um (%d+)%.", effect = "CR_HASTE"},

				-- Atiesh related patterns
				{ pattern = "Erhöht Euren Zauberschaden um bis zu (%d+) und Eure Heilung um bis zu (%d+)%.", effect = {"DMG","HEAL"} },
				{ pattern = "Erhöht durch Zauber und magische Effekte verursachte Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = "HEAL" },
				{ pattern = "Erhöht durch Zauber und magische Effekte verursachte Schaden und Heilung aller Gruppenmitglieder, die sich im Umkreis von %d+ Metern befinden, um bis zu (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Stellt alle 5 Sek. (%d+) Mana bei allen Gruppenmitgliedern, die sich im Umkreis von %d+ Metern befinden, wieder her.", effect = "MANAREG" },
				{ pattern = "Erhöht die kritische Zaubertrefferwertung aller Gruppenmitglieder innerhalb von %d+ Metern um (%d+)%.", effect = "SPELLCRIT" },

				-- Added for HealPoints
				{ pattern = "Ermöglicht, das (%d+)%% Eurer Manaregeneration während des Zauberwirkens weiter läuft%.", effect = "CASTINGREG"},
				-- { pattern = "Improves your chance to get a critical strike with Nature spells by (%d+)%%%.", effect = "NATURECRIT"},
				-- { pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
				-- { pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
				-- { pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
				-- { pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
				-- { pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
				-- { pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
				-- { pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
				-- { pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
				-- { pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
				{ pattern = "Erhöht den Effekt eures Zaubers Verjüngung um (%d+)%.", effect = "IMPREJUVENATION"},
				-- { pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
				{ pattern = "Erhöht den durch Eure Zauber Heiliges Licht und Lichtblitz geheilten Wert um (%d+)%.", effect = "IMPFLASHOFLIGHT"},
				-- { pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
				-- { pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
				-- { pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
				-- { pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
				{ pattern = "Erhöht den durch euren Zauber Erneuerung geheilten Wert um (%d+)%%%.", effect = "CHEAPERRENEW"},

				-- Combat Rating
				{ pattern = "Erhöht Eure Trefferwertung um (%d+)%.", effect = "CR_HIT" },
				{ pattern = "Erhöht Eure kritische Trefferwertung um (%d+)%.", effect = "CR_CRIT" },
				{ pattern = "Erhöht Eure Distanztrefferwertung um (%d+)%.", effect = "CR_RANGEDHIT" },
				{ pattern = "Erhöht die Verteidigungswertung um (%d+)%.", effect = "CR_DEFENSE" },
				{ pattern = "Erhöht Eure kritische Zaubertrefferwertung um (%d+)%.", effect = "CR_SPELLCRIT" },
				{ pattern = "Erhöht Eure Abhärtungswertung um (%d+)%.", effect = "CR_RESILIENCE" },
				{ pattern = "Erhöht Eure Zaubertrefferwertung um (%d+)%.", effect = "CR_SPELLHIT" },
				{ pattern = "Erhöht Trefferwertung um (%d+)%.", effect = "CR_HIT" },
				{ pattern = "Erhöht kritische Trefferwertung um (%d+)%.", effect = "CR_CRIT" },
				{ pattern = "Erhöht Eure Ausweichwertung um (%d+)%.", effect = "CR_DODGE" },
				{ pattern = "Erhöht Eure Blockwertung um (%d+)%.", effect = "CR_BLOCK" },
				{ pattern = "Erhöht Eure Parrierwertung um (%d+)%.", effect = "CR_PARRY" },
				{ pattern = "Erhöht die Fertigkeitswertung für Äxte um (%d+)%.", effect = "CR_WEAPON_AXE" },
				{ pattern = "Erhöht die Fertigkeitswertung für Dolche um (%d+)%.", effect = "CR_WEAPON_DAGGER" },
				{ pattern = "Erhöht die Fertigkeitswertung für Streitkolben um (%d+)%.", effect = "CR_WEAPON_MACE" },
				{ pattern = "Erhöht die Fertigkeitswertung für Schwerter um(%d+)%.", effect = "CR_WEAPON_SWORD" },
				{ pattern = "Erhöht die Fertigkeitswertung für Zweihandschwerter um (%d+)%.", effect = "CR_WEAPON_SWORD_2H" },
				{ pattern = "Erhöht die Fertigkeitswertung für Bögen um (%d+)%.", effect = "CR_WEAPON_BOW" },
				{ pattern = "Erhöht die Fertigkeitswertung für Armbrüste um (%d+)%.", effect = "CR_WEAPON_XBOW" },
				{ pattern = "Erhöht die Fertigkeitswertung für Schusswaffen um (%d+)%.", effect = "CR_WEAPON_GUN" },
				{ pattern = "Erhöht die Fertigkeitswertung für unbewaffneten Kampf um (%d+)%.", effect = "CR_WEAPON_FIST" },
				{ pattern = "Erhöht die Fertigkeitswertung für Stäbe um (%d+)%.", effect = "CR_WEAPON_STAFF" },
				{ pattern = "Erhöht die Fertigkeitswertung für Zweihandäxte um (%d+)%.", effect = "CR_WEAPON_AXE_2H" },
				{ pattern = "Erhöht die Fertigkeitswertung für Zweihandstreitkolben um (%d+)%.", effect = "CR_WEAPON_MACE_2H" },
				{ pattern = "Erhöht die Fertigkeitswertung für Stangenwaffen um (%d+)%.", effect = "CR_WEAPON_POLEARM" },


				-- Updated Patterns (in 2.0)
				{ pattern = "Verringert den Widerstand des Ziels gegen Eure Zauber um (%d+)%.", effect = "SPELLPEN" },
				{ pattern = "Verbessert Eure Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
				{ pattern = "Erhöht die Angriffskraft um (%d+)%.", effect = "ATTACKPOWER" },
				{ pattern = "Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt um (%d+)%.", effect = "ATTACKPOWERFERAL" },
			},

			SEPARATORS = { "/", ",", "&", " und " },

			HEAL_AND_DMG_PATTERNS = {
				["%+(%d+) Heilung und %+(%d+) Zauberschaden"] = false,
				["%+(%d+) Heilzauber und %+(%d+) Schadenszauber"] = false,
				["%+(%d+) Heilung %+(%d+) Zauberschaden"] = false,
			},

			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["Alle Werte"] = ALL_STATS,
				["Stärke"] = "STR",
				["Beweglichkeit"] = "AGI",
				["Ausdauer"] = "STA",
				["Intelligenz"] = "INT",
				["Willenskraft"] = "SPI",

				["Alle Widerstandsarten"] = ALL_RESISTS,

				["Angeln"] = "FISHING",
				["Angelköder"] = "FISHING",
				["Bergbau"] = "MINING",
				["Kräuterkunde"] = "HERBALISM",
				["Kürschnerei"] = "SKINNING",
				["Verteidigung"] = "DEFENSE",
				["Verteidigungsfertigkeit"] = "DEFENSE",

				["Angriffskraft"] = "ATTACKPOWER",
				["Angriffskraft gegen Untote"] = "ATTACKPOWERUNDEAD",
				["Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt"] = "ATTACKPOWERFERAL",
				["Ausweichen"] = "DODGE",
				["Blocken"] = "BLOCK",
				["Blockwert"] = "BLOCKVALUE",
				["Trefferchance"] = "TOHIT",
				["Distanzangriffskraft"] = "RANGEDATTACKPOWER",
				["Gesundheit alle 5 Sek"] = "HEALTHREG",
				["Heilzauber"] = "HEAL",
				["Erhöht Heilung"] = "HEAL",
				["Mana alle 5 Sek"] = "MANAREG",
				["Manaregeneration"] = "MANAREG",
				["Zauberschaden erhöhen"]= "DMG",
				["Kritischer Treffer"] = "CRIT",
				["Zauberschaden"] = HEAL_AND_DMG,
				["Blocken"] = "BLOCK",
				["Gesundheit"] = "HEALTH",
				["HP"] = "HEALTH",
				["Heilung und Zauberschaden"] = HEAL_AND_DMG,
				["Zauberschaden und Heilung"] = HEAL_AND_DMG,
				["Schadenszauber und Heilzauber"] = HEAL_AND_DMG,
				["Schadens- und Heilzauber"] = HEAL_AND_DMG,
				["Zaubertrefferchance"] = "SPELLTOHIT",
				["Mana"] = "MANA",
				["Rüstung"] = "BASE_ARMOR",
				["Verstärkte Rüstung"]= "ARMOR_BONUS",
				["Reduzierte Bedrohung"] = "THREATREDUCTION",
			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "Arkan", effect = "ARCANE" },
				{ pattern = "Feuer", effect = "FIRE" },
				{ pattern = "Frost", effect = "FROST" },
				{ pattern = "Heilig", effect = "HOLY" },
				{ pattern = "Schatten", effect = "SHADOW" },
				{ pattern = "Natur", effect = "NATURE" },
			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "widerst", effect = "RES" },
				{ pattern = "schaden", effect = "DMG" },
				{ pattern = "effekte", effect = "DMG" },
			},

			PATTERNS_OTHER = {
				{ pattern = "Manaregeneration (%d+) pro 5 Sek%.", effect = "MANAREG" },

				{ pattern = "Zandalarianisches Siegel der Macht", effect = "ATTACKPOWER", value = 30 },
				{ pattern = "Zandalarianisches Siegel des Mojo", effect = HEAL_AND_DMG, value = 18 },
				{ pattern = "Zandalarianisches Siegel der Inneren Ruhe", effect = "HEAL", value = 33 },

				{ pattern = "Schwaches Zauberöl", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "Geringes Zauberöl", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "Zauberöl", effect = HEAL_AND_DMG, value = 24 },
				{ pattern = "Hervorragendes Zauberöl", effect = {"DMG", "HEAL", "CR_SPELLCRIT"}, value = {36, 36, 14} },
				{ pattern = "Überragendes Zauberöl", effect = HEAL_AND_DMG, value = 42 },

				{ pattern = "Schwaches Manaöl", effect = "MANAREG", value = 4 },
				{ pattern = "Geringes Manaöl", effect = "MANAREG", value = 8 },
				{ pattern = "Hervorragendes Manaöl", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
				{ pattern = "Überragendes Manaöl", effect = "MANAREG", value = 14 },

				{ pattern = "Eterniumangelschnur", effect = "FISHING", value = 5 },
				{ pattern = "%+30 Distanztrefferwertung", effect = "CR_RANGEDHIT", value = 30 }, --Biznicks 247x128 Accurascope
				{ pattern = "Vitalität", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
				{ pattern = "Seelenfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
				{ pattern = "Sonnenfeuer", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
				{ pattern = "Unbändigkeit", effect = "ATTACKPOWER", value = 70 },
				{ pattern = "Sicherer Stand", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
				{ pattern = "%+2%% Bedrohung", effect = "THREATREDUCTION", value = -2 },
				{ pattern = "Feingefühl", effect = "THREATREDUCTION", value = 2 },

			}
		}
	elseif locale == "koKR" then
		L = {
			NAMES = {
				STR = "힘",
				AGI = "민첩성",
				STA = "체력",
				INT = "지능",
				SPI = "정신력",
				ARMOR = "방어도",
				BASE_ARMOR = "기본 방어도",
				ARMOR_BONUS = "향상되는 방어도",

				ARCANERES = "비전 저항력",
				FIRERES = "화염 저항력",
				NATURERES = "자연 저항력",
				FROSTRES = "냉기 저항력",
				SHADOWRES = "암흑 저항력",

				FISHING = "낚시",
				MINING = "채광",
				HERBALISM = "약초 채집",
				SKINNING = "무두질",
				DEFENSE = "방어 숙련",

				BLOCK = "방패 막기",
				BLOCKVALUE = "피해 방어량",
				DODGE = "회피",
				PARRY = "무기 막기",
				ATTACKPOWER = "전투력",
				ATTACKPOWERUNDEAD = "언데드에 대한 전투력",
				ATTACKPOWERBEAST = "야수에 대한 전투력",
				ATTACKPOWERFERAL = "야수 변신시 전투력",
				CRIT = "치명타 적중률",
				RANGEDATTACKPOWER = "원거리 전투력",
				RANGEDCRIT = "원거리 치명타 적중률",
				TOHIT = "적중률",
				IGNOREARMOR = "방어도 무시",
				THREATREDUCTION = "위협 수준 감소",

				DMG = "주문 공격력",
				DMGUNDEAD = "언데드에 대한 주문 공격력",
				ARCANEDMG = "비전계 주문 공격력",
				FIREDMG = "화염계 주문 공격력",
				FROSTDMG = "냉기계 주문 공격력",
				HOLYDMG = "신성계 주문 공격력",
				NATUREDMG = "자연계 주문 공격력",
				SHADOWDMG = "암흑계 주문 공격력",
				SPELLCRIT = "주문 극대화율",
				SPELLTOHIT = "주문 적중율",
				SPELLPEN = "대상 저항 감소",
				HEAL = "치유량",
				HOLYCRIT = "신성계 주문 극대화율",

				HEALTHREG = "생명력 회복",
				MANAREG = "마나 회복",
				HEALTH = "생명력",
				MANA = "마나",

				CR_WEAPON = "무기 숙련도",
				CR_DEFENSE = "방어 숙련도",
				CR_DODGE = "회피 숙련도",
				CR_PARRY = "무기 막기 숙련도",
				CR_BLOCK = "방패 막기 숙련도",
				CR_HIT = "적중도",
				CR_CRIT = "치명타 적중도",
				CR_HASTE = "가속도",
				CR_SPELLHIT = "주문 적중도",
				CR_SPELLCRIT = "주문 극대화 적중도",
				CR_SPELLHASTE = "주문 가속도",
				CR_RESILIENCE = "탄력도",
				CR_WEAPON_AXE = "도끼류 숙련도",
				CR_WEAPON_DAGGER = "단검류 숙련도",
				CR_WEAPON_MACE = "둔기류 숙련도",
				CR_WEAPON_SWORD = "도검류 숙련도",
				CR_WEAPON_SWORD_2H = "양손 도검류 숙련도",
				SNARERES = "감속 및 이동 방해 효과", -- check
			},

			PATTERNS_SKILL_RATING = {
				{ pattern = "(.*)가 (%d+)만큼 증가합니다" },
				{ pattern = "공격 시 적의 방어도를 (%d+)만큼 (.*)합니다" },
--				{ pattern = "Increases (.*) rating by (%d+)" },
--				{ pattern = "Improves your (.*) rating by (%d+)" },
--				{ pattern = "Improves (.*) rating by (%d+)" },
			},

			SKILL_NAMES = {
				["적중도"] = "CR_HIT",
				["치명타 적중도"] = "CR_CRIT",
				["원거리 치명타 적중도"] = "CR_RANGEDCRIT",
				["방어 숙련도"] = "CR_DEFENSE",
				["주문 극대화 적중도"] = "CR_SPELLCRIT",
				["주문의 극대화 적중도"] = "CR_SPELLCRIT",
				["탄력도"] = "CR_RESILIENCE",
				["주문의 적중도"] = "CR_SPELLHIT",
				["주문 적중도"] = "CR_SPELLHIT",
				["회피 숙련도"] = "CR_DODGE",
				["방패 막기 숙련도"] = "CR_BLOCK",
				["무기 막기 숙련도"] = "CR_PARRY",
				["도끼류 숙련도"] = "CR_WEAPON_AXE",
				["단검류 숙련도"] = "CR_WEAPON_DAGGER",
				["둔기류 숙련도"] = "CR_WEAPON_MACE",
				["도검류 숙련도"] = "CR_WEAPON_SWORD",
				["양손 도검류 숙련도"] = "CR_WEAPON_SWORD_2H",
				["야생 전투 숙련도"] = "CR_WEAPON_FERAL",
				["방패 막기"] = "CR_BLOCK",
				["공격 가속도"] = "CR_HASTE",
				["주문 시전 가속도"] = "CR_SPELLHASTE",
				["맨손 전투 숙련도"] = "CR_WEAPON_FIST",  -- unarmed skill
				["장착 무기류 숙련도"] = "CR_WEAPON_FIST",
				["석궁류 숙련도"] = "CR_WEAPON_CROSSBOW",
				["총기류 숙련도"] = "CR_WEAPON_GUN",
				["활류 숙련도"] = "CR_WEAPON_BOW",
				["지팡이류 숙련도"] = "CR_WEAPON_STAFF",
				["양손 둔기류 숙련도"] = "CR_WEAPON_MACE_2H",
				["양손 도끼류 숙련도"] = "CR_WEAPON_AXE_2H",
				["숙련도"] = "CR_EXPERTISE",
			},


			PATTERNS_PASSIVE = {
				{ pattern = "원거리 전투력이 (%d+)만큼 증가합니다%.", effect = "RANGEDATTACKPOWER" },
				{ pattern = "방패의 피해 방어량이 (%d+)만큼 증가합니다%.", effect = "BLOCKVALUE" },
				{ pattern = "비전 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "ARCANEDMG" },
				{ pattern = "화염 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "FIREDMG" },
				{ pattern = "냉기 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "FROSTDMG" },
				{ pattern = "신성 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "HOLYDMG" },
				{ pattern = "자연 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "NATUREDMG" },
				{ pattern = "암흑 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "SHADOWDMG" },
				{ pattern = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
				{ pattern = "모든 주문 및 효과의 공격력과 치유량이 최대 (%d+)만큼 증가합니다%.", effect = HEAL_AND_DMG },
				{ pattern = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼, 공격력이 최대 (%d+)만큼 증가합니다%.", effect = HEAL_AND_DMG },
				{ pattern = "언데드에 대한 주문 및 효과에 의한 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "DMGUNDEAD", nofinish = true },
				{ pattern = "악마에 대한 주문 및 효과에 의한 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "DMGDEMON" },
				{ pattern = "언데드와 악마에 대한 주문 및 효과에 의한 공격력이 최대 (%d+)만큼 증가합니다%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
				{ pattern = "언데드 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
				{ pattern = "야수 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERBEAST" },
				{ pattern = "악마 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERDEMON" },
				{ pattern = "정령 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
				{ pattern = "용족 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
				{ pattern = "언데드와 악마 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
				{ pattern = "매 5초마다 (%d+)의 생명력이 회복됩니다%.", effect = "HEALTHREG" },
				{ pattern = "매 5초마다 (%d+)의 생명력을 재생시킵니다%.", effect = "HEALTHREG" }, -- 833, 17743
				{ pattern = "매 5초마다 (%d+)의 마나가 회복됩니다%.", effect = "MANAREG" },
				{ pattern = "공격 시 적의 방어도를 (%d+)만큼 무시합니다.", effect = "IGNOREARMOR" },

				-- Atiesh related patterns
				{ pattern = "주문의 공격력이 최대 (%d+)만큼 치유량을 최대 (%d+)만큼 증가합니다%.", effect = {"DMG", "HEAL"} },
				{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
				{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 모든 주문 및 효과에 의한 공격력과 치유량이 최대 (%d+)만큼 증가합니다%.", effect = HEAL_AND_DMG },
				{ pattern = "주위 %d+미터 반경 내에 있는 모든 파티원의 마나가 매 5초마다 (%d+)만큼 회복됩니다%.", effect = "MANAREG" },
				{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 주문 극대화 확률이 (%d+)%%만큼 증가합니다%.", effect = "SPELLCRIT" },

				-- Added for HealPoints
				{ pattern = "시전 중에도 평소의 (%d+)%%에 달하는 속도로 마나가 회복됩니다%.", effect = "CASTINGREG"},
				{ pattern = "재생의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGREGROWTH"},
				{ pattern = "성스러운 빛의 시전 시간이 0%.(%d+)초 만큼 단축됩니다%.", effect = "CASTINGHOLYLIGHT"},
				{ pattern = "치유의 손길의 시전 시간이 0%.(%d+)초 만큼 단축됩니다%.", effect = "CASTINGHEALINGTOUCH"},
				{ pattern = "순간 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGFLASHHEAL"},
				{ pattern = "연쇄 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGCHAINHEAL"},
				{ pattern = "회복의 지속시간이 (%d+)만큼 증가합니다%.", effect = "DURATIONREJUV"},
				{ pattern = "소생의 지속시간이 (%d+)초만큼 증가합니다%.", effect = "DURATIONRENEW"},
				{ pattern = "평상시 생명력과 마나의 회복 속도를 (%d+)만큼 향상시킵니다%.", effect = "MANAREGNORMAL" },
				{ pattern = "연쇄 치유 사용 시 처음 회복되는 대상 외에 치유되는 생명력이 각각 (%d+)%%만큼 증가합니다%.", effect = "IMPCHAINHEAL"},
				{ pattern = "회복에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPREJUVENATION"},
				{ pattern = "하급 치유의 물결에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPLESSERHEALINGWAVE"},
				{ pattern = "빛의 섬광에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "IMPFLASHOFLIGHT"},
				{ pattern = "치유의 물결이나 하급 치유의 물결 시전 후 25%%의 확률로 소비된 마나의 (%d+)%%를 다시 회복합니다%.", effect = "REFUNDHEALINGWAVE"},
				{ pattern = "치유의 물결 사용 시 추가로 주위 아군을 연쇄적으로 회복시킵니다%. 대상이 바뀔 때마다 치유 효과는 (%d+)%%씩 감소됩니다%. 최대 2명의 추가 대상에게 효력을 미칩니다%.", effect = "JUMPHEALINGWAVE"},
				{ pattern = "치유의 손길%, 재생%, 회복%, 평온에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERDRUID"},
				{ pattern = "치유의 손길이 극대화 효과를 발휘할 시 주문에 소비된 마나의 (%d+)%%만큼을 회복합니다%.", effect = "REFUNDHTCRIT"},
				{ pattern = "소생에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERRENEW"},

				{ pattern = "주문 관통력이 (%d+)만큼 증가합니다%.", effect = "SPELLPEN" },
				{ pattern = "전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWER" },
				{ pattern = "표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERFERAL" },
				{ pattern = "매 4초마다 (%d+)의 생명력이 회복됩니다%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
				{ pattern = "은신의 효과 레벨이 (%d+)만큼 증가합니다%.", effect = "STEALTH" },
				{ pattern = "원거리 무기 공격 속도가 (%d+)%%만큼 증가합니다%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
				{ pattern = "%d+미터 반경 내의 파티원의 체력을 (%d+)만큼 증가시킵니다%.", effect = "STA" }, -- 4248
				{ pattern = "수영 속도가 (%d+)%%만큼 증가합니다.%.", effect = "SWIMSPEED" }, -- 7052
				{ pattern = "탈것의 속도가 (%d+)%%만큼 증가합니다", effect = "MOUNTSPEED" }, -- 11122
				{ pattern = "달리기 속도가 (%d+)%%만큼 증가합니다%.", effect = "RUNSPEED" }, -- 13388
				{ pattern = "무기 막기 확률이 (%d+)%%만큼 감소합니다%.", effect = "NEGPARRY" }, -- 7348
				{ pattern = "기절과 공포에 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
				{ pattern = "공포에 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
				{ pattern = "기절 및 방향 감각 상실 효과를 저항할 확률이 (%d+)%%만큼 증가합니다%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
				{ pattern = "탈것의 속도가 (%d+)%%만큼 증가합니다%.", effect = "MOUNTSPEED" }, -- 25653
				{ pattern = "근접 피해 (%d+)만큼 감소%.", effect = "MELEETAKEN" }, -- 31154
				{ pattern = "받는 주문 피해가 (%d+)만큼 감소합니다%.", effect = "DMGTAKEN" }, -- 22191
			},

			SEPARATORS = { "/", ",", "&" },
			
			HEAL_AND_DMG_PATTERNS = {
			},

			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["모든 능력치"] = ALL_STATS,
				["힘"] = "STR",
				["민첩성"] = "AGI",
				["체력"] = "STA",
				["지능"] = "INT",
				["정신력"] = "SPI",

				["모든 저항력"] = ALL_RESISTS,

				["낚시"] = "FISHING",
				["낚시용 미끼"] = "FISHING",
				["낚시 숙련도"] = "FISHING",
				["채광"] = "MINING",
				["약초 채집"] = "HERBALISM",
				["무두질"] = "SKINNING",
				["방어 숙련도"] = "CR_DEFENSE",
				["방어 숙련도 증가"] = "DEFENSE",

				["전투력"] = "ATTACKPOWER",
				["언데드 공격 시 전투력"] = "ATTACKPOWERUNDEAD",

				["회피율"] = "DODGE",
				["방어율"] = "BLOCKVALUE",
				["방패 피해 방어량"] = "BLOCKVALUE",
				["적중률"] = "TOHIT",
				["주문 적중률"] = "SPELLTOHIT",
				["방어율"] = "BLOCK",  -- Blocking
				["원거리 전투력"] = "RANGEDATTACKPOWER",
				["5초당 생명력 회복"] = "HEALTHREG",
				["주문 치유량"] = "HEAL",
				["치유량 증가"] = "HEAL",
				["치유량"] = "HEAL",
				["치유 주문"] = "HEAL",
				["치유 및 주문 공격력"] = HEAL_AND_DMG,
				["공격력 및 주문 치유량"] = HEAL_AND_DMG,
				["주문 공격력 및 치유량"] = HEAL_AND_DMG,
				["주문 위력"] = HEAL_AND_DMG,
				["주문 공격력"] = HEAL_AND_DMG,
				["치명타"] = "CRIT",
				["치명타 공격"] = "CRIT",
				["생명력"] = "HEALTH",
				["HP"] = "HEALTH",
				["마나"] = "MANA",
				["방어도"] = "BASE_ARMOR",
				["방어도 보강"] = "ARMOR_BONUS",
				["탄력성"] = "CR_RESILIENCE",
				["주문 극대화 적중도"] = "CR_SPELLCRIT",
				["주문 관통력"] = "SPELLPEN",
				["적중도"] = "CR_HIT",
				["방어 숙련도"] = "CR_DEFENSE",
				["탄력도"] = "CR_RESILIENCE",
				["극대화 적중도"] = "CR_CRIT",  -- Crit Rating
--				["Critical Rating"] = "CR_CRIT",
				["치명타 적중도"] = "CR_CRIT",
				["회피 숙련도"] = "CR_DODGE",
				["무기 막기 숙련도"] = "CR_PARRY",
				["주문 극대화 적중도"] = "CR_SPELLCRIT",
--				["Spell Critical Rating"] = "CR_SPELLCRIT",
				["주문 극대화 적중도"] = "CR_SPELLCRIT",  -- Spell Crit Rating
				["주문 적중도"] = "CR_SPELLHIT",
				["5초당 마나 회복"] = "MANAREG",
				["마나 회복량이 5초당"] = "MANAREG",  -- Mana per 5 Seconds
				["마나 회복량 5초당"] = "MANAREG",  -- Mana every 5 seconds
				["5초당 마나 회복량"] = "MANAREG",
				["매 5초마나 마나 회복"] = "MANAREG",  -- mana per 5 sec
				["5초당 마나 회복"] = "MANAREG",
				["마나 회복량"] = "MANAREG",
				["근접 공격력"] = "MELEEDMG",
				["무기 공격력"] = "MELEEDMG",
				["모든 저항"] = ALL_RESISTS,
				["위협 감소"] = "THREATREDUCTION",
				["양손 도끼류 숙련도"] = "CR_WEAPON_AXE_2H",
				["기절 저항력"] = "STUNRESIST",
			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "비전", 	effect = "ARCANE" },
				{ pattern = "화염", 	effect = "FIRE" },
				{ pattern = "냉기", 	effect = "FROST" },
				{ pattern = "신성", 	effect = "HOLY" },
				{ pattern = "암흑", 	effect = "SHADOW" },
				{ pattern = "자연", 	effect = "NATURE" }
			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "저항",	 	effect = "RES" },
				{ pattern = "피해", 		effect = "DMG" },
				{ pattern = "주문 공격력",	effect = "DMG" },
			},

			PATTERNS_OTHER = {
--				{ pattern = "방어도 %(%+(%d+)만큼 증가%)", effect = "ARMOR_BONUS" },
				{ pattern = "5초당 (%d+)의 마나 회복%.", effect = "MANAREG" },
				{ pattern = "5초당 마나 회복량 %+(%d+)", effect = "MANAREG" },
				{ pattern = "5초당 마나 회복량 %+(%d+)%.", effect = "MANAREG" },
				{ pattern = "매 5초마다 (%d+)의 마나 회복", effect = "MANAREG" },
				{ pattern = "매 5초마다 (%d+)의 마나가 회복됩니다%.", effect = "MANAREG" },
				{ pattern = "5초당 (%d+)의 마나 회복%.", effect = "MANAREG" },

				{ pattern = "최하급 마술사 오일", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "하급 마술사 오일", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "마술사 오일", effect = HEAL_AND_DMG, value = 24 },
				{ pattern = "반짝이는 마술사 오일", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },
				{ pattern = "최고급 마술사 오일", effect = {"DMG", "HEAL"}, value = {42, 42} },

				{ pattern = "최하급 마나 오일", effect = "MANAREG", value = 4 },
				{ pattern = "하급 마나 오일", effect = "MANAREG", value = 8 },
				{ pattern = "반짝이는 마나 오일", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
				{ pattern = "최고급 마나 오일", effect = "MANAREG", value = 14 },

				{ pattern = "에터니움 낚시줄", effect = "FISHING", value = 5 },
				{ pattern = "활력", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
				{ pattern = "냉기의 영혼", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
				{ pattern = "태양의 불꽃", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
				{ pattern = "전투력", effect = "ATTACKPOWER", value = 70 },
				{ pattern = "침착함", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} }, -- check
				{ pattern = "방어도가 5만큼, 암흑 저항력이 10만큼 증가하고 5초마다 3의 생명력이 회복됩니다.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },  -- Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.
				{ pattern = "위협 수준을 %+2%%만큼", effect = "THREATREDUCTION", value = -2 },  -- %+2%% Threat
				{ pattern = "미묘함", effect = "THREATREDUCTION", value = 2 },

				{ pattern = "물속에서 숨쉴 수 있도록 해줍니다%.", effect = "UNDERWATER", value = 1 }, -- 10506
				{ pattern = "자물쇠 따기 숙련도가 약간 증가합니다%.", effect = "LOCKPICK", value = 1 },
				{ pattern = "은신 감지 능력이 약간 증가합니다%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
				{ pattern = "은신 감지가 증가합니다%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
				{ pattern = "무장 해제에 면역이 됩니다%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
				{ pattern = "달리기 속도가 약간 증가합니다%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
				{ pattern = "낙하 피해가 감소됩니다%.", effect = "SLOWFALL", value = 1 }, -- 19982
				{ pattern = "이동 속도와 생명력 회복 속도가 증가합니다%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
				{ pattern = "달리기 속도가 약간 증가합니다%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
				{ pattern = "은신 능력이 약간 증가합니다%.", effect = "STEALTH", value = 3 }, -- 21758
				{ pattern = "은신 효과가 증가합니다%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
				{ pattern = "모든 주문 및 효과의 공격력과 치유량이 약간 증가합니다%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

				{ pattern = "멋진 패션 감각으로 주위를 감동시킵니다%.", effect = "IMPRESS", value = 1 }, -- 10036
				{ pattern = "모조를 증가시킵니다%.", effect = "MOJO", value = 1 }, -- 23717
			},
		}
	elseif locale == "esES" then
		L = {
			NAMES = {
				STR = "Fuerza",
				AGI = "Agilidad",
				STA = "Aguante",
				INT = "Inteligencia",
				SPI = "Esp\195\173ritu",
				ARMOR = "Armadura",
				BASE_ARMOR = "Armadura Base",
				ARMOR_BONUS = "Bonus de Armadura",

				ARCANERES = "Resistencia Arcana",
				FIRERES = "Resistencia al Fuego",
				NATURERES = "Resistencia a la Naturaleza",
				FROSTRES = "Resistencia a la Escarcha",
				SHADOWRES = "Resistencia a las Sombras",

				FISHING = "Pesca",
				MINING = "Miner\195\173a",
				HERBALISM = "Bot\195\161nica",
				SKINNING = "Desuello",
				DEFENSE = "Defensa",

				BLOCK = "Probabilidad de bloqueo",
				BLOCKVALUE = "Valor de bloqueo",
				DODGE = "Esquivar",
				PARRY = "Parar",
				ATTACKPOWER = "Poder de Ataque",
				ATTACKPOWERUNDEAD = "Poder de Ataque contra no-muertos",
				ATTACKPOWERBEAST = "Poder de Ataque contra bestias",
				ATTACKPOWERFERAL = "Poder de Ataque en forma feral",
				CRIT = "Golpes Cr\195\173ticos",
				RANGEDATTACKPOWER = "Poder de Ataque a distancia",
				RANGEDCRIT = "Disparos Cr\195\173ticos",
				TOHIT = "Probabilidad de Golpear",
				IGNOREARMOR = "Ignorar Armadura",
				THREATREDUCTION = "Reducci\195\179n de Armadura",

				DMG = "Da\195\177o de Hechizo",
				DMGUNDEAD = "Da\195\177o de Hechizo contra no-muertos",
				ARCANEDMG = "Da\195\177o Arcano",
				FIREDMG = "Da\195\177o de Fuego",
				FROSTDMG = "Da\195\177o de Escarcha",
				HOLYDMG = "Da\195\177o Sagrado",
				NATUREDMG = "Da\195\177o de Naturaleza",
				SHADOWDMG = "Da\195\177o de Sombras",
				SPELLCRIT = "Cr\195\173ticos de Hechizo",
				SPELLTOHIT = "Probabilidad de golpear con hechizos",
				SPELLPEN = "Penetraci\195\179n de Hechizoa",
				HEAL = "Sanaci\195\179n",
				HOLYCRIT = "Cr?tico de Sanaci\195\179n",

				HEALTHREG = "Regeneraci\195\179n de Salud",
				MANAREG = "Regeneraci\195\179n de Man\195\161",
				HEALTH = "Puntos de Salud",
				MANA = "Puntos de Man\195\161",

				CR_WEAPON = "Puntos de arma",
				CR_DEFENSE = "Puntos de defensa",
				CR_DODGE = "Puntos de esquivar",
				CR_PARRY = "Puntos de parar",
				CR_BLOCK = "Puntos de bloquear",
				CR_HIT = "\195\173ndice de golpe",
				CR_CRIT = "Puntos de golpe cr\195\173tico",
				CR_HASTE = "Puntos de celeridad",
				CR_SPELLHIT = "Puntos de golpe con hechizo",
				CR_SPELLCRIT = "Puntos de golpe cr\195\173tico con hechizo",
				CR_SPELLHASTE = "Puntos de celeridad con hechizos",
				CR_RESILIENCE = "Temple",
				CR_WEAPON_AXE = "Habilidad con hachas",
				CR_WEAPON_DAGGER = "Habilidad con dagas",
				CR_WEAPON_MACE = "Habilidad con mazas",
				CR_WEAPON_SWORD = "Habilidad con espadas",
				CR_WEAPON_SWORD_2H = "Habilidad con espadas a dos manos",
				SNARERES = "Resistencia a raices e inmovilizaci\195\179n",
			},

			PATTERNS_SKILL_RATING = {
				{ pattern = "Aumenta tu \195\173ndice de (.*) en (%d+) p" },
				{ pattern = "Aumenta tu \195\173ndice de (.*) en (%d+)" },
				{ pattern = "Mejora tu \195\173ndice de (.*) en (%d+) p" },
				{ pattern = "Aumenta el \195\173ndice de (.*) en (%d+) p" },
				{ pattern = "Aumenta el \195\173ndice de (.*) en (%d+)" },
				{ pattern = "?ndice de (.*) aumentado en (%d+)" },
				{ pattern = "Aumenta en (%d+) el ?ndice de (.*)", invert = true },
			},

			SKILL_NAMES = {
				["golpe"] = "CR_HIT",
				["golpe cr\195\173tico"] = "CR_CRIT",
				["golpe cr\195\173tico a distancia"] = "CR_RANGEDCRIT",
				["defensa"] = "CR_DEFENSE",
				["golpe cr\195\173tico con hechizos"] = "CR_SPELLCRIT",
				["temple"] = "CR_RESILIENCE",
				["golpe con hechizos"] = "CR_SPELLHIT",
				["esquivar"] = "CR_DODGE",
				["bloqueo"] = "CR_BLOCK",
				["parada"] = "CR_PARRY",
				["habilidad con hachas"] = "CR_WEAPON_AXE",
				["habilidad con dagas"] = "CR_WEAPON_DAGGER",
				["habilidad con mazas"] = "CR_WEAPON_MACE",
				["habilidad con espadas"] = "CR_WEAPON_SWORD",
				["habilidad con espadas a dos manos"] = "CR_WEAPON_SWORD_2H",
				["habilidad en combate feral"] = "CR_WEAPON_FERAL",
				["bloqueo con escudo"] = "CR_BLOCK",
				["celeridad"] = "CR_HASTE",
				["celeridad con hechizos"] = "CR_SPELLHASTE",
				["habilidad sin armas"] = "CR_WEAPON_FIST",
				["habilidad con armas de pu\195\177o"] = "CR_WEAPON_FIST",
				["habilidad con ballestas"] = "CR_WEAPON_CROSSBOW",
				["habilidad con armas de fuego"] = "CR_WEAPON_GUN",
				["habilidad con arcos"] = "CR_WEAPON_BOW",
				["habilidad con bastones"] = "CR_WEAPON_STAFF",
				["habilidad con mazas a dos manos"] = "CR_WEAPON_MACE_2H",
				["habilidad con hachas a dos manos"] = "CR_WEAPON_AXE_2H",
				["pericia"] = "CR_EXPERTISE",
			},


			PATTERNS_PASSIVE = {
				{ pattern = "Aumenta el poder de ataque a distancia en (%d+)%.", effect = "RANGEDATTACKPOWER" },
				{ pattern = "Aumenta el valor de bloqueo de tu escudo en (%d+)%.", effect = "BLOCKVALUE" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos arcanos y los efectos hasta en (%d+)%.", effect = "ARCANEDMG" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos de fuego y los efectos hasta en (%d+)%.", effect = "FIREDMG" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos de escarcha y los efectos hasta en (%d+)%.", effect = "FROSTDMG" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos sagrados y los efectos hasta en (%d+)%.", effect = "HOLYDMG" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos de naturaleza y los efectos hasta en (%d+)%.", effect = "NATUREDMG" },
				{ pattern = "Aumenta el da\195\177o de tus hechizos de sombras y los efectos hasta en (%d+)%.", effect = "SHADOWDMG" },
				{ pattern = "Aumenta la sanaci\195\179n con hechizos y los efectos hasta en (%d+)%.", effect = "HEAL" },
				{ pattern = "Aumenta el da\195\177o y la sanaci\195\179n de tus hechizos hasta en (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Aumenta el da\195\177o a no-muertos con hechizos y los efectos hasta en (%d+)%.", effect = "DMGUNDEAD", nofinish = true },
				{ pattern = "Aumenta el da\195\177o a demonios con hechizos y los efectos hasta en (%d+)%.", effect = "DMGDEMON" },
				{ pattern = "Aumenta el da\195\177o a no-muertos y demonios con hechizos y los efectos hasta en (%d+)%.", effect = {"DMGUNDEAD", "DMGDEMON"}, nofinish = true },
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra no-muertos%.", effect = "ATTACKPOWERUNDEAD", nofinish = true },
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra bestias%.", effect = "ATTACKPOWERBEAST" },
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra demonios%.", effect = "ATTACKPOWERDEMON" },
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra elementales%.", effect = "ATTACKPOWERELEMENTAL" }, -- 18310
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra dragonantes%.", effect = "ATTACKPOWERDRAGON" }, -- 19961
				{ pattern = "Aumenta el poder de ataque en (%d+) al pelear contra no-muertos y demonios%.", effect = {"ATTACKPOWERUNDEAD", "ATTACKPOWERDEMON"}, nofinish = true }, -- 23206
				{ pattern = "Restaura (%d+) salud cada 5 seg%.", effect = "HEALTHREG" },
				{ pattern = "Restaura (%d+) salud cada 5 seg%.", effect = "HEALTHREG" }, -- 833, 17743
				{ pattern = "Restaura (%d+) man\195\161 cada 5 seg%.", effect = "MANAREG" },
				{ pattern = "Tus ataques ignoran (%d+) de la armadura de tu oponente.", effect = "IGNOREARMOR" },

				-- Atiesh related patterns
				{ pattern = "Aumenta el da\195\177o con hechizos hasta en (%d+) y la sanaci\195\179n hasta en (%d+)%.", effect = {"DMG", "HEAL"} },
				{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = "HEAL" },
				{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = HEAL_AND_DMG },
				{ pattern = "Restores (%d+) mana per 5 seconds to all party members within %d+ yards%.", effect = "MANAREG" },
				{ pattern = "Increases the spell critical chance of all party members within %d+ yards by (%d+)%%%.", effect = "SPELLCRIT" },

				-- Added for HealPoints
				{ pattern = "Allow (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},
				{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"},
				{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
				{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
				{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
				{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
				{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
				{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
				{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
				{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
				{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
				{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
				{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
				{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
				{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
				{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
				{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
				{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},

				{ pattern = "Increases your spell penetration by (%d+)%.", effect = "SPELLPEN" },
				{ pattern = "Aumenta el poder de ataque en (%d+)% p.", effect = "ATTACKPOWER" },
				{ pattern = "Aumenta en +(%d+) p. el poder de ataque bajo formas felinas, de oso, de oso temible y de lech\195\186cico lunar.%.", effect = "ATTACKPOWERFERAL" },
				{ pattern = "Restores (%d+) health every 4 sec%.", effect = "HEALTHREG" }, -- 6461 (typo ?)
				{ pattern = "Increases your effective stealth level by (%d+)%.", effect = "STEALTH" },
				{ pattern = "Increases ranged attack speed by (%d+)%%%.", effect = "RANGED_SPEED_BONUS" }, -- bags are not scanned
				{ pattern = "Gives (%d+) additional stamina to party members within %d+ yards%.", effect = "STA" }, -- 4248
				{ pattern = "Increases swim speed by (%d+)%%%.", effect = "SWIMSPEED" }, -- 7052
				{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 11122
				{ pattern = "Increases run speed by (%d+)%%%.", effect = "RUNSPEED" }, -- 13388
				{ pattern = "Decreases your chance to parry an attack by (%d+)%%%.", effect = "NEGPARRY" }, -- 7348
				{ pattern = "Increases your chance to resist Stun and Fear effects by (%d+)%%%.", effect = {"STUNRESIST", "FEARRESIST"} }, -- 17759
				{ pattern = "Increases your chance to resist Fear effects by (%d+)%%%.", effect = "FEARRESIST" }, -- 28428, 28429, 28430
				{ pattern = "Increases your chance to resist Stun and Disorient effects by (%d+)%%%.", effect = {"STUNRESIST", "DISORIENTRESIST"} }, -- 23839
				{ pattern = "Increases mount speed by (%d+)%%%.", effect = "MOUNTSPEED" }, -- 25653
				{ pattern = "Reduces melee damage taken by (%d+)%.", effect = "MELEETAKEN" }, -- 31154
				{ pattern = "Spell Damage received is reduced by (%d+)%.", effect = "DMGTAKEN" }, -- 22191
				{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CR_RANGEDCRIT" },
			},

			SEPARATORS = { "/", ",", "&", " y " },

			GENERIC_PATTERNS = {
				["^%+?(%d+)%%?(.*)$"]	= true,
				["^(.*)%+ ?(%d+)%%?$"]	= false,
				["^(.*): ?(%d+)$"]		= false
			},

			PATTERNS_GENERIC_LOOKUP = {
				["todas las caracter\195\173sticas"] = ALL_STATS,
				["fuerza"] = "STR",
				["agilidad"] = "AGI",
				["aguante"] = "STA",
				["intelecto"] = "INT",
				["esp\195\173ritu"] = "SPI",

				["todas las resistencias"] = ALL_RESISTS,

				["Pesca"] = "FISHING",
				["Fishing Lure"] = "FISHING",
				["Increased Fishing"] = "FISHING",
				["Miner\195\173a"] = "MINING",
				["Bot\195\161nica"] = "HERBALISM",
				["Desuello"] = "SKINNING",
				["Defensa"] = "CR_DEFENSE",
				["Increased Defense"] = "DEFENSE",

				["Poder de Ataque"] = "ATTACKPOWER",
				["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",

				["Esquivar"] = "DODGE",
				["Bloqueo"] = "BLOCKVALUE",
				["Block Value"] = "BLOCKVALUE",
				["Golpe"] = "TOHIT",
				["Golpe con Hechizo"] = "SPELLTOHIT",
				["Blocking"] = "BLOCK",
				["Ranged Attack Power"] = "RANGEDATTACKPOWER",
				["health every 5 sec"] = "HEALTHREG",
				["Healing Spells"] = "HEAL",
				["Increases Healing"] = "HEAL",
				["Healing"] = "HEAL",
				["healing Spells"] = "HEAL",
				["Healing and Spell Damage"] = HEAL_AND_DMG,
				["Damage and Healing Spells"] = HEAL_AND_DMG,
				["Spell Damage and Healing"] = HEAL_AND_DMG,
				["Spell Power"] = HEAL_AND_DMG,
				["Spell Damage"] = HEAL_AND_DMG,
				["Critical"] = "CRIT",
				["Critical Hit"] = "CRIT",
				["Health"] = "HEALTH",
				["HP"] = "HEALTH",
				["Mana"] = "MANA",
				["Armadura"] = "BASE_ARMOR",
				["Reinforced Armor"] = "ARMOR_BONUS",
				["Resilience"] = "CR_RESILIENCE",
				["Spell Critical strike rating"] = "CR_SPELLCRIT",
				["Spell Penetration"] = "SPELLPEN",
				["\195\173ndice de golpes"] = "CR_HIT",
				["\195\173ndice de defensa"] = "CR_DEFENSE",
				["Resilience Rating"] = "CR_RESILIENCE",
				["\195\173ndice de golpe cr\195\173tico"] = "CR_CRIT",
				["Critical Rating"] = "CR_CRIT",
				["Critical Strike Rating"] = "CR_CRIT",
				["\195\173ndice de esquivar"] = "CR_DODGE",
				["Parry Rating"] = "CR_PARRY",
				["Spell Critical Strike Rating"] = "CR_SPELLCRIT",
				["Spell Critical Rating"] = "CR_SPELLCRIT",
				["Spell Crit Rating"] = "CR_SPELLCRIT",
				["Spell Hit Rating"] = "CR_SPELLHIT",
				["Mana every 5 Sec"] = "MANAREG",
				["Mana per 5 Seconds"] = "MANAREG",
				["Mana every 5 seconds"] = "MANAREG",
				["Mana Per 5 sec"] = "MANAREG",
				["mana per 5 sec"] = "MANAREG",
				["mana every 5 sec"] = "MANAREG",
				["Mana Regen"] = "MANAREG",
				["Melee Damage"] = "MELEEDMG",
				["Weapon Damage"] = "MELEEDMG",
				["Resist All"] = ALL_RESISTS,
				["Reduced Threat"] = "THREATREDUCTION",
				["Two-Handed Axe Skill Rating"] = "CR_WEAPON_AXE_2H",
				["Stun Resistance"] = "STUNRESIST",
			},

			PATTERNS_GENERIC_STAGE1 = {
				{ pattern = "Arcano", 		effect = "ARCANE" },
				{ pattern = "Fuego", 		effect = "FIRE" },
				{ pattern = "Escarcha", 	effect = "FROST" },
				{ pattern = "Sagrado", 		effect = "HOLY" },
				{ pattern = "Sombras",		effect = "SHADOW" },
				{ pattern = "Naturaleza", 	effect = "NATURE" }
			},

			PATTERNS_GENERIC_STAGE2 = {
				{ pattern = "Resistencia", 	effect = "RES" },
				{ pattern = "Da\195\177o", 	effect = "DMG" },
				{ pattern = "Efectos", 		effect = "DMG" },
			},

			PATTERNS_OTHER = {
				{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR_BONUS" },
				{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },

				{ pattern = "Minor Wizard Oil", effect = HEAL_AND_DMG, value = 8 },
				{ pattern = "Lesser Wizard Oil", effect = HEAL_AND_DMG, value = 16 },
				{ pattern = "Wizard Oil", effect = HEAL_AND_DMG, value = 24 },
				{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

				{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
				{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
				{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

				{ pattern = "Eternium Line", effect = "FISHING", value = 5 },
				{ pattern = "Vitality", effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} },
				{ pattern = "Soulfrost", effect = {"FROSTDMG", "SHADOWDMG"}, value = {54, 54} },
				{ pattern = "Sunfire", effect = {"ARCANEDMG", "FIREDMG"}, value = {50, 50} },
				{ pattern = "Savagery", effect = "ATTACKPOWER", value = 70 },
				{ pattern = "Surefooted", effect = {"CR_HIT", "SNARERES"}, value = {10, 5} },
				{ pattern = "Increases defense rating by 5, Shadow resistance by 10 and your normal health regeneration by 3%.", effect = {"CR_DEFENSE", "SHADOWRES", "HEALTHREG_P"}, value = {5, 10, 3} },
				{ pattern = "%+2%% Threat", effect = "THREATREDUCTION", value = -2 },
				{ pattern = "Subtlety", effect = "THREATREDUCTION", value = 2 },

				{ pattern = "Allows underwater breathing%.", effect = "UNDERWATER", value = 1 }, -- 10506
				{ pattern = "Increases your lockpicking skill slightly%.", effect = "LOCKPICK", value = 1 },
				{ pattern = "Moderately increases your stealth detection%.", effect = "STEALTHDETECT", value = 18 }, -- 10501
				{ pattern = "Slightly increases your stealth detection%.", effect = "STEALTHDETECT", value = 10 }, -- 22863, 23280, 31333
				{ pattern = "Immune to Disarm%.", effect = "DISARMIMMUNE", value = 1 }, -- 12639
				{ pattern = "Minor increase to running and swimming speed%.", effect = {"RUNSPEED", "SWIMSPEED"}, value = {8,8} }, -- 19685
				{ pattern = "Reduces damage from falling%.", effect = "SLOWFALL", value = 1 }, -- 19982
				{ pattern = "Increases movement speed and life regeneration rate%.", effect = {"RUNSPEED", "HEALTHREG"}, value = {8,20} }, -- 13505
				{ pattern = "Run speed increased slightly%.", effect = "RUNSPEED", value = 8 }, -- 20048, 25835, 29512
				{ pattern = "Increases your stealth slightly%.", effect = "STEALTH", value = 3 }, -- 21758
				{ pattern = "Increases your effective stealth level%.", effect = "STEALTH", value = 8 }, -- 22003, 23073
				{ pattern = "Increases damage and healing done by magical spells and effects slightly%.", effect = HEAL_AND_DMG, value = 6 }, -- 30804

--				{ pattern = "Impress others with your fashion sense%.", effect = "IMPRESS", value = 1 }, -- 10036
--				{ pattern = "Increases your Mojo%.", effect = "MOJO", value = 1 }, -- 23717
			},
		}
	else
		ItemBonusLib:Print("ItemBonusLib does not support your locale.")
	end
end

if L then -- postprocessing of patterns
	table.insert(L.PATTERNS_OTHER, { pattern = EMPTY_SOCKET_BLUE, effect = "EMPTY_SOCKET_BLUE", value = 1})
	table.insert(L.PATTERNS_OTHER, { pattern = EMPTY_SOCKET_META, effect = "EMPTY_SOCKET_META", value = 1})
	table.insert(L.PATTERNS_OTHER, { pattern = EMPTY_SOCKET_RED, effect = "EMPTY_SOCKET_RED", value = 1})
	table.insert(L.PATTERNS_OTHER, { pattern = EMPTY_SOCKET_YELLOW, effect = "EMPTY_SOCKET_YELLOW", value = 1})
	
	do
		local tmp = L.HEAL_AND_DMG_PATTERNS
		if next(tmp) then
			local r = {}
			for pattern, invert in pairs(tmp) do
				r["^" .. pattern .. "$"] = invert
			end
			L.HEAL_AND_DMG_PATTERNS = r
		end
	end

	for _, p in ipairs(L.PATTERNS_PASSIVE) do
		if not p.nofinish then
			p.pattern = "^" .. p.pattern .. "$"
		else
			p.pattern = "^" .. p.pattern
			p.nofinish = nil
		end
		assert(p.effect)
	end
	for _, p in ipairs(L.PATTERNS_SKILL_RATING) do
		p.pattern = "^" .. p.pattern .. "$"
	end
	local t = {}
	for k, v in pairs(L.PATTERNS_GENERIC_LOOKUP) do
		local lk = k:lower()
		if t[lk] then
			assert(t[lk] == v)
		else
			t[lk] = v
		end
	end
	L.PATTERNS_GENERIC_LOOKUP = t
	for _, p in ipairs(L.PATTERNS_OTHER) do
		assert(p.pattern)
		if not p.nofinish then
			p.pattern = "^" .. p.pattern .. "$"
		else
			p.pattern = "^" .. p.pattern
			p.nofinish = nil
		end
		assert(p.effect)
	end

	local bonus_names = {
		WEAPON_MIN = true,
		WEAPON_MAX = true,
		WEAPON_SPEED = true,
	}
	local function add_bonus_names(e)
		if type(e) == "table" then
			for _, b in ipairs(e) do
				add_bonus_names(b)
			end
		else
			bonus_names[e] = true
		end
	end
	for _, v in pairs(L.SKILL_NAMES) do
		add_bonus_names(v)
	end
	for _, v in ipairs(L.PATTERNS_PASSIVE) do
		add_bonus_names(v.effect)
	end
	for _, e in pairs(L.PATTERNS_GENERIC_LOOKUP) do
		add_bonus_names(e)
	end
	for _, v in ipairs(L.PATTERNS_GENERIC_STAGE1) do
		for _, v2 in ipairs(L.PATTERNS_GENERIC_STAGE2) do
			add_bonus_names(v.effect..v2.effect)
		end
	end
	for _, v in ipairs(L.PATTERNS_OTHER) do
		add_bonus_names(v.effect)
	end
	local names = {}
	for n in pairs(bonus_names) do
		names[#names + 1] = n
	end
	table.sort(names)

	function ItemBonusLib:IsValidName(name)
		return bonus_names[name]
	end

	function ItemBonusLib:GetNameList()
		return names
	end
else
	function ItemBonusLib:IsValidName(name)
	end

	local empty = {}
	function ItemBonusLib:GetNameList()
		return empty
	end
end

AceLibrary:Register(ItemBonusLib, MAJOR_VERSION, MINOR_VERSION)
ItemBonusLib = AceLibrary("ItemBonusLib-1.0")

