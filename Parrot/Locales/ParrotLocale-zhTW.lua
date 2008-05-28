-- $Rev: 75331 $

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot")
L:AddTranslations("zhTW", function() return {
		["Parrot"] = "Parrot",
		["Floating Combat Text of awesomeness. Caw. It'll eat your crackers."] = "絕妙的戰斗記錄指示器。",
		["Inherit"] = "繼承",
		["Parrot Configuration"] = "Parrot 配置",
		["Waterfall-1.0 is required to access the GUI."] = "需要 Waterfall-1.0 庫才能打開圖形界面。",
		["General"] = "通用",
		["General settings"] = "通用設置",
		["Game damage"] = "預設傷害",
		["Whether to show damage over the enemy's heads."] = "是否在敵人頭上顯示傷害值。",
		["Game healing"] = "預設治療",
		["Whether to show healing over the enemy's heads."] = "是否在敵人頭上顯示治療量。",
		["|cffffff00Left-Click|r to change settings with a nice GUI configuration."] = "|cffffff00左鍵點擊|r以 GUI 配置方式改變設置。",
		["|cffffff00Right-Click|r to change settings with a drop-down menu."] = "|cffffff00右鍵點擊|r以下拉選單方式改變設置。",
		["Show guardian events"] = "顯示守衛事件",
		["Whether events involving your guardian(s) (totems, ...) should be displayed"] =  "顯示所有與守衛（如：圖騰，…）相關的事件",
}end)

