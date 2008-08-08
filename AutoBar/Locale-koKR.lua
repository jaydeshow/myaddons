﻿--
-- AutoBar
-- http://code.google.com/p/autobar/
-- Courtesy of Sayclub
--

if (GetLocale() == "koKR") then
	AutoBar.locale = {
		["AutoBar"] = "AutoBar",
		["CONFIG_WINDOW"] = "설정 창",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["Button"] = "버튼",
		["LOAD_ERROR"] = "|cff00ff00AutoBarConfig 모드를 불려오지 못해 오류가 발생했습니다. 당신이 그것을 다운로드하고 사용 가능하게 하십시오.|r 오류: ",
		["Toggle the config panel"] = "설정 창 열기",
		["Empty"] = "빈창",

		-- Waterfall
		["Alpha"] = "투명도",
		["Change the alpha of the bar."] = "바의 투명도를 변경합니다.",
		["Add Button"] = "버튼 추가",
		["Align Buttons"] = "버튼 정렬",
		["Always Popup"] = "항상 팝업";
		["Always keep Popups open for %s"] = "항상 %s|1을;를; 위해 팝업을 엽니다.";
		["Always Show"] = "항상 표시";
		["Always Show %s, even if empty."] = "빈창을 포함하여, 항상 %s|1을;를; 표시합니다.";
		["Announce to Party"] = "파티에 알림",
		["Announce to Raid"] = "공격대에 알림",
		["Announce to Say"] = "일반 알림",
		["Bar Location"] = "바 위치",
		["Bar the Button is located on"] = "버튼이 위치할 바",
		["Bars"] = "바들",
		["Battlegrounds only"] = "전장에서만",
		["Button Width"] = "버튼 너비",
		["Change the button width."] = "버튼의 너비를 변경합니다.",
		["Button Height"] = "버튼 높이",
		["Change the button height."] = "버튼의 높이를 변경합니다.",
		["Category"] = "카테고리",
		["Categories"] = "카테고리",
		["Categories for %s"] = "%s|1을;를; 위한 카테고리",
		["Clamp Bars to screen"] = "화면에 바 고정",
		["Clamped Bars can not be positioned off screen"] = "화면 밖으로 바가 벗어나지 않도록 고정시킵니다.",
		["Collapse Buttons"] = "버튼 접기",
		["Collapse Buttons that have nothing in them."] = "아무것도 등록되지 않은 버튼을 숨김니다.",
		["Configuration for %s"] = "%s|1을;를; 위한 설정",
		["Delete this Custom Button completely"] = "이 사용자 버튼 삭제",
		["Dialog"] = "Dialog",  -- Check
		["Disable Conjure Button"] = "생성 버튼 비활성화",
		["Docked to"] = "위치 변경",
		["Done"] = "완료";
		["Drop"] = "드롭";
		["Drop items, spells or macros onto Button to add them to its top Custom Category"] = "사용자 카테고리 버튼 위에 아이템이나 주문, 매크로를 추가하기 위해 드롭합니다.";
		["Enabled"] = "사용",
		["Enable %s."] = "%s|1을;를; 사용",
		["FadeOut"] = "투명화",
		["Fade out the Bar when not hovering over it."] = "바 위에 오버하지 않을때 투명화게 만듭니다.",
		["FadeOut Time"] = "투명화 시간",
		["FadeOut takes this amount of time."] = "투명화 시간을 설정합니다.",
		["FadeOut Alpha"] = "투명화 투명도",
		["FadeOut stops at this Alpha level."] = "투명화 투명도 레벨을 설정합니다.",
		["FadeOut Cancels in combat"] = "전투 상태시 투명화 취소",
		["FadeOut is cancelled when entering combat."] = "전투 상태시 투명화가 취소됩니다.",
		["FadeOut Cancels on Shift"] = "Shift키 입력시 투명화 취소",
		["FadeOut is cancelled when holding down the Shift key."] = "Shift키 입력시 투명화가 취소됩니다.",
		["FadeOut Cancels on Ctrl"] = "Ctrl키 입력시 투명화 취소",
		["FadeOut is cancelled when holding down the Ctrl key."] = "Ctrl키 입력시 투명화가 취소됩니다.",
		["FadeOut Cancels on Alt"] = "Alt키 입력시 투명화 취소",
		["FadeOut is cancelled when holding down the Alt key."] = "Alt키 입력시 투명화가 취소됩니다.",
		["FadeOut Delay"] = "투명화 지연",
		["FadeOut starts after this amount of time."] = "지정 시간 이후에 투명화를 시작합니다.",
		["Frame Level"] = "창 레벨",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "다른 UI 위나 아래에 나타나는 팝업 버튼 및 창의 레벨을 조정합니다.",
		["General"] = "일반",
		["Hide"] = "숨김",
		["Hide %s"] = "%s|1을;를; 숨김",
		["Item"] = "아이템",
		["Items"] = "아이템들",
		["Location"] = "위치",
		["Macro Text"] = "매크로 이름",
		["Show the button Macro Text"] = "버튼에 매크로 이름을 표시합니다.",
		["Medium"] = "매체",
		["Name"] = "이름",
		["New"] = "신규",
		["New Macro"] = "신규 매크로",
		["No Popup"] = "팝업 없음";
		["No Popup for %s"] = "%s|1을;를; 위한 팝업 없음";
		["Non Combat Only"] = "비전투시만",
		["Not directly usable"] = "직접 사용 불가",
		["Number of columns for %s"] = "%s|1을;를; 위한 컬럼 숫자",
		["Dropdown UI"] = "드랍다운 UI",
		["Options GUI"] = "GUI 옵션",
		["Skin the Buttons"] = "버튼 스킨",
		["Order"] = "순서",
		["Change the order of %s in the Bar"] = "%s 바의 순서를 변경합니다.",
		["Padding"] = "간격",
		["Change the padding of the bar."] = "바의 간격을 변경합니다.",
		["Popup Direction"] = "팝업 위치",
		["Refresh"] = "재실행",
		["Refresh all the bars & buttons"] = "모든 바 & 버튼의 다시 읽습니다.",
		["Remove"] = "제거",
		["Remove this Button from the Bar"] = "바에서 이 버튼을 제거합니다.",
		["Reset"] = "초기화",
		["Reset Bars"] = "바 초기화",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "모든 캐릭터를 위해 기본값으로 초기화 합니다. 사용자 바와 버튼, 카테고리는 변하지 않습니다.",
		["Reset the Bars to default Bar settings"] = "바들의 설정을 기본값으로 초기화합니다.",
		["Revert"] = "되돌리기";
		["Right Click casts "] = "우 클릭 시전 ",
		["Rows"] = "줄",
		["Number of rows for %s"] = "%s|1을;를; 위한 줄의 숫자",
		["RightClick SelfCast"] = "자신에게 시전 우클릭",
		["SelfCast using Right click"] = "자신에게 시전을 우클릭으로 사용합니다.",
		["Key Bindings"] = KEY_BINDINGS,
		["Assign Bindings for Buttons on your Bars."] = "당신의 바 위의 버튼 단축키를 지정합니다.",
		["Scale"] = "비율",
		["Change the scale of the bar."] = "바의 비율을 변경합니다.",
		["Shared Layout"] = "배치 공유",
		["Share the Bar Visual Layout"] = "바의 시각적 배치를 공유합니다.",
		["Shared Buttons"] = "버튼 공유",
		["Share the Bar Button List"] = "바 버튼 목록을 공유합니다.",
		["Shared Position"] = "위치 공유",
		["Share the Bar Position"] = "바 위치를 공유합니다.",
		["Shift Dock Left/Right"] = "좌/우 위치 변경",
		["Shift Dock Up/Down"] = "상/하 위치 변경",
		["Show Count Text"] = "갯수 표시";
		["Show Count Text for %s"] = "%s|1을;를; 위해 갯수를 표시합니다.";
		["Show Empty Buttons"] = "빈 버튼들 표시";
		["Show Empty Buttons for %s"] = "%s|1을;를; 위한 빈 버튼 표시";
		["Show Extended Tooltips"] = "확장 툴팁 표시";
		["Show Hotkey Text"] = "단축키 표시",
		["Show Hotkey Text for %s"] = "%s|1을;를; 위해 단축키를 표시합니다.",
		["Show Tooltips"] = "툴팁 표시";
		["Show Tooltips for %s"] = "%s|1을;를; 위해 툴팁을 표시합니다.";
		["Show Tooltips in Combat"] = "전투중 툴팁 표시";
		["Shuffle"] = "재편성",
		["Shuffle replaces depleted items during combat with the next best item"] = "전투 상태시 해당 아이템을 모두 사용시 다음 가장 좋은 아이템으로 변경시킵니다.",
		["Snap Bars while moving"] = "움직이는 동안 스냅 바",
		["Sticky Frames"] = "접착 창",
		["Style"] = "스타일",
		["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."] = "바의 스타일을 변경합니다. non-Blizzard 스타일을 위해 ButtonFacade가 필요합니다.",
		["Targeted"] = "대상",
		["<Any String>"] = "<모든 문자>",
		["Move the Bars"] = "바 이동",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "바를 이동시키기 위해 드래그합니다. 바를 숨기(빨강)거나 표시(녹색)하기 위해 좌클릭을 합니다. 바 설정을 위해 우클릭을 합니다.",
		["Move the Buttons"] = "버튼 이동",
		["Drag a Button to move it, right click to configure the Button."] = "버튼을 이동시키기 위해 드래그합니다. 버튼 설정을 위해 우클릭하세요.",

		["{star}"] = "{rt1}",
		["{circle}"] = "{rt2}",
		["{diamond}"] = "{rt3}",
		["{triangle}"] = "{rt4}",
		["{moon}"] = "{rt5}",
		["{square}"] = "{rt6}",
		["{x}"] = "{rt7}",
		["{skull}"] = "{rt8}",

		["TOPLEFT"] = "좌측 상단",
		["LEFT"] = "좌측",
		["BOTTOMLEFT"] = "좌측 하단",
		["TOP"] = "상단",
		["CENTER"] = "중앙",
		["BOTTOM"] = "하단",
		["TOPRIGHT"] = "우측 상단",
		["RIGHT"] = "우측",
		["BOTTOMRIGHT"] = "우측 하단",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "FuBar 플러그인 설정",
		["Configure the FuBar Plugin"] = "FuBar 플러그인을 설정합니다.",
--		["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."] = "\n|cffeda55f더블-클릭|r GUI 설정창 열기.\n|cffeda55fCtrl-클릭|r 버튼 잠금 토글. |cffeda55fShift-클릭|r 바 자금 토글.",

		["\n|cffffffff%s:|r %s"] = "\n|cffffffff%s:|r %s",
		["Left-Click"] = "좌-클릭",
		["Right-Click"] = "우-클릭",
		["Alt-Click"] = "Alt-클릭",
		["Ctrl-Click"] = "Ctrl-클릭",
		["Shift-Click"] = "Shift-클릭",
		["Ctrl-Shift-Click"] = "Ctrl-Shift-클릭",
		["ButtonFacade is required to Skin the Buttons"] = "버튼에 스킨을 적용하기 위해 ButtonFacade가 필요합니다.",
		["Waterfall-1.0 is required to access the GUI"] = "GUI 설정을 위해 Waterfall-1.0이 필요합니다.",

		-- Bar Names
		["AutoBarClassBarBasic"] = "기본",
		["AutoBarClassBarExtras"] = "추가",
		["AutoBarClassBarDruid"] = "드루이드",
		["AutoBarClassBarHunter"] = "사냥꾼",
		["AutoBarClassBarMage"] = "마법사",
		["AutoBarClassBarPaladin"] = "성기사",
		["AutoBarClassBarPriest"] = "사제",
		["AutoBarClassBarRogue"] = "도적",
		["AutoBarClassBarShaman"] = "주술사",
		["AutoBarClassBarWarlock"] = "흑마법사",
		["AutoBarClassBarWarrior"] = "전사",

		-- Button Names
		["Buttons"] = "버튼",
		["AutoBarButtonHeader"] = "AutoBar 지정 버튼들",
		["AutoBarCooldownHeader"] = "물약 & 석 대기시간",
		["AutoBarClassBarHeader"] = "직업 바",

		["AutoBarButtonAura"] = "오라 / 상",
		["AutoBarButtonBandages"] = "붕대",
		["AutoBarButtonBattleStandards"] = "전투 깃발",
		["AutoBarButtonBuff"] = "버프",
		["AutoBarButtonBuffWeapon1"] = "주무기 버프",
		["AutoBarButtonBuffWeapon2"] = "보조무기 버프",
		["AutoBarButtonCharge"] = "돌진",
		["AutoBarButtonClassBuff"] = "직업 버프",
		["AutoBarButtonClassPet"] = "직업 소환수",
		["AutoBarButtonConjure"] = "창조",
		["AutoBarButtonCooldownDrums"] = "대기시간: 북소리",
		["AutoBarButtonCooldownPotionCombat"] = "물약 대기시간: 전투",
		["AutoBarButtonCooldownPotionHealth"] = "물약 대기시간: 생명력",
		["AutoBarButtonCooldownPotionMana"] = "물약 대기시간: 마나",
		["AutoBarButtonCooldownPotionRejuvenation"] = "물약 대기시간: 회복",
		["AutoBarButtonCooldownStoneCombat"] = "조각상 대기시간: 전투",
		["AutoBarButtonCooldownStoneHealth"] = "조각상 대기시간: 생명력",
		["AutoBarButtonCooldownStoneMana"] = "조각상 대기시간: 마나",
		["AutoBarButtonCooldownStoneRejuvenation"] = "조각상 대기시간: 회복",
		["AutoBarButtonCrafting"] = "보석세공",
		["AutoBarButtonDebuff"] = "디버프",
		["AutoBarButtonElixirBattle"] = "전투 비약",
		["AutoBarButtonElixirGuardian"] = "강화 비약",
		["AutoBarButtonElixirBoth"] = "전투와 강화 비약",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "폭탄",
		["AutoBarButtonFishing"] = "낚시",
		["AutoBarButtonFood"] = "음식",
		["AutoBarButtonFoodBuff"] = "음식 버프",
		["AutoBarButtonFoodCombo"] = "음식 연계",
		["AutoBarButtonFoodPet"] = "소환수 음식",
		["AutoBarButtonFreeAction"] = "자유 행동",
		["AutoBarButtonHeal"] = "치유",
		["AutoBarButtonSpell1"] = "주문 1",
		["AutoBarButtonSpell2"] = "주문 2",
		["AutoBarButtonSpell3"] = "주문 3",
		["AutoBarButtonSpell4"] = "주문 4",
		["AutoBarButtonHearth"] = "귀환석",
		["AutoBarButtonPickLock"] = "자물쇠 따기",
		["AutoBarButtonMount"] = "탈것",
		["AutoBarButtonPets"] = "소환수들",
		["AutoBarButtonQuest"] = "퀘스트",
		["AutoBarButtonRecovery"] = "마나 / 분노 / 기력",
		["AutoBarButtonRotationDrums"] = "회전: 북소리",
		["AutoBarButtonSpeed"] = "속도",
		["AutoBarButtonStance"] = "태세",
		["AutoBarButtonStealth"] = "은신",
		["AutoBarButtonSting"] = "쐐기",
		["AutoBarButtonTotemEarth"] = "대지의 토템",
		["AutoBarButtonTotemAir"] = "바람의 토템",
		["AutoBarButtonTotemFire"] = "불의 토템",
		["AutoBarButtonTotemWater"] = "물의 토템",
		["AutoBarButtonTrack"] = "추적",
		["AutoBarButtonTrap"] = "덫",
		["AutoBarButtonTrinket1"] = "장신구 1",
		["AutoBarButtonTrinket2"] = "장신구 2",
		["AutoBarButtonWarlockStones"] = "흑마법사 석 창조",
		["AutoBarButtonWater"] = "음료수",
		["AutoBarButtonWaterBuff"] = "음료 버프",

		["AutoBarButtonBear"] = "곰",
		["AutoBarButtonBoomkinTree"] = "생명의 나무 / 달빛야수",
		["AutoBarButtonCat"] = "표범",
		["AutoBarButtonPowerShift"] = "PowerShift",
		["AutoBarButtonTravel"] = "치타",
		["AutoBarButtonFlight"] = "폭풍까마귀",
		["AutoBarButtonNormal"] = "보통",

		-- AutoBarClassButton.lua
		["Num Pad "] = "숫자패드 ",
		["Mouse Button "] = "마우스 버튼 ",
		["Middle Mouse"] = KEY_BUTTON3,
		["Backspace"] = KEY_BACKSPACE,
		["Spacebar"] = KEY_SPACE,
		["Delete"] = KEY_DELETE,
		["Home"] = KEY_HOME,
		["End"] = KEY_END,
		["Insert"] = KEY_INSERT,
		["Page Up"] = KEY_PAGEUP,
		["Page Down"] = KEY_PAGEDOWN,
		["Down Arrow"] = KEY_DOWN,
		["Up Arrow"] = KEY_UP,
		["Left Arrow"] = KEY_LEFT,
		["Right Arrow"] = KEY_RIGHT,
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
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
		["EMPTY"] = "빈창";
		["Default"] = "Default",
		["Zoomed"] = "Zoomed",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "우 클릭시 자신에게 시전 안함";
		["AUTOBAR_CONFIG_REMOVECAT"] = "현재 카테고리 삭제";
		["Columns"] = "컬럼";
		["AUTOBAR_CONFIG_GAPPING"] = "아이콘 간격";
		["AUTOBAR_CONFIG_ALPHA"] = "아이콘 투명도";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "버튼 높이 및 너비\n동시 변경 해제";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "카테고리 아이콘 표시";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Shift 키 팝업";
		["Rearrange Order on Use"] = "사용 순서 재배치";
		["Rearrange Order on Use for %s"] = "%s|1을;를; 위해 사용 순서를 재배치합니다.";
		["Right Click Targets Pet"] = "우 클릭시 대상의 소환수";
		["None"] = "없음";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 바";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "메인 메뉴";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "대화 창";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "대화 창 메뉴";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "액션 바";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "메뉴 버튼";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(찾을수 없음 : 아이템 ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " 배치 (편집 클릭)";
		["AUTOBAR_CONFIG_CHARACTER"] = "캐릭터";
		["Shared"] = "공유";
		["Account"] = "계정";
		["Class"] = "직업";
		["AUTOBAR_CONFIG_BASIC"] = "기본";
		["AUTOBAR_CONFIG_USECHARACTER"] = "캐릭터 배치 사용";
		["AUTOBAR_CONFIG_USESHARED"] = "공유 배치 사용";
		["AUTOBAR_CONFIG_USECLASS"] = "직업 배치 사용";
		["AUTOBAR_CONFIG_USEBASIC"] = "기본 배치 사용";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "설정 툴팁 숨김";
		["AUTOBAR_CONFIG_OSKIN"] = "oSkin 사용";
		["Log Events"] = "이벤트 기록";
		["Log Performance"] = "기록 실행";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "캐릭터 배치";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "공유 배치";
		["AUTOBAR_CONFIG_SHARED1"] = "공유 1";
		["AUTOBAR_CONFIG_SHARED2"] = "공유 2";
		["AUTOBAR_CONFIG_SHARED3"] = "공유 3";
		["AUTOBAR_CONFIG_SHARED4"] = "공유 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "캐릭터 배치 편집";
		["AUTOBAR_CONFIG_EDITSHARED"] = "공유 배치 편집";
		["AUTOBAR_CONFIG_EDITCLASS"] = "직업 배치 편집";
		["AUTOBAR_CONFIG_EDITBASIC"] = "기본 배치 편집";
		["Share the config"] = "설정 공유";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "폭죽",
		["Tradeskill.Tool.Fishing.Lure"] = "낚시 미끼",
		["Tradeskill.Tool.Fishing.Gear"] = "낚시 기어",
		["Tradeskill.Tool.Fishing.Other"] = "낚시 물건",
		["Tradeskill.Tool.Fishing.Tool"] = "낚싯대",

		["Consumable.Food.Bonus"] = "음식: 모든 증가 음식";
		["Consumable.Food.Buff.Strength"] = "음식: 힘 증가";
		["Consumable.Food.Buff.Agility"] = "음식: 민첩 증가";
		["Consumable.Food.Buff.Attack Power"] = "음식: 전투력 증가";
		["Consumable.Food.Buff.Healing"] = "음식: 치유량 증가";
		["Consumable.Food.Buff.Spell Damage"] = "음식: 주문 피해 증가";
		["Consumable.Food.Buff.Stamina"] = "음식: 생명력 증가";
		["Consumable.Food.Buff.Intellect"] = "음식: 지능 증가";
		["Consumable.Food.Buff.Spirit"] = "음식: 정신력 증가";
		["Consumable.Food.Buff.Mana Regen"] = "음식: 마나 회복 증가 ";
		["Consumable.Food.Buff.HP Regen"] = "음식: 생명력 회복 증가";
		["Consumable.Food.Buff.Other"] = "음식: 기타";

		["Consumable.Buff.Health"] = "버프: 생명력";
		["Consumable.Buff.Armor"] = "버프: 방어";
		["Consumable.Buff.Regen Health"] = "버프: 생명력 회복";
		["Consumable.Buff.Agility"] = "버프: 민첩성";
		["Consumable.Buff.Intellect"] = "버프: 지능";
		["Consumable.Buff.Protection"] = "버프: 보호";
		["Consumable.Buff.Spirit"] = "버프: 정신력";
		["Consumable.Buff.Stamina"] = "버프: 체력";
		["Consumable.Buff.Strength"] = "버프: 힘";
		["Consumable.Buff.Attack Power"] = "버프: 전투력";
		["Consumable.Buff.Attack Speed"] = "버프: 공격 속도";
		["Consumable.Buff.Dodge"] = "버프: 회피";
		["Consumable.Buff.Resistance"] = "버프: 저항";

		["Consumable.Buff Group.General.Self"] = "버프: 일반";
		["Consumable.Buff Group.General.Target"] = "버프: 일반 대상";
		["Consumable.Buff Group.Caster.Self"] = "버프: 시전자";
		["Consumable.Buff Group.Caster.Target"] = "버프: 시전자 대상";
		["Consumable.Buff Group.Melee.Self"] = "버프: 근접";
		["Consumable.Buff Group.Melee.Target"] = "버프: 근접 대상";
		["Consumable.Buff.Other.Self"] = "버프: 기타";
		["Consumable.Buff.Other.Target"] = "버프: 기타 대상";
		["Consumable.Buff.Chest"] = "버프: 가슴";
		["Consumable.Buff.Shield"] = "버프: 방패";
		["Consumable.Weapon Buff"] = "버프: 무기";

		["Misc.Usable.BossItem"] = "우두머리 아이템";
		["Misc.Usable.Permanent"] = "계속 사용 가능한 아이템";
		["Misc.Usable.Quest"] = "사용 가능한 퀘스트 아이템";
		["Misc.Usable.Replenished"] = "보충된 아이템";

		["Consumable.Cooldown.Potion.Health.Basic"] = "치유 물약";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "치유 물약: 칼날 산맥";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "치유 물약: 갈퀴송곳니 저수지";
		["Consumable.Cooldown.Potion.Health.PvP"] = "치유 물약: 전장";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "치유 물약: 폭풍우 요새";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "마나 물약";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "마나 물약: 칼날 산맥";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "마나 물약: 갈퀴송곳니 저수지";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "마나 물약: 전장";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "마나 물약: 폭풍우 요새";

		["Consumable.Weapon Buff.Poison.Crippling"] = "신경 마비 독";
		["Consumable.Weapon Buff.Poison.Deadly"] = "맹독";
		["Consumable.Weapon Buff.Poison.Instant"] = "순간 효과 독";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "정신 마비 독";
		["Consumable.Weapon Buff.Poison.Wound"] = "상처 감염 독";
		["Consumable.Weapon Buff.Oil.Mana"] = "마나 오일";
		["Consumable.Weapon Buff.Oil.Wizard"] = "마술사 오일";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "숫돌";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "무게추";

		["Consumable.Bandage.Basic"] = "붕대";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "알터랙 계곡 붕대";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "전쟁노래 협곡 붕대";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "아라시 분지 붕대";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "음식: 증가 없음";
		["Consumable.Food.Percent.Basic"] = "음식: % 생명력 회복";
		["Consumable.Food.Percent.Bonus"] = "음식: % 생명력 회복 (버프)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "음식: 생명력 & 마나 회복, 비-창조";
		["Consumable.Food.Edible.Combo.Conjured"] = "음식: 생명력 & 마나 회복, 창조";
		["Consumable.Food.Combo Percent"] = "음식: % 생명력 & 마나 회복";
		["Consumable.Food.Combo Health"] = "음식 & 음료 동시";
		["Consumable.Food.Edible.Bread.Conjured"] = "음식: 마법사 창조";
		["Consumable.Food.Conjure"] = "음식 창조";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "음식: 아라시 분지";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "음식: 전쟁노래 협곡";

		["Consumable.Food.Pet.Bread"] = "음식: 소환수 빵";
		["Consumable.Food.Pet.Cheese"] = "음식: 소환수 치즈";
		["Consumable.Food.Pet.Fish"] = "음식: 소환수 물고기";
		["Consumable.Food.Pet.Fruit"] = "음식: 소환수 과일";
		["Consumable.Food.Pet.Fungus"] = "음식: 소환수 버섯";
		["Consumable.Food.Pet.Meat"] = "음식: 소환수 고기";

		["Consumable.Buff Pet"] = "버프: 소환수";

		["Custom"] = "사용자";
		["Misc.Minipet.Normal"] = "소환수";
		["Misc.Minipet.Snowball"] = "축제 소환수";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "운고르 : 회복의 수정";

		["Consumable.Anti-Venom"] = "해독제";

		["Consumable.Warlock.Firestone"] = "화염석";
		["Consumable.Warlock.Soulstone"] = "영혼석";
		["Consumable.Warlock.Spellstone"] = "주문석";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "생명석";
		["Spell.Warlock.Create Firestone"] = "화염석 창조";
		["Spell.Warlock.Create Healthstone"] = "생명석 창조";
		["Spell.Warlock.Create Soulstone"] = "영혼석 창조";
		["Spell.Warlock.Create Spellstone"] = "주문석 창조";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "마나석";
		["Spell.Mage.Conjure Mana Stone"] = "마나석 창조";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "숙면의 물약";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "회복 물약";
		["Consumable.Cooldown.Stone.Health.Statue"] = "돌 조각상";
		["Consumable.Cooldown.Drums"] = "대기시간: 북소리";
		["Consumable.Cooldown.Potion"] = "대기시간: 물약";
		["Consumable.Cooldown.Potion.Combat"] = "대기시간: 물약 - 전투";
		["Consumable.Cooldown.Stone.Combat"] = "대기시간: 석 - 전투";
		["Consumable.Cooldown.Stone"] = "대기시간: 석";
		["Consumable.Leatherworking.Drums"] = "북소리";
		["Consumable.Tailor.Net"] = "그물";

		["Misc.Battle Standard.Battleground"] = "전투 깃발";
		["Misc.Battle Standard.Alterac Valley"] = "알터랙 계곡 전투 깃발";
		["Consumable.Cooldown.Stone.Health.Other"] = "치유 아이템: 기타";
		["Consumable.Cooldown.Stone.Mana.Other"] = "어둠/악마의 룬";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "비전 보호 물약";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "화염 보호 물약";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "냉기 보호 물약";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "자연 보호 물약";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "암흑 보호 물약";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "주문 보호 물약 ";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "신성 보호 물약";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "제한된 무적 물약";
		["Consumable.Buff.Free Action"] = "버프: 자유 행동";

		["Misc.Lockboxes"] = LOCKED;
		["Gear.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aura"] = "오라 / 상";
		["Spell.Buff.Weapon"] = "버프 주문: 무기";
		["Spell.Class.Buff"] = "직업 버프";
		["Spell.Class.Pet"] = "직업 소환수";
		["Spell.Crafting"] = "보석세공";
		["Spell.Debuff.Multiple"] = "디버프: 다양";
		["Spell.Debuff.Single"] = "디버프: 싱글";
		["Spell.Fishing"] = "낚시";
		["Spell.Portals"] = "차원문과 순간이동";
		["Spell.Sting"] = "쐐기";
		["Spell.Stance"] = "태세";
		["Spell.Totem.Earth"] = "대지력 토템";
		["Spell.Totem.Air"] = "바람의 토템";
		["Spell.Totem.Fire"] = "불의 토템";
		["Spell.Totem.Water"] = "물의 토템";
		["Spell.Seal"] = "문장";
		["Spell.Track"] = "추적";
		["Spell.Trap"] = "덫";
		["Misc.Hearth"] = "귀환석";
		["Misc.Booze"] = "술";
		["Consumable.Water.Basic"] = "음료";
		["Consumable.Water.Percentage"] = "음료: % 마나 회복";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "음료: 마법사 창조";
		["Consumable.Water.Conjure"] = "음료 창조";
		["Consumable.Water.Buff.Spirit"] = "음료: 정신력 증가";
		["Consumable.Water.Buff"] = "음료: 보너스";
		["Consumable.Buff.Rage"] = "분노의 물약";
		["Consumable.Buff.Energy"] = "기력의 물약";
		["Consumable.Buff.Speed"] = "버프: 신속의 물약";
		["Consumable.Buff Type.Battle"] = "버프: 전투 비약";
		["Consumable.Buff Type.Guardian"] = "버프: 강화 비약";
		["Consumable.Buff Type.Flask"] = "버프: 영약";
		["AUTOBAR_CLASS_SOULSHARDS"] = "영혼석";
		["Misc.Reagent.Ammo.Arrow"] = "화살";
		["Misc.Reagent.Ammo.Bullet"] = "탄환";
		["Misc.Reagent.Ammo.Thrown"] = "투척 무기류";
		["Misc.Explosives"] = "폭발물";
		["Misc.Mount.Normal"] = "탈것";
		["Misc.Mount.Summoned"] = "탈것: 소환";
		["Misc.Mount.Ahn'Qiraj"] = "탈것: 안퀴라즈";
		["Misc.Mount.Flying"] = "탈것: 비행";
	}

