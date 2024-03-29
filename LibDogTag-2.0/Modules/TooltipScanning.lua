﻿local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local tt = CreateFrame("GameTooltip")
tt:SetOwner(UIParent, "ANCHOR_NONE")
tt.left = {}
tt.right = {}
for i=1,30 do
	tt.left[i] = tt:CreateFontString()
	tt.left[i]:SetFontObject(GameFontNormal)
	tt.right[i] = tt:CreateFontString()
	tt.right[i]:SetFontObject(GameFontNormal)
	tt:AddFontStrings(tt.left[i], tt.right[i])
end
local nextTime = 0
local lastName
local lastUnit
local function updateTT(unit)
	local name = UnitName(unit)
	local time = GetTime()
	if lastUnit == unit and lastName == name and nextTime < time then
		return
	end
	lastUnit = unit
	lastName = name
	nextTime = time + 1
	tt:ClearLines()
	tt:SetUnit(unit)
	if not tt:IsOwned(UIParent) then
		tt:SetOwner(UIParent, "ANCHOR_NONE")
	end
end

local LEVEL_start = "^" .. (type(LEVEL) == "string" and LEVEL or "Level")
local function FigureNPCGuild(unit)
	updateTT(unit)
	local left_2 = tt.left[2]:GetText()
	if not left_2 or left_2:find(LEVEL_start) then
		return nil
	end
	return left_2
end
DogTag:AddFakeGlobal("FigureNPCGuild", FigureNPCGuild)

local factionList = {}

local PVP = type(PVP) == "string" and PVP or "PvP"
local function FigureFaction(unit)
	local _, faction = UnitFactionGroup(unit)
	if UnitPlayerControlled(unit) or UnitIsPlayer(unit) then
		return faction
	end

	updateTT(unit)
	local left_2 = tt.left[2]:GetText()
	local left_3 = tt.left[3]:GetText()
	if not left_2 or not left_3 then
		return faction
	end
	local hasGuild = not left_2:find(LEVEL_start)
	local factionText = not hasGuild and left_3 or tt.left[4]:GetText()
	if factionText == PVP then
		return faction
	end
	if factionList[factionText] or faction then
		return factionText
	end
end
DogTag:AddFakeGlobal("FigureFaction", FigureFaction)

local function FigureZone(unit)
	if UnitIsVisible(unit) then
		return nil
	end
	if not UnitIsConnected(unit) then
		return nil
	end
	updateTT(unit)
	local left_2 = tt.left[2]:GetText()
	local left_3 = tt.left[3]:GetText()
	if not left_2 or not left_3 then
		return nil
	end
	local hasGuild = not left_2:find(LEVEL_start)
	local factionText = not hasGuild and left_3 or tt.left[4]:GetText()
	if factionText == PVP then
		factionText = nil
	end
	local hasFaction = factionText and not UnitPlayerControlled(unit) and not UnitIsPlayer(unit) and (UnitFactionGroup(unit) or factionList[factionText])
	if hasGuild and hasFaction then
		return tt.left[5]:GetText()
	elseif hasGuild or hasFaction then
		return tt.left[4]:GetText()
	else
		return left_3
	end
end
DogTag:AddFakeGlobal("FigureZone", FigureZone)

local function UPDATE_FACTION()
	for i = 1, GetNumFactions() do
		local name = GetFactionInfo(i)
		factionList[name] = true
	end
end
DogTag:AddEventHandler("UPDATE_FACTION", UPDATE_FACTION)
DogTag:AddEventHandler("PLAYER_LOGIN", UPDATE_FACTION)

DogTag:AddTag("Guild", {
	[[if UnitIsPlayer(${unit}) then
		value = GetGuildInfo(${unit})
	else
		value = DogTag___FigureNPCGuild(${unit})
	end]],
	ret = "string;nil",
	globals = "GetGuildInfo;UnitIsPlayer;DogTag.__FigureNPCGuild",
	doc = L["Return the guild name or title of unit"],
	example = ('[Guild] => %q; [Guild] => %q; [Guild] => %q'):format(L["My Little Pwnies"], L["Banker"],
	_G.UNITNAME_TITLE_PET:format("Grommash")),
	category = L["Characteristics"]
})

DogTag:AddTag("Owner", {
	([[if not UnitIsPlayer(${unit}) and UnitPlayerControlled(${unit}) then
		local guild = DogTag___FigureNPCGuild(${unit})
		if guild then
			value = guild:match(%q) or guild:match(%q) or guild:match(%q) or guild:match(%q) or guild:match(%q) or guild:match(%q)
		end
	end]]):format(_G.UNITNAME_TITLE_CHARM:gsub("%%s", "(.+)"), _G.UNITNAME_TITLE_COMPANION:gsub("%%s", "(.+)"), _G.UNITNAME_TITLE_CREATION:gsub("%%s", "(.+)"), _G.UNITNAME_TITLE_GUARDIAN:gsub("%%s", "(.+)"), _G.UNITNAME_TITLE_MINION:gsub("%%s", "(.+)"), (_G.UNITNAME_TITLE_PET:gsub("%%s", "(.+)"))),
	ret = "string;nil",
	globals = "DogTag.__FigureNPCGuild;UnitIsPlayer;UnitPlayerControlled",
	doc = L["Return the owner of unit, if a pet"],
	example = ('[Owner] => %q'):format(L["Grommash"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Faction", {
	[[value = DogTag___FigureFaction(${unit})]],
	ret = "string;nil",
	globals = "DogTag.__FigureFaction",
	doc = L["Return the faction of unit"],
	example = ('[Faction] => %q; [Faction] => %q'):format(L["Alliance"], L["Aldor"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Zone", {
	[[value = DogTag___FigureZone(${unit})]],
	ret = "string;nil",
	globals = "DogTag.__FigureZone",
	events = "SlowUpdate",
	doc = L["Return the zone of unit"],
	example = ('[Zone] => %q'):format(L["Shattrath"]),
	category = L["Status"]
})

end