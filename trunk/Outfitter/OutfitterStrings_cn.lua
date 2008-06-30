if GetLocale() == "zhCN" then

Outfitter.cTitle = "Outfitter"
Outfitter.cTitleVersion = Outfitter.cTitle.." "..Outfitter.cVersion

Outfitter.cSingleItemFormat = "%s"
Outfitter.cTwoItemFormat = "%s 和 %s"
Outfitter.cMultiItemFormat = "%s{{, %s}} 和 %s"

Outfitter.cNameLabel = "名称："
Outfitter.cCreateUsingTitle = "优化方向："
Outfitter.cUseCurrentOutfit = "使用当前套装"
Outfitter.cUseEmptyOutfit = "新建空白套装"
Outfitter.cAutomationLabel = "自动："

Outfitter.cOutfitterTabTitle = "Outfitter"
Outfitter.cOptionsTabTitle = "选项"
Outfitter.cAboutTabTitle = "关于"

Outfitter.cNewOutfit = "新建套装"
Outfitter.cRenameOutfit = "重命名套装"

Outfitter.cCompleteOutfits = "全部套装"
Outfitter.cAccessoryOutfits = "附属套装"
Outfitter.cOddsNEndsOutfits = "零碎物品"

Outfitter.cGlobalCategory = "特殊套装"
Outfitter.cNormalOutfit = "普通"
Outfitter.cNakedOutfit = "裸体"

Outfitter.cScriptCategoryName = {}
Outfitter.cScriptCategoryName.PVP = "PvP"
Outfitter.cScriptCategoryName.TRADE = "激活"
Outfitter.cScriptCategoryName.GENERAL = "一般"

Outfitter.cArgentDawnOutfit = "银色黎明"
Outfitter.cCityOutfit = "城内展示"
Outfitter.cBattlegroundOutfit = "战场"
Outfitter.cAVOutfit = "战场：奥特兰克山脉"
Outfitter.cABOutfit = "战场：阿拉希盆地"
Outfitter.cArenaOutfit = "战场：竞技场"
Outfitter.cEotSOutfit = "战场：风暴之眼"
Outfitter.cWSGOutfit = "战场：战歌峡谷"
Outfitter.cDiningOutfit = "吃喝"
Outfitter.cFishingOutfit = "钓鱼"
Outfitter.cHerbalismOutfit = "草药学"
Outfitter.cMiningOutfit = "采矿"
Outfitter.cFireResistOutfit = "抗性：火焰"
Outfitter.cNatureResistOutfit = "抗性：自然"
Outfitter.cShadowResistOutfit = "抗性：暗影"
Outfitter.cArcaneResistOutfit = "抗性：奥术"
Outfitter.cFrostResistOutfit = "抗性：冰霜"
Outfitter.cRidingOutfit = "骑乘"
Outfitter.cSkinningOutfit = "剥皮"
Outfitter.cSwimmingOutfit = "游泳"
Outfitter.cLowHealthOutfit = "低生命/法力"
Outfitter.cHasBuffOutfit = "身具Buff"
Outfitter.cInZonesOutfit = "在地区"
Outfitter.cSoloOutfit = "Solo/小队/团队"
Outfitter.cFallingOutfit = "跌落"

