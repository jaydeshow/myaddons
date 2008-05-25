﻿--[[
--AtlasLoot loot tables zhCN localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--NOTE-zhCN: 本文件是由程序自动生成的，请勿人工干预，任何手动更改都可能会被覆盖！
--$Date: 2008-05-21 11:00:19 -0400 (Wed, 21 May 2008) $
--]]
if (GetLocale() == "zhCN") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootWorldPvPItems"][category] or #AtlasLoot_Data["AtlasLootWorldPvPItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootWorldPvPItems"][category][i][3] = data[i] end end data = nil end
Process("Hellfire",22,{"=q3=胜者指环","=q3=锋利翠榄石","=q3=强能血榴石","","","=q1=荣耀堡的好感","=q1=荣耀堡印记","","","","","","","","","=q3=胜者戒指","=q3=锯齿翠榄石","=q3=纯净血榴石","","","=q1=萨尔玛的好感","=q1=萨尔玛印记"})
Process("Nagrand1",29,{"=q4=暗色骑乘塔布羊缰绳","=q4=卓越秘法黎明石","=q3=圣职者护腿","=q3=梦行者护腿","=q3=暗影追猎者护腿","=q3=神射手的护腿","=q3=破雷护腿","=q3=复仇者的腿甲","=q3=刺客护腿","","=q3=图鉴：秘法黎明石","","","=q2=哈兰作战勋章","","=q4=暗色作战塔布羊缰绳","=q3=哈兰背包","=q3=圣职者腰带","=q3=梦行者腰带","=q3=暗影追猎者腰带","=q3=神射手的腰带","=q3=破雷束带","=q3=复仇者的腰带","=q3=刺客腰带","","=q3=图鉴：稳固水玉","=q1=配方：铁皮药剂","","=q2=哈兰研究勋章"})
Process("Nagrand2",22,{"=q3=哈兰刺杆箭","=q1=哈兰威士忌","","","=q3=阿曼希奥之心","=q2=哈兰双刃刀","=q2=复仇之刃","","","","","","","","","=q3=哈兰弹丸","","","","=q3=罗德里格之心","=q2=阿卡迪亚宽刃剑","=q2=锋利飞镖"})
Process("Terokkar",25,{"=q4=驱魔人的指环","=q3=迅捷之星火钻石","=q3=驱魔人的邪纹罩帽","=q3=驱魔人的龙皮头盔","=q3=驱魔人的蟒皮头盔","=q3=驱魔人的环甲头盔","=q3=驱魔人的板层甲头盔","=q3=驱魔人的鳞甲头盔","","=q1=奥金尼治疗药水","","=q1=幽魂碎片","","","","=q4=驱魔人的徽记","=q3=迅捷之风火钻石","=q3=驱魔人的丝质罩帽","=q3=驱魔人的皮甲头盔","=q3=驱魔人的链甲头盔","=q3=驱魔人的锁甲头盔","=q3=驱魔人的板甲头盔","","","=q1=奥金尼法力药水"})
Process("Zangarmarsh",22,{"=q3=凶暴神像","=q3=冲击图腾","=q3=抗争印记","=q3=终结之刃","=q3=燃烧魔棒","","=q1=荣耀堡印记","","","","","","","","","=q3=狂热圣契","=q3=征服印记","=q3=守备印记","=q3=穿靶弓","","","=q1=萨尔玛印记"})
end