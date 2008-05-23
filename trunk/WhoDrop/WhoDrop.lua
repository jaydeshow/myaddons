--[[ WhoDrop은..

Niagara(테이블 생성)와.. ColaLight(툴팁 표시), 등의 도움을 받아 만들어진 애드온입니다... -_-;;;;;

입력된 자료들은 기본적으로 누구드랍에서 가져왔습니다...

]]

WhoDrop = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local waterfall = AceLibrary("Waterfall-1.0")
local console = AceLibrary("AceConsole-2.0")
local self = WhoDrop
local UFaction

local L = AceLibrary("AceLocale-2.2"):new("WhoDrop")
local BFAC = LibStub("LibBabble-Faction-3.0")
local BF = BFAC:GetLookupTable()
local BBOSS = LibStub("LibBabble-Boss-3.0")
local BB = BBOSS:GetLookupTable()
local BZONE = LibStub("LibBabble-Zone-3.0")
local BZ = BZONE:GetLookupTable()
local BCLASS = LibStub("LibBabble-Class-3.0")
local BC = BCLASS:GetLookupTable()
local BINV = LibStub("LibBabble-Inventory-3.0")
local BI = BINV:GetLookupTable()
local BQ = nil
local TempTable = { }

local TipHooker = AceLibrary("TipHooker-1.0")

BINDING_HEADER_WHODROP = "WhoDrop";
BINDING_NAME_AUTOSEARCH = L["Auto Search"];

WhoDrop.Menu = { 
	type = "group", 
	args = {
		Open = {
			name = L["Open"],
			order = 1,
			type = "execute",
			desc = L["Opens GUI"],
			disabled = "~IsActive",
			func = function() WhoDrop:OnClick() AceLibrary("Dewdrop-2.0"):Close() end,
		},
		Opposing = {
			name = L["Opposing"],
			desc = L["Show Opposing"],
			type = "toggle",
			order = 4,
			get = function() return WhoDrop.db.profile.opp end,
			set = function()
				WhoDrop.db.profile.opp = not WhoDrop.db.profile.opp
				WhoDrop:reBuild();
			end,

		},
		Search = {
			type = "text",
			name = L["Search"],
			desc = L["Serching item by word or item ID"],
			usage = L["<text or item ID>"],
			order = 8,
			get = false,
			set = function (name)
				WhoDrop:Searching(name)
			end
		},
		AutoSearch = {
			type = "execute",
			name = L["Auto Search"],
			desc = L["Serching item by target name or instance name"],
			order = 9,
			func = function ()
				WhoDrop:SearchingInstance()
			end,
		},
		BQ = {
			name = L["Use BQ-2.2"],
			desc = L["Use Babble-Quest-2.2."],
			type = "toggle",
			order = 7,
			get = function() return WhoDrop.db.profile.quest end,
			set = function() 
				WhoDrop.db.profile.quest = not WhoDrop.db.profile.quest
				if WhoDrop.db.profile.quest then
					BQ = AceLibrary("Babble-Quest-2.2")
				end
				WhoDrop:reBuild();
			end,
		},
		Drop = {
			name = L["Drop Item"],
			desc = L["Show Drop Item"],
			type = "toggle",
			order = 5,
			get = function() return WhoDrop.db.profile.drop end,
			set = function() 
				WhoDrop.db.profile.drop = not WhoDrop.db.profile.drop
				WhoDrop:reBuild();
			end,
		},
		Always = {
			name = L["Always Show Link"],
			desc = L["Always Show unfinded item link"],
			type = "toggle",
			order = 5,
			get = function() return WhoDrop.db.profile.always end,
			set = function() 
				WhoDrop.db.profile.always = not WhoDrop.db.profile.always
				WhoDrop:reBuild();
			end,
		},
		Quest = {
			name = L["Quest Reward"],
			desc = L["Show Quest Reward"],
			type = "toggle",
			order = 6,
			get = function() return WhoDrop.db.profile.reward end,
			set = function() 
				WhoDrop.db.profile.reward = not WhoDrop.db.profile.reward
				WhoDrop.theTable = {type = "group", args = {}}
				WhoDrop:reBuild();
			end,
		},
	}
}

local qualitycolors = {
	[0] = "|cff9d9d9d",
	[1] = "|cffffffff",
	[2] = "|cff7AF67A",
	[3] = "|cff6478FF",
	[4] = "|cffbe32be",
	[5] = "|cffFF6464"
}

local CC = { } 

WhoDrop.hasIcon = "Interface\\Icons\\INV_Box_03"
WhoDrop.defaultPosition = "RIGHT"
WhoDrop.hasNoColor = true
WhoDrop.cannotDetachTooltip = true
WhoDrop.hideWithoutStandby = true
WhoDrop.OnMenuRequest = WhoDrop.Menu

