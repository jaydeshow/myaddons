if GetLocale() == "zhTW" then
Outfitter = {}
MCDebugLib:InstallDebugger("Outfitter", Outfitter, {r=0.6,g=1,b=0.8})

Outfitter.cVersion = "4.1.1"

Outfitter.cTitle = "Outfitter"
Outfitter.cTitleVersion = Outfitter.cTitle.." "..Outfitter.cVersion

Outfitter.cSingleItemFormat = "%s"
Outfitter.cTwoItemFormat = "%s and %s"
Outfitter.cMultiItemFormat = "%s{{, %s}} and %s"

Outfitter.cNameLabel = "���Q��"
Outfitter.cCreateUsingTitle = "��������"
Outfitter.cUseCurrentOutfit = "ʹ�î�ǰ���b"
Outfitter.cUseEmptyOutfit = "�½��հ����b"
Outfitter.cAutomationLabel = "�Ԅӣ�"

Outfitter.cOutfitterTabTitle = "Outfitter"
Outfitter.cOptionsTabTitle = "�x�"
Outfitter.cAboutTabTitle = "�P��"

Outfitter.cNewOutfit = "�½����b"
Outfitter.cRenameOutfit = "���������b"

Outfitter.cCompleteOutfits = "ȫ�����b"
Outfitter.cAccessoryOutfits = "�������b"
Outfitter.cOddsNEndsOutfits = "������Ʒ"

Outfitter.cGlobalCategory = "�������b"
Outfitter.cNormalOutfit = "��ͨ"
Outfitter.cNakedOutfit = "���w"

Outfitter.cScriptCategoryName = {}
Outfitter.cScriptCategoryName.PVP = "PvP"
Outfitter.cScriptCategoryName.TRADE = "����"
Outfitter.cScriptCategoryName.GENERAL = "һ��"

Outfitter.cArgentDawnOutfit = "�yɫ����"
Outfitter.cCityOutfit = "�ǃ�չʾ"
Outfitter.cBattlegroundOutfit = "����"
Outfitter.cAVOutfit = "�������W���m��ɽ�}"
Outfitter.cABOutfit = "����������ϣ���"
Outfitter.cArenaOutfit = "������������"
Outfitter.cEotSOutfit = "�������L��֮��"
Outfitter.cWSGOutfit = "���������{��"
Outfitter.cDiningOutfit = "�Ժ�"
Outfitter.cFishingOutfit = "��~"
Outfitter.cHerbalismOutfit = "��ˎ�W"
Outfitter.cMiningOutfit = "�ɵV"
Outfitter.cFireResistOutfit = "���ԣ�����"
Outfitter.cNatureResistOutfit = "���ԣ���Ȼ"
Outfitter.cShadowResistOutfit = "���ԣ���Ӱ"
Outfitter.cArcaneResistOutfit = "���ԣ��W�g"
Outfitter.cFrostResistOutfit = "���ԣ���˪"
Outfitter.cRidingOutfit = "�T��"
Outfitter.cSkinningOutfit = "��Ƥ"
Outfitter.cSwimmingOutfit = "��Ӿ"
Outfitter.cLowHealthOutfit = "������/����"
Outfitter.cHasBuffOutfit = "���Buff"
Outfitter.cInZonesOutfit = "�ڵ؅^"
Outfitter.cSoloOutfit = "Solo"
Outfitter.cFallingOutfit = "����"

