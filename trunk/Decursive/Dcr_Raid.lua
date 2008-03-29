--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2007 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_Events.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_Events.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D = Dcr;
D:SetDateAndRevision("$Date: 2008-03-15 20:56:53 -0400 (Sat, 15 Mar 2008) $", "$Revision: 64659 $");


local L	    = D.L;
local BC    = D.BC;
local BS    = D.BS;
local DC    = DcrC;

local RaidRosterCache		= { };
local SortingTable		= { };
D.Status.Unit_ArrayByName	= { };
D.Status.Unit_Array_UnitToName	= { };
D.Status.Unit_Array_NameToUnit	= { };

D.Status.InternalPrioList	= { };
D.Status.InternalSkipList	= { };
D.Status.Unit_Array		= { };

local pairs		= _G.pairs;
local ipairs		= _G.ipairs;
local type		= _G.type;
local GetNumRaidMembers		= _G.GetNumRaidMembers;
local GetNumPartyMembers	= _G.GetNumPartyMembers;
local UnitName	= _G.UnitName;
local random	= _G.random;
local UnitIsUnit	= _G.UnitIsUnit;
local GetRaidRosterInfo	= _G.GetRaidRosterInfo;
local UnitClass	= _G.UnitClass;
local UnitExists	= _G.UnitExists;
local table	= _G.table;

-------------------------------------------------------------------------------
-- GROUP STATUS UPDATE, these functions update the UNIT table to scan {{{
-------------------------------------------------------------------------------


local function AddToSort (unit, index) -- // {{{
    if (D.profile.Random_Order and
	(not D.Status.InternalPrioList[(UnitName(unit))]) and not UnitIsUnit(unit,"player")) then
	index = random (1, 3000);
    end
    SortingTable[unit] = index;
    --D:Debug("Adding to sort: ", unit, index);
end --}}}

-- Raid/Party Name Check Function (a terrible function, need optimising)
-- this returns the UnitID that the Name points to
-- this does not check "target" or "mouseover"
function D:NameToUnit( Name ) --{{{

    local numRaidMembers = GetNumRaidMembers();
    local FoundUnit = false;

    if (not Name) then
	return false;
    end

    if D.Status.Unit_Array_NameToUnit[Name] ~= nil then
	--D:Debug("%s was found in cachetable to be %s", Name, D.Status.Unit_Array_NameToUnit[Name]);
	return D.Status.Unit_Array_NameToUnit[Name];
    end

    if (numRaidMembers == 0) then
	if (Name == (UnitName("player"))) then
	    FoundUnit =  "player";
	elseif (Name == (UnitName("focus"))) then
	    return  "focus"; -- we won't store this value
	elseif (Name == (UnitName("pet"))) then
	    FoundUnit =  "pet";
	elseif GetNumPartyMembers() > 0 then
	    if (Name == (UnitName("party1"))) then
		FoundUnit =  "party1";
	    elseif (Name == (UnitName("party2"))) then
		FoundUnit =  "party2";
	    elseif (Name == (UnitName("party3"))) then
		FoundUnit =  "party3";
	    elseif (Name == (UnitName("party4"))) then
		FoundUnit =  "party4";
	    elseif (Name == (UnitName("partypet1"))) then
		FoundUnit =  "partypet1";
	    elseif (Name == (UnitName("partypet2"))) then
		FoundUnit =  "partypet2";
	    elseif (Name == (UnitName("partypet3"))) then
		FoundUnit =  "partypet3";
	    elseif (Name == (UnitName("partypet4"))) then
		FoundUnit =  "partypet4";
	    end
	end
    else
	-- we are in a raid
	local i;
	local RaidName;
	for i=1, numRaidMembers do
	    RaidName = GetRaidRosterInfo(i);
	    if ( Name == RaidName) then
		FoundUnit =  "raid"..i;
	    end
	    if ( self.profile.Scan_Pets and Name == (UnitName("raidpet"..i))) then
		FoundUnit =  "raidpet"..i;
	    end
	end
    end

    D.Status.Unit_Array_NameToUnit[Name] = FoundUnit;

    return FoundUnit;

end --}}}
-- }}}



DC.ClassNumToName = {
    [11]	= BC[D.LOC.CLASS_DRUID],
    [12]	= BC[D.LOC.CLASS_HUNTER],
    [13]	= BC[D.LOC.CLASS_MAGE],
    [14]	= BC[D.LOC.CLASS_PALADIN],
    [15]	= BC[D.LOC.CLASS_PRIEST],
    [16]	= BC[D.LOC.CLASS_ROGUE],
    [17]	= BC[D.LOC.CLASS_SHAMAN],
    [18]	= BC[D.LOC.CLASS_WARLOCK],
    [19]	= BC[D.LOC.CLASS_WARRIOR],
}

