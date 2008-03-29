local Capping = Capping
local self = Capping
local L = CappingLocale

local ef, eficon, eftext, icon
local SetEotSCarrierAttribute

----------------------------
function Capping:StartEotS()
----------------------------
	if not ef then
		icon = strlower(UnitFactionGroup("player"))
		self:CreateEotSFrame()
	end

	-- show and reset carrier frame
	ef:Show()
	eftext:SetText("")
	eficon:Hide()
	carrier = nil
	SetEotSCarrierAttribute()

	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "HFlagUpdate")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "AFlagUpdate")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")

	-- setup for final score estimation (2 for EotS)
	self:NewEstimator(2)
	self:RegisterTempEvent("UPDATE_WORLD_STATES")

	-- makes sure GetBattlefieldScore will return correct data
	RequestBattlefieldScoreData()
end

--------------------------------
function Capping:HFlagUpdate(a1)
--------------------------------
	self:EotSFlag(a1, 0)
end

--------------------------------
function Capping:AFlagUpdate(a1)
--------------------------------
	self:EotSFlag(a1, 1)
end
-- carrier detection and setup handlers
-- only have to deal with one carrier at a time
--------------------------------------
function Capping:EotSFlag(a1, faction)
--------------------------------------
	if strfind(a1, L["^(.+) has taken the flag!"]) then
		local _,_,name = strfind(a1, L["^(.+) has taken the flag!"])
		if GetLocale() == "frFR" and name == "L'Alliance" then
			carrier = nil
			eftext:SetText("")
			eficon:Hide()
			self:CheckCombat(SetEotSCarrierAttribute)

			self:AllowEstimatedBarUpdate()
			self:StartBar(L["Flag respawns"], 9, self:GetIconData(icon, "flag"), "info1")
		else
			local class = self:GetClassByName(name, faction)
			carrier = name or ""
			eftext:SetFormattedText("|cff%s%s|r", self:GetClassColorHex(class), carrier)
			ef:SetAlpha(0.6)
			if faction == 0 then
				eficon:SetTexture("Interface\\WorldStateFrame\\HordeFlag")
			else
				eficon:SetTexture("Interface\\WorldStateFrame\\AllianceFlag")
			end
			eficon:Show()
			self:CheckCombat(SetEotSCarrierAttribute)
		end
	elseif strfind(a1, L["dropped"]) then
		carrier = nil
		eftext:SetText("")
		eficon:Hide()
		self:CheckCombat(SetEotSCarrierAttribute)

	elseif strfind(a1, L["captured the"]) or strfind(a1, L["has taken the"]) then
		carrier = nil
		eftext:SetText("")
		eficon:Hide()
		self:CheckCombat(SetEotSCarrierAttribute)

		self:AllowEstimatedBarUpdate()
		self:StartBar(L["Flag respawns"], 9, self:GetIconData(icon, "flag"), "info1")
	end
end


-- needed so that AlwaysUpFrame is not forced to be secure
local function CarrierPosition()
	ef:SetPoint("LEFT", UIParent, "BOTTOMLEFT", AlwaysUpFrame1:GetRight() - 14, AlwaysUpFrame1:GetBottom() + 8.5)
end
local elap = 0
----------------------------------
function Capping:CreateEotSFrame()
----------------------------------
	ef = CreateFrame("Button", "CappingEotSFrame", UIParent, "SecureActionButtonTemplate")
	ef:SetHeight(18)
	ef:SetWidth(120)
	ef:RegisterForClicks("LeftButtonUp")
	ef:SetAttribute("type1", "macro")
	ef:SetAttribute("macrotext", "")
	ef:SetScript("OnUpdate", function(this, a1)
		elap = elap + a1
		if elap < 10 then return end
		elap = 0
		RequestBattlefieldScoreData()
	end)

	eficon = ef:CreateTexture(nil, "ARTWORK")
	eficon:ClearAllPoints()
	eficon:SetPoint("TOPLEFT", ef, "TOPLEFT", -2, 2)
	eficon:SetPoint("BOTTOMRIGHT", ef, "BOTTOMLEFT", 20, -2)
	eficon:Hide()

	eftext = ef:CreateFontString(nil, "OVERLAY")
	eftext:SetFont(GameFontHighlightSmall:GetFont(), 13)
	eftext:SetJustifyH("LEFT")
	eftext:ClearAllPoints()
	eftext:SetPoint("TOPLEFT", eficon, "TOPRIGHT")
	eftext:SetPoint("BOTTOMRIGHT", ef, "BOTTOMRIGHT")
	eftext:SetShadowColor(0,0,0)
	eftext:SetShadowOffset(1,-1)

	-- in case someone wants to access these
	ef.icon, ef.text = eficon, eftext
	
	-- add to the tohide list (frames that are hidden after bg exit and that are protected)
	self:AddFrameToHide(ef)
	
	CarrierPosition()
end

function SetEotSCarrierAttribute()
	ef:SetAlpha(1)
	ef:SetFrameStrata("HIGH")
	CarrierPosition()
	if carrier then
		ef:SetAttribute("macrotext", format("/target %s", carrier))
	else
		ef:SetAttribute("macrotext", "")
	end
end
