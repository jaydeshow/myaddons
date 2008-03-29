if (GetLocale() == "koKR") then
-- Translated by acemage
-- Last Updated: 6/28/2007
-- missing some of black temple boss names.

local BabbleBoss = AceLibrary("Babble-Boss-2.2");
local BabbleZone = AceLibrary("Babble-Zone-2.2");

	AtlasLootBossNames["AuchShadowLabyrinth"] = {
		"선동자 검은심장".." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Grandmaster Vorpil"].." ("..BabbleZone["Shadow Labyrinth"]..")";
		BabbleBoss["Murmur"].." ("..BabbleZone["Shadow Labyrinth"]..")";
	};
end
