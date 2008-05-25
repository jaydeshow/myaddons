local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo")
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

local C = Cartographer
local CQI = Cartographer_QuestInfo

-------------------------------------------------------------------

----
-- for start and end npc, the CQI_Data is:
-- { 
--		quest = "<quest_title>",
--		npc = <NPC>,
-- },
--
-- for objective, the CQI_Data is:
-- {
--		quest = "<quest_title>",
--		obj = <OBJECTIVE>,
-- }
----
function CQI:QuestLog_UpdateQuestDetails()
	self:CloseSeriesFrame()
	self:CloseLocationFrame()
	
	CQI_InfoButton:Hide()
	CQI_StartButton:Hide()
	CQI_EndButton:Hide()
	
	for i = 1, 9 do
		local button = getglobal("CQI_ObjButton"..i)
		button:Hide()
	end

	if not C:IsModuleActive(self) then return end

	local uid = tonumber(string.match(GetQuestLink(GetQuestLogSelection()), 'quest:(%d+)'))
	local q = self:GetQuest(uid)
	if not q then return end

	CQI_InfoButton.CQI_Data = q
	CQI_InfoButton:Show()

	if q.start_npc then
		CQI_StartButton.CQI_Data = {
			quest = q.title_full,
			npc = q.start_npc,
		}
		CQI_StartButton:Show()
	end

	if q.end_npc then
		CQI_EndButton.CQI_Data = {
			quest = q.title_full,
			npc = q.end_npc,
		}
		CQI_EndButton:Show()
	end
		
	if q.objs then
		for i = 1, 9 do
			local q_string = getglobal("QuestLogObjective"..i)
			if q_string:IsVisible() and q.objs[i] and q.objs[i].npcs then
				local button = getglobal("CQI_ObjButton"..i)
				button.CQI_Data = {
					quest = q.title_full,
					obj = q.objs[i],
				}
	 			button:ClearAllPoints()
				button:SetPoint("TOPLEFT", q_string, "TOPLEFT", 0, 0)
				button:SetPoint("BOTTOMRIGHT", q_string, "BOTTOMRIGHT", 0, 0)
				button:Show()
			end
		end
	end
end

-------------------------------------------------------------------

function CQI:OnButtonClick(type, button, data)
	if not data then
		data = this.CQI_Data
		if not data then return end
	end
	
	self:CloseLocationFrame()
	CQI_Tooltip:Hide()
	self:ClearQuestNotes()

	local map = {}
	map.quest = data.quest
	map.zones = {}

	if type == "start" or type == "end" then
		map.title = (type == "start") and L["Quest Start"] or L["Quest End"]
		map.npcs = { data.npc }		
	else
		map.title = data.obj.title
		map.npcs = data.obj.npcs
	end
	
	if not map.npcs then return end
	
	local zone_count = 0
	local last_zone = nil
	
	for _, npc in ipairs(map.npcs) do
		if npc.loc then
			for zone, pos in pairs(npc.loc) do
				if BZR[zone] then
					if not map.zones[zone] then
						map.zones[zone] = { npc }
						last_zone = zone
						zone_count = zone_count + 1
					else
						table.insert(map.zones[zone], npc)
					end
				end
			end
		end
	end
	
	if zone_count == 1 then
		self:OpenQuestMap(map.quest, map.title, type, last_zone, map.zones[last_zone])
	elseif zone_count > 1 then
		self:OpenLocationFrame(map)
	end
end

