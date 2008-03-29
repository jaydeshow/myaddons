local deformat = AceLibrary("Deformat-2.0")
local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_FactionsFu")

local _G = getfenv(0)

local select			= _G.select

local table_insert		= _G.table.insert
local table_remove		= _G.table.remove
local table_sort		= _G.table.sort

local GetFactionInfo = GetFactionInfo

local gender = UnitSex("player")

FuBar_FactionsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0")
local FuBar_FactionsFu = FuBar_FactionsFu
FuBar_FactionsFu.revision = tonumber(string.sub("$Revision: 62954 $", 12, -3)) or 1

FuBar_FactionsFu.hasIcon = "Interface\\Icons\\Spell_Holy_SealOfSalvation"
FuBar_FactionsFu.canHideText = true
FuBar_FactionsFu.clickableTooltip = true
FuBar_FactionsFu:RegisterDB("FuBar_FactionsFuDB")
FuBar_FactionsFu:RegisterDefaults("profile", {
	text = {
		show_name = true,
		show_standing = true,
		show_progress = true,
		show_percent = true,
	},
	color = {
		name = "ATWAR",
		standing = "DEFAULT",
		reputation = "INC",
	},
	other = {
		autozone = true,
		autogain = false,
	},
	AutoZoneFaction = {
	},
})
FuBar_FactionsFu:RegisterDefaults("char", {
	collapsed = {},
})

FuBar_FactionsFu.SessionChangesBase = {}

function FuBar_FactionsFu:OnInitialize()
	self.factions = {}
end

function FuBar_FactionsFu:OnEnable()
	self:RegisterBucketEvent("UPDATE_FACTION", 1)

	self:RegisterEvent("ZONE_CHANGED", "ZoneUpdate")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "ZoneUpdate")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneUpdate")
	self:RegisterEvent("MINIMAP_ZONE_CHANGED", "ZoneUpdate")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZoneUpdate")

--	self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")

	self:SecureHook("SetWatchedFactionIndex", "Hook_SetWatchedFactionIndex")
	self:SecureHook("CollapseFactionHeader", "Hook_CollapseFactionHeader")
	self:SecureHook("ExpandFactionHeader", "Hook_ExpandFactionHeader")

	self:Update()
end

-- function FuBar_FactionsFu:OnDisable()
-- end

local tablecache = {}
local function recyclefactiontable(t)
	while #t > 0 do
		table_insert(tablecache, table_remove(t))
	end
	return t
end
local function getfactiontable(...)
	local t
	if #tablecache > 0 then
		t = table_remove(tablecache)
	else
		t = {}
	end
	for i = 1, select('#', ...), 2 do
		t[select(i, ...)] = select(i + 1, ...)
	end
	return t
end

local collapsids = {}
function FuBar_FactionsFu:OnDataUpdate()
	local factions = recyclefactiontable(self.factions)

	local header = UNKNOWN
	
	local numFactions = GetNumFactions()
	local factionIndex, factionName, factionCheck, factionStanding, factionBar, factionHeader, color, tooltipStanding
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched
	local atWarIndicator, rightBarTexture

	self.watched = nil
	self.watchedid = 0

	local collapsedheaders = self.db.char.collapsed

	for i=1, numFactions do
		name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(i)
		if ( isHeader ) then
			header = name
			table_insert(self.factions, getfactiontable("name", header, "isHeader", true, "isCollapsed", isCollapsed))
			if collapsedheaders[header] and not isCollapsed then
--				self:Print("Loop 1:", i, name, isHeader, isCollapsed)
				table_insert(collapsids, i)
			end
		else
			if header ~= UNKNOWN then
				-- Normalize values
				table_insert(factions, getfactiontable("name", name, "isHeader", false, "standing", standingID, "repIs", barValue - barMin, "repMax", barMax - barMin, "repAbs", barValue, "atWarWith", atWarWith, "canToggleAtWar", canToggleAtWar, "isWatched", isWatched))
				if not self.SessionChangesBase[name] then self.SessionChangesBase[name] = barValue end
				if isWatched then
					self.watched = name
					self.watchedid = i
				end
			end
		end
	end
	self.factions = factions
	table_sort(collapsids)
	for i = #collapsids, 1, -1 do
		local id = collapsids[i]
		local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(id)
--		self:Print("Loop 2:", id, name, isHeader, isCollapsed)
		if isHeader then
			CollapseFactionHeader(id)
		end
		collapsids[i] = nil
	end
