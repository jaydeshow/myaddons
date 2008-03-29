-- HEADER
local Capping = CreateFrame("Button", "Capping", UIParent)
local self = Capping
local L = CappingLocale

-- LIBRARIES
local media = LibStub("LibSharedMedia-2.0")
local dew = AceLibrary("Dewdrop-2.0")
local candy = AceLibrary("CandyBar-2.0")

-- GLOBALS MADE LOCAL
local format, strfind, strlower = format, strfind, strlower

-- LOCAL VARS
local db, f, bg, wasInBG, bgmap
local activebars, allbars = { }, { }
local av, ab, eots, wsg = L["Alterac Valley"], L["Arathi Basin"], L["Eye of the Storm"], L["Warsong Gulch"]
local abbrv = { av = av, ab = ab, eots = eots, wsg = wsg, }

-- LOCAL FUNCS
local ShowOptions, oldSetPoint, adddrop
local function IsInBG()
	return select(2, IsInInstance()) == "pvp"
end
local function IsInArena()
	return select(2, IsInInstance()) == "arena"
end
local function ToggleAnchor()
	if f:IsShown() then 
		f:Hide()
	else 
		f:Show() 
	end
end
local function InitBGMap()
	bgmap = BattlefieldMinimap
	self:ModMap()
	adddrop()
end
local function UpdateWorldInfoPosition()
	if not oldSetPoint then
		oldSetPoint = WorldStateAlwaysUpFrame.SetPoint
		WorldStateAlwaysUpFrame.SetPoint = function(this)
			this:ClearAllPoints()
			oldSetPoint(this, "TOP", UIParent, "TOPLEFT", db.sbx, db.sby)
		end
	end
	WorldStateAlwaysUpFrame:SetPoint()
end
local function SetDefaults(db, t)
	for k,v in pairs(t) do
		if type(db[k]) == "table" then
			SetDefaults(db[k], v)
		else
			db[k] = (db[k] ~= nil and db[k]) or v
		end
	end
end
local t1
local function SetLayout(this)
	dew:Close()
	if not t1 then
		t1 = this:CreateFontString(nil, "ARTWORK")
		t1:SetFontObject(GameFontNormalLarge)
		t1:SetJustifyH("LEFT") 
		t1:SetJustifyV("TOP")
		t1:SetPoint("TOPLEFT", 16, -16)
		t1:SetText(this.name)
		
		local t2 = this:CreateFontString(nil, "ARTWORK")
		t2:SetFontObject(GameFontHighlightSmall)
		t2:SetJustifyH("LEFT") 
		t2:SetJustifyV("TOP")
		t2:SetHeight(43)
		t2:SetPoint("TOPLEFT", t1, "BOTTOMLEFT", 0, -8)
		t2:SetPoint("RIGHT", this, "RIGHT", -32, 0)
		t2:SetNonSpaceWrap(true)
		local function GetInfo(field)
			return GetAddOnMetadata(this.addon, field) or "N/A"
		end
		t2:SetFormattedText("Notes: %s\nAuthor: %s\nVersion: %s", GetInfo("Notes"), GetInfo("Author"), GetInfo("Version"))
	
		local b = CreateFrame("Button", nil, this, "UIPanelButtonTemplate")
		b:SetWidth(120)
		b:SetHeight(20)
		b:SetText("Options Menu")
		b:SetScript("OnClick", ShowOptions)
		b:SetPoint("TOPLEFT", t2, "BOTTOMLEFT", -2, -8)
	end
end
local function CreateUIOptionsFrame(addon)
	local panel = CreateFrame("Frame")
	panel.name = GetAddOnMetadata(addon, "Title") or addon
	panel.addon = addon
	panel:SetScript("OnShow", SetLayout)
	InterfaceOptions_AddCategory(panel)
end


-- EVENT HANDLERS
local elist, clist = {}, {}
Capping:SetScript("OnEvent", function(this, event, ...)
	this[elist[event] or event](this, ...)
end)
function Capping:RegisterTempEvent(event, other)
	self:RegisterEvent(event)
	elist[event] = other or event
end
function Capping:UnregisterAllTempEvents()
	for event in pairs(elist) do
		elist[event] = nil
		self:UnregisterEvent(event)
	end
end
function Capping:CheckCombat(func)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		tinsert(clist, func)
	else
		func(self)
	end
end
function Capping:PLAYER_REGEN_ENABLED()
	for k,v in ipairs(clist) do
		v(self)
		clist[k] = nil
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end
Capping:RegisterEvent("ADDON_LOADED")


