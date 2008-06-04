﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Kil'jaeden"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local CheckInteractDistance = CheckInteractDistance

local db = nil
local started = nil
local deaths = 0
local pName = UnitName("player")
local bloomed = {}
local enrageWarn = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "KilJaeden",

	bomb = "Darkness",
	bomb_desc = "Warn when Darkness of a Thousand Souls is being cast.",
	bomb_cast = "Incoming Big Bomb!",
	bomb_bar = "Explosion!",
	bomb_nextbar = "~Possible Bomb",
	bomb_warning = "Possible bomb in ~10sec",
	kalec_yell = "I will channel my powers into the orbs! Be ready!",
	kalec_yell2 = "Another orb is ready! Make haste!",
	kalec_yell3 = "I have channeled all I can! The power is in your hands!",

	orb = "Shield Orb",
	orb_desc = "Warn when a Shield Orb is shadowbolting.",
	orb_shooting = "Orb Alive - Shooting People!",

	bloom = "Fire Bloom",
	bloom_desc = "Tells you who has been hit by Fire Bloom.",
	bloom_other = "Fire Bloom on %s!",
	bloom_bar = "Fire Blooms",
	bloom_message = "Next Fire Bloom in 5 seconds!",

	bloomsay = "Fire Bloom Say",
	bloomsay_desc = "Place a msg in say notifying that you have Fire Bloom",
	bloom_say = "Fire Bloom on "..strupper(pName).."!",

	bloomwhisper = "Fire Bloom Whisper",
	bloomwhisper_desc = "Whisper players with Fire Bloom.",
	bloom_you = "Fire Bloom on YOU!",

	icons = "Bloom Icons",
	icons_desc = "Place random Raid Icons on players with Fire Bloom (requires promoted or higher)",

	shadow = "Shadow Spike",
	shadow_desc = "Raid warn of casting of Shadow Spike.",
	shadow_message = "Shadow Spikes Inc For 28sec! WATCH OUT!",
	shadow_bar = "Shadow Spikes Expire",
	shadow_warning = "Shadow Spikes Done in 5 sec!",
	shadow_debuff_bar = "Reduced Healing on %s",

	flame = "Flame Dart",
	flame_desc = "Show Flame Dart timer bar.",
	flame_bar = "Next Flame Dart",
	flame_message = "Next Flame Dart in 5 seconds!",

	sinister = "Sinister Reflections",
	sinister_desc = "Warns on Sinister Reflection spawns.",
	sinister_message = "Sinister Reflections Up!",

	shield_up = "Shield is UP!",

	deceiver_dies = "Deciever #%d Killed",
	["Hand of the Deceiver"] = true,

	enrage_yell = "Ragh! The powers of the Sunwell turn against me! What have you done? What have you done?!",
	enrage_warning = "Enrage soon!",
	enrage_message = "10% - Enraged",
} end )

