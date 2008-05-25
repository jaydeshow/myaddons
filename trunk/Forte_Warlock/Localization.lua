-- Forte Class Addon v0.985 by Xus 31-03-2008 for Patch 2.4.x

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english

!! Make sure to keep this saved as UTF-8 format !!

]]

--[[>> still needs translating]]

-- FR 12 missing
if GetLocale() == "frFR" then

	FW.L.VOIDHEART = "Coeur-du-vide";
	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "Essence de Saphiron";
	FW.L.EPHEMERAL_POWER = "Pouvoir phmre"
	FW.L.SHADOWFLAME = "Ombreflamme";
	FW.L.FLAMESHADOW = "Flammeombre";
	FW.L.SPELL_HASTE = "Hte des sorts";
	FW.L.UNSTABLE_POWER = "Pouvoir instable";
	FW.L.SHADOW_TRANCE = "Transe de l'ombre";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "Bndiction du croissant d'argent";
	FW.L.RECURRING_POWER = "Pouvoir rcurrent";
	FW.L.CALL_OF_THE_NEXUS = "L'appel du nexus";
	FW.L.HEROISM = "Horsme";
	FW.L.BLOODLUST = "Furie sanguinaire";
--[[>>]]FW.L.LESSER_SPELL_BLASTING = "Lesser Spell Blasting";
--[[>>]]FW.L.SPELL_BLASTING = "Spell Blasting";
	FW.L.BACKLASH = "Contrecoup";
	FW.L.UNSTABLE_CURRENTS = "Courants instables";
	FW.L.INFERNAL_POWER = "Pouvoir infernal";
	FW.L.SHADOW_VULNERABILITY = "Vunrabilit  l'ombre"
	FW.L.BUFF_BLOOD_PACT = "Pacte de sang";
	FW.L.SPELL_POWER = "Puissance des sorts"; -- Xi'ri's Gift
--[[>>]]FW.L.FEL_INFUSION = "Fel Infusion"; -- The Skull of Gul'dan
	FW.L.ARCANE_ENERGY = "Energie des arcanes"; -- Vengeance of the Illidari
	FW.L.AURA_OF_THE_CRUSADE = "Aura de crois";
--[[>>]]FW.L.BAND_OF_THE_ETERNAL_SAGE = "Band of the Eternal Sage";
--[[>>]]FW.L.MOJO_MADNESS = "Mojo Madness";
--[[>>]]FW.L.FOCUS = "Focus";

	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "Maldiction de tmrit";
	FW.L.CURSE_OF_THE_ELEMENTS = "Maldiction des lments";
	FW.L.CURSE_OF_SHADOW = "Maldiction de l'ombre";
	FW.L.SIPHON_LIFE = "Siphon de vie";
	FW.L.CURSE_OF_AGONY = "Maldiction d'agonie";
	FW.L.UNSTABLE_AFFLICTION = "Affliction instable";
	FW.L.CURSE_OF_WEAKNESS = "Maldiction de faiblesse";
	FW.L.CURSE_OF_DOOM = "Maldiction funeste";
	FW.L.CURSE_OF_TONGUES = "Maldiction des langages";
	FW.L.CURSE_OF_EXHAUSTION = "Maldiction de fatigue";
	FW.L.IMMOLATE = "Immolation";
	FW.L.CORRUPTION = "Corruption";
	FW.L.HOWL_OF_TERROR = "Hurlement de terreur";
	FW.L.FEAR = "Peur";
	FW.L.BANISH = "Bannir";
	FW.L.ENSLAVE_DEMON = "Asservir dmon";
	FW.L.INFERNO = "Inferno";
	FW.L.INFERNAL = "Infernal";
	FW.L.SEDUCTION = "Sduction";
	FW.L.CONSUME_SHADOWS = "Consumer les ombres";
	FW.L.SPELL_LOCK = "Verrou magique";
	FW.L.DEVOUR_MAGIC = "Dvorer la magie";
	FW.L.PHASE_SHIFT = "Changement de phase";
	FW.L.SHADOW_WARD = "Gardien de l'ombre";
	FW.L.DEATH_COIL = "Voile mortel";
	FW.L.SOULSHATTER = "Brise-me";

--[[>>]]FW.L.DEMON_ARMOR = "Demon Armor";
--[[>>]]FW.L.FEL_ARMOR = "Fel Armor";
--[[>>]]FW.L.BURNING_WISH = "Burning Wish";
--[[>>]]FW.L.FEL_ENERGY = "Fel Energy";
--[[>>]]FW.L.TOUCH_OF_SHADOW = "Touch of Shadow";
--[[>>]]FW.L.FEL_STAMINA = "Fel Stamina";

