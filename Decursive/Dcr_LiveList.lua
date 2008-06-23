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

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_DebuffsFrame.xml"] or not DcrLoadedFiles["Dcr_DebuffsFrame.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_DebuffsFrame.xml or Dcr_DebuffsFrame.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D   = Dcr;
D:SetDateAndRevision("$Date: 2008-06-13 20:24:46 -0400 (Fri, 13 Jun 2008) $", "$Revision: 76639 $");

local L	    = D.L;
local BC    = D.BC;
local AceOO = D.AOO;
local DC    = DcrC;
local DS    = DC.DS;

D.LiveList = AceOO.Class();

local LiveList = D.LiveList;
local MicroUnitF = D.MicroUnitF;

LiveList.ExistingPerID	    = {};
LiveList.Number		    = 0;
LiveList.NumberShown	    = 0;
D.ForLLDebuffedUnitsNum   = 0;

-- temporary variables often used in function
local Debuff, Debuffs, IsCharmed, MF, i, Index, RangeStatus;

-- local shortcuts to often called global functions
local _G		= _G;
local pairs		= _G.pairs;
local ipairs		= _G.ipairs;
local next		= _G.next;
local select		= _G.select;
local table		= _G.table;
local UnitExists	= _G.UnitExists;
local IsSpellInRange	= _G.IsSpellInRange;
local UnitClass	= _G.UnitClass;
local UnitIsFriend	= _G.UnitIsFriend;


-- defines what is printed when the object is read as a string
function LiveList:ToString() -- {{{
    return "Decursive Live-List object";
end -- }}}

-- The Factory for LiveList objects
function LiveList:Create() -- {{{

    if self.Number + 1 > D.profile.Amount_Of_Afflicted then
	return false;
    end

    self.Number = self.Number + 1;

    self.ExistingPerID[self.Number] = self:new(DcrLiveList, self.Number);


    return self.ExistingPerID[self.Number];

end -- }}}

function LiveList:DisplayItem (ID, UnitID, Debuff) -- {{{

    --D:Debug("(LiveList) Displaying LVItem %d for UnitID %s", ID, UnitID);
    local LVItem = false;

    if ID > self.Number + 1 then
	return error(("LiveList:DisplayItem: bad argument #1 'ID (= %d)' must be < LiveList.Number + 1 (LiveList.Number = %d)"):format(ID, self.Number),2);
    end

    if not self.ExistingPerID[ID] then
	LVItem=self:Create();
    else
	LVItem = self.ExistingPerID[ID];
    end

    if not LVItem then
	return false;
    end

    if not Debuff then
	Debuff = D.ManagedDebuffUnitCache[UnitID][1];
    end

    LVItem:SetDebuff(UnitID, Debuff, nil);
    --D:Debug("XXXX => Updating ll item %d for %s", ID, UnitID);

    if not LVItem.IsShown then
	D:Debug("(LiveList) Showing LVItem %d", ID);
	LVItem.Frame:Show();
	self.NumberShown = self.NumberShown + 1;
	LVItem.IsShown = true;
    end

end -- }}}

function LiveList:RestAllPosition () -- {{{
    for _, LVitem in ipairs(self.ExistingPerID) do
	LVitem.Frame:ClearAllPoints();
	LVitem.Frame:SetPoint(LVitem:GiveAnchor());
    end
end -- }}}

function LiveList.prototype:GiveAnchor() -- {{{

    local ItemHeight = self.Frame:GetHeight();

    if D.profile.ReverseLiveDisplay then
    end

    if self.ID == 1 then
	if D.profile.ReverseLiveDisplay then
	    return "BOTTOMLEFT", DecursiveMainBar, "BOTTOMLEFT", 5, -1 * (ItemHeight + 1) * D.profile.Amount_Of_Afflicted;
	else
	    return "TOPLEFT", DecursiveMainBar, "BOTTOMLEFT", 5, 0;
	end
    else
	if D.profile.ReverseLiveDisplay then
	    return "BOTTOMLEFT", LiveList.ExistingPerID[self.ID - 1].Frame, "TOPLEFT", 0, 1;
	else
	    return "TOPLEFT", LiveList.ExistingPerID[self.ID - 1].Frame, "BOTTOMLEFT", 0, -1;
	end
    end

end -- }}}


