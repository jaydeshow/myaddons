﻿--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of PDI175, lostcup
--

local L = AceLibrary("AceLocale-2.2"):new("AutoBar")

L:RegisterTranslations("zhCN", function() return {
		["AutoBar"] = "消耗品助手",
		["CONFIG_WINDOW"] = "设置窗口",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["Button"] = "按钮",
		["EDITSLOT"] = "编辑按钮",
		["VIEWSLOT"] = "察看按钮",
		["LOAD_ERROR"] = "|cff00ff00载入 AutoBarConfig 发生错误。 请确定是否有这个插件，并启用插件。|r 错误：",
		["Toggle the config panel"] = "切换消耗品助手设置窗口",
		["Empty"] = "空白",

		-- Waterfall
	["Macro Text"] = "宏标签",
	["Show the button Macro Text"] = "在按钮上显示宏标签",
	["Show Hotkey Text"] = "在按钮上显示热键名称",
	["Show Hotkey Text for %s"] = "在按钮上显示 %s 的热键名称",
	["Show Grid"] = "显示空按钮",
	["Show the grid of the bar even while locked."] = "即使是锁定动作条依然显示空按钮",
		["Alpha"] = "半透明",
		["Change the alpha of the bar."] = "改变动作条半透明",
		["Align Buttons"] = "按钮排列方向";
		["Always Show"] = "总是显示";
		["Always Show %s, even if empty."] = "即使是空的，也总是显示 %s。";
		["Bars"] = "动作条",
		["Battlegrounds only"] = "只能在战场使用";
		["Button Width"] = "按钮宽度";
		["Change the button width."] = "变更按钮的宽度",
		["Button Height"] = "按钮高度";
		["Change the button height."] = "变更按钮的高度",
		["Category"] = "类别",
		["Categories"] = "类别",
		["Categories for %s"] = "%s 的类别",
		["Collapse Buttons"] = "缩减按钮",
		["Collapse Buttons that have nothing in them."] = "当按钮位置无任何设置时，将不显示。",
		["Configuration for %s"] = "%s 的组态",
		["Delete"] = "删除",
		["Dialog"] = "对话框",
		["Docked to"] = "依附于";
		["Enabled"] = "开启",
		["Enable %s."] = "开启 %s",
		["No Popup"] = "不弹出";
		["No Popup for %s"] = "不弹出 %s";
		["Show Count Text"] = "隐显示数量显示";
		["Show Count Text for %s"] = "显示 %s 的数量显示";
		["Show Empty Buttons"] = "显示空按钮";
		["Show Empty Buttons for %s"] = "显示 %s 空按钮";
		["Number of columns for %s"] = "%s 栏的数量",
		["FadeOut"] = "渐隐",
		["Fade out the Bar when not hovering over it."] = "当滑鼠没通过上方时渐隐",
		["Frame Level"] = "框架等级",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "调整动作条和弹出按钮的框架等级，以免遮挡其他界面框架或被遮挡",
		["General"] = "一般",
		["Hide"] = "隐藏",
		["Hide %s"] = "隐藏 %s",
		["Item"] = "物品",
		["Items"] = "物品",
		["Location"] = "使用地点：";
		["Medium"] = "中等",
		["Name"] = "名称",
		["New"] = "新增",
		["Non Combat Only"] = " [仅用于非战斗状态]";
		["Not directly usable"] = "不能直接使用";
		["Order"] = "反向",
		["Change the order of %s in the Bar"] = "变更 %s 动作条的排列方向",
		["Padding"] = "间距",
		["Change the padding of the bar."] = "改变动作条按钮间距",
		["Popup Direction"] = "按钮弹出方向";
		["Refresh"] = "更新",
		["Refresh all the bars & buttons"] = "更新所有的动作条及按钮",
		["Reset"] = "重置为默认";
		["Reset Bars"] = "重制动作条",
		["Reset the Bars to default Bar settings"] = "重置动作条为默认设定值",
		["Rows"] = "行";
		["Number of rows for %s"] = "%s 的列数",
		["Scale"] = "缩放",
		["Change the scale of the bar."] = "改变动作条缩放",
		["Shift Dock Left/Right"] = "调整左右依附距离";
		["Shift Dock Up/Down"] = "调整上下依附距离";
		["Snap Bars while moving"] = "移动时缩起动作条",
		["Sticky Frames"] = "锁定框架",
		["Style"] = "风格",
		["Change the style of the bar."] = "改变动作条风格",
		["Targeted"] = "需目标.";
		["Waterfall-1.0 is required to access the GUI."] = "图形用户介面设定需要 Waterfall-1.0。",
		["<Any String>"] = "<任何字串>",
		["Move the Bars"] = "移动动作条",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "可拖曳动作条移动它，左键点击隐藏(红)或显示(绿)动作条，右键点击显示设定选项。",
		["Move the Buttons"] = "移动按钮",
		["Drag a Button to move it, right click to configure the Button."] = "拖曳按钮来移动它，右键点击来设定按钮。",

		["TOPLEFT"] = "上左",
		["LEFT"] = "左",
		["BOTTOMLEFT"] = "下左",
		["TOP"] = "上",
		["CENTER"] = "中",
		["BOTTOM"] = "下",
		["TOPRIGHT"] = "上右",
		["RIGHT"] = "右",
		["BOTTOMRIGHT"] = "下右",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "FuBarPlugin 配置",
		["Configure the FuBar Plugin"] = "配置 FuBar 插件",
		["Button lock"] = "锁定按钮",
		["Bar lock"] = "锁定动作条",
		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55f双击|r 打开图形配置窗口.\n|cffeda55fCtrl-单击|r 显示/隐藏按钮锁定状态. |cffeda55fShift-单击|r 显示/隐藏动作条锁定状态.",
		["Waterfall-1.0 is required to access the GUI."] = "要进入这个GUI界面你需要安装WaterFall 1.0.",

		["Self Casting"] = "自我施法",
		["Configure Self Casting options"] = "自我施法设定选项",
		["Modifier SelfCast"] = "修改自我施法",
		["SelfCast using the Interface SelfCast Modifier"] = "修改自我施法介面里使用的法术",
		["RightClick SelfCast"] = "右键自我施法",
		["SelfCast using Right click"] = "使用右键自我施法",

		-- Bar Names
		["AutoBarClassBarBasic"] = "基本",
		["AutoBarClassBarDruid"] = "德鲁伊",
		["AutoBarClassBarHunter"] = "猎人",
		["AutoBarClassBarMage"] = "法师",
		["AutoBarClassBarPaladin"] = "圣骑士",
		["AutoBarClassBarPriest"] = "牧师",
		["AutoBarClassBarRogue"] = "潜行者",
		["AutoBarClassBarShaman"] = "萨满祭司",
		["AutoBarClassBarWarlock"] = "术士",
		["AutoBarClassBarWarrior"] = "战士",

		-- Button Names
		["Buttons"] = "按钮",
		["AutoBarButtonHeader"] = "AutoBar 按钮名称",
		["AutoBarCooldownHeader"] = "药水和石头冷却",

		["AutoBarButtonAura"] = "光环 / 守护",
		["AutoBarButtonBandages"] = "绷带",
		["AutoBarButtonBattleStandards"] = "战斗姿势",
		["AutoBarButtonBuff"] = "增益",
		["AutoBarButtonBuffWeapon1"] = "增益: 主手武器",
		["AutoBarButtonBuffWeapon2"] = "增益: 副手武器",
		["AutoBarButtonClassBuff"] = "增益法术",
		["AutoBarButtonClassPet"] = "战斗宠物",
		["AutoBarButtonConjure"] = "法术: 制造",
		["AutoBarButtonCooldownPotionHealth"] = "药水冷却：生命",
		["AutoBarButtonCooldownPotionMana"] = "药水冷却：法力",
		["AutoBarButtonCooldownPotionRejuvenation"] = "药水冷却：活力",
		["AutoBarButtonCooldownStoneHealth"] = "石头冷却：生命",
		["AutoBarButtonCooldownStoneMana"] = "石头冷却：法力",
		["AutoBarButtonCooldownStoneRejuvenation"] = "石头冷却：活力",
		["AutoBarButtonCrafting"] = "专业技能",
		["AutoBarButtonElixirBattle"] = "作战药剂",
		["AutoBarButtonElixirGuardian"] = "防护药剂",
		["AutoBarButtonElixirBoth"] = "作战暨防护药剂",
		["AutoBarButtonER"] = "紧急反应",
		["AutoBarButtonExplosive"] = "工程学炸弹",
		["AutoBarButtonFishing"] = "钓鱼装备",
		["AutoBarButtonFood"] = "食物",
		["AutoBarButtonFoodBuff"] = "增益: 食物",
		["AutoBarButtonFoodCombo"] = "食物: 战斗",
		["AutoBarButtonFoodPet"] = "宠物食物",
		["AutoBarButtonFreeAction"] = "自由行动",
		["AutoBarButtonHeal"] = "生命治疗",
		["AutoBarButtonSpell1"] = "法术 1",
		["AutoBarButtonSpell2"] = "法术 2",
		["AutoBarButtonSpell3"] = "法术 3",
		["AutoBarButtonSpell4"] = "法术 4",
		["AutoBarButtonHearth"] = "炉石",
		["AutoBarButtonPickLock"] = "开锁",
		["AutoBarButtonMount"] = "坐骑",
		["AutoBarButtonPets"] = "宠物",
		["AutoBarButtonQuest"] = "任务物品",
		["AutoBarButtonRecovery"] = "法力恢复",
		["AutoBarButtonSpeed"] = "速度",
		["AutoBarButtonStance"] = "姿态",
		["AutoBarButtonStealth"] = "潜行",
		["AutoBarButtonSting"] = "钉刺",
		["AutoBarButtonTotemEarth"] = "大地图腾",
		["AutoBarButtonTotemAir"] = "风之图腾",
		["AutoBarButtonTotemFire"] = "火焰图腾",
		["AutoBarButtonTotemWater"] = "水之图腾",
		["AutoBarButtonTrack"] = "追踪技能",
		["AutoBarButtonTrap"] = "陷阱",
		["AutoBarButtonTrinket1"] = "饰品1",
		["AutoBarButtonTrinket2"] = "饰品2",
		["AutoBarButtonWater"] = "水",
		["AutoBarButtonWaterBuff"] = "增益: 水",

		["AutoBarButtonBear"] = "熊",
		["AutoBarButtonBoomkinTree"] = "生命之树 / 枭兽",
		["AutoBarButtonCat"] = "猎豹",
		["AutoBarButtonTravel"] = "旅行",
		["AutoBarButtonFlight"] = "飞行",
		["AutoBarButtonNormal"] = "一般",


		-- AutoBarClassButton.lua
		["Num Pad "] = "数字键盘 ",
		["Mouse Button "] = "滑鼠按键 ",
		["Middle Mouse"] = "滑鼠中间键",
		["Backspace"] = "Backspace",
		["Spacebar"] = "Spacebar",
		["Delete"] = "Delete",
		["Home"] = "Home",
		["End"] = "End",
		["Insert"] = "Insert",
		["Page Up"] = "Page Up",
		["Page Down"] = "Page Down",
		["Down Arrow"] = "下",
		["Up Arrow"] = "上",
		["Left Arrow"] = "左",
		["Right Arrow"] = "右",
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["NP"] = "NP",
		["M"] = "M",
		["MM"] = "MM",
		["Bs"] = "Bs",
		["Sp"] = "Sp",
		["De"] = "De",
		["Ho"] = "Ho",
		["En"] = "En",
		["Ins"] = "Ins",
		["Pu"] = "Pu",
		["Pd"] = "Pd",
		["D"] = "D",
		["U"] = "U",
		["L"] = "L",
		["R"] = "R",

		--  AutoBarConfig.lua
		["EMPTY"] = "空";
		["Default"] = "默认",
		["Zoomed"] = "缩放",
		["Dreamlayout"] = "梦幻样式",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "关闭右键自动施法";
		["AUTOBAR_CONFIG_REMOVECAT"] = "移除当前种类";
		["Rows"] = "行";
		["Columns"] = "列";
		["AUTOBAR_CONFIG_GAPPING"] = "图标间隔";
		["AUTOBAR_CONFIG_ALPHA"] = "图标透明度";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "不锁定按钮长宽比";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "显示物品种类图示";
		["Show Tooltips"] = "显示提示讯息";
		["Show Tooltips for %s"] = "显示 %s 的提示讯息";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "按 Shift 弹出按钮";
		["Rearrange Order on Use"] = "使用后重新排列顺序";
		["Rearrange Order on Use for %s"] = "使用 %s 后重新排列顺序";
		["Right Click Targets Pet"] = "右键以宠物为目标";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "无";
		["AUTOBAR_CONFIG_BT3BAR"] = "Bartender3动作条";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "主菜单条";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "对话框架";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "对话框架菜单";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "动作条";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "菜单按钮";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(未发现：物品 ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " 栏位 (左键编辑)";
		["AUTOBAR_CONFIG_CHARACTER"] = "角色";
		["AUTOBAR_CONFIG_SHARED"] = "共用";
		["AUTOBAR_CONFIG_CLASS"] = "职业";
		["AUTOBAR_CONFIG_BASIC"] = "基本";
		["AUTOBAR_CONFIG_USECHARACTER"] = "使用角色";
		["AUTOBAR_CONFIG_USESHARED"] = "使用共用";
		["AUTOBAR_CONFIG_USECLASS"] = "使用职业";
		["AUTOBAR_CONFIG_USEBASIC"] = "使用基本";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "隐藏设定提示讯息";
		["AUTOBAR_CONFIG_OSKIN"] = "使用 oSkin";
		["Log Performance"] = "记录性能";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "设定为角色专用";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "设定为共享";
		["AUTOBAR_CONFIG_SHARED1"] = "共享 1";
		["AUTOBAR_CONFIG_SHARED2"] = "共享 2";
		["AUTOBAR_CONFIG_SHARED3"] = "共享 3";
		["AUTOBAR_CONFIG_SHARED4"] = "共享 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "编辑角色的栏位";
		["AUTOBAR_CONFIG_EDITSHARED"] = "编辑共享的栏位";
		["AUTOBAR_CONFIG_EDITCLASS"] = "编辑职业的栏位";
		["AUTOBAR_CONFIG_EDITBASIC"] = "编辑基本的栏位";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "工程焰火",
		["Tradeskill.Tool.Fishing.Lure"] = "鱼饵",
		["Tradeskill.Tool.Fishing.Gear"] = "钓鱼装备",
		["Tradeskill.Tool.Fishing.Tool"] = "鱼竿",

		["Consumable.Food.Bonus"] = "食物：各类属性提升";
		["Consumable.Food.Buff.Strength"] = "食物：提升力量";
		["Consumable.Food.Buff.Agility"] = "食物：提升敏捷";
		["Consumable.Food.Buff.Attack Power"] = "食物：提升攻击强度";
		["Consumable.Food.Buff.Healing"] = "食物：提升治疗效果";
		["Consumable.Food.Buff.Spell Damage"] = "食物：提升法伤";
		["Consumable.Food.Buff.Stamina"] = "食物：提升耐力";
		["Consumable.Food.Buff.Intellect"] = "食物：提升智力";
		["Consumable.Food.Buff.Spirit"] = "食物：提升精神";
		["Consumable.Food.Buff.Mana Regen"] = "食物：提升法力恢复";
		["Consumable.Food.Buff.HP Regen"] = "食物：提升生命恢复";
		["Consumable.Food.Buff.Other"] = "食物：其他";

		["Consumable.Buff.Health"] = "提升生命力";
		["Consumable.Buff.Armor"] = "提升护甲";
		["Consumable.Buff.Regen Health"] = "提升生命回覆";
		["Consumable.Buff.Agility"] = "提升敏捷";
		["Consumable.Buff.Intellect"] = "提升智力";
		["Consumable.Buff.Protection"] = "提升防护力";
		["Consumable.Buff.Spirit"] = "提升精神";
		["Consumable.Buff.Stamina"] = "提升耐力";
		["Consumable.Buff.Strength"] = "提升力量";
		["Consumable.Buff.Attack Power"] = "提升攻击强度";
		["Consumable.Buff.Attack Speed"] = "提升攻击速度";
		["Consumable.Buff.Dodge"] = "提升闪躲机率";
		["Consumable.Buff.Resistance"] = "提升抗性";

		["Consumable.Buff Group.General.Self"] = "自身增益";
		["Consumable.Buff Group.General.Target"] = "目标增益";
		["Consumable.Buff Group.Caster.Self"] = "使用者增益";
		["Consumable.Buff Group.Caster.Target"] = "使用者目标增益";
		["Consumable.Buff Group.Melee.Self"] = "近战增益";
		["Consumable.Buff Group.Melee.Target"] = "近战目标增益";
		["Consumable.Buff.Other.Self"] = "其他人增益";
		["Consumable.Buff.Other.Target"] = "其他人目标增益";
		["Consumable.Buff.Chest"] = "胸甲增益";
		["Consumable.Buff.Shield"] = "盾牌增益";
		["Consumable.Weapon Buff"] = "武器增益";

		["Misc.Usable.Permanent"] = "可用物品";
		["Misc.Usable.Quest"] = "任务物品";	-- "Usable Quest Items"
		["Misc.Usable.Replenished"] = "补充物品";

		["Consumable.Cooldown.Potion.Health.Basic"] = "治疗药水";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "治疗药水：刀锋山";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "治疗药水：盘牙水库";
		["Consumable.Cooldown.Potion.Health.PvP"] = "奥特兰克治疗药水";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "治疗药水：风暴要塞";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "法力药水";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "法力药水：刀锋山";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "法力药水：盘牙水库";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "奥特兰克法力药水";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "法力药水：风暴要塞";

		["Consumable.Weapon Buff.Poison.Crippling"] = "致残毒药";
		["Consumable.Weapon Buff.Poison.Deadly"] = "致命毒药";
		["Consumable.Weapon Buff.Poison.Instant"] = "速效毒药";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "麻痹毒药";
		["Consumable.Weapon Buff.Poison.Wound"] = "致伤毒药";
		["Consumable.Weapon Buff.Oil.Mana"] = "魔油：提高法力恢复";
		["Consumable.Weapon Buff.Oil.Wizard"] = "魔油：增加伤害/治疗";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "磨刀石";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "平衡石";

		["Consumable.Bandage.Basic"] = "绷带";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "奥特兰克绷带";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "战歌绷带";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "阿拉希绷带";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "食物：无附加效果";
		["Consumable.Food.Percent.Basic"] = "食物：% 恢复生命力";
		["Consumable.Food.Percent.Bonus"] = "食物：% 恢复生命力 (喂食效果)";
		["Consumable.Food.Combo Percent"] = "食物：% 恢复生命力及法力";
		["Consumable.Food.Combo Health"] = "食物：有喝水效果";
		["Consumable.Food.Edible.Bread.Conjured"] = "食物：法师制造物";
		["Consumable.Food.Conjure"] = "造食术";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "食物：阿拉希盆地";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "食物：战歌峡谷";

		["Consumable.Food.Pet.Bread"] = "食物：宠物面包";
		["Consumable.Food.Pet.Cheese"] = "食物：宠物乳酪";
		["Consumable.Food.Pet.Fish"] = "食物：宠物鱼类";
		["Consumable.Food.Pet.Fruit"] = "食物：宠物水果";
		["Consumable.Food.Pet.Fungus"] = "食物：宠物菌类";
		["Consumable.Food.Pet.Meat"] = "食物：宠物肉类";

		["Consumable.Buff Pet"] = "增益：宠物";

		["Custom"] = "自定义";
		["Misc.Minipet.Normal"] = "宠物";
		["Misc.Minipet.Snowball"] = "节庆宠物";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "安戈洛：恢复水晶";

		["Consumable.Anti-Venom"] = "抗毒药剂";

		["Consumable.Cooldown.Stone.Health.Warlock"] = "治疗石";
		["Spell.Warlock.Create Firestone"] = "制造火焰石";
		["Spell.Warlock.Create Healthstone"] = "制造治疗石";
		["Spell.Warlock.Create Soulstone"] = "制造灵魂石";
		["Spell.Warlock.Create Spellstone"] = "制造法术石";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "法力石";
		["Consumable.Mage.Conjure Mana Stone"] = "制造法力石";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "昏睡药水";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "恢复药水";
		["Consumable.Cooldown.Stone.Health.Statue"] = "石像";
		["Consumable.Leatherworking.Drums"] = "战鼓";
		["Consumable.Tailor.Net"] = "网";

		["Misc.Battle Standard.Battleground"] = "战场军旗";
		["Misc.Battle Standard.Alterac Valley"] = "奥特兰克山谷军旗";
		["Consumable.Cooldown.Stone.Health.Other"] = "治疗物品：其他";
		["Consumable.Cooldown.Stone.Mana.Other"] = "恶魔和黑暗符文";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "奥术防护药水";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "火焰防护药水";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "冰霜防护药水";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "自然防护药水";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "暗影防护药水";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "法术反弹";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "神圣防护药水";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "有限无敌药水";
		["Consumable.Buff.Free Action"] = "自由行动药水";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "光环 / 守护";
		["Spell.Buff.Weapon"] = "法术增益：武器";
		["Spell.Class.Buff"] = "增益法术";
		["Spell.Class.Pet"] = "战斗宠物";
		["Spell.Crafting"] = "专业技能";
		["Spell.Fishing"] = "钓鱼";
		["Spell.Portals"] = "传送门";
		["Spell.Sting"] = "钉刺";
		["Spell.Stance"] = "姿态";
		["Spell.Totem.Earth"] = "大地图腾";
		["Spell.Totem.Air"] = "空气图腾";
		["Spell.Totem.Fire"] = "火焰图腾";
		["Spell.Totem.Water"] = "水之图腾";
		["Spell.Track"] = "追踪技能";
		["Spell.Trap"] = "陷阱";
		["Misc.Hearth"] = "炉石";
		["Misc.Booze"] = "酒类";
		["Consumable.Water.Basic"] = "水";
		["Consumable.Water.Percentage"] = "水：% 恢复法力";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "法师造水";
		["Consumable.Water.Conjure"] = "造水术";
		["Consumable.Water.Buff.Spirit"] = "水：提升精神";
		["Consumable.Water.Buff"] = "水：提升精神";
		["Consumable.Buff.Rage"] = "怒气药水";
		["Consumable.Buff.Energy"] = "能量药水";
		["Consumable.Buff.Speed"] = "迅捷药剂";
		["Consumable.Buff Type.Battle"] = "增益: 作战药剂";
		["Consumable.Buff Type.Guardian"] = "增益: 防护药剂";
		["Consumable.Buff Type.Both"] = "增益: 同时属于作战药剂与防护药剂";
		["AUTOBAR_CLASS_SOULSHARDS"] = "灵魂碎片";
		["Reagent.Ammo.Arrow"] = "箭";
		["Reagent.Ammo.Bullet"] = "子弹";
		["Reagent.Ammo.Thrown"] = "投掷武器";
		["Misc.Explosives"] = "工程学爆炸物";-- Check
		["Misc.Mount.Normal"] = "坐骑";
		["Misc.Mount.Summoned"] = "坐骑：召唤类";
		["Misc.Mount.Ahn'Qiraj"] = "坐骑：其拉甲虫";
		["Misc.Mount.Flying"] = "坐骑：飞行类";

		["Revert"] = "复原";
		["Done"] = "完成";
	}
end);


if (GetLocale()=="zhCN") then

--AUTOBAR_CHAT_MESSAGE1 = "保存的配置是老版本的, 已被清除.  不支持配置的升级.";
--AUTOBAR_CHAT_MESSAGE2 = "更新合类物品按钮 #%d 物品 #%d, 使用物品ID替换物品名称.";
--AUTOBAR_CHAT_MESSAGE3 = "更新单类物品按钮 #%d, 使用物品ID替换物品名称.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_VIEWTEXT = "要编辑按钮请选择栏位分页下方的栏位进行编辑。";
--AUTOBAR_CONFIG_SLOTVIEWTEXT = "检视综合栏位 (无法编辑)";
--AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Shift+点击进入详细分类)";
--AUTOBAR_CONFIG_DRAGHANDLE = "鼠标左键拖曳移动 AutoBar\n左键锁定 / 解锁\n右键显示功能选项";
--AUTOBAR_CONFIG_EMPTYSLOT = "空栏位";
--AUTOBAR_CONFIG_CLEARSLOT = "清除栏位";
--AUTOBAR_CONFIG_SETSHARED = "共享设定：";
--AUTOBAR_CONFIG_SETSHAREDTIP = "选择使用共享文件，将会把共享的设定值套用到所有的角色。";
--
--AUTOBAR_CONFIG_TAB_SLOTS = "栏位";
--AUTOBAR_CONFIG_TAB_BAR = "动作条";
--AUTOBAR_CONFIG_TAB_POPUP = "弹出";
--AUTOBAR_CONFIG_TAB_PROFILE = "设定";
--AUTOBAR_CONFIG_TAB_KEYS = "Keys";
--
--AUTOBAR_TOOLTIP1 = " (数量：";
--AUTOBAR_TOOLTIP2 = " [自定义物品]";
--AUTOBAR_TOOLTIP6 = " [使用条件限制]";
--AUTOBAR_TOOLTIP7 = " [使用后需冷却]";
AUTOBAR_TOOLTIP8 = "\n(左键用于主手武器\n右键用于副手武器)";
--
--AUTOBAR_CONFIG_USECHARACTERTIP = "角色栏位的物品只适用于这个角色。";
--AUTOBAR_CONFIG_USESHAREDTIP = "共用栏位的物品适用于其他角色使用相同的物品。\n共用项目可由专案分页中选择。";
--AUTOBAR_CONFIG_USECLASSTIP = "职业栏位的物品适用于所有相同职业的角色。";
--AUTOBAR_CONFIG_USEBASICTIP = "基本栏位的物品适用于所有角色可用的基本物品。";
--AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "改变可见的栏位只作用于这个角色。";
--AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "改变可见的栏位可作用于所有角色使用相同的共用设定。";
--AUTOBAR_CONFIG_TIPOVERRIDE = "这一层的物品优先顺序优于下一层的栏位。\n";
--AUTOBAR_CONFIG_TIPOVERRIDDEN = "上一层的物品优先顺序优于这一层的栏位。\n";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "变动只作用于这个角色。";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "变动作用于所有角色。";
--AUTOBAR_CONFIG_SETUPSINGLE = "单一设定";
--AUTOBAR_CONFIG_SETUPSHARED = "共用设定";
--AUTOBAR_CONFIG_SETUPSTANDARD = "标准设定";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "清空栏位";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "左键将设定单一角色为职业的 AutoBar。";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "左键为共用设定\n开启角色专用以及共用栏位。";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "开启编辑并使用所有栏位。";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "清除所有角色和共用的按钮。";
--AUTOBAR_CONFIG_RESETSINGLETIP = "左键将重置为单一角色设定的预设值。";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "左键将重置为角色共用设定的预设值。\n职业专用按钮会复制到角色栏位。\n预设按钮将复制到共用的栏位。";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "左键将重置为标准预设值。\n职业专用按钮会在职业栏位中。\n预设按钮在基本栏位中。\n共用和角色栏位将会清除。";
--
----  AutoBarConfig.lua
--AUTOBAR_TOOLTIP9 = "合类物品按钮";
--AUTOBAR_TOOLTIP10 = " (按物品ID定制)";
--AUTOBAR_TOOLTIP11 = "\n(物品ID未经过验证)";
--AUTOBAR_TOOLTIP12 = " (按物品名称定制)";
--AUTOBAR_TOOLTIP13 = "单类物品按钮\n\n";
--AUTOBAR_TOOLTIP15 = "\n武器目标\n(左键用于主手武器\n右键用于副手武器.)";
AUTOBAR_TOOLTIP17 = "\n仅用于非战斗状态.";
AUTOBAR_TOOLTIP18 = "\n仅用于战斗状态.";
--AUTOBAR_TOOLTIP20 = "\n使用条件限制：";
--AUTOBAR_TOOLTIP21 = "所需恢复生命";
--AUTOBAR_TOOLTIP22 = "所需恢复法力";
--AUTOBAR_TOOLTIP23 = "单类物品按钮\n\n";

end