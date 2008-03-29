--Handles all the syncing
--Basic concept is
--1. Only send messages for yoursel
--2. Send the event number, if someone receives an event number higher than their current number then they missed the event
--3. Reset event numbers shortly after combat ends (delayed in case messages arrive late)
--4. Use number abbreviations for text (abbreviations are first registered, anyone can send a message requesting all abbreviations be resent as they get used in case of disconnects)
--5. Queue messages together to send at once
local BS = AceLibrary("LibBabble-Spell-3.0"):GetUnstrictLookupTable() --GetLookupTable()
--local BS = AceLibrary("LibBabble-Spell-3.0")
local threat = AceLibrary("Threat-1.0")

local MinimumVersion=46036
local SyncMsg=false

local MaxMsgs=12
local MsgNum=0
local MsgQueue={}

local AbbrevNum=0	--How many phrases in the abbreviation table
local AbbrevTable={}	--Converts phrases to numbers
local RAbbrevTable={}	--Converts numbers to phrases

local RangeSync={}

local FirstInit=true

--This tells us what args in the tables should need conversion
local NeedsConvert={
	DAMAGE={true,true,true,true,true,false,false},
	HEALING={true,true,true,true,false,false}
}

local function GetAbbrev(phrase)
	if not AbbrevTable[phrase] then
		local Abbrev
		AbbrevNum=AbbrevNum+1

		Abbrev=AbbrevNum

		--Lets make full use of the serialization spec by negating if needed
		if Abbrev>127 and Abbrev<=256 then
			Abbrev=Abbrev-256
		elseif Abbrev>256 then
			Abbrev=Abbrev-129
			--Shouldn't ever get to 32767 abbreviations so won't bother with that
		end
		AbbrevTable[phrase]=AbbrevNum

		if not RAbbrevTable[Recount.PlayerName] then
			RAbbrevTable[Recount.PlayerName]=Recount:GetTable()
		end

		RAbbrevTable[Recount.PlayerName][AbbrevNum]=phrase

		--Need to add a message now
		MsgNum=MsgNum+1

		MsgQueue[MsgNum]=Recount:GetTable()
		MsgQueue[MsgNum][1]="ABBREV"
		MsgQueue[MsgNum][2]=AbbrevNum
		MsgQueue[MsgNum][3]=phrase

		if MsgNum==MaxMsgs then
			Recount:SendMsgQueue()
		end

		return AbbrevNum
	end
	return AbbrevTable[phrase]
end

--Replaces Abbreviations with the proper phrases
--If unable to translate due to missing phrases it will return false otherwise true
local function TranslateArgTable(Who, EventType, ArgTable)
	local TransTable=RAbbrevTable[Who]
	if type(TransTable)~="table" then
		return false
	end

	local ArgTypes=NeedsConvert[EventType]

	for k, v in pairs(ArgTable) do
		if ArgTypes[k] then
			if TransTable[v] then
				ArgTable[k]=TransTable[v]
			else
				return false
			end
		end
	end

	return true
end

function Recount:SendEvent(source, victim, EventType, argTable, SpecialEvent)
	--Make sure this isn't a request to add an event from a sync message
	if SyncMsg then
		Recount:FreeTable(argTable)
		return
	end

	--Inc the event numbers
	Recount.EventNum[EventType][source]=(Recount.EventNum[EventType][source] or 0)+1

	--Always want to send special events no matter what
	if not SpecialEvent then
		--Changing code to only spend special events now
		Recount:FreeTable(argTable)
		return
		--Only send messages for ourself
		--[[if source~=Recount.PlayerName and victim~=Recount.PlayerName then
			Recount:FreeTable(argTable)
			return
		end

		--How bad is the buffer? If its below 500 bytes left then lets return
		if ChatThrottleLib:UpdateAvail()<500 then
			return
		end]]
	end

	--First thing the argTable needs to be converted
	for k, v in pairs(argTable) do
		if NeedsConvert[EventType][k] then
			argTable[k]=GetAbbrev(v)
		end
	end

	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]=EventType
	MsgQueue[MsgNum][2]=Recount.EventNum[EventType][source]
	MsgQueue[MsgNum][3]=argTable
	if SpecialEvent then
		MsgQueue[MsgNum][4]=SpecialEvent
	end

	if MsgNum==MaxMsgs then
		Recount:SendMsgQueue()
	end
