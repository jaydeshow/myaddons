FOCUSFRAME_OPTIONS_TITLE = GetAddOnMetadata("Hadar_FocusFrame", "Title");
FOCUSFRAME_OPTIONS_SUBTEXT = "These options control the properties of Hadar's Focus Frame.";


function FocusFrame_Options_OnLoad(panel)
	panel.name = "Hadar's Focus Frame";
	panel.okay = FocusFrame_Options_Okay;
	panel.cancel = FocusFrame_Options_Cancel;
	panel.default = FocusFrame_Options_Default;
	
	InterfaceOptions_AddCategory(panel);
end

function FocusFrame_Options_OnVariableLoad()
	--Set Show buffs check box
	FocusFrame_OptionsBuffsCheckButton.currValue = FF_Options.showBuffs;
	FocusFrame_OptionsBuffsCheckButton.value = FF_Options.showBuffs;
	
	--Set friend buff/debuffs options
	FocusFrame_OptionsFriendDropDown.currValue = FF_Options.friend.type;
	FocusFrame_OptionsFriendDropDown.value = FF_Options.friend.type;
				
	--Set enemy buff/debuffs options
	FocusFrame_OptionsEnemyDropDown.currValue = FF_Options.enemy.type;
	FocusFrame_OptionsEnemyDropDown.value = FF_Options.enemy.type;
	
	--Set scale slider
	FocusFrame_OptionsScaleSlider.currValue = FF_Options.scale;
	FocusFrame_OptionsScaleSlider.value = FF_Options.scale;
		
	--Set locked check box
	FocusFrame_OptionsLockCheckButton.currValue = FF_Options.lock;
	FocusFrame_OptionsLockCheckButton.value = FF_Options.lock;
end

function FocusFrame_Options_OnShow()

	--Set Show buffs check box
	FocusFrame_OptionsBuffsCheckButton:SetChecked(FocusFrame_OptionsBuffsCheckButton.value);
	
	--Set friend buff/debuffs options
	UIDropDownMenu_SetSelectedValue(FocusFrame_OptionsFriendDropDown, FocusFrame_OptionsFriendDropDown.value);
		
	--Set enemy buff/debuffs options
	UIDropDownMenu_SetSelectedValue(FocusFrame_OptionsEnemyDropDown, FocusFrame_OptionsEnemyDropDown.value);

	--Set scale slider
	FocusFrame_OptionsScaleSlider:SetValue(FocusFrame_OptionsScaleSlider.value);
	FocusFrame_OptionsScaleSliderText:SetText(FocusFrame_OptionsScaleSlider.value.."%");

	--Set locked check box
	FocusFrame_OptionsLockCheckButton:SetChecked(FocusFrame_OptionsLockCheckButton.value);

end

-------------------
-- Friend Dropdown
-------------------
function FocusFrame_OptionsFriendDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, FocusFrame_OptionsFriendDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, FF_Options.friend.type);
	--this.defaultValue = "debuffs";
	--this.currValue = FF_Options.friend.type;
	--this.value = this.currValue;
	FocusFrame_OptionsFriendDropDown.tooltip = this.value;
	UIDropDownMenu_SetWidth(90, FocusFrame_OptionsFriendDropDown);
	this.SetValue = 
		function (self, value) 
			UIDropDownMenu_SetSelectedValue(self, value);
			FF_Options.friend.type = value;
			FocusFrame_OptionsFriendDropDown.tooltip = value;
		end;
	this.GetValue =
		function (self)
			return UIDropDownMenu_GetSelectedValue(self);
		end
end

function FocusFrame_OptionsFriendDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(FocusFrame_OptionsFriendDropDown, this.value);
	FocusFrame_OptionsFriendDropDown.tooltip = this.value;
	FF_Options.friend.type = this.value;

	FocusFrame_OptionsFriendDropDown.value = FF_Options.friend.type;
end

function FocusFrame_OptionsFriendDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(FocusFrame_OptionsFriendDropDown);
	local info = UIDropDownMenu_CreateInfo();

	info.text = "Buffs";
	info.func = FocusFrame_OptionsFriendDropDown_OnClick;
	info.value = "buffs";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Buffs";
	info.tooltipText = "Show friendly target Buffs";
	UIDropDownMenu_AddButton(info);

	info.text = "Debuffs";
	info.func = FocusFrame_OptionsFriendDropDown_OnClick;
	info.value = "debuffs";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Debuffs";
	info.tooltipText = "Show friendly target Debuffs";
	UIDropDownMenu_AddButton(info);

	info.text = "Dispellable";
	info.func = FocusFrame_OptionsFriendDropDown_OnClick;
	info.value = "dispellable";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Dispellable";
	info.tooltipText = "Show friendly target Dispellable debuffs";
	UIDropDownMenu_AddButton(info);

