local Capping = Capping
local self = Capping
local L = CappingLocale
local candy = AceLibrary("CandyBar-2.0")

local lastsync = 0
local strfind, strlower = strfind, strlower
local capture_time = 243

--------------------------
function Capping:StartAV()
--------------------------
	self:RegisterTempEvent("CHAT_MSG_MONSTER_YELL", "AVAssaults")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "CheckStartTimer")
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", "SnowfallAlliance") 
	self:RegisterTempEvent("CHAT_MSG_BG_SYSTEM_HORDE", "SnowfallHorde") 

	self:RegisterTempEvent("GOSSIP_SHOW", "AVQuests")
	self:RegisterTempEvent("QUEST_PROGRESS", "AVQuests")
	self:RegisterTempEvent("QUEST_COMPLETE", "AVQuests")
	
	self:RegisterTempEvent("CHAT_MSG_ADDON")
end

-- determines if a node's a graveyard or tower
local lbunk, ltow = strlower(L["Bunker"]), strlower(L["Tower"])
local function NodeType(node)
	-- check for towers; if not, assume it's a graveyard
	if node and (strfind(strlower(node), lbunk) or strfind(strlower(node), ltow)) then
		return "tower"
	end
	return "graveyard"
end

--------------------------------------------------------------
function Capping:CHAT_MSG_ADDON(prefix, message, chan, sender)
--------------------------------------------------------------
	if prefix ~= "cap" or chan ~= "BATTLEGROUND" or sender == UnitName("player") then return end
	if message == "r" then
		if lastsync + 20 < GetTime() then
			for value,color in pairs(self:GetActiveBars()) do
				local active, totalTime, elapsed, running = candy:Status(value)
				if active and running then
					SendAddonMessage("cap", format("%s@%d@%d@%s", value, totalTime, elapsed, color), "BATTLEGROUND")
				end
			end
			lastsync = GetTime()
		end
	else
		local name, maxTime, elapsed, color = strmatch(message, "^(.+)@(%d+)@(%d+)@(.+)")
		if name and elapsed and not candy:Status(name) then
			local icon
			if name == L["Ivus begins moving"] then 
				icon = "Interface\\Icons\\Spell_Nature_NaturesBlessing"
			elseif name == L["Lokholar begins moving"] then 
				icon = "Interface\\Icons\\Spell_Frost_Glacier"
			else 
				icon = self:GetIconData(color, NodeType(name))
			end
			maxTime, elapsed = tonumber(maxTime), tonumber(elapsed)
			self:StartBar(name, maxTime, icon, color or "info1")
			candy:SetTimeLeft(name, maxTime - elapsed)
		end
	end
end

-------------------------
function Capping:SyncAV()
-------------------------
	SendAddonMessage("cap", "r", "BATTLEGROUND")
end

-------------------------------
function Capping:AVAssaults(a1)
-------------------------------
	if strfind(a1, L["avunderattack"]) then
		local node, faction
		_,_,node = strfind(a1, L["avunderattack"])
		if strfind(a1, L["Horde"]) then 
			faction = L["Horde"] 
		else 
			faction = L["Alliance"] 
		end
		node = gsub(node, L["The "], "")
		if faction == L["Horde"] then 
			self:StopBar(node)
			self:StartBar(node, capture_time, self:GetIconData("horde", NodeType(node)), "horde")
		else
			self:StopBar(node)
			self:StartBar(node, capture_time, self:GetIconData("alliance", NodeType(node)), "alliance")
		end
	elseif strfind(a1, L["avtaken"]) then
		local _,_,node = strfind(a1, L["avtaken"])
		node = gsub(node, L["The "], "")
		self:StopBar(node)
	elseif strfind(a1, L["avdestroyed"]) then
		local _,_,node = strfind(a1, L["avdestroyed"])
		node = gsub(node, L["The "], "")
		self:StopBar(node)
	elseif strfind(a1, L["Wicked, wicked, mortals!"]) then 
		self:StartBar(L["Ivus begins moving"], 603, "Interface\\Icons\\Spell_Nature_NaturesBlessing", "alliance")
	elseif strfind(a1, L["The Ice Lord has arrived!"]) or strfind(a1, L["WHO DARES SUMMON LOKHOLAR"]) then
		self:StartBar(L["Lokholar begins moving"], 603, "Interface\\Icons\\Spell_Frost_Glacier", "horde")
	end
end			

local sf = L["Snowfall Graveyard"]
----------------------------------
function Capping:SnowfallHorde(a1)
----------------------------------
	--Initial capture of Snowfall for horde
	if strfind(strlower(a1), strlower(sf)) then
		self:StopBar(sf)
		self:StartBar(sf, capture_time, self:GetIconData("horde", "graveyard"), "horde")
	end
end
-------------------------------------
function Capping:SnowfallAlliance(a1)
-------------------------------------
	--Initial capture of Snowfall for alliance
	if strfind(strlower(a1), strlower(sf)) then
		self:StopBar(sf)
		self:StartBar(sf, capture_time, self:GetIconData("alliance", "graveyard"), "alliance")
	end
end

---------------------------
function Capping:AVQuests()
---------------------------
	if not self.db.avquest then return end
	local event = event
	local target = UnitName("target")
	if event=="GOSSIP_SHOW" or event=="QUEST_PROGRESS" then
		if target == L["Smith Regzar"] or target == L["Murgot Deepforge"] then
			-- Open Quest to Smith or Murgot
			local gossip = GetGossipOptions()
			if gossip and strfind(gossip, L["Upgrade to"] ) then
				SelectGossipOption(1)
			elseif GetItemCount(17422) >= 20 then -- Armor Scraps 17422
				SelectGossipAvailableQuest(1)
			end
		elseif target == L["Primalist Thurloga"] then
			local num = GetItemCount(17306) -- Stormpike Soldier's Blood 17306
			if num >= 5 then
				SelectGossipAvailableQuest(2)
			elseif num > 0 then
				SelectGossipAvailableQuest(1)
			end
		elseif target == L["Arch Druid Renferal"] then
			local num = GetItemCount(17423) -- Storm Crystal 17423
			if num >= 5 then
				SelectGossipAvailableQuest(2)
			elseif num > 0 then
				SelectGossipAvailableQuest(1)
			end
		elseif target == L["Stormpike Ram Rider Commander"] then
			if GetItemCount(17643) > 0 then -- Frost Wolf Hide 17643
				SelectGossipAvailableQuest(1)
			end
		elseif target == L["Frostwolf Wolf Rider Commander"] then
			if GetItemCount(17642) > 0 then -- Alterac Ram Hide 17642
				SelectGossipAvailableQuest(1)
			end
		end
	end
	if event == "QUEST_PROGRESS" then
	   	if IsQuestCompletable() then
	   		CompleteQuest()
	   	end
	elseif event == "QUEST_COMPLETE" then
		GetQuestReward(0)
	end
end

