CappingLocale = {
	-- battlegrounds
	["Alterac Valley"] = true,
	["Arathi Basin"] = true,
	["Warsong Gulch"] = true,
	["Arena"] = true,
	["Eye of the Storm"] = true,

	-- factions
	["Alliance"] = true,
	["Horde"] = true,

	-- options menu
	["Auto quest turnins"] = true,
	["Bar"] = "Timer Bar",
	["Width"] = true,
	["Height"] = true,
	["Texture"] = true,
	["Other"] = true,
	["Other options"] = true,
	["Auto show map"] = true,
	["Map scale"] = true,
	["Hide border"] = true,
	["Port Timer"] = true,
	["Wait Timer"] = true,
	["Show/Hide Anchor"] = true,
	["Narrow map mode"] = true,
	["Test"] = true,
	["Flip growth"] = "Flip bar stacks",
	["Reposition Scoreboard"] = true,
	["Battlefield Minimap"] = true,
	["Icons"] = true,
	["Spacing"] = true,
	["Request sync"] = true,
	["LEFT"] = true,
	["RIGHT"] = true,
	["HIDE"] = true,
	["Fill grow"] = true,
	["Fill right"] = true,
	["Font"] = true,
	["Time position"] = true,
	["Border width"] = true,
	["Send to BG"] = true,
	["Or <Ctrl-left-click> a timer"] = true,
	["Send to SAY"] = true,
	["Or <Shift-left-click> a timer"] = true,
	["Cancel timer"] = true,
	["Or <Ctrl-right-click> a timer"] = true,
	["Reposition Capture Bar"] = true,

	-- etc timers
	["Port: %s"] = true, -- bar text for time remaining to port into a bg
	["Queue: %s"] = true,
	["Battleground Begins"] = true, -- bar text for bg gates opening (why can't they all be the same?)
	["2 minutes"] = true,
	["1 minute"] = true,
	["30 seconds"] = true,
	["One minute until"] = true,
	["Thirty seconds until"] = true,
	["Fifteen seconds until"] = true,
	["%s: %s - %d:%02d remaining"] = true, -- chat message after shift left-clicking a bar

	-- AB
	["Bases: (%d+)  Resources: (%d+)/2000"] = true, -- arathi basin scoreboard
	["Farm"] = true,
	["Lumber Mill"] = true,
	["Blacksmith"] = true,
	["Gold Mine"] = true,
	["Stables"] = true,
	["Southern Farm"] = true,
	["Mine"] = true,
	["has assaulted"] = true,
	["claims the"] = true,
	["has taken the"] = true,
	["has defended the"] = true,
	["Final: 2000 - %d"] = true, -- final score text
	["wins 2000-%d"] = true, -- final score chat message

	-- WSG
	["was picked up by (.+)!"] = true,
	["was picked up by (.+)!2"] = true,
	["dropped"] = true,
	["captured the"] = true,
	["Flag respawns"] = true,
	["%s's flag carrier: %s (%s)"] = true, -- chat message

	-- AV
	 -- NPC
	["Smith Regzar"] = true,
	["Murgot Deepforge"] = true,
	["Primalist Thurloga"] = true,
	["Arch Druid Renferal"] = true,
	["Stormpike Ram Rider Commander"] = true,
	["Frostwolf Wolf Rider Commander"] = true,

	 -- patterns
	["avunderattack"] = "The (.+) is under attack!  If left unchecked",
	["avunderattack2"] = "^(.+) is under attack!  If left unchecked",
	["avtaken"] = "The (.+) was taken by",
	["avtaken2"] = "^(.+) was taken by",
	["avdestroyed"] = "The (.+) was destroyed by",
	["avdestroyed2"] = "^(.+) was destroyed by",
	["Snowfall Graveyard"] = true,
	["Tower"] = true,
	["Bunker"] = true,
	["Bulwark"] = true, -- no need in english version...
	["Upgrade to"] = true, -- the option to upgrade units in AV
	["Wicked, wicked, mortals!"] = true, -- what Ivus says after being summoned
	["Ivus begins moving"] = true,
	["WHO DARES SUMMON LOKHOLAR"] = true, -- what Lok says after being summoned
	["The Ice Lord has arrived!"] = true,
	["Lokholar begins moving"] = true,


	-- EotS
	["^(.+) has taken the flag!"] = true,
	["Bases: (%d+)  Victory Points: (%d+)/2000"] = true,
}

function CappingLocale:CreateLocaleTable(t)
	for k,v in pairs(t) do
		self[k] = (v == true and k) or v
	end
end

CappingLocale:CreateLocaleTable(CappingLocale)