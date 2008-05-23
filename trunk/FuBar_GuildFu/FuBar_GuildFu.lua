-- setting upvalues

local _G				= getfenv(0)

local ipairs			= _G.ipairs
local select			= _G.select

local table_insert		= _G.table.insert
local table_remove		= _G.table.remove
local table_sort		= _G.table.sort

local GetGuildRosterInfo	= _G.GetGuildRosterInfo
local GetNumGuildMembers	= _G.GetNumGuildMembers
local IsAddOnLoaded			= _G.IsAddOnLoaded
local UnitInParty			= _G.UnitInParty
local UnitInRaid			= _G.UnitInRaid

local tablet = AceLibrary("Tablet-2.0")
local T = AceLibrary("Tourist-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_GuildFu")

FuBar_GuildFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
local FuBar_GuildFu = FuBar_GuildFu
FuBar_GuildFu.revision = tonumber(string.sub("$Revision: 73182 $", 12, -3)) or 1

FuBar_GuildFu.hasIcon = true
FuBar_GuildFu.hasNoColor = true
FuBar_GuildFu.clickableTooltip = true
FuBar_GuildFu:RegisterDB("FuBar_GuildFuDB")
FuBar_GuildFu:RegisterDefaults("profile", {
	text = {
		show_guildname = false,
		show_displayed = true,
		show_online = true,
		show_total = true,
	},
	tooltip = {
		motd_show = true,
		sort = "ZONE",
		group_show = true,
		name_color = "CLASS",
		name_status = true,
		class_show = false,
		class_align = "CENTER",
		level_show = true,
		level_align = "CENTER",
		level_color = "RELATIVE",
		zone_show = true,
		zone_align = "CENTER",
		zone_color = "FACTION",
		note_showpublic = true,
		note_showofficer = true,
		note_showauldlangsyne = true,
		note_showctplayernotes = true,
		note_align = "CENTER",
		rank_show = true,
		rank_align = "RIGHT",
	},
	filter = {
		class_druid = true,
		class_hunter = true,
		class_mage = true,
		class_paladin = true,
		class_priest = true,
		class_rogue = true,
		class_shaman = true,
		class_warlock = true,
		class_warrior = true,
		level_0109 = true,
		level_1019 = true,
		level_2029 = true,
		level_3039 = true,
		level_4049 = true,
		level_5059 = true,
		level_6069 = true,
		level_70 = true,
		zone_bg = true,
		zone_inst = true,
		zone_open = true,
	}
})

function FuBar_GuildFu:OnInitialize()
	self.players = {}
end

function FuBar_GuildFu:OnEnable()
	self:RegisterEvent("PLAYER_GUILD_UPDATE")
	
	self:RegisterEvent("GUILD_MOTD")
	
	if IsInGuild() then
		self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
		self:RegisterBucketEvent("GUILD_ROSTER_UPDATE", 1)
		self:RegisterBucketEvent("RosterLib_RosterChanged", 1, "UpdateTooltip")
		GuildRoster()
	end
end

-- function FuBar_GuildFu:OnDisable()
-- end

function FuBar_GuildFu:GUILD_MOTD()
	self:UpdateTooltip()
end

function FuBar_GuildFu:GUILD_ROSTER_UPDATE()
--	if not arg1 or (arg1 and arg7 and arg8) then
--		print("[GuildFu] Debug: GUILD_ROSTER_UPDATE fired with args...")
		self:Update()
--	end
end

function FuBar_GuildFu:PLAYER_GUILD_UPDATE()
	if arg1 and arg1 ~= "player" then return end
--	print("[GuildFu] Debug: PLAYER_GUILD_UPDATE fired...")
	if IsInGuild() then
		if not self:IsBucketEventRegistered("GUILD_ROSTER_UPDATE") then
			self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
			self:RegisterBucketEvent("GUILD_ROSTER_UPDATE", 1)
			self:RegisterBucketEvent("RosterLib_RosterChanged", 1, "UpdateTooltip")
		end
		GuildRoster()
	else
		if self:IsBucketEventRegistered("GUILD_ROSTER_UPDATE") then
			self:CancelScheduledEvent("ScheduledGuildRoster")
			self:UnregisterBucketEvent("GUILD_ROSTER_UPDATE")
			self:UnregisterBucketEvent("RosterLib_RosterChanged")
		end
	end
