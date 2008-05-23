
local Options = CreateFrame('Frame', 'tCDOptionsFrame', UIParent)
local L = TDCOOLDOWN_OPTION_LACALE
local _G = getfenv(0)


function Options:Load()
	self.name = "tdCooldown"

	local font = self:AddFont()
	font:SetPoint('TOPLEFT', 10, -24)

	local display = self:AddDisplay()
	display:SetPoint('BOTTOMLEFT', 10, 10)

	local color = self:AddStyle()
	color:SetPoint('TOPRIGHT', -10, -24)

	InterfaceOptions_AddCategory(self)

	self:LoadBlack()
	self:LoadCenter()
	self:LoadBar()
	self:CreateTypeSet(L.Buff,   "BUFF",   nil,  true, nil)
	self:CreateTypeSet(L.Pet,    "PET",    true, nil,  true)
	self:CreateTypeSet(L.Spell,  "SPELL",  true, nil,  true)
	self:CreateTypeSet(L.Item,   "ITEM",   true, nil,  true)
	self:CreateTypeSet(L.Action, "ACTION", true, nil,  true)
end

local function DropDown_SetSelect(frame, value)
	if frame and frame:IsVisible() and value then
		ToggleDropDownMenu(1, nil, frame)
		UIDropDownMenu_SetSelectedValue(frame, value)
		ToggleDropDownMenu(1, nil, frame)
	end
end

local function DropDown_Init(table)
	local info = UIDropDownMenu_CreateInfo();
	local v
	for _, v in ipairs(table) do
		info.value = v.value
		info.text = v.text or v.value
		info.func = table.dropdown.click
		info.owner = table.dropdown
		info.checked = nil
		UIDropDownMenu_AddButton(info, 1)
	end
end

function Options:CreateTypeSet(name, set, ismin, ispoint, isshine)
	local frame = CreateFrame('Frame', 'tCDOptionsFrame'..set, UIParent)

	local panel = self:CreatePanel(L.Config, frame)
	panel:SetWidth(180); panel:SetHeight(200)
	panel:SetPoint('TOPLEFT', 10, -24)

	local config = self:CreateChecked(L.Config, panel,
		function() this:SetChecked(tCD.db[set].config) end,
		function() tCD.db[set].config = this:GetChecked() end
	)
	config:SetPoint('TOPLEFT', 10, -8)

	local hidecd = self:CreateChecked(L.HideCD, panel,
		function() this:SetChecked(tCD.db[set].hidecooldown) end,
		function() tCD.db[set].hidecooldown = this:GetChecked() end
	)
	hidecd:SetPoint('TOPLEFT', 10, -33)

	local nn, mm
	if ismin then
		nn = L.Min; mm = "min"
	else
		nn = L.Max; mm = "max"
	end
	local minormax = self:CreateInput(nn, panel,
		function() this:SetText(tCD.db[set][mm]) end,
		function()
			local value = this:GetText()
			value = tonumber(value)
			if value then
				tCD.db[set][mm] = value
			else
				this:SetText(tCD.db[set][mm])
			end
			this:ClearFocus()
		end,
		function() this:ClearFocus();this:SetText(tCD.db[set][mm]); end
	)
	minormax:SetPoint('TOPLEFT', 12, -88)

	if ispoint then
		local table = {
			{value = "TOPLEFT", text = L.TOPLEFT},
			{value = "TOP", text = L.TOP},
			{value = "TOPRIGHT", text = L.TOPRIGHT},
			{value = "LEFT", text = L.LEFT},
			{value = "CENTER", text = L.CENTER},
			{value = "RIGHT", text = L.RIGHT},
			{value = "BOTTOMLEFT", text = L.BOTTOMLEFT},
			{value = "BOTTOM", text = L.BOTTOM},
			{value = "BOTTOMRIGHT", text = L.BOTTOMRIGHT},
		}
		local point = self:CreateDropDown(L.Point, panel,
			function() DropDown_SetSelect(this, tCD.db[set].point) end,
			function() tCD.db[set].point = this.value; DropDown_SetSelect(this.owner, this.value) end,
			table
		)
		point:SetPoint("TOPLEFT", -10, -138)
	end
	if isshine then
		panel = self:CreatePanel(L.Shine, frame)
		panel:SetWidth(180); panel:SetHeight(200)
		panel:SetPoint('TOPRIGHT', -10, -24)

		config = self:CreateChecked(L.Config, panel,
			function() this:SetChecked(tCD.db[set].shine) end,
			function() tCD.db[set].shine = this:GetChecked() end
		)
		config:SetPoint('TOPLEFT', 10, -8)

		local scale = self:CreateSlider(L.sScale, panel, 2, 10, 0.2,
			function() this:SetValue(tCD.db[set].scale) end,
			function()
				local value = this:GetValue()
				this.ValText:SetText(format("%.2f", value))
				tCD.db[set].scale = value
			end
		)
		scale:SetPoint("TOPLEFT", 10, -60)

		local time = self:CreateSlider(L.sTime, panel, 0.1, 3, 0.1,
			function() this:SetValue(tCD.db[set].time) end,
			function()
				local value = this:GetValue()
				this.ValText:SetText(format("%.2f", value))
				tCD.db[set].time = value
			end
		)
		time:SetPoint("TOPLEFT", 10, -110)

		local table = {
			{value = 0, text = L.StyleIcon},
			{value = 1, text = L.StyleSystem},
			{value = 2, text = L.StyleRound},
			{value = 3, text = L.StyleExplosive},
			{value = 4, text = L.StyleHeart},
		}
		local style = self:CreateDropDown(L.ShineStyle, panel,
			function() DropDown_SetSelect(this, tCD.db[set].style) end,
			function() tCD.db[set].style = this.value; DropDown_SetSelect(this.owner, this.value) end,
			table
		)
		style:SetPoint("TOPLEFT", -10, -158)
	end

	frame.name = name
	frame.parent = "tdCooldown"
	InterfaceOptions_AddCategory(frame)
