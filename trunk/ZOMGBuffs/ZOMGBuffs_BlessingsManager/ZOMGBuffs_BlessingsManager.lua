if (ZOMGBlessingsManager) then
	z:Print("Installation error, duplicate copy of ZOMGBuffs_BlessingsManager (Addons\ZOMGBuffs\ZOMGBuffs_BlessingsManager and Addons\ZOMGBuffs_BlessingsManager)")
	return
end

local L = LibStub("AceLocale-2.2"):new("ZOMGBlessingsManager")
local BabbleSpell = LibStub("LibBabble-Spell-3.0")
local BS = BabbleSpell:GetLookupTable()
local BC = LibStub("LibBabble-Class-3.0"):GetLookupTable()
local ZFrame
local roster = LibStub("Roster-2.1")
local dewdrop = LibStub("Dewdrop-2.0")
local template
local playerName, playerClass
local split = true					-- Disable to turn off new thing
local abCount = 0

local wow24 = GetBuildInfo() < "1.0.0" or GetBuildInfo() >= "2.4.0"

local blessingCycle = {"BOM", "BOK", "BOW", "BOL", "BOS", "SAN"}
local blessingCycleIndex = {}
for k,v in ipairs(blessingCycle) do blessingCycleIndex[v] = k end

local z = ZOMGBuffs
local man = z:NewModule("ZOMGBlessingsManager")
ZOMGBlessingsManager = man

z:CheckVersion("$Revision: 66426 $")

do
	local specWeight1 = function(t1, t2, t3) return t1 > t2 and t1 > t3 end
	local specWeight2 = function(t1, t2, t3) return t2 > t1 and t2 > t3 end
	local specWeight3 = function(t1, t2, t3) return t3 > t1 and t3 > t2 end
	local specWeight1or2 = function(t1, t2, t3) return t1 > t3 or t2 > t3 end

	man.classSplits = {
		WARRIOR	= {[1] = {title = L["Tank"], discover = specWeight3},	[2] = {title = L["Melee DPS"],	code = "m", discover = specWeight1or2}},
		DRUID	= {[1] = {title = L["Healer"], discover = specWeight3},	[2] = {title = L["Tank"],	code = "t", discover = specWeight2}, [3] = {title = L["Melee DPS"], code = "m", discover = specWeight2}, [4] = {title = L["Caster DPS"], code = "c", discover = specWeight1}},
		SHAMAN	= {[1] = {title = L["Healer"], discover = specWeight3},	[2] = {title = L["Melee DPS"],	code = "m", discover = specWeight2}, [3] = {title = L["Caster DPS"], code = "c", discover = specWeight1}},
		PALADIN	= {[1] = {title = L["Healer"], discover = specWeight1},	[2] = {title = L["Tank"],	code = "t", discover = specWeight2}, [3] = {title = L["Melee DPS"], code = "m", discover = specWeight3}},
		PRIEST	= {[1] = {title = L["Healer"], discover = specWeight1or2}, [2] = {title = L["Caster DPS"],code = "c", discover = specWeight3}},
	}
end

local new, del, deepDel, copy = z.new, z.del, z.deepDel, z.copy
local classOrder, classIndex = z.classOrder, z.classIndex

do
local function getOption(v)
	return man.db.profile[v]
end

local function setOption(v, n)
	man.db.profile[v] = n
end

man.consoleCmd = L["Manager"]
man.options = {
	type = "group",
	order = 10,
	name = "|cFFFF8080Z|cFFFFFF80O|cFF80FF80M|cFF8080FFG|cFFFFFFFFBlessings Manager|r",
	desc = L["Blessings Manager configuration"],
	handler = man,
	args = {
		open = {
			type = "execute",
			name = L["Open"],
			desc = L["Open Blessings Manager"],
			func = "Open",
			hidden = function() return (man.frame and man.frame:IsOpen()) or not man:IsModuleActive() end,
			order = 1,
		},
		unlock = {
			type = "execute",
			name = L["Unlock"],
			desc = L["Unlock undetected mod users for editing"],
			func = "Unlock",
			order = 2,
			hidden = function() return man:NoneLocked() end,
		},
		template = {
			type = "group",
			name = L["Templates"],
			desc = L["Template configuration"],
			order = 10,
			hidden = function() return not man:IsModuleActive() end,
			args = {
			}
		},
		chat = {
			type = "group",
			name = L["Chat Interface"],
			desc = L["Chat interface configuration"],
			order = 20,
			hidden = function() return not man:IsModuleActive() end,
			args = {
				remote = {
					type = "toggle",
					name = L["Remote Buff Requests"],
					desc = L["Allow remote buff requests via the !zomg whisper command"],
					get = getOption,
					set = setOption,
					passValue = "remotechanges",
					order = 1,
				},
			},
		},
		clean = {
			type = "group",
			name = L["Cleanup"],
			desc = L["Cleanup options"],
			order = 50,
			hidden = function() return not man:IsModuleActive() or man.db.profile.playerCodes == nil end,
			args = {
				nonguild = {
					type = "execute",
					name = L["Non-Guildies"],
					desc = L["Strip non-guildies from the stored sub-class definitions"],
					func = function() man:Clean("guild") end,
					order = 1,
				},
				nonraid = {
					type = "execute",
					name = L["Non-Raid Members"],
					desc = L["Strip non-existant raid members from the stored sub-class definitions"],
					func = function() man:Clean("raid") end,
					order = 1,
				}
			},
		},
		send = {
			type = "group",
			name = L["Send"],
			desc = L["Send options"],
			order = 98,
			hidden = function() return not man:IsModuleActive() end,
			args = {
				template = {
					type = "text",
					name = L["Template"],
					desc = L["Send Blessings Manager master template to another player"],
					usage = L["<player name>"],
					input = true,
					get = false,
					set = function(name) man:Send("template", name) end,
					order = 1,
				},
				subclasses = {
					type = "text",
					name = L["Sub-Class Assignments"],
					desc = L["Send Blessings Manager sub-class assignments"],
					usage = L["<player name>"],
					input = true,
					get = false,
					set = function(name) man:Send("subclass", name) end,
					order = 2,
				},
			}
		},
		display = {
			type = "group",
			name = L["Display"],
			desc = L["Display configuration"],
			order = 99,
			hidden = function() return not man:IsModuleActive() end,
			args = {
				autoopen = {
					type = "toggle",
					name = L["Auto-Open Class Split"],
					desc = L["Automatically open the class split frame when defining the sub-class buff assignments"],
					get = getOption,
					set = setOption,
					passValue = "autoOpen",
					order = 1,
				},
				highlights = {
					type = "toggle",
					name = L["Highlights"],
					desc = L["Highlight the selected row and column in the manager"],
					get = getOption,
					set = setOption,
					passValue = "highlights",
					order = 5,
				},
				greyout = {
					type = "toggle",
					name = L["Greyouts"],
					desc = L["Grey out invalid Drag'n'Drop target cells"],
					get = getOption,
					set = setOption,
					passValue = "greyout",
					order = 10,
				},
			}
		},
		behaviour = {
			type = 'group',
			name = L["Behaviour"],
			desc = L["Other behaviour"],
			order = 201,
			args = {
				whispers = {
					type = "toggle",
					name = L["Whispers"],
					desc = L["Send assignments to paladins without ZOMGBuffs or PallyPower via whispers?"],
					get = getOption,
					set = setOption,
					passValue = "whispers",
					order = 1,
				},
			},
		},
	},
}
man.moduleOptions = man.options
man.hideMenuTitle = true
end

-- SetClassIcon
local classButtons = CLASS_BUTTONS
local function SetClassIcon(icon, class)
	local b = classButtons[class]
	if (b) then
		local l, r, t, b = unpack(b)
		icon:SetTexCoord(l + 0.025, r - 0.025, t + 0.025, b - 0.025)
	else
		icon:SetTexCoord(0.75, 1, 0.75, 1)
	end
end

-- DefaultTemplateSubclass
local function DefaultTemplateSubclass()
	return {
		WARRIOR = {
			m = {"BOS", "BOM", "BOK", "BOL", "SAN"},
		},
		DRUID = {
			c = {"BOS", "BOW", "BOK", "BOL", "SAN"},
			m = {"BOS", "BOM", "BOK", "BOL", "SAN", "BOW"},
			t = {"BOK", "BOM", "BOL", "SAN", "BOW"},
		},
		SHAMAN = {
			c = {"BOS", "BOK", "BOW", "BOL", "SAN"},
			m = {"BOS", "BOM", "BOK", "BOW", "BOL", "SAN"},
		},
		PALADIN = {
			m = {"BOS", "BOM", "BOK", "BOW", "BOL", "SAN"},
			t = {"BOK", "BOW", "SAN", "BOL", "BOM"},
		},
		PRIEST = {
			c = {"BOS", "BOW", "BOK", "BOL", "SAN"},
		},
	}
end

-- DefaultTemplate
local function DefaultTemplate()
	return {
		WARRIOR	= {"BOK", "BOL", "BOM", "SAN"},
		ROGUE	= {"BOS", "BOM", "BOK", "BOL", "SAN"},
		HUNTER	= {"BOS", "BOM", "BOK", "BOW", "BOL", "SAN"},
		DRUID	= {"BOW", "BOK", "BOS", "BOL", "SAN"},
		SHAMAN	= {"BOW", "BOK", "BOS", "BOL", "SAN", "BOM"},
		PALADIN	= {"BOW", "BOK", "BOS", "BOL", "SAN", "BOM"},
		PRIEST	= {"BOW", "BOK", "BOS", "BOL", "SAN"},
		MAGE	= {"BOS", "BOW", "BOK", "BOL", "SAN"},
		WARLOCK	= {"BOS", "BOW", "BOK", "BOL", "SAN"},
		subclass = DefaultTemplateSubclass(),
	}
end

-- SetSelf
function man:SetSelf()
	playerName = UnitName("player")
	playerClass = select(2, UnitClass("player"))
	self.canEdit = playerClass == "PALADIN" or (GetNumRaidMembers() > 0 and (IsRaidLeader() or IsRaidOfficer())) or (GetNumPartyMembers() > 0 and IsPartyLeader())
	self:SetTalentNamesAndIcons(playerClass)
end

-- OnModuleInitialize
local should
function man:OnModuleInitialize()
	self.db = z:AcquireDBNamespace("BlessingsManager")
	z:RegisterDefaults("BlessingsManager", "profile", {
		templates = {
			[L["Default"]] = DefaultTemplate(),
		},
		defaultTemplate = L["Default"],
		highlights = true,
		autoOpen = true,
		remotechanges = false,
		whispers = false,
		groups = 5,
		greyout = true,
	} )
	z:RegisterChatCommand({"/zomgman", "/zomgmanager", "/zomgbm"}, self.options)
	self.OnMenuRequest = self.options
	z.options.args.ZOMGBlessingsManager = self.options

	self:SetSelf()

	z.OnCommReceive.ACK = function(self, prefix, sender, channel, whoShouldHaveControl)
		man:OnReceiveAck(sender)
	end
	z.OnCommReceive.MODIFIEDTEMPLATE = function(self, prefix, sender, channel, template, response)
		man:OnReceiveTemplate(sender, template, true)
	end
	z.OnCommReceive.TEMPLATE = function(self, prefix, sender, channel, template)
		man:OnReceiveTemplate(sender, template)
	end
	z.OnCommReceive.GIVEMASTERTEMPLATE = function(self, prefix, sender, channel, template)
		man:OnReceiveMasterTemplate(sender, template)
	end
	z.OnCommReceive.GIVESUBCLASSES = function(self, prefix, sender, channel, playerCodes)
		man:OnReceiveSubClassDefinitions(sender, playerCodes)
	end
	z.OnCommReceive.SYMBOLCOUNT = function(self, prefix, sender, channel, count)
		man:OnReceiveSymbolCount(sender, count)
	end
	z.OnCommReceive.SPELLS_CHANGED = function(self, prefix, sender, channel)
		z:SendComm(sender, "REQUESTCAPABILITY", nil)
		z:SendComm(sender, "REQUESTSPEC", nil)
	end
	z.OnCommReceive.GIVETEMPLATEPART = function(self, prefix, sender, channel, name, class, Type)
		man:OnReceiveBroadcastTemplatePart(sender, name, class, Type)
	end
	z.OnCommReceive.SYNCGROUPS = function(self, prefix, sender, channel, groups)
		if (groups ~= man.db.profile.groups and z.db.profile.info) then
			man.db.profile.groups = groups
			man:Print(L["Synchronised group count with %s to %d because of pending blessing assignments"], z:ColourUnitByName(sender), groups)
			man:AssignPaladins()
			if (man.frame and man.frame:IsOpen()) then
				man:DrawAll()
			end
		end
	end

	self.OnModuleInitialize = nil
end

local function onButtonClick(self)
	self.func(man)
end
local function onButtonEnter(self)
	if (self.tooltipText) then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetText(self:GetText(), 1, 1, 1)
		GameTooltip:AddLine(self.tooltipText, nil, nil, nil, 1)
		GameTooltip:Show()
	end
end
local function onButtonLeave(self)
	GameTooltip:Hide()
end

-- CreateDragDropItem
function man:CreateDragDropItem()
	local icon = CreateFrame("GameTooltip", "ZOMGBuffsTooltipDragger", UIParent, "GameTooltipTemplate")
	icon.tex = icon:CreateTexture(nil, "OVERLAY")
	icon.tex:SetAllPoints()
	icon.text = icon:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	icon.text:SetAllPoints(true)
	self.dragIcon = icon

	self.SplitCreateDragDropItem = nil
	return icon
end

-- StartDrag
function man:StartDrag(text, r, g, b)
	local icon = man.dragIcon
	if (not icon) then
		icon = man:CreateDragDropItem()
	end

	icon:SetBackdropBorderColor(0, 0, 0, 0)
	icon:SetOwner(UIParent, "ANCHOR_CURSOR")
	icon:SetText(" ")
	icon:Show()
	icon:SetAlpha(0.7)

	if (type(text) == "string") then
		icon.tex:Hide()
		icon.text:Show()
		icon.text:SetText(text)
		if (type(r) == "number") then
			icon.text:SetTextColor(r, g, b)
		end
		icon:SetWidth(icon.text:GetStringWidth() + 10)
		icon:SetHeight(icon.text:GetStringHeight() + 10)
	else
		icon.text:Hide()
		icon.tex:Show()
		icon.tex:SetTexture(r)
		icon:SetWidth(24)
		icon:SetHeight(24)
	end

	return icon
end

-- onCellClick
local function onCellClick(self, button)
	man:OnCellClick(self.row, self.col, button, self.split)
end

local function onCellMouseWheel(self, value)
	man:OnCellClick(self.row, self.col, value > 0 and "MOUSEWHEELUP" or "MOUSEWHEELDOWN", self.split)
end

local function onCellDrag(self)
	man:OnCellDrag(self, self.row, self.col, self.split)
end

local function onCellDragStop(self)
	man:OnCellDragStop(self)
end

local function onCellEnter(self)
	if (man.dragIcon and man.dragIcon:IsShown()) then
		return
	end
	if (man.configuring and self.split) then
		man:HighlightClass(man.expandpanel.class, self.row)
	else
		man:OnCellEnter(self, self.row, self.col)
	end
end

local function onCellLeave(self)
	if (man.dragIcon and man.dragIcon:IsShown()) then
		return
	end
	GameTooltip:Hide()
	man:HighlightClass()
end