---------------------------------
function Capping:ADDON_LOADED(a1)
---------------------------------
	if a1 ~= "Capping" then return end
	self:UnregisterEvent("ADDON_LOADED")
	
	-- saved variables database setup
	CappingDB = CappingDB or {}
	db = (CappingDB.profiles and CappingDB.profiles.Default) or CappingDB
	self.db = db
	if not db.dbinit then 
		SetDefaults(db, {
			av = true,
			avquest = true,
			ab = true,
			wsg = true,
			arena = true,
			eots = true,
			port = true,
			wait = true,
			autoshow = true,
			mapscale = 1.3,
			narrow = true,
			hidemapborder = false,
			texture = "BantoBarReverse",
			fontsize = 10,
			width = 200,
			height = 16,
			scale = 1,
			mainup = false,
			reverse = false,
			iconpos = "LEFT",
			colors = {
				alliance = { r=0.0, g=0.0, b=1.0, },
				horde = { r=1.0, g=0.0, b=0.0, },
				info1 = { r=0.6, g=0.6, b=0.6, },
				info2 = { r=1.0, g=1.0, b=0.0, },
				bg = { r=0.3, g=0.3, b=0.3, a=0.5, },
			},
			spacing = 0,
			dbinit = true,
		})
	end
	
	bg = db.colors.bg
	
  	SlashCmdList.CAPPING = ShowOptions
   	SLASH_CAPPING1 = "/capping"
   	CreateUIOptionsFrame("Capping")
	
	-- sharedmedia setup
	media:Register("statusbar", "BantoBarReverse", "Interface\\AddOns\\Capping\\textures\\BantoBarReverse")
	media:Register("statusbar", "Steel", "Interface\\AddOns\\Capping\\textures\\Steel")
	
	-- anchor frame
	f = self
	f:Hide()
	f:SetHeight(16)
	f:SetWidth(200)
	if db.x then
		f:SetPoint(db.p or "TOPLEFT", UIParent, db.rp or "TOPLEFT", db.x, db.y)	
	else
		f:SetPoint("CENTER", UIParent, "CENTER", 200, -100)
	end
	f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, })
	f:SetBackdropColor(0.3, 0.3, 0.3, 0.7)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	f:RegisterForClicks("RightButtonUp")
	f:SetScript("OnDragStart", function(this) this:StartMoving() end)
	f:SetScript("OnDragStop", function(this) 
		this:StopMovingOrSizing()
		local a,b,c,d,e = this:GetPoint()
		db.p, db.rp, db.x, db.y = a, c, floor(d + 0.5), floor(e + 0.5)
	end)
	f:SetScript("OnClick", ShowOptions)
	f:SetFont(GameFontHighlightSmall:GetFont(), 10)
	f:SetText("Capping")

	candy:RegisterGroup("CappingBottom")
	candy:SetGroupPoint("CappingBottom", "TOP", f, "TOP", 0, -13)
	candy:SetGroupVerticalSpacing("CappingBottom", db.spacing)
	candy:RegisterGroup("CappingTop")
	candy:SetGroupPoint("CappingTop", "BOTTOM", f, "BOTTOM", 0, 13)
	candy:SetGroupGrowth("CappingTop", true)
	candy:SetGroupVerticalSpacing("CappingTop", db.spacing)
	
	-- world state info frame positioning
	if db.sbx then
		UpdateWorldInfoPosition()
	end
	
	-- battlefield minimap setup
	if BattlefieldMinimap then
		InitBGMap()
	else
		self:RegisterEvent("ADDON_LOADED")
		function Capping:ADDON_LOADED(a1)
			if a1 == "Blizzard_BattlefieldMinimap" then
				self:UnregisterEvent("ADDON_LOADED")
				InitBGMap()
			end
		end
	end
	
	-- events
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")

end

----------------------------------------
function Capping:PLAYER_ENTERING_WORLD()
----------------------------------------
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:UPDATE_BATTLEFIELD_STATUS()
	self:ZoneCheck()
end

-- zone change
----------------------------------------
function Capping:ZONE_CHANGED_NEW_AREA()
----------------------------------------
	if wasInBG then
		self:ResetAll()
	end
	self:ZoneCheck()
end

-- reset all timers and unregister temp events
do
	local tohide = { }
	local function HideProtectedStuff()
		for _,v in ipairs(tohide) do
			v:Hide()
		end
	end
	-- secure frames that are hidden upon zone change
	--------------------------------------
	function Capping:AddFrameToHide(frame)
	--------------------------------------
		tinsert(tohide, frame)
	end
	---------------------------
	function Capping:ResetAll()
	---------------------------
		wasInBG = false
		self:UnregisterAllTempEvents()
		for value,_ in pairs(activebars) do
			self:StopBar(value)
			activebars[value] = nil
		end
		for value in pairs(allbars) do
			if not candy:IsRegistered(value) then 
				allbars[value] = nil 
			end
		end
		self:CheckCombat(HideProtectedStuff)
	end
