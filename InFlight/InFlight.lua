-- LIBRARIES
local smed = LibStub("LibSharedMedia-3.0")
local dew = AceLibrary("Dewdrop-2.0")

-- GLOBALS -> LOCAL
local InFlight = InFlight
local self = InFlight
local NumTaxiNodes, TaxiNodeGetType, TaxiNodeName, UnitOnTaxi = NumTaxiNodes, TaxiNodeGetType, TaxiNodeName, UnitOnTaxi
local format, strfind, strsub, mod = format, strfind, strsub, math.fmod
local gtt = GameTooltip
local oldTakeTaxiNode

-- LOCAL VARIABLES
local vars, db  -- addon
local source, destination, endTime  -- location data
local porttaken, initbulk, takeoff  -- flags
local rat, isanimal, endText, shapes  -- cache variables
local sb, spark, timeText, locText, bord  -- frame elements
local totalTime, elapsed, throt = 0, 0, 0  -- throttle vars

-- LOCALIZATION 
local gl = GetLocale()
local L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
local L_duration = "Duration: "
local L_tooltipoption2 = " <Shift left-click> to move."
local L_tooltipoption3 = " <Right-click> for options."
local L_confirmpopup = "Take flight to |cffffff00%s%s|r?"
local L_BarOptions = "Bar Options"
local L_FillUp = "Fill Up"
local L_Texture = "Texture"
local L_Width = "Width"
local L_Height = "Height"
local L_Border = "Border"
local L_FillColor = "Fill Color"
local L_UnknownColor = "Unknown Color"
local L_BackgroundColor = "Background Color"
local L_BorderColor = "Border Color"
local L_TextOptions = "Text Options"
local L_CompactMode = "Compact Mode"
local L_ToText = "\"To\" Text"
local L_Font = "Font"
local L_FontSize = "Font Size"
local L_FontColor = "Font Color"
local L_ConfirmFlight = "Confirm Flight"
if gl == "koKR" then
	--L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
	L_duration = "지속시간: "
	L_tooltipoption2 = " <쉬프트+클릭> 하면 이동합니다."
	L_tooltipoption3 = " <오른쪽-클릭> 하면 설정을 엽니다."
	--L_confirmpopup = "Take flight to |cffffff00%s%s|r?"
	L_BarOptions = "바 설정"
	L_FillUp = "바 채우기"
	L_Texture = "바 텍스처"
	L_Width = "길이"
	L_Height = "높이"
	L_Border = "테두리"
	L_FillColor = "바 색상"
	L_UnknownColor = "모르는 경로 색상"
	L_BackgroundColor = "배경 색상"
	L_BorderColor = "테두리 색상"
	L_TextOptions = "글자 설정"
	L_CompactMode = "간단 모드"
	-- L_ToText = "\"To\" Text"
	L_Font = "글꼴"
	L_FontSize = "글꼴 크기"
	L_FontColor = "글꼴 색상"
	L_ConfirmFlight = "경로 확인"
elseif gl == "zhTW" then
	L_destparse = "，(.+)"  -- removes main zone name, leaving only subzone
	L_duration = "時間: "
	L_tooltipoption2 = " Shift-左擊: 移動"
	L_tooltipoption3 = " 右擊: 打開設定選單"
	L_confirmpopup = "你確定你要飛到|cffffff00%s%s|r?"
	L_BarOptions = "外觀"
	L_FillUp = "遞增"
	L_Texture = "時間條紋理"
	L_Width = "寬度"
	L_Height = "高度"
	L_Border = "邊框"
	L_FillColor = "時間條顏色"
	L_UnknownColor = "未知顏色"
	L_BackgroundColor = "背景顏色"
	L_BorderColor = "邊框顏色"
	L_TextOptions = "字形"
	L_CompactMode = "內嵌模式"
	L_ToText = "「到」文字"
	L_Font = "字形"
	L_FontSize = "字形大小"
	L_FontColor = "字形顏色"
	L_ConfirmFlight = "確定飛行"
elseif gl == "esES" then
	--L_destparse = ", (.+)"  -- removes main zone name, leaving only subzone
	L_duration = "Duración: "
	L_tooltipoption2 = " <Shift+Click-Izquierdo> para mover."
	L_tooltipoption3 = " <Click-Derecho> para Opciones."
	L_confirmpopup = "¿Coger un vuelo hacia |cffffff00%s%s|r?"
	L_BarOptions = "Opciones de la Barra"
	L_FillUp = "Rellenar"
	L_Texture = "Textura"
	L_Width = "Ancho"
	L_Height = "Alto"
	L_Border = "Borde"
	L_FillColor = "Color de la Barra"
	L_UnknownColor = "Color de Desconocido"
	L_BackgroundColor = "Color de Fondo"
	L_BorderColor = "Color de Borde"
	L_TextOptions = "Opciones del Texto"
	L_CompactMode = "Modo Compacto"
	L_ToText = "Texto \"Hacia\""
	L_Font = "Fuente"
	L_FontSize = "Tamaño"
	L_FontColor = "Color"
	L_ConfirmFlight = "Confirmar Vuelo"