-- CreateSplitFrame
function man:SplitCreateFrame()
	if (not ZFrame) then
		ZFrame = LibStub("ZFrame-1.0")
	end
	local f = ZFrame:Create(self, L["SPLITTITLE"], nil, 0.7, 0, 0.7)
	self.splitframe = f
	f.ZMain:SetFrameStrata("DIALOG")

	self.frame.OnClose = function(self)
		local f = man.splitframe
		if (f and f:IsOpen()) then
			f:Close()
		end
		if (man.expandpanel) then
			man.expandpanel:Hide()
		end
	end

	f:SetSize(120, 200)

	local cell = CreateFrame("Button", nil, f)
	f.classIcon = cell
	cell:SetWidth(36)
	cell:SetHeight(36)
	cell:SetNormalTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	cell:EnableMouse(false)
	cell:SetPoint("TOPLEFT")

	f.talentIcon = {}
	local function MakeTalentDescriptor(i)
		local icon
		icon = f:CreateTexture(nil, "BACKGROUND")
		icon:SetPoint("TOPLEFT", cell, "TOPRIGHT", 2, -((i - 1) * 12))
		icon:SetHeight(12)
		icon:SetWidth(12)
		icon:SetTexCoord(0.09375, 0.90625, 0.09375, 0.90625)

		local text = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		text:SetPoint("LEFT", icon, "RIGHT", 2, 0)
		text:SetTextColor(1, 1, 1)

		f.talentIcon[i] = icon
		f.talentIcon[i].text = text
	end

	MakeTalentDescriptor(1)
	MakeTalentDescriptor(2)
	MakeTalentDescriptor(3)

	self.SplitCreateFrame = nil
end

-- SplitInitialize
function man:SplitInitialize()
	local f = self.splitframe
	SetClassIcon(f.classIcon:GetNormalTexture(), f.class)

	self:SplitCreateColumns()

	local columns = self:SplitColumnCount(f.class)
	f:SetSize(120 * columns + 5 * (columns - 1), 200)

	for i = 1,#f.column do
		if (i > columns) then
			f.column[i]:Hide()
		else
			f.column[i]:Show()
		end
	end

	self:SplitTitles()
end

-- SplitColumnCount
function man:SplitColumnCount(class)
	local splits = self.classSplits[class]
	if (splits) then
		local count = 0
		for k,v in pairs(splits) do
			count = count + 1
		end
		return count
	end

	return 1
end

-- SplitTitles
function man:SplitTitles()
	local f = self.splitframe
	local splits = self.classSplits[f.class]
	if (splits) then
		for i,split in ipairs(splits) do
			local column = f.column[i]
			if (not column) then
				error("Missing column number "..i)
			end
			column.title:SetText(split.title)
		end
	else
		if (f.column[1]) then
			f.column[1].title:SetText("")
		end
	end
end

-- splitDragStart
local function splitDragStart(self)
	local r, g, b = self.text:GetTextColor()
	local name = self.text:GetText()
	local drag = man:StartDrag(name, r, g, b)
	drag.row, drag.col = self.row, self.col
	drag.name = name
end

-- splitDragStop
local function splitDragStop(self)
	local icon = man.dragIcon
	if (not icon) then
		return
	end
	icon:Hide()
	
	local f = man.splitframe

	local focus = GetMouseFocus()

	for n = 1,man:SplitColumnCount(f.class) do
		local column = f.column[n]
		if (MouseIsOver(column)) then
			target = n
			break
		end
	end

	if (target and target ~= self.col) then
		man:SplitMovePlayer(icon.name, icon.col, target)
	end
end

-- SplitMovePlayer
function man:SplitMovePlayer(name, from, to)
	local f = self.splitframe
	local codes = self.db.profile.playerCodes
	if (not codes) then
		codes = new()
		self.db.profile.playerCodes = codes
	end
	if (not codes[f.class]) then
		codes[f.class] = new()
	end

	if (to == 1) then
		codes[f.class][name] = nil
	else
		codes[f.class][name] = self.classSplits[f.class][to].code
	end

	if (not next(codes[f.class])) then
		codes[f.class] = del(codes[f.class])
	end
	if (not next(codes)) then
		self.db.profile.playerCodes = del(codes)
	end

	self:SplitPopulate()
end

-- SplitSetIcons
function man:SplitCreateColumns()
	local f = self.splitframe

	if (not f.column) then
		f.column = {}
	end
	for n = 1,self:SplitColumnCount(f.class) do
		local column = f.column[n]
		if (not column) then
			column = CreateFrame("Frame", nil, f)
			f.column[n] = column

			if (n == 1) then
				column:SetPoint("TOPLEFT", 0, -54)
			else
				column:SetPoint("TOPLEFT", f.column[n - 1], "TOPRIGHT", 5, 0)
			end
			column:SetWidth(120)
			column:SetHeight(140)

			column:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 64,
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
				insets = {left = 4, right = 4, top = 4, bottom = 4},
			})
			column:SetBackdropColor(0, 0, 0, 1)
			column:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

			local title = column:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
			column.title = title
			title:SetPoint("BOTTOM", column, "TOP")
			title:SetHeight(14)

			local list = {}
			column.list = list

			for i = 1,10 do
				local line = CreateFrame("Frame", nil, column)
				line.col = n
				line.row = i
				list[i] = line

				line:EnableMouse(true)

				line.icon = line:CreateTexture(nil, "BACKGROUND")
				line.icon:SetPoint("TOPLEFT")
				line.icon:SetWidth(12)
				line.icon:SetHeight(12)
				line.icon:Hide()
				line.icon:SetTexCoord(0.09375, 0.90625, 0.09375, 0.90625)

				line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				line.text:SetJustifyH("LEFT")
				line.text:SetPoint("TOPLEFT", 14, 0)
				line.text:SetPoint("BOTTOMRIGHT")

				if (i == 1) then
					line:SetPoint("TOPLEFT", 5, -5)
				else
					line:SetPoint("TOPLEFT", list[i - 1], "BOTTOMLEFT")
				end

				line:SetWidth(110)
				line:SetHeight(13)

				line.highlight = line:CreateTexture(nil, "HIGHLIGHT")
				line.highlight:SetAllPoints(true)
				line.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
				line.highlight:SetBlendMode("ADD")

				--line:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
				--line:GetHighlightTexture():SetBlendMode("ADD")

				line:RegisterForDrag("LeftButton")
				line:SetScript("OnDragStart", splitDragStart)
				line:SetScript("OnDragStop", splitDragStop)
			end

			if (n == 2) then
				if (not f.autoButton) then
					f.autoButton = self:MakeButton(column, L["Auto Assign"], L["Automatically assign players to sub-classes based on talent spec"], man.SplitAutoAssign)
					f.autoButton:SetPoint("BOTTOM", column, "TOP", 0, 20)
				end
			end
		end
		del(column.members)
		column.members = new()
	end
end

-- SplitClass
function man:SplitClass(class, dontClose)
	-- Create frame
	if (not self.splitframe) then
		self:SplitCreateFrame()
	end
	local f = self.splitframe

	-- Toggle it on OnClick
	if (f:IsOpen()) then
		if (f.class == class and not dontClose) then
			f:Close()
			return
		end
	else
		f:Open()
	end

	f.class = class
	self:SplitInitialize()

	self:SplitPopulate()
end

-- SetTalentNamesAndIcons
local talentIconCache = {}
function man:SetTalentNamesAndIcons(class, remote)
	if (not talentIconCache[class]) then
		local name1, name2, name3, icon1, icon2, icon3
		name1, icon1 = GetTalentTabInfo(1, remote)
		name2, icon2 = GetTalentTabInfo(2, remote)
		name3, icon3 = GetTalentTabInfo(3, remote)
		if (name1 and name2 and name3) then
			talentIconCache[class] = {name1, name2, name3, icon1, icon2, icon3}
		end
	end
end

-- GetTalentNamesAndIcons
function man:GetTalentNamesAndIcons(class)
	local res = talentIconCache[class]
	if (not res) then
		-- Find any of this class we can see to get icon info from
		for unit in roster:IterateRoster() do
			if (unit.class == class and UnitIsVisible(unit.unitid) and (not wow24 or CheckInteractDistance(unit.unitid, 4))) then
				local nothing = z.talentSpecs[unit.name]
				break
			end
		end
	else
		return unpack(res)
	end
end

-- SplitPopulateColumn
function man:SplitPopulateColumn(i)
	local f = self.splitframe
	local column = f.column[i]

	local sortList = new()
	for name in pairs(column.members) do
		tinsert(sortList, name)
	end
	sort(sortList)

	for i,line in ipairs(column.list) do
		line:Hide()
	end

	local c = z:GetClassColour(f.class)
	local j = 1
	for n,name in ipairs(sortList) do
		local line = column.list[n]
		line.text:SetText(name)
		line.text:SetTextColor(c.r, c.g, c.b)

		line.icon:Hide()

		local spec = ZOMGBuffs.talentSpecs[name]
		if (spec and spec[1] and spec[2] and spec[3]) then
			local name1, name2, name3, icon1, icon2, icon3 = self:GetTalentNamesAndIcons(f.class)
			if (name1) then
				local tex
				if (spec[1] > spec[2] and spec[1] > spec[3]) then
					tex = icon1
				elseif (spec[2] > spec[1] and spec[2] > spec[3]) then
					tex = icon2
				elseif (spec[3] > spec[1] and spec[3] > spec[2]) then
					tex = icon3
				end

				if (tex) then
					line.icon:SetTexture(tex)
					line.icon:Show()
				end
			end
		end

		line:Show()
	end

	del(sortList)
end

-- SplitPopulate
function man:SplitPopulate()
	local f = self.splitframe
	if (not f or not f:IsOpen()) then
		return
	end
	local class = f.class

	local splits = self.classSplits[f.class]
	local codes = self.db.profile.playerCodes

	for i,column in ipairs(f.column) do
		column.members = del(column.members)
		column.members = new()
	end

	for unit in roster:IterateRoster() do
		if (unit.class == class and unit.subgroup <= self.db.profile.groups) then
			local code = codes and codes[class] and codes[class][unit.name]

			if (code) then
				local assigned
				for i,split in ipairs(splits) do
					if (split.code == code) then
						f.column[i].members[unit.name] = true
						assigned = true
						break
					end
				end
				if (not assigned) then
					error("Could not assign "..unit.name.." to a column for "..class.." with player code of '"..code.."'")
				end
			else
				f.column[1].members[unit.name] = true
			end
		end
	end

	self:SplitColumnDrawAll()
	self:SplitDrawTalentDescriptors()
end

-- SplitAutoAssign
function man:SplitAutoAssign()
	local f = self.splitframe
	if (not f or not f:IsOpen()) then
		return
	end

	local splitDefs = self.classSplits[f.class]
	if (splitDefs) then
		local z = ZOMGBuffs
		for unit in roster:IterateRoster() do
			if (unit.class == f.class and unit.subgroup <= self.db.profile.groups) then
				local spec = z.talentSpecs[unit.name]
				if (spec and spec[1] and spec[2] and spec[3]) then
					local belongsTo
					for i,def in ipairs(splitDefs) do
						if (def.discover(spec[1], spec[2], spec[3])) then
							belongsTo = i
							break
						end
					end
					if (belongsTo) then
						self:SplitMovePlayer(unit.name, nil, belongsTo)
					end
				end
			end
		end
	end
end

-- SplitDrawTalentDescriptors
function man:SplitDrawTalentDescriptors()
	local f = self.splitframe
	if (not f or not f:IsOpen()) then
		return
	end

	local icon = {}
	local name = {}
	name[1], name[2], name[3], icon[1], icon[2], icon[3] = self:GetTalentNamesAndIcons(f.class)
	for i = 1,3 do
		if (name[i] and icon[i]) then
			f.talentIcon[i]:Show()
			f.talentIcon[i].text:Show()

			f.talentIcon[i]:SetTexture(icon[i])
			f.talentIcon[i].text:SetText(name[i])
		else
			f.talentIcon[i]:Hide()
			f.talentIcon[i].text:Hide()
		end
	end
end

-- SplitColumnDrawAll
function man:SplitColumnDrawAll()
	local f = self.splitframe
	if (f and f:IsOpen()) then
		for i = 1,self:SplitColumnCount(f.class) do
			self:SplitPopulateColumn(i)
		end
	end
end

-- scaleTitleTex
local function scaleTitleTex(icon, scale)
	icon:SetHeight(36 * (scale or 1))
	icon:SetWidth(36 * (scale or 1))
	icon:ClearAllPoints()
	icon:SetPoint("TOPLEFT")
end

-- SplitPositionCells
function man:SplitPositionCells()
	local extraWidth = 0
	for i,class in ipairs(classOrder) do
		local exp = self.expanding and self.expanding[class]
		local size

		local titleCell = self.frame.classTitle.cell[i]
		local nextTitleCell = self.frame.classTitle.cell[i + 1]

		scaleTitleTex(titleCell.normalTex, exp and exp.titleScale)
		scaleTitleTex(titleCell.highlightTex, exp and exp.titleScale)

		if (nextTitleCell) then
			local offset = (exp and exp.offset) or 0
			extraWidth = extraWidth + offset
			nextTitleCell:SetPoint("TOPLEFT", titleCell, "TOPRIGHT", 6 + offset, 0)
		end

		for j,row in ipairs(self.frame.row) do
			local cell = row.cell[i]
			local nextCell = row.cell[i + 1]

			if (nextCell) then
				nextCell:SetPoint("TOPLEFT", cell, "TOPRIGHT", 6 + ((exp and exp.offset) or 0), 0)
			end
		end
	end

	self.frame:SetSize(502 + extraWidth, 318)
end

-- splitExpandOnUpdate
local function splitExpandOnUpdate(self, elapsed)
	local any
	self.inOffset = nil
	for c,d in pairs(man.expanding) do
		if (c == man.expandpanel.inOffsetClass) then
			self.inOffset = d.offset
		end

		if (d.dir ~= "done") then
			local finishedThisOne
			local distanceToMove = min(d.targetOffset, d.targetOffset * elapsed * 2)
			if (d.dir == "in") then
				d.offset = d.offset - distanceToMove
				if (d.offset <= 0) then
					d.offset = 0
					finishedThisOne = true
					d.dir = "done"
					man.expanding[c] = nil
				end

				d.titleScale = min(1, (d.titleScale or 0.7) + elapsed)
			else
				d.offset = d.offset + distanceToMove
				if (d.offset >= d.targetOffset) then
					d.offset = d.targetOffset
					finishedThisOne = true
					d.dir = "done"
				end
				self.outOffset = d.offset

				d.titleScale = max(0.7, (d.titleScale or 1) - elapsed)
			end

			if (not finishedThisOne) then
				any = true
			end
		end

		man:SplitPositionCells()
	end

	-- See how much space we have from d.offset and start fading in one column at a time
	local panel = man.expandpanel
	if (panel) then
		local c = man:SplitColumnCount(panel.class) - 1

		if (panel.targetClass) then
			if (panel.class) then
				local anyFaders
				for i = 1,c do
					local col = panel.column[i]
					local a = col:GetAlpha()
					if (a > 0) then
						if (self.inOffset and (i + 1) * 36 > self.inOffset) then		-- not self.inOffset or
							col:SetAlpha(max(0, a - (elapsed * 6)))
						end
						any = true
						anyFaders = true
					end
				end

				if (not anyFaders) then
					man:SplitPanelSetClass()
					any = true
				end
			else
				man:SplitPanelSetClass()
				any = true
			end
		else
			if (self.outOffset) then
				for i = 1,c do
					local col = panel.column[i]
					if (col) then
						local a = col:GetAlpha()
						if (a < 1) then
							if (self.outOffset > i * 36 - 18) then
								col:SetAlpha(min(1, a + (elapsed * 4)))
							end
							any = true
						end
					end
				end
			end
		end
	end

	if (not any) then
		self:SetScript("OnUpdate", nil)
	end
end