end

function Recount:ResetAbbrev()
	for k in pairs(AbbrevTable) do
		AbbrevTable[k]=nil
	end
	AbbrevNum=0
end

function Recount:RequestResetAbbrev()
	Recount:ResetAbbrev()

	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]="RESETABBREV"
	Recount:SendMsgQueue()
end


function Recount:RequestVersion()
	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]="VERSIONREQUEST"

	if MsgNum==MaxMsgs then
		Recount:SendMsgQueue()
	end
end


function Recount:SendVersion()
	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]="VERSION"
	MsgQueue[MsgNum][2]=Recount.Version

	if MsgNum==MaxMsgs then
		Recount:SendMsgQueue()
	end
end

function Recount:SendMsgQueue()
	if MsgNum==0 then
		return
	end

	if Recount.db.char.EnableSync then
		local result=Recount:SendCommMessage("GROUP",MsgQueue)
	end

	MsgNum=0
	for k,v in pairs(MsgQueue) do
		Recount:FreeTableRecurse(v)
		MsgQueue[k]=nil
	end
end

function Recount:DumpMsgQueue()
	Recount:PrintLiteral(MsgQueue)
end

function Recount:DumpAbbrevTable(other)
	if other==nil then
		other=Recount.PlayerName
	end
	local OurTable=RAbbrevTable[other]
	Recount:Print(AbbrevNum.." Abbreviations")

	for i=1,AbbrevNum do
		Recount:Print("Abbrev for "..OurTable[i].." is "..i)
	end
end

function Recount:OnCommReceive(prefix, sender, distribution, Msgs)
	local EventType

	if not Recount.HasEnabled or not Recount.db.char.EnableSync then
		return
	end

	--Make sure we received a table and right prefix
	if type(Msgs)~="table" then
		return
	end

	SyncMsg=true
	for k, v in pairs(Msgs) do
		EventType=v[1]
		if EventType=="ABBREV" then	--Add Abbreviation
			if type(RAbbrevTable[sender])~="table" then
				RAbbrevTable[sender]=Recount:GetTable()
			end

			RAbbrevTable[sender][v[2]]=v[3]
		elseif EventType=="RESETABBREV" then	--Reset abbreviations being used (done for joining groups)
			for k in pairs(AbbrevTable) do
				AbbrevTable[k]=nil
			end
			AbbrevNum=0
		elseif EventType=="DAMAGE" then
			if  Recount.VerNum[sender] and Recount.VerNum[sender]>=MinimumVersion then
				if TranslateArgTable(sender, EventType, v[3]) then
					--Is the event number less
					local Diff=v[2]-(Recount.EventNum[EventType][v[3][1]] or 0)
					if Diff==1 then
						Recount.EventNum[EventType][v[3][1]]=v[2]
						v[3][1]=threat:TranslateForeignMobName(v[3][1])
						v[3][2]=threat:TranslateForeignMobName(v[3][2])
						v[3][3]=BS[v[3][3]] or v[3][3]
						Recount:AddDamageData(v[3][1],v[3][2],v[3][3],v[3][4],v[3][5],v[3][6],v[3][7])
					elseif v[4] then
						Recount:AddDamageData(v[3][1],v[3][2],v[3][3],v[3][4],v[3][5],v[3][6],v[3][7])
					elseif Diff>1 then
						Recount.EventNum[EventType][v[3][1]]=v[2]
					end
				end
			end
		elseif EventType=="HEALING" then
			if  Recount.VerNum[sender] and Recount.VerNum[sender]>=MinimumVersion then
				if TranslateArgTable(sender, EventType, v[3]) then
					--Is the event number less
					local Diff=v[2]-(Recount.EventNum[EventType][v[3][1]] or 0)
					if Diff==1 then
						Recount.EventNum[EventType][v[3][1]]=v[2]
						v[3][1]=threat:TranslateForeignMobName(v[3][1])
						v[3][2]=threat:TranslateForeignMobName(v[3][2])
						v[3][3]=BS[v[3][3]] or v[3][3]
						Recount:AddHealData(v[3][1],v[3][2],v[3][3],v[3][4],v[3][5],v[3][6])
					elseif v[4] then
						Recount:AddHealData(v[3][1],v[3][2],v[3][3],v[3][4],v[3][5],v[3][6])
					elseif Diff>1 then
						Recount.EventNum[EventType][v[3][1]]=v[2]
					end
				end
			end
		elseif EventType=="VERSIONREQUEST" then
			Recount:SendVersion()
		elseif EventType=="VERSION" then
			Recount.VerNum[sender]=tonumber(string.match(v[2],"Revision: (%d+)"))
			if Recount.VerNum[sender]<MinimumVersion then
				Recount.VerTable[sender]="|cffff2020Incompatible|r "..v[2]
			else
				Recount.VerTable[sender]=v[2]
			end
		elseif EventType=="PLAYERSYNC" then
			if Recount.VerNum[sender] and Recount.VerNum[sender]>=MinimumVersion then
				Recount:ReceiveSync(sender,v[2])
			end
		elseif EventType=="HEALCORRECT" then
			if Recount.VerNum[sender] and Recount.VerNum[sender]>=MinimumVersion then
				Recount:HealCorrection(sender,v[2])
			end
		end
	end
	SyncMsg=false
