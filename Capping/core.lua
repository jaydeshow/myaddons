-- HEADER
local Capping = CreateFrame("Button", "Capping", UIParent)
local self = Capping
local L = CappingLocale

-- LIBRARIES
local media = LibStub("LibSharedMedia-3.0")
local dew = AceLibrary("Dewdrop-2.0")

-- GLOBALS MADE LOCAL
local _G = getfenv(0)
local format, strfind, strlower, select, type = format, strfind, strlower, select, type
local min, max, floor, math_sin, math_pi = min, max, floor, math.sin, math.pi
local GetTime = GetTime

-- LOCAL VARS
local db, f, wasInBG, bgmap
local activebars, bars, currentq, bgdd = { }, { }, { }, { }
local av, ab, eots, wsg = L["Alterac Valley"], L["Arathi Basin"], L["Eye of the Storm"], L["Warsong Gulch"]
local abbrv = { av = av, ab = ab, eots = eots, wsg = wsg, }
local backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, }
local narrowed, borderhidden, cbhook

-- LOCAL FUNCS
local ShowOptions, oldSetPoint
local function IsInBG()
	return select(2, IsInInstance()) == "pvp"
end
local function ToggleAnchor()
	if f:IsShown() then
		f:Hide()
	else 
		f:Show() 
	end
end
local function InitBGMap()
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	bgmap = BattlefieldMinimap
	self:ModMap()
	bgdd.text, bgdd.func = "Capping", ShowOptions
	hooksecurefunc("BattlefieldMinimapDropDown_Initialize", function() UIDropDownMenu_AddButton(bgdd, 1) end)
end
local function SetPoints(this, lp, lrt, lrp, lx, ly, rp, rrt, rrp, rx, ry)
	this:ClearAllPoints()
	this:SetPoint(lp, lrt, lrp, lx, ly)
	if rp then this:SetPoint(rp, rrt, rrp, rx, ry) end
end
local function SetWH(this, w, h)
	this:SetWidth(w)
	this:SetHeight(h)
end
local function NewText(parent, font, fontsize, justifyH, justifyV, overlay)
	local t = parent:CreateFontString(nil, overlay or "OVERLAY")
	if fontsize then
		t:SetFont(font, fontsize)
	else
		t:SetFontObject(font)
	end
	t:SetJustifyH(justifyH) 
	t:SetJustifyV(justifyV)
	return t