end

FuBar_GuildFu.sorts ={
	NAME =	function(a,b)
				return a[1]<b[1]
			end,
	CLASS =	function(a,b)
				if a[5]<b[5] then
					return true
				elseif a[5]>b[5] then
					return false
				else
					if a[4]<b[4] then
						return true
					elseif a[4]>b[4] then
						return false
					else
						return FuBar_GuildFu.sorts.NAME(a, b)
					end
				end
			end,
	LEVEL =	function(a,b)
				if a[4]<b[4] then
					return true
				elseif a[4]>b[4] then
					return false
				else
					if a[5]<b[5] then
						return true
					elseif a[5]>b[5] then
						return false
					else
						return FuBar_GuildFu.sorts.NAME(a, b)
					end
				end
			end,
	ZONE =	function(a,b)
				if a[6]<b[6] then
					return true
				elseif a[6]>b[6] then
					return false
				else
					return FuBar_GuildFu.sorts.CLASS(a, b)
				end
			end,
	RANK = function(a,b)
				if a[3]<b[3] then
					return true
				elseif a[3]>b[3] then
					return false
				else
					return FuBar_GuildFu.sorts.CLASS(a, b)
				end
			end,
}

local tablecache = {}
local function recycleplayertable(t)
	while #t > 0 do
		table_insert(tablecache, table_remove(t))
	end
	return t
end
local function getplayertable(...)
	local t
	if #tablecache > 0 then
		t = table_remove(tablecache)
	else
		t = {}
	end
	for i = 1, select('#', ...) do
		t[i] = select(i, ...)
	end
	return t
end

function FuBar_GuildFu:OnDataUpdate()
	if IsInGuild() then
		local players = recycleplayertable(self.players)
		local playersShown = 0
		local playersOnline = 0
		local numGuildMembers = GetNumGuildMembers(true)
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classconst
		for i = 1, numGuildMembers, 1 do
			name, rank, rankIndex, level, class, zone, note, officernote, online, status, classconst = GetGuildRosterInfo(i)
			if note == "" then note = nil end
			if officernote == "" then officernote = nil end
			if online then
				playersOnline = playersOnline + 1
				if self:checkFilter(classconst, level, zone) then
					playersShown = playersShown + 1
					table.insert(players, getplayertable(name or UNKNOWN, rank or UNKNOWN, rankIndex or -1, level or -1, class or UNKNOWN, zone or UNKNOWN, status, note, officernote, classconst))
				end
			end
		end
		table.sort(players, self.sorts[self.db.profile.tooltip.sort])
		
		self.players = players
		self.playersShown = playersShown
		self.playersOnline = playersOnline
		self.playersTotal = numGuildMembers
	else
		self.players = {}
		self.playersShown = 0
		self.playersOnline = 0
		self.playersTotal = 0
	end
end

function FuBar_GuildFu:OnTextUpdate()
	if not IsInGuild() then
		self:SetText(L["No Guild"])
		return
	end
	if self.playersTotal == 0 then
		self:SetText(L["Updating..."])
		return
	end
	
	local needdash = false
	local needslash = false
	local temptext = ""

	local settings_text = self.db.profile.text
	if settings_text.show_guildname then
		self.guildName = GetGuildInfo("player")
		temptext = temptext..self.guildName
		needdash = true
	end
	if settings_text.show_displayed then
		if needdash then
			temptext = temptext.." - "
			needdash = false
		end
		temptext = temptext..self.playersShown
		needslash = true
	end
	if settings_text.show_online then
		if needdash then
			temptext = temptext.." - "
			needdash = false
		end
		if needslash then
			temptext = temptext.."/"
		end
		temptext = temptext..self.playersOnline
		needslash = true
	end
	if settings_text.show_total then
		if needdash then
			temptext = temptext.." - "
			needdash = false
		end
		if needslash then
			temptext = temptext.."/"
		end
		temptext = temptext..self.playersTotal
	end
	if temptext ~= "" then
		self:SetText(temptext)
	else
		self:SetText("")
	end
end

local AuldLangSyne_notes
local CT_PlayerNotes_loaded