-- DE 3 missing
elseif GetLocale() == "deDE" then

	--gear
	FW.L.VOIDHEART = "Herzens der Leere";

	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "Essenz Saphirons";
	FW.L.EPHEMERAL_POWER = "Ephemere Macht";
	FW.L.SHADOWFLAME = "Schattenflamme";
	FW.L.FLAMESHADOW = "Flammenschatten";
	FW.L.SPELL_HASTE = "Zaubertempo";
	FW.L.UNSTABLE_POWER = "Instabile Macht";                                                                 
	FW.L.SHADOW_TRANCE = "Schattentrance";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "Segen des Silberwappens"; 
	FW.L.RECURRING_POWER = "Wiederkehrende Macht";
	FW.L.CALL_OF_THE_NEXUS = "Ruf des Nexus";
	FW.L.HEROISM = "Heldentum";
	FW.L.BLOODLUST = "Kampfrausch";
	FW.L.LESSER_SPELL_BLASTING = "Geringe Zauberwucht";
	FW.L.SPELL_BLASTING = "Zauberwucht";
	FW.L.BACKLASH = "Heimzahlen";
	FW.L.UNSTABLE_CURRENTS = "Unstete Strmung";
	FW.L.INFERNAL_POWER = "Hllische Macht";
	FW.L.SHADOW_VULNERABILITY = "Schattenverwundbarkeit"
	FW.L.BUFF_BLOOD_PACT = "Blutpakt";
	FW.L.SPELL_POWER = "Zauberkraft"; -- Xi'ris Gabe
	FW.L.FEL_INFUSION = "Teufelseinwirkung"; -- Der Schdel des Gul'dan
	FW.L.ARCANE_ENERGY = "Arkane Energie"; -- Vergeltung der Illidari
	FW.L.AURA_OF_THE_CRUSADE = "Aura des Kreuzfahrers";
--[[>>]]FW.L.BAND_OF_THE_ETERNAL_SAGE = "Band des ewigen Weisen";
--[[>>]]FW.L.MOJO_MADNESS = "Mojo Madness";
--[[>>]]FW.L.FOCUS = "Focus";

	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "Fluch der Tollkhnheit";
	FW.L.CURSE_OF_THE_ELEMENTS = "Fluch der Elemente";
	FW.L.CURSE_OF_SHADOW = "Fluch der Schatten";
	FW.L.SIPHON_LIFE = "Lebensentzug";
	FW.L.CURSE_OF_AGONY = "Fluch der Pein";
	FW.L.UNSTABLE_AFFLICTION = "Instabiles Gebrechen";
	FW.L.CURSE_OF_WEAKNESS = "Fluch der Schwche";
	FW.L.CURSE_OF_DOOM = "Fluch der Verdammnis";
	FW.L.CURSE_OF_TONGUES = "Fluch der Sprachen";
	FW.L.CURSE_OF_EXHAUSTION = "Fluch der Erschpfung";
	FW.L.IMMOLATE = "Feuerbrand";
	FW.L.CORRUPTION = "Verderbnis";
	FW.L.HOWL_OF_TERROR = "Schreckensgeheul";
	FW.L.FEAR = "Furcht";
	FW.L.BANISH = "Verbannen";
	FW.L.ENSLAVE_DEMON = "Dmonensklave";
	FW.L.INFERNO = "Inferno";
	FW.L.INFERNAL = "Hllenbestie";
	FW.L.SEDUCTION = "Verfhrung";
	FW.L.CONSUME_SHADOWS = "Schatten verzehren";
	FW.L.SPELL_LOCK = "Zaubersperre";
	FW.L.DEVOUR_MAGIC = "Magieverschlingen";
	FW.L.PHASE_SHIFT = "Phasenverschiebung";
	FW.L.SHADOW_WARD = "Schattenzauberschutz";
	FW.L.DEATH_COIL = "Todesmantel";
	FW.L.SOULSHATTER = "Seele brechen";

	--cooldowns/buffs
	FW.L.DEMON_ARMOR = "Dmonenrstung";
	FW.L.FEL_ARMOR = "Teufelsrstung";
	FW.L.BURNING_WISH = "Brennender Wunsch";
	FW.L.FEL_ENERGY = "Teufelsenergie";
	FW.L.TOUCH_OF_SHADOW = "Berhrung des Schattens";
	FW.L.FEL_STAMINA = "Teufelsausdauer";
	
-- SPANISH - 14 mising  By Intxixu - SPQR - Tyrande
elseif GetLocale() == "esES" then

	--gear
	FW.L.VOIDHEART = "corazn vaco";
	
	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "Esencia de Sapphiron";
	FW.L.EPHEMERAL_POWER = "Poder efmero"
--[[>>]]FW.L.SHADOWFLAME = "Shadowflame";
--[[>>]]FW.L.FLAMESHADOW = "Flameshadow";
--[[>>]]FW.L.SPELL_HASTE = "Spell Haste";
	FW.L.UNSTABLE_POWER = "Poder inestable";
	FW.L.SHADOW_TRANCE = "Trance de las Sombras";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "Bendicin del creciente de plata";