end
local function StartMoving(this) this:StartMoving() end
local function CreateMover(oldframe, w, h, dragstopfunc)
	local mover = oldframe or CreateFrame("Button", nil, UIParent)
	SetWH(mover, w, h)
	mover:SetBackdrop(backdrop)
	mover:SetBackdropColor(0, 0, 0, 0.7)
	mover:SetMovable(true)
	mover:RegisterForDrag("LeftButton")
	mover:SetScript("OnDragStart", StartMoving)
	mover:SetScript("OnDragStop", dragstopfunc)
	mover:SetClampedToScreen(true)
	mover:SetFrameStrata("HIGH")
	mover.close = CreateFrame("Button", nil, mover, "UIPanelCloseButton")
	SetWH(mover.close, 22, 22)
	mover.close:SetPoint("TOPRIGHT", 4, 4)
	return mover
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
local function UpdateCaptureBarPosition()
	if not cbhook then
		hooksecurefunc("UIParent_ManageFramePositions", UpdateCaptureBarPosition)
		cbhook = true
	end
	local nexty = 0
	for i=1, NUM_EXTENDED_UI_FRAMES do
		local cb = _G["WorldStateCaptureBar"..i]
		if cb and cb:IsShown() then
			cb:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", db.cbx, db.cby - nexty)
			nexty = nexty + cb:GetHeight()
		end
	end
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
	
	-- saved variables database setup
	CappingDB = CappingDB or {}
	db = (CappingDB.profiles and CappingDB.profiles.Default) or CappingDB
	self.db = db
	if db.dbinit ~= 2 then 
		db.dbinit = nil
		local function SetDefaults(db, t)
			for k,v in pairs(t) do
				if type(db[k]) == "table" then
					SetDefaults(db[k], v)
				else
					db[k] = (db[k] ~= nil and db[k]) or v
				end
			end
		end
		SetDefaults(db, {
			av = true, avquest = true, ab = true, wsg = true, arena = true, eots = true,
			port = true, wait = true,
			autoshow = true, mapscale = 1.3, narrow = true, hidemapborder = false,
			texture = "BantoBarReverse",
			width = 200, height = 15, inset = 1,
			mainup = false, reverse = false, fill = false,
			iconpos = L["LEFT"], timepos = L["LEFT"],
			font = "Friz Quadrata TT", fontsize = 11,
			colors = {
				alliance = { r=0.0, g=0.0, b=1.0, a=1.0, },
				horde = { r=1.0, g=0.0, b=0.0, a=1.0, },
				info1 = { r=0.6, g=0.6, b=0.6, a=1.0, },
				info2 = { r=1.0, g=1.0, b=0.0, a=1.0, },
				bg = { r=0.3, g=0.3, b=0.3, a=0.5, },
			},
			dbinit = 2,
		})
	end
	
  	SlashCmdList.CAPPING = ShowOptions
   	SLASH_CAPPING1 = "/capping"

   	-- adds Capping config to default UI Interface Options
	local panel = CreateFrame("Frame")
	panel.name = "Capping"
	panel:SetScript("OnShow", function(this)
		dew:Close()
		if not t1 then
			t1 = NewText(this, GameFontNormalLarge, nil, "LEFT", "TOP", "ARTWORK")
			t1:SetPoint("TOPLEFT", 16, -16)
			t1:SetText(this.name)
			
			local t2 = NewText(this, GameFontHighlightSmall, nil, "LEFT", "TOP", "ARTWORK")
			t2:SetHeight(43)
			SetPoints(t2, "TOPLEFT", t1, "BOTTOMLEFT", 0, -8, "RIGHT", this, "RIGHT", -32, 0)
			t2:SetNonSpaceWrap(true)
			local function GetInfo(field)
				return GetAddOnMetadata("Capping", field) or "N/A"
			end
			t2:SetFormattedText("Notes: %s\nAuthor: %s\nVersion: %s", GetInfo("Notes"), GetInfo("Author"), GetInfo("Version"))
		
			local b = CreateFrame("Button", nil, this, "UIPanelButtonTemplate")
			SetWH(b, 120, 20)
			b:SetText("Options Menu")
			b:SetScript("OnClick", ShowOptions)
			b:SetPoint("TOPLEFT", t2, "BOTTOMLEFT", -2, -8)
		end
	end)
	InterfaceOptions_AddCategory(panel)
	
	-- sharedmedia setup
	media:Register("statusbar", "BantoBarReverse", "Interface\\AddOns\\Capping\\textures\\BantoBarReverse")
	media:Register("statusbar", "Steel", "Interface\\AddOns\\Capping\\textures\\Steel")
	
	-- anchor frame
	f = self
	f:Hide()
	if db.x then
		f:SetPoint(db.p or "TOPLEFT", UIParent, db.rp or "TOPLEFT", db.x, db.y)	
	else
		f:SetPoint("CENTER", UIParent, "CENTER", 200, -100)
	end
	CreateMover(f, db.width, 14, function(this) 
		this:StopMovingOrSizing()
		local a,b,c,d,e = this:GetPoint()
		db.p, db.rp, db.x, db.y = a, c, floor(d + 0.5), floor(e + 0.5)
	end)
	f:RegisterForClicks("RightButtonUp")
	f:SetScript("OnClick", ShowOptions)
	f:SetTextFontObject(GameFontHighlightSmall)
	f:SetText("Capping")

	if db.sbx then UpdateWorldInfoPosition() end  -- world state info frame positioning
	if db.cbx then UpdateCaptureBarPosition() end  -- capturebar position
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	
	if BattlefieldMinimap then  -- battlefield minimap setup
		InitBGMap()
	else
		self:RegisterEvent("ADDON_LOADED")
		function Capping:ADDON_LOADED(a1)
			if a1 == "Blizzard_BattlefieldMinimap" then
				InitBGMap()
			end
		end
	end
end

----------------------------------------
function Capping:PLAYER_ENTERING_WORLD()
----------------------------------------
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:UPDATE_BATTLEFIELD_STATUS()
	self:ZoneCheck()
end

----------------------------------------
function Capping:ZONE_CHANGED_NEW_AREA()
----------------------------------------
	if wasInBG then
		self:ResetAll()
	end
	self:ZoneCheck()
end


local tohide = { }
local function HideProtectedStuff()
	for _,v in ipairs(tohide) do
		v:Hide()
	end
end
--------------------------------------
function Capping:AddFrameToHide(frame)  -- secure frames that are hidden upon zone change
--------------------------------------
	tinsert(tohide, frame)
end
---------------------------
function Capping:ResetAll()  -- reset all timers and unregister temp events
---------------------------
	wasInBG = false
	for event in pairs(elist) do  -- unregister all temp events
		elist[event] = nil
		self:UnregisterEvent(event)
	end
	for value,_ in pairs(activebars) do  -- close all temp timerbars
		self:StopBar(value)
		activebars[value] = nil
	end
	self:CheckCombat(HideProtectedStuff)  -- hide secure frames
end

----------------------------
function Capping:ZoneCheck()  -- check if new zone is a battleground
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
		if select(2, IsInInstance()) == "arena" then
			wasInBG = true
			self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
		end
		if bgmap and SHOW_BATTLEFIELD_MINIMAP == "0" then 
			bgmap:Hide()
		end
	end
	self:ModMap()
end