Outfitter.cArgentDawnOutfitDescription = "在瘟疫之地自动换装"
Outfitter.cRidingOutfitDescription = "骑乘时自动换装"
Outfitter.cDiningOutfitDescription = "吃喝时自动换装"
Outfitter.cBattlegroundOutfitDescription = "在战场内自动换装"
Outfitter.cArathiBasinOutfitDescription = "在阿拉希盆地内自动换装"
Outfitter.cAlteracValleyOutfitDescription = "在奥特兰克山谷内自动换装"
Outfitter.cWarsongGulchOutfitDescription = "在战歌峡谷内自动换装"
Outfitter.cEotSOutfitDescription = "在风暴之眼内自动换装"
Outfitter.cArenaOutfitDescription = "在PVP竞技场内自动换装"
Outfitter.cCityOutfitDescription = "友方主城内自动换装"
Outfitter.cSwimmingOutfitDescription = "游泳时自动换装"
Outfitter.cFishingOutfitDescription = "进入战斗会自动换下并在脱离战斗时重新装备"
Outfitter.cSpiritOutfitDescription = "回魔时(脱离5秒规则)自动装备此套"
Outfitter.cHerbalismDescription = "鼠标滑过显示为橙色或红色的草药点时自动换装"
Outfitter.cMiningDescription = "鼠标滑过显示为橙色或红色的矿点时自动换装"
Outfitter.cLockpickingDescription = "鼠标滑过显示为橙色或红色的锁时自动换装"
Outfitter.cSkinningDescription = "鼠标滑过显示为橙色或红色的可剥皮生物时自动换装"
Outfitter.cLowHealthDescription = "生命或者法力低于特定值时自动换装"
Outfitter.cHasBuffDescription = "当身具特定名称buff时自动换装"
Outfitter.SpiritRegenOutfitDescription = "回魔时(脱离5秒规则)自动装备此套"
Outfitter.cDruidCasterFormDescription = "不在任何德鲁伊形态时自动换装"
Outfitter.cPriestShadowformDescription = "暗影形态自动换装"
Outfitter.cShamanGhostWolfDescription = "幽灵狼形态自动换装"
Outfitter.cHunterMonkeyDescription = "灵猴守护自动换装"
Outfitter.cHunterHawkDescription = "雄鹰守护自动换装"
Outfitter.cHunterCheetahDescription = "猎豹守护自动换装"
Outfitter.cHunterPackDescription = "豹群守护自动换装"
Outfitter.cHunterBeastDescription = "野兽守护自动换装"
Outfitter.cHunterWildDescription = "野性守护自动换装"
Outfitter.cHunterViperDescription = "蝰蛇守护自动换装"
Outfitter.cHunterFeignDeathDescription = "假死自动换装"
Outfitter.cMageEvocateDescription = "激活状态自动换装"
Outfitter.cWarriorBerserkerStanceDescription = "狂暴姿态自动换装"
Outfitter.cWarriorDefensiveStanceDescription = "防御姿态自动换装"
Outfitter.cWarriorBattleStanceDescription = "战斗姿态自动换装"
Outfitter.cInZonesOutfitDescription = "当你在以下区域的时候自动换装"
Outfitter.cSoloOutfitDescription = "未组队时自动换装"
Outfitter.cFallingOutfitDescription = "从高空摔下时自动换装"

Outfitter.cMountSpeedFormat = "速度提高(%d+)%%%."; -- For detecting when mounted
Outfitter.cFlyingMountSpeedFormat = "飞行速度提高(%d+)%%%"; -- For detecting when mounted

Outfitter.cBagsFullError = "Outfitter: 不能移除%s：全部背包都满了"
Outfitter.cDepositBagsFullError = "Outfitter: ，不能存放%s：全部银行背包都满了"
Outfitter.cWithdrawBagsFullError = "Outfitter: 不能取出%s：全部背包都满了，"
Outfitter.cItemNotFoundError = "Outfitter: 未找到%s"
Outfitter.cItemAlreadyUsedError = "Outfitter: 不能将%s放入%s：已经穿戴在另一个位置"
Outfitter.cAddingItem = "Outfitter: 添加 %s 到套装：%s"
Outfitter.cNameAlreadyUsedError = "错误：此名字已经被使用"
Outfitter.cNoItemsWithStatError = "警告：没有装备包含这个属性"
Outfitter.cCantUnequipCompleteError = "Outfitter: 不能换下 %s，因为不能换下全部套装（你必须装备另一套全部套装）。"

Outfitter.cEnableAll = "启用所有"
Outfitter.cEnableNone = "禁用所有"

Outfitter.cConfirmDeleteMsg = "你确认要删除套装：%s？"
Outfitter.cConfirmRebuildMsg = "你确认要重建套装：%s？"
Outfitter.cRebuild = "重建"

Outfitter.cWesternPlaguelands = "西瘟疫之地"
Outfitter.cEasternPlaguelands = "东瘟疫之地"
Outfitter.cStratholme = "斯坦索姆"
Outfitter.cScholomance = "通灵学院"
Outfitter.cNaxxramas = "纳克萨玛斯"
Outfitter.cAlteracValley = "奥特兰克山谷"
Outfitter.cArathiBasin = "阿拉希盆地"
Outfitter.cWarsongGulch = "战歌峡谷"
Outfitter.cEotS = "风暴之眼"
Outfitter.cIronforge = "铁炉堡"
Outfitter.cCityOfIronforge = "铁炉堡"
Outfitter.cDarnassus = "达纳苏斯"
Outfitter.cStormwind = "暴风城"
Outfitter.cOrgrimmar = "奥格瑞玛"
Outfitter.cThunderBluff = "雷霆崖"
Outfitter.cUndercity = "幽暗城"
Outfitter.cSilvermoon = "银月城"
Outfitter.cExodar = "埃索达"
Outfitter.cShattrath = "沙塔斯城"
Outfitter.cAQ40 = "安其拉"
Outfitter.cBladesEdgeArena = "刀锋山竞技场"
Outfitter.cNagrandArena = "纳格兰竞技场"
Outfitter.cRuinsOfLordaeron = "洛丹伦废墟"