function WhoDrop:OnInitialize()
	self:RegisterDB("WhoDropDB")
	self:RegisterDefaults("profile", {drop = true})
	self.revision = tonumber(string.sub("$Rev: 32539 $", 7, -3))
	self.version = self.version .. " |cffff8888r"..self.revision.."|r"
	self:RegisterChatCommand({"/WhoDrop"}, self.Menu)

--	self.db.profile.none = nil
--	self.db.profile.dup = nil
	UFaction = string.sub(UnitFactionGroup("player"), 1, 1)
	if  UFaction == "H" then
		CC = {
			["T"] = "|cffffffff",
			["E"] = "|cffffffff",
			["U"] = "|cffffffff",
			["N"] = "|cff89FB89",
			["B"] = "|cffFFD232",
			["H"] = "|cff1eff00",
			["A"] = "|CFFFF2222",
			["S"] = "|cff3CB4FF",
			["R"] = "|cffF389EF",
		}
	else
		CC = {
			["T"] = "|cffffffff",
			["E"] = "|cffffffff",
			["U"] = "|cffffffff",
			["N"] = "|cff89FB89",
			["B"] = "|cffFFD232",
			["A"] = "|cff1eff00",
			["H"] = "|CFFFF2222",
			["S"] = "|cff3CB4FF",
			["R"] = "|cffF389EF",
		}
	end

	if self.db.profile.quest then
		BQ = AceLibrary("Babble-Quest-2.2")
	end
end

function WhoDrop:OnEnable()
	self.theTable = {type = "group", args = {}}
	self:ScheduleEvent(self.InitialConstruct, 3, self)
	waterfall:Register("WhoDrop", "title", "WhoDrop", 'treeType', "TREE", "aceOptions", self.theTable, "colorR", 0.2, "colorG", 0.8, "colorB", 0.2)

	TipHooker:Hook(self.ProcessTooltip, "item")

	if Links then
		Links:AddToMenu(L["WD: Link Drop Info"], 
		function (_, _, link)
			self.PasteDropInfo(link)
		end)
	end
end

function WhoDrop:OnDisable()
	waterfall:Close("WhoDrop")
	waterfall:UnRegister("WhoDrop")

	TipHooker:Unhook(self.ProcessTooltip, "item")
end

function WhoDrop:InitialConstruct()
	self:Construct()
end

function WhoDrop:Seperate(v)
	
	local _, _, name, d, o = string.find(string.gsub(v, "~", "\."), "([^|]+)[|]?(%u*)[|]?(%d*)")
	if d == nil or not d or d == "" then d = "T" end
	if o == nil or not o or o == "" then o = 100 else o = tonumber(o) end
	return name, d, o

end
function WhoDrop:FindDesc(v)
	if (type(v) == "table") then
		for k, b in ipairs(v) do
			return tonumber(k)
		end
	else
		local _, _, id, desc = string.find(v, "(%d*)[|]?(.*)")
		return tonumber(id), desc
	end

end

function WhoDrop:FindLocal(name)
	
--[[	if L:HasBaseTranslation(name) then
		if string.find(name, "-Hero") then
			_,_,name = string.find(name, "(.+)-Hero")
			return BZ[name].."("..L["Hero"]..")"
		elseif BB:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BB[name]
		elseif BF:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BF[name]
		elseif BT:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BT[name]
		elseif BC:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BC[name]
		elseif BI:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BI[name]
		elseif BZ:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BZ[name]
		elseif self.db.profile.quest and BQ ~= nil and BQ:HasBaseTranslation(name) then
			if not self.db.profile.dup then
				self.db.profile.dup = name
			elseif not string.find(self.db.profile.dup, name) then 
				self.db.profile.dup = self.db.profile.dup.."|"..name
			end
			return BQ[name]
		else
			return L[name]
		end
	else
		if string.find(name, "-Hero") then
			_,_,name = string.find(name, "(.+)-Hero")
			return BZ[name].."("..L["Hero"]..")"
		elseif BB:HasBaseTranslation(name) then
			return BB[name]
		elseif BF:HasBaseTranslation(name) then
			return BF[name]
		elseif BT:HasBaseTranslation(name) then
			return BT[name]
		elseif BC:HasBaseTranslation(name) then
			return BC[name]
		elseif BI:HasBaseTranslation(name) then
			return BI[name]
		elseif BZ:HasBaseTranslation(name) then
			return BZ[name]
		elseif self.db.profile.quest and BQ ~= nil and BQ:HasBaseTranslation(name) then
			return BQ[name]
		else
			if not self.db.profile.none then
				self.db.profile.none = name
			elseif not string.find(self.db.profile.none, name) then 
				self.db.profile.none = self.db.profile.none.."|"..name
			end
			return name
		end
	end]]


	if string.find(name, "-Hero") then
		_,_,name = string.find(name, "(.+)-Hero")
		return BZ[name].."("..L["Hero"]..")"
	elseif L:HasBaseTranslation(name) then
		return L[name]
	elseif BBOSS:GetBaseLookupTable()[name] then
		return BB[name]
	elseif BFAC:GetBaseLookupTable()[name] then
		return BF[name]
	elseif BCLASS:GetBaseLookupTable()[name] then
		return BC[name]
	elseif BINV:GetBaseLookupTable()[name] then
		return BI[name]
	elseif BZONE:GetBaseLookupTable()[name] then
		return BZ[name]
	elseif self.db.profile.quest and BQ ~= nil and BQ:HasBaseTranslation(name) then
		return BQ[name]
	else
		return name
	end

