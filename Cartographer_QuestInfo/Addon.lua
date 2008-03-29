-- import quest data from QuestLibrary
-- add quick reference to quest log window
-- by purple

Cartographer_QuestInfo = Cartographer:NewModule("QuestInfo", "AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1")

-------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo");
local BZ = AceLibrary("Babble-Zone-2.2");

local Dewdrop = AceLibrary("Dewdrop-2.0");
local Tablet = AceLibrary("Tablet-2.0");
local Tourist = AceLibrary("Tourist-2.0");
local Quixote = AceLibrary("Quixote-1.0");

local C = Cartographer;
local CN = Cartographer_Notes;
local CQ = Cartographer:HasModule("Quests") and Cartographer:GetModule("Quests");
local CQO = Cartographer:HasModule("Quest Objectives") and Cartographer:GetModule("Quest Objectives");

local CQI = Cartographer_QuestInfo;
local CQI_NOTES = {};
local CQI_DB = {};
local CQI_WORLD;
local CQI_BUTTON;

-- bypass hooks
local GetQuestLogTitle = GetQuestLogTitle

CQI.noteDefaults = {
	titleCol = CN.getColorID(1, 0.5, 0)
}

CQI:RegisterDB("Cartographer_QuestInfoDB")

CQI:RegisterDefaults("profile", {
	iconStyle = "default",
	iconAlpha = 1,
	iconScale = 1,
	minimapIcons = true,
	mapButton = true,
	isClean = false,
});

-------------------------------------------------------------------

local DB_NAME = "QuestInfo";
local DB_VERSION = 1;