Outfitter.cArgentDawnOutfitDescription = "������֮���ԄӓQ�b"
Outfitter.cRidingOutfitDescription = "�T�˕r�ԄӓQ�b"
Outfitter.cDiningOutfitDescription = "�Ժȕr�ԄӓQ�b"
Outfitter.cBattlegroundOutfitDescription = "�ڑ������ԄӓQ�b"
Outfitter.cArathiBasinOutfitDescription = "�ڰ���ϣ��؃��ԄӓQ�b"
Outfitter.cAlteracValleyOutfitDescription = "�ڊW���m��ɽ�ȃ��ԄӓQ�b"
Outfitter.cWarsongGulchOutfitDescription = "�ڑ��{�ȃ��ԄӓQ�b"
Outfitter.cEotSOutfitDescription = "���L��֮�ۃ��ԄӓQ�b"
Outfitter.cArenaOutfitDescription = "��PVP���������ԄӓQ�b"
Outfitter.cCityOutfitDescription = "�ѷ����ǃ��ԄӓQ�b"
Outfitter.cSwimmingOutfitDescription = "��Ӿ�r�ԄӓQ�b"
Outfitter.cFishingOutfitDescription = "�M��𶷕��ԄӓQ�²���Ó�x�𶷕r�����b��"
Outfitter.cSpiritOutfitDescription = "��ħ�r(Ó�x5��Ҏ�t)�Ԅ��b�����"
Outfitter.cHerbalismDescription = "��˻��^�@ʾ���ɫ��tɫ�Ĳ�ˎ�c�r�ԄӓQ�b"
Outfitter.cMiningDescription = "��˻��^�@ʾ���ɫ��tɫ�ĵV�c�r�ԄӓQ�b"
Outfitter.cLockpickingDescription = "��˻��^�@ʾ���ɫ��tɫ���i�r�ԄӓQ�b"
Outfitter.cSkinningDescription = "��˻��^�@ʾ���ɫ��tɫ�ĿɄ�Ƥ����r�ԄӓQ�b"
Outfitter.cLowHealthDescription = "�������߷��������ض�ֵ�r�ԄӓQ�b"
Outfitter.cHasBuffDescription = "������ض����Qbuff�r�ԄӓQ�b"
Outfitter.SpiritRegenOutfitDescription = "��ħ�r(Ó�x5��Ҏ�t)�Ԅ��b�����"
Outfitter.cDruidCasterFormDescription = "�����κε������ΑB�r�ԄӓQ�b"
Outfitter.cPriestShadowformDescription = "��Ӱ�ΑB�ԄӓQ�b"
Outfitter.cShamanGhostWolfDescription = "���`���ΑB�ԄӓQ�b"
Outfitter.cHunterMonkeyDescription = "�`�����o�ԄӓQ�b"
Outfitter.cHunterHawkDescription = "�������o�ԄӓQ�b"
Outfitter.cHunterCheetahDescription = "�C�����o�ԄӓQ�b"
Outfitter.cHunterPackDescription = "��Ⱥ���o�ԄӓQ�b"
Outfitter.cHunterBeastDescription = "Ұ�F���o�ԄӓQ�b"
Outfitter.cHunterWildDescription = "Ұ�����o�ԄӓQ�b"
Outfitter.cHunterViperDescription = "�������o�ԄӓQ�b"
Outfitter.cHunterFeignDeathDescription = "�����ԄӓQ�b"
Outfitter.cMageEvocateDescription = "�����B�ԄӓQ�b"
Outfitter.cWarriorBerserkerStanceDescription = "���ˑB�ԄӓQ�b"
Outfitter.cWarriorDefensiveStanceDescription = "�����ˑB�ԄӓQ�b"
Outfitter.cWarriorBattleStanceDescription = "���ˑB�ԄӓQ�b"
Outfitter.cInZonesOutfitDescription = "���������^��ĕr���ԄӓQ�b"
Outfitter.cSoloOutfitDescription = "δ�Mꠕr�ԄӓQ�b"
Outfitter.cFallingOutfitDescription = "�ĸ߿�ˤ�r�ԄӓQ�b"

Outfitter.cMountSpeedFormat = "�ٶ����(%d+)%%%."; -- For detecting when mounted
Outfitter.cFlyingMountSpeedFormat = "�w���ٶ����(%d+)%%%"; -- For detecting when mounted

