Recount = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0","AceDB-2.0","AceEvent-2.0","AceComm-2.0","Parser-3.0")

local Roster = AceLibrary("Roster-2.1")
local Parser = ParserLib:GetInstance("1.1")
local threat = AceLibrary("Threat-1.0")
local SM = LibStub:GetLibrary("LibSharedMedia-3.0")
--local recountfu = recountfu
local L = AceLibrary("AceLocale-2.2"):new("Recount")

local DataVersion	= "1.1" 
local FilterSize	= 20
local RampUp		= 5
local RampDown		= 10
 
Recount.Version="$Revision: 63855 $"

Recount:RegisterDB("RecountDB","RecountPerCharDB")

SM:Register("statusbar", "Aluminium",			[[Interface\Addons\Recount\Textures\statusbar\Aluminium]])
SM:Register("statusbar", "Armory",				[[Interface\Addons\Recount\Textures\statusbar\Armory]])
SM:Register("statusbar", "BantoBar",			[[Interface\Addons\Recount\Textures\statusbar\BantoBar]])
SM:Register("statusbar", "Flat",				[[Interface\Addons\Recount\Textures\statusbar\Flat]])
SM:Register("statusbar", "Minimalist",			[[Interface\Addons\Recount\Textures\statusbar\Minimalist]])
SM:Register("statusbar", "Otravi",				[[Interface\Addons\Recount\Textures\statusbar\Otravi]])
SM:Register("statusbar", "Empty",               [[Interface\Addons\Recount\Textures\statusbar\Empty]])

-- Elsia: enUS removed from here
-- Elsia: deDE removed from here


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
BINDING_NAME_RECOUNT_THREAT = L["Display"].." "..L["Threat"]
BINDING_NAME_RECOUNT_MANA = L["Display"].." "..L["Mana Gained"]
BINDING_NAME_RECOUNT_ENERGY = L["Display"].." "..L["Energy Gained"]
BINDING_NAME_RECOUNT_RAGE = L["Display"].." "..L["Rage Gained"]
BINDING_NAME_RECOUNT_REPORT_MAIN = L["Report the Main Window Data"]
BINDING_NAME_RECOUNT_REPORT_DETAILS = L["Report the Detail Window Data"]
BINDING_NAME_RECOUNT_RESET_DATA = L["Resets the data"]