end

function FuBar_FactionsFu:OnTextUpdate()
	if self.watched then
		local text = ""
		local factiondata = self.factions[self.watchedid]
		if self.db.profile.text.show_name then
			text = select(4, self:GetColor_ATWAR(factiondata.atWarWith, factiondata.canToggleAtWar, self.db.profile.color.name))..self.watched.."|r"
			if self.db.profile.text.show_standing or self.db.profile.text.show_progress or self.db.profile.text.show_percent then
				text = text.."|cffffffff: |r"
			end
		end
		local standinghex = select(4, self:GetColor_standing(factiondata.standing, self.db.profile.color.standing))
		local rephex = select(4, self:GetColor_standing(factiondata.standing, self.db.profile.color.reputation))
		if self.db.profile.text.show_standing and self.db.profile.text.show_progress and self.db.profile.text.show_percent then
			text = text..("%s%s|r|cffffffff - |r%s%d/%d (%.1f%%)|r"):format(standinghex, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender), rephex, factiondata.repIs, factiondata.repMax, factiondata.repIs / factiondata.repMax * 100)
		elseif self.db.profile.text.show_standing and self.db.profile.text.show_progress and not self.db.profile.text.show_percent then
			text = text..("%s%s|r|cffffffff - |r%s%d/%d|r"):format(standinghex, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender), rephex, factiondata.repIs, factiondata.repMax)
		elseif self.db.profile.text.show_standing and not self.db.profile.text.show_progress and self.db.profile.text.show_percent then
			text = text..("%s%s|r|cffffffff - |r%s%.1f%%|r"):format(standinghex, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender), rephex, factiondata.repIs / factiondata.repMax * 100)
		elseif self.db.profile.text.show_standing and not self.db.profile.text.show_progress and not self.db.profile.text.show_percent then
			text = text..("%s%s|r"):format(standinghex, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender))
		elseif not self.db.profile.text.show_standing and self.db.profile.text.show_progress and self.db.profile.text.show_percent then
			text = text..("%s%d/%d (%.1f%%)|r"):format(rephex, factiondata.repIs, factiondata.repMax, factiondata.repIs / factiondata.repMax * 100)
		elseif not self.db.profile.text.show_standing and self.db.profile.text.show_progress and not self.db.profile.text.show_percent then
			text = text..("%s%d/%d|r"):format(rephex, factiondata.repIs, factiondata.repMax)
		elseif not self.db.profile.text.show_standing and not self.db.profile.text.show_progress and self.db.profile.text.show_percent then
			text = text..("%s%.1f%%|r"):format(rephex, factiondata.repIs / factiondata.repMax * 100)
		end
		self:SetText(text)
	else
		self:SetText("|cffffffffFactions|cff00ff00Fu|r")
	end
end

function FuBar_FactionsFu:OnTooltipUpdate()
	local cat
	local curZone = GetZoneText()
	local supercat = tablet:AddCategory(
		'columns', 5
	)
	local header = UNKNOWN
	for i, factiondata in ipairs(self.factions) do
		if factiondata.isHeader then
			header = factiondata.name
			cat = supercat:AddCategory(
				'text', header,
				'columns', 5,
				'hideBlankLine', true,
				'showWithoutChildren', true,
				'hasCheck', true,
				'checked', true,
				'checkIcon', factiondata.isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
				'func', 'OnClickGroup',
				'arg1', self,
				'arg2', i
			)
		else
			local faction_name = factiondata.name
			local warcolorR, warcolorG, warcolorB = self:GetColor_ATWAR(factiondata.atWarWith, factiondata.canToggleAtWar, self.db.profile.color.name)
			local standingcolorR, standingcolorG, standingcolorB = self:GetColor_standing(factiondata.standing, self.db.profile.color.standing)
			local repcolorR, repcolorG, repcolorB = self:GetColor_standing(factiondata.standing, self.db.profile.color.reputation)
			local sessionChange = self.SessionChangesBase[faction_name] and factiondata.repAbs - self.SessionChangesBase[faction_name] or 0
			cat:AddLine(
				'text', faction_name,
				'textR', warcolorR,
				'textG', warcolorG,
				'textB', warcolorB,
				'text2', GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender),
				'text2R', standingcolorR,
				'text2G', standingcolorG,
				'text2B', standingcolorB,
				'text3', ("%5d / %5d"):format(factiondata.repIs, factiondata.repMax),
				'text3R', repcolorR,
				'text3G', repcolorG,
				'text3B', repcolorB,
				'text4', ("%.1f%%"):format(factiondata.repIs / factiondata.repMax * 100),
				'text4R', repcolorR,
				'text4G', repcolorG,
				'text4B', repcolorB,
				'justify4', "RIGHT",
				'text5',  sessionChange > 0 and "+"..sessionChange or sessionChange < 0 and sessionChange or "-",
				'text5R', sessionChange > 0 and 0 or 1,
				'text5G', sessionChange < 0 and 0 or 1,
				'text5B', sessionChange ~= 0 and 0 or 1,
				'justify5', "RIGHT",
				'hasCheck', true,
				'checked', factiondata.isWatched or faction_name == self.db.profile.AutoZoneFaction[curZone] or faction_name == self.db.char.lastFaction,