local L_CombatEvents = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents")
L_CombatEvents:AddTranslations("zhTW", function() return {
		["[Text] (crit)"] = "[Text] （爆擊）",
		["[Text] (crushing)"] = "[Text] （碾壓）",
		["[Text] (glancing)"] = "[Text] （偏斜）",
		[" ([Amount] absorbed)"] = " （吸收 [Amount]）",
		[" ([Amount] blocked)"] = " （格擋 [Amount]）",
		[" ([Amount] resisted)"] = " （抵抗 [Amount]）",
		[" ([Amount] vulnerable)"] = " （易傷 [Amount]）",
		[" ([Amount] overheal)"] = " （過量治療 [Amount]）",
		["Events"] = "事件",
		["Change event settings"] = "改變事件設置",
		["Incoming"] = "承受",
		["Incoming events are events which a mob or another player does to you."] = "承受事件是那些怪物或玩家對你造成的事件。",
		["Outgoing"] = "輸出",
		["Outgoing events are events which you do to a mob or another player."] = "輸出事件是那些你對怪物或玩家造成的事件。",
		["Notification"] = "提示",
		["Notification events are available to notify you of certain actions."] = "提示事件用來提醒你某個特定動作的觸發。",
		["Event modifiers"] = "事件修飾",
		["Options for event modifiers."] = "事件修飾的選項。",
		["Color"] = "顏色",
		["Whether to color event modifiers or not."] = "是否為事件修飾上色。",
		["Damage types"] = "傷害類型",
		["Options for damage types."] = "傷害類型的選項。",
		["Whether to color damage types or not."] = "是否為傷害類型上色。",
		["Sticky crits"] = "爆擊粘附",
		["Enable to show crits in the sticky style."] = "允許將爆擊用粘附的風格顯示。",
		["Throttle events"] = "事件節流",
		["Whether to merge mass events into single instances instead of excessive spam."] = "是否將大量同類事件整合為一個單一事件而避免訊息氾濫。",
		["Filters"] = "過濾",
		["Filters to be checked for a minimum amount of damage/healing/etc before showing."] = "過濾顯示小於特定值的傷害/治療/其他訊息。",
		["Shorten spell names"] = "縮寫法術名稱",
		["How or whether to shorten spell names."] = "是否或如何縮寫法術名稱。",
		["Style"] = "風格",
		["How or whether to shorten spell names."] = "是否或如何縮寫法術名稱。",
		["None"] = "無",
		["Abbreviate"] = "縮寫",
		["Truncate"] = "截短",
		["Do not shorten spell names."] = "不對法術名稱進行縮寫。",
		["Gift of the Wild => GotW."] = "真言術: 韌 => 韌。",
		["Gift of the Wild => Gift of t..."] = "真言術: 韌 => 真言術...。",
		["Length"] = "長度",
		["The length at which to shorten spell names."] = "需要進行法術名稱縮寫的長度。",
		["Critical hits/heals"] = "爆擊傷害/治療",
		["Crushing blows"] = "碾壓",
		["Glancing hits"] = "偏斜",
		["Partial absorbs"] = "部分吸收",
		["Partial blocks"] = "部分格擋",
		["Partial resists"] = "部分抵抗",
		["Vulnerability bonuses"] = "易傷加成",
		["Overheals"] = "過量治療",
		["<Text>"] = "<Text>",
		["Enabled"] = "啟用",
		["Whether to enable showing this event modifier."] = "是否啟用事件修飾顯示。",
		["What color this event modifier takes on."] = "事件修飾採用何種顏色。",
		["Text"] = "文字",
		["What text this event modifier shows."] = "事件修飾顯示什麼文字。",
		["Physical"] = "物理",
		["Holy"] = "神聖",
		["Fire"] = "火焰",
		["Nature"] = "自然",
		["Frost"] = "冰霜",
		["Shadow"] = "暗影",
		["Arcane"] = "秘法",
		["What color this damage type takes on."] = "此傷害類型採用何種顏色。",
		["Inherit"] = "繼承",
		["Thin"] = "細",
		["Thick"] = "粗",
		["<Tag>"] = "<Tag>",
		["Uncategorized"] = "未分類",
		["Tag"] = "標識",
		["Tag to show for the current event."] = "標識顯示目前事件。",
		["Color of the text for the current event."] = "目前事件的文字顏色。",
		["Sound"] = "音效",
		["What sound to play when the current event occurs."] = "目前事件發生時播放哪個音效。",
		["Sticky"] = "粘附",
		["Whether the current event should be classified as \"Sticky\""] = "是否將目前事件以\"粘附\"方式顯示",
		["Custom font"] = "自訂字型",
		["Font face"] = "字型",
		["Inherit font size"] = "繼承字型大小",
		["Font size"] = "字型大小",
		["Font outline"] = "字型外框",
		["Enable the current event."] = "啟用目前事件。",
		["Scroll area"] = "滾動區域",
		["Which scroll area to use."] = "啟用哪個滾動區域。",
		["What timespan to merge events within.\nNote: a time of 0s means no throttling will occur."] = "合併事件的時間間隔（單位秒）\n注意：0表示不進行節流顯示。",
		["What amount to filter out. Any amount below this will be filtered.\nNote: a value of 0 will mean no filtering takes place."] = "需要過濾的值，低於該值將被過濾\n注意：若過濾值為0則表示不進行過濾。",
		["The amount of damage absorbed."] = "被吸收的傷害量。",
		["The amount of damage blocked."] = "被格擋的傷害量。",
		["The amount of damage resisted."] = "被抵抗的傷害量。",
		["The amount of vulnerability bonus."] = "易傷加成量。",
		["The amount of overhealing."] = "過量治療量。",
		["The normal text."] = "一般文字。",
}end)

local L_Display = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Display")
L_Display:AddTranslations("zhTW", function() return {
		["None"] = "無",
		["Thin"] = "細",
		["Thick"] = "粗",
		["Text transparency"] = "文字透明度",
		["How opaque/transparent the text should be."] = "文字顯示的透明度。",
		["Icon transparency"] = "圖示透明度",
		["How opaque/transparent icons should be."] = "圖示顯示的透明度。",
		["Enable icons"] = "啟用圖示",
		["Set whether icons should be enabled or disabled altogether."] = "設置是否圖示要被一起顯示。",
		["Master font settings"] = "主字型設置",
		["Normal font"] = "正常字型",
		["Normal font face."] = "正常字型。",
		["Normal font size"] = "正常字型大小",
		["Normal outline"] = "正常外框",
		["Sticky font"] = "粘附字型",
		["Sticky font face."] = "粘附字型。",
		["Sticky font size"] = "粘附字型大小",
		["Sticky outline"] = "粘附外框",
	
}end)

