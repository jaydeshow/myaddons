-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x
local FW = FW;
local CA = FW:Module("Casting");


local t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19;
local s1, s2, s3, s4, s5;

local LastCast = 0;

local OtherQueue = {};
local FW_OnSelfCastSuccess = {};
local FW_OnSelfCastCancel = {};
local FW_OnSelfCastStart = {};

FW.SelfQueue = {}; -- also used in timer

-- used in casting, warlock, summon
FW.SU_CAST_START = "SuS";
FW.SU_CAST_CANCEL = "SuC";
FW.SU_CAST_END = "SuE";

FW.SS_CAST_SELF = "SF";
FW.SS_CAST_START = "SS";
FW.SS_CAST_DELAY = "SD";
FW.SS_CAST_CANCEL = "SC";
FW.SS_CAST_END = "SE";

FW.Track = {};
FW.TrackBuffs = {};
FW.TrackDebuffs = {};

local function CA_Unique(unit)
	if not unit then return 0;end
	if FC_Saved.Exceptions[UnitName(unit)] then return FC_Saved.Exceptions[UnitName(unit)]; end
	
	if UnitPlayerControlled(unit) then
		return 2; -- unique player / pet
	elseif UnitClassification(unit) == "rareelite" or UnitClassification(unit) == "worldboss" then
		return 1; -- unique boss
	else
		return 0; -- not unique
	end
end

local function CA_CastOn(target)
	if target == UnitName("focus") and not UnitIsDead("focus") then -- since this is still a guess, give focus priority because you can't see those debuffs
		if UnitIsUnit("target","focus") then
			return 3; -- cast was on current target and focus
		elseif target == UnitName("target") and not UnitIsDead("target") then
			return 0;-- cant be sure since both target and focus are named the same
		else
			return 2;-- cast was on focus
		end	
	elseif target == UnitName("target") and not UnitIsDead("target")  then
		return 1; -- cast was on target unit
	else
		return 0; -- unknown target
	end
end

---------------------------------------------------------------------------
local function CA_SelfChannelStart()
	if not FW.Settings.SummonMeetingStone then return;end

	FW:ShowDebug("Channel Start");
	local spellName, _, _, _, startTime, endTime = UnitChannelInfo("player");
	
	if spellName == FW.L.MEETING_STONE_SUMMON then 
		local target = UnitName("target");
		if target then
			FW:INSERT(FW.SelfQueue, spellName.." (C)",0,endTime,0,target,endTime-startTime,"",0,0,0,0,0);
			FW:CastShow("MeetingStoneSummon",target);
			FW:SummonStartMessage(FW.PLAYER,target);
		end
	end
end


-- SelfQueue 8+: Other Target info
-- SelfQueue 7: Spell Rank
-- SelfQueue 6: Full spell name
-- SelfQueue 5: Target name

-- SelfQueue 4: Success/Cancel (or whatever) Time (including check delay)
-- SelfQueue 3: Time of cast completion (from event) non-zero means casting spell
-- SelfQueue 2: 0 currently casting, 1 'successfully' casted, -1 maybe cancelled

-- SelfQueue 1: Spell Name

--[[local FW.OnSelfChannelStart = {};
function FW:RegisterOnSelfChannelStart(func)
	table.insert(FW.OnSelfChannelStart,func);
end]]

local function CA_SelfStart()
	--FW:ShowDebug("Spell Start");
	local n = FW:ROWS(FW.SelfQueue);
	if n > 0 then
		t1,_,_,_,t5 = FW:GET(FW.SelfQueue,n);
		local  _,_,_,_,_,endTime = UnitCastingInfo("player");
		
		FW:SET(FW.SelfQueue,n,3, endTime);
		-----------------------------------------------------------
		for i,f in ipairs(FW_OnSelfCastStart) do
			f(t1,t5);
		end
		-----------------------------------------------------------
	end
end

