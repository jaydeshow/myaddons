------------------------------------------------
--Icetip GUI
--描述: wow提示增强插件.GUI设置模块
--作者: 月色狼影
--$Rev: 1046 $
--$Id: GUIframe.lua 1046 2008-04-09 06:27:30Z wolftankk $
------------------------------------------------
local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i
local L = IceLocal

ICETIP_ANCHOR_TABLE = {
	L.AnchorSet1,
	L.AnchorSet2,
	L.AnchorSet3,
	L.AnchorSet4,
	L.AnchorSet5,
	L.AnchorSet6,
	L.AnchorSet7
}

ICETIP_ANCHOR_VALUE = {
	false,
	0,
	1,
	2,
	3,
	4,
	5,
}

do
	local temp;
	Icetip_OptionsFrame = CreateFrame("Frame", "Icetip_OptionsFrame", UIParent);
	Icetip_OptionsFrame:Hide();
	Icetip_OptionsFrame:SetWidth(300);
	Icetip_OptionsFrame:SetHeight(410);
	Icetip_OptionsFrame:SetFrameStrata("DIALOG");

	temp = Icetip_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	temp:SetPoint("TOPLEFT", 16, -16);
	temp:SetText(L.IcetipTittle);

	--启用3D模式
	CreateFrame("CheckButton","Icetip_OptionsFrame_Mask", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Mask:SetPoint("TOPLEFT", 16, -35);
	Icetip_OptionsFrame_Mask:SetHitRectInsets(0, -120, 0, 0);
	Icetip_OptionsFrame_MaskText:SetText(L.ViviMask);
	Icetip_OptionsFrame_Mask:SetScript("OnClick", function(self)
		if IcetipDB.VividMask then
			IcetipDB.VividMask = false;
			Icetip:GetVVMask():Hide()
		else
			IcetipDB.VividMask = true;
			Icetip:GetVVMask():Show()
		end
		self:SetChecked(IcetipDB.VividMask)
	end)

	--天赋
	CreateFrame("CheckButton","Icetip_OptionsFrame_Talent", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Talent:SetPoint("TOPLEFT", 180, -35);
	Icetip_OptionsFrame_Talent:SetHitRectInsets(0, -120, 0, 0);
	Icetip_OptionsFrame_TalentText:SetText(L.DisTalent);
	Icetip_OptionsFrame_Talent:SetScript("OnClick", function(self)
		if IcetipDB.Talented then
			IcetipDB.Talented = false;
		else
			IcetipDB.Talented = true;
		end
		self:SetChecked(IcetipDB.Talented)
	end)

	--声望
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Faction", Icetip_OptionsFrame,"InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Faction:SetPoint("TOPLEFT", 16, -57);
	Icetip_OptionsFrame_Faction:SetHitRectInsets(0, -120, 0, 0);
	Icetip_OptionsFrame_FactionText:SetText(L.DisFaction);
	Icetip_OptionsFrame_Faction:SetScript("OnClick", function(self)
		if IcetipDB.DisFaction then
			IcetipDB.DisFaction = false;
		else
			IcetipDB.DisFaction = true;
		end
		self:SetChecked(IcetipDB.DisFaction);
	end);

	--目标
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Target", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Target:SetPoint("TOPLEFT", 180, -57);
	Icetip_OptionsFrame_Target:SetHitRectInsets(0, -130, 0, 0);
	Icetip_OptionsFrame_TargetText:SetText(L.DisUnitTarget);
	Icetip_OptionsFrame_Target:SetScript("OnClick", function(self)
		if IcetipDB.DisTarget then
			IcetipDB.DisTarget = false;
		else
			IcetipDB.DisTarget = true;
		end
		self:SetChecked(IcetipDB.DisTarget);
	end)

	--显示性别
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Sex", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Sex:SetPoint("TOPLEFT", 16, -79);
	Icetip_OptionsFrame_Sex:SetHitRectInsets(0, -120, 0, 0);
	Icetip_OptionsFrame_SexText:SetText(L.ShowNickname);
	Icetip_OptionsFrame_Sex:SetScript("OnClick", function(self)
		if IcetipDB.SexName then
			IcetipDB.SexName = false;
		else
			IcetipDB.SexName = true;
		end
		self:SetChecked(IcetipDB.SexName);
	end)

	--显示军衔
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Rank", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Rank:SetPoint("TOPLEFT", 180, -79);
	Icetip_OptionsFrame_Rank:SetHitRectInsets(0, -130, 0, 0);
	Icetip_OptionsFrame_RankText:SetText(L.DisPlayerRank);
	Icetip_OptionsFrame_Rank:SetScript("OnClick", function(self)
		if IcetipDB.DisPvpRank then
			IcetipDB.DisPvpRank = false;
		else
			IcetipDB.DisPvpRank = true;
		end
		self:SetChecked(IcetipDB.DisPvpRank);
	end)

	--渐隐
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Fade", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Fade:SetPoint("TOPLEFT", 16, -101);
	Icetip_OptionsFrame_Fade:SetHitRectInsets(0, -300, 0, 0);
	Icetip_OptionsFrame_FadeText:SetText(L.SetFadeOut);
	Icetip_OptionsFrame_Fade:SetScript("OnClick", function(self)
		if IcetipDB.Fade then
			IcetipDB.Fade = false;
		else
			IcetipDB.Fade = true;
		end
		self:SetChecked(IcetipDB.Fade);
	end)

	--职业图标
	CreateFrame("CheckButton", "Icetip_OptionsFrame_ClassFlag", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_ClassFlag:SetPoint("TOPLEFT", 16, -123);
	Icetip_OptionsFrame_ClassFlag:SetHitRectInsets(0, -300, 0, 0);
	Icetip_OptionsFrame_ClassFlagText:SetText(L.DisClassFlag);
	Icetip_OptionsFrame_ClassFlag:SetScript("OnClick", function(self)
		if IcetipDB.DisClass then
			IcetipDB.DisClass = false;
		else
			IcetipDB.DisClass = true;
		end
		self:SetChecked(IcetipDB.DisClass);
	end)

	--服务器+22
	CreateFrame("CheckButton", "Icetip_OptionsFrame_Server", Icetip_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	Icetip_OptionsFrame_Server:SetPoint("TOPLEFT", 16, -145);
	Icetip_OptionsFrame_Server:SetHitRectInsets(0, -300, 0, 0);
	Icetip_OptionsFrame_ServerText:SetText(L.DisPlayerSer);
	Icetip_OptionsFrame_Server:SetScript("OnClick", function(self)
		if IcetipDB.Server then
			IcetipDB.Server = false;
		else
			IcetipDB.Server = true;
		end
		self:SetChecked(IcetipDB.Server);
	end)

	--调整Gametooltip缩放+43
	CreateFrame("Slider", "Icetip_OptionsFrame_Scale", Icetip_OptionsFrame, "InterfaceOptionsSliderTemplate");
	Icetip_OptionsFrame_Scale:SetWidth(335);
	Icetip_OptionsFrame_Scale:SetHeight(16);
	Icetip_OptionsFrame_Scale:SetPoint("TOPLEFT", 25, -185);
	Icetip_OptionsFrame_ScaleText:SetText(L.SetTipScale);
	Icetip_OptionsFrame_ScaleLow:SetText("50%");
	Icetip_OptionsFrame_ScaleHigh:SetText("200%");
	Icetip_OptionsFrame_Scale:SetMinMaxValues(50, 200);
	Icetip_OptionsFrame_Scale:SetValueStep(1);
	Icetip_OptionsFrame_Scale:SetScript("OnValueChanged", function(self, value)
		Icetip_OptionsFrame_ScaleText:SetText(L.SetTipScale..value.."%");
		IcetipDB.Scale = value/100;
		GameTooltip:SetScale(IcetipDB.Scale);
		
	end)

	--选择显示位置 下拉菜单+45
	CreateFrame("Frame", "Icetip_OptionsFrame_AnchorDropDown", Icetip_OptionsFrame, "UIDropDownMenuTemplate");
	Icetip_OptionsFrame_AnchorDropDown:SetPoint("TOPLEFT", 25, -230);
	Icetip_OptionsFrame_AnchorDropDown:SetHitRectInsets(16, 16, 0, 0);
	UIDropDownMenu_SetWidth(300, Icetip_OptionsFrame_AnchorDropDown);
	UIDropDownMenu_EnableDropDown(Icetip_OptionsFrame_AnchorDropDown);
	Icetip_OptionsFrame_AnchorDropDown:CreateFontString("Icetip_OptionsFrame_AnchorDropDownLabel", "BACKGROUND", "GameFontNormalSmall");
	Icetip_OptionsFrame_AnchorDropDownLabel:SetPoint("BOTTOMLEFT", Icetip_OptionsFrame_AnchorDropDown, "TOPLEFT", 21, 1);
	Icetip_OptionsFrame_AnchorDropDownLabel:SetText(L.SetAnchor);
	Icetip_OptionsFrame_AnchorDropDown:SetID(1);
	UIDropDownMenu_SetSelectedID(Icetip_OptionsFrame_AnchorDropDown, 1);


	--设置位置偏移
	CreateFrame("Frame", "Icetip_OptionsFrame_Panel", Icetip_OptionsFrame, "OptionFrameBoxTemplate")
	Icetip_OptionsFrame_Panel:SetPoint("TOPLEFT", 16 , -280)
	Icetip_OptionsFrame_Panel:SetWidth(355)
	Icetip_OptionsFrame_Panel:SetHeight(118)
	Icetip_OptionsFrame_Panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	Icetip_OptionsFrame_Panel:SetBackdropColor(0.15, 0.15, 0.15)
	Icetip_OptionsFrame_PanelTitle:SetText(L.SetOffset)

		--offset X
		CreateFrame("Slider", "Icetip_OptionsFrame_OSX", Icetip_OptionsFrame_Panel, "InterfaceOptionsSliderTemplate");
		Icetip_OptionsFrame_OSX:SetWidth(140);
		Icetip_OptionsFrame_OSX:SetHeight(16);
		Icetip_OptionsFrame_OSX:SetPoint("TOPLEFT", 14, -23);
		Icetip_OptionsFrame_OSXText:SetText(L.SetOffsetX);
		Icetip_OptionsFrame_OSXLow:SetText(-500);
		Icetip_OptionsFrame_OSXHigh:SetText(500);
		Icetip_OptionsFrame_OSX:SetMinMaxValues(-500, 500);
		Icetip_OptionsFrame_OSX:SetValueStep(1);
		Icetip_OptionsFrame_OSX:SetScript("OnValueChanged", function(self, value)
				Icetip_OptionsFrame_OSXText:SetText(L.SetOffsetX..value);
				IcetipDB.OffsetX = value;		
		end)

		--Offset Y
		CreateFrame("Slider", "Icetip_OptionsFrame_OSY", Icetip_OptionsFrame_Panel, "InterfaceOptionsSliderTemplate");
		Icetip_OptionsFrame_OSY:SetWidth(140);
		Icetip_OptionsFrame_OSY:SetHeight(16);
		Icetip_OptionsFrame_OSY:SetPoint("TOPRIGHT", -15, -23);
		Icetip_OptionsFrame_OSYText:SetText(L.SetOffsetY);
		Icetip_OptionsFrame_OSYLow:SetText(-500);
		Icetip_OptionsFrame_OSYHigh:SetText(500);
		Icetip_OptionsFrame_OSY:SetMinMaxValues(-500, 500);
		Icetip_OptionsFrame_OSY:SetValueStep(1);
		Icetip_OptionsFrame_OSY:SetScript("OnValueChanged", function(self, value)
				Icetip_OptionsFrame_OSYText:SetText(L.SetOffsetY..value);
				IcetipDB.OffsetY = value;		
		end)

		--OriOffset X
			--Add OrigPoxX
		CreateFrame("Slider", "Icetip_OptionsFrame_SliderOrX", Icetip_OptionsFrame_Panel, "InterfaceOptionsSliderTemplate");
		Icetip_OptionsFrame_SliderOrX:SetWidth(140);
		Icetip_OptionsFrame_SliderOrX:SetHeight(16);
		Icetip_OptionsFrame_SliderOrX:SetPoint("TOPLEFT", 14, -72);
		Icetip_OptionsFrame_SliderOrXText:SetText(L.SetOrgiX);
		Icetip_OptionsFrame_SliderOrXLow:SetText(-500);
		Icetip_OptionsFrame_SliderOrXHigh:SetText(500);
		Icetip_OptionsFrame_SliderOrX:SetMinMaxValues(-500, 500);
		Icetip_OptionsFrame_SliderOrX:SetValueStep(1);
		Icetip_OptionsFrame_SliderOrX:SetScript("OnValueChanged", function(self, value)
				Icetip_OptionsFrame_SliderOrXText:SetText(L.SetOrgiX..value)
				IcetipDB.OrigPosX = value;		
		end)

		CreateFrame("Slider", "Icetip_OptionsFrame_SliderOrY", Icetip_OptionsFrame_Panel, "InterfaceOptionsSliderTemplate");
		Icetip_OptionsFrame_SliderOrY:SetWidth(140);
		Icetip_OptionsFrame_SliderOrY:SetHeight(16);
		Icetip_OptionsFrame_SliderOrY:SetPoint("TOPRIGHT", -15, -72);
		Icetip_OptionsFrame_SliderOrYText:SetText(L.SetOrgiY);
		Icetip_OptionsFrame_SliderOrYLow:SetText(-500);
		Icetip_OptionsFrame_SliderOrYHigh:SetText(500);
		Icetip_OptionsFrame_SliderOrY:SetMinMaxValues(-500, 500);
		Icetip_OptionsFrame_SliderOrY:SetValueStep(1);
		Icetip_OptionsFrame_SliderOrY:SetScript("OnValueChanged", function(self, value)
				Icetip_OptionsFrame_SliderOrYText:SetText(L.SetOrgiY..value)
				IcetipDB.OrigPosY = value;		
		end)




	--register BLZ
	Icetip_OptionsFrame.name = IcetipTitle;
	InterfaceOptions_AddCategory(Icetip_OptionsFrame)
end

function Icetip_Options_Init()
--恢复默认值
	--点击默认选项 直接调用 Icetip:GetDefault()
	
--应用sv
	if IcetipDB.VividMask then
		Icetip:GetVVMask():Show()
	else
		Icetip:GetVVMask():Hide()
	end

	if IcetipDB.Talented then
		IcetipDB.Talented  = true
	else
		IcetipDB.Talented  = false
	end

	if IcetipDB.DisFaction then
		IcetipDB.DisFaction = true
	else
		IcetipDB.DisFaction = false
	end

	if IcetipDB.DisTarget then
		IcetipDB.DisTarget = true
	else
		IcetipDB.DisTarget = false
	end

	if IcetipDB.Fade then
		IcetipDB.Fade = true;
	else
		IcetipDB.Fade = false;
	end

	if IcetipDB.SexName then
		IcetipDB.SexName = true;
	else
		IcetipDB.SexName = false;
	end

	if IcetipDB.DisPvpRank then
		IcetipDB.DisPvpRank = true;
	else
		IcetipDB.DisPvpRank = false;
	end

	if IcetipDB.DisClass then
		IcetipDB.DisClass = true;
	else
		IcetipDB.DisClass = false;
	end

	if IcetipDB.Server then
		IcetipDB.Server = true;
	else
		IcetipDB.Server = false;
	end

	GameTooltip:SetScale(IcetipDB.Scale);
	Icetip_OptionsFrame_AnchorDropDown.initialize = Icetip_OptionsFrame_AnchorDropDown_Initialize;
	for i = 1, #ICETIP_ANCHOR_VALUE do
		if ICETIP_ANCHOR_VALUE[i] == IcetipDB.Anchor then
			Icetip_OptionsFrame_AnchorDropDownText:SetText(ICETIP_ANCHOR_TABLE[i])
		end
	end
end

function Icetip_OptionsFrame_AnchorDropDown_Initialize()
	local info = {};
	for i , v in pairs(ICETIP_ANCHOR_VALUE) do
		info.text = ICETIP_ANCHOR_TABLE[i];
		info.value = i;
		info.checked = nil;
		info.func = function() 
			local id = this:GetID()
			UIDropDownMenu_SetSelectedID(Icetip_OptionsFrame_AnchorDropDown, id)
			IcetipDB.Anchor = ICETIP_ANCHOR_VALUE[this.value]
			end
		UIDropDownMenu_AddButton(info);
	end
end


function Icetip_Options_OnShow()
	Icetip_OptionsFrame_Mask:SetChecked(IcetipDB.VividMask);
	Icetip_OptionsFrame_Talent:SetChecked(IcetipDB.Talented);
	Icetip_OptionsFrame_Faction:SetChecked(IcetipDB.DisFaction);
	Icetip_OptionsFrame_Target:SetChecked(IcetipDB.DisTarget);
	Icetip_OptionsFrame_Fade:SetChecked(IcetipDB.Fade);
	Icetip_OptionsFrame_Sex:SetChecked(IcetipDB.SexName);
	Icetip_OptionsFrame_Rank:SetChecked(IcetipDB.DisPvpRank);
	Icetip_OptionsFrame_ClassFlag:SetChecked(IcetipDB.DisClass);
	Icetip_OptionsFrame_Scale:SetValue(IcetipDB.Scale*100);
	Icetip_OptionsFrame_Server:SetChecked(IcetipDB.Server);
	Icetip_OptionsFrame_OSX:SetValue(IcetipDB.OffsetX);
	Icetip_OptionsFrame_OSY:SetValue(IcetipDB.OffsetY);
	Icetip_OptionsFrame_SliderOrX:SetValue(IcetipDB.OrigPosX);
	Icetip_OptionsFrame_SliderOrY:SetValue(IcetipDB.OrigPosY);
end

Icetip_OptionsFrame:RegisterEvent("VARIABLES_LOADED")
Icetip_OptionsFrame:SetScript("OnEvent", Icetip_Options_Init)
Icetip_OptionsFrame:SetScript("OnShow", Icetip_Options_OnShow)