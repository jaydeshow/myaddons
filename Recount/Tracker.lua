--Data for Recount is tracked within this file
local Tracking={}
local BS = AceLibrary("LibBabble-Spell-3.0"):GetLookupTable()
local BSR = AceLibrary("LibBabble-Spell-3.0"):GetReverseLookupTable()
--local BS = AceLibrary("LibBabble-Spell-3.0")

local TickTime={	
	--Mage Ticks
	[BS["Fireball"]]=2,
	[BS["Ignite"]]=2,

	--Priest Ticks
	[BS["Mind Flay"]]=1,

	--Warlock Ticks
	[BS["Curse of Agony"]]=2,
	[BS["Curse of Doom"]]=60,	
	[BS["Drain Life"]]=2,
	[BS["Health Funnel"]]=1,
	[BS["Hellfire"]]=1,


	--Healing Ticks
	[BS["First Aid"]]=1,
	[BS["Lifebloom"]]=1,
}

local CC={
	[BS["Polymorph"]]=true,
	[BS["Polymorph: Pig"]]=true,
	[BS["Polymorph: Turtle"]]=true,
	[BS["Shackle Undead"]]=true,
	[BS["Freezing Trap Effect"]]=true,
	[BS["Hibernate"]]=true,
	[BS["Sap"]]=true, -- Elsia: Attempt at Sap support
	[BS["Seduction"]]=true, -- Elsia: Attempt at Seduction support
}

local HealBuff={	
	[BS["Lifebloom"]]=true,
	[BS["Earth Shield"]]=true,}

local PrayerOfMending=BS["Prayer of Mending"]

local Resses={
	[BS["Ancestral Spirit"]]=true,
	[BS["Resurrection"]]=true,
	[BS["Rebirth"]]=true,
	[BS["Redemption"]]=true,
}

function Recount.ParseDamageEvent(event, info)
	local HitType 
	local source, victim, ability, element

	ability=info.skill

	if ability==ParserLib_MELEE then
		ability="Melee"
	elseif ability==ParserLib_DAMAGESHIELD then
		ability="Damage Shields"
	end


	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	if not info.element then
		info.element="Physical"
	end

	--Long switch of figuring out the type now
	HitType="Hit"
	if info.isCrit then
		HitType="Crit"
	end
	if info.isDOT then
		HitType="Tick"
	end
	if info.isSplit then
		HitType="Split"
	end
	if info.isCrushing then
		HitType="Crushing"
	end
	if info.isGlancing then
		HitType="Glancing"
	end
	if info.amountBlock then
		HitType="Block"
	end

	element = info.element or "Physical"

	--Use the data
	Recount:AddDamageData(source, victim, ability, element, HitType, info.amount, info.amountResist, event)
end

function Recount.ParseMissEvent(event, info)
	local source,victim,ability

	ability=info.skill

	if ability==ParserLib_MELEE then
		ability="Melee"
	end

	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	--Use the data
	Recount:AddDamageData(source, victim, ability, nil, string.upper(string.sub(info.missType,1,1))..string.sub(info.missType,2))
end

function Recount.ParseHealEvent(event, info)
	local source,victim, type

	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	local healtype="Hit"
	if info.isCrit then
		healtype="Crit"
	end

	if info.isDOT then
		healtype="Tick"
	end

	Recount:AddHealData(source, victim, info.skill, healtype, info.amount)
end

function Recount.ParseDeathEvent(event, info)
	local source,victim

	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	Recount:AddDeathData(source, victim, info.skill)
end

function Recount.ParseMiscEvent(event, info)
	local source,victim

	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	Recount:AddMiscData(source, victim)
end

function Recount.ParseMiscVictimEvent(event, info)
	local victim

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	Recount:AddMiscVictimData(victim)
end

function Recount.ParseInterruptEvent(event, info)
	local source,victim,ability

	ability=info.skill

	if ability==ParserLib_MELEE then
		ability="Melee"
	end

	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	Recount:AddInterruptData(source, victim, ability)
end

function Recount.ParseDispelEvent(event, info)
	local source,victim,ability,sourceability

	if info.isFailed then
		return
	end

	ability=info.skill

	if ability==ParserLib_MELEE then
		ability="Melee"
	end
	
	source=info.source
	if source==ParserLib_SELF then
		source=UnitName("player")
	elseif not source or source==ParserLib_NONE then
		source="No One"
	end

	victim=info.victim
	if victim==ParserLib_SELF then
		victim=UnitName("player")
	elseif victim==ParserLib_NONE then
		victim="No One"
	end

	Recount:AddDispelData(source, victim, ability)

	if CC[ability] then
		sourceability=info.sourceSkill
		if not sourceability or sourceability==ParserLib_MELEE  then
			sourceability="Melee"
		end
		ability = ability .. " (" .. sourceability .. ")"
		Recount:AddCCBreaker(source, victim, ability)
	end