Outfitter.cItemStatFormats =
{
		{Format = "坐骑移动速度略微提升", Value = 3, Types = {"Riding"}},
		{Format = "秘银马刺", Value = 3, Types = {"Riding"}},
	
    "提高法术和魔法效果所造成的伤害和治疗效果，最多(%d+)点",
    "使所有法术和魔法效果所造成的伤害和治疗效果提高最多(%d+)点",
    "使你的法术伤害提高最多(%d+)点，以及你的治疗效果最多(%d+)点",
    "提高所有法术和魔法效果所造成的伤害和治疗效果(%d+)点",
    "^(.-)提高最多([%d%.]+)点(.-)$",
    "^(.-)提高最多([%d%.]+)(.-)$",
    "^(.-)，最多([%d%.]+)点(.-)$",
    "^(.-)，最多([%d%.]+)(.-)$",
    "^(.-)最多([%d%.]+)点(.-)$",
    "^(.-)最多([%d%.]+)(.-)$",
    "^(.-)提高([%d%.]+)点(.-)$",
    "^(.-)提高([%d%.]+)(.-)$",
    "%+(%d+) (.+)，%+(%d+) (.+)", -- Multi-stat items like secondary-color gems
    "%+(%d+) (.+)/%+(%d+) (.+)/%+(%d+) (.+)", -- Multi-stat enchants from ZG
    "%+(%d+) (.+)/%+(%d+) (.+)", -- Multi-stat enchants from ZG
	
	"提高 (.+) %+(%d+)",
	"提升 (.+) by (%d+)",
	
	"回复 (%d+) (.+)",
	
		"%+(%d+) (%w+)法术伤害",
	
	"(%d+) (.+)",
	"(.+) %+(%d+)",
}