local function CA_SelfCancel()
	--FW:ShowDebug("Cancelling spell");
	local i = FW:ROWS(FW.SelfQueue);
	while i>=1 do
		_,t2 = FW:GET(FW.SelfQueue,i);
		if t2 == 0 then -- not awaiting resist check, and not already cancelled
			FW:SET(FW.SelfQueue,i,2, -1);
			FW:SET(FW.SelfQueue,i,4, GetTime() + FW.Settings.Delay);
			break;
		end
		i=i-1;
	end
end

local function CA_SelfRemove(n)
	FW:ShowDebug("Cancelling spell");
	t1,_,t3,_,t5 = FW:GET(FW.SelfQueue,n);
	if t3~= 0 then
		-----------------------------------------------------------
		for i,f in ipairs(FW_OnSelfCastCancel) do
			f(t1,t5);
		end
		-----------------------------------------------------------
	end
	FW:REMOVE(FW.SelfQueue,n); 
end

local function CA_SelfResist()
	local i=1;
	local t;
	while i <= FW:ROWS(FW.SelfQueue) do
		t1,t2,_,_,t5,t6,_,t8,_,_,t11,t12 = FW:GET(FW.SelfQueue,i);
		if t2 == 1 then
			if string.find(arg1,string.format(FW.L.WAS_RESISTED,t1)) then
				t=4;
			elseif string.find(arg1,string.format(FW.L.FAILED_IMMUNE,t1)) then
				t=5;
			elseif string.find(arg1,string.format(FW.L.WAS_EVADED,t1)) then
				t=6;
			elseif string.find(arg1,string.format(FW.L.IS_REFLECTED,t1)) then
				t=7;
			end
			if t then
				if FW.Settings.TimerResists then FW:Show(arg1,unpack(FW.Settings.ColorFailedMsg)); end
				
				if FW.Settings.TimerBarResists then	
					FW:INSERT(FW.ST,0,GetTime(),1,t5,FW.Track[t1][3],FW.Track[t1][4],FW.Track[t1][6],t1,t8,0,0,1,t11,t,1,0,GetTime()+FW.Settings.TimerFailTime,FW:GetFilterType(t1),t12);	
				end
				FW:REMOVE(FW.SelfQueue,i);
				break;
			end
		end
		i=i+1;
	end
end

local function CA_SelfDelay()
	local i = FW:ROWS(FW.SelfQueue);
	if i > 0 then
		local _,_,_,_,_, endTime = UnitCastingInfo("player");
		-----------------------------------------------------------
		if FW:GET(FW.SelfQueue,i,1) == FW.L.SOULSTONE_RESURRECTION then
			FW:CastDelayMessage(FW.PLAYER, endTime - FW:GET(FW.SelfQueue,i,3));	
		end
		-----------------------------------------------------------
		FW:SET(FW.SelfQueue,i,3, endTime); 
	end
end

local function CA_SelfStop()
	local i=FW:ROWS(FW.SelfQueue);
	while i > 0  do
		if FW:GET(FW.SelfQueue,i,2) == -1 then
			CA_SelfRemove(i);
			break;
		end
		i=i-1;
	end	
end