--[[>>]]FW.L.RECURRING_POWER = "Recurring Power";
--[[>>]]FW.L.CALL_OF_THE_NEXUS = "Call of the Nexus";
	FW.L.HEROISM = "Herosmo";
	FW.L.BLOODLUST = "Ansia de sangre";
	FW.L.LESSER_SPELL_BLASTING = "Lesser Spell Blasting";
--[[>>]]FW.L.SPELL_BLASTING = "Spell Blasting";
	FW.L.BACKLASH = "Contragolpe";
	FW.L.UNSTABLE_CURRENTS = "Corrientes inestables";
	FW.L.INFERNAL_POWER = "Poder infernal";
	FW.L.SHADOW_VULNERABILITY = "Vuelnertavilidad de las sombras"
	FW.L.BUFF_BLOOD_PACT = "Pacto de sangre";
	FW.L.SPELL_POWER = "Poder de hechizo"; -- Xi'ri's Gift
	FW.L.FEL_INFUSION = "Fel Infusion"; -- The Skull of Gul'dan
	FW.L.ARCANE_ENERGY = "Arcane Energy"; -- Vengeance of the Illidari
	FW.L.AURA_OF_THE_CRUSADE = "Aura del Cruzado";
	FW.L.BAND_OF_THE_ETERNAL_SAGE = "Band of the Eternal Sage";
--[[>>]]FW.L.MOJO_MADNESS = "Mojo Madness";
--[[>>]]FW.L.FOCUS = "Focus";
	
	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "Maldicin de temeridad";
	FW.L.CURSE_OF_THE_ELEMENTS = "Maldicin de los Elementos";
	FW.L.CURSE_OF_SHADOW = "Maldicin de las Sombras";
	FW.L.SIPHON_LIFE = "Succionar vida";
	FW.L.CURSE_OF_AGONY = "Maldicin de agona";
	FW.L.UNSTABLE_AFFLICTION = "Afliccin inestable";
	FW.L.CURSE_OF_WEAKNESS = "Maldicin de debilidad";
	FW.L.CURSE_OF_DOOM = "Maldicin del Apocalipsis";
	FW.L.CURSE_OF_TONGUES = "Maldicin de las lenguas";
	FW.L.CURSE_OF_EXHAUSTION = "Maldicin de Agotamiento";
	FW.L.IMMOLATE = "Inmolar";
	FW.L.CORRUPTION = "Corrupcin";
	FW.L.HOWL_OF_TERROR = "Aullido de terror";
	FW.L.FEAR = "Miedo";
	FW.L.BANISH = "Desterrar";


	FW.L.ENSLAVE_DEMON = "Esclavizar demonio";
	FW.L.INFERNO = "Inferno";
	FW.L.INFERNAL = "Infernal";
	FW.L.SEDUCTION = "Seduccin";
	FW.L.CONSUME_SHADOWS = "Consumir Sombras";
	FW.L.SPELL_LOCK = "Bloqueo de hechizo";
	FW.L.DEVOUR_MAGIC = "Devorar magia";
	FW.L.PHASE_SHIFT = "Cambio de fase";
	FW.L.SHADOW_WARD = "Resguardo contra las Sombras";
	FW.L.DEATH_COIL = "Espiral de muerte";
	FW.L.SOULSHATTER = "Despedazar alma";
	
--[[>>]]FW.L.DEMON_ARMOR = "Demon Armor";
--[[>>]]FW.L.FEL_ARMOR = "Fel Armor";
--[[>>]]FW.L.BURNING_WISH = "Burning Wish";
--[[>>]]FW.L.FEL_ENERGY = "Fel Energy";
--[[>>]]FW.L.TOUCH_OF_SHADOW = "Touch of Shadow";
--[[>>]]FW.L.FEL_STAMINA = "Fel Stamina";	

