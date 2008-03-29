-- Elsia: For delete on instance entry
-- Deletes data whenever a new, not the same instance is entered. This should safe-guard against corpse-run-reenters and the like.

function Recount:DetectInstanceChange() -- Elsia: With thanks to Loggerhead

	local zone = GetRealZoneText()

	if zone == nil or zone == "" then
		-- zone hasn't been loaded yet, try again in 5 secs.
		self:ScheduleEvent(self.DetectInstanceChange,5,self)
		--self:Print("Unable to determine zone - retrying in 5 secs")
		return
	end

	local ct = 0; for k,v in pairs(Recount.db.char.combatants) do ct = ct + 1; break; end
	if ct==0 then -- Elsia: Already deleted
		return
	end

	inInstance, instanceType = IsInInstance()
	
	if inInstance and (Recount.db.char.DeleteNewInstanceOnly == false or Recount.db.char.LastInstanceName ~= zone) then
	   
		if Recount.db.char.ConfirmDeleteInstance == true then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
		Recount.db.char.LastInstanceName = zone -- Elsia: We'll set the instance even if the user opted to not delete...
	end
end

function Recount:SetupInstanceCheck()
	if Recount.db.char.AutoDeleteNewInstance == true then
	   	Recount:RegisterEvent("ZONE_CHANGED_NEW_AREA","DetectInstanceChange")
		Recount:DetectInstanceChange()
	else
		Recount:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	end
end

-- Elsia: For delete on join raid/group

function Recount:PartyMembersChanged()

	local ct = 0; for k,v in pairs(Recount.db.char.combatants) do ct = ct + 1; break; end
	if ct==0 then -- Elsia: Already deleted
		return
	end

	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	if Recount.db.char.DeleteJoinRaid == true and Recount.inRaid == false and NumRaidMembers > 0 then
		if Recount.db.char.ConfirmDeleteRaid == true then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
	end

	if Recount.db.char.DeleteJoinGroup == true and Recount.inGroup == false and NumPartyMembers > 0 and NumRaidMembers == 0 then
		if Recount.db.char.ConfirmDeleteGroup == true then
			Recount:ShowReset() -- Elsia: Confirm & Delete!
		else
			Recount:ResetData()		-- Elsia: Delete!
		end
	end
	
	Recount.inGroup = false
	Recount.inRaid = false
	
	if NumRaidMembers == 0 and NumPartyMembers > 0 then
	   Recount.inGroup = true
	end

	if NumRaidMembers > 0 then
	   Recount.inRaid = true
	   -- Recount.db.char.lastinraid = time()  -- Elsia: Not currently using time.
	end
end

function Recount:InitPartyBasedDeletion()
	local NumRaidMembers = GetNumRaidMembers()
	local NumPartyMembers = GetNumPartyMembers()

	Recount.inGroup = false
	Recount.inRaid = false

	if NumPartyMembers > 0 and NumRaidMembers == 0 then Recount.inGroup = true end
	if NumRaidMembers > 0 then Recount.inRaid = true end

	if Recount:IsEventRegistered("PARTY_MEMBERS_CHANGED") == false then
		Recount:RegisterEvent("PARTY_MEMBERS_CHANGED","PartyMembersChanged")
	end
end

function Recount:ReleasePartyBasedDeletion()
	if Recount.db.char.DeleteJoinGroup == false and Recount.db.char.DeleteJoinRaid == false then
		if Recount:IsEventRegistered("PARTY_MEMBERS_CHANGED") then
			Recount:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		end
	end
end
