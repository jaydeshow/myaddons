-- Settings --
zUF_ExtraBorder = false			-- true 玩家头像显示扩展边框			false 不显示
local zUF_CanMove = false		-- true 开启头像移动功能				false 关闭
								-- 头像移动命令行：/zuf lock 解锁和锁定；目标头像同时移动。
								-- 不需要移动功能而只使用原始位置时，请设为 false，
								-- 否则队友头像不能自动调整和玩家宠物头像之间的距离。
local zUF_playerHPMP = true		-- true 显示玩家的HP/MP					false 不显示
local zUF_playerHPPct = true	-- true 显示玩家的HP百分比				false 不显示
local zUF_petHPMP = true		-- true 显示玩家宠物的HP/MP				false 不显示
local zUF_targetHPMP = true		-- true 显示目标的HP/MP					false 不显示
local zUF_targetHPPct = true	-- true 显示目标的HP百分比				false 不显示
local zUF_targetType = true		-- true 显示目标玩家种族或生物类型		false 不显示
local zUF_targetClass = true	-- true 显示目标玩家职业（文字）		false 不显示
local zUF_targetIcon = true		-- true 显示目标玩家职业图标			false 不显示
local zUF_ToTHPPct = true		-- true 显示目标的目标的HP百分比		false 不显示
local zUF_partytHPMP = true		-- true 显示队友的HP/MP					false 不显示
local zUF_partyLevel = true		-- true 显示队友等级					false 不显示
local zUF_partyClass = true		-- true 显示队友职业（文字）			false 不显示
local zUF_partyIcon = true		-- true 显示队友职业图标				false 不显示


local function zPrint(msg) DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 0.8, 0.8) end

-- Moving Frame
local MoveFrame
if zUF_CanMove then
	MoveFrame = CreateFrame("Frame", "zUF_MoveFrame", UIParent)
	MoveFrame:SetClampedToScreen(true)
	MoveFrame:EnableMouse(true)
	MoveFrame:SetMovable(true)
	MoveFrame:SetFrameStrata("HIGH")
	MoveFrame:SetFrameLevel(MoveFrame:GetFrameLevel()+2)
	MoveFrame:RegisterForDrag("LeftButton")
	MoveFrame:SetScript("OnDragStart",function() this:StartMoving() end)
	MoveFrame:SetScript("OnDragStop",function() this:StopMovingOrSizing() end)
	MoveFrame:SetWidth(282); MoveFrame:SetHeight(152);
--	MoveFrame:SetPoint("TOPLEFT", UIParent, -19, -4)
	MoveFrame:SetPoint("TOPLEFT", UIParent, 0, 0)
	MoveFrame:Hide()
	local tex = MoveFrame:CreateTexture(nil, "ARTWORK")
	tex:SetAllPoints(MoveFrame)
	tex:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	tex:SetVertexColor(0, 0.8, 0.8, 0.8)
	tex:Show()
--	PlayerFrame:SetPoint("TOPLEFT", zUF_MoveFrame, 0, 0)
	PlayerFrame:SetPoint("TOPLEFT", zUF_MoveFrame, -19, -4)
end

-- Slash CMD
local lock = true
SlashCmdList["ZUF"] = function(msg)
	local _, _, cmd, arg1 = string.find(msg, "(%w+)[ ]?([-%w]*)")
	if (cmd == "lock") then
		if not zUF_CanMove then
			zPrint("zUF: Moving Unit Frame -- Not Enabled !!!")
			return
		end
		if lock then
			lock = nil
			MoveFrame:Show()
			zPrint("zUF: Start Moving")
		else
			lock = true
			MoveFrame:Hide()
			zPrint("zUF: Stop Moving")
		end
	end
end

SLASH_ZUF1 = "/zuf";

-- Basic functions for Display HP/MP
local function zUpdateTextString(textStatusBar, string, showMax)
	local value, valueMax, valuePct
	_, valueMax = textStatusBar:GetMinMaxValues()
	if ( valueMax > 0 ) then
		textStatusBar:Show()
		value = textStatusBar:GetValue()
		if string then
			if showMax then
				string:SetText(value.."/"..valueMax)
			else
				string:SetText(value)
			end
		end
		if textStatusBar.PercentText then
			valuePct = math.floor( 100 * value / valueMax )
			textStatusBar.PercentText:SetText(valuePct.."%")
		end
	else
		textStatusBar:Hide()
	end
end

local globalenv = getfenv()


------------------------------------ Player Frame ------------------------------------

