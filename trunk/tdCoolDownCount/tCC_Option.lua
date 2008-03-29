
local _G = getfenv(0)
local localization = {}

if GetLocale() == "zhCN" then
	localization.text = {
		Title = "tCC 设置",
		Config = "开启",
		Shine = "开启闪光效果",
		Sound = "开启声音效果",
		HideCD = "隐藏系统动画",
		Center = "开启中部提示",
		CMode = "中部加亮",
		Time = "闪光时间:",
		Scale = "闪光大小:",
		Style = "闪光材质",
		CTime = "中部时间:",
		CScale = "中部大小:",
		CAlpha = "中部透明:",
		Size = "字体大小:",
		Point = "计时位置",
		Font = "字体文件",
		Min = "时间下限",
		Max = "时间上限",
		Move = "移动中部",
		Action = "动作条",
		Pet = "宠物条",
		Spell = "技能书",
		Item = "背包",
		Buff = "Buff",
		Font1 = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷却:字体未设置，%s为无效字体，请检查拼写！",
		Range = "超出距离",
		Mana = "法力不足",
		Usable = "不可用",
		Other = "其它",
		Type = "精确时间",
		ColorText = "优先级",
		TextColor = "技能名称颜色",
		Text = "中部文字",
	}
	localization.title = {
		HideCD = "隐藏系统的转圈效果",
		Time = "闪光效果持续时间(单位:秒)",
		CTime = "中部提示的持续时间",
		CAlpha = "中部提示的初始透明度",
		Min = "低于此值的冷却时间不显示(单位:秒)",
		Max = "Buff计时剩余时间低于此值才开始显示\n设为 0 时不设上限(单位:秒)",
		Type = "1分钟到10分钟之间的时间显示为X:XX的形式"
	}
	localization.string = {
		Style = {"技能图标","系统","圆形","爆炸","心型"},
		Point = {"左上","上","右上","左","中","右","左下","下","右下"},
	}
	
elseif GetLocale() == "zhTW" then
	localization.text = { 
		Title = "tCC設置", 
		Config = "開啟", 
		Shine = "開啟閃光效果", 
		Sound = "開啟聲音效果", 
		HideCD = "隱藏系統動畫", 
		Center = "開啟中部提示", 
		CMode = "中部加亮", 
		Time = "閃光時間:", 
		Scale = "閃光大小:", 
		Style = "閃光材質", 
		CTime = "中部時間:", 
		CScale = "中部大小:", 
		CAlpha = "中部透明:", 
		Size = "字體大小:", 
		Point = "計時位置", 
		Font = "字體文件", 
		Min = "時間下限", 
		Max = "時間上限", 
		Move = "移動中部", 
		Action = "動作條", 
		Pet = "寵物條", 
		Spell = "技能書", 
		Item = "背包", 
		Buff = "Buff", 
		Font1 = "|cff7fff7fTCC|r--|cff7fff7f太多|r冷卻:字體未設置，%s為無效字體，請檢查拼寫！",
		Range = "超出距離", 
		Mana = "法力不足", 
		Usable = "不可用", 
		Other = "其它", 
		Type = "精確時間",
		ColorText = "優先級", 
		TextColor = "技能名稱顏色", 
		Text = "中部文字",
	} 
	localization.title = { 
		HideCD = "隱藏系統的轉圈效果", 
		Time = "閃光效果持續時間(單位:秒)", 
		CTime = "中部提示的持續時間", 
		CAlpha = "中部提示的初始透明度", 
		Min = "低於此值的冷卻時間不顯示(單位:秒)", 
		Max = "Buff計時剩餘時間低於此值才開始顯示\n設為0時不設上限(單位:秒)", 
		Type = "1分鐘到10分鐘之間的時間顯示為X:XX的形式" 
	} 
	localization.string = { 
		Style = {"技能圖標","系統","圓形","爆炸","心型"}, 
		Point = {"左上","上","右上","左","中","右","左下","下","右下"}, 
	}
