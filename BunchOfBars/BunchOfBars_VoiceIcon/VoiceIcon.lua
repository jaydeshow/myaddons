

local moduleName = "VoiceIcon"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Voice Icon",

	["Justification"] = true,
	["Set the horizontal justification."] = true,

	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true

} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "语音图标",

	["Justification"] = "位置",
	["Set the horizontal justification."] = "水平方向的显示位置",

	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右"

}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "음성채팅 아이콘",

	["Justification"] = "표시",
	["Set the horizontal justification."] = "아이콘 위치를 설정합니다."
} end)

----------------------------------
--      Local Declaration      --
----------------------------------



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 54155 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		justification = {
			type     = "text",
			name     = L["Justification"],
			desc     = L["Set the horizontal justification."],
			usage    = "",
			validate = { L["LEFT"], L["CENTER"], L["RIGHT"] },
			get      = "GetSetJustification",
			set      = "GetSetJustification"
		}
	}
}

plugin.defaultDB = {
	justification = L["CENTER"]
}



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:RegisterEvent("VOICE_START")
	self:RegisterEvent("VOICE_STOP")
end


function plugin:OnCreate(frame)
	local icon = frame.parts["HealthBar"]:CreateTexture(nil, "OVERLAY")
	icon:SetHeight(14)
	icon:SetWidth(14)
	icon:SetTexture("Interface\\Common\\VoiceChat-Speaker")
	icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
	self:SetPoints(frame, icon)
	icon:Hide()

	local wave = frame.parts["HealthBar"]:CreateTexture(nil, "OVERLAY")
	wave:SetHeight(14)
	wave:SetWidth(14)
	wave:SetTexture("Interface\\Common\\VoiceChat-On")
	wave:SetTexCoord(0.04, 0.96, 0.04, 0.96)
	self:SetPoints(frame, wave)
	wave:Hide()

	icon.wave = wave

	return icon
end


function plugin:SetPoints(frame, icon)
	icon:ClearAllPoints()

	if self.db.profile.justification == L["LEFT"] then
		icon:SetPoint("BOTTOMLEFT", frame.parts["HealthBar"], "BOTTOMLEFT", 2, 2)
	elseif self.db.profile.justification == L["CENTER"] then
		icon:SetPoint("CENTER", frame.parts["HealthBar"], "CENTER", 0, 2)
	else
		icon:SetPoint("BOTTOMRIGHT", frame.parts["HealthBar"], "BOTTOMRIGHT", -2, 2)
	end
end


function plugin:VOICE_START(unit)
	--[[local mode
	local _, it = IsInInstance()
	
	if it == "pvp" or it == "arena" then
		mode = "Battleground"
	elseif GetNumRaidMembers() > 0 then
		mode = "raid"
	else
		mode = "party"
	end

	if self.core.frames[unit] and not GetMuteStatus(unit, mode) then]]--
	if self.core.frames[unit] then
		self.core.frames[unit].parts[self.name]:Show()
		self.core.frames[unit].parts[self.name].wave:Show()
	end
end


function plugin:VOICE_STOP(unit)
	if self.core.frames[unit] then
		self.core.frames[unit].parts[self.name]:Hide()
		self.core.frames[unit].parts[self.name].wave:Hide()
	end
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetJustification(v)
	if type(v) == "nil" then return self.db.profile.justification end

	if self.db.profile.justification ~= v then
		self.db.profile.justification = v

		self:UpdateAllWith("SetPoints")
	end
end