end

function Recount.ParseGain(info)
	Recount:AddGain(info.recipientName, info.sourceName, info.abilityName, info.amount, info.attribute)
end


function Recount.ParseCast(info)
	if info.abilityName==PrayerOfMending then
		Recount.HealBuffs.POM_Casted(info.sourceName)
	elseif Resses[info.abilityName] and not info.isBegin and info.sourceName and info.recipientName then
		Recount:AddRes(info.sourceName, info.recipientName, info.abilityName)
	end
end

function Recount.ParseAura(info)
	if info.abilityName==PrayerOfMending then
		Recount.HealBuffs.POM_Gained(info.recipientName)
	end
end


function Recount:AddSyncAmount(who, type, amount)
	who.Sync.LastChanged=GetTime()
	who.Sync[type]=who.Sync[type]+amount
end

function Recount:SetActive(who)
	who.LastActive=Recount.CurTime
end

function Recount:AddTimeEvent(who, onWho, ability, friendly)
	local Time=GetTime()
	local Adding=Time-who.LastAbility
	
	who.LastAbility=Time
	
	if Adding>3.5 then
		Adding=3.5
	end

	Adding=math.floor(100*Adding+0.5)/100

	Recount:AddSyncAmount(who,"ActiveTime", Adding)

	Recount:AddAmount(who,"ActiveTime",Adding)
	Recount:AddTableDataSum(who,"TimeSpent",onWho,ability,Adding)

	if friendly then
		Recount:AddAmount(who,"TimeHeal",Adding)
		Recount:AddTableDataSum(who,"TimeHealing",onWho,ability,Adding)
	else
		Recount:AddAmount(who,"TimeDamage",Adding)
		Recount:AddTableDataSum(who,"TimeDamaging",onWho,ability,Adding)
	end
end


--Only care about event tracking for those we want to track deaths for
function Recount:AddCurrentEvent(who, eventType, incoming, number)
	if Recount.db.char.Filters.TrackDeaths[who.type] then
		who.LastEvents[who.NextEventNum]=arg1
		who.LastEventTimes[who.NextEventNum]=GetTime()
		who.LastEventType[who.NextEventNum]=eventType
		who.LastEventIncoming[who.NextEventNum]=incoming

		if (not who.unit) or (UnitName(who.unit)~=who.Name) and who.UnitLockout<Recount.UnitLockout then
			who.unit=Recount:FindUnit(who.Name)
			who.UnitLockout=Recount.CurTime
		end
		
		if who.unit then
			if UnitHealthMax(who.unit)~=100 then
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).." ("..math.floor(100*UnitHealth(who.unit)/UnitHealthMax(who.unit)).."%)"
				if number then
					
					who.LastEventNum[who.NextEventNum]=100*number/UnitHealthMax(who.unit)
				else
					who.LastEventNum[who.NextEventNum]=nil
				end
			else
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).."%"
				who.LastEventNum[who.NextEventNum]=nil
			end
			who.LastEventHealthNum[who.NextEventNum]=100*UnitHealth(who.unit)/UnitHealthMax(who.unit)
		else
			who.LastEventHealth[who.NextEventNum]="???"
			who.LastEventHealthNum[who.NextEventNum]=0
			who.LastEventNum[who.NextEventNum]=nil
		end		
		
		who.NextEventNum=who.NextEventNum+1

		if who.NextEventNum>Recount.db.char.MessagesTracked then
			who.NextEventNum=who.NextEventNum-Recount.db.char.MessagesTracked
		end
	end
end

--Functions for adding data 

function Recount:AddAmount(who,datatype,amount)
	if not Recount.db.char.Filters.Data[who.type] or Recount.db.char.GlobalDataCollect == false then
		return
	end

	--We add the data to both overall & current fight data
	who.Fights.OverallData[datatype]=who.Fights.OverallData[datatype]+amount
	RecountDataType=datatype
	who.Fights.CurrentFightData[datatype]=who.Fights.CurrentFightData[datatype]+amount
	RecountDataType=nil

	--Now add the time data
	if who.TimeWindows[datatype] then
		who.TimeWindows[datatype][Recount.TimeStep]=who.TimeWindows[datatype][Recount.TimeStep]+amount

		who.TimeLast[datatype]=Recount.CurTime
		who.TimeLast["OVERALL"]=Recount.CurTime
	end
end