else
	localization.text = {
                Title = "tCC Options",
                Config = "Enabled",
                Shine = "Enable Shining",
                Sound = "Play Sound on Cooldown Completed",
                HideCD = "Hide default Effect",
                Center = "Show HoT Icon on Screen",
                CMode = "Highlight HoT Icon",
                Time = "Duration:",
                Scale = "Size:",
                Style = "Style",
                CTime = "Time:",
                CScale = "Size:",
                CAlpha = "Alpha Val:",
                Size = "Font Size:",
                Point = "Anchor offset",
                Font = "Font File",
                Min = "Min Displayable Cooldown Duration",
                Max = "Max Displayable Cooldown Duration",
                Move = "Effect Test (on|off)",
                Action = "Action",
                Pet = "Pet",
                Spell = "Spell",
                Item = "Item",
                Buff = "Buff",
                Font1 = "|cff7fff7fTCC|r-|cff7fff7fTaiDuo|rCoolDown:Fonts not set,%s is invalid fonts, check the spelling!",
                Range = "OutOfRange", 
                Mana = "NotEnoughMana",
                Usable = "SpellNotUsable", 
                Other = "Other", 
                Type = "Show Precise Duration",
                ColorText = "Priority",
                TextColor = "Color of Spells' Name",
                Text = "Text in center",
        }
        localization.title = {
                Time = "Duration of shining effect (second/s).",
                CTime = "Duration of onScreen hot icon (second/s).",
                CAlpha = "Initial transparency of onScreen hot icon.",
                Min = "Not displayable less than this cooldown duration (second/s).",
                Max = "Not displayable more than this cooldown duartion \n Set 0 no limit (second/s).",
                Type = "Time between 0 to 10 mins will be displayed as the format of X:XX",
        }
        localization.string = {
                Style = {"Icon", "System", "Round", "Explosive", "Heart"},
        }

end

tCC_Option = CreateFrame("Frame",nil,UIParent)
tCC_Option:Hide()
tCC_Option.index = "Action"

local function tCC_Option_Enable(frame)
	local type = frame:GetObjectType()
	if type == "Button" then
		frame:Enable()
		if _G[frame:GetName() .. "Text"] then
			_G[frame:GetName() .. "Text"]:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	elseif type == "Slider" then
		OptionsFrame_EnableSlider(frame)
		frame.disable = nil
	elseif type == "CheckButton" then
		OptionsFrame_EnableCheckBox(frame)
	elseif type == "EditBox" then
		frame:ClearFocus()
		frame.disable = nil
		_G[frame:GetName() .. "Text"]:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	elseif type == "Frame" and frame.type == "DropDown" then
		UIDropDownMenu_EnableDropDown(frame)
		_G[frame:GetName() .. "Text1"]:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
end

