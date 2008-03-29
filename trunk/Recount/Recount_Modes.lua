local threat = AceLibrary("Threat-1.0")
local L = AceLibrary("AceLocale-2.2"):new("Recount")
local Epsilon=0.000000000000000001

--.MainTitle = What you see on the window title 
--.TopNames = Names of the entries for the top data
--.TopAmount = What we call the amount for the top
--.BotNames = Names of the entries for the bottom
--.BotMin = The minimum label for bottom
--.BotAvg = The average label for bottom
--.BotMax = The minimum label for bottom
--.BotAmount = Label for what the amount is on the bottom
local DetailTitles={}
DetailTitles.Attacks={
	TopNames = L["Ability Name"],
	TopAmount = L["Damage"],
	BotNames = L["Type"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Count"]
}

DetailTitles.Resisted={
	TopNames = L["Ability Name"],
	TopAmount = L["Resisted"],
	BotNames = L["Type"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Count"]
}

DetailTitles.DamagedWho={
	TopNames = L["Player/Mob Name"],
	TopAmount = L["Damage"],
	BotNames = L["Attack Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Damage"]
}

DetailTitles.DamageTime={
	TopNames = L["Player/Mob Name"],
	TopAmount = L["Time (s)"],
	BotNames = L["Attack Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Time (s)"]
}

DetailTitles.Heals={
	TopNames = L["Heal Name"],
	TopAmount = L["Heal"],
	BotNames = L["Type"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Count"]
}

DetailTitles.HealedWho={
	TopNames = L["Player/Mob Name"],
	TopAmount = L["Healed"],
	BotNames = L["Heal Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Healed"]
}

DetailTitles.OverHeals={
	TopNames = L["Heal Name"],
	TopAmount = L["Overheal"],
	BotNames = L["Type"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Count"]
}

DetailTitles.HealTime={
	TopNames = L["Player/Mob Name"],
	TopAmount = L["Time (s)"],
	BotNames = L["Heal Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Time (s)"]
}

DetailTitles.ActiveTime={
	TopNames = L["Player/Mob Name"],
	TopAmount = L["Time (s)"],
	BotNames = L["Ability"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Time (s)"]
}


DetailTitles.DOTs={
	TopNames = L["Ability Name"],
	TopAmount = L["DOT Time"],
	BotNames = L["Ticked on"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Duration"]
}

DetailTitles.HOTs={
	TopNames = L["Ability Name"],
	TopAmount = L["HOT Time"],
	BotNames = L["Ticked on"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Duration"]
}

DetailTitles.Interrupts={
	TopNames = L["Interrupted Who"],
	TopAmount = L["Interrupts"],
	BotNames = L["Interrupted"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Count"]
}

DetailTitles.Ressed={
	TopNames = L["Ressed Who"],
	TopAmount = L["Times"],
	BotNames = L["Ability"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Count"]
}


DetailTitles.Dispels={
	TopNames = L["Who"],
	TopAmount = L["Dispels"],
	BotNames = L["Dispelled"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Count"]
}

DetailTitles.CC={
	TopNames = L["Broke"],
	TopAmount = L["Count"],
	BotNames = L["Broke On"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Count"]
}

DetailTitles.Gained={
	TopNames = L["Ability"],
	TopAmount = L["Gained"],
	BotNames = L["From"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Gained"]
}

DetailTitles.GainedFrom={
	TopNames = L["From"],
	TopAmount = L["Gained"],
	BotNames = L["Ability"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Gained"]
}

DetailTitles.Network={
	TopNames = L["Prefix"],
	TopAmount = L["Messages"],
	BotNames = L["Distribution"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Messages"]
}


DetailTitles.NetworkWho={
	TopNames = L["Prefix"],
	TopAmount = L["Bytes"],
	BotNames = L["Distribution"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Messages"]
}

DetailTitles.NetworkWhat={
	TopNames = L["Who"],
	TopAmount = L["Bytes"],
	BotNames = L["Distribution"],
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Messages"]
}

local DataModes={}

function DataModes:DamageReturner(data, num)
	local PetAmount=0
	local Time=data.Fights[Recount.CurDataSet].ActiveTime
	if Recount.db.char.MergePets and data.Pet and Recount.db.char.combatants[data.Pet].Init then
		if Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet] then
			PetAmount=Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].Damage or 0
			if Time<Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].ActiveTime then
				Time=Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].ActiveTime
			end
		end
	end
	
	if num==1 then
		return ((data.Fights[Recount.CurDataSet].Damage or 0) + PetAmount), ((data.Fights[Recount.CurDataSet].Damage or 0) + PetAmount)/Time
	end

	return ((data.Fights[Recount.CurDataSet].Damage or 0)+PetAmount), {{data.Fights[Recount.CurDataSet].Attacks,L["'s Hostile Attacks"],DetailTitles.Attacks},{data.Fights[Recount.CurDataSet].DamagedWho," "..L["Damaged Who"],DetailTitles.DamagedWho},{data.Fights[Recount.CurDataSet].PartialResist,L["'s Partial Resists"],DetailTitles.Resisted},{data.Fights[Recount.CurDataSet].TimeDamaging,L["'s Time Spent Attacking"],DetailTitles.DamageTime}}
end

function DataModes:DPSReturner(data, num)
	local PetAmount=0
	local Time=data.Fights[Recount.CurDataSet].ActiveTime
	if Recount.db.char.MergePets and data.Pet and Recount.db.char.combatants[data.Pet].Init then
		if Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet] then
			PetAmount=Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].Damage or 0
			if Time<Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].ActiveTime then
				Time=Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].ActiveTime
			end
		end
	end
	
	if num==1 then
		return ((data.Fights[Recount.CurDataSet].Damage or 0) + PetAmount)/Time
	end

	return ((data.Fights[Recount.CurDataSet].Damage or 0) + PetAmount)/Time, {{data.Fights[Recount.CurDataSet].Attacks,L["'s Hostile Attacks"],DetailTitles.Attacks},{data.Fights[Recount.CurDataSet].DamagedWho," "..L["Damaged Who"],DetailTitles.DamagedWho},{data.Fights[Recount.CurDataSet].PartialResist,L["'s Partial Resists"],DetailTitles.Resisted},{data.Fights[Recount.CurDataSet].TimeDamaging,L["'s Time Spent Attacking"],DetailTitles.DamageTime}}
end


function DataModes:FriendlyDamageReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].FDamage or 0)
	end

	return (data.Fights[Recount.CurDataSet].FDamage or 0), {{data.Fights[Recount.CurDataSet].FAttacks,L["'s Friendly Fire"],DetailTitles.Attacks},{data.Fights[Recount.CurDataSet].FDamagedWho," "..L["Friendly Fired On"],DetailTitles.DamagedWho}}
end

function DataModes:DamageTakenReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].DamageTaken or 0)
	end

	return (data.Fights[Recount.CurDataSet].DamageTaken or 0), {{data.Fights[Recount.CurDataSet].WhoDamaged," "..L["Took Damage From"],DetailTitles.DamagedWho}}
end

function DataModes:HealingReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].Healing or 0), (data.Fights[Recount.CurDataSet].Healing or 0)/data.Fights[Recount.CurDataSet].ActiveTime
	end


	return (data.Fights[Recount.CurDataSet].Healing or 0), {{data.Fights[Recount.CurDataSet].Heals,L["'s Effective Healing"],DetailTitles.Heals},{data.Fights[Recount.CurDataSet].HealedWho," "..L["Healed Who"],DetailTitles.HealedWho},{data.Fights[Recount.CurDataSet].OverHeals,L["'s Overhealing"],DetailTitles.OverHeals},{data.Fights[Recount.CurDataSet].TimeHealing,L["'s Time Spent Healing"],DetailTitles.HealTime}}
end

function DataModes:HealingTaken(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].HealingTaken or 0)
	end


	return (data.Fights[Recount.CurDataSet].HealingTaken or 0), {{data.Fights[Recount.CurDataSet].WhoHealed," "..L["was Healed by"],DetailTitles.HealedWho}}
