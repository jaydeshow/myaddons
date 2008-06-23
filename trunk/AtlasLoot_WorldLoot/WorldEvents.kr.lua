﻿--[[
--AtlasLoot loot tables koKR localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--$Date: 2008-06-23 10:36:22 -0400 (Mon, 23 Jun 2008) $
--]]
if (GetLocale() == "koKR") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootWorldEvents"][category] or #AtlasLoot_Data["AtlasLootWorldEvents"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootWorldEvents"][category][i][3] = data[i] end end data = nil end
Process("ArmbreakerHuffaz",22,{"=q3=에테리움 고리","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("BashirLanding",27,{"","=q1=불안정한 장로의 영약","=q1=불안정한 의술사의 영약","=q1=불안정한 약탈자의 영약","=q1=불안정한 병사의 영약","","","=q3=불안정한 자수정","=q3=불안정한 황수정","=q3=불안정한 감람석","=q3=불안정한 사파이어","=q3=불안정한 탈라사이트","=q3=불안정한 토파즈","","","","=q3=마력이 깃든 불안정한 다이아몬드","=q3=마력이 담긴 불안정한 다이아몬드","=q1=가속장치 모듈","=q1=마력이 담긴 작은 금 정동석","=q1=마력이 담긴 작은 은 정동석","=q1=마력이 담긴 작은 구리 정동석","=q1=마력이 담긴 작은 철 정동석","=q1=마력이 담긴 큰 금 정동석","=q1=마력이 담긴 큰 은 정동석","=q1=마력이 담긴 큰 구리 정동석","=q1=마력이 담긴 큰 철 정동석"})
Process("BashirStasisChambers",22,{"","=q3=악마의 보루방패","=q2=연합왕의 징표","","","=q3=회암강철 어깨보호구","=q2=연합왕의 징표","","","=q3=안개장막 어깨보호구","=q2=연합왕의 징표","","","","","","=q3=바람술사 어깨보호대","=q2=연합왕의 징표","","","=q3=하늘추적자 어깨보호구","=q2=연합왕의 징표"})
Process("Brewfest1",30,{"=q3=가을 축제 소형 맥주통","","=q1=벨비의 시력 향상 연애 고글","=q1=파란색 가을 축제 모자","=q1=갈색 가을 축제 모자","=q1=녹색 가을 축제 모자","=q1=보라색 가을 축제 모자","=q1=가을 축제 의복","=q1=가을 축제 드레스","=q1=가을 축제 장화","=q1=가을 축제 덧신","","=q1=\"명예 양조장이\" 손도장","=q4=날쌘 가을 축제 산양","=q3=가을 축제 산양","=q3=노란색 가을 축제 잔","=q3=검은무쇠단 맥주잔","=q3=노루토끼 술잔","","=q2=가을 축제 상품권","","=q1=마른 소시지","=q1=육즙이 많은 소시지","=q1=짭짤한 소시지","=q1=절인 소시지","=q1=매콤한 훈제 소시지","=q1=황금색 토막 소시지","","=q1=가을 축제 전통 프렛첼","=q1=가을 축제 맥주"})
Process("Brewfest2",24,{"","=q1=발리브루 청맥주","=q1=발리브루 순한 맥주","=q1=발리브루 흑맥주","","","=q1=썬더 45","=q1=썬더브루 에일 맥주","=q1=썬더브루 스타우트","","","=q1=고르독 그로그주","=q1=무더 우유","=q1=오우거 벌꿀술","","","=q1=종종걸음 맥주","=q1=성큼걸음 맥주","=q1=비틀걸음 맥주","","","=q1=정글 강물","=q1=부두 맥주","=q1=쭈그러든 해골 스타우트"})
Process("ChildrensWeek",19,{"","=q1=돼지 목줄","=q1=쥐 집","=q1=거북이 상자","=q1=보육 수당","","","","","","","","","","","","=q3=용용이 알","=q3=엘레크 조련용 목줄","=q3=잠꾸러기 왕눈이"})
Process("DarkscreecherAkkarai",12,{"=q3=이교도 건틀릿","=q2=아카라이의 갈퀴발톱","","=q3=바람술사 손목띠","=q3=바람술사 허리띠","=q3=하늘추적자 팔보호구","=q3=하늘추적자 장식끈","=q3=안개장막 팔보호구","=q3=안개장막 허리띠","=q3=회암강철 팔보호구","=q3=회암강철 벨트","=q3=스케티스 고리"})
Process("Dukes",27,{"","=q3=심연 가죽 다리보호구","=q3=경화 강철 전투망치","=q3=심연의 인장","=q2=심연 헝겊 장식띠","=q1=불꽃 군주의 불꽃","","","=q3=심연 쇠사슬 다리보호대","=q3=암흑석 클레이모어","=q3=심연의 인장","=q2=심연 가죽 허리띠","","","","","=q3=심연 헝겊 바지","=q3=영혼 분쇄기","=q3=심연의 인장","=q2=심연 판금 벨트","","","","=q3=심연 판금 다리갑옷","=q3=반짝이는 수정 마법봉","=q3=심연의 인장","=q2=심연 쇠사슬 허리띠"})
Process("ElementalInvasion",25,{"","=q3=남작 차르의 홀","=q3=정령 A","=q2=정령의 불씨","","","=q3=템페스트리아의 얼음 목걸이","=q3=정령 A","=q3=도안: 폭풍안개 장갑","=q2=극한의 반지","","","","","","","=q3=아발란치온의 돌가죽 방패","=q3=정령 A","=q2=단단한 돌고리","","","=q3=칼날바람의 장식띠","=q3=정령 A","=q3=도안: 폭풍안개 장갑","=q2=서풍 망토"})
Process("FelTinkererZortan",22,{"=q3=안개장막 장화","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("FishingExtravaganza",23,{"","=q3=아케이나이트 낚싯대","=q3=낚시대가의 낚싯바늘","","","=q2=키퍼의 천사돔","=q2=브로넬의 푸른줄무늬날치","=q2=데지안 여왕물고기","=q2=바위비늘 장사물고기","","","","","","","","","","","","=q2=행운의 낚시 모자","=q2=내트 페이글의 최고급 낚시 장화","=q2=고탄성 이터늄 낚싯줄"})
Process("Forgosh",22,{"=q3=에테리움 목걸이","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("GezzaraktheHuntress",12,{"=q3=게자라크의 송곳니","=q2=게자라크의 발톱","","=q3=바람술사 손목띠","=q3=바람술사 허리띠","=q3=하늘추적자 팔보호구","=q3=하늘추적자 장식끈","=q3=안개장막 팔보호구","=q3=안개장막 허리띠","=q3=회암강철 팔보호구","=q3=회암강철 벨트","=q3=스케티스 고리"})
Process("Gulbor",22,{"=q3=에테리움 목걸이","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("GurubashiArena",17,{"=q3=투기장 손목보호구","=q3=투기장 팔보호구","=q3=투기장 손목띠","=q3=투기장 완갑","","","","","","","","","","","","=q2=검투사의 징표","=q3=최고검투사의 징표"})
Process("Halloween1",28,{"=q3=호박등","=q2=호박 주머니","","=q1=스틸린의 막대 사탕","=q1=문브룩 무지개사탕","=q1=벨라라의 땅콩초코바","=q1=할로윈 호박 사탕","","","","","","","","","","=q1=할로윈 마법봉 - 박쥐","=q1=할로윈 마법봉 - 유령","=q1=할로윈 마법봉 - 오염된 노움","=q1=할로윈 마법봉 - 자객","=q1=할로윈 마법봉 - 해적","=q1=할로윈 마법봉 - 무작위","=q1=할로윈 마법봉 - 해골","=q1=할로윈 마법봉 - 위습","","=q1=캔디콘","=q1=막대 사탕","=q1=캔디바"})
Process("Halloween2",24,{"","=q1=얇은 남자 드워프 가면","=q1=얇은 남자 노움 가면","=q1=얇은 남자 인간 가면","=q1=얇은 남자 나이트 엘프 가면","=q1=얇은 남자 오크 가면","=q1=얇은 남자 타우렌 가면","=q1=얇은 남자 트롤 가면","=q1=얇은 남자 언데드 가면","","","","","","","","=q1=얇은 여자 드워프 가면","=q1=얇은 여자 노움 가면","=q1=얇은 여자 인간 가면","=q1=얇은 여자 나이트 엘프 가면","=q1=얇은 여자 오크 가면","=q1=얇은 여자 타우렌 가면","=q1=얇은 여자 트롤 가면","=q1=얇은 여자 언데드 가면"})
Process("HarvestFestival",8,{"=q1=추수절 선물","=q1=빛의 이름으로!","=q1=호드의 영웅 헬스크림","","=q1=추수절 고기","=q1=추수절 생선","=q1=추수절 과일","=q1=추수절 수정과"})
Process("HeadlessHorseman",20,{"=q4=저주받은 기사의 투구","=q4=광적인 기쁨의 반지","=q4=저주받은 기사의 인장 반지","=q4=마녀의 고리","","=q3=성스러운 투구","=q3=사악한 작은 호박","","=q1=무거운 호박등","=q1=축제 사탕","","","","","","=q4=날쌘 비행 빗자루","=q4=날쌘 마법의 빗자루","=q3=비행 빗자루","=q3=오래된 마법의 빗자루","=q2=낡은 마법의 빗자루"})
Process("HighCouncil",26,{"","=q4=원소 집중의 고리","=q4=심연의 홀","=q3=심연 가죽 팔보호구","=q3=심연 쇠사슬 어깨갑옷","","","=q4=파면의 목걸이","=q4=심연의 홀","=q3=심연 쇠사슬 손목보호대","=q3=심연 판금 견장","","","","","","=q4=돌풍의 단망토","=q4=심연의 홀","=q3=심연 헝겊 손목띠","=q3=심연 가죽 어깨보호구","","","=q4=대지의 수호방패","=q4=심연의 홀","=q3=심연 헝겊 아미스","=q3=심연 판금 완갑"})
Process("Karrog",12,{"=q3=카로그의 결정","=q2=카로그의 돌기","","=q3=바람술사 손목띠","=q3=바람술사 허리띠","=q3=하늘추적자 팔보호구","=q3=하늘추적자 장식끈","=q3=안개장막 팔보호구","=q3=안개장막 허리띠","=q3=회암강철 팔보호구","=q3=회암강철 벨트","=q3=스케티스 고리"})
Process("LunarFestival1",30,{"=q2=엘룬의 등불","","=q1=녹색 축제 드레스","=q1=분홍색 축제 드레스","=q1=보라색 축제 드레스","","=q1=검은색 축제 의상","=q1=파란색 축제 의상","=q1=암녹색 축제 의상","","=q1=달의 축제 만두","","=q1=엘룬의 양초","","=q1=선조의 주화","","=q1=작은 파란색 폭죽","=q1=작은 녹색 폭죽","=q1=작은 빨간색 폭죽","=q1=작은 흰색 폭죽","=q1=작은 노란색 폭죽","=q1=큰 파란색 폭죽","=q1=큰 녹색 폭죽","=q1=큰 빨간색 폭죽","=q1=큰 흰색 폭죽","=q1=큰 노란색 폭죽","","","=q1=행운의 연발탄 폭죽","=q1=장로의 월장석"})
Process("LunarFestival2",28,{"=q2=설계도: 폭죽 발사대","","","=q2=설계도: 작은 파란색 폭죽","=q2=설계도: 작은 녹색 폭죽","=q2=설계도: 작은 빨간색 폭죽","","","=q2=설계도: 큰 파란색 폭죽","=q2=설계도: 큰 녹색 폭죽","=q2=설계도: 큰 빨간색 폭죽","","=q2=도안: 축제 드레스","","","=q2=설계도: 연발탄 발사대","","","=q2=설계도: 파란색 연발탄","=q2=설계도: 녹색 연발탄","=q2=설계도: 빨간색 연발탄","","","=q2=설계도: 큰 파란색 연발탄","=q2=설계도: 큰 녹색 연발탄","=q2=설계도: 큰 빨간색 연발탄","","=q2=도안: 축제 의상"})
Process("MalevustheMad",22,{"=q3=회암강철 장화","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("MidsummerFestival",19,{"","=q3=갈무리한 불꽃","","=q2=불꽃의 팔찌","","=q1=불타는 꽃","=q1=불타는 축제주","=q1=엘더베리 파이","=q1=불에 구운 빵","=q1=한여름 소시지","=q1=불에 구운 스모크","","","","","=q1=불꽃축제 관","=q1=불꽃축제 어깨보호대"}) --Missing: 34683, 34684, 34685, 34686
Process("Noblegarden",7,{"","=q1=우아한 드레스","=q1=흰색 턱시도 셔츠","=q1=검은색 턱시도 바지","=q1=캔디바","=q1=초콜릿","=q1=막대 사탕"})
Process("PorfustheGemGorger",22,{"=q3=바람술사 장화","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
Process("ScourgeInvasionEvent1",30,{"=q2=축복받은 마술사 오일","=q2=신성한 숫돌","=q1=은빛 여명회 휘장","","=q2=죽음의 룬","","","=q3=언데드 정화의 로브","=q3=언데드 정화의 팔보호구","=q3=언데드 정화의 장갑","","","=q3=언데드 퇴치의 튜닉","=q3=언데드 퇴치의 손목보호대","=q3=언데드 퇴치의 장갑","=q1=하급 여명회 징표","=q1=여명회 징표","=q1=상급 여명회 징표","","","","","=q3=언데드 퇴치의 갑옷","=q3=언데드 퇴치의 손목보호구","=q3=언데드 퇴치의 손보호구","","","=q3=언데드 퇴치의 흉갑","=q3=언데드 퇴치의 팔보호구","=q3=언데드 퇴치의 건틀릿"})
Process("ScourgeInvasionEvent2",28,{"","=q3=발자폰의 허리띠","=q3=리치의 사슬","=q3=발자폰의 지팡이","","","=q3=블랙우드의 해골","=q3=군주 블랙우드의 검","=q3=군주 블랙우드의 버클러","","","=q3=보복의 망토","=q3=치유의 팔보호구","=q3=어둠의 손아귀","","","=q3=얼어붙은 손아귀","=q3=스콘의 얼음 목걸이","=q3=스콘의 뾰족 단검","","","=q3=누더기골렘 껍질 다리보호구","=q3=맹렬의 도끼","","","","=q3=귀부인 팔데리스의 망토","=q3=귀부인 팔데리스의 손가락"})
Process("Shartuul",27,{"=q4=타락자의 인장","","=q4=마력이 고갈된 천 팔보호구","=q4=마력이 고갈된 사슬 건틀릿","=q3=마력이 고갈된 망토","=q3=마력이 고갈된 반지","=q3=마력이 고갈된 배지","=q3=마력이 고갈된 단검","=q3=마력이 고갈된 검","=q3=마력이 고갈된 양손 도끼","=q3=마력이 고갈된 둔기","=q3=마력이 고갈된 지팡이","","","","=q4=감독관의 반지","","=q4=수정매듭 팔보호구","=q4=수정껍질 장갑","=q3=수정매듭 단망토","=q3=꿈수정 고리","=q3=불굴의 배지","=q3=수정이 주입된 비수","=q3=수정으로 벼려낸 검","=q3=에펙시스 도끼","=q3=에펙시스 수정 철퇴","=q3=이글거리는 석영 지팡이"})
Process("SkettisHazziksPackage",1,{"=q1=하지크의 가방"})
Process("SkettisTalonpriestIshaal",1,{"=q1=이샤알의 연감"})
Process("Templars",26,{"","=q3=수정 스틸레토","=q2=심연 헝겊 장갑","=q2=심연 쇠사슬 발덮개","=q2=심연의 문장","","","=q3=자수정 전투 지팡이","=q2=심연 헝겊 덧신","=q2=심연 판금 건틀릿","=q2=심연의 문장","","","","","","=q3=쐐기돌 장창","=q2=심연 가죽 장화","=q2=심연 쇠사슬 장갑","=q2=심연의 문장","","","=q3=일격의 활","=q2=심연 가죽 장갑","=q2=심연 판금 경갑","=q2=심연의 문장"})
Process("Terokk",11,{"=q4=테로크의 힘","=q4=테로크의 지혜","=q3=바람술사 다리보호구","=q3=하늘추적자 다리보호구","=q3=안개장막 바지","=q3=회암강철 다리보호구","=q3=갈퀴사제의 선물","=q3=영원한 왕의 브로치","=q3=잃어버린 시간의 조각상","=q3=테로크의 망치","=q3=테로크의 망치"})
Process("VakkiztheWindrager",12,{"=q3=바람몰이 손목띠","","","=q3=바람술사 손목띠","=q3=바람술사 허리띠","=q3=하늘추적자 팔보호구","=q3=하늘추적자 장식끈","=q3=안개장막 팔보호구","=q3=안개장막 허리띠","=q3=회암강철 팔보호구","=q3=회암강철 벨트","=q3=스케티스 고리"}) --Missing: 32718
Process("Valentineday",27,{"=q2=붉은 장미 꽃다발","","","=q3=낭만적인 소풍 바구니","=q1=아름다운 검은색 드레스","=q1=진은 화살","=q1=은 화살","=q1=사랑에 빠진 바보","=q1=붉은 꽃잎 한 줌","=q1=캔디 주머니","=q1=사랑의 로켓","","","","","","=q1=광란의 욕망","=q1=진한 산딸기 크림","=q1=천사의 유혹","=q1=달콤한 속삭임","","=q1=아름다운 붉은색 드레스","=q1=아름다운 푸른색 드레스","=q1=아름다운 보라색 드레스","=q1=붉은색 정찬복","=q1=푸른색 정찬복","=q1=보라색 정찬복"})
Process("Winterviel1",30,{"=q2=녹색 겨울 모자","=q2=빨간색 겨울 모자","=q1=겨울맞이 변장도구","=q1=눈뭉치","=q1=눈송이 한 줌","=q1=싱싱한 호랑가시나무","=q1=겨우살이","","","=q2=도안: 겨울 장화","=q2=도안: 붉은색 겨울 의복","=q2=도안: 초록색 겨울 의복","=q1=조리법: 따뜻한 사과맛 탄산수","=q1=조리법: 에그노그","=q1=조리법: 생강 과자빵","=q1=막대 사탕","=q1=축제일 치즈케이크","=q1=그라추의 엄마손 고기 파이","=q1=매콤한 산적","=q1=달콤한 축제용 햄","=q1=갈아만든 두유","=q1=정원 녹차","=q1=사과맛 탄산수","=q1=축제일 기념주","=q1=스팀휘들 탄산주","=q1=겨울 할아버지 꽁꽁주","=q1=축제일 향료","=q1=파란 리본달린 포장지","=q1=녹색 리본달린 포장지","=q1=보라색 리본달린 포장지"})
Process("Winterviel2",30,{"","=q1=녹색 도우미 상자","=q1=딸랑 방울","=q1=빨간색 도우미 상자","=q1=눈사람 세트","","","=q1=즐거운 축제 마법봉","","","=q3=로켓 태엽돌이","","","=q1=겨울맞이 숯불구이","=q1=겨울맞이 에그노그","","=q2=기계 그린치","=q2=보존된 호랑가시나무","=q2=도안: 겨울날 도끼","=q2=주문식: 무기 마법부여 - 한겨울 추위","=q2=설계도: 눈뭉치제조기 9000","=q2=도안: 겨울 할아버지 장갑","=q1=조제법: 냉기 강화의 비약","=q1=도안: 녹색 축제일 셔츠","","","=q1=겨울맞이 과자","","","=q1=그라추의 말린 과일 듬뿍 케이크"})
Process("WrathbringerLaztarash",22,{"=q3=마나로 벼려낸 구슬","","=q3=암흑의 망토","=q3=불가사의의 망토","=q3=이글거리는 망토","=q3=얼어붙은 망토","=q3=생기의 망토","","=q2=에테리움 죄수 인식표","","","","","","","","","=q3=암흑의 고리","=q3=불가사의의 고리","=q3=이글거리는 고리","=q3=얼어붙은 고리","=q3=생기의 고리"})
end
