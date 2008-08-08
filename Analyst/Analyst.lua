--[[

$Revision: 74273 $

(C) Copyright 2007,2008 Bethink (bethink at naef dot com)

This file is part of Analyst.

Analyst is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Analyst is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Leser General Public License
along with Analyst. If not, see <http://www.gnu.org/licenses/>.

]]


----------------------------------------------------------------------
-- Acquire libraries and declare add-on

local L = AceLibrary("AceLocale-2.2"):new("Analyst")
Analyst = AceLibrary("AceAddon-2.0"):new(
	"AceConsole-2.0",
	"AceDB-2.0",
	"AceDebug-2.0",
	"AceEvent-2.0",
	"AceHook-2.1",
	"FuBarPlugin-2.0")

	
----------------------------------------------------------------------
-- Constants

-- Chat options
local ACE_OPTS = {
	type = "group",
	args = {
		economy = {
			type = "toggle",
			name = L["ECONOMY"],
			desc = L["ECONOMY_DESC"],
			get = "IsEconomyFrameShown",
			set = "ToggleEconomyFrame"
		},
		startDayOfWeek = {
			type = "range",
			name = L["START_DAY_OF_WEEK"],
			desc = L["START_DAY_OF_WEEK_DESC"],
			min = 1,
			max = 7,
			step = 1,
			get = "GetStartDayOfWeek",
			set = "SetStartDayOfWeek"
		},
		showGold = {
			type = "toggle",
			name = L["SHOW_GOLD"],
			desc = L["SHOW_GOLD_DESC"],
			get = "GetShowGold",
			set = "SetShowGold"
		}
	}
}

-- Database version
ANALYST_DATABASE_VERSION = 1

-- Data lifetime
ANALYST_DATA_LIFETIME = 30

-- Bindings
BINDING_HEADER_ANALYST = L["BINDING_HEADER_ANALYST"]
BINDING_NAME_ECONOMY = L["BINDING_NAME_ECONOMY"]


----------------------------------------------------------------------
-- Core handlers

-- One-time initialization
function Analyst:OnInitialize()
	-- Registrations
	self:RegisterDB("AnalystDB")
	self:RegisterChatCommand(L["SLASH_COMMANDS"], ACE_OPTS)

	-- Initialize debuggign
	self:SetDebugging(false)
	self:SetDebugLevel(2)
	
	-- Uncomment below for debugging from the start
	--self:SetDebugging(true)
		
	-- Uncomment below for verbose debugging
	--self:SetDebugLevel(3)

	-- Defaults
	self:RegisterDefaults("profile", {
		startDayOfWeek = 1,
		showGold = true
	})
	
	-- Database version
	if AnalystDBPerChar then
		if AnalystDBPerChar["global"] then
			for k, v in pairs(AnalystDBPerChar["global"]) do
				self.db.char[k] = v
			end
			AnalystDBPerChar["global"] = nil
		end
	end
	self.db.account.databaseVersion = DATABASE_VERSION
	
	-- FuBar
	self.hasIcon = true
	self:SetIcon("Interface\\Icons\\INV_Misc_Spyglass_03.blp")
	self.OnMenuRequest = ACE_OPTS
	
	-- Subsystems
	self:InitializeCapture()
	self:InitializeMeasure()
	self:InitializeVendorValue()
	self:InitializeEconomyFrame()
end

-- Handles (re-)enabling of the addon
function Analyst:OnEnable ()
	-- Subsystems
	self:EnableCapture()
	self:EnableMeasure()
	self:EnableVendorValue()
	self:EnableEconomyFrame()
end

-- Handles disabling of the addon
function Analyst:OnDisable ()
	-- Subsystems
	self:DisableEconomyFrame()
	self:DisableVendorValue()
	self:DisableMeasure()
	self:DisableCapture()
end


----------------------------------------------------------------------
-- Settings

-- Returns whether the Economy Frame is shown
function Analyst:IsEconomyFrameShown ()
	return EconomyFrame:IsShown()
end

