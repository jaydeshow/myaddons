local BabbleTrade=AceLibrary("Babble-Tradeskill-2.2");
local BabbleFaction = AceLibrary("Babble-Faction-2.2");
local BabbleClass = AceLibrary("Babble-Class-2.2");
local BabbleZone = AceLibrary("Babble-Zone-2.2");
local BabbleInventory = AceLibrary("Babble-Inventory-2.2");
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot"); 

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

AtlasLoot_ButtonRegistry = {
  --WoW Factions
    ["Argent1"] = {
        Title = BabbleFaction["Argent Dawn"]..": "..AL["Token Hand-Ins"];
        Next_Page = "Argent2";
        Next_Title = BabbleFaction["Argent Dawn"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Argent2"] = {
        Title = BabbleFaction["Argent Dawn"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
        Prev_Page = "Argent1";
        Prev_Title = BabbleFaction["Argent Dawn"]..": "..AL["Token Hand-Ins"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Bloodsail1"] = {
        Title = BabbleFaction["Bloodsail Buccaneers"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["AQBroodRings"] = {
        Title = BabbleFaction["Brood of Nozdormu"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Cenarion1"] = {
        Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Friendly"];
        Next_Page = "Cenarion2";
        Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Cenarion2"] = {
        Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
        Next_Page = "Cenarion3";
        Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
        Prev_Page = "Cenarion1";
        Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Friendly"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Cenarion3"] = {
        Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
        Next_Page = "Cenarion4";
        Next_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Exalted"];
        Prev_Page = "Cenarion2";
        Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Honored"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Cenarion4"] = {
        Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Exalted"];
        Prev_Page = "Cenarion3";
        Prev_Title = BabbleFaction["Cenarion Circle"]..": "..BabbleFaction["Revered"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Darkmoon1"] = {
        Title = BabbleFaction["Darkmoon Faire"];
        Next_Page = "Darkmoon2";
        Next_Title = AtlasLoot_TableNames["Darkmoon2"][1];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Darkmoon2"] = {
        Title = AtlasLoot_TableNames["Darkmoon2"][1];
        Prev_Page = "Darkmoon1";
        Prev_Title = BabbleFaction["Darkmoon Faire"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Defilers"] = {
        Title = BabbleFaction["The Defilers"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Frostwolf1"] = {
        Title = BabbleFaction["Frostwolf Clan"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["GelkisClan1"] = {
        Title = BabbleFaction["Gelkis Clan Centaur"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["WaterLords1"] = {
        Title = BabbleFaction["Hydraxian Waterlords"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["LeagueofArathor"] = {
        Title = BabbleFaction["The League of Arathor"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["MagramClan1"] = {
        Title = BabbleFaction["Magram Clan Centaur"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Stormpike1"] = {
        Title = BabbleFaction["Stormpike Guard"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Thorium1"] = {
        Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Thorium2";
        Next_Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Thorium2"] = {
        Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Thorium1";
        Prev_Title = BabbleFaction["Thorium Brotherhood"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Timbermaw"] = {
        Title = BabbleFaction["Timbermaw Hold"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Wintersaber1"] = {
        Title = BabbleFaction["Wintersaber Trainers"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Zandalar1"] = {
        Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Zandalar2";
        Next_Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
    ["Zandalar2"] = {
        Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Zandalar1";
        Prev_Title = BabbleFaction["Zandalar Tribe"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_AZEROTHPREBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Pre-Burning Crusade"];
        };
  --Burning Crusade Factions
    ["Aldor1"] = {
        Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Aldor2";
        Next_Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Aldor2"] = {
        Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Aldor1";
        Prev_Title = BabbleFaction["The Aldor"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Ashtongue1"] = {
        Title = BabbleFaction["Ashtongue Deathsworn"];
        Next_Page = "Ashtongue2";
        Next_Title = BabbleFaction["Ashtongue Deathsworn"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Ashtongue2"] = {
        Title = BabbleFaction["Ashtongue Deathsworn"];
        Prev_Page = "Ashtongue1";
        Prev_Title = BabbleFaction["Ashtongue Deathsworn"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["CExpedition1"] = {
        Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "CExpedition2";
        Next_Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["CExpedition2"] = {
        Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "CExpedition1";
        Prev_Title = BabbleFaction["Cenarion Expedition"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Consortium1"] = {
        Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Consortium2";
        Next_Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Consortium2"] = {
        Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Consortium1";
        Prev_Title = BabbleFaction["The Consortium"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["HonorHold1"] = {
        Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "HonorHold2";
        Next_Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["HonorHold2"] = {
        Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "HonorHold1";
        Prev_Title = BabbleFaction["Honor Hold"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["KeepersofTime1"] = {
        Title = BabbleFaction["Keepers of Time"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
    ["Kurenai1"] = {
        Title = BabbleFaction["Kurenai"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["LowerCity1"] = {
        Title = BabbleFaction["Lower City"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Maghar1"] = {
        Title = BabbleFaction["The Mag'har"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Netherwing1"] = {
        Title = BabbleFaction["Netherwing"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Ogrila1"] = {
        Title = BabbleFaction["Ogri'la"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["ScaleSands1"] = {
        Title = BabbleFaction["The Scale of the Sands"];
        Next_Page = "ScaleSands2";
        Next_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
    ["ScaleSands2"] = {
        Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Honored"];
        Prev_Page = "ScaleSands1";
        Prev_Title = BabbleFaction["The Scale of the Sands"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        Next_Page = "ScaleSands3";
        Next_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Revered"].."-"..BabbleFaction["Exalted"];
        };
    ["ScaleSands3"] = {
        Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Revered"].."-"..BabbleFaction["Exalted"];
        Prev_Page = "ScaleSands2";
        Prev_Title = BabbleFaction["The Scale of the Sands"]..": "..BabbleFaction["Friendly"].."-"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
    ["Scryer1"] = {
        Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Scryer2";
        Next_Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Scryer2"] = {
        Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Scryer1";
        Prev_Title = BabbleFaction["The Scryers"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Shatar1"] = {
        Title = BabbleFaction["The Sha'tar"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["Skyguard1"] = {
        Title = BabbleFaction["Sha'tari Skyguard"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["SunOffensive1"] = {
        Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "SunOffensive2";
        Next_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        };
    ["SunOffensive2"] = {
        Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
        Next_Page = "SunOffensive3";
        Next_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        Prev_Page = "SunOffensive1";
        Prev_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        };
    ["SunOffensive3"] = {
        Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_SHATTRATH";
        Back_Title = AL["Factions - Shattrath City"];
        Prev_Page = "SunOffensive2";
        Prev_Title = BabbleFaction["Shattered Sun Offensive"]..": "..BabbleFaction["Revered"];
        };
    ["Sporeggar1"] = {
        Title = BabbleFaction["Sporeggar"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Thrallmar1"] = {
        Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Next_Page = "Thrallmar2";
        Next_Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Thrallmar2"] = {
        Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Revered"].."/"..BabbleFaction["Exalted"];
        Prev_Page = "Thrallmar1";
        Prev_Title = BabbleFaction["Thrallmar"]..": "..BabbleFaction["Friendly"].."/"..BabbleFaction["Honored"];
        Back_Page = "REPMENU_OUTLAND";
        Back_Title = AL["Factions - Outland"];
        };
    ["Tranquillien1"] = {
        Title = BabbleFaction["Tranquillien"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
    ["VioletEye1"] = {
        Title = BabbleFaction["The Violet Eye"];
        Next_Page = "VioletEye2";
        Next_Title = BabbleFaction["The Violet Eye"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
    ["VioletEye2"] = {
        Title = BabbleFaction["The Violet Eye"];
        Prev_Page = "VioletEye1";
        Prev_Title = BabbleFaction["The Violet Eye"];
        Back_Page = "REPMENU_AZEROTHPOSTBC";
        Back_Title = AL["Factions - Azeroth"].." : "..AL["Post-Burning Crusade"];
        };
  --PvP
    ["AVMisc"] = {
        Title = BabbleZone["Alterac Valley"]..": "..AL["Misc. Rewards"];
        Next_Page = "AVBlue";
        Next_Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["AVBlue"] = {
        Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
        Next_Page = "AVPurple";
        Next_Title = BabbleZone["Alterac Valley"]..": "..AL["Epic Rewards"];
        Prev_Page = "AVMisc";
        Prev_Title = BabbleZone["Alterac Valley"]..": "..AL["Misc. Rewards"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["AVPurple"] = {
        Title = BabbleZone["Alterac Valley"]..": "..AL["Epic Rewards"];
        Prev_Page = "AVBlue";
        Prev_Title = BabbleZone["Alterac Valley"]..": "..AL["Superior Rewards"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["ABMisc"] = {
        Title = BabbleZone["Arathi Basin"]..": "..AL["Misc. Rewards"];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB20291";
        Next_Title = AtlasLoot_TableNames["AB20291"][1];
        };
    ["AB20291"] = {
        Title = AtlasLoot_TableNames["AB20291"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB20292";
        Next_Title = AtlasLoot_TableNames["AB20292"][1];
        Prev_Page = "ABMisc";
        Prev_Title = BabbleZone["Arathi Basin"]..": "..AL["Misc. Rewards"];
        };
    ["AB20292"] = {
        Title = AtlasLoot_TableNames["AB20292"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB3039";
        Next_Title = AtlasLoot_TableNames["AB3039"][1];
        Prev_Page = "AB20291";
        Prev_Title = AtlasLoot_TableNames["AB20291"][1];
        };
    ["AB3039"] = {
        Title = AtlasLoot_TableNames["AB3039"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB40491";
        Next_Title = AtlasLoot_TableNames["AB40491"][1];
        Prev_Page = "AB20292";
        Prev_Title = AtlasLoot_TableNames["AB20292"][1];
        };
    ["AB40491"] = {
        Title = AtlasLoot_TableNames["AB40491"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB40492";
        Next_Title = AtlasLoot_TableNames["AB40492"][1];
        Prev_Page = "AB3039";
        Prev_Title = AtlasLoot_TableNames["AB3039"][1];
        };
    ["AB40492"] = {
        Title = AtlasLoot_TableNames["AB40492"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB5059";
        Next_Title = AtlasLoot_TableNames["AB5059"][1];
        Prev_Page = "AB40491";
        Prev_Title = AtlasLoot_TableNames["AB40491"][1];
        };
    ["AB5059"] = {
        Title = AtlasLoot_TableNames["AB5059"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Next_Page = "AB60";
        Next_Title = AtlasLoot_TableNames["AB60"][1];
        Prev_Page = "AB40492";
        Prev_Title = AtlasLoot_TableNames["AB40492"][1];
        };
    ["AB60"] = {
        Title = AtlasLoot_TableNames["AB60"][1];
        Back_Page = "ABMENU";
        Back_Title = BabbleZone["Arathi Basin"];
        Prev_Page = "AB5059";
        Prev_Title = AtlasLoot_TableNames["AB5059"][1];
        };
    ["ABSets1"] = {
        Title = AtlasLoot_TableNames["ABSets1"][1];
        Next_Page = "ABSets2";
        Next_Title = AtlasLoot_TableNames["ABSets2"][1];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["ABSets2"] = {
        Title = AtlasLoot_TableNames["ABSets2"][1];
        Next_Page = "ABSets3";
        Next_Title = AtlasLoot_TableNames["ABSets3"][1];
        Prev_Page = "ABSets1";
        Prev_Title = AtlasLoot_TableNames["ABSets1"][1];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["ABSets3"] = {
        Title = AtlasLoot_TableNames["ABSets3"][1];
        Prev_Page = "ABSets2";
        Prev_Title = AtlasLoot_TableNames["ABSets2"][1];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["WSGMisc"] = {
        Title = BabbleZone["Warsong Gulch"]..": "..AL["Misc. Rewards"];
        Next_Page = "WSG1019";
        Next_Title = AtlasLoot_TableNames["WSG1019"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG1019"] = {
        Title = AtlasLoot_TableNames["WSG1019"][1];
        Next_Page = "WSG2029";
        Next_Title = AtlasLoot_TableNames["WSG2029"][1];
        Prev_Page = "WSGMisc";
        Prev_Title = BabbleZone["Warsong Gulch"]..": "..AL["Misc. Rewards"];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG2029"] = {
        Title = AtlasLoot_TableNames["WSG2029"][1];
        Next_Page = "WSG3039";
        Next_Title = AtlasLoot_TableNames["WSG3039"][1];
        Prev_Page = "WSG1019";
        Prev_Title = AtlasLoot_TableNames["WSG1019"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG3039"] = {
        Title = AtlasLoot_TableNames["WSG3039"][1];
        Next_Page = "WSG4049";
        Next_Title = AtlasLoot_TableNames["WSG4049"][1];
        Prev_Page = "WSG2029";
        Prev_Title = AtlasLoot_TableNames["WSG2029"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG4049"] = {
        Title = AtlasLoot_TableNames["WSG4049"][1];
        Next_Page = "WSG5059";
        Next_Title = AtlasLoot_TableNames["WSG5059"][1];
        Prev_Page = "WSG3039";
        Prev_Title = AtlasLoot_TableNames["WSG3039"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG5059"] = {
        Title = AtlasLoot_TableNames["WSG5059"][1];
        Next_Page = "WSG60";
        Next_Title = AtlasLoot_TableNames["WSG60"][1];
        Prev_Page = "WSG4049";
        Prev_Title = AtlasLoot_TableNames["WSG4049"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["WSG60"] = {
        Title = AtlasLoot_TableNames["WSG60"][1];
        Prev_Page = "WSG5059";
        Prev_Title = AtlasLoot_TableNames["WSG5059"][1];
        Back_Page = "WSGMENU";
        Back_Title = BabbleZone["Warsong Gulch"];
        };
    ["PvP60Accessories1"] = {
        Title = AL["PvP Accessories"]..": "..AL["Level 60"];
        Next_Page = "PvP60Accessories2";
        Next_Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PvP60Accessories2"] = {
        Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
        Next_Page = "PvP60Accessories3";
        Next_Title = AtlasLoot_TableNames["PvP60Accessories3"][1];
        Prev_Page = "PvP60Accessories1";
        Prev_Title = AL["PvP Accessories"]..": "..AL["Level 60"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PvP60Accessories3"] = {
        Title = AtlasLoot_TableNames["PvP60Accessories3"][1];
        Prev_Page = "PvP60Accessories2";
        Prev_Title = AtlasLoot_TableNames["PvP60Accessories2"][1];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PvP70Accessories1"] = {
        Title = AL["PvP Accessories"]..": "..AL["Level 70"];
        Next_Page = "PvP70Accessories2";
        Next_Title = AL["PvP Accessories"]..": "..AL["Level 70"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PvP70Accessories2"] = {
        Title = AL["PvP Accessories"]..": "..AL["Level 70"];
        Prev_Page = "PvP70Accessories1";
        Prev_Title = AL["PvP Accessories"]..": "..AL["Level 70"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PVPWeapons1"] = {
        Title = AL["PvP Weapons"]..": "..AL["Level 60"];
        Next_Page = "PVPWeapons2";
        Next_Title = AL["PvP Weapons"]..": "..AL["Level 60"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PVPWeapons2"] = {
        Title = AL["PvP Weapons"]..": "..AL["Level 60"];
        Prev_Page = "PVPWeapons1";
        Prev_Title = AL["PvP Weapons"]..": "..AL["Level 60"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PVP70Weapons1"] = {
        Title = AL["PvP Weapons"]..": "..AL["Level 70"];
        Next_Page = "PVP70Weapons2";
        Next_Title = AL["PvP Weapons"]..": "..AL["Level 70"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["PVP70Weapons2"] = {
        Title = AL["PvP Weapons"]..": "..AL["Level 70"];
        Prev_Page = "PVP70Weapons1";
        Prev_Title = AL["PvP Weapons"]..": "..AL["Level 70"];
        Back_Page = "HONORMENU";
        Back_Title = AL["PvP Honor System"];
        };
    ["Arena1Weapons1"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 1"];
        Next_Page = "Arena1Weapons2";
        Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 1"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena1Weapons2"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 1"];
        Prev_Page = "Arena1Weapons1";
        Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 1"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena2Weapons1"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
        Next_Page = "Arena2Weapons2";
        Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena2Weapons2"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
        Prev_Page = "Arena2Weapons1";
        Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 2"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena3Weapons1"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
        Next_Page = "Arena3Weapons2";
        Next_Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena3Weapons2"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
        Prev_Page = "Arena3Weapons1";
        Prev_Title = AL["Arena PvP Weapons"]..": "..AL["Season 3"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["Arena4Weapons1"] = {
        Title = AL["Arena PvP Weapons"]..": "..AL["Season 4"];
        Back_Page = "ARENAMENU";
        Back_Title = AL["Arena PvP System"];
        };
    ["PvP70NonSet1"] = {
        Title = AtlasLoot_TableNames["PvP70NonSet1"][1];
        Next_Page = "PvP70NonSet2";
        Next_Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
        Back_Page = "PVP70NONSETEPICS";
        Back_Title = AL["PvP Non-Set Epics"];
        };
    ["PvP70NonSet2"] = {
        Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
        Next_Page = "PvP70NonSet3";
        Next_Title = AtlasLoot_TableNames["PvP70NonSet3"][1];
        Prev_Page = "PvP70NonSet1";
        Prev_Title = AtlasLoot_TableNames["PvP70NonSet1"][1];
        Back_Page = "PVP70NONSETEPICS";
        Back_Title = AL["PvP Non-Set Epics"];
        };
    ["PvP70NonSet3"] = {
        Title = AtlasLoot_TableNames["PvP70NonSet3"][1];
        Prev_Page = "PvP70NonSet2";
        Prev_Title = AtlasLoot_TableNames["PvP70NonSet2"][1];
        Back_Page = "PVP70NONSETEPICS";
        Back_Title = AL["PvP Non-Set Epics"];
        };
  --WorldPvP
    ["Hellfire"] = {
        Title = BabbleZone["Hellfire Peninsula"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["Zangarmarsh"] = {
        Title = BabbleZone["Zangarmarsh"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["Nagrand1"] = {
        Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
        Next_Page = "Nagrand2";
        Next_Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["Nagrand2"] = {
        Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
        Prev_Page = "Nagrand1";
        Prev_Title = BabbleZone["Nagrand"]..": "..AL["Halaa"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
    ["Terokkar"] = {
        Title = BabbleZone["Terokkar Forest"];
        Back_Page = "PVPMENU";
        Back_Title = AL["PvP Rewards"];
        };
  --PvP Armor Sets
    ["PVPDruid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPHunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPMage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPPaladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPPriest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPRogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPShaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPWarlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVPWarrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "PVPSET";
        Back_Title = AL["PvP Armor Sets"];
        };
    ["PVP70RepDruid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepHunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepMage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepPaladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepPriest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepRogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepShaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepWarlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["PVP70RepWarrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "PVP70RepSET";
        Back_Title = AL["PvP Reputation Sets"];
        };
    ["ArenaDruid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaHunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaMage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaPaladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaPriest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaRogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaShaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaWarlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["ArenaWarrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "ARENASET";
        Back_Title = AL["Arena PvP Sets"];
        };
    ["Arena2Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena2Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "ARENA2SET";
        Back_Title = AL["Arena 2 PvP Sets"];
        };
    ["Arena3Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena3Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "ARENA3SET";
        Back_Title = AL["Arena 3 PvP Sets"];
        };
    ["Arena4Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
    ["Arena4Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "ARENA4SET";
        Back_Title = AL["Arena 4 PvP Sets"];
        };
  --Dungeon Armor Sets
    ["T0Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["T0Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T0SET";
        Back_Title = AL["Dungeon 1/2 Sets"];
        };
    ["DS3Hallowed"] = {
        Title = AL["Hallowed Raiment"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Incanter"] = {
        Title = AL["Incanter's Regalia"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Mana"] = {
        Title = AL["Mana-Etched Regalia"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Oblivion"] = {
        Title = AL["Oblivion Raiment"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Assassin"] = {
        Title = AL["Assassination Armor"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Moonglade"] = {
        Title = AL["Moonglade Raiment"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Wastewalker"] = {
        Title = AL["Wastewalker Armor"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Beast"] = {
        Title = AL["Beast Lord Armor"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Desolation"] = {
        Title = AL["Desolation Battlegear"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Tidefury"] = {
        Title = AL["Tidefury Raiment"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Bold"] = {
        Title = AL["Bold Armor"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Doom"] = {
        Title = AL["Doomplate Battlegear"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
    ["DS3Right"] = {
        Title = AL["Righteous Armor"];
        Back_Page = "DS3SET";
        Back_Title = AL["Dungeon 3 Sets"];
        };
  --Tier Armor Sets
    ["T1Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T1Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T1SET";
        Back_Title = AL["Tier 1 Sets"];
        };
    ["T2Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T2Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T2SET";
        Back_Title = AL["Tier 2 Sets"];
        };
    ["T3Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T3Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T3SET";
        Back_Title = AL["Tier 3 Sets"];
        };
    ["T4Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T4Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T4SET";
        Back_Title = AL["Tier 4 Sets"];
        };
    ["T5Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T5Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T5SET";
        Back_Title = AL["Tier 5 Sets"];
        };
    ["T6Druid"] = {
        Title = BabbleClass["Druid"];
        Next_Page = "T6Druid2";
        Next_Title = BabbleClass["Druid"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Druid2"] = {
        Title = BabbleClass["Druid"];
        Prev_Page = "T6Druid";
        Prev_Title = BabbleClass["Druid"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Paladin"] = {
        Title = BabbleClass["Paladin"];
        Next_Page = "T6Paladin2";
        Next_Title = BabbleClass["Paladin"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Paladin2"] = {
        Title = BabbleClass["Paladin"];
        Prev_Page = "T6Paladin";
        Prev_Title = BabbleClass["Paladin"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Shaman"] = {
        Title = BabbleClass["Shaman"];
        Next_Page = "T6Shaman2";
        Next_Title = BabbleClass["Shaman"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Shama2"] = {
        Title = BabbleClass["Shaman"];
        Prev_Page = "T6Shaman";
        Prev_Title = BabbleClass["Shaman"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
    ["T6Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "T6SET";
        Back_Title = AL["Tier 6 Sets"];
        };
  --AQ40 Armor Sets
    ["AQ40Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
    ["AQ40Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "AQ40SET";
        Back_Title = AL["Temple of Ahn'Qiraj Sets"];
        };
  --AQ20 Armor Sets
    ["AQ20Druid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Hunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Mage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Paladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Priest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Rogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Shaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Warlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
    ["AQ20Warrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "AQ20SET";
        Back_Title = AL["Ruins of Ahn'Qiraj Sets"];
        };
  --ZG Armor Sets
    ["ZGDruid"] = {
        Title = BabbleClass["Druid"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGHunter"] = {
        Title = BabbleClass["Hunter"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGMage"] = {
        Title = BabbleClass["Mage"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGPaladin"] = {
        Title = BabbleClass["Paladin"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGPriest"] = {
        Title = BabbleClass["Priest"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGRogue"] = {
        Title = BabbleClass["Rogue"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGShaman"] = {
        Title = BabbleClass["Shaman"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGWarlock"] = {
        Title = BabbleClass["Warlock"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
    ["ZGWarrior"] = {
        Title = BabbleClass["Warrior"];
        Back_Page = "ZGSET";
        Back_Title = AL["Zul'Gurub Sets"];
        };
  --Vanilla WoW Armor Sets
    ["VWOWDeadmines"] = {
        Title = AL["Defias Leather"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWWailingC"] = {
        Title = AL["Embrace of the Viper"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScarletM"] = {
        Title = AL["Chain of the Scarlet Crusade"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWBlackrockD"] = {
        Title = AL["The Gladiator"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWIronweave"] = {
        Title = AL["Ironweave Battlesuit"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScholoCloth"] = {
        Title = AL["Necropile Raiment"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScholoLeather"] = {
        Title = AL["Cadaverous Garb"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScholoMail"] = {
        Title = AL["Bloodmail Regalia"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScholoPlate"] = {
        Title = AL["Deathbone Guardian"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWStrat"] = {
        Title = AL["The Postmaster"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWScourgeInvasion"] = {
        Title = AL["Scourge Invasion"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWShardOfGods"] = {
        Title = AL["Shard of the Gods"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWZGRings"] = {
        Title = AL["Zul'Gurub Rings"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWSpiritofEskhandar"] = {
        Title = AL["Spirit of Eskhandar"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWHakkariBlades"] = {
        Title = AL["The Twin Blades of Hakkari"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWPrimalBlessing"] = {
        Title = AL["Primal Blessing"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWDalRend"] = {
        Title = AL["Dal'Rend's Arms"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["VWOWSpiderKiss"] = {
        Title = AL["Spider's Kiss"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
  --The Burning Crusade WoW Armor Sets
    ["TBCLatrosFlurry"] = {
        Title = AL["Latro's Flurry"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["TBCTwinStars"] = {
        Title = AL["The Twin Stars"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
    ["TBCAzzinothBlades"] = {
        Title = AL["The Twin Blades of Azzinoth"];
        Back_Page = "PRE60SET";
        Back_Title = AL["Pre 60 Sets"];
        };
  --Blacksmithing Plate Sets
    ["ImperialPlate"] = {
        Title = AL["Imperial Plate"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["TheDarksoul"] = {
        Title = AL["The Darksoul"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["FelIronPlate"] = {
        Title = AL["Fel Iron Plate"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["AdamantiteB"] = {
        Title = AL["Adamantite Battlegear"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["FlameG"] = {
        Title = AL["Flame Guard"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["EnchantedAdaman"] = {
        Title = AL["Enchanted Adamantite Armor"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["KhoriumWard"] = {
        Title = AL["Khorium Ward"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["FaithFelsteel"] = {
        Title = AL["Faith in Felsteel"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["BurningRage"] = {
        Title = AL["Burning Rage"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
  --Blacksmithing Mail Sets
    ["BloodsoulEmbrace"] = {
        Title = AL["Bloodsoul Embrace"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["FelIronChain"] = {
        Title = AL["Fel Iron Chain"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
  --Tailoring Sets
    ["BloodvineG"] = {
        Title = AL["Bloodvine Garb"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["NeatherVest"] = {
        Title = AL["Netherweave Vestments"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["ImbuedNeather"] = {
        Title = AL["Imbued Netherweave"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["ArcanoVest"] = {
        Title = AL["Arcanoweave Vestments"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["TheUnyielding"] = {
        Title = AL["The Unyielding"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["WhitemendWis"] = {
        Title = AL["Whitemend Wisdom"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["SpellstrikeInfu"] = {
        Title = AL["Spellstrike Infusion"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["BattlecastG"] = {
        Title = AL["Battlecast Garb"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["SoulclothEm"] = {
        Title = AL["Soulcloth Embrace"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["PrimalMoon"] = {
        Title = AL["Primal Mooncloth"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["ShadowEmbrace"] = {
        Title = AL["Shadow's Embrace"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
    ["SpellfireWrath"] = {
        Title = AL["Wrath of Spellfire"];
        Back_Page = "CRAFTSET";
        Back_Title = AL["Crafted Sets"];
        };
  --Leatherworking Sets
    ["VolcanicArmor"] = {
        Title = AL["Volcanic Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["IronfeatherArmor"] = {
        Title = AL["Ironfeather Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["StormshroudArmor"] = {
        Title = AL["Stormshroud Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["DevilsaurArmor"] = {
        Title = AL["Devilsaur Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["BloodTigerH"] = {
        Title = AL["Blood Tiger Harness"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["PrimalBatskin"] = {
        Title = AL["Primal Batskin"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["WildDraenishA"] = {
        Title = AL["Wild Draenish Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["ThickDraenicA"] = {
        Title = AL["Thick Draenic Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["FelSkin"] = {
        Title = AL["Fel Skin"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["SClefthoof"] = {
        Title = AL["Strength of the Clefthoof"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["GreenDragonM"] = {
        Title = AL["Green Dragon Mail"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["BlueDragonM"] = {
        Title = AL["Blue Dragon Mail"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["BlackDragonM"] = {
        Title = AL["Black Dragon Mail"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["ScaledDraenicA"] = {
        Title = AL["Scaled Draenic Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["FelscaleArmor"] = {
        Title = AL["Felscale Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["FelstalkerArmor"] = {
        Title = AL["Felstalker Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["NetherFury"] = {
        Title = AL["Fury of the Nether"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["PrimalIntent"] = {
        Title = AL["Primal Intent"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["WindhawkArmor"] = {
        Title = AL["Windhawk Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["NetherscaleArmor"] = {
        Title = AL["Netherscale Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
    ["NetherstrikeArmor"] = {
        Title = AL["Netherstrike Armor"];
        Back_Page = "CRAFTSET2";
        Back_Title = AL["Crafted Sets"];
        };
  --Lvl 70 Instance Token Rewards
    ["HardModeCloth"] = {
        Title = AtlasLoot_TableNames["HardModeCloth"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeLeather"] = {
        Title = AtlasLoot_TableNames["HardModeLeather"][1];
        Next_Page = "HardModeLeather2";
        Next_Title = AL["Lvl 70 Instance Rewards"].." - "..BabbleInventory["Leather"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeLeather2"] = {
        Title = AtlasLoot_TableNames["HardModeLeather2"][1];
        Prev_Page = "HardModeLeather";
        Prev_Title = AL["Lvl 70 Instance Rewards"].." - "..BabbleInventory["Leather"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeMail"] = {
        Title = AtlasLoot_TableNames["HardModeMail"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModePlate"] = {
        Title = AtlasLoot_TableNames["HardModePlate"][1];
        Next_Page = "HardModePlate2";
        Next_Title = AL["Lvl 70 Instance Rewards"].." - "..BabbleInventory["Plate"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModePlate2"] = {
        Title = AtlasLoot_TableNames["HardModePlate2"][1];
        Prev_Page = "HardModePlate";
        Prev_Title = AL["Lvl 70 Instance Rewards"].." - "..BabbleInventory["Plate"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeCloaks"] = {
        Title = AtlasLoot_TableNames["HardModeCloaks"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeResist"] = {
        Title = AtlasLoot_TableNames["HardModeResist"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeAccessories"] = {
        Title = AtlasLoot_TableNames["HardModeAccessories"][1];
        Next_Page = "HardModeAccessories2";
        Next_Title = AL["Lvl 70 Instance Rewards"].." - "..AL["Accessories"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeAccessories2"] = {
        Title = AtlasLoot_TableNames["HardModeAccessories"][1];
        Prev_Page = "HardModeAccessories";
        Prev_Title = AL["Lvl 70 Instance Rewards"].." - "..AL["Accessories"];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeRelic"] = {
        Title = AtlasLoot_TableNames["HardModeRelic"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
    ["HardModeWeapons"] = {
        Title = AtlasLoot_TableNames["HardModeWeapons"][1];
        Back_Page = "70TOKENMENU";
        Back_Title = AL["Lvl 70 Instance Token Rewards"];
        };
  --Misc Collections
    ["CardGame1"] = {
        Title = AL["Upper Deck Card Game Items"];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["CraftedWeapons1"] = {
        Title = AL["Crafted Epic Weapons"];
        Next_Page = "CraftedWeapons2";
        Next_Title = AL["Crafted Epic Weapons"];
        Back_Page = "CRAFTINGMENU";
        Back_Title = AL["Collections"];
        };
    ["CraftedWeapons2"] = {
        Title = AL["Crafted Epic Weapons"];
        Prev_Page = "CraftedWeapons1";
        Prev_Title = AL["Crafted Epic Weapons"];
        Back_Page = "CRAFTINGMENU";
        Back_Title = AL["Collections"];
        };
    ["Legendaries"] = {
        Title = AL["Legendary Items"];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["RareMounts1"] = {
        Title = AtlasLoot_TableNames["RareMounts1"][1];
        Next_Page = "RareMounts2";
        Next_Title = AtlasLoot_TableNames["RareMounts2"][1];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["RareMounts2"] = {
        Title = AtlasLoot_TableNames["RareMounts2"][1];
        Prev_Page = "RareMounts1";
        Prev_Title = AtlasLoot_TableNames["RareMounts1"][1];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["Tabards1"] = {
        Title = AtlasLoot_TableNames["Tabards1"][1];
        Next_Page = "Tabards2";
        Next_Title = AtlasLoot_TableNames["Tabards2"][1];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["Tabards2"] = {
        Title = AtlasLoot_TableNames["Tabards2"][1];
        Prev_Page = "Tabards1";
        Prev_Title = AtlasLoot_TableNames["Tabards1"][1];
        Back_Page = "SETMENU";
        Back_Title = AL["Collections"];
        };
    ["WorldEpics1"] = {
        Title = AtlasLoot_TableNames["WorldEpics1"][1];
        Next_Page = "WorldEpics2";
        Next_Title = AtlasLoot_TableNames["WorldEpics2"][1];
        Back_Page = "WORLDEPICS";
        Back_Title = AL["BoE World Epics"];
        };
    ["WorldEpics2"] = {
        Title = AtlasLoot_TableNames["WorldEpics2"][1];
        Next_Page = "WorldEpics3";
        Next_Title = AtlasLoot_TableNames["WorldEpics3"][1];
        Prev_Page = "WorldEpics1";
        Prev_Title = AtlasLoot_TableNames["WorldEpics1"][1];
        Back_Page = "WORLDEPICS";
        Back_Title = AL["BoE World Epics"];
        };
    ["WorldEpics3"] = {
        Title = AtlasLoot_TableNames["WorldEpics3"][1];
        Next_Page = "WorldEpics4";
        Next_Title = AtlasLoot_TableNames["WorldEpics4"][1];
        Prev_Page = "WorldEpics2";
        Prev_Title = AtlasLoot_TableNames["WorldEpics2"][1];
        Back_Page = "WORLDEPICS";
        Back_Title = AL["BoE World Epics"];
        };
    ["WorldEpics4"] = {
        Title = AtlasLoot_TableNames["WorldEpics4"][1];
        Prev_Page = "WorldEpics3";
        Prev_Title = AtlasLoot_TableNames["WorldEpics3"][1];
        Back_Page = "WORLDEPICS";
        Back_Title = AL["BoE World Epics"];
        };
  --Misc
    ["ZGTrash1"] = {
        Title = AtlasLoot_TableNames["ZGTrash1"][1];
        Next_Page = "ZGTrash2";
        Next_Title = AtlasLoot_TableNames["ZGTrash2"][1];
        };
    ["ZGTrash2"] = {
        Title = AtlasLoot_TableNames["ZGTrash2"][1];
        Prev_Page = "ZGTrash1";
        Prev_Title = AtlasLoot_TableNames["ZGTrash1"][1];
        };
    ["AQ40Trash1"] = {
        Title = AtlasLoot_TableNames["AQ40Trash1"][1];
        Next_Page = "AQ40Trash2";
        Next_Title = AtlasLoot_TableNames["AQ40Trash2"][1];
        };
    ["AQ40Trash2"] = {
        Title = AtlasLoot_TableNames["AQ40Trash2"][1];
        Prev_Page = "AQ40Trash1";
        Prev_Title = AtlasLoot_TableNames["AQ40Trash1"][1];
        };
  --Season Events
    ["Brewfest1"] = {
        Title = AL["Brewfest"];
        Next_Page = "Brewfest2";
        Next_Title = AL["Brewfest"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Brewfest2"] = {
        Title = AL["Brewfest"];
        Prev_Page = "Brewfest1";
        Prev_Title = AL["Brewfest"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["ChildrensWeek"] = {
        Title = AL["Children's Week"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Winterviel1"] = {
        Title = AL["Feast of Winter Veil"];
        Next_Page = "Winterviel2";
        Next_Title = AtlasLoot_TableNames["Winterviel2"][1];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Winterviel2"] = {
        Title = AtlasLoot_TableNames["Winterviel2"][1];
        Prev_Page = "Winterviel1";
        Prev_Title = AL["Feast of Winter Veil"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Halloween1"] = {
        Title = AL["Hallow's End"];
        Next_Page = "Halloween2";
        Next_Title = AL["Hallow's End"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Halloween2"] = {
        Title = AL["Hallow's End"];
        Next_Page = "HeadlessHorseman";
        Next_Title = AL["Headless Horseman"];
        Prev_Page = "Halloween1";
        Prev_Title = AL["Hallow's End"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["HeadlessHorseman"] = {
        Title = AL["Headless Horseman"];
        Prev_Page = "Halloween2";
        Prev_Title = AL["Hallow's End"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["HarvestFestival"] = {
        Title = AL["Harvest Festival"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Valentineday"] = {
        Title = AL["Love is in the Air"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["LunarFestival1"] = {
        Title = AL["Lunar Festival"];
        Next_Page = "LunarFestival2";
        Next_Title = AL["Lunar Festival"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["LunarFestival2"] = {
        Title = AL["Lunar Festival"];
        Prev_Page = "LunarFestival1";
        Prev_Title = AL["Lunar Festival"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["MidsummerFestival"] = {
        Title = AL["Midsummer Fire Festival"];
        Next_Page = "LordAhune";
        Next_Title = AL["Lord Ahune"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["LordAhune"] = {
        Title = AL["Lord Ahune"];
        Prev_Page = "MidsummerFestival";
        Prev_Title = AL["Midsummer Fire Festival"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Noblegarden"] = {
        Title = AL["Noblegarden"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    --World Events
    ["BashirLanding"] = {
        Title = AL["Bash'ir Landing Skyguard Raid"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["ElementalInvasion"] = {
        Title = AL["Elemental Invasion"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["GurubashiArena"] = {
        Title = AL["Gurubashi Arena Booty Run"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["Shartuul"] = {
        Title = AL["Shartuul"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["ScourgeInvasionEvent1"] = {
        Title = AL["Scourge Invasion"];
        Next_Page = "ScourgeInvasionEvent2";
        Next_Title = AtlasLoot_TableNames["ScourgeInvasionEvent2"][1];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["ScourgeInvasionEvent2"] = {
        Title = AtlasLoot_TableNames["ScourgeInvasionEvent2"][1];
        Prev_Page = "ScourgeInvasionEvent1";
        Prev_Title = AL["Scourge Invasion"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
    ["FishingExtravaganza"] = {
        Title = AL["Stranglethorn Fishing Extravaganza"];
        Back_Page = "WORLDEVENTMENU";
        Back_Title = AL["World Events"];
        };
  --Abyssal Counci
    ["Templars"] = {
        Title = AL["Abyssal Council"].." - "..AL["Templars"];
        Back_Page = "ABYSSALMENU";
        Back_Title = AL["Abyssal Council"];
        };
    ["Dukes"] = {
        Title = AL["Abyssal Council"].." - "..AL["Dukes"];
        Back_Page = "ABYSSALMENU";
        Back_Title = AL["Abyssal Council"];
        };
    ["HighCouncil"] = {
        Title = AL["Abyssal Council"].." - "..AL["High Council"];
        Back_Page = "ABYSSALMENU";
        Back_Title = AL["Abyssal Council"];
        };
  --Ethereum Prison
    ["ArmbreakerHuffaz"] = {
        Title = AL["Armbreaker Huffaz"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["FelTinkererZortan"] = {
        Title = AL["Fel Tinkerer Zortan"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["Forgosh"] = {
        Title = AL["Forgosh"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["Gulbor"] = {
        Title = AL["Gul'bor"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["MalevustheMad"] = {
        Title = AL["Malevus the Mad"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["PorfustheGemGorger"] = {
        Title = AL["Porfus the Gem Gorger"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["WrathbringerLaztarash"] = {
        Title = AL["Wrathbringer Laz-tarash"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
    ["BashirStasisChambers"] = {
        Title = AL["Bash'ir Landing Stasis Chambers"];
        Back_Page = "ETHEREUMMENU";
        Back_Title = AL["Ethereum Prison"];
        };
  --Skettis
    ["DarkscreecherAkkarai"] = {
        Title = AL["Darkscreecher Akkarai"];
        Back_Page = "SKETTISMENU";
        Back_Title = AL["Skettis"];
        };
    ["Karrog"] = {
        Title = AL["Karrog"];
        Back_Page = "SKETTISMENU";
        Back_Title = AL["Skettis"];
        };
    ["GezzaraktheHuntress"] = {
        Title = AL["Gezzarak the Huntress"];
        Back_Page = "SKETTISMENU";
        Back_Title = AL["Skettis"];
        };
    ["VakkiztheWindrager"] = {
        Title = AL["Vakkiz the Windrager"];
        Back_Page = "SKETTISMENU";
        Back_Title = AL["Skettis"];
        };
    ["Terokk"] = {
        Title = AL["Terokk"];
        Back_Page = "SKETTISMENU";
        Back_Title = AL["Skettis"];
        };
    --Alchemy
    ["AlchemyApprentice1"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Apprentice"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyJourneyman1";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Journeyman"];
        };
    ["AlchemyJourneyman1"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Journeyman"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyExpert1";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Expert"];
        Prev_Page = "AlchemyApprentice1";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Apprentice"];
        };
    ["AlchemyExpert1"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Expert"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyArtisan1";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        Prev_Page = "AlchemyJourneyman1";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Journeyman"];
        };
    ["AlchemyArtisan1"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyArtisan2";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        Prev_Page = "AlchemyExpert1";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Expert"];
        };
    ["AlchemyArtisan2"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyMaster1";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Prev_Page = "AlchemyArtisan1";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        };
    ["AlchemyMaster1"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyMaster2";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Prev_Page = "AlchemyArtisan2";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Artisan"];
        };
    ["AlchemyMaster2"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Next_Page = "AlchemyMaster3";
        Next_Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Prev_Page = "AlchemyMaster1";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        };
    ["AlchemyMaster3"] = {
        Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        Back_Page = "ALCHEMYMENU";
        Back_Title = BabbleTrade["Alchemy"];
        Prev_Page = "AlchemyMaster2";
        Prev_Title = BabbleTrade["Alchemy"]..": "..AL["Master"];
        };
};