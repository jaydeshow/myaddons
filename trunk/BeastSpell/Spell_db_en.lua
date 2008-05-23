if GetLocale() == "enUS" or GetLocale() == "enGB" then

BeastSpell_Data1 = {
	["dbVer"] = 1.1,
	["Wailing Caverns"] = {
		["Deviate Venomwing"] = {
			"Lighting Breath|2", -- [1]
		},
		["Deviate Stinglash"] = {
			"Lighting Breath|2", -- [1]
		},
		["Deviate Coiler Hatchling"] = {
			"Lighting Breath|1", -- [1]
		},
		["Deviate Dreadfang"] = {
			"Lighting Breath|2", -- [1]
		},
		["Deviate Stalker"] = {
			"Lighting Breath|2", -- [1]
		},
		["Deviate Crocolisk"] = {
			"Bite|3", -- [1]
		},
		["Kresh"] = {
			"Bite|3", -- [1]
		  "Shell Shield|1", -- [1]
		},	
		["Deviate Adder"] = {
			"Poisonous Spit|1", -- [1]
		},
		["Deviate Moccasin"] = {
			"Poisonous Spit|1", -- [1]
		},
		["Deviate Viper"] = {
			"Poisonous Spit|1", -- [1]
		},
	},
	["Azuremyst Isle"] = {
		["Death Ravager"] = {
			"Gore|2", -- [1]
		},
		["Ravager Specimen"] = {
			"Bite|2", -- [1]
			"Gore|2", -- [2]
		},
	},
	["Stonetalon Mountains"] = {
		["Deepmoss Webspinner"] = {
			"Bite|3", -- [1]
		},
		["Deepmoss Creeper"] = {
			"Bite|3", -- [1]
		},
		["Besseleth"] = {
			"Bite|3", -- [1]
		},
		["Twilight Runner"] = {
			"Cower|2", -- [1]
		},
	},
	["Blade's Edge Mountains"] = {
		["Scalewing"] = {
			"Lighting Breath|6", -- [1]
		},
		["Felsworn Scalewing"] = {
			"Lighting Breath|6", -- [1]
		},
		["Lashh'an Kaliri"] = {
			"Dive|3", -- [1]
		},
		["Bloodmaul Dire Wolf"] = {
			"Furious Howl|4", -- [1]
		},
		["Rema"] = {
			"Bite|9", -- [1]
			"Furious Howl|4", -- [2]
		},
		["Grovestalker Lynx"] = {
			"Cower|7", -- [1]
		},
		["Bloodmaul Battle Worg"] = {
			"Furious Howl|4", -- [1]
		},
		["Rip-Blade Ravager"] = {
			"Dash|3", -- [1]
			"Gore|9", -- [2]
		},
	},
	["Scarlet Monastery"] = {
		["Scarlet Tracking Hound"] = {
			"Dash|1", -- [1]
		},
	},
	["Ashenvale"] = {
		["Ghostpaw Runner"] = {
			"Bite|3", -- [1]
		},
		["Elder Ashenvale Bear"] = {
			"Claw|4", -- [1]
		},
		["Mist Howler"] = {
			"Furious Howl|1", -- [1]
		},
		["Ashenvale Bear"] = {
			"Claw|3", -- [1]
		},
		["Clattering Crawler"] = {
			"Claw|3", -- [1]
		},
		["Ghostpaw Alpha"] = {
			"Bite|4", -- [1]
			"Furious Howl|2", -- [2]
		},
		["Wildthorn Lurker"] = {
			"Bite|4", -- [1]
		},
	},
	["Eversong Woods"] = {
		["Crazed Dragonhawk"] = {
			"Fire Breath|1", -- [1]
		},
		["Feral Dragonhawk Hatchling"] = {
			"Fire Breath|1", -- [1]
		},
		["Elder Springpaw"] = {
			"Claw|2", -- [1]
		},
	},

	["Desolace"] = {
		["Scorpashi Snapper"] = {
			"Claw|4", -- [1]
			"Scorpid Poison|2", -- [2]
		},
		["Magram Bonepaw"] = {
			"Dash|1", -- [1]
		},
		["Dread Flyer"] = {
			"Dive|1", -- [1]
		},
		["Bonepaw Hyena"] = {
			"Dash|1", -- [1]
		},
		["Scorpashi Venomlash"] = {
			"Scorpid Poison|2", -- [1]
		},
		["Dread Ripper"] = {
			"Screech|2", -- [1]
		},
		["Scorpashi Lasher"] = {
			"Claw|5", -- [1]
			"Scorpid Poison|2", -- [2]
		},
	},
	["Netherstorm"] = {
		["Swiftwing Shredder"] = {
			"Lighting Breath|6", -- [1]
		},
		["Ripfang Lynx"] = {
			"Claw|9", -- [1]
			"Cower|7", -- [2]
		},
		["Warp Chaser"] = {
			"Warp|1", -- [1]
		},
	},
	["Ghostlands"] = {
		["Ghostclaw Ravager"] = {
			"Bite|3", -- [1]  a Ravager dont have Gore? need check
			"Claw|3", -- [2]
		},
		["Ghostclaw Lynx"] = {
			"Claw|2", -- [1]
		},
	},
	["Blasted Lands"] = {
		["Scorpok Stinger"] = {
			"Scorpid Poison|3", -- [1]
		},
		["Grunter"] = {
			"Dash|2", -- [1]
			"Dash|3", -- [2]
			"Charge|5", -- [3]
		},
		["Spiteflayer"] = {
			"Dive|3", -- [1]
		},
		["Ashmane Boar"] = {
			"Dash|2", -- [1]
			"Charge|5", -- [2]
			"Gore|7", -- [3]
		},
		["Ravage"] = {
			"Dash|3", -- [1]
		},
		["Clack the Reaver"] = {
			"Claw|7", -- [1]
			"Scorpid Poison|3", -- [2]
		},
	},
	["Bloodmyst Isle"] = {
		["Enraged Ravager"] = {
			"Gore|3", -- [1]
		},
	},
	["Winterspring"] = {
		["Frostsaber Stalker"] = {
			"Dash|3", -- [1]
			"Dash|3", -- [2]
		},
		["Frostsaber Huntress"] = {
			"Dash|3", -- [1]
		},
		["Rak'shiri"] = {
			"Dash|3", -- [1]
		},
	},
	["Swamp of Sorrows"] = {
		["Shadow Panther"] = {
			"Prowl|1", -- [1]
		},
		["Deathstrike Tarantula"] = {
			"Bite|6", -- [1]
		},
		["Sawtooth Snapper"] = {
			"Bite|6", -- [1]
		},
		["Monstrous Crawler"] = {
			"Claw|6", -- [1]
		},
		["Monstrous Crawler"] = {
			"Claw|6", -- [1]
		},
		["Swamp Jaguar"] = {
			"Dash|1", -- [1]
		},
	},
	["Wetlands"] = {
		["Giant Wetlands Crocolisk"] = {
			"Bite|4", -- [1]
		},
		["Leech Widow"] = {
			"Bite|4", -- [1]
		},
	},
	["Nagrand"] = {
		["Windroc Matriarch"] = {
			"Dive|3", -- [1]
			"Screech|5", -- [2]
		},
		["Windroc Huntress"] = {
			"Claw|9", -- [1]
			"Dive|3", -- [2]
		},
		["Ravenous Windroc"] = {
			"Claw|9", -- [1]
		},
		["Gutripper"] = {
			"Claw|9", -- [1]
			"Screech|5", -- [2]
		},
		["Dark Worg"] = {
			"Furious Howl|4", -- [1]
		},
		["Greater Windroc"] = {
			"Claw|9", -- [1]
			"Screech|5", -- [2]
		},
		["Windroc"] = {
			"Claw|9", -- [1]
			"Dive|3", -- [2]
		},
	},
	["Thousand Needles"] = {
		["Venomous Cloud Serpent"] = {
			"Lighting Breath|3", -- [1]
		},
		["Cloud Serpent"] = {
			"Lighting Breath|3", -- [1]
		},
		["Vile Sting"] = {
			"Claw|5", -- [1]
			"Scorpid Poison|2", -- [2]
		},
		["Scorpid Terror"] = {
			"Scorpid Poison|2", -- [1]
		},
		["Sparkleshell Snapper"] = {
			"Bite|5", -- [1]
		},
		["Elder Cloud Serpent"] = {
			"Lighting Breath|3", -- [1]
		},
		["Salt Flats Vulture"] = {
			"Screech|2", -- [1]
		},
		["Scorpid Reaver"] = {
			"Claw|4", -- [1]
			"Scorpid Poison|2", -- [2]
		},
		["Crag Stalker"] = {
			"Cower|3", -- [1]
		},
	},
	
	["Hillsbrad Foothills"] = {
		["Starving Mountain Lion"] = {
			"Cower|2", -- [1]
		},
		["Creepthess"] = {
			"Bite|3", -- [1]
		},
		["Feral Mountain Lion"] = {
			"Cower|3", -- [1]
		},
		["Forest Moss Creeper"] = {
			"Bite|3", -- [1]
		},
		["Snapjaw"] = {
			"Shell Shield|1", -- [1]
			"Bite|4", -- [1]
		},
		["Cranky Benj"] = {
			"Shell Shield|1", -- [1]
			"Bite|4", -- [1]
		},
		["Gray Bear"] = {
			"Claw|3", -- [1]
		},
		["Elder Moss Creeper"] = {
			"Bite|4", -- [1]
		},
		["Giant Moss Creeper"] = {
			"Bite|4", -- [1]
		},
	},
	["Loch Modan"] = {
		["Black Bear Patriarch"] = {
			"Claw|3", -- [1]
		},
		["Large Loch Crocolisk"] = {
			"Bite|3", -- [1]
		},
		["Forest Lurker"] = {
			"Bite|2", -- [1]
		},
		["Mangy Mountain Boar"] = {
			"Charge|2", -- [1]
		},
		["Wood Lurker"] = {
			"Bite|3", -- [1]
		},
		["Shanda the Spinner"] = {
			"Bite|3", -- [1]
		},
		["Mountain Boar"] = {
			"Charge|1", -- [1]
			"Gore|2", -- [2]
		},
		["Ol' Sooty"] = {
			"Claw|3", -- [1]
		},
		["Elder Mountain Boar"] = {
			"Charge|2", -- [1]
			"Gore|3", -- [2]
		},
		["Loch Crocolisk"] = {
			"Bite|2", -- [1]
		},
	},
	["Eastern Plaguelands"] = {
		["Monstrous Plaguebat"] = {
			"Cower|6", -- [1]
			"Screech|4", -- [2]
		},
		["Plagued Swine"] = {
			"Charge|6", -- [1]
			"Gore|8", -- [2]
		},
		["Noxious Plaguebat"] = {
			"Cower|5", -- [1]
		},
		["Plaguebat"] = {
			"Cower|5", -- [1]
			"Dive|3", -- [2]
		},
	},
	["The Barrens"] = {
		["Oasis Snapjaw"] = {
			"Bite|2", -- [1]
		},
		["Ornery Plainstrider"] = {
			"Cower|2", -- [1]
		},
		["Silithid Swarmer"] = {
			"Scorpid Poison|1", -- [1]
		},
		["Thunderhawk Hatchling"] = {
			"Lighting Breath|2", -- [1]
		},
		["Thunderhawk Cloudscraper"] = {
			"Lighting Breath|2", -- [1]
		},
		["Fleeting Plainstrider"] = {
			"Cower|1", -- [1]
		},
		["Elder Plainstrider"] = {
			"Cower|1", -- [1]
		},
		["Savannah Patriarch"] = {
			"Cower|2", -- [1]
		},
		["Silithid Creeper"] = {
			"Scorpid Poison|1", -- [1]
		},
		["Greater Thunderhawk"] = {
			"Lighting Breath|2", -- [1]
		},
		["Washte Pawne"] = {
			"Lighting Breath|3", -- [1]
		},
	},
	["Duskwood"] = {
			["Green Recluse"] = {
			"Bite|3", -- [1]
		},
		["Black Ravager"] = {
			"Bite|4", -- [1]
		},
		["Naraxis"] = {
			"Bite|4", -- [1]
		},
		["Lupos"] = {
			"Bite|3", -- [1]
		},
		["Black Ravager Mastiff"] = {
			"Bite|4", -- [1]
			"Furious Howl|2", -- [2]
		},
	},
	["Dun Morogh"] = {
		["Winter Wolf"] = {
			"Bite|1", -- [1]
		},
		["Timber"] = {
			"Bite|2", -- [1]
		},
		["Bjarn"] = {
			"Claw|2", -- [1]
		},
		["Starving Winter Wolf"] = {
			"Bite|2", -- [1]
		},
		["Scarred Crag Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Snow Tracker Wolf"] = {
			"Bite|1", -- [1]
		},
		["Large Crag Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Crag Boar Rib"] = {
			"Charge|1", -- [1]
		},
		["Small Crag Boar"] = {
			"Charge|1", -- [1]
		},
		["Elder Crag Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Juvenile Snow Leopard"] = {
			"Cower|1", -- [1]
		},
		["Mangeclaw"] = {
			"Claw|2", -- [1]
		},
		["Black Bear"] = {
			"Claw|1", -- [1]
		},
		["Ice Claw Bear"] = {
			"Claw|1", -- [1]
		},
	},
	["Uldaman"] = {
		["Venomlash Scorpid"] = {
			"Claw|5", -- [1]
		},
		["Deadly Cleft Scorpid"] = {
			"Scorpid Poison|3", -- [1]
		},
		["Shrike Bat"] = {
			"Cower|4", -- [1]
			"Dive|1", -- [2]
			"Screech|2", -- [3]
		},
		["Cleft Scorpid"] = {
			"Scorpid Poison|2", -- [1]
		},
	},
	["Stormwind"] = {
		["Sewer Crocolisk"] = {
			"Bite|7", -- [1]
		},
	},
	["Badlands"] = {
		["Mudrock Tortoise"] = {
			"Dash|2", -- [1]
		},
		["Broken Fang"] = {
			"Dash|1", -- [1]
		},
		["Ridge Stalker"] = {
			"Cower|4", -- [1]
			"Prowl|1", -- [2]
		},
		["Barnabus"] = {
			"Bite|6", -- [1]
		},
		["Zaricotl"] = {
			"Dive|3", -- [1]
		},
		["Elder Crag Coyote"] = {
			"Dash|1", -- [1]
			"Furious Howl|2", -- [2]
		},
		["Wayward Buzzard"] = {
			"Dive|1", -- [1]
		},
		["Ridge Stalker Patriarch"] = {
			"Prowl|2", -- [1]
		},
		["Ridge Huntress"] = {
			"Cower|4", -- [1]
		},
		["Crag Coyote"] = {
			"Bite|5", -- [1]
			"Dash|1", -- [2]
		},
		["Feral Crag Coyote"] = {
			"Dash|1", -- [1]
		},
	},
	["Silverpine Forest"] = {
		["Giant Grizzled Bear"] = {
			"Claw|2", -- [1]
		},
		["Bloodsnout Worg"] = {
			"Bite|3", -- [1]
		},
		["Worg"] = {
			"Furious Howl|1", -- [1]
		},
		["Ferocious Grizzled Bear"] = {
			"Claw|2", -- [1]
		},
	},
	["Azshara"] = {
		["Timberweb Recluse"] = {
			"Bite|6", -- [1]
		},
		["Scalebeard"] = {
			"Shell Shield|1", -- [1]
		},
	},
	["Un'Goro Crater"] = {
		["U'cha"] = {
			"Thunderstomp|3", -- [1]
		},
		["Uhk'loc"] = {
			"Bite|7", -- [1]
		},
		["Un'Goro Gorilla"] = {
			"Thunderstomp|3", -- [1]
		},
	},
	["Blackrock Spire"] = {
		["Scarshield Worg"] = {
			"Dash|3", -- [1]
		},
		["Blackrock Worg"] = {
			"Dash|3", -- [1]
		},
		["Bloodaxe Worg"] = {
			"Bite|8", -- [1]
			"Dash|3", -- [2]
			"Furious Howl|4", -- [3]
		},
	},
	["Stranglethorn Vale"] = {
		["Bhag'thera"] = {
			"Dash|2", -- [1]
		},
		["King Bangalash"] = {
			"Claw|6", -- [1]
			"Dash|2", -- [1]
		},
		["Young Panther"] = {
			"Cower|3", -- [1]
		},
		["Shadowmaw Panther"] = {
			"Prowl|1", -- [1]
		},
		["Misty Valley Gorilla"] = {
			"Thunderstomp|1", -- [1]
		},
		["Elder Shadowmaw Panther"] = {
		    "Dash|2", -- [1]
			"Prowl|2", -- [1]
		},
		["Kurzen War Tiger"] = {
			"Dash|1", -- [1]
		},
		["Jungle Thunderer"] = {
			"Thunderstomp|1", -- [1]
		},
		["Stranglethorn Tiger"] = {
			"Dash|1", -- [1]
		},
		["Jaguero Stalker"] = {
			"Cower|5", -- [1]
			"Prowl|3", -- [2]
		},
		["Sin'Dall"] = {
			"Dash|1", -- [1]
		},
		["Young Stranglethorn Tiger"] = {
			"Cower|3", -- [1]
		},
		["Panther"] = {
			"Cower|3", -- [1]
		},
	},
	["Zul'Gurub"] = {
		["Son of Hakkar"] = {
			"Lighting Breath|6", -- [1]
		},
		["Zulian Panther"] = {
			"Dash|3", -- [1]
			"Prowl|3", -- [2]
		},
		["Razzashi Broodwidow"] = {
			"Bite|8", -- [1]
		},
		["Zulian Guardian"] = {
			"Dash|3", -- [1]
		},
		["Razzashi Cobra"] = {
			"Poisonous Spit|3", -- [1]
		},
		["Razzashi Serpent"] = {
			"Poisonous Spit|3", -- [1]
		},
		["Soulflayer"] = {
			"Lighting Breath|6", -- [1]
		},
		["Razzashi Adder"] = {
			"Poisonous Spit|3", -- [1]
		},
		["lian Prowler"] = {
			"Dash|3", -- [1]
		},
	},
	["Tirisfal Glades"] = {
		["Ragged Scavenger"] = {
			"Bite|1", -- [1]
		},
		["Night Web Spider"] = {
			"Bite|1", -- [1]
		},
		["Greater Duskbat"] = {
			"Cower|1", -- [1]
		},
		["Vicious Night Web Spider"] = {
			"Bite|2", -- [1]
		},
		["Worg"] = {
			"Bite|2", -- [1]
		},
		["Night Web Matriarch"] = {
			"Bite|1", -- [1]
		},
	},
	["Silithus"] = {
		["Stonelash Pincer"] = {
			"Scorpid Poison|4", -- [1]
		},
		["Stonelash Flayer"] = {
			"Scorpid Poison|4", -- [1]
		},
		["Krellack"] = {
			"Scorpid Poison|4", -- [1]
		},
		["Stonelash Scorpid "] = {
			"Scorpid Poison|3", -- [1]
		},
	},
	["Tempest Keep"] = {
		["Bloodfalcon"] = {
			"Fire Breath|2", -- [1]
		},
	},
	["Sunken Temple"] = {
		["Murk Slitherer"] = {
			"Poisonous Spit|2", -- [1]
		},
		["Murk Spitter"] = {
			"Poisonous Spit|2", -- [1]
		},
		["Spawn of Hakkar"] = {
			"Dive|3", -- [1]
			"Lighting Breath|5", -- [2]
		},
		["Hakkari Sapper"] = {
			"Lighting Breath|5", -- [1]
		},
		["Hakkari Frostwing"] = {
			"Lighting Breath|5", -- [1]
		},
		["Hakkari Minion"] = {
			"Poisonous Spit|2", -- [1]
		},
	},
	["Burning Steppes"] = {
		["Firetail Scorpid"] = {
			"Scorpid Poison|4", -- [1]
		},
		["Deathlash Scorpid"] = {
			"Claw|7", -- [1]
			"Scorpid Poison|3", -- [2]
		},
		["Venomtip Scorpid"] = {
			"Scorpid Poison|3", -- [1]
		},
	},
	["The Hinterlands"] = {
		["Silvermane Wolf"] = {
			"Furious Howl|3", -- [1]
		},
		["Saltwater Snapjaw"] = {
			"Bite|7", -- [1]
		},
		["Ironback"] = {
			"Bite|7", -- [1]
			"Shell Shield|1", -- [2]
		},
		["Stalking the Stalkers"] = {
			"Dash|2", -- [1]
		},
		["Old Cliff Jumper"] = {
			"Bite|6", -- [1]
			"Dash|2", -- [2]
		},
		["Vilebranch Raiding Wolf"] = {
			"Bite|7", -- [1]
			"Dash|3", -- [2]
		},
		["Silvermane Howler"] = {
			"Furious Howl|2", -- [1]
		},
		["Witherbark Broodguard"] = {
			"Bite|6", -- [1]
		},
	},
	["Elwynn Forest"] = {
		["Gray Forest Wolf"] = {
			"Bite|1", -- [1]
		},
		["Prowler"] = {
			"Bite|2", -- [1]
		},
		["Mother Fang"] = {
			"Bite|2", -- [1]
		},
		["Rockhide Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Longsnout"] = {
			"Charge|1", -- [1]
		},
		["Forest Spider"] = {
			"Bite|1", -- [1]
		},
		["Young Forest Bear"] = {
			"Claw|2", -- [1]
		},
		["Porcine Entourage"] = {
			"Charge|1", -- [1]
		},
		["Stonetusk Boar"] = {
			"Charge|1", -- [1]
		},
		["Princess"] = {
			"Charge|1", -- [1]
		},
	},
	["Razorfen Kraul"] = {
		["Kraul Bat"] = {
			"Cower|3", -- [1]
		},
		["Blind Hunter"] = {
			"Cower|3", -- [1]
			"Dive|1", -- [2]
		},
		["Rotting Agam'ar"] = {
			"Charge|3", -- [1]
		},
		["Raging Agam'ar"] = {
			"Charge|3", -- [1]
		},
		["Agam'ar"] = {
			"Charge|3", -- [1]
		},
		["Greater Kraul Bat"] = {
			"Dive|1", -- [1]
		},
	},
	["Zul'Farrak"] = {
		["Sandfury Guardian"] = {
			"Poisonous Spit|2", -- [1]
		},
	},
	["Durotar"] = {
		["Durotar Tiger"] = {
			"Cower|1", -- [1]
		},
		["Elder Mottled Boar"] = {
			"Charge|1", -- [1]
			"Gore|2", -- [2]
		},
		["Corrupted Mottled Boar"] = {
			"Charge|1", -- [1]
			"Gore|2", -- [2]
		},
		["Venomtail Scorpid"] = {
			"Claw|2", -- [1]
			"Scorpid Poison|1", -- [2]
		},
		["Death Flayer"] = {
			"Claw|2", -- [1]
			"Scorpid Poison|1", -- [2]
		},
		["Encrusted Surf Crawler"] = {
			"Claw|2", -- [1]
		},
		["Dreadmaw Crocolisk"] = {
			"Bite|1", -- [1]
		},
		["Scorpion"] = {
			"Claw|1", -- [1]
		},
		["Sarkoth"] = {
			"Claw|1", -- [1]
		},
		["Corrupted Scorpid"] = {
			"Scorpid Poison|1", -- [1]
		},
		["Dire Mottled Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Mottled Boar"] = {
			"Charge|1", -- [1]
		},
		["Pygmy Surf Crawler"] = {
			"Claw|1", -- [1]
		},
	},
	["Dustwallow Marsh"] = {
		["Deadmire"] = {
			"Bite|6", -- [1]
		},
		["Mottled Drywallow Crocolisk"] = {
			"Bite|5", -- [1]
		},
		["Drywallow Snapper"] = {
			"Claw|5", -- [1]
		},
		["Darkfang Creeper"] = {
			"Bite|5", -- [1]
		},
		["Darkfang Lurker"] = {
			"Bite|5", -- [1]
		},
		["Drywallow Daggermaw"] = {
			"Bite|6", -- [1]
		},
		["Darkfang Spider"] = {
			"Bite|5", -- [1]
		},
		["Mudrock Snapjaw"] = {
			"Bite|6", -- [1]
		},
		["Drywallow Crocolisk"] = {
			"Bite|5", -- [1]
		},
		["Mudrock Tortoise"] = {
			"Bite|5", -- [1]
		},
	},
	["Alterac Mountains"] = {
		["Mountain Lion"] = {
			"Prowl|1", -- [1]
		},
	},
	["Feralas"] = {
		["Longtooth Howler"] = {
			"Furious Howl|3", -- [1]
		},
		["Old Grizzlegut"] = {
			"Claw|6", -- [1]
		},
		["Groddoc Thunderer"] = {
			"Thunderstomp|2", -- [1]
		},
		["Ironfur Patriarch"] = {
			"Claw|7", -- [1]
		},
		["Arash-ethis"] = {
			"Dive|2", -- [1]
		},
		["Ironfur Bear"] = {
			"Claw|6", -- [1]
		},
		["Longtooth Runner"] = {
			"Bite|6", -- [1]
			"Dash|2", -- [2]
			"Furious Howl|3", -- [3]
		},
		["Mongress"] = {
			"Claw|7", -- [1]
		},
		["Vale Screecher"] = {
			"Dive|2", -- [1]
			"Lighting Breath|4", -- [2]
		},
		["Rogue Vale Screecher"] = {
			"Dive|2", -- [1]
			"Lighting Breath|4", -- [2]
		},
	},
	["Shadowmoon Valley"] = {
		["Shadowwing Owl"] = {
			"Claw|9", -- [1]
			"Dive|3", -- [2]
		},
		["Scorchshell Pincer"] = {
			"Scorpid Poison|5", -- [1]
		},
		["Eclipsion Dragonhawk"] = {
			"Fire Breath|2", -- [1]
		},
		["Coilskar Cobra"] = {
			"Poisonous Spit|3", -- [1]
		},
	},
	["Mulgore"] = {
		["Prairie Wolf"] = {
			"Bite|1", -- [1]
		},
		["Prairie Wolf Alpha"] = {
			"Bite|2", -- [1]
		},
		["Bristleback Battleboar"] = {
			"Charge|1", -- [1]
		},
		["Flatland Cougar"] = {
			"Cower|1", -- [1]
		},
		["Mazzranache"] = {
			"Cower|1", -- [1]
		},
		["Battleboar"] = {
			"Charge|1", -- [1]
		},
		["Elder Plainstrider"] = {
			"Cower|1", -- [1]
		},
		["Prairie Stalker"] = {
			"Bite|1", -- [1]
		},
	},
	["Teldrassil"] = {
		["Lady Sathrah"] = {
			"Bite|2", -- [1]
		},
		["Giant Webwood Spider"] = {
			"Bite|2", -- [1]
		},
		["Strigid Owl"] = {
			"Claw|1", -- [1]
		},
		["Thistle Cub"] = {
			"Charge|1", -- [1]
		},
		["Githyiss the Vile"] = {
			"Bite|1", -- [1]
		},
		["Strigid Hunter"] = {
			"Claw|2", -- [1]
		},
		["Thistle Boar"] = {
			"Charge|1", -- [1]
			"Gore|1", -- [2]
		},
		["Webwood Venomfang"] = {
			"Bite|1", -- [1]
		},
		["Nightsaber"] = {
			"Cower|1", -- [1]
		},
		["Webwood Silkspinner"] = {
			"Bite|2", -- [1]
		},
	},
	["Redridge Mountains"] = {
		["Chatter"] = {
			"Bite|3", -- [1]
		},
		["Greater Tarantula"] = {
			"Bite|3", -- [1]
		},
		["Great Goretusk"] = {
			"Charge|2", -- [1]
			"Gore|3", -- [2]
		},
		["Tarantula"] = {
			"Bite|2", -- [1]
		},
		["Bellygrub"] = {
			"Charge|3", -- [1]
			"Gore|4", -- [2]
		},
	},
	["Blackfathom Deeps"] = {
		["Aku'mai Snapjaw"] = {
			"Bite|4", -- [1]
		},
		["Aku'mai Fisher"] = {
			"Bite|3", -- [1]
			"Shell Shield|1", -- [2]
		},
		["Snapping Crustacean"] = {
			"Claw|3", -- [1]
		},
		["Barbed Crustacean"] = {
			"Claw|4", -- [1]
		},
		["Skittering Crustacean"] = {
			"Claw|3", -- [1]
		},
		["Ghamoo-ra"] = {
			"Bite|3", -- [1]
			"Bite|4", -- [2]
			"Shell Shield|1", -- [3]
		},
	},
	["Blackrock Depths"] = {
		["Deep Stinger"] = {
			"Claw|7", -- [1]
			"Scorpid Poison|3", -- [2]
		},
		["Dark Screecher"] = {
			"Cower|5", -- [1]
			"Dive|3", -- [2]
		},
		["Cave Creeper"] = {
			"Bite|7", -- [1]
		},
	},
	["Western Plaguelands"] = {
		["Bloodshot"] = {
			"Can not be Tamed ", -- [1]
		},
		["Diseased Grizzly"] = {
			"Claw|7", -- [1]
		},
		["Carrion Vulture"] = {
			"Dive|3", -- [1]
			"Screech|3", -- [2]
		},
		["Diseased Wolf"] = {
			"Bite|7", -- [1]
		},
	},
	["Arathi Highlands"] = {
		["Plains Creeper"] = {
			"Bite|5", -- [1]
		},
		["Giant Plains Creeper"] = {
			"Bite|5", -- [1]
		},
	},
	
	["Winterspring"] = {
		["Owl Companion"] = {
			"Claw|7", -- [1]
		},
		["Shardtooth Bear"] = {
			"Claw|7", -- [1]
		},
		["Winterspring Owl"] = {
			"Dive|3", -- [1]
		},
		["Winterspring Screecher"] = {
			"Claw|8", -- [1]
			"Dive|3", -- [2]
			"Screech|4", -- [3]
		},
		["Frostsaber Stalker"] = {
			"Prowl|3", -- [1]
		},
		["Elder Shardtooth"] = {
			"Claw|8", -- [1]
		},
		["Frostsaber Cub"] = {
			"Cower|6", -- [1]
		},
	},
	["Westfall"] = {
		["Shore Crawler"] = {
			"Claw|3", -- [1]
		},
		["Goretusk"] = {
			"Charge|2", -- [1]
			"Gore|2", -- [2]
		},
		["Coyote Packleader"] = {
			"Bite|2", -- [1]
			"Furious Howl|1", -- [2]
		},
		["Coyote"] = {
			"Bite|2", -- [1]
		},
		["Young Goretusk"] = {
			"Charge|2", -- [1]
		},
		["Greater Fleshripper"] = {
			"Screech|1", -- [1]
		},
		["Great Goretusk"] = {
			"Charge|2", -- [1]
		},
	},
	["Darkshore"] = {
		["Thistle Bear"] = {
			"Claw|2", -- [1]
		},
		["Giant Foreststrider"] = {
			"Cower|2", -- [1]
		},
		["Foreststrider"] = {
			"Cower|1", -- [1]
		},
		["Moonstalker Runt"] = {
			"Cower|1", -- [1]
		},
		["Tide Crawler"] = {
			"Claw|2", -- [1]
		},
		["Moonstalker Sire"] = {
			"Cower|2", -- [1]
		},
		["Den Mother"] = {
			"Claw|3", -- [1]
		},
		["Ghost Saber"] = {
			"Claw|3", -- [1]
		},
	},
	["Felwood"] = {
		["Olm the Wise"] = {
			"Claw|7", -- [1]
			"Dive|3", -- [2]
			"Screech|3", -- [3]
		},
		["Felpaw Wolf"] = {
			"Furious Howl|3", -- [1]
			"Bite|6", -- [1]
		},
		["Ironbeak Hunter"] = {
			"Claw|7", -- [1]
			"Dive|3", -- [2]
		},
		["Angerclaw Mauler"] = {
			"Claw|7", -- [1]
		},
		["Death Howl"] = {
			"Furious Howl|3", -- [1]
		},
		["Ironbeak Owl"] = {
			"Screech|3", -- [1]
		},
		["Ironbeak Screecher"] = {
			"Dive|3", -- [1]
		},
		["Snarler"] = {
			"Bite|6", -- [1]
		},
		["Felpaw Ravager"] = {
			"Bite|7", -- [1]
		},
		["Ironbeak Owl"] = {
			"Dive|2", -- [1]
		},
	},
	["Tanaris"] = {
		["Blisterpaw Hyena"] = {
			"Dash|2", -- [1]
		},
		["Scorpid Dunestalker"] = {
			"Scorpid Poison|3", -- [1]
		},
		["Rabid Blisterpaw"] = {
			"Dash|2", -- [1]
		},
		["Murderous Blisterpaw"] = {
			"Dash|2", -- [1]
		},
		["Scorpid Hunter"] = {
			"Claw|6", -- [1]
			"Scorpid Poison|3", -- [2]
		},
		["Scorpid Tail Lasher"] = {
			"Scorpid Poison|3", -- [1]
		},
		["Starving Blisterpaw"] = {
			"Dash|2", -- [1]
		},
		["Giant Surf Glider"] = {
			"Shell Shield|1", -- [1]
		},
		["Roc"] = {
			"Dive|2", -- [1]
		},
		["Fire Roc"] = {
			"Dive|2", -- [1]
		},
		["Searing Roc"] = {
			"Dive|2", -- [1]
		},
		["Greater Firebird"] = {
			"Dive|2", -- [1]
		},
	},
	["Searing Gorge"] = {
		["Rekk'tilac"] = {
			"Bite|6", -- [1]
			"Bite|7", -- [2]
		},
	},
	
	["Hellfire Peninsula"] = {
		["Thornfang Ravager"] = {
			"Gore|8", -- [1]
		},
		["Male Kaliri Hatchling"] = {
			"Claw|8", -- [1]
		},
		["Kaliri Swooper"] = {
			"Dive|3", -- [1]
		},
		["Quillfang Skitterer"] = {
			"Gore|8", -- [1]
		},
		["Kaliri Matriarch"] = {
			"Screech|4", -- [1]
		},
		["Razorfang Hatchling"] = {
			"Dash|3", -- [1]
		},
		["Quillfang Ravager"] = {
			"Bite|8", -- [1]
			"Gore|8", -- [2]
		},
		["Female Kaliri Hatchling"] = {
			"Claw|8", -- [1]
		},
	},
	["Terokkar Forest"] = {
		["Dreadfang Lurker"] = {
			"Bite|8", -- [1]
		},
		["Thornfang Venomspitter"] = {
			"Bite|8", -- [1]
		},
		["Timber Worg"] = {
			"Furious Howl|4", -- [1]
		},
		["Warp Hunter"] = {
			"Warp|1", -- [1]
		},
		["Skettis Kaliri"] = {
			"Dive|3", -- [1]
		},
		["Warp Stalker"] = {
			"Warp|1", -- [1]
		},
		["Scorpid Bonecrawler"] = {
			"Claw|9", -- [1]
			"Scorpid Poison|5", -- [2]
		},
		["Lost Torranche"] = {
			"Cower|7", -- [1]
		},
		["Dreadfang Widow"] = {
			"Bite|9", -- [1]
		},
		["Blackwind Warp Chaser"] = {
			"Warp|1", -- [1]
		},

    },
}
end
