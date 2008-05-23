local lib = LibStub:NewLibrary("LibGUIDRegistry-0.2", 1)

if not lib then
	return
end

local select	= select
local bit_band	= bit.band
local bit_bor	= bit.bor
local UnitGUID	= UnitGUID
local UnitName	= UnitName
local UnitClass	= UnitClass
local UnitRace	= UnitRace
local UnitLevel	= UnitLevel
local UnitSex	= UnitSex
local UnitFactionGroup	= UnitFactionGroup
local UnitCreatureType	= UnitCreatureType
local UnitCreatureFamily	= UnitCreatureFamily
local UnitClassification	= UnitClassification
local UnitPlayerControlled  = UnitPlayerControlled
local UnitIsPlayer			= UnitIsPlayer
local UnitExists	= UnitExists

lib.update	= lib.update or {}
lib.units	= lib.units	or {}
lib.reg		= lib.reg	or {}
lib.names	= lib.names	or {}
lib.guardians	= lib.guardians or {}
lib.callbacks	= lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

local update = lib.update -- save a dereference
local units = lib.units
local reg = lib.reg
local names = lib.names
local guardians = lib.guardians

local function OnEvent(self, event, ...)
	lib[event](lib, ...)
end
lib.frame	= lib.frame or CreateFrame("Frame")
lib.tooltip	= lib.tooltip or CreateFrame("GameTooltip")
lib.tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
local tooltip = lib.tooltip

lib.frame:UnregisterAllEvents()
lib.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lib.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
lib.frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
lib.frame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
lib.frame:RegisterEvent("UNIT_LEVEL")
lib.frame:RegisterEvent("UNIT_NAME_UPDATE")
lib.frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
lib.frame:SetScript("OnEvent", OnEvent)

function lib:COMBAT_LOG_EVENT_UNFILTERED(timestamp, type, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	lib:ProcessActor(srcGUID, srcName, srcFlags)
	lib:ProcessActor(dstGUID, dstName, dstFlags)
	lib.callbacks:Fire("COMBAT_LOG_EVENT_UNFILTERED", timestamp, type, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
end

local function processUnit(unitID, GUID)
	reg[GUID] = reg[GUID] or {}
	reg[GUID].name	= UnitName(unitID)
	reg[GUID].class	= select(2, UnitClass(unitID))
	reg[GUID].race	= select(2, UnitRace(unitID))
	reg[GUID].level	= UnitLevel(unitID)
	reg[GUID].sex	= UnitSex(unitID)
	reg[GUID].faction	= UnitFactionGroup(unitID)
	reg[GUID].creaturetype	= UnitCreatureType(unitID)
	reg[GUID].creaturefamily	= UnitCreatureFamily(unitID)
	reg[GUID].classification	= UnitClassification(unitID)
end

function lib:ProcessActor(GUID, name, flags)
	tooltip:SetHyperLink("unit:"..GUID)
	
	if (not reg[GUID] or not reg[GUID].name) and not names[GUID] then
		names[GUID] = name
	end
end

function lib:PLAYER_TARGET_CHANGED()
	if UnitExists("target")
		processUnit("target", UnitGUID("target"))
	end
end
function lib:PLAYER_FOCUS_CHANGED()
	if UnitExists("focus")
		processUnit("focus", UnitGUID("focus"))
	end
end

local function FlagForUpdate(self, unitID, ...)
	processUnit(unitID, UnitGUID(unitID))
end
lib.UNIT_CLASSIFICATION_CHANGED = FlagForUpdate
lib.UNIT_LEVEL = FlagForUpdate
lib.UNIT_NAME_UPDATE = FlagForUpdate
lib.UPDATE_MOUSEOVER_UNIT = function (self, ...)
	if UnitExists("mouseover")
		processUnit("mouseover", UnitGUID("mouseover"))
	end
end

function lib:GetNPCID(GUID)
	return tonumber(GUID:sub(-12,-7),16)
end

function lib:GetName(GUID)
	return reg[GUID] and reg[GUID].name or names[GUID] or nil
end

function lib:GetClass(GUID)
	return reg[GUID] and reg[GUID].class or nil
end

function lib:GetRace(GUID)
	return reg[GUID] and reg[GUID].race or nil
end

function lib:GetLevel(GUID)
	return reg[GUID] and reg[GUID].level or nil
end

function lib:GetClassification(GUID)
	return reg[GUID] and reg[GUID].classification or nil
end

function lib:GetCreatureType(GUID)
	return reg[GUID] and reg[GUID].creaturetype or nil
end

function lib:GetCreatureFamily(GUID)
	return reg[GUID] and reg[GUID].creaturefamily or nil
end

function lib:GetFaction(GUID)
	return reg[GUID] and reg[GUID].faction or nil
end

function lib:GetSex(GUID)
	return reg[GUID] and reg[GUID].sex or nil
end

local function OnTooltipSetUnit(self, ...)
	local _, unitID = self:GetUnit()
	if unitID then
		processUnit(unitID, UnitGUID(unitID))
	end
end
lib.tooltip:SetScript("OnTooltipSetUnit", OnTooltipSetUnit)

LibGUIDRegistry-0.2_ref = lib