local L_ScrollAreas = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_ScrollAreas")
L_ScrollAreas:AddTranslations("zhTW", function() return {
		["Incoming"] = "承受",
		["Outgoing"] = "輸出",
		["Notification"] = "提示",
		["New scroll area"] = "新滾動區域",
		["Inherit"] = "繼承",
		["None"] = "無",
		["Thin"] = "細",
		["Thick"] = "粗",
		["Left"] = "左",
		["Right"] = "右",
		["Disable"] = "停用",
		["Options for this scroll area."] = "本滾動區域的選項。",
		["Name"] = "名稱",
		["Name of the scroll area."] = "滾動區域的名稱。",
		["<Name>"] = "<名稱>",
		["Remove"] = "移除",
		["Remove this scroll area."] = "移除本滾動區域。",
		["Icon side"] = "圖示位置",
		["Set the icon side for this scroll area or whether to disable icons entirely."] = "設置本滾動區域的圖示位置或是否完全停用圖示。",
		["Test"] = "測試",
		["Send a test message through this scroll area."] = "發送一條測試訊息到本滾動區域。",
		["Normal"] = "正常",
		["Send a normal test message."] = "發送一條正常測試訊息。",
		["Sticky"] = "粘附",
		["Send a sticky test message."] = "發送一條粘附測試訊息。",
		["Direction"] = "方向",
		["Which direction the animations should follow."] = "滾動動畫的方向。",
		["Direction for normal texts."] = "正常文字的方向。",
		["Direction for sticky texts."] = "粘附文字的方向。",
		["Animation style"] = "動畫效果",
		["Which animation style to use."] = "採用何種動畫效果。",
		["Animation style for normal texts."] = "正常文字的動畫效果。",
		["Animation style for sticky texts."] = "粘附文字的動畫效果。",
		["Position: horizontal"] = "水平位置",
		["The position of the box across the screen"] = "在螢幕上的水平位置",
		["Position: vertical"] = "垂直位置",
		["The position of the box up-and-down the screen"] = "在螢幕上的垂直位置",
		["Size"] = "大小",
		["How large of an area to scroll."] = "滾動區域的大小。",
		["Scrolling speed"] = "滾動速度",
		["How fast the text scrolls by."] = "設置以多快的速度滾動。",
		["Seconds for the text to complete the whole cycle, i.e. larger numbers means slower."] = "完成整個滾動循環的秒數，數字越大滾動越慢。",
		["Custom font"] = "自訂字型",
		["Normal font face"] = "正常字型",
		["Normal inherit font size"]  = "繼承正常字型大小",
		["Normal font size"] = "正常字型大小",
		["Normal font outline"] = "正常字型外框",
		["Sticky font face"] = "粘附字型",
		["Sticky inherit font size"] = "繼承粘附字型大小",
		["Sticky font size"] = "粘附字型大小",
		["Sticky font outline"] = "粘附字型外框",
		["Click and drag to the position you want."]  = "拖動到你希望的位置。",
		["Scroll area: %s"] = "滾動區域：%s",
		["Position: %d, %d"] = "位置：%d，%d",
		["Scroll areas"] = "滾動區域",
		["Options regarding scroll areas."] = "滾動區域的選項。",
		["Configuration mode"] = "配置模式",
		["Enter configuration mode, allowing you to move around the scroll areas and see them in action."] = "進入配置模式，讓你可以移動滾動區域並觀看效果。",
		["New scroll area"] = "新增滾動區域",
		["Add a new scroll area."] = "增加一個新的滾動區域。",
		["Center of screen"] = "螢幕中央",
		["Edge of screen"] = "螢幕邊緣",
		["Create"] = "建立",
		["Are you sure?"] = "是否確定？",
		["Send"] = "發送",
}end)

local L_Suppressions = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Suppressions")
L_Suppressions:AddTranslations("zhTW", function() return {
		["New suppression"] = "新增覆蓋事件",
		["Edit"] = "編輯",
		["Edit search string"] = "編輯搜索字串",
		["<Any text> or <Lua search expression>"] = "<任意文字>或<Lua 搜索表達式>",
		["Lua search expression"] = "Lua 搜索表達式",
		["Whether the search string is a lua search expression or not."] = "是否搜索字串是一個 Lua 搜索表達式。",
		["Remove"] = "移除",
		["Remove suppression"] = "移除覆蓋事件",
		["Suppressions"] = "覆蓋事件",
		["List of strings that will be squelched if found."] = "列出的字串若找到則被覆蓋。",
		["Add a new suppression."] = "增加一個新的覆蓋事件。",
		["Create"] = "建立",
		["Are you sure?"] = "是否確定？",
}end)