end

-- LOCAL FUNCTIONS
local function FormatTime(secs, f)  -- simple time format
	if not f then
		return format("%d:%02d", secs / 60, mod(secs, 60))
	end
	f:SetFormattedText("%d:%02d / %s", secs / 60, mod(secs, 60), endText)
end
local function ShortenName(name)  -- shorten name to lighten saved vars
	return gsub(name, L_destparse, "")
end
local function getrgb(clr)  -- get rgb values
	local c = db[clr]
	return c.r, c.g, c.b, c.a
end
local function SetJustify(f, h, v)
	f:SetJustifyH(h)
	f:SetJustifyV(v)
end
local function SetPoints(f, lp, lrt, lrp, lx, ly, rp, rrt, rrp, rx, ry)
	f:ClearAllPoints()
	f:SetPoint(lp, lrt, lrp, lx, ly)
	if rp then f:SetPoint(rp, rrt, rrp, rx, ry) end
end
local function SetToUnknown()  -- setup bar for flights with unknown time
	sb:SetValue(1)
	sb:SetStatusBarColor(getrgb("unknowncolor"))
	endText = "??"
	spark:Hide()
end

----------------------------
function InFlight:LoadBulk()  -- called from InFlight_Load
----------------------------
	InFlightDB = InFlightDB or {}
	db = (InFlightDB.profiles and InFlightDB.profiles.Default) or InFlightDB
	if db.dbinit ~= 3 then
		db.dbinit = nil
		local function SetDefaults(db, t)  -- set saved variables
			for k,v in pairs(t) do
				if type(db[k]) == "table" then
					SetDefaults(db[k], v)
				else
					db[k] = (db[k] ~= nil and db[k]) or v
				end
			end
		end
		SetDefaults(db, {
			confirmflight = false,
			fill = true,
			inline = false,
			border = "Blizzard Tooltip",
			height = 14,
			width = 230,
			font = "Friz Quadrata TT",
			fontsize = 12,
			texture = "Blizzard",
			barcolor = { r = 0.5, g = 0.5, b = 0.8, a = 1.0, },
			unknowncolor = { r = 0.2, g = 0.2, b = 0.4, a = 1.0, },
			bordercolor = { r = 0.6, g = 0.6, b = 0.6, a = 0.8, },
			backcolor = { r = 0.1, g = 0.1, b = 0.1, a = 0.6, },
			fontcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0, },
			totext = " --> ",
			dbinit = 3,
		} )
	end
	-- flight time data
	InFlightVars = InFlightVars or (self.LoadDefaults and self:LoadDefaults()) or { Alliance = {}, Horde = {}, }
	self.LoadDefaults = nil
	vars = InFlightVars[UnitFactionGroup("player")]
	local _, cls = UnitClass("player")
	isanimal = (cls == "DRUID") or (cls == "SHAMAN")
	initbulk = true
	
	oldTakeTaxiNode = TakeTaxiNode
	TakeTaxiNode = function(slot)
		if TaxiNodeGetType(slot) ~= "REACHABLE" then return end
		destination = ShortenName(TaxiNodeName(slot))
		local t = vars[source]
		if t and t[destination] and t[destination] > 0 then  -- saved variables lookup
			endTime = t[destination]
		else
			endTime = nil
		end
		if db.confirmflight then  -- confirm flight
			StaticPopupDialogs.INFLIGHTCONFIRM = StaticPopupDialogs.INFLIGHTCONFIRM or {
				button1 = OKAY,
				button2 = CANCEL,
				OnAccept = function(data) InFlight:StartTimer(data) end,
				timeout = 0,
				exclusive = 1,
				hideOnEscape = 1,
			}
			StaticPopupDialogs.INFLIGHTCONFIRM.text = format(L_confirmpopup, destination, endTime and format(" (%s)", FormatTime(endTime)) or "")

			local dialog = StaticPopup_Show("INFLIGHTCONFIRM")
			if dialog then 
				dialog.data = slot 
			end
		else  -- just take the flight
			self:StartTimer(slot)
		end
	end
	
	hooksecurefunc("TaxiNodeOnButtonEnter", function(button)  -- add time info on the taxi map tooltips
		if TaxiNodeGetType(button:GetID()) == "REACHABLE" then
			local time = (vars[source] and vars[source][ShortenName(TaxiNodeName(button:GetID()))]) or 0
			if time > 0 then
				gtt:AddLine(L_duration..FormatTime(time), 1, 1, 1)
			else
				gtt:AddLine(L_duration.."-:--", 0.8, 0.8, 0.8)
			end
			gtt:Show()
		end
	end)
	-- function hooks to detect if a user took a summon
	hooksecurefunc("AcceptBattlefieldPort", function(index,accept) porttaken = accept and true end)
	hooksecurefunc("ConfirmSummon", function() porttaken = true end)
	
	self:Hide()
	
	self.LoadBulk = nil
	collectgarbage()