local function CA_SelfSucces(delay,n)

	local t1,_,_,_,t5,t6,_,t8,t9,t10,t11,t12 = FW:GET(FW.SelfQueue,n);
	-- t6 is now adjusted duration!
	
	if FW.Track[t1] then
		if FW.Track[t1][1] == 1 then
			s1 = t5;
		else
			if t1 == FW.L.INFERNO then -- exceptions, need to make a proper fix for this
				s1 = FW.L.INFERNAL;
			else -- normal	
				s1 = FW.L.NOTARGET;
			end
			
			t8=0;t9=0;t10=0;t11=0;t12=0;
		end
		-- remove old unique crowd control spells
		
		if FW.ST then -- will fix properly at some point!
			if FW.Track[t1][4] == 3 then
				for i=1,FW:ROWS(FW.ST),1 do
					if FW:GET(FW.ST,i,8) == t1 then
						FW:REMOVE(FW.ST,i);
						break;
					end
				end
			-- remove old curse or same old dot on the same target
			elseif t9 == 1 or t10 == 1 then -- must be target or focus, else cant remove anything

				for i=1,FW:ROWS(FW.ST),1 do
					-- same spell if spell name or both are curses and target didnt change since casting the spell to remove or the target is same unigue
					if (FW:GET(FW.ST,i,8) == t1 or FW.Track[t1][4] == 2 and FW:GET(FW.ST,i,6) == 2) and ( FW:GET(FW.ST,i,10) == 1 and t9 == 1 or FW:GET(FW.ST,i,11) == 1 and t10 == 1) then
						FW:REMOVE(FW.ST,i);
						break;
					end
				end
			end
			FW:INSERT(FW.ST,t6-delay,GetTime(),t6,s1,FW.Track[t1][3],FW.Track[t1][4],FW.Track[t1][6],t1,t8,t9,t10,0,t11,0,1,0,0,FW:GetFilterType(t1),t12);
			if FW.Track[t1][3] == 1 then FW:AddDot(s1,t1);end
		end
	end
	FW:ShowDebug(t1.." cast successfull on "..t5);
	-----------------------------------------------------------
	if t5 ~= "" then
		--FW:ShowDebug(spell.." cast on "..target.." successfull");
		-----------------------------------------------------------
		for i,f in ipairs(FW_OnSelfCastSuccess) do
			if f(t1,t5,n) then return; end -- makes it skip the remove if it has a return value
		end
		-----------------------------------------------------------
	end
	FW:REMOVE(FW.SelfQueue,n);
end


local function CA_SelfEnd(arg2)
	--FW:ShowDebug("Ending spell");
	local i=1;
	while i <= FW:ROWS(FW.SelfQueue) do
		t1,_,_,t4 = FW:GET(FW.SelfQueue,i);
		if t4~=1 and (not arg2 or t1==arg2) then
			if FW.Track[t1] and FW.Track[t1][1] == 1 then
				FW:SET(FW.SelfQueue,i,2, 1);
				FW:SET(FW.SelfQueue,i,4, GetTime() + FW.Settings.Delay);
				
			-- put weird exceptions below!
			elseif t1 == FW.L.RITUAL_OF_SUMMONING.." (C)" then
				FW:SET(FW.SelfQueue,i,2, 1);
				FW:SET(FW.SelfQueue,i,4, GetTime() + 1); -- 1 sec delay on checking if shard is used
			else
				CA_SelfSucces(0,i); -- ignore possible resists
			end
			break;
		else
			i=i+1;
		end
	end
end

--[[function FW:SelfChannelUpdate(remain)
	FW:ShowDebug("Channelling Update "..remain);
end]]

local function CA_SelfChannelEnd()
	--FW:ShowDebug("Channelling End");
	-- problem: when you start casting a new spell while still channeling a spell, channel end may fire after the new spell sent event, making it 'complete' the new cast instantly
	-- solution: a spell already channeling, will always be queued at slot [1], so if this isnt a channeling spell ignore this event!
	if FW:ROWS(FW.SelfQueue) > 0 and string.find(FW:GET(FW.SelfQueue,1,1)," %(C%)$") then CA_SelfEnd();end
end

local function CA_SelfSent(spell,rank,target)
	
	--FW:ShowDebug("Spell Sent");
	LastCast = GetTime();
	CA_SelfChannelEnd();
	if not target or target == "" then if UnitExists("target") then target = UnitName("target");else target=FW.L.NOTARGET; end end
	local i = FW:ROWS(FW.SelfQueue);
	while i>0 do
		if FW:GET(FW.SelfQueue,i,2) == 0 and  FW:GET(FW.SelfQueue,i,3) == 0 then -- replace 'garbage sent events'
			FW:REMOVE(FW.SelfQueue,i);
		end
		i=i-1;
	end
	
	local u,t,f,id,r = FW:CastTargetInfo(target)
	local dura = 0;
	rank = tonumber(select(3,string.find(rank,FW.L.SPELL_RANK)) or 1);

	-- duration adjustments
	if FW.Track[spell] then
		dura = FW.Track[spell][2];
		-- change based on rank
		if FW.Track[spell]["r"] and FW.Track[spell]["r"][rank] then
			dura = dura + FW.Track[spell]["r"][rank];
		end
		-- change based on talents
		if FW.Track[spell]["t"] then
			for k, v in pairs(FW.Track[spell]["t"]) do
				if v[FW.Talent[k]] then
					dura = dura + v[FW.Talent[k]];
				end
			end
		end
		-- change based on setbonus
		if FW.Track[spell]["s"] then
			for k, v in pairs(FW.Track[spell]["s"]) do
				for n, a in pairs(v) do
					if FW.SetBonus[k] >= n then
						dura = dura + a;
					end
				end
			end
		end
		-- set max duration in pvp
		if u == 2 and FW.Track[spell][5] ~= 0 and dura>FW.Track[spell][5] then dura=FW.Track[spell][5] end 
	end
	FW:INSERT(FW.SelfQueue, spell,0,0,0,target,dura,rank,u,t,f,id,r);