local L_Triggers = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Triggers")
L_Triggers:AddTranslations("zhTW", function() return {
		["%s!"] = "%s！",
		["Low Health!"] = "低血量！",
		["Low Mana!"] = "低法力！",
		["Low Pet Health!"] = "寵物低血量！",
		["Free %s!"] = "額外%s！",
		["Trigger cooldown"] = "觸發冷卻",
		["Check every XX seconds"] = "每過 XX 秒檢查一次",
		["Triggers"] = "觸發條件",
		["New trigger"] = "新增觸發條件",
		["Create a new trigger"] = "建立一個新的觸發條件",
		["Inherit"] = "繼承",
		["None"] = "無",
		["Thin"] = "細",
		["Thick"] = "粗",
		["Druid"] = "德魯伊",
		["Rogue"] = "盜賊",
		["Shaman"] = "薩滿",
		["Paladin"] = "聖騎士",
		["Mage"] = "法師",
		["Warlock"] = "術士",
		["Priest"] = "牧師",
		["Warrior"] = "戰士",
		["Hunter"] = "獵人",
		["Output"] = "輸出",
		["The text that is shown"] = "想要顯示的文字",
		['<Text to show>'] = "<顯示文字>",
		["Icon"] = "圖示",
		["The icon that is shown"] = "想要顯示的圖示",
		['<Spell name> or <Item name> or <Path> or <SpellId>'] = "<法術名稱>或<物品名稱>或<路徑>或<法術 ID>",
		["Enabled"] = "啟用",
		["Whether the trigger is enabled or not."] = "是否啟用這個觸發條件。",
		["Remove trigger"] = "移除觸發條件",
		["Remove this trigger completely."] = "徹底移除這個觸發條件。",
		["Color"] = "顏色",
		["Color of the text for this trigger."] = "這個觸發條件的顯示文字顏色。",
		["Sticky"] = "粘附",
		["Whether to show this trigger as a sticky."] = "是否將本觸發條件粘附顯示。",
		["Classes"] = "職業",
		["Classes affected by this trigger."] = "本觸發條件所影響的職業。",
		["Scroll area"] = "滾動區域",
		["Which scroll area to output to."] = "選擇輸出的滾動區域。",
		["Sound"] = "音效",
		["What sound to play when the trigger is shown."] = "觸發條件顯示時播放何種音效。",
		["Test"] = "測試",
		["Test how the trigger will look and act."] = "測試觸發條件的效果。",
		["Custom font"] = "自訂字型",
		["Font face"] = "字型",
		["Inherit font size"] = "繼承字型大小",
		["Font size"] = "字型大小",
		["Font outline"] = "字型外框",
		["Primary conditions"] = "主條件",
		["When any of these conditions apply, the secondary conditions are checked."] = "當這些條件中的任一個滿足時，檢查次條件。",
		["New condition"] = "新增條件",
		["Add a new primary condition"] = "增加一個新的主條件",
		["Remove condition"] = "移除條件",
		["Remove a primary condition"] = "移除一個主條件",
		["Secondary conditions"] = "次條件",
		["When all of these conditions apply, the trigger will be shown."] = "當所有這些條件被滿足時，觸發條件將被顯示。",
		["Add a new secondary condition"] = "增加一個新的次條件",
		["Remove a secondary condition"] = "移除一個次條件",
		["Create"] = "建立",
		["Remove"] = "移除",
		["Are you sure?"] = "是否確定？",

}end)