--				'checkIcon', (faction_name == self.db.profile.AutoZoneFaction[curZone] and "Spell_Holy_MagicalSentry") or "Interface\\Buttons\\UI-RadioButton",
				'func', 'OnClickFaction',
				'arg1', self,
				'arg2', i,
				'arg3', header,
				(faction_name == self.db.profile.AutoZoneFaction[curZone] and 'checkIcon') or nil, (faction_name == self.db.profile.AutoZoneFaction[curZone] and "Interface\\Icons\\Ability_Hunter_SniperShot")
			)
		end
	end
	tablet:SetHint(L["TOOLTIP_HINT"])
end

function FuBar_FactionsFu:OnClick()
	if IsShiftKeyDown() then
		local factiondata = self.factions[self.watchedid]
		if ( ChatFrameEditBox:IsVisible() ) then
			local gender = UnitSex("player")
			ChatFrameEditBox:Insert(("%s: %s - %d/%d (%.1f%%)"):format(factiondata.name, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender), factiondata.repIs, factiondata.repMax, factiondata.repIs / factiondata.repMax * 100))
		end
	else
		ToggleCharacter("ReputationFrame")
	end
end

function FuBar_FactionsFu:UPDATE_FACTION()
	self:Update()
end

function FuBar_FactionsFu:OnClickGroup(id)
	if (self.factions[id].isCollapsed) then
		ExpandFactionHeader(id)
	else
		CollapseFactionHeader(id)
	end
	self:Update()
end

function FuBar_FactionsFu:OnClickFaction(id, header)
	local factiondata = self.factions[id]
	if IsShiftKeyDown() then
		if ( ChatFrameEditBox:IsVisible() ) then
			local gender = UnitSex("player")
			ChatFrameEditBox:Insert(("%s: %s - %d/%d (%.1f%%)"):format(factiondata.name, GetText("FACTION_STANDING_LABEL"..factiondata.standing, gender), factiondata.repIs, factiondata.repMax, factiondata.repIs / factiondata.repMax * 100))
		end
		return
	elseif IsAltKeyDown() then
		local curZone = GetZoneText()
		if self.db.profile.AutoZoneFaction[curZone] and self.db.profile.AutoZoneFaction[curZone] == factiondata.name then
			self.db.profile.AutoZoneFaction[curZone] = nil
		else
			self.db.profile.AutoZoneFaction[curZone] = factiondata.name
		end
		self:SetAutoFaction(curZone)
	elseif IsControlKeyDown() then
		if ( header == FACTION_INACTIVE ) then
			SetFactionActive(id)
		else
			SetFactionInactive(id)
		end
	else
		if ( factiondata.isWatched ) then
			PlaySound("igMainMenuOptionCheckBoxOff")
			SetWatchedFactionIndex(0)
		else
			PlaySound("igMainMenuOptionCheckBoxOn")
			SetWatchedFactionIndex(id)
		end
	end
	self:Update()
end

function FuBar_FactionsFu:GetColor_ATWAR(atwar, canwar, type)
	if type == "ATWAR" then
		local r = atwar and 1 or canwar and 1 or 0
		local g = atwar and 0 or canwar and 1 or 1
		local b = atwar and 0 or canwar and 0 or 0
		return r, g, b, ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end
	return 1, 1, 1, "|cffffff00"
end