if zUF_playerHPMP then
	PlayerFrame:CreateFontString("playerHealth", "ARTWORK", "GameTooltipTextSmall")
	playerHealth:SetTextColor(1, 0.75, 0)
	
	PlayerFrame:CreateFontString("playerMana", "ARTWORK", "GameTooltipTextSmall")
	playerMana:SetTextColor(0.75, 0.75, 1)
	
	PlayerFrameManaBar:SetScript("OnValueChanged", function()
		TextStatusBar_UpdateTextString()
		zUpdateTextString(this, playerMana, true)
	end)
end

if zUF_playerHPPct then
	PlayerFrame:CreateFontString("playerHealthPct", "ARTWORK", "GameTooltipTextSmall")
	playerHealthPct:SetTextColor(0, 1, 0)
	PlayerFrameHealthBar.PercentText = playerHealthPct
end

PlayerFrameHealthBar:SetScript("OnValueChanged", function()
	TextStatusBar_UpdateTextString()
	HealthBar_OnValueChanged(arg1,true)
	if zUF_playerHPMP then
		zUpdateTextString(this, playerHealth, true)
	else
		zUpdateTextString(this)
	end
end)

if zUF_ExtraBorder then
	PlayerFrame:CreateTexture("PlayerFrameExtraBorder", "ARTWORK")
	PlayerFrameExtraBorder:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
	PlayerFrameExtraBorder:SetWidth(82)
	PlayerFrameExtraBorder:SetHeight(100)
	PlayerFrameExtraBorder:SetPoint("LEFT", PlayerFrame, "RIGHT", -10, 0)
	PlayerFrameExtraBorder:SetTexCoord(0.39, 0.09375, 0, 0.78125)
	PlayerFrameBackground:SetWidth(192)
	if zUF_playerHPMP then
		playerHealth:SetPoint("CENTER", PlayerFrameHealthBar, "RIGHT", 36, 0)
		playerMana:SetPoint("CENTER", PlayerFrameManaBar, "RIGHT", 36, 0)
	end
	if zUF_playerHPPct then
		playerHealthPct:SetPoint("CENTER", PlayerFrameHealthBar, "RIGHT", 36, 15)
	end
elseif zUF_playerHPMP then
	playerHealth:SetPoint("LEFT", PlayerFrameHealthBar, "RIGHT", 5, 0)
	playerMana:SetPoint("LEFT", PlayerFrameManaBar, "RIGHT", 5, 0)
	if zUF_playerHPPct then
		playerHealthPct:SetPoint("BOTTOMLEFT", playerHealth, "TOPLEFT", 0, 3)
	end
elseif zUF_playerHPPct then
	playerHealthPct:SetPoint("LEFT", PlayerFrameHealthBar, "RIGHT", 5, 0)
end


----------------------------------- Pet Frame -------------------------------------

if zUF_petHPMP then
	PetFrame:CreateFontString("petHealth", "ARTWORK", "GameTooltipTextSmall")
	petHealth:SetTextColor(1, 0.75, 0)
	
	PetFrame:CreateFontString("petMana", "ARTWORK", "GameTooltipTextSmall")
	petMana:SetTextColor(0.75, 0.75, 1)
	
	local _, playerClass = UnitClass("player")
	if playerClass == "HUNTER" then
		petHealth:SetPoint("LEFT", PetFrameHealthBar, "RIGHT", 30, 0)
		petMana:SetPoint("LEFT", PetFrameManaBar, "RIGHT", 30, -3)
	else
		petHealth:SetPoint("LEFT", PetFrameHealthBar, "RIGHT", 2, 0)
		petMana:SetPoint("LEFT", PetFrameManaBar, "RIGHT", 2, -3)
	end
	
	PetFrameHealthBar:SetScript("OnValueChanged", function()
		TextStatusBar_UpdateTextString()
		HealthBar_OnValueChanged(arg1, true)
		zUpdateTextString(this, petHealth, true)
	end)
	
	PetFrameManaBar:SetScript("OnValueChanged", function()
		TextStatusBar_UpdateTextString()
		zUpdateTextString(this, petMana, true)
	end)
end

local buff
-- Buffs
for i = 1, 10 do
	buff = CreateFrame("Button", "PetFrameBuff"..i, PetFrame, "PartyPetBuffButtonTemplate")
	buff:SetID(i)
	buff:SetScript("OnEnter",function()
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
		GameTooltip:SetUnitBuff("pet", this:GetID())
	end)
	if i == 1 then
		buff:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 48, -42)
	else
		buff:SetPoint("LEFT", "PetFrameBuff"..i-1, "RIGHT", 2, 0)
	end
end