-- simple chinese
elseif GetLocale() == "zhCN" then

	--gear
	FW.L.VOIDHEART = "虚空之心";

	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "萨菲隆精华"; --被禁锢的萨菲隆精华
	FW.L.EPHEMERAL_POWER = "短暂强力";  --短暂能量护符 
	FW.L.SHADOWFLAME = "暗影之焰";
	FW.L.FLAMESHADOW = "烈焰暗影";
	FW.L.SPELL_HASTE = "法术急速"
	FW.L.UNSTABLE_POWER = "能量无常"; --赞达拉英雄护符
	FW.L.SHADOW_TRANCE = "暗影冥思";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "银色新月祝福";  --银色弦月徽记
	FW.L.RECURRING_POWER = "复生之力";  --玛瑟里顿之眼
	FW.L.CALL_OF_THE_NEXUS = "节点召唤";  --希法尔的节点号角
	FW.L.HEROISM = "英雄";
	FW.L.BLOODLUST = "嗜血";
	FW.L.LESSER_SPELL_BLASTING = "次级法术冲击";
	FW.L.SPELL_BLASTING = "法术冲击";
	FW.L.BACKLASH = "反冲";
	FW.L.UNSTABLE_CURRENTS = "不稳定急流";  --逆流六分仪
	FW.L.INFERNAL_POWER = "地狱火之力";  --暗影之灰舌符咒
	FW.L.SHADOW_VULNERABILITY = "暗影易伤"
	FW.L.BUFF_BLOOD_PACT = "血之契印";
	FW.L.SPELL_POWER = "法术能量"; -- 克希利的礼物
	FW.L.FEL_INFUSION = "邪能灌注"; -- 古尔丹之颅
	FW.L.ARCANE_ENERGY = "奥术能量"; -- 伊利达雷的复仇
	FW.L.AURA_OF_THE_CRUSADE = "十字军光环";
	FW.L.BAND_OF_THE_ETERNAL_SAGE = "永恒先知之戒";
	FW.L.POWER_OF_ARCANAGOS = "阿坎纳苟斯之力";
	FW.L.MOJO_MADNESS = "魔精疯狂";
	FW.L.FOCUS = "专注";

	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "鲁莽诅咒";
	FW.L.CURSE_OF_THE_ELEMENTS = "元素诅咒";
	FW.L.CURSE_OF_SHADOW = "暗影诅咒";
	FW.L.SIPHON_LIFE = "生命虹吸";
	FW.L.CURSE_OF_AGONY = "痛苦诅咒";
	FW.L.UNSTABLE_AFFLICTION = "痛苦无常";
	FW.L.CURSE_OF_WEAKNESS = "虚弱诅咒";
	FW.L.CURSE_OF_DOOM = "厄运诅咒";
	FW.L.CURSE_OF_TONGUES = "语言诅咒";
	FW.L.CURSE_OF_EXHAUSTION = "疲劳诅咒";
	FW.L.IMMOLATE = "献祭";
	FW.L.CORRUPTION = "腐蚀术";
	FW.L.HOWL_OF_TERROR = "恐惧嚎叫";
	FW.L.FEAR = "恐惧";
	FW.L.BANISH = "放逐术";
	FW.L.ENSLAVE_DEMON = "奴役恶魔";
	FW.L.INFERNO = "地狱火";
	FW.L.INFERNAL = "地狱火爪牙";
	FW.L.SEDUCTION = "诱惑";
	FW.L.CONSUME_SHADOWS = "吞噬暗影";
	FW.L.SPELL_LOCK = "法术封锁";
	FW.L.DEVOUR_MAGIC = "吞噬魔法";
	FW.L.PHASE_SHIFT = "相位变换";
	FW.L.SHADOW_WARD = "防护暗影结界";
	FW.L.DEATH_COIL = "死亡缠绕";
	FW.L.SOULSHATTER = "灵魂碎裂";



	--cooldowns/buffs
	FW.L.DEMON_ARMOR = "魔甲术";
	FW.L.FEL_ARMOR = "邪甲术";
	FW.L.BURNING_WISH = "燃烧之愿";
	FW.L.FEL_ENERGY = "恶魔能量";
	FW.L.TOUCH_OF_SHADOW = "暗影之触";
	FW.L.FEL_STAMINA = "恶魔耐力";

