local L = AceLibrary("AceLocale-2.2"):new("FuBar_WhisperFu")

L:RegisterTranslations("koKR", function() return {
	["On"] = "켬",
	["Off"] = "끔",
	["Spam Blocker:"] = "스팸 블로커:",
	["Blocked Messages:"] = "차단된 메세지:",

	["Whisper"] = "귓속말",

	["Options"] = "설정",
	["Colours"] = "색상",
	["Set the Text Colours"] = "텍스트 색상을 설정합니다",

	["Send Colour"] = "보낸 귓속말 색상",
	["Sets the color of text for whispers sent"] = "보낸 귓속말의 색상을 설정합니다",

	["Receive Colour"] = "받은 귓속말 색상",
	["Sets the color of text for whispers receieved"] = "받은 귓속말의 색상을 설정합니다",

	["HintText"] = "|cffeda55f클릭|r : 귓속말 보내기.\n|cffeda55fALT-클릭|r : 파티 초대.\n|cffeda55fSHIFT-클릭|r : 정보 보기.\n|cffeda55fCTRL-클릭|r : 모든 귓속말 삭제.",
	["PlayerDesc"] = "%s님과 보낸/받은 귓속말 ",
	["WhisperDesc"] = "%s님과 귓속말 시작",

	["Purge"] = "모든 귓속말 대화 삭제",
	["PurgeDesc"] = "저장되어 있는 모든 귓속말을 삭제합니다",

	["Player Limit"] = "인원수 제한",
	["Maximum number of players to store messages for."] = "저장할 플레이어의 인원수의 최대값을 설정합니다.",

	["Message Limit"] = "메세지 제한",
	["Maximum number of messages to store per player."] = "플레이어당 저장된 메세지의 최대값을 설정합니다.",

	["Wrap Length"] = "길이 줄임",
	["Wrap messages longer than this number of characters."] = "문자의 길이가 해당 숫자 이상이면 메세지를 줄입니다.",

	["Show Times"] = "시간 표시",
	["Show time of whispers in tooltip."] = "툴팁에 귓속말을 한 시간을 표시합니다.",

	["Show Menu Times"] = "메뉴 시간 표시",
	["Show time of whispers in menus."] = "메뉴에 귓속말의 시간을 표시합니다.",

	["Play Whisper Sound"] = "귓속말 효과음 재생",
	["Play a sound each time you receive a message."] = "메세지를 받으면 효과음을 재생합니다.",

	["Show Hint"] = "도움말 표시",
	["Show hint at the bottom of the tooltip."] = "툴팁 하단에 도움말을 표시합니다.",

	--["Spam"] = true,
	--["Spam Settings"] = true,

	["Spam"] = "스팸",
	["View blocked spam messages."] = "차단된 스팸 메세지를 표시합니다.",

	["Spam Options"] = "스팸 설정",
	["Spam blocking options."] = "스팸 차단 설정.",

	["-Report this user-"] = "-해당 사용자 보고-",
	["Report this user as a spammer and attempt to get justice for their griefing!"] = "Report this user as a spammer and attempt to get justice for their griefing!",
	["Are you sure you want to report %s?"] = "정말로 %s|1을;를; 보고하시겠습니까?",

	[" was not found."] = " 찾을 수 없습니다.",
	["I am reporting the user %s for attempting to sell me gold or leveling service for real money.  The following are messages captured, quoting the user's violation of WoW TOS:\n\n"] = "I am reporting the user %s for attempting to sell me gold or leveling service for real money.  The following are messages captured, quoting the user's violation of WoW TOS:\n\n",
	["You already have a GM ticket open."] = "당신은 이미 GM 대기표를 받았습니다.",

	["Block Spam"] = "스팸 차단",
	["Block incoming spam messages."] = "받은 스팸 메세지를 차단합니다.",

	["Play Spam Sound"] = "스팸 효과음 재생",
	["Play a sound each time WhisperFu catches a spam message."] = "WhisperFu가 스팸 메세지를 잡았을 때 효과음을 재생합니다.",

	["Show Spams This Session"] = "이번 접속의 스팸 표시",
	["Shows a counter in the addon title for spams blocked this session."] = "이번 접속의 차단된 스팸에 대한 애드온 제목에 카운터를 표시합니다.",

	["Reset Spam Tally"] = "스팸 부호 초기화",
	["Resets intercepted spam tally to 0.\nCurrent tally is %d."] = "차단한 스팸 부호를 0으로 초기화 합니다.\n현재 부호는 %d 입니다.",

	["Delete Spam Log"] = "스팸 로그 삭제",
	["Deletes all of your spam messages"] = "당신의 모든 스팸 메세지를 삭제합니다.",
	["Spam Log has been cleared."] = "스팸 로그가 삭제되었습니다.",

	["Keyword Options"] = "키워드 설정",

	["Add Keyword"] = "키워드 추가",
	["Add a new keyword to ignore."] = "제외할 새로운 키워드를 추가합니다.",
	[" already exists."] = " 이미 존재합니다.",

	["Add Keyword Group"] = "키워드 그룹 추가",
	["Add a new keyword group to ignore.\nEx: To ignore any messages with the words: \"join\" and \"guild\" you would enter: \"join^guild^\""] = "제외할 새로운 키워드를 추가합니다.\n예: \"join\" 과 \"guild\"가 포함된 모든 메세지를 제외하기 위해서는 다음과 같이 입력하세요: \"join^guild^\"",
	["Enter a keyword group to ignore"] = "제외할 키워드 그룹을 입력하세요.",
	["word1^word2^etc^"] = "단어1^단어2^등등^",
	["That intelligent key group already exists"] = "그 키워드 그룹은 이미 존재합니다.",
    
	["Found an old spam message, spam log is being reset to update to new system."] = "이전 스팸 메세지를 발견 했습니다, 새로운 시스템으로 갱신하기 위해 스팸 로그를 초기화합니다.",
	["Generating GM ticket for: "] = "Generating GM ticket for: ",

	["Reinstate Keyword Defaults"] = "기본 키워드 복원",
	["This will reinstate the default keywords while keeping any you've added intact."] = "이것은 당신이 추가한 키워드를 손상시키지 않으면서 기본 키워드를 복원합니다.",

	["Reinstate Keyword Group Defaults"] = "기본 키워드 그룹 복원",
	["This will reinstate the default keyword groups while keeping any you've added intact."] = "이것은 당신이 추가한 키워드를 손상시키지 않으면서 기본 키워드 그룹을 복원합니다.",

	["Remove Keyword(s)"] = "키워드(들) 제거",
	["Click a keyword to remove it from the spam list.\nCurrent keyword total: %s"] = "스팸 목록에서 키워드를 제거하려면 클릭하세요.\n현재 총 키워드: %s",

	["Remove Keyword Group"] = "키워드 그룹 제거",
	["Click a keyword group to remove it from the spam list.\nCurrent keyword group total: %s"] = "스팸 목록에서 키워드 그룹을 제거하려면 클릭하세요.\n현재 총 키워드 그룹: %s",

	["Remove keyword: "] = "키워드 제거: ",
	["Remove keyword group: "] = "키워드 그룹 제거: ",

	["Enter a keyword to ignore"] = "제외할 키워드를 입력하세요.",
	["New Keyword"] = "새로운 키워드",
	["Please enter a valid keyword"] = "허용된 키워드를 입력하세요.",

	["Delete All Spam Key Groups"] = "모든 스팸 키 그룹 삭제",
	["|cffff3333!This will purge all spam key groups!|r\nYou should not do this unless you are planning on reinstating keyword group defaults afterwards."] = "|cffff3333!모든 스팸키 그룹을 삭제합니다!|r\nYou should not do this unless you are planning on reinstating keyword group defaults afterwards.",
	["Are you sure you want to purge all of your keywords?"] = "정말로 당신의 키워드를 모두 삭제하시겠습니까?",

	["Delete All Spam Keys"] = "모든 스팸 키 삭제",
	["|cffff3333!This will purge all spam keys!|r\nYou should not do this unless you are planning on reinstating keyword defaults afterwards."] = "|cffff3333!모든 스팸키를 삭제합니다!|r\nYou should not do this unless you are planning on reinstating keyword defaults afterwards.",
	["Are you sure you want to purge all of your keyword groups?"] = "정말로 당신의 키워드 그룹을 모두 삭제하시겠습니까?"
} end)
