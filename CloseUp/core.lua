-- Title: CloseUp v2.4.001
-- Author: TotalPackage
-- Date: 03/27/2008

local _G = getfenv(0)
local GetCursorPosition = GetCursorPosition

-- someone wanted the feature to hide the dressing rooms' backgrounds
local function ToggleBG(notog)
	if not notog then CU_HideBG = not CU_HideBG end
	if CU_HideBG then
		DressUpBackgroundTopLeft:Hide()
		DressUpBackgroundTopRight:Hide()
		DressUpBackgroundBotLeft:Hide()
		DressUpBackgroundBotRight:Hide()
		if AuctionDressUpBackgroundTop then
			AuctionDressUpBackgroundTop:Hide()
			AuctionDressUpBackgroundBot:Hide()
		end
	else
		DressUpBackgroundTopLeft:Show()
		DressUpBackgroundTopRight:Show()
		DressUpBackgroundBotLeft:Show()
		DressUpBackgroundBotRight:Show()
		if AuctionDressUpBackgroundTop then
			AuctionDressUpBackgroundTop:Show()
			AuctionDressUpBackgroundBot:Show()
		end
	end
end

local function OnMouseDown(this, a1)
	if a1 == "LeftButton" then
		this.isrotating = 1
		if IsControlKeyDown() then
			ToggleBG()
		end
	elseif a1 == "RightButton" then
		this.ispaning = 1
	end
	this.prevx, this.prevy = GetCursorPosition()
end
local function OnMouseUp(this, a1)
	if a1 == "LeftButton" then
		this.isrotating = nil
	end
	if a1 == "RightButton" then
		this.ispaning = nil
	end
end
local function OnMouseWheel(this, a1)
	local cz, cx, cy = this:GetPosition()
	if a1 > 0 then
		cz = cz + 0.7
	else
		cz = cz - 0.7
	end
	this:SetPosition(cz, cx, cy)
end
local function OnUpdate(this)
	if this.isrotating then
		local currentx, currenty = GetCursorPosition()
		local newrot = this:GetFacing() + ((currentx - this.prevx) / 50)
		this:SetFacing(newrot)
		this.prevx, this.prevy = currentx, currenty
	elseif this.ispaning then
		local currentx, currenty = GetCursorPosition()
		local cz, cx, cy = this:GetPosition()
		local newx = cx + ((currentx - this.prevx) / 50)
		local newy = cy + ((currenty - this.prevy) / 50)
		this:SetPosition(cz, newx, newy)
		this.prevx, this.prevy = currentx, currenty
	end
end

-- base functions
-- - model - model frame name (string)
-- - w/h - new width/height of the model frame
-- - x/y - new x/y positions for default setpoint
-- - sigh - if rotation buttons have different base names than parent
-- - norotate - if the model doesn't have default rotate buttons
local function Apply(model, w, h, x, y, sigh, norotate)
	local gmodel = _G[model]
	if not norotate then
		model = sigh or model
		_G[model.."RotateRightButton"]:Hide()
		_G[model.."RotateLeftButton"]:Hide()
	end
	if w then gmodel:SetWidth(w) end
	if h then gmodel:SetHeight(h) end
	if x or y then 
		local p,rt,rp,px,py = gmodel:GetPoint()
		gmodel:SetPoint(p, rt, rp, x or px, y or py) 
	end
	
	gmodel:EnableMouse(true)
	gmodel:EnableMouseWheel(true)
	gmodel:SetScript("OnMouseDown", OnMouseDown)
	gmodel:SetScript("OnMouseUp", OnMouseUp)
	gmodel:SetScript("OnMouseWheel", OnMouseWheel)
	gmodel:SetScript("OnUpdate", OnUpdate)
end
-- in case someone wants to apply it to his/her model
CloseUpApplyChange = Apply

