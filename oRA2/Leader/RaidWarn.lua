
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALRaidWarn")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Raidwarning"] = true,
	["Options for raid warning."] = true,
	["Leader/RaidWarn"] = true,
	["Send"] = true,
	["Send an RS Message."] = true,
	["<message>"] = true,
	["To Raid"] = true,
	["Old Style"] = true,
	["Send RS Messages to Raid as well."] = true,
	["Use CTRA RS Messages instead of RaidWarning."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Raidwarning"] = "공격대경보",
	["Options for raid warning."] = "공격대 경보에 대한 설정입니다.",
	["Leader/RaidWarn"] = "공격대장/공격대경보",
	["Send"] = "보내기",
	["Send an RS Message."] = "RS 메세지로 보냅니다.",
	["<message>"] = "<메세지>",
	["To Raid"] = "공격대에 보내기",
	["Old Style"] = "옛 방식 사용",
	["Send RS Messages to Raid as well."] = "RS 메세지를 공격대 대화로도 표시합니다.",
	["Use CTRA RS Messages instead of RaidWarning."] = "공격대 경보 대신에 공격대 도우미의 RS 메세지를 사용합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Raidwarning"] = "团队警报",
	["Options for raid warning."] = "团队警报选项。",
	["Leader/RaidWarn"] = "团长/团队警报",
	["Send"] = "发送",
	["Send an RS Message."] = "发送一条 RS 消息。",
	["<message>"] = "<信息>",
	["To Raid"] = "发送到团队频道",
	["Old Style"] = "老样式",
	["Send RS Messages to Raid as well."] = "RS 同时发送一条消息到团队聊天频道。",
	["Use CTRA RS Messages instead of RaidWarning."] = "使用 CTRA RS 消息取代团队警报。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Raidwarning"] = "團隊報警",
	["Options for raid warning."] = "團隊警報選項",
	["Leader/RaidWarn"] = "領隊/團隊報警",
	["Send"] = "發送",
	["Send an RS Message."] = "發送RS訊息",
	["<message>"] = "<訊息>",
	["To Raid"] = "發送到團隊",
	["Old Style"] = "舊式風格",
	["Send RS Messages to Raid as well."] = "發送RS訊息時也發送到團隊頻道",
	["Use CTRA RS Messages instead of RaidWarning."] = "使用團隊助手訊息取代團隊警報",
} end )

L:RegisterTranslations("frFR", function() return {
	["Raidwarning"] = "Avertissement du raid",
	["Options for raid warning."] = "Options concernant l'avertissement du raid.",
	["Leader/RaidWarn"] = "Chef/Alerte raid",
	["Send"] = "Envoyer",
	["Send an RS Message."] = "Envoie un message RS.",
	["<message>"] = "<message>",
	["To Raid"] = "Au raid",
	["Old Style"] = "Ancienne méthode",
	["Send RS Messages to Raid as well."] = "Envoie les messages RS également au canal Raid.",
	["Use CTRA RS Messages instead of RaidWarning."] = "Utilise les messages RS de CTRA au lieu de l'Avertissement Raid.",
} end )

L:RegisterTranslations("deDE", function() return {
	["Raidwarning"] = "Schlachtzugswarnung",
	["Options for raid warning."] = "Optionen f\195\188r Schlachtzugswarnungen.",
	["Leader/RaidWarn"] = "Anf\195\188hrer/Schlachtzugswarnung",
	["Send"] = "Senden",
	["Send an RS Message."] = "Sende eine Schlachtzugswarnung.",
	["<message>"] = "<Nachricht>",
	["To Raid"] = "Zum Schlachtzug",
	["Old Style"] = "CTRA Meldung",
	["Send RS Messages to Raid as well."] = "Sende RS Nachricht auch an den Schlachtzug.",
	["Use CTRA RS Messages instead of RaidWarning."] = "Benutze CTRA RS Nachricht anstatt Schlachtzugswarnungen",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderRaidWarn")
mod.defaults = {
	oldstyle = false,
	toraid = false,
}
mod.leader = true
mod.name = L["Leader/RaidWarn"]
mod.consoleCmd = "rw"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for raid warning."],
	name = L["Raidwarning"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {
		send = {
			name = L["Send"], type = "text",
			desc = L["Send an RS Message."],
			usage = L["<message>"],
			get = false,
			set = "SendRS",
			validate = function(v)
				return v:find("^(.+)$")
			end,
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
		},
		ToRaid = {
			name = L["To Raid"], type = "toggle",
			desc = L["Send RS Messages to Raid as well."],
			get = function() return mod.db.profile.toraid end,
			set = function(v)
				mod.db.profile.toraid = v
			end,
		},
		OldStyle = {
			name = L["Old Style"], type = "toggle",
			desc = L["Use CTRA RS Messages instead of RaidWarning."],
			get = function() return mod.db.profile.oldstyle end,
			set = function(v)
				mod.db.profile.oldstyle = v
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterShorthand("rs", "SendRS")
end

------------------------------
--     Command Handlers     --
------------------------------

function mod:SendRS(msg)
	if not msg or not oRA:IsPromoted() then return end

	if self.db.profile.oldstyle then
		oRA:SendMessage("MS ".. msg:gsub("%%t", UnitName("target") or TARGET_TOKEN_NOT_FOUND))
	else
		SendChatMessage(msg, "RAID_WARNING")
	end
	if self.db.profile.toraid then SendChatMessage(msg, "RAID") end
end

