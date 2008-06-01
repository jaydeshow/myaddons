﻿--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Various Artists
--

if (GetLocale() == "zhTW") then
	AutoBar.locale = {
		["AutoBar"] = "AutoBar",
		["CONFIG_WINDOW"] = "設定視窗",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["Button"] = "按鈕",
		["EDITSLOT"] = "編輯欄位",
		["VIEWSLOT"] = "檢視欄位",
		["LOAD_ERROR"] = "|cff00ff00載入 AutoBarConfig 發生錯誤。請確定是否有這個插件，並啟用插件。|r錯誤: ",
		["Toggle the config panel"] = "切換 AutoBar 設定視窗",
		["Empty"] = "空",

		-- Waterfall
		["Alpha"] = "透明度",
		["Change the alpha of the bar."] = "改變物品列的透明度",
		["Add Button"] = "增加按鈕",
		["Align Buttons"] = "按鈕排列方向",
		["Always Show"] = "永遠顯示";
		["Always Show %s, even if empty."] = "永遠顯示 %s，即使是空白的。";
		["Announce to Party"] = "通報到小隊",
		["Announce to Raid"] = "通報到團隊",
		["Announce to Say"] = "通報到 '說'",
		["Bar Location"] = "放置的物品列",
		["Bar the Button is located on"] = "按鈕放置在物品列上",
		["Bars"] = "物品列",
		["Battlegrounds only"] = "僅限戰場",
		["Button Width"] = "按鈕寬度",
		["Change the button width."] = "改變按鈕的寬度",
		["Button Height"] = "按鈕高度",
		["Change the button height."] = "改變按鈕的高度",
		["Category"] = "類別",
		["Categories"] = "類別",
		["Categories for %s"] = "%s 的類別",
		["Clamp Bars to screen"] = "限制物品列在螢幕內",
		["Clamped Bars can not be positioned off screen"] = "限制物品列無法移出螢幕範圍",
		["Collapse Buttons"] = "緊縮按鈕",
		["Collapse Buttons that have nothing in them."] = "不顯示沒有任何物品的按鈕",
		["Configuration for %s"] = "%s 設定",
		["Delete this Custom Button completely"] = "完全刪除此自訂按鈕",
		["Dialog"] = "對話框",
		["Disable Conjure Button"] = "取消魔法製造按鈕",
		["Docked to"] = "依附於",
		["Done"] = "完成";
		["Enabled"] = "啟用",
		["Enable %s."] = "啟用 %s",
		["FadeOut"] = "淡出",
		["Fade out the Bar when not hovering over it."] = "當滑鼠移開時淡出物品列。",
		["FadeOut Time"] = "淡出時間",
		["FadeOut takes this amount of time."] = "淡出使用時間。",
		["FadeOut Alpha"] = "淡出透明度",
		["FadeOut stops at this Alpha level."] = "淡出後物品列的透明度。",
		["FadeOut Cancels in combat"] = "戰鬥中取消淡出",
		["FadeOut is cancelled when entering combat."] = "進入戰鬥狀態後取消淡出。",
		["FadeOut Cancels on Shift"] = "Shift 取消淡出",
		["FadeOut is cancelled when holding down the Shift key."] = "按住 Shift 鍵時取消淡出效果。",
		["FadeOut Cancels on Ctrl"] = "Ctrl 取消淡出",
		["FadeOut is cancelled when holding down the Ctrl key."] = "按住 Ctrl 鍵時取消淡出效果。",
		["FadeOut Cancels on Alt"] = "Alt 取消淡出",
		["FadeOut is cancelled when holding down the Alt key."] = "按住 Alt 鍵時取消淡出效果。",
		["FadeOut Delay"] = "淡出延遲時間",
		["FadeOut starts after this amount of time."] = "滑鼠移開後開始淡出的時間。",
		["Frame Level"] = "框架層級",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "調整框架的層級，使框架可在其他插件的上方或下方。",
		["General"] = "一般",
		["Hide"] = "隱藏",
		["Hide %s"] = "隱藏 %s",
		["Item"] = "物品",
		["Items"] = "物品",
		["Location"] = "使用地點",
		["Macro Text"] = "巨集名稱",
		["Show the button Macro Text"] = "在按鈕上顯示巨集名稱",
		["Medium"] = "中",
		["Name"] = "名稱",
		["New"] = "新增",
		["New Macro"] = "新巨集",
		["No Popup"] = "不彈出按鈕";
		["No Popup for %s"] = "不彈出 %s 按鈕";
		["Non Combat Only"] = "限戰鬥之外",
		["Not directly usable"] = "無法直接使用",
		["Number of columns for %s"] = "%s 的欄位數目",
		["Dropdown UI"] = "下拉設定選項",
		["Options GUI"] = "圖形介面設定選項",
		["Skin the Buttons"] = "按鈕外觀",
		["Order"] = "順序",
		["Change the order of %s in the Bar"] = "改變 %s 在物品列的順序",
		["Padding"] = "間距",
		["Change the padding of the bar."] = "改變物品列的間距",
		["Popup Direction"] = "按鈕彈出方向",
		["Refresh"] = "重新整理",
		["Refresh all the bars & buttons"] = "重新整理所有物品列及按鈕",
		["Remove"] = "移除",
		["Remove this Button from the Bar"] = "從物品列移除按鈕",
		["Reset"] = "重設",
		["Reset Bars"] = "重設物品列",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "重置所有角色的設定到預設值。自訂物品列，按鈕和類別維持不變。",
		["Reset the Bars to default Bar settings"] = "重設為物品列的預設設定值",
		["Revert"] = "復原";
		["Right Click casts "] = "右鍵點擊施放",
		["Rows"] = "列",
		["Number of rows for %s"] = "%s 的列數",
		["RightClick SelfCast"] = "右鍵自我施法",
		["SelfCast using Right click"] = "使用右鍵自我施法",
		["Key Bindings"] = KEY_BINDINGS,
		["Assign Bindings for Buttons on your Bars."] = "分配物品條榜定的按鈕。",
		["Scale"] = "大小",
		["Change the scale of the bar."] = "改變物品列的大小",
		["Shared Layout"] = "已共用的配置",
		["Share the Bar Visual Layout"] = "共用物品列的視覺配置",
		["Shared Buttons"] = "已共用的按鈕",
		["Share the Bar Button List"] = "共用物品列按鈕清單",
		["Shared Position"] = "已共用的位置",
		["Share the Bar Position"] = "共用物品列的位置",
		["Shift Dock Left/Right"] = "調整左右依附位置",
		["Shift Dock Up/Down"] = "調整上下依附位置",
		["Show Count Text"] = "顯示物品數量";
		["Show Count Text for %s"] = "顯示 %s 的物品數量";
		["Show Empty Buttons"] = "顯示空按鈕";
		["Show Empty Buttons for %s"] = "顯示 %s 為空按鈕";
		["Show Extended Tooltips"] = "顯示額外提示訊息";
		["Show Hotkey Text"] = "在按鈕上顯示快捷鍵",
		["Show Hotkey Text for %s"] = "在按鈕上顯示 %s 的快捷鍵",
		["Show Tooltips"] = "顯示提示訊息";
		["Show Tooltips for %s"] = "顯示 %s 的提示訊息";
		["Show Tooltips in Combat"] = "戰鬥狀態顯示提示訊息";
		["Shuffle"] = "隨機排列",
		["Shuffle replaces depleted items during combat with the next best item"] = "戰鬥期間隨機選取下一個最佳物品取代已耗盡的物品",
		["Snap Bars while moving"] = "使物品列在移動時有粘性",
		["Sticky Frames"] = "粘性框架",
		["Style"] = "樣式",
		["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."] = "改變物品列的樣式，需要安裝 ButtonFacade 插件。",
		["Targeted"] = "目標",
		["<Any String>"] = "<任何字串>",
		["Move the Bars"] = "移動物品列",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "拖曳可以移動物品列，左鍵切換物品列顯示 (綠)/隱藏 (紅)，右鍵可以進行設定。",
		["Move the Buttons"] = "移動按鈕",
		["Drag a Button to move it, right click to configure the Button."] = "拖曳可以移動按鈕，右鍵可以進行設定。",

		["{circle}"] = "{圈圈}",
		["{diamond}"] = "{鑚石}",
		["{skull}"] = "{頭顱}",
		["{square}"] = "{方形}",
		["{star}"] = "{星星}",
		["{triangle}"] = "{三角}",

		["TOPLEFT"] = "左上",
		["LEFT"] = "左",
		["BOTTOMLEFT"] = "左下",
		["TOP"] = "上",
		["CENTER"] = "中",
		["BOTTOM"] = "下",
		["TOPRIGHT"] = "右上",
		["RIGHT"] = "右",
		["BOTTOMRIGHT"] = "右下",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "FuBar 插件設定",
		["Configure the FuBar Plugin"] = "設定 FuBar 插件",
--		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55f雙擊: |r開啟設定介面。\n|cffeda55fCtrl-左擊: |r切換按鈕鎖定。\n|cffeda55fShift-左擊: |r切換物品列鎖定。",

		["\n|cffffffff%s:|r %s"] = "\n|cffffffff%s:|r %s",
		["Left-Click"] = "左鍵",
		["Right-Click"] = "右鍵",
		["Alt-Click"] = "Alt+點擊",
		["Ctrl-Click"] = "Ctrl+點擊",
		["Shift-Click"] = "Shift+點擊",
		["Ctrl-Shift-Click"] = "Ctrl+Shift+點擊",
		["ButtonFacade is required to Skin the Buttons"] = "ButtonFacade 需要按鈕外觀",
		["Waterfall-1.0 is required to access the GUI"] = "圖形用戶介面設定需要 Waterfall-1.0",

		-- Bar Names
		["AutoBarClassBarBasic"] = "基本",
		["AutoBarClassBarExtras"] = "額外",
		["AutoBarClassBarDruid"] = "德魯伊",
		["AutoBarClassBarHunter"] = "獵人",
		["AutoBarClassBarMage"] = "法師",
		["AutoBarClassBarPaladin"] = "聖騎士",
		["AutoBarClassBarPriest"] = "牧師",
		["AutoBarClassBarRogue"] = "盜賊",
		["AutoBarClassBarShaman"] = "薩滿",
		["AutoBarClassBarWarlock"] = "術士",
		["AutoBarClassBarWarrior"] = "戰士",

		-- Button Names
		["Buttons"] = "按鈕",
		["AutoBarButtonHeader"] = "AutoBar 按鈕名稱",
		["AutoBarCooldownHeader"] = "藥水及石頭冷卻時間",
		["AutoBarClassBarHeader"] = "職業物品列",

		["AutoBarButtonAura"] = "光環/守護",
		["AutoBarButtonBandages"] = "繃帶",
		["AutoBarButtonBattleStandards"] = "戰鬥姿勢",
		["AutoBarButtonBuff"] = "增益",
		["AutoBarButtonBuffWeapon1"] = "增益: 主手武器",
		["AutoBarButtonBuffWeapon2"] = "增益: 副手武器",
		["AutoBarButtonCharge"] = "衝鋒",
		["AutoBarButtonClassBuff"] = "職業增益法術",
		["AutoBarButtonClassPet"] = "職業寵物",
		["AutoBarButtonConjure"] = "法術: 製造",
		["AutoBarButtonCooldownDrums"] = "冷卻: 戰鼓",
		["AutoBarButtonCooldownPotionHealth"] = "藥水冷卻: 生命力",
		["AutoBarButtonCooldownPotionMana"] = "藥水冷卻: 法力",
		["AutoBarButtonCooldownPotionRejuvenation"] = "藥水冷卻: 活力",
		["AutoBarButtonCooldownStoneHealth"] = "石頭冷卻: 生命力",
		["AutoBarButtonCooldownStoneMana"] = "石頭冷卻: 法力",
		["AutoBarButtonCooldownStoneRejuvenation"] = "石頭冷卻: 活力",
		["AutoBarButtonCrafting"] = "專業技能",
		["AutoBarButtonDebuff"] = "減益",
		["AutoBarButtonElixirBattle"] = "作戰藥劑",
		["AutoBarButtonElixirGuardian"] = "防護藥劑",
		["AutoBarButtonElixirBoth"] = "作戰及防護藥劑",
		["AutoBarButtonER"] = "緊急反應",
		["AutoBarButtonExplosive"] = "爆裂物",
		["AutoBarButtonFishing"] = "釣魚裝備",
		["AutoBarButtonFood"] = "食物",
		["AutoBarButtonFoodBuff"] = "食物: 增益",
		["AutoBarButtonFoodCombo"] = "食物: 生命力及法力",
		["AutoBarButtonFoodPet"] = "食物: 寵物",
		["AutoBarButtonFreeAction"] = "自由行動",
		["AutoBarButtonHeal"] = "生命治療",
		["AutoBarButtonSpell1"] = "法術1",
		["AutoBarButtonSpell2"] = "法術2",
		["AutoBarButtonSpell3"] = "法術3",
		["AutoBarButtonSpell4"] = "法術4",
		["AutoBarButtonHearth"] = "爐石",
		["AutoBarButtonPickLock"] = "開鎖",
		["AutoBarButtonMount"] = "坐騎",
		["AutoBarButtonPets"] = "寵物",
		["AutoBarButtonQuest"] = "任務物品",
		["AutoBarButtonRecovery"] = "法力/怒氣/能量恢復",
		["AutoBarButtonRotationDrums"] = "旋轉: 戰鼓",
		["AutoBarButtonSpeed"] = "速度提昇",
		["AutoBarButtonStance"] = "姿態",
		["AutoBarButtonStealth"] = "潛行",
		["AutoBarButtonSting"] = "釘刺",
		["AutoBarButtonTotemEarth"] = "大地圖騰",
		["AutoBarButtonTotemAir"] = "風之圖騰",
		["AutoBarButtonTotemFire"] = "火焰圖騰",
		["AutoBarButtonTotemWater"] = "水之圖騰",
		["AutoBarButtonTrack"] = "追蹤技能",
		["AutoBarButtonTrap"] = "陷阱",
		["AutoBarButtonTrinket1"] = "飾品 1",
		["AutoBarButtonTrinket2"] = "飾品 2",
		["AutoBarButtonWarlockStones"] = "術士石頭",
		["AutoBarButtonWater"] = "水",
		["AutoBarButtonWaterBuff"] = "水: 增益",

		["AutoBarButtonBear"] = "熊",
		["AutoBarButtonBoomkinTree"] = "生命之樹/梟獸",
		["AutoBarButtonCat"] = "獵豹",
		["AutoBarButtonTravel"] = "旅行",
		["AutoBarButtonFlight"] = "飛行",
		["AutoBarButtonNormal"] = "正常",

		-- AutoBarClassButton.lua
		["Num Pad "] = "數字鍵盤",
		["Mouse Button "] = "滑鼠按鍵",
		["Middle Mouse"] = "滑鼠中鍵",
		["Backspace"] = "退回鍵",
		["Spacebar"] = "空白鍵",
		["Delete"] = "刪除",
		["Home"] = "Home 鍵",
		["End"] = "End 鍵",
		["Insert"] = "Insert 鍵",
		["Page Up"] = "Page Up 鍵",
		["Page Down"] = "Page Down 鍵",
		["Down Arrow"] = "往下鍵",
		["Up Arrow"] = "往上鍵",
		["Left Arrow"] = "往左鍵",
		["Right Arrow"] = "往右鍵",
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["NP"] = "數",
		["M"] = "鼠",
		["MM"] = "鼠中",
		["Bs"] = "Bs",
		["Sp"] = "Sp",
		["De"] = "De",
		["Ho"] = "Ho",
		["En"] = "En",
		["Ins"] = "Ins",
		["Pu"] = "Pu",
		["Pd"] = "Pd",
		["D"] = "下",
		["U"] = "上",
		["L"] = "左",
		["R"] = "右",

		--  AutoBarConfig.lua
		["EMPTY"] = "空";
		["Default"] = "預設",
		["Zoomed"] = "放大",
		["Dreamlayout"] = "夢幻",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "停用右擊自我施法";
		["AUTOBAR_CONFIG_REMOVECAT"] = "移除目前類型";
		["Columns"] = "欄";
		["AUTOBAR_CONFIG_GAPPING"] = "圖示間隔";
		["AUTOBAR_CONFIG_ALPHA"] = "圖示透明度";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "不鎖定按鈕長寬比";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "顯示物品類型圖示";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "按 Shift 鍵彈出按鈕";
		["Rearrange Order on Use"] = "使用後重新排列順序";
		["Rearrange Order on Use for %s"] = "使用 %s 後重新排列順序";
		["Right Click Targets Pet"] = "右鍵以寵物為目標";
		["None"] = "無";
		["AUTOBAR_CONFIG_BT3BAR"] = "BT3 動作列";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "主目錄";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "聊天視窗";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "聊天視窗選單";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "動作列";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "小選單";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(未發現: 物品 ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " 層 (左鍵編輯)";
		["AUTOBAR_CONFIG_CHARACTER"] = "角色";
		["Shared"] = "共用";
		["Account"] = "帳號";
		["Class"] = "職業";
		["AUTOBAR_CONFIG_BASIC"] = "基本";
		["AUTOBAR_CONFIG_USECHARACTER"] = "使用角色層";
		["AUTOBAR_CONFIG_USESHARED"] = "使用共用層";
		["AUTOBAR_CONFIG_USECLASS"] = "使用職業層";
		["AUTOBAR_CONFIG_USEBASIC"] = "使用基本層";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "隱藏設定提示訊息";
		["AUTOBAR_CONFIG_OSKIN"] = "使用 oSkin";
		["Log Events"] = "紀錄事件";
		["Log Performance"] = "記錄效能";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "角色層";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "共用層";
		["AUTOBAR_CONFIG_SHARED1"] = "共用 1";
		["AUTOBAR_CONFIG_SHARED2"] = "共用 2";
		["AUTOBAR_CONFIG_SHARED3"] = "共用 3";
		["AUTOBAR_CONFIG_SHARED4"] = "共用 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "編輯角色層";
		["AUTOBAR_CONFIG_EDITSHARED"] = "編輯共用層";
		["AUTOBAR_CONFIG_EDITCLASS"] = "編輯職業層";
		["AUTOBAR_CONFIG_EDITBASIC"] = "編輯基本層";
		["Share the config"] = "共用設定";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "煙火",
		["Tradeskill.Tool.Fishing.Lure"] = "魚餌",
		["Tradeskill.Tool.Fishing.Gear"] = "釣魚裝備",
		["Tradeskill.Tool.Fishing.Other"] = "釣魚增益 (魚餌)",
		["Tradeskill.Tool.Fishing.Tool"] = "魚竿",

		["Consumable.Food.Bonus"] = "食物: 所有補助食物";
		["Consumable.Food.Buff.Strength"] = "食物: 力量增益";
		["Consumable.Food.Buff.Agility"] = "食物: 敏捷增益";
		["Consumable.Food.Buff.Attack Power"] = "食物: 攻擊強度增益";
		["Consumable.Food.Buff.Healing"] = "食物: 治療效果增益";
		["Consumable.Food.Buff.Spell Damage"] = "食物: 法術傷害增益";
		["Consumable.Food.Buff.Stamina"] = "食物: 耐力增益";
		["Consumable.Food.Buff.Intellect"] = "食物: 智力增益";
		["Consumable.Food.Buff.Spirit"] = "食物: 精神增益";
		["Consumable.Food.Buff.Mana Regen"] = "食物: 法力恢復增益";
		["Consumable.Food.Buff.HP Regen"] = "食物: 生命力恢復增益";
		["Consumable.Food.Buff.Other"] = "食物: 其他";

		["Consumable.Buff.Health"] = "增益: 生命力";
		["Consumable.Buff.Armor"] = "增益: 護甲值";
		["Consumable.Buff.Regen Health"] = "增益: 生命力恢復速度";
		["Consumable.Buff.Agility"] = "增益: 敏捷";
		["Consumable.Buff.Intellect"] = "增益: 智力";
		["Consumable.Buff.Protection"] = "增益: 防護";
		["Consumable.Buff.Spirit"] = "增益: 精神";
		["Consumable.Buff.Stamina"] = "增益: 耐力";
		["Consumable.Buff.Strength"] = "增益: 力量";
		["Consumable.Buff.Attack Power"] = "增益: 攻擊強度";
		["Consumable.Buff.Attack Speed"] = "增益: 攻擊速度";
		["Consumable.Buff.Dodge"] = "增益: 閃躲";
		["Consumable.Buff.Resistance"] = "增益: 抗性";

		["Consumable.Buff Group.General.Self"] = "增益: 一般";
		["Consumable.Buff Group.General.Target"] = "增益: 一般目標";
		["Consumable.Buff Group.Caster.Self"] = "增益: 施法者";
		["Consumable.Buff Group.Caster.Target"] = "增益: 施法者目標";
		["Consumable.Buff Group.Melee.Self"] = "增益: 近戰";
		["Consumable.Buff Group.Melee.Target"] = "增益: 近戰目標";
		["Consumable.Buff.Other.Self"] = "增益: 其他";
		["Consumable.Buff.Other.Target"] = "增益: 其他目標";
		["Consumable.Buff.Chest"] = "增益: 胸甲";
		["Consumable.Buff.Shield"] = "增益: 盾牌";
		["Consumable.Weapon Buff"] = "增益: 武器";

		["Misc.Usable.BossItem"] = "首領物品";
		["Misc.Usable.Permanent"] = "永久可用物品";
		["Misc.Usable.Quest"] = "可用任務物品";
		["Misc.Usable.Replenished"] = "可再補充物品";

		["Consumable.Cooldown.Potion.Health.Basic"] = "治療藥水";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "治療藥水: 劍刃山脈";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "治療藥水: 盤牙洞穴";
		["Consumable.Cooldown.Potion.Health.PvP"] = "治療藥水: 戰場";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "治療藥水: 風暴要塞";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "法力藥水";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "法力藥水: 劍刃山脈";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "法力藥水: 盤牙洞穴";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "法力藥水: 戰場";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "法力藥水: 風暴要塞";

		["Consumable.Weapon Buff.Poison.Crippling"] = "致殘毒藥";
		["Consumable.Weapon Buff.Poison.Deadly"] = "致命毒藥";
		["Consumable.Weapon Buff.Poison.Instant"] = "速效毒藥";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "麻痹毒藥";
		["Consumable.Weapon Buff.Poison.Wound"] = "致傷毒藥";
		["Consumable.Weapon Buff.Oil.Mana"] = "法力之油";
		["Consumable.Weapon Buff.Oil.Wizard"] = "巫師之油";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "磨刀石";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "平衡石";

		["Consumable.Bandage.Basic"] = "繃帶";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "奧特蘭克繃帶";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "戰歌繃帶";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "阿拉希繃帶";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "食物: 普通";
		["Consumable.Food.Percent.Basic"] = "食物: 恢復生命力 (%)";
		["Consumable.Food.Percent.Bonus"] = "食物: 恢復生命力 (%) (輔助效果)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "食物: 恢復生命力及法力 (非魔法製作)";
		["Consumable.Food.Edible.Combo.Conjured"] = "食物: 恢復生命力及法力 (魔法製作)";
		["Consumable.Food.Combo Percent"] = "食物: 恢復生命力及法力 (%)";
		["Consumable.Food.Combo Health"] = "食物: 恢復生命力及法力";
		["Consumable.Food.Edible.Bread.Conjured"] = "食物: 魔法麵包";
		["Consumable.Food.Conjure"] = "造食術";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "食物: 阿拉希盆地";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "食物: 戰歌峽谷";

		["Consumable.Food.Pet.Bread"] = "食物: 寵物麵包";
		["Consumable.Food.Pet.Cheese"] = "食物: 寵物乳酪";
		["Consumable.Food.Pet.Fish"] = "食物: 寵物魚類";
		["Consumable.Food.Pet.Fruit"] = "食物: 寵物水果";
		["Consumable.Food.Pet.Fungus"] = "食物: 寵物蘑菇";
		["Consumable.Food.Pet.Meat"] = "食物: 寵物肉類";

		["Consumable.Buff Pet"] = "增益: 寵物";

		["Custom"] = "自訂";
		["Misc.Minipet.Normal"] = "觀賞用寵物";
		["Misc.Minipet.Snowball"] = "節慶觀賞用寵物";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "安戈洛: 恢復水晶";

		["Consumable.Anti-Venom"] = "抗毒藥劑";

		["Consumable.Warlock.Firestone"] = "火焰石";
		["Consumable.Warlock.Soulstone"] = "靈魂石";
		["Consumable.Warlock.Spellstone"] = "法術石";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "治療石";
		["Spell.Warlock.Create Firestone"] = "製造火焰石";
		["Spell.Warlock.Create Healthstone"] = "製造治療石";
		["Spell.Warlock.Create Soulstone"] = "製造靈魂石";
		["Spell.Warlock.Create Spellstone"] = "製造法術石";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "法力寶石";
		["Spell.Mage.Conjure Mana Stone"] = "製造法力寶石";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "昏睡藥水";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "活力藥水";
		["Consumable.Cooldown.Stone.Health.Statue"] = "雕像";
		["Consumable.Cooldown.Drums"] = "冷卻: 戰鼓";
		["Consumable.Cooldown.Potion"] = "冷卻: 藥水";
		["Consumable.Cooldown.Stone"] = "冷卻: 石";
		["Consumable.Leatherworking.Drums"] = "戰鼓";
		["Consumable.Tailor.Net"] = "網";

		["Misc.Battle Standard.Battleground"] = "戰場軍旗";
		["Misc.Battle Standard.Alterac Valley"] = "奧特蘭克山谷軍旗";
		["Consumable.Cooldown.Stone.Health.Other"] = "治瘵物品: 其它";
		["Consumable.Cooldown.Stone.Mana.Other"] = "惡魔和黑暗符文";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "秘法防護";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "火焰防護";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "冰霜防護";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "自然防護";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "暗影防護";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "法術防護";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "神聖防護";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "有限無敵藥水";
		["Consumable.Buff.Free Action"] = "增益: 自由行動";

		["Misc.Lockboxes"] = "帶鎖箱";
		["Gear.Trinket"] = "飾品";

		["Spell.Aura"] = "光環/守護";
		["Spell.Buff.Weapon"] = "法術增益: 武器";
		["Spell.Class.Buff"] = "職業增益法術";
		["Spell.Class.Pet"] = "戰鬥寵物";
		["Spell.Crafting"] = "專業技能";
		["Spell.Debuff.Multiple"] = "減益: 多重";
		["Spell.Debuff.Single"] = "減益: 單一";
		["Spell.Fishing"] = "釣魚";
		["Spell.Portals"] = "傳送門和傳送";
		["Spell.Sting"] = "釘刺";
		["Spell.Stance"] = "姿態";
		["Spell.Totem.Earth"] = "大地圖騰";
		["Spell.Totem.Air"] = "風之圖騰";
		["Spell.Totem.Fire"] = "火焰圖騰";
		["Spell.Totem.Water"] = "水之圖騰";
		["Spell.Seal"] = "聖印";
		["Spell.Track"] = "追蹤技能";
		["Spell.Trap"] = "陷阱";
		["Misc.Hearth"] = "爐石";
		["Misc.Booze"] = "酒";
		["Consumable.Water.Basic"] = "水";
		["Consumable.Water.Percentage"] = "水: 恢復法力 (%)";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "水: 魔法水";
		["Consumable.Water.Conjure"] = "造水術";
		["Consumable.Water.Buff.Spirit"] = "水: 精神增益";
		["Consumable.Water.Buff"] = "水: 增益";
		["Consumable.Buff.Rage"] = "增益: 怒氣";
		["Consumable.Buff.Energy"] = "增益: 能量";
		["Consumable.Buff.Speed"] = "增益: 迅捷";
		["Consumable.Buff Type.Battle"] = "增益: 作戰藥劑";
		["Consumable.Buff Type.Guardian"] = "增益: 防護藥劑";
		["Consumable.Buff Type.Flask"] = "增益: 精煉";
		["AUTOBAR_CLASS_SOULSHARDS"] = "靈魂裂片";
		["Misc.Reagent.Ammo.Arrow"] = "箭";
		["Misc.Reagent.Ammo.Bullet"] = "子彈";
		["Misc.Reagent.Ammo.Thrown"] = "投擲武器";
		["Misc.Explosives"] = "爆裂物";
		["Misc.Mount.Normal"] = "坐騎";
		["Misc.Mount.Summoned"] = "坐騎: 召喚";
		["Misc.Mount.Ahn'Qiraj"] = "坐騎: 其拉甲蟲";
		["Misc.Mount.Flying"] = "坐騎: 飛行";
	}

--AUTOBAR_CHAT_MESSAGE1 = "記錄檔是舊的版本，已被清除。不支援記錄檔的升級。";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_TAB_BAR = "物品列";
--AUTOBAR_CONFIG_TAB_POPUP = "彈出";
--AUTOBAR_CONFIG_TAB_PROFILE = "記錄檔";
--AUTOBAR_CONFIG_TAB_KEYS = "快捷鍵";
--
--AUTOBAR_TOOLTIP1 = " (數量: ";
--AUTOBAR_TOOLTIP2 = " [自定義物品]";
--AUTOBAR_TOOLTIP6 = " [使用條件限制]";
--AUTOBAR_TOOLTIP7 = " [使用後需冷卻]";
AUTOBAR_TOOLTIP8 = "\n(左鍵用於主手武器\n右鍵用於副手武器)";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "變動只作用於這個角色。";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "變動作用於所有角色。";
--AUTOBAR_CONFIG_SETUPSINGLE = "古典設定";
--AUTOBAR_CONFIG_SETUPSHARED = "共用設定";
--AUTOBAR_CONFIG_SETUPSTANDARD = "標準設定";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "清空欄位";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "點擊將設定為古典 AutoBar 設定。";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "點擊將設定為共用設定\n啟用角色專用以及共用欄位。";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "啟用編輯並使用所有欄位。";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "清除所有角色和共用的欄位。";
--AUTOBAR_CONFIG_RESETSINGLETIP = "點擊將重設為單一角色設定的預設值。";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "點擊將重設為角色共用設定的預設值。\n職業專用按鈕會複製到角色欄位。\n預設按鈕將複製到共用的欄位。";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "點擊將重設為標準預設值。\n職業專用按鈕會在職業欄位中。\n預設按鈕在基本欄位中。\n共用和角色欄位將會清除。";

--  AutoBarConfig.lua
--AUTOBAR_TOOLTIP9 = "多類型物品按鈕\n";
--AUTOBAR_TOOLTIP10 = " (按物品編號定制)";
--AUTOBAR_TOOLTIP11 = "\n(物品編號未經過驗證)";
--AUTOBAR_TOOLTIP12 = " (按物品名稱定制)";
--AUTOBAR_TOOLTIP13 = "單一類型物品按鈕\n\n";
--AUTOBAR_TOOLTIP15 = "\n武器目標\n(左鍵用於主手武器\n右鍵用於副手武器。)";
AUTOBAR_TOOLTIP17 = "\n僅戰鬥外";
AUTOBAR_TOOLTIP18 = "\n僅戰鬥中";
--AUTOBAR_TOOLTIP20 = "\n使用條件限制: ";
--AUTOBAR_TOOLTIP21 = "需恢復生命力";
--AUTOBAR_TOOLTIP22 = "需恢復法力";

end