-- tradition chinese
elseif GetLocale() == "zhTW" then

	--gear
	FW.L.VOIDHEART = "虛無之心";

	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "薩菲隆精華"; --受限制的薩菲隆精華 
	FW.L.EPHEMERAL_POWER = "短暫強力"; --短暫能量護符
	FW.L.SHADOWFLAME = "暗影之焰";
	FW.L.FLAMESHADOW = "暗影烈焰";
	FW.L.SPELL_HASTE = "施法加速"; 
	FW.L.UNSTABLE_POWER = "能量無常";  --贊達拉英雄符咒
	FW.L.SHADOW_TRANCE = "暗影冥思";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "銀色弦月的祝福";  --銀色弦月塑像 
	FW.L.RECURRING_POWER = "複生之力";  --瑪瑟裏頓之眼
	FW.L.CALL_OF_THE_NEXUS = "奈薩斯的召喚"; --薩法爾之奈薩斯號角
	FW.L.HEROISM = "英勇氣概";
	FW.L.BLOODLUST = "嗜血術";
	FW.L.LESSER_SPELL_BLASTING = "次級法術衝擊";
	FW.L.SPELL_BLASTING = "法術衝擊";
	FW.L.BACKLASH = "反衝";
	FW.L.UNSTABLE_CURRENTS = "不穩定急流"; --亂流之測量儀
	FW.L.INFERNAL_POWER = "地獄火之力";  --灰舌暗影護符
	FW.L.SHADOW_VULNERABILITY = "暗影易傷"
	FW.L.BUFF_BLOOD_PACT = "血之契印";
	FW.L.SPELL_POWER = "法術能量"; -- 希瑞的禮物
	FW.L.FEL_INFUSION = "魔性注入"; -- 古爾丹之顱
	FW.L.ARCANE_ENERGY = "秘法能量"; -- 伊利達瑞的復仇 
	FW.L.AURA_OF_THE_CRUSADE = "十字軍光環";
	FW.L.BAND_OF_THE_ETERNAL_SAGE = "永恆聖人指環";
	FW.L.POWER_OF_ARCANAGOS = "阿坎洛格斯之力";
	FW.L.MOJO_MADNESS = "瘋狂魔精";
	FW.L.FOCUS = "集中";

	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "魯莽詛咒";
	FW.L.CURSE_OF_THE_ELEMENTS = "元素詛咒";
	FW.L.CURSE_OF_SHADOW = "暗影詛咒";
	FW.L.SIPHON_LIFE = "生命虹吸";
	FW.L.CURSE_OF_AGONY = "痛苦詛咒";
	FW.L.UNSTABLE_AFFLICTION = "痛苦動盪";
	FW.L.CURSE_OF_WEAKNESS = "虛弱詛咒";
	FW.L.CURSE_OF_DOOM = "厄運詛咒";
	FW.L.CURSE_OF_TONGUES = "語言詛咒";
	FW.L.CURSE_OF_EXHAUSTION = "疲勞詛咒";
	FW.L.IMMOLATE = "獻祭";
	FW.L.CORRUPTION = "腐蝕術";
	FW.L.HOWL_OF_TERROR = "恐懼嚎叫";
	FW.L.FEAR = "恐懼術";
	FW.L.BANISH = "放逐術";
	FW.L.ENSLAVE_DEMON = "奴役惡魔";
	FW.L.INFERNO = "地獄火";
	FW.L.INFERNAL = "地獄火爪牙";
	FW.L.SEDUCTION = "誘惑";
	FW.L.CONSUME_SHADOWS = "吞噬暗影";
	FW.L.SPELL_LOCK = "法術封鎖";
	FW.L.DEVOUR_MAGIC = "吞噬魔法";
	FW.L.PHASE_SHIFT = "相位變換";
	FW.L.SHADOW_WARD = "防護暗影結界";
	FW.L.DEATH_COIL = "死亡纏繞";
	FW.L.SOULSHATTER = "靈魂粉碎";



	--cooldowns/buffs
	FW.L.DEMON_ARMOR = "魔甲術";
	FW.L.FEL_ARMOR = "獄甲術";
	FW.L.BURNING_WISH = "燃燒之願";
	FW.L.FEL_ENERGY = "惡魔能量";
	FW.L.TOUCH_OF_SHADOW = "暗影之觸";
	FW.L.FEL_STAMINA = "惡魔耐力";

