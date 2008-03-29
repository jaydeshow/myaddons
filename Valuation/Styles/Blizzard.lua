
local tmp_tt = { };

Valuation["styles"]["blizzard"] = {
	["Load"] = function ()
		hooksecurefunc("GameTooltip_ClearMoney", function ()
			if (tmp_tt[this]) then
				tmp_tt[this]:Hide();
			end
		end);
	end,
	
	["Draw"] = function (frame, price)
		if (not tmp_tt[frame]) then
			tmp_tt[frame] = CreateFrame("Frame", "ValuationTooltip_" .. frame:GetName(), frame, "SmallMoneyFrameTemplate");
			
			local tmp = this;
			this = tmp_tt[frame];
			
			MoneyFrame_SetType("STATIC");
			
			this = tmp;
		end
		
		if (price == 0) then
			frame:AddLine(ITEM_UNSELLABLE, 1, 1, 1);
		else
			frame:AddLine(" ");
			
			local tmp = tmp_tt[frame];
			
			tmp:SetPoint("LEFT", frame:GetName() .. "TextLeft" .. frame:NumLines(), "LEFT", 4, 0);
			tmp:Show();
			MoneyFrame_Update(tmp:GetName(), price);
			
			frame:SetMinimumWidth(tmp:GetWidth());
		end
		
		frame:Show();
	end,
}

