
local L = TDITEMTIP_LOCALE

local option = tdItemTip
option:Hide()

local function Load()
	local function OnClick(self)
		if self.disable then
			self:SetChecked(nil)
		else
			tdItemTipDB[self.var] = self:GetChecked() and true or nil
		end
	end

	local function OnShow(self)
		self:SetChecked(tdItemTipDB[self.var])
	end

	local function OnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(L.disable)
		option:TestAddOn(self.loaded, self.unloaded,
			function(i, addon) GameTooltip:AddLine(L.loaded..addon) end,
			function(i, addon) GameTooltip:AddLine(L.unloaded..addon) end
		)
		GameTooltip:Show()
	end

	local function OnLeave() GameTooltip:Hide() end

	local function CreateCheck(var, num, move, loaded, unloaded)
		local frame = CreateFrame("CheckButton", nil, option, "OptionsCheckButtonTemplate")
		local label = frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
		label:SetPoint("LEFT",frame,"RIGHT")
		label:SetText(L[var])

		frame:SetFontString(label)
		frame:SetScript("OnClick", OnClick)
		frame:SetScript("OnShow", OnShow)
		frame:SetPoint("TOPLEFT", 10 + (move or 0) * 30, - 10 - (num - 1) * 26)
		frame.var = var
		frame.loaded = loaded
		frame.unloaded = unloaded
		if option:TestAddOn(loaded, unloaded) then
			frame.disable = true
			frame:SetScript("OnEnter", OnEnter)
			frame:SetScript("OnLeave", OnLeave)
		end
		OnShow(frame)
		return frame
	end

	local frame
	for i, v in ipairs(option.buttons) do
		frame = CreateCheck(v.var, i, v.move, v.loaded, v.unloaded)
	end

	local dropdown = CreateFrame("Frame", "tdItemTipOptionSVStyleDropDown", option, "UIDropDownMenuTemplate")
	local function MenuOnClick()
		tdItemTipDB.svstyle = this.value
		UIDropDownMenu_SetSelectedValue(dropdown, this.value)
	end
	local menuList = {"Blizzard", "Compact", "Short"}
	local function Init()
		local info = {}
		for i, v in pairs(menuList) do
			info.text = format(L.style, v)
			info.value = i
			info.checked = nil
			info.func = MenuOnClick
			UIDropDownMenu_AddButton(info, 1)
		end
	end
	UIDropDownMenu_Initialize(dropdown, Init);
	dropdown:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 10, 0)
	UIDropDownMenu_SetWidth(190,dropdown)
	UIDropDownMenu_SetSelectedValue(dropdown, tdItemTipDB.svstyle)
	option:SetScript("OnShow", nil)
end

option:SetScript("OnShow", Load)
option.name = "tdItemTip"
InterfaceOptions_AddCategory(option)