local CQI_ICON_SET = {
	["default"] = {
		["giver"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\GreyQuestStart",
		["start"] = "Interface\\GossipFrame\\AvailableQuestIcon",
		["end"] = "Interface\\GossipFrame\\ActiveQuestIcon",
		["item"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkItem",
		["monster"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkMonster",
		["event"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
		["object"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
		["unknown"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
	},
	["object"] = {
		["giver"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\GreyQuestStart",
		["start"] = "Interface\\GossipFrame\\AvailableQuestIcon",
		["end"] = "Interface\\GossipFrame\\ActiveQuestIcon",
		["item"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QuestItem",
		["monster"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QuestMonster",
		["event"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QuestEvent",
		["object"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QuestEvent",
		["unknown"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\QuestEvent",
	},
	["mark"] = {
		["giver"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkStart",
		["start"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkStart",
		["end"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEnd",
		["item"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkItem",
		["monster"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkMonster",
		["event"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
		["object"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
		["unknown"] = "Interface\\AddOns\\Cartographer_QuestInfo\\Artwork\\MarkEvent",
	},
};

local CQI_OBJ_TYPES = {
	["giver"] = L["Quest Start"],
	["start"] = L["Quest Start"],
	["end"] = L["Quest End"],
	["item"] = L["Quest Item"],
	["monster"] = L["Quest Monster"],
	["event"] = L["Quest Event"],
	["object"] = L["Quest Object"],
	["unknown"] = L["Quest Objective"],
};

-------------------------------------------------------------------

function CQI:DecodeQuestInfo(line)
	local _, _, count, kind = string.find(line, "(%d+)`(.+)");
	return tonumber(count), kind;
end

function CQI:DecodeQuestObject(line, ignore_loc)
	local _, _, name, zone = string.find(line, "([^`]+)`([^`]+)");

	if ignore_loc then 
		return name, zone;
	end
	
	local loc = {};
	for x, y in string.gmatch(line, "`(%d+),(%d+)") do
		table.insert(loc, { x = tonumber(x) / 10000, y = tonumber(y) / 10000 });
	end
	return name, zone, loc;
end

function CQI:GetQuest(level, title, desc)
	local id = string.format("%d`%s", level, title);
	local q = CQI_DB[id];
	if not q then
		for i = 1,5 do
			id = string.format("%d`%s", level + i, title)
			q = CQI_DB[id]
			if q then break end
			id = string.format("%d`%s", level - i, title)
			q = CQI_DB[id]
			if q then break end
		end
	end
	if not q then
		-- try to match half-width/full-width form
		if id:find("[:?!]") then
			id = id:gsub(":", "："):gsub("?", "？"):gsub("!", "！");
		else
			id = id:gsub("：", ":"):gsub("？", "?"):gsub("！", "!")
		end
		q = CQI_DB[id];
		if not q then return nil end
	end
	if #q == 0 then return q, id end

	desc = desc:gsub("：", ":"):gsub("？", "?"):gsub("！", "!");
	for _, iq in ipairs(q) do
		local i_desc = iq.d:gsub("：", ":"):gsub("？", "?"):gsub("！", "!");
		if i_desc == desc then return iq, id end
	end
	return nil;
end

function CQI:RegisterQuestData(s_db)
	for q_id, s_q in pairs(s_db) do
		local q = CQI_DB[q_id];
		if not q then
			CQI_DB[q_id] = s_q;
		elseif #q == 0 then
			for k, v in pairs(s_q) do
				if not q[k] then
					q[k] = v;
				end
			end
		elseif s_q.d then
			local q_level, q_title = DecodeQuestInfo(q_id);
			local i_q = GetQuest(q_level, q_title, s_q.d);
			if not i_q then
				table.insert(q, s_q);
			else
				for k, v in pairs(s_q) do
					if not i_q[k] then
						i_q[k] = v;
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------

function CQI:OnInitialize()
	if not CN then
		return Cartographer:ToggleModuleActive(self, false)
	end
	
	if not CQI_WORLD then
		CQI_WORLD = {};
		local continents = { GetMapContinents() };
		for i = 1, #continents do
			local zones = { GetMapZones(i) };
			for j = 1, #zones do
				if not CQI_WORLD[zones[j]] then
					CQI_WORLD[zones[j]] = { i, j };
				end
			end
		end
	end
	
	local CL = Cartographer.L;
	local options = {
		toggle = {
			name = CL["Enabled"],
			desc = CL["Suspend/resume this module."],
			type = "toggle",
			order = 10,
			get = function() return Cartographer:IsModuleActive(self) end,
			set = function() Cartographer:ToggleModuleActive(self) end,
		},
		data = {
			name = L["Export"],
			desc = L["Export quest data to other addon."],
			type = "group",
			args = {
				objectives = {
					name = L["Export to QuestObjectives"],
					desc = L["Export quest data to Cartographer QuestObjectives, this will take huge space."],
					type = "execute",
					func = function() self:ExportQuestData() end,
					order = 10,
				},
				clearobjectives = {
					name = L["Remove from QuestObjectives"],
					desc = L["Remove exported data from Cartographer QuestObjectives."],
					type = "execute",
					func = function() self:ClearExportedData() end,
					order = 20,
				},
			},
			order = 20,
		},
		iconstyle = {
			name = L["Icon style"],
			desc = L["Style of the icon."],
			type = "text",
			validate = { ["default"] = L["Default"], ["object"] = L["Object"], ["mark"] = L["Mark"] },
			get = function() return self.db.profile.iconStyle end,
			set = function(v) self:ChangeIconStyle(v) end,
			order = 30,
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
	        get = function() return self.db.profile.mapButton end,
	        set = function() self:ToggleMapButton() end,
			order = 70,
		},
	};

	if not CQO then
		options.data = nil;
	end

	Cartographer.options.args.QuestInfo = {
		name = L["Quest Info"],
		desc = L["Module description"],
		type = "group",
		args = options,
		handler = self,
	};

	self:Hook_IsNoteHidden(CQ);
	self:Hook_IsNoteHidden(CQO);
	self:SecureHook("QuestLog_UpdateQuestDetails");
	
end

function CQI:OnEnable()
	if not CN then
		return Cartographer:ToggleModuleActive(self, false)
	end
	
	if not self.db.profile.isClean then
		self:ClearExportedData();
		self.db.profile.isClean = true;
	end
	
	if self.db.profile.mapButton then
		self:ToggleMapButton("show");
	end
	
	for id, name in pairs(CQI_OBJ_TYPES) do
		CN:RegisterIcon(DB_NAME.."-"..id, {
			text = name,
			path = CQI_ICON_SET[self.db.profile.iconStyle][id],
			width = 14,
			height = 14,
		});
	end
	
    CN:RegisterNotesDatabase(DB_NAME, CQI_NOTES, self);
	CN:RefreshMap(true);
end

function CQI:OnDisable()
    CN:UnregisterNotesDatabase(DB_NAME);

	for id in pairs(CQI_OBJ_TYPES) do
		CN:UnregisterIcon(DB_NAME.."-"..id);
	end

	if self.db.profile.mapButton then
		self:ToggleMapButton("hide");
	end
end

function CQI:CreateMapButton()
	local options = {
		current = {
			name = L["Show active quests"],
			desc = L["Show all info of active quests in current map."],
			type = "execute",
			func = function() self:ShowActiveQuests(); Dewdrop:Close() end,
			order = 10,
		},
		available = {
			name = L["Show available quests"],
			desc = L["Show the givers of available quests in current map."],
			type = "execute",
			func = function() self:ShowAvialableQuests(); Dewdrop:Close() end,
			order = 20,
		},
		clear = {
			name = L["Clear quest icons"],
			desc = L["Clear quest icons generated by QuestInfo"],
			type = "execute",
			func = function() self:ClearQuestNotes(); Dewdrop:Close() end,
			order = 30,
		},
	};

	local button = CreateFrame("Button", "QuestInfoButton", WorldMapFrame, "UIPanelButtonTemplate")
	button:SetText(L["Quest Info"]);
	button:SetWidth(button:GetTextWidth() + 30);
	button:SetHeight(22);
	
	button:SetScript("OnClick", function()
		Dewdrop:Register(this,
			"children", { type = "group", args = options },
			"dontHook", true,
			"point", "TOPRIGHT",
			"relativePoint", "BOTTOMRIGHT"
		);
		this:SetScript("OnClick", function()
			if IsShiftKeyDown() then
				self:ClearQuestNotes(); 
				Dewdrop:Close();
				return;
			end
			if Dewdrop:IsOpen(this) then
				Dewdrop:Close();
			else
				Dewdrop:Open(this);
			end
		end);
		this:GetScript("OnClick")();
	end);
	
	button:SetScript("OnEnter", function(this)
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(L["Open QuestInfo menu"], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:Show();
	end);
	
	button:SetScript("OnLeave", function(this)
		GameTooltip:Hide();
	end);
	
	return button;
end

function CQI:ToggleMapButton(mode)
	local on = not self.db.profile.mapButton;
	if mode == "show" then
		on = true;
	elseif mode == "hide" then
		on = false;
	end
	if on then
		if not CQI_BUTTON then
			CQI_BUTTON = self:CreateMapButton();
		end
		C:AddMapButton(CQI_BUTTON, -2);
	else
		if CQI_BUTTON then
		    C:RemoveMapButton(CQI_BUTTON);
		end
	end
	if not mode then
		self.db.profile.mapButton = on;
	end
end

function CQI:ChangeIconStyle(style)
	self.db.profile.iconStyle = style;
	if not C:IsModuleActive(self) then return end
	local map = CQI_ICON_SET[style];
	for name, path in pairs(map) do
		CN:OverrideIconGraphic(DB_NAME.."-"..name, path);
	end
	CN:RefreshMap(true);
end

-------------------------------------------------------------------

function CQI:ExportQuest(q_id, q)
	if not q.o then return end
	local q_level, q_name = self:DecodeQuestInfo(q_id);
	for lid, o in ipairs(q.o) do
		local pos_list = {};
		local o_count, o_type = self:DecodeQuestInfo(o.i);
		for _, pos in ipairs(o) do
			local npc, zone, loc = self:DecodeQuestObject(pos);
			if BZ:HasReverseTranslation(zone) then
				for _, l in ipairs(loc) do
					if l.x > 0 or l.y > 0 then
						table.insert(pos_list, { zone = zone, x = l.x, y = l.y });
					end
				end
			end
		end
		for _, pos in ipairs(pos_list) do
			CQO:SetNote(pos.zone, q_name, o.t, pos.x, pos.y, o_count, q_level, lid, o_type, L["Quest Info"], #pos_list, q.z);
		end
	end
end

function CQI:ExportQuestData()
	if not CQO then return end

	self:Print(L["Clear old exported data first."]);
	self:ClearExportedData();
	
	self:Print(L["Begin export new quest data."]);
	local n = 0;
	for q_id, q in pairs(CQI_DB) do
		if #q > 0 then
			-- export all objectives for multi-part data regardless
			for _, iq in ipairs(q) do
				self:ExportQuest(q_id, iq);
				n = n + 1;
			end
		else
			self:ExportQuest(q_id, q);
			n = n + 1;
		end
	end
	self:Print(string.format(L["Total %d quest objects have been exported."], n));
end

function CQI:ClearExportedData()
	if not CQO then return end

	if type(L["legacy-data"]) == "table" then
		for _, name in ipairs(L["legacy-data"]) do
			CQO:DeleteNotes("", 0, { quest = "N/A", level = 0, sender = name }, "allsource");
		end
	end
	CQO:DeleteNotes("", 0, { quest = "N/A", level = 0, sender = L["Quest Info"] }, "allsource");
end

-------------------------------------------------------------------

function CQI:ClearQuestNotes()
    CN:UnregisterNotesDatabase(DB_NAME);
    CQI_NOTES = {};
    CN:RegisterNotesDatabase(DB_NAME, CQI_NOTES, self);
    CN:RefreshMap();
end

function CQI:AddQuestNotes(quest, obj, type, name, zone, loc)
	if not BZ:HasReverseTranslation(zone) then return end

	quest = string.format("[%d] %s", self:DecodeQuestInfo(quest));

	if not CQI_OBJ_TYPES[type] then
		type = "unknown";
	end

	for _, l in ipairs(loc) do
		CN:SetNote(zone, l.x, l.y, DB_NAME.."-"..type, DB_NAME,
			"quest", quest,
			"obj", obj,
			"type", type,
			"name", name);
	end
end

function CQI:GotoQuestZone(zone)    
	self:CloseObjectiveFrame();
	ShowUIPanel(WorldMapFrame);

    if CQI_WORLD[zone] then
    	local idx = CQI_WORLD[zone];
    	SetMapZoom(idx[1], idx[2]);
    elseif Tourist:IsInstance(zone) then
--~     	Cartographer:SetCurrentInstance(BZ.reverse[zone]);
		Cartographer_InstanceMaps:ShowInstance(BZ.reverse[zone]);
    end
end

function CQI:OpenQuestMap(quest, obj, type, zone, npc_list)
	for _, npc in ipairs(npc_list) do
		self:AddQuestNotes(quest, obj, type, npc.name, zone, npc.loc);
	end
	self:GotoQuestZone(zone);
end

-------------------------------------------------------------------

function CQI:ShowActiveQuests()
	self:ClearQuestNotes();
	local zone = C:GetCurrentLocalizedZoneName();
	for _, id in Quixote:IterateQuests() do
		local title, level, _, _, complete, _, _, qq_id = Quixote:GetQuest(id);
		local desc = Quixote:GetQuestText(id);
		local q, q_id = self:GetQuest(level, title, desc);
		if q then
			if q.a and not complete then
				local npc, z, loc = self:DecodeQuestObject(q.a);
				if z == zone then
					self:AddQuestNotes(q_id, L["Quest Start"], "start", npc, z, loc);
				end
			end
			if q.c and complete then
				local npc, z, loc = self:DecodeQuestObject(q.c);
				if z == zone then
					self:AddQuestNotes(q_id, L["Quest End"], "end", npc, z, loc);
				end
			end
			if q.o and not complete then
				for lid, o in ipairs(q.o) do
					local desc, _, _, _, done = Quixote:GetQuestStatusById(qq_id, lid);
					if not done or o.t ~= string.gsub(desc, L["objective-filter"], "%1") then
						local _, o_type = self:DecodeQuestInfo(o.i);
						for _, p in ipairs(o) do
							local npc, z, loc = self:DecodeQuestObject(p);
							if z == zone then
								self:AddQuestNotes(q_id, o.t, o_type, npc, z, loc);
							end
						end
					end
				end
			end
		end
	end
end

function CQI:ShowAvialableQuests()
	self:ClearQuestNotes();
	local zone = C:GetCurrentLocalizedZoneName();
	local level = UnitLevel("player");
	for q_id, q in pairs(CQI_DB) do
		if q.a and (q.z == zone or not BZ:HasReverseTranslation(q.z)) then
			local q_level, q_title = self:DecodeQuestInfo(q_id);
			if q_level >= level - 9 and q_level <= level + 5 then
				local npc, z, loc = self:DecodeQuestObject(q.a);
				if z == zone then
					local _, _, _, _, complete = Quixote:GetQuest(q_title);
					if not complete then
						self:AddQuestNotes(q_id, L["Quest Start"], "giver", npc, z, loc);
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------

--
-- for start and end npc, the CQI_Data is:
-- { 
--		quest = "level`title",
--		npc = "name`zone`x,y",
-- },
--
-- for objective, the CQI_Data is:
-- {
--		quest = "level`title",
--		obj = { 
--			"name`zone`x,y`x2,y2`...", 
--			..., 
--			i = "count`tyype", 
--			t = "title",
--		},
-- }
--
function CQI:QuestLog_UpdateQuestDetails()
	self:CloseObjectiveFrame();
	CQI_StartButton:Hide();
	CQI_EndButton:Hide();
	
	for i = 1, 9 do
		local button = getglobal("CQI_ObjButton"..i);
		button:Hide();
	end

	if not C:IsModuleActive(self) then return end

	local q_title, q_level = GetQuestLogTitle(GetQuestLogSelection());
	local _, q_desc = GetQuestLogQuestText();

	local q, q_info = self:GetQuest(q_level, q_title, q_desc);
	if not q then return end
	
	if q.a then
		CQI_StartButton.CQI_Data = {
			quest = q_info,
			npc = q.a,
		};
		CQI_StartButton:Show();
	end

	if q.c then
		CQI_EndButton.CQI_Data = {
			quest = q_info,
			npc = q.c,
		};
		CQI_EndButton:Show();
	end
	
	if q.o then
		for i = 1, 9 do
			local q_string = getglobal("QuestLogObjective"..i);
			if q_string:IsVisible() then
	 			local text = string.gsub(q_string:GetText(), L["objective-filter"], "%1");
				text = string.gsub(text, L[":.+$"], "");
				for lid, o in ipairs(q.o) do
					local o_text = string.gsub(o.t, L["objective-filter"], "%1");
					o_text = string.gsub(o_text, L[":.+$"], "");
	 				if o_text == text and lid > 0 then
						local button = getglobal("CQI_ObjButton"..i);
						button.CQI_Data = {
							quest = q_info,
							obj = o,
						};
			 			button:ClearAllPoints();
						button:SetPoint("TOPLEFT", q_string, "TOPLEFT", 0, 0);
						button:SetPoint("BOTTOMRIGHT", q_string, "BOTTOMRIGHT", 0, 0);
						button:Show();
	 				end
	 			end
			end
		end
	end
end

--[[
-- Added by ZeroFire
-- to use this, add code in QuestFu.lua line 523, modify the param of this func:
			cat:AddLine(
				'text', '  '..description,
				'text2', party .. (done and L["(done)"] or string.format("%s/%s", numGot, numNeeded)),
				'textR', r or 1, 'textG', g or 1, 'textB', b or 1,
				'text2R', r or 1, 'text2G', g or 1, 'text2B', b or 1,
				'size', fontSize, 'size2', fontSize,
				'arg2', questid,
				'indentation', indent,
				-- add following params
				'func',function(a,b,c)
					if Cartographer_QuestInfo and Cartographer_QuestInfo.OnQuestFuClick then
						Cartographer_QuestInfo:OnQuestFuClick(a,b,c)
					end
				end,
				'arg1',description
				'checked', true, 'hasCheck', true, 'checkIcon', 'Interface\\GossipFrame\\PetitionGossipIcon',
			)
--]]
function CQI:OnQuestFuClick(objective,questid)
	if not C:IsModuleActive(self) then return end

	local q_title, q_level = GetQuestLogTitle(questid);
	local q_desc = Quixote:GetQuestText(questid)
	local q, q_info = self:GetQuest(q_level, q_title, q_desc);
	
	if not q or not q.o then return end

	for lid, o in ipairs(q.o) do
		local o_text = string.gsub(o.t, L["objective-filter"], "%1");
		o_text = string.gsub(o_text, L[":.+$"], "");

		if o_text == objective and lid > 0 then
			this = {
				CQI_Data = {
					quest = q_info,
					obj = o,
				},
			}
			self:OnButtonClick()
			break
		end
	end
end

function CQI:OnButtonClick(type)
	if not CN or not this.CQI_Data then return end
	local data = this.CQI_Data;
	
	self:CloseObjectiveFrame();
	CQI_Tooltip:Hide();
	self:ClearQuestNotes();

	if type == "start" then
		local npc, zone, loc = self:DecodeQuestObject(data.npc);
		self:AddQuestNotes(data.quest, L["Quest Start"], type, npc, zone, loc);
		self:GotoQuestZone(zone);
		
	elseif type == "end" then
		local npc, zone, loc = self:DecodeQuestObject(data.npc);
		self:AddQuestNotes(data.quest, L["Quest End"], type, npc, zone, loc);
		self:GotoQuestZone(zone);

	else
		local map = { 
			quest = data.quest,
			name = data.obj.t,
			info = data.obj.i,
			zones = {},
		};
		local zone_count = 0;
		local zone_one = nil;
		
		for _, o in ipairs(data.obj) do
			local npc, zone, loc = self:DecodeQuestObject(o);
			if BZ:HasReverseTranslation(zone) then
				local entry = {
					name = npc,
					loc = loc,
				};
				if not map.zones[zone] then
					map.zones[zone] = { entry };
					zone_one = zone;
					zone_count = zone_count + 1;
				else
					table.insert(map.zones[zone], entry);
				end
			end
		end
		
		if zone_count == 1 then
			local _, o_type = self:DecodeQuestInfo(map.info);
			self:OpenQuestMap(data.quest, data.obj.t, o_type, zone_one, map.zones[zone_one]);
		else
			self:OpenObjectiveFrame(map);
		end
	end
end

function CQI:OnButtonTooltip(type)
	local data = this.CQI_Data;
	if not data then return end
	
	CQI_Tooltip:SetOwner(this, "ANCHOR_RIGHT");
	CQI_Tooltip:ClearLines();
	
	if type == "start" then
		local npc, zone, loc = self:DecodeQuestObject(data.npc);
		CQI_Tooltip:AddLine(L["Quest Start"], 1, 0.5, 0);
		CQI_Tooltip:AddLine(npc, 1, 1, 1);
		CQI_Tooltip:AddLine(string.format("%s <%d,%d>", zone, math.floor(loc[1].x * 100), math.floor(loc[1].y * 100)), 0, 1, 0);

	elseif type == "end" then
		local npc, zone, loc = self:DecodeQuestObject(data.npc);
		CQI_Tooltip:AddLine(L["Quest End"], 1, 0.5, 0);
		CQI_Tooltip:AddLine(npc, 1, 1, 1);
		CQI_Tooltip:AddLine(string.format("%s <%d,%d>", zone, math.floor(loc[1].x * 100), math.floor(loc[1].y * 100)), 0, 1, 0);

	elseif #data.obj > 0 then
		CQI_Tooltip:AddLine(L["Quest Objective"], 1, 0.5, 0);
		for i, o in ipairs(data.obj) do
			if i <= 5 then
				local npc, zone = self:DecodeQuestObject(o, true);
				CQI_Tooltip:AddDoubleLine(npc, zone, 1, 1, 1, 0, 1, 0);
			else
				CQI_Tooltip:AddDoubleLine(" ", L["... more"], 1, 1, 1, 0.6, 0.6, 0.6);
				break;
			end
		end
	end
	
	CQI_Tooltip:Show();
end

-------------------------------------------------------------------

function CQI:OpenObjectiveFrame(map)
	if self.OBJMAP ~= map then
		self.OBJMAP = map;
	else
		self.OBJMAP = nil;
	end
	self.OBJZONES = {};
	self:ScheduleEvent(CQI.UpdateObjectiveFrame, 0, self);
end

function CQI:UpdateObjectiveFrame()
	if not Tablet:IsRegistered("CQI_Objectives") then
		Tablet:Register("CQI_Objectives",
			"data", {},
			"clickable", true,
			'movable', true,
			"cantAttach", true,
			"dontHook", true, 
			"showTitleWhenDetached", true,
			"hideWhenEmpty", true,
			"strata", "HIGH",
			"minWidth", 350,
			"children", function() self:UpdateObjectiveContent() end);
		Tablet:Open("CQI_Objectives");
	end
	Tablet:Refresh("CQI_Objectives");
end

function CQI:CloseObjectiveFrame()
	if Tablet:IsRegistered("CQI_Objectives") then
		self:OpenObjectiveFrame(nil);
	end
end

--
-- OBJMAP is:
-- {
--		quest = "level`title",
--		name = "name",
--		info = "count`type",
--		zones = { 
--			["zone"] = { 
--				{ 
--					name = "name", 
--					loc = { { x = number, y = number }, ... },
--				}, 
--				... 
--			},
--			...
--		}
-- }
--
function CQI:UpdateObjectiveContent()
	local map = self.OBJMAP;
	if not map then return end
	local _, o_type = self:DecodeQuestInfo(map.info);
	Tablet:SetTitle(map.name);
	for zone, npc_list in pairs(map.zones) do
		local cat = Tablet:AddCategory(
			"id", zone,
			"columns", 2,
			"hideBlankLine", true,
			"text", zone,
			"size", 12,
			"child_size", 11,
			"child_size2", 10,
			"textR", 1, "textG", 0.5, "textB", 0, 
			"child_textR", 1, "child_textG", 1, "child_textB", 1,
			"child_text2R", 0, "child_text2G", 1, "child_text2B", 0, 
			"child_wrap2", true,
			"func", function() self:OpenQuestMap(map.quest, map.name, o_type, zone, npc_list) end);
		
		for _, npc in ipairs(npc_list) do
			local where = "";
			for _, l in ipairs(npc.loc) do
				where = where..string.format(" <%d,%d>", math.floor(l.x * 100), math.floor(l.y * 100));
			end
			cat:AddLine(
				"text", npc.name,
				"text2", where,
				"indentation", 10,
				"func", function() self:OpenQuestMap(map.quest, map.name, o_type, zone, { npc }) end);
		end
	end
	Tablet:AddCategory("hideBlankLine"):AddLine(
		"text", L["Close"],
		"size", 11,
		"justify", "center",
		"func", function() self:CloseObjectiveFrame() end);		
end

-------------------------------------------------------------------

function CQI:OnNoteTooltipRequest(zone, id, data, inMinimap)
	Tablet:SetTitle(data.quest);
	Tablet:SetTitleColor(1, 0.5, 0);

	local sub_title = CQI_OBJ_TYPES[data.type] or L["Quest Objective"];
	local cat = Tablet:AddCategory(
		"text", sub_title,
		"columns", 2,
		"wrap", true,
		"justify2", "RIGHT"
	);

	if data.type == "start" or data.type == "end" or data.type == "giver" then
		cat:AddLine("text", L["Name:"], "text2", data.name);
	else
		cat:AddLine("text", L["Objective:"], "text2", data.obj);	
		if data.obj ~= data.name then
			cat:AddLine("text", L["Source:"], "text2", data.name);
		end
	end

 	if not inMinimap then
 		local x, y = CN.getXY(tonumber(id));
		Tablet:AddCategory("hideBlankLine", true, "columns", 2):AddLine(
			"text", L["Location:"], "text2", string.format("<%d,%d>", math.floor(x * 100), math.floor(y * 100)));
	end
end

function CQI:OnNoteTooltipLineRequest(zone, id, data, inMinimap)
	return "text", string.format("%s: %s - %s", CQI_OBJ_TYPES[data.type] or L["Quest Objective"], data.quest, data.name);
end

function CQI:IsMiniNoteHidden(zone, id, data)
	return not self.db.profile.minimapIcons;
end

function CQI:GetNoteTransparency(zone, id, data)
	return self.db.profile.iconAlpha;
end

function CQI:GetNoteScaling(zone, id, data)
	return self.db.profile.iconScale;
end

function CQI:Hook_IsNoteHidden(obj) 
	if not obj then return end
	local func = obj.IsNoteHidden;
	obj.IsNoteHidden = function(self, zone, id, ...)
		if CQI_NOTES[zone] and CQI_NOTES[zone][id] then
			return true;
		end
		if func then
			return func(self, zone, id, ...);
		end
		return false;
	end
end
