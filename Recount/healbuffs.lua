local HealBuffs={}
Recount.HealBuffs=HealBuffs

local BS = AceLibrary("LibBabble-Spell-3.0"):GetLookupTable()
--local BS = AceLibrary("LibBabble-Spell-3.0")

local HealBuff={	
	[BS["Lifebloom"]]=true,
	[BS["Prayer of Mending"]]=true,
	[BS["Earth Shield"]]=true,}

local Lifebloom=BS["Lifebloom"]
local PoM=BS["Prayer of Mending"]
local EarthShield=BS["Earth Shield"]

BS = nil

function HealBuffs:HasMyHealBuffExpiring(unit,buffName)
	local i=1
	local name, TimeLeft

	while (UnitBuff(unit,i) ~= nil) do
		name, _, _, _, _, TimeLeft =  UnitBuff(unit,i)

		if name==buffName and TimeLeft and TimeLeft<0.16 then
			return true
		end
		i=i+1
	end
	return false
end

function HealBuffs:HasMyHealBuff(unit,buffName)
	local i=1
	local Name, Duration
	while (UnitBuff(unit,i) ~= nil) do
		name, _, _, _, Duration =  UnitBuff(unit,i)

		if name==buffName and Duration then
			return true
		end
		i=i+1
	end
	return false
end

function HealBuffs:IsMyHealBuff(victim,ability)
	--first confirm the unitid is correct
	if not UnitExists(victim.unit) or UnitName(victim.unit)~=victim.Name then
		local unit=Recount:FindUnit(victim.Name)
		if unit then
			victim.unit=unit
		else
			--can't find the unit so no idea whats happening
			return false
		end
	end
	
	if ability==Lifebloom then
		--Might not be ours
		if HealBuffs:HasMyHealBuffExpiring(victim.unit,ability) then
			--its ours!
			return true
		end
		return false
	elseif ability==EarthShield then
		if HealBuffs:HasMyHealBuff(victim.unit) then
			return true
		end
		return false
	end

	return false
end

--POM Tracking is based on Roartindon's work in Assessment
-- Sequence is:

-- A casts Prayer of Mending
-- B gains Prayer of Mending
-- B's Prayer of mending heals B for x
-- B casts Prayer of Mending
-- B loses Prayer of Mending
-- C gains Prayer of mending

local POM_OwnerTable={}
local POM_CastQueue={}
local POM_AboutToCast={}

function HealBuffs.POM_Casted(who)
	if POM_AboutToCast[who] and (GetTime()-POM_AboutToCast[who])<0.5 then
		POM_CastQueue[#POM_CastQueue+1]=POM_OwnerTable[who]
		POM_AboutToCast[who]=nil
	else
		POM_CastQueue[#POM_CastQueue+1]=who
	end
end
function HealBuffs.POM_Gained(who)
	if POM_CastQueue[1] then		
		POM_OwnerTable[who]=POM_CastQueue[1]
		table.remove(POM_CastQueue,1)
	else
		POM_OwnerTable[who]="No One"
	end
end

function HealBuffs:WhosPOM(who)
	if POM_OwnerTable[who] then
		POM_AboutToCast[who]=GetTime()
		return POM_OwnerTable[who]
	else
		return "No One"
	end
end