Recount = LibStub("AceAddon-3.0"):NewAddon("Recount", "AceConsole-3.0","AceEvent-3.0", "AceComm-3.0", "AceTimer-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local SM = LibStub:GetLibrary("LibSharedMedia-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale( "Recount" )
  
local DataVersion	= "1.3"
local FilterSize	= 20
local RampUp		= 5
local RampDown		= 10
      
Recount.Version = tonumber(string.sub("$Revision: 75264 $", 12, -3))

local UnitLevel = UnitLevel
local UnitClass = UnitClass
local UnitIsTrivial = UnitIsTrivial
local UnitIsPlayer = UnitIsPlayer
local UnitExists = UnitExists
local UnitName = UnitName
local GetTime = GetTime
local UnitIsFriend = UnitIsFriend
local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers

  
-- Elsia: This is straight from GUIDRegistryLib-0.1 by ArrowMaster.
local bit_bor	= bit.bor
local bit_band  = bit.band
   
local COMBATLOG_OBJECT_AFFILIATION_MINE		= COMBATLOG_OBJECT_AFFILIATION_MINE		or 0x00000001
local COMBATLOG_OBJECT_AFFILIATION_PARTY	= COMBATLOG_OBJECT_AFFILIATION_PARTY	or 0x00000002
local COMBATLOG_OBJECT_AFFILIATION_RAID		= COMBATLOG_OBJECT_AFFILIATION_RAID		or 0x00000004
local COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	or 0x00000008
local COMBATLOG_OBJECT_AFFILIATION_MASK		= COMBATLOG_OBJECT_AFFILIATION_MASK		or 0x0000000F
-- Reaction
local COMBATLOG_OBJECT_REACTION_FRIENDLY	= COMBATLOG_OBJECT_REACTION_FRIENDLY	or 0x00000010
local COMBATLOG_OBJECT_REACTION_NEUTRAL		= COMBATLOG_OBJECT_REACTION_NEUTRAL		or 0x00000020
local COMBATLOG_OBJECT_REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE		or 0x00000040
local COMBATLOG_OBJECT_REACTION_MASK		= COMBATLOG_OBJECT_REACTION_MASK		or 0x000000F0
-- Ownership
local COMBATLOG_OBJECT_CONTROL_PLAYER		= COMBATLOG_OBJECT_CONTROL_PLAYER		or 0x00000100
local COMBATLOG_OBJECT_CONTROL_NPC			= COMBATLOG_OBJECT_CONTROL_NPC			or 0x00000200
local COMBATLOG_OBJECT_CONTROL_MASK			= COMBATLOG_OBJECT_CONTROL_MASK			or 0x00000300
-- Unit type
local COMBATLOG_OBJECT_TYPE_PLAYER			= COMBATLOG_OBJECT_TYPE_PLAYER			or 0x00000400
local COMBATLOG_OBJECT_TYPE_NPC				= COMBATLOG_OBJECT_TYPE_NPC				or 0x00000800
local COMBATLOG_OBJECT_TYPE_PET				= COMBATLOG_OBJECT_TYPE_PET				or 0x00001000
local COMBATLOG_OBJECT_TYPE_GUARDIAN		= COMBATLOG_OBJECT_TYPE_GUARDIAN		or 0x00002000
local COMBATLOG_OBJECT_TYPE_OBJECT			= COMBATLOG_OBJECT_TYPE_OBJECT			or 0x00004000
local COMBATLOG_OBJECT_TYPE_MASK			= COMBATLOG_OBJECT_TYPE_MASK			or 0x0000FC00

-- Special cases (non-exclusive)
local COMBATLOG_OBJECT_TARGET				= COMBATLOG_OBJECT_TARGET				or 0x00010000
local COMBATLOG_OBJECT_FOCUS				= COMBATLOG_OBJECT_FOCUS				or 0x00020000
local COMBATLOG_OBJECT_MAINTANK				= COMBATLOG_OBJECT_MAINTANK				or 0x00040000
local COMBATLOG_OBJECT_MAINASSIST			= COMBATLOG_OBJECT_MAINASSIST			or 0x00080000
local COMBATLOG_OBJECT_RAIDTARGET1			= COMBATLOG_OBJECT_RAIDTARGET1			or 0x00100000
local COMBATLOG_OBJECT_RAIDTARGET2			= COMBATLOG_OBJECT_RAIDTARGET2			or 0x00200000
local COMBATLOG_OBJECT_RAIDTARGET3			= COMBATLOG_OBJECT_RAIDTARGET3			or 0x00400000
local COMBATLOG_OBJECT_RAIDTARGET4			= COMBATLOG_OBJECT_RAIDTARGET4			or 0x00800000
local COMBATLOG_OBJECT_RAIDTARGET5			= COMBATLOG_OBJECT_RAIDTARGET5			or 0x01000000
local COMBATLOG_OBJECT_RAIDTARGET6			= COMBATLOG_OBJECT_RAIDTARGET6			or 0x02000000
local COMBATLOG_OBJECT_RAIDTARGET7			= COMBATLOG_OBJECT_RAIDTARGET7			or 0x04000000
local COMBATLOG_OBJECT_RAIDTARGET8			= COMBATLOG_OBJECT_RAIDTARGET8			or 0x08000000
local COMBATLOG_OBJECT_NONE					= COMBATLOG_OBJECT_NONE					or 0x80000000
local COMBATLOG_OBJECT_SPECIAL_MASK			= COMBATLOG_OBJECT_SPECIAL_MASK			or 0xFFFF0000

local LIB_FILTER_RAIDTARGET	= bit_bor(
	COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET2, COMBATLOG_OBJECT_RAIDTARGET3, COMBATLOG_OBJECT_RAIDTARGET4,
	COMBATLOG_OBJECT_RAIDTARGET5, COMBATLOG_OBJECT_RAIDTARGET6, COMBATLOG_OBJECT_RAIDTARGET7, COMBATLOG_OBJECT_RAIDTARGET8
)
local LIB_FILTER_ME = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER
)
local LIB_FILTER_MY_PET = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PET
						)
local LIB_FILTER_PARTY = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_PARTY)
local LIB_FILTER_RAID  = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_RAID)
local LIB_FILTER_GROUP = bit_bor(LIB_FILTER_PARTY, LIB_FILTER_RAID)

--[[local DefaultConfig={
	char={
		combatants={
			['*'] = {
				Init=false,
				Owner=false,
				AbilityType={},
				TimeLast={},
				TimeData={
					Damage={{},{}},
					DamageTaken={{},{}},
					Healing={{},{}},
					Overhealing={{},{}},
					HealingTaken={{},{}},
					Threat={{},{}}
				},

				TimeWindows={
					Damage={['*']=0},
					DamageTaken={['*']=0},
					Healing={['*']=0},
					HealingTaken={['*']=0},
					Overhealing={['*']=0},
					Threat={['*']=0},
				},
				Fights={
					['*']={
						Damage=0,
						FDamage=0,
						DamageTaken=0,
						Healing=0,
						HealingTaken=0,
						Overhealing=0,
						DeathCount=0,
						DOT_Time=0,
						HOT_Time=0,
						Interrupts=0,
						Dispels=0,
						Dispelled=0,
						ActiveTime=0,
						TimeHeal=0,
						TimeDamage=0,
						CCBreak=0,
						Threat=0,
						ThreatNonZero=0,
						ManaGain=0,
						EnergyGain=0,
						RageGain=0,
						Ressed=0,

						--Ability Data
						Attacks={},
						FAttacks={},
						Heals={},
						OverHeals={},
						DOTs={},
						HOTs={},
						InterruptData={},
						CCBroken={},

						--Interaction Data
						DamagedWho={}, --Who did I damage?
						FDamagedWho={}, --Who did I damage?
						WhoDamaged={}, --Who damaged me?
						HealedWho={}, --Who did I heal?
						WhoHealed={}, --Who healed me?
						DispelledWho={}, --Who did I dispel?
						WhoDispelled={}, --Who dispelled me?
						PartialResist={},	--What spells partially resisted
						PartialBlock={}, -- What attacks partially blocked
						PartialAbsorb={}, -- What damage partially absorbed
						TimeSpent={},	--Where did I spend my time
						TimeDamaging={},	--Where did I spend my time attacking
						TimeHealing={},	--Where did I spend my time healing
						ManaGained={},	--Where did I gain mana
						EnergyGained={}, --Where did I gain energy
						RageGained={}, --Where did I gain rage
						ManaGainedFrom={},	--Where did I gain mana
						EnergyGainedFrom={}, --Where did I gain energy
						RageGainedFrom={}, --Where did I gain rage
						RessedWho={},

						--Elemental Tracking
						ElementDone={},
						ElementDoneResist={},
						ElementDoneBlock={},
						ElementDoneAbsorb={},
						ElementTaken={},
						ElementTakenResist={},
						ElementTakenBlock={},
						ElementTakenAbsorb={},

						ElementHitsDone={},
						ElementHitsTaken={},
					}
				},





				TimeNeedZero={},

				LastEvents={},
				LastEventHealth={},
				LastEventHealthNum={},
				LastEventTimes={},
				LastEventType={},
				LastEventIncoming={},
				LastEventNum={},

				NextEventNum=1,

				LastThreat=0,
				LastAbility=0,
				LastActive=0,

				LastFightIn=0,
				UnitLockout=0,

				HealBuffHas=nil,
				HealBuffName=nil,

				DeathLogs={},

				FightsSaved=0,

				Sync={
					MsgNum=0,
					LastSent=0,
					LastChanged=0,

					Damage=0,
					DamageTaken=0,
					FDamage=0,
					Healing=0,
					HealingTaken=0,
					Overhealing=0,

					ActiveTime=0,
					
					OverhealCorrection=0,
					HealingCorrection=0,
				},
			}
		},
		GUID=nil,
		PetGUID=nil,
		FoughtWho={},
		FightNum=0,
		CombatTimes={},
		version=0,
	}
}
]]

