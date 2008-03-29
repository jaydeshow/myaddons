﻿------------------------------
--      Are you local?      --
------------------------------

local name = BZ["The Black Morass"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..name)
local wave = 0

local boss = BB["Medivh"]
local boss1 = BB["Chrono Lord Deja"]
local boss2 = BB["Temporus"]
local boss3 = BB["Aeonus"]

local db = nil
local fmt = string.format

L:RegisterTranslations("enUS", function() return {
	cmd = "Blackmorass",

	next_portal = "Next Wave",

	portal = "Wave Warnings",
	portal_desc = "Announce approximate warning messages for the next wave.",

	portalbar = "Wave Bars",
	portalbar_desc = "Display approximate timer bars for the next wave.",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "~Until Multiple waves",

	portal_message15s = "%s in ~15 seconds!",
	portal_message140s = "%s in ~140 seconds!",

	disable_trigger = "We will triumph. It is only a matter... of time.",
	disable_message = "%s has been saved!",

	death_trigger = "(.+) dies%.",
	reset_trigger = "No! Damn this feeble, mortal coil!",
	
	-- Bosses
	frenzy = "Aeonus - Frenzy",
	frenzy_desc = "Warn when Aeonus goes into a frenzy.",
	frenzy_trigger = "%s goes into a frenzy!",
	frenzy_message = "Frenzy Alert!",

	hasten = "Temporus - Hasten",
	hasten_desc = "Warns when Temporus gains hasten.",
	hasten_message = "Temporus gains Hasten!",
} end )

L:RegisterTranslations("zhTW", function() return {
	next_portal = "下一個傳送門",

	portal = "傳送門警報",
	portal_desc = "廣播下一個傳送門即將開啟的警報訊息",

	portalbar = "傳送門計時條",
	portalbar_desc = "顯示下一個傳送門的計時條",

	portal_bar = "~%s: Wave %s",
	multiportal_bar = "同時存在多個傳送門",

	portal_message15s = "15 秒後 %s !",
	portal_message140s = "140 秒後 %s !",

	disable_trigger = "我們會獲勝。這只是……時間的問題。",
	disable_message = "%s 獲救了!",

	-- Bosses
	frenzy = "艾奧那斯 - 狂亂",
	frenzy_desc = "艾奧那斯狂亂時發出警報",
	frenzy_trigger = "%s獲得了狂亂的效果。",
	frenzy_message = "艾奧那斯狂亂了!",

	hasten = "坦普拉斯 - 迅速",
	hasten_desc = "坦普拉斯獲得迅速時發出警報",
	hasten_message = "坦普拉斯獲得了迅速!",
} end )

L:RegisterTranslations("koKR", function() return {
	next_portal = "다음 차원문",

	portal = "차원문 경고",
	portal_desc = "다음 차원문에 대한 접근 경고 메세지를 알립니다.",

	portalbar = "차원문 바",
	portalbar_desc = "다음 차원문에 대한 접근 타이머 바를 표시합니다.",

	portal_bar = "~%s: %s 균열",
	multiportal_bar = "~차원문 겹침",

	portal_message15s = "약 15초 이내 %s!",
	portal_message140s = "약 140초 이내 %s!",

	disable_trigger = "우리는 승리한다. 단지 시간문제일 뿐...", -- check
	disable_message = "%s|1을;를; 지켰습니다!",

	death_trigger = "(.+)|1이;가; 죽었습니다%.",
	reset_trigger = "안 돼! 이런 나약한 무리에게 당하다니!",

	-- Bosses
	frenzy = "아에누스 - 광란",
	frenzy_desc = "아에누스가 광란 시 경고합니다.",
	frenzy_trigger = "%s|1이;가; 광란의 상태에 빠집니다!",
	frenzy_message = "광란 경고!",

	hasten = "템퍼루스 - 독촉",
	hasten_desc = "템퍼루스가 독촉에 걸릴 시 경고합니다.",
	hasten_message = "템퍼루스 독촉!",
} end )

L:RegisterTranslations("frFR", function() return {
	next_portal = "Proch. vague",

	portal = "Alertes des vagues",
	portal_desc = "Préviens régulièrement quand apparaîtra la prochaine vague.",

	portalbar = "Barres des vagues",
	portalbar_desc = "Indique l'apparition probable de la prochaine vague via une barre temporelle.",

	portal_bar = "~%s : Vague %s",
	multiportal_bar = "~Plusieurs vagues",

	portal_message15s = "%s dans ~15 sec. !",
	portal_message140s = "%s dans ~140 sec. !",

	disable_trigger = "Nous triompherons. Ce n'est qu'une question... de temps.",
	disable_message = "%s a été sauvé !",

	death_trigger = "(.+) meurt%.",
	reset_trigger = "Non ! Maudite soit cette enveloppe mortelle !",

	-- Bosses
	frenzy = "Aeonus - Frénésie",
	frenzy_desc = "Préviens quand Aeonus est pris de frénésie.",
	frenzy_trigger = "%s est pris de frénésie !",
	frenzy_message = "Frénésie !",

	hasten = "Temporus - Précipiter",
	hasten_desc = "Préviens quand Temporus gagne Précipiter.",
	hasten_message = "Temporus gagne Précipiter !",
} end )