end

function DataModes:OverhealingReturner(data, num)
	if num==1 then
		local OverhealPercent
		OverhealPercent=(math.floor(1000*(data.Fights[Recount.CurDataSet].Overhealing/(data.Fights[Recount.CurDataSet].Overhealing+data.Fights[Recount.CurDataSet].Healing+Epsilon))+0.5)/10).."%"
		return (data.Fights[Recount.CurDataSet].Overhealing or 0), OverhealPercent
	end

	return (data.Fights[Recount.CurDataSet].Overhealing or 0), {{data.Fights[Recount.CurDataSet].OverHeals,L["'s Overhealing"],DetailTitles.OverHeals},{data.Fights[Recount.CurDataSet].Heals,L["'s Effective Healing"],DetailTitles.Heals},{data.Fights[Recount.CurDataSet].HealedWho," "..L["Healed Who"],DetailTitles.HealedWho}}
end

function DataModes:DeathReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].DeathCount or 0)
	end

	return (data.Fights[Recount.CurDataSet].DeathCount or 0), {{data.DeathLogs, Recount.SetDeathDetails, Recount.SetDeathLogDetails}}
end

function DataModes:DOTReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].DOT_Time or 0), (data.Fights[Recount.CurDataSet].DOT_Time or 0)/data.Fights[Recount.CurDataSet].ActiveTime
	end

	return (data.Fights[Recount.CurDataSet].DOT_Time or 0), {{data.Fights[Recount.CurDataSet].DOTs,L["'s DOT Uptime"],DetailTitles.DOTs}}
