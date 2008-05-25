-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english

!! Make sure to keep this saved as UTF-8 format !!

]]

--[[>> still needs translating]]

-- FR 4 missing
if GetLocale() == "frFR" then

	FW.L.MANA_POTION = "^Potion(.+)mana"; -- is All types
	FW.L.HEALING_POTION = "^Potion(.+)soins"; -- is All types
	FW.L.PROTECTION_POTION = "^Potion de protection"; -- is All types
	FW.L.SOULSTONE = "^Pierre d'me"; -- is All types
	FW.L.HEALTHSTONE = "^Pierre de soins"; -- is All types
	FW.L.FEL_BLOSSOM = "^Gangrelys$";
	FW.L.NIGHTMARE_SEED = "^Graine de cauchemardelle$";

	FW.L.VENGEANCE_OF_THE_ILLIDARI = "Vengeance des Illidari";
--[[>>]]FW.L.THE_SKULL_OF_GULDAN = "The Skull of Gul'dan";
	FW.L.ZANDALARIAN_HERO_CHARM = "Charme de hros zandalarien";
	FW.L.XIRIS_GIFT = "Don de Xi'ri";
	FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "L'essence contenue de Saphiron";
	FW.L.ICON_OF_THE_SILVER_CRESCENT = "Icne du croissant d'argent"
--[[>>]]FW.L.HEX_SHRUNKEN_HEAD = "Hex Shrunken Head";

	FW.L.HEARTHSTONE = "Pierre de foyer";
	FW.L.BLESSED_MEDALLION_OF_KARABOR = "Mdaillon bni de Karabor";
	FW.L.EVERLASTING_UNDERSPORE_FROND = "Palmes de sporielles ternelles";

	--buffs	
--[[>>]]FW.L.WELL_FED = "Well Fed";
--[[>>]]FW.L.RECENTLY_BANDAGED = "Recently Bandaged";

-- DE 1 missing
elseif GetLocale() == "deDE" then

	FW.L.MANA_POTION = "anatrank$"; -- is All types
	FW.L.HEALING_POTION = "eiltrank$"; -- is All types
	FW.L.PROTECTION_POTION = "schutztrank$"; -- is All types
	FW.L.SOULSTONE = "Seelenstein$"; -- is All types
	FW.L.HEALTHSTONE = "Gesundheitsstein$"; -- is All types
	FW.L.FEL_BLOSSOM = "^Teufelsblte$";
	FW.L.NIGHTMARE_SEED = "^Alptraumsaat$";

	FW.L.VENGEANCE_OF_THE_ILLIDARI = "Vergeltung der Illidari";
	FW.L.THE_SKULL_OF_GULDAN = "Der Schdel des Gul'dan";
	FW.L.ZANDALARIAN_HERO_CHARM = "Zandalarianisches Heldenamulett";
	FW.L.XIRIS_GIFT = "Xi'ris Gabe";
	FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "Die gebundene Essenz Saphirons";
	FW.L.ICON_OF_THE_SILVER_CRESCENT = "Ikone des Silberwappens"
--[[>>]]FW.L.HEX_SHRUNKEN_HEAD = "Hex Shrunken Head";

	FW.L.HEARTHSTONE = "Ruhestein";
	FW.L.BLESSED_MEDALLION_OF_KARABOR = "Gesegnetes Medaillon von Karabor";
	FW.L.EVERLASTING_UNDERSPORE_FROND = "Unvergnglicher Tiefensporenfarn";
	
	--buffs
	FW.L.WELL_FED = "Satt";
	FW.L.RECENTLY_BANDAGED = "Krzlich bandagiert";

-- SPANISH - 3 mising  By Intxixu - SPQR - Tyrande
elseif GetLocale() == "esES" then

	FW.L.MANA_POTION = "^Pocin de man"; -- is All types
	FW.L.HEALING_POTION = "^Pocin de sanacin"; -- is All types
	FW.L.PROTECTION_POTION = "^Pocin de proteccin"; -- is All types
	FW.L.SOULSTONE = "^Piedra de alma"; -- is All types
	FW.L.HEALTHSTONE = "^Piedra de salud"; -- is All types
	FW.L.FEL_BLOSSOM = "^Flor vil$";
	FW.L.NIGHTMARE_SEED = "^Semilla de pesadilla$";

	FW.L.VENGEANCE_OF_THE_ILLIDARI = "Venganza de los Illidari";
	FW.L.THE_SKULL_OF_GULDAN = "La calavera de Gul'dan";
	FW.L.ZANDALARIAN_HERO_CHARM = "^alismn de hroe Zandalar";
	FW.L.XIRIS_GIFT = "Don de Xi'ri";
	FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "La esencia contenida de Sapphiron";
	FW.L.ICON_OF_THE_SILVER_CRESCENT = "Icono creciente de plata"