function LiveList.prototype:init(Container,ID) -- {{{
    LiveList.super.prototype.init(self); -- needed
    D:Debug("(LiveList) Initializing LiveList object '%s'", ID);

    --ObjectRelated
    self.ID		    = ID;
    self.IsShown	    = false;
    self.Parent		    = Container;

    --Debuff info
    self.UnitID		    = false;
    self.UnitName	    = false;
    self.PrevUnitName	    = false;
    self.PrevUnitID	    = false;
    self.UnitClass	    = false;
    
    self.Debuff			= {};

    self.PrevDebuffIndex	= false;
    self.PrevDebuffName		= false;
    self.PrevDebuffTypeName	= false;
    self.PrevDebuffApplicaton	= false;
    self.PrevDebuffTexture	= false;

    self.IsCharmed	    = false;
    self.PrevIsCharmed	    = false;

    self.Alpha		    = false;

    -- Create the frame
    self.Frame = CreateFrame ("Button", "DcrLiveListItem"..ID, self.Parent, "DcrLVItemTemplate");

    -- Set some basic properties
    self.Frame:SetFrameStrata("LOW");
    self.Frame:RegisterForClicks("AnyDown");

    -- Set the anchor of this item
    self.Frame:SetPoint(self:GiveAnchor());

    -- create the background
    self.BackGroundTexture = self.Frame:CreateTexture("DcrLiveListItem"..ID.."BackTexture", "BACKGROUND", "DcrLVBackgroundTemplate");

    -- Create the Icon Texture
    self.IconTexture = self.Frame:CreateTexture("DcrLiveListItem"..ID.."Icon", "ARTWORK", "DcrLVIconTemplate");

    -- Create the Debuff application count font string
    self.DebuffAppsFontString = self.Frame:CreateFontString("DcrLiveListItem"..ID.."Count", "OVERLAY", "DcrLLAfflictionCountFont");

    -- Create the character name Fontstring
    self.UnitNameFontString = self.Frame:CreateFontString("DcrLiveListItem"..ID.."UnitName", "OVERLAY", "DcrLLUnitNameFont");
    
    -- Create the unitID Fontstring
    self.UnitIDFontString = self.Frame:CreateFontString("DcrLiveListItem"..ID.."UnitID", "OVERLAY", "DcrLLUnitIDFont");
    --self.UnitIDFontString:SetHeight(3);

    -- Create the debuff type fontstring
    self.DebuffTypeFontString = self.Frame:CreateFontString("DcrLiveListItem"..ID.."Type", "OVERLAY", "DcrLLDebuffTypeFont");

    -- Create the debuff name fontstring
    self.DebuffNameFontString = self.Frame:CreateFontString("DcrLiveListItem"..ID.."Name", "OVERLAY", "DcrLLDebuffNameFont");


    -- a reference to this object
    self.Frame.Object = self;

    self.Frame:Show();

end -- }}}

function LiveList.prototype:SetDebuff(UnitID, Debuff, IsCharmed) -- {{{
    self.UnitID		    = UnitID;
    self.UnitName	    = D:PetUnitName(UnitID, true);
    self.Debuff		    = Debuff;
    self.IsCharmed	    = IsCharmed;

    if D.profile.LiveListAlpha ~= self.Alpha then
	self.Frame:SetAlpha(D.profile.LiveListAlpha);
	self.Alpha = D.profile.LiveListAlpha;
    end

    -- Set the graphical elements to the right values
    -- Icon
    if self.PrevDebuffTexture ~= Debuff.Texture then
	self.IconTexture:SetTexture(Debuff.Texture);
	self.PrevDebuffTexture =  Debuff.Texture;
    end

    -- Applications count
    if self.PrevDebuffApplicaton ~= Debuff.Applications then
	if (Debuff.Applications > 1) then
	    self.DebuffAppsFontString:SetText(Debuff.Applications);
	    self.PrevDebuffApplicaton = Debuff.Applications;
	else
	    self.DebuffAppsFontString:SetText(" ");
	    self.PrevDebuffApplicaton = " ";
	end
    end

    -- Unit Name
    if self.PrevUnitName ~= self.UnitName then
	self.UnitClass = select(2, UnitClass(UnitID));
	self.UnitNameFontString:SetText(self.UnitName);
	if self.UnitClass then
	    self.UnitNameFontString:SetTextColor(unpack(DC.ClassesColors[self.UnitClass]));
	end
	self.PrevUnitName =  self.UnitName;
	D:Debug("(LiveList) Updating %d with %s", self.ID, UnitID);
    end

    -- Unit ID
    if self.PrevUnitID ~= UnitID then
	self.UnitIDFontString:SetText("( "..UnitID.." )");
	self.PrevUnitID = UnitID;
    end

    -- Debuff Type Name
    if self.PrevDebuffTypeName ~= Debuff.TypeName then
	if Debuff.Type then
	    self.DebuffTypeFontString:SetText(D:ColorText(L[Debuff.TypeName], "FF" .. DC.TypeColors[Debuff.Type] ));
	    --self.DebuffTypeFontString:SetTextColor(DC.TypeColors[Debuff.Type]);
	else
	    self.DebuffTypeFontString:SetText("Unknown");
	end
	self.PrevDebuffTypeName = Debuff.TypeName;
    end

    -- Debuff Name
    if self.PrevDebuffName ~= Debuff.Name then
	self.DebuffNameFontString:SetText(Debuff.Name);
	self.PrevDebuffName = Debuff.Name;
    end

end -- }}}