--------------------------------
function Capping:ModMap(disable)  -- alter the default minimap
--------------------------------
	if not bgmap then return end
	bgmap:SetScale(db.mapscale)
	disable = not IsInBG() or disable
	
	if db.narrow and not narrowed and not disable then  -- narrow setting
		BattlefieldMinimap1:Hide()
		BattlefieldMinimap4:Hide()
		BattlefieldMinimap5:Hide()
		BattlefieldMinimap8:Hide()
		BattlefieldMinimap9:Hide()
		BattlefieldMinimap12:Hide()
		BattlefieldMinimapBackground:SetWidth(256 / 2)
		BattlefieldMinimapBackground:SetPoint("TOPLEFT", -12 + 64, 12)
		BattlefieldMinimapCorner:SetPoint("TOPRIGHT", -2 - 52, 3 + 1)
		SetWH(BattlefieldMinimapCorner, 24, 24)
		BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", bgmap, "TOPRIGHT", 2 - 53, 7)
		SetWH(BattlefieldMinimapCloseButton, 24, 24)
		narrowed = 1
	elseif disable or (not db.narrow and narrowed) then  -- setting things back to blizz's default
		BattlefieldMinimap1:Show()
		BattlefieldMinimap4:Show()
		BattlefieldMinimap5:Show()
		BattlefieldMinimap8:Show()
		BattlefieldMinimap9:Show()
		BattlefieldMinimap12:Show()
		BattlefieldMinimapBackground:SetWidth(256)
		BattlefieldMinimapBackground:SetPoint("TOPLEFT", -12, 12)
		BattlefieldMinimapCorner:SetPoint("TOPRIGHT", -2, 3)
		SetWH(BattlefieldMinimapCorner, 32, 32)
		BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", bgmap, "TOPRIGHT", 2, 7)
		SetWH(BattlefieldMinimapCloseButton, 32, 32)
		narrowed = nil
	end

	if db.hidemapborder and not borderhidden then  -- Hide border
		BattlefieldMinimapBackground:Hide()
		BattlefieldMinimapCorner:Hide()
		BattlefieldMinimapCloseButton:SetParent(BattlefieldMinimapTab)
		BattlefieldMinimapCloseButton:SetScale(db.mapscale)
		BattlefieldMinimapCloseButton:HookScript("OnClick", function() bgmap:Hide() end)
		borderhidden = true
	elseif not db.hidemapborder and borderhidden then  -- Show border
		BattlefieldMinimapBackground:Show()
		BattlefieldMinimapCorner:Show()
		BattlefieldMinimapCloseButton:SetParent(bgmap)
		BattlefieldMinimapCloseButton:SetScale(1)
		borderhidden = nil
	end
	bgmap:SetPoint("TOPLEFT", BattlefieldMinimapTab, "BOTTOMLEFT", (narrowed and -64) or 0, (borderhidden and 0) or -5)
end

do  -- estimated wait timer and the 2 min timer to port to a certain battleground
	local q, p = L["Queue: %s"], L["Port: %s"]
	local maxq = MAX_BATTLEFIELD_QUEUES
	local GetBattlefieldStatus = GetBattlefieldStatus
	local GetBattlefieldPortExpiration = GetBattlefieldPortExpiration
	local GetBattlefieldEstimatedWaitTime, GetBattlefieldTimeWaited = GetBattlefieldEstimatedWaitTime, GetBattlefieldTimeWaited
	--------------------------------------------
	function Capping:UPDATE_BATTLEFIELD_STATUS()
	--------------------------------------------
		if not db.port and not db.wait then return end
		
		for map in pairs(currentq) do  -- tag each entry to see if it's changed after updating the list
			currentq[map] = 0
		end
		for i=1,maxq,1 do  -- check the status of each queue
			local status, map, _, _, _, teamsize, _ = GetBattlefieldStatus(i)
			if map and teamsize and teamsize > 0 then -- arena
				map = format("%s (%dv%d)", map, teamsize, teamsize)
			end
			if status == "confirm" and db.port then
				self:StopBar(format(q, map))
				self:StartBar(format(p, map), (teamsize > 0 and 60) or 120, GetBattlefieldPortExpiration(i)/1000, "Interface\\Icons\\Ability_TownWatch", "info2", true, true)
				currentq[map] = i
			elseif status == "queued" and db.wait then
				local esttime, waitedtime = GetBattlefieldEstimatedWaitTime(i)/1000, GetBattlefieldTimeWaited(i)/1000
				self:StartBar(format(q, map), esttime, max(1, esttime-waitedtime), "Interface\\Icons\\INV_Misc_Note_03", "info1", 2, true)
				currentq[map] = i
			end
		end
		for map,flag in pairs(currentq) do  -- stop inactive bars
			if flag == 0 then
				self:StopBar(format(p, map))
				self:StopBar(format(q, map))
				currentq[map] = nil
			end
		end
	end
end


local temp = { }
local function CheckActive(barid)
	dew:Close()
	local f = bars[barid]
	if f and f:IsShown() then return f end
end
local function DoReport(this, chan)  -- format chat reports
	if not activebars[this.name] then return end
	local faction = (this.color == "horde" and L["Horde"]) or (this.color == "alliance" and L["Alliance"]) or ""
	SendChatMessage(format(L["%s: %s - %d:%02d remaining"], faction, this.displaytext:GetText(), this.remaining / 60, mod(this.remaining, 60)), chan)
end
local function CheckQueue(name, join)
	local qid = currentq[gsub(name, "^(.+): ", "")]
	if qid and type(qid) == "number" then
		AcceptBattlefieldPort(qid, join) -- leave queue
		return true
	end
end
local function ReportBG(barid)  -- report timer to /bg
	local this = CheckActive(barid)
	if not this then return end
	if not CheckQueue(this.name, true) then
		DoReport(this, "BATTLEGROUND")
	end
