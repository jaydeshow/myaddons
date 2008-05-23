﻿--[[
--AtlasLoot loot tables frFR localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--$Date: 2008-05-21 10:59:36 -0400 (Wed, 21 May 2008) $
--]]
if (GetLocale() == "frFR") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootCrafting"][category] or #AtlasLoot_Data["AtlasLootCrafting"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootCrafting"][category][i][3] = data[i] end end data = nil end
Process("AdamantiteB",4,{"","=q3=Cuirasse en adamantite","=q3=Brassards en plaques d'adamantite","=q3=Gants en plaques d'adamantite"})
Process("ArcanoVest",4,{"","=q3=Robe en tisse-arcane","=q3=Brassards en tisse-arcane","=q3=Bottes en tisse-arcane"})
Process("BattlecastG",3,{"","=q4=Chaperon d'escarmouche","=q4=Pantalon d'escarmouche"})
Process("BlackDragonM",5,{"","=q3=Epaulières en écailles de dragon noir","=q3=Cuirasse en écailles de dragon noir","=q3=Jambières en écailles de dragon noir","=q4=Bottes en écailles de dragon noir"})
Process("BloodTigerH",3,{"","=q3=Epaulières du tigre-sang","=q3=Cuirasse du tigre-sang"})
Process("BloodsoulEmbrace",4,{"","=q3=Epaulières d'âmesang","=q3=Cuirasse d'âmesang","=q3=Gantelets d'âmesang"})
Process("BloodvineG",4,{"","=q3=Gilet en vignesang","=q3=Jambières en vignesang","=q3=Bottes en vignesang"})
Process("BlueDragonM",4,{"","=q3=Epaulières en écailles de dragon bleu","=q3=Cuirasse en écailles de dragon bleu","=q3=Jambières en écailles de dragon bleu"})
Process("BurningRage",5,{"","=q3=Casque Rage-acier","=q3=Epaulières Rage-acier","=q3=Cuirasse Rage-acier","=q3=Gants Rage-acier"})
Process("CraftedWeapons1",22,{"","=q4=Garde du feu","=q4=Brasegarde","=q4=Brasefurie","=q4=Lame Coeur-de-lion","=q4=Championne Coeur-de-lion","=q4=Exécutrice Coeur-de-lion","","","=q4=Tranchant planaire","=q4=Tranchant planaire noir","=q4=Tranchant cruel des plans","=q4=Croissant lunaire","=q4=Tranchelune","=q4=Lune sanguine","","=q4=Marteau poing-de-drake","=q4=Gueule de dragon","=q4=Frappe du dragon","=q4=Tonnerre","=q4=Tonnerre-profond","=q4=Héraut de la tempête"})
Process("CraftedWeapons2",29,{"","=q4=Lame runique en éternium","=q4=Complainte","=q4=Lame longue en gangracier","=q4=Champion en khorium","=q4=Hache de bataille à tranchant gangrené","=q4=Faucheuse en gangracier","=q4=Main de l'éternité","=q4=Marteau runique","=q4=Maillet corrompu durci","=q4=Marteau de la puissance pieuse","","","=q4=Destructeur gyroscopique en khorium","","","=q4=Amnistie noire","=q4=Lame feuille-de-saule","=q4=Garde noire","=q4=Crépuscule","=q4=Eloquente","=q4=Main d'ébène","=q4=Marteau en sulfuron","=q4=Fureur noire","=q4=Bouclier dentelé en obsidienne","","","=q4=Carabine de tireur d'élite endurci","=q4=Disque de force réactif"})
Process("DevilsaurArmor",3,{"","=q3=Gantelets diablosaures","=q3=Jambières diablosaures"})
Process("EnchantedAdaman",5,{"","=q3=Cuirasse enchantée en adamantite","=q3=Ceinture enchantée en adamantite","=q3=Jambières enchantées en adamantite","=q3=Bottes enchantées en adamantite"})
Process("FaithFelsteel",4,{"","=q3=Casque en gangracier","=q3=Gants en gangracier","=q3=Jambières en gangracier"})
Process("FelIronChain",5,{"","=q2=Camail en gangrefer","=q2=Tunique en anneaux de gangrefer","=q2=Brassards en gangrefer","=q2=Gants en anneaux de gangrefer"})
Process("FelIronPlate",6,{"","=q2=Cuirasse en gangrefer","=q2=Gants en plaques de gangrefer","=q2=Ceinture en plaques de gangrefer","=q2=Pantalon en plaques de gangrefer","=q2=Bottes en plaques de gangrefer"})
Process("FelSkin",4,{"","=q3=Gants en gangrecuir","=q3=Jambières en gangrecuir","=q3=Bottes en gangrecuir"})
Process("FelscaleArmor",5,{"","=q2=Cuirasse en gangrécailles","=q2=Gants en gangrécailles","=q2=Pantalon en gangrécailles","=q2=Bottes en gangrécailles"})
Process("FelstalkerArmor",4,{"","=q3=Cuirasse de traqueur gangrené","=q3=Brassards de traqueur gangrené","=q3=Ceinture de traqueur gangrené"})
Process("FlameG",5,{"","=q3=Casque plaie-des-flammes","=q3=Cuirasse plaie-des-flammes","=q3=Brassards plaie-des-flammes","=q3=Gants plaie-des-flammes"})
Process("GreenDragonM",4,{"","=q3=Cuirasse en écailles de dragon vert","=q3=Gantelets en écailles de dragon vert","=q3=Jambières en écailles de dragon vert"})
Process("ImbuedNeather",5,{"","=q3=Tunique en tisse-néant imprégné","=q3=Robe en tisse-néant imprégné","=q3=Pantalon en tisse-néant imprégné","=q3=Bottes en tisse-néant imprégné"})
Process("ImperialPlate",8,{"","=q2=Heaume impérial en plaques","=q2=Epaulières impériales en plaques","=q2=Pansière impériale","=q2=Brassards impériaux en plaques","=q2=Ceinture impériale en plaques","=q2=Jambières impériales en plaques","=q2=Bottes impériales en plaques"})
Process("IronfeatherArmor",3,{"","=q3=Epaulières en plumacier","=q3=Cuirasse en plumacier"})
Process("KhoriumWard",4,{"","=q3=Ceinture en khorium","=q3=Pantalon en khorium","=q3=Bottes en khorium"})
Process("NeatherVest",8,{"","=q2=Tunique en tisse-néant","=q2=Robe en tisse-néant","=q2=Brassards en tisse-néant","=q2=Gants en tisse-néant","=q2=Ceinture en tisse-néant","=q2=Pantalon en tisse-néant","=q2=Bottes en tisse-néant"})
Process("NetherFury",4,{"","=q3=Ceinture de la Furie du Néant","=q3=Jambières de la Furie du Néant","=q3=Bottes de la Furie du Néant"})
Process("NetherscaleArmor",4,{"","=q4=Cuirasse d'ébène en écailles du Néant","=q4=Brassards d'ébène en écailles du Néant","=q4=Ceinture d'ébène en écailles du Néant"})
Process("NetherstrikeArmor",4,{"","=q4=Cuirasse Coup-de-Néant","=q4=Brassards Coup-de-Néant","=q4=Ceinture Coup-de-Néant"})
Process("PrimalBatskin",4,{"","=q3=Pourpoint en peau de chauve-souris primordiale","=q3=Brassards en peau de chauve-souris primordiale","=q3=Gants en peau de chauve-souris primordiale"})
Process("PrimalIntent",4,{"","=q4=Gilet de frappe primordiale","=q4=Brassards de frappe primordiale","=q4=Ceinture de frappe primordiale"})
Process("PrimalMoon",4,{"","=q4=Epaulières d'étoffe lunaire primordiale","=q4=Robe d'étoffe lunaire primordiale","=q4=Ceinture d'étoffe lunaire primordiale"})
Process("SClefthoof",4,{"","=q3=Gilet du sabot-fourchu épais","=q3=Jambières du sabot-fourchu épaisses","=q3=Bottes du sabot-fourchu épaisses"})
Process("ScaledDraenicA",5,{"","=q2=Broigne draenique","=q2=Gants draeniques en écailles","=q2=Pantalon draenique en écailles","=q2=Bottes draeniques en écailles"})
Process("ShadowEmbrace",4,{"","=q4=Epaulières en tisse-ombre gelé","=q4=Robe en tisse-ombre gelé","=q4=Bottes en tisse-ombre gelé"})
Process("SoulclothEm",4,{"","=q4=Epaulières d'âmétoffe","=q4=Gilet d'âmétoffe","=q4=Gants d'âmétoffe"})
Process("SpellfireWrath",4,{"","=q4=Robe du feu-sorcier","=q4=Gants du feu-sorcier","=q4=Ceinture du feu-sorcier"})
Process("SpellstrikeInfu",3,{"","=q4=Chaperon frappe-sort","=q4=Pantalon frappe-sort"})
Process("StormshroudArmor",5,{"","=q3=Epaulières tempétueuses","=q3=Armure tempétueuse","=q3=Gants tempétueux","=q3=Pantalon tempétueux"})
Process("TheDarksoul",4,{"","=q3=Epaulières de ténébrâme","=q3=Cuirasse de ténébrâme","=q3=Jambières de ténébrâme"})
Process("TheUnyielding",3,{"","=q3=Brassards inflexibles","=q4=Ceinturon inflexible"})
Process("ThickDraenicA",5,{"","=q2=Gilet draenique épais","=q2=Gants draeniques épais","=q2=Pantalon draenique épais","=q2=Bottes draeniques épaisses"})
Process("VolcanicArmor",4,{"","=q2=Epaulières volcaniques","=q2=Cuirasse volcanique","=q2=Jambières volcaniques"})
Process("WhitemendWis",3,{"","=q4=Chaperon de la blanche guérison","=q4=Pantalon de la blanche guérison"})
Process("WildDraenishA",5,{"","=q2=Gilet draenique sauvage","=q2=Gants draeniques sauvages","=q2=Jambières draeniques sauvages","=q2=Bottes draeniques sauvages"})
Process("WindhawkArmor",4,{"","=q4=Haubert Faucon-du-vent","=q4=Brassards Faucon-du-vent","=q4=Ceinture Faucon-du-vent"})
end