-- ENGLISH
else	-- standard english version

	--gear
	FW.L.VOIDHEART = "Voidheart";

	--buffs
	FW.L.ESSENCE_OF_SAPPHIRON = "Essence of Sapphiron";
	FW.L.EPHEMERAL_POWER = "Ephemeral Power"
	FW.L.SHADOWFLAME = "Shadowflame";
	FW.L.FLAMESHADOW = "Flameshadow";
	FW.L.SPELL_HASTE = "Spell Haste";
	FW.L.UNSTABLE_POWER = "Unstable Power";
	FW.L.SHADOW_TRANCE = "Shadow Trance";
	FW.L.BLESSING_OF_THE_SILVER_CRESCENT = "Blessing of the Silver Crescent";
	FW.L.RECURRING_POWER = "Recurring Power";
	FW.L.CALL_OF_THE_NEXUS = "Call of the Nexus";
	FW.L.HEROISM = "Heroism";
	FW.L.BLOODLUST = "Bloodlust";
	FW.L.LESSER_SPELL_BLASTING = "Lesser Spell Blasting";
	FW.L.SPELL_BLASTING = "Spell Blasting";
	FW.L.BACKLASH = "Backlash";
	FW.L.UNSTABLE_CURRENTS = "Unstable Currents";
	FW.L.INFERNAL_POWER = "Infernal Power";
	FW.L.SHADOW_VULNERABILITY = "Shadow Vulnerability"
	FW.L.BUFF_BLOOD_PACT = "Blood Pact";
	FW.L.SPELL_POWER = "Spell Power"; -- Xi'ri's Gift
	FW.L.FEL_INFUSION = "Fel Infusion"; -- The Skull of Gul'dan
	FW.L.ARCANE_ENERGY = "Arcane Energy"; -- Vengeance of the Illidari
	FW.L.AURA_OF_THE_CRUSADE = "Aura of the Crusader";
	FW.L.BAND_OF_THE_ETERNAL_SAGE = "Band of the Eternal Sage";
	FW.L.MOJO_MADNESS = "Mojo Madness";
	FW.L.FOCUS = "Focus";

	--spells
	FW.L.CURSE_OF_RECKLESSNESS = "Curse of Recklessness";
	FW.L.CURSE_OF_THE_ELEMENTS = "Curse of the Elements";
	FW.L.CURSE_OF_SHADOW = "Curse of Shadow";
	FW.L.SIPHON_LIFE = "Siphon Life";
	FW.L.CURSE_OF_AGONY = "Curse of Agony";
	FW.L.UNSTABLE_AFFLICTION = "Unstable Affliction";
	FW.L.CURSE_OF_WEAKNESS = "Curse of Weakness";
	FW.L.CURSE_OF_DOOM = "Curse of Doom";
	FW.L.CURSE_OF_TONGUES = "Curse of Tongues";
	FW.L.CURSE_OF_EXHAUSTION = "Curse of Exhaustion";
	FW.L.IMMOLATE = "Immolate";
	FW.L.CORRUPTION = "Corruption";
	FW.L.HOWL_OF_TERROR = "Howl of Terror";
	FW.L.FEAR = "Fear";
	FW.L.BANISH = "Banish";
	FW.L.ENSLAVE_DEMON = "Enslave Demon";
	FW.L.INFERNO = "Inferno";
	FW.L.INFERNAL = "Infernal";
	FW.L.SEDUCTION = "Seduction";
	FW.L.CONSUME_SHADOWS = "Consume Shadows";
	FW.L.SPELL_LOCK = "Spell Lock";
	FW.L.DEVOUR_MAGIC = "Devour Magic";
	FW.L.PHASE_SHIFT = "Phase Shift";
	FW.L.SHADOW_WARD = "Shadow Ward";
	FW.L.DEATH_COIL = "Death Coil";
	FW.L.SOULSHATTER = "Soulshatter";

	--cooldowns/buffs
	FW.L.DEMON_ARMOR = "Demon Armor";
	FW.L.FEL_ARMOR = "Fel Armor";
	FW.L.BURNING_WISH = "Burning Wish";
	FW.L.FEL_ENERGY = "Fel Energy";
	FW.L.TOUCH_OF_SHADOW = "Touch of Shadow";
	FW.L.FEL_STAMINA = "Fel Stamina";
end

-- simple chinese
if GetLocale() == "zhCN" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SUMMON_START = "召唤开始";
FW.L.SUMMON_CANCEL = "召唤取消";
FW.L.SUMMON_PORTAL = "时空门打开";
FW.L.SUMMON_FAILED = "召唤失败";
FW.L.SUMMON_SUCCESS = "召唤成功";

FW.L.SUMMON_START_W = "召唤开始M语";	
FW.L.SUMMON_CANCEL_W = "召唤取消M语";	
FW.L.SUMMON_FAILED_W = "召唤失败M语";

FW.L.SUMMONING = "召唤";
FW.L.SOULTONE_START = "灵魂石开始绑定";
FW.L.SOULTONE_CANCEL = "灵魂石取消绑定";
FW.L.SOULTONE_SUCCESS = "灵魂石成功绑定";

FW.L.SOULSTONE_NORMAL = "灵魂石";

FW.L.SOULTONE_START_W = "灵魂石开始绑定M语";
FW.L.SOULTONE_CANCEL_W = "灵魂石取消绑定M语";
FW.L.SOULTONE_SUCCESS_W = "灵魂石成功绑定M语";

FW.L.SOULWELL_START = "灵魂井开始施放";

FW.L.SEDUCE_START = "诱惑开始施放";
FW.L.SEDUCE_SUCCESS = "成功诱惑";

FW.L.BREAK_FADE = "打断/失效";
FW.L.BREAK_FADE_HINT1 = "失效信息持续时间.";
FW.L.FEAR_BREAK = "恐惧打断";
FW.L.FEAR_FADE = "恐惧失效";
FW.L.BANISH_BREAK = "放逐打断";
FW.L.BANISH_FADE = "放逐失效";
FW.L.ENSLAVE_BREAK = "奴役打断";
FW.L.ENSLAVE_FADE = "奴役失效";

FW.L.SPELL_LOCK_SUCCESS = "法术封锁施放成功";
FW.L.DEVOUR_MAGIC_SUCCESS = "吞噬魔法施放成功";

FW.L.SHARD_MANAGER = "碎片管理";
FW.L.SHARD_MANAGER_ENABLE_TT = "开启碎片管理";