end

------------------------------------------------------------------------------------------------------------------
-- Simplyfied casting functions for raid/party members
------------------------------------------------------------------------------------------------------------------
local function CA_OtherStart(player)
	local spellName, _, _, _, startTime, endTime = UnitCastingInfo(player);
	local unitName = UnitName(player);
	local targetName = UnitName(player.."target") or "";
	FW:SETKEY(OtherQueue,unitName, spellName,targetName,startTime,endTime,0);
	if spellName == FW.L.SOULSTONE_RESURRECTION then
		FW:CastStartMessage(unitName);
	elseif spellName == FW.L.RITUAL_OF_SUMMONING then
		if targetName ~= "" then FW:SummonStartMessage(unitName,targetName);end
	end
end

local function CA_OtherDelay(player)
	local spellName, _, _, _, startTime, endTime = UnitCastingInfo(player);
	local unitName = UnitName(player);
	local index = FW:FIND(OtherQueue,unitName);
	if index and OtherQueue[index+1] == spellName then
		if spellName == FW.L.SOULSTONE_RESURRECTION then
			FW:CastDelayMessage(unitName,endTime - OtherQueue[index+4]);	
		end	
		OtherQueue[index+3] = startTime;
		OtherQueue[index+4] = endTime;

	else	
		local targetName = UnitName(player.."target") or "";
		FW:SETKEY(OtherQueue,unitName, spellName,targetName,startTime,endTime,0);
	end
end

local function CA_OtherCancel(player)
	local unitName = UnitName(player)
	local index = FW:FIND(OtherQueue,unitName);
	if index then
		if OtherQueue[index+1] == FW.L.SOULSTONE_RESURRECTION then
			FW.CastCancelMessage(unitName);
		elseif OtherQueue[index+1] == FW.L.RITUAL_OF_SUMMONING then
			if OtherQueue[index+2] ~= "" then FW:SummonCancelMessage(unitName,OtherQueue[index+2]);end
		end
		FW:REMOVE_INDEX(OtherQueue,index);
	end
end

local function CA_OtherStop(player)
	local unitName = UnitName(player);
	local index = FW:FIND(OtherQueue,unitName);
	if index and OtherQueue[index+5] ~= 1 then -- dont remove marked as channeling, cos channel end fires after this event
		if OtherQueue[index+1] == FW.L.RITUAL_OF_SUMMONING and OtherQueue[index+2] ~= "" then
			FW:SummonCancelMessage(unitName,OtherQueue[index+2]);
		end
		FW:REMOVE_INDEX(OtherQueue,index);
	end
	--FW:ShowDebug("other stop");
end

local function CA_OtherChannelStart(player)
	local unitName = UnitName(player);
	local spellName, _, _, _, startTime, endTime = UnitChannelInfo(player);
	local index = FW:FIND(OtherQueue,unitName);
	if index and OtherQueue[index+1] == spellName then
		OtherQueue[index+3] = startTime;
		OtherQueue[index+4] = endTime;
		OtherQueue[index+5] = 1;
	else	
		local targetName = UnitName(player.."target") or "";
		FW:SETKEY(OtherQueue,unitName, spellName,targetName,startTime,endTime,1);
		
		if targetName ~= "" and (spellName == FW.L.RITUAL_OF_SUMMONING or spellName == FW.L.MEETING_STONE_SUMMON) then
			FW:SummonStartMessage(unitName,targetName)
		end
	end