local L_AnimationStyles = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_AnimationStyles")
L_AnimationStyles:AddTranslations("zhTW", function() return {
		["Straight"] = "直線型",
		["Up, left-aligned"] = "向上，左對齊",
		["Up, right-aligned"] = "向上，右對齊",
		["Up, center-aligned"] = "向上，中對齊",
		["Down, left-aligned"] = "向下，左對齊",
		["Down, right-aligned"] = "向下，右對齊",
		["Down, center-aligned"] = "向下，中對齊",
		["Parabola"] = "拋物線",
		["Up, left"] = "向上，向左",
		["Up, right"] = "向上，向右",
		["Up, alternating"] = "向上，交錯",
		["Down, left"] = "向下，向左",
		["Down, right"] = "向下，向右",
		["Down, alternating"] = "向下，交錯",
		["Semicircle"] = "半圓型",
		["Pow"] = "震動型",
		["Static"] = "靜態型",
		["Rainbow"] = "彩虹型",
		["Horizontal"] = "橫移型",
		["Left"] = "左",
		["Right"] = "右",
		["Alternating"] = "交錯",
		["Action"] = "動作型",
		["Action Sticky"] = "動態粘附",
		["Angled"] = "角度型",
		["Sprinkler"] = "灑水型",
		["Up, clockwise"] = "向上，順時針",
		["Down, clockwise"] = "向下，順時針",
		["Left, clockwise"] = "向左，順時針",
		["Right, clockwise"] = "向右，順時針",
		["Up, counter-clockwise"] = "向上，逆時針",
		["Down, counter-clockwise"] = "向下，逆時針",
		["Left, counter-clockwise"] = "向左，逆時針",
		["Right, counter-clockwise"] = "向右，逆時針",

}end)

local L_Auras = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Auras")
L_Auras:AddTranslations("zhTW", function() return {
		["Auras"] = "光環",
		["Debuff gains"] = "受到減益",
		["The name of the debuff gained."] = "受到減益的名稱。",
		["Buff gains"] = "獲得增益",
		["The name of the buff gained."] = "獲得增益的名稱。",
		["Item buff gains"] = "獲得物品增益",
		["The name of the item buff gained."] = "獲得物品增益的名稱。",
		["The rank of the item buff gained."] = "獲得物品增益的等級。",
		["Debuff fades"] = "減益消退",
		["The name of the debuff lost."] = "消退減益的名稱。",
		["Buff fades"] = "增益消退",
		["The name of the buff lost."] = "消退增益的名稱。",
		["Item buff fades"] = "物品增益消退",
		["The name of the item buff lost."] = "消退物品增益的名稱。",
		["The rank of the item buff lost."] = "消退物品增益的等級。",
		["Self buff gain"] = "獲得自身增益",
		["<Buff name>"] = "<增益名稱>",
		["Self buff fade"] = "自身增益消退",
		["Self debuff gain"] = "獲得自身減益",
		["<Debuff name>"] = "<減益名稱>",
		["Self debuff fade"] = "自身減益消退",
		["Self item buff gain"] = "獲得自身物品增益",
		["<Item buff name>"] = "<物品增益名稱>",
		["Self item buff fade"] = "自身增益消退",
		["Target buff gain"] = "目標獲得增益",
		["Target debuff gain"] = "目標增益消退",
		["Buff inactive"] = "增益未啟動",
		["Buff active"] = "增益啟動",
		["Focus buff gain"] = "焦點目標獲得增益",
		["Focus debuff gain"] = "焦點目標獲得減益",
		["Target buff fade"] = "目標增益消退",
		["Target debuff fade"] = "目標減益消退",
		["Focus buff fade"] = "焦點目標增益消退",
		["Focus debuff fade"] = "焦點目標減益消退",
		["Buff stack gains"] = "獲得增益疊加",
		["Debuff stack gains"] = "獲得減益疊加",
		["New Amount of stacks of the buff."] = "新的增益疊加層數。",
		["New Amount of stacks of the debuff."] = "新的減益疊加層數。",
		["The name of the unit that gained the buff."] = "單位獲得增益的名稱。",
		["Target buff stack gains"] = "目標獲得增益疊加",
		["Target buff gains"] = "目標獲得增益",

}end)