L:RegisterTranslations("koKR", function() return {
	bomb = "어둠의 영혼",
	bomb_desc = "무수한 어둠의 영혼 시전 시 알립니다.",
	bomb_cast = "잠시 후 큰 폭탄!",
	bomb_bar = "폭발!",
	bomb_nextbar = "~폭탄 가능",
	bomb_warning = "약 10초 이내 폭탄 가능!",
	kalec_yell = "수정구에 힘을 쏟겠습니다! 준비하세요!",	--check
	kalec_yell2 = "다른 수정구가 준비됐습니다! 서두르세요!",	--check
	kalec_yell3 = "모든 힘을 수정구에 실었습니다! 이제 그대들의 몫입니다!",	--check

	orb = "보호의 구슬",
	orb_desc = "보호의 구슬의 어둠 화살을 알립니다.",
	orb_shooting = "구슬 활동 - 어활 공격!",

	bloom = "화염 불꽃",
	bloom_desc = "화염 불꽃에 걸린 플레이어를 알립니다.",
	bloom_other = "%s 화염 불꽃!",
	bloom_bar = "화염 불꽃",
	bloom_message = "5초 후 다음 화염 불꽃!",

	bloomsay = "화염 불꽃 대화",
	bloomsay_desc = "자신이 화염 불꽃이 걸렸을시 일반 대화로 출력합니다.",
	bloom_say = "나에게 화염 불꽃!",

	bloomwhisper = "화염 불꽃 귓속말",
	bloomwhisper_desc = "화염 불꽃에 걸린 플레이어에게 귓속말로 알립니다.",
	bloom_you = "당신은 화염 불꽃!",

	icons = "불꽃 전술 표시",
	icons_desc = "화염 불꽃에 걸린 플레이어에게 전술 표시를 지정합니다. (승급자 이상 권한 필요)",

	shadow = "어둠의 쐐기",
	shadow_desc = "어둠의 쐐기에 대하여 공격대에 알립니다.",
	shadow_message = "잠시 후 28초간 어둠의 쐐기! 조심하세요!",
	shadow_bar = "어둠의 쐐기 종료",
	shadow_warning = "5초 후 어둠의 쐐기 종료!",
	shadow_debuff_bar = "%s 치유효과 감소",

	flame = "불꽃 화살",
	flame_desc = "불꽃 화살 타이머 바를 표시합니다.",
	flame_bar = "다음 불꽃 화살",
	flame_message = "5초 후 다음 불꽃 화살!",

	sinister = "사악한 환영",
	sinister_desc = "사악한 환영 생성을 알립니다.",
	sinister_message = "사악한 환영!",

	shield_up = "푸른용의 보호막!",

	deceiver_dies = "심복 #%d 처치",
	["Hand of the Deceiver"] = "기만자의 심복",

	enrage_yell = "으악! 태양샘의 마력이 나를 거부한다! 무슨 짓을 한거지? 무슨 짓을 한거야?!",	--check
	enrage_warning = "잠시후 격노!",
	enrage_message = "10% - 격노",
} end )

L:RegisterTranslations("frFR", function() return {
	bomb = "Ténèbres des mille âmes",
	bomb_desc = "Prévient quand les Ténèbres des mille âmes sont incantés.",
	bomb_cast = "Arrivée d'une énorme bombe !",
	bomb_bar = "Explosion !",
	bomb_nextbar = "~Bombe probable",
	bomb_warning = "Bombe probable dans ~10 sec.",
	kalec_yell = "Je vais canaliser mon énergie vers les orbes ! Préparez-vous !", -- à vérifier
	kalec_yell2 = "Un autre orbe est prêt ! Hâtez-vous !", -- à vérifier
	kalec_yell3 = "J'ai envoyé tout ce que je pouvais ! La puissance est entre vos mains !", -- à vérifier

	orb = "Orbe bouclier",
	orb_desc = "Prévient quand une Orbe bouclier lance des Traits de l'ombre.",
	orb_shooting = "Orbe en vie - Bombardement de traits !",

	bloom = "Fleur du feu",
	bloom_desc = "Prévient quand des joueurs subissent les effets de la Fleur du feu.",
	bloom_other = "Fleur du feu sur %s !",
	bloom_bar = "Fleurs du feu",
	bloom_message = "Prochaine Fleur du feu dans 5 sec. !",

	bloomsay = "Dire - Fleur du feu",
	bloomsay_desc = "Fait dire à votre personnage qu'il est ciblé par la Fleur du feu quand c'est le cas, afin d'aider les membres proches ayant les bulles de dialogue activées.",
	bloom_say = "Fleur du feu sur "..strupper(pName).." !",

	bloomwhisper = "Chuchoter",
	bloomwhisper_desc = "Prévient par chuchotement les derniers joueurs affectés par la Fleur du feu (nécessite d'être promu ou mieux).",
	bloom_you = "Fleur du feu sur VOUS !",

	icons = "Icônes",
	icons_desc = "Place une icône de raid sur les derniers joueurs affectés par la Fleur du feu (nécessite d'être promu ou mieux).",

	shadow = "Pointe de l'ombre",
	shadow_desc = "Prévient quand les Pointes de l'ombre sont incantées.",
	shadow_message = "Pointes de l'ombre pendant 28 sec. !",
	shadow_bar = "Fin des Pointes",
	shadow_warning = "Pointes de l'ombre terminées dans 5 sec. !",
	shadow_debuff_bar = "Soins réduits sur %s",

	flame = "Fléchette des flammes",
	flame_desc = "Affiche une barre temporelle pour la Flèchette des flammes.",
	flame_bar = "Prochaine Fléchette",
	flame_message = "Prochaine Fléchette des flammes dans 5 sec. !",

	sinister = "Reflets sinistres",
	sinister_desc = "Prévient quand les Reflets sinistres apparaissent.",
	sinister_message = "Reflets sinistres actifs !",

	shield_up = "Bouclier ACTIF !",

	deceiver_dies = "Trompeur #%d tué",
	["Hand of the Deceiver"] = "Main du Trompeur", -- à vérifier

	enrage_yell = "Nooon ! Les pouvoirs du Puits de soleil se retournent contre moi ! Qu'avez-vous fait ? Qu'avez-vous fait ?!", -- à vérifier
	enrage_warning = "Enrager imminent !",
	enrage_message = "10% - Enragé",
} end )