end

local function CA_OtherChannelEnd(player)
	local unitName = UnitName(player);
	local index = FW:FIND(OtherQueue,unitName);
	if index then
		if (OtherQueue[index+1] == FW.L.RITUAL_OF_SUMMONING or OtherQueue[index+1] == FW.L.MEETING_STONE_SUMMON) and OtherQueue[index+2] ~= ""  and OtherQueue[index+5] == 1 then
			FW:SummonEndMessage(unitName,OtherQueue[index+2]);
		end
		FW:REMOVE_INDEX(OtherQueue,index);
	end
	--FW:ShowDebug("other channel stop");
end


local function CA_TimedSpellSuccess()
	local i=1;
	local time = GetTime();
	while i <= FW:ROWS(FW.SelfQueue) do
		_,t2,_,t4 = FW:GET(FW.SelfQueue,i);
		if t4 > 0 and t4 < time then
			if t2 == 1 then
				CA_SelfSucces(time-t4+FW.Settings.Delay,i); 
			elseif t2 == -1 then
				 FW:SET(FW.SelfQueue,i,2, 0);
				 FW:SET(FW.SelfQueue,i,4, 0);
				 
				 FW:ShowDebug("ignoring this cancel");
				 i=i+1;
			end
		else
			i=i+1;
		end
		
	end
end

local function CA_TimedClearCastBuffer()
	if UnitCastingInfo("player") or UnitChannelInfo("player") then -- if not casting or channelling for 2 sec, remove everything from cast queue to avoid bugs
		LastCast = GetTime();
	elseif LastCast ~= 0 and GetTime() - LastCast >= 3 then
		FW:ShowDebug("CLEARING BUFFER "..FW:ROWS(FW.SelfQueue));
		
		FW:ERASE(FW.SelfQueue);
		
		LastCast = 0;
	end
end

local function CA_OtherCasts()
	if arg1 ~= "target" and not UnitIsUnit(arg1,"player") and
	(FW:IsWarlock(arg1) or FW.Settings.SummonMeetingStone) and
	(string.find(arg1,"^raid") or (GetNumRaidMembers() == 0 and 
	string.find(arg1,"^party"))) then
		return true;
	else
		return false;
	end
end

---------------------------------------------------------------------------
-- globally accessable
---------------------------------------------------------------------------

-- used for messaging mostly
function FW:RegisterOnSelfCastSuccess(func)
	tinsert(FW_OnSelfCastSuccess,func);
end

function FW:RegisterOnSelfCastStart(func)
	tinsert(FW_OnSelfCastStart,func);
end

function FW:RegisterOnSelfCastCancel(func)
	tinsert(FW_OnSelfCastCancel,func);
end

-- raid casting functions used by any player/class, currently for detecting who's casting summons and soulstones
function FW:SummonEndMessage(player,target)
	FW:SendMergedData(FW.SU_CAST_END..player.." "..target);
end

function FW:SummonCancelMessage(player,target)
	FW:SendMergedData(FW.SU_CAST_CANCEL..player.." "..target);
end

function FW:SummonStartMessage(player,target)
	FW:SendMergedData(FW.SU_CAST_START..player.." "..target);
end

function FW:CastStartMessage(player)
	FW:SendMergedData(FW.SS_CAST_START..player);
end

function FW:CastDelayMessage(player,delay)
	FW:SendMergedData(FW.SS_CAST_DELAY..player..delay);
end

function FW:CastCancelMessage(player)
	FW:SendMergedData(FW.SS_CAST_CANCEL..player);
end
---------------------------------------------------------------------------