end

------------------
-- Enemy Dropdown
------------------
function FocusFrame_OptionsEnemyDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, FocusFrame_OptionsEnemyDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, FF_Options.friend.type);
	--this.defaultValue = "debuffs";
	--this.currValue = FF_Options.friend.type;
	--this.value = this.currValue;
	FocusFrame_OptionsEnemyDropDown.tooltip = this.value;
	UIDropDownMenu_SetWidth(90, FocusFrame_OptionsEnemyDropDown);
	this.SetValue = 
		function (self, value) 
			UIDropDownMenu_SetSelectedValue(self, value);
			FF_Options.friend.type = value;
			FocusFrame_OptionsEnemyDropDown.tooltip = value;
		end;
	this.GetValue =
		function (self)
			return UIDropDownMenu_GetSelectedValue(self);
		end
end

function FocusFrame_OptionsEnemyDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(FocusFrame_OptionsEnemyDropDown, this.value);
	FocusFrame_OptionsEnemyDropDown.tooltip = this.value;
	FF_Options.enemy.type = this.value;

	FocusFrame_OptionsEnemyDropDown.value = FF_Options.enemy.type;
end

function FocusFrame_OptionsEnemyDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(FocusFrame_OptionsEnemyDropDown);
	local info = UIDropDownMenu_CreateInfo();

	info.text = "Buffs";
	info.func = FocusFrame_OptionsEnemyDropDown_OnClick;
	info.value = "buffs";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Buffs";
	info.tooltipText = "Show friendly target Buffs";
	UIDropDownMenu_AddButton(info);

	info.text = "Debuffs";
	info.func = FocusFrame_OptionsEnemyDropDown_OnClick;
	info.value = "debuffs";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Debuffs";
	info.tooltipText = "Show friendly target Debuffs";
	UIDropDownMenu_AddButton(info);

	info.text = "Dispellable";
	info.func = FocusFrame_OptionsEnemyDropDown_OnClick;
	info.value = "dispellable";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Dispellable";
	info.tooltipText = "Show friendly target Dispellable debuffs";
	UIDropDownMenu_AddButton(info);

end

----------------------
-- Buffs Check Button
----------------------
function FocusFrame_OptionsBuffsCheckButton_OnClick(checked)
	if (checked) then
		UIDropDownMenu_EnableDropDown(FocusFrame_OptionsFriendDropDown);
		UIDropDownMenu_EnableDropDown(FocusFrame_OptionsEnemyDropDown);
		FF_Options.showBuffs = true;

		FocusFrame_OptionsBuffsCheckButton.value = FF_Options.showBuffs;		
	else
		UIDropDownMenu_DisableDropDown(FocusFrame_OptionsFriendDropDown);
		UIDropDownMenu_DisableDropDown(FocusFrame_OptionsEnemyDropDown);
		
		FF_Options.showBuffs = false;
		focusFrame_HideBuffs();

		FocusFrame_OptionsBuffsCheckButton.value = FF_Options.showBuffs;
	end
end

-----------------
-- Slider change
-----------------
function FocusFrame_OptionsScaleSlider_OnValueChanged()
	FocusFrame_OptionsScaleSliderText:SetText(FocusFrame_OptionsScaleSlider:GetValue().."%");
	FocusMainFrame:SetScale(FocusFrame_OptionsScaleSlider:GetValue()/100);

	FocusFrame_OptionsScaleSlider.value = FocusFrame_OptionsScaleSlider:GetValue();
end

---------------------
-- Lock check button
---------------------
function FocusFrame_OptionsLockCheckButton_OnClick()
	
	FocusMainFrame:SetMovable(not FocusFrame_OptionsLockCheckButton:GetChecked());
	FF_Options.lock = FocusFrame_OptionsLockCheckButton:GetChecked();

	FocusFrame_OptionsLockCheckButton.value = FF_Options.lock;
end

