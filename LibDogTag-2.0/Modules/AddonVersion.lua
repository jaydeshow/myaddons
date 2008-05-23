local MAJOR_VERSION = "LibDogTag-2.0"
local MINOR_VERSION = tonumber(("$Revision: 62500 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_MINOR_VERSION then
	_G.DogTag_MINOR_VERSION = MINOR_VERSION
end

DogTag_funcs[#DogTag_funcs+1] = function()

local L = DogTag.L
local hasEvent = DogTag.hasEvent
local eventData = DogTag.eventData
local toUpdate = DogTag.toUpdate

local RockComm, addonVersionReceptor
DogTag:AddAddonFinder("Rock", "LibRockComm-1.0", function(v)
	RockComm = v
	RockComm:AddAddonVersionReceptor(addonVersionReceptor)
end)
local mt = {__index = function(self, key)
	self[key] = false
	if not RockComm then
		return self[key]
	end
	RockComm:QueryAddonVersion(self[0], "WHISPER", key)
	return self[key]
end}

local addonVersions = setmetatable({}, {__index = function(self, key)
	local t = setmetatable({ [0] = key }, mt)
	self[key] = t
	return t
end})
DogTag:AddFakeGlobal("addonVersions", addonVersions)

function addonVersionReceptor(sender, addon, version)
	addonVersions[addon][sender] = version or _G.NONE or "None"
	-- trigger "AddonVersion" event
	if not hasEvent.AddonVersion then
		return
	end
	for text, unit in pairs(eventData.AddonVersion) do
		toUpdate[text] = true
	end
end

DogTag:AddTag("AddonVersion", {
	[[if UnitIsPlayer(${unit}) and UnitIsFriend("player", ${unit}) then
		local name, server = UnitName(${unit})
		if server and server ~= "" then
			name = name .. "-" .. server
		end
		value = DogTag___addonVersions[${arg}][name]
	end]],
	ret = "string;nil",
	arg = "string",
	events = "AddonVersion",
	globals = "DogTag.__addonVersions;UnitIsPlayer;UnitIsFriend;UnitName",
	doc = L["Return the version of the unit's argument addon if possible"],
	example = ('[AddonVersion(%s)] => %q'):format(MAJOR_VERSION, "r" .. MINOR_VERSION),
	category = L["Miscellaneous"]
})

end