L:RegisterTranslations("zhCN", function() return {
	bomb = "黑暗",
	bomb_desc = "当千魂之暗开始施法时发出警报。",
	bomb_cast = "即将 大炸弹！",
	bomb_bar = "爆炸！",
	bomb_nextbar = "<可能 炸弹>",
	bomb_warning = "约10秒后，可能炸弹！",
	kalec_yell = "我会将我的力量导入宝珠中！准备好！",
	kalec_yell2 = "又有一颗宝珠准备好了！快点行动！",
	kalec_yell3 = "这是我所能做的一切了！力量现在掌握在你们的手中！",--possible not the orb warning.(another choice:我又将能量灌入了另一颗宝珠！快去使用它！)

	orb = "护盾宝珠",--Shield Orb 
	orb_desc = "当护盾宝珠施放暗影箭时发出警报。",
	orb_shooting = "护盾宝珠 - 暗影箭！",

	bloom = "火焰之花",
	bloom_desc = "当玩家中了火焰之花时发出警报。",
	bloom_other = "火焰之花：>%s<！",
	bloom_bar = "<火焰之花>",
	bloom_message = "5秒后，火焰之花！",

	bloomsay = "火焰之花提醒",
	bloomsay_desc = "当你中了火焰之花时通知周围的玩家。",
	bloom_say = ">"..strupper(pName).."< 中了火焰之花！",

	bloomwhisper = "火焰之花密语",
	bloomwhisper_desc = "当玩家中了火焰之花时密语提示他离开。",
	bloom_you = ">你< 中了火焰之花！",

	icons = "团队标记",
	icons_desc = "为中了火焰之花的玩家随机打上一个团队标记。（需要权限）",

	shadow = "暗影尖刺",
	shadow_desc = "当施放暗影尖刺时发出警报。",
	shadow_message = "28秒后，.暗影之刺<！当心！",
	shadow_bar = "<暗影之刺>",
	shadow_warning = "5秒后，暗影之刺！",
	shadow_debuff_bar = "<降低治疗：%s>",

	flame = "烈焰之刺",
	flame_desc = "显示烈焰之刺记时条。",
	flame_bar = "<下一烈焰之刺>",
	flame_message = "5秒后，烈焰之刺！",

	sinister = "邪恶镜像",
	sinister_desc = "当邪恶镜像时发出警报。",
	sinister_message = "邪恶镜像 出现！",

	shield_up = ">蓝龙之盾< 启用！",

	deceiver_dies = "已杀死欺诈者之手#%d",
	["Hand of the Deceiver"] = "欺诈者之手",

	enrage_yell = "呃！太阳之井的能量开始对抗我！你们都做了些什么？你们都做了些什么？！",--not confirm
	enrage_warning = "即将 激怒！",
	enrage_message = "10% - 激怒",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local deceiver = L["Hand of the Deceiver"]
local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Sunwell Plateau"]
mod.enabletrigger = {deceiver, boss}
mod.toggleoptions = {"bomb", "orb", "flame", -1, "bloom", "bloomwhisper","bloomsay", "icons", -1, "sinister", "shadow", -1, "proximity", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision: 75880 $"):sub(12, -3))
mod.proximityCheck = function( unit ) return CheckInteractDistance( unit, 3 ) end
mod.proximitySilent = true

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Sinister", 45892)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Shield", 45848)
	self:AddCombatListener("SPELL_DAMAGE", "Orb", 45680)
	self:AddCombatListener("SPELL_MISSED", "Orb", 45680)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Bloom", 45641)
	self:AddCombatListener("SPELL_CAST_START", "Shadow", 45885)
	self:AddCombatListener("UNIT_DIED", "Deaths")

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("BigWigs_RecvSync")

	db = self.db.profile
	started = nil
	deaths = 0
	for i = 1, #bloomed do bloomed[i] = nil end
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Sinister()
	if db.sinister then
		self:IfMessage(L["sinister_message"], "Attention", 45892)
	end
	if db.flame then
		self:Bar(L["flame_bar"], 60, 45737)
		self:DelayedMessage(55, L["flame_message"], "Attention")
	end
end

function mod:Shield()
	self:IfMessage(L["shield_up"], "Urgent", 45848)
end

local last = 0
function mod:Orb()
	local time = GetTime()
	if (time - last) > 10 then
		last = time
		if db.orb then
			self:IfMessage(L["orb_shooting"], "Attention", 45680, "Alert")
		end
	end
end

function mod:Deaths(unit)
	if unit == deceiver then
		deaths = deaths + 1
		self:IfMessage(L["deceiver_dies"]:format(deaths), "Positive")
		if deaths == 3 then
			self:Bar(boss, 10, "Spell_Shadow_Charm")
			self:TriggerEvent("BigWigs_ShowProximity", self)
		end
	elseif unit == boss then
		self:GenericBossDeath(unit)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, unit)
	if unit == boss and db.bomb then
		self:Bar(L["bomb_bar"], 8, "Spell_Shadow_BlackPlague")
		self:IfMessage(L["bomb_cast"], "Positive")
		self:Bar(L["bomb_nextbar"], 46, "Spell_Shadow_BlackPlague")
		self:DelayedMessage(36, L["bomb_warning"], "Attention")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L["kalec_yell"] or msg == L["kalec_yell2"] or msg == L["kalec_yell3"]) and db.bomb then
		self:Bar(L["bomb_nextbar"], 40, "Spell_Shadow_BlackPlague")
		self:DelayedMessage(30, L["bomb_warning"], "Attention")
	elseif msg == L["enrage_yell"] then
		self:IfMessage(L["enrage_message"], "Attention")
	end
