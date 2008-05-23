local ips, wps;

local print = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end;

local function hasDebuff(debuffName)
	local GetBuff;
	if( UnitIsFriend("player", "mouseover") )then
		GetBuff = UnitBuff;
	else
		GetBuff = UnitDebuff;
	end;
	local j = 1;
	local debuff = GetBuff("mouseover", j);
	while(debuff)do
		if(debuffName == debuff)then
			return 1;
		end;
		j = j + 1;
		debuff = GetBuff("mouseover", j);
	end;
	return nil;
end;
local function GetSpellColor(spell, rank)
	if(spell == NOT_TAMEABLE)then
		return "|cffffaaaa".. NOT_TAMEABLE .."|r";
	elseif( ips[spell] and ips[spell][rank] )then
		return "|cffffff33".. spell .. BS_LEVEL_DESC .. rank ..")|r";
	elseif( UnitLevel("mouseover") > UnitLevel("player") )then
		return "|cffff0000".. spell .. BS_LEVEL_DESC .. rank ..")|r";
	else
		return "|cff00ff00".. spell .. BS_LEVEL_DESC .. rank ..")|r";
	end;
end;

--带有BeastSpell前缀的函数
local function BeastSpell_GetCRAFT()
	local j, craftName, craftRank;
	for j = 1, GetNumCrafts(), 1 do
		--craftIcon = string.gsub(craftIcon, "^Interface\\Icons\\", "");
		--craftName, craftRank, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(j);
		craftName, craftRank = GetCraftInfo(j);
		_, _, craftRank = string.find(craftRank, "(%d+)");
		if(craftRank == nil)then
			craftRank = "1";
		end;
		if(not ips[craftName])then
			ips[craftName] = {[craftRank] = j,};
		else
			ips[craftName][craftRank] = j;
		end;
	end;
end;

local function BeastSpell_UpdateLv()
	local mouseName = UnitName("mouseover");
	local zone = GetZoneText();
	if(not wps[zone] or not wps[zone][mouseName])then
		return;
	end;
	local mouseLv = UnitLevel("mouseover");
	if(not wps[zone][mouseName]["min"] or not wps[zone][mouseName]["max"])then
		wps[zone][mouseName]["min"] = mouseLv;
		wps[zone][mouseName]["max"] = mouseLv;
	elseif(mouseLv < wps[zone][mouseName]["min"])then
		wps[zone][mouseName]["min"] = mouseLv;
	elseif(wps[zone][mouseName]["max"] < mouseLv)then
		wps[zone][mouseName]["max"] = mouseLv;
	end;
end;

local function BeastSpell_Save(spellTable)
	local mouseLv = UnitLevel("mouseover");
	local mouseName = UnitName("mouseover");
	local zone = GetZoneText();
	local spell, rank;
	if(not wps[zone])then
		wps[zone] = {
			[mouseName] = {},
		};
	elseif(not wps[zone][mouseName])then
		wps[zone][mouseName] = {};
	end;
	local j = 1;
	while(spellTable[j]) do
		wps[zone][mouseName][j] = spellTable[j];
		j = j + 1;
	end;
	while(wps[zone][mouseName][j]) do
		table.remove(wps[zone][mouseName], j);
	end;
end;

local function BeastSpell_ReadData()
	local mouseName = UnitName("mouseover");
	local zone = GetZoneText();
	if(not wps[zone] or not wps[zone][mouseName])then
		return;
	end;
	local tempTable = wps[zone][mouseName];
	local lintText2 = BS_ABILITY;
	if(tempTable[1] ~= NOT_TAMEABLE)then
		local k = 1;
		while(tempTable[k])do
			_, _, spell, rank = string.find(tempTable[k], "(.-)|(%d+)");
			spell = string.gsub(spell, "^%s+", "");
			spell = string.gsub(spell, "%s+$", "");
			lintText2 = lintText2 .. GetSpellColor(spell, rank);
			k = k + 1;
			if(tempTable[k])then
				lintText2 = lintText2 .. ", ";
			end;
		end;
	else
		lintText2 = GetSpellColor( NOT_TAMEABLE );--"不可驯服"
	end;
	GameTooltip:AddLine(lintText2, 1, 1, 1);
	local width = 25 + getglobal("GameTooltipTextLeft"..GameTooltip:NumLines()):GetWidth();
	if(GameTooltip:GetWidth() < width)then
		GameTooltip:SetWidth( width );
	end;
	GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
end;

