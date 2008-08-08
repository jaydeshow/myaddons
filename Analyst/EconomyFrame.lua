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


----------------------------------------------------------------------
-- Constants

-- Periods
ANALYST_PERIOD_TODAY = "TODAY"
ANALYST_PERIOD_YESTERDAY = "YESTERDAY"
ANALYST_PERIOD_THIS_WEEK = "THIS_WEEK"
ANALYST_PERIOD_THIS_MONTH = "THIS_MONTH"
ANALYST_PERIOD_LAST_7_DAYS = "LAST_7_DAYS"
ANALYST_PERIOD_LAST_30_DAYS = "LAST_30_DAYS"
ANALYST_PERIODS = {
	ANALYST_PERIOD_TODAY,
	ANALYST_PERIOD_YESTERDAY,
	ANALYST_PERIOD_THIS_WEEK,
	ANALYST_PERIOD_THIS_MONTH,
	ANALYST_PERIOD_LAST_7_DAYS,
	ANALYST_PERIOD_LAST_30_DAYS
}


---------------------------------------------------------------------
-- Subsystem

-- Initializes the economy frame subsystem
function Analyst:InitializeEconomyFrame ()
	-- Defaults
	self:RegisterDefaults("char", {
		economyFrameAllCharacters = false,
		economyFramePeriod = ANALYST_PERIOD_TODAY,
		economyFrameLeftReport = ANALYST_REPORT_MONEY_GAINED,
		economyFrameRightReport = ANALYST_REPORT_MONEY_SPENT
	})
	
	-- Set attrbiutes
	EconomyFrame:SetAttribute("UIPanelLayout-defined", true)
	EconomyFrame:SetAttribute("UIPanelLayout-enabled", true)
	EconomyFrame:SetAttribute("UIPanelLayout-area", "left")
	EconomyFrame:SetAttribute("UIPanelLayout-pushable", 5)
	EconomyFrame:SetAttribute("UIPanelLayout-whileDead", true)
	
	-- Translations
	EconomyFrameTitleText:SetText(L["ECONOMY_FRAME_TITLE"])
	EconomyFrameAllCharactersText:SetText(L["ALL_CHARACTERS"])

	-- All characters checkbox
	EconomyFrameAllCharacters:SetChecked(self.db.char.economyFrameAllCharacters)
	
	-- Period drop down
	UIDropDownMenu_Initialize(
		EconomyFramePeriodDropDown,
		self.InitializePeriods)
	UIDropDownMenu_SetWidth(100, EconomyFramePeriodDropDown)
	UIDropDownMenu_SetSelectedID(
		EconomyFramePeriodDropDown,
		self:GetPeriodId(self.db.char.economyFramePeriod));
	
	-- Report drop downs
	UIDropDownMenu_Initialize(
		EconomyFrameLeftStatsReportDropDown,
		self.InitializeReports)
	UIDropDownMenu_SetWidth(133, EconomyFrameLeftStatsReportDropDown)
	UIDropDownMenu_SetSelectedID(
		EconomyFrameLeftStatsReportDropDown,
		self:GetReportId(self.db.char.economyFrameLeftReport))
	UIDropDownMenu_Initialize(
		EconomyFrameRightStatsReportDropDown,
		self.InitializeReports)
	UIDropDownMenu_SetWidth(133, EconomyFrameRightStatsReportDropDown)
	UIDropDownMenu_SetSelectedID(
		EconomyFrameRightStatsReportDropDown,
		self:GetReportId(self.db.char.economyFrameRightReport))
end

-- Enable the economy frame subsystem
function Analyst:EnableEconomyFrame ()
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	self:RegisterEvent("ANALYST_FACTS_CHANGED")
end

-- Disables the economy frame subsystem
function Analyst:DisableEconomyFrame ()
end


----------------------------------------------------------------------
-- EconomyFrame

-- OnShow handler
function Analyst:OnShowEconomyFrame ()
	PlaySound("igCharacterInfoOpen")
	SetPortraitTexture(EconomyFramePortrait, "player")
	self:UpdateEconomyFrame()
end

-- OnHide handler
function Analyst:OnHideEconomyFrame ()
	PlaySound("igCharacterInfoClose")
end

-- Handles the UNIT_PORTRAIT_UPDATE event
function Analyst:UNIT_PORTRAIT_UPDATE (unit)
	if unit == "player" then
		SetPortraitTexture(EconomyFramePortrait, "player")
	end
end

-- Handles the ANALYST_FACTS_CHANGED event
function Analyst:ANALYST_FACTS_CHANGED ()
	if EconomyFrame:IsShown() then
		self:UpdateEconomyFrame()
	end
	self:Update()
end

----------------------------------------------------------------------
-- All characters check box

-- Iterates over the current character
function Analyst:CurrentCharacterIterator (charID)
	if not charID then
		charID = self:GetCharID()
		return charID, AnalystDB.chars[charID]
	end
end

