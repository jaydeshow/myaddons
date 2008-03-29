

-- TrinityBars
if IsAddOnLoaded("TrinityBars") then
	TCCBUTTONTYPE = {
		{key = 1, value = "^SpellButton",            type = "Spell" },
		{key = 1, value = "^TrinityActionButton",    type = "Action"},
		{key = 1, value = "^TrinityShapeshiftButton",type = "Action"},
		{key = 1, value = "^TrinityPetButton",       type = "Pet"   },
		{key = 2, value = "AutoCastable",            type = "Pet"   },
		{key = 2, value = "HotKey",                  type = "Action"},
		{key = 2, value = "Stock",                   type = "Item"  },
	}

	tdOld_Trinity_UpdateActionbar_OnEvent = Trinity_UpdateActionbar_OnEvent
	function Trinity_UpdateActionbar_OnEvent(button)
		local start, duration, enable = GetActionCooldown(this:GetID());
		if getglobal(this:GetName().."IconFrameCooldown") then
			CooldownFrame_SetTimer(getglobal(this:GetName().."IconFrameCooldown"), start, duration, enable);
		end
		tdOld_Trinity_UpdateActionbar_OnEvent(button)
	end

	tdOld_Trinity_UpdatePetActionbar_OnEvent = Trinity_UpdatePetActionbar_OnEvent
	function Trinity_UpdatePetActionbar_OnEvent(button)
		local start, duration, enable = GetPetActionCooldown(this:GetID());
		if getglobal(this:GetName().."IconFrameCooldown") then
			CooldownFrame_SetTimer(getglobal(this:GetName().."IconFrameCooldown"), start, duration, enable);
		end
		tdOld_Trinity_UpdatePetActionbar_OnEvent(button)
	end
end