function CQI:OnButtonTooltip(type, data)
	if not data then
		data = this.CQI_Data
		if not data then return end
	end
	
	local npcs, title
	if type == "start" or type == "end" then
		title = (type == "start") and L["Quest Start"] or L["Quest End"]
		npcs = { data.npc }
	else
		title = L["Quest Objective"]
		npcs = data.obj and data.obj.npcs
	end
	
	if not npcs or #npcs == 0 then return end
	
	CQI_Tooltip:SetOwner(this, "ANCHOR_RIGHT")
	CQI_Tooltip:ClearLines()
	CQI_Tooltip:AddLine(title, 1, 0.5, 0)

	if #npcs == 1 then
		CQI_Tooltip:AddLine(npcs[1].name, 1, 1, 1)
	end
	
	local i = 0
	for _, npc in ipairs(npcs) do
		if npc.loc then
			for zone, pos in pairs(npc.loc) do
				local j = 0
				for _, l in ipairs(pos) do
					if l.x ~= 0 and l.y ~= 0 then
						if j < 3 then
							zone = zone..string.format(" <%d,%d>", l.x, l.y)
							j = j + 1
						else
							zone = zone.." ..."
							break
						end
					end
				end
				if i < 5 then
					if #npcs == 1 then
						CQI_Tooltip:AddLine(zone, 0.8, 1, 0)
					else
						CQI_Tooltip:AddDoubleLine(npc.name, zone, 1, 1, 1, 0.8, 1, 0)
					end
				end
				i = i + 1
			end
		end
	end

	if i >= 5 then
		CQI_Tooltip:AddDoubleLine(" ", L["... more"], 1, 1, 1, 0.6, 0.6, 0.6)
	end
	
	CQI_Tooltip:Show()
end

-------------------------------------------------------------------

function CQI:ExtendQuestLog()
	if self.IsQuestLogExtended then return end
	self.IsQuestLogExtended = true

	-- code copied from DoubleWide
	QuestLogFrame:SetAttribute("UIPanelLayout-width", 724)
	QuestLogFrame:SetWidth(724)
	QuestLogFrame:SetHeight(513)

	QuestLogDetailScrollFrame:ClearAllPoints()
	QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPRIGHT", 41, 0)
	QuestLogDetailScrollFrame:SetHeight(362)
	QuestLogListScrollFrame:SetHeight(362)

	local oldQuestsDisplayed = QUESTS_DISPLAYED
	QUESTS_DISPLAYED = QUESTS_DISPLAYED + 17

	for i = oldQuestsDisplayed + 1, QUESTS_DISPLAYED do
	    local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")
	    button:SetID(i)
	    button:Hide()
	    button:ClearAllPoints()
	    button:SetPoint("TOPLEFT", getglobal("QuestLogTitle" .. (i-1)), "BOTTOMLEFT", 0, 1)
	end

	local regions = { QuestLogFrame:GetRegions() }
	local xOffsets = { Left = 3, Middle = 259, Right = 515 }
	local yOffsets =  { Top = 0, Bot = -256 }

	local textures = {
	    TopLeft = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_TopLeft",
	    TopMiddle = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_TopMid",
	    TopRight = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_TopRight",
	    BotLeft = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_BotLeft",
	    BotMiddle = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_BotMid",
	    BotRight = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QL_BotRight",
	}

	local PATTERN = "^Interface\\QuestFrame\\UI%-QuestLog%-(([A-Z][a-z]+)([A-Z][a-z]+))$"
	for _, region in ipairs(regions) do
	    if (region:IsObjectType("Texture")) then
		    local texturefile = region:GetTexture()
		    local which, yofs, xofs = texturefile:match(PATTERN)
		    xofs = xofs and xOffsets[xofs]
		    yofs = yofs and yOffsets[yofs]
		    if (xofs and yofs and textures[which]) then
		        region:ClearAllPoints()
		        region:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", xofs, yofs)
		        region:SetTexture(textures[which])
		        region:SetWidth(256)
		        region:SetHeight(256)
		        textures[which] = nil
		    end
	    end
	end

	for name, path in pairs(textures) do
	    local yofs, xofs = name:match("^([A-Z][a-z]+)([A-Z][a-z]+)$")
	    xofs = xofs and xOffsets[xofs]
	    yofs = yofs and yOffsets[yofs]
	    if (xofs and yofs) then
		    local region = QuestLogFrame:CreateTexture(nil, "ARTWORK")
		    region:ClearAllPoints()
		    region:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", xofs, yofs)
		    region:SetWidth(256)
		    region:SetHeight(256)
		    region:SetTexture(path)
	    end
	end
end