end

function mod:Shadow(_, spellID)
	if db.shadow then
		self:Bar(L["shadow_bar"], 28, spellID)
		self:IfMessage(L["shadow_message"], "Attention", spellID)
		self:DelayedMessage(23, L["shadow_warning"], "Attention")
	end
end

function mod:Bloom(player)
	if db.bloom then
		tinsert(bloomed, player)
		self:Whisper(player, L["bloom_you"], "bloomwhisper")
		self:ScheduleEvent("BWBloomWarn", self.BloomWarn, 0.4, self)
		if player == pName and db.bloomsay then
			self:LocalMessage(L["bloom_you"], "Personal", 45641, "Long")
			SendChatMessage(L["bloom_say"], "SAY")
		end
	end
end

function mod:BloomWarn()
	local msg = nil
	table.sort(bloomed)

	for i,v in ipairs(bloomed) do
		if not msg then
			msg = v
		else
			msg = msg .. ", " .. v
		end
		if db.icons then
			SetRaidTarget(v, i)
		end
	end

	self:IfMessage(L["bloom_other"]:format(msg), "Important", 45641, "Alert")
	self:Bar(L["bloom_bar"], 20, 45641)
	self:DelayedMessage(15, L["bloom_message"], "Attention")
	for i = 1, #bloomed do bloomed[i] = nil end
end

function mod:UNIT_HEALTH(msg)
	if not db.enrage then return end
	if UnitName(msg) == boss then
		local health = UnitHealth(msg)
		if health > 12 and health <= 14 and not enrageWarn then
			self:Message(L["enrage_warning"], "Positive")
			enrageWarn = true
		elseif health > 50 and enrageWarn then
			enrageWarn = false
		end
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
	end
end
