﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Murmur"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

local pName = UnitName("player")
local db = nil
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Murmur",

	touch_message = "%s has %s!",
	touch_message_you = "You have Murmur's Touch!",
	touch_message_other = "%s has Murmur's Touch!",

	touchtimer = "Bar for when Murmur's Touch goes off",
	touchtimer_desc = "Shows a 13 second bar for when Murmur's Touch goes off on the target.",
	touchtimer_bar = "%s: Murmur's Touch",

	youtouch = "You Touch Alert",
	youtouch_desc = "Warn when you have Murmur's Touch",

	othertouch = "Someone else Touch Alert",
	othertouch_desc = "Warn when others have Murmur's Touch",

	icon = "Raid Icon on bomb",
	icon_desc = "Put a Raid Icon on the person who has Murmur's Touch. (Requires promoted or higher)",

	sonicboom = "Sonic Boom",
	sonicboom_desc = "Warns when Murmur begins casting his Sonic Boom",
	sonicboom_trigger = "draws energy from the air...",
	sonicboom_alert = "Sonic Boom in 5 seconds!",
	sonicboom_bar = "Sonic Boom casting!",
} end)

L:RegisterTranslations("koKR", function() return {
	touch_message_you = "당신은 폭탄입니다!",
	touch_message_other = "%s님이 폭탄입니다!",

	touchtimer = "폭발 시점에 대한 바",
	touchtimer_desc = "울림의 손길에 걸린 사람이 폭발할 때 까지의 13초 바를 표시합니다.",
	touchtimer_bar = "%s: 울림의 손길",

	youtouch = "자신의 폭탄 알림",
	youtouch_desc = "당신이 폭탄일 때 알립니다.",

	othertouch = "타인의 폭탄 알림",
	othertouch_desc = "타인이 폭탄일 때 알립니다.",

	icon = "폭탄 공격대 아이콘",
	icon_desc = "폭탄인 사람에게 공격대 아이콘을 지정합니다. (승급자 이상 권한 요구)",

	sonicboom = "음파 폭발",
	sonicboom_desc = "음파 폭발 시전 시 경고합니다.",
	sonicboom_trigger = "대기에서 에너지를 흡수합니다...", -- check
	sonicboom_alert = "5초 이내 음파 폭발!",
	sonicboom_bar = "음파 폭발 시전!",
} end)

L:RegisterTranslations("zhTW", function() return {
	touch_message_you = "你是炸彈! 遠離隊友!",
	touch_message_other = "%s 是炸彈! 遠離隊友!",

	touchtimer = "炸彈倒數計時條",
	touchtimer_desc = "顯示炸彈倒數 13 秒計時條",
	touchtimer_bar = "莫爾墨之觸: %s",

	youtouch = "自身炸彈警報",
	youtouch_desc = "當自己成為炸彈時發出警報",

	othertouch = "隊友炸彈警報",
	othertouch_desc = "當隊友變成炸彈時發出警報",

	icon = "炸彈標記",
	icon_desc = "在被變成炸彈的隊友頭上標記（需要助理或領隊權限）",

	sonicboom = "音速波",
	sonicboom_desc = "當莫爾墨開始施放音速波時發出警報",
	sonicboom_trigger = "從空中吸取能量……",
	sonicboom_alert = "5 秒後音速波，快跑出音速波範圍!",
	sonicboom_bar = "施放音速波",
} end)

