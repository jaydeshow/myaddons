local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

--------------------------------------------------------------------------------
-- ItemIDs (default english)
--------------------------------------------------------------------------------
AtlasLoot_Data["AtlasLootItems"] = {

    EmptyInstance = {};

        ------------
        --- Keys ---
        ------------

    OldKeys = {
        { 0, "INV_Box_01", "=q6=#e9#", "" },
        { 16309, "INV_Jewelry_Talisman_11", "=q3=Drakefire Amulet", "=ds=#e9#, #s2#" },
        { 12344, "INV_Jewelry_Ring_01","=q3=Seal of Ascension", "=ds=#e9#, #s13#" },
        { 17191, "INV_Staff_16", "=q3=Scepter of Celebras", "=ds=#e9#" },
        { 7146, "INV_Misc_Key_01", "=q2=The Scarlet Key", "=ds=#e9#" },
        { 12382, "INV_Misc_Key_13", "=q2=Key to the City", "=ds=#e9#" },
        { 6893,  "INV_Misc_Key_06", "=q1=Workshop Key", "=ds=#e9#" },
        { 11000, "INV_Misc_Key_08", "=q1=Shadowforge Key", "=ds=#e9#" },
        { 11140, "INV_Misc_Key_10", "=q1=Prison Cell Key", "=ds=#e9#" },
        { 18249, "INV_Misc_Key_10", "=q1=Crescent Key", "=ds=#e9#" },
        { 13704, "INV_Misc_Key_11", "=q1=Skeleton Key", "=ds=#e9#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#j7#", "" },
        { 22057, "INV_Misc_EngGizmos_23", "=q1=Brazier of Invocation", "=ds=#m27#" },
        { 21986, "INV_BRD_Banner", "=q1=Banner of Provocation", "=ds=#m27#" },
        { 0, "INV_Box_01", "=q6=#m20#", "" },
        { 9240,  "INV_Hammer_19", "=q2=Mallet of Zul'Farrak", "=ds=#m27#" },
        { 17333, "INV_Potion_76", "=q1=Aqual Quintessence", "=ds=#m3#" },
        { 22754, "INV_Potion_83", "=q1=Eternal Quintessence", "=ds=#m3#" },
        { 13523, "INV_Potion_24", "=q1=Blood of Innocents", "=ds=#m27#" },
        { 18746, "INV_Misc_EngGizmos_08", "=q1=Divination Scryer", "=ds=#m27#" },
        { 18663, "INV_Misc_Urn_01", "=q1=J'eevee's Jar", "=ds=#m27#" },
        { 19974, "INV_Cask_01", "=q1=Mudskunk Lure", "=ds=#m27#" },
        { 7733, "INV_Staff_01", "=q1=Staff of Prehistoria", "=ds=#m27#" }, 
        { 10818, "INV_Scroll_02", "=q1=Yeh'kinya's Scroll", "=ds=#m27#" }, 
        };

        ----------------------
        --- Blackwing Lair ---
        ----------------------

    BWLRazorgore = {
        { 16918, "INV_Bracer_09", "=q4=Netherwind Bindings",         "=ds==q1=#m1# =ds=#c3#", "20.41%" },
        { 16926, "INV_Bracer_09", "=q4=Bindings of Transcendence", "=q1=#m1# =ds=#c5#", "20.37%" },
        { 16934, "INV_Bracer_07", "=q4=Nemesis Bracers",             "=q1=#m1# =ds=#c8#", "18.11%" },
        { 16911, "INV_Bracer_02", "=q4=Bloodfang Bracers",           "=q1=#m1# =ds=#c6#", "20.69%" },
        { 16904, "INV_Bracer_03", "=q4=Stormrage Bracers",         "=q1=#m1# =ds=#c1#", "17.38%" },
        { 16935, "INV_Bracer_17", "=q4=Dragonstalker's Bracers",   "=q1=#m1# =ds=#c2#", "19.13%" },
        { 16943, "INV_Bracer_16", "=q4=Bracers of Ten Storms",     "=q1=#m1# =ds=#c7#", "7.54%" },
        { 16959, "INV_Bracer_19", "=q4=Bracelets of Wrath",        "=q1=#m1# =ds=#c9#", "20.29%" },
        { 16951, "INV_Bracer_18", "=q4=Judgement Bindings",        "=q1=#m1# =ds=#c4#", "13.61%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19337, "INV_Misc_Book_06", "=q4=The Black Book", "=ds=#s14#, =q1=#m1# =ds=#c8#", "18.37%" },
        { 19336, "Spell_Nature_WispSplode", "=q4=Arcane Infused Gem", "=ds=#s14#, =q1=#m1# =ds=#c2#", "17.33%" },
        { 0,"","","" },
        { 19370, "INV_Shoulder_25", "=q4=Mantle of the Blackwing Cabal", "=ds=#s3#, #a1#", "18.57%" },
        { 19369, "INV_Gauntlets_06", "=q4=Gloves of Rapid Evolution",    "=ds=#s9#, #a1#", "17.52%" },
        { 19334, "INV_Sword_50", "=q4=The Untamed Blade",                "=ds=#h2#, #w10#", "9.76%" },
        { 19335, "INV_Mace_06", "=q4=Spineshatter",                      "=ds=#h3#, #w6#", "10.44%" },
        };

    BWLVaelastrasz = {
        { 16818, "INV_Belt_22", "=q4=Netherwind Belt",       "=q1=#m1# =ds=#c3#", "19.94%" },
        { 16925, "INV_Belt_22", "=q4=Belt of Transcendence", "=q1=#m1# =ds=#c5#", "18.76%" },
        { 16933, "INV_Belt_13", "=q4=Nemesis Belt",          "=q1=#m1# =ds=#c8#", "18.42%" },
        { 16936, "INV_Belt_28", "=q4=Dragonstalker's Belt",  "=q1=#m1# =ds=#c2#", "20.17%" },
        { 16903, "INV_Belt_06", "=q4=Stormrage Belt",        "=q1=#m1# =ds=#c1#", "16.90%" },
        { 16910, "INV_Belt_23", "=q4=Bloodfang Belt",        "=q1=#m1# =ds=#c6#", "19.69%" },
        { 16944, "INV_Belt_14", "=q4=Belt of Ten Storms",    "=q1=#m1# =ds=#c7#", "6.93%" },
        { 16960, "INV_Belt_09", "=q4=Waistband of Wrath",    "=q1=#m1# =ds=#c9#", "20.03%" },
        { 16952, "INV_Belt_27", "=q4=Judgement Belt",        "=q1=#m1# =ds=#c4#", "12.23%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19339, "Spell_Nature_WispHeal", "=q4=Mind Quickening Gem", "=ds=#s14#, =q1=#m1# =ds=#c3#", "18.96%" },
        { 19340, "INV_Misc_Rune_06", "=q4=Rune of Metamorphosis", "=ds=#s14#, =q1=#m1# =ds=#c1#", "17.66%" },
        { 0,"","","" },
        { 19372, "INV_Helmet_10", "=q4=Helm of Endless Rage",                   "=ds=#s1#, #a4#", "16.76%" },
        { 19371, "INV_Jewelry_Necklace_12", "=q4=Pendant of the Fallen Dragon", "=ds=#s2#", "18.56%" },
        { 19346, "INV_Weapon_Shortblade_29", "=q4=Dragonfang Blade",            "=ds=#h1#, #w4#", "9.40%" },
        { 19348, "INV_Shield_20", "=q4=Red Dragonscale Protector",              "=ds=#w8#", "8.57%" },
        };

    BWLLashlayer = {
        { 16912, "INV_Boots_07", "=q4=Netherwind Boots",              "=q1=#m1# =ds=#c3#", "17.17%" },
        { 16919, "INV_Boots_07", "=q4=Boots of Transcendence",        "=q1=#m1# =ds=#c5#", "14.61%" },
        { 16927, "INV_Boots_05", "=q4=Nemesis Boots",                 "=q1=#m1# =ds=#c8#", "15.32%" },
        { 16898, "INV_Boots_08", "=q4=Stormrage Boots",               "=q1=#m1# =ds=#c1#", "13.79%" },
        { 16906, "INV_Boots_08", "=q4=Bloodfang Boots",               "=q1=#m1# =ds=#c6#", "15.66%" },
        { 16941, "INV_Boots_Plate_07", "=q4=Dragonstalker's Greaves", "=q1=#m1# =ds=#c2#", "17.78%" },
        { 16949, "INV_Boots_Plate_06", "=q4=Greaves of Ten Storms",   "=q1=#m1# =ds=#c7#", "5.57%" },
        { 16965, "INV_Boots_Plate_04", "=q4=Sabatons of Wrath",       "=q1=#m1# =ds=#c9#", "16.84%" },
        { 16957, "INV_Boots_Plate_09", "=q4=Judgement Sabatons",      "=q1=#m1# =ds=#c4#", "11.28%" },
        { 0,"","","" },
        { 0,"","","" },
        { 20383, "Spell_Shadow_CurseOfTounges", "=q1=Head of the Broodlord Lashlayer", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19342, "INV_Misc_Idol_03", "=q4=Venomous Totem",         "=ds=#s14#, =q1=#m1# =ds=#c6#", "15.06%" },
        { 19341, "INV_Misc_Gem_Pearl_05", "=q4=Lifegiving Gem",    "=ds=#s14#, =q1=#m1# =ds=#c9#", "14.27%" },
        { 0,"","","" },
        { 19374, "INV_Bracer_07", "=q4=Bracers of Arcane Accuracy",               "=ds=#s8#, #a1#", "15.03%" },
        { 19373, "INV_Shoulder_14", "=q4=Black Brood Pauldrons",                  "=ds=#s3#, #a3#", "17.25%" },
        { 19351, "INV_Sword_49", "=q4=Maladath, Runed Blade of the Black Flight", "=ds=#h1#, #w10#", "9.62%" },
        { 19350, "INV_Weapon_Bow_09", "=q4=Heartstriker",                         "=ds=#w2#", "8.45%" },
        };

    BWLFiremaw = {
        { 16913, "INV_Gauntlets_14", "=q4=Netherwind Gloves",           "=q1=#m1# =ds=#c3#", "7.37%" },
        { 16920, "INV_Gauntlets_14", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "6.01%" },
        { 16928, "INV_Gauntlets_19", "=q4=Nemesis Gloves",              "=q1=#m1# =ds=#c8#", "5.28%" },
        { 16907, "INV_Gauntlets_21", "=q4=Bloodfang Gloves",            "=q1=#m1# =ds=#c6#", "6.84%" },
        { 16940, "INV_Gauntlets_10", "=q4=Dragonstalker's Gauntlets",   "=q1=#m1# =ds=#c2#", "6.13%" },
        { 16899, "INV_Gauntlets_25", "=q4=Stormrage Handguards",        "=q1=#m1# =ds=#c1#", "5.34%" },
        { 16948, "INV_Gauntlets_11", "=q4=Gauntlets of Ten Storms",     "=q1=#m1# =ds=#c7#", "2.13%" },
        { 16964, "INV_Gauntlets_10", "=q4=Gauntlets of Wrath",          "=q1=#m1# =ds=#c9#", "5.93%" },
        { 16956, "INV_Gauntlets_29", "=q4=Judgement Gauntlets",         "=q1=#m1# =ds=#c4#", "3.58%" },
        { 0,"","","" },
        { 19365, "INV_Weapon_ShortBlade_27", "=q4=Claw of the Black Drake",    "=ds=#h3#, #w13#", "15.97%" },
        { 19355, "INV_Staff_13", "=q4=Shadow Wing Focus Staff",                "=ds=#w9#", "3.70%" },
        { 19353, "INV_Axe_10", "=q4=Drake Talon Cleaver",                      "=ds=#h2#, #w1#", "3.18%" },
        { 0,"","","" },
        { 0,"","","" },
        { 19343, "INV_Scroll_08", "=q4=Scrolls of Blinding Light",   "=ds=#s14#, =q1=#m1# =ds=#c4#", "9.17%" },
        { 19344, "INV_Misc_Gem_03", "=q4=Natural Alignment Crystal", "=ds=#s14#, =q1=#m1# =ds=#c7#", "4.03%" },
        { 0,"","","" },
        { 19398, "INV_Misc_Cape_18", "=q4=Cloak of Firemaw",                   "=ds=#s4#", "15.39%" },
        { 19400, "INV_Belt_10", "=q4=Firemaw's Clutch",                        "=ds=#s10#, #a1#", "14.75%" },
        { 19399, "INV_Chest_Cloth_50", "=q4=Black Ash Robe",                   "=ds=#s5#, #a1#", "15.00%" },
        { 19396, "INV_Belt_16", "=q4=Taut Dragonhide Belt",                    "=ds=#s10#, #a2#", "5.44%" },
        { 19401, "INV_Pants_Mail_19", "=q4=Primalist's Linked Legguards",      "=ds=#s11#, #a3#", "5.37%" },
        { 19394, "INV_Shoulder_23", "=q4=Drake Talon Pauldrons",               "=ds=#s3#, #a4#", "6.76%" },
        { 19402, "INV_Pants_Plate_16", "=q4=Legguards of the Fallen Crusader", "=ds=#s11#, #a4#", "9.50%" },
        { 0,"","","" },
        { 19397, "INV_Jewelry_Ring_43", "=q4=Ring of Blackrock",               "=ds=#s13#", "5.98%" },
        { 19395, "INV_Misc_Gem_Topaz_02", "=q4=Rejuvenating Gem",              "=ds=#s14#", "5.30%" },
        };

    BWLDraconicForDummies = {
        { 21109, "INV_Misc_StoneTablet_03", "=q1=Draconic for Dummies", "=ds=#m3#" },
        };

    BWLEbonroc = {
        { 16913, "INV_Gauntlets_14", "=q4=Netherwind Gloves",           "=q1=#m1# =ds=#c3#", "6.44%" },
        { 16920, "INV_Gauntlets_14", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "6.59%" },
        { 16928, "INV_Gauntlets_19", "=q4=Nemesis Gloves",              "=q1=#m1# =ds=#c8#", "7.15%" },
        { 16907, "INV_Gauntlets_21", "=q4=Bloodfang Gloves",            "=q1=#m1# =ds=#c6#", "7.07%" },
        { 16940, "INV_Gauntlets_10", "=q4=Dragonstalker's Gauntlets",   "=q1=#m1# =ds=#c2#", "6.91%" },
        { 16899, "INV_Gauntlets_25", "=q4=Stormrage Handguards",        "=q1=#m1# =ds=#c1#", "6.32%" },
        { 16948, "INV_Gauntlets_11", "=q4=Gauntlets of Ten Storms",     "=q1=#m1# =ds=#c7#", "1.93%" },
        { 16964, "INV_Gauntlets_10", "=q4=Gauntlets of Wrath",          "=q1=#m1# =ds=#c9#", "6.19%" },
        { 16956, "INV_Gauntlets_29", "=q4=Judgement Gauntlets",         "=q1=#m1# =ds=#c4#", "4.45%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19345, "Spell_Holy_BlessingOfProtection", "=q4=Aegis of Preservation", "=ds=#s14#, =q1=#m1# =ds=#c5#", "16.47%" },
        { 0,"","","" },
        { 19407, "INV_Gauntlets_27", "=q4=Ebony Flame Gloves",              "=ds=#s9#, #a1#", "16.59%" },
        { 19405, "INV_Chest_Leather_08", "=q4=Malfurion's Blessed Bulwark", "=ds=#s5#, #a2#", "17.03%" },
        { 19396, "INV_Belt_16", "=q4=Taut Dragonhide Belt",                 "=ds=#s10#, #a2#", "5.99%" },
        { 19394, "INV_Shoulder_23", "=q4=Drake Talon Pauldrons",            "=ds=#s3#, #a4#", "5.68%" },
        { 0,"","","" },
        { 19403, "INV_Jewelry_Ring_34", "=q4=Band of Forced Concentration", "=ds=#s13#", "14.63%" },
        { 19397, "INV_Jewelry_Ring_43", "=q4=Ring of Blackrock",            "=ds=#s13#", "5.99%" },
        { 19406, "INV_Misc_Bone_06", "=q4=Drake Fang Talisman",             "=ds=#s14#", "17.41%" },
        { 19395, "INV_Misc_Gem_Topaz_02", "=q4=Rejuvenating Gem",           "=ds=#s14#", "5.62%" },
        { 0,"","","" },
        { 19353, "INV_Axe_10", "=q4=Drake Talon Cleaver",                   "=ds=#h2#, #w1#", "3.60%" },
        { 19355, "INV_Staff_13", "=q4=Shadow Wing Focus Staff",             "=ds=#w9#", "2.77%" },
        { 19368, "INV_Weapon_Rifle_02", "=q4=Dragonbreath Hand Cannon",     "=ds=#w5#", "8.58%" },
        };

    BWLFlamegor = {
        { 16913, "INV_Gauntlets_14", "=q4=Netherwind Gloves",           "=q1=#m1# =ds=#c3#", "6.91%" },
        { 16920, "INV_Gauntlets_14", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "6.47%" },
        { 16928, "INV_Gauntlets_19", "=q4=Nemesis Gloves",              "=q1=#m1# =ds=#c8#", "6.65%" },
        { 16907, "INV_Gauntlets_21", "=q4=Bloodfang Gloves",            "=q1=#m1# =ds=#c6#", "6.41%" },
        { 16940, "INV_Gauntlets_10", "=q4=Dragonstalker's Gauntlets",   "=q1=#m1# =ds=#c2#", "6.73%" },
        { 16899, "INV_Gauntlets_25", "=q4=Stormrage Handguards",        "=q1=#m1# =ds=#c1#", "5.66%" },
        { 16948, "INV_Gauntlets_11", "=q4=Gauntlets of Ten Storms",     "=q1=#m1# =ds=#c7#", "2.72%" },
        { 16964, "INV_Gauntlets_10", "=q4=Gauntlets of Wrath",          "=q1=#m1# =ds=#c9#", "6.63%" },
        { 16956, "INV_Gauntlets_29", "=q4=Judgement Gauntlets",         "=q1=#m1# =ds=#c4#", "3.64%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19430, "INV_Misc_Cape_16", "=q4=Shroud of Pure Thought",         "=ds=#s4#", "17.50%" },
        { 19396, "INV_Belt_16", "=q4=Taut Dragonhide Belt",                "=ds=#s10#, #a2#", "6.41%" },
        { 19433, "INV_Pants_Mail_17", "=q4=Emberweave Leggings",           "=ds=#s11#, #a3#", "18.73%" },
        { 19394, "INV_Shoulder_23", "=q4=Drake Talon Pauldrons",           "=ds=#s3#, #a4#", "5.95%" },
        { 0,"","","" },
        { 19397, "INV_Jewelry_Ring_43", "=q4=Ring of Blackrock",           "=ds=#s13#", "6.25%" },
        { 19432, "INV_Jewelry_Ring_37", "=q4=Circle of Applied Force",     "=ds=#s13#", "18.69%" },
        { 19395, "INV_Misc_Gem_Topaz_02", "=q4=Rejuvenating Gem",          "=ds=#s14#", "5.46%" },
        { 19431, "INV_Misc_ArmorKit_10", "=q4=Styleen's Impeding Scarab", "=ds=#s14#", "17.02%" },
        { 0,"","","" },
        { 19353, "INV_Axe_10", "=q4=Drake Talon Cleaver",                  "=ds=#h2#, #w1#", "3.79%" },
        { 19357, "INV_Mace_05", "=q4=Herald of Woe",                       "=ds=#h2#, #w6#", "9.07%" },
        { 19355, "INV_Staff_13", "=q4=Shadow Wing Focus Staff",            "=ds=#w9#", "2.66%" },
        { 19367, "INV_Wand_11", "=q4=Dragon's Touch",                      "=ds=#w12#", "9.06%" },
        };

    BWLChromaggus = {
        { 16917, "INV_Shoulder_32", "=q4=Netherwind Mantle",          "=q1=#m1# =ds=#c3#", "18.09%" },
        { 16924, "INV_Shoulder_02", "=q4=Pauldrons of Transcendence", "=q1=#m1# =ds=#c5#", "17.83%" },
        { 16932, "INV_Shoulder_19", "=q4=Nemesis Spaulders",          "=q1=#m1# =ds=#c8#", "16.26%" },
        { 16937, "INV_Shoulder_10", "=q4=Dragonstalker's Spaulders",  "=q1=#m1# =ds=#c2#", "16.20%" },
        { 16902, "INV_Shoulder_07", "=q4=Stormrage Pauldrons",        "=q1=#m1# =ds=#c1#", "14.63%" },
        { 16832, "INV_Shoulder_23", "=q4=Bloodfang Spaulders",        "=q1=#m1# =ds=#c6#", "17.03%" },
        { 16945, "INV_Shoulder_33", "=q4=Epaulets of Ten Storms",     "=q1=#m1# =ds=#c7#", "6.73%" },
        { 16953, "INV_Shoulder_37", "=q4=Judgement Spaulders",        "=q1=#m1# =ds=#c4#", "10.97%" },
        { 16961, "INV_Shoulder_34", "=q4=Pauldrons of Wrath",         "=q1=#m1# =ds=#c9#", "16.83%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19386, "INV_Misc_Cape_01", "=q4=Elementium Threaded Cloak",   "=ds=#s4#", "18.93%" },
        { 19388, "INV_Belt_13", "=q4=Angelista's Grasp",                "=ds=#s10#, #a1#", "16.86%" },
        { 19385, "INV_Pants_Cloth_19", "=q4=Empowered Leggings",        "=ds=#s11#, #a1#", "16.27%" },
        { 19391, "INV_Boots_Cloth_01", "=q4=Shimmering Geta",           "=ds=#s12#, #a1#", "17.46%" },
        { 19389, "INV_Shoulder_08", "=q4=Taut Dragonhide Shoulderpads", "=ds=#s3#, #a2#", "16.89%" },
        { 19390, "INV_Gauntlets_19", "=q4=Taut Dragonhide Gloves",      "=ds=#s9#, #a2#", "18.84%" },
        { 19393, "INV_Belt_21", "=q4=Primalist's Linked Waistguard",    "=ds=#s10#, #a3#", "6.17%" },
        { 19392, "INV_Belt_11", "=q4=Girdle of the Fallen Crusader",    "=ds=#s10#, #a4#", "10.97%" },
        { 19387, "INV_Boots_Plate_04", "=q4=Chromatic Boots",           "=ds=#s12#, #a4#", "16.46%" },
        { 0,"","","" },
        { 19347, "INV_Weapon_Shortblade_28", "=q4=Claw of Chromaggus",  "=ds=#h3#, #w4#", "8.39%" },
        { 19352, "INV_Sword_51", "=q4=Chromatically Tempered Sword",    "=ds=#h1#, #w10#", "9.05%" },
        { 19349, "INV_Shield_17", "=q4=Elementium Reinforced Bulwark",  "=ds=#w8#", "8.04%" },
        { 19361, "INV_Weapon_Crossbow_09", "=q4=Ashjre'thul, Crossbow of Smiting", "=ds=#w3#", "7.51%" },
        };

    BWLNefarian = {
        { 16916, "INV_Chest_Cloth_03", "=q4=Netherwind Robes",            "=q1=#m1# =ds=#c3#", "14.03%" },
        { 16931, "INV_Chest_Leather_01", "=q4=Nemesis Robes",             "=q1=#m1# =ds=#c8#", "12.46%" },
        { 16923, "INV_Chest_Cloth_03", "=q4=Robes of Transcendence",      "=q1=#m1# =ds=#c5#", "14.83%" },
        { 16905, "INV_Chest_Cloth_07", "=q4=Bloodfang Chestpiece",        "=q1=#m1# =ds=#c6#", "14.21%" },
        { 16897, "INV_Chest_Chain_16", "=q4=Stormrage Chestguard",        "=q1=#m1# =ds=#c1#", "11.89%" },
        { 16942, "INV_Chest_Chain_03", "=q4=Dragonstalker's Breastplate", "=q1=#m1# =ds=#c2#", "13.30%" },
        { 16950, "INV_Chest_Chain_11", "=q4=Breastplate of Ten Storms",   "=q1=#m1# =ds=#c7#", "5.65%" },
        { 16966, "INV_Chest_Plate16", "=q4=Breastplate of Wrath",         "=q1=#m1# =ds=#c9#", "15.06%" },
        { 16958, "INV_Chest_Plate03", "=q4=Judgement Breastplate",        "=q1=#m1# =ds=#c4#", "9.24%" },
        { 0,"","","" },
        { 19003, "INV_Misc_Head_Dragon_Black", "=q4=Head of Nefarian", "=ds=#m2#", "100%" },
        { 19383, "INV_Jewelry_Necklace_18", "=q4=Master Dragonslayer's Medallion", "=q1=#m4#: =ds=#s2#" },
        { 19384, "INV_Jewelry_Ring_41", "=q4=Master Dragonslayer's Ring", "=q1=#m4#: =ds=#s13#" },
        { 19366, "INV_Misc_Orb_03", "=q4=Master Dragonslayer's Orb", "=q1=#m4#: =ds=#s15#" },
        { 0,"","","" },
        { 19378, "INV_Misc_Cape_20", "=q4=Cloak of the Brood Lord",              "=ds=#s4#", "14.95%" },
        { 19375, "INV_Helmet_52", "=q4=Mish'undare, Circlet of the Mind Flayer", "=ds=#s1#, #a1#", "14.80%" },
        { 19381, "INV_Boots_Cloth_05", "=q4=Boots of the Shadow Flame",          "=ds=#s12#, #a2#", "15.70%" },
        { 19380, "INV_Belt_18", "=q4=Therazane's Link",                          "=ds=#s10#, #a3#", "16.82%" },
        { 19377, "INV_Jewelry_Necklace_17", "=q4=Prestor's Talisman of Connivery", "=ds=#s2#", "14.33%" },
        { 19382, "INV_Jewelry_Ring_42", "=q4=Pure Elementium Band",              "=ds=#s13#", "15.15%" },
        { 19376, "INV_Jewelry_Ring_40", "=q4=Archimtiros' Ring of Reckoning",    "=ds=#s13#", "13.93%" },
        { 19379, "INV_Stone_15", "=q4=Neltharion's Tear",                        "=ds=#s14#", "14.26%" },
        { 0,"","","" },
        { 19364, "INV_Sword_50", "=q4=Ashkandi, Greatsword of the Brotherhood",  "=ds=#h2#, #w10#", "7.21%" },
        { 19363, "INV_Axe_12", "=q4=Crul'shorukh, Edge of Chaos",                "=ds=#h1#, #w1#", "7.00%" },
        { 19360, "INV_Mace_06", "=q4=Lok'amir il Romathis",                      "=ds=#h3#, #w6#", "6.98%" },
        { 19356, "INV_Staff_06", "=q4=Staff of the Shadow Flame",                "=ds=#w9#", "7.27%" },
        { 0,"","","" },
        { 21138, "INV_Misc_Gem_Ruby_03", "=q1=Red Scepter Shard", "=ds=#m3#", "100%" },
        };

    BWLTrashMobs = {
        { 19436, "INV_Misc_Cape_11", "=q4=Cloak of Draconic Might",         "=ds=#s4#", "2.53%" },
        { 19437, "INV_Boots_Cloth_03", "=q4=Boots of Pure Thought",         "=ds=#s12#, #a1#", "2.33%" },
        { 19438, "INV_Boots_Cloth_16", "=q4=Ringo's Blizzard Boots",        "=ds=#s12#, #a1#", "4.42%" },
        { 19439, "INV_Chest_Leather_03", "=q4=Interlaced Shadow Jerkin",    "=ds=#s5#, #a2#", "4.62%" },
        { 19434, "INV_Jewelry_Ring_24", "=q4=Band of Dark Dominion",        "=ds=#s13#", "1.57%" },
        { 19362, "INV_Axe_15", "=q4=Doom's Edge",                           "=ds=#h1#, #w1#", "1.67%" },
        { 19354, "INV_Axe_21", "=q4=Draconic Avenger",                      "=ds=#h2#, #w1#", "5.96%" },
        { 19358, "INV_Mace_05", "=q4=Draconic Maul",                        "=ds=#h2#, #w6#", "2.30%" },
        { 19435, "INV_Wand_06", "=q4=Essence Gatherer",                     "=ds=#w12#", "1.61%" },
        { 0,"","","" },
        { 18562, "INV_Stone_SharpeningStone_01", "=q4=Elementium Ore", "=ds=#e8#", "4.75%" },
        };

        -------------------
        --- Molten Core ---
        -------------------

    MCLucifron = {
        { 16800, "INV_Boots_07", "=q4=Arcanist Boots",         "=q1=#m1# =ds=#c3# (T1)", "12.06%" },
        { 16805, "INV_Gauntlets_19", "=q4=Felheart Gloves",    "=q1=#m1# =ds=#c8# (T1)", "14.89%" },
        { 16829, "INV_Boots_08", "=q4=Cenarion Boots",         "=q1=#m1# =ds=#c1# (T1)", "10.72%" },
        { 16837, "INV_Boots_Plate_06", "=q4=Earthfury Boots",  "=q1=#m1# =ds=#c7# (T1)", "4.16%" },
        { 16863, "INV_Gauntlets_10", "=q4=Gauntlets of Might", "=q1=#m1# =ds=#c9# (T1)", "16.40%" },
        { 16859, "INV_Boots_Plate_09", "=q4=Lawbringer Boots", "=q1=#m1# =ds=#c4# (T1)", " 7.20%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17329, "INV_Gauntlets_26","=q1=Hand of Lucifron",          "=ds=#m3#" },
        { 18872, "INV_Pants_08", "=q4=Manastorm Leggings",           "=ds=#s11#, #a1#", "1.93%" },
        { 19145, "INV_Chest_Cloth_18", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "1.84%" },
        { 19146, "INV_Bracer_04", "=q4=Wristguards of Stability",    "=ds=#s8#, #a2#", "1.95%" },
        { 18875, "INV_Pants_12", "=q4=Salamander Scale Pants",       "=ds=#s11#, #a2#", "2.00%" },
        { 18870, "INV_Helmet_18", "=q4=Helm of the Lifegiver",       "=ds=#s1#, #a3#", "1.09%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",         "=ds=#s11#, #a4#", "2.15%" },
        { 17109, "INV_Jewelry_Necklace_10", "=q4=Choker of Enlightenment", "=ds=#s2#", "12.61%" },
        { 18879, "INV_Jewelry_Ring_14", "=q4=Heavy Dark Iron Ring",  "=ds=#s13#", "2.04%" },        
        { 19147, "INV_Jewelry_Ring_38", "=q4=Ring of Spell Power",   "=ds=#s13#", "2.23%" },
        { 18878, "INV_Weapon_ShortBlade_07", "=q4=Sorcerous Dagger", "=ds=#h3#, #w4#", "2.23%" },
        { 17077, "INV_Staff_13", "=q4=Crimson Shocker",              "=ds=#w12#", "1.60%" },        
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16665, "INV_Misc_Book_11", "=q2=Tome of Tranquilizing Shot", "=ds=#e10#, =q1=#m1# =ds=#c2#", "100%" },
        };

    MCMagmadar = {
        { 16796, "INV_Pants_08", "=q4=Arcanist Leggings",    "=q1=#m1# =ds=#c3# (T1)", "14.57%" },
        { 16814, "INV_Pants_08", "=q4=Pants of Prophecy",    "=q1=#m1# =ds=#c5# (T1)", "14.33%" },
        { 16810, "INV_Pants_Cloth_14", "=q4=Felheart Pants", "=q1=#m1# =ds=#c8# (T1)", "13.75%" },
        { 16822, "INV_Pants_06", "=q4=Nightslayer Pants",    "=q1=#m1# =ds=#c6# (T1)", "13.83%" },
        { 16847, "INV_Pants_Mail_03", "=q4=Giantstalker's Leggings", "=q1=#m1# =ds=#c2# (T1)", "13.28%" },
        { 16835, "INV_Pants_06", "=q4=Cenarion Leggings",    "=q1=#m1# =ds=#c1# (T1)", "12.90%" },
        { 16843, "INV_Pants_03", "=q4=Earthfury Legguards",  "=q1=#m1# =ds=#c7# (T1)", " 4.73%" },
        { 16855, "INV_Pants_04", "=q4=Lawbringer Legplates", "=q1=#m1# =ds=#c4# (T1)", " 8.54%" },
        { 16867, "INV_Pants_04", "=q4=Legplates of Might",   "=q1=#m1# =ds=#c9# (T1)", "13.97%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19136, "INV_Belt_11", "=q4=Mana Igniting Cord",                 "=ds=#s10#, #a1#", "4.79%" },
        { 18823, "INV_Gauntlets_23", "=q4=Aged Core Leather Gloves",      "=ds=#s9#, #a2#", "6.18%" },
        { 18829, "INV_Shoulder_04", "=q4=Deep Earth Spaulders",           "=ds=#s3#, #a3#", "2.10%" },
        { 19144, "INV_Boots_Chain_05", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "1.86%" },
        { 19143, "INV_Gauntlets_26", "=q4=Flameguard Gauntlets",          "=ds=#s9#, #a4#", "5.48%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",              "=ds=#s11#, #a4#", "3.98%" },
        { 18824, "INV_Boots_Plate_08", "=q4=Magma Tempered Boots",        "=ds=#s12#, #a4#", "3.22%" },
        { 17065, "INV_Jewelry_Amulet_03", "=q4=Medallion of Steadfast Might", "=ds=#s2#", "14.05%" },
        { 18821, "INV_Jewelry_Ring_07", "=q4=Quick Strike Ring",          "=ds=#s13#", "5.79%" },
        { 18820, "INV_Misc_StoneTablet_11", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "5.55%" },
        { 19142, "INV_Misc_Book_09", "=q4=Fire Runed Grimoire",               "=ds=#s15#", "5.42%" },
        { 18203, "INV_Misc_MonsterClaw_04", "=q4=Eskhandar's Right Claw", "=ds=#h3#, #w13#", "17.82%" },
        { 18822, "INV_Sword_28", "=q4=Obsidian Edged Blade",              "=ds=#h2#, #w10#", "5.68%" },
        { 17073, "INV_Hammer_04", "=q4=Earthshaker",                      "=ds=#h2#, #w6#", "16.75%" },
        { 17069, "INV_Weapon_Bow_08", "=q4=Striker's Mark",               "=ds=#w2#", "16.37%" },
        };

    MCGehennas = {
        { 16812, "INV_Gauntlets_14", "=q4=Gloves of Prophecy",     "=q1=#m1# =ds=#c5# (T1)", "18.65%" },
        { 16826, "INV_Gauntlets_21", "=q4=Nightslayer Gloves",     "=q1=#m1# =ds=#c6# (T1)", "19.47%" },
        { 16849, "INV_Boots_Chain_13", "=q4=Giantstalker's Boots", "=q1=#m1# =ds=#c2# (T1)", "14.54%" },
        { 16839, "INV_Gauntlets_11", "=q4=Earthfury Gauntlets",    "=q1=#m1# =ds=#c7# (T1)", "7.38%" },
        { 16862, "INV_Boots_Plate_04", "=q4=Sabatons of Might",    "=q1=#m1# =ds=#c9# (T1)", "14.48%" },
        { 16860, "INV_Gauntlets_29", "=q4=Lawbringer Gauntlets",   "=q1=#m1# =ds=#c4# (T1)", "11.77%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17331, "Spell_Fire_Immolation","=q1=Hand of Gehennas",     "=ds=#m3#" },
        { 19145, "INV_Chest_Cloth_18", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "3.83%" },
        { 18872, "INV_Pants_08", "=q4=Manastorm Leggings",           "=ds=#s11#, #a1#", "3.37%" },
        { 19146, "INV_Bracer_04", "=q4=Wristguards of Stability",    "=ds=#s8#, #a2#", "3.53%" },
        { 18875, "INV_Pants_12", "=q4=Salamander Scale Pants",       "=ds=#s11#, #a2#", "3.57%" },
        { 18870, "INV_Helmet_18", "=q4=Helm of the Lifegiver",       "=ds=#s1#, #a3#", "1.77%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",         "=ds=#s11#, #a4#", "3.48%" },
        { 18879, "INV_Jewelry_Ring_14", "=q4=Heavy Dark Iron Ring",  "=ds=#s13#", "3.78%" },
        { 19147, "INV_Jewelry_Ring_38", "=q4=Ring of Spell Power",   "=ds=#s13#", "3.78%" },
        { 18878, "INV_Weapon_ShortBlade_07", "=q4=Sorcerous Dagger", "=ds=#h3#, #w4#", "3.79%" },
        { 17077, "INV_Staff_13", "=q4=Crimson Shocker",              "=ds=#w12#", "3.34%" },
        };

    MCGarr = {
        { 16795, "INV_Helmet_53", "=q4=Arcanist Crown", "=q1=#m1# =ds=#c3# (T1)", "11.31%" },
        { 16813, "INV_Helmet_34", "=q4=Circlet of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "11.36%" },
        { 16808, "INV_Helmet_08", "=q4=Felheart Horns", "=q1=#m1# =ds=#c8# (T1)", "10.62%" },
        { 16846, "INV_Helmet_05", "=q4=Giantstalker's Helmet", "=q1=#m1# =ds=#c2# (T1)", "11.57%" },
        { 16834, "INV_Helmet_09", "=q4=Cenarion Helm", "=q1=#m1# =ds=#c1# (T1)", "11.51%" },
        { 16821, "INV_Helmet_41", "=q4=Nightslayer Cover", "=q1=#m1# =ds=#c6# (T1)", "10.38%" },
        { 16842, "INV_Helmet_09", "=q4=Earthfury Helmet", "=q1=#m1# =ds=#c7# (T1)", "3.91%" },
        { 16866, "INV_Helmet_09", "=q4=Helm of Might", "=q1=#m1# =ds=#c9# (T1)", "11.39%" },
        { 16854, "INV_Helmet_05", "=q4=Lawbringer Helm", "=q1=#m1# =ds=#c4# (T1)", "7.23%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18564, "Spell_Ice_Lament", "=q5=Bindings of the Windseeker", "=ds=#m3#, =q1=#m9#", "3.74%" },
        { 19019, "INV_Sword_39", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#" },
        { 19136, "INV_Belt_11", "=q4=Mana Igniting Cord",                 "=ds=#s10#, #a1#", "4.80%" },
        { 18823, "INV_Gauntlets_23", "=q4=Aged Core Leather Gloves",      "=ds=#s9#, #a2#", "5.23%" },
        { 18829, "INV_Shoulder_04", "=q4=Deep Earth Spaulders",           "=ds=#s3#, #a3#", "1.68%" },
        { 19144, "INV_Boots_Chain_05", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "1.48%" },
        { 19143, "INV_Gauntlets_26", "=q4=Flameguard Gauntlets",          "=ds=#s9#, #a4#", "3.84%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",              "=ds=#s11#, #a4#", "2.82%" },
        { 18824, "INV_Boots_Plate_08", "=q4=Magma Tempered Boots",        "=ds=#s12#, #a4#", "3.05%" },
        { 18821, "INV_Jewelry_Ring_07", "=q4=Quick Strike Ring",          "=ds=#s13#", "4.48%" },
        { 18820, "INV_Misc_StoneTablet_11", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "4.13%" },
        { 19142, "INV_Misc_Book_09", "=q4=Fire Runed Grimoire",           "=ds=#s15#", "3.69%" },
        { 17071, "INV_Weapon_ShortBlade_18", "=q4=Gutgore Ripper",        "=ds=#h1#, #w4#", "11.21%" },
        { 18832, "INV_Sword_15", "=q4=Brutality Blade",                   "=ds=#h1#, #w10#", "13.27%" },
        { 18822, "INV_Sword_28", "=q4=Obsidian Edged Blade",              "=ds=#h2#, #w10#", "4.09%" },
        { 17105, "INV_Hammer_05", "=q4=Aurastone Hammer",                 "=ds=#h3#, #w6#", "12.67%" },
        { 17066, "INV_Shield_10", "=q4=Drillborer Disk",                  "=ds=#w8#", "11.85%" },
        };

    MCShazzrah = {
        { 16801, "INV_Gauntlets_14", "=q4=Arcanist Gloves", "=q1=#m1# =ds=#c3# (T1)", "19.59%" },
        { 16803, "INV_Boots_Cloth_05", "=q4=Felheart Slippers", "=q1=#m1# =ds=#c8# (T1)", "15.28%" },
        { 16811, "INV_Gauntlets_07", "=q4=Boots of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "14.90%" },
        { 16831, "INV_Gauntlets_07", "=q4=Cenarion Gloves", "=q1=#m1# =ds=#c1# (T1)", "19.53%" },
        { 16852, "INV_Gauntlets_10", "=q4=Giantstalker's Gloves", "=q1=#m1# =ds=#c2# (T1)", "18.58%" },
        { 16824, "INV_Gauntlets_08", "=q4=Nightslayer Boots", "=q1=#m1# =ds=#c6# (T1)", "15.58%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17332, "INV_Gauntlets_19","=q1=Hand of Shazzrah",          "=ds=#m3#" },
        { 19145, "INV_Chest_Cloth_18", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "1.97%" },
        { 18872, "INV_Pants_08", "=q4=Manastorm Leggings",           "=ds=#s11#, #a1#", "1.84%" },
        { 19146, "INV_Bracer_04", "=q4=Wristguards of Stability",    "=ds=#s8#, #a2#", "1.85%" },
        { 18875, "INV_Pants_12", "=q4=Salamander Scale Pants",       "=ds=#s11#, #a2#", "1.81%" },
        { 18870, "INV_Helmet_18", "=q4=Helm of the Lifegiver",       "=ds=#s1#, #a3#", "0.78%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",         "=ds=#s11#, #a4#", "2.22%" },
        { 18879, "INV_Jewelry_Ring_14", "=q4=Heavy Dark Iron Ring",  "=ds=#s13#", "1.72%" },
        { 19147, "INV_Jewelry_Ring_38", "=q4=Ring of Spell Power",   "=ds=#s13#", "1.99%" },
        { 18878, "INV_Weapon_ShortBlade_07", "=q4=Sorcerous Dagger", "=ds=#h3#, #w4#", "2.27%" },
        { 17077, "INV_Staff_13", "=q4=Crimson Shocker",              "=ds=#w12#", "3.32%" },
        };

    MCGeddon = {
        { 16797, "INV_Shoulder_02", "=q4=Arcanist Mantle", "=q1=#m1# =ds=#c3# (T1)", "19.92%" },
        { 16807, "INV_Shoulder_23", "=q4=Felheart Shoulder Pads", "=q1=#m1# =ds=#c8# (T1)", "19.78%" },
        { 16836, "INV_Shoulder_07", "=q4=Cenarion Spaulders", "=q1=#m1# =ds=#c1# (T1)", "19.52%" },
        { 16856, "INV_Shoulder_20", "=q4=Lawbringer Spaulders", "=q1=#m1# =ds=#c4# (T1)", "12.62%" },
        { 16844, "INV_Shoulder_29", "=q4=Earthfury Epaulets", "=q1=#m1# =ds=#c7# (T1)", "7.29%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18563, "Spell_Ice_Lament", "=q5=Bindings of the Windseeker", " =ds=#m3#, =q1=#m10#", "3.78%" },
        { 19019, "INV_Sword_39", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#" },
        { 19136, "INV_Belt_11", "=q4=Mana Igniting Cord",                 "=ds=#s10#, #a1#", "2.44%" },
        { 18823, "INV_Gauntlets_23", "=q4=Aged Core Leather Gloves",      "=ds=#s9#, #a2#", "3.04%" },
        { 18829, "INV_Shoulder_04", "=q4=Deep Earth Spaulders",           "=ds=#s3#, #a3#", "1.04%" },
        { 19144, "INV_Boots_Chain_05", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "1.00%" },
        { 19143, "INV_Gauntlets_26", "=q4=Flameguard Gauntlets",          "=ds=#s9#, #a4#", "2.61%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",              "=ds=#s11#, #a4#", "1.77%" },
        { 18824, "INV_Boots_Plate_08", "=q4=Magma Tempered Boots",        "=ds=#s12#, #a4#", "1.48%" },
        { 17110, "INV_Jewelry_Ring_21", "=q4=Seal of the Archmagus",      "=ds=#s13#", "21.93%" },
        { 18821, "INV_Jewelry_Ring_07", "=q4=Quick Strike Ring",          "=ds=#s13#", "2.61%" },
        { 18820, "INV_Misc_StoneTablet_11", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "2.68%" },
        { 19142, "INV_Misc_Book_09", "=q4=Fire Runed Grimoire",           "=ds=#s15#", "2.59%" },
        { 18822, "INV_Sword_28", "=q4=Obsidian Edged Blade",              "=ds=#h2#, #w10#", "2.70%" },
        };

    MCGolemagg = {
        { 16798, "INV_Chest_Cloth_03", "=q4=Arcanist Robes", "=q1=#m1# =ds=#c3# (T1)", "16.51%" },
        { 16815, "INV_Chest_Cloth_03", "=q4=Robes of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "15.65%" },
        { 16809, "INV_Chest_Cloth_09", "=q4=Felheart Robes", "=q1=#m1# =ds=#c8# (T1)", "15.66%" },
        { 16820, "INV_Chest_Cloth_07", "=q4=Nightslayer Chestpiece", "=q1=#m1# =ds=#c6# (T1)", "16.76%" },
        { 16833, "INV_Chest_Cloth_06", "=q4=Cenarion Vestments", "=q1=#m1# =ds=#c1# (T1)", "15.21%" },
        { 16845, "INV_Chest_Chain_03", "=q4=Giantstalker's Breastplate", "=q1=#m1# =ds=#c2# (T1)", "15.83%" },
        { 16841, "INV_Chest_Chain_11", "=q4=Earthfury Vestments", "=q1=#m1# =ds=#c7# (T1)", " 6.08%" },
        { 16865, "INV_Chest_Plate16",  "=q4=Breastplate of Might", "=q1=#m1# =ds=#c9# (T1)", "15.28%" },
        { 16853, "INV_Chest_Plate03",  "=q4=Lawbringer Chestguard", "=q1=#m1# =ds=#c4# (T1)", "9.53%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17203, "Spell_Fire_SealOfFire", "=q4=Sulfuron Ingot",      "=ds=#m3#", "11.98%" },
        { 17182, "INV_Hammer_Unique_Sulfuras", "=q5=Sulfuras, Hand of Ragnaros", "=q1=#m4#: =ds=#h2#, #w6#" },
        { 19136, "INV_Belt_11", "=q4=Mana Igniting Cord",                 "=ds=#s10#, #a1#", "2.18%" },
        { 18823, "INV_Gauntlets_23", "=q4=Aged Core Leather Gloves",      "=ds=#s9#, #a2#", "2.65%" },
        { 18829, "INV_Shoulder_04", "=q4=Deep Earth Spaulders",           "=ds=#s3#, #a3#", "1.20%" },
        { 19144, "INV_Boots_Chain_05", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "1.00%" },
        { 19143, "INV_Gauntlets_26", "=q4=Flameguard Gauntlets",          "=ds=#s9#, #a4#", "2.17%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",              "=ds=#s11#, #a4#", "1.44%" },
        { 18824, "INV_Boots_Plate_08", "=q4=Magma Tempered Boots",        "=ds=#s12#, #a4#", "1.69%" },
        { 18821, "INV_Jewelry_Ring_07", "=q4=Quick Strike Ring",          "=ds=#s13#", "2.26%" },
        { 18820, "INV_Misc_StoneTablet_11", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "2.91%" },
        { 19142, "INV_Misc_Book_09", "=q4=Fire Runed Grimoire",           "=ds=#s15#", "2.46%" },
        { 17103, "INV_Sword_39", "=q4=Azuresong Mageblade",               "=ds=#h3#, #w10#", "17.59%" },
        { 18822, "INV_Sword_28", "=q4=Obsidian Edged Blade",              "=ds=#h2#, #w10#", "2.89%" },
        { 18842, "INV_Staff_13", "=q4=Staff of Dominance",                "=ds=#w9#", "18.95%" },
        { 17072, "INV_Weapon_Rifle_09", "=q4=Blastershot Launcher",       "=ds=#w5#", "17.83%" },
        };

    MCSulfuron = {
        { 16816, "INV_Shoulder_02", "=q4=Mantle of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "21.06%" },
        { 16823, "INV_Shoulder_25", "=q4=Nightslayer Shoulder Pads", "=q1=#m1# =ds=#c6# (T1)", "20.66%" },
        { 16848, "INV_Shoulder_10", "=q4=Giantstalker's Epaulets", "=q1=#m1# =ds=#c2# (T1)", "19.64%" },
        { 16868, "INV_Shoulder_15", "=q4=Pauldrons of Might", "=q1=#m1# =ds=#c9# (T1)", "21.14%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17330, "INV_Gauntlets_03","=q1=Hand of Sulfuron",          "=ds=#m3#" },
        { 19145, "INV_Chest_Cloth_18", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "2.80%" },
        { 18872, "INV_Pants_08", "=q4=Manastorm Leggings",           "=ds=#s11#, #a1#", "2.54%" },
        { 19146, "INV_Bracer_04", "=q4=Wristguards of Stability",    "=ds=#s8#, #a2#", "2.70%" },
        { 18875, "INV_Pants_12", "=q4=Salamander Scale Pants",       "=ds=#s11#, #a2#", "2.58%" },
        { 18870, "INV_Helmet_18", "=q4=Helm of the Lifegiver",       "=ds=#s1#, #a3#", "1.26%" },
        { 18861, "INV_Pants_04", "=q4=Flamewaker Legplates",         "=ds=#s11#, #a4#", "2.54%" },
        { 18879, "INV_Jewelry_Ring_14", "=q4=Heavy Dark Iron Ring",  "=ds=#s13#", "2.32%" },
        { 19147, "INV_Jewelry_Ring_38", "=q4=Ring of Spell Power",   "=ds=#s13#", "2.39%" },
        { 18878, "INV_Weapon_ShortBlade_07", "=q4=Sorcerous Dagger", "=ds=#h3#, #w4#", "2.53%" },
        { 17074, "INV_Spear_08", "=q4=Shadowstrike",                 "=ds=#w7#", "23.50%" },
        { 17077, "INV_Staff_13", "=q4=Crimson Shocker",              "=ds=#w12#", "2.26%" },
        };

    MCMajordomo = {
        { 18811, "INV_Misc_Cape_18", "=q4=Fireproof Cloak",              "=ds=#s4#", "15.12%" },
        { 18808, "INV_Gauntlets_03", "=q4=Gloves of the Hypnotic Flame", "=ds=#s9#, #a1#", "15.36%" },
        { 18809, "INV_Belt_12", "=q4=Sash of Whispered Secrets",         "=ds=#s10#, #a1#", "15.93%" },
        { 19139, "INV_Shoulder_23", "=q4=Fireguard Shoulders",           "=ds=#s3#, #a2#", "15.87%" },
        { 18810, "INV_Shoulder_18", "=q4=Wild Growth Spaulders",         "=ds=#s3#, #a2#", "16.91%" },
        { 18812, "INV_Bracer_02", "=q4=Wristguards of True Flight",      "=ds=#s8#, #a3#", "18.04%" },
        { 18806, "INV_Boots_Plate_09", "=q4=Core Forged Greaves",        "=ds=#s12#, #a4#", "16.53%" },
        { 19140, "INV_Jewelry_Ring_39", "=q4=Cauterizing Band",          "=ds=#s13#", "15.10%" },
        { 18805, "INV_Weapon_ShortBlade_11", "=q4=Core Hound Tooth",     "=ds=#h1#, #w4#", "16.06%" },
        { 18803, "INV_Gizmo_02", "=q4=Finkle's Lava Dredger",            "=ds=#h2#, #w6#", "12.43%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18703, "Spell_Nature_ResistNature", "=q4=Ancient Petrified Leaf", "=ds=#m2# =q1=(#c2#)", "35.25%" },
        { 18715, "INV_Staff_21", "=q4=Lok'delar, Stave of the Ancient Keepers", "=q1=#m4#: =ds=#w9#, =q1=#m1# =ds=#c2#" },
        { 18713, "INV_Weapon_Bow_01", "=q4=Rhok'delar, Longbow of the Ancient Keepers", "=q1=#m4#: =ds=#w2#, =q1=#m1# =ds=#c2#" },
        { 18714, "INV_Misc_Quiver_03", "=q4=Ancient Sinew Wrapped Lamina", "=q1=#m4#: =ds=#w19#, =q1=#m1# =ds=#c2#" },
        { 0,"","","" },
        { 18646, "Spell_Holy_MindSooth", "=q4=The Eye of Divinity", "=ds=#m2# =q1=(#c5#)", "28.30%" },
        { 18608, "INV_Staff_30", "=q4=Benediction", "=q1=#m4#: =ds=#w9#, =q1=#m1# =ds=#c5#" },
        { 18609, "INV_Staff_12", "=q4=Anathema", "=q1=#m4#: =ds=#w9#, =q1=#m1# =ds=#c5#" },
        };

    MCRagnaros = {
        { 16915, "INV_Pants_08", "=q4=Netherwind Pants", "=q1=#m1# =ds=#c3# (T2)", "17.37%" },
        { 16922, "INV_Pants_08", "=q4=Leggings of Transcendence", "=q1=#m1# =ds=#c5# (T2)", "17.30%" },
        { 16930, "INV_Pants_07", "=q4=Nemesis Leggings", "=q1=#m1# =ds=#c8# (T2)", "16.87%" },
        { 16909, "INV_Pants_06", "=q4=Bloodfang Pants", "=q1=#m1# =ds=#c6# (T2)", "17.18%" },
        { 16901, "INV_Pants_06", "=q4=Stormrage Legguards", "=q1=#m1# =ds=#c1# (T2)", "15.49%" },
        { 16938, "INV_Pants_03", "=q4=Dragonstalker's Legguards", "=q1=#m1# =ds=#c2# (T2)", "16.02%" },
        { 16946, "INV_Pants_03", "=q4=Legplates of Ten Storms", "=q1=#m1# =ds=#c7# (T2)", "5.97%" },
        { 16962, "INV_Pants_04", "=q4=Legplates of Wrath", "=q1=#m1# =ds=#c9# (T2)", "17.23%" },
        { 16954, "INV_Pants_04", "=q4=Judgement Legplates", "=q1=#m1# =ds=#c4# (T2)", "10.81%" },
        { 0,"","","" },
        { 17204, "INV_Misc_Gem_Pearl_05", "=q5=Eye of Sulfuras", "=ds=#m3#", "3.42%" },
        { 17182, "INV_Hammer_Unique_Sulfuras", "=q5=Sulfuras, Hand of Ragnaros", "=q1=#m4#: =ds=#h2#, #w6#" },
        { 0,"","","" },
        { 19017, "Spell_Fire_SelfDestruct", "=q1=Essence of the Firelord", "=ds=#m3#", "0.46%" },
        { 19019, "INV_Sword_39", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#" },
        { 17102, "INV_Misc_Cape_17", "=q4=Cloak of the Shrouded Mists", "=ds=#s4#", "14.31%" },
        { 17107, "INV_Misc_Cape_08", "=q4=Dragon's Blood Cape", "=ds=#s4#", "15.32%" },
        { 18817, "INV_Crown_02", "=q4=Crown of Destruction", "=ds=#s1#, #a3#", "16.75%" },
        { 19137, "INV_Belt_29", "=q4=Onslaught Girdle", "=ds=#s10#, #a4#", "13.18%" },
        { 18814, "INV_Jewelry_Amulet_05", "=q4=Choker of the Fire Lord", "=ds=#s2#", "16.08%" },
        { 19138, "INV_Jewelry_Ring_36", "=q4=Band of Sulfuras", "=ds=#s13#", "15.64%" },
        { 17063, "INV_Jewelry_Ring_15", "=q4=Band of Accuria", "=ds=#s13#", "14.81%" },
        { 17082, "INV_Misc_Orb_05", "=q4=Shard of the Flame", "=ds=#s14#", " 4.65%" },
        { 18815, "Spell_Fire_Fire", "=q4=Essence of the Pure Flame", "=ds=#s14#", "17.80%" },
        { 18816, "INV_Sword_48", "=q4=Perdition's Blade", "=ds=#h1#, #w4#", "15.90%" },
        { 17076, "INV_Sword_12", "=q4=Bonereaver's Edge", "=ds=#h2#, #w10#", "5.12%" },
        { 17104, "INV_Axe_09", "=q4=Spinal Reaper", "=ds=#h2#, #w1#", " 4.63%" },
        { 17106, "INV_Shield_08", "=q4=Malistar's Defender", "=ds=#w8#", "13.88%" },
        { 0,"","","" },
        { 21110, "INV_Misc_StoneTablet_03", "=q1=Draconic for Dummies", "=ds=#m3#", "100%" },
        };

    MCTrashMobs = {
        { 16802, "INV_Belt_30", "=q4=Arcanist Belt", "=q1=#m1# =ds=#c3# (T1)", "0.16%"  },
        { 16817, "INV_Belt_22", "=q4=Girdle of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "0.18%" },
        { 16806, "INV_Belt_13", "=q4=Felheart Belt", "=q1=#m1# =ds=#c8# (T1)", "0.19%" },
        { 16827, "INV_Belt_23", "=q4=Nightslayer Belt", "=q1=#m1# =ds=#c6# (T1)", "0.15%" },
        { 16828, "INV_Belt_06", "=q4=Cenarion Belt", "=q1=#m1# =ds=#c1# (T1)", "0.16%" },
        { 16851, "INV_Belt_28", "=q4=Giantstalker's Belt", "=q1=#m1# =ds=#c2# (T1)", "0.17%" },
        { 16838, "INV_Belt_14", "=q4=Earthfury Belt", "=q1=#m1# =ds=#c7# (T1)", "0.07%" },
        { 16864, "INV_Belt_09", "=q4=Belt of Might", "=q1=#m1# =ds=#c9# (T1)", "0.16%" },
        { 16858, "INV_Belt_27", "=q4=Lawbringer Belt", "=q1=#m1# =ds=#c4# (T1)", "0.10%" },
        { 0,"","","" },
        { 17010, "Spell_Fire_FlameBolt", "=q3=Fiery Core", "=ds=#e8#" },
        { 17011, "Spell_Nature_Earthquake", "=q3=Lava Core", "=ds=#e8#" },
        { 11382, "INV_Misc_Gem_Bloodstone_03", "=q2=Blood of the Mountain", "=ds=#e8#" },
        { 17012, "INV_Ammo_FireTar", "=q1=Core Leather", "=ds=#e8#" },
        { 0,"","","" },
        { 16799, "INV_Belt_29", "=q4=Arcanist Bindings", "=q1=#m1# =ds=#c3# (T1)", "0.16%" },
        { 16819, "INV_Pants_08", "=q4=Vambraces of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "0.16%" },
        { 16804, "INV_Bracer_07", "=q4=Felheart Bracers", "=q1=#m1# =ds=#c8# (T1)", "0.16%" },
        { 16825, "INV_Bracer_02", "=q4=Nightslayer Bracelets", "=q1=#m1# =ds=#c6# (T1)", "0.17%" },
        { 16830, "INV_Bracer_03", "=q4=Cenarion Bracers", "=q1=#m1# =ds=#c1# (T1)", "0.17%" },
        { 16850, "INV_Bracer_17", "=q4=Giantstalker's Bracers", "=q1=#m1# =ds=#c2# (T1)", "0.18%" },
        { 16840, "INV_Pants_03", "=q4=Earthfury Bracers", "=q1=#m1# =ds=#c7# (T1)", "0.06%" },
        { 16861, "INV_Bracer_19", "=q4=Bracers of Might", "=q1=#m1# =ds=#c9# (T1)", "0.16%" },
        { 16857, "INV_Bracer_18", "=q4=Lawbringer Bracers", "=q1=#m1# =ds=#c4# (T1)", "0.11%" },
        };

    MCRANDOMBOSSDROPPS = {
        { 18264, "INV_Scroll_05", "=q3=Plans: Elemental Sharpening Stone", "=ds=#p2# (300)", "1.02%" },
        { 18262, "INV_Stone_02", "=q2=Elemental Sharpening Stone",         "=ds=#e6#" },
        { 0,"","","" },
        { 18292, "INV_Scroll_05", "=q3=Schematic: Core Marksman Rifle", "=ds=#p5# (300)", "0.96%" },
        { 18282, "INV_Weapon_Rifle_05", "=q4=Core Marksman Rifle",      "=ds=#w5#" },
        { 0,"","","" },
        { 18291, "INV_Scroll_05", "=q3=Schematic: Force Reactive Disk",     "=ds=#p5# (300)", "0.92%" },
        { 18168, "Spell_Arcane_PortalDarnassus", "=q4=Force Reactive Disk", "=ds=#w8#" },
        { 0,"","","" },
        { 18290, "INV_Scroll_05", "=q3=Schematic: Biznicks 247x128 Accurascope", "=ds=#p5# (300)", "0.11%" },
        { 18283, "INV_Misc_Spyglass_02", "=q3=Biznicks 247x128 Accurascope", "=ds=#e11#" },
        { 0,"","","" },
        { 18259, "INV_Misc_Note_01", "=q3=Formula: Enchant Weapon - Spell Power", "=ds=#p4# (300)", "0.85%" },
        { 0,"","","" },
        { 0,"","","" },
        { 18252, "INV_Scroll_05", "=q3=Pattern: Core Armor Kit", "=ds=#p7# (300)", "0.85%" },
        { 18251, "INV_Misc_ArmorKit_05", "=q3=Core Armor Kit",   "=ds=#e6#" },
        { 0,"","","" },
        { 18265, "INV_Scroll_05", "=q3=Pattern: Flarecore Wraps", "=ds=#p8# (300)", "0.72%" },
        { 18263, "INV_Bracer_09", "=q4=Flarecore Wraps",          "=ds=#s8#, #a1#" },
        { 0,"","","" },
        { 21371, "INV_Scroll_05", "=q3=Pattern: Core Felcloth Bag",       "=ds=#p8# (300)", "0.33%" },
        { 21342, "INV_Misc_Bag_CoreFelclothBag", "=q4=Core Felcloth Bag", "=ds=#m11# #e1# =q1=#m1# #c8#" },
        { 0,"","","" },
        { 18257, "INV_Scroll_05", "=q3=Recipe: Major Rejuvenation Potion", "=ds=#p1# (300)", "0.76%" },
        { 18253, "INV_Potion_47", "=q1=Major Rejuvenation Potion",         "=ds=#e2#" },
        { 0,"","","" },
        { 18260, "INV_Misc_Note_01", "=q3=Formula: Enchant Weapon - Healing Power", "=ds=#p4# (300)", "0.75%" },
        };

        ---------------------
        --- Onyxia's Lair ---
        ---------------------

    Onyxia = {
        { 16914, "INV_Helmet_70", "=q4=Netherwind Crown",       "=q1=#m1# =ds=#c3# (T2)", "14.09%" },
        { 16921, "INV_Helmet_24", "=q4=Halo of Transcendence",  "=q1=#m1# =ds=#c5# (T2)", "13.39%" },
        { 16929, "INV_Helmet_08", "=q4=Nemesis Skullcap",       "=q1=#m1# =ds=#c8# (T2)", "13.54%" },
        { 16900, "INV_Helmet_09", "=q4=Stormrage Cover",        "=q1=#m1# =ds=#c1# (T2)", "13.08%" },
        { 16908, "INV_Helmet_41", "=q4=Bloodfang Hood",         "=q1=#m1# =ds=#c6# (T2)", "13.21%" },
        { 16939, "INV_Helmet_05", "=q4=Dragonstalker's Helm",   "=q1=#m1# =ds=#c2# (T2)", "13.91%" },
        { 16947, "INV_Helmet_69", "=q4=Helmet of Ten Storms",   "=q1=#m1# =ds=#c7# (T2)", "4.86%" },
        { 16963, "INV_Helmet_71", "=q4=Helm of Wrath",          "=q1=#m1# =ds=#c9# (T2)", "13.65%" },
        { 16955, "INV_Helmet_74", "=q4=Judgement Crown",        "=q1=#m1# =ds=#c4# (T2)", "8.64%" },
        { 0,"","","" },
        { 18705, "Spell_Holy_DispelMagic", "=q4=Mature Black Dragon Sinew", "=ds=#m3# =q1=#m1# =ds=#c2#", "24.53%" },
        { 18713, "INV_Weapon_Bow_01", "=q4=Rhok'delar, Longbow of the Ancient Keepers", "=q1=#m4#: =ds=#w2#, =q1=#m1# =ds=#c2#" },
        { 0,"","","" },
        { 15410, "INV_Misc_MonsterScales_07","=q3=Scale of Onyxia",      "=ds=#e8#" },
        { 0,"","","" },
        { 17078, "INV_Misc_Cape_16", "=q4=Sapphiron Drape",              "=ds=#s4#", "15.28%" },
        { 18205, "INV_Belt_12", "=q4=Eskhandar's Collar",                "=ds=#s2#", "14.88%" },
        { 18813, "INV_Jewelry_Ring_13", "=q4=Ring of Binding",           "=ds=#s13#", "16.28%" },
        { 17064, "INV_Misc_MonsterScales_15", "=q4=Shard of the Scale",  "=ds=#s14#", "4.08%" },
        { 17067, "INV_Misc_Book_07", "=q4=Ancient Cornerstone Grimoire", "=ds=#s15#", "16.07%" },
        { 17075, "INV_Sword_18", "=q4=Vis'kag the Bloodletter",          "=ds=#h1#, #w10#", "4.00%" },
        { 17068, "INV_Axe_09", "=q4=Deathbringer",                       "=ds=#h1#, #w1#", "4.31%" },
        { 0,"","","" },
        { 17966, "INV_Misc_Bag_22", "=q2=Onyxia Hide Backpack", "=ds=#m14# #e1#", "100%"},
        { 0,"","","" },
        { 18423, "INV_Misc_Head_Dragon_01", "=q4=Head of Onyxia",      "=ds=#m2#", "100%" },
        { 18404, "INV_Jewelry_Necklace_09", "=q4=Onyxia Tooth Pendant", "=q1=#m4#: =ds=#s2#" },
        { 18403, "INV_Jewelry_Ring_27", "=q4=Dragonslayer's Signet", "=q1=#m4#: =ds=#s13#" },
        { 18406, "Spell_Shadow_LifeDrain", "=q4=Onyxia Blood Talisman", "=q1=#m4#: =ds=#s14#" },
        };

        -----------------
        --- Zul'Gurub ---
        -----------------

    ZGJeklik = {
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",       "=ds=#m3#", "11.41%" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",       "=ds=#m3#", "11.02%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",       "=ds=#m3#", "10.84%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",       "=ds=#m3#", "5.89%" },
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",             "=ds=#m3#", "5.80%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",             "=ds=#m3#", "5.56%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis",       "=ds=#m3#", "2.33%" },
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",               "=ds=#m3#", "2.32%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",               "=ds=#m3#", "2.17%" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "8.8%" },
        { 19881, "INV_Misc_Head_Troll_02", "=q1=Channeler's Head", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19918, "INV_Mace_19", "=q4=Jeklik's Crusher", "=ds=#h2#, #w6#", "3.96%" },
        { 0,"","","" },
        { 19928, "INV_Shoulder_09", "=q3=Animist's Spaulders", "=ds=#s3#, #a2#", "3.39%" },
        { 20262, "INV_Boots_Chain_11", "=q3=Seafury Boots", "=ds=#s12#, #a3#", "4.31%" },
        { 20265, "INV_Boots_Plate_03", "=q3=Peacekeeper Boots", "=ds=#s12#, #a4#", "6.99%" },
        { 19923, "INV_Jewelry_Necklace_03", "=q3=Jeklik's Opaline Talisman", "=ds=#s2#", "12.22%" },
        { 19920, "INV_Jewelry_Ring_47", "=q3=Primalist's Band", "=ds=#s13#", "11.89%" },
        { 19915, "INV_Shield_22", "=q3=Zulian Defender", "=ds=#w8#", " 11.36%" },
        };

    ZGVenoxis = {
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",      "=ds=#m3#", "11.01%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",     "=ds=#m3#", "10.55%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",     "=ds=#m3#", "10.18%" },
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",            "=ds=#m3#", "5.93%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",       "=ds=#m3#", "5.67%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",          "=ds=#m3#", "5.52%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",        "=ds=#m3#", "2.18%" },
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",        "=ds=#m3#", "2.02%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis",    "=ds=#m3#", "2.00%" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "6.0%" },
        { 19881, "INV_Misc_Head_Troll_02", "=q1=Channeler's Head", "=ds=#m3#", "100%" },
        { 22216, "INV_Misc_Organ_04", "=q1=Venoxis's Venom Sac", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 19904, "INV_Chest_Plate08", "=q4=Runed Bloodstained Hauberk", "=ds=#s5#, #a3#", "3.70%" },
        { 19903, "INV_Weapon_Shortblade_31", "=q4=Fang of Venoxis", "=ds=#h3#, #w4#", "3.68%" },
        { 0,"","","" },
        { 19907, "INV_Misc_Cape_10", "=q3=Zulian Tigerhide Cloak", "=ds=#s4#", "12.09%" },
        { 19906, "INV_Boots_Chain_04", "=q3=Blooddrenched Footpads", "=ds=#s12#, #a2#", "11.36%" },
        { 19905, "INV_Jewelry_Ring_46", "=q3=Zanzil's Band", "=ds=#s13#", "6.99%" },
        { 19900, "INV_Axe_34", "=q3=Zulian Stone Axe", "=ds=#h2#, #w1#", "11.89%" },
        };

    ZGMarli = {
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",            "=ds=#m3#", "13.69%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",          "=ds=#m3#", "13.69%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",       "=ds=#m3#", "13.64%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",     "=ds=#m3#", "6.55%" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",      "=ds=#m3#", "6.49%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",     "=ds=#m3#", "6.31%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",        "=ds=#m3#", "2.56%" },
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",        "=ds=#m3#", "2.55%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis",    "=ds=#m3#", "2.30%" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "7.4%" },
        { 19881, "INV_Misc_Head_Troll_02", "=q1=Channeler's Head", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" }, 
        { 20032, "INV_Chest_Cloth_25", "=q4=Flowing Ritual Robes",  "=ds=#s5#, #a1#", "4.46%" },
        { 19927, "INV_Wand_06", "=q4=Mar'li's Touch",               "=ds=#w12#", "4.35%" },
        { 0,"","","" },
        { 19919, "INV_Boots_Chain_04", "=q3=Bloodstained Greaves",  "=ds=#s12#, #a3#", "11.89%" },
        { 19871, "INV_Jewelry_Necklace_21", "=q3=Talisman of Protection", "=ds=#s2#", "11.36%" },
        { 19925, "INV_Jewelry_Ring_44", "=q3=Band of Jin", "=ds=#s13#", " 6.99%" },
        { 19930, "INV_ZulGurubTrinket", "=q3=Mar'li's Eye", "=ds=#s14#", "12.09%" },
        };

    ZGMandokir = {
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",          "=ds=#m3#", "12.94%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis",      "=ds=#m3#", "12.07%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",          "=ds=#m3#", "11.56%" },
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",              "=ds=#m3#", "6.65%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",            "=ds=#m3#", "6.55%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",         "=ds=#m3#", "6.52%" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",        "=ds=#m3#", "2.98%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",       "=ds=#m3#", "2.65%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",       "=ds=#m3#", "2.48%" },
        { 0,"","","" },
        { 22637,"INV_ZulGurubTrinket","=q3=Primal Hakkari Idol","=ds=#m3#" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "9.4%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19867, "INV_Sword_54", "=q4=Bloodlord's Defender",            "=ds=#h3#, #w10#", "5.83%" },
        { 19866, "INV_Sword_55", "=q4=Warblade of the Hakkari",         "=ds=#h4#, #w10#", "3.96%" },
        { 19874, "INV_Weapon_Halberd_12", "=q4=Halberd of Smiting",     "=ds=#w7#", "6.35%" },
        { 20038, "INV_Waepon_Bow_ZulGrub_D_01", "=q4=Mandokir's Sting", "=ds=#w2#", "5.96%" },
        { 19872, "Ability_Mount_Raptor", "=q4=Swift Razzashi Raptor",   "=ds=#e12#", "0.43%" },
        { 0,"","","" },
        { 19870, "INV_Misc_Cape_18", "=q3=Hakkari Loa Cloak",           "=ds=#s4#", "12.54%" },
        { 19895, "INV_Pants_Cloth_14", "=q3=Bloodtinged Kilt",          "=ds=#s11#, #a1#", "13.50%" },
        { 19869, "INV_Gauntlets_26", "=q3=Blooddrenched Grips",         "=ds=#s9#, #a2#", "12.87%" },
        { 19877, "INV_Pants_Mail_14", "=q3=Animist's Leggings",         "=ds=#s11#, #a2#", "12.14%" },
        { 19878, "INV_Shoulder_01", "=q3=Bloodsoaked Pauldrons",        "=ds=#s9#, #a4#", "12.31%" },
        { 19873, "INV_Jewelry_Ring_39", "=q3=Overlord's Crimson Band",  "=ds=#s13#", "12.28%" },
        { 19893, "INV_Jewelry_Ring_46", "=q3=Zanzil's Seal",            "=ds=#s13#", "13.11%" },
        { 19863, "INV_Jewelry_Ring_47", "=q3=Primalist's Seal",         "=ds=#s13#", "12.32%" },
        };

    ZGGrilek = {
        { 19961, "INV_Mace_04", "=q3=Gri'lek's Grinder", "=ds=#h1#, #w6#", "43.90%" },
        { 19962, "INV_Axe_24", "=q3=Gri'lek's Carver",   "=ds=#h2#, #w1#", "41.99%" },
        { 0,"","","" },
        { 19939, "INV_Potion_26", "=q2=Gri'lek's Blood", "=ds=#m3#", "100%" },
        };

    ZGHazzarah = {
        { 19968, "INV_Sword_01", "=q3=Fiery Retributer", "=ds=#h3#, #w10#", "38.37%" },
        { 19967, "INV_Wand_05", "=q3=Thoughtblighter",   "=ds=#w12#", "45.49%" },
        { 0,"","","" },
        { 19942, "INV_Misc_Bandage_16", "=q2=Hazza'rah's Dream Thread", "=ds=#m3#", "100%" },
        };

    ZGRenataki = {
        { 19964, "INV_Sword_37", "=q3=Renataki's Soul Conduit", "=ds=#h3#, #w10#", "40.06%" },
        { 19963, "INV_Spear_03", "=q3=Pitchfork of Madness",    "=ds=#w7#", "45.51%" },
        { 0,"","","" },
        { 19940, "INV_Misc_MonsterFang_01", "=q2=Renataki's Tooth", "=ds=#m3#", "100%" },
        };

    ZGWushoolay = {
        { 19965, "INV_Sword_37", "=q3=Wushoolay's Poker",                 "=ds=#h3#, #w4#", "45.21%" },
        { 19993, "INV_Waepon_Bow_ZulGrub_D_02", "=q3=Hoodoo Hunting Bow", "=ds=#w2#", "40.96%" },
        { 0,"","","" },
        { 19941, "INV_Misc_MonsterTail_02", "=q2=Wushoolay's Mane", "=ds=#m3#", "100%" },
        };

    ZGGahzranka = {
        { 19945, "INV_Helmet_46", "=q4=Foror's Eyepatch", "=ds=#s1#, #a2#", "8,82%" },
        { 19944, "INV_Fishingpole_02", "=q4=Nat Pagle's Fish Terminator", "=ds=#w9#", "2.39%" },
        { 0,"","","" },
        { 19947, "INV_Gizmo_09", "=q3=Nat Pagle's Broken Reel", "=ds=#s14#", "28.20%" },
        { 19946, "INV_Spear_04", "=q3=Tigule's Harpoon", "=ds=#w7#", "29.22%" },
        { 0,"","","" },
        { 22739, "INV_Misc_Book_07", "=q3=Tome of Polymorph: Turtle", "=ds=#e10#, =q1=#m1# =ds=#c3#" },
        };

    ZGThekal = {
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",        "=ds=#m3#", " 14.95%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",   "=ds=#m3#", " 13.74%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",      "=ds=#m3#", " 12.95" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",  "=ds=#m3#", " 6.60%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion", "=ds=#m3#", " 6.56%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint", "=ds=#m3#", " 6.45%" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "8.3%" },
        { 19881, "INV_Misc_Head_Troll_02", "=q1=Channeler's Head", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19897, "INV_Boots_Cloth_09", "=q4=Betrayer's Boots", "=ds=#s12#, #a1#", "5.83%" },
        { 19896, "INV_Weapon_Hand_01", "=q4=Thekal's Grasp", "=ds=#h3#, #w13#", "4.23%" },
        { 19902, "Ability_Mount_JungleTiger", "=q4=Swift Zulian Tiger", "=ds=#e12#", "0.70%" },
        { 0,"","","" },
        { 19898, "INV_Jewelry_Ring_44", "=q3=Seal of Jin",         "=ds=#s13#", "13.65%" },
        { 19899, "INV_Pants_Cloth_14", "=q3=Ritualistic Legguards", "=ds=#s11#, #a1#", "13.41%" },
        { 20260, "INV_Pants_Mail_06", "=q3=Seafury Leggings",      "=ds=#s11#, #a3#", "4.30%" },
        { 20266, "INV_Pants_Plate_04", "=q3=Peacekeeper Leggings", "=ds=#s11#, #a4#", "8.69%" },
        { 19901, "INV_Sword_35", "=q3=Zulian Slicer",              "=ds=#h1#, #w10#, =q1=#e18#", "13.36%" },
        };

    ZGArlokk = {
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",     "=ds=#m3#", "15.49%" },
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",          "=ds=#m3#", "12.52%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",        "=ds=#m3#", "13.17%" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",    "=ds=#m3#", "6.94%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",   "=ds=#m3#", "6.65%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",   "=ds=#m3#", "6.21%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",      "=ds=#m3#", "2.75%" },
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",      "=ds=#m3#", "2.60%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis",  "=ds=#m3#", "2.41%" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "5.6%" },
        { 19881, "INV_Misc_Head_Troll_02", "=q1=Channeler's Head", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19910, "INV_Weapon_Hand_01", "=q4=Arlokk's Grasp",       "=ds=#h4#, #w13#", "3.62%" },
        { 19909, "INV_Staff_35", "=q4=Will of Arlokk",             "=ds=#w9#", "5.14%" },
        { 0,"","","" },
        { 19913, "INV_Boots_Plate_06", "=q3=Bloodsoaked Greaves",   "=ds=#s12#, #a4#", "13.29%" },
        { 19912, "INV_Jewelry_Ring_39", "=q3=Overlord's Onyx Band", "=ds=#s13#", "13.95%" },
        { 19922, "INV_Misc_Bone_DwarfSkull_01", "=q3=Arlokk's Hoodoo Stick", "=ds=#s15#", "13.66%" },
        { 19914, "INV_Misc_Bag_14", "=q3=Panther Hide Sack",        "=ds=#m14# #e1#", "14.03%" },
        };

    ZGJindo = {
        { 19723, "INV_Shirt_07", "=q4=Primal Hakkari Kossack",     "=ds=#m3#", "13.56%" },
        { 19722, "INV_Banner_01", "=q4=Primal Hakkari Tabard",     "=ds=#m3#", "13.48%" },
        { 19724, "INV_Chest_Chain_12", "=q4=Primal Hakkari Aegis", "=ds=#m3#", "12.09%" },
        { 19721, "INV_Shoulder_19", "=q4=Primal Hakkari Shawl",    "=ds=#m3#", "7.30%" },
        { 19719, "INV_Belt_12", "=q4=Primal Hakkari Girdle",       "=ds=#m3#", "6.37%" },
        { 19720, "INV_Belt_07", "=q4=Primal Hakkari Sash",         "=ds=#m3#", "6.10%" },
        { 19716, "INV_Bracer_05", "=q4=Primal Hakkari Bindings",   "=ds=#m3#", "2.85%" },
        { 19717, "INV_Bracer_18", "=q4=Primal Hakkari Armsplint",  "=ds=#m3#", "2.70%" },
        { 19718, "INV_Bracer_14", "=q4=Primal Hakkari Stanchion",  "=ds=#m3#", "2.36%" },
        { 0,"","","" },
        { 22637,"INV_ZulGurubTrinket","=q3=Primal Hakkari Idol","=ds=#m3#" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "8.4%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19885, "INV_Jewelry_Ring_45", "=q4=Jin'do's Evil Eye",          "=ds=#s2#", "6.82%" },
        { 19891, "INV_Misc_Bag_10_Black", "=q4=Jin'do's Bag of Whammies", "=ds=#s15#", "7.70%" },
        { 19890, "INV_Mace_17", "=q4=Jin'do's Hexxer",                    "=ds=#h3#, #w6#", "8.08%" },
        { 19884, "INV_Staff_33", "=q4=Jin'do's Judgement",                "=ds=#w9#", "8.36%" },
        { 0,"","","" },
        { 19888, "INV_Misc_Cape_21", "=q3=Overlord's Embrace",         "=ds=#s4#", "12.72%" },
        { 19886, "INV_Mask_02", "=q3=The Hexxer's Cover",              "=ds=#s1#, #a1#", "12.11%" },
        { 19929, "INV_Gauntlets_16", "=q3=Bloodtinged Gloves",         "=ds=#s9#, #a1#", "11.75%" },
        { 19889, "INV_Pants_Leather_09", "=q3=Blooddrenched Leggings", "=ds=#s11#, #a2#", "11.97%" },
        { 19892, "INV_Boots_Chain_13", "=q3=Animist's Boots",          "=ds=#s12#, #a2#", "12.28%" },
        { 19875, "INV_Helmet_39", "=q3=Bloodstained Coif",             "=ds=#s1#, #a3#", "13.73%" },
        { 19887, "INV_Pants_Mail_09", "=q3=Bloodstained Legplates",    "=ds=#s11#, #a3#", "11.11%" },
        { 19894, "INV_Gauntlets_14", "=q3=Bloodsoaked Gauntlets",      "=ds=#s9#, #a4#", "12.93%" },
        };

    ZGHakkar = {
        { 19857, "INV_Misc_Cape_22", "=q4=Cloak of Consumption",       "=ds=#s4#", "11.65%" },
        { 20257, "INV_Gauntlets_30", "=q4=Seafury Gauntlets",          "=ds=#s9#, #a3#", "4.11%" },
        { 20264, "INV_Gauntlets_10", "=q4=Peacekeeper Gauntlets",      "=ds=#s9#, #a4#", "7.37%" },
        { 19855, "INV_Pants_Plate_21", "=q4=Bloodsoaked Legplates",    "=ds=#s11#, #a4#", "10.52%" },
        { 19876, "INV_Jewelry_Necklace_19", "=q4=Soul Corrupter's Necklace", "=ds=#s2#", "10.11%" },
        { 19856, "INV_Jewelry_Necklace_22", "=q4=The Eye of Hakkar",   "=ds=#s2#", "12.02%" },
        { 0,"","","" },
        { 19859, "INV_Weapon_Shortblade_30", "=q4=Fang of the Faceless", "=ds=#h1#, #w4#", "7.33%" },
        { 19864, "INV_Sword_18", "=q4=Bloodcaller",                    "=ds=#h3#, #w10#", "7.69%" },
        { 19865, "INV_Sword_55", "=q4=Warblade of the Hakkari",        "=ds=#h3#, #w10#", "3.67%" },
        { 19854, "INV_Sword_55", "=q4=Zin'rokh, Destroyer of Worlds",  "=ds=#h2#, #w10#", "6.78%" },
        { 19852, "INV_Axe_35", "=q4=Ancient Hakkari Manslayer",        "=ds=#h1#, #w1#", "6.62%" },
        { 19862, "INV_Shield_12", "=q4=Aegis of the Blood God",        "=ds=#w8#", "9.99%" },
        { 19853, "INV_Weapon_Rifle_10", "=q4=Gurubashi Dwarf Destroyer", "=ds=#w5#", "6.12%" },
        { 19861, "INV_Wand_09", "=q4=Touch of Chaos",                  "=ds=#w12#", "7.24%" },
        { 19802, "INV_Misc_Gem_Bloodstone_02", "=q4=Heart of Hakkar",  "=ds=#m2#", "100%" },
        { 19950, "INV_Jewelry_Necklace_13", "=q4=Zandalarian Hero Charm", "=q1=#m4#: =ds=#s14#" },
        { 19949, "INV_Jewelry_Necklace_13", "=q4=Zandalarian Hero Medallion",  "=q1=#m4#: =ds=#s14#" },
        { 19948, "INV_Jewelry_Necklace_13", "=q4=Zandalarian Hero Badge",      "=q1=#m4#: =ds=#s14#" },
        { 0,"","","" },
        { 19943, "Spell_Nature_Strength", "=q1=Massive Mojo", "=ds=#e8#", "34.3%" },
        };

    ZGMuddyChurningWaters = {
        { 19975, "INV_Misc_Fish_05", "=q1=Zulian Mudskunk", "=ds=#e21#" },
        };

    ZGShared = {
        { 22721, "INV_Jewelry_Ring_16", "=q4=Band of Servitude", "=ds=#s13#" };
        { 22722, "INV_Jewelry_Ring_20", "=q4=Seal of the Gurubashi Berserker", "=ds=#s13#" };
        { 0,"","","" },
        { 22711, "INV_Misc_Cape_16", "=q3=Cloak of the Hakkari Worshipers", "=ds=#s4#" },
        { 22712, "INV_Misc_Cape_16", "=q3=Might of the Tribe", "=ds=#s4#" },
        { 22720, "INV_Helmet_61", "=q3=Zulian Headdress", "=ds=#s1#, #a1#" },
        { 22716, "INV_Belt_01", "=q3=Belt of Untapped Power", "=ds=#s10#, #a1#" },
        { 22718, "INV_Helmet_41", "=q3=Blooddrenched Mask", "=ds=#s1#, #a2#" },
        { 22715, "INV_Gauntlets_10", "=q3=Gloves of the Tormented", "=ds=#s9#, #a3#" },
        { 22714, "INV_Gauntlets_31", "=q3=Sacrificial Gauntlets", "=ds=#s9#, #a4#" },
        { 22713, "INV_Waepon_Bow_ZulGrub_D_01", "=q3=Zulian Scepter of Rites", "=ds=#h3#, #w6#" },
        };

    ZGTrash1 = {
        { 20259, "INV_Gauntlets_25", "=q3=Shadow Panther Hide Gloves", "=ds=#s9#, #a2#" },
        { 20261, "INV_Belt_26", "=q3=Shadow Panther Hide Belt", "=ds=#s10#, #a2#" },
        { 20263, "INV_Helmet_25", "=q3=Gurubashi Helm", "=ds=#s1#, #a4#" },
        { 19908, "INV_Mace_08", "=q3=Sceptre of Smiting", "=ds=#h1#, #w6#" },
        { 19921, "INV_Axe_08", "=q3=Zulian Hacker", "=ds=#h1#, #w1#" },
        { 20258, "INV_Staff_34", "=q3=Zulian Ceremonial Staff", "=ds=#w9#" },
        { 19727, "INV_Weapon_Shortblade_29", "=q3=Blood Scythe", "=ds=#e19#", "0.02%" },
        { 0,"","","" },
        { 19726, "INV_Misc_Herb_09", "=q2=Bloodvine", "=ds=#e8#", "" },
        { 19774, "INV_Misc_Gem_01", "=q2=Souldarite", "=ds=#e8#", "" },
        { 19767, "INV_Misc_Pelt_01", "=q1=Primal Bat Leather", "=ds=#e8#", "" },
        { 19768, "INV_Misc_Pelt_04", "=q1=Primal Tiger Leather", "=ds=#e8#", "" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19821, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c1#", "0.01%" },
        { 19816, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c2#", "0.01%" },
        { 19818, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c3#", "0.01%" },
        { 19815, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c4#", "0.01%" },
        { 19820, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c5#", "0.01%" },
        { 19814, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c6#", "0.01%" },
        { 19817, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c7#", "0.01%" },
        { 19819, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c8#", "0.01%" },
        { 19813, "INV_Misc_Idol_02", "=q2=Punctured Voodoo Doll", "=q1=#m1# =ds=#c9#", "0.01%" },
        };

    ZGTrash2 = {
        { 19708, "INV_Bijou_Blue", "=q3=Blue Hakkari Bijou", "=ds=#e15#", "1.48%" },
        { 19713, "INV_Bijou_Bronze", "=q3=Bronze Hakkari Bijou", "=ds=#e15#", "1.57%" },
        { 19715, "INV_Bijou_Gold", "=q3=Gold Hakkari Bijou", "=ds=#e15#", "1.63%" },
        { 19711, "INV_Bijou_Green", "=q3=Green Hakkari Bijou", "=ds=#e15#", "1.67%" },
        { 19710, "INV_Bijou_Orange", "=q3=Orange Hakkari Bijou", "=ds=#e15#", "1.76%" },
        { 19712, "INV_Bijou_Purple", "=q3=Purple Hakkari Bijou", "=ds=#e15#", "1.67%" },
        { 19707, "INV_Bijou_Red", "=q3=Red Hakkari Bijou", "=ds=#e15#", "1.63%" },
        { 19714, "INV_Bijou_Silver", "=q3=Silver Hakkari Bijou", "=ds=#e15#", "1.59%" },
        { 19709, "INV_Bijou_Yellow", "=q3=Yellow Hakkari Bijou", "=ds=#e15#", "1.50%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19706, "INV_Misc_Coin_11", "=q2=Bloodscalp Coin", "=ds=#e15#", "3.01%" },
        { 19701, "INV_Misc_Coin_07", "=q2=Gurubashi Coin", "=ds=#e15#", "3.12%" },
        { 19700, "INV_Misc_Coin_09", "=q2=Hakkari Coin", "=ds=#e15#", "3.19%" },
        { 19699, "INV_Misc_Coin_10", "=q2=Razzashi Coin", "=ds=#e15#", "3.36%" },
        { 19704, "INV_Misc_Coin_15", "=q2=Sandfury Coin", "=ds=#e15#", "3.47%" },
        { 19705, "INV_Misc_Coin_12", "=q2=Skullsplitter Coin", "=ds=#e15#", "3.32%" },
        { 19702, "INV_Misc_Coin_13", "=q2=Vilebranch Coin", "=ds=#e15#", "3.27%" },
        { 19698, "INV_Misc_ArmorKit_11", "=q2=Zulian Coin", "=ds=#e15#", "3.01%" },
        };

    ZGEnchants = {
        { 19790, "Spell_Nature_Reincarnation", "=q3=Animist's Caress", "=q1=#m1# =ds=#c1#" },
        { 19785, "Spell_Nature_ForceOfNature", "=q3=Falcon's Call", "=q1=#m1# =ds=#c2#" },
        { 19787, "Spell_Shadow_DetectLesserInvisibility", "=q3=Presence of Sight", "=q1=#m1# =ds=#c3#" },
        { 19783, "Spell_Holy_PrayerOfHealing", "=q3=Syncretist's Sigil", "=q1=#m1# =ds=#c4#" },
        { 19789, "Spell_Holy_HolyProtection", "=q3=Prophetic Aura", "=q1=#m1# =ds=#c5#" },
        { 19784, "Spell_Shadow_ScourgeBuild", "=q3=Death's Embrace", "=q1=#m1# =ds=#c6#" },
        { 19786, "Spell_Nature_Purge", "=q3=Vodouisant's Vigilant Embrace", "=q1=#m1# =ds=#c7#" },
        { 19788, "Spell_Shadow_ImpPhaseShift", "=q3=Hoodoo Hex", "=q1=#m1# =ds=#c8#" },
        { 19782, "Spell_Holy_SealOfWrath", "=q3=Presence of Might", "=q1=#m1# =ds=#c9#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20077, "INV_Misc_ArmorKit_08", "=q3=Zandalar Signet of Might", "=ds=#s3# #e17#" },
        { 20076, "INV_Jewelry_Ring_46", "=q3=Zandalar Signet of Mojo", "=ds=#s3# #e17#" },
        { 20078, "Spell_Holy_PowerWordShield", "=q3=Zandalar Signet of Serenity", "=ds=#s3# #e17#" },
        { 0,"","","" },
        { 22635, "Spell_Nature_SpiritArmor", "=q3=Savage Guard", "=ds=#s1#/#s11# #e17#" },
        };

        ------------------------------
        --- The Ruins of Ahn'Qiraj ---
        ------------------------------

    AQ20Kurinnaxx = {
        { 21499, "INV_Chest_Cloth_17", "=q4=Vestments of the Shifting Sands", "=ds=#s5#, #a1#", "7.34%"},
        { 21498, "INV_Weapon_ShortBlade_12", "=q4=Qiraji Sacrificial Dagger", "=ds=#h1#, #w4#", "7.53%"},
        { 0,"","","" },
        { 21500, "INV_Belt_05", "=q3=Belt of the Inquisition",             "=ds=#s10#, #a1#", "14.84%" },
        { 21501, "INV_Gauntlets_24", "=q3=Toughened Silithid Hide Gloves", "=ds=#s9#, #a2#", "12.91%" },
        { 21502, "INV_Bracer_19", "=q3=Sand Reaver Wristguards",           "=ds=#s8#, #a3#", "13.79%" },
        { 21503, "INV_Belt_13", "=q3=Belt of the Sand Reaver",             "=ds=#s10#, #a4#", "14.38%" },
        { 0,"","","" },
        { 22217, "INV_Misc_Organ_04", "=q1=Kurinnaxx's Venom Sac", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20889, "INV_Bracer_18", "=q3=Qiraji Regal Drape",                  "#m3#", "30.83%" },
        { 20885, "INV_Qiraj_DrapeMartial", "=q3=Qiraji Martial Drape",       "#m3#", "30.25%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "7.98%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "7.80%" },
        };

    AQ20CAPTIAN = {
        { 21810, "INV_Boots_Cloth_05", "=q3=Treads of the Wandering Nomad", "=ds=#s12#, #a1#", "3.11%" },
        { 21809, "INV_Jewelry_Necklace_14", "=q3=Fury of the Forgotten Swarm", "=ds=#s2#", "3.20%" },
        { 21806, "INV_Hammer_04", "=q3=Gavel of Qiraji Authority", "=ds=#h2#, #w6#", "3.04%" },
        };

    AQ20Rajaxx = {
        { 21493, "INV_Boots_08", "=q4=Boots of the Vanguard",   "=ds=#s12#, #a2#", "8.13%" },
        { 21492, "INV_Sword_56", "=q4=Manslayer of the Qiraji", "=ds=#h2#, #w10#", "10.04%" },
        { 0,"","","" },
        { 21496, "INV_Bracer_13", "=q3=Bracers of Qiraji Command",            "=ds=#s8#, #a1#", "15.79%" },
        { 21494, "INV_Belt_25", "=q3=Southwind's Grasp",                      "=ds=#s10#, #a2#", "15.13%" },
        { 21497, "INV_Boots_Chain_11", "=q3=Boots of the Qiraji General",     "=ds=#s12#, #a3#", "15.45%" },
        { 21495, "INV_Pants_Plate_15", "=q3=Legplates of the Qiraji Command", "=ds=#s11#, #a4#", "15.47" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20889, "INV_Bracer_18", "=q3=Qiraji Regal Drape",                  "#m3#", "36.51%" },
        { 20885, "INV_Qiraj_DrapeMartial", "=q3=Qiraji Martial Drape",       "#m3#", "33.97%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "8.82%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "8.56%" },
        };

    AQ20Andorov = {
        { 22221, "INV_Scroll_03", "=q1=Plans: Obsidian Mail Tunic", "=ds=#p2# (300)" },
        { 22219, "INV_Scroll_03", "=q1=Plans: Jagged Obsidian Shield", "=ds=#p2# (300)"},
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 22191, "INV_Chest_Chain_17", "=q4=Obsidian Mail Tunic", "=ds=#s5#, #a3#" },
        { 22198, "INV_Shield_22", "=q4=Jagged Obsidian Shield", "=ds=#w8#"},
        };    

    AQ20Moam = {
        { 21472, "INV_Helmet_62", "=q4=Dustwind Turban",                  "=ds=#s1#, #a1#", "7.76%" },
        { 21467, "INV_Chest_Leather_07", "=q4=Thick Silithid Chestguard", "=ds=#s5#, #a2#", "6.76%" },
        { 21479, "INV_Gauntlets_31", "=q4=Gauntlets of the Immovable",    "=ds=#s9#, #a4#", "7.12%" },
        { 21471, "INV_Mace_21", "=q4=Talon of Furious Concentration",     "=ds=#s15#", "7.39%" },
        { 0,"","","" },
        { 21470, "INV_Misc_Cape_16", "=q3=Cloak of the Savior",          "=ds=#s4#", "14.23%" },
        { 21468, "INV_Shoulder_25", "=q3=Mantle of Maz'Nadir",           "=ds=#s3#, #a1#", "15.86%" },
        { 21455, "INV_Helmet_01", "=q3=Southwind Helm",                  "=ds=#s1#, #a2#", "14.08%" },
        { 21474, "INV_Shoulder_29", "=q3=Chitinous Shoulderguards",      "=ds=#s3#, #a2#", "15.25%" },
        { 21469, "INV_Gauntlets_05", "=q3=Gauntlets of Southwind",       "=ds=#s9#, #a2#", "15.28%" },
        { 21476, "INV_Pants_Mail_15", "=q3=Obsidian Scaled Leggings",    "=ds=#s11#, #a3#", "6.81%" },
        { 21475, "INV_Pants_Plate_01", "=q3=Legplates of the Destroyer", "=ds=#s11#, #a4#", "10.39%" },
        { 21477, "INV_Jewelry_Ring_AhnQiraj_04", "=q3=Ring of Fury",     "=ds=#s13#", "14.42%" },
        { 21473, "INV_Misc_Eye_01", "=q3=Eye of Moam",                   "=ds=#s14#", "14.74%" },
        { 0,"","","" },
        { 20886, "INV_Qiraj_HiltSpiked", "=q4=Qiraji Spiked Hilt",           "#m3#", "36.38%" },
        { 20890, "INV_Qiraj_HiltOrnate", "=q4=Qiraji Ornate Hilt",           "#m3#", "33.16%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "7.56%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "8.34%" },
        { 0,"","","" },
        { 22220, "INV_Scroll_05", "=q3=Plans: Black Grasp of the Destroyer", "=ds=#p2# (300)", "4.11%" },
        { 22194, "INV_Gauntlets_31", "=q4=Black Grasp of the Destroyer", "=ds=#s9#, #a3#" },
        };

    AQ20Buru = {
        { 21487, "INV_Gauntlets_12", "=q4=Slimy Scaled Gauntlets", "=ds=#s9#, #a3#", "2.64%" },
        { 21486, "INV_Gauntlets_30", "=q4=Gloves of the Swarm",    "=ds=#s9#, #a4#", "5.22%" },
        { 21485, "INV_Shield_22", "=q4=Buru's Skull Fragment",     "=ds=#w8#", "7.88%" },
        { 0,"","","" },
        { 21489, "INV_Boots_Cloth_05", "=q3=Quicksand Waders",                    "=ds=#s12#, #a1#", "15.95%" },
        { 21491, "INV_Bracer_03", "=q3=Scaled Bracers of the Gorger",             "=ds=#s8#, #a2#", "16.51%" },
        { 21490, "INV_Boots_Plate_04", "=q3=Slime Kickers",                       "=ds=#s12#, #a4#", "15.99%" },
        { 21488, "INV_Misc_AhnQirajTrinket_02", "=q3=Fetish of Chitinous Spikes", "=ds=#s14#", "17.22%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20886, "INV_Qiraj_HiltSpiked", "=q4=Qiraji Spiked Hilt",           "#m3#", "8.31%" },
        { 20890, "INV_Qiraj_HiltOrnate", "=q4=Qiraji Ornate Hilt",           "#m3#", "8.98%" },
        { 20889, "INV_Bracer_18", "=q3=Qiraji Regal Drape",                  "#m3#", "9.77%" },
        { 20885, "INV_Qiraj_DrapeMartial", "=q3=Qiraji Martial Drape",       "#m3#", "9.84%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "26.98%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "25.58%" },
        };

    AQ20Ayamiss = {
        { 21479, "INV_Gauntlets_31", "=q4=Gauntlets of the Immovable", "=ds=#s9#, #a4#", "6.18%" },
        { 21466, "INV_Mace23", "=q4=Stinger of Ayamiss",               "=ds=#h3#, #w6#", "2.06%" },
        { 21478, "INV_Weapon_Bow_13", "=q4=Bow of Taut Sinew",         "=ds=#w2#", "10.14%" },
        { 0,"","","" },
        { 21484, "INV_Helmet_15", "=q3=Helm of Regrowth",                        "=ds=#s1#, #a2#", "15.85%" },
        { 21480, "INV_Gauntlets_10", "=q3=Scaled Silithid Gauntlets",            "=ds=#s9#, #a3#", "17.10%" },
        { 21482, "INV_Boots_Chain_02", "=q3=Boots of the Fiery Sands",           "=ds=#s12#, #a3#", "4.92%" },
        { 21481, "INV_Boots_Plate_05", "=q3=Boots of the Desert Protector",      "=ds=#s12#, #a4#", "11.08%" },
        { 21483, "INV_Jewelry_Ring_AhnQiraj_05", "=q3=Ring of the Desert Winds", "=ds=#s13#", "16.32%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20886, "INV_Qiraj_HiltSpiked", "=q4=Qiraji Spiked Hilt",           "#m3#", "8.24%" },
        { 20890, "INV_Qiraj_HiltOrnate", "=q4=Qiraji Ornate Hilt",           "#m3#", "8.21%" },
        { 20889, "INV_Bracer_18", "=q3=Qiraji Regal Drape",                  "#m3#", "8.85%" },
        { 20885, "INV_Qiraj_DrapeMartial", "=q3=Qiraji Martial Drape",       "#m3#", "10.97%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "26.98%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "27.50%" },
        };

    AQ20Ossirian = {
        { 21456, "INV_Misc_Cape_06", "=q4=Sandstorm Cloak",                  "=ds=#s4#", "10.89%" },
        { 21464, "INV_Bracer_07", "=q4=Shackles of the Unscarred",           "=ds=#s8#, #a1#", "12.62%" },
        { 21462, "INV_Gauntlets_19", "=q4=Gloves of Dark Wisdom",            "=ds=#s9#, #a1#", "11.89%" },
        { 21461, "INV_Pants_Cloth_06", "=q4=Leggings of the Black Blizzard", "=ds=#s11#, #a1#", "12.83%" },
        { 21458, "INV_Gauntlets_24", "=q4=Gauntlets of New Life",            "=ds=#s9#, #a2#", "13.25%" },
        { 21454, "INV_Shoulder_18", "=q4=Runic Stone Shoulders",             "=ds=#s3#, #a3#", "4.10%" },
        { 21463, "INV_Belt_18", "=q4=Ossirian's Binding",                    "=ds=#s10#, #a3#", "12.27%" },
        { 21460, "INV_Helmet_09", "=q4=Helm of Domination",                  "=ds=#s1#, #a4#", "12.18%" },
        { 21453, "INV_Shoulder_28", "=q4=Mantle of the Horusath",            "=ds=#s3#, #a4#", "6.96%" },
        { 21457, "INV_Bracer_19", "=q4=Bracers of Brutality",                "=ds=#s8#, #a4#", "10.74%" },
        { 21715, "INV_Mace_24", "=q4=Sand Polished Hammer",                  "=ds=#h1#, #w6#", "5.95%" },
        { 21459, "INV_Weapon_Crossbow_06", "=q4=Crossbow of Imminent Doom",  "=ds=#w3#", "6.12%" },
        { 21452, "INV_Staff_12", "=q4=Staff of the Ruins",                   "=ds=#w9#", "10.32%" },
        { 0,"","","" },
        { 0,"","","" },
        { 21220, "Ability_Hunter_Pet_Owl", "=q4=Head of Ossirian the Unscarred", "=ds=#m2#", "100%" },
        { 21504, "INV_Jewelry_Necklace_AhnQiraj_03", "=q4=Charm of the Shifting Sands", "=q1=#m4#: =ds=#s2#" },
        { 21507, "INV_Jewelry_Necklace_AhnQiraj_03", "=q4=Amulet of the Shifting Sands", "=q1=#m4#: =ds=#s2#" },
        { 21505, "INV_Jewelry_Necklace_AhnQiraj_03", "=q4=Choker of the Shifting Sands", "=q1=#m4#: =ds=#s2#" },
        { 21506, "INV_Jewelry_Necklace_AhnQiraj_03", "=q4=Pendant of the Shifting Sands", "=q1=#m4#: =ds=#s2#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20886, "INV_Qiraj_HiltSpiked", "=q4=Qiraji Spiked Hilt",           "#m3#", "35.27%" },
        { 20890, "INV_Qiraj_HiltOrnate", "=q4=Qiraji Ornate Hilt",           "#m3#", "30.69%" },
        { 20884, "INV_Qiraj_RingMagisterial", "=q3=Qiraji Magisterial Ring", "#m3#", "9.65%" },
        { 20888, "INV_Qiraj_RingCeremonial", "=q3=Qiraji Ceremonial Ring",   "#m3#", "8.53%" },
        };

    AQ20Trash = {
        { 20873, "INV_QirajIdol_Alabaster", "=q3=Alabaster Idol", "=ds=#e15#", "0.39%" },
        { 20869, "INV_QirajIdol_Amber", "=q3=Amber Idol", "=ds=#e15#", "0.36%" },
        { 20866, "INV_QirajIdol_Azure", "=q3=Azure Idol", "=ds=#e15#", "0.48%" },
        { 20870, "INV_QirajIdol_Jasper", "=q3=Jasper Idol", "=ds=#e15#", "0.52%" },
        { 20868, "INV_QirajIdol_Lambent", "=q3=Lambent Idol", "=ds=#e15#", "0.48%" },
        { 20871, "INV_QirajIdol_Obsidian", "=q3=Obsidian Idol", "=ds=#e15#", "0.41%" },
        { 20867, "INV_QirajIdol_Onyx", "=q3=Onyx Idol", "=ds=#e15#", "0.36%" },
        { 20872, "INV_QirajIdol_Vermillion", "=q3=Vermillion Idol", "=ds=#e15#", "0.31%" },
        { 0,"","","" },
        { 22202, "INV_Misc_StoneTablet_01", "=q1=Small Obsidian Shard", "=ds=#e8#" },
        { 22203, "INV_Stone_15", "=q1=Large Obsidian Shard", "=ds=#e8#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20864, "INV_Scarab_bone", "=q2=Bone Scarab", "=ds=#e15#", "0.84%" },
        { 20861, "INV_Scarab_bronze", "=q2=Bronze Scarab", "=ds=#e15#", "0.88%" },
        { 20863, "INV_Scarab_clay", "=q2=Clay Scarab", "=ds=#e15#", "0.95%" },
        { 20862, "INV_Scarab_crystal", "=q2=Crystal Scarab", "=ds=#e15#", "0.99%" },
        { 20859, "INV_Scarab_gold", "=q2=Gold Scarab", "=ds=#e15#", "0.96%" },
        { 20865, "INV_Scarab_ivory", "=q2=Ivory Scarab", "=ds=#e15#", "0.93%" },
        { 20860, "INV_Scarab_silver", "=q2=Silver Scarab", "=ds=#e15#", "1.82%" },
        { 20858, "INV_Scarab_stone", "=q2=Stone Scarab", "=ds=#e15#", "0.86%" },
        { 0,"","","" },
        { 21761, "INV_Misc_Key_08", "=q1=Scarab Coffer Key", "=ds=#e9#", "7.27%" },
        };

    AQ20ClassBooks = {
        { 21294, "INV_Misc_Book_11", "=q3=Book of Healing Touch XI",                   "=q1=#m1# =ds=#c1#", "4.12%" },
        { 21296, "INV_Misc_Book_11", "=q3=Book of Rejuvenation XI",                    "=q1=#m1# =ds=#c1#", "4.20%" },
        { 21295, "INV_Misc_Book_11", "=q3=Book of Starfire VII",                       "=q1=#m1# =ds=#c1#", "4.00%" },
        { 21306, "INV_Misc_Book_02", "=q3=Guide: Serpent Sting IX",                    "=q1=#m1# =ds=#c2#", "4.85%" },
        { 21304, "INV_Misc_Book_02", "=q3=Guide: Multi-Shot V",                        "=q1=#m1# =ds=#c2#", "4.66%" },
        { 21307, "INV_Misc_Book_02", "=q3=Guide: Aspect of the Hawk VII",              "=q1=#m1# =ds=#c2#", "4.65%" },
        { 21279, "INV_Misc_Book_07", "=q3=Tome of Fireball XII",                       "=q1=#m1# =ds=#c3#", "5.15%" },
        { 21214, "INV_Misc_Book_07", "=q3=Tome of Frostbolt XI",                       "=q1=#m1# =ds=#c3#", "5.10%" },
        { 21280, "INV_Misc_Book_07", "=q3=Tome of Arcane Missiles VIII",               "=q1=#m1# =ds=#c3#", "5.03%" },
        { 21288, "INV_Misc_Book_08", "=q3=Libram: Blessing of Wisdom VI",             "=q1=#m1# =ds=#c4#", "3.50%" },
        { 21289, "INV_Misc_Book_08", "=q3=Libram: Blessing of Might VII",             "=q1=#m1#=ds= #c4#", "3.07%" },
        { 21290, "INV_Misc_Book_08", "=q3=Libram: Holy Light IX",                     "=q1=#m1# =ds=#c4#", "3.09%" },
        { 21284, "INV_Misc_Book_09", "=q3=Codex of Greater Heal V",                    "=q1=#m1#=ds= #c5#", "5.15%" },
        { 21287, "INV_Misc_Book_09", "=q3=Codex of Prayer of Healing V",               "=q1=#m1# =ds=#c5#", "4.89%" },
        { 21285, "INV_Misc_Book_09", "=q3=Codex of Renew X",                           "=q1=#m1# =ds=#c5#", "4.91%" },
        { 21300, "INV_Misc_Book_10", "=q3=Handbook of Backstab IX",                    "=q1=#m1# =ds=#c6#", "4.29%" },
        { 21303, "INV_Misc_Book_10", "=q3=Handbook of Feint V",                        "=q1=#m1# =ds=#c6#", "4.79%" },
        { 21302, "INV_Misc_Book_10", "=q3=Handbook of Deadly Poison V",                "=q1=#m1# =ds=#c6#", "5.47%" },
        { 21291, "INV_Misc_StoneTablet_11", "=q3=Tablet of Healing Wave X",            "=q1=#m1#=ds= #c7#", "2.05%" },
        { 21292, "INV_Misc_StoneTablet_11", "=q3=Tablet of Strength of Earth Totem V", "=q1=#m1# =ds=#c7#", "1.67%" },
        { 21293, "INV_Misc_StoneTablet_11", "=q3=Tablet of Grace of Air Totem III",    "=q1=#m1#=ds= #c7#", "1.81%" },
        { 21281, "INV_Misc_Book_06", "=q3=Grimoire of Shadow Bolt X",                 "=q1=#m1# =ds=#c8#", "4.23%" },
        { 21283, "INV_Misc_Book_06", "=q3=Grimoire of Corruption VII",                "=q1=#m1# =ds=#c8#", "3.82%" },
        { 21282, "INV_Misc_Book_06", "=q3=Grimoire of Immolate VIII",                 "=q1=#m1# =ds=#c8#", "4.51%" },
        { 21298, "INV_Misc_Book_03", "=q3=Manual of Battle Shout VII",                "=q1=#m1# =ds=#c9#", "4.84%" },
        { 21299, "INV_Misc_Book_03", "=q3=Manual of Revenge VI",                      "=q1=#m1# =ds=#c9#", "4.78%" },
        { 21297, "INV_Misc_Book_03", "=q3=Manual of Heroic Strike IX",                "=q1=#m1#=ds= #c9#", "4.83%" },
        };

        -------------------------------
        --- The Temple of Ahn'Qiraj ---
        -------------------------------

    AQ40Skeram = {
        { 21708, "INV_Bracer_12", "=q4=Beetle Scaled Wristguards",                 "=ds=#s8#, #a2#", "12.85%" },
        { 21698, "INV_Pants_Leather_11", "=q4=Leggings of Immersion",              "=ds=#s11#, #a2#", " 10.99%" },
        { 21699, "INV_Shoulder_14", "=q4=Barrage Shoulders",                       "=ds=#s3#, #a3#", "11.50%" },
        { 21705, "INV_Boots_Chain_06", "=q4=Boots of the Fallen Prophet",          "=ds=#s12#, #a3#", "3.33%" },
        { 21814, "INV_Chest_Plate02", "=q4=Breastplate of Annihilation",           "=ds=#s5#, #a4#", "11.01%" },
        { 21704, "INV_Boots_Plate_08", "=q4=Boots of the Redeemed Prophecy",       "=ds=#s12#, #a4#", "7.75%" },
        { 21706, "INV_Boots_Plate_06", "=q4=Boots of the Unwavering Will",         "=ds=#s12#, #a4#", "12.23%" },
        { 0,"","","" },
        { 21701, "INV_Misc_Cape_02", "=q4=Cloak of Concentrated Hatred",           "=ds=#s4#", "11.81%" },
        { 21702, "INV_Jewelry_Necklace_12", "=q4=Amulet of Foul Warding",          "=ds=#s2#", "12.20%" },
        { 21700, "INV_Jewelry_Necklace_AhnQiraj_01", "=q4=Pendant of the Qiraji Guardian", "=ds=#s2#", "11.57%" },
        { 21707, "INV_Jewelry_Ring_AhnQiraj_04", "=q4=Ring of Swarming Thought",   "=ds=#s13#", "12.57%" },
        { 21703, "INV_Mace_21", "=q4=Hammer of Ji'zhi",                            "=ds=#h2#, #w6#", "7.14%" },
        { 21128, "INV_Staff_01", "=q4=Staff of the Qiraji Prophets",               "=ds=#w9#", " 6.32%" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "1.74%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "1.32%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        { 0,"","","" },
        { 22222, "INV_Scroll_05", "=q3=Plans: Thick Obsidian Breastplate", "=ds=#p2# (300)", "5.00%" },
        { 22196, "INV_Chest_Chain_17", "=q4=Thick Obsidian Breastplate", "=ds=#s5#, #a4#" },
        };

    AQ40Vem = {
        { 21697, "INV_Misc_Cape_18", "=q4=Cape of the Trinity",           "=ds=#s4# =q2=#m5#" },
        { 21694, "INV_Shoulder_05", "=q4=Ternary Mantle",                 "=ds=#s3#, #a1# =q2=#m5#" },
        { 21696, "INV_Chest_Cloth_22", "=q4=Robes of the Triumvirate",    "=ds=#s5#, #a1# =q2=#m5#" },
        { 21693, "INV_Helmet_06", "=q4=Guise of the Devourer",            "=ds=#s1#, #a2# =q2=#m5#" },
        { 21692, "INV_Belt_18", "=q4=Triad Girdle",                       "=ds=#s10#, #a4# =q2=#m5#" },
        { 21695, "INV_Jewelry_Ring_AhnQiraj_04", "=q4=Angelista's Touch", "=ds=#s13# =q2=#m5#" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia",           "=ds=#m3# =q2=#m5#" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments",         "=ds=#m3# =q2=#m5#" },
        { 0,"","","" },
        { 21680, "INV_Chest_Cloth_45", "=q4=Vest of Swift Execution",        "=ds=#s5#, #a2# =q2=#n115#" },
        { 21603, "INV_Wand_06", "=q4=Wand of Qiraji Nobility",               "=ds=#w12# =q2=#n115#" },
        { 21681, "INV_Jewelry_Ring_AhnQiraj_05", "=q4=Ring of the Devoured", "=ds=#s13# =q2=#n115#" },
        { 21685, "INV_Misc_AhnQirajTrinket_01", "=q4=Petrified Scarab",      "=ds=#s14# =q2=#n115#" },
        { 0,"","","" },
        { 21689, "INV_Gauntlets_23", "=q4=Gloves of Ebru",             "=ds=#s9#, #a2# =q2=#n116#" },
        { 21691, "INV_Gauntlets_11", "=q4=Ooze-ridden Gauntlets",      "=ds=#s9#, #a4# =q2=#n116#" },
        { 21688, "INV_Boots_Plate_01", "=q4=Boots of the Fallen Hero", "=ds=#s12#, #a4# =q2=#n116#" },
        { 21690, "INV_Jewelry_Necklace_20", "=q4=Angelista's Charm",   "=ds=#s2# =q2=#n116#" },
        { 0,"","","" },
        { 21686, "INV_Shoulder_02", "=q4=Mantle of Phrenic Power",      "=ds=#s3#, #a1# =q2=#n117#" },
        { 21682, "INV_Gauntlets_21", "=q4=Bile-Covered Gauntlets",      "=ds=#s9#, #a2# =q2=#n117#" },
        { 21684, "INV_Shoulder_28", "=q4=Mantle of the Desert's Fury",  "=ds=#s3#, #a3# =q2=#n117#" },
        { 21683, "INV_Shoulder_29", "=q4=Mantle of the Desert Crusade", "=ds=#s3#, #a4# =q2=#n117#" },
        { 21687, "INV_Jewelry_Ring_24", "=q4=Ukko's Ring of Darkness",  "=ds=#s13# =q2=#n117#" },
        };

    AQ40Sartura = {
        { 21671, "INV_Chest_Cloth_26", "=q4=Robes of the Battleguard",           "=ds=#s5#, #a1#", "13.30%" },
        { 21676, "INV_Pants_Cloth_02", "=q4=Leggings of the Festering Swarm",    "=ds=#s11#, #a1#", "13.02%" },
        { 21648, "INV_Boots_Cloth_07", "=q4=Recomposed Boots",                   "=ds=#s12#, #a1#", "7.64%" },
        { 21669, "INV_Helmet_01", "=q4=Creeping Vine Helm",                      "=ds=#s1#, #a2#", "12.33%" },
        { 21672, "INV_Gauntlets_17", "=q4=Gloves of Enforcement",                "=ds=#s9#, #a2#", "11.87%" },
        { 21675, "INV_Belt_15", "=q4=Thick Qirajihide Belt",                     "=ds=#s10#, #a2#", "13.26%" },
        { 21668, "INV_Pants_Mail_15", "=q4=Scaled Leggings of Qiraji Fury",      "=ds=#s11#, #a3#", "4.03%" },
        { 21674, "INV_Gauntlets_31", "=q4=Gauntlets of Steadfast Determination", "=ds=#s9#, #a4#", "11.07%" },
        { 21667, "INV_Pants_Plate_11", "=q4=Legplates of Blazing Light",         "=ds=#s11#, #a4#", "7.44%" },
        { 21678, "INV_Jewelry_Necklace_AhnQiraj_04", "=q4=Necklace of Purity",   "=ds=#s2#", "14.21%" },
        { 21670, "INV_Misc_AhnQirajTrinket_04", "=q4=Badge of the Swarmguard",   "=ds=#s14#", "13.22%" },
        { 21666, "INV_QirajIdol_War", "=q4=Sartura's Might",                     "=ds=#s15#", "6.47%" },
        { 21673, "INV_Misc_MonsterClaw_03", "=q4=Silithid Claw",                 "=ds=#h3#, #w13#", "7.16%" },
        { 0,"","","" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "4.01%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#            ", "4.02%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        };

    AQ40Fankriss = {
        { 21627, "INV_Misc_Cape_20", "=q4=Cloak of Untold Secrets",              "=ds=#s4#", "12.51%" },
        { 21663, "INV_Chest_Cloth_23", "=q4=Robes of the Guardian Saint",        "=ds=#s5#, #a1#", "12.95%" },
        { 21665, "INV_Shoulder_30", "=q4=Mantle of Wicked Revenge",              "=ds=#s3#, #a2#", "13.25%" },
        { 21645, "INV_Boots_04", "=q4=Hive Tunneler's Boots",                    "=ds=#s12#, #a2#", "14.04%" },
        { 21651, "INV_Pants_Mail_10", "=q4=Scaled Sand Reaver Leggings",         "=ds=#s11#, #a3#", "12.91%" },
        { 21639, "INV_Shoulder_29", "=q4=Pauldrons of the Unrelenting",          "=ds=#s3#, #a4#", " 14.78%" },
        { 21652, "INV_Chest_Plate09", "=q4=Silithid Carapace Chestguard",        "=ds=#s5#, #a4#", "10.29%" },
        { 21650, "INV_Sword_59", "=q4=Ancient Qiraji Ripper",                    "=ds=#h1#, #w10#", " 7.19%" },
        { 21635, "INV_Weapon_Halberd_AhnQiraj", "=q4=Barb of the Sand Reaver",   "=ds=#w7#", "6.61%" },
        { 0,"","","" },
        { 21647, "INV_Misc_AhnQirajTrinket_03", "=q4=Fetish of the Sand Reaver", "=ds=#s14#", " 13.82%" },
        { 21664, "INV_Jewelry_Necklace_AhnQiraj_02", "=q4=Barbed Choker",        "=ds=#s2#", "12.63%" },
        { 22402, "INV_Relics_LibramofGrace", "=q4=Libram of Grace",              "=ds=#s16#, #w16#", " 4.21%" },
        { 22396, "INV_Relics_TotemofLife", "=q4=Totem of Life",                  "=ds=#s16#, #w15#", " 1.69%" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "4.84%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "4.09%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        };

    AQ40Viscidus = {
        { 21624, "INV_Gauntlets_26", "=q4=Gauntlets of Kalimdor",               "=ds=#s9#, #a3#", "3.90%" },
        { 21626, "INV_Pants_Mail_11", "=q4=Slime-coated Leggings",              "=ds=#s11#, #a3#", "13.66%" },
        { 21623, "INV_Gauntlets_26", "=q4=Gauntlets of the Righteous Champion", "=ds=#s9#, #a4#", "5.37%" },
        { 21622, "INV_Sword_58", "=q4=Sharpened Silithid Femur",                "=ds=#h3#, #w10#", " 15.12%" },
        { 0,"","","" },
        { 21677, "INV_jewelry_ring_AhnQiraj_01", "=q4=Ring of the Qiraji Fury", "=ds=#s13#", "2.93%" },
        { 21625, "INV_Misc_AhnQirajTrinket_06", "=q4=Scarab Brooch",            "=ds=#s14#", "21.46%" },
        { 22399, "INV_Relics_IdolofHealth", "=q4=Idol of Health",               "=ds=#s16#, #w14#", "7.32%" },
        { 0,"","","" },
        { 20932, "INV_Qiraj_BindingsDominance", "=q4=Qiraji Bindings of Dominance", "=q1=#m1# =ds=#c8#, #c3#, #c7#, #c1#, #c4#", "100%" },
        { 20928, "INV_Qiraj_BindingsCommand", "=q4=Qiraji Bindings of Command", "=q1=#m1# =ds=#c5#, #c6#, #c9#, #c2#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "3.19%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "6.86%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#,#w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        };

    AQ40Huhuran = {
        { 21619, "INV_Gauntlets_17", "=q4=Gloves of the Messiah",          "=ds=#s9#, #a1#", "12.01%" },
        { 21621, "INV_Misc_Cape_01", "=q4=Cloak of the Golden Hive",       "=ds=#s4#", "12.56%" },
        { 21617, "INV_Gauntlets_17", "=q4=Wasphide Gauntlets",             "=ds=#s9#, #a2#", "11.97%" },
        { 21618, "INV_Bracer_02", "=q4=Hive Defiler Wristguards",          "=ds=#s8#, #a4#", "10.34%" },
        { 21616, "INV_Weapon_Bow_14", "=q4=Huhuran's Stinger",             "=ds=#w2#", "5.71%" },
        { 0,"","","" },
        { 21620, "INV_Jewelry_Ring_AhnQiraj_01", "=q4=Ring of the Martyr", "=ds=#s13#", "12.97%" },
        { 0,"","","" },
        { 20932, "INV_Qiraj_BindingsDominance", "=q4=Qiraji Bindings of Dominance", "=q1=#m1# =ds=#c8#, #c3#, #c7#, #c1#, #c4#", "100%" },
        { 20928, "INV_Qiraj_BindingsCommand", "=q4=Qiraji Bindings of Command", "=q1=#m1# =ds=#c5#, #c6#, #c9#, #c2#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "4.31%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "4.11%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        };

    AQ40Emperors = {
        { 20930, "INV_Bracer_18", "=q4=Vek'lor's Diadem", "=q1=#m1# =ds=#c7#, #c1#, #c6#, #c2#, #c4#", "100%" },
        { 21600, "INV_Boots_Cloth_05", "=q4=Boots of Epiphany",                 "=ds=#s12#, #a1#", "15.77%" },
        { 21602, "INV_Bracer_13", "=q4=Qiraji Execution Bracers",               "=ds=#s8#, #a2#",  "15.95%" },
        { 21599, "INV_Gauntlets_28", "=q4=Vek'lor's Gloves of Devastation",     "=ds=#s9#, #a3#",  "15.77%" },
        { 21598, "INV_Belt_31", "=q4=Royal Qiraji Belt",                        "=ds=#s10#, #a4#",  " 9.84%" },
        { 21597, "INV_Wand_10", "=q4=Royal Scepter of Vek'lor",                 "=ds=#s15#",  " 6.99%" },
        { 21601, "INV_jewelry_ring_AhnQiraj_01", "=q4=Ring of Emperor Vek'lor", "=ds=#s13#",  "17.27%" },
        { 20735, "INV_Misc_Note_01", "=q3=Formula: Enchant Cloak - Subtlety", "=ds=#p4# (300)", "6.62%" },
        { 0,"","","" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "6.25%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#" },
        { 20926, "INV_Bracer_18", "=q4=Vek'nilash's Circlet", "=q1=#m1# =ds=#c8#, #c3#, #c5#, #c9#", "100%" },
        { 21604, "INV_Bracer_13", "=q4=Bracelets of Royal Redemption",           "=ds=#s8#, #a1#", "12.51%" },
        { 21605, "INV_Gauntlets_19", "=q4=Gloves of the Hidden Temple",          "=ds=#s9#, #a2#",   "15.45%" },
        { 21609, "INV_Belt_11", "=q4=Regenerating Belt of Vek'nilash",           "=ds=#s10#, #a2#",  "13.35%" },
        { 21607, "INV_Belt_32", "=q4=Grasp of the Fallen Emperor",               "=ds=#s10#, #a3#",   "2.72%" },
        { 21606, "INV_Belt_34", "=q4=Belt of the Fallen Emperor",                "=ds=#s10#, #a4#",  "12.22%" },
        { 21679, "INV_Sword_56", "=q4=Kalimdor's Revenge",                       "=ds=#h2#, #w10#",   " 9.25%" },
        { 21608, "INV_Jewelry_Necklace_AhnQiraj_01", "=q4=Amulet of Vek'nilash", "=ds=#s2#",  "14.25%" },
        { 20726, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Threat", "=ds=#p4# (300)", "6.24%" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "5.00%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#" },
        };

    AQ40Ouro = {
        { 21615, "INV_Helmet_51", "=q4=Don Rigoberto's Lost Hat", "=ds=#s1#, #a1#", "28.63%" },
        { 21611, "INV_Bracer_13", "=q4=Burrower Bracers", "=ds=#s8#, #a1#", "24.44%" },
        { 23557, "INV_Weapon_Rifle_10", "=q4=Larvae of the Great Worm", "=ds=#w5#", "3.95%" },
        { 21610, "INV_Shield_24", "=q4=Wormscale Blocker", "=ds=#w8#", "16.54%" },
        { 23558, "INV_Shield_23","=q4=The Burrower's Shell", "=ds=#s14#", "2.90%" },
        { 23570, "INV_Misc_EngGizmos_19", "=q4=Jom Gabbar", "=ds=#s14#", "2.80%" },
        { 0,"","","" },
        { 20927, "INV_Qiraj_OuroHide", "=q4=Ouro's Intact Hide", "=q1=#m1# =ds=#c3#, #c5#, #c6#, #c9#", "100%" },
        { 20931, "INV_Qiraj_SkinSandworm", "=q4=Skin of the Great Sandworm", "=q1=#m1# =ds=#c8#, #c7#, #c1#, #c2#, #c4#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 21237, "INV_Staff_20", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "5.20%" },
        { 21273, "INV_Staff_20", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4# =ds=#w9#" },
        { 21275, "INV_Staff_20", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4# =ds=#w9#" },
        { 21268, "INV_Mace_24", "=q4=Blessed Qiraji War Hammer", "=q1=#m4# =ds=#h1#, #w6#" },
        { 0,"","","" },
        { 21232, "INV_Staff_24", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "4.10%" },
        { 21242, "INV_Axe_26", "=q4=Blessed Qiraji War Axe", "=q1=#m4# =ds=#h1#, #w1#" },
        { 21272, "INV_Weapon_Rifle_11", "=q4=Blessed Qiraji Musket", "=q1=#m4# =ds=#w5#" },
        { 21244, "INV_Weapon_Shortblade_35", "=q4=Blessed Qiraji Pugio", "=q1=#m4# =ds=#h1#, #w4#" },
        { 21269, "INV_Shield_23", "=q4=Blessed Qiraji Bulwark", "=q1=#m4# =ds=#w8#" },
        };

    AQ40CThun = {
        { 21583, "INV_Misc_Cape_02", "=q4=Cloak of Clarity",          "=ds=#s4#", "14.45%" },
        { 22731, "INV_Misc_Cape_18", "=q4=Cloak of the Devoured",     "=ds=#s4#", "16.34%" },
        { 21585, "INV_Gauntlets_17", "=q4=Dark Storm Gauntlets",      "=ds=#s9#, #a1#", "13.63%" },
        { 22730, "INV_Belt_12", "=q4=Eyestalk Waist Cord",            "=ds=#s10#, #a1#", "10.41%" },
        { 21582, "INV_Belt_31", "=q4=Grasp of the Old God",           "=ds=#s10#, #a1#", "15.04%" },
        { 21586, "INV_Belt_26", "=q4=Belt of Never-ending Agony",     "=ds=#s10#, #a2#", "11.24%" },
        { 21581, "INV_Gauntlets_31", "=q4=Gauntlets of Annihilation", "=ds=#s9#, #a4#", "12.04%" },
        { 21126, "INV_Weapon_Shortblade_33", "=q4=Death's Sting",     "=ds=#h1#, #w4#", "6.84%" },
        { 21134, "INV_Axe_24", "=q4=Dark Edge of Insanity",           "=ds=#h2#, #w1#", "5.93%" },
        { 21839, "INV_Mace22", "=q4=Scepter of the False Prophet",    "=ds=#h3#, #w6#", "4.75%" },
        { 22732, "INV_Jewelry_Necklace_AhnQiraj_04", "=q4=Mark of C'Thun", "=ds=#s2#", "10.62%" },
        { 21596, "INV_Jewelry_Ring_AhnQiraj_06", "=q4=Ring of the Godslayer", "=ds=#s13#", "11.83%" },
        { 21579, "INV_Misc_AhnQirajTrinket_05", "=q4=Vanquished Tentacle of C'Thun", "=ds=#s14#", "12.18%" },
        { 0,"","","" },
        { 0,"","","" },
        { 20933, "INV_Qiraj_HuskOldGod", "=q4=Husk of the Old God", "=q1=#m1# =ds=#c8#, #c3#, #c1#, #c5#", "100%" },
        { 20929, "INV_Qiraj_CarapaceOldGod", "=q4=Carapace of the Old God", "=q1=#m1# =ds=#c7#, #c6#, #c9#, #c2#, #c4#", "100%" },
        { 0,"","","" },
        { 21221, "Spell_Shadow_DetectInvisibility", "=q4=Eye of C'Thun", "=ds=#m2#", "100%" },
        { 21710, "INV_Misc_Cape_10", "=q4=Cloak of the Fallen God",                  "=q1=#m4#: =ds=#s4#" },
        { 21712, "INV_Jewelry_Necklace_AhnQiraj_02", "=q4=Amulet of the Fallen God", "=q1=#m4#: =ds=#s2#" },
        { 21709, "INV_Jewelry_Ring_AhnQiraj_02", "=q4=Ring of the Fallen God",       "=q1=#m4#: =ds=#s13#" },
        { 0,"","","" },
        { 22734, "INV_QirajIdol_Sun", "=q1=Base of Atiesh", "=ds=#m3#" },
        { 22632, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c1#"},
        { 22589, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c3#"},
        { 22631, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c5#"},
        { 22630, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c8#"},
        };

    AQ40Trash1 = {
        { 21838, "INV_Chest_Cloth_48", "=q4=Garb of Royal Ascension",       "=ds=#s5#, #a1#", "0.20%" },
        { 21888, "INV_Gauntlets_14", "=q4=Gloves of the Immortal",          "=ds=#s9#, #a1#", "0.16%" },
        { 21889, "INV_Gauntlets_19", "=q4=Gloves of the Redeemed Prophecy", "=ds=#s9#, #a4# =q1=#m1# =ds=#c4#", "0.39%" },
        { 21856, "INV_Axe_09", "=q4=Neretzek, The Blood Drinker",           "=ds=#h2#, #w1#", "0.20%" },
        { 21837, "INV_Hammer_11", "=q4=Anubisath Warhammer",                "=ds=#h1#, #w6#", "0.21%" },
        { 21836, "INV_Jewelry_Ring_34", "=q4=Ritssyn's Ring of Chaos",      "=ds=#s13#", "0.18%" },
        { 21891, "INV_Misc_AhnQirajTrinket_04", "=q4=Shard of the Fallen Star", "=ds=#s14#", "0.59%" },
        { 0,"","","" },
        { 22202, "INV_Misc_StoneTablet_01", "=q1=Small Obsidian Shard", "=ds=#e8#" },
        { 22203, "INV_Stone_15", "=q1=Large Obsidian Shard", "=ds=#e8#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 21218, "INV_Misc_QirajiCrystal_04", "=q3=Blue Qiraji Resonating Crystal",   "=ds=#e12#", "10.64%" },
        { 21324, "INV_Misc_QirajiCrystal_01", "=q3=Yellow Qiraji Resonating Crystal", "=ds=#e12#", "12.15%" },
        { 21323, "INV_Misc_QirajiCrystal_03", "=q3=Green Qiraji Resonating Crystal",  "=ds=#e12#", "11.62%" },
        { 21321, "INV_Misc_QirajiCrystal_02", "=q3=Red Qiraji Resonating Crystal",    "=ds=#e12#", "1.39%" },
        };

    AQ40Trash2 = {
        { 20876, "INV_QirajIdol_Death", "=q3=Idol of Death", "=ds=#e15#", "0.26%" },
        { 20879, "INV_QirajIdol_Life", "=q3=Idol of Life", "=ds=#e15#", "0.29%" },
        { 20875, "INV_QirajIdol_Night", "=q3=Idol of Night", "=ds=#e15#", "0.29%" },
        { 20878, "INV_QirajIdol_Rebirth", "=q3=Idol of Rebirth", "=ds=#e15#", "0.28%" },
        { 20881, "INV_QirajIdol_Strife", "=q3=Idol of Strife", "=ds=#e15#", "0.21%" },
        { 20877, "INV_QirajIdol_Sage", "=q3=Idol of the Sage", "=ds=#e15#", "0.33%" },
        { 20874, "INV_QirajIdol_Sun", "=q3=Idol of the Sun", "=ds=#e15#", "0.21%" },
        { 20882, "INV_QirajIdol_War", "=q3=Idol of War", "=ds=#e15#", "0.30%" },
        { 0,"","","" },
        { 21230, "INV_Misc_Idol_03", "=q1=Ancient Qiraji Artifact", "=ds=#m2#" },
        { 0,"","","" },
        { 21762, "INV_Misc_Key_08", "=q1=Greater Scarab Coffer Key", "=ds=#e9#", "7.03%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 20864, "INV_Scarab_bone", "=q2=Bone Scarab", "=ds=#e15#", "0.84%" },
        { 20861, "INV_Scarab_bronze", "=q2=Bronze Scarab", "=ds=#e15#", "0.88%" },
        { 20863, "INV_Scarab_clay", "=q2=Clay Scarab", "=ds=#e15#", "0.95%" },
        { 20862, "INV_Scarab_crystal", "=q2=Crystal Scarab", "=ds=#e15#", "0.99%" },
        { 20859, "INV_Scarab_gold", "=q2=Gold Scarab", "=ds=#e15#", "0.96%" },
        { 20865, "INV_Scarab_ivory", "=q2=Ivory Scarab", "=ds=#e15#", "0.93%" },
        { 20860, "INV_Scarab_silver", "=q2=Silver Scarab", "=ds=#e15#", "1.82%" },
        { 20858, "INV_Scarab_stone", "=q2=Stone Scarab", "=ds=#e15#", "0.86%" },
        };

        -------------------
        --- AQ Enchants ---
        -------------------

    AQEnchants = {
        { 20728, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Frost Power", "=ds=#p4# (300)" },
        { 20731, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Superior Agility", "=ds=#p4# (300)" },
        { 20734, "INV_Misc_Note_01", "=q3=Formula: Enchant Cloak - Stealth", "=ds=#p4# (300)" },
        { 20729, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Fire Power", "=ds=#p4# (300)" },
        { 20736, "INV_Misc_Note_01", "=q3=Formula: Enchant Cloak - Dodge", "=ds=#p4# (300)" },
        { 20730, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Healing Power", "=ds=#p4# (300)" },
        { 20727, "INV_Misc_Note_01", "=q3=Formula: Enchant Gloves - Shadow Power", "=ds=#p4# (300)" },
        };

    AQOpening = {
        { 21138, "INV_Misc_Gem_Ruby_03", "=q1=Red Scepter Shard", "=ds=#m3#" },
        { 21530, "INV_Pants_Mail_04", "=q4=Onyx Embedded Leggings", "=ds=#s11#, #a3#" },
        { 21529, "INV_Jewelry_Necklace_17", "=q4=Amulet of Shadow Shielding", "=ds=#s2#" },
        { 0,"","","" },
        { 21139, "INV_Misc_Gem_Emerald_03", "=q1=Green Scepter Shard", "=ds=#m3#" },
        { 21532, "INV_Boots_08", "=q4=Drudge Boots", "=ds=#s12#, #a2#" },
        { 21531, "INV_Jewelry_Necklace_22", "=q4=Drake Tooth Necklace", "=ds=#s2#" },
        { 0,"","","" },
        { 21137, "INV_Misc_Gem_Sapphire_03", "=q1=Blue Scepter Shard", "=ds=#m3#" },
        { 21517, "INV_Helmet_63", "=q4=Gnomish Turban of Psychic Might", "=ds=#s1#, #a1#" },
        { 21527, "INV_Chest_Cloth_31", "=q4=Darkwater Robes", "=ds=#s5#, #a1#" },
        { 21526, "INV_Jewelry_Ring_35", "=q4=Band of Icy Depths", "=ds=#s13#" },
        { 21025, "INV_Misc_Book_02", "=q4=Recipe: Dirge's Kickin' Chimaerok Chops", "=ds=#p3# (300)" },
        { 0,"","","" },
        { 0,"","","" },
        { 21175, "INV_Hammer_25", "=q1=The Scepter of the Shifting Sands", "=ds=#m3#" },
        { 21176, "INV_Misc_QirajiCrystal_05", "=q5=Black Qiraji Resonating Crystal", "=ds=#e12#" },
        { 21522, "INV_Weapon_ShortBlade_25", "=q4=Shadowsong's Sorrow", "=ds=#h1#, #w4#" },
        { 21523, "INV_Weapon_Shortblade_29", "=q4=Fang of Korialstrasz", "=ds=#h3#, #w4#" },
        { 21520, "INV_Sword_49", "=q4=Ravencrest's Legacy", "=ds=#h1#, #w10#" },
        { 21521, "INV_Sword_51", "=q4=Runesword of the Red", "=ds=#h3#, #w10#" },
        };

        ------------------
        --- Gnomeregan ---
        ------------------

    GnNamdoBizzfizzle = {
        { 14639, "INV_Scroll_03", "=q1=Schematic: Minor Recombobulator", "=ds=#p5# (140)" },
        };

    GnTechbot = {
        { 9444, "INV_Shield_09", "=q1=Techbot CPU Shell", "=ds=#w8#", "69.3%" },
        { 0,"","","" },
        { 9277, "INV_Battery_01", "=q1=Techbot's Memory Core", "=ds=#m3#", "100%" },
        };

    GnGrubbis = {
        { 9445, "INV_Gauntlets_17", "=q3=Grubbis Paws", "=ds=#s9#, #a3#", "9.22%" },
        };

    GnViscousFallout = {
        { 9454, "INV_Boots_05", "=q3=Acidic Walkers", "=ds=#s12#, #a1#", "54.02%" },
        { 9453, "INV_Weapon_ShortBlade_02", "=q3=Toxic Revenger", "=ds=#h1#, #w4#", "19.05%" },
        { 9452, "INV_Staff_15", "=q3=Hydrocane",                  "=ds=#w9#", "18.25%" },
        };

    GnElectrocutioner6000 = {
        { 9448, "INV_Misc_Bandage_09", "=q3=Spidertank Oilrag",   "=ds=#s8#, #a1#", "28.37%" },
        { 9447, "INV_Misc_Gear_04", "=q3=Electrocutioner Lagnut", "=ds=#s13#", "28.44%" },
        { 9446, "INV_Sword_30", "=q3=Electrocutioner Leg",        "=ds=#h3#, #w10#", "13.19%" },
        { 0,"","","" },
        { 6893, "INV_Misc_Key_06", "=q1=Workshop Key", "=ds=#e9#" },
        };

    GnCrowdPummeler960 = {
        { 9450, "INV_Boots_03", "=q3=Gnomebot Operating Boots", "=ds=#s12#, #a2#", "60.45%" },
        { 9449, "INV_Mace_14", "=q3=Manual Crowd Pummeler",     "=ds=#h2#, #w6#", "33.14%" },
        };

    GnDIAmbassador = {
        { 9455, "INV_Bracer_09", "=q3=Emissary Cuffs",    "=ds=#s8#, #a2#", "33.96%" },
        { 9457, "INV_Mace_08", "=q3=Royal Diplomatic Scepter", "=ds=#h1#, #w6#", "17.79%" },
        { 9456, "INV_Weapon_Rifle_02", "=q3=Glass Shooter",    "=ds=#w5#", "38.01%" },
        };

    GnMekgineerThermaplugg = {
        { 9492, "INV_Gizmo_01", "=q3=Electromagnetic Gigaflux Reactivator", "=ds=#s1#, #a1#", "7.65%" },
        { 9461, "INV_Misc_Gear_01", "=q3=Charged Gear", "=ds=#s13#", "28.49%" },
        { 9459, "INV_Axe_03", "=q3=Thermaplugg's Left Arm", "=ds=#h2#, #w1#", "18.05%" },
        { 9458, "INV_Shield_10", "=q3=Thermaplugg's Central Core", "=ds=#w8#", "28.61%" },
        { 0,"","","" },
        { 9299, "INV_Misc_Note_05", "=q1=Thermaplugg's Safe Combination", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 4415,"INV_Scroll_03","=q3=Schematic: Craftsman's Monocle","=ds=#p5# (185)", "" },
        { 4413,"INV_Scroll_06","=q2=Schematic: Discombobulator Ray","=ds=#p5# (160)", "" },
        { 4411,"INV_Scroll_03","=q2=Schematic: Flame Deflector","=ds=#p5# (125)", "0.7%" },
        { 7742,"INV_Scroll_03","=q1=Schematic: Gnomish Cloaking Device","=ds=#p5# (200)", "" },
        };

    GnTrash = {
        { 9508, "INV_Shirt_14", "=q3=Mechbuilder's Overalls", "=ds=#s5#, #a1#", "0.02%" },
        { 9491, "INV_Gauntlets_16", "=q3=Hotshot Pilot's Gloves", "=ds=#s9#, #a1#", "0.01%" },
        { 9509, "INV_Pants_08", "=q3=Petrolspill Leggings", "=ds=#s11#, #a2#", "0.01%" },
        { 9510, "INV_Boots_01", "=q3=Caverndeep Trudgers", "=ds=#s12#, #a3#", "0.01%" },
        { 0,"","","" },
        { 9327, "INV_Ingot_04", "=q2=Security DELTA Data Access Card", "=ds=#m20#", "1.41%" },
        { 0,"","","" },
        { 9326, "INV_Stone_04", "=q1=Grime-Encrusted Ring", "=ds=#m2#", "9.38%" },
        { 9362, "INV_Jewelry_Ring_03", "=q2=Brilliant Gold Ring", "=q1=#m4#: =ds=#s13#, =q1=#m3#" },
        { 9538, "INV_Jewelry_Ring_03", "=q3=Talvash's Gold Ring", "=q1=#m4#: =ds=#s13#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 9490, "INV_Sword_37", "=q3=Gizmotron Megachopper", "=ds=#h2#, #w10#", "0.01%" },
        { 9485, "INV_Axe_14", "=q3=Vibroblade", "=ds=#h1#, #w1#", "0.01%" },
        { 9486, "INV_Axe_21", "=q3=Supercharger Battle Axe", "=ds=#h2#, #w1#", "0.02%" },
        { 9488, "INV_Hammer_08", "=q3=Oscillating Power Hammer", "=ds=#h1#, #w6#", "0.02%" },
        { 9487, "INV_Weapon_Rifle_06", "=q3=Hi-tech Supergun", "=ds=#w5#", "0.01%" },
        };

        --------------------
        --- The Stockade ---
        --------------------

    SWStTargor = {
        { 3630, "INV_Misc_Head_Orc_01", "=q1=Head of Targorr", "=ds=#m3#", "100%" },
        };

    SWStKamDeepfury = {
        { 2280, "INV_Staff_06", "=q3=Kam's Walking Stick", "=ds=#w9#", "0.62%" },
        { 0,"","","" },
        { 3640, "INV_Misc_Head_Dwarf_01", "=q1=Head of Deepfury", "=ds=#m3#", "100%" },
        };

    SWStBazilThredd = {
        { 2926, "INV_Misc_Head_Human_01", "=q1=Head of Bazil Thredd", "=ds=#m3#", "100%" },
        };

    SWStDextrenWard = {
        { 3628, "INV_Gauntlets_09", "=q1=Hand of Dextren Ward", "=ds=#m3#", "100%" },
        };

    SWStBruegalIronknuckle = {
        { 3228, "INV_Bracer_02", "=q3=Jimmied Handcuffs",       "=ds=#s8#, #a3#", "54.73%" },
        { 2942, "INV_Gauntlets_04", "=q3=Iron Knuckles",        "=ds=#h1#, #w13#", "18.18%" },
        { 2941, "INV_Weapon_ShortBlade_18", "=q3=Prison Shank", "=ds=#h1#, #w4#", "16.05%" },
        };

    SWStTrash = {
        { 2909, "INV_Misc_Bandana_03", "=q1=Red Wool Bandana", "=ds=#m3#" },
        };

        -------------------------
        --- Blackfathom Deeps ---
        -------------------------

    BFDGhamoora = {
        { 6908, "INV_Belt_24", "=q3=Ghamoo-ra's Bind", "=ds=#s10#, #a1#", "45.81%" },
        { 6907, "INV_Shirt_06", "=q3=Tortoise Armor",  "=ds=#s5#, #a3#", "30.59%" },
        };

    BFDQuestItems = {
        { 5359, "INV_Misc_Note_01", "=q1=Lorgalis Manuscript",  "=ds=#m3#", "100%" },
        { 16762, "INV_Misc_StoneTablet_08", "=q1=Fathom Core",  "=ds=#m3#", "100%" },
        };

    BFDLadySarevess = {
        { 888, "INV_Gauntlets_13", "=q3=Naga Battle Gloves",  "=ds=#s9#, #a2#", "33.72%" },
        { 11121, "INV_Sword_36", "=q3=Darkwater Talwar",      "=ds=#h3#, #w10#", "33.10%" },
        { 3078, "INV_Weapon_Bow_04", "=q3=Naga Heartpiercer", "=ds=#w2#", "16.87%" },
        };

    BFDGelihast = {
        { 6906, "INV_Gauntlets_10", "=q3=Algae Fists",   "=ds=#s9#, #a3#", "38.24%" },
        { 6905, "INV_Weapon_Halberd_06", "=q3=Reef Axe", "=ds=#h2#, #w1#", "42.29%" },
        { 0,"","","" },
        { 1470, "INV_Misc_Bag_05", "=q1=Murloc Skin Bag", "=ds=#m12# #e1#", "14.13%" },
        };

    BFDBaronAquanis = {
        { 16782, "Spell_Shadow_Teleport", "=q2=Strange Water Globe", "=ds=#m2# (#m6#)", "90.35%" },
        { 16886, "INV_Sword_33", "=q3=Outlaw Sabre", "=q1=#m4#: =ds=#h1#, #w10#" },
        { 16887, "INV_Wand_12", "=q3=Witch's Finger", "=q1=#m4#: =ds=#s15#" },
        };

    BFDTwilightLordKelris = {
        { 6903, "INV_Pants_02", "=q3=Gaze Dreamer Pants",     "=ds=#s11#, #a1#", "31.90%" },
        { 1155, "INV_Staff_06", "=q3=Rod of the Sleepwalker", "=ds=#w9#", "45.59%" },
        { 0,"","","" },
        { 5881, "INV_Misc_Head_Orc_01", "=q1=Head of Kelris", "=ds=#m3#", "100%" },
        };

    BFDOldSerrakis = {
        { 6901, "INV_Misc_MonsterScales_03", "=q3=Glowing Thresher Cape", "=ds=#s4#", "36.14%" },
        { 6902, "INV_Bracer_08", "=q3=Bands of Serra'kis", "=ds=#s8#, #a2#", "29.24%" },
        { 6904, "INV_Misc_MonsterFang_01", "=q3=Bite of Serra'kis", "=ds=#h1#, #w4#", "15.34%" },
        };

    BFDAkumai = {
        { 6910, "INV_Pants_14", "=q3=Leech Pants",         "=ds=#s11#, #a1#", "29.72%" },
        { 6911, "INV_Belt_25", "=q3=Moss Cinch",           "=ds=#s10#, #a2#", "29.01%" },
        { 6909, "INV_Sword_42", "=q3=Strike of the Hydra", "=ds=#h2#, #w10#", "14.46%" },
        };

    BFDTrash = {
        { 1486, "INV_Shirt_02", "=q3=Tree Bark Jacket", "=ds=#s5#, #a1#", "0.02%" },
        { 3416, "INV_Chest_Chain", "=q3=Martyr's Chain", "=ds=#s5#, #a3#", "0.01%" },
        { 1491, "INV_Jewelry_Ring_14", "=q3=Ring of Precision", "=ds=#s13#", "0.01%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 2567, "INV_Weapon_ShortBlade_15", "=q3=Evocator's Blade", "=ds=#h1#, #w4#", "0.02%" },
        { 3413, "INV_Sword_29", "=q3=Doomspike", "=ds=#h1#, #w4#", "0.01%" },
        { 3417, "INV_Sword_13", "=q3=Onyx Claymore", "=ds=#h2#, #w10#", "0.01%" },
        { 1454, "INV_Axe_21", "=q3=Axe of the Enforcer", "=ds=#h1#, #w1#", "0.01%" },
        { 1481, "INV_Axe_13", "=q3=Grimclaw", "=ds=#h1#, #w1#", "0.01%" },
        { 3414, "INV_Mace_08", "=q3=Crested Scepter", "=ds=#h3#, #w6#", "0.01%" },
        { 3415, "INV_Staff_32", "=q3=Staff of the Friar", "=ds=#w9#", "0.02%" },
        { 2271, "INV_Staff_31", "=q3=Staff of the Blessed Seer", "=ds=#w9#", "0.02%" },
        };

        -----------------------
        --- Wailing Caverns ---
        -----------------------

    WCKalldanFelmoon = {
        { 6475, "INV_Scroll_03", "=q1=Pattern: Deviate Scale Gloves", "=ds=#p7# (105)" },
        { 6474, "INV_Scroll_03", "=q1=Pattern: Deviate Scale Cloak", "=ds=#p7# (90)" },
        };

    WCMadMagglish = {
        { 5334, "INV_Drink_10", "=q1=99-Year-Old Port", "=ds=#m3#", "100%" },
        };

    WCTrigoretheLasher = {
        { 5425, "INV_Belt_03", "=q3=Runescale Girdle", "=ds=#s8#, #a3#", "50%" },
        { 5426, "INV_Axe_23", "=q3=Serpent's Kiss", "=ds=#h1#, #w1#", "35%" },
        };

    WCBoahn = {
        { 5423, "INV_Axe_17", "=q3=Boahn's Fang", "=ds=#h2#, #w1#", "28%" },
        { 0,"","","" },
        { 5422, "INV_Pants_02", "=q2=Brambleweed Leggings", "=ds=#s11#, #a2#", "64%" },
        };

    WCLordCobrahn = {
        { 6465, "INV_Chest_Cloth_36", "=q3=Robe of the Moccasin", "=ds=#s5#, #a1#", "51.73%" },
        { 10410, "INV_Pants_11", "=q3=Leggings of the Fang", "=ds=#s11#, #a2#", "16.03%" },
        { 6460, "INV_Belt_03", "=q3=Cobrahn's Grasp", "=ds=#s10#, #a3#", "16.20%" },
        };

    WCLadyAnacondra = {
        { 5404, "INV_Shoulder_08", "=q3=Serpent's Shoulders", "=ds=#s3#, #a2#", "58.61%" },	
        { 10412, "INV_Belt_30", "=q3=Belt of the Fang",       "=ds=#s10#, #a2#", "8.63%" },
        { 6446, "INV_Misc_Bag_12", "=q3=Snakeskin Bag",       "=ds=#m12# #e1#", "6.61%" },
        };

    WCKresh = {
        { 13245, "INV_Shield_18", "=q3=Kresh's Back",            "=ds=#w8#", "9.17%" },
        { 6447, "INV_Shield_21", "=q3=Worn Turtle Shell Shield", "=ds=#w8#", "63.66%" },
        };

    WCLordPythas = {
        { 6473, "INV_Shirt_16", "=q3=Armor of the Fang", "=ds=#s5#, #a2#", "52.06%" },
        { 6472, "INV_Wand_10", "=q3=Stinging Viper",     "=ds=#h1#, #w6#", "28.24%" },
        };

    WCSkum = {
        { 6449, "INV_Chest_Cloth_15", "=q3=Glowing Lizardscale Cloak", "=ds=#s4#", "38.24%" },
        { 6448, "INV_Weapon_ShortBlade_10", "=q3=Tail Spike", "=ds=#h1#, #w4#", "39.24%" },
        };

    WCLordSerpentis = {
        { 5970, "INV_Gauntlets_19", "=q3=Serpent Gloves",    "=ds=#s9#, #a1#", "20.96%" },
        { 10411, "INV_Boots_04", "=q3=Footpads of the Fang", "=ds=#s12#, #a2#", "19.07%" },
        { 6459, "INV_Boots_01", "=q3=Savage Trodders",       "=ds=#s12#, #a3#", "24.39%" },
        { 6469, "INV_Weapon_Bow_10", "=q3=Venomstrike",      "=ds=#w2#", "16.63%" },
        };

    WCVerdan = {
        { 6629, "INV_Misc_Cape_17", "=q3=Sporid Cape",    "=ds=#s4#", "16.65%" },
        { 6631, "INV_Staff_25", "=q3=Living Root",        "=ds=#w9#", "34.47%" },
        { 6630, "INV_Shield_10", "=q3=Seedcloud Buckler", "=ds=#w8#", "35.38%" },
        };

    WCMutanus = {
        { 6461, "INV_Shoulder_05", "=q3=Slime-encrusted Pads", "=ds=#s3#, #a1#", "22.96%" },
        { 6627, "INV_Chest_Plate08", "=q3=Mutant Scale Breastplate", "=ds=#s5#, #a3#", "18.33%" },
        { 6463, "INV_Jewelry_Ring_15", "=q3=Deep Fathom Ring", "=ds=#s13#", "21.99%" },
        { 0,"","","" },
        { 10441, "INV_Stone_03", "=q1=Glowing Shard", "=ds=#m2#" },
        };

    WCDeviateFaerieDragon = {
        { 6632, "INV_Misc_Cape_02", "=q3=Feyscale Cloak", "=ds=#s4#", "37.84%" };
        { 5243, "INV_Wand_11", "=q3=Firebelcher",         "=ds=#w12#", "39.65%" };
        };

        ---------------------
        --- The Deadmines ---
        ---------------------

    VCMarisaduPaige = {
        { 3019, "INV_Chest_Cloth_38", "=q2=Noble's Robe", "=ds=#s5#, #a1#", "22.4%" },
        { 4660, "INV_Boots_06", "=q2=Walking Boots", "=ds=#s12#, #a1#", "71.4%" },
        };

    VCBrainwashedNoble = {
        { 5967, "INV_Belt_10", "=q2=Girdle of Nobility", "=ds=#s10#, #a1#", "70.4%" },
        { 3902, "INV_Wand_04", "=q2=Staff of Nobles", "=ds=#w9#", "23.0%" },
        };

    VCForemanThistlenettle = {
        { 1875, "INV_Jewelry_Amulet_03", "=q1=Thistlenettle's Badge", "=ds=#m3#", "100%" },
        };

    VCRhahkZor = {
        { 872, "INV_ThrowingAxe_01", "=q3=Rockslicer",     "=ds=#h2#, #w1#", "3.13%" },
        { 5187, "INV_Hammer_09", "=q3=Rhahk'Zor's Hammer", "=ds=#h2#, #w6#", "77.98%" },
        };

    VCMinerJohnson = {
        { 5444, "INV_Misc_Cape_11", "=q3=Miner's Cape",     "=ds=#s4#", "54.88%" },
        { 5443, "INV_Shield_02", "=q3=Gold-plated Buckler", "=ds=#w8#", "37.21%" },
        };

    VCSneedsShredder = {
        { 2169, "INV_Weapon_ShortBlade_05", "=q3=Buzzer Blade", "=ds=#h1#, #w4#", "70.78%" },
        { 1937, "INV_Sword_24", "=q3=Buzz Saw",                 "=ds=#h1#, #w10#", "8.75%" },
        { 0,"","","" },
        { 7365, "INV_Gizmo_01", "=q1=Gnoam Sprecklesprocket", "=ds=#m3#", "100%" },
        };

    VCSneed = {
        { 5195, "INV_Gauntlets_23", "=q3=Gold-flecked Gloves",  "=ds=#s9#, #a1#", "62.38%" },
        { 5194, "INV_ThrowingAxe_06", "=q3=Taskmaster Axe",     "=ds=#h2#, #w1#", "26.23%" },
        };

    VCGilnid = {
        { 5199, "INV_Pants_02", "=q3=Smelting Pants", "=ds=#s11#, #a2#", "51.37%" },
        { 1156, "INV_Jewelry_Ring_09", "=q3=Lavishly Jeweled Ring", "=ds=#s13#", "35.02%" },
        };

    VCDefiasGunpowder = {
        { 5397, "INV_Misc_Ammo_Gunpowder_01", "=q1=Defias Gunpowder", "=ds=#m3#", "100%" },
        };

    VCCaptainGreenskin = {
        { 10403, "INV_Belt_26", "=q3=Blackened Defias Belt", "=ds=#s10#, #a2#", "23.26%" },
        { 5200, "INV_Spear_07", "=q3=Impaling Harpoon",      "=ds=#w7#", "25.39%" },
        { 5201, "INV_Staff_13", "=q3=Emberstone Staff",      "=ds=#w9#", "34.10%" },
        };

    VCVanCleef = {
        { 5193, "INV_Misc_Cape_08", "=q3=Cape of the Brotherhood", "=ds=#s4#", "21.25%" },
        { 5202, "INV_Shirt_08", "=q3=Corsair's Overshirt", "=ds=#s5#, #a1#", "22.86%" },
        { 10399, "INV_Chest_Leather_08", "=q3=Blackened Defias Armor", "=ds=#s5#, #a2#", "14.77%" },
        { 5191, "INV_Sword_24", "=q3=Cruel Barb", "=ds=#h1#, #w10#", "14.17%" },
        { 0,"","","" },
        { 2874, "INV_Letter_15", "=q1=An Unsent Letter", "=ds=#m2#" },
        { 3637, "INV_Misc_Head_Human_01", "=q1=Head of VanCleef", "=ds=#m3#" },
        };

    VCMrSmite = {
        { 5192, "INV_Sword_24", "=q3=Thief's Blade",          "=ds=#h1#, #w10#", "34.96%" },
        { 5196, "INV_Axe_22", "=q3=Smite's Reaver",           "=ds=#h1#, #w1#", "33.95%" },
        { 7230, "INV_Hammer_09", "=q3=Smite's Mighty Hammer", "=ds=#h2#, #w6#", "17.27%" },
        };

    VCCookie = {
        { 5197, "INV_Fabric_Silk_02", "=q3=Cookie's Tenderizer", "=ds=#h1#, #w6#", "49.62%" },
        { 5198, "INV_Staff_02", "=q3=Cookie's Stirring Rod", "=ds=#w12#", "30.90%" },
        { 0,"","","" },
        { 8490, "INV_Box_PetCarrier_01", "=q1=Cat Carrier (Siamese)", "=ds=#e13#", "12.38%" },
        };

        -------------------------
        --- The Sunken Temple ---
        -------------------------

    STSpawnOfHakkar = {
        { 10802, "INV_Misc_Cape_02", "=q3=Wingveil Cloak", "=ds=#s4#", "25.6%" },
        { 10801, "INV_Boots_07", "=q3=Slitherscale Boots", "=ds=#s12#, #a2#", "42.33%" },
        };

    STTrollMinibosses = {
        { 10787, "INV_Bracer_18", "=q3=Atal'ai Gloves", "=ds=#s9#, #a1# =q2=#m16#", "5.25%" },
        { 10783, "INV_Shoulder_18", "=q3=Atal'ai Spaulders",      "=ds=#s3#, #a2# =q2=#m16#", "3.12%" },
        { 10785, "INV_Pants_07", "=q3=Atal'ai Leggings",          "=ds=#s11#, #a2# =q2=#m16#", "4.42%" },
        { 10784, "INV_Chest_Chain_05", "=q3=Atal'ai Breastplate", "=ds=#s5#, #a3# =q2=#m16#", "2.12%" },
        { 10786, "INV_Boots_01", "=q3=Atal'ai Boots",          "=ds=#s12#, #a3# =q2=#m16#", "6.15%" },
        { 10788, "INV_Belt_15", "=q3=Atal'ai Girdle",          "=ds=#s10#, #a4# =q2=#m16#", "7.17%" },
        { 0,"","","" },
        { 20606, "INV_Feather_14","=q1=Amber Voodoo Feather",    "=ds=#m3# =q2=#st1#, #st6#" },
        { 20607, "INV_Feather_13","=q1=Blue Voodoo Feather",     "=ds=#m3# =q2=#st2#, #st4#" },
        { 20608, "INV_Feather_12","=q1=Green Voodoo Feather",    "=ds=#m3# =q2=#st3#, #st5#" },
        };

    STAtalalarion = {
        { 10800, "INV_Bracer_08", "=q3=Darkwater Bracers",      "=ds=#s8#, #a2# =q2=#m16#", "31.73%" },
        { 10798, "INV_Belt_15", "=q3=Atal'alarion's Tusk Ring", "=ds=#s10#, #a4#", "30.53%" },
        { 10799, "INV_Spear_06", "=q3=Headspike",               "=ds=#w7#", "17.98%" },
        };

    STDreamscythe = {
        { 12465, "INV_Misc_Cape_05", "=q3=Nightfall Drape",      "=ds=#s4#", "4.42%" },
        { 12466, "INV_Belt_11", "=q3=Dawnspire Cord",            "=ds=#s10#, #a1#", "4.16%" },
        { 12464, "INV_Gauntlets_19", "=q3=Bloodfire Talons",     "=ds=#s9#, #a2#", "4.99%" },
        { 10795, "INV_Jewelry_Ring_04", "=q3=Drakeclaw Band", "=ds=#s13# =q2=#m16#", "3.68%" },
        { 10796, "INV_Misc_Orb_03", "=q3=Drakestone", "=ds=#s15#", "4.26%" },
        { 10797, "INV_Sword_09", "=q3=Firebreather",             "=ds=#h1#, #w10#", "4.57%" },
        { 12463, "INV_Sword_19", "=q3=Drakefang Butcher",        "=ds=#h2#, #w10#", "4.40%" },
        { 12243, "INV_Weapon_Halberd_04", "=q3=Smoldering Claw", "=ds=#w7#", "4.50%" },
        };

    STWeaver = {
        { 12465, "INV_Misc_Cape_05", "=q3=Nightfall Drape",      "=ds=#s4#", "4.20%" },
        { 12466, "INV_Belt_11", "=q3=Dawnspire Cord",            "=ds=#s10#, #a1#", "3.89%" },
        { 12464, "INV_Gauntlets_19", "=q3=Bloodfire Talons",     "=ds=#s9#, #a2#", "4.10%" },
        { 10795, "INV_Jewelry_Ring_04", "=q3=Drakeclaw Band", "=ds=#s13# =q2=#m16#", "4.46%" },
        { 10796, "INV_Misc_Orb_03", "=q3=Drakestone",      "=ds=#s15#", "4.47%" },
        { 10797, "INV_Sword_09", "=q3=Firebreather",             "=ds=#h1#, #w10#", "4.08%" },
        { 12463, "INV_Sword_19", "=q3=Drakefang Butcher",        "=ds=#h2#, #w10#", "5.00%" },
        { 12243, "INV_Weapon_Halberd_04", "=q3=Smoldering Claw", "=ds=#w7#", "4.42%" },
        };

    STAvatarofHakkar = {
        { 12462, "INV_Chest_Cloth_42", "=q4=Embrace of the Wind Serpent", "=ds=#s5#, #a1#", "0.15%" },
        { 0,"","","" },
        { 10843, "INV_Misc_Cape_05", "=q3=Featherskin Cape", "=ds=#s4#", "31.12%" },
        { 10842, "INV_Pants_14", "=q3=Windscale Sarong", "=ds=#s11#, #a2#", "33.22%" },
        { 10846, "INV_Boots_01", "=q3=Bloodshot Greaves", "=ds=#s12#, #a3#", "32.44%" },
        { 10845, "INV_Chest_Plate08", "=q3=Warrior's Embrace", "=ds=#s5#, #a4#", "30.44%" },
        { 10838, "INV_Mace_11", "=q3=Might of Hakkar", "=ds=#h3#, #w6#", "16.37%" },
        { 10844, "INV_Staff_32", "=q3=Spire of Hakkar", "=ds=#w9#", "16.02%" },
        { 0,"","","" },
        { 10663, "Spell_Shadow_DemonBreath", "=q1=Essence of Hakkar", "=ds=#m3#", "100%" },
        };

    STJammalan = {
        { 10806, "INV_Chest_Cloth_38", "=q3=Vestments of the Atal'ai Prophet", "=ds=#s5#, #a1#", "24.13%" },
        { 10808, "INV_Gauntlets_17", "=q3=Gloves of the Atal'ai Prophet", "=ds=#s9#, #a1#", "26.74%" },
        { 10807, "INV_Pants_11", "=q3=Kilt of the Atal'ai Prophet", "=ds=#s11#, #a1#", "23.00%" },
        { 0,"","","" },
        { 6212, "INV_Misc_Head_Troll_01","=q1=Head of Jammal'an", "=ds=#m3#" },
        };

    STOgom = {
        { 10803, "INV_Sword_38", "=q3=Blade of the Wretched", "=ds=#h3#, #w10#", "28.21%" },
        { 10805, "INV_Axe_12", "=q3=Eater of the Dead",       "=ds=#h3#, #w1#", "28.27%" },
        { 10804, "INV_Hammer_11", "=q3=Fist of the Damned",   "=ds=#h1#, #w6#", "30.03%" },
        };

    STMorphaz = {
        { 12465, "INV_Misc_Cape_05", "=q3=Nightfall Drape",      "=ds=#s4#", "4.29%" },
        { 12466, "INV_Belt_11", "=q3=Dawnspire Cord",            "=ds=#s10#, #a1#", "4.12%" },
        { 12464, "INV_Gauntlets_19", "=q3=Bloodfire Talons",     "=ds=#s9#, #a2#", "4.21%" },
        { 10795, "INV_Jewelry_Ring_04", "=q3=Drakeclaw Band", "=ds=#s13# =q2=#m16#", "4.07%" },
        { 10796, "INV_Misc_Orb_03", "=q3=Drakestone", "=ds=#s15#", "4.18%" },
        { 10797, "INV_Sword_09", "=q3=Firebreather",             "=ds=#h1#, #w10#", "4.24%" },
        { 12463, "INV_Sword_19", "=q3=Drakefang Butcher",        "=ds=#h2#, #w10#", "4.35%" },
        { 12243, "INV_Weapon_Halberd_04", "=q3=Smoldering Claw", "=ds=#w7#", "4.09%" },
        { 0,"","","" },
        { 20022, "INV_Misc_Key_08", "=q1=Azure Key", "=ds=#m3#", "100%" },
        { 20085, "INV_Misc_Gem_Topaz_03", "=q1=Arcane Shard", "=ds=#m3#", "100%" },
        { 20025, "INV_Potion_08", "=q1=Blood of Morphaz", "=ds=#m3#", "100%" },
        { 20019, "INV_Misc_MonsterFang_01", "=q1=Tooth of Morphaz", "=ds=#m3#", "100%" },
        };

    STHazzas = {
        { 12465, "INV_Misc_Cape_05", "=q3=Nightfall Drape",      "=ds=#s4#", "4.48%" },
        { 12466, "INV_Belt_11", "=q3=Dawnspire Cord",            "=ds=#s10#, #a1#", "4.46%" },
        { 12464, "INV_Gauntlets_19", "=q3=Bloodfire Talons",     "=ds=#s9#, #a2#", "5.00%" },
        { 10795, "INV_Jewelry_Ring_04", "=q3=Drakeclaw Band", "=ds=#s13# =q2=#m16#", "4.18%" },
        { 10796, "INV_Misc_Orb_03", "=q3=Drakestone",      "=ds=#s15#", "4.92%" },
        { 10797, "INV_Sword_09", "=q3=Firebreather",             "=ds=#h1#, #w10#", "4.50%" },
        { 12463, "INV_Sword_19", "=q3=Drakefang Butcher",        "=ds=#h2#, #w10#", "4.58%" },
        { 12243, "INV_Weapon_Halberd_04", "=q3=Smoldering Claw", "=ds=#w7#", "4.56%" },
        };

    STEranikus = {
        { 10847, "INV_Sword_38", "=q4=Dragon's Call", "=ds=#h1#, #w10#", "0.18%" },
        { 0,"","","" },
        { 10833, "INV_Helmet_25", "=q3=Horns of Eranikus",       "=ds=#s1#, #a3#", "25.66%" },
        { 10829, "INV_Jewelry_Amulet_04", "=q3=Dragon's Eye",    "=ds=#s2#", "27.02%" },
        { 10828, "INV_Weapon_ShortBlade_16", "=q3=Dire Nail", "=ds=#h1#, #w4#", "10.91%" },
        { 10837, "INV_Axe_07", "=q3=Tooth of Eranikus",          "=ds=#h3#, #w1#", "10.05%" },
        { 10835, "INV_Shield_04", "=q3=Crest of Supremacy",      "=ds=#w8#", "19.17%" },
        { 10836, "INV_Wand_04", "=q3=Rod of Corrosion", "=ds=#w12#", "21.54%" },
        { 0,"","","" },
        { 10454, "INV_Stone_03", "=q2=Essence of Eranikus",      "=ds=#m2#" },
        { 10455, "INV_Stone_03", "=q2=Chained Essence of Eranikus", "=q1=#m4#: =ds=#s14#" },
        };

    STTrash = {
        { 10630, "INV_Crown_01", "=q3=Soulcatcher Halo", "=ds=#s1#, #a1#", "0.01%" },
        { 10629, "INV_Boots_05", "=q3=Mistwalker Boots", "=ds=#s12#, #a1#", "0.01%" },
        { 10632, "INV_Jewelry_Ring_03", "=q3=Slimescale Bracers", "=ds=#s8#, #a3#", "0.01%" },
        { 10631, "INV_Gauntlets_11", "=q3=Murkwater Gauntlets", "=ds=#s9#, #a3#", "0.01%" },
        { 10633, "INV_Pants_04", "=q3=Silvershell Leggings", "=ds=#s11#, #a3#", "0.01%" },
        { 10634, "INV_Jewelry_Ring_10", "=q3=Mindseye Circle", "=ds=#s13#", "0.02%" },
        { 0,"","","" },
        { 15733, "INV_Scroll_03", "=q3=Pattern: Green Dragonscale Leggings", "=ds=#p7# (270) =q1=#n80#", "1.80%" },
        { 16216, "INV_Misc_Note_01", "=q2=Formula: Enchant Cloak - Greater Resistance", "=ds=#p4# (265) =q1=#n81#", "0.75%" },
        { 0,"","","" },
        { 11318, "INV_Misc_Gem_Stone_01", "=q1=Atal'ai Haze", "=ds=#m3#" },
        { 6181, "INV_Misc_Bone_HumanSkull_01", "=q1=Fetish of Hakkar", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 10625, "INV_Sword_41", "=q3=Stealthblade", "=ds=#h1#, #w4#", "0.01%" },
        { 10628, "INV_Sword_31", "=q3=Deathblow", "=ds=#h2#, #w10#", "0.01%" },
        { 10623, "INV_Axe_07", "=q3=Winter's Bite", "=ds=#h3#, #w1#", "0.01%" },
        { 10626, "INV_Hammer_06", "=q3=Ragehammer", "=ds=#h2#, #w6#", "0.01%" },
        { 10627, "INV_Staff_28", "=q3=Bludgeon of the Grinning Dog", "=ds=#w9#", "0.02%" },
        { 10624, "INV_Weapon_Bow_08", "=q3=Stinging Bow", "=ds=#w2#", "0.02%" },
        };

        ----------------
        --- Maraudon ---
        ----------------

    MaraNamelesProphet = {
        { 17757, "INV_Jewelry_Amulet_02", "=q1=Amulet of Spirits", "=ds=#m3#", "100%" },
        };

    MaraKhanKolk = {
        { 17761, "INV_Misc_Gem_Ruby_02", "=q1=Gem of the First Khan", "=ds=#m3#", "100%" },
        };

    MaraKhanGelk = {
        { 17762, "INV_Misc_Gem_Emerald_01", "=q1=Gem of the Second Khan", "=ds=#m3#", "100%" },
        };

    MaraKhanMagra = {
        { 17763, "INV_Misc_Gem_Topaz_01", "=q1=Gem of the Third Khan", "=ds=#m3#", "100%" },
        };

    MaraKhanVeng  = {
        { 17765, "INV_Misc_Gem_Opal_01", "=q1=Gem of the Fifth Khan", "=ds=#m3#", "100%" },
        };

    MaraNoxxion = {
        { 17746, "INV_Bracer_06", "=q3=Noxxion's Shackles",      "=ds=#s8#, #a4#", "32.50%" },
        { 17744, "INV_Misc_Gem_Pearl_06", "=q3=Heart of Noxxion", "=ds=#s14#", "30.35%" },
        { 17745, "INV_Wand_04", "=q3=Noxious Shooter", "=ds=#w12#", "17.53%" },
        { 0,"","","" },
        { 17702, "INV_Staff_19", "=q1=Celebrian Rod", "=ds=#m3#", "100%" },
        };

    MaraRazorlash = {
        { 17750, "INV_Belt_25", "=q3=Chloromesh Girdle",       "=ds=#s10#, #a1#", "22.93%" },
        { 17748, "INV_Boots_05", "=q3=Vinerot Sandals",        "=ds=#s12#, #a1#", "20.60%" },
        { 17749, "INV_Shoulder_06", "=q3=Phytoskin Spaulders", "=ds=#s3#, #a2#", "22.09%" },
        { 17751, "INV_Pants_05", "=q3=Brusslehide Leggings",   "=ds=#s11#, #a2#", "21.65%" },
        };

    MaraKhanMaraudos   = {
        { 17764, "INV_Misc_Gem_Sapphire_02", "=q1=Gem of the Fourth Khan", "=ds=#m3#", "100%" },
        };

    MaraLordVyletongue = {
        { 17755, "INV_Belt_24", "=q3=Satyrmane Sash", "=ds=#s10#, #a1#", "25.71%" },
        { 17754, "INV_Pants_Wolf", "=q3=Infernal Trickster Leggings", "=ds=#s11#, #a3#", "28.09%" },
        { 17752, "INV_Weapon_ShortBlade_09", "=q3=Satyr's Lash", "=ds=#h1#, #w4#", "23.14%" },
        { 0,"","","" },
        { 17703, "INV_Jewelry_Talisman_08", "=q1=Celebrian Diamond", "=ds=#m3#", "100%" },
        };

    MaraMeshlok = {
        { 17741, "INV_Chest_Cloth_15", "=q3=Nature's Embrace",  "=ds=#s5#, #a1#", "30.34%" },
        { 17742, "INV_Chest_Leather_08", "=q3=Fungus Shroud Armor", "=ds=#s5#, #a2#", "31.37%" },
        { 17767, "INV_Helmet_17", "=q3=Bloomsprout Headpiece",  "=ds=#s1#, #a3#", "28.32%" },
        };

    MaraCelebras = {
        { 17739, "INV_Misc_Cape_17", "=q3=Grovekeeper's Drape", "=ds=#s4#", "30.32%" },
        { 17740, "INV_Helmet_12", "=q3=Soothsayer's Headdress", "=ds=#s1#, #a2#", "28.59%" },
        { 17738, "Ability_Whirlwind", "=q3=Claw of Celebras",   "=ds=#h4#, #w13#", "28.22%" },
        };

    MaraLandslide = {
        { 17736, "INV_Gauntlets_28", "=q3=Rockgrip Gauntlets", "=ds=#s9#, #a3#", "23.09%" },
        { 17734, "INV_Helmet_20", "=q3=Helm of the Mountain",  "=ds=#s1#, #a4#", "20.87%" },
        { 17737, "INV_Misc_Orb_01", "=q3=Cloud Stone",         "=ds=#s15#", "19.99%" },
        { 17943, "INV_Hammer_17", "=q3=Fist of Stone",         "=ds=#h3#, #w6#", "16.58%" },
        };

    MaraTinkererGizlock = {
        { 17719, "INV_Sword_14", "=q3=Inventor's Focal Sword", "=ds=#h3#, #w10#", "27.44%" },
        { 17718, "INV_Shield_10", "=q3=Gizlock's Hypertech Buckler", "=ds=#w8#", "30.61%" },
        { 17717, "INV_Weapon_Rifle_05", "=q3=Megashot Rifle", "=ds=#w5#", "27.23%" },
        };

    MaraRotgrip = {
        { 17732, "INV_Shoulder_05", "=q3=Rotgrip Mantle",      "=ds=#s3#, #a1#", "25.73%" },
        { 17728, "INV_Boots_05", "=q3=Albino Crocscale Boots", "=ds=#s12#, #a2#", "26.20%" },
        { 17730, "INV_Axe_04", "=q3=Gatorbite Axe",            "=ds=#h2#, #w1#", "19.21%" },
        };

    MaraPrincessTheradras = {
        { 17780, "INV_Sword_09", "=q4=Blade of Eternal Darkness", "=ds=#h3#, #w4#", "0.20%" },
        { 0,"","","" },
        { 17715, "INV_Crown_01", "=q3=Eye of Theradras", "=ds=#s1#, #a1#", "13.47%" },
        { 17714, "INV_Bracer_14", "=q3=Bracers of the Stone Princess", "=ds=#s8#, #a3#", "20.06%" },
        { 17711, "INV_Pants_04", "=q3=Elemental Rockridge Leggings", "=ds=#s11#, #a4#", "14.96%" },
        { 17707, "INV_Stone_01", "=q3=Gemshard Heart", "=ds=#s2#", "15.30%" },
        { 17713, "INV_Jewelry_Ring_17", "=q3=Blackstone Ring", "=ds=#s13#", "18.92%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 17766, "INV_Hammer_10", "=q3=Princess Theradras' Scepter", "=ds=#h2#, #w6#", "16.44%" },
        { 17710, "INV_Weapon_ShortBlade_14", "=q3=Charstone Dirk", "=ds=#h3#, #w4#", "14.24%" },
        };

        ------------------
        --- Zul'Farrak ---
        ------------------

    ZFAntusul = {
        { 9640, "INV_Gauntlets_26", "=q3=Vice Grips",             "=ds=#s9#, #a4#", "31.30%" },
        { 9641, "INV_Jewelry_Necklace_02", "=q3=Lifeblood Amulet", "=ds=#s2#", "30.80%" },
        { 9639, "INV_Mace_11", "=q3=The Hand of Antu'sul", "=ds=#h3#, #w6#", "15.47%" },
        { 0,"","","" },
        { 9379, "INV_Sword_45", "=q3=Sang'thraze the Deflector",  "=ds=#h1#, #w10#", "2.10%" },
        { 9372, "INV_Sword_40", "=q4=Sul'thraze the Lasher", "=ds=#h2#, #w10#" },
        };

    ZFThekatheMartyr = {
        { 10660, "INV_Misc_Rune_04", "=q1=First Mosh'aru Tablet", "=ds=#m3#", "100%" },
        };

    ZFWitchDoctorZumrah = {
        { 18083, "INV_Gauntlets_09", "=q3=Jumanza Grips",     "=ds=#s9#, #a1#", "24.97%" },
        { 18082, "INV_Staff_10", "=q3=Zum'rah's Vexing Cane", "=ds=#w9#", "11.98%" },
        };

    ZFNekrumGutchewer = {
        { 9471, "INV_Jewelry_Amulet_01", "=q1=Nekrum's Medallion", "=ds=#m3#", "100%" },
        };

    ZFSezzziz = {
        { 9470, "INV_Banner_01", "=q3=Bad Mojo Mask", "=ds=#s1#, #a1#", "18.69%" },
        { 9473, "INV_Chest_Leather_05", "=q3=Jinxed Hoodoo Skin", "=ds=#s5#, #a2#", "21.12%" },
        { 9474, "INV_Pants_05", "=q3=Jinxed Hoodoo Kilt", "=ds=#s11#, #a2#", "20.95%" },
        { 9475, "INV_Spear_01", "=q3=Diabolic Skiver", "=ds=#w7#", "20.06%" },
        };

    ZFDustwraith = {
        { 12471, "INV_Staff_21", "=q3=Desertwalker Cane", "=ds=#s15#", "17.71%" },
        };

    ZFSergeantBly = {
        { 8548, "INV_Wand_08", "=q1=Divino-matic Rod", "=ds=#m3#", "100%" },
        };

    ZFSandfury = {
        { 8444, "INV_Misc_Key_02", "=q1=Executioner's Key", "=ds=#e9#" },
        };

    ZFHydromancerVelratha = {
        { 9234, "INV_Jewelry_Amulet_05", "=q1=Tiara of the Deep", "=ds=#m3#", "100%" },
        { 10661, "INV_Misc_Rune_08", "=q1=Second Mosh'aru Tablet", "=ds=#m3#", "100%" },
        };

    ZFGahzrilla = {
        { 9469, "INV_Chest_Chain_06", "=q3=Gahz'rilla Scale Armor", "=ds=#s5#, #a3#", "36.76%" },
        { 9467, "INV_Misc_MonsterFang_01", "=q3=Gahz'rilla Fang", "=ds=#h1#, #w4#", "36.83%" },
        { 0,"","","" },
        { 8707, "INV_Misc_MonsterScales_03", "=q1=Gahz'rilla's Electrified Scale", "=ds=#m3#" },
        };

    ZFChiefUkorzSandscalp = {
        { 9479, "Ability_Mount_WhiteDireWolf", "=q3=Embrace of the Lycan", "=ds=#s1#, #a2#", "8.97%" },
        { 9476, "INV_Shoulder_01", "=q3=Big Bad Pauldrons", "=ds=#s3#, #a4#", "28.17%" },
        { 9478, "INV_Axe_07", "=q3=Ripsaw", "=ds=#h3#, #w1#", "19.78%" },
        { 9477, "INV_Staff_Goldfeathered_01", "=q3=The Chief's Enforcer", "=ds=#w9#", "22.33%" },
        { 0,"","","" },
        { 11086, "INV_Sword_43", "=q3=Jang'thraze the Protector", "=ds=#h3#, #w10#", "1.72%" },
        { 9372, "INV_Sword_40", "=q4=Sul'thraze the Lasher", "=ds=#h2# #w10#" },
        };

    ZFZerillis = {
        { 12470, "INV_Bracer_04", "=q3=Sandstalker Ankleguards", "=ds=#s12#, #a2#", "15.55%" },
        };

    ZFTrash = {
        { 9512, "INV_Misc_Cape_05", "=q3=Blackmetal Cape", "=ds=#s4#", "0.02%" },
        { 9484, "INV_Pants_08", "=q3=Spellshock Leggings", "=ds=#s11#, #a1#", "0.01%" },
        {  862, "INV_Belt_34", "=q3=Runed Ring", "=ds=#s13# =q2=#m16#", "0.02%" },
        { 6440, "INV_Belt_30", "=q3=Brainlash", "=ds=#s13#", "0.01%" },
        { 0,"","","" },
        { 9243, "INV_Misc_Organ_01", "=q2=Shriveled Heart", "=ds=#s2#" },
        { 0,"","","" },
        { 9523, "INV_Potion_25", "=q1=Troll Temper", "=ds=#m3#" },
        { 9238, "INV_Misc_MonsterScales_03", "=q1=Uncracked Scarab Shell", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 5616, "INV_Sword_31", "=q3=Gutwrencher", "=ds=#h1#, #w4#", "0.01%" },
        { 9511, "INV_Sword_40", "=q3=Bloodletter Scalpel", "=ds=#h1#, #w10#", "0.01%" },
        { 9481, "INV_Axe_03", "=q3=The Minotaur", "=ds=#h2#, #w1#", "0.01%" },
        { 9480, "INV_Spear_05", "=q3=Eyegouger", "=ds=#w7#", "0.01%" },
        { 9482, "INV_Staff_31", "=q3=Witch Doctor's Cane", "=ds=#w9#", "0.01%" },
        { 9483, "INV_Torch_Lit", "=q3=Flaming Incinerator", "=ds=#w12#", "0.01%" },
        { 2040, "INV_Shield_16", "=q3=Troll Protector", "=ds=#w8#", "0.02%" },
        };

        ----------------------
        --- Razorfen Downs ---
        ----------------------

    RFDTutenkash = {
        { 10776, "INV_Misc_Cape_17", "=q3=Silky Spider Cape", "=ds=#s4#", "28.64%" },
        { 10777, "INV_Gauntlets_32", "=q3=Arachnid Gloves",      "=ds=#s9#, #a2#", "28.95%" },
        { 10775, "INV_Chest_Plate08", "=q3=Carapace of Tuten'kash", "=ds=#s5#, #a4#", "24.87%" },
        };

    RFDHenryStern = {
        { 3831, "INV_Scroll_03", "=q1=Recipe: Mighty Troll's Blood Potion", "=ds=#p1# (180)" },
        { 10841, "INV_Drink_15", "=q1=Goldthorn Tea", "=ds=#p3# (175)" },
        };
    
    RFDMordreshFireEye = {
        { 10771, "INV_Belt_24", "=q3=Deathmage Sash", "=ds=#s10#, #a1#", "27.92%" },
        { 10769, "INV_Misc_Orb_03", "=q3=Glowing Eye of Mordresh", "=ds=#s2#", "29.11%" },
        { 10770, "INV_Misc_Bone_ElfSkull_01", "=q3=Mordresh's Lifeless Skull", "=ds=#s15#", "29.59%" },
        };

    RFDGlutton = {
        { 10774, "INV_Shoulder_28", "=q3=Fleshhide Shoulders", "=ds=#s3#, #a2#", "42.15%" },
        { 10772, "INV_Axe_23", "=q3=Glutton's Cleaver",        "=ds=#h1#, #w1#", "44.22%" },
        };

    RFDRagglesnout = {
        { 10768, "INV_Belt_11", "=q3=Boar Champion's Belt",  "=ds=#s10#, #a3#", "31.40%" },
        { 10758, "INV_Sword_45", "=q3=X'caliboar",           "=ds=#h2#, #w10#", "18.51%" },
        { 10767, "INV_Shield_17", "=q3=Savage Boar's Guard", "=ds=#w8#", "35.14%" },
        };

    RFDAmnennar = {
        { 10762, "INV_Chest_Cloth_17", "=q3=Robes of the Lich", "=ds=#s5#, #a1#", "29.52%" },
        { 10765, "INV_Gauntlets_09", "=q3=Bonefingers",         "=ds=#s9#, #a2#" },
        { 10764, "INV_Chest_Plate12", "=q3=Deathchill Armor",   "=ds=#s5#, #a3#", "24.24%" },
        { 10763, "INV_Helmet_13", "=q3=Icemetal Barbute",       "=ds=#s1#, #a4#", "28.66%" },
        { 10761, "INV_Sword_34", "=q3=Coldrage Dagger",         "=ds=#h1#, #w4#", "13.89%" },
        { 0,"","","" },
        { 10420, "INV_Misc_Bone_HumanSkull_01", "=q1=Skull of the Coldbringer", "=ds=#m3#", "100%" },
        };

    RFDPlaguemaw = {
        { 10760, "INV_Gauntlets_23", "=q3=Swine Fists", "=ds=#s9#, #a2#", "58.15%" },
        { 10766, "INV_Wand_03", "=q3=Plaguerot Sprig", "=ds=#w12#, =q1=#m1# =ds=#c3#", "29.98%" },
        };

    RFDTrash = {
        { 10574, "INV_Misc_Cape_04", "=q3=Corpseshroud", "=ds=#s1#, #a1#", "0.01%" },
        { 10581, "INV_Chest_Leather_08", "=q3=Death's Head Vestment", "=ds=#s5#, #a1#", "0.02%" },
        { 10578, "INV_Boots_01", "=q3=Thoughtcast Boots", "=ds=#s12#, #a1#", "0.01%" },
        { 10583, "INV_Chest_Leather_08", "=q3=Quillward Harness", "=ds=#s5#, #a2#", "0.01%" },
        { 10582, "INV_Boots_08", "=q3=Briar Tredders", "=ds=#s12#, #a2#", "0.02%" },
        { 10584, "INV_Gauntlets_11", "=q3=Stormgale Fists", "=ds=#s9#, #a3#", "0.02%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 10571, "INV_Misc_Bone_10", "=q3=Ebony Boneclub", "=ds=#h1#, #w6#", "0.01%" },
        { 10573, "INV_Sword_41", "=q3=Boneslasher", "=ds=#h2#, #w10#", "0.01%" },
        { 10570, "INV_Axe_04", "=q3=Manslayer", "=ds=#h2#, #w1#", "0.01%" },
        { 10567, "INV_Weapon_Bow_01", "=q3=Quillshooter", "=ds=#w2#", "0.02%" },
        { 10572, "INV_Wand_01", "=q3=Freezing Shard", "=ds=#w12#, =q1=#m1# =q2=#c3#", "0.01%" },
        };

        ---------------
        --- Uldaman ---
        ---------------

    UldMagreganDeepshadow = {
        { 4635, "INV_Jewelry_Amulet_03", "=q1=Hammertoe's Amulet", "=ds=#m3#", "100%" },
        };

    UldTabletofRyuneh = {
        { 4631, "INV_Misc_Rune_02", "=q1=Tablet of Ryun'eh", "=ds=#m3#" },
        };

    UldKromStoutarmChest = {
        { 8027, "INV_Drink_03", "=q1=Krom Stoutarm's Treasure", "=ds=#m3#" },
        };

    UldGarrettFamilyChest = {
        { 8026, "INV_Banner_01", "=q1=Garrett Family Treasure", "=ds=#m3#" },
        };

    UldShovelphlange = {
        { 9375, "INV_Helmet_18", "=q3=Expert Goldminer's Helmet", "=ds=#s1#, #a2#", "9.30%" },
        { 9378, "INV_Pick_02", "=q3=Shovelphlange's Mining Axe",  "=ds=#h1#, #w1#", "13.50%" },
        { 0,"","","" },
        { 9382, "INV_Boots_08", "=q2=Tromping Miner's Boots",     "=ds=#s12#, #a2#", "70.70%" },
        };

    UldBaelog = {
        { 0, "INV_Box_01", "=q6=#n45#", "" },
        { 9401, "INV_Sword_24", "=q3=Nordic Longshank", "=ds=#h1#, #w10#", "8.89%" },
        { 9400, "INV_Weapon_Bow_11", "=q3=Baelog's Shortbow", "=ds=#w2#", "46.52%" },
        { 9399, "INV_Ammo_Arrow_01", "=q2=Precision Arrow", "=ds=#w17#", "78.62%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n46#", "" },
        { 9394, "INV_Helmet_25", "=q3=Horned Viking Helmet", "=ds=#s1#, #a4#", "4.05%" },
        { 9398, "INV_Boots_02", "=q3=Worn Running Boots", "=ds=#s12#, #a2#", "45.09%" },
        { 2459, "INV_Potion_95", "=q1=Swiftness Potion", "=ds=#e2#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n47#", "" },
        { 9404, "INV_Shield_02", "=q3=Olaf's All Purpose Shield", "=ds=#w8#", "11.33%" },
        { 9403, "INV_Shield_07", "=q3=Battered Viking Shield", "=ds=#w8#", "69.85%" },
        { 1177, "INV_Potion_12", "=q1=Oil of Olaf", "=ds=#e2#", "76.54%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x14#", "" },
        { 7740, "INV_Jewelry_Amulet_01", "=q1=Gni'kiv Medallion", "=ds=#m3#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x15#", "" },
        { 7671, "INV_Misc_Gem_Topaz_01", "=q1=Shattered Necklace Topaz", "=ds=#m3#" },
        };

    UldRevelosh = {
        { 9390, "INV_Gauntlets_17", "=q3=Revelosh's Gloves",   "=ds=#s9#, #a1# =q2=#m16#", "20.08%" },
        { 9389, "INV_Shoulder_25", "=q3=Revelosh's Spaulders", "=ds=#s3#, #a2# =q2=#m16#", "18.77%" },
        { 9388, "INV_Bracer_16", "=q3=Revelosh's Armguards",   "=ds=#s8#, #a3# =q2=#m16#", "19.84%" },
        { 9387, "INV_Boots_Plate_06", "=q3=Revelosh's Boots",  "=ds=#s12#, #a4# =q2=#m16#", "20.53%" },
        { 0,"","","" },
        { 7741, "INV_Staff_Goldfeathered_01", "=q1=The Shaft of Tsol", "=ds=#m3#" },
        };

    UldIronaya = {
        { 9407, "INV_Pants_01", "=q3=Stoneweaver Leggings",  "=ds=#s11#, #a1#", "31.02%" },
        { 9409, "INV_Bracer_19", "=q3=Ironaya's Bracers", "=ds=#s8#, #a3# =q2=#m16#", "32.71%" },
        { 9408, "INV_Staff_28", "=q3=Ironshod Bludgeon",     "=ds=#w9#", "17.37%" },
        };

    UldObsidianSentinel = {
        { 8053, "INV_Misc_Orb_03", "=q1=Obsidian Power Source", "=ds=#m3#", "100%" },
        };

    UldAncientStoneKeeper = {
        { 9411, "INV_Shoulder_02", "=q3=Rockshard Pauldrons", "=ds=#s3#, #a3#", "43.41%" },
        { 9410, "INV_Gauntlets_12", "=q3=Cragfists", "=ds=#s9#, #a4# =q2=#m16#", "41.61%" },
        };

    UldGalgannFirehammer = {
        { 11311, "INV_Misc_Cape_08", "=q3=Emberscale Cape", "=ds=#s4#", "36.52%" },
        { 11310, "INV_Shoulder_05", "=q3=Flameseer Mantle", "=ds=#s3#, #a1#", "17.35%" },
        { 9419, "INV_Hammer_17", "=q3=Galgann's Firehammer", "=ds=#h1#, #w6#", "18.10%" },
        { 9412, "INV_Weapon_Rifle_07", "=q3=Galgann's Fireblaster", "=ds=#w5#", "17.10%" },
        };

    UldTabletofWill = {
        { 5824, "INV_Misc_Rune_01", "=q1=Tablet of Will", "=ds=#m3#" },
        };

    UldShadowforgeCache = {
        { 7669, "INV_Misc_Gem_Ruby_01", "=q1=Shattered Necklace Ruby", "=ds=#m3#" },
        };

    UldGrimlok = {
        { 9415, "INV_Shirt_05", "=q3=Grimlok's Tribal Vestments", "=ds=#s5#, #a1#", "36.51%" },
        { 9414, "INV_Pants_06", "=q3=Oilskin Leggings", "=ds=#s11#, #a2#", "29.78%" },
        { 9416, "INV_Spear_08", "=q3=Grimlok's Charge", "=ds=#w7#", "15.05%" },
        { 0,"","","" },
        { 7670, "INV_Misc_Gem_Sapphire_02", "=q1=Shattered Necklace Sapphire", "=ds=#m3#", "100%" },
        };

    UldArchaedas = {
        { 11118, "INV_Stone_15", "=q3=Archaedic Stone", "=ds=#s13# =q2=#m16#", "51.99%" },
        { 9418, "INV_Sword_47", "=q3=Stoneslayer",         "=ds=#h2#, #w10#", "10.48%" },
        { 9413, "INV_Hammer_12", "=q3=The Rockpounder",    "=ds=#h2#, #w6#", "10.94%" },
        { 0,"","","" },
        { 7672, "INV_Misc_Orb_03", "=q1=Shattered Necklace Power Source", "=ds=#m3#", "100%" },
        };

    UldTrash = {
        { 9397, "INV_Misc_Cape_18", "=q3=Energy Cloak", "=ds=#s4#", "0.01%" },
        { 9431, "INV_Helmet_28", "=q3=Papal Fez", "=ds=#s1#, #a1#", "0.01%" },
        { 9429, "INV_Helmet_15", "=q3=Miner's Hat of the Deep", "=ds=#s1#, #a1#", "0.01%" },
        { 9420, "INV_Helmet_15", "=q3=Adventurer's Pith Helmet", "=ds=#s1#, #a2#", "0.01%" },
        { 9406, "INV_Chest_Leather_08", "=q3=Spirewind Fetter", "=ds=#s5#, #a2#", "0.01%" },
        { 9428, "INV_Bracer_06", "=q3=Unearthed Bands", "=ds=#s8#, #a2# =q2=#m16#", "0.01%" },
        { 9430, "INV_Shoulder_18", "=q3=Spaulders of a Lost Age", "=ds=#s3#, #a3#", "0.00%" },
        { 9396, "INV_Pants_10", "=q3=Legguards of the Vault", "=ds=#s11#, #a3#" },
        { 9432, "INV_Bracer_14", "=q3=Skullplate Bracers", "=ds=#s8#, #a4#", "0.01%" },
        { 9393, "INV_Misc_Lantern_01", "=q3=Beacon of Hope", "=ds=#s15#", "0.01%" },
        { 0,"","","" },
        { 7666, "INV_Jewelry_Necklace_02", "=q2=Shattered Necklace", "=q1=#m2#" },
        { 7673, "INV_Jewelry_Necklace_02", "=q3=Talvash's Enhancing Necklace", "=q1=#m4#: =ds=#s2#" },
        { 0,"","","" },
        { 0,"","","" },
        { 9384, "INV_Weapon_ShortBlade_18", "=q3=Stonevault Shiv", "=ds=#h1#, #w4#", "0.01%" },
        { 9392, "INV_Sword_26", "=q3=Annealed Blade", "=ds=#h1#, #w10#", "0.01%" },
        { 9424, "INV_Sword_42", "=q3=Ginn-su Sword", "=ds=#h1#, #w10#", "0.01%" },
        { 9465, "INV_Pick_01", "=q3=Digmaster 5000", "=ds=#h1#, #w1#", "0.01%" },
        { 9383, "INV_Axe_14", "=q3=Obsidian Cleaver", "=ds=#h2#, #w1#", "0.01%" },
        { 9425, "INV_Weapon_Halberd_08", "=q3=Pendulum of Doom", "=ds=#h2#, #w1#", "0.01%" },
        { 9386, "INV_Torch_Lit", "=q3=Excavator's Brand", "=ds=#h1#, #w6#", "0.01%" },
        { 9427, "INV_Misc_Bone_01", "=q3=Stonevault Bonebreaker", "=ds=#h1#, #w6#", "0.01%" },
        { 9423, "INV_Hammer_07", "=q3=The Jackhammer", "=ds=#h2#, #w6#", "0.01%" },
        { 9391, "INV_Misc_Shovel_02", "=q3=The Shoveler", "=ds=#h2#, #w6#, =q2=#c9#", "0.01%" },
        { 9381, "INV_Staff_17", "=q3=Earthen Rod", "=ds=#w12#", "0.01%" },
        { 9426, "INV_Weapon_Bow_01", "=q3=Monolithic Bow", "=ds=#w2#", "0.01%" },
        { 9422, "INV_Musket_02", "=q3=Shadowforge Bushmaster", "=ds=#w5#", "0.01%" },
        };

        -------------------------
        --- Scarlet Monastery ---
        -------------------------

    SMHoundmasterLoksey = {
        { 7756, "INV_Gauntlets_07", "=q3=Dog Training Gloves", "=ds=#s9#, #a2#", "53.66%" },
        { 7710, "INV_Staff_18", "=q3=Loksey's Training Stick", "=ds=#w9#", "13.96%" },
        { 0,"","","" },
        { 3456, "Ability_Hunter_BeastCall", "=q2=Dog Whistle", "=ds=#e13#", "21.33%" },
        };

    SMDoan = {
        { 34227, "INV_Jewelry_Ring_66", "=q4=Deadman's Hand",     "=ds=#s13#", "" },
        { 0,"","","" },
        { 7712, "INV_Shoulder_05", "=q3=Mantle of Doan",          "=ds=#s3#, #a1#", "41.96%" },
        { 7711, "INV_Chest_Cloth_25", "=q3=Robe of Doan",         "=ds=#s5#, #a1#", "42.86%" },
        { 7714, "INV_Weapon_ShortBlade_07", "=q3=Hypnotic Blade", "=ds=#h3#, #w4#", "39.91%" },
        { 7713, "INV_Wand_04", "=q3=Illusionary Rod",             "=ds=#w9#", "38.44%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x1#", "" },
        { 7146, "INV_Misc_Key_01", "=q2=The Scarlet Key",         "=ds=#e9#" },
        };

    SMHerod = {
        { 7719, "INV_Helmet_25", "=q3=Raging Berserker's Helm", "=ds=#s1#, #a3#", "30.62%" },
        { 7718, "INV_Shoulder_01", "=q3=Herod's Shoulder",      "=ds=#s3#, #a3#", "30.82%" },
        { 10330, "INV_Pants_03", "=q3=Scarlet Leggings",        "=ds=#s11#, #a3#", "12.75%" },
        { 7717, "INV_Weapon_Halberd_05", "=q3=Ravager",         "=ds=#h2#, #w1#", "12.86%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n43#", "" },
        { 23192, "INV_Misc_Cape_18", "=q2=Tabard of the Scarlet Crusade", "=ds=#s7#", "0.4%" },
        };

    SMFairbanks = {
        { 19507, "INV_Shoulder_27", "=q2=Inquisitor's Shawl",    "=ds=#s3#, #a1#", "15.94%" },
        { 19508, "INV_Bracer_11", "=q2=Branded Leather Bracers", "=ds=#s8#, #a2#", "16.17%" },
        { 19509, "INV_Boots_Chain_02", "=q2=Dusty Mail Boots",   "=ds=#s12#, #a3#", "17.24%" },
        };

    SMMograine = {
        { 7724, "INV_Gauntlets_19", "=q3=Gauntlets of Divinity", "=ds=#s9#, #a3#", "17.49%" },
        { 10330, "INV_Pants_03", "=q3=Scarlet Leggings", "=ds=#s11#, #a3#", "12.95%" },
        { 7723, "INV_Mace_13", "=q3=Mograine's Might", "=ds=#h2#, #w6#", "17.13%" },
        { 7726, "INV_Shield_05", "=q3=Aegis of the Scarlet Commander", "=ds=#w8#", "38.37%" },
        };

    SMWhitemane = {
        { 7720, "INV_Helmet_12", "=q3=Whitemane's Chapeau",   "=ds=#s1#, #a1#", "34.01%" },
        { 7722, "INV_Jewelry_Amulet_01", "=q3=Triune Amulet", "=ds=#s2#", "33.23%" },
        { 7721, "INV_Hammer_02", "=q3=Hand of Righteousness", "=ds=#h3#, #w6#", "18.32%" },
        { 0,"","","" },
        { 20976, "INV_Scroll_06", "=q2=Design: Citrine Pendant of Golden Healing", "=ds=#p12# (190)", "100%" },
        };

    SMVishas = {
        { 7682, "INV_Spear_01", "=q3=Torturing Poker", "=ds=#h1#, #w4#", "5.56%" },
        { 7683, "INV_Gauntlets_11", "=q3=Bloody Brass Knuckles", "=ds=#h1#, #w13#", "66.1%" },
        };

    SMIronspine = {
        { 7688, "INV_Chest_Plate15", "=q3=Ironspine's Ribcage",  "=ds=#s5#, #a3#", "32.91%" },
        { 7686, "INV_Jewelry_Ring_04", "=q3=Ironspine's Eye", "=ds=#s13#", "40.08%" },
        { 7687, "INV_Hammer_19", "=q3=Ironspine's Fist",         "=ds=#h1#, #w6#", "20.34%" },
        };

    SMAzshir = {
        { 7709, "INV_Pants_07", "=q3=Blighted Leggings", "=ds=#s11#, #a1#", "31.19%" },
        { 7731, "INV_Jewelry_Necklace_06", "=q3=Ghostshard Talisman", "=ds=#s2#", "32.71%" },
        { 7708, "INV_Wand_04", "=q3=Necrotic Wand", "=ds=#w12#", "30.72%" },
        };

    SMFallenChampion = {
        { 7691, "INV_Helmet_28", "=q3=Embalmed Shroud", "=ds=#s1#, #a1#", "38.58%" },
        { 7690, "INV_Gauntlets_32", "=q3=Ebon Vise",    "=ds=#s9#, #a2#", "37.83%" },
        { 7689, "INV_Sword_12", "=q3=Morbid Dawn",      "=ds=#h2#, #w10#", "19.15%" },
        };

    SMBloodmageThalnos = {
        { 7684, "INV_Shoulder_05", "=q3=Bloodmage Mantle", "=ds=#s3#, #a1#", "48.46%" },
        { 7685, "INV_Misc_Orb_02", "=q3=Orb of the Forgotten Seer", "=ds=#s15#", "47.07%" },
        };

    SMTrash = {
        { 7728, "INV_Chest_Cloth_25", "=q3=Beguiler Robes", "=ds=#s5#, #a1#", "0.01%" },
        { 7755, "INV_Shoulder_13", "=q3=Flintrock Shoulders", "=ds=#s3#, #a2#", "0.00%" },
        { 7727, "INV_Shoulder_23", "=q3=Watchman Pauldrons", "=ds=#s3#, #a2#", "0.01%" },
        { 7760, "INV_Pants_06", "=q3=Warchief Kilt", "=ds=#s11#, #a2#", "0.00%" },
        { 7754, "INV_Boots_05", "=q3=Harbinger Boots", "=ds=#s12#, #a2#", "0.01%" },
        { 5819, "INV_Helmet_03", "=q3=Sunblaze Coif", "=ds=#s1#, #a3#", "0.01%" },
        { 7759, "INV_Chest_Chain_11", "=q3=Archon Chestpiece", "=ds=#s5#, #a3#", "0.00%" },
        { 10328, "INV_Chest_Chain_07", "=q3=Scarlet Chestpiece", "=ds=#s5#, #a3#", "0.3%"},
        { 10332, "INV_Boots_02", "=q3=Scarlet Boots", "=ds=#s12#, #a3#", "0.1%"},
        { 2262, "INV_Jewelry_Ring_15", "=q3=Mark of Kern", "=ds=#s13#", "0.01%" },
        { 1992, "INV_Misc_Bone_OrcSkull_01", "=q3=Swampchill Fetish", "=ds=#s15#", "0.00%" },
        { 0,"","","" },
        { 10333, "INV_Bracer_03", "=q2=Scarlet Wristguards", "=ds=#s8#, #a3#", "1.6%"},
        { 10331, "INV_Gauntlets_19", "=q2=Scarlet Gauntlets", "=ds=#s9#, #a3#", "1.7%" },
        { 10329, "INV_Belt_06", "=q2=Scarlet Belt", "=ds=#s10#, #a3#", "1.6%"},
        { 5756, "INV_Weapon_ShortBlade_24", "=q3=Sliverblade", "=ds=#h1#, #w4#", "0.01%" },
        { 8226, "INV_Sword_18", "=q3=The Butcher", "=ds=#h3#, #w10#", "0.01%" },
        { 8225, "INV_Sword_30", "=q3=Tainted Pierce", "=ds=#h1#, #w10#", "0.01%" },
        { 7761, "INV_Axe_06", "=q3=Steelclaw Reaver", "=ds=#h3#, #w1#", "0.01%" },
        { 7786, "INV_Axe_14", "=q3=Headsplitter", "=ds=#h1#, #w1#", "0.01%" },
        { 7753, "INV_Axe_10", "=q3=Bloodspiller", "=ds=#h2#, #w1#", "0.01%" },
        { 7752, "INV_Hammer_17", "=q3=Dreamslayer", "=ds=#h3#, #w6#", "0.01%" },
        { 7736, "INV_Mace_11", "=q3=Fight Club", "=ds=#h1#, #w6#", "0.00%" },
        { 7730, "INV_Hammer_04", "=q3=Cobalt Crusher", "=ds=#h2#, #w6#", "0.01%" },
        { 7758, "INV_Spear_08", "=q3=Ruthless Shiv", "=ds=#w7#", "0.00%" },
        { 7757, "INV_Wand_07", "=q3=Windweaver Staff", "=ds=#w9#", "0.01%" },
        { 7787, "INV_Shield_02", "=q3=Resplendent Guardian", "=ds=#w8#", "0.01%" },
        { 7729, "INV_Weapon_Rifle_06", "=q3=Chesterfall Musket", "=ds=#w5#", "0.01%" },
        };

        ----------------------
        --- Razorfen Kraul ---
        ----------------------

    RFKRoogug = {
        { 6841, "INV_Potion_01", "=q1=Vial of Phlogiston", "=ds=#m3#" },
        };

    RFKThorncurse = {
        { 6681, "INV_Weapon_ShortBlade_10", "=q3=Thornspike", "=ds=#h1#, #w4#", "57,12%" },
        };

    RFKDeathSpeakerJargba = {
        { 6685, "INV_Shoulder_09", "=q3=Death Speaker Mantle",   "=ds=#s3#, #a1#", "40.42%" },
        { 6682, "INV_Chest_Cloth_20", "=q3=Death Speaker Robes", "=ds=#s5#, #a1#", "40.52%" },
        { 2816, "INV_Mace_07", "=q3=Death Speaker Scepter",      "=ds=#h3#, #w6#", "7.72%" },
        };

    RFKRazorfenSpearhide = {
        { 6679, "INV_Spear_05", "=q3=Armor Piercer", "=ds=#w7#", "43%" },
        };

    RFKOverlordRamtusk = {
        { 6686, "INV_Helmet_09", "=q3=Tusken Helm",         "=ds=#s1#, #a3#", "57.14%" },
        { 6687, "INV_Weapon_Halbard_01", "=q3=Corpsemaker", "=ds=#h2#, #w1#", "27.79%" },
        };

    RFKAgathelos = {
        { 6690, "INV_Pants_14", "=q3=Ferine Leggings",     "=ds=#s11#, #a2#", "49.21%" },
        { 6691, "INV_Misc_Bone_06", "=q3=Swinetusk Shank", "=ds=#h1#, #w4#", "24.85%" },
        };

    RFKBlindHunter = {
        { 6697, "INV_Shoulder_05", "=q3=Batwing Mantle", "=ds=#s3#, #a1#", "27.65%" },
        { 6695, "INV_Jewelry_Necklace_04", "=q3=Stygian Bone Amulet", "=ds=#s2#", "22.24%" },
        { 6696, "INV_Weapon_Bow_12", "=q3=Nightstalker Bow", "=ds=#w2#", "25.12%" },
        };

    RFKCharlgaRazorflank = {
        { 6693, "INV_Misc_Bone_05", "=q3=Agamaggan's Clutch", "=ds=#s13#", "32.15%" },
        { 6692, "INV_Axe_18", "=q3=Pronged Reaver",           "=ds=#h1#, #w1#", "15.43%" },
        { 6694, "INV_Shield_02", "=q3=Heart of Agamaggan",    "=ds=#w8#", "30.24%" },
        { 0,"","","" },
        { 17008, "INV_Scroll_03", "=q1=Small Scroll",         "=ds=#m2# (#m6#)" },
        { 5793, "INV_Misc_Organ_01", "=q1=Razorflank's Heart", "=ds=#m3#", "100%" },
        { 5792, "INV_Jewelry_Talisman_01", "=q1=Razorflank's Medallion", "=ds=#m3#", "100%" },
        };

    RFKEarthcallerHalmgar = {
        { 6688, "INV_Helmet_17", "=q3=Whisperwind Headdress", "=ds=#s1#, #a2#", "43.75%" },
        { 6689, "INV_Staff_01", "=q3=Wind Spirit Staff",      "=ds=#w9#", "42.66%" },
        };

    RFKTrash = {
        { 2264, "INV_Shoulder_08", "=q3=Mantle of Thieves", "=ds=#s3#, #a2#", "0.02%" },
        { 1978, "INV_Gauntlets_04", "=q3=Wolfclaw Gloves", "=ds=#s9#, #a2#", "0.02%" },
        { 1488, "INV_Chest_Chain", "=q3=Avenger's Armor", "=ds=#s5#, #a3#", "0.01%" },
        { 4438, "INV_Bracer_03", "=q3=Pugilist Bracers", "=ds=#s8#, #a3#", "0.01%" },
        { 2039, "INV_Jewelry_Ring_02", "=q3=Plains Ring", "=ds=#s13#", "0.02%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        {  776, "INV_Weapon_ShortBlade_02", "=q3=Vendetta", "=ds=#h1#, #w4#", "0.01%" },
        { 1727, "INV_Sword_26", "=q3=Sword of Decay", "=ds=#h3#, #w10#", "0.02%" },
        { 1975, "INV_Sword_25", "=q3=Pysan's Old Greatsword", "=ds=#h2#, #w10#", "0.02%" },
        { 1976, "INV_Hammer_16", "=q3=Slaghammer", "=ds=#h2#, #w6#", "0.02%" },
        { 2549, "INV_Staff_25", "=q3=Staff of the Shade", "=ds=#w9#", "0.02%" },
        };

        ------------------------
        --- Blackrock Dephts ---
        ------------------------

    BRDPyron = {
        { 14486, "Inv_Scroll_03", "=q3=Pattern: Cloak of Fire", "=ds=#p8# (275)", "17.95%" },
        };

    BRDLordRoccor = {
        { 22234, "INV_Shoulder_09", "=q3=Mantle of Lost Hope",        "=ds=#s3#, #a1#", "20.48%" },
        { 11632, "INV_Shoulder_26", "=q3=Earthslag Shoulders",        "=ds=#s3#, #a4#", "19.99%" },
        { 22397, "INV_Relics_IdolofFerocity", "=q3=Idol of Ferocity", "=ds=#s16#, #w14#", "19.58%" },
        { 11631, "INV_Shield_02", "=q3=Stoneshell Guard",             "=ds=#w8#", "22.06%" },
        { 11630, "INV_Ammo_Bullet_02", "=q3=Rockshard Pellets", "=ds=#w18#", "16.82%" },
        { 0,"","","" },
        { 11813, "INV_Misc_Note_01", "=q2=Formula: Smoking Heart of the Mountain", "=ds=#p4# (265)", "14.79%" },
        { 11811, "INV_Misc_Gem_Bloodstone_01", "=q3=Smoking Heart of the Mountain", "=ds=#s14#" },
        };

    BRDHighInterrogatorGerstahn = {
        { 11626, "INV_Misc_Cape_18", "=q3=Blackveil Cape",                 "=ds=#s4#", "15.98%" },
        { 11624, "INV_Shoulder_25", "=q3=Kentic Amice",                    "=ds=#s3#, #a1#", "22.45%" },
        { 22240, "INV_Boots_Chain_04", "=q3=Greaves of Withering Despair", "=ds=#s12#, #a3#", "16.81%" },
        { 11625, "INV_Misc_Orb_03", "=q3=Enthralled Sphere",               "=ds=#s15#", "23.14%" },
        { 0,"","","" },
        { 11140, "INV_Misc_Key_10", "=q1=Prison Cell Key", "=ds=#e9#" },
        };

    BRDArena = {
        { 11677, "INV_Misc_Cape_19", "=q3=Graverot Cape", "=ds=#s4# =q2=#brd1#", "23.07%" },
        { 11675, "INV_Boots_01", "=q3=Shadefiend Boots", "=ds=#s12#, #a2# =q2=#brd1#", "25.84%" },
        { 11731, "INV_Boots_01", "=q3=Savage Gladiator Greaves", "=ds=#s12#, #a3# =q2=#brd1#", "15.14%" },
        { 11678, "INV_Chest_Plate08", "=q3=Carapace of Anub'shiah", "=ds=#s5#, #a4# =q2=#brd1#", "15.78%" },
        { 0,"","","" },
        { 11685, "INV_Shoulder_13", "=q3=Splinthide Shoulders", "=ds=#s3#, #a2# =q2=#brd2#", "24.49%" },
        { 11686, "INV_Belt_12", "=q3=Girdle of Beastial Fury", "=ds=#s10#, #a2# =q2=#brd2#", "15.85%" },
        { 11679, "INV_Bracer_13", "=q3=Rubicund Armguards", "=ds=#s8#, #a3# =q2=#brd2#", "25.13%" },
        { 11730, "INV_Gauntlets_04", "=q3=Savage Gladiator Grips", "=ds=#s9#, #a3# =q2=#brd2#", "14.12%"},
        { 0,"","","" },
        { 11726, "INV_Chest_Chain_15", "=q4=Savage Gladiator Chain", "=ds=#s5#, #a3# =q2=#brd3#", "14.52%" },
        { 22271, "INV_Pants_Leather_21", "=q3=Leggings of Frenzied Magic", "=ds=#s11#, #a2# =q2=#brd3#", "23.24%" },
        { 11729, "INV_Helmet_01", "=q3=Savage Gladiator Helm", "=ds=#s1#, #a3# =q2=#brd3#, #brd5#", "10.08%" },
        { 11722, "INV_Shoulder_30", "=q3=Dregmetal Spaulders", "=ds=#s3#, #a3# =q2=#brd4#", "15.07%" },
        { 11703, "INV_Belt_16", "=q3=Stonewall Girdle", "=ds=#s10#, #a4# =q2=#brd4#", "31.45%" },
        { 22270, "INV_Boots_Plate_02", "=q3=Entrenching Boots", "=ds=#s12#, #a4# =q2=#brd4#", "11.97%" },
        { 22257, "INV_Jewelry_Ring_36", "=q3=Bloodclot Band", "=ds=#s13# =q2=#brd3#", "26.28%" },
        { 22266, "INV_Spear_01", "=q3=Flarethorn", "=ds=#h3#, #w4# =q2=#brd3#", "17.98%" },
        { 11702, "INV_Axe_12", "=q3=Grizzle's Skinner", "=ds=#h3#, #w1# =q2=#brd4#", "20.62%" },
        { 11610, "INV_Scroll_03", "=q3=Plans: Dark Iron Pulverizer", "=ds=#p2# (265) =q2=#brd4#", "69.76%" },
        { 0,"","","" },
        { 11634, "INV_Gauntlets_12", "=q3=Silkweb Gloves", "=ds=#s9#, #a1# =q2=#brd5#", "24.02%" },
        { 11633, "INV_Chest_Plate02", "=q3=Spiderfang Carapace", "=ds=#s5#, #a4# =q2=#brd5#", "20.61%" },
        { 11635, "INV_Weapon_ShortBlade_10", "=q3=Hookfang Shanker", "=ds=#h1#, #w4# =q2=#brd5#", "17.26%" },
        { 0,"","","" },
        { 11662, "INV_Belt_29", "=q3=Ban'thok Sash", "=ds=#s10#, #a1# =q2=#brd6#", "23.77%" },
        { 11665, "INV_Gauntlets_15", "=q3=Ogreseer Fists", "=ds=#s9#, #a2# =q2=#brd6#", "28.16%" },
        { 11728, "INV_Pants_03", "=q3=Savage Gladiator Leggings", "=ds=#s11#, #a3# =q2=#brd6#", "14.95%" },
        { 11824, "INV_Jewelry_Ring_08", "=q3=Cyclopean Band", "=ds=#s13# =q2=#brd6#", "18.37%" },
        };

    BRDTheldren = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n17#" },
        { 22330, "INV_Misc_Cape_16", "=q3=Shroud of Arcane Mastery", "=ds=#s4#", "19.73%" },
        { 22305, "INV_Shoulder_05", "=q3=Ironweave Mantle", "=ds=#s3#, #a1#", "30.39%" },
        { 22317, "INV_Gauntlets_11", "=q3=Lefty's Brass Knuckle", "=ds=#h1#, #w13#", "26.15%" },
        { 22318, "INV_Weapon_Bow_12", "=q3=Malgen's Long Bow", "=ds=#w2#", "22.88%" },
        { 0,"","","" },
        { 22047, "INV_Jewelry_Necklace_28", "=q1=Top Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        };

    BRDHoundmaster = {
        { 11623, "INV_Misc_Cape_20", "=q3=Spritecaster Cape", "=ds=#s4#", "32.09%" },
        { 11626, "INV_Misc_Cape_18", "=q3=Blackveil Cape", "=ds=#s4#", "0.60%" },
        { 11627, "INV_Boots_01", "=q3=Fleetfoot Greaves", "=ds=#s12#, #a3#", "32.09%" },
        { 11628, "INV_Weapon_Bow_04", "=q3=Houndmaster's Bow", "=ds=#w2#", "12.14%" },
        { 11629, "INV_Weapon_Rifle_07", "=q3=Houndmaster's Rifle", "=ds=#w5#", "11.18%" },
        };

    BRDForgewright = {
        { 11000, "INV_Misc_Key_08", "=q1=Shadowforge Key", "=q1=#m4#: =ds=#e9#" },
        };

    BRDPyromantLoregrain = {
        { 11747, "INV_Chest_Cloth_07", "=q3=Flamestrider Robes", "=ds=#s5#, #a2#", "18.10%" },
        { 11749, "INV_Pants_03", "=q3=Searingscale Leggings",    "=ds=#s11#, #a3#", "21.29%" },
        { 11750, "INV_Staff_18", "=q3=Kindling Stave",           "=ds=#w9#", " 16.19%" },
        { 11748, "INV_Staff_13", "=q3=Pyric Caduceus",           "=ds=#w12#", "30.20%" },
        { 0,"","","" },
        { 11207, "INV_Misc_Note_01", "=q2=Formula: Enchant Weapon - Fiery Weapon", "=ds=#p4# (265)", "13.32%" },
        };

    BRDTheVault = {
        { 0, "INV_Box_01", "=q6=#x3#", "" },
        { 11309, "INV_Misc_Gem_Bloodstone_02", "=q1=The Heart of the Mountain", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x5#", "" },
        { 22256, "INV_Gauntlets_17", "=q3=Mana Shaping Handwraps", "=ds=#s9#, #a1#", "4.49%" },
        { 11929, "INV_Pants_11", "=q3=Haunting Specter Leggings", "=ds=#s11#, #a1#", "21.12%" },
        { 11926, "INV_Chest_Chain_07", "=q3=Deathdealer Breastplate", "=ds=#s5#, #a3#", "21.57%" },
        { 22205, "INV_Bracer_14", "=q3=Black Steel Bindings", "=ds=#s8#, #a4#", "4.24%" },
        { 22255, "INV_Jewelry_Ring_04", "=q3=Magma Forged Band", "=ds=#s13#", "4.02%" },
        { 11920, "INV_Axe_13", "=q3=Wraith Scythe", "=ds=#h3#, #w1#", "21.12%" },
        { 11923, "INV_Hammer_07", "=q3=The Hammer of Grace", "=ds=#h3#, #w6#", "19.84%" },
        { 22254, "INV_Wand_02", "=q3=Wand of Eternal Light", "=ds=#w12#", "3.65%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x4#", "" },
        { 11752, "INV_Potion_69", "=q1=Black Blood of the Tormented", "=ds=#m3#", "44.48%" },
        { 11751, "Spell_Fire_LavaSpawn", "=q1=Burning Essence", "=ds=#m3#", "39.35%" },
        { 11753, "Spell_Shadow_EvilEye", "=q1=Eye of Kajal", "=ds=#m3#", "39.95%" },
        { 0,"","","" },
        };

    BRDWarderStilgiss = {
        { 11782, "INV_Shoulder_02", "=q3=Boreal Mantle",           "=ds=#s3#, #a1#", "18.38%" },
        { 22241, "INV_Shoulder_07", "=q3=Dark Warder's Pauldrons", "=ds=#s3#, #a2#", "18.38%" },
        { 11783, "INV_Belt_33", "=q3=Chillsteel Girdle",           "=ds=#s10#, #a3#", "20.50%" },
        { 11784, "INV_Sword_23", "=q3=Arbiter's Blade",            "=ds=#h3#, #w10#", "21.54%" },
        };

    BRDVerek = {  
        { 22242, "INV_Belt_18", "=q3=Verek's Leash", "=ds=#s10#, #a3#", "9.78%" },
        { 11755, "INV_Misc_Bandage_14", "=q3=Verek's Collar", "=ds=#s2#", "9.54%" },
        };

    BRDFineousDarkvire = {
        { 11839, "INV_Helmet_44", "=q3=Chief Architect's Monocle",   "=ds=#s1#, #a1#", "15.28%" },
        { 11841, "INV_Pants_09", "=q3=Senior Designer's Pantaloons", "=ds=#s11#, #a1#", "21.25%" },
        { 11842, "INV_Shoulder_15", "=q3=Lead Surveyor's Mantle",    "=ds=#s3#, #a3#", "20.83%" },
        { 22223, "INV_Helmet_20", "=q3=Foreman's Head Protector",    "=ds=#s1#, #a4#", "19.73%" },
        { 0,"","","" },
        { 11840, "INV_Shirt_Black_01", "=q1=Master Builder's Shirt", "#s6#", "3.9%" },
        { 0,"","","" },
        { 10999, "INV_Hammer_23", "=q1=Ironfel", "=ds=#m3#", "100%" },
        };

    BRDLordIncendius = {
        { 11768, "INV_Bracer_10", "=q3=Incendic Bracers", "=ds=#s8#, #a1#", "1.30%" },
        { 11766, "INV_Bracer_05", "=q3=Flameweave Cuffs", "=ds=#s8#, #a1# =q2=#m16#", "18.88%" },
        { 11764, "INV_Bracer_02", "=q3=Cinderhide Armsplints", "=ds=#s8#, #a2# =q2=#m16#", "18.33%" },
        { 11765, "INV_Bracer_18", "=q3=Pyremail Wristguards", "=ds=#s8#, #a3# =q2=#m16#", "18.85%" },
        { 11767, "INV_Bracer_18", "=q3=Emberplate Armguards", "=ds=#s8#, #a4# =q2=#m16#", "19.24%" },
        { 19268, "INV_Misc_Ticket_Tarot_Elemental_01", "=q3=Ace of Elementals", "=ds=#e16#", "2.10%" },
        { 0,"","","" },
        { 21987, "INV_Ore_Thorium_01", "=q1=Incendicite of Incendius", "=ds=#m3#" },
        { 11126, "INV_Misc_Rune_04", "=q1=Tablet of Kurniya", "=ds=#m3#" },
        };

    BRDBaelGar = {
        { 11807, "INV_Belt_11", "=q3=Sash of the Burning Heart", "=ds=#s10#, #a1#", "13.59%" },
        { 11802, "INV_Pants_04", "=q3=Lavacrest Leggings",       "=ds=#s11#, #a4#", "26.75%" },
        { 11805, "INV_Hammer_09", "=q3=Rubidium Hammer",         "=ds=#h3#, #w6#", "17.02%" },
        { 11803, "INV_Hammer_09", "=q3=Force of Magma",          "=ds=#h2#, #w6#", "27.47%" },
        };

    BRDGeneralAngerforge = {
        { 11821, "INV_Pants_09", "=q3=Warstrife Leggings",               "=ds=#s11#, #a2#", "16.41%" },
        { 11820, "INV_Chest_Plate04", "=q3=Royal Decorated Armor",       "=ds=#s5#, #a3#", "18.55%" },
        { 11810, "INV_Jewelry_Amulet_01", "=q3=Force of Will",           "=ds=#s14#", "12.97%" },
        { 11817, "INV_Sword_25", "=q3=Lord General's Sword",             "=ds=#h3#, #w10# ", "14.72%" },
        { 11816, "INV_Weapon_Halberd_06", "=q3=Angerforge's Battle Axe", "=ds=#h2#, #w1#", "16.41%" },
        { 0,"","","" },
        { 11464, "INV_Misc_Rune_07", "=q1=Marshal Windsor's Lost Information", "=ds=#m3#" },
        };

    BRDGolemLordArgelmach = {
        { 11822, "INV_Boots_05", "=q3=Omnicast Boots",         "=ds=#s12#, #a1#", "26.73%" },
        { 11823, "INV_Pants_13", "=q3=Luminary Kilt",          "=ds=#s11#, #a2#", "25.73%" },
        { 11669, "INV_Jewelry_Ring_05", "=q3=Naglering",       "=ds=#s13#", "22.92%" },
        { 11819, "INV_Jewelry_Talisman_06", "=q3=Second Wind", "=ds=#s14#", "5.75%" },
        { 0,"","","" },
        { 21956, "INV_Scroll_06", "=q2=Design: Dark Iron Scorpid", "=ds=#p12# (300)" },
        { 0,"","","" },
        { 11268, "INV_Misc_Head_Dwarf_01", "=q1=Head of Argelmach", "=ds=#m3#" },
        { 11465, "INV_Misc_Rune_07", "=q1=Marshal Windsor's Lost Information", "=ds=#m3#" },
        };

    BRDGuzzler = {
        { 0, "INV_Box_01", "=q6=#n48#", "" },
        { 11735, "INV_Helmet_46", "=q3=Ragefury Eyepatch", "=ds=#s1#, #a2#", "8.11%" },
        { 18043, "INV_Boots_08", "=q3=Coal Miner Boots", "=ds=#s12#, #a2#", "23.87%" },
        { 22275, "INV_Boots_08", "=q3=Firemoss Boots", "=ds=#s12#, #a2#", "23.87%" },
        { 18044, "INV_Drink_04", "=q3=Hurley's Tankard", "=ds=#h3#, #w6#", "31.02%" },
        { 11312, "INV_Misc_Note_03", "=q1=Lost Thunderbrew Recipe", "=ds=#m3#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n49#", "" },
        { 22212, "INV_Shoulder_16", "=q3=Golem Fitted Pauldrons", "=ds=#s3#, #a3#", "26.04%" },
        { 11745, "INV_Gauntlets_22", "=q3=Fists of Phalanx", "=ds=#s9#, #a4#", "29.79%" },
        { 11744, "INV_Gauntlets_11", "=q3=Bloodfist", "=ds=#h1#, #w13#", "28.48%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n50#", "" },
        { 11612, "INV_Scroll_03", "=q3=Plans: Dark Iron Plate", "=ds=#p2# (285)", "22.20%" },
        { 2662, "INV_Misc_Quiver_06", "=q2=Ribbly's Quiver", "=ds=#m13# #w19#", "17.03%" },
        { 2663, "INV_Misc_Ammo_Bullet_01", "=q2=Ribbly's Bandolier", "=ds=#m13# #w20#", "15.73%" },
        { 11742, "INV_Misc_Bag_20", "=q2=Wayfarer's Knapsack", "=ds=#m13# #e1#", "25.07%" },        
        { 11313, "INV_Misc_Head_Orc_01", "=q1=Ribbly's Head", "=ds=#m3#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#n51#", "" },
        { 12793, "INV_Chest_Leather_01", "=q3=Mixologist's Tunic", "=ds=#s5#, #a2#", "24.87%" },
        { 12791, "INV_Drink_10", "=q3=Barman Shanker", "=ds=#h3#, #w4#", "6.97%" },
        { 13483, "INV_Scroll_06", "=q2=Recipe: Transmute Fire to Earth", "=ds=#p1# (275)" },
        { 18653, "INV_Scroll_06", "=q2=Schematic: Goblin Jumper Cables XL", "=ds=#p5# (265)", "14.13%" },
        { 15759, "INV_Scroll_03", "=q1=Pattern: Black Dragonscale Breastplate", "=ds=#p7# (290)" },
        { 11602, "INV_Misc_Key_03", "=q1=Grim Guzzler Key", "=ds=#e9#" },
        { 11325, "INV_Drink_04", "=q1=Dark Iron Ale Mug", "=ds=#m3#" },
        };

    BRDFlamelash = {
        { 11808, "Spell_Fire_Fire", "=q4=Circle of Flame",              "=ds=#s1#, #a1#", "0.84%" },
        { 0,"","","" },
        { 11812, "INV_Misc_Cape_18", "=q3=Cape of the Fire Salamander", "=ds=#s4#", "25.25%" },
        { 11814, "INV_Gauntlets_04", "=q3=Molten Fists",                "=ds=#s9#, #a3#", "27.88%" },
        { 11832, "INV_Jewelry_Amulet_07", "=q3=Burst of Knowledge",     "=ds=#s14#", "14.61%" },
        { 11809, "INV_Spear_01", "=q3=Flame Wrath",                     "=ds=#w7#", "18.69%" },
        { 0,"","","" },
        { 23320, "INV_Misc_StoneTablet_11", "=q3=Tablet of Flame Shock VI", "=ds=#e10# =q1=#m1# =ds=#c7#" },
        };

    BRDPanzor = {
        { 22245, "INV_Boots_Cloth_05", "=q3=Soot Encrusted Footwear", "=ds=#s12#,#a1#", "22.06%" },
        { 11787, "INV_Boots_Plate_01", "=q3=Shalehusk Boots",         "=ds=#s12#, #a4#", "19.96%" },
        { 11786, "INV_Sword_47", "=q3=Stone of the Earth",            "=ds=#h2#, #w10#", "20.38%" },
        { 11785, "INV_Shield_06", "=q3=Rock Golem Bulwark",           "=ds=#w8#", "21.22%" },
        };

    BRDTomb = {
        { 0, "INV_Box_01", "=q6=#x2#", "" },
        { 11929, "INV_Pants_11", "=q3=Haunting Specter Leggings", "=ds=#s11#, #a1#", "22.60%" },
        { 11925, "INV_Helmet_41", "=q3=Ghostshroud", "=ds=#s1#, #a2#", "21.63%" },
        { 11926, "INV_Chest_Chain_07", "=q3=Deathdealer Breastplate", "=ds=#s5#, #a3#", "22.08%" },
        { 11927, "INV_Pants_04", "=q3=Legplates of the Eternal Guardian", "=ds=#s11#, #a4#", "65.45%" },
        { 11922, "INV_Weapon_ShortBlade_15", "=q3=Blood-etched Blade", "=ds=#h3#, #w4#", "22.05%" },
        { 11920, "INV_Axe_13", "=q3=Wraith Scythe", "=ds=#h3# #w1#", "22.61%" },
        { 11923, "INV_Hammer_07", "=q3=The Hammer of Grace", "=ds=#h3#, #w6#", "21.29%" },
        { 11921, "INV_Hammer_08", "=q3=Impervious Giant", "=ds=#h2#, #w6#", "22.23%" },
        };

    BRDLyceum = {
        { 0, "INV_Box_01", "=q6=#n44#", "" },
        { 11885, "INV_Torch_Lit", "=q1=Shadowforge Torch", "=ds=#m20#" },
        };

    BRDMagmus = {
        { 11746, "INV_Helmet_23", "=q3=Golem Skull Helm",           "=ds=#s1#, #a4#", "20.46%" },
        { 11935, "INV_Misc_Orb_05", "=q3=Magmus Stone",             "=ds=#s15#", "21.26%" },
        { 22395, "INV_Relics_TotemofRage", "=q3=Totem of Rage",     "=ds=#s16#, #w15#", "10.09%" },
        { 22400, "INV_Relics_LibramofTruth", "=q3=Libram of Truth", "=ds=#s16#, #w16#", "9.75%" },
        { 22208, "INV_Hammer_10", "=q3=Lavastone Hammer",           "=ds=#h2#, #w6#", "22.79%" },
        };

    BRDImperatorDagranThaurissan = {
        { 11684, "Spell_Frost_FrostBrand", "=q4=Ironfoe",              "=ds=#h3#, #w6#", "0.46%" },
        { 0,"","","" },
        { 11930, "INV_Misc_Cape_20", "=q3=The Emperor's New Cape",     "=ds=#s4#", "16.16%" },
        { 11924, "INV_Chest_Cloth_16", "=q3=Robes of the Royal Crown", "=ds=#s5#, #a1#", "15.18%" },
        { 22204, "INV_Bracer_10", "=q3=Wristguards of Renown",         "=ds=#s8#, #a2#", "12.92%" },
        { 22207, "INV_Belt_28", "=q3=Sash of the Grand Hunt",          "=ds=#s10#, #a3#", "15.12%" },
        { 11933, "INV_Misc_Gem_Sapphire_01", "=q3=Imperial Jewel",     "=ds=#s2#", "15.99%" },
        { 11934, "INV_Jewelry_Ring_24", "=q3=Emperor's Seal",       "=ds=#s13#", "15.41%" },
        { 11815, "INV_Jewelry_Talisman_01", "=q3=Hand of Justice",         "=ds=#s14#", "10.43%" },
        { 11931, "INV_Axe_22", "=q3=Dreadforge Retaliator",            "=ds=#h2#, #w1#", "15.76%" },
        { 11932, "INV_Staff_30", "=q3=Guiding Stave of Wisdom",        "=ds=#w9#", "15.01%" },
        { 11928, "INV_Mace_13", "=q3=Thaurissan's Royal Scepter",      "=ds=#s15#", " 12.86%" },
        { 0,"","","" },
        { 12033, "INV_Misc_Bag_17", "=q1=Thaurissan Family Jewels", "=ds=#e7# #e1#", "2.2%" },
        { 0,"","","" },
        { 21524, "INV_Helmet_67", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        };

    BRDPrincess = {
        { 12554, "INV_Gauntlets_32", "=q3=Hands of the Exalted Herald", "=ds=#s9#, #a1#", "11.91%" },
        { 12556, "INV_Boots_Wolf", "=q3=High Priestess Boots", "=ds=#s12#, #a1#", "10.26%" },
        { 12557, "INV_Shoulder_25", "=q3=Ebonsteel Spaulders", "=ds=#s3#, #a4#", "12.11%" },
        { 12553, "INV_Boots_02", "=q3=Swiftwalker Boots", "=ds=#s12#, #a2#", "11.05%" },
        };

    BRDBSPlans = {
        { 11614, "INV_Scroll_06", "=q2=Plans: Dark Iron Mail", "=ds=#p2# (270)", "13.38%" },
        { 11615, "INV_Scroll_06", "=q2=Plans: Dark Iron Shoulders", "=ds=#p2# (280)", "7.65%" },
        };

    BRDTrash = {
        { 12552, "INV_Misc_Cape_18", "=q3=Blisterbane Wrap", "=ds=#s4#", "0.01%" },
        { 12551, "INV_Misc_Cape_21", "=q3=Stoneshield Cloak", "=ds=#s4#", "0.01%" },
        { 12542, "INV_Chest_Cloth_40", "=q3=Funeral Pyre Vestment", "=ds=#s5#, #a1#", "0.02%" },
        { 12546, "INV_Bracer_05", "=q3=Aristocratic Cuffs", "=ds=#s8#, #a1#", "0.01%" },
        { 12550, "INV_Bracer_17", "=q3=Runed Golem Shackles", "=ds=#s8#, #a2#", "0.02%" },
        { 12547, "INV_Gauntlets_23", "=q3=Mar Alom's Grip", "=ds=#s9#, #a2#", "0.01%" },
        { 12549, "INV_Helmet_10", "=q3=Braincage", "=ds=#s1#, #a3#", "0.02%" },
        { 12555, "INV_Boots_Plate_06", "=q3=Battlechaser's Greaves", "=ds=#s12#, #a4#", "0.01%" },
        { 12531, "INV_Weapon_ShortBlade_03", "=q3=Searing Needle", "=ds=#h3#, #w4#", "0.02%" },
        { 12535, "INV_Sword_41", "=q3=Doomforged Straightedge", "=ds=#h1#, #w10#", "0.01%" },
        { 12527, "INV_Axe_13", "=q3=Ribsplitter", "=ds=#h3#, #w1# =q2=#m16#", "0.02%" },
        { 12528, "INV_Hammer_07", "=q3=The Judge's Gavel", "=ds=#h2#, #w6#", "0.02%" },
        { 12532, "INV_Wand_07", "=q3=Spire of the Stoneshaper", "=ds=#w9#", "0.01%" },
        { 0,"","","" },
        { 0,"","","" },
        { 15781, "INV_Scroll_05", "=q3=Pattern: Black Dragonscale Leggings", "=ds=#p7# (300) =q1=#n75#", "1.93%" },
        { 15770, "INV_Scroll_03", "=q3=Pattern: Black Dragonscale Shoulders", "=ds=#p7# (300) =q1=#n76#", "1.88%" },
        { 16053, "INV_Scroll_06", "=q2=Schematic: Master Engineer's Goggles", "=ds=#p5# (290) =q1=#n77#", "0.45%" },
        { 16049, "INV_Scroll_06", "=q2=Schematic: Dark Iron Bomb", "=ds=#p5# (285) =q1=#n78#", "1.02%" },
        { 16048, "INV_Scroll_06", "=q2=Schematic: Dark Iron Rifle", "=ds=#p5# (275) =q1=#n79#", "0.98%" },
        { 18654, "INV_Scroll_06", "=q2=Schematic: Gnomish Alarm-O-Bot", "=ds=#p5# (265) =q1=#n78#", "1.88%" },
        { 18661, "INV_Scroll_06", "=q2=Schematic: World Enlarger", "=ds=#p5# (260) =q1=#n78#", "2.00%" },
        { 0,"","","" },
        { 11754, "INV_Misc_Gem_01", "=q2=Black Diamond", "#e8#", "5.0%" },
        { 11078, "INV_Misc_Key_03", "=q1=Relic Coffer Key", "=ds=#e9#" },
        { 18945, "INV_Enchant_DustSoul", "=q1=Dark Iron Residue", "=ds=#m3#" },
        { 11468, "INV_Misc_Bag_09_Black", "=q1=Dark Iron Fanny Pack", "=ds=#m3#" },
        { 11446, "INV_Misc_Note_05", "=q1=A Crumpled Up Note", "=ds=#m2#" },
        };

        ----------------------
        --- Ragefire Chasm ---
        ----------------------

    RFCTaragaman = {
        { 14149, "INV_Misc_Cape_18", "=q3=Subterranean Cape", "=ds=#s4#", "31.59%" },
        { 14148, "INV_Bracer_13", "=q3=Crystalline Cuffs", "=ds=#s8#, #a1#", "33.91%" },
        { 14145, "INV_Weapon_ShortBlade_12", "=q3=Cursed Felblade", "=ds=#h3#, #w10#", "15.98%" },
        { 0,"","","" },
        { 14540, "INV_Misc_Organ_01", "=q1=Taragaman the Hungerer's Heart", "=ds=#m3#", "100%" },
        };

    RFCJergosh = {
        { 14150, "INV_Chest_Cloth_24", "=q3=Robe of Evocation", "=ds=#s5#, #a1#", "36.40%" },
        { 14147, "INV_Bracer_07", "=q3=Cavedweller Bracers", "=ds=#s8#, #a3#", "34.35%" },
        { 14151, "INV_Weapon_ShortBlade_25", "=q3=Chanting Blade", "=ds=#h1#, #w4#", "17.10%" },
        };

    RFCZelemartheWrathful = {
        { 24225, "INV_Potion_55", "=q1=Blood of the Wrathful", "=ds=#m3#", "100%" },
        };

        -----------------------
        --- Shadowfang Keep ---
        -----------------------

    BSFDeathswornCaptain = {
        { 6642, "INV_Chest_Chain_05", "=q3=Phantom Armor", "=ds=#s5#, #a3#", "30.49%" },
        { 6641, "INV_Sword_17", "=q3=Haunting Blade", "=ds=#h2#, #w10#", "58.60%" },
        };

    BSFRethilgore = {
        { 5254, "INV_Shoulder_08", "=q3=Rugged Spaulders", "=ds=#s3#, #a2#", "84.73%" },
        };

    BSFFelSteed = {
        { 6341, "INV_Misc_Lantern_01", "=q3=Eerie Stable Lantern", "=ds=#s15#", "5.48%" },
        { 0,"","","" },
        { 932, "INV_Misc_Bag_08", "=q1=Fel Steed Saddlebags", "=ds=#m12# #e1#", "16.46%" },
        };

    BSFRazorclawtheButcher = {
        { 6226, "INV_Chest_Cloth_24", "=q3=Bloody Apron", "=ds=#s5#, #a1#", "39.47%" },
        { 6633, "INV_Sword_16", "=q3=Butcher's Slicer", "=ds=#h1#, #w10#", "39.53%" },
        { 1292, "INV_Axe_23", "=q3=Butcher's Cleaver", "=ds=#h1#, #w1#", "8.70%" },
        };

    BSFSilverlaine = {
        { 6321, "INV_Belt_29", "=q3=Silverlaine's Family Seal", "=ds=#s13#", "18.91%" },
        { 6323, "INV_Mace_02", "=q3=Baron's Scepter", "=ds=#h3#, #w6#", "37.93%" },
        };

    BSFSpringvale = {
        { 3191, "INV_Axe_06", "=q3=Arced War Axe", "=ds=#h2#, #w1#", "31.73%" },
        { 6320, "INV_Shield_03", "=q3=Commander's Crest", "=ds=#w8#", "27.71%" },
        };

    BSFOdotheBlindwatcher = {
        { 6319, "INV_Belt_03", "=q3=Girdle of the Blindwatcher", "=ds=#s10#, #a2#", "57.15%" },
        { 6318, "INV_Staff_27", "=q3=Odo's Ley Staff", "=ds=#w9#", "29.97%" },
        };

    BSFFenrustheDevourer = {
        { 6340, "INV_Misc_Pelt_Wolf_02", "=q3=Fenrus' Hide", "=ds=#s4#", "58.02%" },
        { 3230, "INV_Bracer_07", "=q3=Black Wolf Bracers", "=ds=#s8#, #a2#", "14.76%" },
        };

    BSFArugalsVoidwalker = {
        { 5943, "INV_Bracer_03", "=q2=Rift Bracers", "=ds=#s8#, #a3#", "3%" },
        };

    BSFWolfMasterNandos = {
        { 6314, "INV_Misc_Cape_10", "=q3=Wolfmaster Cape", "=ds=#s4#", "33.25%" },
        { 3748, "INV_Shoulder_05", "=q3=Feline Mantle", "=ds=#s3#, #a1#", "48.55%" },
        };

    BSFArchmageArugal = {
        { 6324, "INV_Chest_Cloth_31", "=q3=Robes of Arugal",    "=ds=#s5#, #a1#", "30.50%" },
        { 6392, "INV_Belt_10", "=q3=Belt of Arugal",            "=ds=#s10#, #a1#", "30.51%" },
        { 6220, "INV_Weapon_ShortBlade_25", "=q3=Meteor Shard", "=ds=#h1#, #w4#", "15.78%" },
        };

    BSFQuestItems = {
        { 24224, "INV_Crate_02", "=q1=Crate of Bloodforged Ingots", "=ds=#m3#" },
        { 6895, "INV_Hammer_09", "=q1=Jordan's Smithing Hammer", "=ds=#m3#" },
        { 6283, "INV_Misc_Book_08", "=q1=The Book of Ur", "=ds=#m3#" },
        };

    BSFTrash = {
        { 2292, "INV_Chest_Cloth_36", "=q3=Necrology Robes", "=ds=#s5#, #a1#", "0.01%" },
        { 1974, "INV_Bracer_07", "=q3=Mindthrust Bracers", "=ds=#s8#, #a1#", "0.02%" },
        { 1489, "INV_Chest_Leather_08", "=q3=Gloomshroud Armor", "=ds=#s5#, #a2#", "0.01%" },
        { 1935, "INV_Weapon_ShortBlade_24", "=q3=Assassin's Blade", "=ds=#h1#, #w4#", "0.01%" },
        { 1482, "INV_Sword_13", "=q3=Shadowfang", "=ds=#h3#, #w10#", "0.01%" },
        { 2205, "INV_Sword_41", "=q3=Duskbringer", "=ds=#h2#, #w10#", "0.01%" },
        { 1318, "INV_ThrowingAxe_06", "=q3=Night Reaver", "=ds=#h2#, #w1#", "0.01%" },
        { 2807, "INV_Axe_24", "=q3=Guillotine Axe", "=ds=#h3#, #w1#", "0.01%" },
        { 1483, "INV_Hammer_08", "=q3=Face Smasher", "=ds=#h1#, #w6#", "0.02%" },
        { 3194, "INV_Mace_01", "=q3=Black Malice", "=ds=#h2#, #w6#", "0.02%" },
        { 1484, "INV_Wand_04", "=q3=Witching Stave", "=ds=#w9#", "0.01%" },
        };

        ----------------------
        --- Dire Maul EAST ---
        ----------------------

    DMEPusillin = {
        { 18267, "INV_Scroll_03", "=q2=Recipe: Runn Tum Tuber Surprise", "=ds=#p3# (275)", "71.55%" },
        { 0,"","","" },
        { 18261, "INV_Misc_Book_07", "=q1=Book of Incantations", "=ds=#m3#", "100%" },
        { 18249, "INV_Misc_Key_10", "=q1=Crescent Key", "=ds=#e9#", "100%" },
        };

    DMEZevrimThornhoof = {
        { 18319, "INV_Helmet_38", "=q3=Fervent Helm",   "=ds=#s1#, #a3#", "7.88%" },
        { 18313, "INV_Helmet_19", "=q3=Helm of Awareness", "=ds=#s1#, #a4#", "17.87%" },
        { 18323, "INV_Weapon_Bow_03", "=q3=Satyr's Bow",   "=ds=#w2#", "17.24%" },
        { 0,"","","" },
        { 18306, "INV_Gauntlets_22", "=q2=Gloves of Shadowy Mist", "=ds=#s9#, #a1#", "21.40%" },
        { 18308, "INV_Helmet_51", "=q2=Clever Hat",                "=ds=#s1#, #a2#", "23.73%" },
        };

    DMELethtendris = {
        { 18325, "INV_Helmet_31", "=q3=Felhide Cap",              "=ds=#s1#, #a2#", "24.67%" },
        { 18311, "INV_Staff_14", "=q3=Quel'dorai Channeling Rod", "=ds=#w9#", "7.30%" },
        { 0,"","","" },
        { 18302, "INV_Jewelry_Ring_20", "=q2=Band of Vigor", "=ds=#s13#", "29.30%" },
        { 18301, "INV_Wand_06", "=q2=Lethtendris's Wand",    "=ds=#w12#", "25.57%" },
        { 0,"","","" },
        { 18426, "Spell_Nature_Web", "=q1=Lethtendris's Web", "=ds=#m3#" },
        };

    DMEHydro = {
        { 18322, "INV_Boots_08", "=q3=Waterspout Boots",            "=ds=#s12#, #a2#", "16.42%" },
        { 18317, "INV_Jewelry_Necklace_03", "=q3=Tempest Talisman", "=ds=#s2#", "16.44%" },
        { 18324, "INV_Axe_17", "=q3=Waveslicer",                    "=ds=#h2#, #w1#", "8.46%" },
        { 0,"","","" },
        { 18307, "INV_Boots_05", "=q2=Riptide Shoes",        "=ds=#s12#, #a1#", "21.33%" },
        { 18305, "INV_Pants_04", "=q2=Breakwater Legguards", "=ds=#s11#, #a4#", "22.75%" },
        };

    DMEPimgib = {
        { 18354, "INV_Jewelry_Amulet_05", "=q3=Pimgib's Collar", "=ds=#s14#, =q1=#m1# =ds=#c8#", "18.68%" },
        };

    DMEAlzzin = {
        { 18328, "INV_Misc_Cape_17", "=q3=Shadewood Cloak",            "=ds=#s4#", "15.36%" },
        { 18327, "INV_Belt_17", "=q3=Whipvine Cord",                   "=ds=#s10#, #a1#", "16.53%" },
        { 18309, "INV_Gauntlets_20", "=q3=Gloves of Restoration",      "=ds=#s9#, #a2#", "14.05%" },
        { 18318, "INV_Boots_01", "=q3=Merciful Greaves",               "=ds=#s12#, #a3#", "14.88%" },
        { 18312, "INV_Chest_Plate11", "=q3=Energized Chestplate",      "=ds=#s5#, #a4#", "16.08%" },
        { 18326, "INV_Gauntlets_31", "=q3=Razor Gauntlets",            "=ds=#s9#, #a4#", "18.62%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x9#", "" },
        { 18501, "INV_Enchant_ShardRadientSmall", "=q1=Felvine Shard", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18315, "INV_Jewelry_Ring_28", "=q3=Ring of Demonic Potency", "=ds=#s13#", "15.40%" },
        { 18314, "INV_Jewelry_Ring_31", "=q3=Ring of Demonic Guile",   "=ds=#s13#", "13.71%" },
        { 18310, "INV_Sword_18", "=q3=Fiendish Machete",               "=ds=#h1#, #w10#", "15.39%" },
        { 18321, "INV_Mace_13", "=q3=Energetic Rod",                   "=ds=#h3#, #w6#", "15.94%" },
        };

    DMEIsalien = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n20#" },
        { 22304, "INV_Gauntlets_27", "=q3=Ironweave Gloves", "=ds=#s9#, #a1#", "16.24%" },
        { 22472, "INV_Boots_08", "=q3=Boots of Ferocity", "=ds=#s12#, #a2#", "12.55%" },
        { 22401, "INV_Relics_LibramofHope", "=q3=Libram of Hope", "=ds=#s16#, #w16#", "14.76%" },
        { 22345, "INV_Relics_TotemofRebirth", "=q3=Totem of Rebirth", "=ds=#s16#, #w15#", "2.95%" },
        { 22315, "INV_Hammer_02", "=q3=Hammer of Revitalization", "=ds=#h3#, #w6#", "13.65%" },
        { 22314, "INV_Spear_06", "=q3=Huntsman's Harpoon", "=ds=#w7#", "15.50%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 21984, "INV_Jewelry_Necklace_30", "=q1=Left Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        { 22046, "INV_Jewelry_Necklace_29", "=q1=Right Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        };

    DMETrash = {
        { 18295, "INV_Boots_06", "=q3=Phasing Boots", "=ds=#s12#, #a1# =q2=#m16#", "1.26%" },
        { 18298, "INV_Pants_11", "=q3=Unbridled Leggings", "=ds=#s11#, #a2#", "0.62%" },
        { 18296, "INV_Bracer_06", "=q3=Marksman Bands", "=ds=#s8#, #a3#", "0.59%" },
        { 18289, "INV_Jewelry_Necklace_09", "=q3=Barbed Thorn Necklace", "=ds=#s2#", "0.87%" },
        };

        -----------------------
        --- Dire Maul North ---
        -----------------------

    DMNGuardMoldar = {
        { 18496, "INV_Misc_Cape_02", "=q3=Heliotrope Cloak",               "=ds=#s4#", "4.68%" },
        { 18497, "INV_Bracer_13", "=q3=Sublime Wristguards",               "=ds=#s8#, #a1#", "4.14%"},
        { 18494, "INV_Shoulder_15", "=q3=Denwatcher's Shoulders",          "=ds=#s3#, #a3#", "4.62%" },
        { 18493, "INV_Shoulder_26", "=q3=Bulky Iron Spaulders",            "=ds=#s3#, #a4#", "3.96%" },
        { 18498, "INV_Axe_11", "=q3=Hedgecutter",                          "=ds=#h1#, #w1#", "4.94%" },
        { 0,"","","" },
        { 18268, "INV_Misc_Key_04", "=q1=Gordok Inner Door Key", "=ds=#e9#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18450, "INV_Chest_Cloth_24", "=q2=Robe of Combustion",           "=ds=#s5#, #a1#", "6.57%" },
        { 18451, "INV_Belt_16", "=q2=Hyena Hide Belt",                     "=ds=#s10#, #a2#", "6.61%" },
        { 18458, "INV_Bracer_03", "=q2=Modest Armguards",                  "=ds=#s8#, #a3#", "7.12%" },
        { 18459, "INV_Bracer_19", "=q2=Gallant's Wristguards",             "=ds=#s8#, #a4#", "6.09%" },
        { 18464, "INV_Jewelry_Ring_06", "=q2=Gordok Nose Ring",            "=ds=#s13#", "6.52%" },
        { 18462, "INV_Gauntlets_13", "=q2=Jagged Bone Fist",               "=ds=#h3#, #w13#", "7.54%" },
        { 18463, "INV_Sword_04", "=q2=Ogre Pocket Knife",                  "=ds=#h1#, #w10#", "7.38%" },
        { 18460, "INV_Weapon_Rifle_07", "=q2=Unsophisticated Hand Cannon", "=ds=#w5#", "5.86%" },
        };

    DMNStomperKreeg = {
        { 18425, "INV_Drink_05", "=q2=Kreeg's Mug", "=ds=#s15#", "40.24%" },
        { 18269, "INV_Drink_03", "=q2=Gordok Green Grog", "=ds=#e4#", "100%" },
        { 18284, "INV_Drink_05", "=q2=Kreeg's Stout Beatdown", "=ds=#e4#", "100%" },
        };

    DMNGuardFengus = {
        { 18450, "INV_Chest_Cloth_24", "=q2=Robe of Combustion",           "=ds=#s5#, #a1#", "9.76%" },
        { 18451, "INV_Belt_16", "=q2=Hyena Hide Belt",                     "=ds=#s10#, #a2#", "10.64%" },
        { 18458, "INV_Bracer_03", "=q2=Modest Armguards",                  "=ds=#s8#, #a3#", "11.41%" },
        { 18459, "INV_Bracer_19", "=q2=Gallant's Wristguards",             "=ds=#s8#, #a4#", "9.60%" },
        { 18464, "INV_Jewelry_Ring_06", "=q2=Gordok Nose Ring",            "=ds=#s13#", "11.41%" },
        { 18462, "INV_Gauntlets_13", "=q2=Jagged Bone Fist",               "=ds=#h3#, #w13#", "11.79%" },
        { 18463, "INV_Sword_04", "=q2=Ogre Pocket Knife",                  "=ds=#h1#, #w10#", "11.02%" },
        { 18460, "INV_Weapon_Rifle_07", "=q2=Unsophisticated Hand Cannon", "=ds=#w5#", "9.07%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x7#", "" },
        { 18266, "INV_Misc_Key_02", "=q1=Gordok Courtyard Key", "=ds=#e9#", "100%" },
        };

    DMNThimblejack = {
        { 18517, "INV_Scroll_04", "=q4=Pattern: Chromatic Cloak", "=ds=#p7# (300)", "0.92%" },
        { 18518, "INV_Scroll_04", "=q4=Pattern: Hide of the Wild", "=ds=#p7# (300)", "1.29%" },
        { 18519, "INV_Scroll_04", "=q4=Pattern: Shifting Cloak", "=ds=#p7# (300)", "1.14%" },
        { 18414, "INV_Scroll_04", "=q4=Pattern: Belt of the Archmage", "=ds=#p8# (300)", "1.00%" },
        { 0,"","","" },
        { 18418, "INV_Scroll_05", "=q3=Pattern: Cloak of Warding", "=ds=#p8# (300)", "9.75%" },
        { 18415, "INV_Scroll_05", "=q3=Pattern: Felcloth Gloves", "=ds=#p8# (300)", "9.62%" },
        { 18416, "INV_Scroll_05", "=q3=Pattern: Inferno Gloves", "=ds=#p8# (300)", "10.66%" },
        { 18417, "INV_Scroll_05", "=q3=Pattern: Mooncloth Gloves", "=ds=#p8# (300)", "10.28%" },
        { 18514, "INV_Scroll_05", "=q3=Pattern: Girdle of Insight", "=ds=#p7# (300)", "10.90%" },
        { 18515, "INV_Scroll_05", "=q3=Pattern: Mongoose Boots", "=ds=#p7# (300)", "11.18%" },
        { 18516, "INV_Scroll_05", "=q3=Pattern: Swift Flight Bracers", "=ds=#p7# (300)", "10.26%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x6#", "" },
        { 18240, "INV_Potion_08", "=q2=Ogre Tannin", "=ds=#m3#", "100%" },
        { 18509, "INV_Misc_Cape_02", "=q4=Chromatic Cloak", "=ds=#s4#" },
        { 18510, "INV_Misc_Cape_01", "=q4=Hide of the Wild", "=ds=#s4#" },
        { 18511, "INV_Misc_Cape_20", "=q4=Shifting Cloak", "=ds=#s4#" },
        { 18405, "INV_Belt_31", "=q4=Belt of the Archmage", "=ds=#s10#, #a1#" },
        { 0,"","","" },
        { 18413, "INV_Misc_Cape_06", "=q3=Cloak of Warding", "=ds=#s4#" },
        { 18407, "INV_Gauntlets_19", "=q3=Felcloth Gloves", "=ds=#s9#, #a1#" },
        { 18408, "INV_Gauntlets_19", "=q3=Inferno Gloves", "=ds=#s9#, #a1#" },
        { 18409, "INV_Gauntlets_17", "=q3=Mooncloth Gloves", "=ds=#s9#, #a1#" },
        { 18504, "INV_Belt_26", "=q3=Girdle of Insight", "=ds=#s10#, #a2#" },
        { 18506, "INV_Boots_08", "=q3=Mongoose Boots", "=ds=#s12#, #a2#" },
        { 18508, "INV_Bracer_05", "=q3=Swift Flight Bracers", "=ds=#s8#, #a3#" },
        };

    DMNGuardSlipkik = {
        { 18496, "INV_Misc_Cape_02", "=q3=Heliotrope Cloak",      "=ds=#s4#", "5.82%" },
        { 18497, "INV_Bracer_13", "=q3=Sublime Wristguards",      "=ds=#s8#, #a1#", "4.75%" },
        { 18494, "INV_Shoulder_15", "=q3=Denwatcher's Shoulders", "=ds=#s3#, #a3#", "5.70%" },
        { 18493, "INV_Shoulder_26", "=q3=Bulky Iron Spaulders",   "=ds=#s3#, #a4#", "4.89%" },
        { 18498, "INV_Axe_11", "=q3=Hedgecutter",                 "=ds=#h1#, #w1#", "6.01%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18450, "INV_Chest_Cloth_24", "=q2=Robe of Combustion",           "=ds=#s5#, #a1#", "6.78%" },
        { 18451, "INV_Belt_16", "=q2=Hyena Hide Belt",                     "=ds=#s10#, #a2#", "7.83%" },
        { 18458, "INV_Bracer_03", "=q2=Modest Armguards",                  "=ds=#s8#, #a3#", "7.63%" },
        { 18459, "INV_Bracer_19", "=q2=Gallant's Wristguards",             "=ds=#s8#, #a4#", "6.98%" },
        { 18464, "INV_Jewelry_Ring_06", "=q2=Gordok Nose Ring",            "=ds=#s13#", "7.36%" },
        { 18462, "INV_Gauntlets_13", "=q2=Jagged Bone Fist",               "=ds=#h3#, #w13#", "8.52%" },
        { 18463, "INV_Sword_04", "=q2=Ogre Pocket Knife",                  "=ds=#h1#, #w10#", "7.74%" },
        { 18460, "INV_Weapon_Rifle_07", "=q2=Unsophisticated Hand Cannon", "=ds=#w5#", "6.66%" },
        };

    DMNCaptainKromcrush = {
        { 18507, "INV_Boots_05", "=q3=Boots of the Full Moon",       "=ds=#s12#, #a1#", "18.75%" },
        { 18505, "INV_Belt_02", "=q3=Mugger's Belt",                 "=ds=#s10#, #a2#", "18.06%" },
        { 18503, "INV_Chest_Chain_14", "=q3=Kromcrush's Chestplate", "=ds=#s5#, #a4#", "17.48%" },
        { 18502, "INV_Weapon_Halberd_09", "=q3=Monstrous Glaive",    "=ds=#w7#", "21.47%" },
        };

    DMNKingGordok = {
        { 18526, "INV_Crown_01", "=q3=Crown of the Ogre King",       "=ds=#s1#, #a1#", "17.17%" },
        { 18525, "INV_Bracer_12", "=q3=Bracers of Prosperity",       "=ds=#s8#, #a2#", "19.15%" },
        { 18527, "INV_Gauntlets_10", "=q3=Harmonious Gauntlets",     "=ds=#s9#, #a3#", "19.73%" },
        { 18524, "INV_Pants_03", "=q3=Leggings of Destruction",      "=ds=#s11#, #a3#", "18.55%" },
        { 18521, "INV_Boots_Plate_01", "=q3=Grimy Metal Boots",      "=ds=#s12#, #a4#", "17.80%" },
        { 18522, "INV_Jewelry_Ring_32", "=q3=Band of the Ogre King", "=ds=#s13#", "14.96%" },
        { 18523, "INV_Misc_Orb_01", "=q3=Brightly Glowing Stone",    "=ds=#s15#", "20.21%" },
        { 18520, "INV_Sword_11", "=q3=Barbarous Blade",              "=ds=#h2#, #w10#", "16.44%" },  
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 19258, "INV_Misc_Ticket_Tarot_Warlord_01", "=q3=Ace of Warlords", "=ds=#e16#", "1.84%" },
        { 0,"","","" },
        { 18780, "INV_Misc_Note_06", "=q3=Top Half of Advanced Armorsmithing: Volume I", "=ds=#m3#", "6.00%" },
        { 12727, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Breastplate", "=q1=#m4#: =ds=#p2# (300)" },
        };

    DMNChoRush = {
        { 18490, "INV_Helmet_41", "=q3=Insightful Hood", "=ds=#s1#, #a2#", "21.46%" },
        { 18484, "INV_Weapon_ShortBlade_04", "=q3=Cho'Rush's Blade", "=ds=#h1#, #w10#", "22.46%" },
        { 18485, "INV_Shield_13", "=q3=Observer's Shield", "=ds=#w8#", "22.96%" },
        { 18483, "INV_Wand_05", "=q3=Mana Channeling Wand", "=ds=#w12#", "19.01%" },
        };

    DMNTRIBUTERUN = {
        { 18538, "INV_Axe_10", "=q4=Treant's Bane",                 "=ds=#h2#, #w1#" },
        { 0,"","","" },
        { 18495, "INV_Misc_Cape_21", "=q3=Redoubt Cloak",           "=ds=#s4#" },
        { 18532, "INV_Chest_Cloth_29", "=q3=Mindsurge Robe",        "=ds=#s5#, #a1#" },
        { 18528, "INV_Shoulder_26", "=q3=Cyclone Spaulders",        "=ds=#s3#, #a2#" },
        { 18530, "INV_Chest_Chain_12", "=q3=Ogre Forged Hauberk",   "=ds=#s5#, #a3#" },
        { 18533, "INV_Bracer_14", "=q3=Gordok Bracers of Power",    "=ds=#s8#, #a4#" },
        { 18529, "INV_Belt_18", "=q3=Elemental Plate Girdle",       "=ds=#s10#, #a4# =q2=#m16#" },
        { 18500, "INV_Jewelry_Ring_13", "=q3=Tarnished Elven Ring", "=ds=#s13#" },
        { 18537, "INV_Stone_02", "=q3=Counterattack Lodestone",     "=ds=#s14#" },
        { 18531, "INV_Hammer_22", "=q3=Unyielding Maul",            "=ds=#h2#, #w6#" },
        { 18534, "INV_Staff_32", "=q3=Rod of the Ogre Magi",        "=ds=#w9#" },
        { 18499, "INV_Shield_10", "=q3=Barrier Shield",             "=ds=#w8#" },
        { 0,"","","" },
        { 0,"","","" },
        { 18475, "INV_Belt_07", "=q2=Oddly Magical Belt",                "=ds=#s10#, #a1#" },
        { 18478, "INV_Chest_Leather_06", "=q2=Hyena Hide Jerkin",        "=ds=#s5#, #a2#" },
        { 18477, "INV_Pants_14", "=q2=Shaggy Leggings",                  "=ds=#s11#, #a2#" },
        { 18476, "INV_Boots_07", "=q2=Mud Stained Boots",                "=ds=#s12#, #a2#" },
        { 18479, "INV_Helmet_11", "=q2=Carrion Scorpid Helm",            "=ds=#s1#, #a3#" },
        { 18480, "INV_Helmet_23", "=q2=Scarab Plate Helm",               "=ds=#s1#, #a4#" },
        { 18481, "INV_Mace_05", "=q2=Skullcracking Mace",                "=ds=#h2#, #w6#" },
        { 18482, "INV_Weapon_Bow_05", "=q2=Ogre Toothpick Shooter",      "=ds=#w2#" },
        { 18655, "INV_Scroll_06", "=q2=Schematic: Major Recombobulator", "=ds=#p5# (275)" },
        };

        ----------------------
        --- Dire Maul West ---
        ----------------------

    DMWTendrisWarpwood = {
        { 18390, "INV_Pants_14", "=q3=Tanglemoss Leggings",    "=ds=#s11#, #a2#", "22.55%" },
        { 18393, "INV_Belt_34", "=q3=Warpwood Binding",        "=ds=#s10#, #a3#", "19.81%" },
        { 0,"","","" },
        { 18353, "INV_Staff_08", "=q2=Stoneflower Staff",      "=ds=#w9#", "23.46%" },
        { 18352, "INV_Shield_18", "=q2=Petrified Bark Shield", "=ds=#w8#", "21.67%" },
        };

    DMWIllyannaRavenoak = {
        { 18386, "INV_Pants_06", "=q3=Padre's Trousers",           "=ds=#s11#, #a1#", "18.79%" },
        { 18383, "INV_Gauntlets_09", "=q3=Force Imbued Gauntlets", "=ds=#s9#, #a4#", "20.11%" },
        { 0,"","","" },
        { 18349, "INV_Gauntlets_12", "=q2=Gauntlets of Accuracy",  "=ds=#s9#, #a3#", "23.94%" },
        { 18347, "INV_Axe_11", "=q2=Well Balanced Axe",            "=ds=#h1#, #w1#", "22.44%" },
        };

    DMWMagisterKalendris = {
        { 18374, "INV_Shoulder_24", "=q3=Flamescarred Shoulders",      "=ds=#s3#, #a2#", "18.11%" },
        { 18397, "INV_Jewelry_Necklace_07", "=q3=Elder Magus Pendant", "=ds=#s2#", "17.46%" },
        { 18371, "INV_Battery_02", "=q3=Mindtap Talisman",             "=ds=#s14#", "7.45%" },
        { 0,"","","" },
        { 18350, "INV_Misc_Cape_18", "=q2=Amplifying Cloak",           "=ds=#s4#", "21.44%" },
        { 18351, "INV_Bracer_18", "=q2=Magically Sealed Bracers",      "=ds=#s8#, #a4#", "24.36%" },
        { 22309, "INV_Scroll_06", "=q2=Pattern: Big Bag of Enchantment", "=ds=#p8# (300)" },
        };

    DMWTsuzee = {
        { 18387, "INV_Gauntlets_16", "=q3=Brightspark Gloves", "=ds=#s9#, #a1#", "24.79%" },
        { 0,"","","" },
        { 18346, "INV_Pants_09", "=q2=Threadbare Trousers",    "=ds=#s11#, #a1#", "33.94%" },
        { 18345, "INV_Jewelry_Ring_15", "=q2=Murmuring Ring",  "=ds=#s13#", "30.28%" },
        };

    DMWImmolthar = {
        { 18389, "INV_Misc_Cape_01", "=q3=Cloak of the Cosmos",           "=ds=#s4#", "14.35%" },
        { 18385, "INV_Chest_Cloth_51", "=q3=Robe of Everlasting Night",   "=ds=#s5#, #a1#", "15.33%" },
        { 18377, "INV_Gauntlets_21", "=q3=Quickdraw Gloves",              "=ds=#s9#, #a2#", "21.01%" },
        { 18391, "INV_Belt_26", "=q3=Eyestalk Cord",                      "=ds=#s10#, #a2#", "20.08%" },
        { 18394, "INV_Bracer_05", "=q3=Demon Howl Wristguards",           "=ds=#s8#, #a3#", "17.51%" },
        { 18379, "INV_Boots_Plate_06", "=q3=Odious Greaves",              "=ds=#s12#, #a3#", " 19.81%" },
        { 18384, "INV_Shoulder_17", "=q3=Bile-etched Spaulders",          "=ds=#s3#, #a4#", "14.71%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18381, "INV_Misc_Eye_01", "=q3=Evil Eye Pendant",               "=ds=#s2#", "17.78%" },
        { 18370, "INV_Misc_StoneTablet_04", "=q3=Vigilance Charm",        "=ds=#s14#", "6.30%" },
        { 18372, "INV_Weapon_ShortBlade_18", "=q3=Blade of the New Moon", "=ds=#h3#, #w4#", "6.99%" },
        };

    DMWHelnurath = {
        { 18757, "INV_Shoulder_25", "=q3=Diabolic Mantle", "=ds=#s3#, #a1#", "23.12%" },
        { 18754, "INV_Bracer_15", "=q3=Fel Hardened Bracers", "=ds=#s8#, #a4#", "19.24%" },
        { 18756, "INV_Shield_17", "=q3=Dreadguard's Protector", "=ds=#w8#", "19.77%" },
        { 18755, "INV_Weapon_Rifle_03", "=q3=Xorothian Firestick", "=ds=#w5#", "21.92%" },
        };

    DMWPrinceTortheldrin = {
        { 18382, "INV_Misc_Cape_14", "=q3=Fluctuating Cloak",             "=ds=#s4# =q2=#m16#", "21.84%" },
        { 18373, "INV_Chest_Leather_08", "=q3=Chestplate of Tranquility", "=ds=#s5#, #a2#", "6.32%" },
        { 18375, "INV_Bracer_07", "=q3=Bracers of the Eclipse",           "=ds=#s8#, #a2#", "15.62%" },
        { 18378, "INV_Pants_03", "=q3=Silvermoon Leggings",               "=ds=#s11#, #a3#", "21.20%" },
        { 18380, "INV_Pants_04", "=q3=Eldritch Reinforced Legplates",     "=ds=#s11#, #a4#", "15.87%" },
        { 18395, "INV_Jewelry_Ring_11", "=q3=Emerald Flame Ring",         "=ds=#s13#", "14.55%" },
        { 0,"","","" },
        { 21525, "INV_Helmet_68", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x8#", "" },
        { 18336, "INV_Gauntlets_22", "=q1=Gauntlet of Gordok Might", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 18392, "INV_Weapon_ShortBlade_05", "=q3=Distracting Dagger",    "=ds=#h4#, #w4#", "14.70%" },
        { 18396, "INV_Weapon_ShortBlade_22", "=q3=Mind Carver",           "=ds=#h3#, #w10#", "14.62%" },
        { 18376, "INV_Mace_07", "=q3=Timeworn Mace",                      "=ds=#h1#, #w6#", "14.40%" },
        { 18388, "INV_Weapon_Crossbow_08", "=q3=Stoneshatter",            "=ds=#w3#", "7.72%" },
        };

    DMWShendralarProvisioner = { 
        { 18487, "INV_Scroll_03", "=q1=Pattern: Mooncloth Robe", "=ds=#p8# (300)" },
        };

    DMWTrash = {
        { 18344, "INV_Gauntlets_23", "=q3=Stonebark Gauntlets", "=ds=#s9#, #a2#", "0.47%" },
        { 18340, "INV_Jewelry_Talisman_14", "=q3=Eidolon Talisman", "=ds=#s2#", "0.58%" },
        { 18338, "INV_Wand_02", "=q3=Wand of Arcane Potency", "=ds=#w12#", "0.78%" },
        };

        -----------------------
        --- Dire Maul Books ---
        -----------------------

    DMBooks = {
        { 18364, "INV_Misc_Book_10", "=q3=The Emerald Dream", "=ds=#e10#, =q1=#m1# =ds=#c1#" },
        { 18361, "INV_Misc_Book_02", "=q3=The Greatest Race of Hunters", "=ds=#e10#, =q1=#m1# =ds=#c2#" },
        { 18358, "INV_Misc_Book_01", "=q3=The Arcanist's Cookbook", "=ds=#e10#, =q1=#m1# =ds=#c3#" },
        { 18359, "INV_Misc_Book_11", "=q3=The Light and How to Swing It", "=ds=#e10#, =q1=#m1# =ds=#c4#" },
        { 18362, "INV_Misc_Book_08", "=q3=Holy Bologna: What the Light Won't Tell You", "=ds=#e10#, =q1=#m1# =ds=#c5#" },
        { 18356, "INV_Misc_Book_06", "=q3=Garona: A Study on Stealth and Treachery", "=ds=#e10#, =q1=#m1# =ds=#c6#" },
        { 18363, "INV_Misc_Book_04", "=q3=Frost Shock and You", "=ds=#e10#, =q1=#m1# =ds=#c7#" },
        { 18360, "INV_Misc_Book_05", "=q3=Harnessing Shadows", "=ds=#e10#, =q1=#m1# =ds=#c8#" },
        { 18357, "INV_Misc_Book_07", "=q3=Codex of Defense", "=ds=#e10#, =q1=#m1# =ds=#c9#" },
        { 0,"","","" },
        { 18333,"INV_Misc_Book_04","=q2=Libram of Focus","=ds=#e10#" },
        { 18334,"INV_Misc_Book_11","=q2=Libram of Protection","=ds=#e10#" },
        { 18332,"INV_Misc_Book_02","=q2=Libram of Rapidity","=ds=#e10#" },
        { 0,"","","" },
        { 0,"","","" },
        { 18470, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c1#" },
        { 18473, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c2#" },
        { 18468, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c3#" },
        { 18472, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c4#" },
        { 18469, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c5#" },
        { 18465, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c6#" },
        { 18471, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c7#" },
        { 18467, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c8#" },
        { 18466, "INV_Jewelry_Talisman_10", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c9#" },
        { 0,"","","" },
        { 18401,"INV_Misc_Book_11","=q4=Foror's Compendium of Dragon Slaying","=ds=#e10#, =q1=#m1# =ds=#c9#, #c4#" },
        { 18348,"INV_Sword_01","=q4=Quel'Serrar","=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c4#" },
        };

        -----------------------------
        --- UPPER BLACKROCK SPIRE ---
        -----------------------------

    BRMScarshieldQuartermaster = {
        { 18987, "Inv_Letter_17", "=q1=Blackhand's Command", "=ds=#m2#", "100%" },
        };

    UBRSEmberseer = {
        { 12905,"INV_Chest_Cloth_16","=q3=Wildfire Cape",          "=ds=#s4#", "15.20%" },
        { 12927,"INV_Shoulder_10","=q3=TruestrikeShoulders",       "=ds=#s3#, #a2#", "17.47%" },
        { 12929,"INV_Jewelry_Necklace_05","=q3=Emberfury Talisman","=ds=#s2#", "15.89%" },
        { 12926,"Spell_Holy_InnerFire","=q3=Flaming Band",   "=ds=#s13#", "18.52%" },
        { 0,"","","" },
        { 17322, "INV_Misc_Gem_Pearl_04", "=q1=Eye of the Emberseer", "=ds=#m3#", "100%" },
        { 21988, "INV_Ammo_FireTar", "=q1=Ember of Emberseer", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16672,"INV_Gauntlets_11","=q3=Gauntlets of Elements",    "=ds=#s9#, #a3# (D1, #c7#)", "14.23%" },
        };

    UBRSSolakar = {
        { 12609, "INV_Chest_Cloth_17", "=q3=Polychromatic Visionwrap", "=ds=#s5#, #a1#", "15.82%" },
        { 12589, "INV_Belt_11", "=q3=Dustfeather Sash", "=ds=#s10#, #a1#", "12.84%" },
        { 12603, "INV_Chest_Plate06", "=q3=Nightbrace Tunic", "=ds=#s5#, #a2#", "15.06%" },
        { 12606, "INV_Belt_10", "=q3=Crystallized Girdle", "=ds=#s10#, #a2#", "14.04%" },
        { 0,"","","" },
        { 18657, "INV_Scroll_06", "=q2=Schematic: Hyper-Radiant Flame Reflector", "=ds=#p5# (290)", "7.38%" },
        { 18638, "INV_Misc_EngGizmos_04", "=q3=Hyper-Radiant Flame Reflector", "=ds=#s14#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16695, "INV_Shoulder_02", "=q3=Devout Mantle", "=ds=#s3#, #a1# (D1, #c5#)", "12.84%" },
        };

    UBRSFLAME = {
        { 13371, "INV_Misc_Orb_05", "=q2=Father Flame", "=ds=#s15#", "100%" },
        };

    UBRSQuestItems = {
        { 12358, "INV_Misc_Rune_06", "=q1=Darkstone Tablet", "=ds=#m3#" },
        { 12352, "INV_Jewelry_Amulet_01", "=q1=Doomrigger's Clasp", "=ds=#m3#" },
        };

    UBRSRunewatcher = {
        { 12604,"INV_Crown_02","=q3=Starfire Tiara",                  "=ds=#s1#, #a1#", "28.64%" },
        { 12930,"INV_Misc_Root_02","=q3=Briarwood Reed",              "=ds=#s14#", "26.36%" },
        { 12605,"INV_Misc_Bone_ElfSkull_01","=q3=Serpentine Skuller", "=ds=#w12#", "32.95%" },
        };

    UBRSAnvilcrack = {
        { 18047,"INV_Boots_02","=q3=Flame Walkers",                    "=ds=#s12#, #a3#", "18.05%" },
        { 13502,"INV_Belt_23","=q3=Handcrafted Mastersmith Girdle",    "=ds=#s10#, #a4#", "15.78%" },
        { 13498,"INV_Pants_04","=q3=Handcrafted Mastersmith Leggings", "=ds=#s11#, #a4#", "20.63%" },
        { 18048,"INV_Hammer_06","=q3=Mastersmith's Hammer",            "=ds=#h3#, #w6#", "17.26%" },
        { 0,"","","" },
        { 12837,"INV_Scroll_03","=q3=Plans: Masterwork Stormhammer", "=ds=#p2# (300)", "4.80%" },
        { 12794,"INV_Hammer_04", "=q3=Masterwork Stormhammer", "=ds=#h3#, #w6#" },
        { 12834,"INV_Scroll_03","=q3=Plans: Arcanite Champion",      "=ds=#p2# (300)", "4.75%" },
        { 12790,"INV_Sword_39", "=q3=Arcanite Champion", "=ds=#h2#, #w10#" },
        { 0,"","","" },
        { 18779,"INV_Misc_Note_06","=q3=Bottom Half of Advanced Armorsmithing: Volume I","=ds=#m3#", "17.08%" },
        { 12727, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Breastplate", "=q1=#m4#: =ds=#p2# (300)" },
        { 0,"","","" },
        { 21525, "INV_Helmet_68", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x10#", "" },
        { 12806, "INV_Chest_Plate04", "=q3=Unforged Rune Covered Breastplate", "=ds=#m3#" },
        { 12696, "INV_Scroll_03", "=q3=Plans: Demon Forged Breastplate", "=q1=#m4#: =ds=#p2# (285)" },
        };

    UBRSRend = {
        { 12590, "INV_Weapon_ShortBlade_25", "=q4=Felstriker", "=ds=#h1#, #w4#", "1.06%" },
        { 0,"","","" },
        { 22247, "INV_Boots_Cloth_03", "=q3=Faith Healer's Boots", "=ds=#s12#, #a1#", "12.71%" },
        { 18102, "INV_Boots_05", "=q3=Dragonrider Boots", "=ds=#s12#, #a1#", "14.35%" },
        { 12587, "INV_Helmet_46", "=q3=Eye of Rend", "=ds=#s1#, #a2#", "14.50%" },
        { 12588, "INV_Shoulder_11", "=q3=Bonespike Shoulder", "=ds=#s3#, #a3#", "0.85%" },
        { 18104, "INV_Belt_03", "=q3=Feralsurge Girdle", "=ds=#s10#, #a3#", "15.30%" },
        { 12936, "INV_Bracer_17", "=q3=Battleborn Armbraces", "=ds=#s8#, #a4#", "16.96%" },
        { 12935, "INV_Pants_04", "=q3=Warmaster Legguards", "=ds=#s11#, #a4#", "15.05%" },
        { 18103, "INV_Jewelry_Ring_16", "=q3=Band of Rumination", "=ds=#s13#", "15.38%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16733, "INV_Shoulder_30", "=q3=Spaulders of Valor", "=ds=#s3#, #a4# (D1, #c9#)", "13.39%" },
        { 0,"","","" },
        { 12940, "INV_Sword_43", "=q3=Dal'Rend's Sacred Charge", "=ds=#h3#, #w10#", "6.79%" },
        { 12939, "INV_Sword_40", "=q3=Dal'Rend's Tribal Guardian", "=ds=#h4#, #w10#", "7.61%" },
        { 12583, "INV_Weapon_Halberd_04", "=q3=Blackhand Doomsaw", "=ds=#w7#", "7.44%" },
        { 0,"","","" },
        { 12630, "INV_Misc_Head_Orc_01", "=q1=Head of Rend Blackhand", "=ds=#m3#", "100%" },
        };

    UBRSGyth = {
        { 12871,"INV_Shield_21","=q4=Chromatic Carapace","=ds=#m3#", "2.64%" },
        { 12945, "INV_Pants_03", "=q4=Legplates of the Chromatic Defier", "=q1=#m4#: =ds=#s11#, #a3#" },
        { 12903, "INV_Pants_03", "=q4=Legguards of the Chromatic Defier", "=q1=#m4#: =ds=#s11#, #a3#" },
        { 12895, "INV_Chest_Plate09", "=q4=Breastplate of the Chromatic Flight", "=q1=#m4#: =ds=#s5#, #a4#" },
        { 0,"","","" },
        { 22225,"INV_Helmet_27","=q3=Dragonskin Cowl","=ds=#s1#, #a1#", "11.85%" },
        { 12960,"INV_Helmet_24","=q3=Tribal War Feathers","=ds=#s1#, #a2#", "15.24%" },
        { 12953,"INV_Helmet_39","=q3=Dragoneye Coif","=ds=#s1#, #a3#", "15.99%" },
        { 12952,"INV_Helmet_23","=q3=Gyth's Skull","=ds=#s1#, #a4#", "12.43%" },
        { 0,"","","" },
        { 13522,"INV_Scroll_06","=q2=Recipe: Flask of Chromatic Resistance", "=ds=#p1# (300)", "2.95%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16669,"INV_Shoulder_29","=q3=Pauldrons of Elements","=ds=#s3#, #a3# (D1, #c7#)", "14.77%" },
        };

    UBRSBeast = {
        { 12731, "INV_Misc_MonsterScales_15", "=q4=Pristine Hide of the Beast", "=ds=#m3#", "0.77%" },
        { 12752, "INV_Helmet_59", "=q4=Cap of the Scarlet Savant", "=q1=#m4#: =ds=#s1#, #a1#" },
        { 12757, "INV_Chest_Chain_13", "=q4=Breastplate of Bloodthirst", "=q1=#m4#: =ds=#s5#, #a2#" },
        { 12756, "INV_Pants_05", "=q4=Leggings of Arcana", "=q1=#m4#: =ds=#s11#, #a2#" },
        { 0,"","","" },
        { 12967,"INV_Misc_Cape_05","=q3=Bloodmoon Cloak",     "=ds=#s4#", "18.30%" },
        { 12968,"INV_Misc_Cape_18","=q3=Frostweaver Cape",    "=ds=#s4#", "14.47%" },
        { 12965,"INV_Pants_06","=q3=Spiritshroud Leggings",   "=ds=#s11#, #a1#", "13.16%" },
        { 22311,"INV_Boots_Cloth_05","=q3=Ironweave Boots",   "=ds=#s12#, #a1#", "12.31%" },
        { 12966,"INV_Bracer_07","=q3=Blackmist Armguards",    "=ds=#s8#, #a2#", "16.06%" },
        { 12963,"INV_Pants_06","=q3=Blademaster Leggings",    "=ds=#s11#, #a2#", "12.74%" },
        { 12964,"INV_Pants_04","=q3=Tristam Legguards",       "=ds=#s11#, #a3#", "18.16%" },
        { 12709,"INV_Sword_33","=q3=Finkle's Skinner",        "=ds=#h3#, #w4#, =q1=#e18#", "6.95%" },
        { 12969,"INV_Hammer_17","=q3=Seeping Willow",         "=ds=#h2#, #w6#", "11.49%" },
        { 0,"","","" },
        { 16729,"INV_Shoulder_10","=q3=Lightforge Spaulders", "=ds=#s3#, #a4# (D1, #c4#)", "13.62%" },
        { 0,"","","" },
        { 24101, "INV_Misc_Book_02", "=q3=Book of Ferocious Bite V", "=ds=#e10# =q1=#m1# =ds=#c1#", "1.44%" },
        { 19227, "INV_Misc_Ticket_Tarot_Beasts_01", "=q3=Ace of Beasts", "=ds=#e16#", "4.53%" },
        };

    UBRSValthalak = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n16#" },
        { 22337, "INV_Misc_Cape_19", "=q3=Shroud of Domination", "=ds=#s4#", "23.37%" },
        { 22302, "INV_Helmet_30", "=q3=Ironweave Cowl", "=ds=#s1#, #a1#", "27.72%" },
        { 22342, "INV_Pants_09", "=q3=Leggings of Torment", "=ds=#s11#, #a1#", "23.10%" },
        { 22343, "INV_Gauntlets_11", "=q3=Handguards of Savagery", "=ds=#s9#, #a3#", "20.11%" },
        { 22340, "INV_Jewelry_Necklace_04", "=q3=Pendant of Celerity", "=ds=#s2#", "17.66%" },
        { 22339, "INV_Jewelry_Ring_35", "=q3=Rune Band of Wizardry", "=ds=#s13#", "15.49%" },
        { 22335, "INV_Staff_07", "=q3=Lord Valthalak's Staff of Command", "=ds=#w9#", "14.67%" },
        { 22336, "INV_Shield_02", "=q3=Draconian Aegis of the Legion", "=ds=#w8#", "17.66%" },
        };

    UBRSDrakkisath = {
        { 12592,"INV_Sword_29","=q4=Blackblade of Shahram",      "=ds=#h2#, #w10#", "1.08%" },
        { 0,"","","" },
        { 22269,"INV_Misc_Cape_20","=q3=Shadow Prowler's Cloak",           "=ds=#s4#", "10.61%" },
        { 22267,"INV_Helmet_62","=q3=Spellweaver's Turban",                "=ds=#s1#, #a1#", "15.50%" },
        { 13142,"INV_Belt_33","=q3=Brigam Girdle",                         "=ds=#s10#, #a4#", "16.40%" },
        { 13141,"INV_Jewelry_Necklace_09","=q3=Tooth of Gnarr",            "=ds=#s2#", "16.83%" },
        { 13098,"INV_Jewelry_Ring_18","=q3=Painweaver Band",               "=ds=#s13#", "13.51%" },
        { 22268,"INV_Jewelry_Talisman_09","=q3=Draconic Infused Emblem",   "=ds=#s14#", "4.13%" },
        { 22253,"INV_Misc_Book_06","=q3=Tome of the Lost",                 "=ds=#s15#", "16.05%" },
        { 12602,"INV_Shield_20","=q3=Draconian Deflector",                 "=ds=#w8#", "14.52%" },
        { 0,"","","" },
        { 15730,"INV_Scroll_03","=q3=Pattern: Red Dragonscale Breastplate","=ds=#p7# (300)", "3.58%" },
        { 15047,"INV_Chest_Chain_06","=q3=Red Dragonscale Breastplate","=ds=#s5#, #a3#" },
        { 0,"","","" },
        { 13519,"INV_Scroll_06","=q2=Recipe: Flask of the Titans",         "=ds=#p1# (300)", "1.72%" },
        { 16688,"INV_Chest_Cloth_25","=q3=Magister's Robes",     "=ds=#s5#, #a1# (D1, #c3#)", "7.24%" },
        { 16700,"INV_Chest_Cloth_49","=q3=Dreadmist Robe",       "=ds=#s5#, #a1# (D1, #c8#)", "8.04%" },
        { 16690,"INV_Chest_Cloth_11","=q3=Devout Robe",          "=ds=#s5#, #a1# (D1, #c5#)", "6.20%" },
        { 16706,"INV_Chest_Plate06","=q3=Wildheart Vest",        "=ds=#s5#, #a2# (D1, #c1#)", "7.36%" },
        { 16721,"INV_Chest_Leather_07","=q3=Shadowcraft Tunic",  "=ds=#s5#, #a2# (D1, #c6#)", "6.09%" },
        { 16674,"INV_Chest_Chain_03","=q3=Beaststalker's Tunic", "=ds=#s5#, #a3# (D1, #c2#)", "6.81%" },
        { 16666,"INV_Chest_Chain_11","=q3=Vest of Elements",     "=ds=#s5#, #a3# (D1, #c7#)", "3.03%" },
        { 16730,"INV_Chest_Plate03","=q3=Breastplate of Valor",  "=ds=#s5#, #a4# (D1, #c9#)", "5.83%" },
        { 16726,"INV_Chest_Plate03","=q3=Lightforge Breastplate","=ds=#s5#, #a4# (D1, #c4#)", "3.76%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16663,"INV_Potion_27","=q1=Blood of the Black Dragon Champion",  "=ds=#m3#", "100%" },
        };

    UBRSTrash = {
        { 13260, "INV_Boots_01", "=q3=Wind Dancer Boots", "=ds=#s12#, #a3#", "0.01%" },
        { 24102, "INV_Misc_Book_14", "=q3=Manual of Eviscerate IX", "=ds=#e10# =q1=#m1# =ds=#c6# =q1=#n70#", "0.94%" },
        { 0,"","","" },
        { 16247, "INV_Misc_Note_01", "=q2=Formula: Enchant 2H Weapon - Superior Impact", "=ds=#p4# (295) =q1=#n69#", "1.54%" },
        { 0,"","","" },
        { 12607, "INV_Misc_MonsterScales_17", "=q3=Brilliant Chromatic Scale", "=ds=#m3#" },
        { 12219, "Racial_Dwarf_FindTreasure", "=q1=Unadorned Seal of Ascension", "=ds=#m3#" },
        };

        ------------------
        --- Stratholme ---
        ------------------

    STRATSkull = {
        { 13395, "INV_Gauntlets_27", "=q3=Skul's Fingerbone Claws",       "=ds=#s9#, #a2#", "36.52%" },
        { 13394, "INV_Chest_Chain_15", "=q3=Skul's Cold Embrace",         "=ds=#s5#, #a4#", "24.16%" },
        { 13396, "INV_Misc_Bone_ElfSkull_01", "=q3=Skul's Ghastly Touch", "=ds=#w12#", "16.85%" },
        };

    STRATStratholmeCourier={
        { 13304, "INV_Misc_Key_03", "=q1=Festival Lane Postbox Key",     "=ds=#e9#", "45.19%" },
        { 13303, "INV_Misc_Key_03", "=q1=Crusaders' Square Postbox Key", "=ds=#e9#", "43.46%" },
        { 13307, "INV_Misc_Key_03", "=q1=Fras Siabi's Postbox Key",      "=ds=#e9#", "42.88%" },
        { 13305,"INV_Misc_Key_03", "=q1=Elders' Square Postbox Key",     "=ds=#e9#", "36.87%" },
        { 13302, "INV_Misc_Key_03", "=q1=Market Row Postbox Key",        "=ds=#e9#", "35.58%" },
        { 13306, "INV_Misc_Key_03", "=q1=King's Square Postbox Key",     "=ds=#e9#", "37.69%" },
        };

    STRATFrasSiabi = {
        { 13172, "INV_Crate_01", "=q1=Siabi's Premium Tobacco", "=ds=#m3#", "100%" },
        { 13171, "Spell_Fire_SearingTotem", "=q2=Smokey's Lighter", "=q1=#m4#: =ds=#s14#" },
        };

    STRATAtiesh = {
        { 22736, "INV_Sword_61", "=q5=Andonisus, Reaper of Souls", "=q1=#m26#: =ds=#h3#, #w10#", "100%" },
        };

    STRATHearthsingerForresten = {
        { 13378, "INV_Chest_Cloth_38", "=q3=Songbird Blouse", "=ds=#s5#, #a2#", "15.31%" },
        { 13383, "INV_Pants_14", "=q3=Woollies of the Prancing Minstrel", "=ds=#s11#, #a3#", "18.42%" },
        { 13384, "INV_Belt_30", "=q3=Rainbow Girdle", "=ds=#s10#, #a4#", "19.21%" },
        { 13379, "INV_Misc_Flute_01", "=q3=Piccolo of the Flaming Fire", "=ds=#s14#", "15.13%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16682, "INV_Boots_02", "=q3=Magister's Boots", "=ds=#s12#, #a1# (D1, #c3#)", "10.86%" },
        };

    STRATTheUnforgiven = {
        { 13409, "INV_Bracer_13", "=q3=Tearfall Bracers", "=ds=#s8#, #a1#", "14.62%" },
        { 13404, "INV_Misc_Bandana_01", "=q3=Mask of the Unforgiven", "=ds=#s1#, #a2#", "14.96%" },
        { 13405, "INV_Shoulder_25", "=q3=Wailing Nightbane Pauldrons", "=ds=#s3#, #a4#", "12.10%" },
        { 13408, "INV_Weapon_Halberd_05", "=q3=Soul Breaker", "=ds=#h3#, #w1#", "19.33%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16717, "INV_Gauntlets_17", "=q3=Wildheart Gloves", "=ds=#s9#, #a2# (D1, #c1#)", "12.61%" },
        };

    STRATTimmytheCruel = {
        { 13403, "INV_Belt_02", "=q3=Grimgore Noose",                        "=ds=#s10#, #a1#", "16.48%" },
        { 13402, "INV_Boots_01", "=q3=Timmy's Galoshes",                     "=ds=#s12#, #a3#", "16.74%" },
        { 13400, "INV_Bracer_17", "=q3=Vambraces of the Sadist",             "=ds=#s8#, #a4#", "14.02%" },
        { 13401, "INV_Misc_Bone_ElfSkull_01", "=q3=The Cruel Hand of Timmy", "=ds=#h1#, #w6#", "16.87%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16724, "INV_Gauntlets_19", "=q3=Lightforge Gauntlets", "=ds=#s9#, #a4# (D1, #c4#)", "10.42%" },
        };

    STRATMalorsStrongbox = {
        { 0, "INV_Box_01", "=q6=#x13#", "" },
        { 12845, "INV_Jewelry_Necklace_08", "=q1=Medallion of Faith", "=ds=#m3#", "100%" },
        };

    STRATCrimsonHammersmith = {
        { 18781, "INV_Misc_Note_03", "=q3=Bottom Half of Advanced Armorsmithing: Volume II", "=ds=#m3#", "41.6%" },
        { 12726, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Leggings", "=q1=#m4#: =ds=#p2# (300)" },
        { 0,"","","" },
        { 13351, "INV_Shirt_15", "=q1=Crimson Hammersmith's Apron", "=ds=#m3#", "100%" },
        { 12824, "INV_Scroll_06", "=q2=Plans: Enchanted Battlehammer", "=q1=#m4#: =ds=#p2# (280)" },
        };

    STRATBSPlansSerenity = {
        { 12827, "INV_Scroll_06", "=q2=Plans: Serenity", "=ds=#p2# (285)", "100%" },
        };

    STRATCannonMasterWilley = {
        { 22405, "INV_Shoulder_02", "=q3=Mantle of the Scarlet Crusade",    "=ds=#s3#, #a1#", "16.03%" },
        { 22407, "INV_Helmet_41", "=q3=Helm of the New Moon",               "=ds=#s1#, #a2#", "13.61%" },
        { 18721, "INV_Belt_18", "=q3=Barrage Girdle",                       "=ds=#s10#, #a3#", "12.39%" },
        { 13381, "INV_Boots_Plate_09", "=q3=Master Cannoneer Boots",        "=ds=#s12#, #a4#", "12.86%" },
        { 22403, "INV_Jewelry_Necklace_10", "=q3=Diana's Pearl Necklace",   "=ds=#s2#", "14.27%" },
        { 13382, "INV_Misc_Bomb_04", "=q3=Cannonball Runner",               "=ds=#s14#", "12.28%" },
        { 22404, "INV_Weapon_ShortBlade_16", "=q3=Willey's Back Scratcher", "=ds=#h3#, #w13#", "6.26%" },
        { 22406, "INV_Staff_23", "=q3=Redemption",                          "=ds=#w9#", "7.04%" },
        { 13380, "INV_Weapon_Rifle_07", "=q3=Willey's Portable Howitzer",   "=ds=#w5#", "10.71%" },
        { 13377, "INV_Ammo_Bullet_02", "=q3=Miniature Cannon Balls",        "=ds=#w18#", "66.61%" },
        { 0,"","","" },
        { 12839, "INV_Scroll_03", "=q3=Plans: Heartseeker", "=ds=#p2# (300)", "4.98%" },
        { 12783, "INV_Sword_17", "=q3=Heartseeker", "=ds=#h1#, #w4#" },
        { 0,"","","" },
        { 0,"","","" },
        { 16708, "INV_Shoulder_07", "=q3=Shadowcraft Spaulders", "=ds=#s3#, #a2# (D1, #c6#)", "10.68%" },
        { 0,"","","" },
        { 21524, "INV_Helmet_67", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        };

    STRATArchivistGalford = {
        { 13386, "INV_Misc_Cape_19", "=q3=Archivist Cape", "=ds=#s4#", "18.45%" },
        { 18716, "INV_Boots_08", "=q3=Ash Covered Boots",     "=ds=#s12#, #a2#", "16.30%" },
        { 13387, "INV_Belt_21", "=q3=Foresight Girdle",    "=ds=#s10#, #a3#", "18.24%" },
        { 13385, "INV_Misc_Book_05", "=q3=Tome of Knowledge", "=ds=#s15#", "9.87%" },
        { 22897, "INV_Misc_Book_07", "=q3=Tome of Conjure Food VII", "=ds=#e10# =q1=#m1# =ds=#c3#", "4.86%" },
        { 0,"","","" },
        { 12811, "INV_Misc_Gem_Pearl_03", "=q2=Righteous Orb", "=ds=#e8#", "61.3%" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x11#", "" },
        { 14679, "INV_Scroll_06", "=q1=Of Love and Family", "=ds=#m3#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16692, "INV_Gauntlets_14", "=q3=Devout Gloves",     "=ds=#s9#, #a1# (D1, #c5#)", "12.46%" },
        };

    STRATBalnazzar = {
        { 13353, "INV_Misc_Book_06", "=q4=Book of the Dead",          "=ds=#s15#", "1.37%" },
        { 14512, "INV_Scroll_03", "=q4=Pattern: Truefaith Vestments", "=ds=#p8# (300)", "3.02%" },
        { 14154, "INV_Chest_Cloth_31", "=q4=Truefaith Vestments", "=ds=#s5#, #a1# =q1=#m1# =ds=#c5#" },
        { 0,"","","" },
        { 18720, "INV_Shoulder_23", "=q3=Shroud of the Nathrezim",         "=ds=#s3#, #a1#", "10.54%" },
        { 13369, "INV_Boots_05", "=q3=Fire Striders",                      "=ds=#s12#, #a1#", "14.84%" },
        { 13358, "INV_Shoulder_24", "=q3=Wyrmtongue Shoulders",            "=ds=#s3#, #a2#", "11.58%" },
        { 13359, "INV_Helmet_03", "=q3=Crown of Tyranny",                  "=ds=#s1#, #a3#", "13.94%" },
        { 18718, "INV_Helmet_10", "=q3=Grand Crusader's Helm",             "=ds=#s1#, #a4#", "10.16%" },
        { 12103, "INV_Jewelry_Talisman_08", "=q3=Star of Mystaria",        "=ds=#s2#", "12.48%" },
        { 13360, "INV_Weapon_ShortBlade_15", "=q3=Gift of the Elven Magi", "=ds=#h1#, #w4#", "13.66%" },
        { 13348, "INV_Sword_14", "=q3=Demonshear",                         "=ds=#h2#, #w10#", "13.94%" },
        { 18717, "INV_Hammer_06", "=q3=Hammer of the Grand Crusader",      "=ds=#h2#, #w6#", "11.91%" },
        { 0,"","","" },
        { 0,"","","" },
        { 16725, "INV_Boots_Plate_03", "=q3=Lightforge Boots", "=ds=#s12#, #a4# (D1, #c4#)", "11.11%" },
        { 0,"","","" },
        { 13520, "INV_Scroll_06", "=q2=Recipe: Flask of Distilled Wisdom", "=ds=#p1# (300)", "1.94%" },
        { 0,"","","" },
        { 13250, "Spell_Shadow_Possession", "=q1=Head of Balnazzar", "=ds=#m2#" },
        };

    STRATSothosJarien = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n18#" },
        { 22301, "INV_Chest_Cloth_48", "=q3=Ironweave Robe", "=ds=#s5#, #a1#", "19.00%" },
        { 22328, "INV_Pants_04", "=q3=Legplates of Vigilance", "=ds=#s11#, #a4#", "21.27%" },
        { 22327, "INV_Jewelry_Necklace_08", "=q3=Amulet of the Redeemed", "=ds=#s2#", "14.03%" },
        { 22334, "INV_Jewelry_Ring_05", "=q3=Band of Mending", "=ds=#s13#", "17.19%" },
        { 22329, "INV_Wand_07", "=q3=Scepter of Interminable Focus", "=ds=#s15#", "28.51%" },
        { 0,"","","" },
        { 21984, "INV_Jewelry_Necklace_30", "=q1=Left Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        { 22046, "INV_Jewelry_Necklace_29", "=q1=Right Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        };

    STRATStonespine = {
        { 13397, "INV_Misc_Cape_19", "=q3=Stoneskin Gargoyle Cape",  "=ds=#s4#", "23.44%" },
        { 13954, "INV_Boots_08", "=q3=Verdant Footpads",             "=ds=#s12#, #a2#", "25.36%" },
        { 13399, "INV_Gauntlets_11", "=q3=Gargoyle Shredder Talons", "=ds=#h4#, #w13#", "26.16%" },
        { 0,"","","" },
        };

    STRATBaronessAnastari = {
        { 18730, "INV_Gauntlets_16", "=q3=Shadowy Laced Handwraps",  "=ds=#s9#, #a1#", "13.54%" },
        { 18728, "INV_Jewelry_Necklace_11", "=q3=Anastari Heirloom", "=ds=#s2#", "11.92%" },
        { 13534, "INV_Weapon_ShortBlade_18", "=q3=Banshee Finger",   "=ds=#w12#", "13.42%" },
        { 18729, "INV_Weapon_Bow_12", "=q3=Screeching Bow",          "=ds=#w2#", "15.59%" },
        { 0,"","","" },
        { 13535, "INV_Chest_Cloth_47", "=q2=Coldtouch Phantom Wraps",  "=ds=#s5#, #a1#", "9.84%" },
        { 13537, "INV_Bracer_07", "=q2=Chillhide Bracers",             "=ds=#s8#, #a2#", "9.71%" },
        { 13538, "INV_Shoulder_13", "=q2=Windshrieker Pauldrons",      "=ds=#s3#, #a3#", "9.75%" },
        { 13539, "INV_Gauntlets_29", "=q2=Banshee's Touch",            "=ds=#s9#, #a4#", "8.27%" },
        { 13514, "Spell_Shadow_Possession", "=q2=Wail of the Banshee", "=ds=#m8#", "7.73%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16704, "INV_Boots_05", "=q3=Dreadmist Sandals", "=ds=#s12#, #a1# (D1, #c8#)", "13.16%" },
        };

    STRATBlackGuardSwordsmith = {
        { 18783, "INV_Misc_Note_04", "=q3=Bottom Half of Advanced Armorsmithing: Volume III", "=ds=#m3#", "23.5%" },
        { 12725, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Helm", "=q1=#m4#: =ds=#p2# (300)" },
        { 0,"","","" },
        { 13350, "INV_Misc_ArmorKit_20", "=q1=Insignia of the Black Guard", "=ds=#m3#", "100%" },
        { 12825, "INV_Scroll_06", "=q2=Plans: Blazing Rapier", "=q1=#m4#: =ds=#p2# (280)" },
        };

    STRATBSPlansCorruption = {
        { 12830, "INV_Scroll_03", "=q1=Plans: Corruption", "=ds=#p2# (290)", "100%" },
        };

    STRATNerubenkan = {
        { 18740, "INV_Belt_13", "=q3=Thuzadin Sash",                      "=ds=#s10#, #a1#", "14.72%" },
        { 18739, "INV_Pants_04", "=q3=Chitinous Plate Legguards",         "=ds=#s11#, #a4#", "12.19%" },
        { 13529, "INV_Shield_02", "=q3=Husk of Nerub'enkan",              "=ds=#w8#", "12.62%" },
        { 18738, "INV_Weapon_Crossbow_04", "=q3=Carapace Spine Crossbow", "=ds=#w3#", "14.17%" },
        { 0,"","","" },
        { 13530, "INV_Boots_05", "=q2=Fangdrip Runners",         "=ds=#s12#, #a1#", "8.49%" },
        { 13531, "INV_Pants_09", "=q2=Crypt Stalker Leggings",   "=ds=#s11#, #a2#", "10.17%" },
        { 13532, "INV_Gauntlets_31", "=q2=Darkspinner Claws",    "=ds=#s9#, #a3#", "9.69%" },
        { 13533, "INV_Shoulder_18", "=q2=Acid-etched Pauldrons", "=ds=#s3#, #a4#", "8.11%" },
        { 13508, "INV_Misc_Eye_01", "=q2=Eye of Arachnida",      "=ds=#m8#", "7.39%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16675, "INV_Boots_Plate_07", "=q3=Beaststalker's Boots", "=ds=#s12#, #a3# (D1, #c2#)", "13.62%" },
        };

    STRATMalekithePallid = {
        { 18734, "INV_Misc_Cape_11", "=q3=Pale Moon Cloak",                     "=ds=#s4#", "13.42%" },
        { 18735, "INV_Boots_03", "=q3=Maleki's Footwraps",                      "=ds=#s12#, #a1#", "15.03%" },
        { 13524, "INV_Misc_Bone_HumanSkull_01", "=q3=Skull of Burning Shadows", "=ds=#s15#", "13.42%" },
        { 18737, "INV_Axe_11", "=q3=Bone Slicing Hatchet",                      "=ds=#h1#, #w1#", "14.23%" },
        { 0,"","","" },
        { 13525, "INV_Gauntlets_15", "=q2=Darkbind Fingers",     "=ds=#s9#, #a1#", "9.15%" },
        { 13526, "INV_Belt_09", "=q2=Flamescarred Girdle",       "=ds=#s10#, #a2#", "9.57%" },
        { 13528, "INV_Bracer_16", "=q2=Twilight Void Bracers",   "=ds=#s8#, #a3#", "9.49%" },
        { 13527, "INV_Boots_Plate_09", "=q2=Lavawalker Greaves", "=ds=#s12#, #a4#", "9.39%" },
        { 13509, "INV_Misc_Rune_03", "=q2=Clutch of Foresight",  "=ds=#m8#", "6.95%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16691, "INV_Boots_05", "=q3=Devout Sandals", "=ds=#s12#, #a1# (D1, #c5#)", "13.64%" },
        { 0,"","","" },
        { 12833, "INV_Scroll_03", "=q3=Plans: Hammer of the Titans", "=ds=#p2# (300)", "5.86%" },
        { 12796, "INV_Hammer_09", "=q3=Hammer of the Titans", "=ds=#h2#, #w6#" },
        };

    STRATMagistrateBarthilas = {
        { 13376, "INV_Misc_Cape_14", "=q3=Royal Tribunal Cloak", "=ds=#s4#", "12.44%" },
        { 18727, "INV_Helmet_51", "=q3=Crimson Felt Hat",        "=ds=#s1#, #a1#", "13.82%" },
        { 18726, "INV_Bracer_11", "=q3=Magistrate's Cuffs",      "=ds=#s8#, #a2#", "12.87%" },
        { 18722, "INV_Gauntlets_13", "=q3=Death Grips",          "=ds=#s9#, #a4#", "15.34%" },
        { 23198, "INV_Relics_IdolofFerocity", "=q3=Idol of Brutality", "=ds=#s16#, #w14#", "2.37%" },
        { 18725, "INV_Spear_07", "=q3=Peacemaker",               "=ds=#w7#", "14.22%" },
        { 0,"","","" },
        { 12382, "INV_Misc_Key_13", "=q2=Key to the City",       "=ds=#e9#", "100%" },
        };

    STRATRamsteintheGorger = {
        { 13374, "INV_Shoulder_02", "=q3=Soulstealer Mantle",              "=ds=#s3#, #a1#", "9.87%" },
        { 18723, "INV_Jewelry_Necklace_01", "=q3=Animated Chain Necklace", "=ds=#s2#", "7.54%" },
        { 13373, "INV_Misc_Bone_04", "=q3=Band of Flesh",                  "=ds=#s13#", "8.15%" },
        { 13515, "INV_Misc_Gear_06", "=q3=Ramstein's Lightning Bolts",     "=ds=#s14#", "8.09%" },
        { 13372, "INV_Staff_08", "=q3=Slavedriver's Cane",                 "=ds=#w9#", "8.63%" },
        { 13375, "INV_Shield_19", "=q3=Crest of Retribution",              "=ds=#w8#", "9.17%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16737, "INV_Gauntlets_26", "=q3=Gauntlets of Valor", "=ds=#s9#, #a4# (D1, #c9#)", "9.58%" },
        };

    STRATBaronRivendare = {
        { 13505, "INV_Sword_17", "=q4=Runeblade of Baron Rivendare", "=ds=#h2#, #w10#", "0.27%" },
        { 13335, "Ability_Mount_Undeadhorse", "=q4=Deathcharger's Reins", "=ds=#e12#", "0.10%" },
        { 0,"","","" },
        { 13340, "INV_Misc_Cape_20", "=q3=Cape of the Black Baron", "=ds=#s4#", "8.75%" },
        { 22412, "INV_Shoulder_02", "=q3=Thuzadin Mantle", "=ds=#s3#, #a1#", "4.16%" },
        { 13346, "INV_Chest_Cloth_08", "=q3=Robes of the Exalted", "=ds=#s5#, #a1#", "11.51%" },
        { 22409, "INV_Chest_Leather_08", "=q3=Tunic of the Crescent Moon", "=ds=#s5#, #a2#", "4.59%" },
        { 13344, "INV_Gauntlets_31", "=q3=Dracorian Gauntlets", "=ds=#s9#, #a3#", "10.85%" },
        { 22410, "INV_Gauntlets_11", "=q3=Gauntlets of Deftness", "=ds=#s9#, #a3#", "4.98%" },
        { 22411, "INV_Helmet_01", "=q3=Helm of the Executioner", "=ds=#s1#, #a4#", "3.80%" },
        { 13345, "INV_Jewelry_Ring_16", "=q3=Seal of Rivendare", "=ds=#s13#", "9.50%" },
        { 13368, "INV_Weapon_ShortBlade_12", "=q3=Bonescraper", "=ds=#h1#, #w4#", "4.32%" },
        { 13361, "INV_Sword_12", "=q3=Skullforge Reaver", "=ds=#h1#, #w10#", "4.25%" },
        { 13349, "INV_Mace_07", "=q3=Scepter of the Unholy", "=ds=#h3#, #w6#", "9.30%" },
        { 22408, "INV_Wand_07", "=q3=Ritssyn's Wand of Bad Mojo", "=ds=#w12#", "3.39%" },
        { 16687, "INV_Pants_06", "=q3=Magister's Leggings",  "=ds=#s11#, #a1# (D1, #c3#)", "6.79%" },
        { 16699, "INV_Pants_08", "=q3=Dreadmist Leggings",   "=ds=#s11#, #a1# (D1, #c8#)", "7.31%" },
        { 16694, "INV_Pants_08", "=q3=Devout Skirt",         "=ds=#s11#, #a1# (D1, #c5#)", "7.42%" },
        { 16709, "INV_Pants_02", "=q3=Shadowcraft Pants",    "=ds=#s11#, #a2# (D1, #c6#)", "7.76%" },
        { 16719, "INV_Pants_08", "=q3=Wildheart Kilt",       "=ds=#s11#, #a2# (D1, #c1#)", "6.58%" },
        { 16668, "INV_Pants_03", "=q3=Kilt of Elements",     "=ds=#s11#, #a3# (D1, #c7#)", "3.02%" },
        { 16678, "INV_Pants_03", "=q3=Beaststalker's Pants", "=ds=#s11#, #a3# (D1, #c2#)", "6.16%" },
        { 16732, "INV_Pants_04", "=q3=Legplates of Valor",   "=ds=#s11#, #a4# (D1, #c9#)", "5.74%" },
        { 16728, "INV_Pants_04", "=q3=Lightforge Legplates", "=ds=#s11#, #a4# (D1, #c4#)", "4.20%" },
        { 0,"","","" },
        { 13251, "Spell_Shadow_Charm", "=q1=Head of Baron Rivendare", "=ds=#m3#", "100%" },
        { 13246, "INV_Sword_05", "=q3=Argent Avenger", "=q1=#m4#: =ds=#h1#, #w10#" },
        { 13249, "INV_Staff_13", "=q3=Argent Crusader", "=q1=#m4#: =ds=#w9#" },
        { 13243, "INV_Shield_05", "=q3=Argent Defender", "=q1=#m4#: =ds=#w8#" },
        };

    STRATTrash = {
        { 18743, "INV_Misc_Cape_18", "=q3=Gracious Cape", "=ds=#s4#", "0.01%" },
        { 17061, "INV_Misc_Cape_20", "=q3=Juno's Shadow", "=ds=#s4#", "0.01%" },
        { 18745, "INV_Pants_01", "=q3=Sacred Cloth Leggings", "=ds=#s11#, #a1#", "0.01%" },
        { 18744, "INV_Gauntlets_18", "=q3=Plaguebat Fur Gloves", "=ds=#s9#, #a2#", "0.00%" },
        { 18736, "INV_Pants_12", "=q3=Plaguehound Leggings", "=ds=#s11#, #a2#", "0.00%" },
        { 18742, "INV_Shoulder_14", "=q3=Stratholme Militia Shoulderguard", "=ds=#s3#, #a3#", "0.00%" },
        { 18741, "INV_Bracer_17", "=q3=Morlune's Bracer", "=ds=#s8#, #a4#", "0.01%" },
        { 0,"","","" },
        { 16249, "INV_Misc_Note_01", "=q2=Formula: Enchant 2H Weapon - Major Intellect", "=ds=#p4# (300) =q1=#n60#", "1.19%" },
        { 16248, "INV_Misc_Note_01", "=q2=Formula: Enchant Weapon - Unholy", "=ds=#p4# (295) =q1=#n61#", "0.36%" },
        { 18658, "INV_Scroll_06", "=q2=Schematic: Ultra-Flash Shadow Reflector", "=ds=#p5# (300) =q1=#n62#", "1.82%" },
        { 16052, "INV_Scroll_06", "=q2=Schematic: Voice Amplification Modulator", "=ds=#p5# (290) =q1=#n62#", "1.99%" },
        { 15777, "INV_Scroll_06", "=q2=Pattern: Runic Leather Shoulders", "=ds=#p7# (300) =q1=#n63#", "1.00%" },
        { 15768, "INV_Scroll_06", "=q2=Pattern: Wicked Leather Belt", "=ds=#p7# (300) =q1=#n64#", "0.85%" },
        { 14495, "INV_Scroll_06", "=q2=Pattern: Ghostweave Pants", "=ds=#p8# (290) =q1=#n65#", "2.13%" },
        { 16697, "INV_Belt_31", "=q3=Devout Bracers", "=ds=#s8#, #a1# (D1)", "1.15%" },
        { 16702, "INV_Belt_12", "=q3=Dreadmist Belt", "=ds=#s10#, #a1# (D1)", "0.90%" },
        { 16685, "INV_Belt_08", "=q3=Magister's Belt", "=ds=#s10#, #a1# (D1)", "0.80%" },
        { 16714, "INV_Bracer_09", "=q3=Wildheart Bracers", "=ds=#s8#, #a2# (D1)", "1.49%" },
        { 16681, "INV_Bracer_17", "=q3=Beaststalker's Bindings", "=ds=#s8#, #a3# (D1)", "1.64%" },
        { 16671, "INV_Bracer_02", "=q3=Bindings of Elements", "=ds=#s8#, #a3# (D1)", "1.90%" },
        { 16736, "INV_Belt_34", "=q3=Belt of Valor", "=ds=#s10#, #a4# (D1)", "2.02%" },
        { 16723, "INV_Belt_11", "=q3=Lightforge Belt", "=ds=#s10#, #a4# (D1)", "1.83%" },
        { 0,"","","" },
        { 12811, "INV_Misc_Gem_Pearl_03", "=q2=Righteous Orb", "=ds=#e8#", "5.09%" },
        { 12735, "INV_Misc_Pelt_Boar_Ruin_03", "=q2=Frayed Abomination Stitching", "=ds=#m3#", "17.5%" },
        };

        -----------------------------
        --- Lower Blackrock Spire ---
        -----------------------------

    LBRSQuestItems = {
        { 12812, "INV_Gauntlets_29", "=q3=Unfired Plate Gauntlets", "=ds=#m3#", "100%" },
        { 12631, "INV_Gauntlets_03", "=q3=Fiery Plate Gauntlets", "=q1=#m4#: =ds=#s9#, #a4#" },
        { 12699, "INV_Scroll_03", "=q3=Plans: Fiery Plate Gauntlets", "=q1=#m4#: =ds=#p2# (290)" },
        { 0,"","","" },
        { 12533, "INV_Spear_01", "=q1=Roughshod Pike", "=ds=#m3#" },
        { 12740, "INV_Misc_Rune_08", "=q1=Fifth Mosh'aru Tablet", "=ds=#m3#" },
        { 12741, "INV_Misc_Rune_04", "=q1=Sixth Mosh'aru Tablet", "=ds=#m3#" },
        { 12345, "INV_Misc_Bag_19", "=q1=Bijou's Belongings", "=ds=#m3#" },
        };

    LBRSOmokk = {
        { 13170, "INV_Pants_13", "=q3=Skyshroud Leggings",            "=ds=#s11#, #a1#", "8.52%" },
        { 13169, "INV_Pants_09", "=q3=Tressermane Leggings",          "=ds=#s11#, #a2#", "9.52%" },
        { 13168, "INV_Chest_Plate13", "=q3=Plate of the Shaman King", "=ds=#s5#, #a4#", "8.62%" },
        { 13166, "INV_Shoulder_23", "=q3=Slamshot Shoulders",         "=ds=#s3#, #a4#", "7.25%" },
        { 13167, "INV_Hammer_04", "=q3=Fist of Omokk",                "=ds=#h2#, #w6#", "10.64%" },
        { 0,"","","" },
        { 12336, "INV_Misc_Gem_Diamond_02", "=q2=Gemstone of Spirestone", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 12534, "INV_Misc_Head_Centaur_01", "=q1=Omokk's Head",          "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16670, "INV_Boots_Wolf", "=q3=Boots of Elements", "=ds=#s12#, #a3# (D1, #c7#)", "9.35%" },
        };

    LBRSSpirestoneLord = {
        { 13284, "INV_Boots_05", "=q3=Swiftdart Battleboots", "=ds=#s12#, #a1#",   "48.68%" },
        { 13285, "INV_Weapon_Halberd_11", "=q3=The Nicker",   "=ds=#h2#, #w1#", "34.87%" },
        };

    LBRSLordMagus = {
        { 13282, "INV_Boots_01", "=q3=Ogreseer Tower Boots", "=ds=#s12#, #a3#",   "22.95%" },
        { 13283, "Spell_Holy_InnerFire", "=q3=Magus Ring",   "=ds=#s13#", "38.01%" },
        { 13261, "INV_Wand_09", "=q3=Globe of D'sak",   "=ds=#s15#", "18.07%" },
        };

    LBRSVosh = {
        { 12626, "INV_Bracer_07", "=q3=Funeral Cuffs",             "=ds=#s8#, #a1#", "18.74%" },
        { 13257, "INV_Shoulder_07", "=q3=Demonic Runed Spaulders", "=ds=#s3#, #a2#", "16.84%" },
        { 13255, "INV_Gauntlets_30", "=q3=Trueaim Gauntlets",      "=ds=#s9#, #a3#", "18.08%" },
        { 12651, "INV_Weapon_Crossbow_04", "=q3=Blackcrow",        "=ds=#w3#", "8.56%" },
        { 12653, "INV_Weapon_Bow_08", "=q3=Riphook",               "=ds=#w2#", "7.99%" },
        { 12654, "Ability_Hunter_CriticalShot", "=q3=Doomshot",    "=ds=#w17#", "23.06%" },
        { 0,"","","" },
        { 13352, "INV_Misc_StoneTablet_08", "=q1=Vosh'gajin's Snakestone", "=ds=#m3#", "100%" },
        { 12821, "INV_Scroll_03", "=q3=Plans: Dawn's Edge", "=q1=#m4#: =ds=#p2# (275)" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16712, "INV_Gauntlets_24", "=q3=Shadowcraft Gloves", "=ds=#s9#, #a2# (D1, #c6#)", "11.89%" },
        };

    LBRSVoone = {
        { 22231, "INV_Boots_Cloth_02", "=q3=Kayser's Boots of Precision", "=ds=#s12#, #a1#", "15.40%" },
        { 13179, "INV_Bracer_09", "=q3=Brazecore Armguards",              "=ds=#s8#, #a3#", "16.12%" },
        { 13177, "INV_Jewelry_Amulet_04", "=q3=Talisman of Evasion",      "=ds=#s2#", "15.40%" },
        { 12582, "INV_Weapon_ShortBlade_12", "=q3=Keris of Zul'Serak",    "=ds=#h1#, #w4#", "8.08%" },
        { 28972, "INV_ThrowingAxe_06", "=q3=Flightblade Throwing Axe",    "=ds=#w11#", "79.85%" },
        { 0,"","","" },
        { 21524, "INV_Helmet_67", "=q2=Red Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        { 0,"","","" },
        { 12335, "INV_Misc_Gem_Opal_01", "=q2=Gemstone of Smolderthorn", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16676, "INV_Gauntlets_10", "=q3=Beaststalker's Gloves", "=ds=#s9#, #a3# (D1, #c2#)", "9.15%" },
        };

    LBRSGrayhoof = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n21#" },
        { 22306, "INV_Belt_03", "=q3=Ironweave Belt", "=ds=#s10#, #a1#", "20.28%" },
        { 22325, "INV_Belt_26", "=q3=Belt of the Trickster", "=ds=#s10#, #a2#", "20.28%" },
        { 22319, "INV_Misc_Book_07", "=q3=Tome of Divine Right", "=ds=#s15#", "20.81%" },
        { 22398, "INV_Relics_IdolofRejuvenation", "=q3=Idol of Rejuvenation", "=ds=#s16#, #w14#", "12.87%" },
        { 22322, "INV_Mace_15", "=q3=The Jaw Breaker", "=ds=#h1#, #w6#", "20.28%" },
        { 0,"","","" },
        { 21984, "INV_Jewelry_Necklace_30", "=q1=Left Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        { 22046, "INV_Jewelry_Necklace_29", "=q1=Right Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        };

    LBRSSmolderweb = {
        { 13244, "INV_Gauntlets_29", "=q3=Gilded Gauntlets",      "=ds=#s9#, #a3#", "25.06%" },
        { 13213, "INV_Misc_Gem_Pearl_01", "=q3=Smolderweb's Eye", "=ds=#s14#", "24.97%" },
        { 13183, "INV_Wand_10", "=q3=Venomspitter",               "=ds=#h1#, #w6#", "12.49%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16715, "INV_Boots_08", "=q3=Wildheart Boots", "=ds=#s12#, #a2# (D1, #c1#)", "13.03%" },
        };

    LBRSCrystalFang = {
        { 13185, "INV_Shoulder_02", "=q3=Sunderseer Mantle",                   "=ds=#s3#, #a1#", "28.10%" },
        { 13184, "INV_Gauntlets_13", "=q3=Fallbrush Handgrips",                "=ds=#s9#, #a2#", "35.48%" },
        { 13218, "INV_Weapon_ShortBlade_16", "=q3=Fang of the Crystal Spider", "=ds=#h1#, #w4#", "17.62%" },
        };

    LBRSDoomhowl = {
        { 13258, "INV_Gauntlets_22", "=q3=Slaghide Gauntlets", "=ds=#s9#, #a2#", "17.09%" },
        { 22232, "INV_Belt_18", "=q3=Marksman's Girdle",          "=ds=#s10#, #a3#", "20.60%" },
        { 13259, "INV_Boots_Plate_08", "=q3=Ribsteel Footguards", "=ds=#s12#, #a4#", "25.38%" },
        { 13178, "INV_Jewelry_Ring_22", "=q3=Rosewine Circle",    "=ds=#s13#", "21.48%" },
        { 0,"","","" },
        { 18784, "INV_Misc_Note_04", "=q3=Top Half of Advanced Armorsmithing: Volume III", "=ds=#m3#", "10.30%" },
        { 12725, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Helm", "=q1=#m4#: =ds=#p2# (300)" },
        { 0,"","","" },
        { 12712, "INV_Potion_20", "=q1=Warosh's Mojo",            "=ds=#m3#", "100%" },
        { 15867, "INV_Misc_Gem_Variety_02", "=q2=Prismcharm", "=q1=#m4#: =ds=#s14#" },
        };

    LBRSZigris = {
        { 13253, "INV_Gauntlets_14", "=q3=Hands of Power",  "=ds=#s9#, #a1#", "14.22%" },
        { 13252, "INV_Belt_10", "=q3=Cloudrunner Girdle",   "=ds=#s10#, #a2#", "15.48%" },
        { 0,"","","" },
        { 12835, "INV_Scroll_03", "=q3=Plans: Annihilator", "=ds=#p2# (300)", "8.37%" },
        { 12798, "INV_Axe_12", "=q3=Annihilator",           "=ds=#h3#, #w1#" },
        { 0,"","","" },
        { 21955, "INV_Scroll_06", "=q2=Design: Black Diamond Crab", "=ds=#p12# (300)" },
        };

    LBRSSlavener = {
        { 13206, "INV_Pants_06", "=q3=Wolfshear Leggings",      "=ds=#s11#, #a1#", "17.46%" },
        { 13208, "INV_Bracer_07", "=q3=Bleak Howler Armguards", "=ds=#s8#, #a2#", "18.02%" },
        { 13205, "INV_Shield_14", "=q3=Rhombeard Protector",    "=ds=#w8#", "16.93%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16718, "INV_Shoulder_01", "=q3=Wildheart Spaulders", "=ds=#s3#, #a2# (D1, #c1#)", "11.04%" },
        };

    LBRSHalycon = {
        { 22313, "INV_Bracer_13", "=q3=Ironweave Bracers",       "=ds=#s8#, #a1#", "18.16%" },
        { 13210, "INV_Boots_Wolf", "=q3=Pads of the Dread Wolf", "=ds=#s12#, #a2#", "9.88%" },
        { 13211, "INV_Bracer_07", "=q3=Slashclaw Bracers",       "=ds=#s8#, #a3#", "20.32%" },
        { 13212, "INV_Belt_14", "=q3=Halycon's Spiked Collar",   "=ds=#s2#", "18.23%" },
        };

    LBRSWyrmthalak = {
        { 13143, "INV_Jewelry_Ring_17", "=q4=Mark of the Dragon Lord",     "=ds=#s13#", "1.11%" },
        { 0,"","","" },
        { 13162, "INV_Gauntlets_29", "=q3=Reiver Claws",                   "=ds=#s9#, #a4#", "12.14%" },
        { 13164, "INV_Misc_Gem_Bloodstone_01", "=q3=Heart of the Scale",   "=ds=#s14#", "0.73%" },
        { 22321, "INV_Misc_Gem_Bloodstone_01", "=q3=Heart of Wyrmthalak",  "=ds=#s14#", "13.87%" },
        { 13163, "INV_Sword_18", "=q3=Relentless Scythe",                  "=ds=#h2#, #w10#", "14.12%" },
        { 13148, "INV_Spear_05", "=q3=Chillpike",                          "=ds=#w7#", "0.76%" },
        { 13161, "INV_Staff_29", "=q3=Trindlehaven Staff",                 "=ds=#w9#", "10.40%" },
        { 0,"","","" },
        { 12337, "INV_Misc_Gem_Bloodstone_01", "=q2=Gemstone of Bloodaxe", "=ds=#m3#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16679, "INV_Shoulder_10", "=q3=Beaststalker's Mantle", "=ds=#s3#, #a3# (D1, #c2#)", "9.89%" },
        };

    LBRSGrimaxe = {
        { 12634, "INV_Belt_13", "=q3=Chiselbrand Girdle",         "=ds=#s10#, #a3#", "31.73%" },
        { 12637, "INV_Gauntlets_26", "=q3=Backusarian Gauntlets", "=ds=#s9#, #a4#", "26.44%" },
        { 12621, "INV_Weapon_Halberd_11", "=q3=Demonfork",        "=ds=#h3#, #w1#", "27.64%" },
        { 0,"","","" },
        { 12838, "INV_Scroll_03", "=q3=Plans: Arcanite Reaper",   "=ds=#p2# (300)", "6.73%" },
        { 12784, "INV_Axe_09", "=q3=Arcanite Reaper", "=ds=#h2#, #w1#" },
        };

    LBRSSpirestoneButcher = {
        { 12608, "INV_Misc_Cape_19", "=q3=Butcher's Apron", "=ds=#s4#", "54.31%" },
        { 13286, "INV_Pick_05", "=q3=Rivenspike",           "=ds=#h1#, #w1#", "35.78%" },
        };

    LBRSBashguud = {
        { 13203, "INV_Misc_Cape_18", "=q3=Armswake Cloak", "=ds=#s4#", "35.31%" },
        { 13198, "INV_Gauntlets_11", "=q3=Hurd Smasher", "=ds=#h1#, #w13#", "21.15%" },
        { 13204, "INV_Mace_15", "=q3=Bashguuder", "=ds=#h1#, #w6#", "27.09%" },
        };

    LBRSFelguard = {
        { 13181, "INV_Misc_Cape_18", "=q3=Demonskin Gloves", "=ds=#s9#, #a1#", "14.47%" },
        { 13182, "INV_Sword_36", "=q3=Phase Blade", "=ds=#h1#, #w10#", "11.63%" },
        };

    LBRSTrash = {
        { 14513, "INV_Scroll_03", "=q4=Pattern: Robe of the Archmage", "=ds=#p8# (300) =q1=#m1# =ds=#c3# =q1=#n71#", "10.12%" },
        { 14152, "INV_Chest_Cloth_38", "=q4=Robe of the Archmage", "=ds=#s5#, #a1# =q1=#m1# =ds=#c3#" },
        { 0,"","","" },
        { 13494, "INV_Scroll_06", "=q2=Recipe: Greater Fire Protection Potion", "=ds=#p1# (290) =q1=#n71#/#n72#", "1.94%" },
        { 16250, "INV_Misc_Note_01", "=q2=Formula: Enchant Weapon - Superior Striking", "=ds=#p4# (300) =q1=#n75#", "1.04%" },
        { 16244, "INV_Misc_Note_01", "=q2=Formula: Enchant Gloves - Greater Strength", "=ds=#p4# (295) =q1=#n76#", "4.16%" },
        { 15749, "INV_Scroll_06", "=q2=Pattern: Volcanic Breastplate", "=ds=#p7# (285) =q1=#n73#", "2.04%" },
        { 15775, "INV_Scroll_06", "=q2=Pattern: Volcanic Shoulders", "=ds=#p7# (300) =q1=#n74#", "10.56%" },
        { 0,"","","" },
        { 12219, "Racial_Dwarf_FindTreasure", "=q1=Unadorned Seal of Ascension", "=ds=#m3#" },
        { 21982, "INV_Jewelry_Necklace_19", "=q1=Ogre Warbeads", "=ds=#m3#" },
        };

        -------------------
        --- Scholomance ---
        -------------------

    SCHOLOQuestItems = {
        { 13873, "INV_Misc_Key_14", "=q1=Viewing Room Key", "=ds=#e9#" },
        { 0,"","","" },
        { 13471, "INV_Misc_Note_02", "=q1=The Deed to Brill", "=ds=#m3#" },
        { 13448, "INV_Misc_Note_05", "=q1=The Deed to Caer Darrow", "=ds=#m3#" },
        { 13450, "INV_Misc_Note_06", "=q1=The Deed to Southshore", "=ds=#m3#" },
        { 13451, "INV_Misc_Note_01", "=q1=The Deed to Tarren Mill", "=ds=#m3#" },
        };

    SCHOLOBloodStewardofKirtonos = {
        { 13523, "INV_Potion_24", "=q1=Blood of Innocents", "=ds=#m3#", "100%" },
        };

    SCHOLOKirtonostheHerald = {
        { 13956, "INV_Belt_12", "=q3=Clutch of Andros",             "=ds=#s10#, #a1#", "15.31%" },
        { 13957, "INV_Gauntlets_09", "=q3=Gargoyle Slashers",       "=ds=#s9#, #a2#", "14.40%" },
        { 13969, "INV_Bracer_16", "=q3=Loomguard Armbraces",        "=ds=#s8#, #a3#", "16.25%" },
        { 13967, "INV_Boots_Plate_04", "=q3=Windreaver Greaves",    "=ds=#s12#, #a3#", "14.87%" },
        { 13955, "INV_Shoulder_25", "=q3=Stoneform Shoulders",      "=ds=#s3#, #a4#", "14.73%" },
        { 13960, "INV_Misc_Orb_03", "=q3=Heart of the Fiend",       "=ds=#s2#", "16.36%" },
        { 14024, "INV_Weapon_ShortBlade_16", "=q3=Frightalon",      "=ds=#h1#, #w4#", "15.55%" },
        { 13983, "INV_Weapon_Halberd_09", "=q3=Gravestone War Axe", "=ds=#h2#, #w1#", "12.78%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16734, "INV_Boots_Plate_03", "=q3=Boots of Valor", "=ds=#s12#, #a4# (D1, #c9#)", "11.12%" },
        };

    SCHOLOJandiceBarov = {
        { 18689, "INV_Misc_Cape_20", "=q3=Phantasmal Cloak",             "=ds=#s4#", "7.52%" },
        { 14543, "INV_Gauntlets_15", "=q3=Darkshade Gloves",             "=ds=#s9#, #a1#", "0.26%" },
        { 14545, "INV_Pants_11", "=q3=Ghostloom Leggings",               "=ds=#s11#, #a2#", "8.81%" },
        { 14548, "INV_Shoulder_11", "=q3=Royal Cap Spaulders",           "=ds=#s3#, #a3#", "10.06%" },
        { 18690, "INV_Pants_04", "=q3=Wraithplate Leggings",             "=ds=#s11#, #a4#", "8.59%" },
        { 14541, "INV_Sword_03", "=q3=Barovian Family Sword",            "=ds=#h2#, #w10#", "8.27%" },
        { 22394, "INV_Staff_29", "=q3=Staff of Metanoia",                "=ds=#w9#", "8.67%" },
        { 0,"","","" },
        { 13725, "INV_Misc_Bag_15", "=q1=Krastinov's Bag of Horrors", "=ds=#m3#", "100%" },
        { 13523, "INV_Potion_24", "=q1=Blood of Innocents", "=ds=#m3#", "17.8%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16701, "INV_Misc_Bone_TaurenSkull_01", "=q3=Dreadmist Mantle", "=ds=#s3#, #a1# (D1, #c8#)","12.20%" },
        };

    SCHOLORattlegore = {
        { 14538, "INV_Shoulder_02", "=q3=Deadwalker Mantle",      "=ds=#s3#, #a1#", "11.32%" },
        { 14539, "INV_Helmet_14", "=q3=Bone Ring Helm",           "=ds=#s1#, #a2#", "10.89%" },
        { 18686, "INV_Shoulder_03", "=q3=Bone Golem Shoulders",   "=ds=#s3#, #a3#", "9.04%" },
        { 14537, "INV_Boots_Plate_09", "=q3=Corpselight Greaves", "=ds=#s12#, #a4#", "10.22%" },
        { 14531, "INV_Hammer_13", "=q3=Frightskull Shaft",        "=ds=#h2#, #w6#", "9.55%" },
        { 14528, "INV_Shield_02", "=q3=Rattlecage Buckler",       "=ds=#w8#", "9.16%" },
        { 0,"","","" },
        { 13873, "INV_Misc_Key_14", "=q1=Viewing Room Key",       "=ds=#e9#", "100%" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 16711, "INV_Boots_08", "=q3=Shadowcraft Boots", "=ds=#s12#, #a2# (D1, #c6#)", "14.32%" },
        { 0,"","","" },
        { 18782, "INV_Misc_Note_03", "=q3=Top Half of Advanced Armorsmithing: Volume II", "=ds=#m3#", "5.71%" },
        { 12726, "INV_Scroll_05", "=q3=Plans: Enchanted Thorium Leggings", "=q1=#m4#: =ds=#p2# (300)" },
        };

    SCHOLODeathKnight = {
        { 18760, "INV_Jewelry_Ring_09", "=q3=Necromantic Band", "=ds=#s13#", "24.75%" },
        { 18758, "INV_Weapon_ShortBlade_18", "=q3=Specter's Blade", "=ds=#h1#, #w4#", "15.72%" },
        { 18759, "INV_Axe_18", "=q3=Malicious Axe", "=ds=#h2#, #w1#", "24.75%" },
        { 18761, "INV_Wand_12", "=q3=Oblivion's Touch", "=ds=#w12#", "17.17%" },
        { 0,"","","" },
        { 18749, "INV_Misc_Orb_04", "=q1=Charger's Lost Soul", "=ds=#m3#", "10.93%" },
        };

    SCHOLOVectus = {
        { 14577, "INV_Pants_08", "=q3=Skullsmoke Pants", "=ds=#s11#, #a1#", "5.24%" },
        { 18691, "INV_Jewelry_Necklace_06", "=q3=Dark Advisor's Pendant", "=ds=#s2#", "6.16%" },
        };

    SCHOLOMarduk = {
        { 18692, "INV_Boots_Plate_08", "=q3=Death Knight Sabatons", "=ds=#s12#, #a4#", "6.29%" },
        { 14576, "INV_Sword_15", "=q3=Ebon Hilt of Marduk",         "=ds=#h3#, #w10#", "6.55%" },
        };

    SCHOLORasFrostwhisper = {
        { 13314, "INV_Chest_Cloth_12", "=q4=Alanna's Embrace",     "=ds=#s5#, #a1#", "1.07%" },
        { 0,"","","" },
        { 14340, "INV_Chest_Cloth_46", "=q3=Freezing Lich Robes",  "=ds=#s5#, #a1#", "12.55%" },
        { 18693, "INV_Gauntlets_16", "=q3=Shivery Handwraps",      "=ds=#s9#, #a1#", "12.38%" },
        { 14503, "INV_Shoulder_25", "=q3=Death's Clutch",          "=ds=#s3#, #a2#", "11.73%" },
        { 14502, "INV_Belt_10", "=q3=Frostbite Girdle",            "=ds=#s10#, #a2#", "11.20%" },
        { 18694, "INV_Boots_01", "=q3=Shadowy Mail Greaves",       "=ds=#s12#, #a3#", "14.63%" },
        { 14522, "INV_Pants_04", "=q3=Maelstrom Leggings",         "=ds=#s11#, #a3#", "13.01%" },
        { 14525, "INV_Gauntlets_29", "=q3=Boneclenched Gauntlets", "=ds=#s9#, #a4#", "11.45%" },
        { 18695, "INV_Misc_Book_06", "=q3=Spellbound Tome",        "=ds=#s15#", "10.86%" },
        { 13952, "INV_Axe_03", "=q3=Iceblade Hacker",              "=ds=#h3#, #w1#", "9.74%" },
        { 14487, "INV_Hammer_13", "=q3=Bonechill Hammer",          "=ds=#h1#, #w6#", "11.92%" },
        { 18696, "INV_Shield_02", "=q3=Intricately Runed Shield",  "=ds=#w8#", "13.04%" },
        { 0,"","","" },
        { 0,"","","" },
        { 16689, "INV_Shoulder_23", "=q3=Magister's Mantle",       "=ds=#s3#, #a1# (D1, #c3#)", "11.93%" },
        { 0,"","","" },
        { 13521, "INV_Scroll_06", "=q2=Recipe: Flask of Supreme Power", "=ds=#p1# (300)",  "2.92%" },
        { 0,"","","" },
        { 13626, "INV_Misc_Head_Scourge_01", "=q1=Human Head of Ras Frostwhisper", "=ds=#m3#", "100%" },
        { 13986, "INV_Crown_01", "=q3=Crown of Caer Darrow", "=q1=#m4#: =ds=#s1#, #a1#" },
        { 13984, "INV_weapon_shortblade_21", "=q3=Darrowspike", "=q1=#m4#: =ds=#h1#, #w4#" },
        { 13982, "INV_Sword_39", "=q3=Warblade of Caer Darrow", "=q1=#m4#: =ds=#h2#, #w10#" },
        { 14002, "INV_Shield_05", "=q3=Darrowshire Strongguard", "=q1=#m4#: =ds=#w8#" },
        { 0,"","","" },
        { 0, "INV_Box_01", "=q6=#x12#", "" },
        { 12736, "INV_Drink_17","=q1=Frostwhisper's Embalming Fluid","=ds=#m3#" },
        };

    SCHOLOKormok = {
        { 0, "INV_Misc_Bag_09", "=q6=#j5#", "=q5=#n22#" },
        { 22303, "INV_Pants_08", "=q3=Ironweave Pants", "=ds=#s11#, #a1#", "23.33%" },
        { 22326, "INV_Jewelry_Ring_19", "=q3=Amalgam's Band", "=ds=#s13#", "16.67%" },
        { 22331, "INV_Jewelry_Ring_33", "=q3=Band of the Steadfast Hero", "=ds=#s13#", "15.42%" },
        { 22332, "INV_Sword_25", "=q3=Blade of Necromancy", "=ds=#h3#, #w10#", "25.42%" },
        { 22333, "INV_Hammer_04", "=q3=Hammer of Divine Might", "=ds=#h2#, #w6#", "12.50%" },
        { 0,"","","" },
        { 21984, "INV_Jewelry_Necklace_30", "=q1=Left Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        { 22046, "INV_Jewelry_Necklace_29", "=q1=Right Piece of Lord Valthalak's Amulet", "=ds=#m3#" },
        };

    SCHOLOInstructorMalicia = {
        { 16710, "INV_Bracer_07", "=q3=Shadowcraft Bracers", "=ds=#s8#, #a2# (D1, #c6#)", "3.51%" },
        { 0,"","","" },
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "1.81%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "1.12%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "1.27%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "1.03%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "0.88%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "0.85%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "1.00%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#",  "1.51%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "1.09%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#", "0.82%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "0.60%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "0.67%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "0.42%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.36%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.09%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "0.60%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#", "0.54%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "0.57%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "0.67%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "0.45%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "0.45%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "1.12%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#",  "1.39%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "0.91%" },
        };

    SCHOLODoctorTheolenKrastinov = {
        { 16684, "INV_Gauntlets_17", "=q3=Magister's Gloves",           "=ds=#s9#, #a1# (D1, #c3#)", "9.75%" },
        { 0,"","","" },
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "2.81%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "1.91%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "2.37%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "1.82%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "2.42%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "2.16%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "3.14%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#", "2.08%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "1.93%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#", "1.43%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "1.82%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "1.91%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "0.87%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.53%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.78%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "0.42%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#", "0.79%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "1.61%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "1.32%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "1.52%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "1.64%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "1.75%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#", "2.54%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "3.21%" },
        { 13523, "INV_Potion_24", "=q1=Blood of Innocents", "=ds=#m3#", "25.7%" },
        };

    SCHOLOLorekeeperPolkelt ={
        { 16705, "INV_Gauntlets_32", "=q3=Dreadmist Wraps", "=ds=#s9#, #a1# (D1, #c8#)", "14.54%" },
        { 0,"","","" },
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "0.53%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "0.67%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "0.55%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "0.47%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "0.57%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "0.89%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "0.57%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#",  "0.65%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "0.79%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#", "0.83%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "0.63%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "0.47%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "0.26%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.14%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.45%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "0.18%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#",  "0.30%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "0.49%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "0.32%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "0.30%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "0.30%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "0.41%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#", "0.67%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "0.49%" },
        };

    SCHOLOTheRavenian = {
        { 16716, "INV_Belt_15", "=q3=Wildheart Belt", "=ds=#s10#, #a2# (D1, #c1#)", "2.60%" },
        { 0,"","","" },
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "1.32%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "0.76%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "1.04%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "0.89%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "1.32%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "1.41%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "0.95%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#",  "1.52%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "0.82%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#",  "1.02%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "0.95%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "0.93%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "0.20%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.33%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.11%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "0.09%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#", "0.04%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "1.06%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "0.91%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "0.69%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "1.15%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "0.89%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#", "1.52%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "1.74%" },
        };

    SCHOLOLordAlexeiBarov = {
        { 16722, "INV_Bracer_14", "=q3=Lightforge Bracers", "=ds=#s8#, #a4# (D1, #c4#)", "3.37%" },
        { 0,"","","" },
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "4.94%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "3.39%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "5.30%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "4.05%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "2.86%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "2.38%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "4.79%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#", "4.55%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "2.08%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#", "2.35%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "2.83%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "2.38%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "1.01%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.83%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.62%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "1.13%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#", "1.43%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "1.49%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "1.73%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "1.61%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "2.65%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "2.20%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#","4.67%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "4.70%" },
        };

    SCHOLOLadyIlluciaBarov = {
        { 18681, "INV_Shoulder_05", "=q3=Burial Shawl",                 "=ds=#s3#, #a1#", "1.20%" },
        { 14633, "INV_Shoulder_02", "=q3=Necropile Mantle",             "=ds=#s3#, #a1#", "1.07%" },
        { 14626, "INV_Chest_Cloth_43", "=q3=Necropile Robe",            "=ds=#s5#, #a1#", "1.30%" },
        { 14629, "INV_Bracer_07", "=q3=Necropile Cuffs",                "=ds=#s8#, #a1#", "1.17%" },
        { 14631, "INV_Boots_05", "=q3=Necropile Boots",                 "=ds=#s12#, #a1#", "0.94%" },
        { 14632, "INV_Pants_08", "=q3=Necropile Leggings",              "=ds=#s11#, #a1#", "0.78%" },
        { 18682, "INV_Pants_02", "=q3=Ghoul Skin Leggings",             "=ds=#s11#, #a2#", "1.61%" },
        { 14637, "INV_Chest_Leather_03", "=q3=Cadaverous Armor",        "=ds=#s5#, #a2#",  "0.94%" },
        { 14638, "INV_Pants_07", "=q3=Cadaverous Leggings",             "=ds=#s11#, #a2#", "1.15%" },
        { 14640, "INV_Gauntlets_15", "=q3=Cadaverous Gloves",           "=ds=#s9#, #a2#",  "1.12%" },
        { 14636, "INV_Belt_16", "=q3=Cadaverous Belt",                  "=ds=#s10#, #a2#", "0.94%" },
        { 14641, "INV_Boots_05", "=q3=Cadaverous Walkers",              "=ds=#s12#, #a2#", "0.70%" },
        { 14612, "INV_Pants_06", "=q3=Bloodmail Legguards",             "=ds=#s11#, #a3#", "0.44%" },
        { 14616, "INV_Boots_01", "=q3=Bloodmail Boots",                 "=ds=#s12#, #a3#", "0.34%" },
        { 14615, "INV_Gauntlets_26", "=q3=Bloodmail Gauntlets",         "=ds=#s9#, #a3#", "0.49%" },
        { 14614, "INV_Belt_23", "=q3=Bloodmail Belt",                   "=ds=#s10#, #a3#", "0.42%" },
        { 14611, "INV_Chest_Leather_05", "=q3=Bloodmail Hauberk",       "=ds=#s5#, #a3#",  "0.44%" },
        { 14621, "INV_Boots_01", "=q3=Deathbone Sabatons",              "=ds=#s12#, #a4#", "0.75%" },
        { 14620, "INV_Belt_12", "=q3=Deathbone Girdle",                 "=ds=#s10#, #a4#", "0.70%" },
        { 14622, "INV_Gauntlets_28", "=q3=Deathbone Gauntlets",         "=ds=#s9#, #a4#", "0.60%" },
        { 14624, "INV_Chest_Chain_15", "=q3=Deathbone Chestplate",      "=ds=#s5#, #a4#", "0.81%" },
        { 14623, "INV_Pants_04", "=q3=Deathbone Legguards",             "=ds=#s11#, #a4#", "0.83%" },
        { 18684, "INV_Jewelry_Ring_15", "=q3=Dimly Opalescent Ring", "=ds=#s13#", "0.85%" },
        { 23201, "INV_Relics_LibramofHope", "=q3=Libram of Divinity", "=ds=#s16#, #w16#" },
        { 23200, "INV_Relics_TotemofLife", "=q3=Totem of Sustaining", "=ds=#s16#, #w15#", "3.5%" },
        { 18683, "INV_Hammer_13", "=q3=Hammer of the Vesper",           "=ds=#h1#, #w6#",  "1.35%" },
        { 18680, "INV_Weapon_Bow_08", "=q3=Ancient Bone Bow",           "=ds=#w2#", "1.17%" },
        };

    SCHOLODarkmasterGandling = {
        { 13937, "INV_Jewelry_Talisman_12", "=q4=Headmaster's Charge", "=ds=#w9#", "1.11%" },
        { 14514, "INV_Scroll_03", "=q4=Pattern: Robe of the Void",     "=ds=#p8# (300) =q1=#m1# =ds=#c8#", "6.71%" },
        { 14153, "INV_Chest_Cloth_51", "=q4=Robe of the Void",         "=ds=#s5#, #a1# =q1=#m1# =ds=#c8#" },
        { 0,"","","" },
        { 13398, "INV_Boots_08", "=q3=Boots of the Shrieker",                    "=ds=#s12#, #a2#", "10.75%" },
        { 13944, "INV_Chest_Chain_17","=q3=Tombstone Breastplate",               "=ds=#s5#, #a2#", "8.96%" },
        { 13950, "INV_Belt_09", "=q3=Detention Strap",                           "=ds=#s10#, #a3#", "0.24%" },
        { 13951, "INV_Bracer_18", "=q3=Vigorsteel Vambraces",                    "=ds=#s8#, #a4#", "10.38%" },
        { 22433, "INV_Jewelry_Ring_16", "=q3=Don Mauricio's Band of Domination", "=ds=#s13#", "7.72%" },
        { 13964, "INV_Weapon_ShortBlade_25", "=q3=Witchblade",                   "=ds=#h3#, #w4#", "9.82%" },
        { 13953, "INV_Sword_41", "=q3=Silent Fang",                              "=ds=#h3#, #w10#", "9.68%" },
        { 13938, "INV_Misc_Bone_TaurenSkull_01","=q3=Bonecreeper Stylus",        "=ds=#w12#", "8.80% " },
        { 0,"","","" },
        { 21525, "INV_Helmet_68", "=q2=Green Winter Hat", "=ds=#s1#, #a1# =q2=#m28#" },
        { 0,"","","" },
        { 16698, "INV_Helmet_29", "=q3=Dreadmist Mask",     "=ds=#s1#, #a1# (D1, #c8#)", "8.78%" },
        { 16686, "INV_Crown_02", "=q3=Magister's Crown",    "=ds=#s1#, #a1# (D1, #c3#)", "8.60%" },
        { 16693, "INV_Crown_01", "=q3=Devout Crown",        "=ds=#s1#, #a1# (D1, #c5#)", "7.89%" },
        { 16720, "INV_Helmet_27", "=q3=Wildheart Cowl",     "=ds=#s1#, #a2# (D1, #c1#)", "7.09%" },
        { 16677, "INV_Helmet_24", "=q3=Beaststalker's Cap", "=ds=#s1#, #a3# (D1, #c2#)", "7.00%" },
        { 16707, "INV_Helmet_41", "=q3=Shadowcraft Cap",    "=ds=#s1#, #a2# (D1, #c6#)", "6.65%" },
        { 16731, "INV_Helmet_02", "=q3=Helm of Valor",      "=ds=#s1#, #a4# (D1, #c9#)", "6.54%" },
        { 16727, "INV_Helmet_08", "=q3=Lightforge Helm",    "=ds=#s1#, #a4# (D1, #c4#)", "5.32%" },
        { 16667, "INV_Helmet_04", "=q3=Coif of Elements",   "=ds=#s1#, #a3# (D1, #c7#)", "2.86%" },
        { 0,"","","" },
        { 19276, "INV_Misc_Ticket_Tarot_Portal_01", "=q3=Ace of Portals", "=ds=#e16#", "2.20%" },
        { 0,"","","" },
        { 13501, "INV_Scroll_06", "=q2=Recipe: Major Mana Potion", "=ds=#p1# (295)", "8.64%" },
        };

    SCHOLOTrash = {
        { 18697, "INV_Boots_Fabric_01", "=q3=Coldstone Slippers", "=ds=#s12#, #a1#", "0.01%" },
        { 18698, "INV_Helmet_41", "=q3=Tattered Leather Hood", "=ds=#s1#, #a2#", "0.01%" },
        { 18699, "INV_Shoulder_27", "=q3=Icy Tomb Spaulders", "=ds=#s3#, #a2#", "0.01%" },
        { 18700, "INV_Bracer_07", "=q3=Malefic Bracers", "=ds=#s8#, #a2#", "0.01%" },
        { 14536, "INV_Chest_Chain_14", "=q3=Bonebrace Hauberk", "=ds=#s5#, #a3#", "0.01%" },
        { 18702, "INV_Belt_28", "=q3=Belt of the Ordained", "=ds=#s10#, #a4#", "0.01%" },
        { 18701, "INV_Jewelry_Ring_24", "=q3=Innervating Band", "=ds=#s13#", "0.01%" },
        { 0,"","","" },
        { 16254, "INV_Misc_Note_01", "=q3=Formula: Enchant Weapon - Lifestealing", "=ds=#p4# (300) =q1=#n66#", "0.93%" },
        { 16255, "INV_Misc_Note_01", "=q2=Formula: Enchant 2H Weapon - Major Spirit", "=ds=#p4# (300) =q1=#n67#", "0.88%" },
        { 15773, "INV_Scroll_06", "=q2=Pattern: Wicked Leather Armor", "=ds=#p7# (300) =q1=#n66#", "3.03%" },
        { 15776, "INV_Scroll_06", "=q2=Pattern: Runic Leather Armor", "=ds=#p7# (300) =q1=#n68#", "1.62%" },
        { 0,"","","" },
        { 12753, "INV_Misc_ShadowEgg", "=q2=Skin of Shadow", "=ds=#m3#" },
        { 13920, "INV_Misc_MonsterScales_17", "=q1=Healthy Dragon Scale", "=ds=#m2#" },
        { 16705, "INV_Gauntlets_32", "=q3=Dreadmist Wraps", "=ds=#s9#, #a1# (D1)", "0.03%" },
        { 16684, "INV_Gauntlets_17", "=q3=Magister's Gloves", "=ds=#s9#, #a1# (D1)", "1.27%" },
        { 16685, "INV_Belt_08", "=q3=Magister's Belt", "=ds=#s8#, #a1# (D1)", "0.22%" },
        { 16710, "INV_Bracer_07", "=q3=Shadowcraft Bracers", "=ds=#s8#, #a2# (D1)", "1.53%" },
        { 16716, "INV_Belt_15", "=q3=Wildheart Belt", "=ds=#s8#, #a2# (D1)", "1.84%" },
        { 16722, "INV_Bracer_14", "=q3=Lightforge Bracers", "=ds=#s8#, #a4# (D1)", "2.72%" },
        };

        -----------------
        --- Naxxramas ---
        -----------------

    NAXPatchwerk = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "11.39%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22368, "INV_Misc_Desecrated_ClothShoulder", "=q4=Desecrated Shoulderpads", "=q1=#m1# =ds=#c8#, #c3#, #c5#", "21.33%" },
        { 22361, "INV_Misc_Desecrated_MailShoulder", "=q4=Desecrated Spaulders", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#", "36.65%" },
        { 22354, "INV_Misc_Desecrated_PlateShoulder", "=q4=Desecrated Pauldrons", "=q1=#m1# =ds=#c6#, #c9#", "28.78%" },
        { 0,"","","" },
        { 22960, "INV_Misc_Cape_Naxxramas_02", "=q4=Cloak of Suturing", "=ds=#s4#", "12.84%" },
        { 22815, "INV_Axe_22", "=q4=Severance", "=ds=#h2#, #w1#", "16.15%" },
        { 22820, "INV_Wand_1H_Stratholme_D_01", "=q4=Wand of Fates", "=ds=#w12#", "23.19%" },
        { 22818, "INV_Shield_27", "=q4=The Plague Bearer", "=ds=#w8#", "15.53%" },
        { 22961, "INV_Jewelry_Ring_49Naxxramas", "=q4=Band of Reanimation", "=ds=#s13#", "22.15%" },
        };

    NAXGrobbulus = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22368, "INV_Misc_Desecrated_ClothShoulder", "=q4=Desecrated Shoulderpads", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22361, "INV_Misc_Desecrated_MailShoulder", "=q4=Desecrated Spaulders", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22354, "INV_Misc_Desecrated_PlateShoulder", "=q4=Desecrated Pauldrons", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 22968, "INV_Shoulder_14", "=q4=Glacial Mantle", "=ds=#s3#, #a1#" },
        { 22967, "INV_Shoulder_14", "=q4=Icy Scale Spaulders", "=ds=#s3#, #a3#" },
        { 22803, "INV_knife_1h_stratholme_d_02", "=q4=Midnight Haze", "=ds=#h3#, #w4#" },
        { 22988, "INV_Mace_1H_Stratholme_D_02", "=q4=The End of Dreams", "=ds=#h3#, #w6#" },
        { 22810, "INV_Weapon_Rifle_11", "=q4=Toxin Injector", "=ds=#w5#" },
        };

    NAXGluth = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22983, "INV_Shoulder_05", "=q4=Rime Covered Mantle", "=ds=#s3#, #a1#" },
        { 22813, "INV_Sword_46", "=q4=Claymore of Unholy Might", "=ds=#h2#, #w10#" },
        { 23075, "INV_Armor_Shield_Naxxramas_D_01", "=q4=Death's Bargain", "=ds=#w8#" },
        { 22994, "INV_Offhand_Stratholme_A_02", "=q4=Digested Hand of Power", "=ds=#s15#"},
        { 22981, "INV_Jewelry_Necklace_27Naxxramas", "=q4=Gluth's Missing Collar", "=ds=#s2#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 22368, "INV_Misc_Desecrated_ClothShoulder", "=q4=Desecrated Shoulderpads", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22361, "INV_Misc_Desecrated_MailShoulder", "=q4=Desecrated Spaulders", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22354, "INV_Misc_Desecrated_PlateShoulder", "=q4=Desecrated Pauldrons", "=q1=#m1# =ds=#c6#, #c9#" },
        { 22369, "INV_Misc_Desecrated_ClothBracer", "=q4=Desecrated Bindings", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22362, "INV_Misc_Desecrated_MailBracer", "=q4=Desecrated Wristguards", "=q1=#m1# =ds=#c4#, #c7#, #c2#, #c1#" },
        { 22355, "INV_Misc_Desecrated_PlateBracer", "=q4=Desecrated Bracers", "=q1=#m1# =ds=#c9#, #c6#" },
        { 22370, "INV_Misc_Desecrated_ClothBelt", "=q4=Desecrated Belt", "=q1=#m1# =ds=#c5#, #c3#, #c8#" },
        { 22363, "INV_Misc_Desecrated_MailBelt", "=q4=Desecrated Girdle", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22356, "INV_Misc_Desecrated_PlateBelt", "=q4=Desecrated Waistguard", "=q1=#m1# =ds=#c6#, #c9#" },
        { 22372, "INV_Misc_Desecrated_ClothBoots", "=q4=Desecrated Sandals", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22365, "INV_Misc_Desecrated_MailBoots", "=q4=Desecrated Boots", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22358, "INV_Misc_Desecrated_PlateBoots", "=q4=Desecrated Sabatons", "=q1=#m1# =ds=#c6#, #c9#" },
        };

    NAXThaddius = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22367, "INV_Misc_Desecrated_ClothHelm", "=q4=Desecrated Circlet", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22360, "INV_Misc_Desecrated_MailHelm", "=q4=Desecrated Headpiece", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22353, "INV_Misc_Desecrated_PlateHelm", "=q4=Desecrated Helmet", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 23070, "INV_Pants_08", "=q4=Leggings of Polarity", "=ds=#s11#, #a1#" },
        { 23000, "INV_Chest_Chain_15", "=q4=Plated Abomination Ribcage", "=ds=#s5#, #a4#" },
        { 22808, "INV_Mace_1H_Stratholme_D_01", "=q4=The Castigator", "=ds=#h1#, #w6#" },
        { 22801, "INV_Staff_31", "=q4=Spire of Twilight", "=ds=#w9#" },
        { 23001, "INV_Trinket_Naxxramas02", "=q4=Eye of Diminution", "=ds=#s14#" },
        };

    NAXAnubRekhan = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "27.61%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22369, "INV_Misc_Desecrated_ClothBracer", "=q4=Desecrated Bindings", "=q1=#m1# =ds=#c8#, #c3#, #c5#", "28.57%" },
        { 22362, "INV_Misc_Desecrated_MailBracer", "=q4=Desecrated Wristguards", "=q1=#m1# =ds=#c4#, #c7#, #c2#, #c1#", "31.30%" },
        { 22355, "INV_Misc_Desecrated_PlateBracer", "=q4=Desecrated Bracers", "=q1=#m1# =ds=#c9#, #c6#", "29.53%" },
        { 0,"","","" },
        { 22938, "INV_Misc_Cape_Naxxramas_02", "=q4=Cryptfiend Silk Cloak", "=ds=#s4#", "20.39%" },
        { 22936, "INV_Bracer_17", "=q4=Wristguards of Vengeance", "=ds=#s8#, #a4#", "16.85%" },
        { 22937, "INV_Offhand_Naxxramas_D_01", "=q4=Gem of Nerubis", "=ds=#s15#", "15.09%" },
        { 22939, "INV_Jewelry_Ring_50Naxxramas", "=q4=Band of Unanswered Prayers", "=ds=#s13#", "16.85%" },
        { 22935, "INV_Jewelry_Amulet_04", "=q4=Touch of Frost", "=ds=#s2#", "13.32%" },
        };

    NAXGrandWidowFaerlina = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "19.01%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22369, "INV_Misc_Desecrated_ClothBracer", "=q4=Desecrated Bindings", "=q1=#m1# =ds=#c8#, #c3#, #c5#", "25.22%" },
        { 22362, "INV_Misc_Desecrated_MailBracer", "=q4=Desecrated Wristguards", "=q1=#m1# =ds=#c4#, #c7#, #c2#, #c1#", "24.59%" },
        { 22355, "INV_Misc_Desecrated_PlateBracer", "=q4=Desecrated Bracers", "=q1=#m1# =ds=#c9#, #c6#", "35.74%" },
        { 0,"","","" },
        { 22941, "INV_Shoulder_07", "=q4=Polar Shoulder Pads", "=ds=#s3#, #a2#", "14.96%" },
        { 22940, "INV_Shoulder_16", "=q4=Icebane Pauldrons", "=ds=#s3#, #a4#", "21.55%" },
        { 22806, "INV_Sword_60", "=q4=Widow's Remorse", "=ds=#h1#, #w10#", "14.45%" },
        { 22942, "INV_Mace_29", "=q4=The Widow's Embrace", "=ds=#h3#, #w6#", "21.67%" },
        { 22943, "INV_Jewelry_Necklace_29Naxxramas", "=q4=Malice Stone Pendant", "=ds=#s2#", "17.49%" },
        };

    NAXMaexxna = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "11.13%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22371, "INV_Misc_Desecrated_ClothGlove", "=q4=Desecrated Gloves", "=q1=#m1# =ds=#c8#, #c3#, #c5#", "44.26%" },
        { 22364, "INV_Misc_Desecrated_MailGlove", "=q4=Desecrated Handguards", "=q1=#m1# =ds=#c4#, #c7#, #c2#, #c1#", "49.03%" },
        { 22357, "INV_Misc_Desecrated_PlateGloves", "=q4=Desecrated Gauntlets", "=q1=#m1# =ds=#c9#, #c6#", "90.80%" },
        { 0,"","","" },
        { 23220, "INV_Chest_Cloth_46", "=q4=Crystal Webbed Robe", "=ds=#s5#, #a1#", "11.34%" },
        { 22804, "INV_knife_1h_stratholme_d_01", "=q4=Maexxna's Fang", "=ds=#h1#, #w4#", "18.05%" },
        { 22807, "INV_Sword_11", "=q4=Wraith Blade", "=ds=#h3#, #w10#", "14.25%" },
        { 22947, "INV_Jewelry_Necklace_28Naxxramas", "=q4=Pendant of Forgotten Names", "=ds=#s2#", "31.88%" },
        { 22954, "INV_Trinket_Naxxramas04", "=q4=Kiss of the Spider", "=ds=#s14#", "11.62%" },
        };

    NAXInstructorRazuvious = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "24.39%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22372, "INV_Misc_Desecrated_ClothBoots", "=q4=Desecrated Sandals", "=q1=#m1# =ds=#c8#, #c3#, #c5#", "27.64%" },
        { 22365, "INV_Misc_Desecrated_MailBoots", "=q4=Desecrated Boots", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#", "31.10%" },
        { 22358, "INV_Misc_Desecrated_PlateBoots", "=q4=Desecrated Sabatons", "=q1=#m1# =ds=#c6#, #c9#", "26.02%" },
        { 0,"","","" },
        { 23017, "INV_Misc_Cape_Naxxramas_01", "=q4=Veil of Eclipse", "=ds=#s4#", "19.31%" },
        { 23219, "INV_Belt_13", "=q4=Girdle of the Mentor", "=ds=#s10#, #a4#", "8.74%" },
        { 23014, "INV_Sword_07", "=q4=Iblis, Blade of the Fallen Seraph", "=ds=#h1#, #w10#", "9.35%" },
        { 23009, "INV_Wand_1H_Stratholme_D_01", "=q4=Wand of the Whispering Dead", "=ds=#w12#", "12.80%" },
        { 23004, "INV_Relics_IdolofHealth", "=q4=Idol of Longevity", "=ds=#s16#, #w14#", "17.68%" },
        { 23018, "INV_Jewelry_Ring_50Naxxramas", "=q4=Signet of the Fallen Defender", "=ds=#s13#", "19.31%" },
        };

    NAXGothikderHarvester = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22372, "INV_Misc_Desecrated_ClothBoots", "=q4=Desecrated Sandals", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22365, "INV_Misc_Desecrated_MailBoots", "=q4=Desecrated Boots", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22358, "INV_Misc_Desecrated_PlateBoots", "=q4=Desecrated Sabatons", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 23032, "INV_Helmet_53", "=q4=Glacial Headdress", "=ds=#s1#, #a1#" },
        { 23021, "INV_Bracer_07", "=q4=The Soul Harvester's Bindings", "=ds=#s8#, #a1#" },
        { 23020, "INV_Helmet_04", "=q4=Polar Helmet", "=ds=#s1#, #a2#" },
        { 23073, "INV_Boots_08", "=q4=Boots of Displacement", "=ds=#s12#, #a2#" },
        { 23023, "INV_Jewelry_Necklace_29Naxxramas", "=q4=Sadist's Collar", "=ds=#s2#" },
        };

    NAXTheFourHorsemen = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22351, "INV_Misc_Desecrated_ClothChest", "=q4=Desecrated Robe", "=q1=#m1# =ds=#c8#, #c3#, #c5#" },
        { 22350, "INV_Misc_Desecrated_MailChest", "=q4=Desecrated Tunic", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22349, "INV_Misc_Desecrated_PlateChest", "=q4=Desecrated Breastplate", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 23071, "INV_Pants_Leather_09", "=q4=Leggings of Apocalypse", "=ds=#s11#, #a2#" },
        { 22809, "INV_Mace_26", "=q4=Maul of the Redeemed Crusader", "=ds=#h2#, #w6#" },
        { 22691, "INV_Sword_2H_AshbringerCorrupt", "=q4=Corrupted Ashbringer", "=ds=#h2#, #w10#" },
        { 22811, "INV_Weapon_Bow_13", "=q4=Soulstring", "=ds=#w2#" },
        { 23025, "INV_Jewelry_Ring_48Naxxramas", "=q4=Seal of the Damned", "=ds=#s13#" },
        { 23027, "INV_Trinket_Naxxramas01", "=q4=Warmth of Forgiveness", "=ds=#s14#" },
        };

    NAXNothderPlaguebringer = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#", "13.07%" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22370, "INV_Misc_Desecrated_ClothBelt", "=q4=Desecrated Belt", "=q1=#m1# =ds=#c5#, #c3#, #c8#", "26.23%" },
        { 22363, "INV_Misc_Desecrated_MailBelt", "=q4=Desecrated Girdle", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#", "32.67%" },
        { 22356, "INV_Misc_Desecrated_PlateBelt", "=q4=Desecrated Waistguard", "=q1=#m1# =ds=#c6#, #c9#", "29.66%" },
        { 0,"","","" },
        { 23030, "INV_Misc_Cape_Naxxramas_01", "=q4=Cloak of the Scourge", "=ds=#s4#", "13.33%" },
        { 22816, "INV_Axe_08", "=q4=Hatchet of Sundered Bone", "=ds=#h1#, #w1#", "15.99%" },
        { 23005, "INV_Relics_TotemofLife", "=q4=Totem of Flowing Water", "=ds=#s16#, #w15#", "3.01%" },
        { 23006, "INV_Relics_LibramofGrace", "=q4=Libram of Light", "=ds=#s16#, #w16#", "14.36%" },
        { 23029, "INV_Offhand_Naxxramas_04", "=q4=Noth's Frigid Heart", "=ds=#s15#", "11.09%" },
        { 23031, "INV_Jewelry_Ring_53Naxxramas", "=q4=Band of the Inevitable", "=ds=#s13#", "12.90%" },
        { 23028, "INV_Jewelry_Ring_35", "=q4=Hailstone Band", "=ds=#s13#", "13.59%" },
        };

    NAXHeiganderUnclean = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22370, "INV_Misc_Desecrated_ClothBelt", "=q4=Desecrated Belt", "=q1=#m1# =ds=#c5#, #c3#, #c8#" },
        { 22363, "INV_Misc_Desecrated_MailBelt", "=q4=Desecrated Girdle", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22356, "INV_Misc_Desecrated_PlateBelt", "=q4=Desecrated Waistguard", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 23035, "INV_Helmet_50", "=q4=Preceptor's Hat", "=ds=#s1#, #a1#" },
        { 23033, "INV_Helmet_20", "=q4=Icy Scale Coif", "=ds=#s1#, #a3#" },
        { 23019, "INV_Helmet_06", "=q4=Icebane Helmet", "=ds=#s1#, #a4#" },
        { 23068, "INV_Pants_Plate_20", "=q4=Legplates of Carnage", "=ds=#s11#, #a4#" },
        { 23036, "INV_Jewelry_Necklace_30Naxxramas", "=q4=Necklace of Necropsy", "=ds=#s2#" },
        };

    NAXLoatheb = {
        { 22726, "INV_Qiraj_JewelBlessed", "=q5=Splinter of Atiesh", "=ds=#m3#" },
        { 22727, "INV_Staff_20", "=q5=Frame of Atiesh", "=ds=#m2#" },
        { 0,"","","" },
        { 22366, "INV_Misc_Desecrated_ClothPants", "=q4=Desecrated Leggings", "=q1=#m1# =ds=#c5#, #c3#, #c8#" },
        { 22359, "INV_Misc_Desecrated_MailPants", "=q4=Desecrated Legguards", "=q1=#m1# =ds=#c7#, #c1#, #c2#, #c4#" },
        { 22352, "INV_Misc_Desecrated_PlatePants", "=q4=Desecrated Legplates", "=q1=#m1# =ds=#c6#, #c9#" },
        { 0,"","","" },
        { 23039, "INV_Weapon_Halberd_04", "=q4=The Eye of Nerub", "=ds=#w7#" },
        { 22800, "INV_Staff_13", "=q4=Brimstone Staff", "=ds=#w9#" },
        { 23037, "INV_Jewelry_Ring_52Naxxramas", "=q4=Ring of Spiritual Fervor", "=ds=#s13#" },
        { 23038, "INV_Jewelry_Ring_48Naxxramas", "=q4=Band of Unnatural Forces", "=ds=#s13#" },
        { 23042, "INV_Trinket_Naxxramas05", "=q4=Loatheb's Reflection", "=ds=#s14#" },
        };

    NAXSapphiron = {
        { 23050, "INV_Misc_Cape_Naxxramas_03", "=q4=Cloak of the Necropolis", "=ds=#s4#" },
        { 23045, "INV_Misc_Cape_Naxxramas_03", "=q4=Shroud of Dominion", "=ds=#s4#" },
        { 23072, "INV_Gauntlets_22", "=q4=Fists of the Unrelenting", "=ds=#s9#, #a4#" },
        { 23043, "INV_Shield_26", "=q4=The Face of Death", "=ds=#w8#" },
        { 23242, "INV_Weapon_Hand_03", "=q4=Claw of the Frost Wyrm", "=ds=#h4#, #w13#" },
        { 23049, "INV_Offhand_Naxxramas_03", "=q4=Sapphiron's Left Eye", "=ds=#s15#" },
        { 23048, "INV_Offhand_Naxxramas_02", "=q4=Sapphiron's Right Eye", "=ds=#s15#" },
        { 23040, "INV_Trinket_Naxxramas05", "=q4=Glyph of Deflection", "=ds=#s14#" },
        { 23047, "INV_Trinket_Naxxramas01", "=q4=Eye of the Dead", "=ds=#s14#" },
        { 23046, "INV_Trinket_Naxxramas06", "=q4=The Restrained Essence of Sapphiron", "=ds=#s14#" },
        { 23041, "INV_Trinket_Naxxramas03", "=q4=Slayer's Crest", "=ds=#s14#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 23545, "Spell_Shadow_DarkRitual", "=q4=Power of the Scourge", "=ds=#s3# #e17#" },
        { 23547, "Spell_Shadow_DeadofNight", "=q4=Resilience of the Scourge", "=ds=#s3# #e17#" },
        { 23549, "Spell_Shadow_AntiShadow", "=q4=Fortitude of the Scourge", "=ds=#s3# #e17#" },
        { 23548, "Spell_Shadow_DeathPact", "=q4=Might of the Scourge", "=ds=#s3# #e17#" },
        };

    NAXKelThuzard = {
        { 22802, "INV_Weapon_Shortblade_37", "=q4=Kingsfall", "=ds=#h1#, #w4#" },
        { 23054, "INV_Sword_61", "=q4=Gressil, Dawn of Ruin", "=ds=#h1#, #w10#" },
        { 23577, "INV_Sword_62", "=q4=The Hungering Cold", "=ds=#h1#, #w10#" }, 
        { 23056, "INV_Mace_27", "=q4=Hammer of the Twisting Nether", "=ds=#h1#, #w6#" },
        { 22798, "INV_Mace_25", "=q4=Might of Menethil", "=ds=#h2#, #w6#" },
        { 22799, "INV_Staff_15", "=q4=Soulseeker", "=ds=#w9#" },
        { 22821, "INV_Wand_1H_Stratholme_D_02", "=q4=Doomfinger", "=ds=#w12#" },
        { 22812, "INV_Weapon_Crossbow_12", "=q4=Nerubian Slavemaker", "=ds=#w3#" },
        { 22819, "INV_Shield_28", "=q4=Shield of Condemnation", "=ds=#w8#" },
        { 23057, "INV_Jewelry_Necklace_29Naxxramas", "=q4=Gem of Trapped Innocents", "=ds=#s2#" },
        { 23053, "INV_Jewelry_Necklace_28Naxxramas", "=q4=Stormrage's Talisman of Seething", "=ds=#s2#" },
        { 0,"","","" },
        { 22520, "INV_Misc_Urn_01", "=q4=The Phylactery of Kel'Thuzad", "=ds=#m2#", "100%" },
        { 23207, "INV_Misc_Token_ArgentDawn3", "=q4=Mark of the Champion", "=q1=#m4# =ds=#s14#" },
        { 23206, "INV_Misc_Token_ArgentDawn2", "=q4=Mark of the Champion", "=q1=#m4# =ds=#s14#" },
        { 23064, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of the Dreamwalker", "=ds=#s13# =q1=#m1# =ds=#c1#" },
        { 23067, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of the Cryptstalker", "=ds=#s13# =q1=#m1# =ds=#c2#" },
        { 23062, "INV_Jewelry_Ring_51Naxxramas", "=q4=Frostfire Ring", "=ds=#s13# =q1=#m1# =ds=#c3#" },
        { 23066, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of Redemption", "=ds=#s13# =q1=#m1# =ds=#c4#" },
        { 23061, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of Faith", "=ds=#s13# =q1=#m1# =ds=#c5#" },
        { 23060, "INV_Jewelry_Ring_51Naxxramas", "=q4=Bonescythe Ring", "=ds=#s13# =q1=#m1# =ds=#c6#" },
        { 23065, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of the Earthshatterer", "=ds=#s13# =q1=#m1# =ds=#c7#" },
        { 23063, "INV_Jewelry_Ring_51Naxxramas", "=q4=Plagueheart Ring", "=ds=#s13# =q1=#m1# =ds=#c8#" },
        { 23059, "INV_Jewelry_Ring_51Naxxramas", "=q4=Ring of the Dreadnaught", "=ds=#s13# =q1=#m1# =ds=#c9#" },
        { 0,"","","" },
        { 22733, "INV_Misc_AhnQirajTrinket_04", "=q1=Staff Head of Atiesh", "=ds=#m3#" },
        { 22632, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c1#"},
        { 22589, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c3#"},
        { 22631, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c5#"},
        { 22630, "INV_Staff_Medivh", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c8#"},
        };

    NAXTrash = {
        { 23069, "INV_Chest_Cloth_46", "=q4=Necro-Knight's Garb", "=ds=#s5#, #a1# =q1=#m1# =ds=#c5#, #c3#, #c8#" },
        { 23226, "INV_Chest_Leather_02", "=q4=Ghoul Skin Tunic", "=ds=#s5#, #a2#" },
        { 23663, "INV_Belt_32", "=q4=Girdle of Elemental Fury", "=ds=#s10#, #a3#" },
        { 23664, "INV_Shoulder_01", "=q4=Pauldrons of Elemental Fury", "=ds=#s3#, #a3# =q1=#m1# =ds=#c7#" },
        { 23665, "INV_Pants_Mail_14", "=q4=Leggings of Elemental Fury", "=ds=#s11#, #a3# =q1=#m1# =ds=#c7#" },
        { 23666, "INV_Belt_27", "=q4=Belt of the Grand Crusader", "=ds=#s10#, #a4# =q1=#m1# =ds=#c4#" },
        { 23667, "INV_Shoulder_22", "=q4=Spaulders of the Grand Crusader", "=ds=#s3#, #a4# =q1=#m1# =ds=#c4#" },
        { 23668, "INV_Pants_04", "=q4=Leggings of the Grand Crusader", "=ds=#s11#, #a4# =q1=#m1# =ds=#c4#" },
        { 23044, "INV_knife_1h_stratholme_d_03", "=q4=Harbinger of Doom", "=ds=#h1#, #w4#" },
        { 23221, "INV_Mace_28", "=q4=Misplaced Servo Arm", "=ds=#h1# #w6#" },
        { 23238, "INV_Armor_Shield_Naxxramas_D_02", "=q4=Stygian Buckler", "=ds=#w8#" },
        { 23237, "INV_Jewelry_Ring_48Naxxramas", "=q4=Ring of the Eternal Flame", "=ds=#s13#" },
        { 0,"","","" },
        { 0,"","","" },
        { 0,"","","" },
        { 22376, "INV_Misc_WartornScrap_Cloth", "=q3=Wartorn Cloth Scrap", "=ds=#m3#" },
        { 22373, "INV_Misc_WartornScrap_Leather", "=q3=Wartorn Leather Scrap", "=ds=#m3#" },
        { 22374, "INV_Misc_WartornScrap_Chain", "=q3=Wartorn Chain Scrap", "=ds=#m3#" },
        { 22375, "INV_Misc_WartornScrap_Plate", "=q3=Wartorn Plate Scrap", "=ds=#m3#" },
        { 0,"","","" },
        { 22708, "INV_Jewelry_Ring_35", "=q1=Fate of Ramaladni", "=ds=#m3#" },
        { 23055, "INV_Scroll_02", "=q1=Word of Thawing", "=ds=#m20#" },
        };
};