local L_CombatEvents_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents_Data")
L_CombatEvents_Data:AddTranslations("zhTW", function() return {
		["Incoming damage"] = "承受傷害",
		["Melee damage"] = "近戰傷害",
		["Melee"] = "近戰",
		["The name of the enemy that attacked you."] = "攻擊你的敵人名稱。",
		["The amount of damage done."] = "造成的傷害量。",
		[" (%d hit, %d crit)"] = "（%d次命中，%d次爆擊）",
		[" (%d hit, %d crits)"] = "（%d次命中，%d次爆擊）",
		[" (%d hits, %d crit)"] = "（%d次命中，%d次爆擊）",
		[" (%d hits, %d crits)"] = "（%d次命中，%d次爆擊）",
		[" (%d crits)"] = "（%d次爆擊）",
		[" (%d hits)"] = "（%d次命中）",
		["Multiple"] = "多重",
		["Melee misses"] = "近戰未命中",
		["Miss!"] = "未命中！",
		["Melee dodges"] = "近戰躲閃",
		["Dodge!"] = "躲閃！",
		["Melee parries"] = "近戰招架",
		["Parry!"] = "招架！",
		["Melee blocks"] = "近戰格擋",
		["Block!"] = "格擋！",
		["Melee absorbs"] = "近戰吸收",
		["Absorb!"] = "吸收！",
		["Melee immunes"] = "近戰免疫",
		["Immune!"] = "免疫！",
		["Melee evades"] = "近戰閃避",
		["Evade!"] = "閃避！",
		["Skills"] = "技能",
		["Skill damage"] = "技能傷害",
		["The type of damage done."] = "造成傷害的類型。",
		["The spell or ability that the enemy attacked you with."] = "敵人攻擊你所用的法術或技能。",
		["DoTs and HoTs"] = "DoT 和 HoT",
		["Skill DoTs"] = "技能 DoT",
		["Ability misses"] = "技能未命中",
		["Ability dodges"] = "技能躲閃",
		["Ability parries"] = "技能招架",
		["Ability blocks"] = "技能格擋",
		["Spell resists"] = "法術抵抗",
		["Resist!"] = "抵抗！",
		["Skill absorbs"] = "技能吸收",
		["Skill immunes"] = "技能免疫",
		["Skill reflects"] = "技能反射",
		["Reflect!"] = "反射！",
		["Skill interrupts"] = "技能打斷",
		["Interrupt!"] = "打斷！",
		["Incoming heals"] = "受到治療",
		["Heals"] = "治療",
		["The name of the ally that healed you."] = "治療你的盟友名字。",
		["The spell or ability that the ally healed you with."] = "盟友用來治療你的法術名稱。",
		["The amount of healing done."] = "受到的治療量。",
		[" (%d heal, %d crit)"] = "（%d次治療，%d次爆擊）",
		[" (%d heal, %d crits)"] = "（%d次治療，%d次爆擊）",
		[" (%d heals, %d crit)"] = "（%d次治療，%d次爆擊）",
		[" (%d heals, %d crits)"] = "（%d次治療，%d次爆擊）",
		[" (%d heals)"] = "（%d次治療）",
		["Heals over time"] = "持續治療",
		["Environmental damage"] = "環境傷害",
		["Outgoing damage"] = "輸出傷害",
		["The name of the enemy you attacked."] = "你所攻擊的敵人名稱。",
		["The spell or ability that you used."] = "你所使用的法術或技能。",
		["Skill evades"] = "技能閃避",
		["Outgoing heals"] = "輸出治療",
		["The name of the ally you healed."] = "你所治療的盟友名字。",
		["Pet melee"] = "近戰（寵物）",
		["Pet melee damage"] = "近戰傷害（寵物）",
		["Pet [Amount]"] = "[Amount]（寵物）",
		["(Pet) +[Amount]"] = "（寵物） +[Amount]",
		["Pet heals"] = "治療（寵物）",
		["The name of the enemy your pet attacked."] = "寵物攻擊的敵人名稱。",
		["Pet melee misses"] = "近戰未命中（寵物）",
		["Pet Miss!"] = "未命中！（寵物）",
		["Pet melee dodges"] = "近戰躲閃（寵物）",
		["Pet Dodge!"] = "躲閃！（寵物）",
		["Pet melee parries"] = "近戰招架（寵物）",
		["Pet Parry!"] = "招架！（寵物）",
		["Pet melee blocks"] = "近戰格擋（寵物）",
		["Pet Block!"] = "格擋！（寵物）",
		["Pet melee absorbs"] = "近戰吸收（寵物）",
		["Pet Absorb!"] = "吸收！（寵物）",
		["Pet melee immunes"] = "近戰免疫（寵物）",
		["Pet Immune!"] = "免疫！（寵物）",
		["Pet melee evades"] = "近戰閃避（寵物）",
		["Pet Evade!"] = "閃避！（寵物）",
		["Pet skills"] = "寵物技能",
		["Pet skill"] = "寵物技能",
		["Pet skill damage"] = "寵物技能傷害",
		["Pet [Amount] ([Skill])"] = "[Amount] （[Skill]）（寵物）",
		["The ability or spell your pet used."] = "寵物所使用的技能或法術。",
		["Pet ability misses"] = "技能未命中（寵物）",
		["Pet ability dodges"] = "技能躲閃（寵物）",
		["Pet ability parries"] = "技能招架（寵物）",
		["Pet ability blocks"] = "技能格擋（寵物）",
		["Pet spell resists"] = "技能抵抗（寵物）",
		["Pet Resist!"] = "抵抗！（寵物）",
		["Pet skill absorbs"] = "技能吸收（寵物）",
		["Pet skill immunes"] = "技能免疫（寵物）",
		["Pet skill reflects"] = "技能反射（寵物）",
		["Pet Reflect!"] = "反射！（寵物）",
		["Pet skill evades"] = "技能閃避（寵物）",
		["Combat status"] = "戰鬥狀態",
		["Enter combat"] = "進入戰鬥",
		["Leave combat"] = "脫離戰鬥",
		["Power gain/loss"] = "獲得/失去能量",
		["Power change"] = "能量變化",
		["Power gain"] = "獲得能量",
		["+[Amount] [Type]"] = "+[Amount] [Type]",
		["The amount of power gained."] = "獲得能量的數量。",
		["The type of power gained (Mana, Rage, Energy)."] = "獲得能量的類型（法力，怒氣，能量）。",
		["The ability or spell used to gain power."] = "為獲得能量而使用的技能或法術。",
		["The character that the power comes from."] = "為你提供能量的角色。",
		[" (%d gains)"] = "（獲得%d點）",
		["Power loss"] = "失去能量",
		["-[Amount] [Type]"] = "-[Amount] [Type]",
		["The amount of power lost."] = "失去能量的數量。",
		["The type of power lost (Mana, Rage, Energy)."] = "失去能量的類型（法力，怒氣，能量）。",
		["The ability or spell take away your power."] = "使用的技能或法術而失去能量。",
		["The character that caused the power loss."] = "令你失去能量的角色。",
		[" (%d losses)"] = "（失去%s點）",
		["Combo points"] = "連擊點",
		["Combo point gain"] = "獲得連擊點",
		["[Num] CP"] = "[Num]點CP",
		["The current number of combo points."] = "目前的連擊點數",
		["Combo points full"] = "連擊點已滿",
		["[Num] CP Finish It!"] = "[Num]點CP 終結技！",
		["Honor gains"] = "獲得榮譽",
		["The amount of honor gained."] = "獲得的榮譽點數。",
		["The name of the enemy slain."] = "被殺死的敵人名字。",
		["The rank of the enemy slain."] = "被殺死的敵人級別。",
		["Reputation"] = "聲望",
		["Reputation gains"] = "獲得聲望",
		["The amount of reputation gained."] = "獲得的聲望點數。",
		["The name of the faction."] = "勢力的名稱。",
		["Reputation losses"] = "失去聲望",
		["The amount of reputation lost."] = "失去聲望的點數。",
		["Skill gains"] = "技能提升",
		["The skill which experienced a gain."] = "獲得提升的技能。",
		["The amount of skill points currently."] = "目前的技能點數。",
		["Experience gains"] = "獲得經驗",
		["The name of the enemy slain."] = "殺死的敵人名稱。",
		["The amount of experience points gained."] = "獲得的經驗點數。",
		["Killing blows"] = "殺死",
		["Player killing blows"] = "殺死玩家",
		["Killing Blow!"] = "殺死！",
		["The spell or ability used to slay the enemy."] = "用來殺死敵人的法術或技能。",
		["NPC killing blows"] = "殺死 NPC",
		["Soul shard gains"] = "獲得靈魂碎片",
		["The name of the soul shard."] = "靈魂碎片的名稱。",
		["Extra attacks"] = "額外攻擊",
		["%s!"] = "%s！",
		["The name of the spell or ability which provided the extra attacks."] = "導致額外攻擊的法術或技能名稱。",
		["Self heals"] = "自身治療",
		["Self heals over time"] = "自身治療持續時間",
		["Pet skill DoTs"] = "寵物技能 DoTs",
		["Skill you were interrupted in casting"] = "在你施法中打斷的技能",
		["The spell you interrupted"] = "你打斷的技能",
		-- Schools
		["Physical"] = "物理",
		["Holy"] = "神圣",
		["Fire"] = "火焰",
		["Nature"] = "自然",
		["Frost"] = "冰霜",
		["Shadow"] = "暗影",
		["Arcane"] = "奧術",
}end)

