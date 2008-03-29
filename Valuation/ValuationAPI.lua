
function Valuation.GetString(index, ...)
	return Valuation.locale[index]:format(...);
end

function Valuation.MoneyToGSC(money)
	local gold = math.floor(money / 10000);
	local silver = math.floor(money / 100 % 100);
	local copper = money % 100;
	
	return gold, silver, copper;
end

