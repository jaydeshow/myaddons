

local moduleName = "HealthBarText"



----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBars"..moduleName)

L:RegisterTranslations("enUS", function() return {
	[moduleName] = "Health Bar Text",

	["'AFK/Offline/Dead/Feigned/...'"] = true,
	["'Dead/Feigned/...' or 'Health status' on mouseover"] = true,
	["'Dead/Feigned/...' or 'Health status'"] = true,
--	["'Status colored Name' followed by 'Mana %' while not Dead or AFK"] = true,
	["'Classcolored Name' and 'Dead/Feigned/...' or 'Health status'"] = true,
	["'Status colored Name' and 'Dead/Feigned/...' or 'Health status'"] = true,

	["Text Format"] = true,

	["Predefined Formats"] = true,
	["Choose from a set of prefedined formats."] = true,

	["Text Justification"] = true,
	["Set the horizontal text justification."] = true,
} end)

--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	[moduleName] = "生命条的文字内容",

	["'AFK/Offline/Dead/Feigned/...'"] = "'AFK/离线/死亡/假死/...'",
	["'Dead/Feigned/...' or 'Health status' on mouseover"] = "鼠标提示:'死亡/假死/...'或者'生命值情况'",
	["'Dead/Feigned/...' or 'Health status'"] = "'死亡/假死/...'或者'生命值情况'",
--	["'Status colored Name' followed by 'Mana %' while not Dead or AFK"] = "在没有死亡或者AFK的状态下,根据法力值的百分比改变角色名字的颜色",
	["'Classcolored Name' and 'Dead/Feigned/...' or 'Health status'"] = "'彩色角色名''死亡/假死/...'或者'生命值情况'",
	["'Status colored Name' and 'Dead/Feigned/...' or 'Health status'"] = "'彩色状态名''死亡/假死/...'或者'生命值情况'",

	["Text Format"] = "文本格式",

	["Predefined Formats"] = "预置格式",
	["Choose from a set of prefedined formats."] = "选择一个预置格式",

	["Text Justification"] = "文本位置",
	["Set the horizontal text justification."] = "水平方向的文本显示位置",
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	[moduleName] = "생명력 바 글자",

	["'AFK/Offline/Dead/Feigned/...'"] = "'자리비움/오프라인/죽음/죽은척하기/...'",
	["'Dead/Feigned/...' or 'Health status' on mouseover"] = "'죽음/죽은척하기/...' 또는 '치유상태 표시'",
	["'Status colored Name' followed by 'Mana %' while not Dead or AFK"] = "자리비움 또는 죽지 않았을 때 마나량을 색상화된 이름으로 표시",

	["Text Format"] = "글자 설정",

	["Predefined Formats"] = "정의된 설정",
	["Choose from a set of prefedined formats."] = "미리 만들어진 설정을 사용합니다.",

	["Text Justification"] = "글자 정의",
	["Set the horizontal text justification."] = "표시하고 싶은 글자를 입력합니다."
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local DogTag = AceLibrary("DogTag-1.0")

local formats = {
	["[Offline:AFK:HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]"] = L["'AFK/Offline/Dead/Feigned/...'"],
	["[[HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]:IsMouseOver?Text([MissingHP:Negate:Red] | [CurHP:Green])]"] = L["'Dead/Feigned/...' or 'Health status' on mouseover"],
	["[[HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]:Text([MissingHP:Negate:Red] | [CurHP:Green])]"] = L["'Dead/Feigned/...' or 'Health status'"],
	["[Name:ClassColor][[HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]:Text([MissingHP:Negate:Red] | [CurHP:Green])]"] = L["'Classcolored Name' and 'Dead/Feigned/...' or 'Health status'"],
	["[[Offline:AFK]?Name:Gray!Name:ClassColor][[HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]:Text([MissingHP:Negate:Red] | [CurHP:Green])]"] = L["'Status colored Name' and 'Dead/Feigned/...' or 'Health status'"],

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
		}
	}
}

plugin.defaultDB = {
	format        = "[Offline:AFK:HasDivineIntervention:IsFeignedDeath:HasSoulstone:Dead]",
	justification = "LEFT"
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