Outfitter.cItemStatPhrases =
{
		["耐力"] = "Stamina",
		["智力"] = "Intellect",
		["敏捷"] = "Agility",
		["力量"] = "Strength",
		["精神"] = "Spirit",
		["所有属性"] = {"Stamina", "Intellect", "Agility", "Strength", "Spirit"},
	
		["护甲"] = "Armor",
	
		["法力值"] = "Mana",
		["生命值"] = "Health",
	
		["火焰抗性"] = "FireResist",
		["自然抗性"] = "NatureResist",
		["冰霜抗性"] = "FrostResist",
		["暗影抗性"] = "ShadowResist",
		["奥术抗性"] = "ArcaneResist",
		["所有抗性"] = {"FireResist", "NatureResist", "FrostResist", "ShadowResist", "ArcaneResist"},
	
		["防御等级"] = "DefenseRating",
		["韧性等级"] = "ResilienceRating",
		["攻击强度"] = {"Attack", "RangedAttack"},
		["远程攻击强度"] = "RangedAttack",
		["爆击等级"] = "MeleeCritRating",
		["命中等级"] = "MeleeHitRating",
		["躲闪等级"] = "DodgeRating",
		["招架等级"] = "ParryRating",
		["格挡"] = "Block",
		["格挡值"] = "Block",
		["武器伤害"] = "MeleeDmg",
		["近战伤害"] = "MeleeDmg",
		["伤害"] = "MeleeDmg",
	
		["法术爆击等级"] = "SpellCritRating",
		["法术爆击"] = "SpellCritRating",
		["法术命中等级"] = "SpellHitRating",
		["法术穿透"] = "SpellPen",
	    ["法术急速等级"] = "SpellHasteRating",
	
	["法术伤害和治疗效果"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"},
		["法术伤害"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg"},
		["魔法伤害和效果"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg"},
	["法术伤害和治疗"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"},
	["法术伤害"] = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg"},
	
		["火焰"] = "FireDmg",
		["暗影"] = "ShadowDmg",
		["冰霜"] = "FrostDmg",
		["奥术"] = "ArcaneDmg",
		["自然"] = "NatureDmg",
	
	["healing done by spells and effects"] = "Healing",
		["治疗"] = "Healing",
		["治疗法术"] = "Healing",
	
		["钓鱼"] = "Fishing",
		["草药学"] = "Herbalism",
		["采矿"] = "Mining",
		["剥皮"] = "Skinning",
		["坐骑速度"] = "Riding",
	
		["每5秒法力"] = {"ManaRegen", "CombatManaRegen"},
	["mana regen"] = {"ManaRegen", "CombatManaRegen"},
	["health per 5 sec"] = {"HealthRegen", "CombatHealthRegen"},
	["health regen"] = {"HealthRegen", "CombatHealthRegen"},
}

Outfitter.cAgilityStatName = "敏捷"
Outfitter.cArmorStatName = "护甲"
Outfitter.cDefenseStatName = "防御"
Outfitter.cIntellectStatName = "智力"
Outfitter.cSpiritStatName = "精神"
Outfitter.cStaminaStatName = "耐力"
Outfitter.cStrengthStatName = "力量"
Outfitter.cTotalStatsName = "所有属性"
Outfitter.cHealthStatName = "生命值"
Outfitter.cManaStatName = "法力值"

Outfitter.cManaRegenStatName = "法力恢复"
Outfitter.cCombatManaRegenStatName = "5秒回魔(战斗)"
Outfitter.cHealthRegenStatName = "生命恢复"
Outfitter.cCombatHealthRegenStatName = "5秒回血(战斗)"

Outfitter.cSpellCritStatName = "法术爆击"
Outfitter.cSpellHitStatName = "法术命中"
Outfitter.cSpellDmgStatName = "法术伤害"
Outfitter.cSpellHasteStatName = "法术急速"
Outfitter.cFrostDmgStatName = "冰霜伤害"
Outfitter.cFireDmgStatName = "火焰伤害"
Outfitter.cArcaneDmgStatName = "奥术伤害"
Outfitter.cShadowDmgStatName = "暗影伤害"
Outfitter.cNatureDmgStatName = "自然伤害"
Outfitter.cHealingStatName = "治疗"

Outfitter.cMeleeCritStatName = "物理爆击"
Outfitter.cMeleeHitStatName = "物理命中"
Outfitter.cMeleeHasteStatName = "法术急速等级"
Outfitter.cMeleeDmgStatName = "近战伤害"
Outfitter.cAttackStatName = "攻击强度"
Outfitter.cRangedAttackStatName = "远程攻击强度"
Outfitter.cDodgeStatName = "躲闪"
Outfitter.cParryStatName = "招架"
Outfitter.cBlockStatName = "格挡"
Outfitter.cResilienceStatName = "韧性"

Outfitter.cArcaneResistStatName = "奥术抗性"
Outfitter.cFireResistStatName = "火焰抗性"
Outfitter.cFrostResistStatName = "冰霜抗性"
Outfitter.cNatureResistStatName = "自然抗性"
Outfitter.cShadowResistStatName = "暗影抗性"

Outfitter.cFishingStatName = "钓鱼"
Outfitter.cHerbalismStatName = "草药学"
Outfitter.cMiningStatName = "采矿"
Outfitter.cSkinningStatName = "剥皮"

Outfitter.cOptionsTitle = "Outfitter 选项"
Outfitter.cShowMinimapButton = "显示小地图按钮"
Outfitter.cShowMinimapButtonOnDescription = "关闭：不在小地图上显示 Outfitter 按钮"
Outfitter.cShowMinimapButtonOffDescription = "开启：在小地图上显示 Outfitter 按钮"
Outfitter.cAutoSwitch = "禁用自动切换套装"
Outfitter.cAutoSwitchOnDescription = "开启：禁用自动切换套装"
Outfitter.cAutoSwitchOffDescription = "关闭：开启自动切换套装"
Outfitter.cTooltipInfo = "在物品提示上显示'用于：'"
Outfitter.cTooltipInfoOnDescription = "关闭：不在提示上显示' 用于：'信息（如果你遇到了性能问题，选择这个选项）"
Outfitter.cTooltipInfoOffDescription = "开启：在提示上显示'用于：' 信息"
Outfitter.cRememberVisibility = "头部和背部设置"
Outfitter.cRememberVisibilityOnDescription = "关闭：所有头部和背部装备使用统一的显/隐设置"
Outfitter.cRememberVisibilityOffDescription = "开启：记住并使用每件头部和背部装备各自的显/隐设置"
Outfitter.cShowHotkeyMessages = "显示快捷键换装信息"
Outfitter.cShowHotkeyMessagesOnDescription = "关闭：使用快捷键换装时不显示信息"
Outfitter.cShowHotkeyMessagesOffDescription = "开启：使用快捷键换装时不显示信息"
Outfitter.cShowOutfitBar = "显示outfit bar"
Outfitter.cShowOutfitBarDescription = "显示一个带图标的动作条你可以点击换装"
Outfitter.cEquipOutfitMessageFormat = "Outfitter: %s 已装备"
Outfitter.cUnequipOutfitMessageFormat = "Outfitter: %s 未装备"

Outfitter.cAboutTitle = "关于 Outfitter"
Outfitter.cAuthor = "John Stephen 和 Bruce Quinton 设计编写， %s 也有贡献。"
Outfitter.cTestersTitle = "Outfitter 4.1 测试者"
Outfitter.cTestersNames = "%s"
Outfitter.cSpecialThanksTitle = "特别感谢"
Outfitter.cSpecialThanksNames = "%s"
Outfitter.cTranslationCredit = "Translations by %s"
Outfitter.cURL = "wobbleworks.com"

Outfitter.cOpenOutfitter = "打开 Outfitter"

Outfitter.cKeyBinding = "按键绑定"

	BINDING_HEADER_OUTFITTER_TITLE = Outfitter.cTitle;
	BINDING_NAME_OUTFITTER_OUTFIT = "打开 Outfitter"

	BINDING_NAME_OUTFITTER_OUTFIT1  = "套装 1"
	BINDING_NAME_OUTFITTER_OUTFIT2  = "套装 2"
	BINDING_NAME_OUTFITTER_OUTFIT3  = "套装 3"
	BINDING_NAME_OUTFITTER_OUTFIT4  = "套装 4"
	BINDING_NAME_OUTFITTER_OUTFIT5  = "套装 5"
	BINDING_NAME_OUTFITTER_OUTFIT6  = "套装 6"
	BINDING_NAME_OUTFITTER_OUTFIT7  = "套装 7"
	BINDING_NAME_OUTFITTER_OUTFIT8  = "套装 8"
	BINDING_NAME_OUTFITTER_OUTFIT9  = "套装 9"
	BINDING_NAME_OUTFITTER_OUTFIT10 = "套装 10"

Outfitter.cShow = "显示"
Outfitter.cHide = "隐藏"
Outfitter.cDontChange = "不作改变"

Outfitter.cHelm = "头盔"
Outfitter.cCloak = "披风"

Outfitter.cAutomation = "自动"

Outfitter.cDisableOutfit = "禁用套装"
Outfitter.cDisableAlways = "总是禁用"
Outfitter.cDisableOutfitInBG = "在战场禁用"
Outfitter.cDisableOutfitInCombat = "战斗中禁用"
Outfitter.cDisableOutfitInAQ40 = "在安其拉禁用"
Outfitter.cDisableOutfitInNaxx = "在纳克萨玛斯禁用 "
Outfitter.cDisabledOutfitName = "%s（禁用）"

Outfitter.cOutfitBar = "Outfit Bar"
Outfitter.cShowInOutfitBar = "在outfit bar上显示"
Outfitter.cChangeIcon = "选择图标..."

Outfitter.cMinimapButtonTitle = "Outfitter 小地图按钮"
Outfitter.cMinimapButtonDescription = "点击选择不同套装或者拖动到新位置。"

Outfitter.cClassName = {}
Outfitter.cClassName.DRUID = "德鲁伊"
Outfitter.cClassName.HUNTER = "猎人"
Outfitter.cClassName.MAGE = "法师"
Outfitter.cClassName.PALADIN = "圣骑士"
Outfitter.cClassName.PRIEST = "牧师"
Outfitter.cClassName.ROGUE = "潜行者"
Outfitter.cClassName.SHAMAN = "萨满祭司"
Outfitter.cClassName.WARLOCK = "术士"
Outfitter.cClassName.WARRIOR = "战士"

Outfitter.cBattleStance = "战斗姿态"
Outfitter.cDefensiveStance = "防御姿态"
Outfitter.cBerserkerStance = "狂暴姿态"

Outfitter.cWarriorBattleStance = "战士：战斗姿态"
Outfitter.cWarriorDefensiveStance = "战士：防御姿态"
Outfitter.cWarriorBerserkerStance = "战士：狂暴姿态"

Outfitter.cBearForm = "熊形态"
Outfitter.cFlightForm = "飞行形态"
Outfitter.cSwiftFlightForm = "迅捷飞行形态"
Outfitter.cCatForm = "猎豹形态"
Outfitter.cAquaticForm = "水生形态"
Outfitter.cTravelForm = "旅行形态"
Outfitter.cDireBearForm = "巨熊形态"
Outfitter.cMoonkinForm = "枭兽形态"
Outfitter.cTreeOfLifeForm = "生命之树"

Outfitter.cGhostWolfForm = "幽魂之狼"

Outfitter.cStealth = "潜行"

Outfitter.cDruidCasterForm = "德鲁伊：施法形态"
Outfitter.cDruidBearForm = "德鲁伊：熊形态"
Outfitter.cDruidCatForm = "德鲁伊：猎豹形态"
Outfitter.cDruidAquaticForm = "德鲁伊：水生形态"
Outfitter.cDruidTravelForm = "德鲁伊：旅行形态"
Outfitter.cDruidMoonkinForm = "德鲁伊：枭兽形态"
Outfitter.cDruidFlightForm = "德鲁伊：飞行形态"
Outfitter.cDruidSwiftFlightForm = "德鲁伊：迅捷飞行形态"
Outfitter.cDruidTreeOfLifeForm = "德鲁伊：生命之树"
Outfitter.cDruidProwl = "德鲁伊：影遁"
Outfitter.cProwl = "影遁"

Outfitter.cPriestShadowform = "牧师：暗影形态"

Outfitter.cRogueStealth = "盗贼：潜行"
Outfitter.cLockpickingOutfit = "盗贼:开锁"

Outfitter.cShamanGhostWolf = "萨满祭司：幽魂之狼"

Outfitter.cHunterMonkey = "猎人：灵猴守护"
Outfitter.cHunterHawk =  "猎人：雄鹰守护"
Outfitter.cHunterCheetah =  "猎人：猎豹守护"
Outfitter.cHunterPack =  "猎人：豹群守护"
Outfitter.cHunterBeast =  "猎人：野兽守护"
Outfitter.cHunterWild =  "猎人：野性守护"
Outfitter.cHunterViper = "猎人：蝰蛇守护"
Outfitter.cHunterFeignDeath = "猎人：假死"

Outfitter.cMageEvocate = "法师：唤醒"

Outfitter.cAspectOfTheCheetah = "猎豹守护"
Outfitter.cAspectOfThePack = "豹群守护"
Outfitter.cAspectOfTheBeast = "野兽守护"
Outfitter.cAspectOfTheWild = "野性守护"
Outfitter.cAspectOfTheViper = "蝰蛇守护"
Outfitter.cEvocate = "唤醒"

Outfitter.cCompleteCategoryDescripton = "全部套装指定了每个位置的装备，换装时将替换所有套装。"
Outfitter.cAccessoryCategoryDescription = "附属套装只是指定了部分位置的装备。喜欢的话你可以同时装备几套附属套装"
Outfitter.cOddsNEndsCategoryDescription = "零碎物品是所有未出现于任何套装的装备列表。主要用处是可以让你确认使用了所有装备或者没有携带多余的垃圾。"

Outfitter.cRebuildOutfitFormat = "重建 %s"

Outfitter.cSlotEnableTitle = "允许位置"
Outfitter.cSlotEnableDescription = "选择：如果你希望在切换至当前套装时更换这个位置的装备；不选：这个位置在切换至当前套装时不会有任何改变。"

Outfitter.cFinger0SlotName = "戒指（上）"
Outfitter.cFinger1SlotName = "戒指（下）"

Outfitter.cTrinket0SlotName = "饰品（上）"
Outfitter.cTrinket1SlotName = "饰品（下）"

Outfitter.cOutfitCategoryTitle = "分类"
Outfitter.cBankCategoryTitle = "银行"
Outfitter.cDepositToBank = "存放所有装备到银行"
Outfitter.cDepositUniqueToBank = "存放唯一装备到银行"
Outfitter.cWithdrawFromBank = "从银行取出装备"

Outfitter.cMissingItemsLabel = "未找到："
Outfitter.cBankedItemsLabel = "银行："

Outfitter.cStatsCategory = "属性"
Outfitter.cMeleeCategory = "近战"
Outfitter.cSpellsCategory = "治疗和法术"
Outfitter.cRegenCategory = "恢复"
Outfitter.cResistCategory = "抗性"
Outfitter.cTradeCategory = "商业技能"

Outfitter.cTankPoints = "坦点"
Outfitter.cCustom = "自定义"

Outfitter.cScriptFormat = "脚本 (%s)"
Outfitter.cScriptSettings = "设置..."
Outfitter.cNoScript = "无"
Outfitter.cDisableScript = "禁用脚本"
Outfitter.cDisableIn = "禁用更多"
Outfitter.cEditScriptTitle = "套装：%s 的脚本"
Outfitter.cEditScriptEllide = "自定义..."
Outfitter.cEventsLabel = "事件："
Outfitter.cScriptLabel = "脚本："
Outfitter.cSetCurrentItems = "使用当前装备"
Outfitter.cConfirmSetCurrentMsg = "你确认要使用当前装备更新套装：%s？\n注：只有当前启用的位置才会被更新 \n -- 你也可以在以后启用其它位置。"
Outfitter.cSetCurrent = "更新"
Outfitter.cTyping = "输入..."
Outfitter.cScriptErrorFormat = "错误发生在 %d 行：%s"
Outfitter.cExtractErrorFormat = "%[字符串 \"套装脚本\"%]:(%d+):(.*)"
Outfitter.cPresetScript = "预设脚本："
Outfitter.cCustomScript = "自定义"
Outfitter.cSettings = "设置"
Outfitter.cSource = "源"
Outfitter.cInsertFormat = "<- %s"

Outfitter.cContainerBagSubType = "容器"
Outfitter.cUsedByPrefix = "用于套装："

Outfitter.cNone = "无"
Outfitter.cTooltipMultibuffSeparator1 = " 和 "
Outfitter.cTooltipMultibuffSeparator2 = " / "
Outfitter.cNoScriptSettings = "这个脚本没有设置选项。"
Outfitter.cMissingItemsSeparator = "，"
Outfitter.cUnequipOthers = "装备后，换下其他附属套装"

Outfitter.cConfirmResetMsg = "你确定要重置这个角色的Outfitter设置？将会删除所有套装并重建默认套装。"
Outfitter.cReset = "重置"

Outfitter.cIconFilterLabel = "搜索："
Outfitter.cIconSetLabel = "图标："

Outfitter.cCantReloadUI = "你必须重新启动魔兽来完成Outfitter的这次版本更新"
Outfitter.cChooseIconTitle = "为 %s 套装选择一个图标"
Outfitter.cOutfitterDecides = "Outfitter 将为你选择一个图标"

Outfitter.cSuggestedIcons = "建议使用图标"
Outfitter.cSpellbookIcons = "你的技能书"
Outfitter.cYourItemIcons = "你的背包"
Outfitter.cEveryIcon = "全部图标"
Outfitter.cItemIcons = "全部图标（只包含物品）"
Outfitter.cAbilityIcons = "全部图标（只包含技能）"

Outfitter.cRequiresLockpicking = "需要开锁"
Outfitter.cUseDurationTooltipLineFormat = "^Use: .* for (%d+) sec"

Outfitter.cOutfitBarSizeLabel = "尺寸"
Outfitter.cOutfitBarSmallSizeLabel = "小"
Outfitter.cOutfitBarLargeSizeLabel = "大"
Outfitter.cOutfitBarAlphaLabel = "透明度"
Outfitter.cOutfitBarCombatAlphaLabel = "战斗透明度"
Outfitter.cOutfitBarVerticalLabel = "垂直排列"
Outfitter.cOutfitBarLockPositionLabel = "锁定位置"
Outfitter.cOutfitBarHideBackgroundLabel = "隐藏背景"

Outfitter.cPositionLockedError = "Outfit Bar 不能被移动因为你已经锁定了它的位置"

Outfitter.cMustBeAtBankError = "你必须保持你的银行为打开状态来创建一个未找到物品列表"
Outfitter.cMissingItemReportIntro = "未找到物品（如果一件物品被多个套装使用它将在列表中出现多次）:"
Outfitter.cNoMissingItems = "没有装备未找到"

Outfitter.cAutoChangesDisabled = "自动换装已禁用"
Outfitter.cAutoChangesEnabled = "自动换装已启用"

end