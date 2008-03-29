
local _G = getfenv(0)

zTipOption = CreateFrame("Frame",nil,UIParent)
zTipOption:Hide()

function zTipOption:Init()
	-- localize
	self:Localize()

	-- init frame
	self:SetWidth(300); self:SetHeight(420);
	self:SetPoint("CENTER")
	self:SetFrameStrata("HIGH")
	self:SetToplevel(true)
	self:SetMovable(true)
	self:SetClampedToScreen(true)

	-- background
	self:SetBackdrop( {
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
	  insets = { left = 5, right = 5, top = 5, bottom = 5 }
	});
	self:SetBackdropColor(0,0,0)

	-- drag
	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart",function() this:StartMoving() end)
	self:SetScript("OnDragStop",function() this:StopMovingOrSizing() end)

	-- title
	self:CreateFontString("zTipOptionTitle", "ARTWORK", "SystemFont")
	zTipOptionTitle:SetPoint("TOP",0,-10)
	zTipOptionTitle:SetTextColor(0.8,0.5,1)
	zTipOptionTitle:SetText(self.locStr["zTip Options"])

	-- buttons
	zTipOption:InitButtons()

	-- sub titles
	self:CreateFontString("zTipOptionPositionTitle","ARTWORK","SystemFont")
	zTipOptionPositionTitle:SetPoint("BOTTOMLEFT", "zTipOptionFollowCursor","TOPLEFT",2,10)
	zTipOptionPositionTitle:SetText(self.locStr["Positions"])

	self:CreateFontString("zTipOptionOffsetTitle","ARTWORK","SystemFont")
	zTipOptionOffsetTitle:SetPoint("BOTTOMLEFT", "zTipOptionOffsetX","TOPLEFT",-5,10)
	zTipOptionOffsetTitle:SetText(self.locStr["Offsets"])

	self:CreateFontString("zTipOptionOrigPosTitle","ARTWORK","SystemFont")
	zTipOptionOrigPosTitle:SetPoint("BOTTOMLEFT", "zTipOptionOrigPosX","TOPLEFT",-5,10)
	zTipOptionOrigPosTitle:SetText(self.locStr["Original Position Offsets"])

	-- read options
	zTipOption:LoadOptions()

	-- done
	self.ready = 1
end