--Meant for like elemental data and this type isn't expected to be initialized 
function Recount:AddAmount2(who,datatype,secondary,amount)
	if not Recount.db.char.Filters.Data[who.type]  or Recount.db.char.GlobalDataCollect == false then
		return
	end

	--We add the data to both overall & current fight data
	who.Fights.OverallData[datatype][secondary]=(who.Fights.OverallData[datatype][secondary] or 0)+amount
	who.Fights.CurrentFightData[datatype][secondary]=(who.Fights.CurrentFightData[datatype][secondary] or 0)+amount
end

--Two Different Types of table functions
--First type tracks min/max & count while the other only counts the total sum in the count column
function Recount:AddTableDataStats(who,datatype,secondary,detailtype,amount)
	if not Recount.db.char.Filters.Data[who.type]   or Recount.db.char.GlobalDataCollect == false then
		return
	end

	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	local Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
	
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
end
local first=false
function Recount:CorrectTableData(who,datatype,secondary,amount)
	if not Recount.db.char.Filters.Data[who.type]   or Recount.db.char.GlobalDataCollect == false then
		return
	end

	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	
--[[	if not CurTable.count and not first then
		Recount:Print(datatype,secondary,amount)
		Recount:Print(debugstack())
	end]]
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount

	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount
end



function Recount:AddTableDataStatsNoAmount(who,datatype,secondary,detailtype)
	if not Recount.db.char.Filters.Data[who.type] or Recount.db.char.GlobalDataCollect == false then
		return
	end

	local CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	local Details=CurTable.Details[detailtype]

	Details.count=Details.count+1

	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end



	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
end

function Recount:AddTableDataSum(who,datatype,secondary,detailtype,amount)
	if (not Recount.db.char.Filters.Data[who.type]) or Recount.db.char.GlobalDataCollect == false  then
		--Have to make sure this won't be used by something that needs to have data recorded for it
		if Recount.db.char.combatants[secondary].Init then
			if not Recount.db.char.Filters.Data[Recount.db.char.combatants[secondary].type] or Recount.db.char.GlobalDataCollect == false then
				return
			end
		else		
			return
		end
	end

	local CurTable=who.Fights.OverallData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.amount=(CurTable.amount or 0)+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end
	local Details=CurTable.Details[detailtype]
	Details.count=Details.count+amount


	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.amount=(CurTable.amount or 0)+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+amount
end