end

function WhoDrop:BuildTable()
	WhoDropData = { }
--	self.theTable = {type = "group", args = {}}

	if self.db.profile.drop then
		for k,v in pairs(WhoDropInstanceData) do
			WhoDropData[k]=v;
		end
	end

	if WhoDropFieldData and self.db.profile.reward then
		for k,v in pairs(WhoDropFieldData) do
			if WhoDropData[k] then
				for a, b in pairs(v) do
					for c, d in pairs(b) do
						if WhoDropData[k][a] then
							WhoDropData[k][a][c] = d;
						else
							WhoDropData[k][a] = b;
						end
					end
				end
			else
				WhoDropData[k] = v;
			end
		end
	end
	if WhoDropEtcData then
		for k, v in pairs(WhoDropEtcData) do
			if WhoDropData[k] then
				for a, b in pairs(v) do
					WhoDropData[k][a] = b;
				end
			else
				WhoDropData[k] = v;
			end
		end
	end
end	

function WhoDrop:Construct()
	self:BuildTable()
	
	for a, b in pairs(WhoDropData) do
		local AN, AD, AO, CN, CD, CO, EN, ED, EO, GN, GD, GO, IN, ID, IO
		if not self.theTable then
			self.theTable = {type = "group", args = {}}
		end

		if not self.theTable.args[a] then
			AN, AD, AO = self:Seperate(a)
			self.theTable.args[a] ={
				name = CC[AD]..self:FindLocal(AN).."|r",
				desc = CC[AD]..self:FindLocal(AN).."|r",
				type ="group",
				order = AO, 
				args = {}
			}
		end
		for c, d in pairs(b) do
			CN, CD, CO = self:Seperate(c)
			if  ( CD == "H" or CD == "A" ) and CD ~= UFaction and not WhoDrop.db.profile.opp then
			else
				self.theTable.args[a].args[c] = {
					name = CC[CD]..self:FindLocal(CN).."|r",
					desc = CC[CD]..self:FindLocal(CN).."|r",
					type = "group",
					order = CO, 
					args = {}
				}
				for e, f in pairs(d) do
					EN, ED, EO = self:Seperate(e)

					if  ( ED == "H" or ED == "A" ) and ED ~= UFaction and not WhoDrop.db.profile.opp then
					else
						
						if not self.theTable.args[a].args[c].args[e] then
							self.theTable.args[a].args[c].args[e] = {
								name = CC[ED]..self:FindLocal(EN).."|r",
								desc = CC[ED]..self:FindLocal(EN).."|r",
								type = "group",
								order = EO, 
								args = {}
							}
						end
						for g, h in pairs(f) do
							if not self.theTable.args[a].args[c].args[e].args[g] then
								GN, GD, GO = self:Seperate(g)
								self.theTable.args[a].args[c].args[e].args[g] = {
									name = CC[GD]..self:FindLocal(GN).."|r",
									desc = CC[GD]..self:FindLocal(GN).."|r",
									order = GO,
									type = "group",
									args = {}
								}
							end
							for i, j in pairs(h) do
								if (type(i) ~= "number") then
									if not self.theTable.args[a].args[c].args[e].args[g].args[i] then
										IN, ID, iO = self:Seperate(i)
										self.theTable.args[a].args[c].args[e].args[g].args[i] = {
											name = CC[ID]..self:FindLocal(IN).."|r",
											desc = CC[ID]..self:FindLocal(IN).."|r",
											order = IO,
											type = "group",
											args = {}
										}
									end

									for k, l in pairs(j) do
										if not self.theTable.args[a].args[c].args[e].args[g].args[i].args[k] then
											local id, Desc = self:FindDesc(l)
											if type(id) == "number" and type(Desc) ~= "boolean" then
												Desc = "\n"..Desc
											elseif type(id) == "number" then
												Desc = ""
											end
											if type(id) ~= "number" then
												self.theTable.args[a].args[c].args[e].args[g].args[i].args[k] = {
													name = Desc,
													desc = Desc,
													order = tonumber(k),
													type = 'header',
												}
											else
												local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
												if not link  then
													self.theTable.args[a].args[c].args[e].args[g].args[i].args[k] = {
														name = "|cFFFF2222["..id.."]",
														desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
														order = tonumber(k),
														type = 'execute',
														func = function()
															if tonumber(id) then
																GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
																GameTooltip:SetHyperlink("item:" .. id)
																GameTooltip:Hide()
																WhoDrop:Construct()
																collectgarbage()
																waterfall:Refresh("WhoDrop")
															end
														 end,
													}
													if WhoDrop.db.profile.always then								
														self.theTable.args[a].args[c].args[e].args[g].args[i].args[k].link = "item:" .. id
													end
												else
													if AD == "U" or CD == "U" or ED == "U" or GD == "U" or ID == "U" then order = tonumber(k) else order = 6 - tonumber(rarity) end
														self.theTable.args[a].args[c].args[e].args[g].args[i].args[k] = {
															name = qualitycolors[rarity].."["..n.."]",
															desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
															order = order,
															type = 'execute',
															link = link,
															func = function() 
																if IsControlKeyDown() then
																		DressUpItemLink("item:" .. id);
																elseif IsShiftKeyDown() then
																	if not ChatFrameEditBox:IsVisible() then
																		ChatFrameEditBox:Show()
																	end
																	ChatFrameEditBox:Insert(link)
																elseif	 IsAltKeyDown() then
																	self.PasteDropInfo(link)
																else
																	ShowUIPanel(ItemRefTooltip)
																	if not ItemRefTooltip:IsVisible() then
																		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																	end
																	ItemRefTooltip:SetHyperlink(link)
																end
															end,
														}
													end
												end
											end
										end
								else
									if not self.theTable.args[a].args[c].args[e].args[g].args[i] then
										local id, Desc = self:FindDesc(j)
										if type(id) == "number" and type(Desc) ~= "boolean" then
											Desc = "\n"..Desc
										elseif type(id) == "number" then
											Desc = ""
										end
										if type(id) ~= "number" then
											self.theTable.args[a].args[c].args[e].args[g].args[i] = {
												name = Desc,
												desc = Desc,
												order = tonumber(i),
												type = 'header',
											}
										else
											local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
											if not link  then
												self.theTable.args[a].args[c].args[e].args[g].args[i] = {
													name = "|cFFFF2222["..id.."]",
													desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
													order = tonumber(i),
													type = 'execute',
													func = function()
														if tonumber(id) then
															GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
															GameTooltip:SetHyperlink("item:" .. id)
															GameTooltip:Hide()
															WhoDrop:Construct()
															collectgarbage()
															waterfall:Refresh("WhoDrop")
														end
													 end,
												}
												if WhoDrop.db.profile.always then								
													self.theTable.args[a].args[c].args[e].args[g].args[i].link = "item:" .. id
												end
											else
												if AD == "U" or CD == "U" or ED == "U" or GD == "U" then order = tonumber(i) else order = 6 - tonumber(rarity) end
													self.theTable.args[a].args[c].args[e].args[g].args[i] = {
														name = qualitycolors[rarity].."["..n.."]",
														desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
														order = order,
														type = 'execute',
														link = link,
														func = function() 
															if IsControlKeyDown() then
																DressUpItemLink("item:" .. id);
															elseif IsShiftKeyDown() then
																if not ChatFrameEditBox:IsVisible() then
																	ChatFrameEditBox:Show()
																end
																ChatFrameEditBox:Insert(link)
															elseif IsAltKeyDown() then
																self.PasteDropInfo(link)
															else
																ShowUIPanel(ItemRefTooltip)
																if not ItemRefTooltip:IsVisible() then
																	ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																end
																ItemRefTooltip:SetHyperlink(link)
															end
														end,
													}
												end
											end
										end
									end
								end
							end
						end
					end
			end
		end
	end
	collectgarbage()
	waterfall:Refresh("WhoDrop")