end
local function ReportSAY(barid)  -- report timer to /s
	local this = CheckActive(barid)
	if not this then return end
	DoReport(this, "SAY")
end
local function CancelBar(barid)  -- close bar, leave queue if a queue timer
	local this = CheckActive(barid)
	if not this then return end
	if not CheckQueue(this.name, nil) then
		self:StopBar(nil, this)
	end
end
local function BarOnClick(this, button)
	if button == "LeftButton" then
		if IsShiftKeyDown() then
			ReportSAY(this.id)
		elseif IsControlKeyDown() then
			ReportBG(this.id)
		else
			ToggleAnchor()
		end
	elseif button == "RightButton" then
		if IsControlKeyDown() then
			CancelBar(this.id)
		else
			ShowOptions(nil, this.id)
		end
	end
end
local function BarOnUpdate(this, a1)
	this.elapsed = this.elapsed + a1
	if this.elapsed < this.throt then return end
	this.elapsed = 0

	local remain = this.endtime - GetTime()
	this.remaining = remain
	local duration = this.duration
	local frac = ( (db.fill and min(duration, duration - remain)) or max(0.0001, remain) ) / duration
	this.bar:SetWidth( (this.barback:GetWidth() - (2 * db.inset)) * frac )

	if db.reverse then
		this.bar:SetTexCoord(frac, 0, 0, 1)
	else
		this.bar:SetTexCoord(0, frac, 0, 1)
	end
	if remain < 60 then
		if remain < 10 then  -- fade effects
			if remain > 0.5 then
				this:SetAlpha(0.75 + 0.25 * math_sin(remain * math_pi))
			elseif remain > -1.5 then
				this:SetAlpha((remain + 1.5) / 2)
			elseif this.noclose then
				this:SetAlpha(0.7)
				this.throt = 100
				return
			else
				self:StopBar(nil, this)
				return
			end
			this.throt = 0.05
		end
		this.timetext:SetFormattedText("%d", max(0, remain))
	elseif remain < 600 then
		this.timetext:SetFormattedText("%d:%02d", remain/60, mod(remain,60))
	elseif remain < 3600 then
		this.timetext:SetFormattedText("%dm", remain/60)
	else
		this.timetext:SetFormattedText("%0.1fh", remain/3600)
	end
end
local function lsort(a, b)
	return bars[a].remaining < bars[b].remaining
end
local function SortBars()
	for i = 1, getn(bars), 1 do
		temp[i] = i
	end
	sort(temp, lsort)
	local pdown, pup = -1, -1
	for _, k in ipairs(temp) do
		local f = bars[k]
		if f:IsShown() then
			if f.down then
				SetPoints(f, "TOPLEFT", bars[pdown] or Capping, "BOTTOMLEFT", 0, -1)
				pdown = k
			else
				SetPoints(f, "BOTTOMLEFT", bars[pup] or Capping, "TOPLEFT", 0, 1)
				pup = k
			end
		end
	end
end
local function UpdateBarLayout(f)
	local inset, w, h = db.inset, db.width, db.height
	local icon, bar, barback, spark, timetext, displaytext = f.icon, f.bar, f.barback, f.spark, f.timetext, f.displaytext
	SetWH(f, w, h)
	SetWH(icon, h, h)
	SetWH(barback, w - h, h)
	bar:SetHeight(h - 2*inset)
	spark:SetHeight(2.1*(h - 2*inset))
	if db.iconpos == "HIDE" then  -- icon position
		icon:Hide()
		barback:SetWidth(w)
		SetPoints(barback, "LEFT", f, "LEFT", 0, 0)
	elseif db.iconpos == "RIGHT" then
		icon:Show()
		SetPoints(icon, "RIGHT", f, "RIGHT", 0, 0)
		SetPoints(barback, "RIGHT", icon, "LEFT", 0, 0)
	else
		icon:Show()
		SetPoints(icon, "LEFT", f, "LEFT", 0, 0)
		SetPoints(barback, "LEFT", icon, "RIGHT", 0, 0)
	end
	if db.timepos == "RIGHT" then  -- time text placement
		SetPoints(timetext, "RIGHT", barback, "RIGHT", -(4 + inset), 0)
		SetPoints(displaytext, "LEFT", barback, "LEFT", (4 + inset), 0, "RIGHT", timetext, "LEFT", -(4 + inset), 0)
	else
		SetPoints(displaytext, "LEFT", barback, "LEFT", db.fontsize*3, 0, "RIGHT", barback, "RIGHT", -(4 + inset), 0)
		SetPoints(timetext, "BOTTOMRIGHT", displaytext, "BOTTOMLEFT", -db.fontsize/2, 0)
	end
	if db.reverse then  -- horizontal flip of bar growth
		SetPoints(bar, "RIGHT", barback, "RIGHT", -inset, 0)
		spark:SetPoint("CENTER", bar, "LEFT", 0, 0)
	else
		SetPoints(bar, "LEFT", barback, "LEFT", inset, 0)
		spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
	end