end


function Options:CreatePanel(name, parent)
	local panel = CreateFrame('Frame', parent:GetName() .. name, parent, 'OptionFrameBoxTemplate')
	panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	panel:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	_G[panel:GetName() .. 'Title']:SetText(name)

	return panel
end

function Options:CreateDropDown(name, panel, show, click, table)
	local frame = CreateFrame("Frame", panel:GetName()..name, panel, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(140, frame)

	local label = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	label:SetPoint("TOPLEFT",frame,"TOPLEFT",0,20)
	label:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,20)
	label:SetJustifyH("CENTER"); label:SetHeight(18)
	label:SetText(name)

	frame:SetScript("OnShow", show)
	frame.click = click
	table.dropdown = frame
	
	UIDropDownMenu_Initialize(frame, function() DropDown_Init(table) end);

	return frame
end

function Options:CreateInput(name, panel, show, enter, escape)
	local frame = CreateFrame("EditBox", panel:GetName() .. name, panel, "InputBoxTemplate")
	frame:SetAutoFocus(nil) frame:SetWidth(150) frame:SetHeight(20)

	local label = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	label:SetPoint("TOPLEFT",frame,"TOPLEFT",0,20)
	label:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,20)
	label:SetJustifyH("CENTER"); label:SetHeight(18)

	label:SetText(name)
	frame:SetScript("OnShow", show)
	frame:SetScript("OnEscapePressed", escape)
	frame:SetScript("OnEnterPressed", enter)
	frame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
		GameTooltip:SetText(L.InputTip)
		GameTooltip:Show()
	end)
	frame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	frame:Show()

	return frame
end