--
function Recount:AddDamageData(source, victim, ability, element, hittype, damage, resist, event)
	--Recount:Print("Damage event added for "..source.." attacking "..victim.." with "..ability.." with result of "..hittype)
	--See if both the source & victim are in the tables
	local SpecialEvent=false
	local owner=Recount.Pets:IsUniquePet(source)
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
		owner = Recount.PlayerName -- Elsia: Fix up so that owner properly gets set
	end
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end

	owner=Recount.Pets:IsUniquePet(victim) -- Elsia: Fixed bug, this read source rather than victim, meaning pets never showed in damage taken
	if owner then
		victim=victim.." <"..owner..">"
	end
	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim,owner)
	end

	local sourceData=Recount.db.char.combatants[source]
	local victimData=Recount.db.char.combatants[victim]

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Need to add events for potential deaths
	local DPass=damage
	if DPass==0 then
		DPass=nil
	end
	Recount:AddCurrentEvent(sourceData, "DAMAGE", false)
	Recount:AddCurrentEvent(victimData, "DAMAGE", true, DPass)

	--Is this friendly fire?
	local FriendlyFire=sourceData.isFriend==victimData.isFriend

	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.FightNum
	victimData.LastFightIn=Recount.FightNum

	--Need to set the source as active
	Recount:AddTimeEvent(sourceData,victim,ability,false)
	

	--Stats for keeping track of DOT Uptime
	if hittype=="Tick" then
		--3 is default time since most abilities have 3 seconds inbetween ticks
		local time=3
		if TickTime[ability] then
			time=TickTime[ability]
		end
		Recount:AddAmount(sourceData,"DOT_Time",time)
		Recount:AddTableDataSum(sourceData,"DOTs",ability,victim,time)
	end

	if damage then
		--Victim always cares
		Recount:AddAmount(victimData,"DamageTaken",damage)		
		Recount:AddTableDataSum(victimData,"WhoDamaged",source,ability,damage)	

		--Sync Data
		Recount:AddSyncAmount(victimData, "DamageTaken", damage)

		
		--Melee is always considered Melee since its handled differently from specials keep it seperate
		if ability=="Melee" then
			element="Melee"
		end

		Recount:AddAmount2(victimData,"ElementTaken",element,damage)
		if resist then
			if hittype=="Crit" then
				resist=resist*2
			end
			Recount:AddAmount2(victimData,"ElementTakenResist",element,resist)
		end

		--Record the element type
		sourceData.AbilityType[ability]=element
		
		--Alright now if there was a friendly damage done or not decides where this data goes for the source
		if not FriendlyFire then
			Recount:AddSyncAmount(sourceData, "Damage", damage)
			Recount:AddAmount(sourceData,"Damage",damage)	
			Recount:AddTableDataStats(sourceData,"Attacks",ability,hittype,damage)
			Recount:AddAmount2(sourceData,"ElementDone",element,damage)
			if resist then
				Recount:AddAmount2(sourceData,"ElementDoneResist",element,resist)
				if resist<(damage/2.5) then
					--25% Resist
					Recount:AddTableDataStats(sourceData,"PartialResist",ability,"25% Resist",resist)
				elseif resist<(1.25*damage) then
					--50% Resist
					Recount:AddTableDataStats(sourceData,"PartialResist",ability,"50% Resist",resist)
				else
					--75% Resist
					Recount:AddTableDataStats(sourceData,"PartialResist",ability,"75% Resist",resist)
				end
			else
				Recount:AddTableDataStats(sourceData,"PartialResist",ability,"No Resist",0)
			end

			Recount:AddTableDataSum(sourceData,"DamagedWho",victim,ability,damage)	

			--Needs to be here for tracking so we don't add Friendly Damage as well
			if Tracking["DAMAGE"] then
				if Tracking["DAMAGE"][source] then
					for _, v in pairs(Tracking["DAMAGE"][source]) do
						v.func(v.pass,damage)
					end
				end

				if sourceData.inGroup and Tracking["DAMAGE"]["!RAID"] then
					for _, v in pairs(Tracking["DAMAGE"]["!RAID"]) do
						v.func(v.pass,damage)
					end
				end
			end
		else
			Recount:AddSyncAmount(sourceData, "FDamage", damage)
			Recount:AddAmount(sourceData,"FDamage",damage)
			Recount:AddTableDataStats(sourceData,"FAttacks",ability,hittype,damage)
			Recount:AddTableDataSum(sourceData,"FDamagedWho",victim,ability,damage)
		end

		
		--For identifying who killed when no message is triggered
		victimData.LastAttackedBy=source
		

		--Tracking for passing data to other functions	
		if Tracking["DAMAGETAKEN"] then 
			if Tracking["DAMAGETAKEN"][victim] then
				for _, v in pairs(Tracking["DAMAGETAKEN"][victim]) do
					v.func(v.pass,damage)
				end
			end

			if victimData.inGroup and Tracking["DAMAGETAKEN"]["!RAID"] then
				for _, v in pairs(Tracking["DAMAGETAKEN"]["!RAID"]) do
					v.func(v.pass,damage)
				end
			end
		end
	else
		Recount:AddTableDataStatsNoAmount(sourceData,"Attacks",ability,hittype)
	end


	if sourceData.inGroup and not victimData.isFriend then
		if (victimData.level==-1) or ((Recount.FightingLevel~=-1) and (victimData.level>Recount.FightingLevel)) then
			Recount.FightingWho=victim
			Recount.FightingLevel=victimData.level
		end
	elseif victimData.inGroup and not sourceData.isFriend then
		if (sourceData.level==-1) or ((Recount.FightingLevel~=-1) and (sourceData.level>Recount.FightingLevel)) then
			Recount.FightingWho=source
			Recount.FightingLevel=sourceData.level
		end
	end

	--Alright if we have an element type for this ability add its hit type data
	element=sourceData.AbilityType[ability]
	if element then
		Recount:AddTableDataSum(sourceData,"ElementHitsDone",element,hittype,1)
		Recount:AddTableDataSum(victimData,"ElementHitsTaken",element,hittype,1)
	end	


	--Last thing we should do is add sync message
	local dataTable=Recount:GetTable()

	dataTable[1]=source
	dataTable[2]=victim
		dataTable[3]=BSR[ability]
	if dataTable[3]==nil then
		dataTable[3]=ability
		if ability~="Melee" then
			Recount.UnknownSpells[ability]=true
		end
	end
	dataTable[4]=element
	dataTable[5]=hittype
	dataTable[6]=damage
	dataTable[7]=resist
	Recount:SendEvent(source, victim, "DAMAGE", dataTable, SpecialEvent)
end