function LiveList:GetDebuff(UnitID) -- {{{
    --  (note that this function is only called for the mouseover and target if the MUFs are active)

    D:Debug("(LiveList) Getting Debuff for ", UnitID);
    if (UnitID == "target" or UnitID == "mouseover") and not UnitIsFriend(UnitID, "player") then
	if D.ManagedDebuffUnitCache[UnitID] and D.ManagedDebuffUnitCache[UnitID][1] and D.ManagedDebuffUnitCache[UnitID][1].Type then
	    D.ManagedDebuffUnitCache[UnitID][1].Type = false; -- clear target/mouseover debuff
	    D.UnitDebuffed["target"] = false;
	end
	D:Debug("(LiveList) GetDebuff() |cFF00DDDDcanceled|r, unit %s is hostile or gone.", UnitID);
	return;
    end

    -- decrease the total debuff number if the MUFs system isn't already doing it and if it's not the mouseover or target unit
    if not D.profile.ShowDebuffsFrame and D.UnitDebuffed[UnitID] and UnitID ~= "mouseover" and UnitID ~= "target" then
	D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum - 1;
    end

    -- Get the unit Debuffs
    if not D.profile.ShowDebuffsFrame or UnitID == "mouseover" or UnitID == "target" then
	Debuffs, IsCharmed = D:UnitCurableDebuffs(UnitID, true);
    else -- The MUFs are active and Unit is not mouseover and is not target
	MF = MicroUnitF.UnitToMUF[UnitID];
	Debuffs = MF.Debuffs;
    end

    if (Debuffs and Debuffs[1] and Debuffs[1].Type) then -- there is a Debuff

	D.UnitDebuffed[UnitID] = true; -- register that this unit is debuffed

	-- increase the total debuff number
	if not D.profile.ShowDebuffsFrame and UnitID ~= "mouseover" and UnitID ~= "target" then

	    D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum + 1;

	end
    else
	D.UnitDebuffed[UnitID] = false; -- unregister this unit
    end
end -- }}}

function LiveList:DelayedGetDebuff(UnitID) -- {{{
    if not D:IsEventScheduled("GetDebuff"..UnitID) then
	D.DebuffUpdateRequest = D.DebuffUpdateRequest + 1;
	D:ScheduleEvent("GetDebuff"..UnitID, self.GetDebuff, (D.profile.ScanTime / 2) * (1 + floor(D.DebuffUpdateRequest / 7.5)), self, UnitID);
    end
end -- }}}