local function Color_Click()
	if ColorPickerFrame:IsShown() then
		ColorPickerFrame:Hide()
	else
		local r, g, b = this.click()
		ColorPickerFrame.button = this
		ColorPickerFrame.hasOpacity = nil
		ColorPickerFrame.previousValues = {r = r, g = g, b = b}

		ColorPickerFrame.func = this.func
		ColorPickerFrame.cancelFunc = this.cancel

		ColorPickerFrame:SetColorRGB(r, g, b)
		
		ShowUIPanel(ColorPickerFrame)
	end
end

function Options:CreateColor(name, panel, show, click, func, cancel)
	local frame = CreateFrame('Button', panel:GetName() .. name, panel)
	frame:SetWidth(16); frame:SetHeight(16)
	frame:SetNormalTexture('Interface/ChatFrame/ChatFrameColorSwatch')

	local bg = frame:CreateTexture(nil, 'BACKGROUND')
	bg:SetWidth(14); bg:SetHeight(14)
	bg:SetTexture(1, 1, 1)
	bg:SetPoint('CENTER')

	frame.click = click
	frame.func = func
	frame.cancel = cancel

	frame:RegisterForClicks("LeftButtonUp")
	frame:SetScript('OnClick', Color_Click)
	frame:SetScript('OnShow', show)

	return frame
end

function Options:CreateChecked(name, panel, show, click)
	local frame = CreateFrame("CheckButton", panel:GetName()..name, panel, "OptionsCheckButtonTemplate")
	local label = frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
	label:SetPoint("LEFT",frame,"RIGHT")

	label:SetText(name)
	frame:SetFontString(label)
	frame:SetScript("OnClick", click)
	frame:SetScript("OnShow", show)

	return frame
end

function Options:CreateSlider(name, panel, minValue, maxValue, step, show, changed)
	local panelname = panel:GetName()
	local frame = CreateFrame("Slider", panelname .. name, panel, "OptionsSliderTemplate")
	frame:SetMinMaxValues(minValue, maxValue); frame:SetValueStep(step)
	_G[panelname..name.."Low"]:SetText(minValue)
	_G[panelname..name.."High"]:SetText(maxValue)
	_G[panelname..name.."Text"]:SetText(name)

	local label = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	label:SetPoint("BOTTOM",frame,"BOTTOM",0,-10)
	label:SetJustifyH("CENTER");

	frame.ValText = label
	frame:SetScript("OnShow", show)
	frame:SetScript("OnValueChanged", changed)

	return frame
end

function Options:AddDisplay()
	local panel = self:CreatePanel(L.Display, self)
	panel:SetWidth(180); panel:SetHeight(200)

	local mmss = self:CreateChecked(L.Long, panel,
		function() this:SetChecked(tCD.db.long) end,
		function() tCD.db.long = this:GetChecked() end
	)
	mmss:SetPoint('TOPLEFT', 10, -8)

	return panel
end

function Options:AddFont()
	local panel = self:CreatePanel(L.Font, self)
	panel:SetWidth(180); panel:SetHeight(156)

	local font = self:CreateInput(L.File, panel,
		function() this:SetText(tCD.db.font); end,
		function()
			tCD.db.font = tCD:TestFont(this:GetText())
			this:SetText(tCD.db.font)
			this:ClearFocus()
		end,
		function() this:ClearFocus();this:SetText(tCD.db.font); end
	)
	font:SetPoint('TOPLEFT', 12, -28)

	local size = self:CreateSlider(L.Size, panel, 5, 36, 1,
	function() this:SetValue(tCD.db.size) end,
	function()
		local value = this:GetValue()
		this.ValText:SetText(value)
		tCD.db.size = value
	end)
	size:SetPoint("TOPLEFT", 10, -80)

	return panel
end