local L_Cooldowns = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Cooldowns")
L_Cooldowns:AddTranslations("zhTW", function() return {
		["Cooldowns"] = "冷卻",
		["Skill cooldown finish"] = "技能冷卻完成",
		["[[Skill] ready!]"] = "[Skill] 冷卻完成！",
		["The name of the spell or ability which is ready to be used."] = "冷卻完成的法術或技能名稱。",
		["Traps"] = "陷阱",
		["Shocks"] = "震擊",
		["Divine Shield"] = "聖盾",
		["%s Tree"] = "%s系",
		["Spell ready"] = "法術可用",
		["<Spell name>"] = "<法術名稱>",
}end)

local L_Loot = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Loot")
L_Loot:AddTranslations("zhTW", function() return {
		["Loot"] = "拾取",
		["Loot items"] = "拾取物品",
		["Loot [Name] +[Amount]([Total])"] = "拾取[Name] +[Amount]（[Total]）",
		["The name of the item."] = "物品名稱。",
		["The amount of items looted."] = "物品數量。",
		["The total amount of items in inventory."] = "背包中物品的總量。",
		["Loot money"] = "拾取金錢",
		["Loot +[Amount]"] = "拾取 +[Amount]",
		["The amount of gold looted."] = "拾取金錢的數量。",

}end)

