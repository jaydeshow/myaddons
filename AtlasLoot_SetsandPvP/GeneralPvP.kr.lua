﻿--[[
--AtlasLoot loot tables koKR localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--$Date: 2008-05-21 11:00:19 -0400 (Wed, 21 May 2008) $
--]]
if (GetLocale() == "koKR") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootGeneralPvPItems"][category] or #AtlasLoot_Data["AtlasLootGeneralPvPItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootGeneralPvPItems"][category][i][3] = data[i] end end data = nil end
Process("Arena1Weapons1",25,{"=q4=검투사의 오른갈퀴","=q4=검투사의 왼갈퀴","=q4=검투사의 마법검","=q4=검투사의 단도","=q4=검투사의 비수","=q4=검투사의 절단검","=q4=검투사의 쾌검","=q4=검투사의 대검","=q4=검투사의 클레버","=q4=검투사의 톱날도끼","=q4=검투사의 참수도끼","=q4=검투사의 망치","=q4=검투사의 구원봉","=q4=검투사의 뾰족철퇴","=q4=검투사의 파쇄기","=q4=검투사의 분쇄기","=q4=검투사의 마울","=q4=검투사의 내릴톱","=q4=검투사의 전쟁 지팡이","=q4=검투사의 철벽방패","=q4=검투사의 투척용 도끼","=q4=검투사의 강화석궁","=q4=검투사의 타도의 손길","=q4=검투사의 병법서","=q4=검투사의 구원서"})
Process("Arena1Weapons2",9,{"=q4=검투사의 결의의 우상","=q4=검투사의 불변의 우상","=q4=검투사의 불굴의 우상","=q4=검투사의 인내의 성서","=q4=검투사의 정의의 성서","=q4=검투사의 복수의 성서","=q4=검투사의 불굴의 토템","=q4=검투사의 생존의 토템","=q4=검투사의 다시 부는 바람의 토템"})
Process("Arena2Druid",21,{"","=q4=무자비한 검투사의 용가죽 투구","=q4=무자비한 검투사의 용가죽 어깨갑옷","=q4=무자비한 검투사의 용가죽 튜닉","=q4=무자비한 검투사의 용가죽 장갑","=q4=무자비한 검투사의 용가죽 다리보호대","","","=q4=무자비한 검투사의 고룡가죽 투구","=q4=무자비한 검투사의 고룡가죽 어깨갑옷","=q4=무자비한 검투사의 고룡가죽 튜닉","=q4=무자비한 검투사의 고룡가죽 장갑","=q4=무자비한 검투사의 고룡가죽 다리보호대","","","","=q4=무자비한 검투사의 코도가죽 투구","=q4=무자비한 검투사의 코도가죽 어깨갑옷","=q4=무자비한 검투사의 코도가죽 튜닉","=q4=무자비한 검투사의 코도가죽 장갑","=q4=무자비한 검투사의 코도가죽 다리보호대"})
Process("Arena2Hunter",6,{"","=q4=무자비한 검투사의 사슬 투구","=q4=무자비한 검투사의 사슬 어깨갑옷","=q4=무자비한 검투사의 사슬 갑옷","=q4=무자비한 검투사의 사슬 건틀릿","=q4=무자비한 검투사의 사슬 다리보호구"})
Process("Arena2Mage",6,{"","=q4=무자비한 검투사의 비단 두건","=q4=무자비한 검투사의 비단 아미스","=q4=무자비한 검투사의 비단 의복","=q4=무자비한 검투사의 비단 손보호구","=q4=무자비한 검투사의 비단 바지"})
Process("Arena2Paladin",21,{"","=q4=무자비한 검투사의 강철 투구","=q4=무자비한 검투사의 강철 어깨보호구","=q4=무자비한 검투사의 강철 가슴보호대","=q4=무자비한 검투사의 강철 건틀릿","=q4=무자비한 검투사의 강철 다리보호대","","","=q4=무자비한 검투사의 미늘 투구","=q4=무자비한 검투사의 미늘 어깨보호구","=q4=무자비한 검투사의 미늘 가슴보호대","=q4=무자비한 검투사의 미늘 건틀릿","=q4=무자비한 검투사의 미늘 다리보호대","","","","=q4=무자비한 검투사의 문장 면갑","=q4=무자비한 검투사의 문장 어깨갑옷","=q4=무자비한 검투사의 문장 가슴보호구","=q4=무자비한 검투사의 문장 장갑","=q4=무자비한 검투사의 문장 다리갑옷"})
Process("Arena2Priest",13,{"","=q4=무자비한 검투사의 명주 두건","=q4=무자비한 검투사의 명주 어깨보호대","=q4=무자비한 검투사의 명주 로브","=q4=무자비한 검투사의 명주 장갑","=q4=무자비한 검투사의 명주 다리보호구","","","=q4=무자비한 검투사의 달빛매듭 두건","=q4=무자비한 검투사의 달빛매듭 어깨보호대","=q4=무자비한 검투사의 달빛매듭 로브","=q4=무자비한 검투사의 달빛매듭 장갑","=q4=무자비한 검투사의 달빛매듭 다리보호구"})
Process("Arena2Rogue",6,{"","=q4=무자비한 검투사의 가죽 투구","=q4=무자비한 검투사의 가죽 어깨갑옷","=q4=무자비한 검투사의 가죽 튜닉","=q4=무자비한 검투사의 가죽 장갑","=q4=무자비한 검투사의 가죽 다리보호대"})
Process("Arena2Shaman",21,{"","=q4=무자비한 검투사의 사슬매듭 투구","=q4=무자비한 검투사의 사슬매듭 어깨갑옷","=q4=무자비한 검투사의 사슬매듭 갑옷","=q4=무자비한 검투사의 사슬매듭 건틀릿","=q4=무자비한 검투사의 사슬매듭 다리보호구","","","=q4=무자비한 검투사의 쇠사슬 투구","=q4=무자비한 검투사의 쇠사슬 어깨갑옷","=q4=무자비한 검투사의 쇠사슬 갑옷","=q4=무자비한 검투사의 쇠사슬 건틀릿","=q4=무자비한 검투사의 쇠사슬 다리보호구","","","","=q4=무자비한 검투사의 고리사슬 투구","=q4=무자비한 검투사의 고리사슬 어깨갑옷","=q4=무자비한 검투사의 고리사슬 갑옷","=q4=무자비한 검투사의 고리사슬 건틀릿","=q4=무자비한 검투사의 고리사슬 다리보호구"})
Process("Arena2Warlock",13,{"","=q4=무자비한 검투사의 공포매듭 두건","=q4=무자비한 검투사의 공포매듭 어깨보호대","=q4=무자비한 검투사의 공포매듭 로브","=q4=무자비한 검투사의 공포매듭 장갑","=q4=무자비한 검투사의 공포매듭 다리보호구","","","=q4=무자비한 검투사의 지옥매듭 두건","=q4=무자비한 검투사의 지옥매듭 아미스","=q4=무자비한 검투사의 지옥매듭 의복","=q4=무자비한 검투사의 지옥매듭 손보호구","=q4=무자비한 검투사의 지옥매듭 바지"})
Process("Arena2Warrior",6,{"","=q4=무자비한 검투사의 판금 투구","=q4=무자비한 검투사의 판금 어깨보호구","=q4=무자비한 검투사의 판금 흉갑","=q4=무자비한 검투사의 판금 건틀릿","=q4=무자비한 검투사의 판금 다리보호대"})
Process("Arena2Weapons1",27,{"=q4=무자비한 검투사의 오른갈퀴","=q4=무자비한 검투사의 왼갈퀴","=q4=무자비한 검투사의 마법검","=q4=무자비한 검투사의 단도","=q4=무자비한 검투사의 비수","=q4=무자비한 검투사의 절단검","=q4=무자비한 검투사의 쾌검","=q4=무자비한 검투사의 대검","=q4=무자비한 검투사의 클레버","=q4=무자비한 검투사의 톱날도끼","=q4=무자비한 검투사의 참수도끼","=q4=무자비한 검투사의 망치","=q4=무자비한 검투사의 구원봉","=q4=무자비한 검투사의 뾰족철퇴","=q4=무자비한 검투사의 파쇄기","=q4=무자비한 검투사의 해골망치","=q4=무자비한 검투사의 마울","=q4=무자비한 검투사의 내릴톱","=q4=무자비한 검투사의 전쟁 지팡이","=q4=무자비한 검투사의 방벽 방패","=q4=무자비한 검투사의 보루방패","=q4=무자비한 검투사의 철벽방패","=q4=무자비한 검투사의 투척용 도끼","=q4=무자비한 검투사의 불사조 강화석궁","=q4=무자비한 검투사의 타도의 손길","=q4=무자비한 검투사의 병법서","=q4=무자비한 검투사의 구원서"})
Process("Arena2Weapons2",9,{"=q4=무자비한 검투사의 결의의 우상","=q4=무자비한 검투사의 불변의 우상","=q4=무자비한 검투사의 인내의 우상","=q4=무자비한 검투사의 인내의 성서","=q4=무자비한 검투사의 정의의 성서","=q4=무자비한 검투사의 복수의 성서","=q4=무자비한 검투사의 불굴의 토템","=q4=무자비한 검투사의 생존의 토템","=q4=무자비한 검투사의 다시 부는 바람의 토템"})
Process("Arena3Druid",21,{"","=q4=복수심에 불타는 검투사의 용가죽 투구","=q4=복수심에 불타는 검투사의 용가죽 어깨갑옷","=q4=복수심에 불타는 검투사의 용가죽 튜닉","=q4=복수심에 불타는 검투사의 용가죽 장갑","=q4=복수심에 불타는 검투사의 용가죽 다리보호대","","","=q4=복수심에 불타는 검투사의 고룡가죽 투구","=q4=복수심에 불타는 검투사의 고룡가죽 어깨갑옷","=q4=복수심에 불타는 검투사의 고룡가죽 튜닉","=q4=복수심에 불타는 검투사의 고룡가죽 장갑","=q4=복수심에 불타는 검투사의 고룡가죽 다리보호대","","","","=q4=복수심에 불타는 검투사의 코도가죽 투구","=q4=복수심에 불타는 검투사의 코도가죽 어깨갑옷","=q4=복수심에 불타는 검투사의 코도가죽 조끼","=q4=복수심에 불타는 검투사의 코도가죽 장갑","=q4=복수심에 불타는 검투사의 코도가죽 다리보호대"})
Process("Arena3Hunter",6,{"","=q4=복수심에 불타는 검투사의 사슬 투구","=q4=복수심에 불타는 검투사의 사슬 어깨갑옷","=q4=복수심에 불타는 검투사의 사슬 갑옷","=q4=복수심에 불타는 검투사의 사슬 건틀릿","=q4=복수심에 불타는 검투사의 사슬 다리보호구"})
Process("Arena3Mage",6,{"","=q4=복수심에 불타는 검투사의 비단 두건","=q4=복수심에 불타는 검투사의 비단 아미스","=q4=복수심에 불타는 검투사의 비단 의복","=q4=복수심에 불타는 검투사의 비단 손보호대","=q4=복수심에 불타는 검투사의 비단 바지"})
Process("Arena3Paladin",21,{"","=q4=복수심에 불타는 검투사의 강철 투구","=q4=복수심에 불타는 검투사의 강철 어깨보호구","=q4=복수심에 불타는 검투사의 강철 흉갑","=q4=복수심에 불타는 검투사의 강철 건틀릿","=q4=복수심에 불타는 검투사의 강철 다리보호대","","","=q4=복수심에 불타는 검투사의 미늘 투구","=q4=복수심에 불타는 검투사의 미늘 어깨보호구","=q4=복수심에 불타는 검투사의 미늘 흉갑","=q4=복수심에 불타는 검투사의 미늘 건틀릿","=q4=복수심에 불타는 검투사의 미늘 다리보호대","","","","=q4=복수심에 불타는 검투사의 문장 면갑","=q4=복수심에 불타는 검투사의 문장 어깨갑옷","=q4=복수심에 불타는 검투사의 문장 가슴보호구","=q4=복수심에 불타는 검투사의 문장 장갑","=q4=복수심에 불타는 검투사의 문장 다리갑옷"})
Process("Arena3Priest",13,{"","=q4=복수심에 불타는 검투사의 명주 두건","=q4=복수심에 불타는 검투사의 명주 어깨보호대","=q4=복수심에 불타는 검투사의 명주 로브","=q4=복수심에 불타는 검투사의 명주 장갑","=q4=복수심에 불타는 검투사의 명주 다리보호구","","","=q4=복수심에 불타는 검투사의 달빛매듭 두건","=q4=복수심에 불타는 검투사의 달빛매듭 어깨보호대","=q4=복수심에 불타는 검투사의 달빛매듭 로브","=q4=복수심에 불타는 검투사의 달빛매듭 장갑","=q4=복수심에 불타는 검투사의 달빛매듭 다리보호구"})
Process("Arena3Rogue",6,{"","=q4=복수심에 불타는 검투사의 가죽 투구","=q4=복수심에 불타는 검투사의 가죽 어깨갑옷","=q4=복수심에 불타는 검투사의 가죽 튜닉","=q4=복수심에 불타는 검투사의 가죽 장갑","=q4=복수심에 불타는 검투사의 가죽 다리보호대"})
Process("Arena3Shaman",21,{"","=q4=복수심에 불타는 검투사의 사슬매듭 투구","=q4=복수심에 불타는 검투사의 사슬매듭 어깨갑옷","=q4=복수심에 불타는 검투사의 사슬매듭 갑옷","=q4=복수심에 불타는 검투사의 사슬매듭 건틀릿","=q4=복수심에 불타는 검투사의 사슬매듭 다리보호구","","","=q4=복수심에 불타는 검투사의 쇠사슬 투구","=q4=복수심에 불타는 검투사의 쇠사슬 어깨갑옷","=q4=복수심에 불타는 검투사의 쇠사슬 갑옷","=q4=복수심에 불타는 검투사의 쇠사슬 건틀릿","=q4=복수심에 불타는 검투사의 쇠사슬 다리보호구","","","","=q4=복수심에 불타는 검투사의 고리사슬 투구","=q4=복수심에 불타는 검투사의 고리사슬 어깨갑옷","=q4=복수심에 불타는 검투사의 고리사슬 갑옷","=q4=복수심에 불타는 검투사의 고리사슬 건틀릿","=q4=복수심에 불타는 검투사의 고리사슬 다리보호구"})
Process("Arena3Warlock",13,{"","=q4=복수심에 불타는 검투사의 공포매듭 두건","=q4=복수심에 불타는 검투사의 공포매듭 어깨보호대","=q4=복수심에 불타는 검투사의 공포매듭 로브","=q4=복수심에 불타는 검투사의 공포매듭 장갑","=q4=복수심에 불타는 검투사의 공포매듭 다리보호구","","","=q4=복수심에 불타는 검투사의 지옥매듭 두건","=q4=복수심에 불타는 검투사의 지옥매듭 아미스","=q4=복수심에 불타는 검투사의 지옥매듭 의복","=q4=복수심에 불타는 검투사의 지옥매듭 장갑","=q4=복수심에 불타는 검투사의 지옥매듭 바지"})
Process("Arena3Warrior",6,{"","=q4=복수심에 불타는 검투사의 판금 투구","=q4=복수심에 불타는 검투사의 판금 어깨보호구","=q4=복수심에 불타는 검투사의 판금 흉갑","=q4=복수심에 불타는 검투사의 판금 건틀릿","=q4=복수심에 불타는 검투사의 판금 다리보호대"})
Process("Arena3Weapons1",24,{"=q4=복수심에 불타는 검투사의 오른갈퀴","=q4=복수심에 불타는 검투사의 왼갈퀴","=q4=복수심에 불타는 검투사의 왼손 분쇄기","=q4=복수심에 불타는 검투사의 마법검","=q4=복수심에 불타는 검투사의 단도","=q4=복수심에 불타는 검투사의 난도질 검","=q4=복수심에 불타는 검투사의 비수","=q4=복수심에 불타는 검투사의 절단검","=q4=복수심에 불타는 검투사의 쾌검","=q4=복수심에 불타는 검투사의 대검","=q4=복수심에 불타는 검투사의 클레버","=q4=복수심에 불타는 검투사의 도끼","=q4=복수심에 불타는 검투사의 톱날도끼","=q4=복수심에 불타는 검투사의 참수도끼","=q4=복수심에 불타는 검투사의 전투도끼","=q4=복수심에 불타는 검투사의 망치","=q4=복수심에 불타는 검투사의 구원봉","=q4=복수심에 불타는 검투사의 뾰족철퇴","=q4=복수심에 불타는 검투사의 파쇄기","=q4=복수심에 불타는 검투사의 해골망치","=q4=복수심에 불타는 검투사의 내릴톱","=q4=복수심에 불타는 검투사의 전투 지팡이","=q4=복수심에 불타는 검투사의 지팡이","=q4=복수심에 불타는 검투사의 전쟁 지팡이"})
Process("Arena3Weapons2",24,{"=q4=복수심에 불타는 검투사의 방벽 방패","=q4=복수심에 불타는 검투사의 보루 방패","=q4=복수심에 불타는 검투사의 철벽 방패","=q4=복수심에 불타는 검투사의 투척용 도끼","=q4=복수심에 불타는 검투사의 장궁","=q4=복수심에 불타는 검투사의 강화석궁","=q4=복수심에 불타는 검투사의 라이플","=q4=복수심에 불타는 검투사의 빛의 지휘봉","=q4=복수심에 불타는 검투사의 사무치는 손길","=q4=복수심에 불타는 검투사의 타도의 손길","=q4=복수심에 불타는 검투사의 병법서","=q4=복수심에 불타는 검투사의 흑마법서","=q4=복수심에 불타는 검투사의 구원서","","","=q4=복수심에 불타는 검투사의 결의의 우상","=q4=복수심에 불타는 검투사의 불변의 우상","=q4=복수심에 불타는 검투사의 인내의 우상","=q4=복수심에 불타는 검투사의 인내의 성서","=q4=복수심에 불타는 검투사의 정의의 성서","=q4=복수심에 불타는 검투사의 복수의 성서","=q4=복수심에 불타는 검투사의 불굴의 토템","=q4=복수심에 불타는 검투사의 생존의 토템","=q4=복수심에 불타는 검투사의 다시 부는 바람의 토템"})
Process("ArenaDruid",21,{"","=q4=검투사의 용가죽 투구","=q4=검투사의 용가죽 어깨갑옷","=q4=검투사의 용가죽 튜닉","=q4=검투사의 용가죽 장갑","=q4=검투사의 용가죽 다리보호대","","","=q4=검투사의 고룡가죽 투구","=q4=검투사의 고룡가죽 어깨갑옷","=q4=검투사의 고룡가죽 튜닉","=q4=검투사의 고룡가죽 장갑","=q4=검투사의 고룡가죽 다리보호대","","","","=q4=검투사의 코도가죽 투구","=q4=검투사의 코도가죽 어깨갑옷","=q4=검투사의 코도가죽 튜닉","=q4=검투사의 코도가죽 장갑","=q4=검투사의 코도가죽 다리보호대"})
Process("ArenaHunter",6,{"","=q4=검투사의 사슬 투구","=q4=검투사의 사슬 어깨갑옷","=q4=검투사의 사슬 갑옷","=q4=검투사의 사슬 건틀릿","=q4=검투사의 사슬 다리보호구"})
Process("ArenaMage",6,{"","=q4=검투사의 비단 두건","=q4=검투사의 비단 아미스","=q4=검투사의 비단 의복","=q4=검투사의 비단 손보호대","=q4=검투사의 비단 바지"})
Process("ArenaPaladin",21,{"","=q4=검투사의 강철 투구","=q4=검투사의 강철 어깨보호구","=q4=검투사의 강철 흉갑","=q4=검투사의 강철 건틀릿","=q4=검투사의 강철 다리보호대","","","=q4=검투사의 미늘 투구","=q4=검투사의 미늘 어깨보호구","=q4=검투사의 미늘 흉갑","=q4=검투사의 미늘 건틀릿","=q4=검투사의 미늘 다리보호대","","","","=q4=검투사의 문장 면갑","=q4=검투사의 문장 어깨갑옷","=q4=검투사의 문장 가슴보호구","=q4=검투사의 문장 장갑","=q4=검투사의 문장 다리갑옷"})
Process("ArenaPriest",13,{"","=q4=검투사의 명주 두건","=q4=검투사의 명주 어깨보호대","=q4=검투사의 명주 로브","=q4=검투사의 명주 장갑","=q4=검투사의 명주 다리보호구","","","=q4=검투사의 달빛매듭 두건","=q4=검투사의 달빛매듭 어깨보호대","=q4=검투사의 달빛매듭 로브","=q4=검투사의 달빛매듭 장갑","=q4=검투사의 달빛매듭 다리보호구"})
Process("ArenaRogue",6,{"","=q4=검투사의 가죽 투구","=q4=검투사의 가죽 어깨갑옷","=q4=검투사의 가죽 튜닉","=q4=검투사의 가죽 장갑","=q4=검투사의 가죽 다리보호대"})
Process("ArenaShaman",21,{"","=q4=검투사의 사슬매듭 투구","=q4=검투사의 사슬매듭 어깨갑옷","=q4=검투사의 사슬매듭 갑옷","=q4=검투사의 사슬매듭 건틀릿","=q4=검투사의 사슬매듭 다리보호구","","","=q4=검투사의 쇠사슬 투구","=q4=검투사의 쇠사슬 어깨갑옷","=q4=검투사의 쇠사슬 갑옷","=q4=검투사의 쇠사슬 건틀릿","=q4=검투사의 쇠사슬 다리보호구","","","","=q4=검투사의 고리사슬 투구","=q4=검투사의 고리사슬 어깨갑옷","=q4=검투사의 고리사슬 갑옷","=q4=검투사의 고리사슬 건틀릿","=q4=검투사의 고리사슬 다리보호구"})
Process("ArenaWarlock",13,{"","=q4=검투사의 공포매듭 두건","=q4=검투사의 공포매듭 어깨보호대","=q4=검투사의 공포매듭 로브","=q4=검투사의 공포매듭 장갑","=q4=검투사의 공포매듭 다리보호구","","","=q4=검투사의 지옥매듭 두건","=q4=검투사의 지옥매듭 아미스","=q4=검투사의 지옥매듭 의복","=q4=검투사의 지옥매듭 장갑","=q4=검투사의 지옥매듭 바지"})
Process("ArenaWarrior",6,{"","=q4=검투사의 판금 투구","=q4=검투사의 판금 어깨보호구","=q4=검투사의 판금 흉갑","=q4=검투사의 판금 건틀릿","=q4=검투사의 판금 다리보호대"})
Process("PVP70RepDruid",21,{"","=q3=용가죽 투구","=q3=용가죽 어깨갑옷","=q3=용가죽 로브","=q3=용가죽 장갑","=q3=용가죽 다리보호대","","","=q3=고룡가죽 투구","=q3=고룡가죽 어깨보호대","=q3=고룡가죽 로브","=q3=고룡가죽 장갑","=q3=고룡가죽 다리보호대","","","","=q3=코도가죽 투구","=q3=코도가죽 어깨갑옷","=q3=코도가죽 로브","=q3=코도가죽 장갑","=q3=코도가죽 다리보호대"})
Process("PVP70RepHunter",6,{"","=q3=추적자의 사슬 투구","=q3=추적자의 사슬 어깨갑옷","=q3=추적자의 사슬 갑옷","=q3=추적자의 사슬 건틀릿","=q3=추적자의 사슬 다리보호구"})
Process("PVP70RepMage",6,{"","=q3=마법술사의 비단 두건","=q3=마법술사의 비단 아미스","=q3=마법술사의 비단 의복","=q3=마법술사의 비단 장갑","=q3=마법술사의 비단 바지"})
Process("PVP70RepPaladin",13,{"","=q3=성전사의 미늘 투구","=q3=성전사의 미늘 어깨보호구","=q3=성전사의 미늘 흉갑","=q3=성전사의 미늘 건틀릿","=q3=성전사의 미늘 다리보호대","","","=q3=성전사의 문장 머리보호구","=q3=성전사의 문장 어깨갑옷","=q3=성전사의 문장 가슴갑옷","=q3=성전사의 문장 장갑","=q3=성전사의 문장 다리보호구"})
Process("PVP70RepPriest",13,{"","=q3=명주 두건","=q3=명주 어깨보호대","=q3=명주 로브","=q3=명주 장갑","=q3=명주 다리보호구","","","=q3=달빛매듭 두건","=q3=달빛매듭 어깨보호대","=q3=달빛매듭 의복","=q3=달빛매듭 전투 장갑","=q3=달빛매듭 다리보호대"})
Process("PVP70RepRogue",6,{"","=q3=기회주의자의 가죽 투구","=q3=기회주의자의 가죽 어깨갑옷","=q3=기회주의자의 가죽 튜닉","=q3=기회주의자의 가죽 장갑","=q3=기회주의자의 가죽 다리보호대"})
Process("PVP70RepShaman",21,{"","=q3=예언자의 사슬매듭 투구","=q3=예언자의 사슬매듭 어깨갑옷","=q3=예언자의 사슬매듭 갑옷","=q3=예언자의 사슬매듭 건틀릿","=q3=예언자의 사슬매듭 다리보호구","","","=q3=예언자의 쇠사슬 투구","=q3=예언자의 쇠사슬 어깨갑옷","=q3=예언자의 쇠사슬 갑옷","=q3=예언자의 쇠사슬 건틀릿","=q3=예언자의 쇠사슬 다리보호구","","","","=q3=예언자의 고리사슬 투구","=q3=예언자의 고리사슬 어깨보호구","=q3=예언자의 고리사슬 흉갑","=q3=예언자의 고리사슬 장갑","=q3=예언자의 고리사슬 다리보호구"})
Process("PVP70RepWarlock",6,{"","=q3=공포매듭 두건","=q3=공포매듭 어깨보호대","=q3=공포매듭 로브","=q3=공포매듭 장갑","=q3=공포매듭 다리보호구"})
Process("PVP70RepWarrior",6,{"","=q3=야만의 판금 투구","=q3=야만의 판금 어깨보호구","=q3=야만의 판금 흉갑","=q3=야만의 판금 건틀릿","=q3=야만의 판금 다리보호대"})
Process("PVP70Weapons1",29,{"","=q3=최고사령관의 오른갈퀴","=q3=최고사령관의 왼갈퀴","=q3=최고사령관의 마법단검","=q3=최고사령관의 단도","=q3=최고사령관의 비수","=q3=최고사령관의 절단검","=q3=최고사령관의 쾌검","=q3=최고사령관의 전투검","=q3=최고사령관의 클레버","=q3=최고사령관의 톱날도끼","=q3=최고사령관의 참수도끼","=q3=최고사령관의 파쇄기","=q3=최고사령관의 뾰족철퇴","","","=q3=대장군의 오른갈퀴","=q3=대장군의 왼갈퀴","=q3=대장군의 마법검","=q3=대장군의 단도","=q3=대장군의 단검","=q3=대장군의 절단검","=q3=대장군의 쾌검","=q3=대장군의 클레이모어","=q3=대장군의 클레버","=q3=대장군의 톱날도끼","=q3=대장군의 참수도끼","=q3=대장군의 파쇄기","=q3=대장군의 뾰족철퇴"})
Process("PVP70Weapons2",23,{"","=q3=최고사령관의 해골망치","=q3=최고사령관의 마울","=q3=최고사령관의 내릴톱","=q3=최고사령관의 전쟁 지팡이","=q3=최고사령관의 보루 방패","=q3=최고사령관의 강화석궁","=q3=최고사령관의 전투 고서","","","","","","","","","=q3=대장군의 해골망치","=q3=대장군의 마울","=q3=대장군의 내릴톱","=q3=대장군의 전쟁 지팡이","=q3=대장군의 보루 방패","=q3=대장군의 강화석궁","=q3=대장군의 전투 고서"})
Process("PVPDruid",30,{"","=q4=야전사령관의 용가죽 투구","=q4=야전사령관의 용가죽 어깨갑옷","=q4=야전사령관의 용가죽 흉갑","=q4=작전사령관의 용가죽 건틀릿","=q4=작전사령관의 용가죽 다리보호대","=q4=작전사령관의 용가죽 장화","","","=q3=부사령관의 용가죽 머리보호구","=q3=부사령관의 용가죽 어깨보호구","=q3=기사대장의 용가죽 흉갑","=q3=상급기사의 용가죽 고리장갑","=q3=기사대장의 용가죽 다리보호구","=q3=상급기사의 용가죽 발보호대","","=q4=장군의 용가죽 투구","=q4=장군의 용가죽 견장","=q4=장군의 용가죽 갑옷","=q4=전투사령관의 용가죽 장갑","=q4=전투사령관의 용가죽 다리보호구","=q4=전투사령관의 용가죽 장화","","","=q3=부사령관의 용가죽 머리보호구","=q3=부사령관의 용가죽 어깨보호구","=q3=용사의 용가죽 갑옷","=q3=혈투사의 용가죽 장갑","=q3=용사의 용가죽 다리보호구","=q3=혈투사의 용가죽 신발"})
Process("PVPHunter",30,{"","=q4=야전사령관의 사슬 투구","=q4=야전사령관의 사슬 어깨갑옷","=q4=야전사령관의 사슬 흉갑","=q4=작전사령관의 사슬 장갑","=q4=작전사령관의 사슬 다리보호대","=q4=작전사령관의 사슬 장화","","","=q3=부사령관의 사슬 면갑","=q3=부사령관의 사슬 어깨보호구","=q3=기사대장의 사슬 갑옷","=q3=상급기사의 사슬 장갑","=q3=기사대장의 사슬 다리갑옷","=q3=상급기사의 사슬 경갑","","=q4=장군의 사슬 투구","=q4=장군의 사슬 어깨보호구","=q4=장군의 사슬 흉갑","=q4=전투사령관의 사슬 장갑","=q4=전투사령관의 사슬 다리보호대","=q4=전투사령관의 사슬 장화","","","=q3=부사령관의 사슬 투구","=q3=부사령관의 사슬 어깨보호구","=q3=용사의 사슬 갑옷","=q3=혈투사의 사슬 장갑","=q3=용사의 사슬 다리보호대","=q3=혈투사의 사슬 경갑"})
Process("PVPMage",30,{"","=q4=야전사령관의 화관","=q4=야전사령관의 비단 어깨갑옷","=q4=야전사령관의 비단 의복","=q4=작전사령관의 비단 장갑","=q4=작전사령관의 비단 다리보호구","=q4=작전사령관의 비단 장화","","","=q3=부사령관의 비단 두건","=q3=부사령관의 비단 어깨보호대","=q3=기사대장의 비단 튜닉","=q3=상급기사의 비단 손보호구","=q3=기사대장의 비단 다리보호대","=q3=상급기사의 비단 덧신","","=q4=장군의 비단 두건","=q4=장군의 비단 아미스","=q4=장군의 비단 의복","=q4=전투사령관의 비단 장갑","=q4=전투사령관의 비단 바지","=q4=전투사령관의 비단 장화","","","=q3=부사령관의 비단 머리보호구","=q3=부사령관의 비단 어깨보호대","=q3=용사의 비단 튜닉","=q3=혈투사의 비단 손보호구","=q3=용사의 비단 다리보호대","=q3=혈투사의 비단 발보호구"})
Process("PVPPaladin",30,{"","=q4=야전사령관의 강철 면갑","=q4=야전사령관의 강철 어깨갑옷","=q4=야전사령관의 강철 흉갑","=q4=작전사령관의 강철 장갑","=q4=작전사령관의 강철 다리갑옷","=q4=작전사령관의 강철 장화","","","=q3=부사령관의 강철 머리보호구","=q3=부사령관의 강철 어깨보호구","=q3=기사대장의 강철 흉갑","=q3=상급기사의 강철 건틀릿","=q3=기사대장의 강철 다리보호구","=q3=상급기사의 강철 발덮개","","=q4=장군의 강철 면갑","=q4=장군의 강철 어깨갑옷","=q4=장군의 강철 가슴갑옷","=q4=전투사령관의 강철 장갑","=q4=전투사령관의 강철 다리갑옷","=q4=전투사령관의 강철 장화","","","=q3=부사령관의 강철 머리보호구","=q3=부사령관의 강철 어깨보호구","=q3=용사의 강철 흉갑","=q3=혈투사의 강철 건틀릿","=q3=용사의 강철 다리보호구","=q3=혈투사의 강철 발덮개"})
Process("PVPPriest",30,{"","=q4=야전사령관의 머리장식","=q4=야전사령관의 명주 어깨보호대","=q4=야전사령관의 명주 의복","=q4=작전사령관의 명주 장갑","=q4=작전사령관의 명주 바지","=q4=작전사령관의 명주 샌들","","","=q3=부사령관의 명주 두건","=q3=부사령관의 명주 어깨보호대","=q3=기사대장의 명주 튜닉","=q3=상급기사의 명주 손보호구","=q3=기사대장의 명주 다리보호대","=q3=상급기사의 명주 덧신","","=q4=장군의 명주 두건","=q4=장군의 명주 어깨보호대","=q4=장군의 명주 로브","=q4=전투사령관의 명주 장갑","=q4=전투사령관의 명주 다리보호구","=q4=전투사령관의 명주 장화","","","=q3=부사령관의 명주 머리보호구","=q3=부사령관의 명주 어깨보호대","=q3=용사의 명주 튜닉","=q3=혈투사의 명주 손보호구","=q3=용사의 명주 다리보호대","=q3=혈투사의 명주 발보호구"})
Process("PVPRogue",30,{"","=q4=야전사령관의 가죽 복면","=q4=야전사령관의 가죽 견장","=q4=야전사령관의 가죽 흉갑","=q4=작전사령관의 가죽 장갑","=q4=작전사령관의 가죽 다리보호구","=q4=작전사령관의 가죽 경갑","","","=q3=부사령관의 가죽 면갑","=q3=부사령관의 가죽 어깨보호구","=q3=기사대장의 가죽 흉갑","=q3=상급기사의 가죽 손보호구","=q3=기사대장의 가죽 다리보호대","=q3=상급기사의 가죽 덧신","","=q4=장군의 가죽 투구","=q4=장군의 가죽 어깨갑옷","=q4=장군의 가죽 흉갑","=q4=전투사령관의 가죽 장갑","=q4=전투사령관의 가죽 다리보호대","=q4=전투사령관의 가죽 장화","","","=q3=부사령관의 가죽 투구","=q3=부사령관의 가죽 어깨보호구","=q3=용사의 가죽 흉갑","=q3=혈투사의 가죽 손보호구","=q3=용사의 가죽 다리보호대","=q3=혈투사의 가죽 발보호구"})
Process("PVPShaman",30,{"","=q4=야전사령관의 쇠사슬 투구","=q4=야전사령관의 쇠사슬 어깨갑옷","=q4=야전사령관의 쇠사슬 갑옷","=q4=작전사령관의 쇠사슬 건틀릿","=q4=작전사령관의 쇠사슬 다리보호구","=q4=작전사령관의 쇠사슬 장화","","","=q3=부사령관의 쇠사슬 머리보호구","=q3=부사령관의 쇠사슬 어깨갑옷","=q3=기사대장의 쇠사슬 갑옷","=q3=상급기사의 쇠사슬 장갑","=q3=기사대장의 쇠사슬 다리보호구","=q3=상급기사의 쇠사슬 경갑","","=q4=장군의 쇠사슬 투구","=q4=장군의 쇠사슬 어깨갑옷","=q4=장군의 쇠사슬 갑옷","=q4=전투사령관의 쇠사슬 건틀릿","=q4=전투사령관의 쇠사슬 다리보호구","=q4=전투사령관의 쇠사슬 장화","","","=q3=부사령관의 쇠사슬 머리보호구","=q3=부사령관의 쇠사슬 어깨갑옷","=q3=용사의 쇠사슬 갑옷","=q3=혈투사의 쇠사슬 손보호구","=q3=용사의 쇠사슬 다리보호대","=q3=혈투사의 쇠사슬 경갑"})
Process("PVPWarlock",30,{"","=q4=야전사령관의 화관","=q4=야전사령관의 공포매듭 어깨보호구","=q4=야전사령관의 공포매듭 로브","=q4=작전사령관의 공포매듭 장갑","=q4=작전사령관의 공포매듭 다리보호구","=q4=작전사령관의 공포매듭 장화","","","=q3=부사령관의 공포매듭 두건","=q3=부사령관의 공포매듭 어깨갑옷","=q3=기사대장의 공포매듭 튜닉","=q3=상급기사의 공포매듭 손보호구","=q3=기사대장의 공포매듭 다리보호대","=q3=상급기사의 공포매듭 덧신","","=q4=장군의 공포매듭 두건","=q4=장군의 공포매듭 어깨보호대","=q4=장군의 공포매듭 로브","=q4=전투사령관의 공포매듭 장갑","=q4=전투사령관의 공포매듭 바지","=q4=전투사령관의 공포매듭 장화","","","=q3=부사령관의 공포매듭 머리보호구","=q3=부사령관의 공포매듭 어깨보호대","=q3=용사의 공포매듭 튜닉","=q3=혈투사의 공포매듭 손보호구","=q3=용사의 공포매듭 다리보호대","=q3=혈투사의 공포매듭 발보호구"})
Process("PVPWarrior",30,{"","=q4=야전사령관의 판금 투구","=q4=야전사령관의 판금 어깨갑옷","=q4=야전사령관의 판금 갑옷","=q4=작전사령관의 판금 건틀릿","=q4=작전사령관의 판금 다리보호대","=q4=작전사령관의 판금 장화","","","=q3=부사령관의 판금 투구","=q3=부사령관의 판금 어깨보호구","=q3=기사대장의 판금 갑옷","=q3=상급기사의 판금 건틀릿","=q3=기사대장의 판금 다리보호구","=q3=상급기사의 판금 경갑","","=q4=장군의 판금 투구","=q4=장군의 판금 어깨보호구","=q4=장군의 판금 갑옷","=q4=전투사령관의 판금 건틀릿","=q4=전투사령관의 판금 다리보호구","=q4=전투사령관의 판금 장화","","","=q3=부사령관의 판금 투구","=q3=부사령관의 판금 어깨보호구","=q3=용사의 판금 흉갑","=q3=혈투사의 판금 건틀릿","=q3=용사의 판금 다리보호구","=q3=혈투사의 판금 경갑"})
Process("PVPWeapons1",29,{"","=q4=최고사령관의 오른손칼날","=q4=최고사령관의 왼손칼날","=q4=최고사령관의 마법검","=q4=최고사령관의 더크","=q4=최고사령관의 장검","=q4=최고사령관의 쾌검","=q4=최고사령관의 클레이모어","=q4=최고사령관의 손도끼","=q4=최고사령관의 전투도끼","=q4=최고사령관의 전투해머","=q4=최고사령관의 분쇄기","=q4=최고사령관의 전투 망치","=q4=최고사령관의 파괴자","","","=q4=대장군의 오른발톱","=q4=대장군의 왼발톱","=q4=대장군의 마법검","=q4=대장군의 비수","=q4=대장군의 장검","=q4=대장군의 쾌검","=q4=대장군의 대검","=q4=대장군의 클레버","=q4=대장군의 전투도끼","=q4=대장군의 전투철퇴","=q4=대장군의 곤봉","=q4=대장군의 분쇄기","=q4=대장군의 파괴자"})
Process("PVPWeapons2",24,{"","=q4=최고사령관의 글레이브","=q4=최고사령관의 지팡이","=q4=최고사령관의 아이기스","=q4=최고사령관의 장궁","=q4=최고사령관의 석궁","=q4=최고사령관의 손대포","=q4=최고사령관의 마력의 고서","=q4=최고사령관의 회복의 고서","","","","","","","","=q4=대장군의 장창","=q4=대장군의 전쟁 지팡이","=q4=대장군의 철벽방패","=q4=대장군의 곡궁","=q4=대장군의 석궁","=q4=대장군의 장총","=q4=대장군의 파괴의 고서","=q4=대장군의 치유의 고서"})
Process("PvP60Accessories1",30,{"","=q4=검은 전투기계타조 조종기","=q4=검은 전투산양 고삐","=q4=검은 전투군마 마구","=q4=검은 전투호랑이 고삐","=q4=검은색 전투 엘레크 고삐","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","=q3=얼라이언스 계급장","","=q4=검은 전투코도 발굽","=q4=검은 전투늑대 뿔피리","=q4=붉은 전투해골마 마구","=q4=검은 전투랩터 호루라기","=q4=날쌘 전투 매타조","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장","=q3=호드 계급장"})
Process("PvP60Accessories2",28,{"=q3=근위병의 단망토","=q3=근위병의 단망토","=q3=근위병의 단망토","","=q3=하급투사의 비단 소매장식","=q3=하급기사의 비단 소매장식","","=q3=하급기사의 용가죽 팔보호구","=q3=하급기사의 용가죽 팔보호구","","=q3=하급기사의 가죽 팔보호구","=q3=하급기사의 가죽 팔보호구","","=q3=하급기사의 사슬 손목보호대","=q3=하급기사의 사슬 손목보호대","=q3=하급기사의 판금 손목보호구","=q3=하급기사의 판금 손목보호구","","=q3=정예근위병의 계급장","=q3=정예근위병의 계급장","=q3=정예근위병의 계급장","","=q1=정찰병의 휘장","=q1=기사의 제복","=q1=얼라이언스 전투 깃발","=q1=전투 치유 물약","=q1=전투 마나 물약","=q1=별의 슬픔"})
Process("PvP60Accessories3",28,{"=q3=수호병의 망토","=q3=수호병의 망토","=q3=수호병의 망토","","=q3=하급투사의 비단 소매장식","=q3=하급투사의 비단 소매장식","","=q3=하급투사의 용가죽 손목보호대","=q3=하급투사의 용가죽 손목보호대","","=q3=하급투사의 가죽 손목보호대","=q3=하급투사의 가죽 손목보호대","","=q3=하급투사의 쇠사슬 손목보호구","=q3=하급투사의 쇠사슬 손목보호구","=q3=하급투사의 판금 팔보호구","=q3=하급투사의 판금 팔보호구","","=q3=정예수호병의 계급장","=q3=정예수호병의 계급장","=q3=정예수호병의 계급장","","=q1=척후병의 휘장","=q1=투사의 문장","=q1=호드 전투 깃발","=q1=전투 치유 물약","=q1=전투 마나 물약","=q1=별의 슬픔"})
Process("PvP70Accessories1",29,{"","","=q4=얼라이언스의 부적","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=얼라이언스의 메달","=q3=승리의 고리","=q3=지배의 고리","","","","=q4=호드의 부적","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=호드의 메달","=q3=승리의 고리","=q3=지배의 고리"}) --Missing: 37864, 37865
Process("PvP70Accessories2",23,{"=q4=굵은 화려한 루비","=q4=매끄러운 화려한 여명석","=q4=문자가 새겨진 화려한 토파즈","","=q1=일급 전투 치유 물약","=q1=일급 전투 치유 물약","=q1=일급 전투 마나 물약","=q1=일급 전투 마나 물약","=q1=별의 눈물","","","","","","","=q4=룬이 새겨진 화려한 루비","=q4=번뜩이는 화려한 여명석","=q4=마력이 담긴 화려한 황옥","","=q1=일급 전투 치유 물약","=q1=일급 전투 치유 물약","=q1=일급 전투 마나 물약","=q1=일급 전투 마나 물약"})
Process("PvP70NonSet1",26,{"=q4=수호병의 두꺼운 외투","=q4=수호병의 두꺼운 망토","","=q4=정복의 구원자 펜던트","=q4=지배의 구원자 펜던트","=q4=구조의 구원자 펜던트","=q4=구원자의 구제 펜던트","=q4=평정의 구원자 펜던트","=q4=승리의 구원자 펜던트","","=q4=지배의 역전용사 고리","=q4=구조의 역전용사 고리","=q4=승리의 역전용사 고리","","","=q4=지휘관의 무자비함","=q4=지휘관의 악행","=q4=지휘관의 결단","=q4=지휘관의 기민함","=q4=지휘관의 용맹","=q4=지휘관의 끈기","","=q4=지배의 구원자 고리","=q4=구조의 구원자 고리","=q4=평정의 구원자 고리","=q4=승리의 구원자 고리"})
Process("PvP70NonSet1b",26,{"","","","","","","","","","","=q4=지배의 구원자 고리","=q4=구조의 구원자 고리","=q4=승리의 구원자 고리","=q4=평정의 구원자 고리","","=q4=지휘관의 무자비함","=q4=지휘관의 악행","=q4=지휘관의 결단","=q4=지휘관의 기민함","=q4=지휘관의 용맹","=q4=지휘관의 끈기"}) --Missing: 35129, 35130, 35131, 35132, 35133, 35134, 35135, 37927, 37928, 37929
Process("PvP70NonSet2",30,{"=q4=구원자의 공포매듭 소매장식","=q4=구원자의 공포매듭 허리띠","=q4=구원자의 공포매듭 덧신","","=q4=구원자의 달빛매듭 소매장식","=q4=구원자의 달빛매듭 허리띠","=q4=구원자의 달빛매듭 덧신","","=q4=구원자의 비단 소매장식","=q4=구원자의 비단 허리띠","=q4=구원자의 비단 장화","","","","","=q4=구원자의 용가죽 팔보호구","=q4=구원자의 용가죽 허리띠","=q4=구원자의 용가죽 장화","","=q4=구원자의 코도가죽 팔보호구","=q4=구원자의 코도가죽 허리띠","=q4=구원자의 코도가죽 장화","","=q4=구원자의 가죽 팔보호구","=q4=구원자의 가죽 허리띠","=q4=구원자의 가죽 장화","","=q4=구원자의 고룡가죽 팔보호구","=q4=구원자의 고룡가죽 허리띠","=q4=구원자의 고룡가죽 장화"})
Process("PvP70NonSet3",30,{"=q4=구원자의 사슬 팔보호구","=q4=구원자의 사슬 벨트","=q4=구원자의 사슬 발덮개","","=q4=구원자의 사슬매듭 팔보호구","=q4=구원자의 사슬매듭 벨트","=q4=구원자의 사슬매듭 발덮개","","=q4=구원자의 쇠사슬 팔보호구","=q4=구원자의 쇠사슬 벨트","=q4=구원자의 쇠사슬 발덮개","","=q4=구원자의 고리사슬 팔보호구","=q4=구원자의 고리사슬 벨트","=q4=구원자의 고리사슬 발덮개","=q4=구원자의 강철 팔보호구","=q4=구원자의 강철 허리띠","=q4=구원자의 강철 경갑","","=q4=구원자의 문장 팔보호구","=q4=구원자의 문장 허리띠","=q4=구원자의 문장 경갑","","=q4=구원자의 판금 팔보호구","=q4=구원자의 판금 허리띠","=q4=구원자의 판금 경갑","","=q4=구원자의 미늘 팔보호구","=q4=구원자의 미늘 허리띠","=q4=구원자의 미늘 경갑"})
end