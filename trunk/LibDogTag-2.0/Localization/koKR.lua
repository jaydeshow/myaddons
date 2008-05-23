﻿local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

if GetLocale() == "koKR" then
	local L = _G.DogTag__L
	
	L["DogTag Help"] = "DogTag 도움말"
	-- races
	L["Blood Elf"] = "블러드 엘프"
	L["Draenei"] = "드레나이"
	L["Dwarf"] = "드워프"
	L["Gnome"] = "노움"
	L["Human"] = "인간"
	L["Night Elf"] = "나이트 엘프"
	L["Orc"] = "오크"
	L["Tauren"] = "타우렌"
	L["Troll"] = "트롤"
	L["Undead"] = "언데드"
	
	-- short races
	L["Blood Elf_short"] = "블엘"
	L["Draenei_short"] = "드레"
	L["Dwarf_short"] = "드웝"
	L["Gnome_short"] = "놈"
	L["Human_short"] = "인간"
	L["Night Elf_short"] = "나엘"
	L["Orc_short"] = "오크"
	L["Tauren_short"] = "타렌"
	L["Troll_short"] = "트롤"
	L["Undead_short"] = "언데"

	-- classes
	L["Warrior"] = "전사"
	L["Priest"] = "사제"
	L["Mage"] = "마법사"
	L["Shaman"] = "주술사"
	L["Paladin"] = "성기사"
	L["Warlock"] = "흑마법사"
	L["Druid"] = "드루이드"
	L["Rogue"] = "도적"
	L["Hunter"] = "사냥꾼"

	-- short classes
	L["Warrior_short"] = "전"
	L["Priest_short"] = "사"
	L["Mage_short"] = "마"
	L["Shaman_short"] = "주"
	L["Paladin_short"] = "성"
	L["Warlock_short"] = "흑"
	L["Druid_short"] = "드"
	L["Rogue_short"] = "도"
	L["Hunter_short"] = "냥"

	L["Player"] = "플레이어"
	L["Target"] = "대상"
	L["Pet"] = "소환수"
	L["Focus-target"] = "주시 대상"
	L["Mouse-over"] = "마우스-오버"
	L["%s's pet"] = "%s의 소환수"
	L["%s's target"] = "%s의 대상"
	L["Party member #%d"] = "파티원 #%d"
	L["Raid member #%d"] = "공격대원 #%d"

	-- classifications
	L["Rare"] = "희귀"
	L["Rare-Elite"] = "희귀" .. "-" .. ELITE
	L["Elite"] = "정예"
	L["Boss"] = "보스"
	
	-- short classifications
	L["Rare_short"] = "희"
	L["Rare-Elite_short"] = "희+"
	L["Elite_short"] = "+"
	L["Boss_short"] = "보"

	L["Curse"] = "저주"
	L["Disease"] = "질병"
	L["Divine Intervention"] = "성스러운 중재"
	L["Feigned Death"] = "죽은척하기" -- must match aura
	L["Holy Light"] = "성스러운 빛"
	L["Ice Block"] = "얼음 방패"
	L["Invisibility"] = "투명화"
	L["Last Stand"] = "최후의 저항"
	L["Magic"] = "마법"
	L["Misdirection"] = "눈속임"
	L["Poison"] = "독"
	L["Shadowform"] = "어둠의 형상"
	L["Shield Wall"] = "방패의 벽"
	L["Stealthed"] = "은신중"
	L["Soulstoned"] = "영혼석 보관"

	L["Dead"] = "죽음"
	L["Ghost"] = "유령"
	L["Offline"] = "오프중"
	L["Online"] = "접속중"
	L["Combat"] = "전투중"
	L["Resting"] = "휴식중"
	L["Tapped"] = "선점"
	L["AFK"] = "자리비움"
	L["DND"] = "다른용무중"

	L["True"] = "True"

	L["Rage"] = "분노"
	L["Focus"] = "주시"
	L["Energy"] = "기력"
	L["Mana"] = "마나"
	
	L["PvP"] = "전쟁" -- PVP,
	L["FFA"] = "전투 지역"
	
	L["Grommash"] = "그롬마쉬"
	L["Thrall"] = "스랄"
	L["My Little Pwnies"] = "My Little Pwnies"
	L["Banker"] = "은행원"
	
	L["Alliance"] = "얼라이언스"
	L["Aldor"] = "알도르 사제회"
	
	L["Exodar"] = "엑소다르"
	L["Shattrath"] = "샤트라스"

	-- genders
	L["Male"] = "남자"
	L["Female"] = "여자"
	
	-- guildRank
	L["Guild Leader"] = "길드관리자"
	L["Initiate"] = "신입길드원"
	
	-- forms
	L["Bear"] = "곰"
	L["Cat"] = "표범"
	L["Moonkin"] = "달빛야수"
	L["Aquatic"] = "바다표범"
	L["Flight"] = "폭풍까마귀"
	L["Travel"] = "치타"
	L["Tree"] = "나무"

	L["Bear_short"] = "곰"
	L["Cat_short"] = "표범"
	L["Moonkin_short"] = "달빛"
	L["Aquatic_short"] = "바표"
	L["Flight_short"] = "폭까"
	L["Travel_short"] = "치타"
	L["Tree_short"] = "나무"
	
	-- type
	L["Humanoid"] = "인간형"
	L["Beast"] = "야수"

	-- shortgenders
	L["Male_short"] = "남"
	L["Female_short"] = "여"
	
	L["Leader"] = "지휘관"

	-- spell trees
	L["Hybrid"] = "혼성" -- for all 3 trees
	L["Druid_Tree_1"] = "조화"
	L["Druid_Tree_2"] = "야성"
	L["Druid_Tree_3"] = "회복"
	L["Hunter_Tree_1"] = "야수"
	L["Hunter_Tree_2"] = "사격"
	L["Hunter_Tree_3"] = "생존"
	L["Mage_Tree_1"] = "비전"
	L["Mage_Tree_2"] = "화염"
	L["Mage_Tree_3"] = "냉기"
	L["Paladin_Tree_1"] = "신성"
	L["Paladin_Tree_2"] = "보호"
	L["Paladin_Tree_3"] = "징벌"
	L["Priest_Tree_1"] = "수양"
	L["Priest_Tree_2"] = "신성"
	L["Priest_Tree_3"] = "암흑"
	L["Rogue_Tree_1"] = "암살"
	L["Rogue_Tree_2"] = "전투"
	L["Rogue_Tree_3"] = "잠행"
	L["Shaman_Tree_1"] = "정기"
	L["Shaman_Tree_2"] = "고양"
	L["Shaman_Tree_3"] = "복원"
	L["Warrior_Tree_1"] = "무기"
	L["Warrior_Tree_2"] = "분노"
	L["Warrior_Tree_3"] = "방어"
	L["Warlock_Tree_1"] = "고통"
	L["Warlock_Tree_2"] = "악마"
	L["Warlock_Tree_3"] = "파괴"
	
	--Modules's category,doc
	
	L["Syntax"] = "구문-체계"
	L["Tags"] = "태그"
	L["Examples"] = "예제"
	L["Modifiers"] = "활용-변경"
	L["alias for "] = "형식: "
	L["e.g. "] = "예제: "
		
	--Abbrev
	L["Abbreviations"] = "줄임말"
	L["Turn value into its shortened class equivalent"] = "단축된 같은 뜻의 직업 value으로 바꿉니다"
	L["Turn value into its shortened racial equivalent"] = "단축된 같은 뜻의 종족 value으로 바꿉니다"
	L["Turn value into its shortened druid form equivalent"] = "단축된 같은 뜻의 드루이드 폼 value으로 바꿉니다"
	L["Abbreviate value if a space is found"] = "띄워쓰기가 있는 경우엔 value으로 줄여집니다"
		
	--AddonVersion
	L["Miscellaneous"] = "기타"
	L["Return the version of the unit's argument addon if possible"] = "가능한 경우 unit의 argument 애드온의 버전을 가져옵니다"
	
	--Auras
	L["Auras"] = "오라"
	L["Return the shapeshift form the unit is in if unit is a druid"] = "unit이 드루이드일 경우에는 변신중이면 폼 형태로 가져옵니다"
	L["Return the shortened shapeshift form the unit is in if unit is a druid"] = "unit이 드루이드일 경우에는 변신중이면 폼의 줄임말을 가져옵니다"
	L["Return the total number of debuffs that unit has"] = "unit이 가진 디버프의 전체 number를 가져옵니다"
	L["Return the aura name if unit has the aura argument"] = "unit이 오라 argument를 가질 경우에는 오라 이름을 가져옵니다"
	L["Return the number of total aura charges of unit of aura argument"] = "unit에 오라 argument의 전체 중첩 수를 가져옵니다"
	L["Return the absolute time that aura argument will finish, or blank if no aura or time is not known"] = "오라가 없거나 시간을 모를 경우에는 공백으로, 오라 argument가 완료될 절대 시간을 가져옵니다"
	L["Return the time left in seconds that aura argument will finish"] = "오라 argument 가 완료될 시간을 초단위로 가져옵니다"
	L["Return Shadowform if the unit has the shadowform buff"] = "unit이 어둠의 형상 버프를 가질 경우에는 어둠의 형상을 가져옵니다"
	L["Return Feigned Death if unit is currently feigning death"] = "unit이 죽은척하기 상태일 경우에는 죽은척하기를 가져옵니다"
	L["Return Stealthed if the unit is stealthed in some way"] = "unit이 어떻게 해서든 은신중일 경우에는 은신중을 가져옵니다"
	L["Return Shield Wall if the unit has the Shield Wall buff"] = "unit이 방패의 벽 버프를 가질 경우에는 방패의 벽을 가져옵니다"
	L["Return Last Stand if the unit has the Last Stand buff"] = "unit이 최후의 저항 버프를 가질 경우에는 최후의 저항을 가져옵니다"
	L["Return Soulstoned if the unit has the Soulstone buff"] = "unit이 영혼석 보관 버프를 가질 경우에는 영혼석 보관을 가져옵니다"
	L["Return Misdirection if the unit has the Misdirection buff"] = "unit이 눈속임 버프를 가질 경우에는 눈속임을 가져옵니다"
	L["Return Ice Block if the unit has the Ice Block buff"] = "unit이 얼음 방패 버프를 가질 경우에는 얼음 방패를 가져옵니다"
	L["Return Invisibility if the unit has the Invisibility buff"] = "unit이 투명화 버프를 가질 경우에는 투명화를 가져옵니다"
	L["Return Divine Intervention if the unit has the Divine Intervention buff"] = "unit이 성스러운 중재 버프를 가질 경우에는 성스러운 중재를 가져옵니다"
	L["Return argument if friendly unit is has a debuff of argument type"] = "우호적인 unit이 argument 유형의 디버프를 가질 경우에는 argument를 가져옵니다"
	L["Return Magic if the unit has a Magic debuff"] = "unit이 마법 디버프를 가질 경우에는 마법을 가져옵니다"
	L["Return Curse if the unit has a Curse debuff"] = "unit이 저주 디버프를 가질 경우에는 저주를 가져옵니다"
	L["Return Poison if the unit has a Poison debuff"] = "unit이 독 디버프를 가질 경우에는 독을 가져옵니다"
	L["Return Disease if the unit has a Disease debuff"] = "unit이 질병 디버프를 가질 경우에는 질병을 가져옵니다"
	
	--Cast
	L["Casting"] = "시전"
	L["Return the current or last spell to be cast"] = "현재나 마지막 주문의 시전을 가져옵니다"
	L["Return the current cast target name"] = "현재 시전의 대상 이름을 가져옵니다"
	L["Return the current cast rank"] = "현재 시전 주문 레벨을 가져옵니다"
	L["Return the time the current cast started"] = "현재 시전의 시작한 시간을 가져옵니다"
	L["Return the time the current cast is meant to finish"] = "현재 시전의 끝내기 위한 시간을 가져옵니다"
	L["Return the number of seconds the current cast has been delayed by interruption"] = "현재 시전이 방해로 인하여 밀린 초의 number를 가져옵니다"
	L["Return True if the current cast is a channeling spell"] = "현재 시전이 정신집중(channeling) 주문인 경우에는 True로 가져옵니다"
	L["Return the time which the current cast stopped, blank if not stopped yet"] = "현재의 시전이 멈추지 않았다면 공백으로, 멈추었을 경우에 그 시간을 가져옵니다"
	L["Return the message as to why the cast stopped, if there is an error"] = "오류가 있는 경우에 무슨 이유로 시전이 멈추었는지 메세지를 가져옵니다"
	
	--Characteristics
	L["Characteristics"] = "특색"
	L["Return True if unit is a friend"] = "unit이 아군일 경우에는 True로 가져옵니다"
	L["Return True if unit is an enemy"] = "unit이 적군일 경우에는 True로 가져옵니다"
	L["Return True if unit can be attacked"] = "unit이 공격이 가능한 경우에는 True로 가져옵니다"
	L["Return the name of unit"] = "unit이 이름을 가져옵니다"
	L["Return True if unit exists"] = "unit이 접속해 있는 경우 True로 가져옵니다"
	L["Return the realm of unit if not your own realm"] = "자신의 서버가 아닌 경우에는 unit의 서버이름을 가져옵니다"
	L["Return the name of unit, appending unit's realm if different from yours"] = "unit의 이름, 당신과 서버가 다를경우 unit의 서버를 덧붙여서 가져옵니다"
	L["Return the level of unit"] = "unit의 레벨을 가져옵니다"
	L["Return %d if the level of unit is %d"] = "unit의 레벨이 %d인 경우에는 %d을 가져옵니다"
	L["Return the class of unit"] = "unit의 직업을 가져옵니다"
	L["Return the class of unit if unit is a player or enemy, but not a pet"] = "unit이 플레이어나 적군인 경우에 단, 소환수는 제외하고 unit의 직업을 가져옵니다"
	L["Return the class of unit if unit is a player"] = "unit이 플레이어인 경우에는 unit의 직업을 가져옵니다"
	L["Return the shortened class of unit"] = "unit의 직업 줄임말을 가져옵니다"
	L["Return the shortened class of unit if unit is a player or enemy, but not a pet"] = "unit이 플레이어나 적군인 경우에 단, 소환수는 제외하고 unit의 직업 줄임말을 가져옵니다"
	L["Return the shortened class of unit if unit is a player"] = "unit이 플레이어인 경우에는 unit의 직업 줄임말을 가져옵니다"
	L["Return the creature family or type of unit"] = "unit의 유형이나 생물의 종류를 가져옵니다"
	L["Return the creature type of unit"] = "unit의 생물 유형을 가져옵니다"
	L["Return the classification of unit"] = "unit의 등급을 가져옵니다"
	L["Return a shortened classification of unit"] = "unit의 등급 줄임말을 가져옵니다"
	L["Return the race of unit"] = "unit의 종족을 가져옵니다"
	L["Return the race if unit is player, otherwise the creature family"] = "unit이 플레이어인 경우는 종족을 그렇지 않으면 생물의 종류를 가져옵니다"
	L["Return the shortened race of unit"] = "unit의 종족 줄임말을 가져옵니다"
	L["Return + if the unit is elite"] = "unit이 정예일 경우에는 + 로 가져옵니다"
	L["Return Male, Female, or blank depending on unit"] = "unit에 따라서 남자, 여자, 또는 공백으로 가져옵니다"
	L["Return m, f, or blank depending on unit"] = "unit에 따라서 남, 여, 또는 공백으로 가져옵니다"
	L["Return the guild rank of unit"] = "unit의 길드 등급을 가져옵니다"
	L["Return True if unit is a player"] = "unit이 플레이어인 경우에는 True로 가져옵니다"
	L["Return True if unit is a player's pet"] = "unit이 플레이어의 소환수인 경우에는 True로 가져옵니다"
	L["Return True if unit is a player or a player's pet"] = "unit이 플레이어나 플레이어의 소환수인 경우에는 True로 가져옵니다"
	L["Return the PvP rank or wrap the PvP rank of unit around value"] = "unit의 전쟁 계급이나 호칭등을 가져옵니다"
	L["Return the color or wrap value with the hostility color of unit"] = "unit의 색상을 적대적 색상으로 입혀서 가져옵니다"
	L["Return the color or wrap value with the aggression color of unit"] = "unit의 색상을 중립적 색상으로 입혀서 가져옵니다"
	L["Return the color or wrap value with the class color of unit"] = "unit의 색상을 직업 색상으로 입혀서 가져옵니다"
	L["Return the color or wrap value with the difficulty color of unit's level compared to your own level"] = "unit의 레벨을 자신의 레벨보다 높을때 어려운 색상으로 입혀서 가져옵니다"
	
	--Compare
	L["Comparisons"] = "비교"
	L["Compare argument and value, hide if not equal"] = "value과 argument를 비교하여, 동등하지 않으면 숨깁니다"
	L["Compare argument and value, hide if argument isn't less than value"] = "value과 argument를 비교하여, value이 argument 보다 높은 경우에는 숨깁니다."
	L["Compare argument and value, hide if argument isn't less than or equal to value"] = "value과 argument를 비교하여, value이 argument 보다 높은 경우만 숨기고 동등시는 표시합니다"
	L["Compare argument and value, hide if argument isn't greater than value"] = "value과 argument를 비교하여, value이 인수argument 보다 낮은 경우에는 숨깁니다"
	L["Compare argument and value, hide if argument isn't greater than or equal value"] = "value과 argument를 비교하여, value이 argument 보다 낮은 경우만 숨기고 동등시는 표시합니다"
	L["Compare argument and value, hide if argument is equal to value"] = "value과 argument를 비교하여, 동등하면 숨깁니다"
	L["Compare argument and value, hide if argument is less than value"] = "value과 argument를 비교하여, value이 argument 보다 낮은 경우에는 숨깁니다"
	L["Compare argument and value, hide if argument is greater than value"] = "value과 argument를 비교하여, value이 argument 보다 높은 경우에는 숨깁니다"
	L["Compare argument and value, hide if argument is less than or equal to value"] = "value과 argument를 비교하여, 동등하거나 value이 argument 보다 낮은 경우에는 숨깁니다"
	L["Compare argument and value, hide if argument is greater than or equal to value"] = "value과 argument를 비교하여, 동등하거나 value이 argument 보다 높은 경우에는 숨깁니다"
	L["Compare argument and value, hide if argument is not equal to value"] = "value과 argument를 비교하여, value이 argument 보다 노은 경우만 숨기고 동등시는 표시합니다"
	L["Hide if value is equal to 0"] = "value이 0과 동등할 경우에는 숨깁니다"
	L["Check if value contains argument, hide if not contained"] = "value에 argument가 포함되었는지 확인하여, 포함되지 않은 경우에는 숨깁니다"
	L["Check if value contains argument, hide if contained"] = "value에 argument가 포함되었는지 확인하여, 포함된 경우에는 숨깁니다"
	
	--DruidMana
	L["Return the current mana of unit if unit is you and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 마나를 현재로 가져옵니다"
	L["Return the maximum mana of unit if unit is you and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 마나를 최대로 가져옵니다"
	L["Return the percentage mana of unit if unit is you and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 마나를 퍼센트로 가져옵니다"
	L["Return the missing mana of unit if unit is you and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 빠진 마나를 가져옵니다"
	L["Return the current and maximum mana of unit if unit is you and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 마나를 현재와 최대로 가져옵니다"
	L["Return the max mana of unit if at max mana, unit is you, and you are a druid"] = "unit이 자신이며 드루이드일때 unit의 마나를 최대로 가져옵니다"
	
	--Example
	L["Mathematics"] = "계산"
	L["Return the square of number_value"] = "number_value의 제곱을 가져옵니다"
	L["Return the cube of number_value"] = "number_value의 3제곱을 가져옵니다"
	L["Return the current mana/rage/energy of unit"] = "unit의 현재 마나/분노/기력을 가져옵니다"
	L["Return value multiplied by two if a number, otherwise concatenate with itself"] = "value이 number인 경우에는 2를 곱하거나, 그렇지 않으면 자체적으로 연결하여 가져옵니다"
	L["Return the color or wrap value with sage color"] = "현명하게 색상을 value에 입히거나 색상을 가져옵니다"
	L["Return the number of bananas of unit, if LibMonkey-1.0 is available"] = "LibMonkey-1.0를 이용할 수 있는 경우에는, unit의 bananas number를 가져옵니다"
	L["Return a random value between 1 and arg, updating every second"] = "매초마다 업데이트하는 1과 arg사이의 임의의 value을 가져옵니다"
	
	--Experience
	L["Experience"] = "경험치"
	L["Return the current experience of unit"] = "unit의 경험치를 현재로 가져옵니다"
	L["Return the maximum experience of unit"] = "unit의 경험치를 최대로 가져옵니다"
	L["Return the current and maximum experience of unit"] = "unit의 경험치를 현재와 최대로 가져옵니다"
	L["Return the percentage experience of unit"] = "unit의 경험치를 퍼센트로 가져옵니다"
	L["Return the missing experience of unit"] = "unit의 필요한 경험치를 가져옵니다"
	L["Return the accumulated rest experience of unit"] = "unit의 휴식으로 쌓인 경험치를 가져옵니다"
	L["Return the percentage accumulated rest experience of unit"] = "unit의 휴식으로 쌓인 경험치를 퍼센트로 가져옵니다"
	
	--GuildNote
	L["Return the guild note of unit, if unit is in your guild"] = "unit이 당신의 길드인 경우에는, unit의 길드 메모를 가져옵니다"
	L["Return the officer's guild note of unit, if unit is in your guild and you are an officer"] = "unit이 당신의 길드나 당신이 관리자인 경우에는, unit의 관리자 길드 메모를 가져옵니다"
	
	--Health
	L["Health"] = "체력"
	L["Return the current health of unit, will use MobHealth if found"] = "MobHealth를 찾아서 사용한다면, unit의 체력을 현재로 가져옵니다"
	L["Return the maximum health of unit, will use MobHealth if found"] = "MobHealth를 찾아서 사용한다면, unit의 체력을 최대로 가져옵니다"
	L["Return the percentage health of unit"] = "unit의 체력을 퍼센트로 가져옵니다"
	L["Return the missing health of unit, will use MobHealth if found"] = "MobHealth를 찾아서 사용한다면, unit의 빠진 체력을 가져옵니다"
	L["Return the current health and maximum health of unit, will use MobHealth if found"] = "MobHealth를 찾아서 사용한다면, unit의 체력을 현재와 최대로 가져옵니다"
	L["Return the current and maximum health of unit, but only if properly found through MobHealth"] = "MobHealth를 통해 정확히 찾아졌을때에만 unit의 체력을 현재와 최대로 가져옵니다"
	L["Return the current and maximum health of unit, but only if properly found through MobHealth, otherwise show the percentage health"] = "MobHealth를 통해 정확히 찾아졌을때에만 unit의 체력을 현재와 최대, 그렇지 않으면 체력을 퍼센트로 가져옵니다"
	L["Return True if unit is at full health"] = "unit의 체력이 가득차 있는 경우에는 True로 가져옵니다"
	L["Return the color or wrap value with the health color of unit"] = "unit의 체력 색상을 value에 입히거나 색상을 가져옵니다"
	
	--Math
	L["Turn positive number_value into negative or vice-versa"] = "정의된 number_value의 negative나 반대로 넘깁니다"
	L["Round number_value to the one's place or the place specified by number"] = "number_value의 Round로 number에 의해 지정되는 하나의 자리나 자리로 나타냅니다"
	L["Add number to number_value"] = "number_value에 number를 추가합니다"
	L["Subtract number from number_value"] = "number_value에서 number를 뺍니다"
	L["Multiply number_value by number"] = "number_value와 number를 곱합니다"
	L["Divide number_value by number"] = "number_value와 number를 나눕니다"
	L["Raise number_value to the power of number"] = "마력 number의 number_value을 제곱합니다"
	L["Return number_value modulo number"] = "모듈 number의 number_value를 가져옵니다"
	L["Take the floor of number_value"] = "number_value의 소수점은 제외합니다"
	L["Take the ceiling of number_value"] = "number_value의 소수점을 올림합니다"
	L["Take the absolute value of number_value"] = "number_value의 절대적 value을 합니다"
	L["Take the signum of number_value"] = "number_value에 signum 합니다"
	L["Return the greater of number_value and number"] = "number_value와 number중 큰 수를 가져옵니다"
	L["Return the lesser of number_value and number"] = "number_value와 number중 낮은 수를 가져옵니다"
	L["Return the mathematical number π, or %s"] = "%s 또는 number π 계산하여 가져옵니다"
	L["Convert the radian number_value into degrees"] = "number_value의 radian의 degrees을 변환합니다"
	L["Convert the degree number_value into radians"]= "number_value의 degrees의 radian을 변환합니다"
	L["Return the cosine of the radian number_value"]= "number_value의 radian에 cosine을 가져옵니다"
	L["Return the sine of the radian number_value"]= "number_value의 radian에 sine을 가져옵니다"
	L["Return the mathematical number e, or %s"] = "number 계산이나 %s를 가져옵니다"
	L["Return the natural log of number_value"] = "number_value의 natural log를 가져옵니다"
	L["Return the log base 10 of number_value"] = "number_value의 log base 10을 가져옵니다"
		
	--Misc
	L["Return True if the Alt key is held down"] = "Alt키를 누르고 있을때 True를 가져옵니다"
	L["Return True if the Shift key is held down"] = "Shift키를 누르고 있을때 True를 가져옵니다"
	L["Return True if the Ctrl key is held down"] = "Ctrl키를 누르고 있을때 True를 가져옵니다"
	L["Return the argument"] = "argument을 가져옵니다"
	L["Return the current time in seconds, specified by WoW's internal format"] = "WoW의 서버시간에 맞추어 현재 시간의 초를 가져옵니다"
	L["Set the transparency of the FontString according to argument"]= "argument에 따른 FontString을 투명도를 조정합니다"
	L["Return True if currently mousing over the Frame the FontString is harbored in"]= "Frame에 현재 마우스 오버할 경우  FontString을 True로 가져옵니다"
	L["Return the number of combo points you have"] = "당신이 가진 연계점수의 number를 가져옵니다"
	L["Return @ or argument repeated by the number of combo points you have"]= "@ 또는 argument에서 되풀이되는 당신이 가진 연계점수의 number를 가져옵니다"
	L["Return the color or wrap value with the rrggbb color of argument"]= "value에 argument의 rrggbb 을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with white color"] = "value에 흰색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with red color"] = "value에 붉은색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with green color"] = "value에 초록색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with blue color"] = "value에 파란색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with cyan color"] = "value에 청록색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with fuchsia color"] = "value에 자주색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with yellow color"] = "value에 노란색을 입힌 색상이나 색상을 가져옵니다"
	L["Return the color or wrap value with gray color"] = "value에 회색을 입힌 색상이나 색상을 가져옵니다"
		
	--Power
	L["Power"] = "마력"
	L["Return the maximum mana/rage/energy of unit"] = "unit의 마나/분노/기력을 최대로 가져옵니다"
	L["Return the percentage mana/rage/energy of unit"] = "unit의 마나/분노/기력을 퍼센트로 가져옵니다"
	L["Return the missing mana/rage/energy of unit"] = "unit의 빠진 마나/분노/기력을 가져옵니다"
	L["Return the current and maximum mana/rage/energy of unit"] = "unit의 마나/분노/기력을 현재와 최대로 가져옵니다"
	L["Return whether unit currently uses Rage, Focus, Energy, or Mana"] = "unit이 사용하는 현재의 분노, 집중, 기력, 또는 마나에 맞춰서 가져옵니다"
	L["Return True if unit currently uses the power of argument"] = "unit의 현재 사용하는 마력의 argument를 True로 가져옵니다"
	L["Return True if unit currently uses rage"] = "unit의 현재 사용하는 분노를 True로 가져옵니다"
	L["Return True if unit currently uses focus"] = "unit의 현재 사용하는 집중을 True로 가져옵니다"
	L["Return True if unit currently uses energy"] = "unit의 현재 사용하는 기력을 True로 가져옵니다"
	L["Return True if unit currently uses mana"] = "unit의 현재 사용하는 마나를 True로 가져옵니다"
	L["Return True if unit is at full rage/mana/energy"] = "unit의 현재 가득찬 분노/마나/기력을 True로 가져옵니다"
	L["Return True if unit has no power type at all"] = "unit의 현재 마력이 없거나 가진 모든 타입을 True로 가져옵니다"
	L["Return the color or wrap value with current power color of unit, whether rage, mana, or energy"] = "unit이 마력색상을 사용하는 현재의 분노, 집중, 기력, 또는 마나에 맞춰서 색상을 입혀서 가져옵니다"
	
	--Range
	L["Status"] = "상태"
	L["Return the approximate range of unit, if RangeCheck-1.0 is available"] = "RangeCheck-1.0를 이용할 수 있는 경우에는, unit의 대략의 거리를 가져옵니다"
	L["Return the approximate minimum range of unit, if RangeCheck-1.0 is available"] = "RangeCheck-1.0를 이용할 수 있는 경우에는, unit의 대략의 최하 거리를 가져옵니다"
	L["Return the approximate maximum range of unit, if RangeCheck-1.0 is available"] = "RangeCheck-1.0를 이용할 수 있는 경우에는, unit의 대략의 최대 거리를 가져옵니다"
	
	--Reputation
	L["Reputation"] = "평판"
	L["Return the color or wrap value with the color associated with either the currently watched faction or the given argument"] = "argument를 가지거나 value에 현재 선택한 진영에 따른 색상을 입히거나 색상을 가져옵니다"
	L["Return the current reputation of the watched faction or argument"] = "argument 또는 선택한 진영의 평판을 현재로 가져옵니다"
	L["Return the maximum reputation of the currently watched faction or argument"] = "argument 또는 선택한 진영의 평판을 최대로 가져옵니다"
	L["Return the current and maximum reputation of the currently watched faction or argument"] = "argument 또는 선택한 진영의 평판을 현재와 최대로 가져옵니다"
	L["Return the percentage reputation of the currently watched faction or argument"] = "argument 또는 선택한 진영의 평판을 퍼센트로 가져옵니다"
	L["Return the missing reputation of the currently watched faction or argument"] = "argument 또는 선택한 진영의 필요한 평판을 가져옵니다"
	L["Return the name of the currently watched faction"] = "현재 선택한 진영의 이름을 가져옵니다"
	L["Return your current reputation rank with the watched faction or argument"] = "argument 또는 선택한 진영의 평판 관계를 가져옵니다"
	
	--Status
	L["Return whether unit is offline, has divine intervention, is dead, feigning death, or has a soulstone while dead"] = "unit이 죽었을때 영혼석 보관을 가지고 있거나 성스러운 중재, 죽음, 죽은척하기, 오프라인등을 가져옵니다"
	L["Return the time offline if unit is offline"] = "unit이 오프라인 경우에는 오프라인 시간을 가져옵니다"
	L["Return Offline and the time offline if unit is offline"] = "unit이 오프라인 경우에는 오프라인과 오프라인 시간을 가져옵니다"
	L["Return the time dead if unit is dead and time is known, unit can be dead and have an unknown time of death"] = "unit이 죽은 시간을 알수없을때는 unknown으로, unit의 죽음과 그시간을 알고 있을때는 죽은 시간을 가져옵니다"
	L["Return Dead or Ghost if unit is dead"] = "unit이 죽은 경우에는 죽음 또는 유령을 가져옵니다"
	L["Return Dead or Ghost and the time dead if unit is dead"] = "unit이 죽은 경우에는 죽음 또는 유령, 죽은 시간을 가져옵니다"
	L["Return the time AFK if unit is AFK"] = "unit이 자리비움 경우에는 자리비움 시간을 가져옵니다"
	L["Return AFK and the time AFK if unit is AFK"] = "unit이 자리비움 경우에는 자리비움과 자리비움 시간을 가져옵니다"
	L["Return DND if the unit has specified DND"] = "unit이 다른용무중 경우에는 다른용무중을 가져옵니다"
	L["Return PvP or FFA if the unit is PvP-enabled"] = "unit이 전투활성화일 경우에는 전쟁 또는 전투지역을 가져옵니다"
	L["Return Resting if you are in an inn or capital city"] = "당신이 대도시에 있을 경우에는 휴식중을 가져옵니다"
	L["Return Leader if unit is a party leader"] = "unit이 파티 지휘관일 경우에는 지휘관을 가져옵니다"
	L["Return the happiness number of your pet"] = "소환수의 만족도 number를 가져옵니다"
	L["Return a description of how happy your pet is"] = "소환수의 만족도의 상태를 가져옵니다"
	L["Return an icon representative of how happy your pet is"] = "소환수의 만족도의 상태를 아이콘으로 가져옵니다"
	L["Return * if unit is tapped by you"] = "unit이 당신의 선점일 경우에는 *를 가져옵니다"
	L["Return * if unit is tapped, but not by you"] = "unit이 당신의 선점이 아닐 경우에는 *를 가져옵니다"
	L["Return True if unit is in combat"] = "unit이 전투중이면 True를 가져옵니다"
	L["Return the function key to press to select unit"] = "unit을 선택하는 단축키를 가져옵니다"
	L["Return the raid group that unit is in"] = "unit이 속한 공격대 그룹번호를 가져옵니다"
	L["Return True if unit is the master looter for your raid"] = "공격대의 전리품 담당자를 True로 가져옵니다"
	L["Return the name of unit's target"] = "unit의 대상 이름을 가져옵니다"
	L["Return the name of unit's target's target"] = "unit의 대상의 대상 이름을 가져옵니다"
	L["Return the number of group members currently targeting unit"] = "현재 대상지정중인 그룹 멤버의 number를 가져옵니다"
	L["Return an alphabetized, comma-separated list of group members currently targeting unit"] = "현재 대상지정중인 그룹 멤버의 리스트를 콤마로 해서 알파벳순으로 가져옵니다"
	L["Return True if you are in a party or raid"] = "당신이 파티나 공격대에 있을 경우에는 True로 가져옵니다"
	L["Return True if unit is the same as argument"] = "unit이 동일한 argument일 경우에는 True로 가져옵니다"
	L["Return True if unit is under mind control"] = "unit이 정신 지배중인 경우에는 True로 가져옵니다"
	L["Return the color or wrap value with the color associated with unit's current status"] = "unit의 현재 상태에 따른 색상을 입힌 value 색상을 가져옵니다"
	L["Return the color or wrap value with the color associated with your pet's happiness"] = "소환수의 만족도에 따른 색상을 입힌 value 색상을 가져옵니다"
	L["Return the color or wrap value with red if unit is in combat, otherwise no color"] = "unit의 전투 상태에 따른 색상을 입힌 value 색상이나 아닐경우는 색상을 없게해서 가져옵니다"
	L["Return True if unit is in visible range"] = "unit이 시야에 보이는 거리일 경우에는 True로 가져옵니다"
	
	--Talent
	L["Return the talent spec of unit if available"] = "unit이 시야에 보일 경우에는 특성을 수치로 가져옵니다"
	L["Return the talent tree of unit if available"] = "unit이 시야에 보일 경우에는 특성을 글자로 가져옵니다"
	
	--TextManip
	L["Text manipulation"] = "텍스트 조작"
	L["Prepend argument to the beginning of value"] = "value의 다음에 오는 argument를 선첨부합니다"
	L["Append argument to the end of value"] = "value의 끝에 argument를 덧붙입니다"
	L["Append a percentage sign to the end of number_value"] = "number_value의 끝에 퍼센트 기호를 덧붙입니다"
	L["Shorten value to have at maximum 3 decimal places showing"] = "value을 소수를 포함한 최대 3자리 보여지게 자릅니다"
	L["Shorten value to its closest denomination"] = "value을 근접한 단위로 자릅니다"
	L["Turn value into an uppercase string"] = "value을 대문자로 넘깁니다"
	L["Turn value into a lowercase string"] = "value을 소문자로 넘깁니다"
	L["Wrap value with square brackets"] = "value에 각괄호를 입힙니다"
	L["Wrap value with angle brackets"] = "value에 꺾음 괄호를 입힙니다"
	L["Wrap value with braces"] = "value에 중괄호를 입힙니다"
	L["Wrap value with parentheses"] = "value에 괄호를 입힙니다"
	L["Truncate value to the length specified by number"] = "value에 number의 길이 조건으로 자릅니다"
	L["Truncate value to the length specified by number and add ellipsis to the end if actually truncated"] = "value에 number의 길이 조건으로 잘라서 마지막에 해당되는부분을 생략합니다"
	L["Repeat value number times"] = "value에 number 만큼 반복합니다"
	L["Return the length of value"] = "value의 길이를 가져옵니다"
	L["Turn number_value into a roman numeral."] = "number_value를 로마 숫자로 넘깁니다"
	
	--Threat
	L["Threat"] = "위협"
	L["Return the current threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"] = ""
	L["Return the maximum threat that group members have against enemy unit or that group members have against your target, if ThreatLib is available"] = ""
	L["Return the percentage threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"] = ""
	L["Return the missing threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"] = ""
	L["Return the current and maximum threat that you have against enemy unit or that friendly unit has against your target, if ThreatLib is available"] = ""
	L["Return True if you have no threat against enemy unit, friendly unit has no threat against your target, or if ThreatLib is unavailable"] = ""
	
	--TooltipScanning
	L["Return the guild name or title of unit"] = "unit의 호칭이나 길드 이름을 가져옵니다"
	L["Return the owner of unit, if a pet"] = "소환수일 경우에는 unit의 주인을 가져옵니다"
	L["Return the faction of unit"] = "unit의 진영을 가져옵니다"
	L["Return the zone of unit"] = "unit의 지역을 가져옵니다"
end

end