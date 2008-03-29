local L = AlchemyProcsLocals
local amountExpected = {}

--Procs data
AlchemyProcs = {
	["Version"] = L["DataVersion"];		--Data version,field to keep back compatibility
}

local function showHelp()
	for i= 1,#L["Help"] do
		print(L["Help"][i])
	end
end

local function print(text)
	if (DEFAULT_CHAT_FRAME) then
		if (not text) then
			text = tostring(text)
		end
		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
end

local function getItemId(item)	
	if ( item == nil ) then 
		return nil
	end
	local found, _, itemId = string.find(item,"Item(%d+)")
	if ( found ) then
		return tonumber(itemId);
	end
	local itemString
	found, _, itemString = string.find(item, "^|c%x+|H(.+)|h%[.+%]")
	if ( not found ) then
		itemString = item;
	end
	_, itemId = strsplit(":", itemString)
	return tonumber(itemId);
end

local function loadData(itemId)	
	local procs = {}
	for i= 0,4 do
		procs[i] = 0;
	end
	if ( AlchemyProcs[itemId] ) then
		procs[0],procs[1],procs[2],procs[3],procs[4] = string.split(":", AlchemyProcs[itemId]);
	end	
	return procs;
end

local function saveData(itemId,procs)
	if ( itemId ) then
		if ( procs ) then
			AlchemyProcs[itemId] = string.format("%s:%s:%s:%s:%s:%s",procs[0],procs[1],procs[2],procs[3],procs[4],amountExpected[itemId]);
		else
			AlchemyProcs[itemId] = nil;
		end	
	else 
		AlchemyProcs = {};
	end
	AlchemyProcs_UpdateData(itemId);
end

local function getMastery()
	local _, _, _, numSpells = GetSpellTabInfo(1);
	for i= 1, numSpells do		
		local spell = GetSpellName(i,BOOKTYPE_SPELL);		
		if( spell == L["Elixir Master"] or spell == L["Potion Master"] or spell == L["Transmutation Master"] ) then
			return spell;
		end
	end	
	return nil;
end

local function canProcs(subType)
	local mastery = getMastery();
	if ( mastery == L["Elixir Master"] ) then
		return ( subType == L["Flask"] or subType == L["Elixir"] );
	elseif ( mastery == L["Potion Master"] ) then
		return ( subType == L["Potion"] );
	elseif ( mastery == L["Transmutation Master"] ) then
		return ( subType == L["Meta"] or subType == L["Elemental"] );
	end	
	return false;
end

local lastProcs = {
	time = GetTime();
}

local function checkProcs(msg)
	local item, amount = string.match(msg,L["Mutiple"]);
	if( not item and not amount ) then
		item = string.match(msg, L["Single"]);
		amount = 1;
	end		
	if( not item ) then
		-- No match found, not a trade skill creation
		return
	end
	
	local itemId = getItemId(item);
	local subType = getSubType(itemId);
		
	
	amount = tonumber(amount);	
	
	-- Check if the creation can proc
	if( not itemId or not amount or not amountExpected[itemId] or not canProcs(subType) ) then		
		return;
	end	
			
	-- Check mutiple loot messages in one creation 
	local procs = loadData(itemId);
	if ( itemId == lastProcs.itemId and GetTime() - lastProcs.time < 1 ) then
		procs[lastProcs.index] = procs[lastProcs.index] - 1;
		amount = amount + lastProcs.amount;
	end
	
	-- Save data		
	local index = amount - amountExpected[itemId];
	procs[index] = procs[index] + 1;
	saveData(itemId,procs);
		
	-- Infomation for mutiple loot messages checking
	lastProcs.time = GetTime();
	lastProcs.itemId = itemId;
	lastProcs.index = index;
	lastProcs.amount = amount;
	
end

local function scanSkills()
	if( GetTradeSkillLine() ~= L["Alchemy"] ) then
		return;
	end
	
	for i= 1, GetNumTradeSkills() do
		local itemLink = GetTradeSkillItemLink(i);
		if( itemLink ) then
			local id = getItemId(itemLink);	
			if( id ) then
				amountExpected[id] = GetTradeSkillNumMade(i);
			end
		end
	end
end

local function showData(itemId)
	local procs = loadData(itemId);
	local made = 0;
	for i= 0,4 do
		made = made + procs[i];	
	end
	local proc = made - procs[0];	
	local _, itemLink = GetItemInfo(itemId);
	if ( not itemLink ) then
		itemLink = L["Item"]..itemId;
	end
		
	print(string.format(L["Data"],itemLink));	
	print(string.format(L["Made"]..":%d   "..L["Procs"]..":%d (%.2f%%)", made, proc, proc/made * 100));
	for i = 1,4 do
		if ( tonumber(procs[i]) ~= 0 ) then
			print(string.format("%s : %d (%.2f%%)", L["Proc"][i], procs[i], procs[i]/made*100));
		end
	end
end

-- Conver old data format
local function convertOldData(oldVersion)
	AlchemyProcs["Version"] = L["DataVersion"];
	print(L["Data updated"]);
end

function AlchemyProcs_OnEvent(this, event, arg1, ...)
	if (event == "VARIABLES_LOADED") then 
		AlchemyProcs_OnInitialize();
	elseif (event == "CHAT_MSG_LOOT") then
		checkProcs(arg1);
	else	
		scanSkills();
	end
end

function AlchemyProcs_OnInitialize()			
	print(L["Addon Loaded"].." (Ver "..L["Version"]..")");
end

function AlchemyProcs_Cmd(cmdLine)
	if ( AlchemyProcs["Version"] ~= L["DataVersion"] ) then
		convertOldData(AlchemyProcs["Version"]);
	end
	cmdLine = string.gsub(cmdLine,"(%s+)"," ");
	local cmd,arg= string.split(" ",cmdLine);
	if ( cmd ~= "" ) then
		cmd = string.lower(cmd);
		if ( cmd == "list" or cmd == "l" ) then
			if ( arg == "all" ) then
				local empty = true;
				for k,v in pairs(AlchemyProcs) do
					if ( k ~= "Version" ) then	--Skip the version field
						showData(k);
						empty = false;
					end
				end
				if ( empty ) then
					print(L["No data"]);
				end
			else
				local _, itemLink = GetItemInfo(arg);
				local itemId = getItemId(itemLink);
				if ( not itemId ) then
					print(L["Help"][4]);
					return
				end
				if ( AlchemyProcs[itemId] ) then
					showData(itemId);
				else
					print(L["No such data"]);
				end
			end		
		elseif ( cmd == "remove" or cmd == "r" ) then
			local _, itemLink = GetItemInfo(arg);	
			local itemId = getItemId(itemLink);
			if ( not itemId ) then
				print(L["Help"][5]);
				return;
			end
			if ( AlchemyProcs[itemId] ) then
				saveData(itemId);
				print(string.format(L["Data removed"],itemLink));
			else
				print(L["No such data"]);
			end
		elseif ( cmd == "clear" ) then
			saveData();
			print(L["All data cleared"]);
		elseif ( cmd == "help" or cmd == "h" or cmd == "?") then
			showHelp();
		else
			print(string.format(L["Invalid command"],cmd))
			showHelp();
		end
	else		
		AlchemyProcs_ToggleGUI(true);
	end
end

SlashCmdList["AlchemyProcs"] = AlchemyProcs_Cmd;
SLASH_AlchemyProcs1 = "/AlchemyProcs";
SLASH_AlchemyProcs2 = "/ap";