function FuBar_GuildFu:OnTooltipUpdate()
	local settings_tooltip = self.db.profile.tooltip
	local cat
	if not IsInGuild() then
		cat = tablet:AddCategory(
			'columns', 1,
			'text', L["You aren't in a guild."],
			'hideBlankLine', true,
			'showWithoutChildren', true
		)
		return
	end

	if self.playersShown == 0 then
		cat = tablet:AddCategory(
			'columns', 1,
			'text', L["All guild mates offline or filtered."],
			'hideBlankLine', true,
			'showWithoutChildren', true
		)
		return
	end

	AuldLangSyne_notes = AuldLangSyne_notes or AuldLangSyne and AuldLangSyne:HasModule("Note") and AuldLangSyne:GetModule("Note")
	CT_PlayerNotes_loaded = CT_PlayerNotes_loaded or IsAddOnLoaded("CT_PlayerNotes")

	if settings_tooltip.motd_show then
		self.guildMOTD = GetGuildRosterMOTD()
		cat = tablet:AddCategory(
			'columns', 1,
			'text', L["MOTD"]
		)
		cat:AddLine(
			'text', self.guildMOTD,
			'wrap', true,
			'textR', 1,
			'textG', 1,
			'textB', 0
		)
	end

	local cols = {}
	table_insert(cols, L["Name"])
	if settings_tooltip.class_show then
		table_insert(cols, L["Class"])
	end
	if settings_tooltip.level_show then
		table_insert(cols, L["Level"])
	end
	if settings_tooltip.zone_show then
		table_insert(cols, L["Zone"])
	end
	if (settings_tooltip.note_showpublic
		or (settings_tooltip.note_showofficer and CanViewOfficerNote())
		or (AuldLangSyne_notes and settings_tooltip.note_showauldlangsyne)
		or (CT_PlayerNotes_loaded and settings_tooltip.note_showctplayernotes)) then
		table_insert(cols, L["Notes"])
	end
	if settings_tooltip.rank_show then
		table_insert(cols, L["Rank"])
	end

	cat = tablet:AddCategory(
		'columns', #cols
	)
	local header = {}
	for i = 1, #cols do
		if i == 1 then
			header['text'] = cols[i]
			header['justify'] = "CENTER"
		else
			header['text'..i] = cols[i]
			header['justify'..i] = "CENTER"
		end
	end
	cat:AddLine(header)
	local line = {}
	local colcount
	local temptext
	local classcolor
	local levelcolor
	local zonecolorR, zonecolorG, zonecolorB
	local reverse_class = self.reverse_class
	for _, data in ipairs(self.players) do
		classcolor = RAID_CLASS_COLORS[data[10]]
		levelcolor = GetDifficultyColor(data[4])
		if settings_tooltip.name_status and data[7] ~= "" then
			line['text'] = data[7].." "..data[1]
		else
			line['text'] = data[1]
		end
		if settings_tooltip.name_color == "CLASS" then
			line['textR'] = classcolor.r
			line['textG'] = classcolor.g
			line['textB'] = classcolor.b
		else
			line['textR'] = 1
			line['textG'] = 1
			line['textB'] = 0
		end
		colcount = 1
		if settings_tooltip.class_show then
			colcount = colcount + 1
			line['text'..colcount] = data[5]
			line['justify'..colcount] = settings_tooltip.class_align
			line['text'..colcount..'R'] = classcolor.r
			line['text'..colcount..'G'] = classcolor.g
			line['text'..colcount..'B'] = classcolor.b
		end
		if settings_tooltip.level_show then
			colcount = colcount + 1
			line['text'..colcount] = data[4]
			line['justify'..colcount] = settings_tooltip.level_align
			line['text'..colcount..'R'] = levelcolor.r
			line['text'..colcount..'G'] = levelcolor.g
			line['text'..colcount..'B'] = levelcolor.b
		end
		if settings_tooltip.zone_show then
			colcount = colcount + 1
			line['text'..colcount] = data[6]
			line['justify'..colcount] = settings_tooltip.zone_align
			if settings_tooltip.zone_color == "FACTION" then
				zonecolorR, zonecolorG, zonecolorB = T:GetFactionColor(data[6])
			elseif settings_tooltip.zone_color == "LEVEL" then
				zonecolorR, zonecolorG, zonecolorB = T:GetLevelColor(data[6])
			else
				zonecolorR, zonecolorG, zonecolorB = 1, 1, 0
			end
			line['text'..colcount..'R'] = zonecolorR
			line['text'..colcount..'G'] = zonecolorG
			line['text'..colcount..'B'] = zonecolorB
		end
		if (settings_tooltip.note_showpublic
			or (settings_tooltip.note_showofficer and CanViewOfficerNote())
			or (AuldLangSyne_notes and settings_tooltip.note_showauldlangsyne)
			or (CT_PlayerNotes_loaded and settings_tooltip.note_showctplayernotes)) then
			colcount = colcount + 1
			temptext = ""
			if settings_tooltip.note_showpublic then
				temptext = ((data[8] and (" ["..data[8].."] ")) or " - ")
			end
			if settings_tooltip.note_showofficer and CanViewOfficerNote() then
				temptext = temptext..((data[9] and (" ["..data[9].."] ")) or " - ")
			end
			if AuldLangSyne_notes and settings_tooltip.note_showauldlangsyne then
				temptext = temptext ..((AuldLangSyne_notes.db.realm.guild[data[1]] and (" {"..AuldLangSyne_notes.db.realm.guild[data[1]].."} ")) or "")
			end
			if CT_PlayerNotes_loaded and settings_tooltip.note_showctplayernotes then
				temptext = temptext ..((CT_GuildNotes[data[1]] and (" {"..CT_GuildNotes[data[1]].."} ")) or "")
			end
			line['text'..colcount] = temptext
			line['justify'..colcount] = settings_tooltip.note_align
			line['text'..colcount..'R'] = 1
			line['text'..colcount..'G'] = 1
			line['text'..colcount..'B'] = 0
		end
		if settings_tooltip.rank_show then
			colcount = colcount + 1
			line['text'..colcount] = data[2]
			line['justify'..colcount] = settings_tooltip.rank_align
			line['text'..colcount..'R'] = 1
			line['text'..colcount..'G'] = 1
			line['text'..colcount..'B'] = 0
		end
		line['func'] = 'OnNameClick'
		line['arg1'] = self
		line['arg2'] = data[1]
		if settings_tooltip.group_show then
			line['hasCheck'] = true
			line['checked'] = (UnitInParty(data[1]) or UnitInRaid(data[1])) and true