local L_TriggerConditions_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_TriggerConditions_Data")
L_TriggerConditions_Data:AddTranslations("zhTW", function() return {
	-- Parrot_TriggerConditions_Data
		["Enemy target health percent"] = "敵對目標血量百分比",
		["Friendly target health percent"] = "友方目標血量百分比",
		["Self health percent"] = "自身血量百分比",
		["Self mana percent"] = "自身法力百分比",
		["Pet health percent"] = "寵物血量百分比",
		["Incoming block"] = "承受格擋",
		["Incoming crit"] = "承受爆擊",
		["Incoming dodge"] = "承受躲閃",
		["Incoming parry"] = "承受招架",
		["Outgoing block"] = "產生格擋",
		["Outgoing crit"] = "產生爆擊",
		["Outgoing dodge"] = "產生躲閃",
		["Outgoing parry"] = "產生招架",
		["Outgoing cast"] = "進行施法",
		["<Skill name>"] = "<技能名稱>",
		["Incoming cast"] = "承受施法",
		["Minimum power amount"] = "最小能量值",
		["Warrior stance"] = "戰士姿態",
		["Not in warrior stance"] = "沒有處於戰士姿態",
		["Druid Form"] = "德魯伊形態",
		["Not in Druid Form"] = "沒有處于德魯伊形態",
}end)

local L_CombatStatus = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatStatus")
L_CombatStatus:AddTranslations("zhTW", function() return {
	-- Parrot_CombatStatus:
		["Combat status"] = "戰鬥狀態",
		["Enter combat"] = "進入戰鬥",
		["+Combat"] = "+戰鬥",
		["Leave combat"] = "離開戰鬥",
		["-Combat"] = "-戰鬥",
		["In combat"] = "戰鬥中",
		["Not in combat"] = "非戰鬥",
}end)