L:RegisterTranslations("frFR", function() return {
	touch_message_you = "Vous êtes la bombe !",
	touch_message_other = "%s est la bombe !",

	touchtimer = "Délais avant explosion de la bombe",
	touchtimer_desc = "Affiche une barre de 13 secondes indiquant quand la bombe explose sur la cible.",
	touchtimer_bar = "%s : Toucher de Marmon",

	youtouch = "Bombe (vous)",
	youtouch_desc = "Préviens quand vous êtes la bombe.",

	othertouch = "Bombe (les autres)",
	othertouch_desc = "Préviens quand les autres sont la bombe.",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur la personne qui est la bombe (nécessite d'être promu ou mieux).",

	sonicboom = "Grondement sonore",
	sonicboom_desc = "Préviens quand Marmon commence à lancer son Grondement sonore.",
	sonicboom_trigger = "tire de l'énergie de l'air...",
	sonicboom_alert = "Grondement sonore dans 5 sec. !",
	sonicboom_bar = "Grondement sonore en incantation !",
} end)

L:RegisterTranslations("deDE", function() return {
	touch_message_you = "Du bist die Bombe!",
	touch_message_other = "%s ist die Bombe!",

	touchtimer = "Leiste die anzeigt, wann die Bombe explodiert",
	touchtimer_desc = "Eine 13sek\195\188ndige Leiste die anzeigt, wann die Bombe auf dem Ziel explodiert.",
	touchtimer_bar = "%s: Murmurs Ber\195\188hrung",

	youtouch = "Du bist die Bombe - Warnung",
	youtouch_desc = "Warnt wenn du die Bombe bist",

	othertouch = "Jemand anders ist die Bombe - Warnung",
	othertouch_desc = "Warnt wenn jemand anders die Bombe ist",

	icon = "Raidsymbol auf Bombe",
	icon_desc = "Setzt ein Raidsymbol auf die Person die die Bombe ist. (Ben\195\182tigt bef\195\182rderten Status oder h\195\182her)",

	sonicboom = "\195\156berschallknall",
	sonicboom_desc = "Warnt wenn Murmur beginnt, seinen \195\156berschallknall zu wirken.",
	sonicboom_trigger = "entzieht der Luft Energie...",
	sonicboom_alert = "\195\156berschallknall in 5 Sekunden!",
	sonicboom_bar = "\195\156berschallknall wird gewirkt!",
} end)

L:RegisterTranslations("zhCN", function() return {
	touch_message_you = "你是炸弹！远离队友！",
	touch_message_other = ">%s<是炸弹！远离队友！",

	touchtimer = "炸弹倒计时条",
	touchtimer_desc = "显示炸弹倒数13秒记时条。",
	touchtimer_bar = "<摩摩尔之触：%s> ",

	youtouch = "你是炸弹警告",
	youtouch_desc = "当自己成为炸弹时发出警报。",

	othertouch = "队友炸弹警告",
	othertouch_desc = "当队友成为炸弹时发出警报。",

	icon = "团队标记炸弹",
	icon_desc = "在被成为炸弹的队友打上团队标记。（需要助理或更高权限）",

	sonicboom = "音爆",
	sonicboom_desc = "当摩摩尔开始施放音爆发出警告。",
	sonicboom_trigger = "从空气中吸取能量……",
	sonicboom_alert = "5秒后发动 音爆！快速跑出音爆范围～",
	sonicboom_bar = "<正在施放音爆>",
} end)

L:RegisterTranslations("esES", function() return {
	touch_message_you = "Tu eres la bomba!",
	touch_message_other = "%s es la bomba!",

	touchtimer = "Retardo de explosi\195\179n de la bomba",
	touchtimer_desc = "Muestra una barra de 13 segundos de forma que sepas cuando va a estallar la bomba.",
	touchtimer_bar = "%s : Toque de Murmur",

	youtouch = "Bomba (tu)",
	youtouch_desc = "Aviso para cuando tu eres la bomba",

	othertouch = "Bomba (los otros)",
	othertouch_desc = "Aviso para cuando otros son la bomba",

	icon = "Icono de Raid para la bomba",
	icon_desc = "Pone un icono de Raid en la persona que es la bomba (Requiere promocionado o superior).",

	sonicboom = "Bum s\195\179nico",
	sonicboom_desc = "Aviso cuando Murmur comienza a lanzar Bum s\195\179nico",
	sonicboom_trigger = "extrae energ\195\173a del aire...",
	sonicboom_alert = "Bum s\195\179nico en 5 segundos!",
	sonicboom_bar = "Lanzando Bum s\195\179nico!",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss
mod.toggleoptions = {"sonicboom", -1, "touchtimer", "youtouch", "othertouch", "icon", "bosskill"}
mod.revision = tonumber(("$Revision: 66707 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Touch", 33711, 33760, 38794) -- from wowhead, 33711 is probably the correct one
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Touch(player, spellID)
	if player == pName and db.youtouch then
		self:Message(L["touch_message_you"], "Personal", true)
		self:Message(fmt(L["touch_message_other"], player), "Attention", nil, nil, true)		
	elseif db.othertouch then
		self:Message(fmt(L["touch_message_other"], player), "Attention")
		self:Whisper(player, L["touch_message_you"])
	end
	if player and db.touchtimer then
		self:Bar(fmt(L["touchtimer_bar"], player), 13, spellID, "Red")
	end
	if player and db.icon then
		self:Icon(player)
	end	
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if db.sonicboom and msg:find(L["sonicboom_trigger"]) then
		self:Message(L["sonicboom_alert"], "Important")
		self:Bar(L["sonicboom_bar"], 5, "Spell_Nature_AstralRecal", "Red")
	end
end