function zTipOption:InitButtons()
	self.Buttons = {
		-- Click Butons
		{name="Close",type="Button",inherits="UIPanelCloseButton",
			point="TOPRIGHT",func=function() zTipOption:Hide() end,},
		{name="Reset",type="Button",inherits="UIPanelButtonTemplate2",
			width=50, height=20, text = "Reset",
			point="TOPLEFT",x=5,y=-5,func=zTipOption.Reset},

		-- Check Buttons
		{name="Target",type="CheckButton",var="TargetOfMouse",
			point="TOPLEFT",x=20,y=-35},
		{name="Fade",type="CheckButton",var="Fade",
			point="LEFT",relative="Target",rpoint="RIGHT",x=100,},
		{name="PVPName",type="CheckButton",var="DisplayPvPRank",
			point="TOP",relative="Target",rpoint="BOTTOM",},
		{name="Reputation",type="CheckButton",var="DisplayFaction",
			point="LEFT",relative="PVPName",rpoint="RIGHT",x=100,},
		{name="RealmName",type="CheckButton",var="PlayerServer",
			point="TOP",relative="PVPName",rpoint="BOTTOM",},
		{name="IsPlayer",type="CheckButton",var="ShowIsPlayer",
			point="LEFT",relative="RealmName",rpoint="RIGHT",x=100,},
		{name="ClassIcon",type="CheckButton",var="ClassIcon",
			point="TOP",relative="RealmName",rpoint="BOTTOM",},
		{name="VividMask",type="CheckButton",var="VividMask",
			point="TOP",relative="IsPlayer",rpoint="BOTTOM",
			func = zTipOption.OnVividMaskClicked},
		{name="ShowTalent",type="CheckButton",var="ShowTalent",
			point="TOP",relative="ClassIcon",rpoint="BOTTOM",},
		{name="TargetedBy",type="CheckButton",var="TargetedBy",
			point="TOP",relative="VividMask",rpoint="BOTTOM",},

		-- Sliders
		{name="Scale",type="Slider",min=0.00,max=2.00,step=0.01,width=220,
			var = "Scale", func = zTipOption.OnScaleChanged,
			point="CENTER",relative="IsPlayer",rpoint="BOTTOMLEFT",y=-80},

		-- Check Buttons for AnchorType
		{name="FollowCursor",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="TOP",relative="ClassIcon",rpoint="BOTTOM",y=-110,},
		{name="RootOnTop",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="LEFT",relative="FollowCursor",rpoint="RIGHT",x=100,},
		{name="OnCursorTop",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="TOP",relative="FollowCursor",rpoint="BOTTOM",},
		{name="RightBottom",type="CheckButton",func = zTipOption.OnAnchorChanged,
			point="LEFT",relative="OnCursorTop",rpoint="RIGHT",x=100,},

		-- input box
		{name="OffsetX",type="EditBox",width=32,height=20,var="OffsetX",
			point="TOPLEFT",relative="OnCursorTop",rpoint="BOTTOMLEFT",y=-40},
		{name="OffsetY",type="EditBox",width=32,height=20,var="OffsetY",
			point="LEFT",relative="OffsetX",rpoint="RIGHT",x=105,},
		{name="OrigPosX",type="EditBox",width=32,height=20,var="OrigPosX",
			point="TOP",relative="OffsetX",rpoint="BOTTOM",y=-25,},
		{name="OrigPosY",type="EditBox",width=32,height=20,var="OrigPosY",
			point="LEFT",relative="OrigPosX",rpoint="RIGHT",x=105},
	}

	local button, text, name, value
	for key, value in ipairs(zTipOption.Buttons) do
		-- pre settings
		if value.type == "CheckButton" then
			value.inherits = "UIOptionsCheckButtonTemplate"
		elseif value.type == "Slider" then
			value.inherits = "OptionsSliderTemplate"
		elseif value.type == "EditBox" then
			value.inherits = "InputBoxTemplate"
		end

		-- creations
		button = CreateFrame(value.type, "zTipOption"..value.name, zTipOption, value.inherits)

		if value.type == "CheckButton" then
			text = button:CreateFontString(button:GetName().."Text","ARTWORK","GameFontNormal")
			text:SetPoint("LEFT",button,"RIGHT")
			button:SetFontString(text)
		elseif value.type == "EditBox" then
			text = button:CreateFontString(button:GetName().."Text","ARTWORK","GameFontNormal")
			text:SetPoint("LEFT",button,"RIGHT",5,0)
			button.text = text
		end

		-- setup
		button:SetID(key)
		if value.width then
			button:SetWidth(value.width)
		end
		if value.height then
			button:SetHeight(value.height)
		end
		if value.point then
			if value.relative then
				value.relative = "zTipOption"..value.relative
			end
			button:SetPoint(value.point, value.relative or zTipOption, value.rpoint or value.point, value.x or 0, value.y or 0)
		end
		if value.text then
			if button.text then
				button.text:SetText(value.text)
			else
				button:SetText(value.text)
			end
		end

		-- post settings
		if value.type == "Button" then
			if value.text then button:SetText(value.text) end
			if value.func then button:SetScript("OnClick",value.func) end
		elseif value.type == "CheckButton" then
			if not value.text then button:SetText(self.locStr[value.name]) end
			if value.func then
				button:SetScript("OnClick", value.func)
			else
				button:SetScript("OnClick", zTipOption.OnCheckButtonClicked)
			end
		elseif value.type == "Slider" then
			button.text = _G["zTipOption"..value.name.."Text"]
			if value.text then
				button.title = value.text
			else
				button.title = self.locStr[value.name]
			end
			button.text:SetText(button.title)
			_G["zTipOption"..value.name.."Low"]:SetText(value.min)
			_G["zTipOption"..value.name.."High"]:SetText(value.max)
			button:SetMinMaxValues(value.min, value.max)
			button:SetValueStep(value.step)
			if value.func then button:SetScript("OnValueChanged", value.func) end
		elseif value.type == "EditBox" then
			if not value.text then button.text:SetText(self.locStr[value.name]) end
			if value.func then
				button:SetScript("OnEnterPressed", value.func)
			else
				button:SetScript("OnEnterPressed", zTipOption.OnEditBoxEnterPressed)
			end
		end
	end
