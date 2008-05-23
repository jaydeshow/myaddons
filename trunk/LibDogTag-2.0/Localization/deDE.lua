local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 59974 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

if GetLocale() == "deDE" then
	local L = _G.DogTag__L
	
	-- races
	L["Blood Elf"] = "Blutelf"
	L["Dwarf"] = "Zwerg"
	L["Gnome"] = "Gnom"
	L["Human"] = "Mensch"
	L["Night Elf"] = "Nachtelf"
	L["Undead"] = "Untoter"

	-- classes
	L["Warrior"] = "Krieger"
	L["Priest"] = "Priester"
	L["Mage"] = "Magier"
	L["Shaman"] = "Schamane"
	L["Warlock"] = "Hexenmeister"
	L["Druid"] = "Druide"
	L["Rogue"] = "Schurke"
	L["Hunter"] = "J\195\164ger"

	-- short classes
	L["Warrior_short"] = "Kr"
	L["Warlock_short"] = "He"
	L["Hunter_short"] = "J\195\164"

	L["%s's pet"] = "%s's Begleiter"
	L["%s's target"] = "%s's Ziel"
	L["Party member #%d"] = "Party Mitglied #%d"
	L["Raid member #%d"] = "Schlachtzug #%d"

	L["Feigned Death"] = "Totgestellt"
	L["Stealthed"] = "Verstohlen"
	L["Soulstoned"] = "Seelenstein"

	L["Ghost"] = "Geist"
	L["Online"] = "Online"
	L["Combat"] = "Kampf"
	L["Resting"] = "Ausgeruht"
	L["Tapped"] = "angezapft"

	-- forms
	L["Bear"] = "B\195\164r"
	L["Cat"] = "Katze"
	L["Moonkin"] = "Mondkin"
	L["Aquatic"] = "Wasser"
	L["Flight"] = "Flug"
	L["Travel"] = "Reise"
	L["Tree"] = "Baum"

	L["Bear_short"] = "B\195\164"
	L["Cat_short"] = "Ka"
	L["Moonkin_short"] = "Mk"
	L["Aquatic_short"] = "Wa"
	L["Flight_short"] = "Fl"
	L["Travel_short"] = "Re"
	L["Tree_short"] = "Ba"

	-- shortgenders
	L["Male_short"] = "m"
	L["Female_short"] = "w"

	L["Leader"] = "Leiter"

	-- spell trees
	L["Hybrid"] = "Hybride"
	L["Druid_Tree_1"] = "Gleichgewicht"
	L["Druid_Tree_2"] = "Wilder Kampf"
	L["Druid_Tree_3"] = "Wiederherstellung"
	L["Hunter_Tree_1"] = "Tierherrschaft"
	L["Hunter_Tree_2"] = "Treffsicherheit"
	L["Hunter_Tree_3"] = "Überleben"
	L["Mage_Tree_1"] = "Arkan"
	L["Mage_Tree_2"] = "Feuer"
	L["Paladin_Tree_1"] = "Heilig"
	L["Paladin_Tree_2"] = "Schutz"
	L["Paladin_Tree_3"] = "Vergeltung"
	L["Priest_Tree_1"] = "Disziplin"
	L["Priest_Tree_2"] = "Heilig"
	L["Priest_Tree_3"] = "Schatten"
	L["Rogue_Tree_1"] = "Meucheln"
	L["Rogue_Tree_2"] = "Kampf"
	L["Rogue_Tree_3"] = "T\195\164uschung"
	L["Shaman_Tree_1"] = "Elementar"
	L["Shaman_Tree_2"] = "Verst\195\164rkung"
	L["Shaman_Tree_3"] = "Wiederherstellung"
	L["Warrior_Tree_1"] = "Waffen"
	L["Warrior_Tree_2"] = "Furor"
	L["Warrior_Tree_3"] = "Schutz"
	L["Warlock_Tree_1"] = "Gebrechen"
	L["Warlock_Tree_2"] = "D\195\164monologie"
	L["Warlock_Tree_3"] = "Zerstörung"
end

end