end

-- check entry to a battleground zone
----------------------------
function Capping:ZoneCheck()
----------------------------
	if IsInBG() then
		local z = GetRealZoneText()
		wasInBG = true
		if z == wsg and db.wsg then
			self:StartWSG()
		elseif z == eots and db.eots then
			self:StartEotS()
		elseif z == ab and db.ab then
			self:StartAB()
		elseif z == av and db.av then
			self:StartAV()
		end
		if db.autoshow then
			if not bgmap then
				LoadAddOn("Blizzard_BattlefieldMinimap")
			end
			bgmap:Show()
		end
	else
		if IsInArena() then
			wasInBG = true
			self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
		end
		if bgmap and SHOW_BATTLEFIELD_MINIMAP == "0" then 
			bgmap:Hide()
		end
	end
	self:ModMap()
end

-- alter the default minimap
do
	local narrowed, borderhidden
	-------------------------
	function Capping:ModMap(disable)
	-------------------------
		if not bgmap then return end
		
		bgmap:SetScale(db.mapscale)
		
		if not IsInBG() then
			disable = true
		end
		
		
		-- narrow setting
		if db.narrow and not narrowed and not disable then
			BattlefieldMinimap1:Hide()
			BattlefieldMinimap4:Hide()
			BattlefieldMinimap5:Hide()
			BattlefieldMinimap8:Hide()
			BattlefieldMinimap9:Hide()
			BattlefieldMinimap12:Hide()
			BattlefieldMinimapBackground:SetWidth(256 / 2)
			BattlefieldMinimapBackground:SetPoint("TOPLEFT", -12 + 64, 12)
			BattlefieldMinimapCorner:SetPoint("TOPRIGHT", -2 - 52, 3 + 1)
			BattlefieldMinimapCorner:SetWidth(32 * 0.75)
			BattlefieldMinimapCorner:SetHeight(32 * 0.75)
			BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", bgmap, "TOPRIGHT", 2 - 53, 7)
			BattlefieldMinimapCloseButton:SetWidth(32 * 0.75)
			BattlefieldMinimapCloseButton:SetHeight(32 * 0.75)
			narrowed = 1
		elseif disable or (not db.narrow and narrowed) then
			-- setting things back to blizz's default
			BattlefieldMinimap1:Show()
			BattlefieldMinimap4:Show()
			BattlefieldMinimap5:Show()
			BattlefieldMinimap8:Show()
			BattlefieldMinimap9:Show()
			BattlefieldMinimap12:Show()
			BattlefieldMinimapBackground:SetWidth(256)
			BattlefieldMinimapBackground:SetPoint("TOPLEFT", -12, 12)
			BattlefieldMinimapCorner:SetPoint("TOPRIGHT", -2, 3)
			BattlefieldMinimapCorner:SetWidth(32)
			BattlefieldMinimapCorner:SetHeight(32)
			BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", bgmap, "TOPRIGHT", 2, 7)
			BattlefieldMinimapCloseButton:SetWidth(32)
			BattlefieldMinimapCloseButton:SetHeight(32)
			narrowed = nil
		end
		
		-- hide border setting
		if db.hidemapborder and not borderhidden then
			BattlefieldMinimapBackground:Hide()
			BattlefieldMinimapCorner:Hide()
			BattlefieldMinimapCloseButton:SetParent(BattlefieldMinimapTab)
			BattlefieldMinimapCloseButton:SetScale(db.mapscale)
			BattlefieldMinimapCloseButton:HookScript("OnClick", function() bgmap:Hide() end)
			borderhidden = true
		elseif not db.hidemapborder and borderhidden then
			BattlefieldMinimapBackground:Show()
			BattlefieldMinimapCorner:Show()
			BattlefieldMinimapCloseButton:SetParent(bgmap)
			BattlefieldMinimapCloseButton:SetScale(1)
			borderhidden = nil
		end
		bgmap:SetPoint("TOPLEFT", BattlefieldMinimapTab, "BOTTOMLEFT", (narrowed and -64) or 0, (borderhidden and 0) or -5)
	end
end