function Recount:AddHealData(source, victim, ability, healtype, amount, overheal)
	--First lets figure if there was overhealing
	--Get the tables	
	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	end
	if owner and not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end -- Elsia: Until here is if pets heal anybody.

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.
	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim,owner) -- Elsia: Bug, owner was missing here
	end
	local victimData=Recount.db.char.combatants[victim]

	--Might need to change who the source is here
	local oldSource=nil
	local SpecialEvent=false
	if (source==victim) and source~=Recount.PlayerName and HealBuff[ability]  then
		if Recount.HealBuffs:IsMyHealBuff(victimData,ability) then
			oldSource=source
			source=Recount.PlayerName
			SpecialEvent=true
		end
	end

	if ability==PrayerOfMending then
		source=Recount.HealBuffs:WhosPOM(source)
	end

	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source)
	end

	local sourceData=Recount.db.char.combatants[source]
	

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Need to add events for potential deaths
	Recount:AddCurrentEvent(victimData, "HEAL", true, amount)
	if source~=victim then
		Recount:AddCurrentEvent(sourceData, "HEAL", false)
	end

	--Before any further processing need to check if we are in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		return
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.FightNum
	victimData.LastFightIn=Recount.FightNum

	local VictimUnit=victimData.unit

	if (not VictimUnit or victim~=UnitName(VictimUnit)) and (victimData.UnitLockout>Recount.UnitLockout) then
		victimData.UnitLockout=Recount.CurTime
		VictimUnit=Recount:FindUnit(victim)
		victimData.unit=VictimUnit
	end

	

	if VictimUnit and UnitHealthMax(VictimUnit)~=100 and overheal==nil then
		local HealthMissing = UnitHealthMax(VictimUnit)-UnitHealth(VictimUnit)
		if HealthMissing<amount then
			overheal=amount-HealthMissing
			amount=HealthMissing --Adjust healing considered to the correct number
		else
			overheal=0
		end
	else
		overheal=0
	end
	Recount:AddSyncAmount(sourceData,"Healing", amount)
	Recount:AddSyncAmount(victimData,"HealingTaken", amount)
	Recount:AddSyncAmount(sourceData,"Overhealing", overheal)

	if oldSource then
		if not Recount.db.char.combatants[oldSource].Init then
			Recount:AddCombatant(oldSource)
		end
		local old=Recount.db.char.combatants[oldSource]
		Recount:AddSyncAmount(old,"Healing", amount)
		Recount:AddSyncAmount(old,"Overhealing", overheal)
		Recount:SendHealCorrection(old.Name,amount,overheal,ability)
	end

	--Tracking for passing data to other functions
	if Tracking["HEALING"] then
		if Tracking["HEALING"][source] then
			for _, v in pairs(Tracking["HEALING"][source]) do
				v.func(v.pass,amount)
			end
		end

		if sourceData.inGroup and Tracking["HEALING"]["!RAID"] then
			for _, v in pairs(Tracking["HEALING"]["!RAID"]) do
				v.func(v.pass,amount)
			end
		end
	end

	if Tracking["HEALINGTAKEN"] then
		if Tracking["HEALINGTAKEN"][victim] then
			for _, v in pairs(Tracking["HEALINGTAKEN"][victim]) do
				v.func(v.pass,amount)
			end
		end

		if victimData.inGroup and Tracking["HEALINGTAKEN"]["!RAID"] then
			for _, v in pairs(Tracking["HEALINGTAKEN"]["!RAID"]) do
				v.func(v.pass,amount)
			end
		end
	end

	

	--Need to set the source as active
	Recount:AddTimeEvent(sourceData,victim,ability,true)

	--Stats for keeping track of HOT Uptime
	if healtype=="Tick" then
		--3 is default time since most abilities have 3 seconds inbetween ticks
		local time=3
		if TickTime[ability] then
			time=TickTime[ability]
		end
		Recount:AddAmount(sourceData,"HOT_Time",time)
		Recount:AddTableDataSum(sourceData,"HOTs",ability,victim,time)
	end

	--No reason to add information if everything was overhealing
	if amount>0 then
		Recount:AddAmount(sourceData,"Healing",amount)
		Recount:AddAmount(victimData,"HealingTaken",amount)

		Recount:AddTableDataStats(sourceData,"Heals",ability,healtype,amount)
		Recount:AddTableDataSum(sourceData,"HealedWho",victim,ability,amount)
		Recount:AddTableDataSum(victimData,"WhoHealed",source,ability,amount)
	end

	--Now if there was overhealing lets add that data in
	if overheal>0 then
		Recount:AddAmount(sourceData,"Overhealing",overheal)
		Recount:AddTableDataStats(sourceData,"OverHeals",ability,healtype,overheal)
	end

	--Last thing we should do is add sync message
	local dataTable=Recount:GetTable()

	dataTable[1]=source
	dataTable[2]=victim
	dataTable[3]=BSR[ability]
	if dataTable[3]==nil then
		dataTable[3]=ability
		if ability~="Melee" then
			Recount.UnknownSpells[ability]=true
		end
	end
	dataTable[4]=healtype
	dataTable[5]=amount
	dataTable[6]=overheal
	Recount:SendEvent(source, victim, "HEALING", dataTable,SpecialEvent)