--AUTOBAR_CHAT_MESSAGE1 = "이 캐릭터에 대한 전 버전의 설정값이 있습니다. 삭제하십시오. 설정 업데이트를 시도하지 않고 있습니다.";
--
----  AutoBar_Config.xml
--AUTOBAR_CONFIG_TAB_BAR = "바";
--AUTOBAR_CONFIG_TAB_POPUP = "팝업";
--AUTOBAR_CONFIG_TAB_PROFILE = "프로파일";
--AUTOBAR_CONFIG_TAB_KEYS = "단축키";

--AUTOBAR_TOOLTIP1 = " (갯수: ";
--AUTOBAR_TOOLTIP2 = " [사용자 아이템]";
--AUTOBAR_TOOLTIP6 = " [제한된 사용]";
--AUTOBAR_TOOLTIP7 = " [재사용]";
AUTOBAR_TOOLTIP8 = "\n(주 무기에 적용 좌 클릭\n보조 무기에 적용 우 클릭)";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "변경은 현재 캐릭터만 영향을 줍니다.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "변경은 모든 캐릭터에 영향을 줍니다.";
--AUTOBAR_CONFIG_SETUPSINGLE = "싱글 구성";
--AUTOBAR_CONFIG_SETUPSHARED = "공유 구성";
--AUTOBAR_CONFIG_SETUPSTANDARD = "표준 구성";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "빈 슬레이트";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "표준 오토바와 비슷한 하나의 캐릭터 설정들을 위해 클릭하세요.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "공유되는 설정들을 위해 클릭하세요.\n공유되는 계층들 뿐만 아니라 특정 캐릭터를 가능하게 합니다.";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "모든 계층들의 편집과 사용을 가능하게 합니다.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "모든 캐릭터를 없애고 슬롯들을 공유합니다.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "싱글 캐릭터를 기본값으로 초기화 하려면 클릭하세요.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "공유되는 캐릭터를 기본값으로 초기화 하려면 클릭하세요.\n직업 특정의 슬롯이 캐릭터 계층으로 복사해 집니다.\n기본 슬롯이 공유되는 계층으로 복사해 집니다.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "표준을 기본값으로 초기화 하려면 클릭하세요.\n직업 특정의 슬롯들은 직업 계층 안에 있습니다.\n기본 슬롯들은 기초적인 계층 안에 있습니다.\n공유 그리고 캐릭터 계층들을 비우게 됩니다.";

--  AutoBar_Config.lua
--AUTOBAR_TOOLTIP15 = "\n무기 대상\n(좌시 클릭 주무기\n우 클릭시 보조무기)";
AUTOBAR_TOOLTIP17 = "\n비전투시만";
AUTOBAR_TOOLTIP18 = "\n전투시만";
--AUTOBAR_TOOLTIP21 = "체력 회복 요구";
--AUTOBAR_TOOLTIP22 = "마나 회복 요구";

end