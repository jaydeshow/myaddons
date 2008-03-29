

local moduleName = "Threshold"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Threshold",

	["Health"] = true,
	["Show the line at this amount of health. 0 will hide the line."] = true
} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "警戒线",

	["Health"] = "生命值",
	["Show the line at this amount of health. 0 will hide the line."] = "在生命条上显示一根警戒线. 0 为隐藏"
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "기준선",

	["Health"] = "생명력",
	["Show the line at this amount of health. 0 will hide the line."] = "생명력을 기준선까지만 보여줍니다. 0이되면 사라집니다."
} end)


----------------------------------
--      Local Declaration      --
----------------------------------



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52863 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		add = {
			type  = "text",
			name  = L["Health"],
			desc  = L["Show the line at this amount of health. 0 will hide the line."],
			usage = "",
			get   = "GetSetValue",
			set   = "GetSetValue"
		}
	}
}

plugin.defaultDB = {
	value = 0
}



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	self:RegisterEvent("UNIT_MAXHEALTH", "UpdateUnit")
end


function plugin:OnCreate(frame)
	local line = frame.parts["HealthBar"]:CreateTexture(nil, "OVERLAY")
	line:SetHeight(18)
	line:SetWidth(1)
	line:SetTexture("Interface\\Addons\\BunchOfBars\\Textures\\Charcoal")
	line:SetVertexColor(1, 0, 0, 1)
	line:Hide()

	return line
end


function plugin:OnUpdate(frame, line)
	local m = UnitHealthMax(frame.unit)

	if self.db.profile.value == 0 or self.db.profile.value > m then
		line:Hide()
	else
		local v = (self.db.profile.value / m) * 100

		line:ClearAllPoints()
		line:SetPoint("BOTTOMLEFT", frame.parts["HealthBar"], "BOTTOMLEFT", v, 0)
		line:Show()
	end
end


function plugin:UpdateUnit(unit)
	if self.core.frames[unit] then
		self:OnUpdate(self.core.frames[unit], self.core.frames[unit].parts[self.name])
	end
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetValue(v)
	if type(v) == "nil" then return self.db.profile.value end

	v = tonumber(v)

	if v == nil then -- could not convert
		v = 0
	end

	if self.db.profile.value ~= v then
		self.db.profile.value = v

		self:UpdateAll()
	end
end