FW.L.SHARD_MANAGER_HINT1 = "开启选项前保持自定义设置.碎片包一直为优先选择.";
FW.L.SHARD_BAG_PRIOR = "优先使用碎片包";
FW.L.SHARD_BAG_PRIOR_TT = "将碎片整理到你置顶的包中. 0为行囊, 从右到左分别为1到4号.";
FW.L.SHARD_DELETE = "允许摧毁碎片";
FW.L.SHARD_DELETE_TT = "将多出碎片摧毁,具体取决于下面的设置.";
FW.L.SHARD_MAX = "最大保留碎片数";
FW.L.SHARD_MAX_TT = "超过这个数的碎片都会被摧毁. 碎片包内的碎片不会被摧毁.";
FW.L.SHARD_MIN = "最少保留碎片数";
FW.L.SHARD_MIN_TT = "和最小保留空格一起使用. 你最少都会保有这个数目的碎片.";
FW.L.SHARD_FREE = "最小保留空格";
FW.L.SHARD_FREE_TT = "定义你希望在包包中最少要保留的空格数. 如果允许,插件会尽量摧毁碎片,保留这个数目的空间.";

FW.L.BLOOD_PACT = "血之契印";
FW.L.BLOOD_PACT_ON = "血之契印打开";
FW.L.BLOOD_PACT_GAIN = "获得血之契印";
FW.L.BLOOD_PACT_LOSS = "失去血之契印";
FW.L.BLOOD_PACT_TT = "开启血之契印信息. 你可以将这些信息显示给其他人, 输入 'self' 或者 'all', 这样你的队友也能看见这些信息.";

FW.L._GAINED_BLOOD_PACT = " 得到血之契印.";
FW.L._LOST_BLOOD_PACT = " 失去血之契印.";

FW.L.DELAY_PET_TARGET = "Pet目标延迟";

-- tradition chinese
elseif GetLocale() == "zhTW" then

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SUMMON_START = "召喚開始";
FW.L.SUMMON_CANCEL = "召喚取消";
FW.L.SUMMON_PORTAL = "時空門打開";
FW.L.SUMMON_FAILED = "召喚失敗";
FW.L.SUMMON_SUCCESS = "召喚成功";

FW.L.SUMMON_START_W = "召喚開始M語";	
FW.L.SUMMON_CANCEL_W = "召喚取消M語";	
FW.L.SUMMON_FAILED_W = "召喚失敗M語";

FW.L.SUMMONING = "召喚";
FW.L.SOULTONE_START = "靈魂石開始綁定";
FW.L.SOULTONE_CANCEL = "靈魂石取消綁定";
FW.L.SOULTONE_SUCCESS = "靈魂石成功綁定";

FW.L.SOULSTONE_NORMAL = "靈魂石";

FW.L.SOULTONE_START_W = "靈魂石開始綁定M語";
FW.L.SOULTONE_CANCEL_W = "靈魂石取消綁定M語";
FW.L.SOULTONE_SUCCESS_W = "靈魂石成功綁定M語";

FW.L.SOULWELL_START = "靈魂井開始施放";

FW.L.SEDUCE_START = "誘惑開始施放";
FW.L.SEDUCE_SUCCESS = "成功誘惑";

FW.L.BREAK_FADE = "打斷/失效";
FW.L.BREAK_FADE_HINT1 = "失效資訊持續時間.";
FW.L.FEAR_BREAK = "恐懼打斷";
FW.L.FEAR_FADE = "恐懼失效";
FW.L.BANISH_BREAK = "放逐打斷";
FW.L.BANISH_FADE = "放逐失效";
FW.L.ENSLAVE_BREAK = "奴役打斷";
FW.L.ENSLAVE_FADE = "奴役失效";

FW.L.SPELL_LOCK_SUCCESS = "法術封鎖施放成功";
FW.L.DEVOUR_MAGIC_SUCCESS = "吞噬魔法施放成功";

FW.L.SHARD_MANAGER = "碎片管理";
FW.L.SHARD_MANAGER_ENABLE_TT = "開啟碎片管理";

FW.L.SHARD_MANAGER_HINT1 = "開啟選項前保持自定義設置.碎片包一直為優先選擇.";
FW.L.SHARD_BAG_PRIOR = "優先使用碎片包";
FW.L.SHARD_BAG_PRIOR_TT = "將碎片整理到你置頂的包中. 0為行囊, 從右到左分別為1到4號.";
FW.L.SHARD_DELETE = "允許摧毀碎片";
FW.L.SHARD_DELETE_TT = "將多出碎片摧毀,具體取決於下面的設置.";
FW.L.SHARD_MAX = "最大保留碎片數";
FW.L.SHARD_MAX_TT = "超過這個數的碎片都會被摧毀. 碎片包內的碎片不會被摧毀.";
FW.L.SHARD_MIN = "最少保留碎片數";
FW.L.SHARD_MIN_TT = "和最小保留空格一起使用. 你最少都會保有這個數目的碎片.";
FW.L.SHARD_FREE = "最小保留空格";
FW.L.SHARD_FREE_TT = "定義你希望在包包中最少要保留的空格數. 如果允許,插件會儘量摧毀碎片,保留這個數目的空間.";