local n = 0
function Options:CreateColorAddSlider(name, panel, set)
	local slider = self:CreateSlider(name, panel, 0.5, 1.5, 0.01,
		function() this:SetValue(tCD.db.style[set].s) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(format("%.2f", value))
			tCD.db.style[set].s = value
		end
	)
	slider:SetPoint("TOPLEFT", 10, (-50 * n) -30)

	local color = self:CreateColor(name, panel,
		function() local color = tCD.db.style[set]; this:GetNormalTexture():SetVertexColor(color.r, color.g, color.b) end,
		function() local color = tCD.db.style[set]; return color.r, color.g, color.b end,
		function()
			local r, g, b = ColorPickerFrame:GetColorRGB()
			tCD.db.style[set].r = r
			tCD.db.style[set].g = g
			tCD.db.style[set].b = b
			ColorPickerFrame.button:GetNormalTexture():SetVertexColor(r, g, b)
		end,
		function()
			local color = ColorPickerFrame.previousValues;
			tCD.db.style[set].r = color.r
			tCD.db.style[set].g = color.g
			tCD.db.style[set].b = color.b
			ColorPickerFrame.button:GetNormalTexture():SetVertexColor(color.r, color.g, color.b)
		end
	)
	color:SetPoint("LEFT", slider, "RIGHT", 5, 0)
	n = n + 1
end

function Options:AddStyle()
	local panel = self:CreatePanel(L.Color, self)
	panel:SetWidth(180); panel:SetHeight(374)

	self:CreateColorAddSlider(DAYS, panel, "days")
	self:CreateColorAddSlider(HOURS, panel, "hrs")
	self:CreateColorAddSlider(MINUTES, panel, "mins")
	self:CreateColorAddSlider(SECONDS, panel, "secs")
	self:CreateColorAddSlider(L.Short, panel, "short")

	return panel
end

function Options:LoadBar()
	local frame = CreateFrame('Frame', 'tCDOptionsFrameBar', UIParent)

	local panel = self:CreatePanel(L.Bar, frame)
	panel:SetWidth(180); panel:SetHeight(374)
	panel:SetPoint('TOPLEFT', 10, -24)

	local lock = self:CreateChecked(L.Locked, panel, 
		function() this:SetChecked(tCD.db.bar.locked) end, 
		function() tCD.db.bar.locked = this:GetChecked()
			Options:UpdateBar() end
	)
	lock:SetPoint('TOPLEFT', 10, -8)
	local hidden = self:CreateChecked(L.Hidden, panel, 
		function() this:SetChecked(tCD.db.bar.hidden) end,  
		function() tCD.db.bar.hidden = this:GetChecked()
			Options:UpdateBar() end
	)
	hidden:SetPoint('TOPLEFT', 10, -38)
	local reverse = self:CreateChecked(L.Reverse, panel, 
		function() this:SetChecked(tCD.db.bar.reverse) end, 
		function() tCD.db.bar.reverse = this:GetChecked()
			Options:UpdateBar() end
	)
	reverse:SetPoint('TOPLEFT', 10, -68)
	local sound = self:CreateChecked(L.Sound, panel, 
		function() this:SetChecked(tCD.db.bar.sound) end, 
		function() tCD.db.bar.sound = this:GetChecked()
			Options:UpdateBar() end
	)
	sound:SetPoint('TOPLEFT', 10, -98)

	panel = self:CreatePanel(L.Style, frame)
	panel:SetWidth(180); panel:SetHeight(374)
	panel:SetPoint('TOPRIGHT', -10, -24)
	local width = self:CreateSlider(L.bWidth, panel, 50, 200, 1,
		function() this:SetValue(tCD.db.bar.width) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.bar.width = value
			Options:UpdateBar()
		end
	)
	width:SetPoint("TOPLEFT", 10, -25)

	local height = self:CreateSlider(L.bHeight, panel, 10, 50, 1,
		function() this:SetValue(tCD.db.bar.height) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.bar.height = value
			Options:UpdateBar()
		end
	)
	height:SetPoint("TOPLEFT", 10, -75)

	local spacing = self:CreateSlider(L.bSpacing, panel, 0, 20, 1,
		function() this:SetValue(tCD.db.bar.spacing) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.bar.spacing = value
			Options:UpdateBar()
		end
	)
	spacing:SetPoint("TOPLEFT", 10, -125)

	local alpha = self:CreateSlider(L.bAlpha, panel, 0, 1, 0.1,
		function() this:SetValue(tCD.db.bar.alpha) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(format("%.2f", value))
			tCD.db.bar.alpha = value
			Options:UpdateBar()
		end
	)
	alpha:SetPoint("TOPLEFT", 10, -175)

	local size = self:CreateSlider(L.Size, panel, 9, 40, 1,
		function() this:SetValue(tCD.db.bar.size) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.bar.size = value
			Options:UpdateBar()
		end
	)
	size:SetPoint("TOPLEFT", 10, -225)

	frame.name = L.Bar
	frame.parent = "tdCooldown"
	InterfaceOptions_AddCategory(frame)