-- creates/modifies buttons (reset/target/undress)
local newbutton
do
	local gtt = GameTooltip
	local function gttshow(this)
		gtt:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
		gtt:SetText(this.tt)
		if CloseUpNPCModel:IsVisible() and this.tt == "Undress" then
			gtt:AddLine("NPCs are no longer functional dressup models (2.1)")
		end
		gtt:Show()
	end
	local function gtthide()
		gtt:Hide()
	end
	function newbutton(name, parent, text, w, h, func, button, tt)
		local b = button or CreateFrame("Button", name, parent, "UIPanelButtonTemplate")
		b:SetText(text or b:GetText())
		b:SetWidth(w or b:GetWidth())
		b:SetHeight(h or b:GetHeight())
		b:SetScript("OnClick", func)
		if tt then
			b.tt = tt
			b:SetScript("OnEnter", gttshow)
			b:SetScript("OnLeave", gtthide)
		end
		return b
	end
end
-- modifies the auction house dressing room
local function DoAH()
	Apply("AuctionDressUpModel", nil, 370, 0, 10)
	local tb, du = AuctionDressUpFrameResetButton, AuctionDressUpModel
	local w, h = 20, tb:GetHeight()
	newbutton(nil, nil, "T", w, h, function()
		if UnitExists("target") and UnitIsVisible("target") then
			du:SetUnit("target")
		end
	end, tb, "Target")
	local a,b,c,d,e = tb:GetPoint()
	tb:SetPoint(a,b,c,d,e-30)
	local rb = newbutton("CloseUpAHResetButton", du, "R", 20, 22, function() du:Dress() end, nil, "Reset")
	rb:SetPoint("RIGHT", tb, "LEFT", 0, 0)
	local ub = newbutton("CloseUpAHUndressButton", du, "U", 20, 22, function() du:Undress() end, nil, "Undress")
	ub:SetPoint("LEFT", tb, "RIGHT", 0, 0)
	ToggleBG(true)
end
local function DoIns()
	Apply("InspectModelFrame", nil, nil, nil, nil, "InspectModel")
end

-- now apply the changes
-- need an event frame since 2 of the models are from LoD addons
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(this, event, a1)
	if a1 == "Blizzard_AuctionUI" then
		DoAH()
	elseif a1 == "Blizzard_InspectUI" then
		DoIns()
	end
end)
-- in case Blizzard_AuctionUI or Blizzard_InspectUI were loaded early
if AuctionDressUpModel then DoAH() end
if InspectModelFrame then DoIns() end

-- main dressing room model
do
	Apply("DressUpModel", nil, 332, nil, 104)
	-- ok, stop freaking asking for it, here it is, like it or not
	local tb = DressUpFrameCancelButton
	local w, h = 40, tb:GetHeight()
	local m = DressUpModel

	-- since 2.1 dressup models doesn't apply properly to NPCs, make a substitute
	local tm = CreateFrame("PlayerModel", "CloseUpNPCModel", DressUpFrame)
	tm:SetAllPoints(DressUpModel)
	tm:Hide()
	Apply("CloseUpNPCModel", nil, nil, nil, nil, nil, true)
	
	DressUpFrame:HookScript("OnShow", function()
		tm:Hide()
		m:Show()
		ToggleBG(true)
	end)
	
	-- convert default close button into set target button
	newbutton(nil, nil, "Tar", w, h, function()
		if UnitExists("target") and UnitIsVisible("target") then 
			if UnitIsPlayer("target") then
				tm:Hide()
				m:Show()
				m:SetUnit("target")
			else
				tm:Show()
				m:Hide()
				tm:SetUnit("target")
			end
			SetPortraitTexture(DressUpFramePortrait, "target")
		end
	end, tb, "Target")
	local a,b,c,d,e = tb:GetPoint()
	tb:SetPoint(a, b, c, d - (w/2), e)

	local ub = newbutton("CloseUpUndressButton", DressUpFrame, "Und", w, h, function() m:Undress() end, nil, "Undress")
	ub:SetPoint("LEFT", tb, "RIGHT", -2, 0)
end

Apply("CharacterModelFrame")
Apply("TabardModel", nil, nil, nil, nil, "TabardCharacterModel")

-- hunter pet models
local _, cls = UnitClass("player")
if cls == "HUNTER" or cls == "WARLOCK" then
	Apply("PetModelFrame")
	Apply("PetStableModel")
	PetPaperDollPetInfo:SetFrameStrata("HIGH")
end