-- CreatePanelTitle
function man:CreatePanelTitle()
	local panel = self.expandpanel
	panel.title1 = panel.column[1]:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	panel.title1:SetPoint("BOTTOM", panel, "TOPLEFT", -24, 5)
	panel.title1:SetHeight(40)
	panel.title1:SetWidth(38)
	panel.title1:SetTextColor(1, 1, 1)
	panel.title1:SetJustifyV("BOTTOM")
	self.CreatePanelTitle = nil
end

-- SplitPanelColumnPopulate
function man:SplitPanelColumnPopulate(col)
	local panel = self.expandpanel
	local class = panel.class
	if (class) then
		for i = 1,6 do
			local Type = self:GetCell(i, col.col, true)
			local cell = col.cell[i]
			if (Type) then
				local singleSpell, classSpell = z:GetBlessingFromType(Type)
				local icon = BabbleSpell:GetSpellIcon(classSpell or singleSpell)

				cell.icon:SetTexture(icon)
				if (self:CellHasError(i, col.col, true)) then
					self.anyErrors = true
					cell.icon:SetVertexColor(1, 0.5, 0.5)
				else
					cell.icon:SetVertexColor(1, 1, 1)
				end
			else
				cell.icon:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")		-- Blank for errors/missing
				cell.icon:SetVertexColor(0, 0, 0)
			end
		end
	end
end

-- SplitPanelSetClass
function man:SplitPanelSetClass()
	local panel = self.expandpanel

	panel.class = panel.targetClass
	panel.targetClass = nil

	if ((self.splitframe and self.splitframe:IsOpen()) or (self.db.profile.autoOpen and (not self.splitframe or not self.splitframe:IsOpen()))) then
		self:SplitClass(panel.class, true)
	end

	local c = self:SplitColumnCount(panel.class) - 1
	for i = 1,c do
		local col = panel.column[i]
		if (col) then
			col:Show()
			col.title:SetText(self.classSplits[panel.class][i + 1].title)
			self:SplitPanelColumnPopulate(col)
		end
	end
	for i = c + 1,#panel.column do
		local col = panel.column[i]
		col:Hide()
	end

	if (not panel.title1) then
		self:CreatePanelTitle()
	end
	if (c > 0) then
		panel.title1:SetText((self.classSplits[panel.class] and self.classSplits[panel.class][1].title) or "")
	else
		panel.title1:SetText("")
	end

	panel:SetWidth(42 * c)

	local ind = classIndex[panel.class]
	local parent = self.frame.classTitle.cell[ind]
	panel:SetPoint("TOPLEFT", parent, "BOTTOMRIGHT", 6, -8)
end

-- SplitCreateExpandPanelColumn
function man:SplitCreateExpandPanelColumns()
	local panel = self.expandpanel
	if (not panel.column) then
		panel.column = {}
	end

	local function CreateColumn(colNumber)
		local col = CreateFrame("Frame", "ZOMGBMExpandColumn"..colNumber, panel)
		panel.column[colNumber] = col
		col.col = colNumber
		col.cell = {}
		col:SetWidth(42)
		col:SetHeight(42 * 6)

		col.title = col:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		col.title:SetPoint("BOTTOM", col, "TOP", -3, 5)
		col.title:SetHeight(40)
		col.title:SetWidth(38)
		col.title:SetTextColor(1, 1, 1)
		col.title:SetJustifyV("BOTTOM")

		if (colNumber == 1) then
			col:SetPoint("TOPLEFT")
		else
			col:SetPoint("TOPLEFT", panel.column[colNumber - 1], "TOPRIGHT")
		end

		local cell
		for i = 1,6 do
			prev = cell

			abCount = abCount + 1
			cell = CreateFrame("Button", "ZOMGActionButton"..abCount, col, "ActionButtonTemplate")
			tinsert(col.cell, cell)
			if (i == 1) then
				cell:SetPoint("TOPLEFT")
			else
				cell:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -6)
			end

			cell.icon = getglobal(cell:GetName().."Icon")
			cell.text = getglobal(cell:GetName().."Text")

			cell.col = colNumber
			cell.row = i
			cell.split = true

			cell:SetHitRectInsets(-4, -4, -4, -4)
			cell:EnableMouseWheel(true)

			cell:SetScript("OnEnter", onCellEnter)
			cell:SetScript("OnLeave", onCellLeave)
			cell:SetScript("OnClick", onCellClick)
			cell:SetScript("OnDragStart", onCellDrag)
			cell:SetScript("OnDragStop", onCellDragStop)
			cell:SetScript("OnMouseWheel", onCellMouseWheel)
			cell:RegisterForDrag("LeftButton")
			cell:RegisterForClicks("AnyUp")
		end
		col:SetAlpha(0)
		return col
	end

	for i = 1,3 do
		local col = panel.column[i]
		if (not col) then
			col = CreateColumn(i)
		end
	end

	self.SplitCreateExpandPanelColumns = nil
end

-- SplitCreateExpandPanel
function man:SplitCreateExpandPanel()
	local panel = CreateFrame("Frame", "ZOMGBMExpandPanel", self.frame)
	self.expandpanel = panel

	self.expandpanel:SetScript("OnHide",
		function(self)
			man:SplitExpand("reset")
			if (self.title1) then
				self.title1:SetText("")
			end
			self.class = nil
			self.targetClass = nil
			for i = 1,3 do
				local col = self.column[i]
				if (col) then
					col:SetAlpha(0)
				end
			end
		end)

	panel:SetHeight(36 * 6 + 20)
	panel:SetWidth(42)

	self.SplitCreateExpandPanel = nil
	return panel
end

-- SplitExpand
function man:SplitExpand(class)
	if (self.dragIcon and self.dragIcon:IsShown()) then
		return
	end

	if (class == "reset") then
		self.frame:SetScript("OnUpdate", nil)
		self.expanding = del(self.expanding)
		self:SplitPositionCells()
		return
	end

	if (not self.configuring) then
		return
	end

	if (not self.expanding) then
		self.expanding = new()
	end
	if (self.expanding[class] and self.expanding[class].dir == "out") then
		return
	end

	for cl,d in pairs(self.expanding) do
		if (cl ~= class) then
			local exp = self.expanding[cl]
			if (exp.dir ~= "in") then
				exp.dir = "in"
			end
		end
	end

	local c = self:SplitColumnCount(class) - 1
	if (c > 0) then
		if (not self.expanding[class]) then
			self.expanding[class] = {dir = "out", cols = c, targetOffset = c * 42, offset = 0}
		else
			self.expanding[class].dir = "out"
		end
	end
	self.frame:SetScript("OnUpdate", splitExpandOnUpdate)

	if (not self.expandpanel) then
		self:SplitCreateExpandPanel()
	end
	self.expandpanel:Show()

	if (self.SplitCreateExpandPanelColumns) then
		self:SplitCreateExpandPanelColumns()
	end

	if (self.expandpanel.class ~= class) then
		self.expandpanel.targetClass = class
		if (self.expandpanel.class) then
			local c1 = self:SplitColumnCount(self.expandpanel.class)
			if (c1 > 1) then
				self.expandpanel.inOffsetClass = self.expandpanel.class
			else
				self:SplitPanelSetClass()
			end
		else
			self:SplitPanelSetClass()
		end
	else
		self.expandpanel.targetClass = nil
	end
end

-- AssignPaladins
-- Create a self.pala list
-- Each entry contains the row number for display, and their part of the template
function man:AssignPaladins()
	local names, oldNames = {}, {}
	local groups = self.db.profile.groups
	for unit in roster:IterateRoster() do
		if (unit.class == "PALADIN" and unit.subgroup <= groups) then
			tinsert(names, unit.name)
		end
	end
	sort(names)

	if (not self.pala) then
		self.pala = {}
	else
		for palaName,info in pairs(self.pala) do
			oldNames[palaName] = true
		end
	end

	-- Make unique initials for the paladins we have
	-- If first two letters match something we already
	-- have, then take first and last, then try first
	-- plus each letter thru name until unique one found
	local temp = new()
	for i,name in ipairs(names) do
		local n = name:sub(1, 2)
		if (temp[n]) then
			n = name:sub(1,1) .. name:sub(-1, -1)
			if (temp[n]) then
				for i = 3,strlen(name) - 1 do
					n = name:sub(1,1) .. name:sub(i, i)
					if (not temp[n]) then
						break
					end
				end
			end
		end
		temp[n] = name
	end
	local initials = new()
	for ini,ori in pairs(temp) do
		initials[ori] = ini
	end
	del(temp)

	del(self.paladinOrder)
	self.paladinOrder = names

	for k,v in ipairs(names) do
		oldNames[v] = nil
		if (self.pala[v]) then
			self.pala[v].row = k
		else
			self.pala[v] = {
				row = k,
				template = {}
			}
		end
		local pala = self.pala[v]
		pala.initials = initials[v]

		local unit = roster:GetUnitObjectFromName(v)
		if (not UnitIsConnected(unit.unitid)) then
			pala.offline = true
		else
			local t = ZOMGBuffs.talentSpecs and ZOMGBuffs.talentSpecs[v]
			if (t) then
				pala.canKings = t.canKings
				pala.canSanctuary = t.canSanctuary
				pala.improvedWisdom = t.impWisdom
				pala.improvedMight = t.impMight
				pala.spec = {t[1], t[2], t[3]}
			end
			if (not pala.gotCapabilities) then
				z:SendComm(v, "REQUESTCAPABILITY", nil)
				z:SendComm(v, "REQUESTSPEC", nil)
				z:SendComm(v, "REQUESTTEMPLATE", nil)
				if (pala.canEdit == nil) then
					pala.canEdit = false
				end

				local ver = ZOMGBuffs.versionRoster and ZOMGBuffs.versionRoster[v]
				if (ver) then
					if (type(ver) == "string" and strfind(ver, "PallyPower")) then
						pala.gotCapabilities = true
						pala.canEdit = true
						if (ZOMGBlessingsPP) then
							ZOMGBlessingsPP:Announce()
						end
					end
				end
			end
		end
	end
	self.paladins = #names
	
	for name in pairs(oldNames) do
		del(self.pala[name])
		self.pala[name] = nil
	end

	ZOMGBuffs:DrawGroupNumbers()			-- Update the names on paladin columns

	del(initials)
	del(oldNames)
	
	if (self.replyQueue and next(self.replyQueue)) then
		for name,msg in pairs(self.replyQueue) do
			self:BuffResponse(name, msg)
		end
		self.replyQueue = nil
	end
end

-- OnReceiveTemplate
-- A paladin has changed their template, so we receive that and update it into our display
function man:OnReceiveTemplate(sender, template, modified)
	-- Paladin changed their template, so we'll reflect this in the manager

	local pala = self.pala and self.pala[sender]
	if (pala) then
		pala.template = copy(template)
		pala.template.modified = nil

		local def = pala.template.default
		pala.template.default = nil
		if (def) then
			for k,v in pairs(classOrder) do
				if (not pala.template[v]) then
					pala.template[v] = def
				end
			end
		end

		pala.modified = modified and true		-- Flagged when a paladin changes their own template
		pala.canEdit = true
		if (self.frame and self.frame:IsOpen()) then
			self:DrawAll()
		end
	--else
	--	if (z.db.profile.info) then
	--		self:Print("Got template change from unrecognised player (%s)", z:ColourUnitByName(sender))
	--	end
	end
end

-- OnReceiveMasterTemplate
function man:OnReceiveMasterTemplate(sender, newTemplate)
	local i = 1
	local templates = self.db.profile.templates
	local name
	while true do
		name = format("Received_%03d", i)
		if (not templates[name]) then
			break
		end
		i = i + 1
	end

	if (name) then
		newTemplate.modified = nil
		templates[name] = copy(newTemplate)
		self:MakeTemplateOptions()

		self:Print(L["Blessings Manager master template received from %s. Stored in local templates as |cFFFFFF80%s|r"], z:ColourUnitByName(sender), name)
	end
end

-- OnReceiveSubClassDefinitions
function man:OnReceiveSubClassDefinitions(sender, playerCodes)
	local codes = self.db.profile.playerCodes
	if (not codes) then
		self.db.profile.playerCodes = copy(playerCodes)
	else
		for class,list in pairs(playerCodes) do
			for name,code in pairs(list) do
				if (not codes[class]) then
					codes[class] = {}
				end
				codes[class][name] = code
			end
		end
	end
	self:Print(L["Player sub-class assignments received from %s"], z:ColourUnitByName(sender))
end

-- OnReceiveSymbolCount
function man:OnReceiveSymbolCount(sender, count)
	local pala = self.pala and self.pala[sender]
	if (pala) then
		pala.symbols = count
		self:DrawPaladinByName(sender)
	end
end

-- ClearCells
function man:ClearCells()
	for k,v in pairs(self.pala) do
		v.template = {}
	end
end

-- Generate
function man:Generate()
	if (self.canEdit) then
		self:AssignTemplateToPaladins()
		self:BroadcastTemplates()
		self:DrawAll()

		z:Log("man", nil, "gen")
	end
end

-- GetCodeIndex
function man:GetCodeIndex(class, code)
	local splits = self.classSplits[class]
	if (splits) then
		for i,info in ipairs(splits) do
			if (info.code == code) then
				return i
			end
		end
	end
end

-- GetSplitClassCounts
function man:GetSplitClassCounts()
	local ret = new()
	local codes = self.db.profile.playerCodes

	for unit in roster:IterateRoster() do
		if (unit.subgroup <= self.db.profile.groups) then
			local class = unit.class
			local name = unit.name
			local code = codes and codes[class] and codes[class][name]

			if (not ret[class]) then
				local splits = self.classSplits[class]
				if (splits) then
					ret[class] = new()
					for i = 1,#splits do
						tinsert(ret[class], 0)
					end
				else
					ret[class] = new(0)
				end
			end
			local c = ret[class]

			if (code) then
				local codeIndex = self:GetCodeIndex(class, code)
				if (not codeIndex) then
					self:Print("%s has code '%s', but there is not code definitions for his class", z:ColourUnitByName(name), code)
					c[1] = c[1] + 1
				else
					c[codeIndex] = c[codeIndex] + 1
				end
			else
				c[1] = c[1] + 1
			end
		end
	end

	return ret
end

-- FillNFromList
function man:FillNFromList(dest, source, n, kingList, sancList, needBOL)
	local got, i = 0, 1

	local copyKings = copy(kingList)
	local copySanc = copy(sancList)
	
	while (got < n) do
		local Type = source[i]
		if (Type) then
			--if ((Type == "BOK" and canK) or (Type == "SAN" and canS) or (Type ~= "BOK" and Type ~= "SAN")) then
			local ok
			if (Type == "BOK" or Type == "SAN") then
				-- We need to see if we have enough people to do kings + sanc if it's required,
				-- else exclude the second priority buff if not
				-- This covers occasions like having 2 palas, only 1 can do Kings+Sanc, and both buffs are wanted.
				local countK, countS = 0, 0
				local firstK, firstS
				for name in pairs(copyKings) do
					firstK = name
					countK = countK + 1
				end
				for name in pairs(copySanc) do
					firstS = name
					countS = countS + 1
				end
				if (countK == 1 and countS == 1) then
					if (firstK == firstS) then
						-- We have 1 paladin that can do Kings and Sanc, so we'll lose one of the buffs
						if (Type == "BOK") then
							if (copySanc[firstK]) then
								copySanc[firstK] = nil
								countS = countS - 1
							end
						else
							if (copyKings[firstS]) then
								copyKings[firstS] = nil
								countK = countK - 1
							end
						end
					end
				end

				if ((Type == "BOK" and countK > 0) or (Type == "SAN" and countS > 0)) then
					ok = true
				end
			elseif (Type == "BOL") then
				if (needBOL) then
					ok = true
				else
					if (not self.bolWarned) then
						self.bolWarned = true
						self:Print(L["%s skipped because no %s present"], z:ColourBlessing("BOL"), z:ColourClass("PALADIN", L["Holy"]))
					end
				end
			else
				ok = true
			end

			if (ok) then
				got = got + 1
				dest[Type] = got
			end
		else
			break
		end
		i = i + 1
	end
	
	del(copyKings)
	del(copySanc)