end

function Options:UpdateBar()
	local font, size, mode = GameFontNormalSmall:GetFont()
	local bar, p, r, y
	if tCD.db.bar.reverse then
		p = "BOTTOMLEFT"; r = "TOPLEFT"; y = tCD.db.bar.spacing
	else
		p = "TOPLEFT"; r = "BOTTOMLEFT"; y = - tCD.db.bar.spacing
	end
	if tCD.db.bar.locked then
		tCDBar0:Hide()
	else
		tCDBar0:Show()
	end
	local i = 1
	while true do
		bar = _G["tCDBar"..i]
		if not bar then
			break
		elseif tCD.db.bar.hidden then
			bar:Hide()
		end
		bar:SetAlpha(tCD.db.bar.alpha)
		bar:SetWidth(tCD.db.bar.width)
		bar:SetHeight(tCD.db.bar.height)
		bar.Name:SetWidth(tCD.db.bar.width)
		bar.Name:SetHeight(tCD.db.bar.height)
		bar.Name:SetFont(font, tCD.db.bar.size, mode)
		bar.Timer:SetFont(font, tCD.db.bar.size, mode)
		bar.Icon:SetWidth(tCD.db.bar.height)
		bar.Icon:SetHeight(tCD.db.bar.height)
		bar:ClearAllPoints()
		bar:SetPoint(p, _G["tCDBar"..(i-1)], r, 0, y)
		i = i + 1
	end

	if self.move and self.move:IsVisible() then
		self.move:SetWidth(tCD.db.center.width)
		self.move:SetHeight(tCD.db.center.width)
	end
	tCD:TestAllCooling()
end