end

------------------------------
function InFlight:InitSource()
------------------------------
	for i = 1, NumTaxiNodes(), 1 do
		if TaxiNodeGetType(i) == "CURRENT" then
			source = ShortenName(TaxiNodeName(i))
			break
		end
	end
end

----------------------------------
function InFlight:StartTimer(slot)
----------------------------------
	Dismount()
	if isanimal then  -- animal form unshift
		shapes = shapes or {
			["Interface\\Icons\\Spell_Nature_SpiritWolf"] = true, -- ghost wolf
			["Interface\\Icons\\Ability_Druid_TravelForm"] = true, -- travel
			["Interface\\Icons\\Ability_Druid_FlightForm"] = true, -- flight
			["Interface\\Icons\\Ability_Druid_CatForm"] = true, -- kitty
			["Interface\\Icons\\Ability_Racial_BearForm"] = true, -- bear
			["Interface\\Icons\\Spell_Nature_ForceOfNature"] = true, -- moonkin
			["Interface\\Icons\\Ability_Druid_TreeofLife"] = true, -- tree
		}
		for i = 1, 32, 1 do
			local id, isaura = GetPlayerBuff(i, "HELPFUL")
			if not id or id == 0 then break end
			if isaura and shapes[GetPlayerBuffTexture(id)] then
				CancelPlayerBuff(id)
				break
			end
		end
	end
	if not sb then  -- create the timer bar
		self:CreateBar()
	end
	locText:SetFormattedText("%s%s%s", not db.inline and source or "", not db.inline and db.totext or "", destination or "")
	if endTime then  -- start the timers and setup statusbar
		sb:SetValue((db.fill and 0) or 1)
		sb:SetStatusBarColor(getrgb("barcolor"))
		spark:Show()
		rat = sb:GetWidth() / endTime
		endText = FormatTime(endTime)
	else
		SetToUnknown()
	end
	porttaken = nil
	elapsed, totalTime = 0, 0
	takeoff = true
	throt = min(0.2, (endTime or 50) * 0.004)  -- increases updates for short flights
	self:Show()
	
	if slot then
		oldTakeTaxiNode(slot)
	end
end

---------------------------------------
function InFlight:StartMiscFlight(s, d)  -- support for druid and many other special flightpaths
---------------------------------------
	self:TAXIMAP_OPENED(nil, true)
	endTime = vars[s] and vars[s][d]
	source, destination = s, d
	self:StartTimer()
end

