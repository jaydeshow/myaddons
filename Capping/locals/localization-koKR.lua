if GetLocale() ~= "koKR" then return end

--- ko translations initially provided by McKabi
CappingLocale:CreateLocaleTable({
	-- battlegrounds
	["Alterac Valley"] = "알터랙 계곡",
	["Arathi Basin"] = "아라시 분지",
	["Warsong Gulch"] = "전쟁노래 협곡",
	["Arena"] = "투기장",
	["Eye of the Storm"] = "폭풍의 눈",

	-- factions
	["Alliance"] = "얼라이언스",
	["Horde"] = "호드",

	-- options menu
	["Auto quest turnins"] = "퀘스트 자동 반납",
	["Bar"] = "막대",
	["Width"] = "너비",
	["Height"] = "높이",
	["Texture"] = "텍스처",
	["Other"] = "그 밖에",
	["Other options"] = "그 밖에 설정",
	["Auto show map"] = "자동으로 지도 보이기",
	["Map scale"] = "지도 크기",
	["Hide border"] = "테두리 숨기기",
	["Port Timer"] = "입장 시간",
	["Wait Timer"] = "대기 시간",
	["Show/Hide Anchor"] = "표식 보이기/감추기",
	["Narrow map mode"] = "좁은 지도 표시",
	["Test"] = "시험",
	["Flip growth"] = "막대 위로 쌓기",
	["Reposition Scoreboard"] = "점수판 위치 바꾸기",
	["Battlefield Minimap"] = "전장 작은 지도",
	["Icons"] = "아이콘",
	["Spacing"] = "간격",
	["Request sync"] = "동기화 요청",
	["LEFT"] = "우측",
	["RIGHT"] = "좌측",
	["HIDE"] = "숨김",
	["Fill grow"] = "성장방향 채우기",
	["Fill right"] = "우측부터 채우기",
	["Font"] = "글꼴",
	["Time position"] = "시간 위치",
	["Border width"] = "테두리 너비",
	["Send to BG"] = "전장 대화 출력",
	["Or <Ctrl-left-click> a timer"] = "또는, 타이머 <Ctrl-좌-클릭>",
	["Send to SAY"] = "일반 대화 출력",
	["Or <Shift-left-click> a timer"] = "또는, 타이머 <Shift-좌-클릭>",
	["Cancel timer"] = "시간 취소",
	["Or <Ctrl-right-click> a timer"] = "또는, 타이머 <Ctrl-우-클릭>",
	["Reposition Capture Bar"] = "점령시간 바",

	-- etc timers
	["Port: %s"] = "입장: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "대기: %s",
	["Battleground Begins"] = "전투 개시", -- bar text for bg gates opening (why can't they all be the same?)
	["2 minutes"] = "2분",
	["1 minute"] = "1분",
	["30 seconds"] = "30초",
	["One minute until"] = "1분 전",
	["Thirty seconds until"] = "30초 전",
	["Fifteen seconds until"] = "15초 전",
	["%s: %s - %d:%02d remaining"] = "%s: %s - %d:%02d 남았음", -- chat message after shift left-clicking a bar

	-- AB
	["Bases: (%d+)  Resources: (%d+)/2000"] = "거점: (%d+)  자원: (%d+)/2000", -- arathi basin scoreboard
	["Farm"] = "농장",
	["Lumber Mill"] = "제재소",
	["Blacksmith"] = "대장간",
	["Mine"] = "금광",
	["Stables"] = "마구간",
	["has assaulted"] = "공격했습니다",
	["claims the"] = "넘어갈 것입니다",
	["has taken the"] = "점령했습니다",
	["has defended the"] = "방어했습니다",
	["Final: 2000 - %d"] = "종료: 2000 - %d", -- final score text
	["wins 2000-%d"] = "승리 2000-%d", -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = "([^ ]*)|1이;가; ([^!]*) 깃발을 손에 넣었습니다!",
	["dropped"] = "([^ ]*)|1이;가; ([^!]*) 깃발을 떨어뜨렸습니다!",
	["captured the"] = "([^ ]*)|1이;가; ([^!]*) 깃발 쟁탈에 성공했습니다!",
	["Flag respawns"] = "새 깃발 생성",
	["%s's flag carrier: %s (%s)"] = "%s 깃발 운반자: %s (%s)", -- chat message

	-- AV
	 -- NPC
	["Smith Regzar"] = "대장장이 렉자르",
	["Murgot Deepforge"] = "멀고트 딥포지",
	["Primalist Thurloga"] = "원시술사 투를로가",
	["Arch Druid Renferal"] = "대드루이드 렌퍼럴",
	["Stormpike Ram Rider Commander"] = "스톰파이크 산양기병대 지휘관",
	["Frostwolf Wolf Rider Commander"] = "서리늑대 늑대기병대 지휘관",

	 -- patterns
	["avunderattack"] = "(.+)... 공격받고 있습니다! 저지하지 않으면",
	["avtaken"] = "가 (.+)... 점령했습니다!",
	["avdestroyed"] = "가 (.+)... 파괴했습니다!",
	["Snowfall Graveyard"] = "눈사태 무덤",
	["Tower"] = "보초탑",
	["Bunker"] = "참호",
	["Upgrade to"] = "추가 전리품", -- the option to upgrade units in AV
	---["Wicked, wicked, mortals!"] = true, -- what Ivus says after being summoned
	["Ivus begins moving"] = "이부스 이동 시작",
	---["WHO DARES SUMMON LOKHOLAR"] = true, -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = "얼음 군주께서 당도하셨어요!",
	["Lokholar begins moving"] = "로크홀라 이동 시작",


	-- EotS
	["^(.+) has taken the flag!"] = "^(.+)|1이;가; 깃발을 차지했습니다!",
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = "거점: (%d+)  승점: (%d+)/2000",

})

