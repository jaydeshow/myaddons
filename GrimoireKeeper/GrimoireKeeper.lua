-- GrimoireKeeper.lua

GrimoireKeeperData = {Version = 2};
local GKOld_MerchantFrame_UpdateMerchantInfo;

function GrimoireKeeper_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

function GrimoireKeeper_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		_,class = UnitClass("player");
		if class == "WARLOCK" then
			this:RegisterEvent("PET_BAR_UPDATE");
			this:RegisterEvent("ADDON_LOADED");
			hooksecurefunc("MerchantFrame_UpdateMerchantInfo", GrimoireKeeper_ColorMerchantInfo);
			if GrimoireKeeperData.Version and GrimoireKeeperData.Version > 1 then return;
				-- Already updated.
			else
				DEFAULT_CHAT_FRAME:AddMessage("Grimoire Keeper's gnomes have moved to a new crayon system.  You'll have to re-summon your pets to update the gnomes.  Sorry!");
			    GrimoireKeeperData = {};
			    GrimoireKeeperData.Version = 2;
			end
			GrimoireKeeper_CheckFelguard();
		end
		this:UnregisterEvent("VARIABLES_LOADED");
	elseif event == "PET_BAR_UPDATE" then 
		GrimoireKeeper_ParsePetSkills();
	elseif event == "ADDON_LOADED" and arg1 == "Blizzard_TalentUI" then
		this:UnregisterEvent("ADDON_LOADED");
		hooksecurefunc("TalentFrame_OnHide", GrimoireKeeper_CheckFelguard);
		hooksecurefunc("TalentFrame_OnShow", GrimoireKeeper_CheckFelguard);
	end
end

function GrimoireKeeper_ParsePetSkills()
	local hasPetSpells, petToken = HasPetSpells();
	if hasPetSpells ~= nil and petToken == "DEMON" then
        local i = 1;
		local name, rank = GetSpellName(i, BOOKTYPE_PET)

		while name ~= nil do
			_,_,rank = string.find(rank, "(%d+)")
			if rank == nil then rank = "0" end;
			if GK_GRIMOIRES[name] then
				name = GK_GRIMOIRES[name][1];
				GrimoireKeeperData[name] = tonumber(rank);-- insert into DB --
			end
			i = i + 1;
			name, rank = GetSpellName(i, BOOKTYPE_PET);
		end
	else return;
	end
end

function GrimoireKeeper_ColorMerchantInfo()
	local total = GetMerchantNumItems();
	local name, item;
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i);
		if (index <= total) then
			item = GetMerchantItemInfo(index);
			if item == nil then return end;
--DEFAULT_CHAT_FRAME:AddMessage("item = " .. item);
			if string.find(item, GK_TEXT_GRIMOIRE) then
				-- parse parts --
				text = GK_TEXT_GRIMOIRE..GK_ARTICLE_REGEX;
				_,_,name, rank = string.find(item, text.."(.+)（"..GK_TEXT_RANK.." (%d+)）");
				if name == nil then _,_,name = string.find(item, text.."(.+)") end;
				-- strip all spaces and non-alphanumeric chars --
				if name == nil then _,_,name = string.find(item, text.."(.+)") end;
				if name == "血契" then name = "血之契印" end ;

--if name ~=nil then DEFAULT_CHAT_FRAME:AddMessage("name = " .. name) end;

--				DEFAULT_CHAT_FRAME:AddMessage( name..":"..tostring(rank)..":"..tostring(GrimoireKeeperData[name]) );
				if name ~= nil and GrimoireKeeperData[name] ~= nil then
					local itemButton = getglobal("MerchantItem"..i.."ItemButton");
					local merchantButton = getglobal("MerchantItem"..i);
					if rank ~= nil then rank = tonumber(rank) end;
					if (rank == nil) or (rank <= GrimoireKeeperData[name]) then
						SetItemButtonNameFrameVertexColor(merchantButton, 0, 0.75, 0.75);
						SetItemButtonSlotVertexColor(merchantButton, 0, 0.75, 0.75);
						SetItemButtonTextureVertexColor(itemButton, 0, 0.65, 0.65);
						SetItemButtonNormalTextureVertexColor(itemButton, 0, 0.65, 0.65);
					end
				elseif name ~= nil and GK_GRIMOIRES[name] and GK_GRIMOIRES[name][2] and not GrimoireKeeperData["Has Felguard"] then -- Felguard skills.
					local itemButton = getglobal("MerchantItem"..i.."ItemButton");
					local merchantButton = getglobal("MerchantItem"..i);
					SetItemButtonNameFrameVertexColor(merchantButton, 0.1, 0.1, 0.1);
					SetItemButtonSlotVertexColor(merchantButton, 0.1, 0.1, 0.1);
					SetItemButtonTextureVertexColor(itemButton, 0.1, 0.1, 0.1);
					SetItemButtonNormalTextureVertexColor(itemButton, 0.1, 0.1, 0.1);
				end
			end
		end
	end
end

function GrimoireKeeper_CheckFelguard()
	_,_,_,_,rank = GetTalentInfo(2,22);
	if rank > 0 then
		GrimoireKeeperData["Has Felguard"] = true;
	else
		GrimoireKeeperData["Has Felguard"] = false;
	end;
end