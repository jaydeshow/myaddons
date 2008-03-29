
Valuation["styles"]["compact"] = {
	["Load"] = function ()
		-- Nil
	end,
	
	["Draw"] = function (frame, price, amount)
		if (price == 0) then
			frame:AddLine(ITEM_UNSELLABLE, 1, 1, 1);
		else
			local gold, silver, copper = Valuation.MoneyToGSC(price);
			local header = amount > 1 and Valuation.GetString("Sells for [%d]:", amount) or Valuation.GetString("Sells for:");
			local text = "";
			
			if (gold > 0) then
				text = ("|cffffffff%d|cffffd700g|r"):format(gold);
			end
			
			if (silver > 0) then
				text = text .. (" |cffffffff%d|cffc7c7cfs|r"):format(silver);
			end
			
			if (copper > 0) then
				text = text .. (" |cffffffff%d|cffeda55fc|r"):format(copper);
			end
			
			frame:AddDoubleLine(header, text, 0, 1, 1, 1, 1, 1);
		end
		
		frame:Show();
	end,
}

