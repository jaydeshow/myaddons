-- settings
ZUF_Style = true -- 是否使用清新风格（去除边框）
local ZUF_Gold = nil -- 是否更改边框为金色
local ZUF_Move = nil -- 是否移动头像(命令行 /zuf lock 来解锁；目标头像的偏移同下)
local zUF_Target_OfsX = 250 -- 目标头像水平偏移，zUF默认：280；系统默认：250。
local zUF_Target_HP_Percent = nil -- 是否在目标头像左边显示血量百分比
local zUF_Target_Health = true -- 是否显示目标血量（无法取得时显示为百分比）
local zUF_Target_Mana = true -- 是否显示目标魔法值
local zUF_ClassIcon = true -- 是否显示目标，队友职业图标
local ZUF_PartyText = true -- 是否显示队友等级文字
local zUF_ClassType = nil -- 是否显示目标，队友职业文字

-- localize
local locNotSpecified = ""
local locSpecified = ""
local tmp = GetLocale()
if tmp == "zhCN" then
	locNotSpecified	= "未指定"
	locSpecified	= "变异生物"
elseif tmp == "zhTW" then
	locNotSpecified	= "未指定" -- 也許不正確？
	locSpecified	= "變異生物"
elseif tmp == "enUS" then
	locNotSpecified	= "Not specified" -- maybe not correct
	locSpecified	= "Freak"
end

local function zPrint(msg) DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 0.8, 0.8) end
--[[
	Moving Frame
--]]

local MoveFrame

if ZUF_Move then
	MoveFrame = CreateFrame("Frame","ZUF_MoveFrame",UIParent)
	MoveFrame:SetClampedToScreen(true)
	MoveFrame:EnableMouse(true)
	MoveFrame:SetMovable(true)
	MoveFrame:SetFrameStrata("HIGH")
	MoveFrame:SetFrameLevel(MoveFrame:GetFrameLevel()+2)
	MoveFrame:RegisterForDrag("LeftButton")
	MoveFrame:SetScript("OnDragStart",function() this:StartMoving() end)
	MoveFrame:SetScript("OnDragStop",function() this:StopMovingOrSizing() end)
	MoveFrame:SetWidth(280); MoveFrame:SetHeight(110);
	MoveFrame:SetPoint("TOPLEFT",UIParent,-19,-4)
	MoveFrame:Hide()
	local tex = MoveFrame:CreateTexture(nil,"ARTWORK")
	tex:SetAllPoints(MoveFrame)
	tex:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	tex:SetVertexColor(0,0.8,0.8,0.8)
	tex:Show()
	
	PlayerFrame:SetPoint("TOPLEFT",ZUF_MoveFrame,0,0)
	TargetFrame:SetPoint("TOPLEFT",PlayerFrame,zUF_Target_OfsX + 20,0)
end

--[[
	Slash CMD
--]]
local lock = true
SlashCmdList["ZUF"] = function(msg)
	local _, _, cmd, arg1 = string.find(msg, "(%w+)[ ]?([-%w]*)")
	if (cmd == "lock") then
		if not ZUF_Move then
			zPrint("ZUF: Moving Unit Frame -- Not Enabled !!!")
			return
		end
		if lock then
			lock = nil
			MoveFrame:Show()
			zPrint("ZUF: Start Moving")
		else
			lock = true
			MoveFrame:Hide()
			zPrint("ZUF: Stop Moving")
		end
	end
end

SLASH_ZUF1 = "/zuf";

--[[

--]]
-- override TextStatusBar_UpdateTextString
local function zUpdateTextString(textStatusBar, string, showMax)
	if(string) then
		local value, valueMax
		_, valueMax = textStatusBar:GetMinMaxValues()
		if ( valueMax > 0 ) then
			textStatusBar:Show()
			value = textStatusBar:GetValue()
			if showMax then
				string:SetText(value.."/"..valueMax)
			else
				string:SetText(value)
			end
			-- health percent
			if textStatusBar.PercentText then
				textStatusBar.PercentText:SetText(math.floor(100*value/valueMax).."%")
				textStatusBar.PercentText:SetTextColor(this:GetStatusBarColor())
			end
			string:Show()
		else
			textStatusBar:Hide()
			string:Hide()
		end
	end
end

local globalenv = getfenv()
--[[
	Player Frame
--]]

--[[ BackGround ]]--