-------------
-- OK button 
-------------
function FocusFrame_Options_Okay()

	--Set Show buffs check box
	FocusFrame_OptionsBuffsCheckButton.currValue = FocusFrame_OptionsBuffsCheckButton.value;
	
	--Set friend buff/debuffs options
	FocusFrame_OptionsFriendDropDown.currValue = FocusFrame_OptionsFriendDropDown.value;
				
	--Set enemy buff/debuffs options
	FocusFrame_OptionsEnemyDropDown.currValue = FocusFrame_OptionsEnemyDropDown.value;
	
	--Set scale slider
	FocusFrame_OptionsScaleSlider.currValue = FocusFrame_OptionsScaleSlider.value;
	
	FF_Options.scale = FocusFrame_OptionsScaleSlider:GetValue();
		
	--Set locked check box
	FocusFrame_OptionsLockCheckButton.currValue = FocusFrame_OptionsLockCheckButton.value;
end

-----------------
-- Cancel button
-----------------
function FocusFrame_Options_Cancel()
	
	--Set Show buffs check box
	FF_Options.showBuffs = FocusFrame_OptionsBuffsCheckButton.currValue;
	FocusFrame_OptionsBuffsCheckButton.value = FocusFrame_OptionsBuffsCheckButton.currValue;

	if (FF_Options.showBuffs) then
		UIDropDownMenu_EnableDropDown(FocusFrame_OptionsFriendDropDown);
		UIDropDownMenu_EnableDropDown(FocusFrame_OptionsEnemyDropDown);
	else
		UIDropDownMenu_DisableDropDown(FocusFrame_OptionsFriendDropDown);
		UIDropDownMenu_DisableDropDown(FocusFrame_OptionsEnemyDropDown);
	end
	
	--Set friend buff/debuffs options
	FF_Options.friend.type = FocusFrame_OptionsFriendDropDown.currValue;
	FocusFrame_OptionsFriendDropDown.value = FocusFrame_OptionsFriendDropDown.currValue;
				
	--Set enemy buff/debuffs options
	FF_Options.enemy.type = FocusFrame_OptionsEnemyDropDown.currValue;
	FocusFrame_OptionsEnemyDropDown.value = FocusFrame_OptionsEnemyDropDown.currValue;
	
	--Set scale slider
	FF_Options.scale = FocusFrame_OptionsScaleSlider.currValue;
	FocusFrame_OptionsScaleSlider.value = FocusFrame_OptionsScaleSlider.currValue;
	
	FocusMainFrame:SetScale(FF_Options.scale/100);
		
	--Set locked check box
	FF_Options.lock = FocusFrame_OptionsLockCheckButton.currValue;
	FocusFrame_OptionsLockCheckButton.value = FocusFrame_OptionsLockCheckButton.currValue;

	FocusMainFrame:SetMovable(not FF_Options.lock);
	
end

------------------
-- Default button
------------------
function FocusFrame_Options_Default()

	FF_Options.scale = 100;
	FF_Options.lock = false;
	FF_Options.showBuffs = true;
	FF_Options.friend.type = "debuffs";
	FF_Options.enemy.type = "debuffs";
	
	--Set Show buffs check box
	FocusFrame_OptionsBuffsCheckButton.currValue = FF_Options.showBuffs;
	FocusFrame_OptionsBuffsCheckButton.value = FF_Options.showBuffs;
	
	--Set friend buff/debuffs options
	FocusFrame_OptionsFriendDropDown.currValue = FF_Options.friend.type;
	FocusFrame_OptionsFriendDropDown.value = FF_Options.friend.type;

	--Set enemy buff/debuffs options
	FocusFrame_OptionsEnemyDropDown.currValue = FF_Options.enemy.type;
	FocusFrame_OptionsEnemyDropDown.value = FF_Options.enemy.type;
		
	-- Enable drop downs
	UIDropDownMenu_EnableDropDown(FocusFrame_OptionsFriendDropDown);
	UIDropDownMenu_EnableDropDown(FocusFrame_OptionsEnemyDropDown);
	
	--Set scale slider
	FocusFrame_OptionsScaleSlider.currValue = FF_Options.scale;
	FocusFrame_OptionsScaleSlider.value = FF_Options.scale;
	
	--Set locked check box
	FocusFrame_OptionsLockCheckButton.currValue = FF_Options.lock;
	FocusFrame_OptionsLockCheckButton.value = FF_Options.lock;

end