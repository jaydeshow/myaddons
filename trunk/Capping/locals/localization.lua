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
	["Enable"] = true,
	["Auto quest turnins"] = true,
	["Enable Alterac Valley automatic quest turnins"] = true,
	["Bar"] = "Timer Bar",
	["Statusbar options"] = true,
	["Font size"] = true,
	["Change statusbar font size"] = true,
	["Width"] = true,
	["Change statusbar width"] = true,
	["Height"] = true,
	["Change statusbar thickness"] = true,
	["Scale"] = true,
	["Change statusbar scale"] = true,
	["Texture"] = true,
	["Statusbar textures"] = true,
	["Other"] = true,
	["Other options"] = true,
	["Auto show map"] = true,
	["Auto show the battlefield minimap on entry"] = true,
	["Map scale"] = true,
	["Hide border"] = true,
	["Change the default scale of the battlefield minimap"] = true,
	["Port Timer"] = true,
	["Enable timers for port expiration"] = true,
	["Wait Timer"] = true,
	["Enable timers for queue wait time"] = true,
	["Show/Hide Anchor"] = true,
	["Show/Hide the bars anchor (can also left-click a statusbar)"] = true,
	["Toggle class color"] = true,
	["Enable/disable class color indicators on the scoreboard"] = true,
	["Narrow map mode"] = true,
	["Narrow the battlefield minimap, removing some empty space"] = true,
	["Test"] = true,
	["Start a test bar"] = true,
	["Reverse fill"] = true,
	["Set statusbars to fill up instead of depleting"] = true,
	["Flip growth"] = true,
	["Set objective timers to grow up and misc timers to grow down"] = true,
	["Reposition Scoreboard"] = true,
	["Move the scoreboard to the Capping anchor's CURRENT position"] = true,
	["Battlefield Minimap"] = true,
	["Options for the battlefield minimap"] = true,
	["Colors"] = true,
	["Icons"] = true,
	["Bar icons display options"] = true,
	["Spacing"] = true,
	["Request sync"] = true,
	["LEFT"] = true,
	["RIGHT"] = true,
	["HIDE"] = true,
	
	-- etc timers
	["Port: %s"] = true, -- bar text for time remaining to port into a bg
	["Queue: %s"] = true,
	["Battleground Begins"] = true, -- bar text for bg gates opening (why can't they all be the same?)
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
	["avunderattack"] = "^([%w ]+) is under attack!  If left unchecked",
	["avtaken"] = "^([%w ]+) was taken by",
	["avdestroyed"] = "^([%w ]+) was destroyed by",
	["The "] = true,
	["Snowfall Graveyard"] = true,
	["Tower"] = true,
	["Bunker"] = true,
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