end

-- CanKingsCanSanc
function man:CanKingsCanSanc()
	local canK, canS, kingList, sancList
	kingList = new()
	sancList = new()
	for k,v in pairs(self.pala) do
		if (v.canKings) then
			canK = true
			kingList[k] = true
		end
		if (v.canSanctuary) then
			canS = true
			sancList[k] = true
		end
	end

	return canK, canS, kingList, sancList
end

-- GetPopularSubClass
function man:GetPopularSubClass(class, scc)
	local popularSubClass = 1
	local counts = scc[class]			-- Work out which sub-class is the most popular.
	if (counts) then					-- Note that this is the most popular from who is currently in the raid
		local max = 0					-- and this may well change if other people from other sub-classes join
		for i,num in ipairs(counts) do	-- the raid later. This is a minor issue we can discard.
			if (num > max) then			-- The only problem will be if the most popular is not the first type
				popularSubClass = i		-- and members join later who are of first type, who would have needed exceptions
				max = num
			end
		end
	end
	
	return popularSubClass
end

-- GetRelavantTemplatePart
function man:GetRelavantTemplatePart()
	-- For the split version, we check which is the most common sub-class per class, and make that the group blessing
	-- Then create on-the-fly exceptions for all the less populated sub-classes
	if (not template) then
		return
	end

	self.bolWarned = nil
	local scc = self:GetSplitClassCounts()
	local needBOL = scc.PALADIN and scc.PALADIN[1] > 0
	local p = self.paladins
	local canK, canS, kingList, sancList = self:CanKingsCanSanc()
	local ret = new()
	
	for classNo,class in ipairs(classOrder) do
		local index = self:GetPopularSubClass(class, scc)

		if (not ret[class]) then
			ret[class] = new()
		end

		if (index > 1) then
			local subclassList = self.db.profile.templates.current.subclass
			if (subclassList) then
				local subclass = subclassList[class]
				if (subclass) then
					-- subclass will contain a list if codes, with attached buff definitions
					local splits = self.classSplits[class]
					if (splits) then
						local code = splits[index].code
						self:FillNFromList(ret[class], subclass[code], p, kingList, sancList, needBOL)
					else
						error("Wanted codes for %s, but they don't exist in self.classSplits", class)
					end
				else
					index = 1	-- No alternatives defined for this class
				end
			else
				index = 1		-- No alternatives defined for this class
			end
		end

		if (index == 1) then
			self:FillNFromList(ret[class], template[class], p, kingList, sancList, needBOL)
		end
		self.bolWarned = nil

		-- Build exceptions for this class based on which subclasses we have
		local codes = self.db.profile.playerCodes
		if (codes and self.classSplits and self.classSplits[class]) then
			local e = ret.exceptions
			if (not e) then
				e = new()
				ret.exceptions = e
			end

			local groupBuffCode
			if (index > 1) then
				groupBuffCode = self.classSplits[class][index].code
			else
				groupBuffCode = " "
			end

			local codeIndex = new()
			for i = 1,#self.classSplits[class] do
				codeIndex[self.classSplits[class][i].code or " "] = i
			end

			-- We need all codes, even ones in sub-class 1, which are implied by their absence
			local c = codes[class]
			local tempCodes = (c and copy(c)) or new()
			for unit in roster:IterateRoster() do
				if (unit.class == class) then
					if (not tempCodes[unit.name]) then
						tempCodes[unit.name] = " "
					end
				end
			end

			-- Insert any players from subclass types (whether in raid or not)
			for name,code in pairs(tempCodes) do
				if (code ~= groupBuffCode) then
					if (not e[class]) then
						e[class] = new()
					end
					local ind = codeIndex[code or " "]

					local source
					if (ind == 1) then
						source = template[class]
					else
						source = template.subclass[class][code]
					end
					if (source) then
						local got, i = 0, 1
						while (got < p) do
							local Type = source[i]
							if (Type) then
								if ((Type == "BOK" and canK) or (Type == "SAN" and canS) or (Type ~= "BOK" and Type ~= "SAN")) then
									got = got + 1
									if (not e[class][got]) then
										e[class][got] = new()
									end
									e[class][got][name] = Type
								end
							else
								break
							end
							i = i + 1
						end
					end
				end
			end

			del(tempCodes)
			del(codeIndex)
		end
	end

	del(kingList)
	del(sancList)
	deepDel(scc)

	if (ret.exceptions and not next(ret.exceptions)) then
		ret.exceptions = del(ret.exceptions)
	end

	return ret
end

-- DupRow
function man:DupRow(small, pala, class, buff)
	-- Here we'll now put the same buff for the same paladin wherever possible
	-- merely to make it look clearer in the manager, and so people can easier
	-- identify which pala does which buffs
	for class,list in pairs(small) do
		if (not pala.template[class]) then
			if (list[buff]) then
				pala.template[class] = buff
				list[buff] = nil
			end
		end
	end
end

-- SyncGroupCount
function man:SyncGroupCount()
	z:SendCommMessage("GROUP", "SYNCGROUPS", self.db.profile.groups)
end

-- AssignTemplateToPaladins
-- TODO - Recode all of this, it still relies on legacy code from early
-- alphas that had per player exception setup in main template
function man:AssignTemplateToPaladins()
	local p = self.paladins
	if (p == 0) then
		return
	end

	self:SyncGroupCount()
	if (z.db.profile.info) then
		self:Print(L["Generating Blessing Assignments for groups 1 to %d"], self.db.profile.groups)
	end
	
	local kingCount, sancCount = 0, 0
	local canKings = new()
	local canSanctuary = new()
	local palaList = new()
	for k,pala in pairs(self.pala) do
		if (pala.canKings) then
			kingCount = kingCount + 1
			canKings[k] = true
		end
		if (pala.canSanctuary) then
			sancCount = sancCount + 1
			canSanctuary[k] = true
		end
		tinsert(palaList, k)
	end
	sort(palaList)

	if (#palaList == 0) then
		-- Nothing to do
		del(palaList)
		del(canKings)
		del(canSanctuary)
		return
	end

	self:ClearCells()
	local small = self:GetRelavantTemplatePart()
	local smallCopy = copy(small)

	local function HowManyMoreCanDo(buff, startPala)
		local count = 0
		for i = startPala,#palaList do
			local pala = self.pala[palaList[i]]

			if (buff == "BOK") then
				if (pala.canKings) then
					count = count + 1
				end
			elseif (buff == "SAN") then
				if (pala.canSanctuary) then
					count = count + 1
				end
			end
		end
		return count
	end
	
	-- First pass will assign certain blessings to paladins based on talent spec (kings, sanctuary, imp wisdom, imp might)
	for i,palaName in ipairs(palaList) do
		local pala = self.pala[palaName]
		pala.template = {}

		for class,list in pairs(small) do
			if (pala.canSanctuary and list.SAN and (sancCount == 1 or not pala.canKings or kingCount > 1 or not list.BOK)) then
				list.SAN = nil
				pala.template[class] = "SAN"
			elseif (pala.canKings and list.BOK and (kingCount == 1 or (HowManyMoreCanDo("BOK", i + 1) == 0 or ((not list.BOM or pala.improvedMight == 0) and (not list.BOW or pala.improvedWisdom == 0))))) then
				list.BOK = nil
				pala.template[class] = "BOK"
			elseif ((kingCount > 1 or not pala.canKings or not list.BOK) and (sancCount > 1 or not pala.canSanctuary or not list.SAN)) then
				if ((pala.improvedMight or 0) > 0 and list.BOM) then
					list.BOM = nil
					pala.template[class] = "BOM"
				elseif ((pala.improvedWisdom or 0) > 0 and list.BOW) then
					list.BOW = nil
					pala.template[class] = "BOW"
				end
			end
		end

		if (pala.canKings and canKings[palaName]) then
			canKings[palaName] = nil
			kingCount = kingCount - 1
		end
		if (pala.canSanctuary and canSanctuary[palaName]) then
			canSanctuary[palaName] = nil
			sancCount = sancCount - 1
		end
	end

	-- Second pass to do improved wisdom and might that we missed first time
	for i,palaName in ipairs(palaList) do
		local pala = self.pala[palaName]
		pala.canEdit = true

		for class,list in pairs(small) do
			if (not pala.template[class]) then
				if ((pala.improvedMight or 0) > 0 and list.BOM) then
					list.BOM = nil
					pala.template[class] = "BOM"
					self:DupRow(small, pala, class, "BOM")
				elseif ((pala.improvedWisdom or 0) > 0 and list.BOW) then
					list.BOW = nil
					pala.template[class] = "BOW"
					self:DupRow(small, pala, class, "BOW")
				end
			end
		end
	end

	-- Third pass to give out the remaining ones
	for j,class in ipairs(classOrder) do
		for i,palaName in ipairs(palaList) do
			local pala = self.pala[palaName]
			if (not pala.template[class]) then
				local list = small[class]
				local canK, canS, impM, impW = pala.canKings, pala.canSanctuary, pala.improvedMight, pala.improvedWisdom
				for buff in pairs(list) do
					if ((buff == "BOK" and canK) or (buff == "SAN" and canS) or (buff ~= "BOK" and buff ~= "SAN")) then
						pala.template[class] = buff
						list[buff] = nil
						self:DupRow(small, pala, class, buff)
						break
					end
				end
			end
		end
	end

	deepDel(small)					-- Should be empty anyway

	-- Now, we'll go through any single exceptions
	-- A lot of this involves comparing the desired buffs with the wanted exceptions.
	-- In the case of re-ordered buffs that would ultimately end up being the same, we can just skip the exceptions.
	-- ie: We have 2 paladins and the template for paladins says BOW, BOS and one paladin is defined as BOS, BOW
	--	then we just skip the exceptions because the result is the same
	small = smallCopy
	local e = (split and small.exceptions) or template.exceptions
	if (e) then
		--self:Print("Exceptions")
		for class,list in pairs(e) do
			--self:Print("- "..class)

			-- Build a list of all players with exceptions for this class, we only want to do each player once
			local playerList = new()
			for row,players in pairs(list) do
				for name,Type in pairs(players) do
					playerList[name] = true
				end
			end

			local swapList

			for playerName in pairs(playerList) do
				--self:Print("--  "..z:ColourUnitByName(playerName))

				-- Build a list of what this player wants as buffs
				local wants = new()
				local dontReplace = new()
				for row = 1,p do
					-- Buff type to be replaced by this exception
					local buff = (list[row] and list[row][playerName]) or (small[row] and small[row][class])
					if (buff) then
						--self:Print("--- wants "..z:ColourBlessing(buff))
						wants[buff] = true
					end
				end

				-- Now delete any that they're already going to get as class buffs
				for buff2 in pairs(small[class]) do
					if (wants[buff2]) then
						--self:Print("---- Already getting: "..z:ColourBlessing(buff2))
						wants[buff2] = nil
						dontReplace[buff2] = true
					end
				end

				-- First pass will assign BOK and SAN where needed
				for i,palaName in ipairs(palaList) do
					local pala = self.pala[palaName]
					local thisPalasBuff = pala.template[class]

					if (not dontReplace[thisPalasBuff]) then
						if (pala.canKings and wants.BOK) then
							wants.BOK = nil
							pala.template[playerName] = "BOK"
						elseif (pala.canSanctuary and wants.SAN) then
							wants.SAN = nil
							pala.template[playerName] = "SAN"
						end
					end
				end

				-- Second pass to give out Imp Might/Wis where possible to appropriate paladins
				for i,palaName in ipairs(palaList) do
					local pala = self.pala[palaName]
					if (not pala.template[playerName]) then
						local thisPalasBuff = pala.template[class]

						if (not dontReplace[thisPalasBuff]) then
							if ((pala.improvedMight or 0) > 0 and wants.BOM) then
								wants.BOM = nil
								pala.template[playerName] = "BOM"
							elseif ((pala.improvedWisdom or 0) > 0 and wants.BOW) then
								wants.BOW = nil
								pala.template[playerName] = "BOW"
							end
						end
					end
				end

				-- Finally, go through what's left and fill them in
				for i,palaName in ipairs(palaList) do
					local pala = self.pala[palaName]
					if (not pala.template[playerName]) then
						local thisPalasBuff = pala.template[class]

						if (not dontReplace[thisPalasBuff]) then
							for buff in pairs(wants) do
								if ((buff == "BOK" and pala.canKings) or (buff == "SAN" and pala.canSanctuary) or (buff ~= "BOK" and buff ~= "SAN")) then
									--self:Print("        Assigned "..z:ColourBlessing(buff).." to Paladin "..z:ColourUnitByName(palaName))
									pala.template[playerName] = buff
									wants[buff] = nil
									break
								end
							end
						end
					end
				end

				if (next(wants)) then -- and roster:GetUnitObjectFromName(playerName)) then
					for buff in pairs(wants) do
					--self:Print("Didn't match %s's %s on first pass", z:ColourUnitByName(playerName), z:ColourBlessing(buff))
						if (buff == "BOK" or buff == "SAN") then
							for i,palaName in ipairs(palaList) do
								local pala = self.pala[palaName]
								local thisPalasBuff = pala.template[class]
								local changed
					--z.PrintLiteral(self, "dontReplace", dontReplace, "thisPalasBuff", thisPalasBuff, "buff", buff)

								if ((buff == "BOK" and pala.canKings) or (buff == "SAN" and pala.canSanctuary)) then
									-- Reallocate previously assigned buff to match up with exception

					--self:Print(" Want to reallocate %s's %s to %s who is currently doing %s as main buff", z:ColourUnitByName(playerName), z:ColourBlessing(buff), z:ColourUnitByName(palaName), z:ColourBlessing(thisPalasBuff))

									-- First see if we can simply re-allocate the current exceptions without breaking any previously assigned ones
									for j,palaName2 in ipairs(palaList) do
										local pala2 = self.pala[palaName2]

										if (pala2 ~= pala and pala2.template[class] and not dontReplace[pala2.template[class]]) then
											if ((thisPalasBuff == "BOK" and pala2.canKings) or (thisPalasBuff == "SAN" and pala2.canSanctuary) or (thisPalasBuff ~= "BOK" and thisPalasBuff ~= "SAN")) then
					--self:Print("  Potential target: %s", z:ColourUnitByName(palaName2))
												local fail
												if (pala2.template.exceptions) then
													-- See if the new target paladin can do the exceptions already given to old paladin
													for exName,exBuff in pairs(pala2.template.exceptions) do
														if ((exBuff == "BOK" and not pala2.canKings) or (exBuff == "SAN" and not pala2.canSanctuary)) then
															if (exBuff == "BOK" and not pala2.canKings) then
																fail = z:ColourUnitByName(palaName2).." can't do BOK"
															else
																fail = z:ColourUnitByName(palaName2).." can't do SANCTUARY"
															end
															break
														end
													end
												end

												if (not fail) then
													if (swapList and swapList[palaName] and swapList[palaName][class]) then
					--self:Print("  Already swapped buffs for %s and %s", z:ColourUnitByName(palaName), z:ColourUnitByName(palaName2))
													else
					--self:Print("  Swapping main buffs for %s and %s", z:ColourUnitByName(palaName), z:ColourUnitByName(palaName2))
														pala.template[class] = pala2.template[class]
														pala2.template[class] = thisPalasBuff
														if (not swapList) then
															swapList = new()
														end
														if (not swapList[palaName]) then
															swapList[palaName] = new()
														end
														swapList[palaName][class] = true

					--self:Print("  Swapping exceptions %s and %s", z:ColourUnitByName(palaName), z:ColourUnitByName(palaName2))
														if (pala.template or pala2.template) then
															local temp = new()
															if (pala2.template) then
																for exName, exBuff in pairs(pala2.template) do
																	if (exName == playerName) then
					--self:Print("1: Re-Added want of %s for %s", exBuff, playerName)
																		wants[exBuff] = true
																		pala2.template[exName] = nil
																	else
																		local c = self:GetClassFromCodesList(exName)
																		local unit = not c and roster:GetUnitObjectFromName(exName)
																		if (c == class or (unit and unit.class == class)) then
					--self:Print("  Moving %s's exception for %s from %s to temp", z:ColourUnitByName(exName), z:ColourBlessing(exBuff), z:ColourUnitByName(palaName2))
																			temp[exName] = exBuff
																			pala2.template[exName] = nil
																		end
																	end
																end
															end
														if (pala.template) then
																for exName, exBuff in pairs(pala.template) do
																	if (exName == playerName) then
					--self:Print("2: Re-Added want of %s for %s", exBuff, playerName)
																		wants[exBuff] = true
																		pala.template[exName] = nil
																	else
																		local c = self:GetClassFromCodesList(exName)
																		local unit = not c and roster:GetUnitObjectFromName(exName)
																		if (c == class or (unit and unit.class == class)) then
					--self:Print("  Moving %s's exception for %s from %s to %s", z:ColourUnitByName(exName), z:ColourBlessing(exBuff), z:ColourUnitByName(palaName), z:ColourUnitByName(palaName2))
																			if (not pala2.template) then
																				pala2.template = new()
																			end
																			pala2.template[exName] = exBuff
																			pala.template[exName] = nil
																		end
																	end
																end
															end
															for exName, exBuff in pairs(temp) do
																local c = self:GetClassFromCodesList(exName)
																local unit = not c and roster:GetUnitObjectFromName(exName)
																if (c == class or (unit and unit.class == class)) then
					--self:Print("  Moving %s's exception for %s from temp to %s", z:ColourUnitByName(exName), z:ColourBlessing(exBuff), z:ColourUnitByName(palaName))
																	if (not pala.template) then
																		pala.template = new()
																	end
																	pala.template[exName] = exBuff
																end
															end
														end
													end

													if (pala.template[playerName]) then
														-- New want, because it's just been replaced in the swap
														wants[pala.template[playerName]] = true
					--self:Print("3: Re-Added want of %s for %s", pala.template[playerName], playerName)
													end
													pala.template[playerName] = buff
													wants[buff] = nil

													changed = true
													break
					--else
					--self:Print("   Potential failed because %s", fail)
												end
											end
										end
									end
								end
								if (changed) then
									break
								end
							end
						end
					end

					if (next(wants)) then
						-- Now go through what we need and make assignments
						for i,palaName in ipairs(palaList) do
							local pala = self.pala[palaName]
							local thisPalasBuff = pala.template[class]

							if (not dontReplace[thisPalasBuff] and not pala.template[playerName]) then
								for buff in pairs(wants) do
									if ((buff == "BOK" and pala.canKings) or (buff == "SAN" and pala.canSanctuary) or (buff ~= "BOK" and buff ~= "SAN")) then
										pala.template[playerName] = buff
										wants[buff] = nil
										break
									end
								end
							end
						end

						-- Something left over because an exception tried to end up on a pala who can't cast it
						if (roster:GetUnitObjectFromName(playerName)) then
							for buff in pairs(wants) do
								self:Print("|cffff8080WARNING|r Didn't allocate %s to %s", z:ColourBlessing(buff), z:ColourUnitByName(playerName))
							end
						end
					end
				end

				del(wants)
				del(dontReplace)
			end

			del(playerList)
			deepDel(swapList)
		end
	end

	deepDel(small)
	del(palaList)
	del(canKings)
	del(canSanctuary)
