local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 59952 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

DogTag:AddModifier("ShortClass", {
	([[if value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	else
		value = nil
	end]]):format(L["Priest"], L["Priest_short"], L["Mage"], L["Mage_short"], L["Shaman"], L["Shaman_short"], L["Paladin"], L["Paladin_short"], L["Warlock"], L["Warlock_short"], L["Druid"], L["Druid_short"], L["Rogue"], L["Rogue_short"], L["Hunter"], L["Hunter_short"], L["Warrior"], L["Warrior_short"]),
	ret = "string;nil",
	doc = L["Turn value into its shortened class equivalent"],
	example = ('[Text(%s):ShortClass] => %q; [Text(Hello):ShortClass] => ""'):format(L["Priest"], L["Priest_short"]),
	category = L["Abbreviations"],
})

DogTag:AddModifier("ShortRace", {
	([[if value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	else
		value = nil
	end]]):format(L["Blood Elf"], L["Blood Elf_short"], L["Draenei"], L["Draenei_short"], L["Dwarf"], L["Dwarf_short"], L["Gnome"], L["Gnome_short"], L["Human"], L["Human_short"], L["Night Elf"], L["Night Elf_short"], L["Orc"], L["Orc_short"], L["Tauren"], L["Tauren_short"], L["Troll"], L["Troll_short"], L["Undead"], L["Undead_short"]),
	ret = "string;nil",
	doc = L["Turn value into its shortened racial equivalent"],
	example = ('[Text(%s):ShortRace] => %q; [Text(Hello):ShortRace] => ""'):format(L["Blood Elf"], L["Blood Elf_short"]),
	category = L["Abbreviations"]
})

DogTag:AddModifier("ShortDruidForm", {
	([[if value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	elseif value == %q then
		value = %q
	else
		value = nil
	end]]):format(L["Bear"], L["Bear_short"], L["Cat"], L["Cat_short"], L["Moonkin"], L["Moonkin_short"], L["Aquatic"], L["Aquatic_short"], L["Flight"], L["Flight_short"], L["Travel"], L["Travel_short"], L["Tree"], L["Tree_short"]),
	ret = "string;nil",
	doc = L["Turn value into its shortened druid form equivalent"],
	example = ('[Text(%s):ShortDruidForm] => %q; [Text(Hello):ShortDruidForm] => ""'):format(L["Bear"], L["Bear_short"]),
	category = L["Abbreviations"]
})

local function abbreviate(text)
	local b = text:byte(1)
	if b <= 127 then
		return text:sub(1, 1)
	elseif b <= 223 then
		return text:sub(1, 2)
	elseif b <= 239 then
		return text:sub(1, 3)
	else
		return text:sub(1, 4)
	end
end
DogTag:AddFakeGlobal("abbreviate", abbreviate)
DogTag:AddModifier("Abbreviate", {
	[[if value:find(" ") then
		value = value:gsub(" *([^ ]+) *", DogTag___abbreviate)
	end]],
	value = "string",
	ret = "string",
	globals = "DogTag.__abbreviate",
	doc = L["Abbreviate value if a space is found"],
	example = '[Text(Hello):Abbreviate] => "Hello"; [Text(Hello World):Abbreviate] => "HW"',
	category = L["Abbreviations"]
})

end
