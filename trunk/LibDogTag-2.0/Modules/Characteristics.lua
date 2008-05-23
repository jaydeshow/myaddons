local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 63783 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local FakeGlobals = DogTag.FakeGlobals

DogTag:AddTag("IsFriend", {
	([[value = UnitIsFriend('player', ${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	events = "UNIT_FACTION",
	globals = "UnitIsFriend",
	doc = L["Return True if unit is a friend"],
	example = ('[IsFriend] => %q; [IsFriend] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("IsEnemy", {
	alias = "~IsFriend",
	doc = L["Return True if unit is an enemy"],
	example = ('[IsEnemy] => %q; [IsEnemy] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("CanAttack", {
	([[value = UnitCanAttack('player', ${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "UnitCanAttack",
	events = "UNIT_FACTION",
	doc = L["Return True if unit can be attacked"],
	example = ('[CanAttack] => %q; [CanAttack] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Name", {
	[[value = UnitName(${unit})]],
	ret = "string",
	events = "UNIT_NAME_UPDATE;PLAYER_ENTERING_WORLD",
	globals = "UnitName",
	doc = L["Return the name of unit"],
	example = ('[Name] => %q'):format(UnitName("player")),
	category = L["Characteristics"]
})

DogTag:AddTag("Exists", {
	("value = UnitExists(${unit}) and %q"):format(L["True"]),
	ret = "string",
	events = "PLAYER_ENTERING_WORLD",
	globals = "UnitExists",
	doc = L["Return True if unit exists"],
	example = ('[Exists] => %q; [Exists] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Realm", {
	[[local _
	_, value = UnitName(${unit})
	if value == "" then
		value = nil
	end]],
	ret = "string;nil",
	events = "UNIT_NAME_UPDATE",
	globals = "UnitName",
	doc = L["Return the realm of unit if not your own realm"],
	example = ('[Realm] => %q'):format(GetRealmName()), 
	category = L["Characteristics"]
})

DogTag:AddTag("NameRealm", {
	alias = "Text([Name][Realm:Prepend(-)])",
	doc = L["Return the name of unit, appending unit's realm if different from yours"],
	example = ('[NameRealm] => %q'):format(UnitName("player") .. "-" .. GetRealmName()),
	category = L["Characteristics"]
})

DogTag:AddTag("NameHostile", "Name:HostileColor")

DogTag:AddTag("Level", {
	function(data)
		if FakeGlobals.Base.__better_UnitLevel then
			return [[local x = DogTag___better_UnitLevel(${unit})
			if x > 0 then
				value = x
			else
				value = "??"
			end]], 'globals', "DogTag.__better_UnitLevel", 'events', "Talent"
		else
			return [[local x = UnitLevel(${unit})
			if x > 0 then
				value = x
			else
				value = "??"
			end]], 'globals', "UnitLevel"
		end
	end,
	ret = "number;string",
	events = "UNIT_LEVEL",
	doc = L["Return the level of unit"],
	example = ('[Level] => "%d"; [Level] => "??"'):format(UnitLevel("player")),
	category = L["Characteristics"]
})

DogTag:AddTag("IsMaxLevel", {
	alias = ("Level = %d"):format(_G.MAX_PLAYER_LEVEL),
	doc = L["Return %d if the level of unit is %d"]:format(_G.MAX_PLAYER_LEVEL, _G.MAX_PLAYER_LEVEL),
	example = ('[IsMaxLevel] => %q'):format(UnitLevel("player") >= _G.MAX_PLAYER_LEVEL and _G.MAX_PLAYER_LEVEL or ""),
	category = L["Characteristics"]
})

DogTag:AddTag("Class", {
	([[value = UnitClass]] .. (_G.UnitClassBase and "Base" or "") .. [[(${unit}) or %q]]):format(UNKNOWN),
	ret = "string",
	globals = _G.UnitClassBase and "UnitClassBase" or "UnitClass",
	doc = L["Return the class of unit"],
	example = ('[Class] => %q'):format((UnitClass("player"))),
	category = L["Characteristics"]
})

DogTag:AddTag("SmartClass", {
	alias = "[IsPlayer || [IsEnemy ? ~IsPet]] ? Class",
	doc = L["Return the class of unit if unit is a player or enemy, but not a pet"],
	example = ('[SmartClass] => %q'):format((UnitClass("player"))),
	category = L["Characteristics"]
})

DogTag:AddTag("PlayerClass", {
	alias = "IsPlayer ? Class",
	doc = L["Return the class of unit if unit is a player"],
	example = ('[PlayerClass] => %q'):format((UnitClass("player"))),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortClass", {
	alias = "Class:ShortClass",
	doc = L["Return the shortened class of unit"],
	example = ('[ShortClass] => %q'):format(L["Paladin_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortSmartClass", {
	alias = "SmartClass:ShortClass",
	doc = L["Return the shortened class of unit if unit is a player or enemy, but not a pet"],
	example = ('[ShortSmartClass] => %q'):format(L["Paladin_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortPlayerClass", {
	alias = "PlayerClass:ShortClass",
	doc = L["Return the shortened class of unit if unit is a player"],
	example = ('[ShortSmartClass] => %q'):format(L["Paladin_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Creature", {
	([[value = UnitCreatureFamily(${unit}) or UnitCreatureType(${unit}) or %q]]):format(UNKNOWN),
	ret = "string",
	globals = "UnitCreatureFamily;UnitCreatureType",
	doc = L["Return the creature family or type of unit"],
	example = ('[Creature] => %q; [Creature] => %q'):format(L["Cat"], L["Humanoid"]),
	category = L["Characteristics"]
})

DogTag:AddTag("CreatureType", {
	([[value = UnitCreatureType(${unit}) or %q]]):format(UNKNOWN),
	ret = "string",
	globals = "UnitCreatureType",
	doc = L["Return the creature type of unit"],
	example = ('[CreatureType] => %q; [CreatureType] => %q'):format(L["Beast"], L["Humanoid"]),
	category = L["Characteristics"]
})


DogTag:AddTag("Classification", {
	([[local c = UnitClassification(${unit})
	if c == "rare" then
		value = %q
	elseif c == "rareelite" then
		value = %q
	elseif c == "elite" then
		value = %q
	elseif c == "worldboss" then
		value = %q
	end]]):format(L["Rare"], L["Rare-Elite"], L["Elite"], L["Boss"]),
	ret = "string;nil",
	globals = "UnitClassification",
	doc = L["Return the classification of unit"],
	example = ('[Classification] => %q; [Classification] => %q; [Classification] => ""'):format(L["Elite"], L["Boss"]),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortClassification", {
	([[local c = UnitClassification(${unit})
	if c == "rare" then
		value = %q
	elseif c == "rareelite" then
		value = %q
	elseif c == "elite" then
		value = %q
	elseif c == "worldboss" then
		value = %q
	end]]):format(L["Rare_short"], L["Rare-Elite_short"], L["Elite_short"], L["Boss_short"]),
	ret = "string;nil",
	globals = "UnitClassification",
	doc = L["Return a shortened classification of unit"],
	example = ('[ShortClassification] => %q; [ShortClassification] => %q; [Classification] => ""'):format(L["Elite_short"], L["Boss_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Race", {
	[[value = UnitRace(${unit})]],
	ret = "string",
	globals = "UnitRace",
	doc = L["Return the race of unit"],
	example = ('[Race] => %q'):format((UnitRace("player"))),
	category = L["Characteristics"]
})

DogTag:AddTag("SmartRace", {
	alias = "IsPlayer ? Race ! Creature",
	doc = L["Return the race if unit is player, otherwise the creature family"],
	example = ('[SmartRace] => %q; [SmartRace] => %q'):format(UnitRace("player"), L["Humanoid"]),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortRace", {
	alias = "Race:ShortRace",
	doc = L["Return the shortened race of unit"],
	example = ('[ShortRace] => %q'):format(L["Blood Elf_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Plus", {
	([[value = UnitIsPlusMob(${unit}) and %q]]):format(L["Elite_short"]),
	ret = "string;nil",
	globals = "UnitIsPlusMob",
	doc = L["Return + if the unit is elite"],
	example = ('[Plus] => %q; [Plus] => ""'):format(L["Elite_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("Sex", {
	([[local sex = UnitSex(${unit})
	if sex == 2 then
		value = %q
	elseif sex == 3 then
		value = %q
	end]]):format(L["Male"], L["Female"]),
	ret = "string;nil",
	globals = "UnitSex",
	doc = L["Return Male, Female, or blank depending on unit"],
	example = ('[Sex] => %q; [Sex] => %q; [Sex] => ""'):format(L["Male"], L["Female"]),
	category = L["Characteristics"]
})

DogTag:AddTag("ShortSex", {
	([[local sex = UnitSex(${unit})
	if sex == 2 then
		value = %q
	elseif sex == 3 then
		value = %q
	end]]):format(L["Male_short"], L["Female_short"]),
	ret = "string;nil",
	globals = "UnitSex",
	doc = L["Return m, f, or blank depending on unit"],
	example = ('[ShortSex] => %q; [ShortSex] => %q; [ShortSex] => ""'):format(L["Male_short"], L["Female_short"]),
	category = L["Characteristics"]
})

DogTag:AddTag("GuildRank", {
	[[local _, rank = GetGuildInfo(${unit})
	value = rank]],
	ret = "string;nil",
	globals = "GetGuildInfo",
	doc = L["Return the guild rank of unit"],
	example = ('[GuildRank] => %q; [GuildRank] => %q'):format(L["Guild Leader"], L["Initiate"]),
	category = L["Characteristics"]
})

DogTag:AddTag("IsPlayer", {
	([[value = UnitIsPlayer(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "UnitIsPlayer",
	doc = L["Return True if unit is a player"],
	example = ('[IsPlayer] => %q; [IsPlayer] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("IsPet", {
	([[value = not UnitIsPlayer(${unit}) and UnitPlayerControlled(${unit}) and %q]]):format(L["True"]),
	ret = "string;nil",
	globals = "UnitIsPlayer;UnitPlayerControlled",
	doc = L["Return True if unit is a player's pet"],
	example = ('[IsPet] => %q; [IsPet] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTag("IsPlayerOrPet", {
	([[value = (UnitIsPlayer(${unit}) or UnitPlayerControlled(${unit}) or UnitPlayerOrPetInRaid(${unit})) and %q]]):format(L["True"]),
	fakeAlias = "IsPlayer | IsPet",
	ret = "string;nil",
	globals = "UnitIsPlayer;UnitPlayerControlled;UnitPlayerOrPetInRaid",
	doc = L["Return True if unit is a player or a player's pet"],
	example = ('[IsPlayerOrPet] => %q; [IsPlayerOrPet] => ""'):format(L["True"]),
	category = L["Characteristics"]
})

DogTag:AddTagAndModifier("PvPRank", {
	function(data)
		return [[local pvpname = UnitPVPName(${unit})
		local name = UnitName(${unit})
		if name ~= pvpname and pvpname then
		]] .. (not data.isMod and [[
			local str = "%s*" .. name .. "%s*"
			value = pvpname:gsub(str, '')
		]] or [[
			value = pvpname:gsub(name, value)
		]]) .. [[
		end]]
	end,
	ret = "string;nil",
	events = "UNIT_NAME_UPDATE;PLAYER_ENTERING_WORLD",
	globals = "UnitPVPName;UnitName",
	doc = L["Return the PvP rank or wrap the PvP rank of unit around value"],
	example = ('[PvPRank] => %q; [NameRealm:PvPRank] => %q'):format(_G.PVP_RANK_10_1, _G.PVP_RANK_10_1 .. " " .. UnitName("player") .. "-" .. GetRealmName()),
	category = L["Characteristics"]
})

DogTag:AddTagAndModifier("HostileColor", {
	function(data)
		return [[local r, g, b

		if UnitIsPlayer(${unit}) or UnitPlayerControlled(${unit}) then
			if UnitCanAttack(${unit}, "player") then
				-- they can attack me
				if UnitCanAttack("player", ${unit}) then
					-- and I can attack them
					r, g, b = unpack(colors.hostile)
				else
					-- but I can't attack them
					r, g, b = unpack(colors.civilian)
				end
			elseif UnitCanAttack("player", ${unit}) then
				-- they can't attack me, but I can attack them
				r, g, b = unpack(colors.neutral)
			elseif UnitIsPVP(${unit}) then
				-- on my team
				r, g, b = unpack(colors.friendly)
			else
				-- either enemy or friend, no violence
				r, g, b = unpack(colors.civilian)
			end
		elseif (UnitIsTapped(${unit}) and not UnitIsTappedByPlayer(${unit})) or UnitIsDead(${unit}) then
			r, g, b = unpack(colors.tapped)
		else
			local reaction = UnitReaction(${unit}, "player")
			if reaction then
				if reaction >= 5 then
					r, g, b = unpack(colors.friendly)
				elseif reaction == 4 then
					r, g, b = unpack(colors.neutral)
				else
					r, g, b = unpack(colors.hostile)
				end
			else
				r, g, b = unpack(colors.unknown)
			end
		end

		]] .. (data.isMod and [[
		value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
		value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]])
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_FACTION",
	globals = "UnitIsPlayer;UnitPlayerControlled;UnitCanAttack;UnitIsPVP;UnitIsTapped;UnitIsTappedByPlayer;UnitIsDead;UnitReaction",
	doc = L["Return the color or wrap value with the hostility color of unit"],
	example = '[Text(Hello):HostileColor] => "|cffff0000Hello|r"; [Text([HostileColor]Hello)] => "|cffff0000Hello"',
	category = L["Characteristics"]
})

DogTag:AddTagAndModifier("AggroColor", {
	function(data)
		return [[local val = UnitReaction("player", ${unit}) or 5

		local info = UnitReactionColor[val]
		]] .. (data.isMod and [[
		value = ("|cff%02x%02x%02x%s|r"):format(info.r * 255, info.g * 255, info.b * 255, value)
		]] or [[
		value = ("|cff%02x%02x%02x"):format(info.r * 255, info.g * 255, info.b * 255)
		]])
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_FACTION",
	globals = "UnitReaction;UnitReactionColor",
	doc = L["Return the color or wrap value with the aggression color of unit"],
	example = '[Text(Hello):AggroColor] => "|cffffff00Hello|r"; [Text([AggroColor]Hello)] => "|cffffff00Hello"',
	category = L["Characteristics"]
})

DogTag:AddTagAndModifier("ClassColor", {
	function(data)
		return [[local _,class = UnitClass(${unit})
		local r, g, b = unpack(colors[class] or colors.unknown)
		]] .. (data.isMod and [[
		value = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, value)
		]] or [[
		value = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
		]])
	end,
	value = "number;string",
	ret = "string",
	globals = "UnitClass",
	doc = L["Return the color or wrap value with the class color of unit"],
	example = '[Text(Hello):ClassColor] => "|cfff58cbdHello|r"; [Text([ClassColor]Hello)] => "|cfff58cbdHello"',
	category = L["Characteristics"]
})

DogTag:AddTagAndModifier("DifficultyColor", {
	function(data)
		return [[local level = ]] .. (FakeGlobals.Base.__better_UnitLevel and [[DogTag___better_]] or [[]]) .. [[UnitLevel(${unit})
		if level <= 0 or (UnitClassification(${unit}) ~= "normal" and UnitLevel(${unit}) <= 0) then
			level = 99
		end
		local info = GetDifficultyColor(level)
		]] .. (data.isMod and [[
		value = ("|cff%02x%02x%02x%s|r"):format(info.r * 255, info.g * 255, info.b * 255, value)
		]] or [[
		value = ("|cff%02x%02x%02x"):format(info.r * 255, info.g * 255, info.b * 255)
		]])
	end,
	value = "number;string",
	ret = "string",
	events = "UNIT_LEVEL;PLAYER_LEVEL_UP;Talent",
	globals = "UnitCanAttack;GetDifficultyColor;UnitLevel;DogTag.__better_UnitLevel;UnitClassification",
	doc = L["Return the color or wrap value with the difficulty color of unit's level compared to your own level"],
	example = '[Text(Hello):DifficultyColor] => "|cffff7f00Hello|r"; [Text([DifficultyColor]Hello)] => "|cffff7f00Hello"',
	category = L["Characteristics"]
})


end