-- estimated wait timer and the 2 min timer to port to a certain battleground
do
	local currentq = { }
	local q, p = L["Queue: %s"], L["Port: %s"]
	local maxq = MAX_BATTLEFIELD_QUEUES
	local GetBattlefieldStatus = GetBattlefieldStatus
	local GetBattlefieldPortExpiration = GetBattlefieldPortExpiration
	local GetBattlefieldEstimatedWaitTime, GetBattlefieldTimeWaited = GetBattlefieldEstimatedWaitTime, GetBattlefieldTimeWaited
	--------------------------------------------
	function Capping:UPDATE_BATTLEFIELD_STATUS()
	--------------------------------------------
		if not db.port and not db.wait then return end
		
		-- tag each entry to see if it's changed after updating the list
		for map in pairs(currentq) do
			currentq[map] = 0
		end
		
		for i=1,maxq,1 do
			local status, map, _, _, _, teamsize, _ = GetBattlefieldStatus(i)
			if map and teamsize and teamsize > 0 then -- arena
				map = format("%s (%dv%d)", map, teamsize, teamsize)
			end
			if status == "confirm" and db.port then
				local ptext = format(p, map)
				local active, _, _, running = candy:Status(ptext)
				if not active or not running then
					local expireTime = (teamsize > 0 and 60) or 120
					self:StopBar(format(q, map))
					self:StartBar(ptext, expireTime, "Interface\\Icons\\Ability_TownWatch", "info2", true, true)
				end
				currentq[map] = i
				candy:SetTimeLeft(ptext, GetBattlefieldPortExpiration(i)/1000)
			elseif status == "queued" and db.wait then
				local qtext = format(q, map)
				local active, _, _, running = candy:Status(qtext)
				local esttime, waitedtime = GetBattlefieldEstimatedWaitTime(i)/1000, GetBattlefieldTimeWaited(i)/1000
				if not active or not running then
					self:StartBar(qtext, esttime, "Interface\\Icons\\INV_Misc_Note_03", "info1", true, true)
					candy:SetFade(qtext, 120)
				end
				currentq[map] = i
				candy:SetTimeLeft(qtext, max(1, esttime-waitedtime))
			end
		end
		
		-- if an entry "previous" entry was unchanged, then it was probably removed
		for map,flag in pairs(currentq) do
			if flag == 0 then
				self:StopBar(format(p, map))
				self:StopBar(format(q, map))
				currentq[map] = nil
			end
		end
		candy:UpdateGroup("CappingBottom")
		candy:UpdateGroup("CappingTop")
	end
	-- a way to get battlefield id from bar text
	---------------------------------------
	function Capping:GetBattlefieldId(name)
	---------------------------------------
		local tmp = currentq[gsub(name, "^(.+): ", "")]
		if tmp and type(tmp) == "number" then
			return tmp
		end
	end
end


-- gives some user friendliness to the Candy Bars
-- - left-click to toggle anchor
-- - ctrl or alt left-click to send maybe useful info to /bg
-- - shift left-click to send to /s
-- - right-click to bring up config menu
-- - any modifier key and right-click to cancel timer (if queue timer, leave that queue)
local function lOnClick(name, button)
	if button == "LeftButton" then
		if IsModifierKeyDown() then
			if not activebars[name] then return end
			local chan = (IsShiftKeyDown() and "SAY") or "BATTLEGROUND"
			local _,time,elapsed,_ = candy:Status(name)
			SendChatMessage(format(L["%s: %s - %d:%02d remaining"], self:GetFactionFromBarColor(name), name, (time-elapsed) / 60, mod(time-elapsed, 60)), chan)
		else
			ToggleAnchor()
		end
	elseif button == "RightButton" then
		if IsModifierKeyDown() then
			self:StopBar(name)
			local qid = self:GetBattlefieldId(name)
			if qid then
				AcceptBattlefieldPort(qid, nil) -- leave queue
			end
		else
			ShowOptions()
		end
	end
end

-- begin a statusbar timer
-- - name: id of bar and text of bar
-- - duration: full duration of bar
-- - icondata: icon path or table containing icon data
-- - color: database index
-- - nonactive: set true if you want to continue this bar timer after zoning
-- - separate: set true to anchor to the top instead of bottom
-- - specialText: bar text if different from name
--------------------------------------------------------------------------------------------
function Capping:StartBar(name, duration, icondata, color, nonactive, separate, specialText)
--------------------------------------------------------------------------------------------
	local icon,l,r,t,b
	if type(icondata) == "table" then
		icon, l, r, t, b = icondata.path, icondata.l, icondata.r, icondata.t, icondata.b
	else
		icon, l, r, t, b = icondata, 0.07, 0.93, 0.07, 0.93
	end
	
	local c = db.colors[color or "info1"] or db.colors.info1
	candy:Register(name, duration, specialText or name, icon, c.r, c.g, c.b)
	candy:SetTexture(name, media:Fetch("statusbar", db.texture))
	candy:SetWidth(name, db.width)
	candy:SetHeight(name, db.height)
	candy:SetFontSize(name, db.fontsize)
	candy:SetScale(name, db.scale)
	candy:SetFade(name, 1.5)
	candy:SetBackgroundColor(name, bg.r, bg.g, bg.b, bg.a or 0.5)
	candy:SetReversed(name, db.reverse) 
	candy:SetOnClick(name, lOnClick)
	
	if db.mainup then 
		separate = not separate 
	end
	candy:RegisterWithGroup(name, (separate and "CappingTop") or "CappingBottom")

	candy:Start(name, true)
	-- seems like texcoords doesn't take effect until after the bar starts
	if db.iconpos == L["HIDE"] then
		candy:SetIcon(name)
	else
		candy:SetIconPosition(name, (db.iconpos == L["RIGHT"] and "RIGHT") or "LEFT")
		candy:SetIcon(name, icon, l, r, t, b)
	end
	if not nonactive then 
		activebars[name] = color
	end
	allbars[name] = color