local Default_Profile={
	profile={
		Colors={
			["Window"]={
				["Title"] = { r = 1, g = 0, b = 0, a = 1},
				["Background"]= { r = 24/255, g = 24/255, b = 24/255, a = 1},
				["Title Text"] = {r = 1, g = 1, b = 1, a = 1},
			},
			["Bar"]={
				["Bar Text"] = {r = 1, g = 1, b = 1},
				["Total Bar"] = { r = 0.75, g = 0.75, b = 0.75},
			},
			["Other Windows"]={
				["Title"] = { r = 1, g = 0, b = 0, a = 1},
				["Background"]= { r = 24/255, g = 24/255, b = 24/255, a = 1},
				["Title Text"] = {r = 1, g = 1, b = 1, a = 1},
			},
			["Detail Window"]={
			},
			["Class"]={
				["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45, a=1 },
				["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79, a=1 },
				["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0, a=1 },
				["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73, a=1 },
				["MAGE"] = { r = 0.41, g = 0.8, b = 0.94, a=1 },
				["ROGUE"] = { r = 1.0, g = 0.96, b = 0.41, a=1 },
				["DRUID"] = { r = 1.0, g = 0.49, b = 0.04, a=1 },
				["SHAMAN"] = { r = 0.14, g = 0.35, b = 1.0, a=1 },
				["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43, a=1 },
				["PET"] = { r = 0.09, g = 0.61, b = 0.55, a=1 },
--				["GUARDIAN"] = { r = 0.61, g = 0.09, b = 0.09 },
				["MOB"] = { r = 0.58, g = 0.24, b = 0.63, a=1 },
				["UNKNOWN"] = { r = 0.1, g = 0.1, b = 0.1, a=1 },
				["HOSTILE"] = { r = 0.7, g = 0.1, b = 0.1, a=1 },
				["UNGROUPED"] = { r = 0.63, g = 0.58, b = 0.24, a=1 },
			},
			["Realtime"]={
			},
			["Names"]={
			}
		},
		MaxFights=5,
		--Window={
			--ShowCurAndLast=false,
		--},
		MessagesTracked=50,
		GlobalStatusBar=false,
		AutoDelete=true,
		AutoDeleteCombatants=true, -- Elsia: set this to true to reduce data accumulation
		AutoDeleteTime=180,
		AutoDeleteNewInstance=true, -- Elsia: set this to true
		ConfirmDeleteInstance=true, -- Elsia: Get annoying popup box?
		LastInstanceName="", -- Elsia: Last instance is empty by default
		DeleteNewInstanceOnly=true,
		DeleteJoinRaid = true,
		ConfirmDeleteRaid = true,
		DeleteJoinGroup = true,
		ConfirmDeleteGroup = true,
		BarTexture="BantoBar",
		MergePets=true,
		RecordCombatOnly=true,
		SegmentBosses=false,
		MainWindowVis=true,
		MainWindowMode=1,
		Locked=false,
		EnableSync=true, -- Elsia: Default enable sync is set to true again now, thanks to lazy syncing.
		GlobalDataCollect=true, -- Elsia: Global toggle for data collection
		HideCollect=false, -- Elsia: Hide Recount window when not collecting data
		Font="ABF",
		Scaling=1,
		MainWindow={
			Buttons={
				ReportButton=true,
				FileButton=true,
				ConfigButton=true,
				ResetButton=true,
				LeftButton=true,
				RightButton=true,
			},
			RowHeight=14,
			RowSpacing=1,
			AutoHide=false,
			ShowScrollbar=true, -- Elsia: Allow toggle of scrollbar
			HideTotalBar=true,
			BarText=
			{
				RankNum =true,
				PerSec = true,
				Percent = true,
				NumFormat = 1,
			},
			Position={
				x = 0,
				y = 0,
				w = 140,
				h = 200,
			},
		},
		Filters={
			Show={
				Self=true,
				Grouped=true,
				Ungrouped=true, -- Elsia: Default show leaving party members
				Hostile=false,
				Pet=false,
				Trivial=false,
				Nontrivial=false,
				Boss=false,
				Unknown=false,
			},
			Data={
				Self=true,
				Grouped=true,
				Ungrouped=false, -- Elsia: Removed to reduce default data accumulation
				Hostile=false,
				Pet=true,
				Trivial=false,
				Nontrivial=false,
				Boss=true,
				Unknown=true,
			},
			TimeData={
				Self=true,
				Grouped=false, -- Elsia: Removed Default timed on for groups
				Ungrouped=false,
				Hostile=false,
				Pet=false,
				Trivial=false,
				Nontrivial=false,
				Boss=false, -- Elsia:Removed Default timed on for bosses
				Unknown=false,
			},
			TrackDeaths={
				Self=true,
				Grouped=true,
				Ungrouped=false,
				Hostile=false,
				Pet=true,
				Trivial=false,
				Nontrivial=false,
				Boss=true,
				Unknown=false,
			},
		},
		ZoneFilters={
			none=true, -- Elsia: These fields are named after what IsInInstance() returns for types.
			pvp=true,
			arena=true,
			party=true,
			raid=true,
		},
		FilterDeathType={
			DAMAGE=true,
			HEAL=true,
			MISC=true,
		},
		FilterDeathIncoming={
			[true]=true,
			[false]=false
		},
		RealtimeWindows={}
	}
} 

SM:Register("statusbar", "Aluminium",			[[Interface\Addons\Recount\Textures\statusbar\Aluminium]])
SM:Register("statusbar", "Armory",				[[Interface\Addons\Recount\Textures\statusbar\Armory]])
SM:Register("statusbar", "BantoBar",			[[Interface\Addons\Recount\Textures\statusbar\BantoBar]])
SM:Register("statusbar", "Flat",				[[Interface\Addons\Recount\Textures\statusbar\Flat]])
SM:Register("statusbar", "Minimalist",			[[Interface\Addons\Recount\Textures\statusbar\Minimalist]])
SM:Register("statusbar", "Otravi",				[[Interface\Addons\Recount\Textures\statusbar\Otravi]])
SM:Register("statusbar", "Empty",               [[Interface\Addons\Recount\Textures\statusbar\Empty]])

BINDING_HEADER_RECOUNT = "Recount"
BINDING_NAME_RECOUNT_PREVIOUSPAGE = L["Show previous main page"]
BINDING_NAME_RECOUNT_NEXTPAGE = L["Show next main page"]
BINDING_NAME_RECOUNT_DAMAGE = L["Display"].." "..L["Damage Done"]
BINDING_NAME_RECOUNT_DPS = L["Display"].." "..L["DPS"]
BINDING_NAME_RECOUNT_FRIENDLYFIRE = L["Display"].." "..L["Friendly Fire"]
BINDING_NAME_RECOUNT_DAMAGETAKEN = L["Display"].." "..L["Damage Taken"]
BINDING_NAME_RECOUNT_HEALING = L["Display"].." "..L["Healing Done"]
BINDING_NAME_RECOUNT_HEALINGTAKEN = L["Display"].." "..L["Healing Taken"]
BINDING_NAME_RECOUNT_OVERHEALING = L["Display"].." "..L["Overhealing Done"]
BINDING_NAME_RECOUNT_DEATHS = L["Display"].." "..L["Deaths"]
BINDING_NAME_RECOUNT_DOTS = L["Display"].." "..L["DOT Uptime"]
BINDING_NAME_RECOUNT_HOTS = L["Display"].." "..L["HOT Uptime"]
BINDING_NAME_RECOUNT_DISPELS = L["Display"].." "..L["Dispels"]
BINDING_NAME_RECOUNT_DISPELLED = L["Display"].." "..L["Dispelled"]
BINDING_NAME_RECOUNT_INTERRUPTS = L["Display"].." "..L["Interrupts"]
BINDING_NAME_RECOUNT_CCBREAKER = L["Display"].." "..L["CC Breakers"]
BINDING_NAME_RECOUNT_ACTIVITY = L["Display"].." "..L["Activity"]
BINDING_NAME_RECOUNT_MANA = L["Display"].." "..L["Mana Gained"]
BINDING_NAME_RECOUNT_ENERGY = L["Display"].." "..L["Energy Gained"]
BINDING_NAME_RECOUNT_RAGE = L["Display"].." "..L["Rage Gained"]
BINDING_NAME_RECOUNT_REPORT_MAIN = L["Report the Main Window Data"]
BINDING_NAME_RECOUNT_REPORT_DETAILS = L["Report the Detail Window Data"]
BINDING_NAME_RECOUNT_RESET_DATA = L["Resets the data"]
BINDING_NAME_RECOUNT_SHOW_MAIN = L["Shows the main window"]
BINDING_NAME_RECOUNT_HIDE_MAIN = L["Hides the main window"]
BINDING_NAME_RECOUNT_TOGGLE_MAIN = L["Toggles the main window"]

local optFrame

local function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

Recount.consoleOptions = {
	name = L["Recount"],
	type = 'group',
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = L["Config Access"].."\n",
			cmdHidden = true
		},
		windesc = {
			order = 10,
			type = "description",
			name = L["Window Options"].."\n",
			cmdHidden = true
		},
		syncdesc = {
			order = 20,
			type = "description",
			name = L["Sync Options"].."\n",
			cmdHidden = true
		},
		datadesc = {
			order = 30,
			type = "description",
			name = L["Data Options"].."\n",
			cmdHidden = true
		},
		[L["gui"]] = {
			order = 2,
			name = L["GUI"],
			desc = L["Open Ace3 Config GUI"],
			type = 'execute',
			func = function()
				InterfaceOptionsFrame:Hide()
				AceConfigDialog:SetDefaultSize("Recount", 500, 550)
				AceConfigDialog:Open("Recount") end
		},
		[L["sync"]] = {
			order = 21,
			name  = L["Sync"],
			desc = L["Toggles sending synchronization messages"],
			type = 'toggle',
			get = function(info) return Recount.db.profile.EnableSync end,
			set = function(info,v)
				if v then -- Elsia: Make sure it's on before enabling, an event might intervene
					Recount:ConfigComm(); 
					Recount:Print("Lazy Sync enabled")
				end
					
				Recount.db.profile.EnableSync=v
				
				if not v then -- Elsia: Make sure it's off before disabling, an event might intervene
					Recount:FreeComm();
					Recount:Print("Lazy Sync disabled")
				end
			end,
		},
		[L["reset"]] = {
			order = 31,
			name = L["Reset"],
			desc = L["Resets the data"],
			type = 'execute',
			func = function() Recount:ResetData() end
		},
		[L["verChk"]] = {
			order = 22,
			name = L["VerChk"],
			desc = L["Displays the versions of players in the raid"],
			type = 'execute',
			func = function() Recount:ReportVersions() end
		},
		[L["show"]] = {
			order = 12,
			name = L["Show"],
			desc = L["Shows the main window"],
			type = 'execute',
			func = function() Recount.MainWindow:Show();Recount:RefreshMainWindow() end,
			dialogHidden = true
		},
		hide = {
			order = 13,
			name = L["Hide"],
			desc = L["Hides the main window"],
			type = 'execute',
			func = function() Recount.MainWindow:Hide() end,
			dialogHidden = true
		},
		toggle = {
			order = 11,
			name = L["Toggle"],
			desc = L["Toggles the main window"],
			type = 'execute',
			func = function() if Recount.MainWindow:IsShown() then Recount.MainWindow:Hide() else Recount.MainWindow:Show();Recount:RefreshMainWindow() end end
		},
		config = {
			order = 3,
			name = L["Config"],
			desc = L["Shows the config window"],
			type = 'execute',
			func = function() Recount:ShowConfig() end
		},
		resetpos = {
			order = 14,
			name = L["ResetPos"],
			desc = L["Resets the positions of the detail, graph, and main windows"],
			type = 'execute',
			func = function() Recount:ResetPositions() end
		},
		lock = {
			order = 15,
			name  = L["Lock"],
			desc = L["Toggles windows being locked"],
			type = 'toggle',
			get = function(info) return Recount.db.profile.Locked end,
			set = function(info,v)
				Recount.db.profile.Locked=v
				Recount:LockWindows(v)
			end,
		},
	}
}

Recount.consoleOptions2 = deepcopy(Recount.consoleOptions)	
	
Recount.consoleOptions2.args.report = {
			order = 32,
			name = L["Report"],
			type = 'group',
			desc = L["Allows the data of a window to be reported"],
			args = {
				detail = {
					name = L["Detail"],
					desc = L["Report the Detail Window Data"],
					type = 'execute',
					func = function()  Recount:ShowReport("Detail",Recount.ReportDetail) end
				},
				main ={
					name = L["Main"],
					desc = L["Report the Main Window Data"],
					type = 'execute',
					func = function()  Recount:ShowReport("Main",Recount.ReportData) end
				}
			}
		}
		
Recount.consoleOptions2.args.realtime = {
			name = L["Realtime"],
			type = 'group', 
			desc = L["Specialized Realtime Graphs"],
			args = {
				netfps = {
					name = "Network and FPS",
					type = 'group', inline = true,
					args = {
						fps = {
							name = L["FPS"],
							desc = L["Starts a realtime window tracking your FPS"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("FPS","FPS","") end
						},
						lag = {
							name = L["Lag"],
							desc = L["Starts a realtime window tracking your latency"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("Latency","LAG","") end
						},
						uptraffic = {
							name = L["Upstream Traffic"],
							desc = L["Starts a realtime window tracking your upstream traffic"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("Upstream Traffic","UP_TRAFFIC","") end
						},
						downtraffic = {
							name = L["Downstream Traffic"],
							desc = L["Starts a realtime window tracking your downstream traffic"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("Downstream Traffic","DOWN_TRAFFIC","") end
						},
						bandwidth = {
							name = L["Available Bandwidth"],
							desc = L["Starts a realtime window tracking amount of available AceComm bandwidth left"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("Bandwidth Available","AVAILABLE_BANDWIDTH","") end
						},
					},
				},
				raid = {
					name = L["Raid"],
					desc = L["Tracks your entire raid"],
					type = 'group', inline = true,

					args = {
						dps = {
							name = L["DPS"],
							desc = L["Tracks Raid Damage Per Second"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("!RAID","DAMAGE","Raid DPS") end
						},
						dtps = {
							name = L["DTPS"],
							desc = L["Tracks Raid Damage Taken Per Second"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("!RAID","DAMAGETAKEN","Raid DTPS") end
						},
						hps = {
							name = L["HPS"],
							desc = L["Tracks Raid Healing Per Second"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("!RAID","HEALING","Raid HPS") end
						},
						htps = {
							name = L["HTPS"],
							desc = L["Tracks Raid Healing Taken Per Second"],
							type = 'execute',
							func = function() Recount:CreateRealtimeWindow("!RAID","HEALINGTAKEN","Raid HTPS") end
						},
					}
				}
			}
}

function Recount:ReportVersions() -- Elsia: Functionified so GUI can use it too
	Recount:Print(L["Displaying Versions"])
	if Recount.VerTable then -- Elsia: Fixed nil error on non sync situation.
		for k,v in pairs(Recount.VerTable) do
			Recount:Print(k.." "..v)
		end
	end
end

function Recount:ShowCombatantList()
	for k,v in pairs(Recount.db2.combatants) do
		Recount:Print(k.." "..(v.Name or "nil").." "..(v.type or "nil").." "..(v.level or "nil").." "..(v.enClass or "nil").." "..(v.class or "nil").." "..(v.GUID or "nil"))
	end
	Recount:ShowNrCombatants()
end

function Recount:NrCombatants()
	local v = Recount.db2.combatants
	local size = 0
	for _,_ in pairs(v) do size = size + 1 end
	return size
end

function Recount:ShowNrCombatants()
	Recount:Print(Recount:NrCombatants())
end

function Recount:ResetData()
	if Recount.GraphWindow then
		Recount.GraphWindow:Hide()
		Recount.GraphWindow.LineGraph:LockXMin(false)
		Recount.GraphWindow.LineGraph:LockXMax(false)
		Recount.GraphWindow.TimeRangeSet=false
	end

	if Recount.DetailWindow then
		Recount.DetailWindow:Hide()
	end

	for k,v in pairs(Recount.db2.combatants) do
		Recount:DeleteGuardianOwnerByGUID(Recount.db2.combatants[k])
		Recount.db2.combatants[k]=nil
	end

	for k,v in pairs(Recount.db2.CombatTimes) do
		Recount.db2.CombatTimes[k]=nil
	end

	if Recount.MainWindow and Recount.MainWindow.DispTableSorted then
		Recount.MainWindow.DispTableSorted=Recount:GetTable()
		Recount.MainWindow.DispTableLookup=Recount:GetTable()
	end

	if Recount.MainWindow then
		Recount:RefreshMainWindow()
	end

	if #Recount.db2.FoughtWho > 0 then
		Recount:SendReset() -- Elsia: Sync the reset if we actually fought something
	end
 
	Recount.db2.FoughtWho={}

	Recount:ResetTableCache()
	
	if Recount.db.profile.CurDataSet ~= "CurrentFightData" and Recount.db.profile.CurDataSet ~= "LastFightData" then
		Recount.db.profile.CurDataSet = "OverallData"
	end
	
	Recount.db2.FightNum=0

	for k,v in pairs(Recount.db2.combatants) do
		v.LastFightIn=0
	end
	
	--Perform a garbage collect if they are resetting the data
	collectgarbage("collect")
end

function Recount:FindUnit(name)
	local unit --, UnitObj
	--Handle this as two passes
	
	unit=Recount:GetUnitIDFromName(name) -- We shouldn't need to find roster units.

	if unit then
		return unit
	end

	unit=Recount:FindTargetedUnit(name)

	return unit
end

local Epsilon=0.000000000000000001

function Recount:ResetFightData(data)
	--Init Data tracked
	data = data or {}
	data.Damage=0
	data.FDamage=0
	data.DamageTaken=0
	data.Healing=0
	data.HealingTaken=0
	data.Overhealing=0
	data.DeathCount=0
	data.DOT_Time=0
	data.HOT_Time=0
	data.Interrupts=0
	data.Dispels=0
	data.Dispelled=0
	data.ActiveTime=0
	data.TimeHeal=0
	data.TimeDamage=0
	data.CCBreak=0
	if RecountThreat then RecountThreat:ResetThreat() end
	data.ManaGain=0
	data.EnergyGain=0
	data.RageGain=0
	data.Ressed=0

	for k, v in pairs(data) do
		if type(v)=="table" then
			for k2 in pairs(v) do
				if type(v[k2])=="table" then
					Recount:FreeTable(v[k2])
				end
				v[k2]=nil
			end
		else
			data[k]=0
		end

	end
end

function Recount:InitFightData(data)
	--Init Data tracked
	data.Damage=0
	data.FDamage=0
	data.DamageTaken=0
	data.Healing=0
	data.HealingTaken=0
	data.Overhealing=0
	data.DeathCount=0
	data.DOT_Time=0
	data.HOT_Time=0
	data.Interrupts=0
	data.Dispels=0
	data.Dispelled=0
	data.ActiveTime=0
	data.TimeHeal=0
	data.TimeDamage=0
	data.CCBreak=0
	if RecountThreat then RecountThreat:ResetThreat() end
	data.ManaGain=0
	data.EnergyGain=0
	data.RageGain=0
	data.Ressed=0

	--Ability Data
	data.Attacks=Recount:GetTable()
	data.FAttacks=Recount:GetTable()
	data.Heals=Recount:GetTable()
	data.OverHeals=Recount:GetTable()
	data.DOTs=Recount:GetTable()
	data.HOTs=Recount:GetTable()
	data.InterruptData=Recount:GetTable()
	data.CCBroken=Recount:GetTable()

	--Interaction Data
	data.DamagedWho=Recount:GetTable() --Who did I damage?
	data.FDamagedWho=Recount:GetTable() --Who did I damage?
	data.WhoDamaged=Recount:GetTable() --Who damaged me?
	data.HealedWho=Recount:GetTable() --Who did I heal?
	data.WhoHealed=Recount:GetTable() --Who healed me?
	data.DispelledWho=Recount:GetTable() --Who did I dispel?
	data.WhoDispelled=Recount:GetTable() --Who dispelled me?
	data.TimeSpent=Recount:GetTable()	--Where did I spend my time
	data.TimeDamaging=Recount:GetTable()	--Where did I spend my time attacking
	data.TimeHealing=Recount:GetTable()	--Where did I spend my time healing
	data.ManaGained=Recount:GetTable()	--Where did I gain mana
	data.EnergyGained=Recount:GetTable() --Where did I gain energy
	data.RageGained=Recount:GetTable() --Where did I gain rage
	data.ManaGainedFrom=Recount:GetTable()	--Where did I gain mana
	data.EnergyGainedFrom=Recount:GetTable() --Where did I gain energy
	data.RageGainedFrom=Recount:GetTable() --Where did I gain rage
	data.PartialResist=Recount:GetTable()	--What spells partially resisted
	data.PartialBlock=Recount:GetTable() -- What attacks partially blocked
	data.PartialAbsorb=Recount:GetTable() -- What damage partially absorbed
	data.RessedWho=Recount:GetTable()

	--Elemental Tracking
	data.ElementDone=Recount:GetTable()
	data.ElementDoneResist=Recount:GetTable()
	data.ElementDoneBlock=Recount:GetTable()
	data.ElementDoneAbsorb=Recount:GetTable()
	data.ElementTaken=Recount:GetTable()
	data.ElementTakenResist=Recount:GetTable()
	data.ElementTakenBlock=Recount:GetTable()
	data.ElementTakenAbsorb=Recount:GetTable()

	data.ElementHitsDone=Recount:GetTable()
	data.ElementHitsTaken=Recount:GetTable()
end

function Recount:CreateOwnerFlags(nameFlags)
	local ownerFlags=bit_band(nameFlags,COMBATLOG_OBJECT_AFFILIATION_MASK+COMBATLOG_OBJECT_REACTION_MASK+COMBATLOG_OBJECT_CONTROL_MASK)
	if bit_band(nameFlags,COMBATLOG_OBJECT_CONTROL_PLAYER)~=0 then
		ownerFlags = ownerFlags + COMBATLOG_OBJECT_TYPE_PLAYER
	else -- NPC
		ownerFlags = ownerFlags + COMBATLOG_OBJECT_TYPE_NPC
	end	
	
	return ownerFlags
end

function Recount:DetermineType(name,nameFlags)
	local combatant=Recount.db2.combatants[name]

	if nameFlags then
		if bit_band(nameFlags,COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_TYPE_PLAYER)==COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_TYPE_PLAYER and bit_band(nameFlags,COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)==0 then
			combatant.type="Self"
			return
		elseif bit_band(nameFlags,COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 and bit_band(nameFlags,COMBATLOG_OBJECT_AFFILIATION_MINE)~=0 then
			combatant.type="Pet"
			combatant.enClass="PET"
			combatant.Owner=Recount.PlayerName
			--Recount:SetOwner(combatant,name,combatant.Owner, Recount.PlayerGUID, Recount:CreateOwnerFlags(nameFlags))
			return
		elseif bit_band(nameFlags,COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 and bit_band(nameFlags,COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
			--Recount:Print("Pet1! "..name)
			combatant.type="Pet"
			combatant.enClass="PET"
			Recount:PartyPetOwnerFromGUID(combatant, name, nameGUID, nameFlags)
			return
		elseif bit_band(nameFlags,COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 and bit_band(COMBATLOG_OBJECT_TYPE_PLAYER)~=0 then
			combatant.type="Grouped"
			return
		elseif bit_band(nameFlags,COMBATLOG_OBJECT_TYPE_NPC+COMBATLOG_OBJECT_CONTROL_NPC)==COMBATLOG_OBJECT_TYPE_NPC+COMBATLOG_OBJECT_CONTROL_NPC then
			if combatant.isTrivial then
				combatant.type="Trivial"
			elseif combatant.level==-1 then
				combatant.type="Boss"
			else
				combatant.type="Nontrivial"
			end
			return
		end
	end
	
	if name==Recount.PlayerName then
		combatant.type="Self"
		return
	end
	
	if combatant.checkLater then
		combatant.type="Unknown"
		combatant.enClass="UNKNOWN"
		return
	end

	if combatant.isPlayer then
		if combatant.inGroup then
			combatant.type="Grouped"
		elseif combatant.isFriend then
			combatant.type="Ungrouped"
		else
			combatant.type="Hostile"
		end
	else
		if combatant.Owner then
			combatant.type="Pet"
			combatant.enClass="PET"
		else
			if combatant.isTrivial then
				combatant.type="Trivial"
			elseif combatant.level==-1 then
				combatant.type="Boss"
			else
				--Recount:Print(name.."nt2")
				--Recount:Print(debugstack(2, 3, 2))
				combatant.type="Nontrivial"
			end
		end
	end
end

local FlagsToUnitID =
{
 [COMBATLOG_OBJECT_TARGET]				= "target",
 [COMBATLOG_OBJECT_FOCUS]				= "focus",
 [COMBATLOG_OBJECT_MAINTANK]			= "maintank",
 [COMBATLOG_OBJECT_MAINASSIST]			= "mainassist",
 [COMBATLOG_OBJECT_RAIDTARGET1]			= "raid1target",
 [COMBATLOG_OBJECT_RAIDTARGET2]			= "raid2target",
 [COMBATLOG_OBJECT_RAIDTARGET3]			= "raid3target",
 [COMBATLOG_OBJECT_RAIDTARGET4]			= "raid4target",
 [COMBATLOG_OBJECT_RAIDTARGET5]			= "raid5target",
 [COMBATLOG_OBJECT_RAIDTARGET6]			= "raid6target",
 [COMBATLOG_OBJECT_RAIDTARGET7]			= "raid7target",
 [COMBATLOG_OBJECT_RAIDTARGET8]			= "raid8target",
}

function Recount:FindPetUnitFromFlags(unitFlags, unitGUID)
	assert(bit_band(unitFlags,COMBATLOG_OBJECT_TYPE_PET))
	if bit_band(unitFlags,COMBATLOG_OBJECT_TYPE_PET)==0 then -- Elsia: Has to be a pet. Guardians don't yet have unitids
		return
	end
	
	-- Check for my pet
	if bit_band(unitFlags,COMBATLOG_OBJECT_TYPE_PET)~=0 and bit_band(COMBATLOG_OBJECT_AFFILIATION_MINE)~=0 then
		return "pet" -- Elsia: My pet is easy
	end

	local vGUID
	
	-- Check for raid and party pets.
	if bit_band(unitFlags,COMBATLOG_OBJECT_TYPE_PET)~=0 and bit_band(unitFlags,COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID+COMBATLOG_OBJECT_AFFILIATION_MINE)~=0 then
		if bit_band(unitFlags,COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
			local Num=GetNumRaidMembers() 
			if Num>0 then
				for i=1,Num do
					if vGUID == UnitGUID("raidpet"..i) then
						return "raidpet"..i
					end
				end
			end
		elseif bit_band(unitFlags,COMBATLOG_OBJECT_AFFILIATION_PARTY)~=0 then
			local Num=GetNumPartyMembers()
			if Num>0 then
				for i=1,Num do
					if vGUID == UnitGUID("partypet"..i) then
						return "partypet"..i
					end
				end
			end
		end
	end
	
	assert(false) -- This should never happen
	
	return nil
end

function Recount:FindUnitFromFlags(unitname,unitFlags)
-- Elisa: This check excludes pets.

	if bit_band(unitFlags,COMBATLOG_OBJECT_TYPE_PLAYER)~=0 and bit_band(unitFlags,COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID+COMBATLOG_OBJECT_AFFILIATION_MINE)~=0 then
		return unitname -- Elsia: Covers all non-pet players in raid
	end

	-- This returns all target-inferable units from flags.
	for k,v in pairs(FlagsToUnitID) do
		if bit_band(k,unitFlags)~=0 then
			local vname, vrealm = UnitName(v)
			if vname and vname == unitname then
				return v
			end
		end
	end

	return nil
end

function Recount:CombatantIsMob(combatant, unit)
	combatant.enClass="MOB"
--	combatant.unit=unit
	combatant.level=UnitLevel(unit)
	combatant.isTrivial=UnitIsTrivial(unit)
	if combatant.isTrivial then
		combatant.type="Trivial"
	elseif combatant.level==-1 then
		combatant.type="Boss"
	else
		combatant.type="Nontrivial"
	end
end

Recount.ElementalMobID = {
	[15430] = "3BF8", -- Earth elemental totem and it's greater elemental
	[15439] = "3C4E" -- Fire elemental totem
}

local gopts = {}

function Recount:AddGreaterElemental(opts)
	
	local nameGUID, petName, nameFlags, ownerGUID, owner, ownerFlags = unpack(opts)

	--Recount:Print(nameGUID)
	
	local newguid1 = tonumber(nameGUID:sub(-1-5,-1),16)+1
	local mobid = tonumber(nameGUID:sub(3+6,3+9),16)
	local newguid2 = tonumber(nameGUID:sub(3,3+5),16)
	local nameGUID2 = string.format("0x%06X",newguid2)..Recount.ElementalMobID[mobid]..string.format("%06X",newguid1)
	--Recount:Print(mobid.." "..nameGUID.." "..nameGUID2)
	
	RecountTempTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	RecountTempTooltip:ClearLines()
	RecountTempTooltip:SetHyperlink("unit:" .. nameGUID2)	

	if RecountTempTooltip:NumLines() > 0 then
		petName = getglobal("RecountTempTooltipTextLeft1"):GetText()
		nameGUID = nameGUID2
		--Recount:Print("Adding Guardian: "..petName.." "..nameGUID)
		Recount:AddPetCombatant(nameGUID, petName, nameFlags, ownerGUID, owner, ownerFlags)
	--else
	--	Recount:Print("Eek: ".. RecountTempTooltip:NumLines())
	end
end

function Recount:ScanGUIDTooltip(nameGUID)
	local newguid1 = tonumber(nameGUID:sub(-1-5,-1),16)
	local mobid = tonumber(nameGUID:sub(3+6,3+9),16)
	local newguid2 = tonumber(nameGUID:sub(3,3+5),16)
	local nameGUID2 = string.format("0x%06X",newguid2)..string.format("%04X",mobid)..string.format("%06X",newguid1)
	Recount:Print(mobid.." "..nameGUID.." "..nameGUID2)

	RecountTempTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	RecountTempTooltip:ClearLines()
	RecountTempTooltip:SetHyperlink("unit:" .. nameGUID2)	
	
	local tooltipName = "RecountTempTooltip"

	local textLeft, textRight, ttextLeft, ttextRight;

	for idx = 1, RecountTempTooltip:NumLines() do
		ttextLeft = getglobal(tooltipName.."TextLeft"..idx)
		if ttextLeft then
			textLeft = ttextLeft:GetText()
			if textLeft then
				Recount:Print("left"..idx..": "..textLeft)
			end
		else
			textLeft = nil
		end
			
		ttextRight = getglobal(tooltipName.."TextRight"..idx)
		if ttextRight then
			textRight = ttextRight:GetText()
			if textRight then
				Recount:Print("right"..idx..": "..textRight)
			end
		else
			textRight = nil
		end
	end
end

function Recount:SetGuardianGUID(name, nameGUID)
	Recount.GuardianGUIDs = Recount.GuardianGUIDs or {}
	Recount.GuardianReverseGUIDs = Recount.GuardianReverseGUIDs or {}
	tinsert(Recount.GuardianGUIDs, nameGUID, name)
	tinsert(Recount.GuardianReverseGUIDs, name, nameGUID)
end

function Recount:GetGuardianOwnerByGUID(nameGUID)
	return Recount.GuardianOwnerGUIDs and Recount.GuardianOwnerGUIDs[nameGUID]
end

function Recount:TrackGuardianOwnerByGUID(owner, name, nameGUID)

	owner.GuardianReverseGUIDs = owner.GuardianReverseGUIDs or {}
	Recount.GuardianOwnerGUIDs = Recount.GuardianOwnerGUIDs or {}

	local oldGUID = owner.GuardianReverseGUIDs and owner.GuardianReverseGUIDs[name]
	
	if not oldGUID then
		owner.GuardianReverseGUIDs[name]=nameGUID
		Recount.GuardianOwnerGUIDs[nameGUID]=owner.Name
	else
		owner.GuardianReverseGUIDs[name]=nameGUID
		Recount.GuardianOwnerGUIDs[oldGUID]=nil
		Recount.GuardianOwnerGUIDs[nameGUID]=owner.Name
	end
end

function Recount:DeleteGuardianOwnerByGUID(owner)
	if owner.GuardianReverseGUIDs then

		for k,v in pairs(owner.GuardianReverseGUIDs) do
			if Recount.GuardianOwnerGUIDs then
				Recount.GuardianOwnerGUIDs[v] = nil
			end
		end
	end
end
	
function Recount:AddPetCombatant(nameGUID, petName, nameFlags, ownerGUID, owner, ownerFlags)
	local name=petName.." <"..owner..">"
	local combatant=Recount.db2.combatants[name] or {}
	
	if bit_band(ownerFlags, COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID+COMBATLOG_OBJECT_REACTION_FRIENDLY)==0 then
		--return -- Elsia: We only keep affiliated or friendly pets. These flags can be horribly wrong unfortunately
	end
	
	if petName:match("<(.-)>") or owner:match("<(.-)>") then
		--Recount:DPrint(petName.." : "..owner.." !Double owner detected! Please report the trace below")
		--Recount:DPrint(debugstack(2, 3, 2))
	end
		
	--local elementschool = petName:match("(.*) Elemental Totem")
	--Recount:Print(petName.." "..(elementschool or "nil").." "..nameGUID:sub(3,-1))
	if bit_band(nameFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) then
		local mobid = tonumber(nameGUID:sub(3+6,3+9),16)
		if Recount.ElementalMobID[mobid] then -- This really summoned a greater fire elemental totem, which is what we really care about.

			--Recount:Print("Elem!")
			gopts = {nameGUID, petName, nameFlags, ownerGUID, owner, ownerFlags }
			Recount:ScheduleTimer("AddGreaterElemental", 0.2, gopts)
		--else
			--Recount:Print(mobid)
		end
		if Recount.db2.combatants[owner] then -- We have a valid stored owner.
			Recount:TrackGuardianOwnerByGUID(Recount.db2.combatants[owner], petName, nameGUID)
		else
			Recount:SetOwner(combatant,name,owner,ownerGUID,ownerFlags)
			if Recount.db2.combatants[owner] then -- We have a valid stored owner.
				Recount:TrackGuardianOwnerByGUID(Recount.db2.combatants[owner], petName, nameGUID)
			end
		end
	end

	combatant.GUID=nameGUID
	combatant.LastFlags=nameFlags
	
	if combatant.Name then -- Already have such a pet!
		--Recount:DPrint("Pet1: "..name.." "..owner.." "..petName)
		Recount:CheckRetention(name)
		return
	end
	
	
	combatant.Name=petName
	Recount:SetOwner(combatant,name,owner,ownerGUID,ownerFlags)
	combatant.type="Pet"
	combatant.enClass="PET"
	-- Elsia: We inherit flags from owner, as currently 2.4 ptr the pet flags are not useful (typically 0xa28 for outsider,neutral, npc)
	combatant.inGroup = bit_band(ownerFlags, COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0
	combatant.isPlayer=false
	combatant.isFriend=bit_band(ownerFlags,COMBATLOG_OBJECT_REACTION_FRIENDLY) ~= 0
	combatant.unit = Recount:FindPetUnitFromFlags(nameFlags, nameGUID)
	if combatant.unit then
		combatant.level = UnitLevel(combatant.unit)
	else
		combatant.level=Recount.db2.combatants[owner].level -- Elsia: For guardians and other unidentifiable unitid pets, assume the owner level (heuristic)
	end

--[[	if not combatant then
		if not Recount.db.profile.Filters.Data[combatant.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
			combatant = nil -- Elsia: We don't keep initial combatant types which we don't collect. Should reduce data growth.
			return
		end
	end]]

	--combatant.Init=true

	--Recount:DPrint("Pet2: "..name.." "..owner.." "..petName)
	
	combatant.LastFightIn=Recount.db2.FightNum
	combatant.UnitLockout=Recount.CurTime
	
	Recount:CheckRetention(name)
end

function Recount:AddCombatant(name,owner,nameGUID,nameFlags,ownerGUID)
	local combatant = {}
	
	if not nameFlags then
		Recount:Print("Improper: ".. name.." "..(nameFlags or "nil"))

		return -- Elsia: Improper!
	end

	combatant.GUID=nameGUID
	
	-- Handle Attributes that can be extracted from flags.
	combatant.inGroup = bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0
	combatant.isPlayer=bit_band(nameFlags, COMBATLOG_OBJECT_TYPE_PLAYER)==COMBATLOG_OBJECT_TYPE_PLAYER
	combatant.isFriend=bit_band(nameFlags,COMBATLOG_OBJECT_REACTION_FRIENDLY) ~= 0
	
	-- Handle identified pets
	if owner then
		combatant.Name=string.match(name,"(.*) <"..owner..">")
		if not combatant.Name then -- Elsia: not sure when this can happen
			combatant.Name = name
			name = name.." <"..owner..">"
		end
		if combatant.Name:match("<(.-)>") or owner:match("<(.-)>") then
			--Recount:DPrint(combatant.Name.." : "..owner.." !Double owner detected! Please report the trace below")
			--Recount:DPrint(debugstack(2, 3, 2))
		end
	
		Recount:SetOwner(combatant,name,owner,ownerGUID, Recount:CreateOwnerFlags(nameFlags))
		combatant.type="Pet"
		combatant.enClass="PET"
		combatant.level=1
--		combatant.unit = Recount:FindPetUnitFromFlags(nameFlags, nameGUID)
--		if combatant.unit then
--			combatant.level = UnitLevel(combatant.unit)
--		else
--			combatant.level=Recount.db2.combatants[owner].level -- Elsia: For guardians and other unidentifiable unitid pets, assume the owner level (heuristic)
--		end
	else
	-- Handle non-pet units
		combatant.Name=name
		combatant.Owner=false -- Not a pet
		
		-- Handle Friendly combatants
		if combatant.isFriend and (combatant.inGroup or combatant.isPlayer)  then
			-- Can find Unit from this
			--unit = Recount:FindUnitFromFlags(name,nameFlags)
			
--			if unit and combatant.isPlayer then -- Player Units
			if combatant.isPlayer then -- Player Units
				if Recount.PlayerName == name then
					combatant.type = "Self"
					combatant.class, combatant.enClass=UnitClass("player")
					combatant.level = UnitLevel("player")
				-- Handle Friendly grouped combatants
				elseif combatant.inGroup then
					local unit = Recount:FindUnitFromFlags(name,nameFlags)
					combatant.type = "Grouped"
					combatant.class, combatant.enClass=UnitClass(unit)
					combatant.level = UnitLevel(unit)
				-- Handle Friendly ungrouped combatants
				else
					combatant.type = "Ungrouped"
					local unit = Recount:FindTargetedUnit(name)
					if unit then
						combatant.class, combatant.enClass=UnitClass(unit)
						combatant.level = UnitLevel(unit)
					else
						combatant.enClass = "UNGROUPED" -- Check for target uid here
						combatant.level = 1
					end
				end
			else
				--Recount:Print("Got non-player grouped entity: "..name) -- Elsia: This proves to be pets!
				--Recount:Print(debugstack(2, 3, 2))
			end
				--combatant.unit=unit
				--combatant.level=UnitLevel(unit)
		-- Handle hostile combatants
		elseif combatant.isPlayer then
			combatant.type = "Hostile"
			local unit = Recount:FindTargetedUnit(name)
			if unit then
				combatant.class, combatant.enClass=UnitClass(unit)
				combatant.level = UnitLevel(unit)
			else
				combatant.enClass = "HOSTILE" -- Check for target uid here
				combatant.level = 1
			end
		elseif bit_band(nameFlags,COMBATLOG_OBJECT_NONE) ~= COMBATLOG_OBJECT_NONE then -- Mob units that were flag targets
			combatant.enClass="MOB"
--	combatant.unit=unit
			local unit = Recount:FindTargetedUnit(name)
			combatant.level=unit and UnitLevel(unit) or 1
			combatant.isTrivial=unit and UnitIsTrivial(unit) or nil
			if combatant.isTrivial then
				combatant.type="Trivial"
			elseif combatant.level==-1 then
				combatant.type="Boss"
			else
				combatant.type="Nontrivial"
			end
			combatant.enClass="MOB"
			--Recount:CombatantIsMob(combatant,unit)
		else
			combatant.type="Unknown"
			combatant.enClass="UNKNOWN"
		end
	end

--[[		else
				unit = Recount:FindTargetedUnit(name)
				if unit then -- Mob units that were otherwise raid targets
					if UnitIsPlayer(unit) then
						combatant.type = "Ungrouped"
						combatant.class, combatant.enClass=UnitClass(unit)
						combatant.unit=unit
						combatant.level=UnitLevel(unit)
					else
						Recount:CombatantIsMob(combatant,unit)
					end
				else -- Unidentifyable mobs
					Recount:DetermineType(name,nameFlags)
					--combatant.type="Unknown"
					combatant.checkLater=true
					combatant.level=0
				end
			end
		else
			unit = Recount:FindTargetedUnit(name)
			if unit then -- Mob units that were otherwise raid targets
				if UnitIsPlayer(unit) then
					combatant.type = "Ungrouped"
					combatant.class, combatant.enClass=UnitClass(unit)
					combatant.unit=unit
					combatant.level=UnitLevel(unit)
				else
					Recount:CombatantIsMob(combatant,unit)
				end
			end
			Recount:DetermineType(name,nameFlags)
	
			if combatant.type=="Pet" then
				combatant.enClass="PET"
			elseif not combatant.isPlayer then
				combatant.enClass="MOB"
			else
	
			-- Can't find Unit from this
				combatant.type="Unknown"
				combatant.enCLASS="UNKNOWN"
				combatant.isFriend=false
				combatant.checkLater=true
				combatant.level=0
			end
		end	
	end

	if combatant.type == "Pet" then
		combatant.enClass = "PET"
	elseif not combatant.enClass then
		combatant.enClass="UNKNOWN"
	end
	]]
--[[	if not combatant then
		if not Recount.db.profile.Filters.Data[combatant.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
			--Recount:Print("purge")
--			combatant = nil -- Elsia: We don't keep initial combatant types which we don't collect. Should reduce data growth.
			return
--		else
			--Recount:Print("keep")
		end
	end]]

	--combatant.Init=true

	combatant.LastFightIn=Recount.db2.FightNum
	combatant.UnitLockout=Recount.CurTime
	Recount.db2.combatants[name]=combatant
	Recount:InitCombatant(name)
	
	--return Recount.db2.combatants[name]
end

function Recount:TestRetention(name)
	local combatant = Recount.db2.combatants[name]
	if combatant then
		if combatant.type=="Pet" and combatant.Owner and not Recount.db.profile.Filters.Data[Recount.db2.combatants[combatant.Owner].type] then
			--Recount:DPrint("Tested negative on pet: "..name.." "..combatant.Owner.." "..Recount.db2.combatants[combatant.Owner].type)
			return nil
		elseif not Recount.db.profile.Filters.Data[combatant.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
			return nil
		else
			return true
		end
	end
	return nil
end

function Recount:CheckRetention(name)
	
	local combatant = Recount.db2.combatants[name]

	if combatant then
		if combatant.type=="Pet" and combatant.Owner and Recount.db2.combatants[combatant.Owner] and Recount.db2.combatants[combatant.Owner].type and not Recount.db.profile.Filters.Data[Recount.db2.combatants[combatant.Owner].type] then
			--Recount:DPrint("Not keeping pet: "..name.." "..combatant.Owner.." "..Recount.db2.combatants[combatant.Owner].type)
			Recount:DeleteCombatant(combatant.Owner) -- Elsia: We won't keep the pet if we don't keep the owner.
			return nil
		elseif not Recount.db.profile.Filters.Data[combatant.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
			--Recount:Print("purge")
--			combatant = nil -- Elsia: We don't keep initial combatant types which we don't collect. Should reduce data growth.
			--return
			--Recount:DPrint("Dumping: "..name.." "..(combatant.type or "nil"))
			Recount:DeleteCombatant(name)
			--Recount.db2.combatants[name] = nil -- Don't retain
			return nil
		else
			--Recount:Print("keep: "..name)
			return true
--		else
		end
	end
	return nil
end

function Recount:InitCombatant(name)
	local combatant = Recount.db2.combatants[name]
	
	combatant.Fights = {}
end

function Recount:PartyPetOwnerFromGUID(who,petName,petGUID, petFlags)
	local ownerName, ownerGUID = Recount:FindOwnerPetFromGUID(petName,petGUID)
	--Recount:SetOwner(who,petName,ownerName, ownerGUID, Recount:CreateOwnerFlags(petFlags))
end

function Recount:SetOwner(who,petName,owner,ownerGUID,ownerFlags)

	who.Owner=owner

	if who.Owner then
		if not Recount.db2.combatants[who.Owner] then
			Recount:AddCombatant(who.Owner, nil,ownerGUID,ownerFlags)
		end
		if not Recount.db2.combatants[who.Owner].Pet then 
			Recount.db2.combatants[who.Owner].Pet = {}
		end
		
		for i,k in ipairs(Recount.db2.combatants[who.Owner].Pet) do -- Prevent multi-pet registration
			if k == petName then return end
		end
		table.insert(Recount.db2.combatants[who.Owner].Pet,petName)
	end
end

Recount.LastGroupCheck=0
function Recount:GroupCheck()
	local gettime = GetTime()

	if Recount.LastGroupCheck>gettime and Recount.LastGroupCheck-gettime <= 0.25 then
		return
	end
	Recount.LastGroupCheck=gettime+0.25

	for k,v in pairs(Recount.db2.combatants) do
		local Unit = Recount:GetUnitIDFromName(k)

		--Recount:Print(k.." "..(v.type or "nil").." "..(v.enClass or "nil"))
		--Must be in our group
		if Unit then
			v.unit=Unit
			v.isPlayer=UnitIsPlayer(Unit)
			v.inGroup=true
		else
			v.inGroup=false
			Recount:DeleteVersion(k)
		end

		Recount:DetermineType(k)

		if v.type=="Pet" then
			v.enClass="PET"
		elseif not v.isPlayer then
			v.enClass="MOB"
		elseif v.unit then
			if UnitExists(v.unit) and UnitName(v.unit)==k then
				v.Class, v.enClass=UnitClass(v.unit)
			else
				if not v.enClass then
					v.enClass="UNKNOWN"
				end
				v.unit=nil
			end
		end
	end

	Recount.Pets:ScanRoster()
end

local FilterWeights={}
local FilterMiddle=0

function Recount:CreateFilterWeights()
	local sum=0
	local val,widthUp,widthDown
	local DownAt=FilterSize-RampDown
	widthUp=1/RampUp
	widthDown=1/RampDown

	for i=1,FilterSize do
		if i<=RampUp then
			val=i*widthUp
			FilterWeights[#FilterWeights+1]=val
			sum=sum+val
		elseif i<=DownAt then
			FilterWeights[#FilterWeights+1]=1
			sum=sum+1
		else
			val=(FilterSize-i+1)*widthDown
			FilterWeights[#FilterWeights+1]=val
			sum=sum+val
		end
	end
	for i=1,FilterSize do
		FilterWeights[i]=FilterWeights[i]/sum
		FilterMiddle=FilterMiddle+i*FilterWeights[i]
	end

	FilterMiddle=math.floor(FilterMiddle)-1
end

local LinComp=0.3
function Recount:CheckIfAlmostLinear(TimeData, NewTime, NewVal)
	if #TimeData[1]<=1 or (NewTime-TimeData[1][#TimeData[1]])>10 then
		return false
	end

	local MidTime=TimeData[1][#TimeData[1]]
	local MidValue=TimeData[2][#TimeData[2]]

	local Width=NewTime-TimeData[1][#TimeData[1]-1]
	local Lerp=(MidTime-TimeData[1][#TimeData[1]-1])/Width
	local LinValue=Lerp*NewVal+(1-Lerp)*TimeData[2][#TimeData[2]-1]

	if Lerp>0.5 then
		Lerp=1-Lerp
	end

	local Weight=(MidValue-LinValue)/(Lerp*Width)

	if Weight<0 then
		Weight=-Weight
	end

	if Weight<LinComp then
		return true
	end
	return false
end

function Recount:TimeTick()
	if not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end
	
	local Time=time()
	local TimeCheck2=GetTime()-FilterSize-1
	local TimeCheck=Time-FilterSize-1
	local TimeFormatted

	--First check if combat status changed
	Recount:CheckCombat(Time)
	Recount.CurTime=Time
	Recount.UnitLockout=Time-5


	--Need to increment where data gets put and erase the old ones
	local PrevTimeStep=Recount.TimeStep
	Recount.TimeStep=Recount.TimeStep+1
	if Recount.TimeStep>FilterSize then
		Recount.TimeStep=1
	end

	if RecountThreat then RecountThreat:FindCurrentThreatTarget() end

	local gotdeleted
	
	for name,v in pairs(Recount.db2.combatants) do

--[[		if name == "Totemic Call" or name == "Fel Energy" or name == "Evocation" or name == "Furor" or name == "Bloodrage" or name =="Master of Elements" then
			Recount:Print(name .. " " .. ( owner or "nil").." ".. (nameGUID or "nil").." "..(nameFlags or "nil") .." "..(ownerGUID or "nil"))
			Recount:Print(debugstack(2, 3, 2))
		end]]
		
		if Recount.db.profile.GlobalDataCollect == true and Recount.CurrentDataCollect and Recount.db.profile.Filters.Data[v.type] and Recount.db.profile.Filters.TimeData[v.type] and v.TimeLast and v.TimeLast["OVERALL"] and v.TimeLast["OVERALL"]>=TimeCheck then -- Elsia: Added global collection switch
			--First threat data
			if RecountThreat then RecountThreat:UpdateCurrentThreat(v) end

			for k, v2 in pairs(v.TimeWindows) do
				local Temp
				local NewEntry=0

				if v.TimeLast and v.TimeLast[k] and v.TimeLast[k]>=TimeCheck then
					--Something is strange here but this works
					for k,v3 in ipairs(v2) do
						Temp = (FilterSize-k)+Recount.TimeStep
						if Temp>FilterSize then
							NewEntry=NewEntry+v3*FilterWeights[Temp-FilterSize]
						else
							NewEntry=NewEntry+v3*FilterWeights[Temp]
						end
					end
					--Need to set where we will be putting new data to 0
					v2[Recount.TimeStep]=0
				end

				v.TimeData = v.TimeData or {}
				v.TimeData[k] = v.TimeData[k] or {{},{}}
				local TimeData=v.TimeData[k]
				if NewEntry~=0 then
					--do we need a leading zero?
					if not v.TimeNeedZero or not v.TimeNeedZero[k] then
						TimeData[1][#TimeData[1]+1]=Time-1-FilterMiddle
						TimeData[2][#TimeData[2]+1]=0

						v.TimeNeedZero = v.TimeNeedZero or {}
						v.TimeNeedZero[k]=true
					end

					if not Recount:CheckIfAlmostLinear(TimeData, Time-FilterMiddle, NewEntry) then
						TimeData[1][#TimeData[1]+1]=Time-FilterMiddle
						TimeData[2][#TimeData[2]+1]=NewEntry
					else
						--If almost linear write over the old value
						TimeData[1][#TimeData[1] ]=Time-FilterMiddle
						TimeData[2][#TimeData[2] ]=NewEntry
					end
				elseif v.TimeNeedZero and v.TimeNeedZero[k] then --Check if we need a trailing zero
					TimeData[1][#TimeData[1]+1]=Time-FilterMiddle
					TimeData[2][#TimeData[2]+1]=0
					v.TimeNeedZero = v.TimeNeedZero or {}
					v.TimeNeedZero[k]=false
				end
			end
		end

		--Lets see if this unit needs to be updated
		if Recount.db.profile.GlobalDataCollect and Recount.CurrentDataCollect and v.checkLater and v.LastFightIn>(Recount.db2.FightNum-4) and v.UnitLockout<Recount.UnitLockout then
			v.UnitLockout=Recount.CurTime
			local Unit=Recount:FindUnit(name)
			if Unit then
				v.isFriend=UnitIsFriend("player",Unit)
				v.class, v.enClass=UnitClass(Unit)
				v.checkLater=false
				v.level=UnitLevel(Unit)
				v.isPlayer=UnitIsPlayer(Unit)
				v.isTrivial=UnitIsTrivial(Unit)
				v.unit=Unit

				--Must be in our group
				if UnitExists(name) then -- Elsia: This is much faster than roster scanning
					v.unit=name
					v.inGroup=true
				else
					v.inGroup=false
				end

				--Recount:Print("gc: "..name)
				Recount:DetermineType(name)

				if v.type=="Pet" then
					v.enClass="PET"
				elseif not v.isPlayer then
					v.enClass="MOB"
				end
			end
		end
		
		local idler = v.checkLater or v.type == "Unknown" or v.enClass == "UNKNOWN" or (not Recount.db.profile.Filters.Data[v.type] and not Recount.db.profile.Filters.Show[v.type])
		
		v.LastActive = v.LastActive or Time
		if idler and Time-v.LastActive > 30 then
			Recount:DeleteCombatant(name)
			gotdeleted = true
--		elseif idler then
--			Recount:Print(name.."t: "..(Time-v.LastActive))
		end
	
		if name == Recount.Player and not v.inGroup then
			Recount:GroupCheck()
			if not v.inGroup then
				Recount:DPrint("Yikes, can't get player into group status!")
			end
		end
	end
	
	if gotdeleted then
		Recount:SetMainWindowMode(Recount.db.profile.MainWindowMode)
		Recount:FullRefreshMainWindow()
	end

	
	
	if Recount.db.profile.AutoDelete and math.fmod(Time,10)==0 then
		Recount:DeleteOldTimeData(Time)
	end
end

function Recount:PutInCombat()
	Recount.InCombat=true
	Recount.InCombatT=Recount.CurTime
	Recount.InCombatF=date("%H:%M:%S")
	Recount.FightingWho=""
	Recount.FightingLevel=0

	if Recount.db.profile.MainWindow.AutoHide then
		Recount.MainWindow:Hide()
	end

	if --[[Recount.db.profile.Window.ShowCurAndLast and ]] Recount.db.profile.CurDataSet=="LastFightData" then
		Recount.db.profile.CurDataSet="CurrentFightData"
		
	end

	--If current mode is not overall data we need to reset disp table
	if Recount.db.profile.CurDataSet~="OverallData" then -- Elsia: Fix for double entry in CurAndLast mode
		Recount.MainWindow.DispTableSorted=Recount:GetTable()
		Recount.MainWindow.DispTableLookup=Recount:GetTable()
	end
end


function Recount:CheckCombat(Time)

	if Recount:CheckPartyCombatWithPets() then
		Recount:CheckVisible()
	elseif Recount.InCombat then
		Recount:LeaveCombat(Time)
	end
		
--[[
	local InCombat = Recount:CheckPartyCombatWithPets()
	
	if InCombat then Recount:CheckVisible() end -- Elsia: Check combat log visibility while in range
	
	if not InCombat and Recount.InCombat then --We were in combat but no longer
		Recount:LeaveCombat(Time)
--	else
--		Recount:Print("hmm")
	end
	]]
	
end

--Moved into a seperate function
function Recount:LeaveCombat(Time)

	if Recount.db.profile.MainWindow.AutoHide then
		Recount.RefreshMainWindow()
		Recount.MainWindow:Show()
	end

	--Did we actually fight someone?
	Recount.InCombat=false
	if (Recount.FightingWho=="") then
		return
	end

	-- Elsia: Only sync for actual fights
	if Recount.db.profile.GlobalDataCollect and Recount.CurrentDataCollect and Recount.db.profile.EnableSync  then -- Elsia: Only sync if collecting
		Recount:BroadcastLazySync()
	end

	if (Time-Recount.InCombatT)>3 then
		Recount.db2.CombatTimes[#Recount.db2.CombatTimes+1]={Recount.InCombatT,Time,Recount.InCombatF,date("%H:%M:%S"),Recount.FightingWho}

		--Save current data as the last fight
		Recount.Fights:MoveFights()

		if --[[Recount.db.profile.Window.ShowCurAndLast and]] Recount.db.profile.CurDataSet=="CurrentFightData" then
			Recount.db.profile.CurDataSet="LastFightData"
		end

		--If current mode is not overall data we need to reset disp table
		if Recount.db.profile.CurDataSet~="OverallData" then
			Recount.MainWindow.DispTableSorted=Recount:GetTable()
			Recount.MainWindow.DispTableLookup=Recount:GetTable()
		end

		Recount.db2.FightNum=Recount.db2.FightNum+1
	else
		Recount.Fights:CopyCurrentFights()

--		if --[[Recount.db.profile.Window.ShowCurAndLast and]] Recount.db.profile.CurDataSet=="CurrentFightData" then
--			Recount.db.profile.CurDataSet="LastFightData"
--		end
	end
	
end

function Recount:DeleteOldTimeData(Time)
	local DeleteTime=Time-60*Recount.db.profile.AutoDeleteTime

	for name,v in pairs(Recount.db2.combatants) do
		if v.TimeData then
			for _,Check in pairs(v.TimeData) do
				while Check[1][1] and Check[1][1]<DeleteTime do
					table.remove(Check[1],1)
					table.remove(Check[2],1)
				end
			end
		end
	end

	local Fights=Recount.db2.CombatTimes

	while Fights[1] and Fights[1][2]<DeleteTime do
		table.remove(Fights,1)
	end
end

function Recount:FixLastTime()
	local Time=GetTime()
	for name,v in pairs(Recount.db2.combatants) do
		v.LastAbility=Time
	end
end

function Recount:DelayedResizeWindows()
	Recount:ResizeMainWindow()
	--DelayedResizeWindows=nil
end

function Recount:HandleProfileChanges()
	if not Recount.MainWindow then
		return
	end

	Recount:SetBarTextures(Recount.db.profile.BarTexture)
	Recount:RestoreMainWindowPosition(Recount.db.profile.MainWindow.Position.x,Recount.db.profile.MainWindow.Position.y,Recount.db.profile.MainWindow.Position.w,Recount.db.profile.MainWindow.Position.h)
	Recount:ResizeMainWindow()
	Recount:FullRefreshMainWindow()
	Recount:SetupMainWindowButtons()

	if Recount.db.profile.GraphWindow then
		Recount.GraphWindow:ClearAllPoints()
		Recount.GraphWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.profile.GraphWindowX,Recount.db.profile.GraphWindowY)
	end

	if Recount.db.profile.DetailWindow then
		Recount.DetailWindow:ClearAllPoints()
		Recount.DetailWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.profile.DetailWindowX,Recount.db.profile.DetailWindowY)
	end

	Recount.profilechange = true
	Recount:CloseAllRealtimeWindows()
	
	if Recount.db.profile.RealtimeWindows then
		local Windows=Recount.db.profile.RealtimeWindows
		for k,v in pairs(Windows) do
			if v[8] and v[8] == true then -- Elsia: Make sure to respect closed windows as closed on startup
				Recount:CreateRealtimeWindowSized(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			end
		end
	end
	Recount.profilechange = nil

	Recount:ShowConfig()
end

function Recount:InitCombatData()
	Recount.db2.combatants = Recount.db2.combatants or {}
	Recount.db2.CombatTimes = Recount.db2.CombatTimes or {}
	Recount.db2.FoughtWho = Recount.db2.FoughtWho or {}
	
end

function Recount:OnInitialize()
	local acedb = LibStub:GetLibrary("AceDB-3.0")
	Recount.db = acedb:New("RecountDB", Default_Profile)
--	Recount.db2 = acedb:New("RecountPerCharDB", DefaultConfig)
	RecountPerCharDB = RecountPerCharDB or {}
	Recount.db2 = RecountPerCharDB
	Recount.db2.char = nil -- Elsia: Dump old db data hard.
	Recount.db2.global = nil
	Recount:InitCombatData()
	self.db.RegisterCallback( self, "OnNewProfile", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileReset", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileChanged", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileCopied", "HandleProfileChanges" )

	Recount.consoleOptions2.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(Recount.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Recount", Recount.consoleOptions2, "recount")
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Recount Report",Recount.consoleOptions2.args.report)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Recount Realtime",Recount.consoleOptions2.args.realtime)
 	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Recount Blizz", Recount.consoleOptions)

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Recount Profile", Recount.consoleOptions2.args.profile)
	
	AceConfigDialog:AddToBlizOptions("Recount Blizz", "Recount")
	AceConfigDialog:AddToBlizOptions("Recount Profile", "Profile", "Recount")
	AceConfigDialog:AddToBlizOptions("Recount Report", "Report", "Recount")
	AceConfigDialog:AddToBlizOptions("Recount Realtime", "Realtime", "Recount")
	
	if Recount.db2["version"]~=DataVersion then
		Recount:ResetData()

		Recount.db2.version=DataVersion
	end

	RecountTempTooltip = CreateFrame("GameTooltip", "RecountTempTooltip", nil, "GameTooltipTemplate")
	RecountTempTooltip:SetOwner(UIParent, "ANCHOR_NONE")

--[[	self.vars.Llines, self.vars.Rlines = {}, {}
	for i=1,30 do
		self.vars.Llines[i], self.vars.Rlines[i] = tt:CreateFontString(), tt:CreateFontString()
		self.vars.Llines[i]:SetFontObject(GameFontNormal)
		self.vars.Rlines[i]:SetFontObject(GameFontNormal)
		tt:AddFontStrings(self.vars.Llines[i], self.vars.Rlines[i])
	end]]
	
	
	Recount.TimeStep=1
	Recount.InCombat=false
	Recount.db.profile.CurDataSet=Recount.db.profile.CurDataSet or "OverallData"
	Recount.FightingLevel=0
	Recount.CurTime=time()

	Recount.CurrentDataCollect = true
	
	Recount:CreateMainWindow()

	Recount:CreateDetailWindow()
	Recount:CreateGraphWindow()
	Recount:CreateFilterWeights()
	Recount:InitOrder()

	Recount:SetupMainWindow()
	Recount:ScheduleTimer("DelayedResizeWindows",0.1)

	SM.RegisterCallback(Recount, "LibSharedMedia_Registered", "UpdateBarTextures")
	SM.RegisterCallback(Recount, "LibSharedMedia_SetGlobal", "UpdateBarTextures")
	if Recount.db.profile.BarTexture then
		Recount:SetBarTextures(Recount.db.profile.BarTexture)
	end

	if Recount.db.profile.GraphWindowX then
		Recount.GraphWindow:ClearAllPoints()
		Recount.GraphWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.profile.GraphWindowX,Recount.db.profile.GraphWindowY)
	end

	if Recount.db.profile.DetailWindowX then
		Recount.DetailWindow:ClearAllPoints()
		Recount.DetailWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.profile.DetailWindowX,Recount.db.profile.DetailWindowY)
	end

	if Recount.db.profile.RealtimeWindows then
		local Windows=Recount.db.profile.RealtimeWindows
		for k,v in pairs(Windows) do
			if v[8] and v[8] == true then -- Elsia: Make sure to respect closed windows as closed on startup
				Recount:CreateRealtimeWindowSized(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			end
		end
	end
	
	if RecountThreat then RecountThreat:IsThreatActive() end

	Recount.PlayerName=UnitName("player")
	Recount.PlayerGUID=nil
	Recount.PlayerLevel=UnitLevel("player")

	Recount.GuardiansGUIDs={} -- No need to db, guardians are not persistent GUIDs
	Recount.LatestGuardian=0

	if RecountThreat then Recount.ThreatTargetName="GLOBAL" end

	Recount.EventNum={}
	Recount.EventNum["DAMAGE"]={}
	Recount.EventNum["HEALING"]={}

--	Recount.db2.FightNum=0

--[[	for k,v in pairs(Recount.db2.combatants) do
		v.LastFightIn=0
	end]]
	
	if Recount.db.profile.EnableSync then
		Recount:ConfigComm()
	end
	
	Recount:FixLastTime()
	--Recount:ScaleWindows(Recount.db.profile.Scaling,true)
	Recount:ScaleWindows(Recount.db.profile.Scaling) -- Elsia: Bug: Even for first time we need in place code for scaling.

	Recount:LockWindows(Recount.db.profile.Locked)
end

function Recount:OnEnable(first)

	Recount.TimeTick() -- Elsia: Prevent that time data is not initialized when an event comes in before the first tick.
	
	if RecountThreat then RecountThreat:IsThreatActive() end
	Recount:ScheduleTimer("GroupCheck",1)

	Recount:ScheduleRepeatingTimer("TimeTick",1)

	--Recount:RegisterEvent("Threat_Activate") -- Elsia: Threat-1.0 deactivated until Threat-2.0 is ready.
	--Recount:RegisterEvent("Threat_Deactivate")

	Recount:RegisterEvent("UNIT_PET")
	Recount:RegisterEvent("PLAYER_PET_CHANGED")

	Recount:RegisterEvent("ZONE_CHANGED_NEW_AREA","DetectInstanceChange") -- Elsia: This is needed for zone change deletion and collection

	Recount:DetectInstanceChange() -- Elsia: We need to do this regardless for Zone filtering.

	if Recount.db.profile.DeleteJoinRaid or Recount.db.profile.DeleteJoinGroup then
		Recount:ScheduleTimer("InitPartyBasedDeletion", 5) -- Elsia: Wait 5 seconds before enabling auto-delete to prevent startup popups.
	end
	
	--Parser Events
	Recount:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED","CombatLogEvent")
	
	Recount.Pets:ScanRoster()

	Recount.HasEnabled=true
end

function Recount:OnDisable()
	if not Recount.HasEnabled then
		return
	end
	Recount.HasEnabled=false
	Parser:UnregisterAllEvents("Recount")
end

function Recount:Threat_Activate()
	Recount.ThreatActive=true
end

function Recount:Threat_Deactivate()
	Recount.ThreatActive=false
end

local Tables={}
function Recount:FreeTable(t)
	if type(t)~="table" then
		return
	end

	for k in pairs(t) do
		t[k]=nil
	end

	for _,v in pairs(Tables) do
		if v==t then
			return
		end
	end

	tinsert(Tables,t)
end

function Recount:FreeTableRecurse(t)
	--Check the table first before recursing
	for _,v in pairs(Tables) do
		if v==t then
			return
		end
	end

	for k in pairs(t) do
		if type(t[k])=="table" then
			Recount:FreeTableRecurse(t[k])
		end
		t[k]=nil
	end

	tinsert(Tables,t)
end

function Recount:FreeTableRecurseLimit(t,depth)
	--Check the table first before recursing
	if depth<0 then
		return
	end

	for k in pairs(t) do
		if type(t[k])=="table" then
			Recount:FreeTableRecurseLimit(t[k],depth-1)
		end
		t[k]=nil
	end

	tinsert(Tables,t)
end

function Recount:GetTable()
	local t
	if #Tables>0 then
		t=Tables[1]
		tremove(Tables,1)
		if #t>0 then
			Recount:Print("WARNING! For some reason there is "..#t.." entries left. There is probably a table in use that shouldn't have been freed")
		end
		return t
	else
		return {}
	end
end

function Recount:HowManyTables(str)
	if str==nil then
		str=""
	else
		str=str.." "
	end
	Recount:Print(str.."Free Tables: "..#Tables)
end

function Recount:ResetTableCache()
	Tables=Recount:GetTable()
end

function Recount:ResetPositions()
	Recount:ResetPositionAllWindows()
end

local TestPie
local Amount=0
function Recount:TestPie()
	TestPie:ResetPie()
	TestPie:AddPie(Amount,{0.0,1.0,0.0})
	TestPie:CompletePie({0.2,0.2,1.0})

	Amount=Amount+1
	if Amount>=100 then
		Amount=1
	end
end

local function TestPieChart()
	local Graph = LibStub:GetLibrary("LibGraph-2.0")
	local g=Graph:CreateGraphPieChart("TestPieChart",UIParent,"LEFT","LEFT",0,0,150,150)
	TestPie=g
	g:AddPie(35,{1.0,0.0,0.0})
	g:AddPie(21,{0.0,1.0,0.0})
	g:CompletePie({0.2,0.2,1.0})
	Recount:ScheduleRepeatingTimer("PieTest",Recount.TestPie,0)
end