end
-------------------------------------
function Capping:GetBar(name, getone)  -- get active bar or unused/new one
-------------------------------------
	local f, tf
	for k, b in ipairs(bars) do  -- find already assigned bar
		if b.name == name then
			f = b
		elseif getone and not tf and not b:IsShown() then
			tf = b
		end
	end
	if not getone then return f end -- don't assign a new bar

	f = f or tf
	if not f then  -- no available bar, create new one
		local bgc = db.colors.bg
		local texture = media:Fetch("statusbar", db.texture)
		local font = media:Fetch("font", db.font)
		
		f = CreateFrame("Button", nil, UIParent)
		f:Hide()
		f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		f:SetScript("OnClick", BarOnClick)
		f:SetScript("OnUpdate", BarOnUpdate)
		f.icon = f:CreateTexture(nil, "ARTWORK")
		f.barback = f:CreateTexture(nil, "BACKGROUND")
		f.barback:SetTexture(texture)
		f.barback:SetVertexColor(bgc.r, bgc.g, bgc.b, bgc.a or 0.5)
		f.bar = f:CreateTexture(nil, "ARTWORK")
		f.bar:SetTexture(texture)
		f.timetext = NewText(f, font, db.fontsize-1, "RIGHT", "BOTTOM")
		f.displaytext = NewText(f, font, db.fontsize, "LEFT", "BOTTOM")
		
		local spark = f:CreateTexture(nil, "BORDER")
		spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		spark:SetBlendMode("ADD")
		spark:SetAlpha(0.8)
		spark:SetWidth(18)
		f.spark = spark
		
		UpdateBarLayout(f)
		tinsert(bars, f)
		f.id = getn(bars)
	end
	
	return f
end
-------------------------------------------------------------------------------------------------------
function Capping:StartBar(name, duration, remaining, icondata, color, nonactive, separate, specialText)
-------------------------------------------------------------------------------------------------------
	local icon,l,r,t,b
	if type(icondata) == "table" then
		icon, l, r, t, b = icondata.path, icondata.l, icondata.r, icondata.t, icondata.b
	else
		icon, l, r, t, b = icondata, 0.07, 0.93, 0.07, 0.93
	end
	local c = db.colors[color or "info1"] or db.colors.info1
	if db.mainup then 
		separate = not separate 
	end
	
	local f = self:GetBar(name, true)
	f.name = name
	f.color = color
	f.endtime = GetTime() + remaining
	f.duration = duration
	f.remaining = remaining
	f.down = not separate
	f.noclose = (nonactive == 2)
	f.throt = (duration < 300 and 0.1) or (duration < 600 and 0.25) or 0.5
	f.elapsed = f.throt - 0.01
	
	f.displaytext:SetText(specialText or name)
	f.icon:SetTexture(icon)
	f.icon:SetTexCoord(l, r, t, b)
	f.bar:SetVertexColor(c.r, c.g, c.b, c.a or 0.9)
	f:SetAlpha(1)
	
	if not nonactive then 
		activebars[name] = color
	end
	f:Show()
	SortBars()
end
------------------------------------
function Capping:StopBar(name, this)
------------------------------------
	local f = this or self:GetBar(name)
	if f then
		f.name = ""
		f:Hide()
		SortBars()
	end
end


local icons = { -- textures used on worldmap { left, right, top, bottom } a/h
	symbol = { 0.75, 0.875, 0.625, 0.75,   0, 0.125, 0.75, 0.875, },
	flag = { 0.375, 0.5, 0.625, 0.75,   0.5, 0.625, 0.625, 0.75, },
	graveyard = { 0.375, 0.5, 0, 0.125,   0.625, 0.75, 0.125, 0.25, },
	tower = { 0.125, 0, 0.125, 0.25,   0.5, 0.375, 0.125, 0.25, },
	farm = { 0, 0.125, 0.5, 0.625,   0.25, 0.375, 0.5, 0.625, },
	blacksmith = { 0.375, 0.5, 0.375, 0.5,   0.625, 0.75, 0.375, 0.5, },
	mine = { 0.125, 0.25,0.25, 0.375,   0.375, 0.5, 0.25, 0.375, },
	stables = { 0.625, 0.75, 0.5, 0.625,   0.875, 1, 0.5, 0.625, },
	lumbermill = { 0.75, 0.875, 0.25, 0.375,   0, 0.125, 0.375, 0.5, },
	path = "Interface\\Minimap\\POIIcons",
}
-------------------------------------------
function Capping:GetIconData(faction, name)
-------------------------------------------
	local t = icons[name or "symbol"] or icons.symbol
	if faction == "horde" then
		icons.l, icons.r, icons.t, icons.b = t[5], t[6], t[7], t[8]
	else
		icons.l, icons.r, icons.t, icons.b = t[1], t[2], t[3], t[4]
	end
	return icons
end

--------------------------------
function Capping:GetActiveBars()
--------------------------------
	return activebars
end


local timetil = {
	[strlower(L["2 minutes"])] = 123,
	[strlower(L["1 minute"])] = 63,
	[strlower(L["One minute until"])] = 63,
	[strlower(L["30 seconds"])] = 32,
	[strlower(L["Thirty seconds until"])] = 32,
	[strlower(L["Fifteen seconds until"])] = 16,
}
------------------------------------
function Capping:CheckStartTimer(a1)  -- timer for when a battleground begins
------------------------------------
	local a1 = strlower(a1)
	for text,time in pairs(timetil) do
		if strfind(a1, text) then
			self:StartBar(L["Battleground Begins"], 123, time, "Interface\\Icons\\Spell_Holy_PrayerOfHealing", "info2")
			break
		end
	end
