

local moduleName = "UnitName"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Unit Name",

	["'Status colored Name'"] = true,
	["'(AFK/Offline)' 'Classcolored Name'"] = true,
	["'Classcolored Name'"] = true,
	["AFK/Offline"] = true,

	["Text Format"] = true,

	["Predefined Formats"] = true,
	["Choose from a set of prefedined formats."] = true,

	["Text Justification"] = true,
	["Set the horizontal text justification."] = true,

	["Width"] = true,
	["Width of the text area."] = true
} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "角色名",

	["'Status colored Name'"] = "彩色状态名",
	["'(AFK/Offline)' 'Classcolored Name'"] = "'(AFK/离线)' '彩色的角色名'",
	["'Classcolored Name'"] = "彩色角色名",
	["AFK/Offline"] = "'AFK/离线/死亡/...'",

	["Text Format"] = "文本格式",

	["Predefined Formats"] = "预置格式",
	["Choose from a set of prefedined formats."] = "选择一个预置的格式",

	["Text Justification"] = "文本位置",
	["Set the horizontal text justification."] = "水平方向的文本显示位置",

	["Width"] = "宽",
	["Width of the text area."] = "文本显示宽度"
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "유닛 이름",

	["'Status colored Name'"] = "'색상화된 이름'",
	["'(AFK/Offline)' 'Classcolored Name'"] = "'자리비움/오프라인' '클래스별 이름'",
	["'Classcolored Name'"] = "'색상화된 이름'",

	["Text Format"] = "글자 설정",

	["Predefined Formats"] = "정의된 설정",
	["Choose from a set of prefedined formats."] = "미리 정의된 설정을 사용합니다.",

	["Text Justification"] = "글자 정의",
	["Set the horizontal text justification."] = "표시하고 싶은 글자를 정의합니다."
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local DogTag = AceLibrary("DogTag-1.0")


local formats = {
	["[RaidGroup:Bracket][~RaidGroup?Leader?Text(*)][[Offline:AFK]?Name:Gray!Name:ClassColor]"]      = L["'Status colored Name'"],
	["[RaidGroup:Bracket][~RaidGroup?Leader?Text(*)][[Offline:AFK]:Trunc(2):Red] [Name:ClassColor]"] = L["'(AFK/Offline)' 'Classcolored Name'"],
	["[RaidGroup:Bracket][Name:ClassColor]"] = L["'Classcolored Name'"],
	["[RaidGroup:Bracket][[Offline:AFK:HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]:Trunc(2):Red]"] = L["AFK/Offline"]

}

local formatsdesc = { }
do
	for k in pairs(formats) do
		formatsdesc[k] = k
	end
end



----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BunchOfBars:NewModule(moduleName)

plugin.revision = tonumber(("$Revision: 52894 $"):match("%d+"))

plugin.options = {
	name = L[moduleName],
	args = {
		format = {
			type  = "text",
			name  = L["Text Format"],
			desc  = L["Text Format"],
			usage = "DogTag-1.0 tags. See http://www.wowace.com/wiki/DogTag-1.0/Tags",
			get   = "GetSetFormat",
			set   = "GetSetFormat"
		},
		preformats = {
			type  = "text",
			name  = L["Predefined Formats"],
			desc  = L["Choose from a set of prefedined formats."],
			usage = "",
			validate     = formats,
			validateDesc = formatsdesc,
			get = "GetSetFormat",
			set = "GetSetFormat"
		},
		justification = {
			type     = "text",
			name     = L["Text Justification"],
			desc     = L["Set the horizontal text justification."],
			usage    = "",
			validate = { "LEFT", "CENTER", "RIGHT" },
			get      = "GetSetJustification",
			set      = "GetSetJustification"
		},
		width = {
			type = "range",
			name = L["Width"],
			desc = L["Width of the text area."],
			min = 40,
            		max = 300,
            		step = 5,
           		get = "GetSetWidth",
            		set = "GetSetWidth",
		}
	}
}

plugin.defaultDB = {
	position = 1,

	format        = "[RaidGroup:Paren][~RaidGroup?Leader?Text(*)][[Offline:AFK]?Name:Gray!Name:ClassColor]",
	justification = "RIGHT",
	width         = 100
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
	local font = frame:CreateFontString(nil, "OVERLAY")
	font:SetFontObject(GameFontNormalSmall)
	font:SetWidth(self.db.profile.width)
	font:SetHeight(14)
	font:SetVertexColor(1, 1, 1, 1)
	font:SetJustifyH(self.db.profile.justification)

	return font
end


function plugin:OnUpdate(frame, font)
	DogTag:RegisterFontString(font, frame, frame.unit, self.db.profile.format)
end


function plugin:OnInactive(frame, font)
	DogTag:UnregisterFontString(font)
end



----------------------------------
--      Option Handlers         --
----------------------------------

function plugin:GetSetFormat(v)
	if type(v) == "nil" then return self.db.profile.format end

	-- this check is to assure we don't update to often
	if self.db.profile.format ~= v then
		self.db.profile.format = DogTag:FixCasing(v)

		self:UpdateAll()
	end
end


function plugin:GetSetJustification(v)
	if type(v) == "nil" then return self.db.profile.justification end

	if self.db.profile.justification ~= v then
		self.db.profile.justification = v

		self:UpdateAllWith(function(frame, font)
			font:SetJustifyH(self.db.profile.justification)
		end)
	end
end


function plugin:GetSetWidth(v)
	if type(v) == "nil" then return self.db.profile.width end

	if self.db.profile.width ~= v then
		self.db.profile.width = v

		self:UpdateAllWith(function(frame, font)
			font:SetWidth(self.db.profile.width)
		end)
	end
end