-- Debuffs
PetFrameDebuff1:ClearAllPoints()
PetFrameDebuff1:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 48, -59)
for i = 5, 10 do
	buff = CreateFrame("Button", "PetFrameDebuff"..i, PetFrame, "PartyPetBuffButtonTemplate")
	buff:SetID(i)
	buff:SetPoint("LEFT", "PetFrameDebuff"..i-1, "RIGHT", 2, 0)
end

-- Adjust Gap between Pet and PartyMemberFrame1 if not zUF_CanMove
function zAdjustPetPartyGap()
	if zUF_CanMove then
		return
	end
	local yOffset = -128
	if UnitIsVisible("pet") then
		yOffset = yOffset - 24
		if zUF_PlayerFrameXPRP then
			yOffset = yOffset - 12
		end
	end
	PartyMemberFrame1:SetPoint("TOPLEFT", 10, yOffset)
end

-------------------------------------------- Target Frame -------------------------------------------

MAX_TARGET_DEBUFFS = 32

if zUF_targetHPMP then
	TargetFrameTextureFrame:CreateFontString("targetHealth", "ARTWORK", "GameFontNormalSmall")
	targetHealth:SetTextColor(1, 1, 1, 0.9)
	targetHealth:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)

	TargetFrameTextureFrame:CreateFontString("targetMana","ARTWORK","GameFontNormalSmall")
	targetMana:SetTextColor(1, 1, 1, 0.9)
	targetMana:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)

	TargetFrameManaBar:SetScript("OnValueChanged", function()
		zUpdateTextString(this, targetMana, true)
		if MobHealth3BlizzardPowerText or MI2_MobManaText then
			targetMana:SetText("")
		end
	end)
end

if zUF_targetHPPct then
	TargetFrame:CreateFontString("targetHealthPct", "ARTWORK", "GameTooltipTextSmall")
	targetHealthPct:SetTextColor(1, 0.75, 0)
	targetHealthPct:SetPoint("RIGHT", TargetFrameHealthBar, "LEFT", -5, 0)
	TargetFrameHealthBar.PercentText = targetHealthPct
end

TargetFrameHealthBar:SetScript("OnValueChanged", function()
	HealthBar_OnValueChanged(arg1, true)
	if zUF_targetHPMP then
		zUpdateTextString(this, targetHealth, true)
		local _, vMax = this:GetMinMaxValues()
		if MobHealth3BlizzardHealthText or MI2_MobHealthText or UnitIsDead("target") or vMax == 100 or (MobHealth_GetTargetCurHP and UnitCanAttack("player", "target") and not UnitIsDead("target") and not UnitIsFriend("player", "target")) then
			targetHealth:SetText("")
		end
	else
		zUpdateTextString(this)
	end
end)

-- Adjust Gap between Player and Target
local xOffset = 250
if zUF_ExtraBorder then
	xOffset = xOffset + 35
elseif zUF_playerHPMP then
	xOffset = xOffset + 30
end
if zUF_targetHPPct then
	xOffset = xOffset + 25
	if not zUF_ExtraBorder and not zUF_playerHPMP and not zUF_playerHPPct then
		xOffset = xOffset - 25
	end
end
TargetFrame:SetPoint("TOPLEFT", PlayerFrame, xOffset + 19, 0)

-- Type/Class --
if zUF_targetClass then
	TargetFrame:CreateFontString("TargetFrameClass", "ARTWORK", "GameFontNormalSmall")
	TargetFrameClass:SetPoint("BOTTOMRIGHT", TargetFrameNameBackground, "TOPRIGHT", -5, 1)
end

if zUF_targetType then
	TargetFrame:CreateFontString("TargetFrameType", "ARTWORK", "GameTooltipTextSmall")
	TargetFrameType:SetPoint("BOTTOMLEFT", TargetFrameNameBackground, "TOPLEFT", 0, 3)
	TargetFrameType:SetTextColor(1, 0.75, 0)
end

function zUpdateTargetClassType()
	if zUF_targetClass then
		local class, classEN = UnitClass("target")
		if UnitIsPlayer("target") then
			local color = RAID_CLASS_COLORS[classEN]
			TargetFrameClass:SetTextColor(color.r, color.g, color.b)
		else
			class = ""
		end
		TargetFrameClass:SetText(class)
	end
	if zUF_targetType then
		local type = ""
		if UnitIsPlayer("target") then
			type = UnitRace("target")
		elseif UnitPlayerControlled("target") then
			if UnitCreatureFamily("target") then
				type = UnitCreatureFamily("target")
			end
		elseif UnitCreatureType("target") then
			type = UnitCreatureType("target")
		end
		TargetFrameType:SetText(type)
	end
