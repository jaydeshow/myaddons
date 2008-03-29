local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";

local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

AtlasLoot_SearchTables = {
        [1] = "AtlasLootItems";
        [2] = "AtlasLootExpansionItems";
        [3] = "AtlasLootBGItems";
        [4] = "AtlasLootGeneralPvPItems";
        [5] = "AtlasLootWorldPvPItems";
        [6] = "AtlasLootWBItems";
        [7] = "AtlasLootWorldEvents";
        [8] = "AtlasLootRepItems";
        [9] = "AtlasLootSetItems";
        [10] = "AtlasLootCrafting";
    };

function AtlasLoot_FindLootPage(text)
    for x,y in ipairs(AtlasLoot_SearchTables) do
        if AtlasLoot_Data[y] then
            y=AtlasLoot_Data[y];
            for k,v in pairs(y) do
                for i,j in pairs(v) do
                    local itemName, _, _, _, _, _, _, _, _, _ = GetItemInfo(j[1]);
                    if ((itemName ~= nil) and (string.lower(itemName) == string.lower(text))) or (string.lower(text) == string.lower(string.sub(j[3], 5))) then
                        return k;
                    end
                end
            end
        end
    end
    return nil;
end

function AtlasLoot_Search(text)
    AtlasLoot_LoadAllModules();
    local lootpage = AtlasLoot_FindLootPage(text);
    if lootpage == nil then
        DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..WHITE..AL["No match found for"].." \""..text.."\".");
    else
        if AtlasLoot_TableNames[lootpage] then
            AtlasLoot_ShowBossLoot(lootpage, AtlasLoot_TableNames[lootpage][1], AtlasLoot_AnchorFrame);
        else
            AtlasLoot_ShowBossLoot(lootpage, lootpage, AtlasLoot_AnchorFrame);
        end
    end
end