local function tCC_Option_Disable(frame)
	local type = frame:GetObjectType()
	if type == "Button" then
		frame:Disable()
		if _G[frame:GetName() .. "Text"] then
			_G[frame:GetName() .. "Text"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		end
	elseif type == "Slider" then
		OptionsFrame_DisableSlider(frame)
		frame.disable = true
	elseif type == "CheckButton" then
		OptionsFrame_DisableCheckBox(frame)
	elseif type == "EditBox" then
		frame:ClearFocus()
		frame.disable = true
		_G[frame:GetName() .. "Text"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	elseif type == "Frame" and frame.type == "DropDown" then
		UIDropDownMenu_DisableDropDown(frame)
		_G[frame:GetName() .. "Text1"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
end

function tCC_Option_UpdateEnOrDis(auto, check)
	if auto then
		local set
		if check  then
			set = tCC_Option_Enable
		else
			set = tCC_Option_Disable
		end
		for _, frame in ipairs(auto) do
			local button = _G["tCC_Option"..frame]
			set(button)
			if button.auto and button.GetChecked then
				local seccheck = check and button:GetChecked() and true
				tCC_Option_UpdateEnOrDis(button.auto, seccheck)
			end
		end
	end
end

local function tCC_OptionSliderSetValue(frame, value)
	if frame:IsVisible() and value and frame:GetValue() ~= value then
		local disable = frame.disable
		frame.disable = true
		frame:SetValue(value)
		frame.font:SetText(frame.text..(frame.string and frame.string[value] or value))
		frame.disable = disable
	end
end

local function tCC_Option_CheckButtonSetChecked(frame, check, notdo)
	local value = frame:GetChecked() and true
	if frame:IsVisible() and value ~= check then
		frame:SetChecked(check)
		if not notdo then
			tCC_Option_UpdateEnOrDis(frame.auto, check)
		end
	end
end

local function tCC_Option_DropDownSetSelect(frame, value)
	if frame and frame:IsVisible() and value then
		ToggleDropDownMenu(1, nil, frame)
		UIDropDownMenu_SetSelectedValue(frame, value)
		ToggleDropDownMenu(1, nil, frame)
	end
end

local function tCC_Option_EditBoxSetText(frame, text)
	if frame:IsVisible() and text and text ~= frame:GetText() then
		local disable = frame.disable
		frame.disable = true
		frame:SetText(text)
		frame.disable = disable
	end
end

function tCC_OptionColor_OnClick()
	if ColorPickerFrame:IsShown() then
		ColorPickerFrame:Hide()
	else
		ColorPickerFrame.index = this.index
		ColorPickerFrame.hasOpacity = nil
		ColorPickerFrame.previousValues = {r = tCCDB.Color[this.index].r, g = tCCDB.Color[this.index].g, b = tCCDB.Color[this.index].b}

		ColorPickerFrame.func = tCC_OptionColor_OnColorChange
		ColorPickerFrame.cancelFunc = function() tCC_OptionColor_OnColorChange(ColorPickerFrame.previousValues, ColorPickerFrame.index) end

		ColorPickerFrame:SetColorRGB(tCCDB.Color[this.index].r, tCCDB.Color[this.index].g, tCCDB.Color[this.index].b)
		
		ShowUIPanel(ColorPickerFrame)
	end
end

function tCC_OptionColor_OnColorChange(rgb, index)
	local r, g, b
	if rgb then
		r = rgb.r; g = rgb.g; b = rgb.b
	else
		r, g, b = ColorPickerFrame:GetColorRGB()
		index = ColorPickerFrame.index
	end
	
	tCCDB.Color[index].r = r
	tCCDB.Color[index].g = g
	tCCDB.Color[index].b = b

	getglobal("tCC_Option"..index.."NormalTexture"):SetVertexColor(r, g, b)
end

function tCC_Option_LoadOptions(index)
	local show, frame = {"Alls","Others","Max","Min","Open","Point","Sound","Centers","Shines"}
	for _, frame in ipairs(show) do
		frame = _G["tCC_Option" .. frame]
		if frame and not frame:IsVisible() then
			frame:Show()
		end
	end
	local button = _G["tCC_Option"..index]
	for _, frame in ipairs(button.auto) do
		frame = _G["tCC_Option"..frame]
		if frame and frame:IsVisible() then
			frame:Hide()
		end
	end

	if index ~= "Other" then
		local value = tCCDB[index]

		tCC_OptionSliderSetValue(tCC_OptionTime,   value.time)
		tCC_OptionSliderSetValue(tCC_OptionScale,  value.scale)
		tCC_OptionSliderSetValue(tCC_OptionCTime,  value.ctime)
		tCC_OptionSliderSetValue(tCC_OptionCScale, value.cscale)
		tCC_OptionSliderSetValue(tCC_OptionCAlpha, value.calpha)
		tCC_OptionSliderSetValue(tCC_OptionSize,   value.size)

		tCC_Option_EditBoxSetText(tCC_OptionMin,  value.min)
		tCC_Option_EditBoxSetText(tCC_OptionMax,  value.max)
		tCC_Option_EditBoxSetText(tCC_OptionFont, value.font)

		tCC_Option_DropDownSetSelect(tCC_OptionFontDrop, value.font)
		tCC_Option_DropDownSetSelect(tCC_OptionStyle, value.style)
		tCC_Option_DropDownSetSelect(tCC_OptionPoint, value.point)

		tCC_Option_CheckButtonSetChecked(tCC_OptionShine,  value.shine, true)
		tCC_Option_CheckButtonSetChecked(tCC_OptionCenter, value.center, true)
		tCC_Option_CheckButtonSetChecked(tCC_OptionHideCD, value.hide, true)
		tCC_Option_CheckButtonSetChecked(tCC_OptionConfig, value.config, true)
		tCC_Option_CheckButtonSetChecked(tCC_OptionCMode,  value.cmode, true)
		tCC_Option_CheckButtonSetChecked(tCC_OptionSound,  value.sound, true)

		tCC_Option_UpdateEnOrDis(tCC_OptionConfig.auto, value.config)
	else
		if tdRange_GetColor then
			tCC_OptionColor_OnColorChange(tCCDB.Color.Range, "Range")
			tCC_OptionColor_OnColorChange(tCCDB.Color.Mana, "Mana")
			tCC_OptionColor_OnColorChange(tCCDB.Color.Usable, "Usable")
			for i = 1, 3 do
				_G["tCC_OptionColorText"..i]:SetText(localization.text[tCCDB.Other.Color[i]])
			end
		end
		tCC_Option_Enable(tCC_OptionFont)
		tCC_Option_Enable(tCC_OptionSize)
		tCC_Option_CheckButtonSetChecked(tCC_OptionType,  tCCDB.Other.type)
		tCC_Option_CheckButtonSetChecked(tCC_OptionText,  tCCDB.Other.text)
		tCC_OptionColor_OnColorChange(tCCDB.Color.TextColor, "TextColor")
		tCC_OptionSliderSetValue(tCC_OptionSize, tCCDB.Other.size)
		tCC_Option_EditBoxSetText(tCC_OptionFont, tCCDB.Other.font)
		tCC_Option_DropDownSetSelect(tCC_OptionFontDrop, tCCDB.Other.font)
	end
	if tCC_Move and tCC_Move:IsVisible() then tCC_Move:Hide() end
end

function tCC_Option_Init()
	tCC_Option:SetWidth(390); tCC_Option:SetHeight(490);
	tCC_Option:SetPoint("CENTER")
	tCC_Option:SetFrameStrata("LOW")
	tCC_Option:SetToplevel(false)
	tCC_Option:SetMovable(true)
	tCC_Option:SetClampedToScreen(true)
	tCC_Option:SetBackdrop( { 
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, 
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	});
	tCC_Option:EnableMouse(true)
	tCC_Option:RegisterForDrag("LeftButton")
	tCC_Option:SetScript("OnDragStart",function() this:StartMoving() end)
	tCC_Option:SetScript("OnDragStop",function() this:StopMovingOrSizing() end)

	tCC_Option:CreateTexture("tCC_OptionHeader", "OVERLAY")
	tCC_OptionHeader:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	tCC_OptionHeader:SetPoint("TOP",0,12)
	tCC_OptionHeader:SetWidth(256)
	tCC_OptionHeader:SetHeight(64)

	tCC_Option:CreateFontString("tCC_OptionTitle", "OVERLAY", "GameFontNormalSmall")
	tCC_OptionTitle:SetPoint("CENTER",tCC_OptionHeader,"CENTER",0,12)
	tCC_OptionTitle:SetText(localization.text.Title)

	local tCC_Option_Buttons = {
		{name="Close", type="Button", inherits="UIPanelCloseButton",
			point="TOPRIGHT",x=-5,y=-5},
		{name="Reset", type="Button", inherits="UIPanelButtonTemplate",text=RESET,
			point="TOPLEFT", x=10, y=-10, width=50, height=20,
			func=function()
					local fonts = tCCDB.Fonts
					tCC:GetDefault()
					tCCDB.Fonts = fonts
					tCC_Option_LoadOptions(tCC_Option.index)
				end},

		{name="Action",type="Button",
			point="TOPLEFT",x=15, y=-35,
			auto={"Others","Max", "Point"},},
		{name="Pet",   type="Button",
			point="LEFT",relative="Action",rpoint="RIGHT",
			auto={"Others","Max","Point"},},
		{name="Spell", type="Button",
			point="LEFT",relative="Pet",rpoint="RIGHT",
			auto={"Others","Max","Point","Centers","Sound"}},
		{name="Item",  type="Button",
			point="LEFT",relative="Spell",rpoint="RIGHT",
			auto={"Others","Max","Point","Centers","Sound"}},
		{name="Buff",  type="Button",
			point="LEFT",relative="Item",rpoint="RIGHT",
			auto={"Others","Min","Centers","Shines","Sound"}},
		{name="Other", type="Button",
			point="LEFT",relative="Buff",rpoint="RIGHT",
			auto={"Open","Alls","Centers","Shines","Point"}},


		{name="Open", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Action",rpoint="BOTTOMLEFT",y=-10, width=360,height=38},
		{name="Alls", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Open",rpoint="BOTTOMLEFT",y=-10, width=175,height=110},
		{name="Centers", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Alls",rpoint="BOTTOMLEFT",y=-10, width=175,height=230},
		{name="Others", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Open",rpoint="BOTTOMLEFT",y=-10, width=175,height=350},
		{name="Fonts", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Alls",rpoint="TOPRIGHT",x=10, width=175,height=159},
		{name="Shines", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
			point="TOPLEFT",relative="Fonts",rpoint="BOTTOMLEFT",y=-10, width=175,height=180},

--		{name="Styles", type="Frame", inherits="tCC_OptionFrameBoxTemplate",
--			point="TOPLEFT",relative="Fonts",rpoint="BOTTOMLEFT",y=-10, width=175,height=180},

		{name="Config",type="CheckButton",var="config",
			auto={"Shine","Center","HideCD","Size","Point","Min","Max","Font","Sound"},
			parent="Open",point="TOPLEFT",x=5,y=-5},
		{name="Shine",type="CheckButton",var="shine",
			auto={"Time","Scale","Style"},
			parent="Shines",point="TOPLEFT", x=5,y=-5},
		{name="Center",type="CheckButton",var="center",
			auto={"CTime","CScale","Move","CAlpha","CMode"},
			parent="Centers", point="TOPLEFT",x=5,y=-5},
		{name="HideCD",type="CheckButton",var="hide",
			parent="Alls", point="TOPLEFT",x=5,y=-5},
		{name="Sound",type="CheckButton",var="sound",
			parent="Alls",point="TOPLEFT",relative="HideCD",rpoint="BOTTOMLEFT"},
		{name="CMode",type="CheckButton",var="cmode",
			parent="Centers",point="TOPLEFT",relative="Center",rpoint="BOTTOMLEFT"},
		{name="Type",type="CheckButton",
			parent = "Others",point="TOPLEFT",x=5,y=-5,
			func=function() tCCDB.Other.type = this:GetChecked() and true or nil end},
		{name="Text",type="CheckButton",
			parent = "Others",point="TOPLEFT",relative="Type",rpoint="BOTTOMLEFT",
			func=function() tCCDB.Other.text = this:GetChecked() and true or nil end},
		{name="TextColor",type="Button",func=tCC_OptionColor_OnClick,
			parent="Others",point="TOPLEFT",relative="Text",rpoint="TOPLEFT",x=5,y=-30,
			inherits="tCC_OptionColorPickerTemplate",},


		{name="Time",type="Slider",min=0.00,max=5.00,step=0.01,var = "time",
			parent="Shines",point="TOPLEFT",relative="Shine",rpoint="BOTTOMLEFT",x=5,y=-25},
		{name="Scale",type="Slider",min=36,max=500,step=1,var = "scale",
			parent="Shines",point="TOPLEFT",relative="Time",rpoint="BOTTOMLEFT",y=-25},

		{name="CTime",type="Slider",min=0.00,max=5.00,step=0.01,var = "ctime",
			parent="Centers",point="TOPLEFT",relative="CMode",rpoint="BOTTOMLEFT",x=5,y=-25},
		{name="CScale",type="Slider",min=50,max=200,step=1,var = "cscale",
			parent="Centers",point="TOPLEFT",relative="CTime",rpoint="BOTTOMLEFT",y=-25},
		{name="CAlpha",type="Slider",min=0,max=1,step=0.01,var = "calpha",
			parent="Centers",point="TOPLEFT",relative="CScale",rpoint="BOTTOMLEFT",y=-25},

		{name="Min",type="EditBox",var="min",letter=5,numonly=true,func=function()
				local value = tonumber(this:GetText())
				if value then
					tCCDB[tCC_Option.index].min = value
				else
					this:SetValue(tostring(tCCDB[tCC_Option.index].min))
				end
				this:ClearFocus()
			end,
			parent="Alls",point="TOPLEFT",relative="Sound",rpoint="BOTTOMLEFT",y=-25,x=10},
		{name="Max",type="EditBox",height=20,var="max",letter=5,numonly=true,func=function()
				local value = tonumber(this:GetText())
				if value then
					tCCDB[tCC_Option.index].max = value
				else
					this:SetValue(tostring(tCCDB[tCC_Option.index].max))
				end
				this:ClearFocus()
			end,
			parent="Alls",point="CENTER",relative="Min",rpoint="CENTER",},


		{name="Font",type="EditBox",var="font",func=tCC_OptionSetFont,drop="FontDrop",
			parent="Fonts",point="TOPLEFT",x=15,y=-25},
		{name="Size",type="Slider",min=1,max=36,step=1,var = "size",
			parent="Fonts",point="TOPLEFT",relative="Font",rpoint="BOTTOMLEFT",x=-5,y=-25},

		{name="Move",type="Button",inherits="UIPanelButtonTemplate",
			width=100, height=20, func=tCC_CenterMove,
			parent="Centers",point="TOPLEFT",relative="CAlpha",rpoint="BOTTOMLEFT",y=-20},
		{name="Point",type="DropDown",width=130,var = "point",value = {"TOPLEFT","TOP","TOPRIGHT","LEFT","CENTER","RIGHT","BOTTOMLEFT","BOTTOM","BOTTOMRIGHT"},
			parent="Fonts",point="TOPLEFT",relative="Size",rpoint="BOTTOMLEFT",x=-20,y=-25,},
		{name="Style",type="DropDown",width=130,var = "style",value = {1,2,3,4,5},
			parent="Shines",point="TOPLEFT",relative="Scale",rpoint="BOTTOMLEFT",x=-20,y=-25,},
		{name="FontDrop",type="DropDown",width=130,var = "font",value = tCCDB.Fonts,menu="Font",
			parent="Font",},

	}
	if tdRange_GetColor then
		tinsert(tCC_Option_Buttons, {name="Range", type="Button",func=tCC_OptionColor_OnClick,parent="Others",point="TOPLEFT",relative="TextColor",rpoint="BOTTOMLEFT",inherits="tCC_OptionColorPickerTemplate",y=-20})
		tinsert(tCC_Option_Buttons, {name="Mana",  type="Button",func=tCC_OptionColor_OnClick,parent="Others",point="TOPLEFT",relative="Range",rpoint="BOTTOMLEFT",inherits="tCC_OptionColorPickerTemplate",})
		tinsert(tCC_Option_Buttons, {name="Usable",type="Button",func=tCC_OptionColor_OnClick,parent="Others",point="TOPLEFT",relative="Mana",rpoint="BOTTOMLEFT",inherits="tCC_OptionColorPickerTemplate",})
		tinsert(tCC_Option_Buttons, {name="ColorText1",type="Button",parent="Others",point="TOPLEFT",relative="Usable",rpoint="BOTTOMLEFT",inherits="UIPanelButtonTemplate",width=80,height=26, y=-40})
		tinsert(tCC_Option_Buttons, {name="ColorText2",type="Button",parent="Others",point="TOP",relative="ColorText1",rpoint="BOTTOM",inherits="UIPanelButtonTemplate",width=80,height=26})
		tinsert(tCC_Option_Buttons, {name="ColorText3",type="Button",parent="Others",point="TOP",relative="ColorText2",rpoint="BOTTOM",inherits="UIPanelButtonTemplate",width=80,height=26})
		tinsert(tCC_Option_Buttons, {name="Below1",type="Button",text="↓",func=tCC_OptionColorRangeOnClick,parent="Others",string=1,var=1,point="LEFT",relative="ColorText1",rpoint="RIGHT",inherits="UIPanelButtonTemplate",width=20,height=26,x=30})
		tinsert(tCC_Option_Buttons, {name="Below2",type="Button",text="↓",func=tCC_OptionColorRangeOnClick,parent="Others",string=1,var=2,point="LEFT",relative="ColorText2",rpoint="RIGHT",inherits="UIPanelButtonTemplate",width=20,height=26,x=30})
		tinsert(tCC_Option_Buttons, {name="Above2",type="Button",text="↑",func=tCC_OptionColorRangeOnClick,parent="Others",string=-1,var=2,point="LEFT",relative="ColorText2",rpoint="RIGHT",inherits="UIPanelButtonTemplate",width=20,height=26,x=5})
		tinsert(tCC_Option_Buttons, {name="Above3",type="Button",text="↑",func=tCC_OptionColorRangeOnClick,parent="Others",string=-1,var=3,point="LEFT",relative="ColorText3",rpoint="RIGHT",inherits="UIPanelButtonTemplate",width=20,height=26,x=5})
	end
	
	local button, text, name, value
	for _, value in ipairs(tCC_Option_Buttons) do
		if not value.inherits then
			if value.type == "CheckButton" then
				value.inherits = "tCC_OptionCheckButtonTemplate"
			elseif value.type == "Slider" then
				value.inherits = "tCC_OptionSliderTemplate"
			elseif value.type == "EditBox" then
				value.inherits = "tCC_OptionEditBoxTemplate"
			elseif value.type == "Button" then
				value.inherits = "tCC_OptionButtonTemplate"
			end
		end

		if value.type == "DropDown" then
			button = CreateFrame("Frame", "tCC_Option"..value.name, _G[value.parent and "tCC_Option"..value.parent or "tCC_Option"], "tCC_OptionDropDownTemplate")
			if value.width then
				UIDropDownMenu_SetWidth(value.width, button)
			end
			if value.buttonwidth then
				UIDropDownMenu_SetButtonWidth(value.buttonwidth, button)
			end
			UIDropDownMenu_Initialize(button, function() tCC_Option_DropDownMenu_Initialise(value) end);
			button.type = "DropDown"
		else
			button = CreateFrame(value.type, "tCC_Option"..value.name, _G[value.parent and "tCC_Option"..value.parent or "tCC_Option"], value.inherits)
			if value.width then
				button:SetWidth(value.width)
			end
			if value.height then
				button:SetHeight(value.height)
			end

			if value.type == "Slider" then
				button.text = value.text or localization.text[value.name] or ""
				_G["tCC_Option"..value.name.."Low"]:SetText(value.min)
				_G["tCC_Option"..value.name.."High"]:SetText(value.max)
				button:SetMinMaxValues(value.min, value.max)
				button:SetValueStep(value.step)
			elseif value.type == "EditBox" then
				if value.letter then button:SetMaxLetters(value.letter) end
				if value.numonly then button:SetNumeric(value.numonly) end
			end
			if value.func then
				if value.type == "CheckButton" then
					button:SetScript("OnClick", value.func)
				elseif value.type == "Slider" then
					button:SetScript("OnValueChange", value.func)
				elseif value.type == "EditBox" then
					button:SetScript("OnEnterPressed", value.func)
				elseif value.type == "Button" then
					button:SetScript("OnClick", value.func)
				end
			end
		end
		button.string = value.string or localization.string[value.name] or nil
		button.var = value.var or nil
		button.auto = value.auto or nil
		button.index = value.name or nil
		button.drop = value.drop or nil
		button.menu = value.menu or nil

		if value.point then
			if value.relative then
				value.relative = "tCC_Option"..value.relative
			end
			button:SetPoint(value.point, _G[value.relative or (value.parent and "tCC_Option"..value.parent) or "tCC_Option"], value.rpoint or value.point, value.x or 0, value.y or 0)
		end
		if value.type == "Button" then
			button:SetText(value.text or localization.text[value.name] or "")
		elseif _G[button:GetName().."Text1"] then
			_G[button:GetName().."Text1"]:SetText(value.text or localization.text[value.name] or "")
		elseif _G[button:GetName().."Text"] then
			button.font = _G[button:GetName().."Text"]
			button.font:SetText(value.text or localization.text[value.name] or "")
		end

		local title = value.title or localization.title[value.name] or nil
		if title then
			button.title = title
			button:SetScript("OnEnter",function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT");GameTooltip:SetText(this.title) end)
			button:SetScript("OnLeave",function() GameTooltip:Hide() end)
		end
	end
	if tdRange_GetColor then
		tCC_OptionOthers:CreateFontString("tCC_OptionColorText", "OVERLAY", "GameFontNormalSmall")
		tCC_OptionColorText:SetText(localization.text.ColorText)
		tCC_OptionColorText:SetPoint("BOTTOMLEFT",tCC_OptionColorText1,"TOPLEFT",0,5)
	end
	tCC_Option:Show()

	_G["tCC_OptionAction"]:Disable()
	tCC_Option_LoadOptions("Action")
	tCC_Option.ready = true
end

function tCC_OptionColorRangeOnClick()
	local i, j = this.var, this.var + this.string
	local k, l = _G["tCC_OptionColorText"..i], _G["tCC_OptionColorText"..j]
	local o, p = tCCDB.Other.Color[i], tCCDB.Other.Color[j]
	k:SetText(localization.text[p])
	l:SetText(localization.text[o])
	tCCDB.Other.Color[i] = p
	tCCDB.Other.Color[j] = o
end

function tCC_CenterMove()
	if tCC_Move and tCC_Move:IsVisible() then
		tCC_Move:Hide()
	else
		if not tCC_Move then
			tCC_Move = CreateFrame("Frame",nil,UIParent)
			tCC_Move:SetClampedToScreen(true)
			tCC_Move:EnableMouse(true)
			tCC_Move:SetMovable(true)
			tCC_Move:RegisterForDrag("LeftButton")
			tCC_Move:SetScript("OnDragStart",function() this:StartMoving() end)
			tCC_Move:SetScript("OnDragStop",function()
				this:StopMovingOrSizing();
				local p,_,s,x,y = this:GetPoint()
				tCCDB[tCC_Option.index].x = x
				tCCDB[tCC_Option.index].y = y
				tCCDB[tCC_Option.index].p = p
				tCCDB[tCC_Option.index].s = s
			end)
			tCC_Move.texture = tCC_Move:CreateTexture(nil,"ARTWORK")
			tCC_Move.texture:SetAllPoints(tCC_Move)
			tCC_Move.texture:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_01")
		end

		tCC_Move:SetWidth(tCCDB[tCC_Option.index].cscale);
		tCC_Move:SetHeight(tCCDB[tCC_Option.index].cscale);
		tCC_Move:ClearAllPoints()
		if tCCDB[tCC_Option.index].p then
			tCC_Move:SetPoint(tCCDB[tCC_Option.index].p,UIParent,tCCDB[tCC_Option.index].s,tCCDB[tCC_Option.index].x,tCCDB[tCC_Option.index].y)
		else
			tCC_Move:SetPoint("CENTER",UIParent,"CENTER",0,0)
		end
		tCC_Move:Show()
	end
end

function tCC_OptionSetFont()
	if(not tCCTestFont) then
		CreateFont("tCCTestFont")
	end
	local font = string.lower(this:GetText())
	if( tCCTestFont:SetFont(font, tCCDB[tCC_Option.index].size) ) then
		tCCDB[tCC_Option.index].font = font
		local ishave, i
		for i = 1, #(tCCDB.Fonts) do
			if tCCDB.Fonts[i] == font then
				ishave = true
				break
			end
		end
		if not ishave then
			tinsert(tCCDB.Fonts, font)
			local info = {}
			info.value = font
			info.text = font
			info.func = tCC_Option_DropDownMenu_OnClick
			info.owner = tCC_OptionFont
			info.checked = nil
			info.icon = nil
			UIDropDownMenu_AddButton(info, 1)
		end
		this:SetText(font)
		tCC_Option_DropDownSetSelect(tCC_OptionFontDrop, font)
	else
		DEFAULT_CHAT_FRAME:AddMessage(format(localization.text.Font1, font))
		this:SetText(tCCDB[tCC_Option.index].font)
	end
	this:ClearFocus()
end

function tCC_Option_DropDownMenu_Initialise(v) 
	local info = UIDropDownMenu_CreateInfo();
	for i = 1, #(v.value) do
		info.value = v.value[i]
		info.text = (v.string and v.string[i]) or
			(localization.string[v.name] and localization.string[v.name][i]) or
			v.value[i] 
		info.func = tCC_Option_DropDownMenu_OnClick
		info.owner = _G["tCC_Option"..v.name]
		info.checked = nil
		info.icon = nil
		UIDropDownMenu_AddButton(info, 1)
	end
end

function tCC_Option_DropDownMenu_OnClick()
	tCC_Option_DropDownSetSelect(this.owner, this.value)
	tCCDB[tCC_Option.index][this.owner.var] = this.value
	if this.owner.menu then
		_G["tCC_Option"..this.owner.menu]:SetText(this.value)
		_G["tCC_Option"..this.owner.menu]:ClearFocus()
	end
end