-- Toggles the Economy Frame
function Analyst:ToggleEconomyFrame ()
	if EconomyFrame:IsShown() then
		HideUIPanel(EconomyFrame)
	else
		ShowUIPanel(EconomyFrame)
	end
end

-- Returns the start day of the week
function Analyst:GetStartDayOfWeek ()
	return self.db.profile.startDayOfWeek
end

-- Sets the start day of the week
function Analyst:SetStartDayOfWeek (startDayOfWeek)
	self.db.profile.startDayOfWeek = startDayOfWeek
	self:UpdateEconomyFrame()
	self:Update()
end

-- Returns whether to show the gold in the title
function Analyst:GetShowGold ()
	return self.db.profile.showGold
end

-- Sets whether to show the gold gained or lost in the title
function Analyst:SetShowGold (showGold) 
	self.db.profile.showGold = showGold
	self:Update()
end


----------------------------------------------------------------------
-- FuBar

-- Handles clicks
function Analyst:OnClick (button)
	self:ToggleEconomyFrame()
end

-- Handles text update
function Analyst:OnTextUpdate ()
	if self.db.profile.showGold then
		local start, finish = self:GetPeriodStartFinish()
		local change = 0
		for charID in self:GetCharacterIterator() do
			for t = start, finish, 86400 do
				local day = date("%Y%m%d", t)
				change = change + self:GetFacts(ANALYST_MEASURE_MONEY_GAINED_TOTAL, day, charID).value
				change = change - self:GetFacts(ANALYST_MEASURE_MONEY_SPENT_TOTAL, day, charID).value
			end
		end
		local color
		if change >= 0 then
			color = "|cFF00FF00"
		else
			color = "|cFFFF0000"
		end
		self:SetText(color .. self:FormatCopper(math.abs(change)))
	else
		self:SetText(self:GetTitle())
	end
end

--  Handles tooltip updates
function Analyst:OnTooltipUpdate ()
	local report = self:GetReport(ANALYST_REPORT_OVERVIEW)
	local tablet = AceLibrary("Tablet-2.0")
	tablet:SetHint(L["ECONOMY_FRAME_HINT"])
	local cat = tablet:AddCategory(
		"columns", 2,
		"text", report.label,
		"child_textR", 1, "child_textG", 0.82, "child_textB", 0,
		"child_text2R", 1, "child_text2G", 1, "child_text2B", 1)
	local start, finish = self:GetPeriodStartFinish()
	for i in ipairs(report.measures) do
		local measureName = report.measures[i]
		local measure = self:GetMeasure(measureName)
		local facts = { }
		for charID in self:GetCharacterIterator() do
			for t = start, finish, 86400 do
				local day = date("%Y%m%d", t)
				local dayFacts = Analyst:GetFacts(measureName, day, charID)
				self:MergeFacts(facts, dayFacts)
			end
		end
		local text2
		if self:GetMeasureType(measureName) == ANALYST_MTYPE_MONEY then
			text2 = self:FormatCopper(facts.value)
		else
			text2 = tostring(facts.value)
		end
		cat:AddLine("text", measure.label, "text2", text2)
	end
end


----------------------------------------------------------------------
-- Helpers

-- Returns today's date
function Analyst:GetDate ()
	local now = time()
	local components = date("*t", today)
	local seconds =	((components.hour * 60) + components.min) * 60 + components.sec
	return now - seconds + 43200
end

-- Returns the CharID of the current character
function Analyst:GetCharID ()
	return UnitName("player") .. " - " .. GetRealmName():trim()
end

-- Formats a copper amount
function Analyst:FormatCopper (copper)
	local prefix
	if copper >= 0 then
		prefix = ""
	else
		prefix = "-"
		copper = math.abs(copper)
	end
	if copper >= 10000 then
		return string.format("%s%.1f G", prefix, copper / 10000.0)
	elseif copper >= 100 then
		return string.format("%s%.1f S", prefix, copper / 100.0)
	else
		return string.format("%s%d C", prefix, copper)
	end
end