end

-------------------------------------- TargetofTarget Frame --------------------------------------

if zUF_ToTHPPct then
	TargetofTargetTextureFrame:CreateFontString("targettargetHPPct", "ARTWORK", "GameTooltipTextSmall")
	targettargetHPPct:SetPoint("BOTTOMLEFT", TargetofTargetHealthBar, "TOPRIGHT", 0, 5)
	TargetofTargetHealthBar.PercentText = targettargetHPPct
	
	TargetofTargetHealthBar:SetScript("OnValueChanged", function()
		HealthBar_OnValueChanged(arg1, true)
--		zUpdateTextString(this)
		local _, maxValue = this:GetMinMaxValues()
		local currValue = this:GetValue()
		local pctValue = math.floor( 100 * currValue / maxValue )
		if ( maxValue > 0 ) and ( pctValue < 100 ) and ( pctValue > 0 ) then
			targettargetHPPct:SetText(pctValue.."%")
		else
			targettargetHPPct:SetText("")
		end
	end)
end

------------------------------------------- Party Frame ----------------------------------------------

for i = 1, 4 do
	local str = "PartyMemberFrame"..i
	local unit = "party"..i
-- Level
	if zUF_partyLevel then
		local text = getglobal(str):CreateFontString(str.."Level", "ARTWORK", "GameFontNormalSmall")
		text:SetPoint("TOPLEFT", str, "BOTTOMLEFT", -10, 16)
		text:SetJustifyH("LEFT")
	end
-- Class
	if zUF_partyClass then
		text = getglobal(str):CreateFontString(str.."Class", "ARTWORK", "GameFontNormalSmall")
		text:SetPoint("TOPLEFT", str, "BOTTOMLEFT", -10, 4)
		text:SetJustifyH("LEFT")
	end
	if zUF_partytHPMP then
-- Health
		text = getglobal(str):CreateFontString(unit.."Health", "ARTWORK", "GameTooltipTextSmall")
		text:SetPoint("LEFT", str.."HealthBar", "RIGHT", 3, 0)
		text:SetTextColor(1, 0.75, 0)
		getglobal(str.."HealthBar"):SetScript("OnValueChanged", function()
			zUpdateTextString(this, getglobal(unit.."Health"), true)
			HealthBar_OnValueChanged(arg1, true)
			PartyMemberHealthCheck()
		end)
-- Mana
		text = getglobal(str):CreateFontString(unit.."Mana", "ARTWORK", "GameTooltipTextSmall")
		text:SetPoint("LEFT", str.."ManaBar", "RIGHT", 3, 0)
		text:SetTextColor(0.75, 0.75, 1)
		getglobal(str.."ManaBar"):SetScript("OnValueChanged", function()
			zUpdateTextString(this, getglobal(unit.."Mana"), true)
		end)
	end
-- Buff
	for j = 1, 16 do
		buff = CreateFrame("Button", str.."Buff"..j, getglobal(str), "PartyBuffButtonTemplate")
		buff:SetID(j)
		buff:SetScript("OnEnter",function()
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 15, -25)
				GameTooltip:SetUnitBuff("party"..this:GetParent():GetID(), this:GetID())
		end)
		if j == 1 then
			buff:SetPoint("TOPLEFT", str, "TOPLEFT", 48, -32)
		else
			buff:SetPoint("LEFT", str.."Buff"..j-1, "RIGHT", 2, 0)
		end
	end
-- Debuff
	local debuffbutton1 = getglobal(str.."Debuff1")
	debuffbutton1:ClearAllPoints()
	debuffbutton1:SetPoint("LEFT", str, "RIGHT", 22, 25)
	for j = 5, 10 do
		buff = CreateFrame("Button", str.."Debuff"..j, getglobal(str), "PartyBuffButtonTemplate")
		buff:SetID(j)
		buff:SetPoint("LEFT", str.."Debuff"..j-1, "RIGHT", 2, 0)
	end
-- PartyMember Tip
	getglobal(str):SetScript("OnEnter", UnitFrame_OnEnter)
end

-- Level/Class
function zUpdatePartyMemberLevelClass(partyNum)
	local frame = globalenv["PartyMemberFrame"..partyNum]
	if frame:IsShown() then
		if zUF_partyLevel then
			local level = UnitLevel(frame.unit)
			if not level or level < 1 then
				level = "??"
			end
			globalenv[frame:GetName().."Level"]:SetText(level)
		end
		if zUF_partyClass then
			local class, classEN = UnitClass(frame.unit)
			if UnitClass(frame.unit) then
				local color = RAID_CLASS_COLORS[classEN]
				globalenv[frame:GetName().."Class"]:SetTextColor(color.r, color.g, color.b)
			else
				class = "??"
				globalenv[frame:GetName().."Class"]:SetTextColor(1, 0.75, 0)
			end
			globalenv[frame:GetName().."Class"]:SetText(class)
		end
	end
