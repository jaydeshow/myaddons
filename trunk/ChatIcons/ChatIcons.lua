local addon = CreateFrame("Frame","ChatIcons")

local TEXTURE_LINK_FORMAT_FORMAT = "|T%%s:%d:%d:0:%d|t"
local TEXTURE_LINK_FORMAT
local ITEM_LINK_PATTERN = "|c%x%x%x%x%x%x%x%x|Hitem:(%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+|h"
local SPELL_LINK_PATTERN = "|c%x%x%x%x%x%x%x%x|Hspell:(%d+)|h"
local PLAYER_LINK_PATTERN = "|Hplayer:([^|:]+)"
local classIcons, raceIcons
local EXAMPLE_TEXT = "|Hplayer:CHAT_ICONS_FAKE_NAME_LINK|h[Medihv]|h 说: 我刷了好久 |cff1eff00|Hitem:21884:0:0:0:0:0:0:0|h[源生火焰]|h|r 用来做" ..
                     "\124cffa335ee\124Hitem:21848:0:0:0:0:0:0:0\124h[法术打击长袍]\124h\124r.  现在我的|cff71d5ff|Hspell:133|h[火球术]|h|r 比原来猛多了!"
function addon:OnEvent(event,...)
	local h = self[event]
	if type(h) == "function" then
		h(self,event,...)
	end
end

function addon:PLAYER_LOGIN()
	self:HookChatFrames()
	self.db = ChatIconsDB
	self.name = "ChatIcons"
	self.okay = function() self:ApplyTempOptions() end
	self.cancel = function() self:ResetTempOptions() end
	self.default = function() self:ResetOptions() self:ResetTempOptions()  if self:IsVisible() then self:Hide() self:Show() end end
	
	InterfaceOptions_AddCategory(self)
	InterfaceOptionsFrame:HookScript("OnHide",self.cancel)
	self:UpdateTextureLinkFormat()
end

local function addmsg(...) addon:AddMsgHook(...) end

function addon:HookChatFrames()
	if not self.hooks then self.hooks = {} end
	local n = "ChatFrame"
	for i=1,7 do
		local cf = getglobal(n..i)
		self.hooks[cf] = cf.AddMessage
		cf.AddMessage = addmsg
	end
end

local function parseMessage(s,iconFormat,pattern,geticon)
	local matchStart,matchEnd,match = s:find(pattern)
	while match do
		local icon = geticon(match)
		local iconlength = 0
		if icon then
			local iconstring = iconFormat:format(icon)
			iconlength = #iconstring
			s = s:sub(1,matchStart - 1) .. iconstring .. s:sub(matchStart)
		end
		matchStart,matchEnd,match = s:find(pattern,matchEnd + iconlength)
	end
	return s
end

local function getSpellIcon(id)
	local _,_,icon = GetSpellInfo(id)
	return icon
end

local function getPlayerInfo(name)
	if name == "CHAT_ICONS_FAKE_NAME_LINK" then
		return "HUMAN_MALE","MAGE"
	else
		if UnitName(name) then
			local _,race = UnitRace(name)
			local gender = UnitSex(name) == 3 and "FEMALE" or "MALE"
			local _,class = UnitClass(name)
			return race:upper().."_"..gender,class
		else
			for i=1,GetNumGuildMembers(true) do
				local n,_,_,_,_,_,_,_,_,_,class = GetGuildRosterInfo(i)
				if name == n then
					return "UNKNOWN",class
				end
			end
		end
	end
end

local function getPlayerClassIcon(name)
	local _,class = getPlayerInfo(name)
	return classIcons[class]
end

local function getPlayerRaceIcon(name)
	return raceIcons[(getPlayerInfo(name))]
end

function addon:ProcessMessage(msg,textureFormat,example)
	local db = example and self.tempDB or self.db
	if db.items then msg = parseMessage(msg,textureFormat,ITEM_LINK_PATTERN,GetItemIcon) end
	if db.spells then msg = parseMessage(msg,textureFormat,SPELL_LINK_PATTERN,getSpellIcon) end
	if example or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_GUILD" then
		--if db.race then msg = parseMessage(msg,textureFormat,PLAYER_LINK_PATTERN,getPlayerRaceIcon) end
		if db.class then msg = parseMessage(msg,textureFormat,PLAYER_LINK_PATTERN,getPlayerClassIcon) end
	end
	return msg
end

function addon:AddMsgHook(frame,s,...)
	if s then
		s = self:ProcessMessage(s,TEXTURE_LINK_FORMAT)
	end
	self.hooks[frame](frame,s,...)
end

function addon:OnShow()
	self:ResetTempOptions()
	if not self.builtGui then
		self:BuildWidgetMethods()
		self:BuildGuiOptions()
	end
end

function addon:UpdateTextureLinkFormat()
	local db = self.db
	local size = db.autosize and 0 or db.size
	TEXTURE_LINK_FORMAT = TEXTURE_LINK_FORMAT_FORMAT:format(size,size,db.offset)
end