end

function WhoDrop:reBuild()
	waterfall:Close("WhoDrop")
	self:Construct()
	waterfall:Register("WhoDrop", "title", "WhoDrop", 'treeType', "TREE", "aceOptions", self.theTable, "colorR", 0.2, "colorG", 0.8, "colorB", 0.2)
end
function WhoDrop:OnClick()
	if waterfall:IsOpen("WhoDrop") then
		waterfall:Close("WhoDrop")
	else
		waterfall:Open("WhoDrop")
	end
end

function WhoDrop:OnTooltipUpdate()
	AceLibrary("Tablet-2.0"):SetHint(L["Click To Open GUI"])
end 

function WhoDrop.ProcessTooltip(tooltip, name, link)
	local _, _, itemid = strfind(link, "item:(%d+):")
	if itemid then
		itemid = tonumber(itemid)
		WhoDrop:AddInfoToTooltip(itemid, tooltip)
	end
	tooltip:Show()
end

function WhoDrop.PasteDropInfo(link)
	if WhoDropData then
		local _, _, itemid = strfind(link, "item:(%d+):")
		 _, link = GetItemInfo(itemid)
		local text = ""
		for a, b in pairs(WhoDropData) do
			local AN, AD, CN, CD, EN, ED, GN, GD
			AN, AD = self:Seperate(a)
			for c, d in pairs(b) do
				CN, CD = self:Seperate(c)
				for e, f in pairs(d) do
					EN, ED = self:Seperate(e)
					for g, h in pairs(f) do
						GN, GD = self:Seperate(g)
						for i, j in pairs(h) do
							if ( string.find(a, "Quest Reward") ) then
								IN, ID = self:Seperate(i)
								for k, l in pairs(j) do
									id, Desc = self:FindDesc(l)
									if type(id) == "number" and tonumber(itemid) == tonumber(id) then
										if (GD == "H" or GD == "A") and GD ~= UFaction and not self.db.profile.opp  then
											break;
										end
										if (ED == "H" or ED == "A") and ED ~= UFaction and not self.db.profile.opp  then
											break;
										end
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text..self:FindLocal(GN).." : "..self:FindLocal(IN).."<"..self:FindLocal(EN)..">"..Desc
									end
								end
							else
								local id, Desc = self:FindDesc(j)
								if type(id) == "number" and tonumber(itemid) == tonumber(id) then
									if (ED == "H" or ED == "A") and ED ~= UFaction and not self.db.profile.opp  then
										break;
									end
									if (CD == "H" or CD == "A") and CD ~= UFaction and not self.db.profile.opp  then
										break;
									end
									if string.find(c, "|E") or string.find(e, "|E") or string.find(g, "|E") then

									elseif string.find(c, "Instance") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text..self:FindLocal(GN).."<"..self:FindLocal(EN)..">"..Desc
									elseif string.find(a, "Reputaion") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " ( "..Desc.." )"
										end
										text = text..self:FindLocal(EN).." - "..self:FindLocal(GN)..Desc
									elseif string.find(a, "PvP") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text..self:FindLocal(CN).."( "..self:FindLocal(EN)..Desc.." )"
									elseif string.find(a, "Exchange") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text..self:FindLocal(EN).."( "..self:FindLocal(CN)..Desc.." )"
									else
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text..self:FindLocal(EN).." : "..self:FindLocal(GN).."<"..self:FindLocal(CN)..">"..Desc
									end
								end
							end
						end
					end
				end
			end
		end
		collectgarbage()
		if text ~= "" then
			if not ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Show()
			end
			ChatFrameEditBox:Insert(link.." WD:"..text)
		end
	end
