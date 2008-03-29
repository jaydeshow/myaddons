

local moduleName = "Target"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Party Target",

	["Text Justification"] = true,
	["Set the horizontal text justification."] = true,
} end)

L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "队友的目标",

	["Text Justification"] = "文本位置",
	["Set the horizontal text justification."] = "水平方向的文本显示位置",
}end)

----------------------------------
--      Local Declaration      --
----------------------------------

local DogTag = AceLibrary("DogTag-1.0")


----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52894 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		justification = {
			type     = "text",
			name     = L["Text Justification"],
			desc     = L["Set the horizontal text justification."],
			usage    = "",
			validate = { "LEFT", "CENTER", "RIGHT" },
			get      = "GetSetJustification",
			set      = "GetSetJustification"
		}
	}
}

plugin.defaultDB = {
--	format        = "[Target]",
	justification = "RIGHT"
}



----------------------------------
--      Module Functions        --
----------------------------------

function plugin:OnEnable()
	-- stupix fix for removing the "Dead" of just resurrected people, only works if they recieve a buff that boosts their hp
	-- why is there no event for this?
	--self:RegisterBucketEvent("UNIT_MAXHEALTH", 2, "UpdateUnits")
end


function plugin:OnCreate(frame)
	local bar  = frame.parts["HealthBar"]
	local font = bar:CreateFontString(nil, "OVERLAY")
	font:SetFontObject(GameFontHighlightSmall)
	font:SetVertexColor(1, 1, 1, 1)
	font:SetJustifyH(self.db.profile.justification)
	font:ClearAllPoints()
	font:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 2, 3) -- somehow an offset of 3 places the text in the center
	font:SetPoint("TOPRIGHT", bar, "TOPRIGHT", -2, 0)
	font:Show()

	return font
end


function plugin:OnUpdate(frame, font)
	DogTag:RegisterFontString(font, frame, frame.unit, "[Target]")
end


function plugin:OnInactive(frame, font)
	DogTag:UnregisterFontString(font)
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetJustification(v)
	if type(v) == "nil" then return self.db.profile.justification end

	if self.db.profile.justification ~= v then
		self.db.profile.justification = v

		self:UpdateAllWith(function(frame, font)
			font:SetJustifyH(self.db.profile.justification)
		end)
	end
end