--[[>>]]FW.L.HEX_SHRUNKEN_HEAD = "Hex Shrunken Head";

	FW.L.HEARTHSTONE = "Piedra de hogar";
	FW.L.BLESSED_MEDALLION_OF_KARABOR = "Medalln bendito de Karabor";
	FW.L.EVERLASTING_UNDERSPORE_FROND = "Esqueje de sotoespora eterno";

	--buffs
--[[>>]]FW.L.WELL_FED = "Well Fed";
--[[>>]]FW.L.RECENTLY_BANDAGED = "Recently Bandaged";

-- Simple Chinese
elseif GetLocale() == "zhCN" then


	
	FW.L.MANA_POTION = "法力药水$"; -- is All types
	FW.L.HEALING_POTION = "治疗药水$"; -- is All types
	FW.L.PROTECTION_POTION = "防护药水$"; -- is All types
	FW.L.SOULSTONE = "灵魂石$"; -- is All types
	FW.L.HEALTHSTONE = "治疗石$"; -- is All types
	FW.L.FEL_BLOSSOM = "^野魔花$";
	FW.L.NIGHTMARE_SEED = "^梦魇草$";

	FW.L.VENGEANCE_OF_THE_ILLIDARI = "^伊利达雷的复仇$";
	FW.L.THE_SKULL_OF_GULDAN = "^古尔丹之颅$";
	FW.L.ZANDALARIAN_HERO_CHARM = "^赞达拉英雄护符$";
	FW.L.XIRIS_GIFT = "^克希利的礼物$";
	FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "^萨菲隆的精华$";
	FW.L.ICON_OF_THE_SILVER_CRESCENT = "^银色新月徽记$";
	FW.L.HEX_SHRUNKEN_HEAD = "^妖术之颅$";

	FW.L.HEARTHSTONE = "^炉石$";
	FW.L.BLESSED_MEDALLION_OF_KARABOR = "^卡拉波神圣勋章$";
	FW.L.EVERLASTING_UNDERSPORE_FROND = "^无尽幽暗孢子叶$";


	--buffs
	FW.L.WELL_FED = "进食充分";
	FW.L.RECENTLY_BANDAGED = "新近包扎";

-- trdition Chinese
elseif GetLocale() == "zhTW" then


	MANA_POTION = "法力藥水$"; -- is All types
	HEALING_POTION = "治療藥水$"; -- is All types
	PROTECTION_POTION = "防護藥水$"; -- is All types
	SOULSTONE = "靈魂石$"; -- is All types
	HEALTHSTONE = "治療石$"; -- is All types
	FEL_BLOSSOM = "^野魔花$";
	NIGHTMARE_SEED = "^夢魘草$";

	VENGEANCE_OF_THE_ILLIDARI = "^伊利達瑞的復仇$";
	THE_SKULL_OF_GULDAN = "^古爾丹之顱$";
	ZANDALARIAN_HERO_CHARM = "^贊達拉英雄符咒$";
	XIRIS_GIFT = "^希瑞的禮物$";
	THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "^受限制的薩菲隆精華$";
	ICON_OF_THE_SILVER_CRESCENT = "^銀色弦月塑像$"
	FW.L.HEX_SHRUNKEN_HEAD = "^妖術皺縮人頭$";

	HEARTHSTONE = "^爐石$";
	BLESSED_MEDALLION_OF_KARABOR = "^受祝福的卡拉伯爾勳章$";
	EVERLASTING_UNDERSPORE_FROND = "^永恆地孢藻葉$";

	--buffs
	FW.L.WELL_FED = "充分進食";
	FW.L.RECENTLY_BANDAGED = "新近包紮";
-- ENGLISH
else	-- standard english version
	
	FW.L.MANA_POTION = "Mana Potion$"; -- is All types
	FW.L.HEALING_POTION = "Healing Potion$"; -- is All types
	FW.L.PROTECTION_POTION = "Protection Potion$"; -- is All types
	FW.L.SOULSTONE = "Soulstone$"; -- is All types
	FW.L.HEALTHSTONE = "Healthstone$"; -- is All types
	FW.L.FEL_BLOSSOM = "^Fel Blossom$";
	FW.L.NIGHTMARE_SEED = "^Nightmare Seed$";

	FW.L.VENGEANCE_OF_THE_ILLIDARI = "Vengeance of the Illidari";
	FW.L.THE_SKULL_OF_GULDAN = "The Skull of Gul'dan";
	FW.L.ZANDALARIAN_HERO_CHARM = "Zandalarian Hero Charm";
	FW.L.XIRIS_GIFT = "Xi'ri's Gift";
	FW.L.THE_RESTRAINED_ESSENCE_OF_SAPPHIRON = "The Restrained Essence of Sapphiron";
	FW.L.ICON_OF_THE_SILVER_CRESCENT = "Icon of the Silver Crescent";
	FW.L.HEX_SHRUNKEN_HEAD = "Hex Shrunken Head";

	FW.L.HEARTHSTONE = "Hearthstone";
	FW.L.BLESSED_MEDALLION_OF_KARABOR = "Blessed Medallion of Karabor";
	FW.L.EVERLASTING_UNDERSPORE_FROND = "Everlasting Underspore Frond";

	--buffs
	FW.L.WELL_FED = "Well Fed";
	FW.L.RECENTLY_BANDAGED = "Recently Bandaged";