end

function Recount:AddInterruptData(source, victim, ability)
	--Get the tables	
	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
		owner = Recount.PlayerName
	end
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end -- Elsia: Until here is if pets interupts anybody.

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim, owner) -- Elsia: Bug, owner missing here
	end

	local sourceData=Recount.db.char.combatants[source]
	local victimData=Recount.db.char.combatants[victim]

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Need to add events for potential deaths	
	Recount:AddCurrentEvent(victimData,"MISC", true)
	Recount:AddCurrentEvent(sourceData,"MISC", false)

	--Friendly fire interrupt? (Duels)
	local FriendlyFire=sourceData.isFriend==victimData.isFriend

	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.FightNum
	victimData.LastFightIn=Recount.FightNum

	Recount:AddAmount(sourceData,"Interrupts",1)
	Recount:AddTableDataSum(sourceData,"InterruptData",victim,ability,1)
end

function Recount:AddDispelData(source, victim, ability)
	--Get the tables	
	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
		owner = Recount.PlayerName
	end
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end -- Elsia: Until here is if pets dispelled anybody.

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim,owner) -- Elsia: Bug owner missing
	end

	local victimData=Recount.db.char.combatants[victim]
	local sourceData=Recount.db.char.combatants[source]

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)
	
	local FriendlyFire=sourceData.isFriend==victimData.isFriend

	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.FightNum
	victimData.LastFightIn=Recount.FightNum

	--Need to add events for potential deaths	
	Recount:AddCurrentEvent(victimData, "MISC", true)
	Recount:AddCurrentEvent(sourceData, "MISC", false)

	if FriendlyFire then
		Recount:AddAmount(sourceData,"Dispels",1)
		Recount:AddTableDataSum(sourceData,"DispelledWho",victim,ability,1)
		Recount:AddAmount(victimData,"Dispelled",1)
		Recount:AddTableDataSum(victimData,"WhoDispelled",source,ability,1)
	end
end

function Recount:AddDeathData(source, victim, skill)
	--Before any further processing need to check if we are in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		return
	end

	local owner
	
	if source and type(source) == "string" then -- Elsia: Fix bug when death doesn't have a killer
	
		owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
		if owner then
			source=source.." <"..owner..">"
		end
		if not Recount.db.char.combatants[source].Init then
			Recount:AddCombatant(source,owner)
		end -- Elsia: Until here is if pets heal anybody.
	end
		
	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	--Get the tables	
	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim, owner) -- Elsia: Bug owner missing
	end

	local victimData=Recount.db.char.combatants[victim]
	local sourceData

	--Fight tracking purposes to speed up leaving combat
	victimData.LastFightIn=Recount.FightNum

	--Need to add events for potential deaths	
	if source and source~=victim then -- Elsia: May be worth removing the source~=victim check
		if not Recount.db.char.combatants[source].Init then
			Recount:AddCombatant(source,owner) -- Elsia: Potential owner bug here
		end
		sourceData=Recount.db.char.combatants[source]
		sourceData.LastFightIn=Recount.FightNum
		Recount:AddCurrentEvent(sourceData, "MISC", false)
	end	
	
	Recount:AddCurrentEvent(victimData, "MISC", true)

	--This saves who/what killed the victim
	if source then
		victimData.LastKilledBy=source
		victimData.LastKilledAt=GetTime()
	elseif skill then
		victimData.LastKilledBy=skill
		victimData.LastKilledAt=GetTime()
	else
		--The case where we actually add a deathcount
		Recount:AddAmount(victimData,"DeathCount",1)
	end

	--We delay the saving of the event logs just in case more messages come later
	if Recount.db.char.Filters.TrackDeaths[victimData.type] then
		Recount:ScheduleEvent("Death"..victim,Recount.HandleDeath,2,Recount,victim,GetTime())
	end
end

