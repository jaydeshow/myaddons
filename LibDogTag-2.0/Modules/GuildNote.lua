local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L

local guildNotes, officerNotes
local function refreshGuildNotes(auto)
	if auto and getmetatable(guildNotes) then
		return
	end
	for k in pairs(guildNotes) do
		guildNotes[k] = nil
	end
	for k in pairs(officerNotes) do
		officerNotes[k] = nil
	end
	if not IsInGuild() then
		return nil
	end
	for i = 1, GetNumGuildMembers(true) do
		local name, _, _, _, _, _, note, officernote = GetGuildRosterInfo(i)
		if note then
			note = note:trim()
			if note == "" then
				note = nil
			end
		end
		if officernote then
			officernote = officernote:trim()
			if officernote == "" then
				officernote = nil
			end
		end
		guildNotes[name] = note
		officerNotes[name] = officernote
	end
end
local x = {__index=function(self, name)
	refreshGuildNotes()
	setmetatable(guildNotes, nil)
	setmetatable(officerNotes, nil)
	return self[name]
end}
guildNotes = setmetatable({},x)
officerNotes = setmetatable({},x)
DogTag:AddFakeGlobal("guildNotes", guildNotes)
DogTag:AddFakeGlobal("officerNotes", officerNotes)

local nextGuildRosterUpdate = 0
DogTag:AddEventHandler("GUILD_ROSTER_UPDATE", function()
	refreshGuildNotes(true)

	nextGuildRosterUpdate = GetTime() + 20
end)

DogTag:AddEventHandler("PLAYER_GUILD_UPDATE", function()
	refreshGuildNotes(true)
end)

DogTag:AddTimerHandler(function(num, currentTime)
	if currentTime > nextGuildRosterUpdate then
		if IsInGuild() then
			GuildRoster()
		end
		nextGuildRosterUpdate = currentTime + 20
	end
end)

DogTag:AddTag("GuildNote", {
	[[local name, server = UnitName(${unit})
	if name and (not server or server == "") then
		value = DogTag___guildNotes[name]
	end]],
	ret = "string;nil",
	globals = "UnitName;DogTag.__guildNotes",
	events = "GUILD_ROSTER_UPDATE",
	doc = L["Return the guild note of unit, if unit is in your guild"],
	example = ('[GuildNote] => %q'):format("My note"),
	category = L["Characteristics"]
})

DogTag:AddTag("OfficerNote", {
	[[local name, server = UnitName(${unit})
	if name and (not server or server == "") then
		value = DogTag___officerNotes[name]
	end]],
	ret = "string;nil",
	globals = "UnitName;DogTag.__officerNotes",
	events = "GUILD_ROSTER_UPDATE",
	doc = L["Return the officer's guild note of unit, if unit is in your guild and you are an officer"],
	example = ('[OfficerNote] => %q'):format("Special note"),
	category = L["Characteristics"]
})

end