end

-- Simple Chinese
if GetLocale() == "zhCN" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.COOLDOWN_TIMER = "冷却计时";

FW.L.CD_HINT1 = "设置颜色时使用透明度控制文字和其他部分的显示.";
FW.L.CD_HINT2 = "使用自定义选项屏蔽冷却或者改变颜色,右键点击屏蔽.";

FW.L.CD_BASIC1_TT = "显示冷却计时条.";		
FW.L.CD_BASIC2_TT = "锁定冷却条. 冷却条锁定后无法点击,因此你就不能移动或者通过它打开设置.";

FW.L.CD_CUSTOMIZE_TT = "自定义你的冷却技能.";

FW.L.CD_SPECIFIC1 = "右击图标屏蔽";
FW.L.CD_SPECIFIC1_TT = "右键点击图标屏蔽此技能冷却显示,在自定义选项中可以设定解除屏蔽.";
FW.L.CD_SPECIFIC2 = "竖向显示";
FW.L.CD_SPECIFIC2_TT = "冷却条竖向显示.";
FW.L.CD_SPECIFIC3 = "没有冷却时隐藏";
FW.L.CD_SPECIFIC3_TT = "当冷却条没有冷却显示时自动隐藏.";
FW.L.CD_SPECIFIC4 = "结束时闪动";
FW.L.CD_SPECIFIC4_TT = "每个技能冷却结束后显示一个闪动效果(JCC效果).";
FW.L.CD_SPECIFIC5 = "小时间刻度";
FW.L.CD_SPECIFIC5_TT = "冷却条上显示更详细的时间刻度,如果你的时间显示长度远小于60M时很有帮助.";
FW.L.CD_SPECIFIC6 = "最大计时长度(秒)";
FW.L.CD_SPECIFIC6_TT = "设定冷却条显示的最大冷却计时长度,单位为秒,超过这个时间的冷却技能也会在冷却条开始端显示.";
FW.L.CD_SPECIFIC7 = "显示Buffs";
FW.L.CD_SPECIFIC7_TT = "冷却计时同样会显示某些特定的自身buff";
FW.L.CD_SPECIFIC8 = "冷却计时方向";
FW.L.CD_SPECIFIC8_TT = "转换冷却计时的移动方向.";
FW.L.CD_SPECIFIC9 = "闪光大小";
FW.L.CD_SPECIFIC9_TT = "设定图标闪动的最大比例.";

FW.L.RESURRECT_TIMER = "复活计时";
FW.L.SS = "灵魂石";
FW.L.BUFF = "Buff";

FW.L.ICON_FONT = "冷却字体";
FW.L.ICON_TEXT = "冷却时间";
FW.L.ICON_TEXT_TT = "这个显示技能冷却的时间,想显示具体时间,请设置好文字颜色的透明度.";

FW.L.UPDATE_INTERVAL_BUFFS = "更新buff扫描间隔";

-- trdition Chinese
elseif GetLocale() == "zhTW" then	

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.COOLDOWN_TIMER = "冷卻計時";

FW.L.CD_HINT1 = "設置顏色時使用透明度控制文字和其他部分的顯示.";
FW.L.CD_HINT2 = "使用自定義選項遮罩冷卻或者改變顏色,右鍵點擊遮罩.";

FW.L.CD_BASIC1_TT = "顯示冷卻計時條.";		
FW.L.CD_BASIC2_TT = "鎖定冷卻條. 冷卻條鎖定後無法點擊,因此你就不能移動或者通過它打開設置.";

FW.L.CD_CUSTOMIZE_TT = "自定義你的冷卻技能.";