function Options:LoadCenter()
	local frame = CreateFrame('Frame', 'tCDOptionsFrameCenter', UIParent)
	local panel = self:CreatePanel(L.Center, frame)
	panel:SetWidth(180); panel:SetHeight(374)
	panel:SetPoint('TOPLEFT', 10, -24)

	local center = self:CreateChecked(L.Center, panel, 
		function() this:SetChecked(tCD.db.center.config) end, 
		function() tCD.db.center.config = this:GetChecked()
			Options:UpdateBar() end
	)
	center:SetPoint('TOPLEFT', 10, -8)
	local mode = self:CreateChecked(L.HighLight, panel, 
		function() this:SetChecked(tCD.db.center.mode) end,  
		function() tCD.db.center.mode = this:GetChecked()
			Options:UpdateBar() end
	)
	mode:SetPoint('TOPLEFT', 10, -38)
	local text = self:CreateChecked(L.Text, panel, 
		function() this:SetChecked(tCD.db.center.text) end, 
		function() tCD.db.center.text = this:GetChecked()
			Options:UpdateBar() end
	)
	text:SetPoint('TOPLEFT', 10, -68)
	local sct = self:CreateChecked(L.Sct, panel, 
		function() this:SetChecked(tCD.db.center.sct) end, 
		function() tCD.db.center.sct = this:GetChecked()
			Options:UpdateBar() end
	)
	sct:SetPoint('TOPLEFT', 10, -98)

	local move = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
	move:SetWidth(80) move:SetHeight(26) move:SetText(L.MoveCenter)
	move:SetPoint("BOTTOMLEFT", 10, 14)
	move:SetScript("OnClick", function() Options:CenterMove() end)

	panel = self:CreatePanel(L.Style, frame)
	panel:SetWidth(180); panel:SetHeight(374)
	panel:SetPoint('TOPRIGHT', -10, -24)
	local width = self:CreateSlider(L.cWidth, panel, 50, 200, 1,
		function() this:SetValue(tCD.db.center.width) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.center.width = value
			Options:UpdateBar()
		end
	)
	width:SetPoint("TOPLEFT", 10, -25)

	local alpha = self:CreateSlider(L.cAlpha, panel, 0, 1, 0.1,
		function() this:SetValue(tCD.db.center.alpha) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(format("%.2f", value))
			tCD.db.center.alpha = value
			Options:UpdateBar()
		end
	)
	alpha:SetPoint("TOPLEFT", 10, -75)

	local time = self:CreateSlider(L.cTime, panel, 0, 3, 0.1,
		function() this:SetValue(tCD.db.center.time) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(format("%.2f", value))
			tCD.db.center.time = value
			Options:UpdateBar()
		end
	)
	time:SetPoint("TOPLEFT", 10, -125)

	local size = self:CreateSlider(L.cSize, panel, 10, 50, 1,
		function() this:SetValue(tCD.db.center.size) end,
		function()
			local value = this:GetValue()
			this.ValText:SetText(value)
			tCD.db.center.size = value
			Options:UpdateBar()
		end
	)
	size:SetPoint("TOPLEFT", 10, -175)


	frame.name = L.Center
	frame.parent = "tdCooldown"
	InterfaceOptions_AddCategory(frame)
end

local function UpdateBlackList()
	local value = tCDOptionsFrameBlack.slider:GetValue()
	local button, spell
	local list = {}
	local j = 1
	for spell, _ in pairs(tCDblackData) do
		tinsert(list, spell)
	end
	for i = value * tCDOptionsFrameBlack.maxcheck + 1, (value + 1) * tCDOptionsFrameBlack.maxcheck do
		button = tCDOptionsFrameBlack.button[j]
		button:SetChecked(nil)
		if list[i] then
			button.index = i
			button:SetText(list[i])
			button:Enable()
		else
			button.index = nil
			button:SetText("")
			button:Disable()
		end
		j = j + 1
	end
end
local function LoadBlackList()
	local spell
	local i = 0
	for spell, _ in pairs(tCDblackData) do
		i = i + 1	
	end
	tCDOptionsFrameBlack.slider:SetMinMaxValues(0, max(0, ceil(i / tCDOptionsFrameBlack.maxcheck) - 1))
	tCDOptionsFrameBlack.slider:SetValue(0)
	UpdateBlackList()
end
local function AddBlack()
	local value = tCDOptionsFrameBlack.edit:GetText()
	tCDOptionsFrameBlack.edit:ClearFocus()
	tCDOptionsFrameBlack.edit:SetText("")
	if value and value ~= "" then
		tCDblackData[value] = true
	end
	LoadBlackList()
end
local function DeleteBlack()
	local button
	for i = 1, tCDOptionsFrameBlack.maxcheck do
		button = tCDOptionsFrameBlack.button[i]
		if button:GetChecked() and button:GetText() then
			tCDblackData[button:GetText()] = nil
		end
	end
	LoadBlackList()