-- Returns an iterator for the selected characters
function Analyst:GetCharacterIterator ()
	if self.db.char.economyFrameAllCharacters then
		return next, AnalystDB.chars, nil
	else
		return self.CurrentCharacterIterator, self, nil
	end
end

-- Handles character selection
function Analyst:OnAllCharactersClick ()
	self.db.char.economyFrameAllCharacters = EconomyFrameAllCharacters:GetChecked()
	self:UpdateEconomyFrame()
	self:Update()
end

-- Handles mouse enter on character selection
function Analyst:OnAllCharactersEnter ()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:SetText(L["ALL_CHARACTERS_TOOLTIP"], nil, nil, nil, nil, 1)
end

-- Handles mouse leave on character selection
function Analyst:OnAllCharactersLeave ()
	GameTooltip:Hide()
end


----------------------------------------------------------------------
-- Period drop down

-- Initializes the period drop down on load (callback)
function Analyst:InitializePeriods ()
	self = Analyst
	self:AddPeriodSelection(ANALYST_PERIOD_TODAY)
	self:AddPeriodSelection(ANALYST_PERIOD_YESTERDAY)
	self:AddPeriodSelection(ANALYST_PERIOD_THIS_WEEK)
	self:AddPeriodSelection(ANALYST_PERIOD_THIS_MONTH)
	self:AddPeriodSelection(ANALYST_PERIOD_LAST_7_DAYS)
	self:AddPeriodSelection(ANALYST_PERIOD_LAST_30_DAYS)
end

-- Adds an option to the period drop down
function Analyst:AddPeriodSelection (name)
	local info = UIDropDownMenu_CreateInfo()
	info.owner = getglobal(UIDROPDOWNMENU_INIT_MENU)
	info.text = L:GetTranslation(name)
	info.func = self.OnPeriodClick
	info.checked = false
	info.arg1 = Analyst
	info.arg2 = name
	UIDropDownMenu_AddButton(info)
end

-- Handles selection of a period
function Analyst:OnPeriodClick (name)	
	UIDropDownMenu_SetSelectedID(this.owner, this:GetID())
	self.db.char.economyFramePeriod = name
	self:UpdateEconomyFrame()
	self:Update()
end

-- Returns the start and finish dates for the selected period
function Analyst:GetPeriodStartFinish ()
	-- Evaluate period
	local today = self:GetDate()
	local start
	local finish = today
	local period = self.db.char.economyFramePeriod
	if period == ANALYST_PERIOD_TODAY then
		start = today
	elseif period == ANALYST_PERIOD_YESTERDAY then
		start = today - 86400
		finish = start
	elseif period == ANALYST_PERIOD_THIS_WEEK then
		local components = date("*t", today)
		local dayOfWeek = components.wday - 1
		if dayOfWeek == 0 then
			dayOfWeek = 7
		end
		local startDayOfWeek = self.db.profile.startDayOfWeek
		if dayOfWeek >= startDayOfWeek then
			start = today - (dayOfWeek - startDayOfWeek) * 86400
		else
			start = today - (dayOfWeek + 7 - startDayOfWeek) * 86400
		end
	elseif period == ANALYST_PERIOD_THIS_MONTH then
		local dayOfMonth = tonumber(date("%d", today))
		start = today - (dayOfMonth - 1) * 86400
	elseif period == ANALYST_PERIOD_LAST_7_DAYS then
		start = today - 6 * 86400
	elseif period == ANALYST_PERIOD_LAST_30_DAYS then
		start = today - 29 * 86400
	end
	if not start then
		self:LevelDebug(1, "Unknown period")
		start = today
	end
	return start, finish
end

-- Returns the ID of a period given its name
function Analyst:GetPeriodId (name)
	for i in ipairs(ANALYST_PERIODS) do
		if ANALYST_PERIODS[i] == name then
			return i
		end
	end
	return nil
end


----------------------------------------------------------------------
-- Report drop down

-- Initializes the period drop down on load (callback)
function Analyst:InitializeReports ()
	self = Analyst
	local reports = self:GetReports()
	for i in ipairs(reports) do
		if reports[i].name ~= ANALYST_REPORT_OVERVIEW then
			self:AddReportSelection(reports[i].name)
		end
	end
end

-- Adds an option to the period drop down
function Analyst:AddReportSelection (name)
	local info = UIDropDownMenu_CreateInfo()
	info.owner = getglobal(UIDROPDOWNMENU_INIT_MENU)
	info.text = L:GetTranslation(name)
	info.func = self.OnReportClick
	info.checked = false
	info.arg1 = Analyst
	info.arg2 = name
	UIDropDownMenu_AddButton(info)
end

-- Handles selection of a period
function Analyst:OnReportClick (name)
	UIDropDownMenu_SetSelectedID(this.owner, this:GetID())
	if this.owner:GetName() == "EconomyFrameLeftStatsReportDropDown" then
		self.db.char.economyFrameLeftReport = name
	elseif this.owner:GetName() == "EconomyFrameRightStatsReportDropDown" then
		self.db.char.economyFrameRightReport = name
	end
	self:UpdateEconomyFrame()