end

-- GetClassFromCodesList
function man:GetClassFromCodesList(find)
	for class,list in pairs(self.db.profile.playerCodes) do
		for name,code in pairs(list) do
			if (name == find) then
				return class
			end
		end
	end
end

-- BroadcastTemplatePart
function man:BroadcastTemplatePart(name, class, Type)
	if (playerClass == "PALADIN" or IsRaidLeader() or IsRaidOfficer()) then
		if (ZOMGBlessingsPP) then
			ZOMGBlessingsPP:GiveTemplatePart(name, class, Type)
		end
		z:SendCommMessage("GROUP", "GIVETEMPLATEPART", name, class, Type)
		if (name == playerName) then
			man:OnReceiveBroadcastTemplatePart(name, name, class, Type)

			ZOMGBlessings:ModifyTemplate(class, Type)
		end
	end
end

-- OnReceiveTemplatePart
function man:OnReceiveBroadcastTemplatePart(sender, name, class, buff)
	local unit = roster:GetUnitObjectFromName(sender)
	if (unit and unit.class == "PALADIN" or unit.rank > 0 or (sender == name)) then
		local pala = self.pala[name]
		if (pala) then
			pala.template[class] = buff
			self:DrawIconsByName(name)
			if (name == playerName) then
				ZOMGBlessings:ModifyTemplate(class, buff)
			end
		end
	end
end

-- OnReceiveTemplatePart
-- PallyPower support only
function man:OnReceiveTemplatePart(sender, classOrName, spell)
	local pala = self.pala and self.pala[sender]
	if (pala) then
		pala.template[classOrName] = spell
		if (self.frame and self.frame:IsOpen()) then
			self:DrawAll()
		end
	end
end

-- GiveTemplate
function man:GiveTemplate(name, quiet, playerRequested)
	if (playerClass == "PALADIN" or IsRaidLeader() or IsRaidOfficer()) then
		local pala = self.pala[name]
		if (pala) then
			local unit = roster:GetUnitObjectFromName(name)

			if (ZOMGBlessingsPP) then
				-- PallyPower assignments are broadcast over the RAID/PARTY addon channels, instead of via whisper, so always send them
				ZOMGBlessingsPP:GiveTemplate(name, pala.template)
			end

			if (unit and UnitIsConnected(unit.unitid)) then
				local v = z.versionRoster[name]
				if (v) then
					if (type(v) ~= "string" and not strfind(v, "PallyPower")) then
						if (unit and unit.class == "PALADIN") then
							z:SendComm(name, "GIVETEMPLATE", pala.template, quiet, playerRequested)
							pala.waitingForAck = GetTime()
							self:DrawPaladinByName(name)
						end
					end
				elseif (self.db.profile.whispers) then
					-- They don't have the mod, so ask them to do this instead
					SendChatMessage(format(L["%s %s, Please use these buff settings:"], z.chatAnswer, name), "WHISPER", nil, name)

					for i,Type in ipairs(blessingCycle) do
						local str
						for j,class in ipairs(classOrder) do
							if (pala.template[class] == Type) then
								if (str) then
									str = str..", "..class
								else
									str = format("%s %s : %s", z.chatAnswer, z:GetBlessingFromType(Type), class)
								end
							end
						end
						if (str) then
							SendChatMessage(str, "WHISPER", nil, name)
						end
					end

					local ex

					for k,v in pairs(pala.template) do
						if (k ~= "modified" and k ~= "state" and not classIndex[k]) then
							local unit = roster:GetUnitObjectFromName(k)
							if (unit) then
								if (not ex) then
									ex = new()
								end
								if (ex[v]) then
									tinsert(ex[v], k)
								else
									ex[v] = new(k)
								end
							end
						end
					end

					if (ex) then
						SendChatMessage(format(L["%s And these single buffs afterwards:"], z.chatAnswer), "WHISPER", nil, name)

						for k,v in pairs(ex) do
							SendChatMessage(format("%s %s : %s", z.chatAnswer, z:GetBlessingFromType(k), table.concat(v, ", ")), "WHISPER", nil, name)
						end

						deepDel(ex)
					end
				end
			elseif (z.db.profile.info) then
				self:Print(L["%s is offline, template not sent"], z:ColourUnitByName(name))
			end
		end
	end
end

-- GiveAllTemplates
function man:GiveAllTemplates()
	if (ZOMGBlessingsPP) then
		ZOMGBlessingsPP:SignalClear()
	end
	for name in pairs(self.pala) do
		self:GiveTemplate(name)
	end
end

-- MakeButton
function man:MakeButton(parent, text, tooltip, func)
	local b = CreateFrame("Button", nil, parent, "OptionsButtonTemplate")
	b:GetRegions():SetAllPoints(b)			-- Makes the text part (first region) fit all over button, instead of just centered and fuxed when scaled
	b.func = func
	b:SetScript("OnClick", onButtonClick)
	b:SetScript("OnEnter", onButtonEnter)
	b:SetScript("OnLeave", onButtonLeave)
	b:SetText(text)
	b.tooltipText = tooltip
	b:SetWidth(max(80, b:GetRegions():GetStringWidth() + 25))
	--b:SetFrameLevel(main:GetFrameLevel() + 1)
	return b
end

-- CreateMainMainFrame
function man:CreateMainMainFrame()
	if (not ZFrame) then
		ZFrame = LibStub("ZFrame-1.0")
	end
	local main = ZFrame:Create(self, L["TITLE"], "ZOMGBMFrame", 1, 0.5, 0.1)
	self.frame = main

	main.OnClick = function(self, button)
		if (button == "RightButton") then
			dewdrop:Open(man.frame, "children", man.options, 'cursorX', true, 'cursorY', true)
		else
			dewdrop:Close()
		end
	end

	local prevButton, rightButtons
	local function AddButton(text, tooltip, func)
		local b = self:MakeButton(main, text, tooltip, func)
		if (not prevButton) then
			if (rightButtons) then
				b:SetPoint("BOTTOMRIGHT")
			else
				b:SetPoint("BOTTOMLEFT")
			end
		else
			if (rightButtons) then
				b:SetPoint("TOPRIGHT", prevButton, "TOPLEFT", -5, 0)
			else
				b:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 5, 0)
			end
		end
		prevButton = b
		return b
	end

	main.configure	= AddButton(L["Configure"],	L["Configure the automatic template generation"], man.ToggleConfigure)
	main.help		= AddButton(L["Help"],		L["What the hell am I looking at?"], man.Help)

	prevButton = nil
	rightButtons = true
	main.generate	= AddButton(L["Generate"],	L["Generate automatic templates from manager's main template. This will broadcast new templates to all paladins, so only use at start of raid to set initial configuration. Changes made later by individual paladins will be reflected in the blessings grid."], man.Generate)
	main.broadcast	= AddButton(L["Broadcast"],	L["Broadcast these templates to all paladins (Simply a refresh)"], man.BroadcastTemplates)
	main.groups		= AddButton("8 Groups",		L["Change how many groups are included in template generation and Paladin inclusion"], man.GroupsMenu)

	main.classTitle = CreateFrame("Frame", "ZOMGBMClassTitle", main)
	main.classTitle.cell = {}
	main.classTitle:SetPoint("TOPLEFT")
	main.classTitle:SetPoint("BOTTOMRIGHT", main, "TOPRIGHT", 0, -40)

	local splitFunc, splitExpandFunc, splitOnLeaveFunc
	splitFunc = function(self)
		man:SplitClass(self.class)
	end
	splitExpandFunc = function(self)
		if (man.dragIcon and man.dragIcon:IsShown()) then
			return
		end
		man:SplitExpand(self.class)
		man:HighlightClass(self.class)
		if (not man.configuring and man.splitframe and man.splitframe:IsOpen()) then
			man:SplitClass(self.class, true)
		end
	end
	splitOnLeaveFunc = function(self)
		if (man.dragIcon and man.dragIcon:IsShown()) then
			return
		end
		man:HighlightClass()
	end
	for k,v in pairs(classOrder) do
		local cell = CreateFrame("Button", "ZOMGBMClassTitle"..v, main)
		main.classTitle.cell[k] = cell
		cell:SetWidth(36)
		cell:SetHeight(36)
		cell:SetNormalTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")

		cell:SetHitRectInsets(-4, -4, -4, -4)

		local count = cell:CreateFontString(nil, "OVERLAY", "NumberFontNormalLarge")
		cell.classcount = count
		count:SetPoint("TOPRIGHT")
		count:SetText("0")
		count:SetTextColor(1, 1, 0, 1)

		cell.class = v
		cell:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		cell:SetScript("OnClick", splitFunc)
		cell:SetScript("OnEnter", splitExpandFunc)
		cell:SetScript("OnLeave", splitOnLeaveFunc)
		cell:EnableMouse(true)

		if (k == 1) then
			cell:SetPoint("TOPLEFT", 126, 0)
		else
			cell:SetPoint("TOPLEFT", prev, "TOPRIGHT", 6, 0)
		end

		cell.normalTex = cell:GetNormalTexture()
		cell.highlightTex = cell:GetHighlightTexture()
		SetClassIcon(cell.normalTex, v)
		prev = cell
	end

	self.CreateMainMainFrame = nil
	return main
end