end

local GetBattlefieldScore, GetNumBattlefieldScores = GetBattlefieldScore, GetNumBattlefieldScores
----------------------------------------------
function Capping:GetClassByName(name, faction)  -- retrieves a player's class by name
----------------------------------------------
	for i = 1, GetNumBattlefieldScores(), 1 do
		local iname,_,_,_,_,ifaction,_,_,_,iclass,_,_ = GetBattlefieldScore(i)
		if ifaction == faction and gsub(iname, "-(.+)", "") == name then
			return iclass
		end
	end
end

local classcolor = { }
for class,color in pairs(RAID_CLASS_COLORS) do
	classcolor[class] = format("%02x%02x%02x", color.r*255, color.g*255, color.b*255)
end
--------------------------------------
function Capping:GetClassColorHex(cls)  -- retrieves hex color by class (class must be english and in caps)
--------------------------------------
	return classcolor[cls or "PRIEST"] or classcolor["PRIEST"]
end

local function CarrierOnEnter(this)
	if not this.car then return end
	local c = db.colors[strlower(this.faction)] or db.colors.info1
	this:SetBackdropColor(c.r, c.g, c.b, 0.4)
end
local function CarrierOnLeave(this)
	this:SetBackdropColor(0, 0, 0, 0)
end
---------------------------------------------------------------
function Capping:CreateCarrierButton(name, w, h, postclick, oe)  -- create common secure button
---------------------------------------------------------------
	local b = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	SetWH(b, w, h)
	b:RegisterForClicks("LeftButtonUp")
	b:SetAttribute("type1", "macro")
	b:SetAttribute("macrotext", "")
	b:SetBackdrop(backdrop)
	b:SetBackdropColor(0, 0, 0, 0)
	b:SetScript("PostClick", postclick)
	b:SetScript("OnEnter", CarrierOnEnter)
	b:SetScript("OnLeave", CarrierOnLeave)
	return b
end

---------------------------------------------------------------------------------------
function Capping:CreateText(parent, fontsize, justifyH, tlrp, tlx, tly, brrp, brx, bry)  -- create common text fontstring
---------------------------------------------------------------------------------------
	local text = NewText(parent, GameFontNormal:GetFont(), fontsize, justifyH, "CENTER", "BACKGROUND")
	SetPoints(text, "TOPLEFT", tlrp, "TOPLEFT", tlx, tly, "BOTTOMRIGHT", brrp, "BOTTOMRIGHT", brx, bry)
	text:SetShadowColor(0,0,0)
	text:SetShadowOffset(1,-1)
	return text
end


do  -- initialize or update a final score estimation bar (AB and EotS uses this)
	local ascore, atime, abases, hscore, htime, hbases = 0, 0, 0, 0, 0, 0
	local updatetime, currentbg
	local GetWorldStateUIInfo, tonumber = GetWorldStateUIInfo, tonumber
	local f2 = L["Final: 2000 - %d"]
	local ptspersec = {
		[1] = { [0]=0.0, [1]=0.8333, [2]=1.1111, [3]=1.6667, [4]=3.3333, [5]=30.0, }, -- ab
		[2] = { [0]=0.0, [1]=0.5, [2]=1.0, [3]=2.5, [4]=5, }, -- eots
	}
	local sbpattern = {
		[1] = L["Bases: (%d+)  Resources: (%d+)/2000"],  -- ab
		[2] = L["Bases: (%d+)  Victory Points: (%d+)/2000"],  -- eots
	}
	local function getstatedata(off)
		local base, score = strmatch(select(3, GetWorldStateUIInfo(currentbg + off)) or "", sbpattern[currentbg])
		return tonumber(base), tonumber(score)
	end
	local function getlscore(time, pps, currentscore)  -- estimate loser's final score
		local lscore = time * pps + currentscore
		if currentbg == 1 then
			return format(f2, min(1990, 10 * floor((lscore + 5)/10)))
		else
			return format(f2, min(1999, floor(lscore + 0.5)))
		end
	end
	---------------------------------
	function Capping:NewEstimator(bg)  -- resets estimator and sets new battleground
	---------------------------------
		currentbg = bg
		updatetime = nil
		ascore, atime, abases, hscore, htime, hbases = 0, 0, 0, 0, 0, 0
	end
	--------------------------------------
	function Capping:UPDATE_WORLD_STATES()
	--------------------------------------
		local currenttime = GetTime()
		local ABases, AScore  = getstatedata(0)
		local HBases, HScore = getstatedata(1)
		if ABases and HBases then
			abases, hbases = ABases, HBases
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
		local ATime = ((2000 - ascore) / apps) - (currenttime - atime)
		local HTime = ((2000 - hscore) / hpps) - (currenttime - htime)
		
		local f = self:GetBar("EstFinal")
		local elapsed = (f and f:IsShown() and (f.duration - f.remaining)) or 0
		if HTime < ATime then  -- Horde is winning
			self:StartBar("EstFinal", HTime + elapsed, HTime, self:GetIconData("horde", "symbol"), "horde", nil, nil, getlscore(HTime, apps, ascore))
		else  -- Alliance is winning
			self:StartBar("EstFinal", ATime + elapsed, ATime, self:GetIconData("alliance", "symbol"), "alliance", nil, nil, getlscore(ATime, hpps, hscore))
		end
	end