Outfitter.cBagsFullError = "Outfitter: �����Ƴ�%s��ȫ���������M��"
Outfitter.cDepositBagsFullError = "Outfitter: �����ܴ��%s��ȫ���y�б������M��"
Outfitter.cWithdrawBagsFullError = "Outfitter: ����ȡ��%s��ȫ���������M�ˣ�"
Outfitter.cItemNotFoundError = "Outfitter: δ�ҵ�%s"
Outfitter.cItemAlreadyUsedError = "Outfitter: ���܌�%s����%s���ѽ���������һ��λ��"
Outfitter.cAddingItem = "Outfitter: ��� %s �����b��%s"
Outfitter.cNameAlreadyUsedError = "�e�`���������ѽ���ʹ��"
Outfitter.cNoItemsWithStatError = "���棺�]���b������@������"
Outfitter.cCantUnequipCompleteError = "Outfitter: ���ܓQ�� %s����鲻�ܓQ��ȫ�����b�������b����һ��ȫ�����b����"

Outfitter.cEnableAll = "��������"
Outfitter.cEnableNone = "��������"

Outfitter.cConfirmDeleteMsg = "��_�JҪ�h�����b��%s��"
Outfitter.cConfirmRebuildMsg = "��_�JҪ�ؽ����b��%s��"
Outfitter.cRebuild = "�ؽ�"

Outfitter.cWesternPlaguelands = "������֮��"
Outfitter.cEasternPlaguelands = "�|����֮��"
Outfitter.cStratholme = "˹̹��ķ"
Outfitter.cScholomance = "ͨ�`�WԺ"
Outfitter.cNaxxramas = "�{���_��˹"
Outfitter.cAlteracValley = "�W���m��ɽ��"
Outfitter.cArathiBasin = "����ϣ���"
Outfitter.cWarsongGulch = "���{��"
Outfitter.cEotS = "�L��֮��"
Outfitter.cIronforge = "�F�t��"
Outfitter.cCityOfIronforge = "�F�t��"
Outfitter.cDarnassus = "�_�{�K˹"
Outfitter.cStormwind = "���L��"
Outfitter.cOrgrimmar = "�W����"
Outfitter.cThunderBluff = "������"
Outfitter.cUndercity = "�İ���"
Outfitter.cSilvermoon = "�y�³�"
Outfitter.cExodar = "�����_"
Outfitter.cShattrath = "ɳ��˹��"
Outfitter.cAQ40 = "������"
Outfitter.cBladesEdgeArena = "���hɽ������"
Outfitter.cNagrandArena = "�{���m������"
Outfitter.cRuinsOfLordaeron = "�嵤���U��"

Outfitter.cItemStatFormats =
{
		{Format = "���T�Ƅ��ٶ���΢����", Value = 3, Types = {"Riding"}},
		{Format = "���y�R��", Value = 3, Types = {"Riding"}},
	
		"��߷��g��ħ��Ч������ɵĂ������ί�Ч�������(%d+)�c",
	"Increases (.+) done by up to (%d+) and (healing) done by up to (%d+)",
	"Increases (healing) done by up to (%d+) and damage done by up to (%d+) for all (magical spells and effects)",
	"Increases the (.+) of your .+ by (%d+)",
	"Increases your (.+) by (%d+)",
	"Improves your (.+) by (%d+)",
	"Increases (.+) by up to (%d+)",
	"Increases (.+) by (%d+)",
	"%+(%d+) (.+) and %+(%d+) (.+)", -- Multi-stat items like secondary-color gems
	"%+(%d+) (.+)/%+(%d+) (.+)/%+(%d+) (.+)", -- Multi-stat enchants from ZG
	"%+(%d+) (.+)/%+(%d+) (.+)", -- Multi-stat enchants from ZG
	
	"��� (.+) %+(%d+)",
	"���� (.+) by (%d+)",
	
	"�؏� (%d+) (.+)",
	
		"%+(%d+) (%w+)���g����",
	
	"(%d+) (.+)",
	"(.+) %+(%d+)",
}

