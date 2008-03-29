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
	["Enable"] = "켜기",
	["Auto quest turnins"] = "퀘스트 자동 반납",
	["Enable Alterac Valley automatic quest turnins"] = "알터랙 계곡 퀘스트 자동 반납하기", 
	["Bar"] = "막대",
	["Statusbar options"] = "상태 막대 설정",
	["Font size"] = "글꼴 크기",
	["Change statusbar font size"] = "상태 막대 글꼴 크기를 바꿉니다",
	["Width"] = "너비", 
	["Change statusbar width"] = "상태 막대 너비를 바꿉니다",
	["Height"] = "높이",
	["Change statusbar thickness"] = "상태 막대 두께를 바꿉니다",
	["Scale"] = "크기",
	["Change statusbar scale"] = "상태 막대 크기를 바꿉니다",
	["Texture"] = "텍스처",
	["Statusbar textures"] = "상태 막대 텍스처",
	["Other"] = "그 밖에",
	["Other options"] = "그 밖에 설정",
	["Auto show map"] = "자동으로 지도 보이기",
	["Auto show the battlefield minimap on entry"] = "자동으로 작은 전장 지도를 보여줍니다",
	["Map scale"] = "지도 크기",
	["Hide border"] = "테두리 숨기기",
	["Change the default scale of the battlefield minimap"] = "작은 전장 지도의 기본 크기를 바꿉니다",
	["Port Timer"] = "입장 시간",
	["Enable timers for port expiration"] = "입장 가능한 남은 시간 표시",
	["Wait Timer"] = "대기 시간",
	["Enable timers for queue wait time"] = "대기 시간 표시",
	["Show/Hide Anchor"] = "표식 보이기/감추기",
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = "막대 표식을 보이거나 감춥니다. (상태 막대를 왼쪽 클릭해도 됨)",
	["Toggle class color"] = "직업별 색 켜거나 끄기",
	["Enable/disable class color indicators on the scoreboard"] = "점수판에서 직업별 색으로 구분하는 기능을 켜거나 끕니다",
	["Narrow map mode"] = "좁은 지도 표시",
	["Narrow the battlefield minimap, removing some empty space"] = "전장 작은 지도를 빈 곳을 없애 좁게 표시합니다",
	["Test"] = "시험",
	["Start a test bar"] = "막대 시험 시작",
	["Reverse fill"] = "거꾸로 채우기",
	["Set statusbars to fill up instead of depleting"] = "상태 막대를 비우는 대신 채우도록 설정합니다",
	["Flip growth"] = "위로 쌓기",
	["Set objective timers to grow up and misc timers to grow down"] = "목표 시간을 위로, 그 밖에 시간을 아래로 쌓아갑니다",
	["Reposition Scoreboard"] = "점수판 위치 바꾸기",
	["Move the scoreboard to the Capping anchor's CURRENT position"] = "점수판을 Capping 표식이 있는 현재 위치로 옮깁니다",
	["Battlefield Minimap"] = "전장 작은 지도",
	["Options for the battlefield minimap"] = "전장 작은 지도 설정",
	["Colors"] = "색상",
	["Icons"] = "아이콘",
	["Bar icons display options"] = "막대 아이콘 표시 설정",
	["Spacing"] = "간격",
	["Request sync"] = "동기화 요청",
	["LEFT"] = "우측",
	["RIGHT"] = "좌측",
	["HIDE"] = "숨김",

	-- etc timers
	["Port: %s"] = "입장: %s", -- bar text for time remaining to port into a bg
	["Queue: %s"] = "대기: %s",
	["Battleground Begins"] = "전투 개시", -- bar text for bg gates opening (why can't they all be the same?)
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
	--["The "] = true,
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