end

-- simply cancels a timer
------------------------------
function Capping:StopBar(name)
------------------------------
	candy:Stop(name)
	candy:Unregister(name)
end

---------------------------------------------
function Capping:GetFactionFromBarColor(name)
---------------------------------------------
	local color = strlower(activebars[name] or "")
	return (color == "horde" and L["Horde"]) or (color == "alliance" and L["Alliance"]) or ""
end

-- status icons for battleground objectives
do
	local it = { path = "Interface\\Minimap\\POIIcons", }
	-- textures used on worldmap { row, col, }
	local icons = {
		alliance = {
			symbol = { 0.75, 0.875, 0.625, 0.75, },
			flag = { 0.375, 0.5, 0.625, 0.75, },
			graveyard = { 0.375, 0.5, 0, 0.125, },
			tower = { 0.125, 0, 0.125, 0.25, },
			farm = { 0, 0.125, 0.5, 0.625, },
			blacksmith = { 0.375, 0.5, 0.375, 0.5, },
			mine = { 0.125, 0.25,0.25, 0.375, },
			stables = { 0.625, 0.75, 0.5, 0.625, },
			lumbermill = { 0.75, 0.875, 0.25, 0.375, },
		},
		horde = {
			symbol = { 0, 0.125, 0.75, 0.875, },
			flag = { 0.5, 0.625, 0.625, 0.75, },
			graveyard = { 0.625, 0.75, 0.125, 0.25, },
			tower = { 0.5, 0.375, 0.125, 0.25, },
			farm = { 0.25, 0.375, 0.5, 0.625, },
			blacksmith = { 0.625, 0.75, 0.375, 0.5, },
			mine = { 0.375, 0.5, 0.25, 0.375, },
			stables = { 0.875, 1, 0.5, 0.625, },
			lumbermill = { 0, 0.125, 0.375, 0.5, },
		},
	}
	-------------------------------------------
	function Capping:GetIconData(faction, name)
	-------------------------------------------
		local t = icons[faction or "alliance"][name] or icons.alliance.symbol
		it.l, it.r, it.t, it.b = t[1], t[2], t[3], t[4]
		return it
	end
end

--------------------------------
function Capping:GetActiveBars()
--------------------------------
	return activebars
end




---- Below are some common functions used by more than 1 battleground ----

-- timer for when a battleground begins
do
	local bgbegin = L["Battleground Begins"]
	local timetil = {
		[strlower(L["1 minute"])] = 63,
		[strlower(L["One minute until"])] = 63,
		[strlower(L["30 seconds"])] = 32,
		[strlower(L["Thirty seconds until"])] = 32,
		[strlower(L["Fifteen seconds until"])] = 15.5,
	}
	------------------------------------
	function Capping:CheckStartTimer(a1)
	------------------------------------
		local a1 = strlower(a1)
		for text,time in pairs(timetil) do
			if strfind(a1, text) then
				if not candy:IsRegistered(bgbegin) then
					self:StartBar(bgbegin, 63, "Interface\\Icons\\Spell_Holy_PrayerOfHealing", "info1")
				end
				if time ~= 63 then 
					candy:SetTimeLeft(bgbegin, time) 
				end
				break
			end
		end
	end
end

-- scoreboard handlers
do
	local GetBattlefieldScore, GetNumBattlefieldScores = GetBattlefieldScore, GetNumBattlefieldScores
	-- retrieves a player's class by name, returned in english and caps (ie. WARRIOR) 
	-- note: faction is either 0 or 1 (Horde or Alliance, respectively)
	----------------------------------------------
	function Capping:GetClassByName(name, faction)
	----------------------------------------------
		for i = 1, GetNumBattlefieldScores(), 1 do
			local iname,_,_,_,_,ifaction,_,_,_,iclass,_,_ = GetBattlefieldScore(i)
			if ifaction == faction and gsub(iname, "-(.+)", "") == name then
				return iclass
			end
		end
	end
end