Outfitter.cItemStatPhrases =
{
		["����"] = "Stamina",
		["����"] = "Intellect",
		["����"] = "Agility",
		["����"] = "Stength",
		["����"] = "Spirit",
		["���Ќ���"] = {"Stamina", "Intellect", "Agility", "Strength", "Spirit"},
	
		["�o��"] = "Armor",
	
		["����ֵ"] = "Mana",
		["����ֵ"] = "Health",
	
		["���濹��"] = "FireResist",
		["��Ȼ����"] = "NatureResist",
		["��˪����"] = "FrostResist",
		["��Ӱ����"] = "ShadowResist",
		["�W�g����"] = "ArcaneResist",
		["���п���"] = {"FireResist", "NatureResist", "FrostResist", "ShadowResist", "ArcaneResist"},
	
		["�����ȼ�"] = "DefenseRating",
		["�g�Եȼ�"] = "ResilienceRating",
		["���􏊶�"] = {"Attack", "RangedAttack"},
		["�h�̹��􏊶�"] = "RangedAttack",
		["�����ȼ�"] = "MeleeCritRating",
		["���еȼ�"] = "MeleeHitRating",
		["���W�ȼ�"] = "DodgeRating",
		["�мܵȼ�"] = "ParryRating",
		["���"] = "Block",
		["���ֵ"] = "Block",
		["��������"] = "MeleeDmg",
		["��������"] = "MeleeDmg",
		["����"] = "MeleeDmg",
	
		["���g�����ȼ�"] = "SpellCritRating",
		["���g����"] = "SpellCritRating",
		["���g���еȼ�"] = "SpellHitRating",
		["���g��͸"] = "SpellPen",
	    ["���g���ٵȼ�"] = "SpellHasteRating",
	
	["damage and healing done by magical spells and effects"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"},
		["���g����"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg"},
		["ħ��������Ч��"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg"},
	
		["����"] = "FireDmg",
		["��Ӱ"] = "ShadowDmg",
		["��˪"] = "FrostDmg",
		["�W�g"] = "ArcaneDmg",
		["��Ȼ"] = "NatureDmg",
	
	["healing done by spells and effects"] = "Healing",
		["�ί�"] = "Healing",
		["�ί����g"] = "Healing",
	
		["��~"] = "Fishing",
		["��ˎ�W"] = "Herbalism",
		["�ɵV"] = "Mining",
		["��Ƥ"] = "Skinning",
		["���T�ٶ�"] = "Riding",
	
		["ÿ5�뷨��"] = {"ManaRegen", "CombatManaRegen"},
	["mana regen"] = {"ManaRegen", "CombatManaRegen"},
	["health per 5 sec"] = {"HealthRegen", "CombatHealthRegen"},
	["health regen"] = {"HealthRegen", "CombatHealthRegen"},
}

Outfitter.cAgilityStatName = "����"
Outfitter.cArmorStatName = "�o��"
Outfitter.cDefenseStatName = "����"
Outfitter.cIntellectStatName = "����"
Outfitter.cSpiritStatName = "����"
Outfitter.cStaminaStatName = "����"
Outfitter.cStrengthStatName = "����"
Outfitter.cTotalStatsName = "���Ќ���"
Outfitter.cHealthStatName = "����ֵ"
Outfitter.cManaStatName = "����ֵ"

Outfitter.cManaRegenStatName = "�����֏�"
Outfitter.cCombatManaRegenStatName = "5���ħ(��)"
Outfitter.cHealthRegenStatName = "�����֏�"
Outfitter.cCombatHealthRegenStatName = "5���Ѫ(��)"

Outfitter.cSpellCritStatName = "���g����"
Outfitter.cSpellHitStatName = "���g����"
Outfitter.cSpellDmgStatName = "���g����"
Outfitter.cSpellHasteStatName = "���g����"
Outfitter.cFrostDmgStatName = "��˪����"
Outfitter.cFireDmgStatName = "�������"
Outfitter.cArcaneDmgStatName = "�W�g����"
Outfitter.cShadowDmgStatName = "��Ӱ����"
Outfitter.cNatureDmgStatName = "��Ȼ����"
Outfitter.cHealingStatName = "�ί�"

Outfitter.cMeleeCritStatName = "������"
Outfitter.cMeleeHitStatName = "��������"
Outfitter.cMeleeHasteStatName = "���g���ٵȼ�"
Outfitter.cMeleeDmgStatName = "��������"
Outfitter.cAttackStatName = "���􏊶�"
Outfitter.cRangedAttackStatName = "�h�̹��􏊶�"
Outfitter.cDodgeStatName = "���W"
Outfitter.cParryStatName = "�м�"
Outfitter.cBlockStatName = "���"
Outfitter.cResilienceStatName = "�g��"

Outfitter.cArcaneResistStatName = "�W�g����"
Outfitter.cFireResistStatName = "���濹��"
Outfitter.cFrostResistStatName = "��˪����"
Outfitter.cNatureResistStatName = "��Ȼ����"
Outfitter.cShadowResistStatName = "��Ӱ����"

Outfitter.cFishingStatName = "��~"
Outfitter.cHerbalismStatName = "��ˎ�W"
Outfitter.cMiningStatName = "�ɵV"
Outfitter.cSkinningStatName = "��Ƥ"

Outfitter.cOptionsTitle = "Outfitter �x�"
Outfitter.cShowMinimapButton = "�@ʾС�؈D���o"
Outfitter.cShowMinimapButtonOnDescription = "�P�]������С�؈D���@ʾ Outfitter ���o"
Outfitter.cShowMinimapButtonOffDescription = "�_������С�؈D���@ʾ Outfitter ���o"
Outfitter.cAutoSwitch = "�����Ԅ��ГQ���b"
Outfitter.cAutoSwitchOnDescription = "�_���������Ԅ��ГQ���b"
Outfitter.cAutoSwitchOffDescription = "�P�]���_���Ԅ��ГQ���b"
Outfitter.cTooltipInfo = "����Ʒ��ʾ���@ʾ'���ڣ�'"
Outfitter.cTooltipInfoOnDescription = "�P�]��������ʾ���@ʾ' ���ڣ�'��Ϣ����������������܆��}���x���@���x헣�"
Outfitter.cTooltipInfoOffDescription = "�_��������ʾ���@ʾ'���ڣ�' ��Ϣ"
Outfitter.cRememberVisibility = "�^���ͱ����O��"
Outfitter.cRememberVisibilityOnDescription = "�P�]�������^���ͱ����b��ʹ�ýyһ���@/�[�O��"
Outfitter.cRememberVisibilityOffDescription = "�_����ӛס��ʹ��ÿ���^���ͱ����b����Ե��@/�[�O��"
Outfitter.cShowHotkeyMessages = "�@ʾ����I�Q�b��Ϣ"
Outfitter.cShowHotkeyMessagesOnDescription = "�P�]��ʹ�ÿ���I�Q�b�r���@ʾ��Ϣ"
Outfitter.cShowHotkeyMessagesOffDescription = "�_����ʹ�ÿ���I�Q�b�r���@ʾ��Ϣ"
Outfitter.cShowOutfitBar = "�@ʾoutfit bar"
Outfitter.cShowOutfitBarDescription = "�@ʾһ�����D�˵Ą����l������c���Q�b"
Outfitter.cEquipOutfitMessageFormat = "Outfitter: %s ���b��"
Outfitter.cUnequipOutfitMessageFormat = "Outfitter: %s δ�b��"

Outfitter.cAboutTitle = "�P�� Outfitter"
Outfitter.cAuthor = "John Stephen �� Bruce Quinton �OӋ������ %s Ҳ��ؕ�I��"
Outfitter.cTestersTitle = "Outfitter 4 �yԇ��"
Outfitter.cTestersNames = "%s"
Outfitter.cSpecialThanksTitle = "�؄e���x"
Outfitter.cSpecialThanksNames = "%s"
Outfitter.cTranslationCredit = "Translations by %s"
Outfitter.cURL = "wobbleworks.com"

Outfitter.cOpenOutfitter = "���_ Outfitter"

Outfitter.cKeyBinding = "���I����"

	BINDING_HEADER_OUTFITTER_TITLE = Outfitter.cTitle;
	BINDING_NAME_OUTFITTER_OUTFIT = "���_ Outfitter"

	BINDING_NAME_OUTFITTER_OUTFIT1  = "���b 1"
	BINDING_NAME_OUTFITTER_OUTFIT2  = "���b 2"
	BINDING_NAME_OUTFITTER_OUTFIT3  = "���b 3"
	BINDING_NAME_OUTFITTER_OUTFIT4  = "���b 4"
	BINDING_NAME_OUTFITTER_OUTFIT5  = "���b 5"
	BINDING_NAME_OUTFITTER_OUTFIT6  = "���b 6"
	BINDING_NAME_OUTFITTER_OUTFIT7  = "���b 7"
	BINDING_NAME_OUTFITTER_OUTFIT8  = "���b 8"
	BINDING_NAME_OUTFITTER_OUTFIT9  = "���b 9"
	BINDING_NAME_OUTFITTER_OUTFIT10 = "���b 10"

Outfitter.cShow = "�@ʾ"
Outfitter.cHide = "�[��"
Outfitter.cDontChange = "������׃"

Outfitter.cHelm = "�^��"
Outfitter.cCloak = "���L"

Outfitter.cAutomation = "�Ԅ�"

Outfitter.cDisableOutfit = "�������b"
Outfitter.cDisableAlways = "���ǽ���"
Outfitter.cDisableOutfitInBG = "�ڑ�������"
Outfitter.cDisableOutfitInCombat = "���н���"
Outfitter.cDisableOutfitInAQ40 = "�ڰ���������"
Outfitter.cDisableOutfitInNaxx = "�ڼ{���_��˹���� "
Outfitter.cDisabledOutfitName = "%s�����ã�"

Outfitter.cOutfitBar = "Outfit Bar"
Outfitter.cShowInOutfitBar = "��outfit bar���@ʾ"
Outfitter.cChangeIcon = "�x��D��..."

Outfitter.cMinimapButtonTitle = "Outfitter С�؈D���o"
Outfitter.cMinimapButtonDescription = "�c���x��ͬ���b�����τӵ���λ�á�"

Outfitter.cClassName = {}
Outfitter.cDruidClassName = "������"
Outfitter.cHunterClassName = "�C��"
Outfitter.cMageClassName = "����"
Outfitter.cPaladinClassName = "ʥ�Tʿ"
Outfitter.cPriestClassName = "����"
Outfitter.cRogueClassName = "������"
Outfitter.cShamanClassName = "�_�M��˾"
Outfitter.cWarlockClassName = "�gʿ"
Outfitter.cWarriorClassName = "��ʿ"

Outfitter.cBattleStance = "���ˑB"
Outfitter.cDefensiveStance = "�����ˑB"
Outfitter.cBerserkerStance = "���ˑB"

Outfitter.cWarriorBattleStance = "��ʿ�����ˑB"
Outfitter.cWarriorDefensiveStance = "��ʿ�������ˑB"
Outfitter.cWarriorBerserkerStance = "��ʿ�����ˑB"

Outfitter.cBearForm = "���ΑB"
Outfitter.cFlightForm = "�w���ΑB"
Outfitter.cSwiftFlightForm = "Ѹ���w���ΑB"
Outfitter.cCatForm = "�C���ΑB"
Outfitter.cAquaticForm = "ˮ���ΑB"
Outfitter.cTravelForm = "�����ΑB"
Outfitter.cDireBearForm = "�����ΑB"
Outfitter.cMoonkinForm = "�n�F�ΑB"
Outfitter.cTreeOfLifeForm = "����֮��"

Outfitter.cGhostWolfForm = "�Ļ�֮��"

Outfitter.cStealth = "����"

Outfitter.cDruidCasterForm = "��������ʩ���ΑB"
Outfitter.cDruidBearForm = "�����������ΑB"
Outfitter.cDruidCatForm = "���������C���ΑB"
Outfitter.cDruidAquaticForm = "��������ˮ���ΑB"
Outfitter.cDruidTravelForm = "�������������ΑB"
Outfitter.cDruidMoonkinForm = "���������n�F�ΑB"
Outfitter.cDruidFlightForm = "���������w���ΑB"
Outfitter.cDruidSwiftFlightForm = "��������Ѹ���w���ΑB"
Outfitter.cDruidTreeOfLifeForm = "������������֮��"
Outfitter.cDruidProwl = "��������Ӱ��"
Outfitter.cProwl = "Ӱ��"

Outfitter.cPriestShadowform = "��������Ӱ�ΑB"

Outfitter.cRogueStealth = "�I�\������"
Outfitter.cLockpickingOutfit = "�I�\:�_�i"

Outfitter.cShamanGhostWolf = "�_�M��˾���Ļ�֮��"

Outfitter.cHunterMonkey = "�C�ˣ��`�����o"
Outfitter.cHunterHawk =  "�C�ˣ��������o"
Outfitter.cHunterCheetah =  "�C�ˣ��C�����o"
Outfitter.cHunterPack =  "�C�ˣ���Ⱥ���o"
Outfitter.cHunterBeast =  "�C�ˣ�Ұ�F���o"
Outfitter.cHunterWild =  "�C�ˣ�Ұ�����o"
Outfitter.cHunterViper = "�C�ˣ��������o"
Outfitter.cHunterFeignDeath = "�C�ˣ�����"

Outfitter.cMageEvocate = "����������"

Outfitter.cAspectOfTheCheetah = "�C�����o"
Outfitter.cAspectOfThePack = "��Ⱥ���o"
Outfitter.cAspectOfTheBeast = "Ұ�F���o"
Outfitter.cAspectOfTheWild = "Ұ�����o"
Outfitter.cAspectOfTheViper = "�������o"
Outfitter.cEvocate = "����"

Outfitter.cCompleteCategoryDescripton = "ȫ�����bָ����ÿ��λ�õ��b�䣬�Q�b�r����Q�������b��"
Outfitter.cAccessoryCategoryDescription = "�������bֻ��ָ���˲���λ�õ��b�䡣ϲ�g��Ԓ�����ͬ�r�b����׸������b"
Outfitter.cOddsNEndsCategoryDescription = "������Ʒ������δ���F���κ����b���b���б���Ҫ��̎�ǿ���׌��_�Jʹ���������b����ߛ]�Дy�������������"

Outfitter.cRebuildOutfitFormat = "�ؽ� %s"

Outfitter.cSlotEnableTitle = "���Sλ��"
Outfitter.cSlotEnableDescription = "�x�������ϣ�����ГQ����ǰ���b�r���Q�@��λ�õ��b�䣻���x���@��λ�����ГQ����ǰ���b�r�������κθ�׃��"

Outfitter.cFinger0SlotName = "��ָ���ϣ�"
Outfitter.cFinger1SlotName = "��ָ���£�"

Outfitter.cTrinket0SlotName = "�Ʒ���ϣ�"
Outfitter.cTrinket1SlotName = "�Ʒ���£�"

Outfitter.cOutfitCategoryTitle = "���"
Outfitter.cBankCategoryTitle = "�y��"
Outfitter.cDepositToBank = "��������b�䵽�y��"
Outfitter.cDepositUniqueToBank = "���Ψһ�b�䵽�y��"
Outfitter.cWithdrawFromBank = "���y��ȡ���b��"

Outfitter.cMissingItemsLabel = "δ�ҵ���"
Outfitter.cBankedItemsLabel = "�y�У�"

Outfitter.cRepairAllBags = "Outfitter: ����y���������b��"
Outfitter.cStatsCategory = "����"
Outfitter.cMeleeCategory = "����"
Outfitter.cSpellsCategory = "�ί��ͷ��g"
Outfitter.cRegenCategory = "�֏�"
Outfitter.cResistCategory = "����"
Outfitter.cTradeCategory = "�̘I����"

Outfitter.cTankPoints = "̹�c"
Outfitter.cCustom = "�Զ��x"

Outfitter.cScriptFormat = "�_�� (%s)"
Outfitter.cScriptSettings = "�O��..."
Outfitter.cNoScript = "�o"
Outfitter.cDisableScript = "�����_��"
Outfitter.cDisableIn = "���ø���"
Outfitter.cEditScriptTitle = "���b��%s ���_��"
Outfitter.cEditScriptEllide = "�Զ��x..."
Outfitter.cEventsLabel = "�¼���"
Outfitter.cScriptLabel = "�_����"
Outfitter.cSetCurrentItems = "ʹ�î�ǰ�b��"
Outfitter.cConfirmSetCurrentMsg = "��_�JҪʹ�î�ǰ�b��������b��%s��\nע��ֻ�Ю�ǰ���õ�λ�òŕ������� \n -- ��Ҳ�������Ժ�������λ�á�"
Outfitter.cSetCurrent = "����"
Outfitter.cTyping = "ݔ��..."
Outfitter.cScriptErrorFormat = "�e�`�l���� %d �У�%s"
Outfitter.cExtractErrorFormat = "%[�ַ��� \"���b�_��\"%]:(%d+):(.*)"
Outfitter.cPresetScript = "�A�O�_����"
Outfitter.cCustomScript = "�Զ��x"
Outfitter.cSettings = "�O��"
Outfitter.cSource = "Դ"
Outfitter.cInsertFormat = "<- %s"

Outfitter.cContainerBagSubType = "����"
Outfitter.cUsedByPrefix = "�������b��"

Outfitter.cNone = "�o"
Outfitter.cTooltipMultibuffSeparator1 = " �� "
Outfitter.cTooltipMultibuffSeparator2 = " / "
Outfitter.cNoScriptSettings = "�@���_���]���O���x헡�"
Outfitter.cMissingItemsSeparator = "��"
Outfitter.cUnequipOthers = "�b��󣬓Q�������������b"

Outfitter.cConfirmResetMsg = "��_��Ҫ�����@����ɫ��Outfitter�O�ã������h���������b���ؽ�Ĭ�J���b��"
Outfitter.cReset = "����"

Outfitter.cIconFilterLabel = "������"
Outfitter.cIconSetLabel = "�D�ˣ�"

Outfitter.cCantReloadUI = "����������ħ�F�����Outfitter���@�ΰ汾����"
Outfitter.cChooseIconTitle = "�� %s ���b�x��һ���D��"
Outfitter.cOutfitterDecides = "Outfitter �������x��һ���D��"

Outfitter.cSuggestedIcons = "���hʹ�ÈD��"
Outfitter.cSpellbookIcons = "��ļ��ܕ�"
Outfitter.cYourItemIcons = "��ı���"
Outfitter.cEveryIcon = "ȫ���D��"
Outfitter.cItemIcons = "ȫ���D�ˣ�ֻ������Ʒ��"
Outfitter.cAbilityIcons = "ȫ���D�ˣ�ֻ�������ܣ�"

Outfitter.cRequiresLockpicking = "��Ҫ�_�i"
Outfitter.cUseDurationTooltipLineFormat = "^Use: .* for (%d+) sec"

Outfitter.cOutfitBarSizeLabel = "�ߴ�"
Outfitter.cOutfitBarSmallSizeLabel = "С"
Outfitter.cOutfitBarLargeSizeLabel = "��"
Outfitter.cOutfitBarAlphaLabel = "͸����"
Outfitter.cOutfitBarCombatAlphaLabel = "��͸����"
Outfitter.cOutfitBarVerticalLabel = "��ֱ����"
Outfitter.cOutfitBarLockPositionLabel = "�i��λ��"
Outfitter.cOutfitBarHideBackgroundLabel = "�[�ر���"

Outfitter.cPositionLockedError = "Outfit Bar ���ܱ��Ƅ�������ѽ��i��������λ��"
end