function Recount:HandleDeath(victim,DeathTime)
	owner=Recount.Pets:IsUniquePet(victim) -- Elsia: Added pet support here 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.
	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim,owner)
	end

	local who=Recount.db.char.combatants[victim]

	
	local num=Recount.db.char.MessagesTracked
	local DeathLog=Recount:GetTable()

	DeathLog.DeathAt=Recount.CurTime
	DeathLog.Messages=Recount:GetTable()
	DeathLog.MessageTimes=Recount:GetTable()
	DeathLog.MessageType=Recount:GetTable()
	DeathLog.MessageIncoming=Recount:GetTable()
	DeathLog.Health=Recount:GetTable()
	DeathLog.HealthNum=Recount:GetTable()
	DeathLog.EventNum=Recount:GetTable()

	if who.LastKilledBy and math.abs(who.LastKilledAt-DeathTime)<2 then
		DeathLog.KilledBy=who.LastKilledBy
	elseif who.LastAttackedBy then
		DeathLog.KilledBy=who.LastAttackedBy
		who.LastAttackedBy=nil
	end
			
	local offset
	for i=1,num do
		offset=math.fmod(who.NextEventNum+i+num-2,num)+1
		if who.LastEvents[offset] and (who.LastEventTimes[offset]-DeathTime)>-15 then
			DeathLog.MessageTimes[#DeathLog.MessageTimes+1]=who.LastEventTimes[offset]-DeathTime
			DeathLog.Messages[#DeathLog.Messages+1]=who.LastEvents[offset]
			DeathLog.MessageType[#DeathLog.MessageType+1]=who.LastEventType[offset]
			DeathLog.MessageIncoming[#DeathLog.MessageIncoming+1]=who.LastEventIncoming[offset]
			DeathLog.Health[#DeathLog.Health+1]=who.LastEventHealth[offset]
			DeathLog.HealthNum[#DeathLog.HealthNum+1]=who.LastEventHealthNum[offset]
			DeathLog.EventNum[#DeathLog.HealthNum]=who.LastEventNum[offset]
		end
	end

	who.DeathLogs[#who.DeathLogs+1]=DeathLog
end

function Recount:AddMiscData(source, victim)
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		return
	end

	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
		owner = Recount.PlayerName
	end

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	--Get the tables
	if not Recount.db.char.combatants[victim].Init then
		--If the victim doesn't exist we don't care
		return
	end
	
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end

	local sourceData=Recount.db.char.combatants[source]
	local victimData=Recount.db.char.combatants[victim]

	--Need to add events for potential deaths
	Recount:AddCurrentEvent(sourceData, "MISC", false)
	Recount:AddCurrentEvent(victimData, "MISC", true)
end

function Recount:AddMiscVictimData(victim)
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		return
	end

	--Get the tables
	if not Recount.db.char.combatants[victim].Init then
		--Lets not add events for someone who doesn't exist
		return
	end

	local victimData=Recount.db.char.combatants[victim]

	--Need to add events for potential deaths
	Recount:AddCurrentEvent(victimData, "MISC", true)
end

function Recount:AddCCBreaker(source, victim, ability)
	--Get the tables
	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
		owner = Recount.PlayerName
	end
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end -- Elsia: Until here is if pets heal anybody.

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	if not Recount.db.char.combatants[victim].Init then
		Recount:AddCombatant(victim,owner) -- Elsia: Bug owner missing
	end

	local sourceData=Recount.db.char.combatants[source]
	local victimData=Recount.db.char.combatants[victim]

	Recount:SetActive(sourceData)
	Recount:SetActive(victimData)

	--Is this friendly fire?
	local FriendlyFire=sourceData.isFriend==victimData.isFriend
	
	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.char.RecordCombatOnly then
		if (not FriendlyFire) and (sourceData.inGroup or victimData.inGroup) then
			Recount:PutInCombat()
		else
			return
		end
	end

	--Fight tracking purposes to speed up leaving combat
	sourceData.LastFightIn=Recount.FightNum
	victimData.LastFightIn=Recount.FightNum
	
	if not FriendlyFire then
		Recount:AddAmount(sourceData,"CCBreak",1)
		Recount:AddTableDataSum(sourceData,"CCBroken",ability,victim,1)
	end
end


function Recount:AddGain(source, victim, ability, amount, attribute)
	--Get the tables
	local owner=Recount.Pets:IsUniquePet(source) -- Elsia: Copied from damage add to add pet healing support 
	if owner then
		source=source.." <"..owner..">"
	elseif event=="CHAT_MSG_SPELL_PET_DAMAGE" then
		SpecialEvent=true
		source=source.." <"..Recount.PlayerName..">"
	end
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source,owner)
	end -- Elsia: Until here is if pets heal anybody.

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	local sourceData=Recount.db.char.combatants[source]

	Recount:SetActive(sourceData)

	local DataAmount, DataTable, DataTable2

	if attribute=="Mana" then
		DataAmount="ManaGain"
		DataTable="ManaGained"
		DataTable2="ManaGainedFrom"
	elseif attribute=="Energy" or attribute=="Focus" then -- Elsia: Focus for pet.
		DataAmount="EnergyGain"
		DataTable="EnergyGained"
		DataTable2="EnergyGainedFrom"
	elseif attribute=="Rage" then
		DataAmount="RageGain"
		DataTable="RageGained"
		DataTable2="RageGainedFrom"
	else
		return
	end

	Recount:AddAmount(sourceData,DataAmount,amount)
	Recount:AddTableDataSum(sourceData,DataTable,ability,victim,amount)
	Recount:AddTableDataSum(sourceData,DataTable2,victim,ability,amount)
end

function Recount:AddRes(source, victim, ability)
	--Get the tables
	if not Recount.db.char.combatants[source].Init then
		Recount:AddCombatant(source)
	end

	local sourceData=Recount.db.char.combatants[source]

	Recount:SetActive(sourceData)

	owner=Recount.Pets:IsUniquePet(victim) 
	if owner then
		victim=victim.." <"..owner..">"
	end -- Elsia until here.

	Recount:AddAmount(sourceData,"Ressed",1)
	Recount:AddTableDataSum(sourceData,"RessedWho",victim,ability,1)
end

--Network data tracking
function Recount_AddNetworkData(prefix, msg, distr, sender)
	--Get the tables
	if not Recount.db.char.combatants[sender].Init then
		Recount:AddCombatant(sender)
	end
	if not Recount.db.char.combatants[prefix].Init then
		Recount:AddCombatant(prefix)
	end


	local sourceData=Recount.db.char.combatants[sender]
	local prefixData=Recount.db.char.combatants[prefix]

	Recount:SetActive(sourceData)
	Recount:SetActive(prefixData)
	
	size=string.len(msg)
	Recount:AddAmount(sourceData,"NetworkWho",size)
	Recount:AddAmount(prefixData,"NetworkWhat",size)
	Recount:AddTableDataStats(sourceData,"NetworkTrafficWho",prefix,distr,size)
	Recount:AddTableDataStats(prefixData,"NetworkTrafficWhat",sender,distr,size)
end

--Potential Tracking
--"DAMAGE"
--"DAMAGETAKEN"
--"HEALING"
--"HEALINGTAKEN"
function Recount:RegisterTracking(id, who, stat, func, pass)
	--Special trackers handled first
	if stat=="FPS" then
		Recount:ScheduleRepeatingEvent(id.."_TRACKER",func,0,pass,1)
		return
	elseif stat=="LAG" then
		Recount:ScheduleRepeatingEvent(id.."_TRACKER",function() local _, _, lag = GetNetStats(); func(pass,lag*0.1) end,0.1)
	elseif stat=="UP_TRAFFIC" then
		Recount:ScheduleRepeatingEvent(id.."_TRACKER",function() local _, up  = GetNetStats(); func(pass,1024*up*0.1) end,0.1)
	elseif stat=="DOWN_TRAFFIC" then
		Recount:ScheduleRepeatingEvent(id.."_TRACKER",function() local down  = GetNetStats(); func(pass,1024*down*0.1) end,0.1)
	elseif stat=="AVAILABLE_BANDWIDTH" then
		Recount:ScheduleRepeatingEvent(id.."_TRACKER",function() func(pass,ChatThrottleLib:UpdateAvail()*0.1) end,0.1)
	end
	
	if type(Tracking[stat])~="table" then
		Tracking[stat]=Recount:GetTable()
	end

	if type(Tracking[stat][who])~="table" then
		Tracking[stat][who]=Recount:GetTable()
	end

	if type(Tracking[stat][who][id])~="table" then
		Tracking[stat][who][id]=Recount:GetTable()
	end

	Tracking[stat][who][id].func=func
	Tracking[stat][who][id].pass=pass
end	

function Recount:UnregisterTracking(id, who, stat)
	if stat=="FPS" or stat=="LAG" or stat=="UP_TRAFFIC" or stat=="DOWN_TRAFFIC" or stat=="AVAILABLE_BANDWIDTH" then
		Recount:CancelScheduledEvent(id.."_TRACKER")
		return
	end

	if type(Tracking[stat])~="table" or type(Tracking[stat][who])~="table"  then
		return
	end

	Tracking[stat][who][id]=nil
end


--Threat Tracking
function Recount:ThreatChanged(who,threat)	
	if Tracking["THREAT"] and Tracking["THREAT"][who] then
		for _, v in pairs(Tracking["THREAT"][who]) do
			v.func(v.pass,threat)
		end
	end
end