-- retrieves hex color by class (class must be english and in caps)
do
	local rcc = RAID_CLASS_COLORS
	local classcolor = {
		HUNTER = format("%02x%02x%02x", rcc.HUNTER.r*255, rcc.HUNTER.g*255, rcc.HUNTER.b*255),
		WARLOCK = format("%02x%02x%02x", rcc.WARLOCK.r*255, rcc.WARLOCK.g*255, rcc.WARLOCK.b*255),
		PRIEST = format("%02x%02x%02x", rcc.PRIEST.r*255, rcc.PRIEST.g*255, rcc.PRIEST.b*255),
		PALADIN = format("%02x%02x%02x", rcc.PALADIN.r*255, rcc.PALADIN.g*255, rcc.PALADIN.b*255),
		MAGE = format("%02x%02x%02x", rcc.MAGE.r*255, rcc.MAGE.g*255, rcc.MAGE.b*255),
		ROGUE = format("%02x%02x%02x", rcc.ROGUE.r*255, rcc.ROGUE.g*255, rcc.ROGUE.b*255),
		DRUID = format("%02x%02x%02x", rcc.DRUID.r*255, rcc.DRUID.g*255, rcc.DRUID.b*255),
		SHAMAN = format("%02x%02x%02x", rcc.SHAMAN.r*255, rcc.SHAMAN.g*255, rcc.SHAMAN.b*255),
		WARRIOR = format("%02x%02x%02x", rcc.WARRIOR.r*255, rcc.WARRIOR.g*255, rcc.WARRIOR.b*255),	
	}
	--------------------------------------
	function Capping:GetClassColorHex(cls)
	--------------------------------------
		return classcolor[cls or "PRIEST"] or classcolor["PRIEST"]
	end
end


-- initialize or update a final score estimation bar (AB and EotS uses this)
do
	local ptspersec = {
		[1] = { [0]=0.0, [1]=0.8333, [2]=1.1111, [3]=1.6667, [4]=3.3333, [5]=30.0, }, -- ab
		[2] = { [0]=0.0, [1]=0.5, [2]=1.0, [3]=2.5, [4]=5, }, -- eots
	}
	local ascore, atime, abases, hscore, htime, hbases = 0, 0, 0, 0, 0, 0
	local updatebar, updatetime, currentbg, slowit
	
	-- parse battleground info
	local getstatedata
	do
		local GetWorldStateUIInfo = GetWorldStateUIInfo
		local tonumber = tonumber
		local sbpattern = {
			[1] = L["Bases: (%d+)  Resources: (%d+)/2000"],  -- ab
			[2] = L["Bases: (%d+)  Victory Points: (%d+)/2000"],  -- eots
		}
		function getstatedata()
			local base1, score1 = strmatch(select(3, GetWorldStateUIInfo(currentbg)) or "", sbpattern[currentbg])
			local base2, score2 = strmatch(select(3, GetWorldStateUIInfo(currentbg + 1)) or "", sbpattern[currentbg])
			return tonumber(base1), tonumber(score1), tonumber(base2), tonumber(score2)
		end
	end
	-- takes care of candybar related stuff
	local barhandle
	do
		local f1, f2 = L["wins 2000-%d"], L["Final: 2000 - %d"]
		local finaltext = "asdfblah"
		local function start(winner, lscore, wtime, prev)
			finaltext = format(f1, lscore)
			self:StartBar(finaltext, wtime + prev, self:GetIconData(winner, "symbol"), winner, nil, nil, format(f2, lscore))
		end
		-- update the estimated final score bar
		function barhandle(winner, wtime, lscore)
			local active, totalTime, elapsed, running = candy:Status(finaltext)
			if active and running then
				if updatebar then
					self:StopBar(finaltext)
					start(winner, lscore, wtime, elapsed)
				end
				candy:SetTimeLeft(finaltext, wtime)
			else
				start(winner, lscore, wtime, 0)
			end
		end
	end
	-- estimate loser's final score
	local function getlscore(time, pps, currentscore)
		local lscore = time * pps + currentscore
		if currentbg == 1 then
			return min(1990, 10 * floor((lscore + 5)/10))
		else
			return min(1999, floor(lscore + 0.5))
		end
	end
	-- resets estimator and sets new battleground
	---------------------------------
	function Capping:NewEstimator(bg)
	---------------------------------
		currentbg = bg
		slowit = true
		ascore, atime, abases, hscore, htime, hbases = 0, 0, 0, 0, 0, 0
		updatetime, updatebar = nil, nil
	end
	-- tells estimator to allow refresh (usually when number of bases changed)
	------------------------------------------
	function Capping:AllowEstimatedBarUpdate()
	------------------------------------------
		updatebar, updatetime = true, true
	end
	-- base chunk
	--------------------------------------
	function Capping:UPDATE_WORLD_STATES()
	--------------------------------------
		slowit = not slowit
		if slowit then return end
		
		local currenttime = GetTime()
		local ABases, AScore, HBases, HScore = getstatedata()
		if ABases and HBases then
			if abases ~= ABases or hbases ~= HBases then
				abases, hbases, updatebar = ABases, HBases, true
			end
			if ascore ~= AScore then
				ascore, atime, updatetime = AScore, currenttime, true
			end
			if hscore ~= HScore then
				hscore, htime, updatetime = HScore, currenttime, true
			end
		end
		
		if not updatetime then return end
		updatetime = nil

		local apps, hpps = ptspersec[currentbg][abases], ptspersec[currentbg][hbases]
		-- timeTil2000 = ((remainingScore) / scorePerSec) - (timeSinceLastUpdate)
		local ATime, HTime = ((2000 - ascore) / apps) - (currenttime - atime), ((2000 - hscore) / hpps) - (currenttime - htime)
		if HTime < ATime then  -- Horde is winning
			barhandle("horde", HTime, getlscore(HTime, apps, ascore))
		else  -- Alliance is winning
			barhandle("alliance", ATime, getlscore(ATime, hpps, hscore))
		end
		updatebar = nil
	end