end

--[[
	functions
--]]
local value, isChecked
function zTipOption:Reset()
	zTipSaves = zTip:GetDefault()
	zTipOption:LoadOptions()
	GameTooltip:SetScale(zTipSaves.Scale)
end
function zTipOption:OnCheckButtonClicked()
	isChecked = this:GetChecked()
	if isChecked then
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
	end
	value = zTipOption.Buttons[this:GetID()]
	if value.var then
		if isChecked then
			zTipSaves[value.var] = true
		else
			zTipSaves[value.var] = false
		end
	end
end
function zTipOption:OnVividMaskClicked()
	zTipOption:OnCheckButtonClicked()
	if this:GetChecked() then
		zTip:GetVividMask():Show()
	else
		if GameTooltipMask then GameTooltipMask:Hide() end
	end
end
function zTipOption:OnAnchorChanged()
	zTipOption:OnCheckButtonClicked()

	if isChecked and value.name ~= "RightBottom" then
		for i = 0, 2, 1 do
			i = i + zTipOptionFollowCursor:GetID()
			if i ~= this:GetID() then
				_G["zTipOption"..zTipOption.Buttons[i].name]:SetChecked(false)
			end
		end
	end

	local anchor = false
	if zTipOptionFollowCursor:GetChecked() then
		anchor = 0
	end
	if zTipOptionRootOnTop:GetChecked() then
		anchor = 1
	end
	if zTipOptionOnCursorTop:GetChecked() then
		anchor = 2
	end
	if anchor then
		if not zTipOptionRightBottom:GetChecked() then
			anchor = anchor + 3
		end
	else
		zTipOptionRightBottom:SetChecked(false)
	end

	zTipSaves.Anchor = anchor
end
function zTipOption:OnScaleChanged()
	local scale = this:GetValue()
	if scale == 0 then scale = 0.01 end
	zTipSaves.Scale = scale
	GameTooltip:SetScale(scale)
	this.text:SetText(this.title.." : "..math.floor(scale*100).."%")
end
function zTipOption:OnEditBoxEnterPressed()
	local num = this:GetText()
	if not num then return end
	num = tonumber(num)
	if not num then return end
	value = zTipOption.Buttons[this:GetID()]
	zTipSaves[value.var] = num
end
--[[
	read options
--]]
function zTipOption:SetAnchor(followcursor, rootontop, oncursortop, rightbottom)
	zTipOptionFollowCursor:SetChecked(followcursor)
	zTipOptionRootOnTop:SetChecked(rootontop)
	zTipOptionOnCursorTop:SetChecked(oncursortop)
	zTipOptionRightBottom:SetChecked(rightbottom)
end
function zTipOption:LoadOptions()
	local button
	for key, value in ipairs(zTipOption.Buttons) do
		button = _G["zTipOption"..value.name]
		if value.type == "CheckButton" then
			if value.var then
				button:SetChecked(zTipSaves[value.var])
			end
		elseif value.type == "Slider" then
			button:SetValue(zTipSaves[value.var])
		elseif value.type == "EditBox" then
			button:SetText(zTipSaves[value.var])
		end
	end
	-- for anchor
	local anchor = zTipSaves["Anchor"]
	local result = {false,false,false,false}
	if anchor then
		if anchor > 2 then
			anchor = anchor - 3
		else
			result[4] = true
		end
		result[anchor+1] = true
	end
	self:SetAnchor(unpack(result))
end