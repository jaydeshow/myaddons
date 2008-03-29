local s = {}
local _, v

function tdRange_GetColor(id)
	s.Range = IsActionInRange(id) == 0 and true or nil
	s.Usable, s.Mana = IsUsableAction(id);
	s.Usable = not s.Usable
	for _, v in ipairs(tCCDB.Other.Color) do
		if s[v] then
			return tCCDB.Color[v].r, tCCDB.Color[v].g, tCCDB.Color[v].b, v
		end
	end
	return 1.0, 1.0, 1.0, ""
end

function ActionButton_UpdateUsable()
	local r, g, b, index = tdRange_GetColor(ActionButton_GetPagedID(this))
	if not (this.index and this.index == index) then
		this.index = index
		getglobal(this:GetName().."Icon"):SetVertexColor(r, g, b);
	end
end


hooksecurefunc("ActionButton_OnUpdate", function(elapsed)
	if ( this.rangeTimer and this.rangeTimer <= elapsed ) then
		ActionButton_UpdateUsable();
	end
end)
