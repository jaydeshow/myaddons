local L = AceLibrary("AceLocale-2.2"):new("beql")
L:RegisterTranslations("koKR", function() return{

	["Bayi's Extended Quest Log"] = "Bayi의 Extended Quest Log",
	["No Objectives!"] = "수행 목표 없음!",
	["(Done)"] = "(완료)",
	["Click to open Quest Log"] = "클릭시 퀘스트 목록을 엽니다",
	["Completed!"] = "완료!",
	[" |cffff0000Disabled by|r"] = " |cffff0000사용 불가|r",
	["Reload UI ?"] = "UI를 다시 불러오시겠습니까 ?",	
	["FubarPlugin Config"] = "Fubar 플러그인 설정",
	["Requires Interface Reload"] = "UI 리로드 필요",		
	
	["Quest Log Options"] = "퀘스트 목록 설정",
	["Options related to the Quest Log"] = "퀘스트 목록에 관련된 설정을 변경합니다",
	["Lock Quest Log"] = "퀘스트 목록창 고정",
	["Makes the quest log unmovable"] = "퀘스트 목록창의 위치를 고정합니다",
	["Always Open Minimized"] = "항상 최소화하여 열기",	
	["Force the quest log to open minimized"] = "퀘스트 목록창을 항상 최소화하여 엽니다",
	["Always Open Maximized"] = "항상 최대화하여 열기",
	["Force the quest log to open maximized"] = "퀘스트 목록창을 항상 최대화하여 엽니다",
	["Show Quest Level"] = "퀘스트 레벨 보기",
	["Shows the quests level"] = "퀘스트 레벨을 표시합니다",
	["Info on Quest Completion"] = "퀘스트 완료 알림",
	["Shows a message and plays a sound when you complete a quest"] = "퀘스트 완료시 소리를 재생하고 메세지를 표시합니다",
	["Auto Complete Quest"] = "자동 퀘스트 완료",
	["Automatically Complete Quests"] = "자동으로 퀘스트를 완료합니다",	
	["Mob Tooltip Quest Info"] = "몹 툴팁 퀘스트 정보 표시",
	["Show quest info in mob tooltips"] = "몹의 툴팁에 퀘스트 정보를 표시합니다",
	["Item Tooltip Quest Info"] = "아이템 툴팁 퀘스트 정보 표시",
	["Show quest info in item tooltips"] = "아이템 툴팁에 퀘스트 정보를 표시합니다",
	["Simple Quest Log"] = "간단한 퀘스트 창",
	["Uses the default Blizzard Quest Log"] = "Blizzard 기본 퀘스트 창을 사용합니다",	
	["Quest Log Alpha"] = "퀘스트 창 투명도",
	["Sets the Alpha of the Quest Log"] = "퀘스트 창의 투명도를 설정합니다",

	["Quest Tracker"] = "퀘스트 알리미",
	["Quest Tracker Options"] = "퀘스트 알리미 설정",
	["Options related to the Quest Tracker"] = "퀘스트 알리미와 관련된 설정을 변경합니다",
	["Lock Tracker"] = "퀘스트 알리미 고정",
	["Makes the quest tracker unmovable"] = "퀘스트 알리미의 위치를 고정합니다",	
	["Show Tracker Header"] = "퀘스트 알리미 제목 보기",
	["Shows the trackers header"] = "퀘스트 알리미의 제목을 표시합니다",
	["Hide Completed Objectives"] = "완료된 목표 숨김",
	["Automatical hide completed objectives in tracker"] = "완료된 목표는 퀘스트 알리미에서 숨깁니다",	
	["Remove Completed Quests"] = "완료된 퀘스트 삭제",
	["Automatical remove completed quests from tracker"] = "완료된 퀘스트는 퀘스트 알리미에서 삭제합니다",	
	["Font Size"] = "폰트 크기",
	["Changes the font size of the tracker"] = "퀘스트 알리미의 폰트 크기를 변경합니다",
	["Sort Tracker Quests"] = "퀘스트 알리미 정렬",
	["Sort the quests in tracker"] = "퀘스트 알리미에서 퀘스트 정렬을 사용합니다",	
	["Show Quest Zones"] = "퀘스트 지역 보기",
	["Show the quests zone it belongs to above its name"] = "퀘스트 이름 상단에 퀘스트 지역을 표시합니다",
	["Add New Quests"] = "신규 퀘스트 추가",
	["Automatical add new Quests to tracker"] = "퀘스트 수락시 자동으로 퀘스트 알리미에 퀘스트를 추가합니다",
	["Add Untracked"] = "퀘스트 변동 시 추가",
	["Automatical add quests with updated objectives to tracker"] = "퀘스트 진행에 변동이 있을 경우 퀘스트를 퀘스트 알리미에 추가합니다",	
	["Reset tracker position"] = "퀘스트 알리미 위치 초기화",
	["Active Tracker"] = "동적 퀘스트 알리미",
	["Showing on mouseover tooltips, clicking opens the tracker, rightclicking removes the quest from tracker"] = "마우스 오버시 툴팁을 표시하며, 클릭시 퀘스트창을 엽니다. 우클릭시 퀘스트를 퀘스트 알리미에서 제거합니다",	
	["Hide Objectives for Completed only"] = "완료된 목표만 숨김",
	["Hide objectives only for completed quests"] = "완료된 퀘스트의 목표만 숨깁니다",	
	
	["Markers"] = "목차",
	["Customize the Objective/Quest Markers"] = "퀘스트와 목표의 목차에 대한 설정을 변경합니다",
	["Show Objective Markers"] = "퀘스트 목표 목차 표시",
	["Display Markers before objectives"] = "퀘스트 목표 앞에 목차를 표시합니다",
	["Use Listing"] = "순서 목차 사용",
	["User Listing rather than symbols"] = "문자형 목차 대신에 순서 목차를 사용합니다",
	["List Type"] = "순서 목차 형식",
	["Set the type of listing"] = "사용할 순서 목차를 변경합니다",
	["Symbol Type"] = "문자 목차 형식",
	["Set the type of symbol"] = "사용할 문자 목차를 변경합니다",

	["Colors"] = "색상",
	["Set tracker Colors"] = "퀘스트 알리미의 색상을 설정합니다",
	["Background"] = "배경",
	["Use Background"] = "배경 색상을 사용합니다",
	["Custom Background Color"] = "배경 색상 설정",
	["Use custom color for background"] = "퀘스트 알리미의 배경에 색상을 사용합니다",
	["Background Color"] = "배경 색상",
	["Sets the Background Color"] = "배경 색상을 선택합니다",
	["Background Corner Color"] = "배경 외곽선 색상",
	["Sets the Background Corner Color"] = "퀘스트 알리미의 배경 외곽선 색상을 선택합니다",	
	["Use Quest Level Colors"] = "퀘스트 레벨별 색상 사용",
	["Use the colors to indicate quest difficulty"] = "퀘스트 난이도에 따른 색상값을 사용합니다",	
	["Custom Zone Color"] = "지역 색상 설정",
	["Use custom color for Zone names"] = "지역명에 사용자 지정 색상을 사용합니다",
	["Zone Color"] = "지역 색상",
	["Sets the zone color"] = "지역명 색상을 설정합니다",	
	["Fade Colors"] = "점층 색상",
	["Fade the objective colors"] = "퀘스트 완료 목표에 점층 색상 기능을 사용합니다",
	["Custom Objective Color"] = "퀘스트 목표 색상 설정",
	["Use custom color for objective text"] = "퀘스트 목표에 사용자 지정 색상을 사용합니다",	
	["Objective Color"] = "퀘스트 목표 색상",
	["Sets the color for objectives"] = "퀘스트 목표 색상을 선택합니다",	
	["Completed Objective Color"] = "완료된 퀘스트 목표",
	["Sets the color for completed objectives"] = "완료된 퀘스트 목표에 대한 색상을 설정합니다",	
	["Custom Header Color"] = "퀘스트 이름 사용자 색상",
	["Use custom color for headers"] = "퀘스트 이름에 사용자 지정 색상을 사용합니다",
	["Completed Header Color"] = "완료된 퀘스트 이름 색상",
	["Sets the color for completed headers"] = "완료된 퀘스트 이름에 대한 색상을 선택합니다",
	["Failed Header Color"] = "실패한 퀘스트 색상",
	["Sets the color for failed quests"] = "실패한 퀘스트 이름에 대한 색상을 선택합니다",
	["Header Color"] = "퀘스트 이름 색상",
	["Sets the color for headers"] = "퀘스트 이름에 대한 색상을 선택합니다",
	["Disable Tracker"] = "퀘스트 알리미 사용안함",
	["Disable the Tracker"] = "퀘스트 알리미를 사용하지 않습니다",
	["Quest Tracker Alpha"] = "퀘스트 알리미 투명도",
	["Sets the Alpha of the Quest Tracker"] = "퀘스트 알리미의 투명도를 설정합니다",
	["Auto Resize Tracker"] = "퀘스트 알리미 크기 자동 조정",
	["Automatical resizes the tracker depending on the lenght of the text in it"] = "문자열의 길이에 따라서 퀘스트 알리미의 크기를 자동 조정합니다",
	["Fixed Tracker Width"] = "고정 너비 사용",
	["Sets the fixed width of the tracker if auto resize is disabled"] = "퀘스트 알리미의 너비를 자동 조정하지 않고 고정된 크기로 설정합니다",		

	["Pick Locale"] = "언어 선택",
	["Change Locale (needs Interface Reload)"] = "지역화 파일 변경 (UI를 다시 불러와야 합니다)",
	
	["|cffffffffQuests|r"] = "|cffffffff퀘스트|r",
	["|cffff8000Tracked Quests|r"] = "|cffff8000확인중인 퀘스트|r",
	["|cff00d000Completed Quests|r"] = "|cff00d000완료된 퀘스트|r",
	["|cffeda55fClick|r to open Quest Log and |cffeda55fShift+Click|r to open Waterfall config"] = "|cffeda55f클릭|r시 퀘스트창을 열기 |cffeda55fShift 클릭|r시 Waterfall 설정창 열기",

	["Tooltip"] = "툴팁",
	["Tooltip Options"] = "툴팁 설정",
	["Tracker Tooltip"] = "퀘스트 알리미 툴팁",
	["Showing mouseover tooltips in tracker"] = "퀘스트 알리미에 마우스를 올려 놓으면 툴팁을 표시합니다",
	["Quest Description in Tracker Tooltip"] = "퀘스트 알리미 툴팁에 퀘스트 설명 표시",
	["Displays the actual quest's description in the tracker tooltip"] = "퀘스트 알리미 툴팁에 실제 퀘스트 설명을 표시합니다",
	["Party Quest Progression info"] = "파티 퀘스트 진행 정보",
	["Displays Party members quest status in the tooltip - Quixote must be installed on the partymembers client"] = "파티원의 퀘스트 상태를 툴팁에 표시합니다 - 파티원이 Quixote 라이브러리를 설치하고 있어야 합니다",
	["Enable Left Click"] = "좌클릭 사용",
	["Left clicking a quest in the tracker opens the Quest Log"] = "퀘스트 알리미를 좌클릭 했을 때 퀘스트창을 엽니다",
	["Enable Right Click"] = "우클릭 사용",
	["Right clicking a quest in the tracker removes it from the tracker"] = "퀘스트 알리미를 우클릭 했을 때 퀘스트 알리미에서 퀘스트를 삭제합니다",
	["Quest Log Scale"] = "퀘스트창 크기",
	["Sets the Scale of the Quest Log"] = "퀘스트창의 크기를 설정합니다",
	["Force Tracker Unlock"] = "퀘스트 알리미 이동 활성화",
	["Make the Tracker movable even with CTMod loaded. Please check your CTMod config before using it"] = "CTMod가 사용중일 때에도 퀘스트 알리미를 움직일 수 있습니다. 사용 전에 CTMod 설정을 확인하세요",
	["Quest Progression to Party Chat"] = "퀘스트 진행상황 파티에 알림",
	["Prints the Quest Progression Status to the Party Chat"] = "파티 대화로 퀘스트 진행상황을 알려줍니다",	
	["Completion Sound"] = "완료시 재생음",
	["Select the sound to be played when a quest is completed"] = "퀘스트 완료시 재생할 소리를 선택합니다",
	
	["Quest Description Color"] = "퀘스트 상세 설명 색상",
	["Sets the color for the Quest description"] = "퀘스트의 상세 설명에 대한 색상을 설정합니다",
	["Party Member Color"] = "파티원 색상",
	["Party Member with Quixote Color"] = "Quixote 색상에 따른 파티원 색상",
	["Sets the color for Party member"] = "파티원의 색상을 설정합니다",	
} end )

if GetLocale() == "koKR" then

BEQL_COMPLETE = "%(완료%)"
BEQL_QUEST_ACCEPTED = "퀘스트를 수락했습니다:"

end