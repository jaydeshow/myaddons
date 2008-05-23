Cartographer_QuestInfo = Cartographer:NewModule("QuestInfo", "AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1")

-------------------------------------------------------------------

local CQI = Cartographer_QuestInfo
local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo")

local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local Gratuity = LibStub("LibGratuity-3.0")

local C = Cartographer
local CN = Cartographer_Notes
local CQ = C:HasModule("Quests") and C:GetModule("Quests")
local CQO = C:HasModule("Quest Objectives") and C:GetModule("Quest Objectives")

-------------------------------------------------------------------

CQI:RegisterDB("Cartographer_QuestInfoDB")
CQI:RegisterDefaults("profile", {
	iconAlpha = 1,
	iconScale = 1,
	minimapIcons = true,
	cartoButton = true,
	wideQuestLog = false,
})

-------------------------------------------------------------------

function CQI:OnInitialize()
	if not CN then
		return C:ToggleModuleActive(self, false)
	end

	local CL = Cartographer.L
	local options = {
		toggle = {
			name = CL["Enabled"],
			desc = CL["Suspend/resume this module."],
			type = "toggle",
			order = 10,
			get = function() return C:IsModuleActive(self) end,
			set = function() C:ToggleModuleActive(self) end,
		},
		data = {
			name = L["Export"],
			desc = L["Export quest data to other addon."],
			type = "group",
			args = {
				quests = {
					name = L["Quests"],
					desc = L["Export quest data to Cartographer Quests."],
					type = "group",
					disabled = not CQ,
					args = {
						export = {
							name = L["Export data"],
							desc = L["Export quest data, this will take huge space."],
							type = "execute",
							func = function() self:ExportToQuestsModule() end,
							order = 10,
						},
						clear = {
							name = L["Clear exported data"],
							desc = L["Clear exported data."],
							type = "execute",
							func = function() self:RemoveFromQuestsModule() end,
							order = 20,
						},
					},
				},
				objectives = {
					name = L["Quest Objectives"],
					desc = L["Export quest data to Cartographer QuestObjectives."],
					type = "group",
					disabled = not CQO,
					args = {
						export = {
							name = L["Export data"],
							desc = L["Export quest data, this will take huge space."],
							type = "execute",
							func = function() self:ExportToObjectivesModule() end,
							order = 10,
						},
						clear = {
							name = L["Clear exported data"],
							desc = L["Clear exported data."],
							type = "execute",
							func = function() self:RemoveFromObjectivesModule() end,
							order = 20,
						},
					},
				},
			},
			order = 20,
		},
		iconalpha = {
			name = L["Icon alpha"],
			desc = L["Alpha transparency of the icon."],
			type = "range",
			min = 0.1,
			max = 1,
			step = 0.05,
			isPercent = true,
	        get = function() return self.db.profile.iconAlpha end,
	        set = function(v) self.db.profile.iconAlpha = v; CN:RefreshMap() end,
			order = 40
		},
		iconscale = {
			name = L["Icon size"],
			desc = L["Size of the icons on the map."],
			type = "range",
			min = 0.5,
			max = 2,
			step = 0.05,
			isPercent = true,
	        get = function() return self.db.profile.iconScale end,
	        set = function(v) self.db.profile.iconScale = v; CN:RefreshMap() end,
			order = 50
		},
		minimapicons = {
			name = L["Show minimap icons"],
			desc = L["Show quest icons on the minimap."],
			type = "toggle",
	        get = function() return self.db.profile.minimapIcons end,
	        set = function() self.db.profile.minimapIcons = not self.db.profile.minimapIcons; CN:RefreshMap() end,
			order = 60,
		},
		worldmapicon = {
			name = L["Show world map button"],
			desc = L["Show button on the world map."],
			type = "toggle",
	        get = function() return self.db.profile.cartoButton end,
	        set = function() self:ToggleCartoButton() end,
			order = 70,
		},
		widequestlog = {
			name = L["Make quest log double wide"],
			desc = L["Make the quest log window double wide, this will require UI reload."],
			type = "toggle",
	        get = function() return self.db.profile.wideQuestLog end,
	        set = function() self.db.profile.wideQuestLog = not self.db.profile.wideQuestLog end,
			order = 80,
		},
	}

	Cartographer.options.args.QuestInfo = {
		name = L["Quest Info"],
		desc = L["Module description"],
		type = "group",
		args = options,
		handler = self,
	}

	self:PurgeHostileQuests()
	self:SecureHook("QuestLog_UpdateQuestDetails")
end

function CQI:OnEnable()
	self:EnableCartoMap()

	if self.db.profile.wideQuestLog then
		self:ExtendQuestLog()
	end
end