DC.ClassNameToNum = D:tReverse(DC.ClassNumToName);


-- this gets an array of units for us to check

do

    local D = D;

    function IsInSkipList ( name, group, classNum ) -- {{{
	if (D.Status.InternalSkipList[name] or D.Status.InternalSkipList[group] or D.Status.InternalSkipList[classNum]) then
	    return true;
	end

	return false;
    end -- }}}

    function IsInSkipOrPriorList( name, group, classNum )  --{{{

	if (IsInSkipList ( name, group, classNum )) then
	    return true;
	end

	if (D.Status.InternalPrioList[name] or D.Status.InternalPrioList[group] or D.Status.InternalPrioList[classNum]) then
	    return true;
	end

	return false;
    end --}}}


    local ClassPrio = { };
    local GroupsPrio = { };

    local currentGroup = 0; -- the group we are in

    function GetUnitDefaultPriority (RaidId, UnitGroup) -- {{{

	if (not UnitGroup) then
	    return RaidId;
	end

	if (UnitGroup >= currentGroup) then
	    return ( 8 - ( UnitGroup - currentGroup ) ) * 100 + (41 - RaidId);
	end

	if (UnitGroup < currentGroup) then
	    return (currentGroup - UnitGroup) * 100 + (41 - RaidId);
	end
    end -- }}}

    function GetUnitPriority(Unit, RaidId, UnitGroup, LocalizedClass, IsPet) -- {{{

	-- A little explanation of the principle behind this function {{{
	--[=[ ****************************************************************************
	  levels of priority:

	  0 --> PriorityList
	  1 --> Group
	  2 --> Class
	  3 --> Default (Decursive "natural" order: our group, groups after, groups before)
	  4 --> Pets

	  - 8 groups with 5 persons maximum per group
	  - 9 classes with 80 persons max for each class (Pets may be counted)
	  - 80 persons for default (including possible pets)

	  Priority list:    1,000,000 till 100,000,000
	  Group indexes:    10,000, 20,000, 30,000, till 80,000
	  class indexes:    1,000, 2,000, 3,000, till 9,000
	  default indexes:  100 to 800 (palyer's index will be 900)
	  pet indexes:	    Same as above but * -1

	  We make additions, exemple:
	    - Our current group is the group 7
	    - The resulting default groups priorities are:
		7:800 8: 700, 1:600, 2: 500, 3: 400, 4: 300, 5: 200, 6:100
	    - Archarodim, Mage from Group 5 (23rd unit of the raid)
	    - Unit Archarodim priority is 223
	    - Class Mage priority is 4000
	    - Group 5 priority is 20000

	    --> Archarodim priority is 200 + 23 + 4000 + 20000 = 24223
	**************************************************************************** }}} ]=]

	-- Get Decursive's natural default priority of the unit
	local UnitPriority = GetUnitDefaultPriority(RaidId, UnitGroup);

	-- Get the class priority if available
	if ( LocalizedClass and ClassPrio[ DC.ClassNameToNum [LocalizedClass] ] ) then
	    UnitPriority = UnitPriority + ( 9 + 1 - ClassPrio[DC.ClassNameToNum [LocalizedClass]]) * 1000;
	end

	-- Get the group priority if available
	if (UnitGroup and GroupsPrio[UnitGroup]) then
	    UnitPriority = UnitPriority + (8 + 1 - GroupsPrio[UnitGroup]) * 10000;
	end

	-- Get the priority list index if available
	if not IsPet then
	    local Unit_Name = (UnitName(Unit));

	    local PrioListIndex = 100;

	    -- get the higher of the three...
	    if (D.Status.InternalPrioList[Unit_Name] and D.Status.InternalPrioList[Unit_Name] < PrioListIndex) then
		PrioListIndex = D.Status.InternalPrioList[Unit_Name];
	    end

	    if (D.Status.InternalPrioList[UnitGroup] and D.Status.InternalPrioList[UnitGroup] < PrioListIndex) then
		PrioListIndex = D.Status.InternalPrioList[UnitGroup];
	    end

	    if (D.Status.InternalPrioList[ DC.ClassNameToNum [LocalizedClass] ] and D.Status.InternalPrioList[ DC.ClassNameToNum [LocalizedClass] ] < PrioListIndex) then
		PrioListIndex = D.Status.InternalPrioList[ DC.ClassNameToNum [LocalizedClass] ];
	    end


	    if ( PrioListIndex < 100) then
		UnitPriority = UnitPriority + (100 + 1 - PrioListIndex) * 1000000;
	    end
	end

	if IsPet then
	    UnitPriority = UnitPriority * -1;
	end

	return UnitPriority;
    end -- }}}



    function D:GetUnitArray() --{{{

	-- if the groups composition did not changed
	if (not self.Groups_datas_are_invalid) then
	    return;
	end

	self:Debug ("|cFFFF44FF-->|r Updating Units Array");

	local pname;
	local raidnum = GetNumRaidMembers();
	local MyName = (UnitName( "player"));
	local MyClassNum = DC.ClassNameToNum[(UnitClass("player"))];


	-- clear all the arrays
	self.Status.InternalPrioList	    = {};
	self.Status.InternalSkipList	    = {};
	SortingTable			    = {};
	self.Status.Unit_ArrayByName	    = {};
	D.Status.Unit_Array_NameToUnit	    = {};
	local RaidRosterCache		    = {};

	local unit;


	-- ############### PARSE PRIO AND SKIP LIST ###############

	ClassPrio = { };
	GroupsPrio = { };

	-- First clean and load the prioritylist (remove missing units)
	for i, ListEntry in ipairs(self.profile.PriorityList) do

	    -- first add names present in our raid group
	    if (type(ListEntry) == "string") then
		unit = self:NameToUnit( ListEntry );
		if (unit) then
		    self.Status.InternalPrioList[ListEntry] = i;
		end

	    else -- if ListEntry is a not a string, then it's a number
		 -- representing the groups or the classes

		self.Status.InternalPrioList[ListEntry] = i;

		if (ListEntry < 10) then
		    table.insert(GroupsPrio, ListEntry);
		else
		    table.insert(ClassPrio, ListEntry);
		end
	    end
	end

	-- Reverse GroupsPrio and ClassPrio so we can have something useful...
	GroupsPrio = self:tReverse(GroupsPrio);
	ClassPrio  = self:tReverse(ClassPrio);

	-- Get a cleaned skip list
	for i, ListEntry in ipairs(self.profile.SkipList) do
	    if (type(ListEntry) == "string") then
		unit = self:NameToUnit( ListEntry );
		if (unit) then
		    self.Status.InternalSkipList[ListEntry] = i;
		end
	    else
		self.Status.InternalSkipList[ListEntry] = i;
	    end
	end


	-- if we are not in a raid but in a party
	if (raidnum == 0) then
	    currentGroup = 1;
	    -- Add the player to the main list if needed
	    if (not IsInSkipOrPriorList(MyName, false, MyClassNum)) then
		-- the player is not in a priority state, add to default prio
		AddToSort( "player", 900);
		self.Status.Unit_ArrayByName[MyName] = "player";
	    elseif (not IsInSkipList(MyName, false, MyClassNum)) then
		-- The player is contained within a priority rule
		AddToSort("player",  GetUnitPriority ("player", 1, 1, (UnitClass("player")) ) );
		self.Status.Unit_ArrayByName[MyName] = "player";
	    end

	    local unit = "";

	    -- add the party members... if they exist
	    for i = 1, 4 do
		unit = "party"..i;

		if (UnitExists(unit)) then

		    pname = (UnitName(unit));

		    if (not pname) then -- at logon sometimes pname is nil...
			pname = unit;
		    end

		    -- check the name to see if we skip
		    if (not IsInSkipList(pname, nil, DC.ClassNameToNum[(UnitClass(unit))])) then

			self.Status.Unit_ArrayByName[pname] = unit;

			AddToSort(unit,  GetUnitPriority (unit, i + 1, 1, (UnitClass(unit)) ) );

		    end
		end
	    end
	end

	if ( raidnum > 0 ) then -- if we are in a raid
	    currentGroup = 0;
	    local rName, rGroup;
	    local CaheID = 1; -- make an ordered table

	    -- Cache the raid roster info eliminating useless info and already listed members
	    for i = 1, raidnum do
		rName, _, rGroup, _, rClass = GetRaidRosterInfo(i);

		-- find our group (a whole iteration is required, raid info are not ordered)
		if ( currentGroup==0 and rName == MyName) then
		    currentGroup = rGroup;
		end

		-- add all except member to skip
		if (not IsInSkipList(rName, rGroup, DC.ClassNameToNum[rClass]) ) then

		    if (not RaidRosterCache[CaheID]) then
			RaidRosterCache[CaheID] = {};
		    end

		    if (not rName) then -- at logon sometimes rName is nil...
			rName = rGroup.."unknown"..i;
		    end
		    RaidRosterCache[CaheID].rName    = rName;
		    RaidRosterCache[CaheID].rGroup   = rGroup;
		    RaidRosterCache[CaheID].rClass   = rClass;
		    RaidRosterCache[CaheID].rIndex   = i;
		    CaheID = CaheID + 1;
		end

	    end

	    -- Add the player to the main list if needed
	    if (not IsInSkipOrPriorList(MyName, currentGroup, MyClassNum)) then
		local PlayerRID = self:NameToUnit(MyName);
		AddToSort( PlayerRID, 900);
		self.Status.Unit_ArrayByName[MyName] = PlayerRID;
	    end

	    -- Now we have a cache without the units we want to skip
	    for _, raidMember in ipairs(RaidRosterCache) do
		-- put each raid member with the right priority in our sorting table
		if not self.Status.Unit_ArrayByName[raidMember.rName] then
		    AddToSort("raid"..raidMember.rIndex, GetUnitPriority ("raid"..raidMember.rIndex, raidMember.rIndex, raidMember.rGroup, raidMember.rClass, false) );
		    self.Status.Unit_ArrayByName[raidMember.rName] = "raid"..raidMember.rIndex;
		end

	    end

	end -- END if we are in a raid

	-- If we have to scan pets...
	if ( self.profile.Scan_Pets ) then
	    local pet = "";

	    -- add our own pet
	    if (UnitExists("pet")) then
		AddToSort("pet", -900);
		self.Status.Unit_ArrayByName[(D:PetUnitName("pet"))] = "pet";
	    end

	    -- the parties pets if they have them
	    if (raidnum == 0) then
		for i = 1, 4 do
		    pet = "partypet"..i;

		    if (UnitExists(pet)) then
			pname = (D:PetUnitName(pet));

			if (not pname) then -- at logon sometimes pname is nil...
			    pname = pet;
			end

			AddToSort(pet, GetUnitPriority (pet, i, 1, (UnitClass(pet)), true) );

			self.Status.Unit_ArrayByName[pname] = pet;
		    end
		end
	    end

	    -- and then the raid pets if they are out
	    if (raidnum > 0) then
		for i = 1, raidnum do

		    pet = "raidpet"..i;

		    if ( UnitExists(pet) ) then

			pname = (D:PetUnitName(pet));

			if (not pname) then -- at logon sometimes pname is nil...
			    pname = pet;
			end

			-- add it only if not already in (could be the player pet...)
			if (not self.Status.Unit_ArrayByName[pname]) then


			    AddToSort(pet, GetUnitPriority (pet, i, RaidRosterCache[i].rGroup, (UnitClass(pet)), true) );
			    self.Status.Unit_ArrayByName[pname] = pet;

			end
		    end
		end
	    end
	end

	-- we use a hash-key style table for self.Status.Unit_ArrayByName because it allows us
	-- to not care if we add a same unit several times (speed optimization)
	-- but we cannot use sort unless indexes are integer so:
	self.Status.Unit_Array = {}
	for name, unit in pairs(self.Status.Unit_ArrayByName) do -- /!\ PAIRS not iPAIRS
	    table.insert(self.Status.Unit_Array, unit);
	    self.Status.Unit_Array_UnitToName[unit] = name; -- just a usefull table, not used here :)
	end

	table.sort(self.Status.Unit_Array, function (a,b)
	    if (not (SortingTable[a] < 0 and SortingTable[b] < 0)) then
		return SortingTable[b] < SortingTable[a];
	    else
		return SortingTable[a] < SortingTable[b];
	    end
	end);

	--self.Status.Unit_Array_UnitToIndex = {};
	--self.Status.Unit_Array_UnitToIndex = self:tReverse(self.Status.Unit_Array); -- slow :/


	if UnitExists("focus") and UnitIsFriend("focus", "player") then
	    table.insert(self.Status.Unit_Array, "focus");
	    self.Status.UnitNum = #self.Status.Unit_Array;
	    self.Status.Unit_Array_UnitToName["focus"] = (D:PetUnitName("focus", true));
	    --self.Status.Unit_Array_UnitToIndex["focus"] = self.MicroUnitF:MFUsableNumber();
	end

	self.Status.UnitNum = #self.Status.Unit_Array;

	self.Groups_datas_are_invalid = false;

	return;
    end

end

--}}}

-------------------------------------------------------------------------------
DcrLoadedFiles["Dcr_Raid.lua"] = true;