-- CreateMainFrame
function man:CreateMainFrame()
	local f = self.frame
	if (not f) then
		f = self:CreateMainMainFrame()
		f.row = {}
	end

	local function CreateClassRow(rowNumber)
		local row = CreateFrame("Frame", "ZOMGBMClassRow"..rowNumber, self.frame)
		row:SetID(rowNumber)
		row.row = rowNumber
		row.cell = {}
		row:SetWidth(100 + 36 * #classOrder)
		row:SetHeight(40)

		local cell = CreateFrame("Frame", nil, row)
		row.title = cell
		cell:SetPoint("TOPLEFT", 0, -2)
		cell:SetWidth(120)
		cell:SetHeight(36)
		cell.name = cell:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		cell.name:SetAllPoints()
		local c = RAID_CLASS_COLORS.PALADIN
		cell.name:SetTextColor(c.r, c.g, c.b)

		cell.spec = cell:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		cell.spec:SetAllPoints()
		cell.spec:SetJustifyH("RIGHT")
		cell.spec:SetJustifyV("BOTTOM")
		cell.spec:SetTextColor(0, 1, 0)

		cell.symbols = cell:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		cell.symbols:SetAllPoints()
		cell.symbols:SetJustifyH("RIGHT")
		cell.symbols:SetJustifyV("MIDDLE")
		cell.symbols:SetTextColor(1, 1, 1)

		cell.ackWait = cell:CreateTexture(nil, "OVERLAY")
		cell.ackWait:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		cell.ackWait:SetTexCoord(0, 0.25, 0, 0.25)
		cell.ackWait:SetPoint("BOTTOMLEFT")
		cell.ackWait:SetWidth(14)
		cell.ackWait:SetHeight(14)
		--cell.ackWait:Hide()

		cell.offline = cell:CreateTexture(nil, "OVERLAY")
		cell.offline:SetPoint("CENTER")
		cell.offline:SetHeight(48)
		cell.offline:SetWidth(48)
		cell.offline:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon")
		cell.offline:Hide()

		cell.version = cell:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		cell.version:SetTextColor(0.5, 0.5, 0.5)
		cell.version:SetAllPoints()
		cell.version:SetJustifyH("RIGHT")
		cell.version:SetJustifyV("TOP")
		cell.version:Hide()

		cell.icons = {}

		for i = 1,#classOrder do
			prev = cell

			abCount = abCount + 1
			cell = CreateFrame("Button", "ZOMGActionButton"..abCount, row, "ActionButtonTemplate")
			tinsert(row.cell, cell)
			cell:SetPoint("TOPLEFT", prev, "TOPRIGHT", 6, 0)

			cell.icon = getglobal(cell:GetName().."Icon")
			cell.text = getglobal(cell:GetName().."Text")

			cell:SetID(i)
			cell.col = i
			cell.row = rowNumber

			cell:SetHitRectInsets(-4, -4, -4, -4)
			cell:EnableMouseWheel(true)

			cell:SetScript("OnEnter", onCellEnter)
			cell:SetScript("OnLeave", onCellLeave)
			cell:SetScript("OnClick", onCellClick)
			cell:SetScript("OnDragStart", onCellDrag)
			cell:SetScript("OnDragStop", onCellDragStop)
			cell:SetScript("OnMouseWheel", onCellMouseWheel)
			cell:RegisterForDrag("LeftButton")
			cell:RegisterForClicks("AnyUp")
		end
		return row
	end

	local rowSort = new()
	if (self.configuring) then
		for i = 1,#blessingCycle do
			tinsert(rowSort, tostring(i))
		end
	else
		rowSort = self.paladinOrder
	end

	local prevrow = f.classTitle
	for i,name in ipairs(rowSort) do

		local row = f.row[i]
		if (not row) then
			row = CreateClassRow(i)
			f.row[i] = row
		end

		row:Show()

		if (self.configuring) then
			row.pala = nil
			row.title.name:SetText(i)
		else
			if (not self.pala[name]) then
				error("No self.pala for "..name)
			end

			self.pala[name].row = i
			row.pala = name
			row.title.name:SetText(name)
		end

		row:SetPoint("TOPLEFT", prevrow, "BOTTOMLEFT", 0, -2)
		prevrow = row
	end

	-- Hide now un-used rows
	for i = #rowSort + 1,#f.row do
		f.row[i]:Hide()
	end

	if (split and self.configuring) then
		self:SplitPositionCells()
	else
		local h, w
		h = 66 + #rowSort * 42
		w = 124 + 42 * #classOrder

		f:SetSize(w, h)
	end

	if (self.configuring) then
		del(rowSort)
	end

	self:SetButtons()
end

-- CellHasError
function man:CellHasError(row, col, panel)
	local Type = self:GetCell(row, col, panel)
	for i = 1,row - 1 do
		if (self:GetCell(i, col, panel) == Type) then
			return true
		end
	end
end

-- DrawIcons
function man:DrawIcons(row)
	local rowNumber = row:GetID()

	if (self.configuring) then
		for k,v in pairs(classOrder) do
			local cell = row.cell[k]
			local temp = template[v]
			if (temp and temp[rowNumber]) then
				local singleSpell, classSpell = z:GetBlessingFromType(temp[rowNumber])
				local icon = BabbleSpell:GetSpellIcon(classSpell or singleSpell)

				cell.icon:SetTexture(icon)
				if (self:CellHasError(rowNumber, k)) then
					self.anyErrors = true
					cell.icon:SetVertexColor(1, 0.5, 0.5)
				elseif (self:HasException(rowNumber, k)) then
					cell.icon:SetVertexColor(0.5, 0.5, 1)
				else
					cell.icon:SetVertexColor(1, 1, 1)
				end
			else
				cell.icon:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")		-- Blank for errors/missing
				cell.icon:SetVertexColor(0, 0, 0)
			end
			cell:Enable()
		end
	else
		local pala = self.pala[row.pala]

		if (rowNumber ~= pala.row) then
			error("Row number mismatch for "..who)
		end

		local template = self.pala[row.pala].template
		for k,v in pairs(classOrder) do
			local cell = row.cell[k]
			if (not cell) then
				error("Missing cell "..tostring(index).."x"..tostring(k))
			end

			local Type = template and template[v]
			if (Type) then
				local singleSpell, classSpell = z:GetBlessingFromType(Type)
				if (not singleSpell) then
					error("Unknown type "..tostring(Type))
				end

				local icon = BabbleSpell:GetSpellIcon(classSpell or singleSpell)
				cell.icon:SetTexture(icon)

				if (self:CellHasError(rowNumber, k)) then
					self.anyErrors = true
					cell.icon:SetVertexColor(1, 0.5, 0.5)
				elseif (self:HasException(rowNumber, k)) then
					cell.icon:SetVertexColor(0.5, 0.5, 1)
				else
					cell.icon:SetVertexColor(1, 1, 1)
				end
			else
				cell.icon:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")		-- Blank for errors/missing
				cell.icon:SetVertexColor(0, 0, 0)
			end
			if (pala.canEdit) then
				cell:Enable()
			else
				cell:Disable()
			end
		end
	end
end

-- DrawIconsByName
function man:DrawIconsByName(who)
	if (self.frame) then
		local pala = self.pala[who]
		if (not pala) then
			error("Missing self.pala for "..tostring(who))
		end

		local row = self.frame.row[pala.row]
		if (not row) then
			error("Missing row for "..tostring(who))
		end

		self:DrawIcons(row)
	end
end

-- PalaIcon
local function PalaIcon(self, index, tex)

	local icon = self.icons[index]

	if (not icon and tex) then
		icon = self:CreateTexture(nil, "OVERLAY")
		self.icons[index] = icon
		icon:SetWidth(14)
		icon:SetHeight(14)

		if (index == 1) then
			icon:SetPoint("TOPLEFT", 4, -1)
		else
			icon:SetPoint("TOPLEFT", self.icons[index - 1], "TOPRIGHT", 0, 0)
		end
	end

	if (icon) then
		if (tex) then
			icon:SetTexture(tex)
			icon:Show()
		else
			icon:Hide()
		end
	end
end

-- ConvertVersion
-- Converts (for example) "0.9a" to "0.009a" internally so we can compare versions properly
function man:ConvertVersion(ver)
	local major, minor, letter = strmatch(ver, "([0-9]+)\.([0-9]+)([a-z]*)")
	return format("%s.%03d%s", major, tonumber(minor), letter)
end

-- DrawPaladin
function man:DrawPaladin(row)
	local icon = 1

	row.title.offline:Hide()
	row.title.ackWait:Hide()
	row.title.version:Hide()
	row.title.symbols:Hide()
	row.title.spec:Hide()

	if (self.configuring) then
		row.title.name:SetText(row:GetID())
	else
		local who = row.pala
		local pala = self.pala[who]
		if (not pala) then
			return			-- error("No self.pala for "..who)
		end
		row.title.name:SetText(who)

		local unit = roster:GetUnitObjectFromName(who)

		local v = z.versionRoster and z.versionRoster[who]
		if (v) then
			row.title.version:Show()
			if (type(v) == "string") then
				row.title.version:SetText(v)
				if (strfind(v, "PallyPower")) then
					row.title.version:SetTextColor(0.5, 0.5, 0.5)
				else
					row.title.version:SetTextColor(1, 0, 0)
				end
			else
				row.title.version:SetFormattedText("r%d", v)
				if (v < z.versionCompat) then
					row.title.version:SetTextColor(1, 0, 0)
				elseif (v == z.maxVersionSeen) then
					row.title.version:SetTextColor(0.5, 1, 0.5)
				elseif (v < z.maxVersionSeen) then
					row.title.version:SetTextColor(1, 0.5, 0.5)
				else
					row.title.version:SetTextColor(0.5, 0.5, 0.5)
				end
			end
		else
			row.title.version:Hide()
		end

		if (pala.symbols) then
			row.title.symbols:SetText(pala.symbols)
			if (pala.symbols < 20) then
				row.title.symbols:SetTextColor(1, 0.5, 0.5)
			else
				row.title.symbols:SetTextColor(1, 1, 0.5)
			end
			row.title.symbols:Show()
		end

		if (pala.spec) then
			row.title.spec:SetText(table.concat(pala.spec, " / "))
			row.title.spec:Show()
		end

		if (not unit or not UnitIsConnected(unit.unitid)) then
			row.title.offline:Show()
			row.title.name:SetTextColor(0.5, 0.5, 0.5)
			row.title.version:SetTextColor(0.5, 0.5, 0.5)
			row.title.spec:SetTextColor(0.5, 0.5, 0.5)
			row.title.symbols:SetTextColor(0.5, 0.5, 0.5)
		else
			local c = RAID_CLASS_COLORS.PALADIN
			row.title.name:SetTextColor(c.r, c.g, c.b)
			row.title.spec:SetTextColor(0, 1, 0)
		end

		if (type(pala.improvedWisdom) ~= "number") then
			pala.improvedWisdom = pala.improvedWisdom and 2 or 0
		end
		if (type(pala.improvedMight) ~= "number") then
			pala.improvedMight = pala.improvedMight and 5 or 0
		end

		if (pala.canKings) then
			PalaIcon(row.title, icon, "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings")
			icon = icon + 1
		end
		if (pala.canSanctuary) then
			PalaIcon(row.title, icon, "Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary")
			icon = icon + 1
		end
		if ((pala.improvedMight or 0) > 0) then
			PalaIcon(row.title, icon, "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings")
			icon = icon + 1
		end
		if ((pala.improvedWisdom or 0) > 0) then
			PalaIcon(row.title, icon, "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom")
			icon = icon + 1
		end

		if (pala.waitingForAck) then
			row.title.ackWait:Show()
		end
	end
	for i = icon,4 do
		PalaIcon(row.title, i)
	end
end

-- OnReceiveVersion
function man:OnReceiveVersion(sender, version)
	self:DrawPaladinByName(sender)
end

-- DrawPaladinByName
function man:DrawPaladinByName(who)
	if (not self.frame or not self.pala) then
		return
	end

	local pala = self.pala[who]
	if (not pala) then
		return	-- error("No self.pala for "..tostring(who))
	end
	row = pala.row
	if (not row) then
		return	-- error("No row for "..tostring(who))
	end

	local row = self.frame.row[row]
	if (not row) then
		return	-- error("No frame row for "..tostring(who))
	end

	self:DrawPaladin(row)
end

-- SetButtons
function man:SetButtons()
	if (self.configuring) then
		self.frame.configure:SetText(L["Finish"])
		self.frame.configure.tooltipText = L["Finish configuring template"]
		self.frame.broadcast:Hide()
		self.frame.generate:Hide()
		self.frame.groups:Hide()
	else
		self.frame.configure:SetText(L["Configure"])
		self.frame.configure.tooltipText = L["Configure the automatic template generation"]

		if (self.canEdit) then
			self.frame.broadcast:Show()
			self.frame.generate:Show()
		else
			self.frame.broadcast:Hide()
			self.frame.generate:Hide()
		end
		self.frame.groups:Show()
	end
end

-- ToggleConfigure
function man:ToggleConfigure()
	self.configuring = not self.configuring
	if (self.frame) then
		self:SetButtons()
		if (not self.configuring) then
			self:AssignPaladins()
		end

		if (not self.configuring and self.expandpanel) then
			self.expandpanel:Hide()
		end

		self:DrawAll()
	end
end

-- OnPlayerHasControl
function man:OnPlayerHasControl(sender, newTemplate)
	if (template.modified) then
		self:SaveTemplate(L["Autosave"])
	end

	self.db.char.selectedTemplate = nil
	self.db.profile.templates.current = copy(newTemplate)

	if (self.frame) then
		self:DrawPaladinByName(sender)
		self:DoButtons()
	end
end

-- EnableBroadcast
function man:EnableBroadcast()
	self.frame.broadcast:Enable()
	self.frame.generate:Enable()
end

-- AssumeControl
function man:BroadcastTemplates()
	if (self.canEdit) then
		self.frame.broadcast:Disable()
		self.frame.generate:Disable()
		self:ScheduleEvent("ZOMGBlessings_EnableBroadcast", self.EnableBroadcast, 5, self)

		self:GiveAllTemplates()
	end
end

-- GroupsMenu
local groupsMenu
function man:GroupsMenu()
	local button = self.frame.groups
	
	if (not groupsMenu) then
		local function getGroups(i)
			return self.db.profile.groups == i
		end
		local function setGroups(i)
			self.db.profile.groups = i
			self:AssignPaladins()
			if (self.frame and self.frame:IsOpen()) then
				self:DrawAll()
			end
			dewdrop:Close()
		end

		groupsMenu = {
			type = 'group',
			name = " ",
			desc = " ",
			args = {
				spacer = {
					type = 'header',
					name = " ",
					order = 100,
				}
			}
		}
		
		for i = 1,8 do
			groupsMenu.args["group"..i] = {
				type = 'toggle',
				name = format(i == 1 and L["%d Group"] or L["%d Groups"], i),
				desc = format(i == 1 and L["%d Group"] or L["%d Groups"], i),
				get = getGroups,
				set = setGroups,
				passValue = i,
				isRadio = true,
				order = i,
			}
		end
	end

	if (dewdrop:IsOpen(button)) then
		dewdrop:Close()
	else
		dewdrop:Open(button, 'children', groupsMenu, 'point', "TOPLEFT", 'relativePoint', "BOTTOMLEFT")
	end
end

-- GetCell
function man:GetCell(row, col, panel)
	if (panel) then
		local class = self.expandpanel.class
		if (row and col and template.subclass) then
			if (template.subclass[class]) then
				local t = template.subclass[class]

				local code = self.classSplits[class][col + 1].code
				if (not code) then
					error("No code for "..class)
				end

				if (t[code]) then
					return t[code][row]
				end
			end
		end
		return template[class][row]
	else
		local class = classOrder[col]
		if (man.configuring) then
			if (template[class]) then
				return template[class][row]
			end
		else
			local pala = self:GetPalaFromRow(row)
			if (pala) then
				return pala.template and pala.template[class]
			end
		end
	end
end

-- SetCell
function man:SetCell(row, col, Type, panel)
	if (panel) then
		if (row and col) then
			local class = self.expandpanel.class

			if (not template.subclass) then
				template.subclass = {}
			end
			if (not template.subclass[class]) then
				template.subclass[class] = {}
			end
			local t = template.subclass[class]

			local code = self.classSplits[class][col + 1].code
			if (not code) then
				error("No code for "..class)
			end

			if (not t[code]) then
				t[code] = copy(template[class])
			end
			t[code][row] = Type
			template.modified = true

			local diff
			for i = 1,6 do
				if (t[code][row] ~= template[class][row]) then
					diff = true
					break
				end
			end

			if (not diff) then
				if (not next(t[code])) then
					t[code] = del(t[code])
				end
				if (not next(template.subclass[class])) then
					template.subclass[class] = nil
				end
				if (not next(template.subclass)) then
					template.subclass = nil
				end
			end
		end
	else
		local class = classOrder[col]
		if (man.configuring) then
			if (template[class]) then
				template[class][row] = Type
				template.modified = true
				self:MakeTemplateOptions()
			end
		else
			local pala, palaName = self:GetPalaFromRow(row)
			if (pala and pala.template) then
				z:Log("man", nil, "change", palaName, class, pala.template[class], Type)

				pala.template[class] = Type
				
				if (self:AnyBetaUsers()) then
					self:GiveTemplate(palaName, true)
				else
					self:BroadcastTemplatePart(palaName, class, Type)
				end
			end
		end
	end
end

-- AnyBetaUsers
function man:AnyBetaUsers()
	--local ret
	for name, version in pairs(ZOMGBuffs.versionRoster) do
		if (version == 0) then
			local unit = roster:GetUnitObjectFromName(name)
			if (unit and (unit.class == "PALADIN" or unit.rank > 0)) then
				return true
				--if (not ret) then
				--	ret = z:ColourUnitByName(unit.name)
				--else
				--	ret = ret..", "..z:ColourUnitByName(unit.name)
				--end
			end
		end
	end

	--if (ret and not self.betaWarning) then
	--	-- This is mostly just for me. Noone outside of guild ever used this pre-release
	--	self.betaWarning = true
	--	self:Print("WARNING: Beta User Warnings: %s", ret)
	--	self:Print("WARNING: Using larger data sends")
	--end

	--return ret ~= nil
end

-- GetException
function man:GetException(name, row, col)
	if (not man.configuring) then
		local pala = self:GetPalaFromRow(row)
		if (pala) then
			return pala.template[name]
		end
	end
end

-- HasException
function man:HasException(row, col)
	local class = classOrder[col]
	if (not man.configuring) then
		local t = self:GetPalaTemplateFromRow(row)
		if (t) then
			for nameClass,blessing in pairs(t) do
				if (nameClass ~= "modified" and nameClass ~= "state" and not classIndex[nameClass]) then
					local found = self:NameToClass(nameClass)
					if (found == classOrder[col]) then
						return true
					end
				end
			end
		end
	end
end

-- SetException
function man:SetException(name, row, col, n)
	local class = classOrder[col]
	if (not man.configuring and self.canEdit) then
		local pala, palaName = self:GetPalaFromRow(row)
		if (pala and pala.canEdit) then
			if (n ~= pala.template[name]) then
				pala.template[name] = n

				z:Log("man", nil, "exception", palaName, name, oldType, pala.template[name])

				self:DrawIcons(self.frame.row[row])

				if (self:AnyBetaUsers()) then
					self:GiveTemplate(palaName, true)
				else
					self:BroadcastTemplatePart(palaName, name, n)
				end
			end
		end
	end
end

-- ClearCellExceptions
function man:ClearCellExceptions(row, col)
	local class = classOrder[col]
	if (not man.configuring) then
		local pala, palaName = self:GetPalaFromRow(row)
		if (pala and pala.canEdit) then
			for nameClass,blessing in pairs(pala.template) do
				local found = self:NameToClass(nameClass)
				if (found == classOrder[col]) then
					pala.template[nameClass] = nil
					self:DrawIcons(self.frame.row[row])
					if (ZOMGBlessingsPP) then
						ZOMGBlessingsPP:GiveTemplatePart(palaName, nameClass, nil)
					end
				end
			end
			self:GiveTemplate(palaName, true)
			z:Log("man", nil, "clearcell", palaName, classOrder[col])
		end
	end
end

-- UnitContextMenu
local contextMenu = {
	type = "group",
	order = 2,
	name = L["Exceptions"],
	desc = L["Unit exceptions"],
	handler = man,
}
local contextRow, contextCol
function man:UnitContextMenu(row, col)
	local class = classOrder[col]
	local list

	for unit in roster:IterateRoster() do
		if (unit.class == class and unit.subgroup <= self.db.profile.groups) then
			if (not list) then
				list = new()
			end
			tinsert(list, unit)
		end
	end
	if (list or self:HasException(row, col)) then
		if (list) then
			sort(list, function(a,b) return a.name < b.name end)
		end

		local function getFunc(k, ...)
			local name, buff = strsplit(",", k)
			return self:GetException(name, contextRow, contextCol) == buff
		end
		local function setFunc(k, onoff, ...)
			local name, buff = strsplit(",", k)
			self:SetException(name, contextRow, contextCol, buff)
		end

		local mainBuff = self:GetCell(row, col)
		local pala = self:GetPalaFromRow(row)

		contextMenu.args = {
			header = {
				type = "header",
				name = L["Exceptions"],
				order = 1,
			},
			remove = {
				type = "execute",
				name = L["Clear"],
				desc = L["Remove all exceptions for this cell"],
				func = function() man:ClearCellExceptions(contextRow, contextCol) end,
				order = 100,
				hidden = function() return not self:HasException(row, col) end,
			}
		}

		if (list) then
			for i,unit in ipairs(list) do
				local cName = z:ColourUnit(unit.unitid)
				local cDesc = format(L["Single target exception for %s"], cName)
				contextMenu.args[unit.name] = {
					type = "group",
					order = i + 2,
					name = z:ColourUnit(unit.unitid),
					desc = cDesc,
					get = getFunc,
					set = setFunc,
					pass = true,
					args = {
						none = {
							type = "toggle",
							order = 1,
							name = L["None"],
							desc = cDesc,
							passValue = unit.name,
							isRadio = true,
						},
					},
				}

				for j,buff in ipairs(blessingCycle) do
					if (buff ~= mainBuff and ((class ~= "ROGUE" and class ~= "WARRIOR") or buff ~= "BOW") and (not pala.gotCapabilities or (buff == "SAN" and pala.canSanctuary) or (buff == "BOK" and pala.canKings) or (buff ~= "SAN" and buff ~= "BOK"))) then
						contextMenu.args[unit.name].args[buff] = {
							type = "toggle",
							order = j + 2,
							name = z:ColourBlessing(buff),
							desc = cDesc,
							passValue = unit.name..","..tostring(buff),
							isRadio = true,
						}
					end
				end
			end
			del(list)
		end

		contextRow, contextCol = row, col
		dewdrop:Open(self.frame, "children", contextMenu, 'cursorX', true, 'cursorY', true)
	end
end

-- OnCellClick
function man:OnCellClick(row, col, button, panel)
	if (button == "RightButton" and not self.configuring and not panel and self.canEdit) then
		self:UnitContextMenu(row, col)
	else
		if (self.configuring or self.canEdit) then
			local pala = self:GetPalaFromRow(row)
			if (not self.configuring and (not pala or (self.canEdit and pala.waitingForAck) or not pala.canEdit)) then
				return
			end

			local Type = self:GetCell(row, col, panel)
			local ind = blessingCycleIndex[Type] or 0
			local class = classOrder[col]

			for i = 1,20 do		-- Just in case we get stuck.
				if (button == "LeftButton" or button == "MOUSEWHEELDOWN") then
					if (ind == 0) then
						ind = 1
					elseif (ind == #blessingCycle) then
						ind = 0
					else
						ind = ind + 1
					end
				else
					if (ind == 0) then
						ind = #blessingCycle
					elseif (ind == 1) then
						ind = 0
					else
						ind = ind - 1
					end
				end
				Type = blessingCycle[ind]

				if (self.configuring) then
					break
				elseif (pala.gotCapabilities) then
					if ((Type == "BOK" and pala.canKings) or
						(Type == "SAN" and pala.canSanctuary) or
						(Type == "BOW" and (class ~= "ROGUE" and class ~= "WARRIOR")) or
						(Type ~= "BOK" and Type ~= "SAN" and Type ~= "BOW")) then
						break
					end
				end
			end

			self:SetCell(row, col, Type, panel)
			self:DrawAll(panel)
		end
	end
end

-- DimNonDraggables
function man:DimNonDraggables(row, col, panel, onoff)
	if (not self.db.profile.greyout or (not self.canDesaturate and not row)) then
		return
	end

	local rows = self.frame.row

	for i,cellrow in ipairs(rows) do
		for j,class in ipairs(classOrder) do
			local cell = cellrow.cell[j]
			local cellTex = cell.icon:GetTexture()

			if (onoff and (panel or j ~= col or i == row) and cellTex ~= "Interface\\Tooltips\\UI-Tooltip-Background") then
				if (not cell.icon:SetDesaturated(true)) then
					return				-- User's gfx card can't do this, so just return now
				end
			else
				cell.icon:SetDesaturated(nil)
			end
		end
	end

	local p = self.expandpanel
	if (p) then
		for column,cellcolumn in ipairs(p.column) do
			for rownum,cell in ipairs(cellcolumn.cell) do
				local cellTex = cell.icon:GetTexture()
				if (onoff and (not panel or column ~= col or rownum == row) and cellTex ~= "Interface\\Tooltips\\UI-Tooltip-Background") then
					cell.icon:SetDesaturated(true)
				else
					cell.icon:SetDesaturated(nil)
				end
			end
		end
	end

	self.canDesaturate = true
end

-- OnCellDrag
function man:OnCellDrag(cell, row, col, panel)
	if (self.configuring or self.canEdit) then
		if (not self.configuring) then
			local pala = self:GetPalaFromRow(row)
			if (not pala or not pala.canEdit) then
				return
			end
		end

		dewdrop:Close()
		local icon = self:StartDrag(true, cell.icon:GetTexture())
		icon.dragRow = row
		icon.dragCol = col
		icon.dragPanel = panel

		man:DimNonDraggables(row, col, panel, true)
	end
end

-- OnCellDragStop
function man:OnCellDragStop(cell)
	man:DimNonDraggables()

	local icon = self.dragIcon
	if (not icon) then
		return
	end

	icon:ClearAllPoints()
	icon:Hide()

	if (self.configuring or self.canEdit) then
		local f = GetMouseFocus()

		if (f ~= cell and f:GetParent() and cell:GetParent() and f:GetParent():GetParent() == cell:GetParent():GetParent()) then
			local row = f.row
			local col = f.col
			local panel = f.split

			if (cell.col == f.col and cell.row ~= f.row and f.split == cell.split) then
				local pala = self:GetPalaFromRow(cell.row)
				if (pala) then
					if (not self.configuring and not pala.canEdit) then
						return
					end
				end
				pala = self:GetPalaFromRow(f.row)
				if (pala) then
					if (not self.configuring and not pala.canEdit) then
						return
					end
				end

				-- Shuffle the order up or down depending on direction of drag
				local save = self:GetCell(cell.row, col, panel)
				if (row > cell.row) then
					for i = cell.row,row - 1 do
						self:SetCell(i, col, self:GetCell(i + 1, col, panel), panel)
					end
				else
					for i = cell.row,row + 1,-1 do
						self:SetCell(i, col, self:GetCell(i - 1, col, panel), panel)
					end
				end
				self:SetCell(row, col, save, panel)
				self:DrawAll()
			end
		end
	end
end

-- man:GetPalaFromRow(row)
function man:GetPalaFromRow(row)
	for name,pala in pairs(self.pala) do
		if (pala.row == row) then
			return pala, name
		end
	end
	return nil
end

-- GetPalaTemplateFromRow
function man:GetPalaTemplateFromRow(row)
	local pala = self:GetPalaFromRow(row)
	return pala and pala.template
end

-- NameToClass
function man:NameToClass(nameClass)
	if (nameClass ~= "modified" and nameClass ~= "state" and not classIndex[nameClass]) then
		-- Must be a name
		local unit = roster:GetUnitObjectFromName(nameClass)
		if (unit) then
			return unit.class
		end
	end
	return nil
end

-- SplitPositionCells
function man:HighlightClass(highlightClass, highlightRow)
	for i,class in ipairs(classOrder) do
		local titleCell = self.frame.classTitle.cell[i]
		if (not self.db.profile.highlights or not highlightClass or class == highlightClass) then
			titleCell:SetAlpha(1)
		else
			titleCell:SetAlpha(0.5)
		end

		for j,row in ipairs(self.frame.row) do
			local cell = row.cell[i]
			if (not self.db.profile.highlights or not highlightClass or class == highlightClass) then
				cell:SetAlpha(1)
			else
				cell:SetAlpha(0.5)
			end
		end
	end

	for j,row in pairs(self.frame.row) do
		if (not self.db.profile.highlights or not highlightRow or j == highlightRow) then
			row.title:SetAlpha(1)
		else
			row.title:SetAlpha(0.5)
		end
	end
end

-- OnCellEnter
function man:OnCellEnter(cell, row, col)
	local class = classOrder[col]
	local e

	if (self.dragIcon and self.dragIcon:IsShown()) then
		return
	end

	self:HighlightClass(class, row)
	if (self.splitframe and self.splitframe:IsOpen()) then
		self:SplitClass(class, true)
	end

	if (man.configuring) then
		e = template.exceptions and template.exceptions[class] and template.exceptions[class][row]
	else
		local pala = self:GetPalaFromRow(row)
		if (not pala) then
			return
		end

		for nameClass,blessing in pairs(pala.template) do
			if (nameClass ~= "modified" and nameClass ~= "state" and not classIndex[nameClass]) then
				-- Must be a name
				if (self:NameToClass(nameClass) == classOrder[col]) then
					if (not e) then
						e = new()
					end
					e[nameClass] = blessing
				end
			end
		end
	end

	if (e) then
		GameTooltip:SetOwner(cell, "ANCHOR_BOTTOMLEFT")
		GameTooltip:SetText(L["Exceptions"], 1, 1, 1)

		for k,v in pairs(e) do
			GameTooltip:AddDoubleLine(z:ColourUnitByName(k), z:ColourBlessing(v))
		end
		GameTooltip:Show()
	end

	if (not man.configuring) then
		del(e)
	end

	self:SplitExpand(class)
end

-- SendAll
function man:SendAll(...)
	for k,v in pairs(self.pala) do
		if (k ~= playerName) then
			z:SendComm(k, ...)
		end
	end
end

-- DrawAll
function man:DrawAll()
	self:CreateMainFrame()

	self.anyErrors = nil
	if (self.configuring) then
		self.frame:SetTitle(L["TITLE_CONFIGURE"])

		for i = 1,#blessingCycle do
			local row = self.frame.row[i]
			self:DrawPaladin(row)
			self:DrawIcons(row)
		end
	else
		self.frame:SetTitle(L["TITLE"])

		for k,v in pairs(self.pala) do
			self:DrawPaladinByName(k)
			self:DrawIconsByName(k)
		end
	end

   	if (self.configuring and self.expandpanel and self.expandpanel.class) then
		for i = 1,3 do
			local col = self.expandpanel.column[i]
			if (col and col:IsShown()) then
				self:SplitPanelColumnPopulate(col)
			end
		end
	end

	self:DoButtons()
end

-- CreatePPWarning
function man:CreatePPWarning()
	local f = CreateFrame("Frame", nil, self.frame.classTitle)
	self.frame.ppWarning = f
	
	f:SetPoint("TOPLEFT")
	f:SetPoint("BOTTOMRIGHT", self.frame.classTitle, "BOTTOMLEFT", 120, 0)
	f:EnableMouse(true)

	local tex = f:CreateTexture(nil, "OVERLAY")
	f.tex = tex
	tex:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
	tex:SetWidth(32)
	tex:SetHeight(32)
	tex:SetPoint("LEFT", 5, 0)
	tex:SetTexCoord(0.2, 0.8, 0.2, 0.8)

	local text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	f.text = text
	text:SetPoint("LEFT", tex, "RIGHT", 0, 0)
	text:SetText(L["Warning!"])
	
	f:SetScript("OnEnter",
		function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			GameTooltip:SetText(L["PallyPower users are in the raid and you are NOT promoted\rPallyPower only accepts assignment changes from promoted players"])
		end)
	f:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	self.CreatePPWarning = nil
end

-- AnyPPUsers
function man:AnyPPUsersAndNotPromoted()
	local leader = true
	if (GetNumRaidMembers() > 0) then
		leader = IsRaidOfficer() or IsRaidLeader()
	elseif (GetNumPartyMembers() > 0) then
		leader = IsPartyLeader()
	end
	if (not leader) then
		for palaName,pala in pairs(self.pala) do
			if (palaName ~= playerName) then
				local ver = z.versionRoster[palaName]
				if (ver and type(ver) == "string" and ver == "PallyPower") then
					return true
				end
			end
		end
	end
end

-- ValidatePP
function man:ValidatePP()
	if (self.frame) then
		if (self:AnyPPUsersAndNotPromoted()) then
			if (not self.frame.ppWarning) then
				self:CreatePPWarning()
			else
				self.frame.ppWarning:Show()
			end
		else
			if (self.frame.ppWarning) then
				self.frame.ppWarning:Hide()
			end
		end
	end
end

-- DoButtons
function man:DoButtons()
	if (self.frame) then
		if (self.configuring and self.anyErrors) then
			self.frame.configure:Disable()
		else
			self.frame.configure:Enable()
		end
		self:ValidatePP()

		self.frame.groups:SetFormattedText(self.db.profile.groups == 1 and L["%d Group"] or L["%d Groups"], self.db.profile.groups)
	end
end

-- Open
function man:ToggleFrame()
	if (self.frame and self.frame:IsOpen()) then
		self:Close()
	else
		self:Open()
	end
end

-- Open
function man:Open()
	dewdrop:Close()
	self:AssignPaladins()

	self:CreateMainFrame()
	self.frame:Open()
	self:DrawAll()
	self:DrawClassCounts()

	self.frame.broadcast:Enable()
end

-- Close
function man:Close()
	self.frame:Close()
	dewdrop:Close()
end

-- Unlock
function man:Unlock()
	local any
	for palaName,pala in pairs(self.pala) do
		if (not pala.canEdit or not pala.gotCapabilities) then
			pala.gotCapabilities = true
			pala.canEdit = true
			any = true
		end
	end
	if (any) then
		if (self.frame and self.frame:IsOpen()) then
			self:DrawAll()
		end
	end
end

-- Unlock
function man:NoneLocked()
	for palaName,pala in pairs(self.pala) do
		if (not pala.gotCapabilities) then
			return false
		end
	end
	return true
end

-- Send
function man:Send(type, name)
	if (type == "template") then
		if (template) then
			z:SendComm(name, "GIVEMASTERTEMPLATE", template)
		end
	else
		local codes = self.db.profile.playerCodes
		if (codes) then
			z:SendComm(name, "GIVESUBCLASSES", codes)
		end
	end
end

-- Clean
function man:Clean(mode)		-- guild or raid
	local cleaned = 0
	local codes = self.db.profile.playerCodes
	if (codes) then
		for class,list in pairs(codes) do
			for name,code in pairs(list) do
				if (mode == "guild") then
					if (not rollcall:GetLevel(name)) then
						list[name] = nil
						cleaned = cleaned + 1
					end

				elseif (mode == "raid") then
					if (not roster:GetUnitObjectFromName(name)) then
						list[name] = nil
						cleaned = cleaned + 1
					end
				end
			end
		end
	end

	self:SplitColumnDrawAll()

	self:Print(L["Cleaned %d players from the stored sub-class list"], cleaned)
end

-- GetClassBuffs
function man:GetShouldHaveBuffs(playerName, playerClass)
	-- Get list of buff types for a class
	local ret = new()

	if (self.paladinOrder) then
		for i,name in ipairs(self.paladinOrder) do
			local pala = self.pala[name]
			if (pala) then
				local single = pala.template[playerName]
				if (single) then
					ret[i] = {1, single}
				else
					local group = pala.template[playerClass]
					if (group) then
						ret[i] = {2, group}
					else
						ret[i] = {0}
					end
				end
			end
		end
	end

	return ret
end

-- OnRaidRosterUpdate
function man:OnRaidRosterUpdate()
	local wasPaladins = new()
	for k,v in pairs(self.pala) do
		wasPaladins[k] = true
	end

	local change
	for unit in roster:IterateRoster() do
		if (unit.class == "PALADIN" and unit.subgroup <= self.db.profile.groups) then
			if (not wasPaladins[unit.name]) then
				change = true
				break
			else
				wasPaladins[unit.name] = nil
			end
		end
	end

	-- Only re-assign if the paladins changed in roster
	if (change or next(wasPaladins)) then
		self:AssignPaladins()

		if (self.frame and self.frame:IsOpen()) then
			self:DrawAll()
		end
	end

	del(wasPaladins)

	self:DoButtons()
end

-- OnReceiveCapability
function man:OnReceiveCapability(sender, cap)
	if (type(cap.impWisdom) ~= "number") then
		cap.impWisdom = cap.impWisdom and 2 or 0
	end
	if (type(cap.impMight) ~= "number") then
		cap.impMight = cap.impMight and 5 or 0
	end

	self:AssignPaladins()

	if (self.pala and self.pala[sender]) then
		self.pala[sender].canKings = cap.canKings			-- true/nil
		self.pala[sender].canSanctuary = cap.canSanctuary		-- true/nil
		self.pala[sender].improvedMight = cap.impMight			-- 0 - 5
		self.pala[sender].improvedWisdom = cap.impWisdom		-- 0 - 2
		--self:DrawPaladinByName(sender)

		self.pala[sender].gotCapabilities = true
	end

	if (self.frame and self.frame:IsOpen()) then
		self:DrawAll()
	end
end

-- OnReceiveSpec
function man:OnReceiveSpec(sender, spec)
	if (self.pala and self.pala[sender]) then
		self.pala[sender].spec = spec			-- { n, n, n }
		self:DrawPaladinByName(sender)
	end
	self:SplitColumnDrawAll()
end

-- OnSelectTemplate
function man:OnSelectTemplate(templateName)
	template = self.db.profile.templates.current
	if (not template) then
		if (not self.db.profile.templates[L["Default"]]) then
			self.db.profile.templates[L["Default"]] = DefaultTemplate()
			self:SelectTemplate(L["Default"])
		end
	end

	self:AssignPaladins()

	if (self.frame and self.frame:IsOpen()) then
		self:DrawAll()
	end
end

-- OnReceiveAck
function man:OnReceiveAck(sender)
	if (self.pala and self.pala[sender]) then
		self.pala[sender].waitingForAck = nil
		self:DrawPaladinByName(sender)
	elseif (z.db.profile.info) then
		self:Print("Unexpected ACK from %s", z:ColourUnitByName(sender))
	end
end

-- CheckRoster
function man:CheckRoster()
	local newPalas = new()
	local oldPalas = new()
	local anyCameOnline

	self:SetSelf()
	
	if (not self.pala) then
		self:AssignPaladins()
	end

	for name,v in pairs(self.pala) do
		oldPalas[name] = true
	end

	for unit in roster:IterateRoster() do
		if (unit.class == "PALADIN" and unit.subgroup <= self.db.profile.groups) then
			if (oldPalas[unit.name]) then
				oldPalas[unit.name] = nil
			else
				newPalas[unit.name] = true
			end

			local pala = self.pala[unit.name]
			if (pala) then
				if (UnitIsConnected(unit.unitid)) then
					if (pala.offline) then
						pala.offline = nil
						anyCameOnline = true
					end
				else
					if (not pala.offline) then
						pala.offline = true
						self:DrawPaladinByName(unit.name)
					end
				end
			end
		end
	end

	if (next(oldPalas) or next(newPalas)) then
		if (next(newPalas)) then
			local any
			for name in pairs(newPalas) do
				if (not z.versionRoster[name] or type(z.versionRoster[name]) ~= "number") then
					any = true
					break
				end
			end

			if (any) then
				-- If there's any PallyPower users, they should respond immediately to the 'REQ'
				local Type = (GetNumRaidMembers() > 0 and "RAID") or "PARTY"
				SendAddonMessage("PLPWR", "ZOMG", Type)
				SendAddonMessage("PLPWR", "REQ", Type)
			end
		end

		self:AssignPaladins()
		if (self.frame and self.frame:IsOpen()) then
			self:DrawAll()
		end
	elseif (anyCameOnline) then
		self:ScheduleEvent("ZOMGBlessings_AssignPaladins", self.AssignPaladins, 5, self)
	end

	self:DrawClassCounts()
	self:SplitPopulate()

	del(oldPalas)
	del(newPalas)
end

-- DrawClassCounts
function man:DrawClassCounts()
	if (self.frame and self.frame:IsOpen()) then
		for k,v in pairs(classOrder) do
			local cell = self.frame.classTitle.cell[k]
			local count = z.classcount[v]
			if (count == 0) then
				cell.classcount:Hide()
			else
				cell.classcount:Show()
				cell.classcount:SetText(count)
			end
		end
	end
end

--function man:RosterUnitChanged(newID, newName, newClass, newGroup, newRank, oldName, oldID, oldClass, oldGroup, oldRank)
--	if (self.frame and self.frame:IsVisible()) then
--		if (newClass == "PALADIN" or oldClass == "PALADIN") then
--			self:AssignPaladins()
--			if (self.frame and self.frame:IsOpen()) then
--				self:DrawAll()
-- 			end
--		end
--	end
--end

-- ChatConvertBlessing
function man:ChatConvertBlessing(code)
	code = strlower(code)
	if (code == L["bow"] or code == L["wisdom"] or code == L["wis"]) then
		return "BOW"
	elseif (code == L["bom"] or code == L["might"]) then
		return "BOM"
	elseif (code == L["bos"] or code == L["salv"] or code == L["sal"] or code == L["salvation"]) then
		return "BOS"
	elseif (code == L["san"] or code == L["sanc"] or code == L["sanctuary"]) then
		return "SAN"
	elseif (code == L["bok"] or code == L["kings"] or code == L["king"]) then
		return "BOK"
	elseif (code == L["bol"] or code == L["light"]) then
		return "BOL"
	end
end

-- ChatReplaceBuff(minus, plus)
function man:ChatReplaceBuff(sender, Minus, Plus)
	local unit = roster:GetUnitObjectFromName(sender)
	if (not unit) then
		return
	end

	if (not self.db.profile.remotechanges) then
		SendChatMessage(format(L["%s Remote control of buff settings is not enabled"], z.chatAnswer), "WHISPER", nil, sender)
		return
	end

	if (playerClass ~= "PALADIN" and not IsRaidLeader() and not IsRaidOfficer()) then
		SendChatMessage(format(L["%s %s is not allowed to do that"], z.chatAnswer, UnitName("player")), "WHISPER", nil, sender)
		return
	end

	local minus = self:ChatConvertBlessing(Minus)
	if (not minus) then
		SendChatMessage(format(L["%s Could not interpret %s"], z.chatAnswer, "-"..Minus), "WHISPER", nil, sender)
		return
	end
	local plus = self:ChatConvertBlessing(Plus)
	if (not plus) then
		SendChatMessage(format(L["%s Could not interpret %s"], z.chatAnswer, "+"..Plus), "WHISPER", nil, sender)
		return
	end

	for i,paladinName in ipairs(self.paladinOrder) do
		local pala = self.pala[paladinName]
		if (pala) then
			local blessingType = pala.template[sender] or pala.template[unit.class]
			if (blessingType == minus) then
				local oldClassBuff = pala.template[unit.class]
				local targetString

				if (z.classcount[unit.class] == 1) then
					-- Only one of the requesting class, so set the class buff
					targetString = z:ColourClass(unit.class)
					z:Log("man", sender, "change", paladinName, unit.class, pala.template[unit.class], plus, true)
					pala.template[sender] = nil
					pala.template[unit.class] = plus
				else
					if (plus ~= oldClassBuff) then
						-- Set a single exception for this buff
						targetString = z:ColourUnitByName(sender)
						z:Log("man", sender, "exception", paladinName, sender, pala.template[sender], plus, true)
						pala.template[sender] = plus
					else
						-- It's being set to the same as the class buff, so just remove the exception
						targetString = z:ColourClass(unit.class)
						z:Log("man", sender, "change", paladinName, unit.class, pala.template[unit.class], plus, true)
						pala.template[sender] = nil
					end
				end

				self:GiveTemplate(paladinName, true, true)
				if (z.db.profile.info) then
					self:Print(format(L["Assigned %s to buff %s on %s (by request of %s)"], z:ColourUnitByName(paladinName), z:ColourBlessing(plus), targetString, z:ColourUnitByName(sender)))
				end

				local singleBuff, classBuff = z:GetBlessingFromType(blessingType)
				local buff = (pala.template[sender] and singleBuff) or classBuff
				local spellName = z:GetBlessingFromType(plus)
				SendChatMessage(format(L["%s Assigned %s to %s"], z.chatAnswer, GetSpellLink and GetSpellLink(spellName) or spellName, paladinName), "WHISPER", nil, sender)
				return
			end
		end
	end

	local spellName = z:GetBlessingFromType(minus)
	SendChatMessage(format(L["%s You don't get %s from anyone"], z.chatAnswer, GetSpellLink and GetSpellLink(spellName) or spellName), "WHISPER", nil, sender)
end

-- BuffResponse
function man:BuffResponse(sender, msg)
	local unit = roster:GetUnitObjectFromName(sender)
	if (not unit) then
		-- Only reply to people in raid/party
		return
	end

	if (not self.paladinOrder or not self.pala) then
		if (not self.replyQueue) then
			self.replyQueue = {}
		end
		self.replyQueue[sender] = msg
		return
	end

	local showSyntax
	if (not msg or msg == "") then
		SendChatMessage(format(L["%s Your Paladin buffs come from:"], z.chatAnswer), "WHISPER", nil, sender)

		for i,paladinName in ipairs(self.paladinOrder) do
			local pala = self.pala[paladinName]
			if (pala) then
				local blessingType = pala.template[sender] or pala.template[unit.class]
				if (blessingType) then
					local singleBuff = z:GetBlessingFromType(blessingType)
					if (singleBuff) then
						SendChatMessage(format("%s %s - %s", z.chatAnswer, GetSpellLink and GetSpellLink(singleBuff) or singleBuff, paladinName), "WHISPER", nil, sender)
					end
				end
			end
		end
	elseif (msg == "?" or strlower(msg) == L["CHATHELP"]) then
		showSyntax = true
	else
		-- -bow +bom			-- Wants to have bom instead of bow
		local one, two = strmatch(msg, "([-\+%a]+) +([-\+%a]+)")
		if (one and two) then
			local plus, minus

			if (strsub(one, 1, 1) == "+") then
				plus = one
				minus = two
			elseif (strsub(two, 1, 1) == "+") then
				plus = two
				minus = one
			end
			if (plus and minus) then
				if (strsub(minus, 1, 1) == "-") then
					self:ChatReplaceBuff(sender, strsub(minus, 2), strsub(plus, 2))
				else
					showSyntax = true
				end
			else
				showSyntax = true
			end
		else
			showSyntax = true
		end
	end

	if (showSyntax) then
		local i = 1
		while (true) do
			if (not L:HasTranslation("CHATHELPRESPONSE"..i)) then
				break
			end
			SendChatMessage(format("%s %s", z.chatAnswer, L["CHATHELPRESPONSE"..i]), "WHISPER", nil, sender)
			i = i + 1
		end
	end
end

-- OnLogEnabled
function man:OnLogEnabled()
	ZOMGLog:Register("man",
		function(code, a, b, c, d, remote)
			if (code == "gen") then
				return format(L["Generated automatic template"])
			elseif (code == "change") then
				return format(L["%s %s's template - %s from %s to %s"], remote and L["Remotely changed"] or L["Changed"], z:ColourUnitByName(a), z:ColourClass(b), (c and z:ColourBlessing(c,nil,true)) or "none", (d and z:ColourBlessing(d,nil,true)) or "none")
			elseif (code == "exception") then
				return format(L["%s %s's exception - %s from %s to %s"], remote and L["Remotely changed"] or L["Changed"], z:ColourUnitByName(a), z:ColourUnitByName(b), (c and z:ColourBlessing(c,nil,true)) or "none", (d and z:ColourBlessing(d,nil,true)) or "none")
			elseif (code == "clearcell") then
				return format(L["Cleared %s's exceptions for %s"], z:ColourUnitByName(a), z:ColourClass(b))
			end
		end
	)
end

-- AceDB20_ResetDB
function man:OnResetDB()
	self:OnSelectTemplate()
end

-- OnEnable
function man:OnModuleEnable()
	self:OnResetDB()
	self:RegisterEvent("RAID_ROSTER_UPDATE", "ValidatePP")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "ValidatePP")
end

-- OnDisable
function man:OnModuleDisable()
	self:Close()
	if (self.splitframe) then
		self.splitframe:SetScript("OnUpdate", nil)
		self:SplitExpand("reset")
	end
end

-- Help
function man:Help(n)
	local helpFrame = z:GetHelpFrame()
	helpFrame:SetHelp(L["HELP_TITLE"], L["HELP_TEXT"])
end