function CQI:OnDisable()
	self:DisableCartoMap()
end

-------------------------------------------------------------------

----
-- Scan Quest tooltip to get title and objective title
----
function CQI:GetQuestText(uid, level)
	local link = "|cff808080|Hquest:"..uid..":"..level.."|h[dummy]|h|r"
	Gratuity:SetHyperlink(link)

	local n = Gratuity:NumLines()
	if n <= 0 then return end

	local title, desc, objs
	local desc_state = 0

	for i = 1, n do
		local line = Gratuity:GetLine(i):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("[\n\t]", " ")
		if i == 1 then
			title = line
		elseif line == " " then
			desc_state = desc_state + 1
		elseif desc_state == 1 then
			desc = (desc or "")..line
		else
			local _, _, o = line:find("^%s+%- (.-)x?%d*$")
			if o then
				if not objs then
					objs = {}
				end
				table.insert(objs, o)
			end
		end
	end

	return "["..level.."] "..title, title, desc, objs
end

----
-- Get Quest short summary, this is fast
----
function CQI:PeekQuest(uid)
	local data = QuestInfo_Quest[uid]
	if not data then return end

	local _, _, side, level_req, level, start_npc, end_npc, sharable =
		data.i:find("^(.)`(%d+)`(%d+)`(%-?%d+)`(%-?%d+)`(%d+)$")
	return tonumber(level),tonumber(level_req), tonumber(start_npc), tonumber(end_npc), sharable == "1",  side, data
end

-------------------------------------------------------------------

----
-- Get NPC info from database
----
function CQI:GetNPC(id, zone_filter)
	local data = QuestInfo_NPC[id]
	if not data then return end

	local _, _, level_min, level_max, classify, loc = data:find("^(%d+)`(%d+)`(%d+)(|.*)$")
	local out = {}
	out.id = id
	out.name = QuestInfo_Name[id]
	out.level_min = tonumber(level_min)
	out.level_max = tonumber(level_max)
	out.classify = tonumber(classify)

	for zone, pos in loc:gmatch("|(%d+):([^|]*)") do
		zone = tonumber(zone)
		local zone_name = QuestInfo_Zone[zone]
		if (not zone_filter or zone_filter == zone) and zone_name then
			if not out.loc then
				out.loc = {}
			end
			if not out.loc[zone_name] then
				out.loc[zone_name] = {}
			end
			for x, y in string.gmatch(pos, "(%d+),(%d+)") do
				table.insert(out.loc[zone_name], {x = tonumber(x)/10, y = tonumber(y)/10})
			end
		end
	end

	return out
end

----
-- Get quest info from database
----
function CQI:GetQuest(uid, ignore_obj)
	local level, level_req, start_npc, end_npc, sharable, side, data = self:PeekQuest(uid)
	if not data then return end

	local out = {}
	out.id = uid
	out.side = side
	out.level = level
	out.level_req = level_req
	out.sharable = sharable
	out.start_npc = self:GetNPC(start_npc)
	out.end_npc = self:GetNPC(end_npc)

	local q_title_full, q_title, q_desc, q_objs = self:GetQuestText(uid, level)
	out.title = q_title or "????"
	out.title_full = q_title_full or "????"
	out.desc = q_desc

	if ignore_obj then return out end

	if data.o then
		out.objs = {}
		for i, o in pairs(data.o) do
			local obj = {}
			obj.title = q_objs and q_objs[i] or "????"
			for npc_id, npc_zone in string.gmatch(o, "(%-?%d+)@?(%d*)") do
				local npc = self:GetNPC(tonumber(npc_id), tonumber(npc_zone))
				if npc then
					if not obj.npcs then
						obj.npcs = {}
					end
					table.insert(obj.npcs, npc)
				end
			end
			out.objs[i] = obj
		end
	end

	if data.s then
		out.series = {}
		for qid in string.gmatch(data.s, "(%d+)") do
			table.insert(out.series, tonumber(qid))
		end
	end

	return out
end

-------------------------------------------------------------------

function CQI:GetQuestColor(level)
	local diff = level - UnitLevel("player")
	if diff >= 5 then -- red / impossible
		return 1, 0.125, 0.125
	elseif diff >= 3 then -- orange / very difficult
		return 1, 0.5, 0.25
	elseif diff >= -2 then -- yellow / difficult
		return 1, 1, 0
	elseif -diff <= GetQuestGreenRange() then -- green / standard
		return 0.25, 0.75, 0.25
	else -- grey / trivial
		return 0.5, 0.5, 0.5
	end
end

function CQI:PurgeHostileQuests()
	local hostile = (UnitFactionGroup("player") == "Alliance") and "H" or "A"
	for uid, data in pairs(QuestInfo_Quest) do
		if data.i:sub(1, 1) == hostile then
			QuestInfo_Quest[uid] = nil
		end
	end
