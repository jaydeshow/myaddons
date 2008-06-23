local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

function Atlas112Compat()

    AtlasLootBossButtons["MagistersTerrace"] = {
        "SunOffensive1";
        "";
        "SMTFireheart";
		"";
		"";
        "SMTVexallus";
		"";
		"";
        "SMTDelrissa";
        "SMTKaelthas";
		"";
		"SMTTrash";
        };
    
    AtlasLootBossButtons["Naxxramas"] = {
        "";
        "Argent1";
        "";
        "";
        "";
        "";
        "NAXPatchwerk";
        "NAXGrobbulus";
        "NAXGluth";
        "NAXThaddius";
        "";
        "NAXAnubRekhan";
        "NAXGrandWidowFaerlina";
        "NAXMaexxna";
        "";
        "NAXInstructorRazuvious";
        "NAXGothikderHarvester";
        "NAXTheFourHorsemen";
        "";
        "";
        "";
        "";
        "";
        "";
        "NAXNothderPlaguebringer";
        "NAXHeiganderUnclean";
        "NAXLoatheb";
        "";
        "NAXSapphiron";
        "NAXKelThuzard";
        "";
        "NAXTrash";
        "T3SET";
        };
    
    
    AtlasLoot_ExtraText["AlteracValleySouth"] = {
        "";
        GREEN..AL["Misc. Rewards"];
        GREEN..AL["Superior Rewards"];
        GREEN..AL["Epic Rewards"];
    };
    
    AtlasLootBattlegrounds["AlteracValleySouth"] = {
        "Frostwolf1";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "AVMisc";
        "AVBlue";
        "AVPurple";
    };
    

end