end

function WhoDrop:AddInfoToTooltip(itemid, tooltip)

	if WhoDropData then
		if TempTable[itemid] then
			if TempTable[itemid] ~= "" then
				tooltip:AddLine(TempTable[itemid], 1.0, 1.0, 0, 1)
			end
			return;
		end

		local text = ""
		for a, b in pairs(WhoDropData) do
			local AN, AD, CN, CD, EN, ED, GN, GD, IN, ID
			AN, AD = self:Seperate(a)
			for c, d in pairs(b) do
				CN, CD = self:Seperate(c)
				for e, f in pairs(d) do
					EN, ED = self:Seperate(e)
					for g, h in pairs(f) do
						GN, GD = self:Seperate(g)
						for i, j in pairs(h) do
							if ( string.find(a, "Quest Reward") ) then
								IN, ID = self:Seperate(i)
								for k, l in pairs(j) do
									id, Desc = self:FindDesc(l)
									if type(id) == "number" and tonumber(itemid) == tonumber(id) then
										if text ~= "" then
											text = text.."\n"
										end
										if (GD == "H" or GD == "A") and GD ~= UFaction and not self.db.profile.opp  then
											break;
										end
										if (ED == "H" or ED == "A") and ED ~= UFaction and not self.db.profile.opp  then
											break;
										end
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text.."WD:"..CC[GD]..self:FindLocal(GN).."|r : "..self:FindLocal(IN).."<"..self:FindLocal(EN)..">"..Desc
									end
								end
							else
								local id, Desc = self:FindDesc(j)
								if type(id) == "number" and tonumber(itemid) == tonumber(id) then
									if text ~= "" then
										text = text.."\n"
									end
									if (ED == "H" or ED == "A") and ED ~= UFaction and not self.db.profile.opp  then
										break;
									end
									if (CD == "H" or CD == "A") and CD ~= UFaction and not self.db.profile.opp  then
										break;
									end
									if string.find(c, "|E") or string.find(e, "|E") or string.find(g, "|E") then

									elseif string.find(a, "Instance") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = "\n"..Desc
										end
										text = text.."WD:"..CC[GD]..self:FindLocal(GN).."|r<"..CC[ED]..self:FindLocal(EN).."|r>"..Desc
									elseif string.find(a, "Reputaion") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " ( "..Desc.." )"
										end
										text = text.."WD:"..CC[ED]..self:FindLocal(EN).."|r - "..CC[GD]..self:FindLocal(GN).."|r"..Desc
									elseif string.find(a, "PvP") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text.."WD:"..CC[CD]..self:FindLocal(CN).."|r( "..CC[ED]..self:FindLocal(EN).."|r"..Desc.." )"
									elseif string.find(a, "Exchange") then
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text.."WD:"..CC[ED]..self:FindLocal(EN).."|r( "..CC[CD]..self:FindLocal(CN).."|r"..Desc.." )"
									else
										if type(Desc) ~= "boolean" and strlen(Desc) > 0 then
											Desc = " - "..Desc
										end
										text = text.."WD:"..CC[ED]..self:FindLocal(EN).."|r : "..self:FindLocal(GN).."<"..self:FindLocal(CN)..">"..Desc
									end
								end
							end
						end
					end
				end
			end
		end
		tooltip:AddLine(text, 1.0, 1.0, 0, 1)

		if itemid then
			TempTable[itemid] = text
		end
	end