local function BeastSpell_BeastLore()
	local j, lineText, f, spells;
	for j = GameTooltip:NumLines(), 1, -1 do
		lineText = getglobal("GameTooltipTextLeft"..j):GetText();
		--if( lineText and string.find(lineText, "驯兽能力：") )then
		--f, _, spells = string.find(lineText, "驯兽能力：(.+)");
		_, _, spells = string.find(lineText, BS_ABILITY_LORE);
		if( spells )then
			local wildSpells = {};
			local spella;
			--for spell, rank in string.gmatch(spells, "(.-)%s*%(.-%s*(%d+)%),*%s*") do
			for spella in string.gmatch(spells, "[^,]+") do
				local _, _, spell, rank = string.find(spella, "(.-)%(.-(%d+)");
				if(not rank or rank == "")then
					spell = spella;
					rank = 1;
				end;
				spell = string.gsub(spell, "^%s+", "");
				spell = string.gsub(spell, "%s+$", "");
				table.insert( wildSpells, spell .."|".. rank);
			end;
			BeastSpell_Save(wildSpells);--储存野兽信息
			local lintText2 = BS_ABILITY;
			local k = 1;
			while(wildSpells[k])do
				_, _, spell, rank = string.find(wildSpells[k], "(.-)|(%d+)");
				lintText2 = lintText2 .. GetSpellColor(spell, rank);
				k = k + 1;
				if(wildSpells[k])then
					lintText2 = lintText2 .. ", ";
				end;
			end;
			getglobal("GameTooltipTextLeft"..j):SetText(lintText2);
			local width = 25 + getglobal("GameTooltipTextLeft"..j):GetWidth();
			if(GameTooltip:GetWidth() < width)then
				GameTooltip:SetWidth( width );
			end;
			return;
		elseif(lineText == NOT_TAMEABLE)then--不可驯服
			local wildSpells = { NOT_TAMEABLE, };--不可驯服
			BeastSpell_Save( wildSpells );--储存野兽信息
			getglobal("GameTooltipTextLeft"..j):SetText( GetSpellColor( NOT_TAMEABLE ) );
			return;
		end;
	end;
end;

local function BeastSpell_SetTootip()
	if( hasDebuff(BS_BEAST_LORE) )then
		GameTooltip:SetUnit("mouseover");
		BeastSpell_BeastLore();
	else
		BeastSpell_ReadData();
	end;
	BeastSpell_UpdateLv();
end;

--[[
function BeastSpell_OnLoad()
	local obj = CreateFrame("Frame", nil, UIParent);
	obj:SetScript("OnEvent", BeastSpell_OnEvent);
	--obj:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	--obj:RegisterEvent("UNIT_AURA");
	obj:RegisterEvent("VARIABLES_LOADED");
	--obj:RegisterEvent("PLAYER_ENTERING_WORLD");
end;
--]]

function BeastSpell_OnEvent()
	if ( event == "UPDATE_MOUSEOVER_UNIT" ) then
		if ( UnitExists("mouseover") and not UnitPlayerControlled("mouseover") and UnitCreatureType("mouseover") == BS_BEAST )then
			if( UnitCreatureFamily("mouseover") )then
				BeastSpell_SetTootip();
			elseif( not hasDebuff(BS_BEAST_LORE) )then
				GameTooltip:AddLine(NOT_TAMEABLE, 1, 0.7, 0.7);
				GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
			end;
		end;
	elseif( event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" )then
		if( CraftFrame and CraftFrame:IsVisible() )then
		--CraftFrame:IsVisible()
			if( CraftIsPetTraining() )then
				BeastSpell_GetCRAFT();
			end;
			BeastSpell_TrainFrame_OnEvent(event);
		end;
	elseif(event == "CRAFT_CLOSE")then
		BeastSpell_TrainFrame:Hide();
	--elseif ( event == "CHAT_MSG_SYSTEM" ) then
		--ERR_LEARN_SPELL_S;
	elseif ( event == "UNIT_PET_TRAINING_POINTS" ) then
		BeastSpell_TrainFrame_UpdateTP();
	elseif( event == "VARIABLES_LOADED" )then
		this:UnregisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		this:RegisterEvent("CRAFT_SHOW");
		this:RegisterEvent("CRAFT_UPDATE");
		this:RegisterEvent("CRAFT_CLOSE");
		this:RegisterEvent("UNIT_PET_TRAINING_POINTS");
		--检查存档
		if(not BeastSpell_Self)then
			BeastSpell_Self = {};
		end;
		ips = BeastSpell_Self;
		print(BS_LOAD_MESSAGE);--加载成功
		if(not BeastSpell_Wild or not BeastSpell_Wild["dbVer"])then
			BeastSpell_Wild = BeastSpell_Data1;
		end;
		BeastSpell_Data1 = nil;
		wps = BeastSpell_Wild;
		--初始化窗体
		BeastSpell_TrainFrame_Init();
	end;
end;

--BeastSpell_OnLoad();