end
function Options:LoadBlack()
	local frame = CreateFrame('Frame', 'tCDOptionsFrameBlack', UIParent)
	local panel = self:CreatePanel(L.Black, frame)
	panel:SetWidth(367); panel:SetHeight(374)
	panel:SetPoint('TOPLEFT', 10, -24)

	frame:SetScript("OnShow", LoadBlackList)

	local i, button
	frame.button = {}
	frame.maxcheck = 14
	for i = 1, frame.maxcheck do
		button = CreateFrame("CheckButton", nil, frame, "OptionsCheckButtonTemplate")
		if i == 1 then
			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -30)
		else
			button:SetPoint("TOPLEFT", frame.button[i-1], "BOTTOMLEFT", 0, 8)
		end
		local text = button:CreateFontString(nil,"ARTWORK","GameFontNormal")
		text:SetPoint("LEFT",button,"RIGHT")
		button:SetFontString(text)

		button:EnableMouseWheel(true)
		button:SetScript("OnMouseWheel", function()
			local value = tCDOptionBlackSlider:GetValue()
			local minV, maxV = tCDOptionBlackSlider:GetMinMaxValues()
			if arg1 < 0 then
				if value < maxV then
					tCDOptionBlackSlider:SetValue(value + 1)
				end
			else
				if value > minV then
					tCDOptionBlackSlider:SetValue(value - 1)
				end
			end
		end)

		frame.button[i] = button
	end
	local slider = CreateFrame("Slider", "tCDOptionBlackSlider", frame, "OptionsSliderTemplate")
	slider:SetOrientation('VERTICAL')
	slider:SetWidth(10)
	slider:SetHeight(200)
	slider:ClearAllPoints()
	slider:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-20,-30)
	slider:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-20,40)
	slider:SetValueStep(1)
	slider:SetScript("OnValueChanged", UpdateBlackList)
	tCDOptionBlackSliderLow:SetText("")
	tCDOptionBlackSliderHigh:SetText("")
	frame.slider = slider

	local update = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	update:SetWidth(40)
	update:SetHeight(26)
	update:SetText(L.Update)
	update:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 15)
	update:SetScript("OnClick", LoadBlackList)

	local delete = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	delete:SetWidth(40)
	delete:SetHeight(26)
	delete:SetText(DELETE)
	delete:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 15)
	delete:SetScript("OnClick", DeleteBlack)

	local add = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	add:SetWidth(40)
	add:SetHeight(26)
	add:SetText(ADD)
	add:SetPoint("RIGHT", delete, "LEFT", 0, 0)
	add:SetScript("OnClick", AddBlack)

	local edit = CreateFrame("EditBox",nil, frame, "InputBoxTemplate")
	edit:SetPoint("TOPLEFT", update, "TOPRIGHT", 5, 0)
	edit:SetPoint("BOTTOMRIGHT", add, "BOTTOMLEFT", -1, 0)
	edit:SetAutoFocus(nil)
	frame.edit = edit

	frame.name = L.Black
	frame.parent = "tdCooldown"
	InterfaceOptions_AddCategory(frame)
end

function Options:CenterMove()
	if self.move and self.move:IsVisible() then
		self.move:Hide()
	else
		if not self.move then
			local move = CreateFrame("Frame",nil,InterfaceOptionsFrame)
			move:SetClampedToScreen(true) move:EnableMouse(true)
			move:SetToplevel(true) move:SetMovable(true)
			move:RegisterForDrag("LeftButton")
			move:SetScript("OnDragStart",function() this:StartMoving() end)
			move:SetScript("OnDragStop",function()
				this:StopMovingOrSizing();
				local p,_,r,x,y = this:GetPoint()
				tCD.db.center.p = p
				tCD.db.center.r = r
				tCD.db.center.x = x
				tCD.db.center.y = y
			end)
			move.texture = move:CreateTexture(nil,"ARTWORK")
			move.texture:SetAllPoints(move)
			move.texture:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_01")
			self.move = move
		end

		self.move:SetWidth(tCD.db.center.width);
		self.move:SetHeight(tCD.db.center.width);
		self.move:ClearAllPoints()
		self.move:SetPoint(tCD.db.center.p, UIParent,tCD.db.center.r, tCD.db.center.x, tCD.db.center.y)

		self.move:Show()
	end
end

Options:Load()