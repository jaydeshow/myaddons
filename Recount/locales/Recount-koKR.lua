local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Recount", "koKR")
if not L then return end

	L["Profiles"] = "프로필"
	L["GUI"] = "GUI"
	L["gui"] = "gui"
	L["Open GUI"] = "GUI 열기"
	L["Sync"] = "동기화"
	L["sync"] = "동기화"
	L["Toggles sending synchronization messages"] = "동기화 메세지를 보냄"
	L["Reset"] = "초기화"
	L["reset"] = "초기화"
	L["Resets the data"] = "수집된 데이터를 초기화 합니다."
	L["VerChk"] = "버전 확인"
	L["verChk"] = "버전확인"
	L["Displays the versions of players in the raid"] = "공격대 참여시 버전을 표시합니다."
	L["Displaying Versions"] = "버전 표시"
	L["Show"] = "보기"
	L["show"] = "보기"
	L["Shows the main window"] = "메인창을 표시합니다."
	L["Hide"] = "숨김"
	L["Hides the main window"] = "메인창을 숨깁니다."
	L["Toggle"] = "전환"
	L["Toggles the main window"] = "메인창을 표시/숨깁니다."
	L["Report"] = "보고"
	L["Allows the data of a window to be reported"] = "기록된 정보를 모두 표시합니다."
	L["Detail"] = "상세"
	L["Report the Detail Window Data"] = "상세 데이터를 보고합니다."
	L["Main"] = "메인"
	L["Report the Main Window Data"] = "메인 데이터를 보고합니다."
	L["Config"] = "설정"
	L["Shows the config window"] = "설정창을 불러옵니다."
	L["ResetPos"] = "위치 초기화"
	L["Resets the positions of the detail, graph, and main windows"] = "상세/그래프/메인창의 위치를 초기화 합니다."
	L["Lock"] = "잠금"
	L["Toggles windows being locked"] = "창의 위치를 고정합니다."
	L["|cffff4040Disabled|r"] = "|cffff4040중지|r"
	L["|cff40ff40Enabled|r"] = "|cff40ff40사용|r"
	L["Unknown Spells"] = "알 수 없는 주문"
	L["Shows found unknown spells in BabbleSpell"] = "BabbleSpell에 없는 주문을 표시합니다."
	L["Unknown Spells:"] = "알 수 없는 주문:"
	L["Realtime"] = "실시간"
	L["Specialized Realtime Graphs"] = "실시간으로 그래프를 표시합니다."
	L["FPS"] = "FPS"
	L["Starts a realtime window tracking your FPS"] = "현재 FPS를 기록합니다."
	L["Lag"] = "Lag"
	L["Starts a realtime window tracking your latency"] = "현재 지연시간을 기록합니다."
	L["Upstream Traffic"] = "업스트림 트래픽"
	L["Starts a realtime window tracking your upstream traffic"] = "현재 업스트림 트래픽을 기록합니다."
	L["Downstream Traffic"] = "다운스트림 트래픽"
	L["Starts a realtime window tracking your downstream traffic"] = "현재 다운스트림 트래픽을 기록합니다."
	L["Available Bandwidth"] = "가능한 대역폭"
	L["Starts a realtime window tracking amount of available AceComm bandwidth left"] = "AceComm에서 가능한 대역폭을 기록합니다."
	L["Tracks your entire raid"] = "공격대시에 기록합니다."
	L["DPS"] = "DPS"
	L["Tracks Raid Damage Per Second"] = "공격대 초당 데미지를 기록합니다."
	L["DTPS"] = "DTPS"
	L["Tracks Raid Damage Taken Per Second"] = "공격대 받은 데미지를 기록합니다."
	L["HPS"] = "HPS"
	L["Tracks Raid Healing Per Second"] = "공격대 치유량을 기록합니다."
	L["HTPS"] = "HTPS"
	L["Tracks Raid Healing Taken Per Second"] = "공격대 받은 치유량을 기록합니다."
	L["Pet"] = "소환수" -- Elsia: Stuff from here down is not yet fully localized.
	L["Mob"] = "몹"
	L["Title"] = "제목"
	L["Background"] = "배경"
	L["Title Text"] = "제목 문자"
	L["Bar Text"] = "바 문자"
	L["Total Bar"] = "전체 바"
	L["Show previous main page"] = "이전 메인 페이지 보기" -- Elsia: And even more stuff not yet fully localized.
	L["Show next main page"] = "다음 메인 페이지 보기"
	L["Display"] = "표시"
	L["Damage Done"] = "데미지"
	L["Friendly Fire"] = "아군에게 준 피해"
	L["Damage Taken"] = "받은 데미지"
	L["Healing Done"] = "치유량"
	L["Healing Taken"] = "받은 치유량"
	L["Overhealing Done"] = "오버힐"
	L["Deaths"] = "죽음"
	L["DOT Uptime"] = "DOT 시간비율"
	L["HOT Uptime"] = "HOT 시간비율"
	L["Dispels"] = "해제"
	L["Dispelled"] = "해제 받음"
	L["Interrupts"] = "방해"
	L["Ressers"] = "부활"
	L["CC Breakers"] = "군중제어 해제"
	L["Activity"] = "활동"
	L["Threat"] = "위협"
	L["Mana Gained"] = "획득 마나"
	L["Energy Gained"] = "획득 기력"
	L["Rage Gained"] = "획득 분노"
	L["Network Traffic(by Player)"] = "네트워크 트래픽(플레이어)"
	L["Network Traffic(by Prefix)"] = "네트워크 트래픽(by Prefix)"
	L["Bar Color Selection"] = "바 색상 설정"
	L["Class Colors"] = "직업 색상"
	L["Reset Colors"] = "색상 초기화"
	L["Is this shown in the main window?"] = "메인 창에 이것을 표시합니까?"
	L["Record Data"] = "데이터 기록"
	L["Whether data is recorded for this type"] = "이 유형에 의해 데이터가 기록됩니다."
	L["Record Time Data"] = "시간 데이터 기록"
	L["Whether time data is recorded for this type (used for graphs can be a |cffff2020memory hog|r if you are concerned about memory)"] = "이 유형에 의해 시간 자료가 기록됩니다. (그래프를 사용하기 위해 필요하며, |cffff2020많은 메모리 용량|r을 차지하므로 메모리에 대해 우려해야 합니다.)"
	L["Record Deaths"] = "죽음 기록"
	L["Records when deaths occur and the past few actions involving this type"] = "죽을 경우 이 유형에 관련된 활동이 기록됩니다."
	L["Record Buffs/Debuffs"] = "버프/디버프 기록"
	L["Records the times and applications of buff/debuffs on this type"] = "이 유형에 의해 버프/디버프 적용과 시간을 기록합니다."
	L["Filters"] = "선별"
	L["Players"] = "플레이어"
	L["Self"] = "자신"
	L["Grouped"] = "그룹화"
	L["Ungrouped"] = "그룹화 안된 것"
	L["Pets"] = "소환수"
	L["Mobs"] = "몹"
	L["Trivial"] = "하찮은 것"
	L["Non-Trivial"] = "고려할만한 것"
	L["Bosses"] = "보스들"
	L["Unknown"] = "알수없음"
	L["Bar Selection"] = "바 설정"
	L["Font Selection"] = "글꼴 설정"
	L["General Window Options"] = "일반적인 창 옵션"
	L["Reset Positions"] = "위치 초기화"
	L["Window Scaling"] = "창 크기"
	L["Data Deletion"] = "데이터 삭제"
	L["Instance Based Deletion"] = "인던을 기반으로 삭제"
	L["Group Based Deletion"] = "그룹을 기반으로 삭제"
	L["Global Realtime Windows"] = "공통 실시간 창"
	L["Network"] = "네트워크"
	L["Latency"] = "지연 시간"
	L["Up Traffic"] = "업 트래픽"
	L["Down Traffic"] = "다운 트래픽"
	L["Bandwidth"] = "대역폭"
	L["Recount Version"] = "Recount 버전"
	L["Check Versions"] = "버전 체크"
	L["Data Options"] = "데이터 옵션"
	L["Combat Log Range"] = "전투 로그 거리"
	L["Yds"] = "야드"
	L["Fix Ambiguous Log Strings"] = "확실하지 않은 로그들 수정"
	L["Merge Pets w/ Owners"] = "소환수를 주인에게 합치기"
	L["Main Window Options"] = "메인 창 옵션"
	L["Show Buttons"] = "버튼 보기"
	L["File"] = "파일"
	L["Previous"] = "이전"
	L["Next"] = "다음"
	L["Row Height"] = "줄 간격"
	L["Row Spacing"] = "줄 높이"
	L["Autohide On Combat"] = "전투시 자동숨김"
	L["Show Scrollbar"] = "스크롤바 표시"
	L["Data"] = "데이터"
	L["Appearance"] = "외형"
	L["Color"] = "색상"
	L["Window"] = "창"
	L["Window Color Selection"] = "창 색상 설정"
	L["Main Window"] = "메인 창"
	L["Other Windows"] = "다른 창"
	L["Global Data Collection"] = "공통 데이터 수집"
	L["Autoswitch Shown Fight"] = "전투별 자동전환 되어 보기"
	L["Lock Windows"] = "창 잠금"
	L["Autodelete Time Data"] = "시간 데이터 자동삭제"
	L["Delete on Entry"] = "입장시 삭제"
	L["New"] = "New"
	L["Confirmation"] = "확인"
	L["Delete on New Group"] = "새 그룹시 삭제"
	L["Delete on New Raid"] = "새 공격대시 삭제"
	L["Sync Data"] = "데이터 동기화"
	L["Set Combat Log Range"] = "전투 로그 거리 설정"
	L["Detail Window"] = "세부사항 창"
	L["Death Details for"] = "죽음에 세부사항:"
	L["Health"] = "체력"
	L["Recount"] = "Recount"
	L["Outgoing"] = "준"
	L["Incoming"] = "받은"
	L["Damage Report for"] = "데미지 보고:"
	L["Damage"] = "데미지"
	L["Resisted"] = "저항"
	L["Report for"] = "보고:"
	L["Glancing"] = "빗맞음"
	L["Hit"] = "평타"
	L["Crushing"] = "강타"
	L["Crit"] = "치명타"
	L["Miss"] = "빚맞힘"
	L["Dodge"] = "회피"
	L["Parry"] = "막음"
	L["Block"] = "방어"
	L["Resist"] = "저항"
	L["Tick"] = "틱"
	L["Split"] = "분할"
	L["X Gridlines Represent"] = "X 격자줄 표시"
	L["Seconds"] = "초"
	L["Graph Window"] = "그래프 창"
	L["Data Name"] = "데이터 이름"
	L["Enabled"] = "활성화"
	L["Fought"] = "전투"
	L["Start"] = "시작"
	L["End"] = "끝"
	L["Normalize"] = "표준화"
	L["Integrate"] = "병합"
	L["Stack"] = "쌓아 올림"
	L["Report Data"] = "데이터 보고"
	L["Report To"] = "보고할 곳"
	L["Report Top"] = "보고될 순위"
	L["Reset Recount?"] = "Recount를 초기화 하시겠습니까?"
	L["Do you wish to reset the data?"] = "당신은 데이터의 초기화를 바랍니까?"
	L["Yes"] = "예"
	L["No"] = "아니오"
	L["Show Details (Left Click)"] = "세부사항 보기(좌 클릭)"
	L["Show Graph (Shift Click)"] = "그래프 보기(Shift+클릭)"
	L["Add to Current Graph (Alt Click)"] = "현재 그래프 추가(Alt+클릭)"
	L["Show Realtime Graph (Ctrl Click)"] = "실시간 그래프 보기(Ctrl+클릭)"
	L["Delete Combatant (Ctrl-Alt Click)"] = "전투원 삭제(Ctrl+Alt+클릭)"
	L[" for "] = " <- "
	L["Overall Data"] = "전체 데이터"
	L["Current Fight"] = "현재의 전투"
	L["Last Fight"] = "마지막 전투"
	L["Fight"] = "전투"
	L["Top Color"] = "상단 색상"
	L["Bottom Color"] = "하단 색상"
	L["Ability Name"] = "기술 이름"
	L["Type"] = "분류"
	L["Min"] = "최하"
	L["Avg"] = "평균"
	L["Max"] = "최대"
	L["Count"] = "횟수"
	L["Player/Mob Name"] = "플레이어/몹 이름"
	L["Attack Name"] = "공격 이름"
	L["Time (s)"] = "시간(초)"
	L["Heal Name"] = "치유 이름"
	L["Heal"] = "치유"
	L["Healed"] = "치유"
	L["Overheal"] = "오버힐"
	L["Ability"] = "기술"
	L["DOT Time"] = "지속피해 시간"
	L["Ticked on"] = "틱"
	L["Duration"] = "지속"
	L["HOT Time"] = "지속치유 시간"
	L["Interrupted Who"] = "방해 대상"
	L["Interrupted"] = "방해"
	L["Ressed Who"] = "부활 대상"
	L["Times"] = "시간"
	L["Who"] = "대상"
	L["Broke"] = "해제 종류"
	L["Broke On"] = "해제된 대상"
	L["Gained"] = "획득"
	L["From"] = " - "
	L["Prefix"] = "Prefix"
	L["Messages"] = "메세지"
	L["Distribution"] = "분포"
	L["Bytes"] = "Bytes"
	L["'s Hostile Attacks"] = "의 적에게 준 공격"
	L["Damaged Who"] = "데미지 대상"
	L["'s Partial Resists"] = "의 부분 저항"
	L["'s Time Spent Attacking"] = "의 공격에 들인 시간"
	L["'s Friendly Fire"] = "의 아군에게 준 피해"
	L["Friendly Fired On"] = "아군에게 준 피해"
	L["Took Damage From"] = "받은 데미지"
	L["'s Effective Healing"] = "의 유효 치유량"
	L["Healed Who"] = "치유 대상"
	L["'s Overhealing"] = "의 오버힐"
	L["'s Time Spent Healing"] = "의 치유에 들인 시간"
	L["was Healed by"] = "받은 치유"
	L["'s DOT Uptime"] = "의 지속적인 피해 시간 비율"
	L["'s HOT Uptime"] = "의 지속적인 치유 시간 비율"
	L["'s Interrupts"] = "의 방해"
	L["'s Resses"] = "의 부활 횟수"
	L["'s Dispels"] = "의 해제"
	L["was Dispelled by"] = "받은 해제"
	L["'s Time Spent"] = "의 활동 시간"
	L["CC Breaking"] = "군중제어 해제"
	L["'s Mana Gained"] = "의 마나 획득"
	L["'s Mana Gained From"] = "의 ~에서 획득한 마나"
	L["'s Energy Gained"] = "의 기력 획득"
	L["'s Energy Gained From"] = "의 ~에서 획득한 기력"
	L["'s Rage Gained"] = "의 분노 획득"
	L["'s Rage Gained From"] = "의 ~에서 획득한 분노"
	L["'s Network Traffic"] = "의 네트워크 트레픽"
	L["Top 3"] = "상위 3"
	L["Damage Abilities"] = "데미지 기술"
	L["Attacked"] = "공격"
	L["Pet Damage Abilities"] = "소환수 데미지 기술"
	L["Pet Attacked"] = "소환수 공격"
	L["Click for more Details"] = "추가 세부사항을 위한 클릭"
	L["Friendly Attacks"] = "아군 공격"
	L["Attacked by"] = "에 따른 공격"
	L["Heals"] = "치유량"
	L["Healed By"] = "에 따른 치유"
	L["Over Heals"] = "오버힐"
	L["DOTs"] = "지속적인 피해"
	L["HOTs"] = "지속적인 치유"
	L["Dispelled By"] = "에 따른 해제"
	L["Attacked/Healed"] = "공격/치유"
	L["Time Damaging"] = "피해준 시간"
	L["Time Healing"] = "치유한 시간"
	L["Mana Abilities"] = "마나 기술"
	L["Mana Sources"] = "마나 출처"
	L["Energy Abilities"] = "기력 기술"
	L["Energy Sources"] = "기력 출처"
	L["Rage Abilities"] = "분노 기술"
	L["Rage Sources"] = "분노 출처"
	L["CC's Broken"] = "군중제어 해제"
	L["Ressed"] = "부활"
	L["Network Traffic"] = "네트워크 트레픽"
	L["'s DPS"] = "의 DPS"
	L["'s DTPS"] = "의 DTPS"
	L["'s HPS"] = "의 HPS"
	L["'s HTPS"] = "의 HTPS"
	L["'s TPS"] = "의 TPS"
	L["Threat on"] = "위협"
	L["Name of Ability"] = "기술의 이름"
	L["Time"] = "시간"
	L["Killed By"] = "~ 의하여 죽음"
	L["Combat Messages"] = "전투 메시지"
	L["Misc"] = "기타"
	L["Show Graph"] = "그래프 보기"
	L["Config Recount"] = "Recount 설정"
	L["Death Graph"] = "죽은 횟수 그래프"
	L["Melee"] = "일반 공격"
	L["Physical"] = "기술/기타"
	L["Arcane"] = "비전"
	L["Fire"] = "화염"
	L["Frost"] = "냉기"
	L["Holy"] = "신성"
	L["Nature"] = "자연"
	L["Shadow"] = "암흑"
	L["Total"] = "총"
	L["Taken"] = "받은량"
	L["Damage Focus"] = "데미지 집중점"
	L["Avg. DOTs Up"] = "평균. 지속적인 피해량"
	L["Pet Damage"] = "소환수 데미지"
	L["No Pet"] = "소환수 없음"
	L["Pet Time"] = "소환수 시간"
	L["Pet Focus"] = "소환수 집중점"
	L["Healing"] = "치유"
	L["Overhealing"] = "오버힐"
	L["Heal Focus"] = "치유 집중점"
	L["Avg. HOTs Up"] = "평균. 지속적인 치유량"
	L["Attack Summary Outgoing (Click for Incoming)"] = "준 공격 요약(받은 것을 볼려면 클릭)"
	L["Attack Summary Incoming (Click for Outgoing)"] = "받은 공격 요약(준 것을 볼려면 클릭)"
	L["Summary Report for"] = "요약 보고서:"
	L["Say"] = "일반"
	L["Party"] = "파티"
	L["Raid"] = "공격대"
	L["Guild"] = "길드"
	L["Officer"] = "길드 관리자"
	L["Whisper"] = "귓속말"
	L["Whisper Target"] = "대상에게 귓속말"
	L["Blocked"] = "방어"
	L["Absorbed"] = "흡수"
	L["Guardian"] = "보호"
	L["Click for next Pet"] = "다음 소환수를 위해 클릭"
	L["Outside Instances"] = "외부 인던"
	L["Party Instances"] = "파티 인던"
	L["Raid Instances"] = "공격대 인던"
	L["Battlegrounds"] = "전장"
	L["Arenas"] = "투기장"
	L["Content-based Filters"] = "콘텐츠별 선별"
	L["Show Total Bar"] = "전체 바 보기"
	L["Config Access"] = "설정 이용"
	L["Window Options"] = "창 옵션"
	L["Sync Options"] = "동기화 옵션"
	L["Hostile"] = "적"
	L["Rank Number"] = "순위 번호"
	L["Bar Text Options"] = "바 문자 옵션"
	L["Per Second"] = "DPS"
	L["Percent"] = "퍼센트(%)"
	L["Fight Segmentation"] = "전투 세분화"
	L["Keep Only Boss Segments"] = "보스만 세분화 유지"
	L["Click|r to toggle the Recount window"] = "좌-클릭|r : Recount 창 표시/숨김"
	L["Right-click|r to open the options menu"] = "우-클릭|r : 옵션 메뉴 열기"
	L["Number Format"] = "숫자 형식"
	L["Standard"] = "표준"
	L["Commas"] = "콤마"
	L["Short"] = "간단히"
	L["Hide When Not Collecting"] = "수집되지 않을 때 숨김"
	L["DoT"] = "지속 피해"
	L["HoT"] = "지속 치유"
	L["Recorded Fights"] = "전투 기록"
	L["Set the maximum number of recorded fight segments"] = "전투 세분화 기록의 최대 수 설정"
	L["pause"] = "중단"
	L["Pause"] = "중단"
	L["Toggle pause of global data collection"] = "전체적인 데이터 수집 일시 중지 전환"
	L["Data collection turned off"] = "데이터 수집 취소"
	L["Data collection turned on"] = "데이터 수집 작동"

	L["Death Track"] = "죽음 기록"
	L["Report the DeathTrack Window Data"] = "죽음기록창 데이터 보고"
	L["Show Death Track (Left Click)"] = "죽음 기록 보기(좌-클릭)"
	L[" dies."] = " 죽음."
	