L:RegisterTranslations("zhCN", function() return {
	next_portal = "下一传送门",

	portal = "传送门警告",
	portal_desc = "通知全队注意下一传送门即将打开。",

	portalbar = "传送门记时条",
	portalbar_desc = "显示下一个传送们打开的计时。",

	portal_bar = "~%s: 波 %s",
	multiportal_bar = "~同时存在多个传送门",

	portal_message15s = "15秒后 - %s !",
	portal_message140s = "140秒后 %s !",

	disable_trigger = "我们会胜利的。这只是个……时间问题。",
	disable_message = "%s 获救了！",
	death_trigger = "(.+)死亡了。",
	--reset_trigger = "No! Damn this feeble, mortal coil!",

	-- Bosses
	frenzy = "埃欧努斯 - 狂乱",
	frenzy_desc = "当埃欧努斯进入狂乱时发出警报。",
	frenzy_trigger = "%s变得狂怒无比！",
	frenzy_message = "狂乱！",

	hasten = "坦普卢斯 - 时光加速",
	hasten_desc = "当获得了时光加速时发出警报。",
	hasten_message = "时光加速！",
} end )

L:RegisterTranslations("deDE", function() return {
	next_portal = "N\195\164chstes Portal",

	portal = "Portalwarnungen",
	portal_desc = "Ungef\195\164hre Warnung f\195\188r das n\195\164chste Portal.",

	portalbar = "Portalleiste",
	portalbar_desc = "Zeige ungef\195\164hre Zeitleiste f\195\188r das n\195\164chste Portal..",

	portal_bar = "~%s: Welle %s",
	multiportal_bar = "~Mehrere Portale gleichzeitig",

	portal_message15s = "%s in ~15 Sekunden!",
	portal_message140s = "%s in ~140 Sekunden!",

	disable_trigger = "Wir werden siegen. Es ist nur eine Frage der Zeit...",
	disable_message = "%s wurde gerettet!",

	-- Bosses
	frenzy = "Aeonus - Raserei",
	frenzy_desc = "Warnen, wenn Aeonus in Raserei verf\195\164llt.",
	frenzy_trigger = "%s ger\195\164t in Raserei!",
	frenzy_message = "Raserei! - Einlullender Schuss!",

	hasten = "Temporus - Hasten",
	hasten_desc = "Warnen, wenn Temporus 'Hasten' bekommt",
	hasten_message = "Temporus bekommt 'Hasten'!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(name)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Black Morass"]
mod.synctoken = "The Black Morass"
mod.enabletrigger = boss
mod.toggleoptions = {"portal", "portalbar", -1, "hasten", -1, "frenzy", "bosskill"}
mod.revision = tonumber(("$Revision: 66707 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Hasten", 31458)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("UPDATE_WORLD_STATES")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["reset_trigger"] then
		self:TriggerEvent("BigWigs_RebootModule", self)
		wave = 0
	elseif msg == L["disable_trigger"] then
		if db.bosskill then
			self:Message(fmt(L["disable_message"], boss), "Bosskill", nil, "Victory")
		end
		BigWigs:ToggleModuleActive(self, false)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if db.frenzy and msg == L["frenzy_trigger"] then
		self:Message(L["frenzy_message"], "Important", nil, "Alert")
	end
end

function mod:Hasten()
	if db.hasten then
		self:Message(L["hasten_message"], "Important", nil, "Alert")
	end
end

function mod:BossDeath(source)
	if source == boss1 then
		wave = 6
	elseif source == boss2 then
		wave = 12
	else
		return
	end
	if db.portal then
		self:Message(fmt(L["portal_message140s"], L["next_portal"]), "Attention")
	end
	if db.portalbar then
		self:Bar(fmt(L["portal_bar"], L["next_portal"],wave+1), 125, "INV_Misc_ShadowEgg")
	end
end

-- Thanks to Ammo and Mecdemort for their work on the MountHyjal Wave timers which these new BM timers were based on
function mod:UPDATE_WORLD_STATES()
	if self.zonename ~= GetRealZoneText() then return end
	local _, _, text = GetWorldStateUIInfo(2)
	local num = tonumber((text or ""):match("(%d+)") or nil)
	if num and num > wave then
		wave = wave + 1
		if db.portal then
			if wave == 6 then
				self:Message(fmt(L["portal_message15s"], boss1), "Attention")
			elseif wave == 12 then
				self:Message(fmt(L["portal_message15s"], boss2), "Attention")
			elseif wave == 18 then
				self:Message(fmt(L["portal_message15s"], boss3), "Attention")
			else
				self:Message(fmt(L["portal_message15s"], L["next_portal"]), "Attention")
			end
		end
		if db.portalbar then
			self:TriggerEvent("BigWigs_StopBar", self, L["multiportal_bar"])
			self:Bar(L["multiportal_bar"], 127, "INV_Misc_ShadowEgg")
			if wave == 6 then
				self:Bar(fmt(L["portal_bar"], boss1, wave), 15, "INV_Misc_ShadowEgg")
			elseif wave == 12 then
				self:Bar(fmt(L["portal_bar"], boss2, wave), 15, "INV_Misc_ShadowEgg")
			elseif wave == 18 then
				self:Bar(fmt(L["portal_bar"], boss3, wave), 15, "INV_Misc_ShadowEgg")
			else
				self:Bar(fmt(L["portal_bar"], L["next_portal"], wave), 15, "INV_Misc_ShadowEgg")
			end
		end
	end
end