function FW:CastTargetInfo(target)
	t1 = CA_CastOn(target);-- 3=both target and focus, 2=target, 1=focus, 0=unknown
	if t1 == 3 then
		return CA_Unique("focus"),1,1,FW:GiveID(1,1),GetRaidTargetIndex("focus") or 0;
	elseif t1 == 2 then
		return CA_Unique("focus"),0,1,FW:GiveID(0,1),GetRaidTargetIndex("focus") or 0;
	elseif t1 == 1 then
		return CA_Unique("target"),1,0,FW:GiveID(1,0),GetRaidTargetIndex("target") or 0;
	else
		return 0,0,0,-1,0; -- uncertain about target, will use debuff check on focus and target
end
	end

function FW:CastShow(key,target)
	if FW.Settings[key]==1 or FW.Settings[key]==3 then FW:ToGroup(string.format(FW.Settings[(key.."Msg")],target)); end
	if FW.Settings[key]>=2 then FW:ToChannel(string.format(FW.Settings[(key.."Msg")],target)); end
	if FW.Settings[key.."Whisper"] and target~=FW.PLAYER then FW:Whisper( FW.Settings[(key.."WhisperMsg")],target); end
end

FW:RegisterToEvent("UNIT_SPELLCAST_INTERRUPTED",
function()
	if arg1 == "player" then
		CA_SelfCancel();
	end

end);
FW:RegisterToEvent("UNIT_SPELLCAST_FAILED",
function()
	if arg1 == "player" then
		CA_SelfCancel();
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_DELAYED",
function() 
	if arg1 == "player" then
		CA_SelfDelay();
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_STOP",
function()
	if arg1 == "player" then
		CA_SelfStop();
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_SENT",
function()
	if arg1 == "player" then
		CA_SelfSent(arg2,arg3,arg4);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_START",		
function() 
	if arg1 == "player" then 
		CA_SelfStart();
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_SUCCEEDED",
function()
	if arg1 == "player" then
		CA_SelfEnd(arg2);
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_START",
function()
	if arg1 == "player" then
		CA_SelfChannelStart();
	end
end);
FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_STOP",
function()
	if arg1 == "player" then
		CA_SelfChannelEnd();
	end
end);

function FW:RegisterOtherCasts()
	FW:RegisterToEvent("UNIT_SPELLCAST_INTERRUPTED",
	function()
		if CA_OtherCasts() then
			CA_OtherCancel(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_FAILED",
	function()
		if CA_OtherCasts() then
			CA_OtherCancel(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_DELAYED",
	function() 
		if CA_OtherCasts() then
			CA_OtherDelay(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_STOP",
	function() 
		if CA_OtherCasts() then
			CA_OtherStop(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_START",		
	function() 
		if CA_OtherCasts() then
			CA_OtherStart(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_START",
	function()
		if CA_OtherCasts() then
			CA_OtherChannelStart(arg1);
		end
	end);
	FW:RegisterToEvent("UNIT_SPELLCAST_CHANNEL_STOP",
	function()
		if CA_OtherCasts() then
			CA_OtherChannelEnd(arg1);
		end
	end);
end

FW:RegisterToEvent("CHAT_MSG_SPELL_SELF_DAMAGE", CA_SelfResist);
FW:RegisterToEvent("PLAYER_LEAVING_WORLD",	function() FW:ERASE(FW.SelfQueue);end);
FW:RegisterToEvent("PLAYER_DEAD",		function() FW:ERASE(FW.SelfQueue);end);

FW:RegisterUpdatedEvent(CA_TimedSpellSuccess);

FW:RegisterVariablesEvent(function()
	FW:RegisterTimedEvent("UpdateInterval",		CA_TimedClearCastBuffer);
end);

FW:SetMainCategory(FW.L.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FW.L.CASTING,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_MAX_FAIL,		"","Delay");
		FW:RegisterOption(FW.NUM,1,FW.NON,FW.L.DELAY_MAX_FASTCAST,	"","CancelDelay");

FW.Default.Delay = 0.1; -- maximum delay between cast success event and evade/resist/immune event (seems to be system lag only)
FW.Default.CancelDelay = 0.5 -- maximum delay between a possible fastcast macro generated fail and the actual success (server lag)

FW.Default.MeetingStoneSummon = 0;		FW.Default.MeetingStoneSummonMsg = "Summoning >> %s << Clicky clicky!"