-- create extra border
PlayerFrame:CreateTexture("PlayerFrameExtraBorder", "ARTWORK")
PlayerFrameExtraBorder:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
PlayerFrameExtraBorder:SetWidth(52)
PlayerFrameExtraBorder:SetHeight(100)
PlayerFrameExtraBorder:SetPoint("LEFT", PlayerFrame, "RIGHT", -10, 0)
PlayerFrameExtraBorder:SetTexCoord(0.39,0.09375,0,0.78125)

-- backdrop and border texture color
PlayerFrameBackground:SetWidth(166)
if ZUF_Gold then
	PlayerFrameTexture:SetVertexColor(1,0.9,0.2)
	PlayerFrameExtraBorder:SetVertexColor(0.8,0.7,0,0.6)
end

--[[ player text ]]--

-- HP text creation
PlayerFrame:CreateFontString("PlayerFrameHealthBarText2","ARTWORK","TextStatusBarText")
PlayerFrameHealthBarText2:SetPoint("CENTER", PlayerFrameExtraBorder, "CENTER", 2,4)
-- MP text creation
PlayerFrame:CreateFontString("PlayerFrameManaBarText2","ARTWORK","TextStatusBarText")
PlayerFrameManaBarText2:SetTextColor(0.6, 0.9, 1.0)
PlayerFrameManaBarText2:SetPoint("CENTER", PlayerFrameHealthBarText2, "CENTER", 0, -11)

-- hp percent creation
PlayerFrame:CreateFontString("PlayerTitle","ARTWORK","TextStatusBarText")
PlayerTitle:SetPoint("BOTTOM",PlayerFrameHealthBarText2, "TOP", 0, 3)
PlayerFrameHealthBar.PercentText = PlayerTitle

-- TEXT on change
PlayerFrameHealthBar:SetScript("OnValueChanged", function()
	TextStatusBar_UpdateTextString()
	HealthBar_OnValueChanged(arg1,true)
	PlayerFrameHealthBarText2:SetTextColor(this:GetStatusBarColor())
	zUpdateTextString(this, PlayerFrameHealthBarText2)
end)

PlayerFrameManaBar:SetScript("OnValueChanged", function()
	TextStatusBar_UpdateTextString()
	zUpdateTextString(this, PlayerFrameManaBarText2)
end)

--[[
	Target Frame
--]]
MAX_TARGET_DEBUFFS = 32

-- position
if not ZUF_Move then
	TargetFrame:SetPoint("TOPLEFT",zUF_Target_OfsX,-4)
end

-- HP percent
if zUF_Target_HP_Percent then
	TargetFrame:CreateFontString("TargetHealthPercent","ARTWORK","TextStatusBarText")
	TargetFrameHealthBar.PercentText = TargetHealthPercent
	TargetHealthPercent:SetPoint("TOPRIGHT",TargetFrameHealthBar, "TOPLEFT", 0, 0)
	TargetHealthPercent:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	local scale = GetCVar("uiscale")
	if not scale then
		scale = 1
	else
		scale = tonumber(scale)
	end
	if scale < 0.86 then
		TargetHealthPercent:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	end
	TargetFrameHealthBar:SetScript("OnValueChanged", function()
		HealthBar_OnValueChanged(arg1,true)
		local valueMax
		_, valueMax = this:GetMinMaxValues()
		if valueMax > 0 then
			TargetHealthPercent:SetText(math.floor(100*this:GetValue()/valueMax).."%")
			TargetHealthPercent:SetTextColor(this:GetStatusBarColor())
		end
	end)
end

-- Target Health
if zUF_Target_Health then
	TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarText","ARTWORK","TextStatusBarText")
	TargetFrameHealthBarText:SetPoint("RIGHT",TargetFrameHealthBar,0,1)
	TargetFrameHealthBar:SetScript("OnValueChanged", function()
		HealthBar_OnValueChanged(arg1,true)
		zUpdateTextString(this, TargetFrameHealthBarText, true)
		TargetFrameHealthBarText:SetTextColor(this:GetStatusBarColor())
		local vMax
		_, vMax = this:GetMinMaxValues()
		if vMax == 100 then
			TargetFrameHealthBarText:SetText(this:GetValue().."%")
		end
	end)
end