end

-------------------------------------------------------------------

local _cq

function CQI:BatchExportToQuestsModule()
	local CQDB = CQ.db.faction

	while true do
		local uid = next(QuestInfo_Quest, _cq.current_uid)
		if not uid then break end
		local q = CQI:GetQuest(uid, true)

		if q.start_npc and q.start_npc.loc then
			if q.title == "????" and _cq.retry < 15 then
				_cq.retry = _cq.retry + 1
				self:ScheduleEvent("CQI-BatchExportToQuestsModule", self.BatchExportToQuestsModule, _cq.retry / 2, self)
				return
			end
			if q.title ~= "????" and not CQDB or not CQDB.quests[q.title] then
				for zone, pos in pairs(q.start_npc.loc) do
					if BZR[zone] then
						for _, l in ipairs(pos) do
							if l.x ~= 0 and l.y ~= 0 then
								CQ:SetNote(zone, l.x, l.y, q.start_npc.name, { [q.title] = q.level })
								CQDB.quests[q.title].CQI = true
								_cq.count = _cq.count + 1
								if (_cq.count % 100) == 0 then
									self:Print(string.format(L["Exporting %d quests..."], _cq.count))
								end
							end
						end
					end
				end
			end
		end

		_cq.retry = 0
		_cq.current_uid = uid
	end

	self:Print(string.format(L["Total %d quests have been exported."], _cq.count))
end

function CQI:ExportToQuestsModule()
	if not CQ then return end

	self:Print(L["Clear old exported quests first."])
	self:RemoveFromQuestsModule()

	self:Print(L["Begin exporting new quests."])
	self:CancelScheduledEvent("CQI-BatchExportToQuestsModule")
	_cq = {}
	_cq.count = 0
	_cq.retry = 0
	_cq.current_uid = nil
	self:BatchExportToQuestsModule()
end

function CQI:RemoveFromQuestsModule()
	if not CQ then return end

	local CQDB = CQ.db.faction
	if not CQDB or not CQDB.quests then return end

	for k, v in pairs(CQDB.quests) do
		if v.CQI then
			CQDB.quests[k] = nil
		end
	end

	CN:RefreshMap(true)
end

-------------------------------------------------------------------

local _cqo

function CQI:BatchExportToObjectivesModule()
	while true do
		local uid = next(QuestInfo_Quest, _cqo.current_uid)
		if not uid then break end
		local q = CQI:GetQuest(uid)

		if q.objs then
			if q.title == "????" and _cqo.retry < 15 then
				_cqo.retry = _cqo.retry + 1
				self:ScheduleEvent("CQI-BatchExportToObjectivesModule", self.BatchExportToObjectivesModule, _cqo.retry / 2, self)
				return
			end

			if q.title ~= "????" then
				for oid, o in ipairs(q.objs) do
					local pos_list = {}
					if o.npcs then
						for _, npc in ipairs(o.npcs) do
							for zone, loc in pairs(npc.loc) do
								if BZR[zone] then
									for _, l in ipairs(pos) do
										if l.x ~= 0 and l.y ~= 0 then
											table.insert(pos_list, { zone = zone, x = l.x, y = l.y })
										end
									end
								end
							end
						end
					end
					for _, pos in ipairs(pos_list) do
						local otype = o.id < 0 and "item" or "monster"
						CQO:SetNote(pos.zone, q.title, o.name, pos.x, pos.y, #q.objs, q.level, oid, otype, L["Quest Info"], #pos_list, pos.zone)
						_cqo.count = _cqo.count + 1
						if (_cqo.count % 100) == 0 then
							self:Print(string.format(L["Exporting %d quest objects..."], _cqo.count))
						end
					end
				end
			end
		end

		_cqo.retry = 0
		_cqo.current_uid = uid
	end

	self:Print(string.format(L["Total %d quest objects have been exported."], _cqo.count))
end

function CQI:ExportToObjectivesModule()
	if not CQO then return end

	self:Print(L["Clear old exported objectives first."])
	self:RemoveFromObjectivesModule()

	self:Print(L["Begin exporting new quest objectives."])
	self:CancelScheduledEvent("CQI-BatchExportToObjectivesModule")
	_cqo = {}
	_cqo.count = 0
	_cqo.retry = 0
	_cqo.current_uid = nil
	self:BatchExportToObjectivesModule()
end

function CQI:RemoveFromObjectivesModule()
	if not CQO then return end
	CQO:DeleteNotes("", 0, { quest = "N/A", level = 0, sender = L["Quest Info"] }, "allsource")
end
