local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 60006 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

if GetLocale() == "frFR" then
	local L = _G.DogTag__L

	L["DogTag Help"] = "Aide DogTag"

	-- races
	L["Blood Elf"] = "Elfe de sang"
	L["Draenei"] = "Draeneï"
	L["Dwarf"] = "Nain"
	L["Gnome"] = "Gnome"
	L["Human"] = "Humain"
	L["Night Elf"] = "Elfe de la nuit"
	L["Orc"] = "Orc"
	L["Tauren"] = "Tauren"
	L["Troll"] = "Troll"
	L["Undead"] = "Mort-vivant"

	-- short races
	L["Blood Elf_short"] = "ES"
	L["Draenei_short"] = "Dr"
	L["Dwarf_short"] = "Na"
	L["Gnome_short"] = "Gn"
	L["Human_short"] = "Hu"
	L["Night Elf_short"] = "EN"
	L["Orc_short"] = "Or"
	L["Tauren_short"] = "Ta"
	L["Troll_short"] = "Tr"
	L["Undead_short"] = "MV"

	-- classes
	L["Warrior"] = "Guerrier"
	L["Priest"] = "Prêtre"
	L["Mage"] = "Mage"
	L["Shaman"] = "Chaman"
	L["Paladin"] = "Paladin"
	L["Warlock"] = "Démoniste"
	L["Druid"] = "Druide"
	L["Rogue"] = "Voleur"
	L["Hunter"] = "Chasseur"

	-- short classes
	L["Warrior_short"] = "Gu"
	L["Priest_short"] = "Pr"
	L["Mage_short"] = "Ma"
	L["Shaman_short"] = "Ch"
	L["Paladin_short"] = "Pa"
	L["Warlock_short"] = "Dé"
	L["Druid_short"] = "Dr"
	L["Rogue_short"] = "Vo"
	L["Hunter_short"] = "Ch"

	L["Player"] = PLAYER
	L["Target"] = TARGET
	L["Focus-target"] = FOCUS
	L["Mouse-over"] = "Sous la souris"
	L["%s's pet"] = "Familier de %s"
	L["%s's target"] = "Cible de %s"
	L["Party member #%d"] = "Membre du groupe #%d"
	L["Raid member #%d"] = "Membre du raid #%d"

	-- classifications
	L["Rare"] = ITEM_QUALITY3_DESC
	L["Rare-Elite"] = ELITE .. "-" .. ITEM_QUALITY3_DESC
	L["Elite"] = ELITE
	L["Boss"] = BOSS
	-- short classifications
	L["Rare_short"] = "r"
	L["Rare-Elite_short"] = "r+"
	L["Elite_short"] = "+"
	L["Boss_short"] = "b"

	L["Feigned Death"] = "Feint la mort"
	L["Stealthed"] = "Camouflé"
	L["Soulstoned"] = "Âme conservée"

	L["Dead"] = DEAD
	L["Ghost"] = "Fantôme"
	L["Offline"] = PLAYER_OFFLINE
	L["Online"] = "En ligne"
	L["Combat"] = "Combat"
	L["Resting"] = "Repos"
	L["Tapped"] = "Touché"
	L["AFK"] = "ABS"
	L["DND"] = "NPD"

	L["True"] = "Vrai"

	L["Rage"] = RAGE
	L["Focus"] = FOCUS
	L["Energy"] = ENERGY
	L["Mana"] = MANA

	L["PvP"] = PVP
	L["FFA"] = "FFA"

	-- genders
	L["Male"] = MALE
	L["Female"] = FEMALE

	-- forms
	L["Bear"] = "Ours"
	L["Cat"] = "Félin"
	L["Moonkin"] = "Sélénien"
	L["Aquatic"] = "Aquatique"
	L["Flight"] = "Vol"
	L["Travel"] = "Voyage"
	L["Tree"] = "Arbre"

	L["Bear_short"] = "Ou"
	L["Cat_short"] = "Fé"
	L["Moonkin_short"] = "Sé"
	L["Aquatic_short"] = "Aq"
	L["Flight_short"] = "Vo"
	L["Travel_short"] = "Vy"
	L["Tree_short"] = "Ar"

	-- shortgenders
	L["Male_short"] = "h"
	L["Female_short"] = "f"

	L["Leader"] = "Chef"

	-- spell trees
	L["Hybrid"] = "Hybride" -- for all 3 trees
	L["Druid_Tree_1"] = "Equilibre"
	L["Druid_Tree_2"] = "Combat farouche"
	L["Druid_Tree_3"] = "Restauration"
	L["Hunter_Tree_1"] = "Maîtrise des bêtes"
	L["Hunter_Tree_2"] = "Précision"
	L["Hunter_Tree_3"] = "Survie"
	L["Mage_Tree_1"] = "Arcane"
	L["Mage_Tree_2"] = "Feu"
	L["Mage_Tree_3"] = "Givre"
	L["Paladin_Tree_1"] = "Sacré"
	L["Paladin_Tree_2"] = "Protection"
	L["Paladin_Tree_3"] = "Vindicte"
	L["Priest_Tree_1"] = "Discipline"
	L["Priest_Tree_2"] = "Sacré"
	L["Priest_Tree_3"] = "Ombre"
	L["Rogue_Tree_1"] = "Assassinat"
	L["Rogue_Tree_2"] = "Combat"
	L["Rogue_Tree_3"] = "Finesse"
	L["Shaman_Tree_1"] = "Elémentaire"
	L["Shaman_Tree_2"] = "Amélioration"
	L["Shaman_Tree_3"] = "Restauration"
	L["Warrior_Tree_1"] = "Armes"
	L["Warrior_Tree_2"] = "Fureur"
	L["Warrior_Tree_3"] = "Protection"
	L["Warlock_Tree_1"] = "Affliction"
	L["Warlock_Tree_2"] = "Démonologie"
	L["Warlock_Tree_3"] = "Destruction"
end

end