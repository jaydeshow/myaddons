local VERSION = tonumber(("$Revision: 70154 $"):match("%d+"))

local tablet = AceLibrary("Tablet-2.0")
local tourist = AceLibrary:HasInstance("Tourist-2.0") and AceLibrary("Tourist-2.0") or nil
local dewdrop = AceLibrary("Dewdrop-2.0")
local quixote = AceLibrary("Quixote-1.0")
--local quixote = LibStub("LibQuixote-2.0")

local _G = getfenv(0)

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu")

QuestsFu = AceLibrary("AceAddon-2.0"):new("AceModuleCore-2.0", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
local QuestsFu = QuestsFu

QuestsFu.version = "r"..VERSION
QuestsFu.revision = VERSION
QuestsFu.date = ("$Date: 2008-04-16 23:39:35 -0400 (Wed, 16 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
QuestsFu.hasIcon = true
QuestsFu.clickableTooltip = true
QuestsFu.cannotHideText = true
QuestsFu.hideWithoutStandby = true

local new, del, newHash, newSet, deepCopy, deepDel, clear
do
	local list = setmetatable({}, {__mode='k'})
	function new(...)
		local t = next(list)
		if t then
			list[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			return t
		else
			return { ... }
		end
	end

	function newHash(...)
		local t = next(list)
		if t then
			list[t] = nil
		else
			t = {}
		end
		for i = 1, select('#', ...), 2 do
			t[select(i, ...)] = select(i+1, ...)
		end
		return t
	end

	function newSet(...)
		local t = next(list)
		if t then
			list[t] = nil
		else
			t = {}
		end
		for i = 1, select('#', ...) do
			t[select(i, ...)] = true
		end
		return t
	end

	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		t[''] = true
		t[''] = nil
		list[t] = true
		return nil
	end

	function clear(t)
		for k in pairs(t) do
			t[k] = nil
		end
		t[''] = true
		t[''] = nil
		return t
	end

	function deepCopy(from)
		if type(from) ~= "table" then
			return from
		end
		local to = new()
		for k,v in pairs(from) do
			to[k] = deepCopy(v)
		end
		return to
	end

	function deepDel(t)
		if type(t) ~= "table" then
			return nil
		end
		for k,v in pairs(t) do
			t[k] = deepDel(v)
		end
		return del(t)
	end
end
QuestsFu.new = new
QuestsFu.del = del
QuestsFu.newHash = newHash
QuestsFu.newSet = newSet
QuestsFu.deepCopy = deepCopy
QuestsFu.deepDel = deepDel
QuestsFu.clear = clear

do
	local function get_Active(name)
		if QuestsFu:HasModule(name) then
			return QuestsFu:IsModuleActive(name)
		else
			return false
		end
	end
	local function set_Active(name, value)
		if not QuestsFu:HasModule(name) then
			local _,_,_,_,loadable = GetAddOnInfo("FuBar_QuestsFu_" .. name)
			if loadable then
				LoadAddOn("FuBar_QuestsFu_" .. name)
			else
				return
			end
		end
		QuestsFu:ToggleModuleActive(name, value)
	end
	QuestsFu.menu = {
		type = "group",
		handler = QuestsFu,
		args = {
			modules = {
				name = L["Modules"], type = "text",
				desc = L["Modules"],
				multiToggle = true,
				validate = {},
				validateDesc = {},
				get = get_Active,
				set = set_Active,
				order = 1,
			},
			text = {
				type = 'group', name = L["Text"], order = 99,
				desc = L["Toolbar text"],
				args = {
					current = {
						type = 'toggle', name = L["Current"],
						desc = L["Show current # of quests"],
						get = function() return QuestsFu.db.profile.showTextOpt.current end,
						set = function(t) QuestsFu.db.profile.showTextOpt.current = t; QuestsFu:UpdateText() end,
					},
					complete = {
						type = 'toggle', name = L["Completed"],
						desc = L["Show # of quests completed"],
						get = function() return QuestsFu.db.profile.showTextOpt.complete end,
						set = function(t) QuestsFu.db.profile.showTextOpt.complete = t; QuestsFu:UpdateText() end,
					},
					total = {
						type = 'toggle', name = L["Total"],
						desc = L["Show total possible quests"],
						get = function() return QuestsFu.db.profile.showTextOpt.total end,
						set = function(t) QuestsFu.db.profile.showTextOpt.total = t; QuestsFu:UpdateText() end,
					},
					lastmessage = {
						type = 'toggle', name = L["Last message"],
						desc = L["Show last quest status message"],
						get = function() return QuestsFu.db.profile.showTextOpt.lastmessage end,
						set = function(t) QuestsFu.db.profile.showTextOpt.lastmessage = t; QuestsFu:UpdateText() end,
					},
				},
			},
			colors = {
				type = 'group', name = L["Colors"],
				desc = L["Choose custom colors"],
				get = function(k)
					return unpack(QuestsFu.db.profile.colors[k])
				end,
				set = function(k, r, g, b, a)
					local t = QuestsFu.db.profile.colors[k]
					t[1] = r
					t[2] = g
					t[3] = b
					QuestsFu:UpdateTooltip()
				end,
				pass = true,
				order = 99,
				args = {
					difficulty = {type = 'header', name = L["Difficulty"], order = 1,},
					trivial = {type = 'color', name = L["Trivial"], desc = L["Trivial"], order = 2,},
					standard = {type = 'color', name = L["Standard"], desc = L["Standard"], order = 3,},
					difficult = {type = 'color', name = L["Difficult"], desc = L["Difficult"], order = 4,},
					verydifficult = {type = 'color', name = L["Very difficult"], desc = L["Very difficult"], order = 5,},
					impossible = {type = 'color', name = L["Impossible"], desc = L["Impossible"], order = 6,},
					completion = {type = 'header', name = L["Completion"], order = 7,},
					notstarted = {type = 'color', name = L["Not started"], desc = L["Not started"], order = 8,},
					underway = {type = 'color', name = L["Underway"], desc = L["Underway"], order = 10,},
					done = {type = 'color', name = L["Done"], desc = L["Done"], order = 12,},
					other = {type = 'header', name = L["Other"], order = 13,},
					header = {type = 'color', name = L["Header"], desc = L["Header"], order = 14,},
				},
			},
			tablet = {
				type = 'group', name = L["FuBar Tablet"], order = 99,
				desc = L["Settings for the main FuBar tablet"],
				args = {
					levels = {
						type = 'group', name = L["Levels"], order = 99,
						desc = L["Show quest levels"],
						args = {
							tablet = {
								type = "toggle", name = L["In QuestsFu"],
								desc = L["Show quest levels in the QuestsFu tooltip"],
								get = function() return QuestsFu.db.profile.showLevelsTablet end,
								set = function(t) QuestsFu.db.profile.showLevelsTablet = t; QuestsFu:UpdateTooltip() end,
							},
							zone = {
								type = "toggle", name = L["Zone"],
								desc = L["Show zone levels in the QuestsFu tooltip"],
								get = function() return QuestsFu.db.profile.showLevelsZone end,
								set = function(t) QuestsFu.db.profile.showLevelsZone = t; QuestsFu:UpdateTooltip() end,
							},
						},
					},
					impossible = {
						type = 'toggle', name = L["Impossible quests"],
						desc = L["Show impossible (red) quests"],
						get = function() return QuestsFu.db.profile.showImpossible end,
						set = function(t) QuestsFu.db.profile.showImpossible = t; QuestsFu:UpdateTooltip() end,
					},
					area = {
						type = 'toggle', name = L["Zone"],
						desc = L["Show quest zones"],
						get = function() return QuestsFu.db.profile.showArea end,
						set = function(t) QuestsFu.db.profile.showArea = t; QuestsFu:UpdateTooltip() end,
					},
					caonly = {
						type = 'toggle', name = L["Current area only"],
						desc = L["Only show quests for the current zone"],
						get = function() return QuestsFu.db.profile.showCurrentAreaOnly end,
						set = function(t) QuestsFu.db.profile.showCurrentAreaOnly = t; QuestsFu:UpdateTooltip() end,
					},
					classanyway = {
						type = 'toggle', name = L["Class quests always"],
						desc = L["Always show class quests"],
						get = function() return QuestsFu.db.profile.showClassAlways end,
						set = function(t) QuestsFu.db.profile.showClassAlways = t; QuestsFu:UpdateTooltip() end,
					},
					description = {
						type = 'toggle', name = L["Details"],
						desc = L["Show quest details"],
						get = function() return QuestsFu.db.profile.showDescription end,
						set = function(t) QuestsFu.db.profile.showDescription = t; QuestsFu:UpdateTooltip() end,
					},
					cadonly = {
						type = 'toggle', name = L["Current area details only"],
						desc = L["Show details for current area quests only"],
						get = function() return QuestsFu.db.profile.showCurrentAreaDescriptionOnly end,
						set = function(t) QuestsFu.db.profile.showCurrentAreaDescriptionOnly = t; QuestsFu:UpdateTooltip() end,
					},
					completed= {
						type = 'toggle', name = L["Completed objectives"],
						desc = L["Show completed objectives"],
						get = function() return QuestsFu.db.profile.showCompletedObjectives end,
						set = function(t) QuestsFu.db.profile.showCompletedObjectives = t; QuestsFu:UpdateTooltip() end,
					},
					color = {
						type = 'group', name = L["Color"], order = 99,
						desc = L["Color settings"],
						args = {
							zone = {
								type = 'toggle', name = L["Zone"],
								desc = L["Color zone names by suggested level"],
								get = function() return QuestsFu.db.profile.color.zone end,
								set = function(t) QuestsFu.db.profile.color.zone = t; QuestsFu:UpdateTooltip() end,
							},
							title = {
								type = 'toggle', name = L["Title"],
								desc = L["Color the quest title by difficulty"],
								get = function() return QuestsFu.db.profile.color.title end,
								set = function(t) QuestsFu.db.profile.color.title = t; QuestsFu:UpdateTooltip() end,
							},
							level = {
								type = 'toggle', name = L["Level"],
								desc = L["Color the quest level by difficulty"],
								get = function() return QuestsFu.db.profile.color.level end,
								set = function(t) QuestsFu.db.profile.color.level = t; QuestsFu:UpdateTooltip() end,
							},
							objectives = {
								type = 'toggle', name = L["Objectives"],
								desc = L["Color objective completion status"],
								get = function() return QuestsFu.db.profile.color.objectives end,
								set = function(t) QuestsFu.db.profile.color.objectives = t; QuestsFu:UpdateTooltip() end,
							},
						},
					},
					wrap = {
						type = 'toggle', name = L["Wrap quest titles"],
						desc = L["Wrap long quest titles on to multiple lines"],
						get = function() return QuestsFu.db.profile.wrapQuests end,
						set = function(t) QuestsFu.db.profile.wrapQuests = t; QuestsFu:UpdateTooltip() end,
					},
				},
			},
		},
	}
end

function QuestsFu:OnInitialize()
	local colors = {
		notstarted = {1,0,0},
		underway = {1,1,0},
		done = {0,1,0},
	}

	for k,v in pairs(QuestDifficultyColor) do
		colors[k] = {v.r,v.g,v.b}
	end
	-- (Gets us: trivial, standard, difficult, verydifficult, impossible, header.)

	self:RegisterDB("QuestsFuDB")
	self:RegisterDefaults('profile', {
		showLevelsTablet = true,
		showLevelsZone = true,
		showImpossible = true,
		showArea = true,
		showCurrentAreaOnly = false,
		showClassAnyway = true,
		showCurrentAreaDescriptionOnly = false,
		showDescription = true,
		showCompletedObjectives = false,
		wrapQuests = true,
		showTextOpt = {
			total = true,
			current = true,
			complete = false,
			lastmessage = false,
		},
		color = {
			zone = true,
			level = true,
			title = true,
			objectives = true,
		},
		colors = colors,
	})
	self:RegisterDefaults('char', {
		hidden = {},
	})

	self:RegisterChatCommand({"/questsfu", "/fuq" }, self.options)
	self.OnMenuRequest = self.menu --FuBarPlugin

	self.lastuimessage = ""
	self.lastquestmessage = ""

	self.loadedWatchedQuests = false

	-- strip out any alpha values that might have made it into the colors
	for color, t in pairs(self.db.profile.colors) do
		if #t == 4 then
			table.remove(t)
		end
	end
end

local function InitializeExternalModules()
	for i = 1, GetNumAddOns() do
		local deps = newSet(GetAddOnDependencies(i))
		if deps["FuBar_QuestsFu"] and IsAddOnLoadOnDemand(i) and not IsAddOnLoaded(i) then
			local name = GetAddOnInfo(i)
			if name:find("^FuBar_QuestsFu_") then
				local modName = name:sub(14)
				local defaultState = tonumber(GetAddOnMetadata(name, "X-FuBar_QuestsFu-DefaultState"))
				self:SetModuleDefaultState(modName, defaultState ~= 0)
				if self:IsModuleActive(modName, true) then
					local _,_,_,_,loadable = GetAddOnInfo(i)
					if loadable then
						LoadAddOn(i)
					end
				else
					self.options.args.modules.validate[modName] = modName
					self.options.args.modules.validateDesc[modName] = GetAddOnMetadata(name, "Notes")
				end
			end
		end
		deps = del(deps)
	end
end

function QuestsFu:OnEnable()
	-- Modules:
	InitializeExternalModules()
	self:RegisterEvent("ADDON_LOADED")
	self:ADDON_LOADED()

	-- Actual functionality:
	if quixote.firstScanDone then
		self:RegisterEvent("Quixote_Update", "Update")
		self:RegisterEvent("PLAYER_LEVEL_UP", "UpdateTooltip") -- Quest difficulty colors can change on level; just redraw the tooltip in case they have it open while levelling.
		self:RegisterEvent("UI_INFO_MESSAGE","OnUIInfoMessage")
		self:RegisterEvent("MINIMAP_ZONE_CHANGED", "Update")
		self:RegisterEvent("ZONE_CHANGED", "Update")
		self:RegisterEvent("ZONE_CHANGED_INDOORS", "Update")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "Update")
	else
		self:RegisterEvent("Quixote_Ready", function() self:OnEnable() end, true)
	end
end

local pendingModules = {}
function QuestsFu:OnModuleCreated(name, module)
	self.menu.args.modules.validate[name] = module.lname and module.lname or name
	self.menu.args.modules.validateDesc[name] = (L["Toggle whether the %s module is active"]):format(name)
	pendingModules[name] = module
end

function QuestsFu:ADDON_LOADED()
	for name, module in pairs(pendingModules) do
		pendingModules[name] = nil
		if module.lname then
			self.menu.args.modules.validate[name] = module.lname
		end
		if module.desc then
			self.menu.args.modules.validateDesc[name] = module.desc
		end
	end
end

function QuestsFu:OnModuleEnable(module)
	self.menu.args[string.lower(module.name)] = module.menu
end

function QuestsFu:OnModuleDisable(module)
	self.menu.args[string.lower(module.name)] = nil
end

----------------------------------------------------
-- Quest info messages
----------------------------------------------------

function QuestsFu:OnUIInfoMessage()
	self.lastuimessage = arg1
	self:ScheduleEvent(self.ClearUIInfoMessage, 0.5, self)
end

function QuestsFu:ClearUIInfoMessage()
	self.lastuimessage = ""
end

----------------------------------------------------
-- FuBarPlugin OnFooUpdates
----------------------------------------------------

function QuestsFu:OnDataUpdate()
	self.lastquestmessage = self.lastuimessage
end

function QuestsFu:OnTextUpdate()
	local text = ""
	local maxQuests = MAX_QUESTS
	local r,g,b = GameFontNormal:GetTextColor()
	local numQuests, numQuestsDone = quixote:GetNumQuests()
	if self.db.profile.showTextOpt.complete then
		r,g,b = self:GetColorFromCompletion(numQuestsDone / numQuests)
		text = text .. self:Colorize(numQuestsDone, r, g, b)
	end
	if self.db.profile.showTextOpt.complete and (self.db.profile.showTextOpt.current or self.db.profile.showTextOpt.total) then
		text = text .. self:Colorize("/", r, g, b)
	end
	if self.db.profile.showTextOpt.current then
		r,g,b = self:GetColorFromCompletion((maxQuests - numQuests) / maxQuests)
		text = text .. self:Colorize(numQuests, r, g, b)
	end
	if self.db.profile.showTextOpt.current and self.db.profile.showTextOpt.total then
		text = text .. self:Colorize("/", r, g, b)
	end
	if self.db.profile.showTextOpt.total then
		text = text .. self:Colorize(maxQuests, r, g, b)
	end
	if (self.db.profile.showTextOpt.total or self.db.profile.showTextOpt.complete or self.db.profile.showTextOpt.current) and self.db.profile.showTextOpt.lastmessage and self.lastquestmessage ~= "" then
		text = text .. " m: "
	end
	if self.db.profile.showTextOpt.lastmessage and self.lastquestmessage ~= "" then
		text = text .. self.lastquestmessage
	end
	self:SetText(text)
end

function QuestsFu:OnTooltipUpdate()
	if quixote:GetNumQuests() > 0 then
		local cat
		if not self.db.profile.showArea then
			cat = tablet:AddCategory('columns', 2, 'child_func', 'QuestClick', 'child_arg1', self)
			for _,questid in quixote:QuestsByLevel() do
				self:AddQuestToCategory(cat, questid, true, self.db.profile.showDescription)
			end
		else
			local currentZone = GetZoneText()
			local zonename
			for _, zone in quixote:IterZones() do
				-- If showing area headers and either not showing only the current area's quests or this is the current area.
				if self.db.profile.showArea and ((currentZone == zone) or not self.db.profile.showCurrentAreaOnly or (self.db.profile.showClassAnyway and UnitClass("player") == zone)) then
					--local r,g,b = 0.749,1,0.749
					local r,g,b = unpack(self.db.profile.colors.header)
					zonename = zone
					if zone == UnitClass("player") then
						local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
						r,g,b = color.r, color.g, color.b
					elseif tourist and tourist:IsZoneOrInstance(zone) then
						if self.db.profile.showLevelsZone then
							local high, low = tourist:GetLevel(zone)
							if high > 0 and low > 0 then
								zonename = string.format("%s (%d-%d)", zone, high, low)
							end
						end
						if self.db.profile.color.zone then
							r,g,b = tourist:GetLevelColor(zone)
						end
					end
					cat = tablet:AddCategory(
						'id', zone, 'text', zonename,
						'columns', 2,
						'hideBlankLine', true, 'showWithoutChildren', true,
						'checked', true, 'hasCheck', true, 'checkIcon', self.db.char.hidden[zone] and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
						'func', 'ToggleCategory', 'arg1', self, 'arg2', zone,
						'textR', r, 'textG', g, 'textB', b,
						'child_func', 'QuestClick', 'child_arg1', self
					)
					-- If we're not hiding the zone and it's either the current zone or we're not showing only the current zone.
					if (not self.db.char.hidden[zone]) and ((not self.db.profile.showCurrentAreaOnly) or (currentZone == zone) or (self.db.profile.showClassAnyway and UnitClass("player") == zone)) then
						for _,questid in quixote:QuestsByZone(zone) do
							self:AddQuestToCategory(cat, questid, false, self.db.profile.showDescription)
						end
					end
				end
			end
		end
	end
	tablet:SetHint(L["TOOLTIP_HINT"])
end

----------------------------------------------------
-- Tablet utility functions
----------------------------------------------------

function QuestsFu:Colorize(s, r, g, b)
	return string.format("|c00%02X%02X%02X%s|r", (r or 255) * 255, (g or 255) * 255, (b or 255) * 255, s)
end

function QuestsFu:GetColorFromLevel(level)
	local color = GetDifficultyColor(level)
	-- Color should be the output of GetDifficultyColor; a table.
	if color == QuestDifficultyColor.trivial then
		return unpack(self.db.profile.colors.trivial)
	elseif color == QuestDifficultyColor.standard then
		return unpack(self.db.profile.colors.standard)
	elseif color == QuestDifficultyColor.difficult then
		return unpack(self.db.profile.colors.difficult)
	elseif color == QuestDifficultyColor.verydifficult then
		return unpack(self.db.profile.colors.verydifficult)
	elseif color == QuestDifficultyColor.impossible then
		return unpack(self.db.profile.colors.impossible)
	end
end

function QuestsFu:GetColorFromCompletion(percent)
	if percent <= 0 then
		return unpack(self.db.profile.colors.notstarted)
	elseif percent >= 1 then
		return unpack(self.db.profile.colors.done)
	elseif percent == 0.5 then
		return unpack(self.db.profile.colors.underway)
	elseif percent < 0.5 then
		percent = percent / 0.5
		local r1,g1,b1 = unpack(self.db.profile.colors.notstarted)
		local r2,g2,b2 = unpack(self.db.profile.colors.underway)
		return r1+(r2-r1)*percent, g1+(g2-g1)*percent, b1+(b2-b1)*percent
	elseif percent < 1 then
		percent = (percent-0.5) / 0.5
		local r1,g1,b1 = unpack(self.db.profile.colors.underway)
		local r2,g2,b2 = unpack(self.db.profile.colors.done)
		return r1+(r2-r1)*percent, g1+(g2-g1)*percent, b1+(b2-b1)*percent
	end
end

function QuestsFu:AddQuestToCategory(cat, questref, appendZone, showObjectives, hideChecks)
	local title, level, tag, suggestedGroup, complete, leaderboard, zone, questid = quixote:GetQuest(questref)
	if not title or not level then return end

	--Are we hiding impossible quests, and is this quest impossible?
	local questImpossible = (GetDifficultyColor(level) == QuestDifficultyColor.impossible)
	if not questImpossible or (questImpossible and self.db.profile.showImpossible) then
		local thisQuest, thisQuestColor
		local questLevel, questZone = "",""
		local currentZone = GetZoneText()
		local r,g,b = self:GetColorFromLevel(level)

		local questShared = QuestsFu:MembersOnQuest(questid)
		if appendZone then questZone = string.format(" (%s)", zone) end
		if self.db.profile.showLevelsTablet then questLevel = self:MakeTag(level, tag, suggestedGroup) end
		if complete == 1 then complete = L["(done)"]
		elseif complete == -1 then complete = L["(failed)"]
		else complete = nil end

		if not self.db.profile.color.title then title = self:Colorize(title, 1, 1, 1) end
		if not self.db.profile.color.level then questLevel = self:Colorize(questLevel, 1, 1, 1) end

		cat:AddLine(
			'text', questLevel..title..questZone..((questShared ~= 0) and " |c0000ff00<"..questShared..">|r" or ''), 'wrap', self.db.profile.wrapQuests,
			'text2', complete,
			'textR', r or 1, 'textG', g or 1, 'textB', b or 1,
			'text2R', (complete == L["(failed)"]) and 1 or 0, 'text2G', (complete == L["(done)"]) and 1 or 0, 'text2B', 0,
			'func', 'QuestClick', 'arg1', self, 'arg2', questid,
			'indentation', 6,
			'checked', self:IsWatched(questid),
			'hasCheck', (not hideChecks) and self:IsWatched(questid) or false
		)

		-- If we're showing descriptions/objectives and it's either the current zone or we're not showing descriptions only for the current zone.
		if showObjectives and ((currentZone == zone) or not self.db.profile.showCurrentAreaDescriptionOnly) then
			-- If we know of leaderboard objectives:
			if leaderboard > 0 then
				for i=1,leaderboard do
					self:AddLeaderboardToCategory(cat, questid, i)
				end
			-- Otherwise, if the quest is incomplete (or complete and we're showing completed objectives), add the generic objective.
			elseif not (complete and not self.db.profile.showCompletedObjectives) then
				local objective = quixote:GetQuestText(questid)
				cat:AddLine(
					'text', objective, 'wrap', true,
					'textR', r or 1, 'textG', g or 1, 'textB', b or 1,
					'size', tablet:GetNormalFontSize()-2,
					'arg2', questid,
					'indentation', 12
				)
			end
		end
	end
end

do
	local classhex = {}
	for class,colors in pairs(RAID_CLASS_COLORS) do
		classhex[class] = string.format("%02X%02X%02X", colors.r * 255, colors.g * 255, colors.b * 255)
	end
	function QuestsFu:AddLeaderboardToCategory(cat, questid, i, fontSize, indent)
		local title, level = quixote:GetQuest(questid)
		local description, qtype, numGot, numNeeded, done = quixote:GetQuestStatusById(questid, i)

		-- avoid nil value errors - Tue Jul 31 11:07:27 CEST 2007 - fin
		numGot		= numGot or 0
		numNeeded	= numNeeded or 0

		if not fontSize then fontSize = tablet:GetNormalFontSize()-2 end
		if not indent then indent = 12 end
		if not (done and not self.db.profile.showCompletedObjectives) then
			local r,g,b = self:GetColorFromLevel(level)
			if self.db.profile.color.objectives then
				r,g,b = self:GetColorFromCompletion(qtype == 'reputation' and (quixote:GetReactionLevel(numGot)/quixote:GetReactionLevel(numNeeded)) or (numGot/numNeeded))
			end
			local party = ''
			for i=1, GetNumPartyMembers(), 1 do
				local unit = 'party'..i
				local n = quixote:GetPartyQuestStatus(unit, title, description)
				if n and type(n) == 'number' then
					local formatstring
					if n == numNeeded then
						formatstring = "%s|c00%s%s:d|r "
					else
						formatstring = "%s|c00%s%s:%d|r "
					end
					local _,class = UnitClass(unit)
					party = string.format(formatstring, party, classhex[class], string.sub(UnitName(unit), 1, 3), n)
				end
			end
			cat:AddLine(
				'text', '  '..description,
				'text2', party .. (done and L["(done)"] or string.format("%s/%s", numGot, numNeeded)),
				'textR', r or 1, 'textG', g or 1, 'textB', b or 1,
				'text2R', r or 1, 'text2G', g or 1, 'text2B', b or 1,
				'size', fontSize, 'size2', fontSize,
				'arg2', questid,
				'indentation', indent
			)
		end
	end
end

function QuestsFu:ToggleCategory(id, button)
	self.db.char.hidden[id] = not self.db.char.hidden[id]
	self:UpdateTooltip()
end

function QuestsFu:QuestClick(questid)
	if IsAltKeyDown() then
		-- Shift-click toggles quest-watch on this quest.
		self:ToggleQuestWatch(questid)
	elseif IsShiftKeyDown() and IsControlKeyDown() and ChatFrameEditBox:IsVisible() then
		-- Add the quest objectives to the chat editbox, if it's open.
		local leaderboard = select(6, quixote:GetQuestById(questid))
		local i = 1
		for i=1,leaderboard do
			local description, qtype, numGot, numNeeded = quixote:GetQuestStatusById(questid, i)
			ChatFrameEditBox:Insert(string.format("{%s %s/%s} ", description, numGot, numNeeded))
		end
	elseif IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		-- Add quest link to the chat editbox if it's open.
		local name, level, tag, suggestedGroup = quixote:GetQuestById(questid)
		local questLink = GetQuestLink(questid)
		ChatFrameEditBox:Insert(self:MakeTag(level, tag, suggestedGroup)..questLink)
	elseif IsControlKeyDown() then
		self:ShareQuest(questid)
	else
		self:ShowLog(questid)
	end
end

function QuestsFu:ToggleQuestWatch(questid)
	if IsQuestWatched(questid) then
		RemoveQuestWatch(questid)
	else
		-- Set error if no objectives
		if GetNumQuestLeaderBoards(questid) == 0 then
			UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME)
			return
		end
		-- Set an error message if trying to show too many quests
		if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
			UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME)
			return
		end
		AddQuestWatch(questid)
	end
	QuestWatch_Update()
end

function QuestsFu:OnClick()
	ToggleQuestLog()
end

----------------------------------------------------
-- Utility functions
----------------------------------------------------

function QuestsFu:MakeTag(level, tag, suggestedGroup)
	return "[" .. level .. tag .. ((suggestedGroup and suggestedGroup > 1) and suggestedGroup or '') .. "] "
end

function QuestsFu:MembersOnQuest(questid)
	--Return the number of party members on a quest.  Returns zero if not in a party.
	local n = 0
	local party = GetNumPartyMembers()
	if party > 0 then
		for i = 1,party do
			n = n + (IsUnitOnQuest(questid, "party"..i) and 1 or 0)
		end
	end
	return n
end

function QuestsFu:ShowLog(questid)
	if QuestLogFrame:IsVisible() then
		if self.lastIndex == questid then
			HideUIPanel(QuestLogFrame)
		end
	else
		ShowUIPanel(QuestLogFrame)
	end
	local numEntries = GetNumQuestLogEntries()
	if (numEntries > QUESTS_DISPLAYED) then
		if (questid < numEntries - QUESTS_DISPLAYED) then
			FauxScrollFrame_SetOffset(QuestLogListScrollFrame, questid - 1)
			QuestLogListScrollFrameScrollBar:SetValue((questid - 1) * QUESTLOG_QUEST_HEIGHT)
		else
			FauxScrollFrame_SetOffset(QuestLogListScrollFrame, numEntries - QUESTS_DISPLAYED)
			QuestLogListScrollFrameScrollBar:SetValue((numEntries - QUESTS_DISPLAYED) * QUESTLOG_QUEST_HEIGHT)
		end
	end

	SelectQuestLogEntry(questid)
	QuestLog_SetSelection(questid)
	self.lastIndex = questid
	-- Lightheaded support
--~ 	if LightHeaded then
--~ 		LightHeaded:QuestLogTitleButton_OnClick()
--~ 	end
end

function QuestsFu:ShareQuest(questid)
	-- Share the quest with nearby party members.
	local wasSelected = GetQuestLogSelection()
	SelectQuestLogEntry(questid)
	if GetQuestLogPushable() and GetNumPartyMembers() > 0 then
		QuestLogPushQuest()
	end
	SelectQuestLogEntry(questid)
end

function QuestsFu:IsWatched(questid)
	if type(questid) == 'string' then
		local title, level, tag, suggestedGroup, complete, nObjectives, zone, id = quixote:GetQuest(self.questid)
		questid = select(8, quixote:GetQuestByName(questid))
	end
	return IsQuestWatched(questid)
end

function QuestsFu.reloadTablet(id)
	if tablet:IsRegistered(id) then
		tablet:Close(id)
		tablet:Unregister(id)
	end
end

function QuestsFu.toggleTablet(id, t)
	if tablet:IsRegistered(id) then
		if t then
			tablet:Open(id)
		else
			tablet:Close(id)
		end
	end
end

do
	local strataChoices = {['BACKGROUND'] = L['BACKGROUND'], ['LOW'] = L['LOW'], ['MEDIUM'] = L['MEDIUM'], ['HIGH'] = L['HIGH'], }
	function QuestsFu.strataOption(self, id, order)
		return {
			type = "text",
			name = L["Strata"],
			desc = L["Adjust the strata of this panel (takes effect after you reload your UI)"],
			get = function() return self.db.profile.strata end,
			set = function(t)
				self.db.profile.strata = t
				QuestsFu.reloadTablet(id)
				self:Update()
			end,
			validate = strataChoices,
			order = order,
		}
	end
end

function QuestsFu.maxHeightOption(self, id, order)
	return {
		type = "range",
		name = L["Max height"],
		desc = L["Adjust the maximum height of this panel, in pixels (takes effect after you reload your UI)"],
		get = function() return self.db.profile.maxHeight end,
		set = function(t)
			self.db.profile.maxHeight = t
			QuestsFu.reloadTablet(id)
			self:Update()
		end,
		min = 50, max = 800, step = 10,
		order = order,
	}
end

function QuestsFu.minWidthOption(self, id, order)
	return {
		type = "range",
		name = L["Minimum width"],
		desc = L["Adjust the minimum width of this panel, in pixels (takes effect after you reload your UI)"],
		get = function() return self.db.profile.minWidth end,
		set = function(t)
			self.db.profile.minWidth = t
			QuestsFu.reloadTablet(id)
			self:Update()
		end,
		min = 50, max = 800, step = 10,
		order = order,
	}
end

function QuestsFu.lockOption(self, id, order)
	return {
		type = 'toggle',
		name = L["Lock"],
		desc = L["Lock or unlock this panel"],
		disabled = function() return not tablet:IsRegistered(id) end,
		get = function() return tablet:IsRegistered(id) and tablet:IsLocked(id) end,
		set = function() tablet:ToggleLocked(id) end,
		order = order,
	}
end