Recount.consoleOptions = {
	type = 'group',
	args = {
		sync = {
			name  = L["Sync"],
			desc = L["Toggles sending synchronization messages"],
			type = 'toggle',
			get = function() return Recount.db.char.EnableSync end,
			set = function(v)
				if v == true then -- Elsia: Make sure it's on before enabling, an event might intervene
					Recount:ConfigComm(); 
				end
					
				Recount.db.char.EnableSync=v
				
				if v == false then -- Elsia: Make sure it's off before disabling, an event might intervene
					Recount:FreeComm();
				end
			end,
			map = { [false] = L["|cffff4040Disabled|r"], [true] = L["|cff40ff40Enabled|r"] }
		},
		[L["reset"]] = {
			name = L["Reset"],
			desc = L["Resets the data"],
			type = 'execute',
			func = function() Recount:ResetData() end
		},
		[L["verChk"]] = {
			name = L["VerChk"],
			desc = L["Displays the versions of players in the raid"],
			type = 'execute',
			func = function() Recount:ReportVersions() end
		},
		[L["show"]] = {
			name = L["Show"],
			desc = L["Shows the main window"],
			type = 'execute',
			func = function() Recount.MainWindow:Show();Recount:RefreshMainWindow() end
		},
		hide = {
			name = L["Hide"],
			desc = L["Hides the main window"],
			type = 'execute',
			func = function() Recount.MainWindow:Hide() end
		},
		toggle = {
			name = L["Toggle"],
			desc = L["Toggles the main window"],
			type = 'execute',
			func = function() if Recount.MainWindow:IsShown() then Recount.MainWindow:Hide() else Recount.MainWindow:Show();Recount:RefreshMainWindow() end end
		},
		report = {
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
		},
		config = {
			name = L["Config"],
			desc = L["Shows the config window"],
			type = 'execute',
			func = function() Recount:ShowConfig() end
		},
		resetpos = {
			name = L["ResetPos"],
			desc = L["Resets the positions of the detail, graph, and main windows"],
			type = 'execute',
			func = function() Recount:ResetPositions() end
		},
		lock = {
			name  = L["Lock"],
			desc = L["Toggles windows being locked"],
			type = 'toggle',
			get = function() return Recount.db.char.Locked end,
			set = function(v)
				Recount.db.char.Locked=v
				Recount:LockWindows(v)
			end,
			map = { [false] = L["|cffff4040Disabled|r"], [true] = L["|cff40ff40Enabled|r"] }
		},
		unknownSpells = {
			name = L["Unknown Spells"],
			desc = L["Shows found unknown spells in BabbleSpell"], -- Elsia: Fixed typo, also in all localizations
			type = 'execute',
			func = function() Recount:Print(L["Unknown Spells:"]);for k in pairs(Recount.UnknownSpells) do Recount:Print(k) end end
		},
		realtime = {
			name = L["Realtime"],
			type = 'group',
			desc = L["Specialized Realtime Graphs"],
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
				raid = {
					name = L["Raid"],
					desc = L["Tracks your entire raid"],
					type = 'group',

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
		},
	}
}

Recount:RegisterChatCommand({"/recount"}, Recount.consoleOptions)

function Recount:ReportVersions() -- Elsia: Functionified so GUI can use it too
	Recount:Print(L["Displaying Versions"])
	if(Recount.VerTable ~= nil) then -- Elsia: Fixed nil error on non sync situation.
		for k,v in pairs(Recount.VerTable) do
			Recount:Print(k.." "..v)
		end
	end
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

	if Recount.MainWindow then
		Recount:RefreshMainWindow()
	end

	for k,v in pairs(Recount.db.char.combatants) do
		Recount.db.char.combatants[k]=nil
	end

	for k,v in pairs(Recount.db.char.CombatTimes) do
		Recount.db.char.CombatTimes[k]=nil
	end

	if Recount.MainWindow and Recount.MainWindow.DispTableSorted then
		Recount.MainWindow.DispTableSorted=Recount:GetTable()
		Recount.MainWindow.DispTableLookup=Recount:GetTable()
	end
	Recount.db.char.FoughtWho={}

	Recount:ResetTableCache()
	--Perform a garbage collect if they are resetting the data
	collectgarbage("collect")
end

function Recount:FindUnit(name)
	local unit, UnitObj
	--Handle this as two passes
	unit=Roster:GetUnitIDFromName(name)

	if unit then
		return unit
	end

	for UnitObj in Roster:IterateRoster(true) do
		if unit==nil and name==UnitName(UnitObj.unitid.."target") then
			unit=UnitObj.unitid.."target"
		end
	end
	return unit
end

local Epsilon=0.000000000000000001

function Recount:ResetFightData(data)
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
	data.Threat=0
	data.ThreatNonZero=0
	data.ManaGain=0
	data.EnergyGain=0
	data.RageGain=0
	data.Ressed=0

	--Network traffic
	data.NetworkWho=0
	data.NetworkWhat=0

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
	data.Threat=0
	data.ThreatNonZero=0
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
	data.RessedWho=Recount:GetTable()

	--Network Tracking
	data.NetworkWho=0
	data.NetworkWhat=0
	data.NetworkTrafficWho=Recount:GetTable()
	data.NetworkTrafficWhat=Recount:GetTable()

	--Elemental Tracking
	data.ElementDone=Recount:GetTable()
	data.ElementDoneResist=Recount:GetTable()
	data.ElementTaken=Recount:GetTable()
	data.ElementTakenResist=Recount:GetTable()

	data.ElementHitsDone=Recount:GetTable()
	data.ElementHitsTaken=Recount:GetTable()
end

function Recount:DetermineType(name)
	local combatant=Recount.db.char.combatants[name]

	if name==Recount.PlayerName then
		combatant.type="Self"
		return
	end

	if combatant.checkLater then
		combatant.type="Unknown"
		return
	end

	if combatant.isPlayer then
		if combatant.inGroup then
			combatant.type="Grouped"
		else
			combatant.type="Ungrouped"
		end
	else
		if combatant.Owner then
			combatant.type="Pet"
		else
			if combatant.isTrivial then
				combatant.type="Trivial"
			elseif combatant.level==-1 then
				combatant.type="Boss"
			else
				combatant.type="Nontrivial"
			end
		end
	end
end

function Recount:AddCombatant(name,owner)
	local combatant=Recount.db.char.combatants[name]

	combatant.Init=true

	if not owner then
		combatant.Name=name
	else
		combatant.Name=string.match(name,"(.*) <"..owner..">")
	end
	if owner then
		Recount:SetOwner(combatant,name,owner)
	end
	local unit=Recount:FindUnit(combatant.Name)
	if unit then
		local UnitObj=Roster:GetUnitObjectFromName(combatant.Name)
		if UnitObj then
			unit=UnitObj.unitid
			combatant.inGroup=true
			combatant.groupNum=UnitObj.subgroup
		else
			combatant.inGroup=false
		end
		combatant.isPlayer=UnitIsPlayer(unit)
		combatant.isTrivial=UnitIsTrivial(unit)
		combatant.isFriend=UnitIsFriend("player",unit)
		combatant.class, combatant.enClass=UnitClass(unit)
		combatant.unit=unit
		combatant.level=UnitLevel(unit)
		combatant.isTrivial=UnitIsTrivial(unit)
	else
		combatant.isFriend=false
		combatant.enClass="WARRIOR"
		combatant.checkLater=true
		combatant.inGroup=false
		combatant.level=0
	end

	Recount:DetermineType(name)

	if combatant.type=="Pet" then
		combatant.enClass="PET"
	elseif not combatant.isPlayer then
		combatant.enClass="MOB"
	end

	combatant.LastFightIn=Recount.FightNum
	combatant.UnitLockout=Recount.CurTime
end


function Recount:SetOwner(who,petName,owner)

	who.Owner=owner

	if who.Owner then
		if who.Owner==who.Name then
			who.Owner=nil
			return
		end
		if not Recount.db.char.combatants[who.Owner].Init then
			Recount:AddCombatant(who.Owner)
		end
		Recount.db.char.combatants[who.Owner].Pet=petName
	end
end

Recount.LastGroupCheck=0
function Recount:GroupCheck()
	if Recount.LastGroupCheck>GetTime() then
		return
	end
	Recount.LastGroupCheck=GetTime()+0.25

	for k,v in pairs(Recount.db.char.combatants) do
		local Unit = Roster:GetUnitObjectFromName(k)

		--Must be in our group
		if Unit then
			v.unit=Unit.unitid
			v.isPlayer=UnitIsPlayer(Unit.unitid)
			v.inGroup=true
			v.groupNum=Unit.subgroup
		else
			v.inGroup=false
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
				v.unit=nil
			end
		end
	end

	Recount.Pets:ScanRoster()
end

function Recount:NewRaidMember()
	Recount:SendVersion()	--Sending the version for the new person
	Recount:ResetAbbrev()	--Resetting abbreviations for the new person
end

function Recount:RosterLib_UnitChanged(id, name, class, subgroup, rank, oldname, oldid, oldclass, oldsubgroup, oldrank )
	Recount:ScheduleEvent(Recount.GroupCheck,1)
	--Reset Abbreviations if someone joined which is whenever the new name isn't nil and the oldname is nil
	if name~=nil and oldname==nil then
		Recount:ScheduleEvent(Recount.NewRaidMember,0.1)
	end

	--Player is leaving the group, if we have them in our version table remove then
	if name==nil and oldname~=nil and Recount.VerTable ~= nil then
		if Recount.VerTable[oldname] then
			Recount.VerTable[oldname]=nil
		end
	end
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

local function ThreatFallback()
	--First lets look at old threat target and is it still hostile if so keep that target
	--If it isn't lets search through the raid for a target
	if  Recount.ThreatTarget==threat.GlobalTarget or (not UnitExists(Recount.ThreatTarget)) or UnitIsFriend("player",Recount.ThreatTarget) then
		Recount.ThreatTarget=threat.GlobalTarget
		local Check
		for unit in Roster:IterateRoster(true) do
			Check=unit.unitid.."target"
			if Recount.ThreatTarget==threat.GlobalTarget and UnitExists(Check) and not UnitIsFriend("player",Check) then
				Recount.ThreatTarget=Check
			end
		end
	end
end

function Recount:FindThreatTarget()
	--Check up to three targets down the line before falling back on checking our old target we were using then checking the entire raids target then lastly settling on a global target
	if UnitExists("target") then
		if UnitIsFriend("player","target") then
			if UnitExists("targettarget") then
				if UnitIsFriend("player","targettarget") then
					if UnitExists("targettargettarget") then
						if UnitIsFriend("player","targettargettarget") then
							ThreatFallback()
						else
							Recount.ThreatTarget="targettargettarget"
						end
					else
						ThreatFallback()
					end
				else
					Recount.ThreatTarget="targettarget"
				end
			else
				ThreatFallback()
			end
		else
			Recount.ThreatTarget="target"
		end
	else
		ThreatFallback()
	end

	if Recount.ThreatTarget~=threat.GlobalTarget then
		Recount.ThreatTargetName=UnitName(Recount.ThreatTarget)
	else
		Recount.ThreatTargetName=threat.GlobalTarget
	end

	Recount.ThreatTargetSet=Recount.CurTime
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
	local Time=time()
	local TimeCheck2=GetTime()-FilterSize-1
	local TimeCheck=Time-FilterSize-1
	local TimeFormatted

	--First check if combat status changed
	Recount:CheckCombat(Time)
	Recount.CurTime=Time
	Recount.UnitLockout=Time-5

	--Send Messages that are waiting
	Recount:SendMsgQueue()

	--Need to increment where data gets put and erase the old ones
	local PrevTimeStep=Recount.TimeStep
	Recount.TimeStep=Recount.TimeStep+1
	if Recount.TimeStep>FilterSize then
		Recount.TimeStep=1
	end

	if Recount.ThreatActive then
		if Recount.ThreatTargetSet~=Recount.CurTime then
			Recount:FindThreatTarget()
		end
	end

	for name,v in pairs(Recount.db.char.combatants) do
		if Recount.db.char.GlobalDataCollect == true and Recount.db.char.Filters.Data[v.type] and Recount.db.char.Filters.TimeData[v.type] and v.TimeLast["OVERALL"] and v.TimeLast["OVERALL"]>=TimeCheck then -- Elsia: Added global collection switch
			--First threat data
			if v.type=="Self" or v.type=="Grouped" or v.type=="Pet" then
				if Recount.ThreatActive then
					local CurThreat=threat:GetThreat(name,Recount.ThreatTargetName)

					v.TimeWindows.Threat[PrevTimeStep]=CurThreat-(v.LastThreat or 0)
					v.LastThreat=CurThreat

					--Don't want to reset threat since want to keep it for later
					if CurThreat~=0 then
						v.Fights.OverallData.ThreatNonZero=CurThreat
						v.Fights.CurrentFightData.ThreatNonZero=CurThreat
					end
					v.Fights.OverallData.Threat=CurThreat
					v.Fights.CurrentFightData.Threat=CurThreat
				else
					v.TimeWindows.Threat[PrevTimeStep]=-(v.LastThreat or 0)
					v.LastThreat=0
				end

				if v.TimeWindows.Threat[PrevTimeStep]~=0 then
					Recount:ThreatChanged(name,v.TimeWindows.Threat[PrevTimeStep])
				end

				if v.LastThreat~=0 then
					v.TimeLast.Threat=Recount.CurTime
					v.TimeLast["OVERALL"]=Recount.CurTime
				end
			end

			for k, v2 in pairs(v.TimeWindows) do
				local Temp
				local NewEntry=0

				if v.TimeLast[k] and v.TimeLast[k]>=TimeCheck then
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

				local TimeData=v.TimeData[k]
				if NewEntry~=0 then
					--do we need a leading zero?
					if not v.TimeNeedZero[k] then
						TimeData[1][#TimeData[1]+1]=Time-1-FilterMiddle
						TimeData[2][#TimeData[2]+1]=0

						v.TimeNeedZero[k]=true
					end

					if not Recount:CheckIfAlmostLinear(TimeData, Time-FilterMiddle, NewEntry) then
						TimeData[1][#TimeData[1]+1]=Time-FilterMiddle
						TimeData[2][#TimeData[2]+1]=NewEntry
					else
						--If almost linear write over the old value
						TimeData[1][#TimeData[1]]=Time-FilterMiddle
						TimeData[2][#TimeData[2]]=NewEntry
					end
				elseif v.TimeNeedZero[k] then --Check if we need a trailing zero
					TimeData[1][#TimeData[1]+1]=Time-FilterMiddle
					TimeData[2][#TimeData[2]+1]=0
					v.TimeNeedZero[k]=false
				end
			end
		end

		--Lets see if this unit needs to be updated
		if Recount.db.char.GlobalDataCollect == true and v.checkLater and v.LastFightIn>(Recount.FightNum-4) and v.UnitLockout<Recount.UnitLockout then
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

				local rUnit = Roster:GetUnitObjectFromName(k)

				--Must be in our group
				if rUnit then
					v.unit=rUnit.unitid
					v.inGroup=true
					v.groupNum=rUnit.subgroup
				else
					v.inGroup=false
				end

				Recount:DetermineType(name)

				if v.type=="Pet" then
					--Recount:FindOwner(v) -- Elsia: Odd bug, this function never existed and type can only be Pet if it has an owner.Maybe the idea was to recheck owner but it never got implemented? Actually the function got removed a long time ago. Just not this call.
					v.enClass="PET"
				elseif not v.isPlayer then
					v.enClass="MOB"
				end
			end
		end
	end

--	if Recount.db.char.AutoDeleteCombatants and math.fmod(Time,30)==0 then   -- Elsia: Bye autodeletecombatants!
--		local DeleteTime=Time-60*Recount.db.char.AutoDeleteTime
--		for name,v in pairs(Recount.db.char.combatants) do
--			if (v.type ~= "Pet" and v.LastActive<DeleteTime) or (v.type == "Pet" and Recount.db.char.combatants[v.Owner].LastActive<DeleteTime) then -- Elsia: Take owner time for deleting for pets
--				if v.type == "Pet" then
--					Recount.db.char.combatants[v.Owner]=nil -- Elsia: Always delete pets with owners, this should take care of older pets.
--					Recount.db.char.combatants[name]=nil
--				else
--					if v.Pet then
--						Recount.db.char.combatants[v.Pet]=nil -- Elsia: If it's a pet owner, delete pet. Note: Only the last pet will be deleted this way
--					end
--					Recount.db.char.combatants[name]=nil
--				end
--			end
--		end
--	end

	if Recount.db.char.AutoDelete and math.fmod(Time,10)==0 then
		Recount:DeleteOldTimeData(Time)
	end

	if Recount.db.char.GlobalDataCollect == true then -- Elsia: Only sync if collecting
		Recount:UpdatePlayerSync()
	end
end

function Recount:PutInCombat()
	Recount.InCombat=true
	Recount.InCombatT=Recount.CurTime
	Recount.InCombatF=date("%H:%M:%S")
	Recount.FightingWho=""
	Recount.FightingLevel=0

	if Recount.db.char.MainWindow.AutoHide then
		Recount.MainWindow:Hide()
	end

	if Recount.db.profile.Window.ShowCurAndLast then
		Recount.CurDataSet="CurrentFightData"
	end

	--If current mode is not overall data we need to reset disp table
	if Recount.CurDataSet~="OverallData" then -- Elsia: Fix for double entry in CurAndLast mode
		Recount.MainWindow.DispTableSorted=Recount:GetTable()
		Recount.MainWindow.DispTableLookup=Recount:GetTable()
	end
end


function Recount:CheckCombat(Time)
	local InCombat=false
	for unit in Roster:IterateRoster(true) do
		if (not InCombat) and UnitAffectingCombat(unit.unitid) then
			if not Recount.InCombat then
				Recount:PutInCombat()
			end
			InCombat=true
		end
	end

	if not InCombat and Recount.InCombat then --We were in combat but no longer
		Recount:LeaveCombat(Time)
	end
end

--Moved into a seperate function
function Recount:LeaveCombat(Time)
	--No matter what we want to clear the event numbers
	--[[for k, v in pairs(Recount.EventNum) do
		for k2 in pairs(v) do
			v[k2]=nil
		end
	end]]

	if Recount.db.char.MainWindow.AutoHide then
		Recount.MainWindow:Show()
	end

	--Did we actually fight someone?
	Recount.InCombat=false
	if (Recount.FightingWho=="") then
		return
	end

	Recount.InCombat=false

	if (Time-Recount.InCombatT)>5 then
		Recount.db.char.CombatTimes[#Recount.db.char.CombatTimes+1]={Recount.InCombatT,Time,Recount.InCombatF,date("%H:%M:%S"),Recount.FightingWho}

		--Save current data as the last fight
		Recount.Fights:MoveFights()

		if Recount.db.profile.Window.ShowCurAndLast then
			Recount.CurDataSet="Fight1"
		end

		--If current mode is not overall data we need to reset disp table
		if Recount.CurDataSet~="OverallData" then
			Recount.MainWindow.DispTableSorted=Recount:GetTable()
			Recount.MainWindow.DispTableLookup=Recount:GetTable()
		end

		Recount.FightNum=Recount.FightNum+1
	else
		for _,v in pairs(Recount.db.char.combatants) do
			Recount:ResetFightData(v.Fights["CurrentFightData"])
		end
	end
end

function Recount:DeleteOldTimeData(Time)
	local DeleteTime=Time-60*Recount.db.char.AutoDeleteTime

	for name,v in pairs(Recount.db.char.combatants) do
		for _,Check in pairs(v.TimeData) do
			while Check[1][1] and Check[1][1]<DeleteTime do
				table.remove(Check[1],1)
				table.remove(Check[2],1)
			end
		end
	end

	local Fights=Recount.db.char.CombatTimes

	while Fights[1] and Fights[1][2]<DeleteTime do
		table.remove(Fights,1)
	end
end

function Recount:FixLastTime()
	local Time=GetTime()
	for name,v in pairs(Recount.db.char.combatants) do
		v.LastAbility=Time
	end
end

local function DelayedResizeWindows()
	Recount:ResizeMainWindow()
	DelayedResizeWindows=nil
end

function Recount:OnInitialize()
	if Recount.db.char["version"]~=DataVersion then
		--Recount:ResetDB()
		Recount:ResetData()

		Recount.db.char.version=DataVersion
	end

	Recount.TimeStep=1
	Recount.InCombat=false
	Recount.CurDataSet="OverallData"
	Recount.FightingLevel=0
	Recount.CurTime=time()
	Recount.UnknownSpells={}

	Recount:CreateMainWindow()

	Recount:CreateDetailWindow()
	Recount:CreateGraphWindow()
	Recount:CreateFilterWeights()
	Recount:InitOrder()

	Recount:SetupMainWindow()
	Recount:ScheduleEvent(DelayedResizeWindows,0.1)

	SM.RegisterCallback(Recount, "LibSharedMedia_Registered", "UpdateBarTextures")
	SM.RegisterCallback(Recount, "LibSharedMedia_SetGlobal", "UpdateBarTextures")
	if Recount.db.char.BarTexture then
		Recount:SetBarTextures(Recount.db.char.BarTexture)
	end


	if Recount.db.char.GraphWindowX then
		Recount.GraphWindow:ClearAllPoints()
		Recount.GraphWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.char.GraphWindowX,Recount.db.char.GraphWindowY)
	end

	if Recount.db.char.DetailWindowX then
		Recount.DetailWindow:ClearAllPoints()
		Recount.DetailWindow:SetPoint("TOPLEFT",UIParent,"TOPLEFT",Recount.db.char.DetailWindowX,Recount.db.char.DetailWindowY)
	end

	if Recount.db.char.RealtimeWindows then
		local Windows=Recount.db.char.RealtimeWindows
--		Recount.db.char.RealtimeWindows={} -- Elsia: Allow persistence of windows between restarts
		for k,v in pairs(Windows) do
			if v[8] and v[8] == true then -- Elsia: Make sure to respect closed windows as closed on startup
				Recount:CreateRealtimeWindowSized(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			end
		end
	end


	Recount.ThreatActive=threat:IsActive()

	Recount.PlayerName=UnitName("player")
	Recount.ThreatTargetName="GLOBAL"

	Recount.EventNum={}
	Recount.EventNum["DAMAGE"]={}
	Recount.EventNum["HEALING"]={}

	Recount.FightNum=0

	for k,v in pairs(Recount.db.char.combatants) do
		v.LastFightIn=0
	end
	
	if Recount.db.char.EnableSync==true then
		Recount:ConfigComm()
	end
	
	Recount:FixLastTime()
	--Recount:ScaleWindows(Recount.db.char.Scaling,true)
	Recount:ScaleWindows(Recount.db.char.Scaling) -- Elsia: Bug: Even for first time we need in place code for scaling.

	if Recount.db.char.UseFixLog then
		Recount:FixStrings()
	end
end

function Recount:FixParserLib()
	--Just need to reset anything that might already have a pattern set
	for k,v in pairs(Parser.patternTable) do
		Parser.patternTable[k]=nil
	end
end

function Recount:OnEnable(first)
	if first and Recount.db.char.UseCombatLogRange then
		Recount:SetLogRange(Recount.db.char.CombatLogRange)
	end

	Recount.TimeTick() -- Elsia: Prevent that time data is not initialized when an event comes in before the first tick.
	
	Recount.ThreatActive=threat:IsActive()
	Recount:ScheduleEvent(Recount.GroupCheck,1)

	Recount:ScheduleRepeatingEvent("RecountTick",Recount.TimeTick,1)

	Recount:RegisterEvent("RosterLib_UnitChanged")
	Recount:RegisterEvent("Threat_Activate")
	Recount:RegisterEvent("Threat_Deactivate")
	--Recount:RegisterEvent("SharedMedia_SetGlobal")

	Recount:RegisterEvent("UNIT_PET")
	Recount:RegisterEvent("PLAYER_PET_CHANGED")

	if Recount.db.char.AutoDeleteNewInstance == true then
	   	Recount:RegisterEvent("ZONE_CHANGED_NEW_AREA","DetectInstanceChange")
		Recount:DetectInstanceChange()
	end

	if Recount.db.char.DeleteJoinRaid or Recount.db.char.DeleteJoinGroup then
		Recount:InitPartyBasedDeletion()
	end
	
	Recount:RegisterEvent("CHAT_MSG_ADDON",Recount_AddNetworkData)
	
	-- threat:RequestActiveOnSolo(true) Elsia: Threat debugging

	--Parser Events
	Parser:RegisterInfoType("Recount","hit",Recount.ParseDamageEvent)
	Parser:RegisterInfoType("Recount","miss",Recount.ParseMissEvent)
	Parser:RegisterInfoType("Recount","heal",Recount.ParseHealEvent)
	Parser:RegisterInfoType("Recount","death",Recount.ParseDeathEvent)
	Parser:RegisterInfoType("Recount","interrupt",Recount.ParseInterruptEvent)
	Parser:RegisterInfoType("Recount","dispel",Recount.ParseDispelEvent)

	Parser:RegisterInfoType("Recount","debuff",Recount.ParseMiscVictimEvent)
	Parser:RegisterInfoType("Recount","buff",Recount.ParseMiscVictimEvent)
	Parser:RegisterInfoType("Recount","fade",Recount.ParseMiscVictimEvent)


	Parser:RegisterInfoType("Recount","buff",Recount.ParseMiscVictimEvent)
	Parser:RegisterInfoType("Recount","fade",Recount.ParseMiscVictimEvent)


	Recount:RegisterParserEvent({eventType = "Cast"}, Recount.ParseCast)
	Recount:RegisterParserEvent({eventType = "Aura"}, Recount.ParseAura)
	Recount:RegisterParserEvent({eventType = "Gain"}, Recount.ParseGain)


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


--Don't call this before UI has finished loading
function Recount:SetLogRange(Dist)
    if not Dist then
        Dist=200;
    end

    SetCVar("CombatDeathLogRange", Dist);
    SetCVar("CombatLogRangeParty", Dist);
    SetCVar("CombatLogRangePartyPet", Dist);
    SetCVar("CombatLogRangeFriendlyPlayers", Dist);
    SetCVar("CombatLogRangeFriendlyPlayersPets", Dist);
    SetCVar("CombatLogRangeHostilePlayers", Dist);
    SetCVar("CombatLogRangeHostilePlayersPets", Dist);
    SetCVar("CombatLogRangeCreature", Dist);
end

local DefaultConfig={
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

					--Network Tracking
					NetworkWho=0,
					NetworkWhat=0,
					NetworkTrafficWho={},
					NetworkTrafficWhat={},

					--Elemental Tracking
					ElementDone={},
					ElementDoneResist={},
					ElementTaken={},
					ElementTakenResist={},

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
			},
		}
	},
	FoughtWho={},
	CombatTimes={},
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
	UseCombatLogRange=true,
	CombatLogRange=200,
	BarTexture="BantoBar",
	version=0,
	MergePets=true,
	RecordCombatOnly=true,
	MainWindowVis=true,
	UseFixLog=true,
	Locked=false,
	EnableSync=false, -- Elsia: Default enable sync is set to false now
	GlobalDataCollect=true, -- Elsia: Global toggle for data collection
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
	},
	Filters={
		Show={
			Self=true,
			Grouped=true,
			Ungrouped=true, -- Elsia: Default show leaving party members
			Pet=true,
			Trivial=false,
			Nontrivial=false,
			Boss=false,
			Unknown=false,
		},
		Data={
			Self=true,
			Grouped=true,
			Ungrouped=false, -- Elsia: Removed to reduce default data accumulation
			Pet=true,
			Trivial=false,
			Nontrivial=true,
			Boss=true,
			Unknown=true,
		},
		TimeData={
			Self=true,
			Grouped=false, -- Elsia: Removed Default timed on for groups
			Ungrouped=false,
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
			Pet=true,
			Trivial=false,
			Nontrivial=false,
			Boss=true,
			Unknown=false,
		},
	},
	FilterDeathType={
		DAMAGE=true,
		HEAL=true,
		MISC=true
	},
	FilterDeathIncoming={
		[true]=true,
		[false]=false
	},
	RealtimeWindows={}
}

local Default_Profile={
	Colors={
		["Window"]={
			["Title"] = { r = 1, g = 0, b = 0, a = 1},
			["Background"]= { r = 24/255, g = 24/255, b = 24/255, a = 1},
			["Title Text"] = {r = 1, g = 1, b = 1, a = 1},
		},
		["Bar"]={
			["Bar Text"] = {r = 1, g = 1, b = 1},
		},
		["Other Windows"]={
			["Title"] = { r = 1, g = 0, b = 0, a = 1},
			["Background"]= { r = 24/255, g = 24/255, b = 24/255, a = 1},
			["Title Text"] = {r = 1, g = 1, b = 1, a = 1},
		},
		["Detail Window"]={
		},
		["Class"]={
			["HUNTER"] = { r = 0.67, g = 0.83, b = 0.45 },
			["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79 },
			["PRIEST"] = { r = 1.0, g = 1.0, b = 1.0 },
			["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73 },
			["MAGE"] = { r = 0.41, g = 0.8, b = 0.94 },
			["ROGUE"] = { r = 1.0, g = 0.96, b = 0.41 },
			["DRUID"] = { r = 1.0, g = 0.49, b = 0.04 },
			["SHAMAN"] = { r = 0.14, g = 0.35, b = 1.0 },
			["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43 },
			["PET"] = { r = 0.09, g = 0.61, b = 0.55 },
			["MOB"] = { r = 0.58, g = 0.24, b = 0.63 },
		},
		["Realtime"]={
		},
		["Names"]={
		}
	},
	MaxFights=5,
	Window={
		ShowCurAndLast=false,
	},
}

Recount:RegisterDefaults('char',DefaultConfig)
Recount:RegisterDefaults('profile',Default_Profile)

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
--	Recount.MainWindow:ClearAllPoints()
--	Recount.MainWindow:SetPoint("CENTER",UIParent,"CENTER",0,0)
--	Recount.GraphWindow:ClearAllPoints()
--	Recount.GraphWindow:SetPoint("CENTER",UIParent,"CENTER",0,0)
--	Recount.DetailWindow:ClearAllPoints()
--	Recount.DetailWindow:SetPoint("CENTER",UIParent,"CENTER",0,0)
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

function TestPieChart()
	local Graph = LibStub:GetLibrary("LibGraph-2.0")
-- local Graph = AceLibrary("Graph-1.0")
	local g=Graph:CreateGraphPieChart("TestPieChart",UIParent,"LEFT","LEFT",0,0,150,150)
	TestPie=g
	g:AddPie(35,{1.0,0.0,0.0})
	g:AddPie(21,{0.0,1.0,0.0})
	g:CompletePie({0.2,0.2,1.0})
	Recount:ScheduleRepeatingEvent("PieTest",Recount.TestPie,0)
end