end

function Recount:SendPlayerSync(who, time)
	local SyncMsg=Recount:GetTable()
	SyncMsg[1]=GetAbbrev(who.Name)
	who.Sync.MsgNum=who.Sync.MsgNum+1
	SyncMsg[2]=who.Sync.MsgNum
	SyncMsg[3]=who.Sync.Damage
	SyncMsg[4]=who.Sync.DamageTaken
	SyncMsg[5]=0 --who.Sync.FDamage
	SyncMsg[6]=who.Sync.Healing
	SyncMsg[7]=who.Sync.Overhealing
	SyncMsg[8]=who.Sync.HealingTaken
	SyncMsg[9]=who.Sync.ActiveTime

	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]="PLAYERSYNC"
	MsgQueue[MsgNum][2]=SyncMsg

	who.Sync.LastSent=time+2.5*math.random()

	if MsgNum==MaxMsgs then
		Recount:SendMsgQueue()
	end
end

function Recount:ReceiveSync(From, SyncMsg)
	local TransTable=RAbbrevTable[From]

	if TransTable==nil or TransTable[SyncMsg[1]]==nil then
		return
	end

	SyncMsg[1]=threat:TranslateForeignMobName(TransTable[SyncMsg[1]])
	local who=Recount.db.char.combatants[SyncMsg[1]]
	local MsgDiff=SyncMsg[2]-who.Sync.MsgNum

	if MsgDiff<-1 then
		return
	elseif MsgDiff>1 then
		who.Sync.MsgNum=SyncMsg[2]
		who.Sync.Damage=SyncMsg[3]
		who.Sync.DamageTaken=SyncMsg[4]
		who.Sync.FDamage=SyncMsg[5]
		who.Sync.Healing=SyncMsg[6]
		who.Sync.Overhealing=SyncMsg[7]
		who.Sync.HealingTaken=SyncMsg[8]
		if SyncMsg[9] then
			who.Sync.ActiveTime=SyncMsg[9]
		end
		return
	elseif MsgDiff==1 then
		who.Sync.MsgNum=SyncMsg[2]
	end

	local Diff=SyncMsg[3]-who.Sync.Damage
	if Diff>0 then
		Recount:AddAmount(who,"Damage",Diff)
		who.Sync.Damage=SyncMsg[3]
	end

	Diff=SyncMsg[4]-who.Sync.DamageTaken
	if Diff>0 then
		Recount:AddAmount(who,"DamageTaken",Diff)
		who.Sync.DamageTaken=SyncMsg[4]
	end

	--[[Diff=SyncMsg[5]-who.Sync.FDamage
	if Diff>0 then
		--Recount:AddAmount(who,"FDamage",Diff)
		Recount:Print("Received a FDamage Sync Number from",From,"for",SyncMsg[1])
		who.Sync.FDamage=SyncMsg[5]
	end]]

	Diff=SyncMsg[8]-who.Sync.HealingTaken
	if Diff>0 then
		Recount:AddAmount(who,"HealingTaken",Diff)
		who.Sync.FDamage=SyncMsg[8]
	end

	Diff=SyncMsg[7]-who.Sync.Overhealing
	if Diff>0 then
		Recount:AddAmount(who,"Overhealing",Diff)
		who.Sync.Overhealing=SyncMsg[7]
	end

	Diff=SyncMsg[6]-who.Sync.Healing

	if Diff>0 then
		who.Sync.Healing=SyncMsg[6]
		Recount:AddAmount(who,"Healing",Diff)
	end

	Diff=SyncMsg[9]-who.Sync.ActiveTime
	if Diff>0 then
		who.Sync.ActiveTime=SyncMsg[9]
		Recount:AddAmount(who,"ActiveTime",Diff)
	end
