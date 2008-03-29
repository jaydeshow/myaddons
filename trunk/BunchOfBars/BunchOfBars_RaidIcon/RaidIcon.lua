

local moduleName = "RaidIcon"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Raid Icons",

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
	[moduleName] = "团队图标",

	["Justification"] = "位置",
	["Set the horizontal justification."] = "水平方向的显示位置",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右"

}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "공격대 징표",

	["Justification"] = "표시",
	["Set the horizontal justification."] = "수평 위치를 설정합니다."
} end)



----------------------------------
--      Local Declaration      --
----------------------------------



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52895 $"):match("%d+"))

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
	justification = L["LEFT"]
}



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAll")
end


function plugin:OnCreate(frame)
	local icon = frame.parts["HealthBar"]:CreateTexture(nil, "OVERLAY")
	icon:SetHeight(14)
	icon:SetWidth(14)
	icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	self:SetPoints(frame, icon)
	icon:Hide()

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


function plugin:OnUpdate(frame, icon)
	local i = GetRaidTargetIndex(frame.unit)

	if i then
		SetRaidTargetIconTexture(icon, i)
		icon:Show()
	else
		icon:Hide()
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