FW.L.CD_SPECIFIC1 = "右擊圖示遮罩";
FW.L.CD_SPECIFIC1_TT = "右鍵點擊圖示遮罩此技能冷卻顯示,在自定義選項中可以設定解除遮罩.";
FW.L.CD_SPECIFIC2 = "豎向顯示";
FW.L.CD_SPECIFIC2_TT = "冷卻條豎向顯示.";
FW.L.CD_SPECIFIC3 = "沒有冷卻時隱藏";
FW.L.CD_SPECIFIC3_TT = "當冷卻條沒有冷卻顯示時自動隱藏.";
FW.L.CD_SPECIFIC4 = "結束時閃動";
FW.L.CD_SPECIFIC4_TT = "每個技能冷卻結束後顯示一個閃動效果(JCC效果).";
FW.L.CD_SPECIFIC5 = "小時間刻度";
FW.L.CD_SPECIFIC5_TT = "冷卻條上顯示更詳細的時間刻度,如果你的時間顯示長度遠小於60M時很有幫助.";
FW.L.CD_SPECIFIC6 = "最大計時長度(秒)";
FW.L.CD_SPECIFIC6_TT = "設定冷卻條顯示的最大冷卻計時長度,單位為秒,超過這個時間的冷卻技能也會在冷卻條開始端顯示.";
FW.L.CD_SPECIFIC7 = "顯示Buffs";
FW.L.CD_SPECIFIC7_TT = "冷卻計時同樣會顯示某些特定的自身buff";
FW.L.CD_SPECIFIC8 = "冷卻計時方向";
FW.L.CD_SPECIFIC8_TT = "轉換冷卻計時的移動方向.";
FW.L.CD_SPECIFIC9 = "閃光大小";
FW.L.CD_SPECIFIC9_TT = "設定圖示閃動的最大比例.";

FW.L.RESURRECT_TIMER = "復活計時";
FW.L.SS = "靈魂石";
FW.L.BUFF = "Buff";

FW.L.ICON_FONT = "冷卻字體";
FW.L.ICON_TEXT = "冷卻時間";
FW.L.ICON_TEXT_TT = "這個顯示技能冷卻的時間,想顯示具體時間,請設置好文字顏色的透明度.";

FW.L.UPDATE_INTERVAL_BUFFS = "更新buffs掃描間隔";

else
-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.COOLDOWN_TIMER = "Cooldown Timer";

FW.L.CD_HINT1 = "Use alpha in the color settings to hide/show texts and other parts.";
FW.L.CD_HINT2 = "Use the 'Customize' option to ignore cooldowns or change a color. Right-click an icon to ignore.";

FW.L.CD_BASIC1_TT = "Visually enable the cooldown timer.";		
FW.L.CD_BASIC2_TT = "Lock the cooldown bar. When the bar is locked you will click through it, so you can no longer accidently move it or open the options from it.";

FW.L.CD_CUSTOMIZE_TT = "Customize each of your cooldowns.";

FW.L.CD_SPECIFIC1 = "Right-click icons to ignore";
FW.L.CD_SPECIFIC1_TT = "Right-clicking an icon on the cooldown bar will put it on ignore. You can remove it from ignore using the customization option.";
FW.L.CD_SPECIFIC2 = "Flip to vertical";
FW.L.CD_SPECIFIC2_TT = "Change the bar orientation from horizontal to vertical.";
FW.L.CD_SPECIFIC3 = "Auto-hide when no cooldowns";
FW.L.CD_SPECIFIC3_TT = "Hide the cooldown timer scale and background when you have no visible cooldowns.";
FW.L.CD_SPECIFIC4 = "Splash ready cooldowns";
FW.L.CD_SPECIFIC4_TT = "This will show an icon 'splash' at the origin of the cooldown timer each time a cooldown is ready.";
FW.L.CD_SPECIFIC5 = "Detail scale";
FW.L.CD_SPECIFIC5_TT = "You will receive some extra time scale points on the cooldown bar. Useful if you have changed the time scale to something a lot smaller than 60 minutes.";
FW.L.CD_SPECIFIC6 = "Time scale max (sec)";
FW.L.CD_SPECIFIC6_TT = "Set the scale of the cooldown bar, by giving the biggest cooldown time in seconds(!) that the bar should display. Cooldowns outside your scale will still show at the end of the bar.";
FW.L.CD_SPECIFIC7 = "Show Buffs";
FW.L.CD_SPECIFIC7_TT = "The cooldown timer will also show certain self buffs.";
FW.L.CD_SPECIFIC8 = "Flip bar direction";
FW.L.CD_SPECIFIC8_TT = "Flip the timer bar direction.";
FW.L.CD_SPECIFIC9 = "Splash icon Factor";
FW.L.CD_SPECIFIC9_TT = "Set what maximum scale factor to use for the icon splash.";

FW.L.RESURRECT_TIMER = "Resurrect Timer";
FW.L.SS = "Soulstone";
FW.L.BUFF = "Buff";

FW.L.ICON_FONT = "Icon Font";
FW.L.ICON_TEXT = "Icon text";
FW.L.ICON_TEXT_TT = "This is the time text on the cooldown icons themselves. To show these, change the text color transparency.";

FW.L.UPDATE_INTERVAL_BUFFS = "Update interval buffs";

end