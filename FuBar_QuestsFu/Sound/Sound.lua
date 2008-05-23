local VERSION = tonumber(("$Revision: 47304 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Sound = QuestsFu:NewModule("Sound", "AceEvent-2.0", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-08-24 05:59:06 -0400 (Fri, 24 Aug 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local quixote = AceLibrary("Quixote-1.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Sound")
QuestsFu_Sound.lname = L["Sound"]
QuestsFu_Sound.desc = L["Play sounds in response to quest events"]

function QuestsFu_Sound:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Sound")
	QuestsFu:RegisterDefaults("Sound", "profile", {
		["complete"] = true,
		["progress"] = true,
		["type"] = {
			["*"] = "Faction",
		}
	})
	self.menu = {
		name = L["Sound"],
		desc = L["Play sounds in response to quest events"],
		type = "group",
		args = {
			complete = {
				type = 'group', name = L["Sound on complete"],
				desc = L["Play a sound when all a quests' objectives are complete"],
				args = {
					toggle = {
						type = 'toggle',
						name = L["Enabled"],
						desc = L["Enabled"],
						get = function() return self.db.profile.complete end,
						set = function(t) self.db.profile.complete = t end,
					},
					sound = {
						type = 'text', name = L["Sounds are..."],
						desc = L["Sounds are..."],
						get = function() return self.db.profile.type.complete end,
						set = function(t) self.db.profile.type.complete = t end,
						validate = {["Faction"] = L["Faction"], ["Peon"] = L["Peon"], ["Peasant"] = L["Peasant"], ["Random"] = L["Random"], },
					},
				},
			},
			progress = {
				type = 'group', name = L["Sound on progress"],
				desc = L["Play a sound when a one objective of a multi-part quest is completed"],
				args = {
					toggle = {
						type = 'toggle',
						name = L["Enabled"],
						desc = L["Enabled"],
						get = function() return self.db.profile.progress end,
						set = function(t) self.db.profile.progress = t end,
					},
					sound = {
						type = 'text', name = L["Sounds are..."],
						desc = L["Sounds are..."],
						get = function() return self.db.profile.type.progress end,
						set = function(t) self.db.profile.type.progress = t end,
						validate = {["Faction"] = L["Faction"], ["Peon"] = L["Peon"], ["Peasant"] = L["Peasant"], ["Random"] = L["Random"], },
					},
				},
			},
		},
	}
	local _,race = UnitRace("player")
	if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
		self.faction = 1
	else
		self.faction = 2
	end
	--Quick db-update check:
	if type(self.db.profile.type) == 'string' then
		self.db.profile.type = {
			["progress"] = self.db.profile.type,
			["complete"] = self.db.profile.type,
		}
	end
end

function QuestsFu_Sound:OnEnable()
	self:RegisterEvent("Quixote_Quest_Complete")
	self:RegisterEvent("Quixote_Leaderboard_Update")
end

do
	local sounds = 
	GetLocale() == "zhTW" and {
		"Sound\\Creature\\Peon\\PeonBuildingComplete1.wav", --Work complete!
		"Sound\\Creature\\Peon\\PeonBuildingComplete1.wav", --Work complete! -- purple, for localized sound
	} or {
		"Sound\\Creature\\Peon\\PeonBuildingComplete1.wav", --Work complete!
		"Interface\\Addons\\FuBar_QuestsFu\\Sound\\Peasant_work_done.mp3", --Job done!
	}
	function QuestsFu_Sound:Quixote_Quest_Complete(name, id)
		if self.db.profile.complete then
			PlaySoundFile(self:GetSoundFile("complete", sounds))
		end
	end
end

do
	local sounds = {
		"Sound\\Creature\\Peon\\PeonReady1.wav", --Ready to work!
		"Sound\\Creature\\Peasant\\PeasantWhat3.wav", --More work?
	}
	function QuestsFu_Sound:Quixote_Leaderboard_Update(name, id, lid, description, numHad, numGot, numNeeded, ltype)
		if self.db.profile.progress and numGot == numNeeded then
			local _,_,_,_,complete,nobj = quixote:GetQuestById(id)
			if not complete and nobj > 1 then
				PlaySoundFile(self:GetSoundFile("progress", sounds))
			end
		end
	end
end

function QuestsFu_Sound:GetSoundFile(t, sounds)
	local t = self.db.profile.type[t]
	if t == 'Faction' then
		return sounds[self.faction]
	elseif t == 'Peon' then
		return sounds[1]
	elseif t == 'Peasant' then
		return sounds[2]
	else --random
		return sounds[math.random(#sounds)]
	end
end