local INC_COLORS = {
	[1] = {r = 0.55, g = 0, b = 0},			-- hated
	[2] = {r = 1, g = 0, b = 0},			-- hostile
	[3] = {r = 1, g = 0.55, b = 0},			-- unfriendly
	[4] = {r = 0.75, g = 0.75, b = 0.75},	-- neutral
	[5] = {r = 1, g = 1, b = 1},			-- friendly
	[6] = {r = 0, g = 1, b = 0},			-- honored
	[7] = {r = 0.25, g = 0.4, b = 0.9},		-- reverted
	[8] = {r = 0.6, g = 0.2, b = 0.8},		-- exalted
}

function FuBar_FactionsFu:GetColor_standing(standing, type)
	if type == "DEFAULT" then
		local color = FACTION_BAR_COLORS[standing]
		return color.r, color.g, color.b, ("|cff%02x%02x%02x"):format(color.r * 255, color.g * 255, color.b * 255)
	end
	if type == "INC" then
		local color = INC_COLORS[standing]
		return color.r, color.g, color.b, ("|cff%02x%02x%02x"):format(color.r * 255, color.g * 255, color.b * 255)
	end
	return 1, 1, 1, "|cffffff00"
end

function FuBar_FactionsFu:ZoneUpdate()
	local curZone = GetZoneText()
	if self.lastZone ~= curZone then
		self:SetAutoFaction(curZone)
		self.lastZone = curZone
	end
end

function FuBar_FactionsFu:SetAutoFaction(zone)
	if not self.db.profile.other.autozone then return end
	-- is there a auto-faction set for the current zone?
	if self.db.profile.AutoZoneFaction[zone] then
		-- if lastFaction is set, last zone had autofaction, too
		-- if not we have to store the current watched faction
		if self.db.char.lastFaction == nil then
			self.db.char.lastFaction = self.watched or false
		end
		self.SettingAutoFaction = true
		self:SetWatchedFactionName(self.db.profile.AutoZoneFaction[zone])
	-- no auto-faction set so restore last faction if set
	elseif self.db.char.lastFaction ~= nil then
		self.SettingAutoFaction = true
		self:SetWatchedFactionName(self.db.char.lastFaction)
		self.db.char.lastFaction = nil
	end
end

function FuBar_FactionsFu:SetWatchedFactionName(name)
--	self:Print("SetWatchedFactionName(", name, ") called...")
	if name == false then
		SetWatchedFactionIndex(0)
		return
	end
	local i = 0
	local lname
	local lnextname = GetFactionInfo(i + 1)
	repeat
		i = i + 1
		lname = lnextname
		lnextname = GetFactionInfo(i + 1)
		if lname == name then
			SetWatchedFactionIndex(i)
			return
		end
	until (lname == "" and lnextname == "") or i > 500
end

function FuBar_FactionsFu:Hook_SetWatchedFactionIndex(id)
--	self:Print("SetWatchedFactionIndex(", id, ") called...")
	if not self.SettingAutoFaction then
		self.db.char.lastFaction = nil
		if not id or id <= 0 then
			local curZone = GetZoneText()
			if self.db.profile.AutoZoneFaction[cuZone] then
				self:SetAutoFaction(curZone)
			end
		end
	end
	self.SettingAutoFaction = nil
end

function FuBar_FactionsFu:Hook_CollapseFactionHeader(id)
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(id)
--	self:Print("CollapseFactionHeader:", id, name, isHeader, isCollapsed)
	if not (name and isHeader) then return end
	self.db.char.collapsed[name] = true
end

function FuBar_FactionsFu:Hook_ExpandFactionHeader(id)
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(id)
--	self:Print("ExpandFactionHeader:", id, name, isHeader, isCollapsed)
	if not name then return end
	self.db.char.collapsed[name] = nil
end

function FuBar_FactionsFu:CHAT_MSG_COMBAT_FACTION_CHANGE()
	local faction, change
--	self:Print("FACTION_STANDING_CHANGED:", deformat(arg1, FACTION_STANDING_CHANGED))
--	self:Print("FACTION_STANDING_INCREASED", deformat(arg1, FACTION_STANDING_INCREASED))
--	self:Print("FACTION_STANDING_DECREASED", deformat(arg1, FACTION_STANDING_DECREASED))
	faction, change = deformat(arg1, FACTION_STANDING_INCREASED)
	if faction and change then
		self.SessionChanges[faction] = (self.SessionChanges[faction] or 0) + change
	else
		faction, change = deformat(arg1, FACTION_STANDING_DECREASED)
		if faction and change then
			self.SessionChanges[faction] = (self.SessionChanges[faction] or 0) - change
		end
	end
	self:UpdateTooltip()
end