-- 'checkIcon', self.factions[i].isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
		end

		cat:AddLine(line)
	end
end

function FuBar_GuildFu:OnClick()
	ToggleFriendsFrame(3) 
end

function FuBar_GuildFu:OnNameClick(name)
	if not name then return end
	if IsAltKeyDown() then
		InviteUnit(name)
	else
		SetItemRef("player:"..name, "|Hplayer:"..name.."|h["..name.."|h", "LeftButton")
	end
end

function FuBar_GuildFu:checkFilter(class, level, zone)
	local settings_filter = self.db.profile.filter
	if not settings_filter.class_druid		and class == "DRUID"		then return false end
	if not settings_filter.class_hunter		and class == "HUNTER"	then return false end
	if not settings_filter.class_mage		and class == "MAGE"		then return false end
	if not settings_filter.class_paladin	and class == "PALADIN"	then return false end
	if not settings_filter.class_priest		and class == "PRIEST"	then return false end
	if not settings_filter.class_rogue		and class == "ROGUE"		then return false end
	if not settings_filter.class_shaman		and class == "SHAMAN"	then return false end
	if not settings_filter.class_warlock	and class == "WARLOCK"	then return false end
	if not settings_filter.class_warrior	and class == "WARRIOR"	then return false end
	
	if not settings_filter.level_0109 and level < 10 then return false end
	if not settings_filter.level_1019 and level >= 10 and level < 20 then return false end
	if not settings_filter.level_2029 and level >= 20 and level < 30 then return false end
	if not settings_filter.level_3039 and level >= 30 and level < 40 then return false end
	if not settings_filter.level_4049 and level >= 40 and level < 50 then return false end
	if not settings_filter.level_5059 and level >= 50 and level < 60 then return false end
	if not settings_filter.level_6069 and level >= 60 and level < 70 then return false end
	if not settings_filter.level_70 and level == 70 then return false end
	
	if not settings_filter.zone_bg and T:IsBattleground(zone) then return false end
	if not settings_filter.zone_inst and T:IsInstance(zone) and not T:IsBattleground(zone) then return false end
	if not settings_filter.zone_open and T:IsZone(zone) then return false end
	
	return true
end