end

function WhoDrop:Searching(value)

	if WhoDropData then
		local SearchingTable = {type = "group", args = {}}
		local num = 0
		for a, b in pairs(WhoDropData) do
			local AN, AD, CN, CD, EN, ED, GN, GD, IN, ID
			AN, AD = self:Seperate(a)
			for c, d in pairs(b) do
				CN, CD = self:Seperate(c)
				for e, f in pairs(d) do
					EN, ED = self:Seperate(e)
					for g, h in pairs(f) do
						GN, GD = self:Seperate(g)
						for i, j in pairs(h) do
							if ( string.find(a, "Quest Reward") ) then
								IN, ID = self:Seperate(i)
								for k, l in pairs(j) do
									local id, Desc = self:FindDesc(l)
									if type(id) == "number" then
										local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
										if value and (tonumber(value) == tonumber(id) or ( link  and ( string.find(n, value) ) or string.find(self:FindLocal(GN), value) or string.find(self:FindLocal(IN), value)) ) then

											if not ( ( ( ( GD == "H" or GD == "A" ) and GD ~= UFaction ) or ( ( ED == "H" or ED == "A" ) and ED ~= UFaction ) ) and not WhoDrop.db.profile.opp ) then

												Desc = "\n"..CC[GD]..self:FindLocal(GN).."|r<"..self:FindLocal(EN)..">"..(Desc and "\n"..Desc)

												if not SearchingTable.args[value] then
													SearchingTable.args[value] = {type = "group", args = {}}
												end
												if not link  then
													if not SearchingTable.args[value].args[id] then
														SearchingTable.args[value].args[id] = {
															name = "|cFFFF2222["..id.."]",
															desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
															order = tonumber(k),
															type = 'execute',
															func = function()
																if tonumber(id) then
																	GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
																	GameTooltip:SetHyperlink("item:" .. id)
																	GameTooltip:Hide()
																	WhoDrop:Construct()
																	collectgarbage()
																	waterfall:Refresh("WhoDrop Searching")
																end
															 end,
														}
														if WhoDrop.db.profile.always then								
															SearchingTable.args[value].args[id].link = "item:" .. id
														end
														num = num + 1
													end
												else
													if not SearchingTable.args[value].args[id] then
														SearchingTable.args[value].args[id] = {
															name = qualitycolors[rarity].."["..n.."]",
															desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
															order = 6 - tonumber(rarity),
															type = 'execute',
															link = link,
															func = function() 	
																if IsControlKeyDown() then
																	DressUpItem(id)
																elseif IsShiftKeyDown() then
																	if not ChatFrameEditBox:IsVisible() then
																		ChatFrameEditBox:Show()
																	end
																	ChatFrameEditBox:Insert(link)
																elseif IsAltKeyDown() then
																	self.PasteDropInfo(link)
																else
																	ShowUIPanel(ItemRefTooltip)
																	if not ItemRefTooltip:IsVisible() then
																		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																	end
																	ItemRefTooltip:SetHyperlink(link)
																end
															end,
														}
														num = num + 1
													end
												end
											end
										end
									end
								end
							else
								local id, Desc = self:FindDesc(j)
								if type(id) == "number" then
									local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
									if value and (tonumber(value) == tonumber(id) or ( link  and ( string.find(n, value) ) or string.find(self:FindLocal(EN), value) or string.find(self:FindLocal(GN), value)) ) then

										if not ( ( ( ( ED == "H" or ED == "A" ) and ED ~= UFaction ) or ( ( CD == "H" or CD == "A" ) and CD ~= UFaction ) ) and not WhoDrop.db.profile.opp ) then

											if string.find(c, "Instance") then
												Desc = "\n"..CC[GD]..self:FindLocal(GN).."|r<"..CC[ED]..self:FindLocal(EN).."|r>"..(Desc and "\n"..Desc)
											elseif string.find(a, "Reputaion") then
												Desc = "\n"..CC[ED]..self:FindLocal(EN).."|r - "..CC[GD]..self:FindLocal(GN).."|r"..(Desc and " ( "..Desc.." )")
											elseif string.find(a, "PvP") then
												Desc = "\n"..CC[CD]..self:FindLocal(CN).."|r( "..CC[ED]..self:FindLocal(EN).."|r"..(Desc and " - "..Desc)..")"
											elseif string.find(a, "Exchange") then
												Desc = "\n"..CC[ED]..self:FindLocal(EN).."|r( "..CC[CD]..self:FindLocal(CN).."|r"..(Desc and " - "..Desc)..")"
											else
												Desc = "\n"..CC[ED]..self:FindLocal(EN).."|r<"..self:FindLocal(CN)..">"..(Desc and "\n"..Desc)
											end
											if not SearchingTable.args[value] then
												SearchingTable.args[value] = {type = "group", args = {}}
											end
											if not link  then
												if not SearchingTable.args[value].args[id] then
													SearchingTable.args[value].args[id] = {
														name = "|cFFFF2222["..id.."]",
														desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
														order = tonumber(i),
														type = 'execute',
														func = function()
															if tonumber(id) then
																GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
																GameTooltip:SetHyperlink("item:" .. id)
																GameTooltip:Hide()
																WhoDrop:Construct()
																collectgarbage()
																waterfall:Refresh("WhoDrop Searching")
															end
														 end,
													}
													if WhoDrop.db.profile.always then								
														SearchingTable.args[value].args[id].link = "item:" .. id
													end
													num = num + 1
												end
											else
												if not SearchingTable.args[value].args[id] then
													SearchingTable.args[value].args[id] = {
														name = qualitycolors[rarity].."["..n.."]",
														desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
														order = 6 - tonumber(rarity),
														type = 'execute',
														link = link,
														func = function() 	
															if IsControlKeyDown() then
																DressUpItem(id)
															elseif IsShiftKeyDown() then
																if not ChatFrameEditBox:IsVisible() then
																	ChatFrameEditBox:Show()
																end
																ChatFrameEditBox:Insert(link)
															elseif IsAltKeyDown() then
																self.PasteDropInfo(link)
															else
																ShowUIPanel(ItemRefTooltip)
																if not ItemRefTooltip:IsVisible() then
																	ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																end
																ItemRefTooltip:SetHyperlink(link)
															end
														end,
													}
													num = num + 1
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if SearchingTable.args[value] then
			SearchingTable.args[value].name = format(L["Searching Result %d"], num)
			waterfall:Register("WhoDrop Searching", "title", L["WhoDrop Searching Result: "]..value, 'treeType', "TREE", "aceOptions", SearchingTable, "colorR", 0.2, "colorG", 0.8, "colorB", 0.2)
			waterfall:Open("WhoDrop Searching")
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff0070ddWhoDrop:|r|cff1eff00"..L["No searching result"])
		end
		collectgarbage()
	end