-- Target Mana
if zUF_Target_Mana then
	TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarText","ARTWORK","TextStatusBarText")
	TargetFrameManaBarText:SetPoint("RIGHT",TargetFrameManaBar,0,0)
	TargetFrameManaBar:SetScript("OnValueChanged", function()
		zUpdateTextString(this, TargetFrameManaBarText, true)
	end)
end

--[[ Target Player Class ]]
local zRAID_CLASS_COLORS = {
	["HUNTER"] = { r = 0, g = 1, b = 0 },
	["WARLOCK"] = { r = 0.6, g = 0.33, b = 1 },
	["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0 },
	["PALADIN"] = { r = 1, g = 0.5, b = 0.8 },
	["MAGE"] = { r = 0.0, g = 1, b = 1 },
	["ROGUE"] = { r = 1, g = 1, b = 0.0 },
	["DRUID"] = { r = 1.0, g = 0.5, b = 0.0 },
	["SHAMAN"] = {  r = 0.14, g = 0.35, b = 1.0 },
	["WARRIOR"] = { r = 0.85, g = 0.61, b = 0.43 },
}
if zUF_ClassType then
	TargetFrame:CreateFontString("TargetFrameClassType", "ARTWORK", "SystemFont")
	TargetFrameClassType:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -5, 1)
	TargetFrameClassType:Show()
end

function zUpdateTargetClassType()
	if not zUF_ClassType then
		return
	end
	if UnitIsPlayer("target") then
		local class,classEN = UnitClass("target")
		TargetFrameClassType:SetText(class)
		TargetFrameClassType:SetTextColor(
			zRAID_CLASS_COLORS[classEN].r,
			zRAID_CLASS_COLORS[classEN].g,
			zRAID_CLASS_COLORS[classEN].b)
	else
		TargetFrameClassType:SetTextColor(1.0,0.82,0)
		
		local CreatureType = UnitCreatureType("target")
		if CreatureType == locNotSpecified then
			CreatureType = locSpecified
		end
		if UnitPlayerControlled("target") then
			TargetFrameClassType:SetText(UnitCreatureFamily("target") or CreatureType)
		elseif CreatureType then
			TargetFrameClassType:SetText(CreatureType)
		else
			TargetFrameClassType:SetText("")
			return
		end
	end
end

--[[
	Party Frame
--]]

--[[ party member level and class ]]
for i = 1,4 do
	local str = "PartyMemberFrame"..i
	local text,buff
	
	-- create text string
	if ZUF_PartyText then
		text = getglobal(str):CreateFontString(str.."LevelClass","ARTWORK","GameFontNormalSmall")
		text:SetPoint("TOPLEFT", str, "BOTTOMLEFT", -10, 16)
		text:SetJustifyH("LEFT")
	end
	
	-- Health
	text = getglobal(str):CreateFontString(str.."HealthBarText2","ARTWORK","TextStatusBarText")
	text:SetPoint("TOPLEFT", str, "TOPRIGHT", -10, -13)
	text:SetJustifyH("LEFT")
	getglobal(str.."HealthBar"):SetScript("OnValueChanged", function()
		zUpdateTextString(this, getglobal(this:GetName().."Text2"))
		HealthBar_OnValueChanged(arg1,true)
		PartyMemberHealthCheck()
		getglobal(this:GetName().."Text2"):SetTextColor(this:GetStatusBarColor())
	end)
		
	-- buff
	for j=1,11 do
		buff = CreateFrame("Button", str.."Buff"..j, getglobal(str), "PartyBuffButtonTemplate")
		buff:SetID(j)
		buff:SetScript("OnEnter",function()
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 15, -25)
				GameTooltip:SetUnitBuff("party"..this:GetParent():GetID(), this:GetID())
		end)
		if j == 1 then
			buff:SetPoint("TOPLEFT", str, "TOPLEFT", 48, -30)
		elseif j == 8 then
			buff:SetPoint("TOP",str.."Buff4","BOTTOM",0,0)
		else
			buff:SetPoint("LEFT", str.."Buff"..j-1, "RIGHT", 0, 0)
		end
	end
	
	-- debuff
	local debuffbutton1 = getglobal(str.."Debuff1")
	debuffbutton1:ClearAllPoints()
	debuffbutton1:SetPoint("LEFT", str, "RIGHT", 35, 7)
	for j = 5,8 do
		buff = CreateFrame("Button", str.."Debuff"..j, getglobal(str), "PartyBuffButtonTemplate")
		buff:SetID(j)
		if j == 5 then
			buff:SetPoint("TOP",str.."Debuff1","BOTTOM",0,0)
		else
			buff:SetPoint("LEFT", str.."Debuff"..j-1, "RIGHT", 2, 0)
		end
	end
	
	-- party member tip
	getglobal(str):SetScript("OnEnter",UnitFrame_OnEnter)