function addon:ResetTempOptions()
	if not self.tempDB then self.tempDB = {} end
	for k,v in pairs(self.db) do
		self.tempDB[k] = v
	end
end

function addon:ResetOptions()
	ChatIconsDB = {
		items = true,
		spells = true,
--		race = false,
		class = false,
		size = 12,
		offset = -3,
		autosize = true,
		exampleFontSize = 14,
	}
	self.db = ChatIconsDB
end

function addon:ApplyTempOptions()
	for k,v in pairs(self.tempDB) do
		self.db[k] = v
	end
	self:UpdateTextureLinkFormat()
end

local createCheckButton, checkbutton_PostClick, widget_OnShow, slider_Disable, slider_Enable, widget_SetDependency

function addon:BuildGuiOptions()
	local t = self:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	t:SetText("ChatIcons")
	t:SetPoint("TOPLEFT",16,-16)
	self.title = t
	
	t = self:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	t:SetText("添加图标到聊天框.")
	t:SetPoint("TOPLEFT",self.title,"BOTTOMLEFT",0,0)
	t:SetPoint("RIGHT",-32,0)
	t:SetHeight(32)
	t:SetJustifyH("LEFT")
	self.subtext = t
	
	self.itemIcons = createCheckButton("物品图标","items","在物品链接旁边添加图标.","TOPLEFT",self.subtext,"BOTTOMLEFT",-2,-8)
	self.spellIcons = createCheckButton("技能图标","spells","在技能链接旁边添加图标.","TOPLEFT",self.itemIcons,"BOTTOMLEFT",0,-8)
	self.classIcons = createCheckButton("职业图标","class","当有人在团队,小队,公会频道发言时,在名字旁边添加职业图标.","TOPLEFT",self.spellIcons,"BOTTOMLEFT",0,-8)
	
	--self.raceIcons = createCheckButton("Player Race Icons","race","Race icons are added next to players' names when they speak in party, raid or guild chat.","TOPLEFT",self.classIcons,"BOTTOMLEFT",0,-8)
	--self.moneyIcons = createCheckButton("Coin Icons","money","","TOPLEFT",self.classIcons,"BOTTOMLEFT",0,-8)
	
	self.autosize = createCheckButton("自动调整图标大小","autoSizing","图标大小根据文字大小自动调整.","TOPRIGHT",self.subtext,"BOTTOMRIGHT",-110,-8)
	
	local iconSize = createSlider("图标大小","size",5,30,"设置图标的宽度和高度.","TOPLEFT",self.autosize,"BOTTOMLEFT",3,-20)
	iconSize:SetDependency(self.autosize,true)
	self.iconSize = iconSize
	self.verticalOffset = createSlider("垂直偏移","offset",-15,15,"设置图标相对于顶部的垂直便宜量.","TOPLEFT",self.iconSize,"BOTTOMLEFT",0,-32)
	
	local e = CreateFrame("Frame",nil,self)
	e:SetWidth(357)
	e:SetHeight(100)
	e:SetPoint("BOTTOMLEFT",15,50)
	e:SetBackdrop(GameTooltip:GetBackdrop()) -- lol, cheater
	e:SetBackdropColor(0,0,0,.5)
	e:SetBackdropBorderColor(0.5,0.5,0.5,.5)
	self.exampleBox = e
	
	t = self:CreateFontString(nil,"ARTWORK","GameFontNormal")
	t:SetText("示例")
	t:SetPoint("BOTTOMLEFT",e,"TOPLEFT",4,0)
	
	t = e:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	t:SetPoint("TOPLEFT",5,-5)
	t:SetPoint("BOTTOMRIGHT",-10,10)
	t:SetJustifyH("LEFT")
	t:SetJustifyV("TOP")
	self.exampleText = t
	
	self.exampleTextFontSize = createSlider("Example Text Font Size","exampleFontSize",7,25,"设置示例中的文字大小.","TOPLEFT",t,"BOTTOMLEFT",0,-24)
	
	self.builtGui = true
end

function addon:UpdateExamples()
	if not self.exampleText then return end
	local db = self.tempDB
	local size = db.autosize and 0 or db.size
	local format = TEXTURE_LINK_FORMAT_FORMAT:format(size,size,db.offset)
	self.format = format
	local t = self.exampleText
	local font,size,flags = t:GetFont()
	t:SetFont(font,db.exampleFontSize,flags)
	self.exampleText:SetText(self:ProcessMessage(EXAMPLE_TEXT,format,true))
end