end

function DataModes:HOTReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].HOT_Time or 0), (data.Fights[Recount.CurDataSet].HOT_Time or 0)/data.Fights[Recount.CurDataSet].ActiveTime
	end

	return (data.Fights[Recount.CurDataSet].HOT_Time or 0), {{data.Fights[Recount.CurDataSet].HOTs,L["'s HOT Uptime"],DetailTitles.HOTs}}
end

function DataModes:InterruptReturner(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].Interrupts or 0)
	end

	return (data.Fights[Recount.CurDataSet].Interrupts or 0), {{data.Fights[Recount.CurDataSet].InterruptData,L["'s Interrupts"],DetailTitles.Interrupts}}
end

function DataModes:Ressed(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].Ressed or 0)
	end

	return (data.Fights[Recount.CurDataSet].Ressed or 0), {{data.Fights[Recount.CurDataSet].RessedWho,L["'s Resses"],DetailTitles.Ressed}}
end

function DataModes:Dispels(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].Dispels or 0)
	end

	return (data.Fights[Recount.CurDataSet].Dispels or 0), {{data.Fights[Recount.CurDataSet].DispelledWho,L["'s Dispels"],DetailTitles.Dispels}}
end

function DataModes:Dispelled(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].Dispelled or 0)
	end

	return (data.Fights[Recount.CurDataSet].Dispelled or 0), {{data.Fights[Recount.CurDataSet].WhoDispelled," "..L["was Dispelled by"],DetailTitles.Dispels}}
end

function DataModes:ActiveTime(data, num)
	if num==1 then
		return (math.floor(data.Fights[Recount.CurDataSet].ActiveTime*100)/100 or 0)
	end

	return (math.floor(data.Fights[Recount.CurDataSet].ActiveTime*100)/100 or 0), {{data.Fights[Recount.CurDataSet].TimeSpent,L["'s Time Spent"],DetailTitles.ActiveTime},{data.Fights[Recount.CurDataSet].TimeDamaging,L["'s Time Spent Attacking"],DetailTitles.DamageTime},{data.Fights[Recount.CurDataSet].TimeHealing,L["'s Time Spent Healing"],DetailTitles.HealTime}}
