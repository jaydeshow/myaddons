
Valuation = {};
Valuation["events"] = {};
Valuation["locale"] = {};
Valuation["styles"] = {};


function Valuation:OnLoad(frame)
	for i in pairs(self.events) do
		frame:RegisterEvent(i);
	end
end

function Valuation:OnEvent(event, ...)
	self.events[event](...);
end

function Valuation.OnSlashCmd(slash, cmd)
	local function PrintUsage(...)
		local info   = ChatTypeInfo["SYSTEM"];
		local colour = ("|cff%02x%02x%02x"):format(info.r * 255, info.g * 255, info.b * 255);
		
		DEFAULT_CHAT_FRAME:AddMessage(colour .. "Valuation: |r" .. Valuation.GetString("Usage:"));
		
		for i = 1, select("#", ...) do
			DEFAULT_CHAT_FRAME:AddMessage(colour .. "Valuation:  * |r" .. select(i, ...));
		end
	end
	
	local t = { };
	
	for w in string.gmatch(cmd, "%S+") do
		table.insert(t, string.lower(w));
	end
	
	if (t[1] == "style") then
		if (Valuation.styles[t[2]]) then
			ValuationCfg["style"] = t[2];
			
			ReloadUI();
		end
	end
	
	-- Reload or fail! xD
	PrintUsage("/" .. slash .. " style <blackhole | blizzard | compact>");
end