do  -- visuals
	local bdrop = { edgeSize = 16, insets = {}, }
	local bdi = bdrop.insets
	local function UpdateTextLook(t, adj)
		t:SetFont(smed:Fetch("font", db.font), db.fontsize - adj)
		t:SetShadowColor(0.1, 0.1, 0.1, db.fontcolor.a)
		t:SetShadowOffset(1,-1)
		t:SetTextColor(getrgb("fontcolor"))
	end
	-----------------------------
	function InFlight:CreateBar()
	-----------------------------
		sb = CreateFrame("StatusBar", "InFlightBar", UIParent)
		sb:Hide()
		sb:SetPoint(db.p or "TOP", UIParent, db.rp or "BOTTOMLEFT", db.x or (GetScreenWidth()/2), db.y or (GetScreenHeight()-200))
		sb:SetMovable(true)
		sb:EnableMouse(true)
		sb:SetScript("OnMouseUp", function(this, a1) if a1 == "RightButton" then InFlight:ShowOptions() end end)
		sb:RegisterForDrag("LeftButton")
		sb:SetScript("OnDragStart", function(this) if IsShiftKeyDown() then this:StartMoving() end end)
		sb:SetScript("OnDragStop", function(this) 
			this:StopMovingOrSizing() 
			local a,b,c,d,e = this:GetPoint()
			db.p, db.rp, db.x, db.y = a, c, floor(d + 0.5), floor(e + 0.5)
		end)
		sb:SetScript("OnEnter", function(this)
			gtt:SetOwner(this, "ANCHOR_RIGHT")
			gtt:SetText("InFlight", 1, 1, 1)
			gtt:AddLine(L_tooltipoption2, 0, 1, 0)
			gtt:AddLine(L_tooltipoption3, 0, 1, 0)
			gtt:Show()
		end)
		sb:SetScript("OnLeave", function() gtt:Hide() end)
		sb:SetMinMaxValues(0, 1)
	
		timeText = sb:CreateFontString(nil, "OVERLAY")
		locText = sb:CreateFontString(nil, "OVERLAY")
		
		spark = sb:CreateTexture(nil, "ARTWORK")
		spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		spark:SetWidth(16)
		spark:SetBlendMode("ADD")
		
		bord = CreateFrame("Frame", nil, sb)  -- border/background
		SetPoints(bord, "TOPLEFT", sb, "TOPLEFT", -4, 4, "BOTTOMRIGHT", sb, "BOTTOMRIGHT", 4, -4)
		bord:SetFrameStrata("LOW")
		
		self:UpdateLook()
		
		self:SetScript("OnUpdate", function(this, a1)
			elapsed = elapsed + a1
			if elapsed < throt then return end
			totalTime = totalTime + elapsed
			elapsed = 0
			
			if takeoff then  -- check if in actually in flight after take off (doesn't happen immediately)
				if UnitOnTaxi("player") then
					takeoff = nil
					sb:Show()
					elapsed, totalTime = throt - 0.01, 0
				elseif totalTime > 5 then
					this:Hide()
				end
				return
			end
			if not UnitOnTaxi("player") then  -- flight ended
				if not porttaken then 
					vars[source] = vars[source] or { }
					vars[source][destination] = floor(totalTime + 0.5)
				end
				endTime = nil
				sb:Hide()
				this:Hide()
				return
			end
			if endTime then  -- update statusbar if destination time is known
				if totalTime - 2 > endTime then   -- in case the flight is longer than expected
					SetToUnknown()
					endTime = nil
				else
					local value = (db.fill and totalTime) or (endTime - totalTime)
					sb:SetValue(value / endTime)
					spark:SetPoint("CENTER", sb, "LEFT", value * rat, 0)
					FormatTime(value, timeText)
				end
			else  -- destination time is unknown, so show that it's timing
				FormatTime(totalTime, timeText)
			end
		end)
		self.CreateBar = nil
	end
	------------------------------
	function InFlight:UpdateLook()
	------------------------------
		if not sb then return end
		
		sb:SetWidth(db.width)
		sb:SetHeight(db.height)
		
		local texture = smed:Fetch("statusbar", db.texture)
		local inset = (db.border=="Textured" and 2) or 5
		bdrop.bgFile = texture
		bdrop.edgeFile = smed:Fetch("border", db.border)
		bdi.left, bdi.right, bdi.top, bdi.bottom = inset, inset, inset, inset
		bord:SetBackdrop(bdrop)
		bord:SetBackdropColor(getrgb("backcolor"))
		bord:SetBackdropBorderColor(getrgb("bordercolor"))
		sb:SetStatusBarTexture(texture)
		if endTime then  -- in case we're in flight
			rat = db.width / endTime
			sb:SetStatusBarColor(getrgb("barcolor"))
		else
			SetToUnknown()
		end
		spark:SetHeight(db.height*2.4)
		
		UpdateTextLook(locText, 0)
		UpdateTextLook(timeText, 1)
		if db.inline then
			SetJustify(timeText, "RIGHT", "CENTER")
			SetPoints(timeText, "RIGHT", sb, "RIGHT", -4, 0)
			SetJustify(locText, "LEFT", "CENTER")
			SetPoints(locText, "LEFT", sb, "LEFT", 4, 0, "RIGHT", timeText, "LEFT", -2, 0)
		else
			SetJustify(timeText, "CENTER", "CENTER")
			SetPoints(timeText, "CENTER", sb, "CENTER", 0, 0)
			SetJustify(locText, "CENTER", "BOTTOM")
			SetPoints(locText, "TOPLEFT", sb, "TOPLEFT", -24, db.fontsize*2.5, "BOTTOMRIGHT", sb, "TOPRIGHT", 24, (db.border=="None" and 1) or 3)
		end	
		locText:SetFormattedText("%s%s%s", not db.inline and source or "", not db.inline and db.totext or "", destination or "")
	end
end

---------------------------------
function InFlight:SetLayout(this)  -- setups the options in the default interface options
---------------------------------
	dew:Close()
	if not this.t1 then
		local t1 = this:CreateFontString(nil, "ARTWORK")
		t1:SetFontObject(GameFontNormalLarge)
		SetJustify(t1, "LEFT", "TOP")
		t1:SetPoint("TOPLEFT", 16, -16)
		t1:SetText("InFlight")
		this.tl = t1
		
		local t2 = this:CreateFontString(nil, "ARTWORK")
		t2:SetFontObject(GameFontHighlightSmall)
		SetJustify(t2, "LEFT", "TOP")
		t2:SetHeight(43)
		SetPoints(t2, "TOPLEFT", t1, "BOTTOMLEFT", 0, -8, "RIGHT", this, "RIGHT", -32, 0)
		t2:SetNonSpaceWrap(true)
		local function GetInfo(field)
			return GetAddOnMetadata("InFlight", field) or "N/A"
		end
		t2:SetFormattedText("Notes: %s\nAuthor: %s\nVersion: %s", GetInfo("Notes"), GetInfo("Author"), GetInfo("Version"))
	
		local b = CreateFrame("Button", nil, this, "UIPanelButtonTemplate")
		b:SetWidth(120)
		b:SetHeight(20)
		b:SetText(MAINMENU_BUTTON)
		b:SetScript("OnClick", InFlight.ShowOptions)
		b:SetPoint("TOPLEFT", t2, "BOTTOMLEFT", -2, -8)
	end
end

do  -- options table
	smed:Register("border", "Textured", "\\Interface\\None")  -- dummy border
	local function set(k,r,g,b,a)
		if type(db[k]) == "table" then
			local t = db[k]
			t.r, t.g, t.b, t.a = r,g,b,a
		else
			db[k] = r
		end
		self:UpdateLook()
	end
	local function get(k)
		local t = db[k]
		if type(t) == "table" then
			return t.r, t.g, t.b, t.a
		else
			return t
		end
	end
	local opts = {
		type="group",
		args = {
			header = { type="header", name="|cffaaaaffIn|r|cffddddffFlight|r", order=1, },
			frame = {
				type="group", name=L_BarOptions, desc=L_BarOptions, pass=true, set=set, get=get, order=2,
				args={
					fill = { type="toggle", name=L_FillUp, desc=L_FillUp, order=1, },
					texture = { type="text", name=L_Texture, desc=L_Texture, validate=smed:List("statusbar"), order=2, },
					width = { type="range", name=L_Width, desc=L_Width, min=60, max=600, step=5, order=3, },
					height = { type="range", name=L_Height, desc=L_Height, min=4, max=100, step=1, order=4, },
					border = { type="text", name=L_Border, desc=L_Border, validate=smed:List("border"), order=5, },
					barcolor = { type="color", name=L_FillColor, desc=L_FillColor, hasAlpha=true, order=6, },
					unknowncolor = { type="color", name=L_UnknownColor, desc=L_UnknownColor, hasAlpha=true, order=7, },
					backcolor = { type="color", name=L_BackgroundColor, desc=L_BackgroundColor, hasAlpha=true, order=8, },
					bordercolor = { type="color", name=L_BorderColor, desc=L_BorderColor, hasAlpha=true, order=9, },
				},
			},
			text = {
				type="group", name=L_TextOptions, desc=L_TextOptions, pass=true, set=set, get=get, order=3,
				args={
					inline = { type="toggle", name=L_CompactMode, desc=L_CompactMode, order=1, },
					totext = { type="text", name=L_ToText, desc=L_ToText, usage="", order=2, },
					font = { type="text", name=L_Font, desc=L_Font, validate=smed:List("font"), order=3, },
					fontsize = { type="range", name=L_FontSize, desc=L_FontSize, min=4, max=40, step=1, order=4, },
					fontcolor = { type="color", name=L_FontColor, desc=L_FontColor, hasAlpha=true, order=5, },
				},
			},
			confirmflight = { type="toggle", name=L_ConfirmFlight, desc=L_ConfirmFlight, passValue="confirmflight", set=set, get=get, order=5, },
		},
	}
	local function dewdd() dew:FeedAceOptionsTable(opts) end
	-------------------------------
	function InFlight:ShowOptions()
	-------------------------------
		dew:Open(UIParent, 'children', dewdd, 'cursorX', true, 'cursorY', true) 
	end
end