end

function DataModes:PolyBreak(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].CCBreak or 0)
	end
	return (data.Fights[Recount.CurDataSet].CCBreak or 0), {{data.Fights[Recount.CurDataSet].CCBroken," "..L["CC Breaking"],DetailTitles.CC}}
end

function DataModes:ManaGained(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].ManaGain or 0)
	end
	return (data.Fights[Recount.CurDataSet].ManaGain or 0), {{data.Fights[Recount.CurDataSet].ManaGained,L["'s Mana Gained"],DetailTitles.Gained},{data.Fights[Recount.CurDataSet].ManaGainedFrom,L["'s Mana Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:EnergyGained(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].EnergyGain or 0)
	end
	return (data.Fights[Recount.CurDataSet].EnergyGain or 0), {{data.Fights[Recount.CurDataSet].EnergyGained,L["'s Energy Gained"],DetailTitles.Gained},{data.Fights[Recount.CurDataSet].EnergyGainedFrom,L["'s Energy Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:RageGained(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].RageGain or 0)
	end
	return (data.Fights[Recount.CurDataSet].RageGain or 0), {{data.Fights[Recount.CurDataSet].RageGained,L["'s Rage Gained"],DetailTitles.Gained},{data.Fights[Recount.CurDataSet].RageGainedFrom,L["'s Rage Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:NetworkWho(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].NetworkWho or 0)
	end
	return (data.Fights[Recount.CurDataSet].NetworkWho or 0), {{data.Fights[Recount.CurDataSet].NetworkTrafficWho,L["'s Network Traffic"],DetailTitles.NetworkWho}}
end

function DataModes:NetworkWhat(data, num)
	if num==1 then
		return (data.Fights[Recount.CurDataSet].NetworkWhat or 0)
	end
	return (data.Fights[Recount.CurDataSet].NetworkWhat or 0), {{data.Fights[Recount.CurDataSet].NetworkTrafficWhat,L["'s Network Traffic"],DetailTitles.NetworkWhat}}
end



function DataModes:Threat(data)
	--[[local ThreatAmount
	
	if Recount.ThreatActive then
		ThreatAmount=threat:GetThreat(data.Name,Recount.ThreatTargetName)
		
		return ThreatAmount
	end]]
	
	if Recount.InCombat then
		return (data.Fights[Recount.CurDataSet].Threat or 0)
	end

	return (data.Fights[Recount.CurDataSet].ThreatNonZero or 0)
end

local SpecialTotals={}
function SpecialTotals:Threat()
	if Recount.ThreatActive then
		if Recount.ThreatTarget and Recount.ThreatTarget~=threat.GlobalTarget and UnitExists(Recount.ThreatTarget.."target") then
			local t=threat:GetThreat(UnitName(Recount.ThreatTarget.."target"),Recount.ThreatTargetName)
			if t>0 then
				return t
			end
		end
		return threat:GetMaxThreatOnTarget(Recount.ThreatTargetName)
	end
	return 1
end




--Some code for table management from Ace2
local new, del
do
	local cache = setmetatable({},{__mode='k'})
	function new()
		local t = next(cache)
		if t then
			cache[t] = nil
			return t
		else
			return {}
		end
	end
	
	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		cache[t] = true
		return nil
	end
end



function Recount:AddSortedTooltipData(title,data,num)
	local SortedData=Recount:GetTable()
	GameTooltip:AddLine(title,1,0.82,0)

	local total=Epsilon
	local i=0
	for k,v in pairs(data) do
		if v.amount then
			i=i+1
			if not SortedData[i] then
				SortedData[i]=Recount:GetTable()
			end
			SortedData[i][1]=k
			SortedData[i][2]=v.amount
			
			total=total+v.amount
		end		
	end

	if num>i then
		num=i
	end

	table.sort(SortedData,RecountSortFunc)

	for i=1,num do
		if SortedData[i] then
			GameTooltip:AddDoubleLine(i..". "..SortedData[i][1],SortedData[i][2].." ("..math.floor(100*SortedData[i][2]/total).."%)",1,1,1,1,1,1)
		end
	end

	Recount:FreeTableRecurse(SortedData)
end
--The various tooltip functions used for each of the main window data displays
local TooltipFuncs={}
function TooltipFuncs:Damage(name,data)
	if data ~= nil then
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Damage Abilties"],data.Fights[Recount.CurDataSet].Attacks,3)
	GameTooltip:AddLine("")
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Attacked"],data.Fights[Recount.CurDataSet].DamagedWho,3)
	if Recount.db.char.MergePets and data.Pet and Recount.db.char.combatants[data.Pet].Init then
		if Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet] then
			local Damage=Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].Damage or 0 
			Damage=Damage/(Damage+(data.Fights[Recount.CurDataSet].Damage or 0))
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(L["Pet"]..":",data.Pet.." ("..math.floor(Damage*100+0.5).."%)",nil,nil,nil,1,1,1)
			Recount:AddSortedTooltipData(L["Top 3"].." "..L["Pet Damage Abilties"],Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].Attacks,3)
			GameTooltip:AddLine("")
			Recount:AddSortedTooltipData(L["Top 3"].." "..L["Pet Attacked"],Recount.db.char.combatants[data.Pet].Fights[Recount.CurDataSet].DamagedWho,3)
		end
	end

	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
	end
end

function TooltipFuncs:FDamage(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Friendly Attacks"],data.Fights[Recount.CurDataSet].FAttacks,3)
	GameTooltip:AddLine("")
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Friendly Fired On"],data.Fights[Recount.CurDataSet].FDamagedWho,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:DamageTaken(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Attacked by"],data.Fights[Recount.CurDataSet].WhoDamaged,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:Healing(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Heals"],data.Fights[Recount.CurDataSet].Heals,3)
	GameTooltip:AddLine("")
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Healed"],data.Fights[Recount.CurDataSet].HealedWho,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:HealingTaken(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Healed By"],data.Fights[Recount.CurDataSet].WhoHealed,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:Overhealing(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Over Heals"],data.Fights[Recount.CurDataSet].OverHeals,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:DOTs(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["DOTs"],data.Fights[Recount.CurDataSet].DOTs,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:HOTs(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["HOTs"],data.Fights[Recount.CurDataSet].HOTs,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:Interrupts(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Interrupted"],data.Fights[Recount.CurDataSet].InterruptData,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:Dispels(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Dispelled"],data.Fights[Recount.CurDataSet].DispelledWho,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:Dispelled(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Dispelled By"],data.Fights[Recount.CurDataSet].WhoDispelled,3)
	GameTooltip:AddLine("<Click for more Details>",0,0.9,0)
end

function TooltipFuncs:ActiveTime(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Attacked/Healed"],data.Fights[Recount.CurDataSet].TimeSpent,3)
	local Heal,Damage
	Heal=data.Fights[Recount.CurDataSet].TimeHeal
	Damage=data.Fights[Recount.CurDataSet].TimeDamage
	local Total=Heal+Damage+Epsilon
	Heal=100*Heal/Total
	Damage=100*Damage/Total
	GameTooltip:AddDoubleLine(L["Time Damaging"]..":",math.floor(Damage+0.5).."%",nil,nil,nil,1,1,1)
	GameTooltip:AddDoubleLine(L["Time Healing"]..":",math.floor(Heal+0.5).."%",nil,nil,nil,1,1,1)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:ManaGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Mana Abilities"],data.Fights[Recount.CurDataSet].ManaGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Mana Sources"],data.Fights[Recount.CurDataSet].ManaGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:EnergyGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Energy Abilities"],data.Fights[Recount.CurDataSet].EnergyGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Energy Sources"],data.Fights[Recount.CurDataSet].EnergyGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:RageGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Rage Abilities"],data.Fights[Recount.CurDataSet].RageGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Rage Sources"],data.Fights[Recount.CurDataSet].RageGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:Threat(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
end

function TooltipFuncs:DeathCounts(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	GameTooltip:Hide()
end

function TooltipFuncs:CCBroken(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["CC's Broken"],data.Fights[Recount.CurDataSet].CCBroken,3)
end

function TooltipFuncs:Ressed(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Ressed"],data.Fights[Recount.CurDataSet].RessedWho,3)
end

function TooltipFuncs:NetworkWho(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Network Traffic"],data.Fights[Recount.CurDataSet].NetworkTrafficWho,3)
end

function TooltipFuncs:NetworkWhat(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Network Traffic"],data.Fights[Recount.CurDataSet].NetworkTrafficWhat,3)
end


local MainWindowModes={
{L["Damage Done"],DataModes.DamageReturner,TooltipFuncs.Damage,nil,{"DAMAGE",L["'s DPS"]},nil,"Damage"},
{L["DPS"],DataModes.DPSReturner,TooltipFuncs.Damage,nil,{"DAMAGE","'s DPS"},nil,"Damage"},
{L["Friendly Fire"],DataModes.FriendlyDamageReturner,TooltipFuncs.FDamage},
{L["Damage Taken"],DataModes.DamageTakenReturner,TooltipFuncs.DamageTaken,nil,{"DAMAGETAKEN",L["'s DTPS"]},nil,"DamageTaken"},
{L["Healing Done"],DataModes.HealingReturner,TooltipFuncs.Healing,nil,{"HEALING",L["'s HPS"]},nil,"Healing"},
{L["Healing Taken"],DataModes.HealingTaken,TooltipFuncs.HealingTaken,nil,{"HEALINGTAKEN",L["'s HTPS"]},nil,"HealingTaken"},
{L["Overhealing Done"],DataModes.OverhealingReturner,TooltipFuncs.Overhealing},
{L["Deaths"],DataModes.DeathReturner,TooltipFuncs.DeathCounts},
{L["DOT Uptime"],DataModes.DOTReturner,TooltipFuncs.DOTs,nil,nil,nil,nil},
{L["HOT Uptime"],DataModes.HOTReturner,TooltipFuncs.HOTs,nil,nil,nil,nil},
{L["Dispels"],DataModes.Dispels,TooltipFuncs.Dispels,nil,nil,nil,nil},
{L["Dispelled"],DataModes.Dispelled,TooltipFuncs.Dispelled,nil,nil,nil,nil},
{L["Interrupts"],DataModes.InterruptReturner,TooltipFuncs.Interrupts,nil,nil,nil,nil},
{L["Ressers"],DataModes.Ressed,TooltipFuncs.Ressed,nil,nil,nil,nil},
{L["CC Breakers"],DataModes.PolyBreak,TooltipFuncs.CCBroken,nil,nil,nil,nil},
{L["Activity"],DataModes.ActiveTime,TooltipFuncs.ActiveTime,nil,nil,nil,nil},
{L["Threat"],DataModes.Threat,TooltipFuncs.Threat,SpecialTotals.Threat,{"THREAT",L["'s TPS"]}, function() return L["Threat on"].." "..Recount.ThreatTargetName end, "Threat"},
{L["Mana Gained"],DataModes.ManaGained,TooltipFuncs.ManaGained},
{L["Energy Gained"],DataModes.EnergyGained,TooltipFuncs.EnergyGained},
{L["Rage Gained"],DataModes.RageGained,TooltipFuncs.RageGained},
{L["Network Traffic(by Player)"],DataModes.NetworkWho,TooltipFuncs.NetworkWho},
{L["Network Traffic(by Prefix)"],DataModes.NetworkWhat,TooltipFuncs.NetworkWhat},
}

function Recount:SetupMainWindow()
	Recount:LoadMainWindowData(MainWindowModes)	
end