end


do  -- options table and functions
	local ena, copt = _G.ENABLE, _G.COLORS
	local sbmover, cbmover
	local function set(k, v, v2, v3, v4)
		if db.colors[k] then  -- set color saved variables
			local c = db.colors[k]
			c.r, c.g, c.b, c.a = v, v2, v3, v4
			for index, f in pairs(bars) do
				if k == "bg" then
					f.barback:SetVertexColor(v, v2, v3, v4 or 0.5)
				elseif k == f.color then
					f.bar:SetVertexColor(v, v2, v3, v4 or 1)
				end
			end
		else  -- set non-table saved variables
			db[k] = v
			if abbrv[k] then  -- enable/disable a battleground while in it
				if GetRealZoneText() == abbrv[k] then
					if not v then 
						self:ResetAll()
					else 
						self:ZoneCheck() 
					end
				end
			else  -- update visual options
				local texture = media:Fetch("statusbar", db.texture)
				local font = media:Fetch("font", db.font)
				self:SetWidth(db.width)
				for index, f in pairs(bars) do
					f.bar:SetTexture(texture)
					f.barback:SetTexture(texture)
					f.timetext:SetFont(font, db.fontsize-1)
					f.displaytext:SetFont(font, db.fontsize)
					f:SetHeight(db.height)
					if k == "mainup" then f.down = not f.down end
					UpdateBarLayout(f)
				end
				SortBars()
				self:ModMap()
			end
		end
	end
	local function get(k)
		if db.colors[k] then
			local c = db.colors[k]
			return c.r, c.g, c.b, c.a
		else
			return db[k]
		end
	end
	local function exec(k)
		if k == "test" then
			local testicon = "Interface\\Icons\\Ability_ThunderBolt"
			self:StartBar(L["Test"].." - "..L["Other"].."1", 75, 75, testicon, "info1", true, true)
			self:StartBar(L["Test"].." - "..L["Other"].."2", 60, 60, testicon, "info2", true, true)
			self:StartBar(L["Test"].." - "..L["Alliance"], 30, 30, testicon, "alliance", true)
			self:StartBar(L["Test"].." - "..L["Horde"], 60, 60, testicon, "horde", true)
			self:StartBar(L["Test"], 75, 75, testicon, "info2", true)
		elseif k == "movesb" then
			sbmover = sbmover or CreateMover(nil, 220, 48, function(this)
				this:StopMovingOrSizing()
				db.sbx, db.sby = floor(this:GetLeft() + 50.5), floor(this:GetTop() - GetScreenHeight() + 10.5)
				UpdateWorldInfoPosition()
			end)
			sbmover:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", WorldStateAlwaysUpFrame:GetLeft() - 50, WorldStateAlwaysUpFrame:GetTop() - 10)
			sbmover:Show()
		elseif k == "movecb" then
			cbmover = cbmover or CreateMover(nil, 173, 27, function(this)
				this:StopMovingOrSizing()
				db.cbx, db.cby = floor(this:GetRight() + 0.5), floor(this:GetTop() + 0.5)
				UpdateCaptureBarPosition()
			end)
			cbmover:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", db.cbx or max(0, MinimapCluster:GetRight() - CONTAINER_OFFSET_X), db.cby or max(20, MinimapCluster:GetBottom()))
			cbmover:Show()
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
				type="group", name=av, desc=av, pass=true, set=set, get=get, func=exec, order=2,
				args = {
					av = { type="toggle", name=ena, desc=ena, order=1, },
					avquest = { type="toggle", name=L["Auto quest turnins"], desc=L["Auto quest turnins"], order=2, },
					syncav = { type="execute", name=L["Request sync"], desc=L["Request sync"], disabled = function() return GetRealZoneText() ~= av end, order=3, },
				},
			},
			ab = {
				type="group", name=ab, desc=ab, pass=true, set=set, get=get, order=3,
				args = { ab = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			eots = {
				type="group", name=eots, desc=eots, pass=true, set=set, get=get, order=4,
				args = { eots = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			wsg = {
				type="group", name=wsg, desc=wsg, pass=true, set=set, get=get, order=5,
				args = { wsg = { type="toggle", name=ena, desc=ena, order=1, }, },
			},
			bars = {
				type="group", name=L["Bar"], desc=L["Bar"], pass=true, set=set, get=get, func=exec, order=6,
				args = {
					texture = { type="text", name=L["Texture"], desc=L["Texture"], validate=media:List("statusbar"), order=1, },
					width = { type="range", name=L["Width"], desc=L["Width"], min=100, max=500, step=5, order=2, },
					height = { type="range", name=L["Height"], desc=L["Height"], min=6, max=50, step=1, order=3, },
					inset = { type="range", name=L["Border width"], desc=L["Border width"], min=0, max=8, step=0.5, order=4, },
					iconpos = { type="text", name=L["Icons"], desc=L["Icons"], validate = { L["LEFT"], L["RIGHT"], L["HIDE"], }, order=5, },
					fill = { type="toggle", name=L["Fill grow"], desc=L["Fill grow"], order=6, },
					reverse = { type="toggle", name=L["Fill right"], desc=L["Fill right"], order=7, },
					mainup = { type="toggle", name=L["Flip growth"], desc=L["Flip growth"], order=8, },
					font = { type="text", name=L["Font"], desc=L["Font"], validate=media:List("font"), order=9, },
					fontsize = { type="range", name=_G.FONT_SIZE, desc=_G.FONT_SIZE, min=6, max=24, step=0.5, order=10, },
					timepos = { type="text", name=L["Time position"], desc=L["Time position"], validate = { L["LEFT"], L["RIGHT"], }, order=11, },
					colors = {
						type="group", name=copt, desc=copt, pass=true, set=set, get=get, order=12,
						args = {
							alliance = { type="color", name=L["Alliance"], desc=copt, hasAlpha = true, order=1, },
							horde = { type="color", name=L["Horde"], desc=copt, hasAlpha = true, order=2, },
							info1 = { type="color", name=L["Other"].."1", desc=copt, hasAlpha = true, order=3, },
							info2 = { type="color", name=L["Other"].."2", desc=copt, hasAlpha = true, order=4, },
							bg = { type="color", name=L["Texture"], desc=copt, hasAlpha = true, order=5, },
						},
					},
					test = { type="execute", name=L["Test"], desc=L["Test"], order=13, },
				},
			},
			bgmap = {
				type="group", name=L["Battlefield Minimap"], desc=L["Battlefield Minimap"], pass=true, set=set, get=get, order=7,
				args = {
					autoshow = { type="toggle", name=L["Auto show map"], desc=L["Auto show map"], order=1, },
					narrow = { type="toggle", name=L["Narrow map mode"], desc=L["Narrow map mode"], order=2, },
					hidemapborder = { type="toggle", name=L["Hide border"], desc=L["Hide border"], order=3, },
					mapscale = { type="range", name=L["Map scale"], desc=L["Map scale"], min=0.3, max=3.0, step=0.05, order=4, },
				},
			},
			other = {
				type="group", name=L["Other"], desc=L["Other"], pass=true, set=set, get=get, func=exec, order=8,
				args = {
					port = { type="toggle", name=L["Port Timer"], desc=L["Port Timer"], order=1, },
					wait = { type="toggle", name=L["Wait Timer"], desc=L["Wait Timer"], order=2, },
					movesb = { type="execute", name=L["Reposition Scoreboard"], desc=L["Reposition Scoreboard"], order=3, },
					movecb = { type="execute", name=L["Reposition Capture Bar"], desc=L["Reposition Capture Bar"], order=4, },
				},
			},
			anchor = { type="execute", name=L["Show/Hide Anchor"], desc=L["Show/Hide Anchor"], func=exec, passValue="anchor", order=9, },
		},
	}
	local baropts = {  -- dropdown for bar timers
		type="group",
		args = {
			reportbg = { type="execute", name=L["Send to BG"], desc=L["Or <Ctrl-left-click> a timer"], func=ReportBG, order=1, },
			reportsay = { type="execute", name=L["Send to SAY"], desc=L["Or <Shift-left-click> a timer"], func=ReportSAY, order=2, },
			cancelbar = { type="execute", name=L["Cancel timer"], desc=L["Or <Ctrl-right-click> a timer"], func=CancelBar, order=3, },
			blank = { type="header", order=98, },
			options = { type="execute", name=L["Other options"], desc=L["Other options"], order=99, },
		},
	}
	local baropts2 = {  -- dropdown for bar timers
		type="group",
		args = {
			reportbg = { type="execute", name=_G.ENTER_BATTLE, desc=L["Or <Ctrl-left-click> a timer"], func=ReportBG, order=1, },
			cancelbar = { type="execute", name=_G.LEAVE_QUEUE, desc=L["Or <Ctrl-right-click> a timer"], func=CancelBar, order=2, },
			blank = { type="header", order=98, },
			options = { type="execute", name=L["Other options"], desc=L["Other options"], order=99, },
		},
	}
	local feed
	local function ddopt()
		dew:FeedAceOptionsTable((feed == 1 and baropts) or (feed == 2 and baropts2) or opts)
	end
	function ShowOptions(a1, barid)
		barid = type(barid) == "number" and barid
		feed = nil
		if barid then
			if not activebars[bars[barid].name] then
				baropts2.args.reportbg.passValue = barid
				baropts2.args.cancelbar.passValue = barid
				feed = 2
			else
				baropts.args.reportbg.passValue = barid
				baropts.args.reportsay.passValue = barid
				baropts.args.cancelbar.passValue = barid
				feed = 1
			end
		end
		dew:Open(f, 'children', ddopt, 'cursorX', true, 'cursorY', true)
	end
	baropts.args.options.func = ShowOptions
	baropts2.args.options.func = ShowOptions
end