end

-- Hide BuffTooltip
function PartyMemberBuffTooltip_Update(isPet)
	--
end

-- Update Buffs of Pet and Party
local zOld_RefreshBuffs = RefreshBuffs
function RefreshBuffs(button, showBuffs, unit)
	local tmp = MAX_PARTY_DEBUFFS
	if string.find(unit, "party") and string.len(unit) == 6 then
		MAX_PARTY_DEBUFFS = 10
--~ 	local zShowCastable = true
		for i = 1, 16 do
			_, _, buff = UnitBuff(unit, i, zShowCastable)
			if buff then
				globalenv[button:GetName().."Buff"..i.."Icon"]:SetTexture(buff)
				globalenv[button:GetName().."Buff"..i.."Border"]:Hide()
				globalenv[button:GetName().."Buff"..i]:Show()
			else
				globalenv[button:GetName().."Buff"..i]:Hide()
			end
		end
	elseif unit == "pet" then
		MAX_PARTY_DEBUFFS = 10
		for i = 1, 10 do
			_, _, buff = UnitBuff("pet", i)
			if buff then
				globalenv[button:GetName().."Buff"..i.."Icon"]:SetTexture(buff)
				globalenv[button:GetName().."Buff"..i.."Border"]:Hide()
				globalenv[button:GetName().."Buff"..i]:Show()
			else
				globalenv[button:GetName().."Buff"..i]:Hide()
			end
		end
	end
--	zOld_RefreshBuffs(button, showBuffs, unit)
	zOld_RefreshBuffs(button, nil, unit)
	MAX_PARTY_DEBUFFS = tmp
end


-------------------------------------- Event Handler -------------------------------------

local EventFrame = CreateFrame("Frame", nil, UIParent)
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
EventFrame:RegisterEvent("UNIT_LEVEL")
EventFrame:RegisterEvent("UNIT_PET")
EventFrame:SetScript("OnEvent",
	function()
		if event == "PLAYER_ENTERING_WORLD" then
			if not zUF_CanMove then
				zAdjustPetPartyGap()
			end
			zUpdateTargetClassType()
			zUpdateClassIcon("TargetFrame", "target")
			for i = 1, 4 do
				zUpdatePartyMemberLevelClass(i)
				zUpdateClassIcon("PartyMemberFrame"..i, "party"..i)
			end
		elseif event == "PLAYER_TARGET_CHANGED" then
			zUpdateTargetClassType()
			zUpdateClassIcon("TargetFrame", "target")
		elseif event == "PARTY_MEMBERS_CHANGED" then
			for i = 1, 4 do
				zUpdatePartyMemberLevelClass(i)
				zUpdateClassIcon("PartyMemberFrame"..i, "party"..i)
			end
		elseif event == "UNIT_LEVEL" then
			for i = 1, 4 do
				if globalenv["PartyMemberFrame"..i].unit == arg1 then
					zUpdatePartyMemberLevelClass(i)
--					zUpdateClassIcon("PartyMemberFrame"..i, "party"..i)
				end
			end
		elseif event == "UNIT_PET" and not zUF_CanMove then
			zAdjustPetPartyGap()
		end
	end)


----------------------------------------- Class Icon ----------------------------------------

local t
-- Target Class Icon
if zUF_targetIcon then
	t = TargetFrameTextureFrame:CreateTexture("TargetFrameClassIcon", "OVERLAY")
	t:SetWidth(32); t:SetHeight(32);
	t:SetPoint("BOTTOMLEFT", TargetFrameNameBackground, "TOPRIGHT", -7, -10)
end

-- Party Class Icon
if zUF_partyIcon then
	for i = 1, 4 do
--		local partyMember = globalenv["PartyMemberFrame"..i]
		local pvpIcon = globalenv["PartyMemberFrame"..i.."PVPIcon"]
		pvpIcon:SetAlpha(0)
		t = pvpIcon:GetParent():CreateTexture("PartyMemberFrame"..i.."ClassIcon", "BORDER")
		t:SetWidth(32); t:SetHeight(32);
		t:SetPoint("CENTER", pvpIcon)
		pvpIcon:SetPoint("TOPLEFT", -9, -10)
	end
end

function zUpdateClassIcon(parentName, unit)
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