FW.L.BLOOD_PACT = "血之契印";
FW.L.BLOOD_PACT_ON = "血之契印打開";
FW.L.BLOOD_PACT_GAIN = "獲得血之契印";
FW.L.BLOOD_PACT_LOSS = "失去血之契印";
FW.L.BLOOD_PACT_TT = "開啟血之契印資訊. 你可以將這些資訊顯示給其他人, 輸入 'self' 或者 'all', 這樣你的隊友也能看見這些資訊.";

FW.L._GAINED_BLOOD_PACT = " 得到血之契印.";
FW.L._LOST_BLOOD_PACT = " 失去血之契印.";

FW.L.DELAY_PET_TARGET = "Pet目標延遲";


-- ENGLISH
else	-- standard english version

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.SUMMON_START = "Summoning Start";
FW.L.SUMMON_CANCEL = "Summoning Cancel";
FW.L.SUMMON_PORTAL = "Summoning Portal Open";
FW.L.SUMMON_FAILED = "Summoning Failed";
FW.L.SUMMON_SUCCESS = "Summoning Successfull";

FW.L.SUMMON_START_W = "Summoning Start whisper";	
FW.L.SUMMON_CANCEL_W = "Summoning Cancel whisper";	
FW.L.SUMMON_FAILED_W = "Summoning Failed whisper";

FW.L.SUMMONING = "Summoning";
FW.L.SOULTONE_START = "Soulstone cast Start";
FW.L.SOULTONE_CANCEL = "Soulstone cast Cancel";
FW.L.SOULTONE_SUCCESS = "Soulstone cast Success";

FW.L.SOULSTONE_NORMAL = "Soulstone";

FW.L.SOULTONE_START_W = "Soulstone cast Start whisper";
FW.L.SOULTONE_CANCEL_W = "Soulstone cast Cancel whisper";
FW.L.SOULTONE_SUCCESS_W = "Soulstone cast Success whisper";

FW.L.SOULWELL_START = "Soulwell cast Start";

FW.L.SEDUCE_START = "Seduce cast Start";
FW.L.SEDUCE_SUCCESS = "Seduce cast Success";

FW.L.BREAK_FADE = "Break/Fade";
FW.L.BREAK_FADE_HINT1 = "The time you set in the fade string defines when it is displayed.";
FW.L.FEAR_BREAK = "Fear Break";
FW.L.FEAR_FADE = "Fear Fade";
FW.L.BANISH_BREAK = "Banish Break";
FW.L.BANISH_FADE = "Banish Fade";
FW.L.ENSLAVE_BREAK = "Enslave Break";
FW.L.ENSLAVE_FADE = "Enslave Fade";

FW.L.SPELL_LOCK_SUCCESS = "Spell Lock cast Success";
FW.L.DEVOUR_MAGIC_SUCCESS = "Devour Magic cast Success";

FW.L.SHARD_MANAGER = "Shard Manager";
FW.L.SHARD_MANAGER_ENABLE_TT = "Enable the Shard Manager";

FW.L.SHARD_MANAGER_HINT1 = "Customize the settings before you enable it! A shard bag should always be highest priority.";
FW.L.SHARD_BAG_PRIOR = "Shard bags priority";
FW.L.SHARD_BAG_PRIOR_TT = "Let the addon move your shards into the bags you prefer most. Bag 0 is your backpack, your normal bags go up from 1 to 4 from right to left.";
FW.L.SHARD_DELETE = "Allow shard deleting";
FW.L.SHARD_DELETE_TT = "Allow the deleting of excess shards, depending on the following settings.";
FW.L.SHARD_MAX = "Maximum shard count";
FW.L.SHARD_MAX_TT = "Simply deletes shards if you get above this number. It will never delete shards from shardbags.";
FW.L.SHARD_MIN = "Minimum shard count";
FW.L.SHARD_MIN_TT = "Overwrites the 'Minimum free space' setting. The addon will always keep this minimum.";
FW.L.SHARD_FREE = "Minimum free space";
FW.L.SHARD_FREE_TT = "Specifies the minimum free space you want to have in your 'normal' bags. The addon will delete shards to keep these slots open, if allowed.";

FW.L.BLOOD_PACT = "Blood Pact";
FW.L.BLOOD_PACT_ON = "Blood Pact on";
FW.L.BLOOD_PACT_GAIN = "Blood Pact gain";
FW.L.BLOOD_PACT_LOSS = "Blood Pact loss";
FW.L.BLOOD_PACT_TT = "Enable BLood Pact messages. You can set this to any classes, names and/or 'self' or 'all', so it will only show gains/losses for these players in your party.";

FW.L._GAINED_BLOOD_PACT = "%s gained Blood Pact.";
FW.L._LOST_BLOOD_PACT = "%s lost Blood Pact.";

FW.L.DELAY_PET_TARGET = "Delay pet target";
end