end

-- Returns the ID of a report
function Analyst:GetReportId (name)
	local reports = self:GetReports()
	for i in ipairs(reports) do
		if reports[i].name == name then
			return i - 1
		end
	end
	return nil
end


----------------------------------------------------------------------
-- Data management

-- Updates the economy frame
function Analyst:UpdateEconomyFrame ()
	-- Get start and finish
	local start, finish = self:GetPeriodStartFinish()
	
	-- Update reports
	self:UpdateReport(EconomyFrameTopStats, 8, ANALYST_REPORT_OVERVIEW, start, finish)
	self:UpdateReport(EconomyFrameLeftStats, 12, self.db.char.economyFrameLeftReport, start, finish)
	self:UpdateReport(EconomyFrameRightStats, 12, self.db.char.economyFrameRightReport, start, finish)
end

-- Updates a single report
function Analyst:UpdateReport (frame, maxMeasures, reportName, start, finish)
	-- Get date
	local day = date("%Y%m%d", time())
	
	-- Get the report
	local report = self:GetReport(reportName)
	if not report then
		self:LevelDebug(1, "Undefined report " .. reportName)
		return
	end
	
	-- Process each measure
	for i in ipairs(report.measures) do
		if i > maxMeasures then
			break
		end
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
		local label = getglobal(frame:GetName() .. i .. "Label")
		label:SetText(measure.label)
		local text = getglobal(frame:GetName() .. i .. "StatText")
		if self:GetMeasureType(measureName) == ANALYST_MTYPE_MONEY then
			text:SetText(self:FormatCopper(facts.value))
		else
			text:SetText(tostring(facts.value))
		end
		local statFrame = getglobal(frame:GetName() .. i)
		statFrame.facts = facts
		statFrame.measure = measure
	end
	for i = #report.measures + 1, maxMeasures do
		local label = getglobal(frame:GetName() .. i .. "Label")
		label:SetText("")
		local text = getglobal(frame:GetName() .. i .. "StatText")
		text:SetText("")
		local statFrame = getglobal(frame:GetName() .. i)
		statFrame.facts = nil
		statFrame.measure = nil
	end
end


----------------------------------------------------------------------
-- Stat tooltip

-- Shows the tooltip upon entry
function Analyst:OnStatEnter ()
	local facts = this.facts
	local measure = this.measure
	if facts and measure then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
		GameTooltip:AddLine(
			measure.label,
			HIGHLIGHT_FONT_COLOR.r,
			HIGHLIGHT_FONT_COLOR.g,
			HIGHLIGHT_FONT_COLOR.b)
		self:AddSubFacts(GameTooltip, measure, facts.detail)
		self:AddSubFacts(GameTooltip, measure, facts.consumed, L:GetTranslation("CONSUMED"))
		self:AddSubFacts(GameTooltip, measure, facts.produced, L:GetTranslation("PRODUCED"))
		GameTooltip:Show()
	end
end

-- Adds sub-facts to the game tooltip
function Analyst:AddSubFacts (gameTooltip, measure, subFacts, label)
	-- No sub facts?
	if not subFacts then
		if not label then
			gameTooltip:AddLine(
				L:GetTranslation("NO_DETAIL_INFO"),
				GRAY_FONT_COLOR.r,
				GRAY_FONT_COLOR.g,
				GRAY_FONT_COLOR.b)
		end
		return
	end
	
	-- Prepare data
	local data = { }
	for detail in pairs(subFacts) do
		local element = { }
		element.detail = detail
		element.value = subFacts[detail]
		table.insert(data, element)
	end
	table.sort(
		data,
		function (element1, element2)
			return element1.value > element2.value or
				(element1.value == element2.value and element1.detail < element2.detail)
		end)
	
	-- No data?
	if #data == 0 then
		return
	end
	
	-- Add title
	if label then
		gameTooltip:AddLine(
			label,
			HIGHLIGHT_FONT_COLOR.r,
			HIGHLIGHT_FONT_COLOR.g,
			HIGHLIGHT_FONT_COLOR.b)
	end
	
	-- Add values
	for i in ipairs(data) do
		if i > 10 then
			break
		end
		local text
		if self:GetMeasureType(measure.name) == ANALYST_MTYPE_MONEY then
			text = self:FormatCopper(data[i].value)
		else
			text = tostring(data[i].value)
		end
		gameTooltip:AddDoubleLine(
			data[i].detail,
			text,
			NORMAL_FONT_COLOR.r,
			NORMAL_FONT_COLOR.g,
			NORMAL_FONT_COLOR.b,
			HIGHLIGHT_FONT_COLOR.r,
			HIGHLIGHT_FONT_COLOR.g,
			HIGHLIGHT_FONT_COLOR.b)
	end
end

-- Hides the tooltip upon leaveing
function Analyst:OnStatLeave ()
	GameTooltip:Hide()
end