end


function WhoDrop:SearchingInstance()
	local value, type
	if UnitName("target") and not UnitIsPlayer("target") then
		value = UnitName("target")
	elseif  IsInInstance() then
		value = GetRealZoneText()
		InsType = tonumber(GetCurrentDungeonDifficulty())
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cff0070ddWhoDrop:|r|cff1eff00"..L["you target mob or you is in instance"])
		return
	end

	if WhoDropData then
		local SearchingTable = {type = "group", args = {}}
		local num = 0
		for a, b in pairs(WhoDropData) do
			local AN, AD, CN, CD, EN, ED, GN, GD
			AN, AD = self:Seperate(a)
			for c, d in pairs(b) do
				CN, CD = self:Seperate(c)
				for e, f in pairs(d) do
					if InsType and InsType < 2 and string.find(e, "-Hero") then

					else
						EN, ED = self:Seperate(e)
						for g, h in pairs(f) do
							GN, GD = self:Seperate(g)
							for i, j in pairs(h) do
								if ( string.find(a, "Quest Reward") ) then
									IN, ID = self:Seperate(i)
									for k, l in pairs(j) do
										local id, Desc = self:FindDesc(l)
										if id and id ~= nil and tonumber(id) then
											local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
											local zone
											zone = self:FindLocal(EN)
											if zone == value or self:FindLocal(GN) == value then

												if not ( ( GD == "H" or GD == "A" ) and ED ~= UFaction and not WhoDrop.db.profile.opp ) then

													Desc = "\n"..CC[GD]..self:FindLocal(GN).."|r<"..self:FindLocal(EN)..">"..(Desc and "\n"..Desc)
													if not SearchingTable.args[value] then
														SearchingTable.args[value] = {type = "group", args = {}}
													end
													if not link  then
														if not SearchingTable.args[value].args[id] then
															SearchingTable.args[value].args[id] = {
																name = "|cFFFF2222["..id.."]",
																desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
																order = tonumber(k),
																type = 'execute',
																func = function()
																	if tonumber(id) then
																		GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
																		GameTooltip:SetHyperlink("item:" .. id)
																		GameTooltip:Hide()
																		WhoDrop:Construct()
																		collectgarbage()
																		waterfall:Refresh("WhoDrop Searching")
																	end
																 end,
															}
															if WhoDrop.db.profile.always then								
																SearchingTable.args[value].args[id].link = "item:" .. id
															end
															num = num + 1
														end
													else
														if not SearchingTable.args[value].args[id] then
															SearchingTable.args[value].args[id] = {
																name = qualitycolors[rarity].."["..n.."]",
																desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
																order = 6 - tonumber(rarity),
																type = 'execute',
																link = link,
																func = function() 	
																	if IsControlKeyDown() then
																		DressUpItem(id)
																	elseif IsShiftKeyDown() then
																		if not ChatFrameEditBox:IsVisible() then
																			ChatFrameEditBox:Show()
																		end
																		ChatFrameEditBox:Insert(link)
																	elseif IsAltKeyDown() then
																		self.PasteDropInfo(link)
																	else
																		ShowUIPanel(ItemRefTooltip)
																		if not ItemRefTooltip:IsVisible() then
																			ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																		end
																		ItemRefTooltip:SetHyperlink(link)
																	end
																end,
															}
															num = num + 1
														end
													end
												end
											end
										end
									end
								else

									local id, Desc = self:FindDesc(j)
									if id and id ~= nil and tonumber(id) then
										local n, link, rarity, _,_,_,_,_,_, texture = GetItemInfo(id)
										local zone
										if string.find(self:FindLocal(EN), L["Hero"]) then
											zone = string.sub(self:FindLocal(EN), 1, strlen(self:FindLocal(EN))-strlen(L["Hero"])-2)
										else
											zone = self:FindLocal(EN)
										end
										if zone == value or self:FindLocal(GN) == value then

											if not ( ( ED == "H" or ED == "A" ) and ED ~= UFaction and not WhoDrop.db.profile.opp ) then

												if string.find(c, "Instance") then
													Desc = "\n"..CC[GD]..self:FindLocal(GN).."|r<"..CC[ED]..self:FindLocal(EN).."|r>"..(Desc and "\n"..Desc)
												elseif string.find(a, "Reputaion") then
													Desc = "\n"..CC[ED]..self:FindLocal(EN).."|r - "..CC[GD]..self:FindLocal(GN).."|r"..(Desc and " ( "..Desc.." )")
												elseif string.find(a, "PvP") then
													Desc = "\n"..CC[CD]..self:FindLocal(CN).."|r( "..CC[ED]..self:FindLocal(EN).."|r"..(Desc and " - "..Desc)
												else
													Desc = "\n"..CC[ED]..self:FindLocal(EN).."|r<"..self:FindLocal(CN)..">"..(Desc and "\n"..Desc)
												end
												if not SearchingTable.args[value] then
													SearchingTable.args[value] = {type = "group", args = {}}
												end
												if not link  then
													if not SearchingTable.args[value].args[id] then
														SearchingTable.args[value].args[id] = {
															name = "|cFFFF2222["..id.."]",
															desc = L["Item not found, click to query server.\n|cFFFF2222WARNING: This WILL disconnect you if the server has not seen the item.|r"].."\n|CFFFFFFFFItemID:"..id.."|r"..Desc,
															order = tonumber(i),
															type = 'execute',
															func = function()
																if tonumber(id) then
																	GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
																	GameTooltip:SetHyperlink("item:" .. id)
																	GameTooltip:Hide()
																	WhoDrop:Construct()
																	collectgarbage()
																	waterfall:Refresh("WhoDrop Searching")
																end
															 end,
														}
														if WhoDrop.db.profile.always then								
															SearchingTable.args[value].args[id].link = "item:" .. id
														end
														num = num + 1
													end
												else
													if not SearchingTable.args[value].args[id] then
														SearchingTable.args[value].args[id] = {
															name = qualitycolors[rarity].."["..n.."]",
															desc = "|CFFFFFFFFItemID:"..id.."|r"..Desc,
															order = 6 - tonumber(rarity),
															type = 'execute',
															link = link,
															func = function() 	
																if IsControlKeyDown() then
																	DressUpItem(id)
																elseif IsShiftKeyDown() then
																	if not ChatFrameEditBox:IsVisible() then
																		ChatFrameEditBox:Show()
																	end
																	ChatFrameEditBox:Insert(link)
																elseif IsAltKeyDown() then
																	self.PasteDropInfo(link)
																else
																	ShowUIPanel(ItemRefTooltip)
																	if not ItemRefTooltip:IsVisible() then
																		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
																	end
																	ItemRefTooltip:SetHyperlink(link)
																end
															end,
														}
														num = num + 1
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if SearchingTable.args[value] then
			SearchingTable.args[value].name = format(L["Searching Result %d"], num)
			waterfall:Register("WhoDrop Searching", "title", L["WhoDrop Searching Result: "]..value, 'treeType', "TREE", "aceOptions", SearchingTable, "colorR", 0.2, "colorG", 0.8, "colorB", 0.2)
			waterfall:Open("WhoDrop Searching")
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff0070ddWhoDrop:|r|cff1eff00"..L["No searching result"])
		end
		collectgarbage()
	end
end