end

-- update buffs ( this function is not protected, so just override it )
local zOld_RefreshBuffs = RefreshBuffs
function RefreshBuffs(button, showBuffs, unit)
	local tmp = MAX_PARTY_DEBUFFS
	local icon
	if string.find(unit, "party") and string.len(unit) == 6 then
		MAX_PARTY_DEBUFFS = 8
--~ 		local zShowCastable = true
		for i=1,11 do
			_,_,icon = UnitBuff(unit, i, zShowCastable)
			if ( icon ) then
				globalenv[button:GetName().."Buff"..i.."Icon"]:SetTexture(icon)
				globalenv[button:GetName().."Buff"..i]:Show()
			else
				globalenv[button:GetName().."Buff"..i]:Hide()
			end
		end
	end
	zOld_RefreshBuffs(button, nil, unit)
	MAX_PARTY_DEBUFFS = tmp
end

function zUpdatePartyMemberLevelClass(partyNum)
	local frame = globalenv["PartyMemberFrame"..partyNum]
	if frame:IsShown() then
		if ZUF_PartyText then
			local level = UnitLevel(frame.unit)
			if not level or level < 1 then
				level = "??"
			end
			local class = ""
			if zUF_ClassType then
				class = UnitClass(frame.unit) or "??"
			end
			globalenv[frame:GetName().."LevelClass"]:SetText(level.."\n"..class)
		end
	end
end
--[[
	All the HOOK func replace into this Event Handler, to bypass Secure Problem
--]]
local EventFrame = CreateFrame("Frame",nil,UIParent)
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
EventFrame:RegisterEvent("UNIT_LEVEL")
EventFrame:SetScript("OnEvent",
	function()
		if event == "PLAYER_ENTERING_WORLD" then
			zUpdateTargetClassType()
			zUpdateClassIcon("TargetFrame","target")
			for i = 1,4 do
				zUpdatePartyMemberLevelClass(i)
				zUpdateClassIcon("PartyMemberFrame"..i,"party"..i)
			end
		elseif event == "PLAYER_TARGET_CHANGED" then
			zUpdateTargetClassType()
			zUpdateClassIcon("TargetFrame","target")
		elseif event == "PARTY_MEMBERS_CHANGED" then
			for i = 1,4 do
				zUpdatePartyMemberLevelClass(i)
				zUpdateClassIcon("PartyMemberFrame"..i,"party"..i)
			end
		elseif event == "UNIT_LEVEL" then
			for i = 1,4 do
				if globalenv["PartyMemberFrame"..i].unit == arg1 then
					zUpdatePartyMemberLevelClass(i)
					zUpdateClassIcon("PartyMemberFrame"..i,"party"..i)
				end
			end
		end	
	end)
	
--[[
	Class Icons
--]]
if zUF_ClassIcon then
	local t
	--target
	t = TargetFrameTextureFrame:CreateTexture("TargetFrameClassIcon","OVERLAY")
	t:SetWidth(32); t:SetHeight(32);
	t:SetPoint("BOTTOMLEFT",TargetFrameNameBackground,"TOPRIGHT",-10,-10)
	--party
	for i = 1,4 do
		local partyMember = globalenv["PartyMemberFrame"..i]
		local pvpIcon = globalenv["PartyMemberFrame"..i.."PVPIcon"]
		pvpIcon:SetAlpha(0)
		t = pvpIcon:GetParent():CreateTexture("PartyMemberFrame"..i.."ClassIcon","BORDER")
		t:SetWidth(32); t:SetHeight(32);
		t:SetPoint("CENTER",pvpIcon)
		pvpIcon:SetPoint("TOPLEFT",-9,-10)
	end
end

function zUpdateClassIcon(parentName,unit)
	local icon = globalenv[parentName.."ClassIcon"]
	
	if not icon then
		return
	end

	local iconname
	if UnitIsPlayer(unit) then
		_, iconname = UnitClass(unit)
	end
	if iconname then
		iconname = "Interface\\AddOns\\zUnitFrame\\Icons\\"..iconname
	end
	icon:SetTexture(iconname)
end