function addon:BuildWidgetMethods()
	checkbutton_PostClick = function(b)
		local value = b:GetChecked() 
		self.tempDB[b.option] = value and true or false -- to force a value into the database when nil is returned
		self:UpdateExamples()
		
		if b.dependentWidgets then
			for _,widget in pairs(b.dependentWidgets) do
				widget:OnDependencyValueChanged(value)
			end
		end
	end
	
	slider_Disable = function(s)
		s:EnableMouse(false)
		local c = GRAY_FONT_COLOR
		s.text:SetTextColor(c.r, c.g, c.b)
		s.valueText:Hide()
		s.lowText:SetTextColor(c.r, c.g, c.b)
		s.highText:SetTextColor(c.r, c.g, c.b)
		s.thumb:Hide()
	end
	
	slider_Enable = function(s)
		local c = HIGHLIGHT_FONT_COLOR
		s.text:SetTextColor(c.r, c.g, c.b)
		s.valueText:Show()
		local c = NORMAL_FONT_COLOR
		s.lowText:SetTextColor(c.r, c.g, c.b)
		s.highText:SetTextColor(c.r, c.g, c.b)
		
		s:EnableMouse(true)
		s.thumb:Show()
	end
	
	slider_OnValueChanged = function(s)
		local value = s:GetValue()
		s.valueText:SetText(value)
		self.tempDB[s.option] = value
		self:UpdateExamples()
	end
	
	widget_OnShow = function(w)
		w:SetValue(self.tempDB[w.option])
	end
	
	widget_SetDependency = function(w,parent,invert)
		if not parent.dependentWidgets then parent.dependentWidgets = {} end
		w.invertDependency = invert
		table.insert(parent.dependentWidgets,w)
		w:OnDependencyValueChanged(parent:GetValue())
	end
	
	widget_OnDependencyValueChanged = function(w,value)
		if w.invertDependency then value = not value end
		if value then w:Enable()
		else w:Disable() end
	end
end

local function setupWidget(widget,name,option,tooltipText,...)
	local text = getglobal(widget:GetName().."Text") -- ew
	text:SetText(name)
	widget.text = text
	widget:SetPoint(...)
	widget.tooltipText = tooltipText
	widget.option = option
	
	widget.SetDependency = widget_SetDependency
	widget.OnDependencyValueChanged = widget_OnDependencyValueChanged
	
	widget:SetScript("OnShow",widget_OnShow)
	widget_OnShow(widget)
end

createCheckButton = function(name,option,tooltipText,...)
	local b = CreateFrame("CheckButton","ChatIcons - "..name,addon,"InterfaceOptionsCheckButtonTemplate")
	b.SetValue = b.SetChecked
	b.GetValue = b.GetChecked
	b:SetScript("PostClick",checkbutton_PostClick)
		
	setupWidget(b,name,option,tooltipText,...)
	b:SetHitRectInsets(0,-b.text:GetWidth(),0,0)
	return b
end

createSlider = function(name,option,min,max,tooltipText,...)
	local s = CreateFrame("Slider","ChatIcons - "..name,addon,"InterfaceOptionsSliderTemplate")
	local t = s:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	t:SetPoint("TOP",s,"BOTTOM")
	s.valueText = t
	
	t = getglobal(s:GetName() .. "Low") -- ew
	t:SetText(min)
	s.lowText = t
	
	t = getglobal(s:GetName() .. "High") -- ew
	t:SetText(max)
	s.highText = t
	
	s.thumb = getglobal(s:GetName() .. "Thumb") -- ew
	
	s.Enable = slider_Enable
	s.Disable = slider_Disable
	
	s:SetScript("OnValueChanged",slider_OnValueChanged)
	s:SetMinMaxValues(min,max)
	s:SetValueStep(1)
	setupWidget(s,name,option,tooltipText,...)
	return s
end

classIcons = {
	DRUID = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
	WARLOCK = "Interface\\Icons\\Spell_Nature_FaerieFire",
	HUNTER = "Interface\\Icons\\INV_Weapon_Bow_07",
	MAGE = "Interface\\Icons\\INV_Staff_13",
	PRIEST = "Interface\\Icons\\INV_Staff_30",
	WARRIOR = "Interface\\Icons\\INV_Sword_27",
	SHAMAN = "Interface\\Icons\\Spell_Nature_BloodLust",
	PALADIN = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Classes_Paladin",
	ROGUE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Classes_Rogue",
}

--[[raceIcons = {
	HUMAN_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Human-Male",
	HUMAN_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Human-Female",
	GNOME_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Gnome-Male",
	GNOME_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Gnome-Female",
	DWARF_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Dwart-Male",
	DWARF_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Dwarf-Female",
	NIGHTELF_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_NightElf-Male",
	NIGHTELF_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_NightElf-Female",
	DRAENEI_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Draenei-Male",
	DRAENEI_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Draenei-Female",
	UNDEAD_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Undaed-Male",
	UNDEAD_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Undead-Female",
	ORC_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Orc-Male",
	ORC_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Orc-Female",
	TROLL_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Troll-Male",
	TROLL_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Troll-Female",
	TAUREN_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Tauren-Male",
	TAUREN_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_Tauren-Female",
	BLOODELF_MALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_BloodElf-Male",
	BLOODELF_FEMALE = "Interface\\AddOns\\ChatIcons\\images\\UI-CharacterCreate-Races_BloodElf-Female",
}
]]
addon:SetScript("OnShow",addon.OnShow)
addon:SetScript("OnEvent",addon.OnEvent)
addon:RegisterEvent("PLAYER_LOGIN")
addon:ResetOptions()