local L = AceLibrary("AceLocale-2.2"):new("FuBar_GuildFu")

L:RegisterTranslations("koKR", function() return {
	["Group"] = "그룹",
	["Name"] = "이름",
	["Class"] = "직업",
	["Level"] = "레벨",
	["Zone"] = "지역",
	["Notes"] = "쪽지",
	["Rank"] = "등급",
	["Show"] = "표시",
	["Align"] = "정렬",
	["Color"] = "색상",
	["None"] = "없음",
	["Left"] = "좌",
	["Center"] = "중앙",
	["Right"] = "우",
	["No Guild"] = "길드 없음",
	["Updating..."] = "업데이트중...",
	["You aren't in a guild."] = "길드에 속해있지 않습니다.",
	["All guild mates offline or filtered."] = "오프라인이거나 필터링되는 길드원",
	["Text"] = "텍스트",
	["Text Settings"] = "텍스트 설정",
	["Show Guild Name"] = "길드이름 표시",
	["Toggles display of the guild name"] = "길드 이름 표시를 토글합니다",
	["Show Displayed"] = "표시 설정",
	["Toggles display of number of unfiltered guildmates"] = "필터링되지 않는 길드원의 수의 표시를 토글합니다.",
	["Show Online"] = "온라인 길드원 표시",
	["Toggles display of number of online guildmates"] = "온라인 길드원의 수의 표시를 토글합니다",
	["Show Total"] = "총길드원 표시",
	["Toggles display of number of total guildmates"] = "총 길드원의 수의 표시를 토글합니다",
	["Tooltip"] = "툴팁",
	["Tooltip Settings"] = "툴팁 설정",
	["MOTD"] = "오늘의 길드 메세지",
	["MOTD Settings"] = "길드 메세지 설정",
	["Toggles display of guild MOTD"] = "오늘의 길드 메세지 표시를 토글합니다",
	["Sort"] = "정렬",
	["Sets sorting"] = "정렬 설정",
	["Group Indicator Settings"] = "그룹 구분자 설정",
	["Toggles display of group indicators"] = "그룹 구분자 표시를 토글합니다",
	["Name Column Settings"] = "이름란 설정",
	["Sets color of name column"] = "이름란의 색상을 설정합니다",
	["Status"] = "상태",
	["Toggles display of status"] = "상태 표시를 토글합니다",
	["Class Column Settings"] = "직업란 설정",
	["Toggles display of class column"] = "직업란의 표시를 토글합니다",
	["Sets alignment of class column"] = "직업란의 정렬을 설정합니다",
	["Level Column Settings"] = "레벨란 설정",
	["Toggles display of level column"] = "레벨란의 표시를 토글합니다",
	["Sets alignment of level column"] = "레벨란의 정렬을 설정합니다",
	["Sets color of level column"] = "레벨란의 색상을 설정합니다",
	["Relative"] = "우호도",
	["Zone Column Settings"] = "지역란 설정",
	["Toggles display of zone column"] = "지역란의 표시를 토글합니다",
	["Sets alignment of zone column"] = "지역란의 정렬을 설정합니다",
	["Sets color of zone column"] = "지역란의 색상을 설정합니다",
	["Faction"] = "진영",
	["Notes Column Settings"] = "쪽지란 설정",
	["Show Public"] = "쪽지 표시",
	["Toggles diplay of public notes"] = "쪽지 표시를 토글합니다",
	["Show Officer"] = "관리자 쪽지 표시",
	["Toggles display of officer notes"] = "관리자 쪽지의 표시를 토글합니다",
	["Show AuldLangSyne"] = "AuldLangSyne 표시",
	["Toggles display of AuldLangSyne notes"] = "AuldLangSyne 쪽지의 표시를 토글합니다",
	["Show CT_PlayerNotes"] = "CT_PlayerNotes 표시",
	["Toggles display of CT_PlayerNotes notes"] = "CT_PlayerNotes 쪽지의 표시를 토글합니다",
	["Sets alignment of notes column"] = "쪽지란의 정렬을 설정합니다",
	["Rank Column Settings"] = "등급란 설정",
	["Toggles display of rank column"] = "등급란의 표시를 토글합니다",
	["Sets alignment of rank column"] = "등급란의 정렬을 설정합니다",
	["Filter"] = "필터",
	["Filter Settings"] = "필터 설정",
	["Class Filter Settings"] = "직업별 필터 설정",
	["Druid"] = "드루이드",
	["Toggles display of Druids"] = "드루이드의 표시를 토글합니다",
	["Hunter"] = "사냥꾼",
	["Toggles display of Hunters"] = "사냥꾼의 표시를 토글합니다",
	["Mage"] = "마법사",
	["Toggles display of Mages"] = "마법사의 표시를 토글합니다",
	["Paladin"] = "성기사",
	["Toggles display of Paladins"] = "성기사의 표시를 토글합니다",
	["Priest"] = "사제",
	["Toggles display of Priests"] = "사제의 표시를 토글합니다",
	["Rogue"] = "도적",
	["Toggles display of Rogues"] = "도적의 표시를 토글합니다",
	["Shaman"] = "주술사",
	["Toggles display of Shamans"] = "주술사의 표시를 토글합니다",
	["Warlock"] = "흑마법사",
	["Toggles display of Warlocks"] = "흑마법사의 표시를 토글합니다",
	["Warrior"] = "전사",
	["Toggles display of Warriors"] = "전사의 표시를 토글합니다",
	["Level Filter Settings"] = "레벨별 필터 설정",
	["Toggles display of level 1 to 9 chars"] = "1-9레벨 사이의 캐릭터의 표시를 토글합니다",
	["Toggles display of level 10 to 19 chars"] = "10-19레벨 사이의 캐릭터의 표시를 토글합니다",
	["Toggles display of level 20 to 29 chars"] = "20-29레벨 사이의 캐릭터의 표시를 토글합니다",
	["Toggles display of level 30 to 39 chars"] = "30-39레벨 사이의 캐릭터의 표시를 토글합니다",
	["Toggles display of level 40 to 49 chars"] = "40-49레벨 사이의 캐릭터의 표시를 토글합니다",
	["Toggles display of level 50 to 59 chars"] = "50-59레벨 사이의 캐릭터의 표시를  토글합니다",
	["Toggles display of level 60 to 69 chars"] = "60-69레벨 사이의 캐릭터의 표시를  토글합니다",
	["Toggles display of level 70 chars"] = "70레벨 캐릭터의 표시를 토글합니다",
	["Zone Filter Settings"] = "지역 필터 설정",
	["In Battleground"] = "전장",
	["Toggles display of chars in battlegrounds"] = "전장에 있는 캐릭터의 표시를 토글합니다",
	["In Instance"] = "인스턴스 던전",
	["Toggles display of chars in instances"] = "인스턴스 던전에 있는 캐릭터의 표시를 토글합니다",
	["In Open Field"] = "야외",
	["Toggles display of chars in open field"] = "야외에 있는 캐릭터의 표시를 토글합니다",
} end)