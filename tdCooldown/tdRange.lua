
function tdRange_GetColor(id)
	local isUsable, notEnoughMana = IsUsableAction(id)
	if notEnoughMana then
		return 0.5, 0.5, 1.0, 1
	elseif not isUsable then
		return 0.4, 0.4, 0.4, 2
	elseif IsActionInRange(id) == 0 then
		return 0.5, 0.1, 0.1, 3
	else
		return 1.0, 1.0, 1.0, 0
	end
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