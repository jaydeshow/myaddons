local CQI = Cartographer_QuestInfo
local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo")

local Tablet = AceLibrary("Tablet-2.0")

-------------------------------------------------------------------

----
--	<INFO> = {
--		current = <qid>,
--		series = { <qid>, <qid>, ... },
--	}
----

local INFO
local _sc_retry = 0

function CQI:OpenSeriesFrame(map)
	INFO = INFO ~= map and map or nil
	self:CancelScheduledEvent("CQI-UpdateSeriesFrame")
	_sc_retry = 0
	self:ScheduleEvent("CQI-UpdateSeriesFrame", self.UpdateSeriesFrame, 0, self)
end

function CQI:CloseSeriesFrame()
	if Tablet:IsRegistered("CQI_Series") then
		self:OpenSeriesFrame(nil)
	end
end

-------------------------------------------------------------------

function CQI:UpdateSeriesFrame()
	if not Tablet:IsRegistered("CQI_Series") then
		Tablet:Register("CQI_Series",
			"data", {},
			"clickable", true,
			'movable', true,
			"cantAttach", true,
			"dontHook", true,
			"showTitleWhenDetached", true,
			"hideWhenEmpty", true,
			"strata", "HIGH",
			"minWidth", 450,
			"children", function() self:UpdateSeriesContent() end)
		Tablet:Open("CQI_Series")
	end
	Tablet:Refresh("CQI_Series")
end

function CQI:UpdateSeriesContent()
	local map = INFO
	if not map then return end

	Tablet:SetTitle(L["Quest Series"])

	local cat = Tablet:AddCategory(
		"id", "series",
		"columns", 1,
		"hideBlankLine", true,
		"child_justify", "LEFT",
		"child_size", 14)

	local has_unknown = false
	for step, uid in pairs(map.series) do
		local q = self:GetQuest(uid)

		if q.title == "????" then
			has_unknown = true
		end

		local r, g, b = 0, 1, 1
		if uid ~= map.current then
			r, g, b = self:GetQuestColor(q.level)
		end

		cat:AddLine(
			"text", q.title_full,
			"textR", r, "textG", g, "textB", b,
			"func", function()
				if q.start_npc and q.start_npc.loc then
					for zone in pairs(q.start_npc.loc) do
						self:OpenQuestMap(q.title_full, L["Quest Start"], "start", zone, { q.start_npc })
						return
					end
				end
			end)

		cat:AddLine(
			"text", q.desc,
			"hasCheck", true,
			"textR", 1, "textG", 1, "textB", 1,
			"wrap", true)
	end

	Tablet:AddCategory("hideBlankLine", true):AddLine(
		"text", L["Close"],
		"size", 14,
		"justify", "center",
		"func", function() self:CloseSeriesFrame() end)

	if has_unknown and _sc_retry < 15 then
		_sc_retry = _sc_retry + 1
		self:ScheduleEvent("CQI-UpdateSeriesFrame", self.UpdateSeriesFrame, _sc_retry, self)
	end
end

-------------------------------------------------------------------

function CQI:OnInfoClick(button, q)
	if not q then
		q = this.CQI_Data
		if not q then return end
	end

	self:CloseSeriesFrame()
	CQI_Tooltip:Hide()

	if q.series then
		self:OpenSeriesFrame({
			current = q.id,
			series = q.series,
		})
	end
end

-------------------------------------------------------------------

local _it

function CQI:BatchShowInfoTooltip()
	local q = _it.q
	local this = _it.this
	if not q or not this then return end
	local has_unknown = false

	CQI_Tooltip:ClearLines()
	CQI_Tooltip:SetOwner(this, "ANCHOR_RIGHT")

	CQI_Tooltip:AddLine(q.title_full, 1, 0.5, 0)
	if q.level_req then
		CQI_Tooltip:AddDoubleLine(L["Requires:"], q.level_req, 0.8, 1, 0, 1, 1, 1)
	end
	if q.sharable then
		CQI_Tooltip:AddDoubleLine(" ", L["Sharable"], 1, 1, 1, 1, 1, 1)
	end

	if q.series then
		CQI_Tooltip:AddLine(L["Series:"], 0.8, 1, 0)
		for step, uid in pairs(q.series) do
			if uid == q.id then
				CQI_Tooltip:AddLine("  "..q.title_full, 0, 1, 1)
			else
				local level = self:PeekQuest(uid)
				local title_full = self:GetQuestText(uid, level)
				if not title_full then
					title_full = "????"
					has_unknown = true
				end
				local r, g, b = self:GetQuestColor(level)
				CQI_Tooltip:AddLine("  "..title_full, r, g, b)
			end
		end
	end

	CQI_Tooltip:Show()

	if has_unknown and _it.retry < 15 then
		_it.retry  = _it.retry + 1
		self:ScheduleEvent("CQI-BatchShowInfoTooltip", self.BatchShowInfoTooltip, _it.retry / 2, self)
	end
end

function CQI:OnInfoTooltip(q)
	if not q then
		q = this.CQI_Data
		if not q then return end
	end

	self:CancelScheduledEvent("CQI-BatchShowInfoTooltip")
	_it = {}
	_it.this = this
	_it.retry = 0
	_it.q = q
	self:BatchShowInfoTooltip()
end
