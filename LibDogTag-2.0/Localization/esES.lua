local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 72789 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

if GetLocale() == "esES" then
	local L = _G.DogTag__L

	L["DogTag Help"] = "Ayuda de DogTag"

	-- races
	L["Blood Elf"] = "Elfo de sangre"
	L["Draenei"] = "Draenei"
	L["Dwarf"] = "Enano"
	L["Gnome"] = "Gnomo"
	L["Human"] = "Humano"
	L["Night Elf"] = "Elfo de la oscuridad"
	L["Orc"] = "Orco"
	L["Tauren"] = "Tauren"
	L["Troll"] = "Troll"
	L["Undead"] = "No-muerto"

	-- short races
	L["Blood Elf_short"] = "ES"
	L["Draenei_short"] = "Dr"
	L["Dwarf_short"] = "Dw"
	L["Gnome_short"] = "Gn"
	L["Human_short"] = "Hu"
	L["Night Elf_short"] = "EO"
	L["Orc_short"] = "Or"
	L["Tauren_short"] = "Ta"
	L["Troll_short"] = "Tr"
	L["Undead_short"] = "NM"

	-- classes
	L["Warrior"] = "Guerrero"
	L["Priest"] = "Sacerdote"
	L["Mage"] = "Mago"
	L["Shaman"] = "Chaman"
	L["Paladin"] = "Paladín"
	L["Warlock"] = "Burjo"
	L["Druid"] = "Druida"
	L["Rogue"] = "Bribón"
	L["Hunter"] = "Cazador"

	-- short classes
	L["Warrior_short"] = "Gu"
	L["Priest_short"] = "Sa"
	L["Mage_short"] = "Ma"
	L["Shaman_short"] = "Ch"
	L["Paladin_short"] = "Pa"
	L["Warlock_short"] = "Br"
	L["Druid_short"] = "Dr"
	L["Rogue_short"] = "Br"
	L["Hunter_short"] = "Ca"

	L["Player"] = PLAYER
	L["Target"] = TARGET
	L["Focus-target"] = FOCUS
	L["Mouse-over"] = "Ratón encima"
	L["%s's pet"] = "Mascota %s"
	L["%s's target"] = "Objetivo %s"
	L["Party member #%d"] = "Miembro grupo #%d"
	L["Raid member #%d"] = "Miembro Raid #%d"

	-- classifications
	L["Rare"] = ITEM_QUALITY3_DESC
	L["Rare-Elite"] = ITEM_QUALITY3_DESC .. "-" .. ELITE
	L["Elite"] = ELITE
	L["Boss"] = BOSS
	-- short classifications
	L["Rare_short"] = "r"
	L["Rare-Elite_short"] = "r"
	L["Elite_short"] = ""
	L["Boss_short"] = "b"

	L["Feigned Death"] = "Fingir Muerte"
	L["Stealthed"] = "Sigilo"
	L["Soulstoned"] = "Piedra del alma"

	L["Dead"] = DEAD
	L["Ghost"] = "Fantasma"
	L["Offline"] = PLAYER_OFFLINE
	L["Online"] = "En línea"
	L["Combat"] = "Combate"
	L["Resting"] = "Descansando"
	L["Tapped"] = "Roscado"
	L["AFK"] = "AFK"
	L["DND"] = "DND"

	L["True"] = "Verdad"

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
	L["Bear"] = "Oso"
	L["Cat"] = "Gato"
	L["Moonkin"] = "Moonkin"
	L["Aquatic"] = "Acuático"
	L["Flight"] = "Vuelo"
	L["Travel"] = "Viaje"
	L["Tree"] = "Arbol"

	L["Bear_short"] = "Os"
	L["Cat_short"] = "Ga"
	L["Moonkin_short"] = "Mk"
	L["Aquatic_short"] = "Ac"
	L["Flight_short"] = "Vu"
	L["Travel_short"] = "Vi"
	L["Tree_short"] = "Ar"

	-- shortgenders
	L["Male_short"] = "m"
	L["Female_short"] = "f"

	L["Leader"] = "Lider"

	-- spell trees
	L["Hybrid"] = "Híbrido" -- for all 3 trees
	L["Druid_Tree_1"] = "Saldo"
	L["Druid_Tree_2"] = "Lucha Animal"
	L["Druid_Tree_3"] = "Restauración"
	L["Hunter_Tree_1"] = "Maestría Bestias"
	L["Hunter_Tree_2"] = "Tiro"
	L["Hunter_Tree_3"] = "Supervivencia"
	L["Mage_Tree_1"] = "Arcano"
	L["Mage_Tree_2"] = "Fuego"
	L["Mage_Tree_3"] = "Escarcha"
	L["Paladin_Tree_1"] = "Santo"
	L["Paladin_Tree_2"] = "Protection"
	L["Paladin_Tree_3"] = "Retribution"
	L["Priest_Tree_1"] = "Disciplina"
	L["Priest_Tree_2"] = "Santo"
	L["Priest_Tree_3"] = "Sombra"
	L["Rogue_Tree_1"] = "Asesinato"
	L["Rogue_Tree_2"] = "Combate"
	L["Rogue_Tree_3"] = "Sutileza"
	L["Shaman_Tree_1"] = "Elemental"
	L["Shaman_Tree_2"] = "Mejora"
	L["Shaman_Tree_3"] = "Restoration"
	L["Warrior_Tree_1"] = "Armas"
	L["Warrior_Tree_2"] = "Furia"
	L["Warrior_Tree_3"] = "Protección"
	L["Warlock_Tree_1"] = "Afección"
	L["Warlock_Tree_2"] = "Demonologia"
	L["Warlock_Tree_3"] = "Destrucción"
end

end