end

function Recount:DetermineSyncMultiple()
	--Determines the factor for how delayed will sends be sent
	return math.exp(-0.0006*(ChatThrottleLib:UpdateAvail()-4000))
end


function Recount:UpdatePlayerSync()
	local CurTime=GetTime()
	local CheckTime=CurTime-10*Recount:DetermineSyncMultiple()
	for name, who in pairs(Recount.db.char.combatants) do
		if who.Sync.LastSent<CheckTime and who.Sync.LastSent<who.Sync.LastChanged then
			Recount:SendPlayerSync(who,CurTime)
		end
	end
end

function Recount:HealCorrection(From, Correct)
	local TransTable=RAbbrevTable[From]

	if TransTable==nil or TransTable[Correct[1]]==nil then
		return
	end

	local who=TransTable[Correct[1]]
	local whoName=who
	local amount=Correct[2]
	local overheal=Correct[3]

	if not Recount.db.char.combatants[who].Init then
		Recount:AddCombatant(who)
	end

	who=Recount.db.char.combatants[who]

	Recount:AddAmount(who,"Healing",-amount)
	Recount:AddAmount(who,"Overhealing",-overheal)

	Recount:CorrectTableData(who,"HealedWho",whoName,amount)
	Recount:CorrectTableData(who,"WhoHealed",whoName,amount)

	if Correct[4] then
		local ability=TransTable[Correct[4]]
		Recount:CorrectTableData(who,"Heals",ability,amount)
	end
end

function Recount:SendHealCorrection(who,amount,overheal,healName)
	local Correct=Recount:GetTable()
	Correct[1]=GetAbbrev(who)
	Correct[2]=amount
	Correct[3]=overheal
	Correct[4]=GetAbbrev(healName)

	MsgNum=MsgNum+1

	MsgQueue[MsgNum]=Recount:GetTable()
	MsgQueue[MsgNum][1]="HEALCORRECT"
	MsgQueue[MsgNum][2]=Correct

	if MsgNum==MaxMsgs then
		Recount:SendMsgQueue()
	end
end

--Need this at the end
function Recount:ConfigComm()
	if Recount:IsCommRegistered("RECOUNT", "GROUP") == false then -- Elsia: We are already connected, just treat it like a DC
		if FirstInit == true then
			Recount:SetCommPrefix("RECOUNT")
			Recount:RegisterMemoizations("ABBREV","RESETABBREV","DAMAGE","HEALING","VERSIONREQUEST","VERSION","RANGELIST","PLAYERSYNC","EVENTNUM","HEALCORRECT")
			FirstInit = false
		end
		
		Recount:RegisterComm("RECOUNT", "GROUP", "OnCommReceive")
		Recount:SetDefaultCommPriority("BULK")

		Recount.VerTable={}
		Recount.VerNum={}
	end

	--Need to request a reset in case we DC'ed and rejoined into a raid
	Recount:SendVersion()
	Recount:RequestVersion()
	Recount:RequestResetAbbrev()
end

function Recount:FreeComm()
	if Recount:IsCommRegistered("RECOUNT", "GROUP") == true then
		Recount:UnregisterComm("RECOUNT", "GROUP")
	end
end
