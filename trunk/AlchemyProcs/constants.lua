-- Constants don't need localized

local L = AlchemyProcsLocals;

function getSubType(itemId)
	return select(7, GetItemInfo(itemId))
end

L["Flask"] = getSubType(32898);  --Shattrath Flask of Fortification
L["Elixir"] = getSubType(2454);  --Elixir of Lion's Strength
L["Potion"] = getSubType(858);   --Lesser Healing Potion 
L["Elemental"] = getSubType(22573);  -- Mote of Earth
L["Meta"] = getSubType(25868);   --Skyfire Diamond

L["Mutiple"] = string.gsub(LOOT_ITEM_CREATED_SELF_MULTIPLE, "%%s", "(.+)"); 
L["Mutiple"] = string.gsub(L["Mutiple"], "%%d", "(%-?%%d+)");      --Mutiple creation pattern
L["Single"] = string.gsub(LOOT_ITEM_CREATED_SELF, "%%s", "(.+)");  --Single creation pattern

L["Title"] = "Alchemy Procs"; -- GUI Title,you may localize this if you need

L["Addon"] = "AlchemyProcs";
L["Version"] = GetAddOnMetadata("AlchemyProcs", "Version")     	--UI Version
L["DataVersion"] = 1;  --Saved data format version
L["GUIVersion"] = 1;  --GUI options version