local IndexOffset = 0; -- used when target and/or mouseover are found
local DebuffedUnitsNumber = 0;
function LiveList:Update_Display() -- {{{

    -- Update the unit array
    if (D.Groups_datas_are_invalid) then
	D:GetUnitArray();
    end

    Index = 0;

    if D.profile.ShowDebuffsFrame and D.profile.LV_OnlyInRange then -- The MUFs are here and we test for range
	DebuffedUnitsNumber = MicroUnitF.UnitsDebuffedInRange;
    else -- the MUFs are not here or we don't test for range
	DebuffedUnitsNumber = D.ForLLDebuffedUnitsNum;
    end

    -- Check the units in order of importance:

    -- First the Target
    if D.UnitDebuffed["target"] and UnitExists("target") and UnitIsFriend("player", "target") then
	Index = Index + 1;
	self:DisplayItem(Index, "target");
	if not D.Status.SoundPlayed then
	    D:PlaySound ("target");
	end
    end

    -- Then the MouseOver
    if not D.Status.MouseOveringMUF and D.UnitDebuffed["mouseover"] and UnitExists("mouseover") and UnitIsFriend("player", "mouseover") then
	Index = Index + 1;
	self:DisplayItem(Index, "mouseover");
	if not D.Status.SoundPlayed then
	    D:PlaySound ("mouseover");
	end
    end
    IndexOffset = Index;

    -- Then continue with all the remaining units if at least one of them is debuffed
    -- We need this loop because:
    --	    1, we have to show an ordered list (always true)
    --	    2, we want to test if the unit is in spell range (only if the option is active and the MUFs hidden)
    --	    There is no event to do the last and a not simple table.sort() would be needed for the first...
    if DebuffedUnitsNumber > 0 and Index < D.profile.Amount_Of_Afflicted then
	for _, UnitID in ipairs(D.Status.Unit_Array) do
	    -- if the unit is debuffed and still exists and is not stealthed check this only if the MUFs engine is not there, redudent tests otherwise...
	    if D.UnitDebuffed[UnitID] and UnitExists(UnitID) and not (not D.profile.ShowDebuffsFrame and D.profile.Ingore_Stealthed and D.Stealthed_Units[UnitID]) then

		-- we don't care about range
		if not D.profile.LV_OnlyInRange then
		    Index = Index + 1;
		    self:DisplayItem(Index, UnitID);

		    -- play the sound if not already done
		    if not D.Status.SoundPlayed then
			D:PlaySound (UnitID);
		    end

		else -- we care about range

		    if D.profile.ShowDebuffsFrame then
			RangeStatus = MicroUnitF.UnitToMUF[UnitID].UnitStatus;
			RangeStatus = (RangeStatus == DC.AFFLICTED or RangeStatus == DC.AFFLICTED_AND_CHARMED) and true or false;
		    else
			RangeStatus = IsSpellInRange(D.Status.CuringSpells[D.ManagedDebuffUnitCache[UnitID][1].Type], UnitID);
			RangeStatus = (RangeStatus and RangeStatus ~= 0) and true or false;
		    end

		    if (RangeStatus) then
			Index = Index + 1;
			self:DisplayItem(Index, UnitID);
			-- play the sound if not already done
			if not D.Status.SoundPlayed then
			    D:PlaySound (UnitID);
			end
		    end
		end
	    end

	    -- don't loop if we reach the max displayed unit num or if all debuffed units have been displayed
	    if Index == D.profile.Amount_Of_Afflicted or Index == DebuffedUnitsNumber + IndexOffset then
		break;
	    end
	end
    end

    -- reset the sound if no units were displayed
    if Index == 0 and D.Status.SoundPlayed then
	Dcr:Debug("No more unit displayed, sound re-enabled");
	D.Status.SoundPlayed = false; -- re-enable the sound if no more debuff
    end

    -- Hide unneeded Items
    if self.NumberShown > Index then -- if there are more unit shown than the actual number of debuffed units
	for i = Index + 1, self.NumberShown do
	    if self.ExistingPerID[i] and self.ExistingPerID[i].IsShown then
		D:Debug("(LiveList) Hidding LVItem %d", i);
		self.ExistingPerID[i].Frame:Hide();
		self.ExistingPerID[i].IsShown = false;
		self.NumberShown = self.NumberShown - 1;
	    else
		break;
	    end
	end
    end


end -- }}}



function LiveList:DisplayTestItem() -- {{{
    if not self.TestItemDisplayed then
	self.TestItemDisplayed = true;
	D:SpecialEvents_UnitDebuffLost(D:NameToUnit((UnitName("player"))), "Test item");
    end
end -- }}}

function LiveList:HideTestItem() -- {{{
     self.TestItemDisplayed = false;
     local i = 1;

     for UnitID, Debuffed in pairs(D.UnitDebuffed) do
	 if Debuffed then
	     D:ScheduleEvent("rmt"..i, D.SpecialEvents_UnitDebuffLost, i * (D.profile.ScanTime / 2), D, UnitID, "Test item");
	     i = i + 1;
	 end
     end

end -- }}}


-- this displays the tooltips of the live-list
function LiveList:DebuffTemplate_OnEnter() --{{{
    if (D.profile.AfflictionTooltips and this.Object.UnitID) then
	DcrDisplay_Tooltip:SetOwner(this, "ANCHOR_CURSOR");
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetUnitDebuff(this.Object.UnitID,this.Object.Debuff.index); -- OK
	DcrDisplay_Tooltip:Show();
    end
end --}}}

function LiveList:Onclick() -- {{{
    D:Println(L[D.LOC.HLP_LL_ONCLICK_TEXT]);
end -- }}}

DcrLoadedFiles["Dcr_LiveList.lua"] = true;