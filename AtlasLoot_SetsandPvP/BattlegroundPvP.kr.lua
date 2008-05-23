﻿--[[
--AtlasLoot loot tables koKR localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--$Date: 2008-05-21 11:00:19 -0400 (Wed, 21 May 2008) $
--]]
if (GetLocale() == "koKR") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootBGItems"][category] or #AtlasLoot_Data["AtlasLootBGItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootBGItems"][category][i][3] = data[i] end end data = nil end
Process("AB20291",26,{"","=q3=산악연대 헝겊 벨트","=q3=산악연대 헝겊 장화","=q3=산악연대 가죽 벨트","=q3=산악연대 도마뱀가죽 벨트","=q3=산악연대 쇠사슬 벨트","=q3=산악연대 통가죽 벨트","=q3=산악연대 가죽 장화","=q3=산악연대 도마뱀가죽 장화","=q3=산악연대 쇠사슬 경갑","=q3=산악연대 통가죽 경갑","","","","","","=q3=파멸단 헝겊 벨트","=q3=파멸단 헝겊 장화","=q3=파멸단 가죽 벨트","=q3=파멸단 도마뱀가죽 벨트","=q3=파멸단 사슬 벨트","=q3=파멸단 통가죽 벨트","=q3=파멸단 가죽 장화","=q3=파멸단 도마뱀가죽 장화","=q3=파멸단 쇠사슬 경갑","=q3=파멸단 사슬 경갑"})
Process("AB20292",21,{"","=q3=산악연대 강철 벨트","=q3=산악연대 쇠사슬 벨트","=q3=산악연대 강철 경갑","=q3=산악연대 쇠사슬 경갑","=q3=아라소르 부적","","","","","","","","","","","=q3=파멸단 강철 벨트","=q3=파멸단 쇠사슬 벨트","=q3=파멸단 강철 경갑","=q3=파멸단 쇠사슬 경갑","=q3=파멸단 부적"})
Process("AB3039",23,{"","=q3=산악연대 헝겊 벨트","=q3=산악연대 헝겊 장화","=q3=산악연대 가죽 벨트","=q3=산악연대 도마뱀가죽 벨트","=q3=산악연대 가죽 장화","=q3=산악연대 도마뱀가죽 장화","=q3=아라소르 부적","","","","","","","","","=q3=파멸단 헝겊 벨트","=q3=파멸단 헝겊 장화","=q3=파멸단 가죽 벨트","=q3=파멸단 도마뱀가죽 벨트","=q3=파멸단 가죽 장화","=q3=파멸단 도마뱀가죽 장화","=q3=파멸단 부적"})
Process("AB40491",30,{"","=q3=산악연대 헝겊 벨트","=q3=산악연대 헝겊 장화","=q3=산악연대 가죽 벨트","=q3=산악연대 도마뱀가죽 벨트","=q3=산악연대 가죽 장화","=q3=산악연대 도마뱀가죽 장화","=q3=산악연대 사슬 벨트","=q3=산악연대 사슬 벨트","=q3=산악연대 쇠사슬 벨트","=q3=산악연대 쇠사슬 벨트","=q3=산악연대 사슬 경갑","=q3=산악연대 사슬 경갑","=q3=산악연대 쇠사슬 경갑","=q3=산악연대 쇠사슬 경갑","","=q3=파멸단 헝겊 벨트","=q3=파멸단 헝겊 장화","=q3=파멸단 가죽 벨트","=q3=파멸단 도마뱀가죽 벨트","=q3=파멸단 가죽 장화","=q3=파멸단 도마뱀가죽 장화","=q3=파멸단 사슬 벨트","=q3=파멸단 사슬 벨트","=q3=파멸단 쇠사슬 벨트","=q3=파멸단 쇠사슬 벨트","=q3=파멸단 사슬 경갑","=q3=파멸단 사슬 경갑","=q3=파멸단 쇠사슬 경갑","=q3=파멸단 쇠사슬 경갑"})
Process("AB40492",25,{"","=q3=산악연대 강철 벨트","=q3=산악연대 강철 벨트","=q3=산악연대 판금 벨트","=q3=산악연대 판금 벨트","=q3=산악연대 강철 경갑","=q3=산악연대 강철 경갑","=q3=산악연대 판금 경갑","=q3=산악연대 판금 경갑","=q3=아라소르 부적","","","","","","","=q3=파멸단 강철 벨트","=q3=파멸단 강철 벨트","=q3=파멸단 판금 벨트","=q3=파멸단 판금 벨트","=q3=파멸단 강철 경갑","=q3=파멸단 강철 경갑","=q3=파멸단 판금 경갑","=q3=파멸단 판금 경갑","=q3=파멸단 부적"})
Process("AB5059",29,{"","=q3=산악연대 헝겊 벨트","=q3=산악연대 헝겊 장화","=q3=산악연대 가죽 벨트","=q3=산악연대 도마뱀가죽 벨트","=q3=산악연대 가죽 장화","=q3=산악연대 도마뱀가죽 장화","=q3=산악연대 사슬 벨트","=q3=산악연대 사슬 경갑","=q3=산악연대 강철 벨트","=q3=산악연대 판금 벨트","=q3=산악연대 강철 경갑","=q3=산악연대 판금 경갑","=q3=아라소르 부적","","","=q3=파멸단 헝겊 벨트","=q3=파멸단 헝겊 장화","=q3=파멸단 가죽 벨트","=q3=파멸단 도마뱀가죽 벨트","=q3=파멸단 가죽 장화","=q3=파멸단 도마뱀가죽 장화","=q3=파멸단 사슬 벨트","=q3=파멸단 쇠사슬 벨트","=q3=파멸단 사슬 경갑","=q3=파멸단 쇠사슬 경갑","=q3=파멸단 판금 벨트","=q3=파멸단 판금 경갑","=q3=파멸단 부적"})
Process("AB60",26,{"","=q4=의장대 망토","=q4=산악연대 견장","=q4=산악연대 가죽 어깨보호구","=q4=산악연대 도마뱀가죽 어깨보호구","=q4=산악연대 사슬 어깨갑옷","=q4=산악연대 쇠사슬 어깨갑옷","=q4=산악연대 강철 어깨갑옷","=q4=산악연대 판금 어깨갑옷","=q4=현자의 발톱","=q4=무쇠껍질 지팡이","","","","","","=q4=죽음의 경비대 망토","=q4=파멸단 견장","=q4=파멸단 가죽 어깨보호구","=q4=파멸단 도마뱀가죽 어깨보호구","=q4=파멸단 사슬 어깨갑옷","=q4=파멸단 쇠사슬 어깨갑옷","","=q4=파멸단 판금 어깨갑옷","=q4=의식의 송곳니","=q4=무쇠껍질 지팡이"})
Process("ABMisc",24,{"","=q1=최상급 치유 비약","=q1=최상급 마나 비약","=q1=산악연대 비상 휴대식량","=q1=산악연대 전투 휴대식량","=q1=산악연대 야전 휴대식량","=q1=산악연대 룬매듭 붕대","=q1=산악연대 마법 붕대","=q1=산악연대 비단 붕대","","","","","","","","=q1=최상급 치유 비약","=q1=최상급 마나 비약","=q1=파멸단 비상 휴대식량","=q1=파멸단 전투 휴대식량","=q1=파멸단 야전 휴대식량","=q1=파멸단 룬매듭 붕대","=q1=파멸단 마법 붕대","=q1=파멸단 비단 붕대"})
Process("ABSets1",29,{"","=q4=산악연대 견장","=q3=산악연대 헝겊 벨트","=q3=산악연대 헝겊 장화","","","=q4=산악연대 가죽 어깨보호구","=q3=산악연대 가죽 벨트","=q3=산악연대 가죽 장화","","","=q4=산악연대 도마뱀가죽 어깨보호구","=q3=산악연대 도마뱀가죽 벨트","=q3=산악연대 도마뱀가죽 장화","","","=q4=파멸단 견장","=q3=파멸단 헝겊 벨트","=q3=파멸단 헝겊 장화","","","=q4=파멸단 가죽 어깨보호구","=q3=파멸단 가죽 벨트","=q3=파멸단 가죽 장화","","","=q4=파멸단 도마뱀가죽 어깨보호구","=q3=파멸단 도마뱀가죽 벨트","=q3=파멸단 도마뱀가죽 장화"})
Process("ABSets2",24,{"","=q4=산악연대 사슬 어깨갑옷","=q3=산악연대 사슬 벨트","=q3=산악연대 사슬 경갑","","","=q4=산악연대 쇠사슬 어깨갑옷","=q3=산악연대 쇠사슬 벨트","=q3=산악연대 쇠사슬 경갑","","","","","","","","=q4=파멸단 사슬 어깨갑옷","=q3=파멸단 사슬 벨트","=q3=파멸단 사슬 경갑","","","=q4=파멸단 쇠사슬 어깨갑옷","=q3=파멸단 쇠사슬 벨트","=q3=파멸단 쇠사슬 경갑"})
Process("ABSets3",19,{"","=q4=산악연대 판금 어깨갑옷","=q3=산악연대 판금 벨트","=q3=산악연대 판금 경갑","","","=q4=산악연대 강철 어깨갑옷","=q3=산악연대 강철 벨트","=q3=산악연대 강철 경갑","","","","","","","","=q4=파멸단 판금 어깨갑옷","=q3=파멸단 판금 벨트","=q3=파멸단 판금 경갑"})
Process("AVBlue",29,{"","=q3=스톰파이크 현자의 망토","=q3=스톰파이크 병사의 망토","=q3=스톰파이크 천 벨트","=q3=스톰파이크 가죽 벨트","=q3=스톰파이크 사슬 벨트","=q3=스톰파이크 판금 벨트","=q3=스톰파이크 현자의 펜던트","=q3=스톰파이크 병사의 펜던트","=q3=충격의 단검","=q3=폭풍강타 망치","=q3=일격의 지팡이","=q3=놀 가죽 탄띠","=q3=하피 가죽 화살통","","","=q3=서리늑대 조언가의 망토","=q3=서리늑대 용사의 망토","=q3=서리늑대 천 허리띠","=q3=서리늑대 가죽 허리띠","=q3=서리늑대 사슬 허리띠","=q3=서리늑대 판금 허리띠","=q3=서리늑대 조언가의 펜던트","=q3=서리늑대 용사의 펜던트","=q3=빙하의 칼날","=q3=얼음이빨","=q3=극지의 지팡이","=q3=놀 가죽 탄띠","=q3=하피 가죽 화살통"})
Process("AVMisc",24,{"","=q3=스톰파이크 전투깃발","=q1=스톰파이크 전투휘장","","","=q2=얼음 화살","=q1=일급 치유 비약","=q1=최상급 치유 비약","=q1=알터랙 만나빵","=q1=알터랙 두꺼운 룬매듭 붕대","","","","","","","=q3=서리늑대 전투깃발","=q1=서리늑대 전투휘장","","","=q2=얼음 탄환","=q1=일급 마나 비약","=q1=최상급 마나 비약","=q1=알터랙 샘물"})
Process("AVPurple",24,{"","=q4=스톰파이크 전투산양 고삐","","","=q4=돈 훌리오의 고리","=q4=구원의 꽃다발","=q4=신비한 비전술의 고서","=q4=검은 마력의 고서","=q4=절개의 단검","=q4=불굴의 방패","","","","","","","=q4=전투서리늑대 뿔피리","","","=q4=돈 로드리고의 고리","=q4=테라제인의 손길","=q4=불타는 아르카나의 고서","=q4=얼음 군주의 고서","=q4=단호의 철퇴"})
Process("WSG1019",24,{"","=q3=청지기의 단망토","=q3=파수꾼의 메달","=q3=현자의 반지","=q3=수호자의 고리","=q3=파수꾼의 칼날","=q3=수호자의 검","=q3=현자의 지팡이","=q3=길잡이의 활","","","","","","","","=q3=전투치유사의 망토","=q3=정찰병의 메달","=q3=조언자의 반지","=q3=용사의 고리","=q3=정찰병의 칼날","=q3=용사의 검","=q3=조언자의 옹이진 지팡이","=q3=수색병의 활"})
Process("WSG2029",26,{"","=q3=청지기의 단망토","=q3=파수꾼의 메달","=q3=현자의 반지","=q3=수호자의 고리","=q3=의무의 룬","=q3=완수의 룬","=q3=파수꾼의 칼날","=q3=수호자의 검","=q3=현자의 지팡이","=q3=길잡이의 활","","","","","","=q3=전투치유사의 망토","=q3=정찰병의 메달","=q3=조언자의 반지","=q3=용사의 고리","=q3=의무의 룬","=q3=완수의 룬","=q3=정찰병의 칼날","=q3=용사의 검","=q3=조언자의 옹이진 지팡이","=q3=수색병의 활"})
Process("WSG3039",24,{"","=q3=청지기의 단망토","=q3=파수꾼의 메달","=q3=현자의 반지","=q3=수호자의 고리","=q3=파수꾼의 칼날","=q3=수호자의 검","=q3=현자의 지팡이","=q3=길잡이의 활","","","","","","","","=q3=전투치유사의 망토","=q3=정찰병의 메달","=q3=조언자의 반지","=q3=용사의 고리","=q3=정찰병의 칼날","=q3=용사의 검","=q3=조언자의 옹이진 지팡이","=q3=수색병의 활"})
Process("WSG4049",30,{"","=q4=드리아드의 손목띠","=q4=숲추적자의 팔보호구","=q4=바람지기의 손목보호대","=q4=광전사의 팔보호구","=q3=청지기의 단망토","=q3=파수꾼의 메달","=q3=현자의 반지","=q3=수호자의 고리","=q3=의무의 룬","=q3=완수의 룬","=q3=파수꾼의 칼날","=q3=수호자의 검","=q3=현자의 지팡이","=q3=길잡이의 활","","=q4=드리아드의 손목띠","=q4=숲추적자의 팔보호구","=q4=바람지기의 손목보호대","=q4=광전사의 팔보호구","=q3=전투치유사의 망토","=q3=정찰병의 메달","=q3=조언자의 반지","=q3=용사의 고리","=q3=의무의 룬","=q3=완수의 룬","=q3=정찰병의 칼날","=q3=용사의 검","=q3=조언자의 옹이진 지팡이","=q3=수색병의 활"})
Process("WSG5059",28,{"","=q4=드리아드의 손목띠","=q4=숲추적자의 팔보호구","=q4=바람지기의 손목보호대","=q4=광전사의 팔보호구","=q3=청지기의 단망토","=q3=파수꾼의 메달","=q3=현자의 반지","=q3=수호자의 고리","=q3=파수꾼의 칼날","=q3=수호자의 검","=q3=현자의 지팡이","=q3=길잡이의 활","","","","=q4=드리아드의 손목띠","=q4=숲추적자의 팔보호구","=q4=바람지기의 손목보호대","=q4=광전사의 팔보호구","=q3=전투치유사의 망토","=q3=정찰병의 메달","=q3=조언자의 반지","=q3=용사의 고리","=q3=정찰병의 칼날","=q3=용사의 검","=q3=조언자의 옹이진 지팡이","=q3=수색병의 활"})
Process("WSG60",27,{"","=q4=드리아드의 손목띠","=q4=파수꾼의 비단 다리보호구","=q4=숲추적자의 팔보호구","=q4=파수꾼의 가죽 바지","=q4=파수꾼의 도마뱀가죽 바지","=q4=바람지기의 손목보호대","=q4=파수꾼의 사슬 다리보호구","=q4=파수꾼의 쇠사슬 다리보호구","=q4=광전사의 팔보호구","=q4=파수꾼의 강철 다리보호대","=q4=파수꾼의 판금 다리보호대","","","","","=q4=드리아드의 손목띠","=q4=수색병의 비단 다리보호구","=q4=숲추적자의 팔보호구","=q4=수색병의 가죽 바지","=q4=수색병의 도마뱀가죽 바지","=q4=바람지기의 손목보호대","=q4=수색병의 사슬 다리보호구","=q4=수색병의 쇠사슬 다리보호구","=q4=광전사의 팔보호구","=q4=수색병의 강철 다리갑옷","=q4=수색병의 판금 다리보호대"})
Process("WSGMisc",24,{"","=q1=은빛날개 전투 휘장","","","=q1=일급 치유 비약","=q1=최상급 치유 비약","=q1=전쟁노래 협곡 비상 휴대식량","=q1=전쟁노래 협곡 야전 휴대식량","=q1=전쟁노래 협곡 마법 붕대","","","","","","","","=q1=전쟁노래 전투 휘장","","","=q1=일급 마나 비약","=q1=최상급 마나 비약","=q1=전쟁노래 협곡 전투 휴대식량","=q1=전쟁노래 협곡 룬매듭 붕대","=q1=전쟁노래 협곡 비단 붕대"})
end
