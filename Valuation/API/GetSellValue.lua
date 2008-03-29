
local lastID;
local lastValue;

local GetSellValue_original = GetSellValue;

function GetSellValue(item)
	local ID;
	
	if (type(item) == "number") then
		ID = item;
	else
		local link = select(2, GetItemInfo(item));
		
		ID = link and tonumber(link:match("item:(%d+)"));
	end
	
	-------------------------
	
	local value = -1;
	
	if (ID) then
		if (lastID == ID) then
			value = lastValue;
		elseif (math.floor(#ValuationDB / 2.5) > ID) then
			local startByte = math.floor(ID * 2.5) + 1;
			local startBit  = (ID * 2.5) % 1 * 8;
			
			value = ValuationDB:byte(startByte) * 2 ^ 16;
			value = value + ValuationDB:byte(startByte + 1) * 2 ^ 8;
			value = value + ValuationDB:byte(startByte + 2);
			value = math.floor(value / 2 ^ (4 - startBit)) % 0x100000;
			value = value - 1;
			
			lastID    = ID;
			lastValue = value;
		end
	end
	
	-------------------------
	
	if (value >= 0) then
		if (ID == 33999) then
			return 5000000; -- (Epic) Cenarion War Hippogryph
		end
		
		return value;
	end
	
	return ID and GetSellValue_original and GetSellValue_original(ID);
end

