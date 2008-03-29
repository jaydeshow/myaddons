local BabbleTrade=AceLibrary("Babble-Tradeskill-2.2");
local BabbleClass = AceLibrary("Babble-Class-2.2");
local BabbleZone = AceLibrary("Babble-Zone-2.2");
local BabbleInventory=AceLibrary("Babble-Inventory-2.2");
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

local RED = "|cffff0000";
local ORANGE = "|cffFF8400";

function AtlasLoot_CraftingMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Alchemy
    AtlasLootMenuItem_2_Name:SetText(BabbleTrade["Alchemy"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_2.lootpage="ALCHEMYMENU";
    AtlasLootMenuItem_2:Show();
    --Crafted Armor Sets
    AtlasLootMenuItem_4_Name:SetText(AL["Crafted Sets"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Box_01");
    AtlasLootMenuItem_4.lootpage="CRAFTSET";
    AtlasLootMenuItem_4:Show();
    --Crafted Epic Weapons
    AtlasLootMenuItem_5_Name:SetText(AL["Crafted Epic Weapons"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Sword_1H_Blacksmithing_02");
    AtlasLootMenuItem_5.lootpage="CraftedWeapons1";
    AtlasLootMenuItem_5:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Crafting"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootCraftedSetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "CRAFTINGMENU";
    getglobal("AtlasLootItemsFrame_NEXT").lootpage = "CRAFTSET2";
    getglobal("AtlasLootItemsFrame_NEXT").title = "|cffFFFFFF"..AL["Crafted Sets"];
    getglobal("AtlasLootItemsFrame_NEXT"):Show();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Plate Blacksmithing header
    AtlasLootMenuItem_1_Name:SetText(RED..BabbleTrade["Blacksmithing"]);
    AtlasLootMenuItem_1_Extra:SetText(ORANGE..BabbleInventory["Plate"]);
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Chest_Plate05");
    AtlasLootMenuItem_1.isheader = true;
    AtlasLootMenuItem_1:Show();
    --Imperial Plate
    AtlasLootMenuItem_2_Name:SetText(AL["Imperial Plate"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Belt_01");
    AtlasLootMenuItem_2.lootpage="ImperialPlate";
    AtlasLootMenuItem_2:Show();
    --The Darksoul
    AtlasLootMenuItem_3_Name:SetText(AL["The Darksoul"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_01");
    AtlasLootMenuItem_3.lootpage="TheDarksoul";
    AtlasLootMenuItem_3:Show();
    --Fel Iron Plate
    AtlasLootMenuItem_4_Name:SetText(AL["Fel Iron Plate"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Chest_Plate07");
    AtlasLootMenuItem_4.lootpage="FelIronPlate";
    AtlasLootMenuItem_4:Show();
    --Adamantite Battlegear
    AtlasLootMenuItem_5_Name:SetText(AL["Adamantite Battlegear"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_30");
    AtlasLootMenuItem_5.lootpage="AdamantiteB";
    AtlasLootMenuItem_5:Show();
    --Flame Guard
    AtlasLootMenuItem_6_Name:SetText(AL["Flame Guard"]);
    AtlasLootMenuItem_6_Extra:SetText(ORANGE..AL["Fire Resistance Gear"]);
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Helmet_22");
    AtlasLootMenuItem_6.lootpage="FlameG";
    AtlasLootMenuItem_6:Show();
    --Enchanted Adamantite Armor
    AtlasLootMenuItem_7_Name:SetText(AL["Enchanted Adamantite Armor"]);
    AtlasLootMenuItem_7_Extra:SetText(ORANGE..AL["Arcane Resistance Gear"]);
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Belt_29");
    AtlasLootMenuItem_7.lootpage="EnchantedAdaman";
    AtlasLootMenuItem_7:Show();
    --Khorium Ward
    AtlasLootMenuItem_8_Name:SetText(AL["Khorium Ward"]);
    AtlasLootMenuItem_8_Extra:SetText("");
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Boots_Chain_01");
    AtlasLootMenuItem_8.lootpage="KhoriumWard";
    AtlasLootMenuItem_8:Show();
    --Faith in Felsteel
    AtlasLootMenuItem_9_Name:SetText(AL["Faith in Felsteel"]);
    AtlasLootMenuItem_9_Extra:SetText("");
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Pants_Plate_06");
    AtlasLootMenuItem_9.lootpage="FaithFelsteel";
    AtlasLootMenuItem_9:Show();
    --Burning Rage
    AtlasLootMenuItem_10_Name:SetText(AL["Burning Rage"]);
    AtlasLootMenuItem_10_Extra:SetText("");
    AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_26");
    AtlasLootMenuItem_10.lootpage="BurningRage";
    AtlasLootMenuItem_10:Show();
    --Mail Blacksmithing Header
    AtlasLootMenuItem_12_Name:SetText(RED..BabbleTrade["Blacksmithing"]);
    AtlasLootMenuItem_12_Extra:SetText(ORANGE..BabbleInventory["Mail"]);
    AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_04");
    AtlasLootMenuItem_12.isheader = true;
    AtlasLootMenuItem_12:Show();
    --Bloodsoul Embrace
    AtlasLootMenuItem_13_Name:SetText(AL["Bloodsoul Embrace"]);
    AtlasLootMenuItem_13_Extra:SetText("");
    AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_15");
    AtlasLootMenuItem_13.lootpage="BloodsoulEmbrace";
    AtlasLootMenuItem_13:Show();
    --Fel Iron Chain
    AtlasLootMenuItem_14_Name:SetText(AL["Fel Iron Chain"]);
    AtlasLootMenuItem_14_Extra:SetText("");
    AtlasLootMenuItem_14_Icon:SetTexture("Interface\\Icons\\INV_Helmet_35");
    AtlasLootMenuItem_14.lootpage="FelIronChain";
    AtlasLootMenuItem_14:Show();
    --Tailoring Header
    AtlasLootMenuItem_16_Name:SetText(RED..BabbleTrade["Tailoring"]);
    AtlasLootMenuItem_16_Extra:SetText("");
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_21");
    AtlasLootMenuItem_16.isheader = true;
    AtlasLootMenuItem_16:Show();
    --Bloodvine Garb
    AtlasLootMenuItem_17_Name:SetText(AL["Bloodvine Garb"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_14");
    AtlasLootMenuItem_17.lootpage="BloodvineG";
    AtlasLootMenuItem_17:Show();
    --Netherweave Vestments
    AtlasLootMenuItem_18_Name:SetText(AL["Netherweave Vestments"]);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_29");
    AtlasLootMenuItem_18.lootpage="NeatherVest";
    AtlasLootMenuItem_18:Show();
    --Imbued Netherweave
    AtlasLootMenuItem_19_Name:SetText(AL["Imbued Netherweave"]);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Pants_Leather_09");
    AtlasLootMenuItem_19.lootpage="ImbuedNeather";
    AtlasLootMenuItem_19:Show();
    --Arcanoweave Vestments
    AtlasLootMenuItem_20_Name:SetText(AL["Arcanoweave Vestments"]);
    AtlasLootMenuItem_20_Extra:SetText(ORANGE..AL["Arcane Resistance Gear"]);
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_01");
    AtlasLootMenuItem_20.lootpage="ArcanoVest";
    AtlasLootMenuItem_20:Show();
    --The Unyielding
    AtlasLootMenuItem_21_Name:SetText(AL["The Unyielding"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Belt_03");
    AtlasLootMenuItem_21.lootpage="TheUnyielding";
    AtlasLootMenuItem_21:Show();
    --Whitemend Wisdom
    AtlasLootMenuItem_22_Name:SetText(AL["Whitemend Wisdom"]);
    AtlasLootMenuItem_22_Extra:SetText("");
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Helmet_53");
    AtlasLootMenuItem_22.lootpage="WhitemendWis";
    AtlasLootMenuItem_22:Show();
    --Spellstrike Infusion
    AtlasLootMenuItem_23_Name:SetText(AL["Spellstrike Infusion"]);
    AtlasLootMenuItem_23_Extra:SetText("");
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_14");
    AtlasLootMenuItem_23.lootpage="SpellstrikeInfu";
    AtlasLootMenuItem_23:Show();
    --Battlecast Garb
    AtlasLootMenuItem_24_Name:SetText(AL["Battlecast Garb"]);
    AtlasLootMenuItem_24_Extra:SetText("");
    AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Helmet_70");
    AtlasLootMenuItem_24.lootpage="BattlecastG";
    AtlasLootMenuItem_24:Show();
    --Soulcloth Embrace
    AtlasLootMenuItem_25_Name:SetText(AL["Soulcloth Embrace"]);
    AtlasLootMenuItem_25_Extra:SetText(ORANGE..AL["Arcane Resistance Gear"]);
    AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_12");
    AtlasLootMenuItem_25.lootpage="SoulclothEm";
    AtlasLootMenuItem_25:Show();
    --Primal Mooncloth
    AtlasLootMenuItem_26_Name:SetText(AL["Primal Mooncloth"]);
    AtlasLootMenuItem_26_Extra:SetText(ORANGE..BabbleTrade["Mooncloth Tailoring"]);
    AtlasLootMenuItem_26_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_04");
    AtlasLootMenuItem_26.lootpage="PrimalMoon";
    AtlasLootMenuItem_26:Show();
    --Shadow's Embrace
    AtlasLootMenuItem_27_Name:SetText(AL["Shadow's Embrace"]);
    AtlasLootMenuItem_27_Extra:SetText(ORANGE..BabbleTrade["Shadoweave Tailoring"]);
    AtlasLootMenuItem_27_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_25");
    AtlasLootMenuItem_27.lootpage="ShadowEmbrace";
    AtlasLootMenuItem_27:Show();
    --Wrath of Spellfire
    AtlasLootMenuItem_28_Name:SetText(AL["Wrath of Spellfire"]);
    AtlasLootMenuItem_28_Extra:SetText(ORANGE..BabbleTrade["Spellfire Tailoring"]);
    AtlasLootMenuItem_28_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_19");
    AtlasLootMenuItem_28.lootpage="SpellfireWrath";
    AtlasLootMenuItem_28:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Crafted Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootCraftedSetMenu2()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "CRAFTINGMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV").lootpage = "CRAFTSET";
    getglobal("AtlasLootItemsFrame_PREV").title = "|cffFFFFFF"..AL["Crafted Sets"];
    getglobal("AtlasLootItemsFrame_PREV"):Show();
    --Leatherworking Leather Header
    AtlasLootMenuItem_1_Name:SetText(RED..BabbleTrade["Leatherworking"]);
    AtlasLootMenuItem_1_Extra:SetText(ORANGE..BabbleInventory["Leather"]);
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Chest_Leather_04");
    AtlasLootMenuItem_1.isheader = true;
    AtlasLootMenuItem_1:Show();
    --Volcanic Armor
    AtlasLootMenuItem_2_Name:SetText(AL["Volcanic Armor"]);
    AtlasLootMenuItem_2_Extra:SetText(ORANGE..AL["Fire Resistance Gear"]);
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Pants_06");
    AtlasLootMenuItem_2.lootpage="VolcanicArmor";
    AtlasLootMenuItem_2:Show();
    --Ironfeather Armor
    AtlasLootMenuItem_3_Name:SetText(AL["Ironfeather Armor"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Chest_Leather_06");
    AtlasLootMenuItem_3.lootpage="IronfeatherArmor";
    AtlasLootMenuItem_3:Show();
    --Stormshroud Armor
    AtlasLootMenuItem_4_Name:SetText(AL["Stormshroud Armor"]);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Chest_Leather_08");
    AtlasLootMenuItem_4.lootpage="StormshroudArmor";
    AtlasLootMenuItem_4:Show();
    --Devilsaur Armor
    AtlasLootMenuItem_5_Name:SetText(AL["Devilsaur Armor"]);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Pants_Wolf");
    AtlasLootMenuItem_5.lootpage="DevilsaurArmor";
    AtlasLootMenuItem_5:Show();
    --Blood Tiger Harness
    AtlasLootMenuItem_6_Name:SetText(AL["Blood Tiger Harness"]);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_23");
    AtlasLootMenuItem_6.lootpage="BloodTigerH";
    AtlasLootMenuItem_6:Show();
    --Primal Batskin
    AtlasLootMenuItem_7_Name:SetText(AL["Primal Batskin"]);
    AtlasLootMenuItem_7_Extra:SetText("");
    AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Chest_Leather_03");
    AtlasLootMenuItem_7.lootpage="PrimalBatskin";
    AtlasLootMenuItem_7:Show();
    --Wild Draenish Armor
    AtlasLootMenuItem_8_Name:SetText(AL["Wild Draenish Armor"]);
    AtlasLootMenuItem_8_Extra:SetText("");
    AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Pants_Leather_07");
    AtlasLootMenuItem_8.lootpage="WildDraenishA";
    AtlasLootMenuItem_8:Show();
    --Thick Draenic Armor
    AtlasLootMenuItem_9_Name:SetText(AL["Thick Draenic Armor"]);
    AtlasLootMenuItem_9_Extra:SetText("");
    AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Boots_Chain_01");
    AtlasLootMenuItem_9.lootpage="ThickDraenicA";
    AtlasLootMenuItem_9:Show();
    --Fel Skin
    AtlasLootMenuItem_10_Name:SetText(AL["Fel Skin"]);
    AtlasLootMenuItem_10_Extra:SetText("");
    AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_22");
    AtlasLootMenuItem_10.lootpage="FelSkin";
    AtlasLootMenuItem_10:Show();
    --Strength of the Clefthoof
    AtlasLootMenuItem_11_Name:SetText(AL["Strength of the Clefthoof"]);
    AtlasLootMenuItem_11_Extra:SetText("");
    AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\INV_Boots_07");
    AtlasLootMenuItem_11.lootpage="SClefthoof";
    AtlasLootMenuItem_11:Show();
    --Primal Intent
    AtlasLootMenuItem_12_Name:SetText(AL["Primal Intent"]);
    AtlasLootMenuItem_12_Extra:SetText(ORANGE..BabbleTrade["Elemental Leatherworking"]);
    AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_45");
    AtlasLootMenuItem_12.lootpage="PrimalIntent";
    AtlasLootMenuItem_12:Show();
    --Windhawk Armor
    AtlasLootMenuItem_13_Name:SetText(AL["Windhawk Armor"]);
    AtlasLootMenuItem_13_Extra:SetText(ORANGE..BabbleTrade["Tribal Leatherworking"]);
    AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\INV_Chest_Leather_01");
    AtlasLootMenuItem_13.lootpage="WindhawkArmor";
    AtlasLootMenuItem_13:Show();
    --Leatherworking Leather Header
    AtlasLootMenuItem_16_Name:SetText(RED..BabbleTrade["Leatherworking"]);
    AtlasLootMenuItem_16_Extra:SetText(ORANGE..BabbleInventory["Mail"]);
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_12");
    AtlasLootMenuItem_16.isheader = true;
    AtlasLootMenuItem_16:Show();
    --Green Dragon Mail
    AtlasLootMenuItem_17_Name:SetText(AL["Green Dragon Mail"]);
    AtlasLootMenuItem_17_Extra:SetText(ORANGE..AL["Nature Resistance Gear"]);
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Pants_05");
    AtlasLootMenuItem_17.lootpage="GreenDragonM";
    AtlasLootMenuItem_17:Show();
    --Blue Dragon Mail
    AtlasLootMenuItem_18_Name:SetText(AL["Blue Dragon Mail"]);
    AtlasLootMenuItem_18_Extra:SetText(ORANGE..AL["Arcane Resistance Gear"]);
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_04");
    AtlasLootMenuItem_18.lootpage="BlueDragonM";
    AtlasLootMenuItem_18:Show();
    --Black Dragon Mail
    AtlasLootMenuItem_19_Name:SetText(AL["Black Dragon Mail"]);
    AtlasLootMenuItem_19_Extra:SetText(ORANGE..AL["Fire Resistance Gear"]);
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Pants_03");
    AtlasLootMenuItem_19.lootpage="BlackDragonM";
    AtlasLootMenuItem_19:Show();
    --Scaled Draenic Armor
    AtlasLootMenuItem_20_Name:SetText(AL["Scaled Draenic Armor"]);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Pants_Mail_07");
    AtlasLootMenuItem_20.lootpage="ScaledDraenicA";
    AtlasLootMenuItem_20:Show();
    --Felscale Armor
    AtlasLootMenuItem_21_Name:SetText(AL["Felscale Armor"]);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Boots_Chain_08");
    AtlasLootMenuItem_21.lootpage="FelscaleArmor";
    AtlasLootMenuItem_21:Show();
    --Felstalker Armor
    AtlasLootMenuItem_22_Name:SetText(AL["Felstalker Armor"]);
    AtlasLootMenuItem_22_Extra:SetText("");
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Belt_13");
    AtlasLootMenuItem_22.lootpage="FelstalkerArmor";
    AtlasLootMenuItem_22:Show();
    --Fury of the Nether
    AtlasLootMenuItem_23_Name:SetText(AL["Fury of the Nether"]);
    AtlasLootMenuItem_23_Extra:SetText("");
    AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Pants_Plate_12");
    AtlasLootMenuItem_23.lootpage="NetherFury";
    AtlasLootMenuItem_23:Show();
    --Netherscale Armor
    AtlasLootMenuItem_24_Name:SetText(AL["Netherscale Armor"]);
    AtlasLootMenuItem_24_Extra:SetText(ORANGE..BabbleTrade["Dragonscale Leatherworking"]);
    AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Belt_29");
    AtlasLootMenuItem_24.lootpage="NetherscaleArmor";
    AtlasLootMenuItem_24:Show();
    --Netherstrike Armor
    AtlasLootMenuItem_25_Name:SetText(AL["Netherstrike Armor"]);
    AtlasLootMenuItem_25_Extra:SetText(ORANGE..BabbleTrade["Dragonscale Leatherworking"]);
    AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Belt_03");
    AtlasLootMenuItem_25.lootpage="NetherstrikeArmor";
    AtlasLootMenuItem_25:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..AL["Crafted Sets"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLoot_AlchemyMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
        getglobal("AtlasLootMenuItem_"..i).isheader = false;
    end
    getglobal("AtlasLootItemsFrame_BACK"):Show();
    getglobal("AtlasLootItemsFrame_BACK").lootpage = "CRAFTINGMENU";
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Apprentice
    AtlasLootMenuItem_1_Name:SetText(AL["Apprentice"]);
    AtlasLootMenuItem_1_Extra:SetText("");
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_1.lootpage = "AlchemyApprentice1";
    AtlasLootMenuItem_1:Show();
    --Expert
    AtlasLootMenuItem_2_Name:SetText(AL["Expert"]);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_2.lootpage="AlchemyExpert1";
    AtlasLootMenuItem_2:Show();
    --Master
    AtlasLootMenuItem_3_Name:SetText(AL["Master"]);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_3.lootpage="AlchemyMaster1";
    AtlasLootMenuItem_3:Show();
    --Journeyman
    AtlasLootMenuItem_16_Name:SetText(AL["Journeyman"]);
    AtlasLootMenuItem_16_Extra:SetText("");
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_16.lootpage = "AlchemyJourneyman1";
    AtlasLootMenuItem_16:Show();
    --Artisan
    AtlasLootMenuItem_17_Name:SetText(AL["Artisan"]);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Potion_23");
    AtlasLootMenuItem_17.lootpage="AlchemyArtisan1";
    AtlasLootMenuItem_17:Show();
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i.."_Extra"):Show();
    end
    AtlasLoot_BossName:SetText("|cffFFFFFF"..BabbleTrade["Alchemy"]);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end