end





---- OPTIONS ----

-- updates active bars with new options if needed
-----------------------------------
function Capping:UpdateActiveBars()
-----------------------------------
	local texture = media:Fetch("statusbar", db.texture)
	for value in pairs(allbars) do
		if candy:IsRegistered(value) then
			candy:SetTexture(value, texture)
			candy:SetWidth(value, db.width)
			candy:SetHeight(value, db.height)
			candy:SetFontSize(value, db.fontsize)
			candy:SetScale(value, db.scale)
			candy:SetReversed(value, db.reverse)
			if db.iconpos == L["HIDE"] then
				candy:SetIcon(value, nil)
			else
				candy:SetIconPosition(value, (db.iconpos == L["RIGHT"] and "RIGHT") or "LEFT")
			end
		else
			allbars[value] = nil
		end
	end
	candy:UpdateGroup("CappingBottom")
	candy:UpdateGroup("CappingTop")
	candy:SetGroupVerticalSpacing("CappingBottom", db.spacing)
	candy:SetGroupVerticalSpacing("CappingTop", db.spacing)
end


-- options table and functions
do
	local ena, copt = L["Enable"], L["Colors"]
	local function set(k, v, v2, v3, a)
		if db.colors[k] then
			local c = db.colors[k]
			c.r, c.g, c.b, c.a = v, v2, v3, a
			if k == "bg" then
				-- update active bars with updated background colors
				for value in pairs(allbars) do
					if candy:IsRegistered(value) then
						candy:SetBackgroundColor(value, c.r, c.g, c.b, c.a or 0.5)
					end
				end
			else
				-- update active bars with updated bar colors
				for value,color in pairs(allbars) do
					if color == k and candy:IsRegistered(value) then
						candy:SetColor(value, c.r, c.g, c.b)
					end
				end
			end
		else
			db[k] = v
			if abbrv[k] then
				-- enable/disable a battleground while in it
				if GetRealZoneText() == abbrv[k] then
					if not v then 
						self:ResetAll()
					else 
						self:ZoneCheck() 
					end
				end
			else
				self:UpdateActiveBars()
				self:ModMap()
			end
		end
	end
	local function get(k)
		if db.colors[k] then
			return db.colors[k].r, db.colors[k].g, db.colors[k].b, db.colors[k].a
		else
			return db[k]
		end
	end
	local function exec(k)
		if k == "test" then
			local testicon = "Interface\\Icons\\Ability_ThunderBolt"
			self:StartBar(L["Test"].." - "..L["Other"].."1", 60, testicon, "info1", true, true)
			self:StartBar(L["Test"].." - "..L["Other"].."2", 45, testicon, "info2", true, true)
			self:StartBar(L["Test"].." - "..L["Alliance"], 30, testicon, "alliance", true)
			self:StartBar(L["Test"].." - "..L["Horde"], 45, testicon, "horde", true)
			self:StartBar(L["Test"], 60, testicon, "info1", true)
		elseif k == "movesb" then
			db.sbx, db.sby = Capping:GetLeft() + 50, Capping:GetTop() - GetScreenHeight()
			UpdateWorldInfoPosition()
		elseif k == "anchor" then
			ToggleAnchor()
		elseif k == "syncav" then
			self:SyncAV()
		end
	end
	
	local opts = {
		type = "group",
		args = {
			header = { type="header", name="|cff5555ffCapping|r", order=1, },
			av = {
				type="group", name=av, desc=av,
				pass=true, set=set, get=get,
				order=2,
				args = {
					av = { type="toggle", name=ena, desc=ena, order=1, },
					avquest = { type="toggle", name=L["Auto quest turnins"], desc=L["Enable Alterac Valley automatic quest turnins"], order=2, },
					sync = {
						type="execute", name=L["Request sync"], desc=L["Request sync"],
						func=exec, passValue="syncav", 
						disabled = function() return GetRealZoneText() ~= av end,
						order=3,
					},
				},
			},
			ab = {
				type="group", name=ab, desc=ab,
				pass=true, set=set, get=get,
				order=3,
				args = { ab = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			eots = {
				type="group", name=eots, desc=eots,
				pass=true, set=set, get=get,
				order=4,
				args = { eots = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			wsg = {
				type="group", name=wsg, desc=wsg,
				pass=true, set=set, get=get,
				order=5,
				args = { wsg = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			bars = {
				type="group", name=L["Bar"], desc=L["Statusbar options"],
				pass=true, set=set, get=get, func=exec,
				order=6,
				args = {
					texture = { type="text", name=L["Texture"], desc=L["Statusbar textures"], validate=media:List("statusbar"), order=1, },
					scale = { type="range", name=L["Scale"], desc=L["Change statusbar scale"], min=0.5, max=2, step=0.1, order=2, },
					width = { type="range", name=L["Width"], desc=L["Change statusbar width"], min=50, max=300, step=10, order=3, },
					height = { type="range", name=L["Height"], desc=L["Change statusbar thickness"], min=10, max=40, step=2, order=4, },
					spacing = { type="range", name=L["Spacing"], desc=L["Spacing"], min=-2, max=20, step=0.5, order=5, },
					fontsize = { type="range", name=L["Font size"], desc=L["Change statusbar font size"], min=6, max=24, step=0.2, order=7, },
					iconpos = { type="text", name=L["Icons"], desc=L["Bar icons display options"], validate = { L["LEFT"], L["RIGHT"], L["HIDE"], }, order=8, },
					reverse = { type="toggle", name=L["Reverse fill"], desc=L["Set statusbars to fill up instead of depleting"], order=9, },
					mainup = { type="toggle", name=L["Flip growth"], desc=L["Set objective timers to grow up and misc timers to grow down"], order=10, },
					colors = {
						type="group", name=L["Colors"], desc=copt,
						pass=true, set=set, get=get,
						order=11,
						args = {
							alliance = { type="color", name=L["Alliance"], desc=copt, order=1, },
							horde = { type="color", name=L["Horde"], desc=copt, order=2, },
							info1 = { type="color", name=L["Other"].."1", desc=copt, order=3, },
							info2 = { type="color", name=L["Other"].."2", desc=copt, order=4, },
							bg = { type="color", name=L["Texture"], desc=copt, hasAlpha = true, order=5, },
						},
					},
					test = { type="execute", name=L["Test"], desc=L["Start a test bar"], order=12, },
				},
			},
			bgmap = {
				type="group", name=L["Battlefield Minimap"], desc=L["Options for the battlefield minimap"],
				pass=true, set=set, get=get,
				order=7,
				args = {
					autoshow = { type="toggle", name=L["Auto show map"], desc=L["Auto show the battlefield minimap on entry"], order=1, },
					narrow = { type="toggle", name=L["Narrow map mode"], desc=L["Narrow the battlefield minimap, removing some empty space"], order=2, },
					hidemapborder = { type="toggle", name=L["Hide border"], desc=L["Hide border"], order=3, },
					mapscale = { type="range", name=L["Map scale"], desc=L["Change the default scale of the battlefield minimap"], min=0.3, max=3.0, step=0.05, order=4, },
				},
			},
			other = {
				type="group", name=L["Other"], desc=L["Other options"],
				pass=true, set=set, get=get, func=exec,
				order=8,
				args = {
					port = { type="toggle", name=L["Port Timer"], desc=L["Enable timers for port expiration"], order=1, },
					wait = { type="toggle", name=L["Wait Timer"], desc=L["Enable timers for queue wait time"], order=2, },
					movesb = { type="execute", name=L["Reposition Scoreboard"], desc=L["Move the scoreboard to the Capping anchor's CURRENT position"], order=4, },
				},
			},
			anchor = {
				type="execute", name=L["Show/Hide Anchor"], desc=L["Show/Hide the bars anchor (can also left-click a statusbar)"],
				func=exec, passValue="anchor",
				order=9,
			},
		},
	}
	
	function ShowOptions()
		dew:Open(f, 'children', function() dew:FeedAceOptionsTable(opts) end, 'cursorX', true, 'cursorY', true)
	end
	
	-- adds Capping to battlefield minimap dropdown menu
	local entry = { text = "Capping", func = ShowOptions, }
	function adddrop()
		hooksecurefunc("BattlefieldMinimapDropDown_Initialize", function() UIDropDownMenu_AddButton(entry, 1) end)
	end
end
