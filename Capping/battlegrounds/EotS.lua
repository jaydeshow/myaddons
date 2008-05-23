local Capping = Capping
local self = Capping
local L = CappingLocale

local ef, eficon, eftext, carrier, cclass
local elap = 0

-- handles secure stuff
local function SetEotSCarrierAttribute()
	ef:SetAlpha(1)
	ef:SetFrameStrata("HIGH")
	ef:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame1:GetRight() - 14, AlwaysUpFrame1:GetBottom() + 8.5)
	ef:SetAttribute("macrotext", format("/target %s", carrier or ""))
end
-- resets carrier display
local function ResetCarrier(captured)
	carrier, ef.faction, ef.car = nil, nil, nil
	eftext:SetText("")
	eficon:Hide()
	if captured then
		self:StartBar(L["Flag respawns"], 9, 9, self:GetIconData(strlower(UnitFactionGroup("player")), "flag"), "info2")
	end
	self:CheckCombat(SetEotSCarrierAttribute)
end
local function CarrierOnClick(this)
	if IsControlKeyDown() and carrier then
		SendChatMessage(format(L["%s's flag carrier: %s (%s)"], L[this.faction], carrier, cclass), "BATTLEGROUND")
	end
end
-- parse battleground messages
local function EotSFlag(a1, faction)
	if strfind(a1, L["^(.+) has taken the flag!"]) then
		local name = strmatch(a1, L["^(.+) has taken the flag!"])
		if name == "L'Alliance" then  -- frFR
			ResetCarrier(true)
		else
			cclass = self:GetClassByName(name, faction)
			carrier, ef.car = name, true
			ef.faction = (faction == 0 and "Horde") or "Alliance"
			ef:SetAlpha(0.6)
			eftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(cclass), carrier or "")
			eficon:SetTexture((faction == 0 and "Interface\\WorldStateFrame\\HordeFlag") or "Interface\\WorldStateFrame\\AllianceFlag")
			eficon:Show()
			self:CheckCombat(SetEotSCarrierAttribute)
		end
	elseif strfind(a1, L["dropped"]) then
		ResetCarrier()
	elseif strfind(a1, L["captured the"]) or strfind(a1, L["has taken the"]) then
		ResetCarrier(true)
	end
end

----------------------------
function Capping:StartEotS()
----------------------------
	if not ef then
		ef = self:CreateCarrierButton("CappingEotSFrame", 132, 18, CarrierOnClick)
		ef:SetScript("OnUpdate", function(this, a1)
			elap = elap + a1
			if elap < 10 then return end
			elap = 0
			RequestBattlefieldScoreData()
		end)

		eficon = ef:CreateTexture(nil, "ARTWORK")  -- flag icon
		eficon:SetPoint("TOPLEFT", ef, "TOPLEFT", 0, 1)
		eficon:SetPoint("BOTTOMRIGHT", ef, "BOTTOMLEFT", 20, -1)

		eftext = self:CreateText(ef, 13, "LEFT", eficon, 22, 0, ef, 0, 0)  -- carrier text
		ef.text = eftext

		-- add to the tohide list (frames that are hidden after bg exit and that are protected)
		self:AddFrameToHide(ef)
	end
	ef:Show()
	ResetCarrier()
	
	-- setup for final score estimation (2 for EotS)
	self:NewEstimator(2)
	self:RegisterTempEvent("UPDATE_WORLD_STATES")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "HFlagUpdate")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "AFlagUpdate")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")

	-- makes sure GetBattlefieldScore will return correct data
	RequestBattlefieldScoreData()
end

--------------------------------
function Capping:HFlagUpdate(a1)
--------------------------------
	EotSFlag(a1, 0)
end

--------------------------------
function Capping:AFlagUpdate(a1)
--------------------------------
	EotSFlag(a1, 1)
end

