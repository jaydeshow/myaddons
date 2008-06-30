local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")
local PT = LibStub("LibPeriodicTable-3.1")

local _G = getfenv(0)

-- We cache the results, so that we don't have to do a PT lookup for every item.
local cache = {}
local scanned = {}

Mendeleev = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "AceEvent-2.0")
local Mendeleev		= Mendeleev
local GetItemInfo	= _G.GetItemInfo

local ipairs		= _G.ipairs
local pairs			= _G.pairs
local type			= _G.type

local string_format	= _G.string.format
local string_match	= _G.string.match
local string_rep	= _G.string.rep

local table_insert	= _G.table.insert
local table_sort	= _G.table.sort

local options = {
	type = "group",
	args = {
		sets = {
			name = L["Toggle sets."],
			desc = L["Toggle sets from showing information in the tooltip."],
			type = "group",
			args = {},
		},
		itemLevel = {
			type = "toggle",
			name = L["Show item level"],
			desc = L["Toggle showing the item level in the tooltip."],
			get = function() return Mendeleev.db.profile.showItemLevel end,
			set = function(v) Mendeleev.db.profile.showItemLevel = v end,
		},
		itemId = {
			type = "toggle",
			name = L["Show item identifier"],
			desc = L["Toggle showing the item identifier in the tooltip."],
			get = function() return Mendeleev.db.profile.showItemID end,
			set = function(v) Mendeleev.db.profile.showItemID = v end,
		},
		itemCount = {
			type = "toggle",
			name = L["Show item count"],
			desc = L["Toggle showing the item count in the tooltip."],
			get = function() return Mendeleev.db.profile.showItemCount end,
			set = function(v) Mendeleev.db.profile.showItemCount = v end,
		},
		stackSize = {
			type = "toggle",
			name = L["Show stack size"],
			desc = L["Toggle showing the stack size in the tooltip."],
			get = function() return Mendeleev.db.profile.showStackSize end,
			set = function(v) Mendeleev.db.profile.showStackSize = v end,
		},
		usedInTree = {
			type = "toggle",
			name = L["Show 'used in' tree"],
			desc = L["Toggle showing the 'used in' tree in the tooltip."],
			get = function() return Mendeleev.db.profile.showUsedInTree end,
			set = function(v) Mendeleev.db.profile.showUsedInTree = v end,
		},
		usedInTreeSelf = {
			type = "toggle",
			name = L["Limit 'used in' tree to craftable"],
			desc = L["Toggle limiting the 'used in' tree to items the char can craft."],
			get = function() return Mendeleev.db.profile.limitUsedInTree end,
			set = function(v) Mendeleev.db.profile.limitUsedInTree = v end,
		},
		usedInTreeIcons = {
			type = "toggle",
			name = L["Show icons in 'used in' tree"],
			desc = L["Toggle showing of icons in the 'used in' tree."],
			get = function() return Mendeleev.db.profile.UsedInTreeIcons end,
			set = function(v) Mendeleev.db.profile.UsedInTreeIcons = v end,
		},
	},
}

function Mendeleev:OnInitialize()
	self.title = "Mendeleev"
	self.revision = tonumber(("$Revision: 77433 $"):match("%d+"))
	self.version = self.version .. "." .. self.revision
	
	_G.MENDELEEV_TITLE = self.title
	_G.MENDELEEV_VERSION = self.version
	_G.MENDELEEV_DATE = self.date

	self:RegisterDB("MendeleevDB")
	self:RegisterDefaults("profile", {
		showItemLevel = false,
		showItemID = false,
		showItemCount = false,
		showStackSize = true,
		showUsedInTree = true,
		limitUsedInTree = false,
		UsedInTreeIcons = true,
		sets = {},
	})

	local t = options.args.sets.args

	for _, v in ipairs(MENDELEEV_SETS) do
		local key = v.setindex
		local period = select(2, key:find("%.")) or 0
		local parent = key:sub(1, period - 1)
		if not t[parent] then
			t[parent] = {
				name = L[parent],
				desc = string_format(L["Toggle sets in the %s category."], L[parent]),
				type = "group",
				args = {},
			}
		end
		t[parent].args[key] = {
			name = v.name,
			desc = string_format(L["Toggle %s."], v.name),
			type = "toggle",
			get  = function() return not self.db.profile.sets[key] end,
			set  = function(val) self.db.profile.sets[key] = not val cache = {} scanned = {} end,
		}
	end

	self:RegisterChatCommand("/mendeleev", options, "MENDELEEV")
end

function Mendeleev:OnEnable(first)
	self:HookScript(GameTooltip, "OnTooltipSetItem")
	self:HookScript(GameTooltip, "OnTooltipCleared")
	self:HookScript(ItemRefTooltip, "OnTooltipSetItem")
	self:HookScript(ItemRefTooltip, "OnTooltipCleared")
	self:HookScript(ShoppingTooltip1, "OnTooltipSetItem")
	self:HookScript(ShoppingTooltip1, "OnTooltipCleared")
	self:HookScript(ShoppingTooltip2, "OnTooltipSetItem")
	self:HookScript(ShoppingTooltip2, "OnTooltipCleared")
	
	if AtlasLootTooltip then
		self:HookScript(AtlasLootTooltip, "OnTooltipSetItem")
		self:HookScript(AtlasLootTooltip, "OnTooltipCleared")
	end

	if first then
		-- load our sets into the cache
		for _,v in ipairs(MENDELEEV_SETS) do
			PT:GetSetTable(v.setindex)
		end
		collectgarbage()
	end

	self:RegisterEvent("TRADE_SKILL_SHOW", "ScanTradeSkill")
	self:RegisterEvent("CRAFT_SHOW", "ScanCraft")
end

-- function Mendeleev:OnDisable()
-- end

function Mendeleev:GetUsedInTable(skill, reagentid)
	local ret
	local ptrmr = PT:GetSetTable("TradeskillResultMats.Reverse." .. skill)
	if PT:IsSetMulti("TradeskillResultMats.Reverse." .. skill) then
		for k, v in ipairs(ptrmr) do
			if type(v) == "table" then
				local guit = self:GetUsedInTable(v.set, reagentid)
				if guit then
					if not ret then 
						ret = {}
					end
					for k, v in pairs(guit) do
						ret[k] = v
					end
				end
			end
		end
	else
		local usedin = ptrmr and ptrmr[tonumber(reagentid)]
		if usedin then
			for item, num in usedin:gmatch("(%d+)x(%d+)") do
				item = tonumber(item)
				num = tonumber(num)
				if not ret then 
					ret = {}
				end
				ret[item] = num
			end
		end
	end
	return ret
end

local tradeskillNames = {
	["Alchemy"] = GetSpellInfo(2259),
	["Blacksmithing.Armorsmith"] = GetSpellInfo(9788),
	["Blacksmithing.Basic"] = GetSpellInfo(2018),
	["Blacksmithing.Weaponsmith.Axesmith"] = GetSpellInfo(17041),
	["Blacksmithing.Weaponsmith.Basic"] = GetSpellInfo(9787),
	["Blacksmithing.Weaponsmith.Hammersmith"] = GetSpellInfo(17040),
	["Blacksmithing.Weaponsmith.Swordsmith"] = GetSpellInfo(17039),
	["Cooking"] = GetSpellInfo(2550),
	["Enchanting"] = GetSpellInfo(7411),
	["Engineering.Basic"] = GetSpellInfo(4036),
	["Engineering.Gnomish"] = GetSpellInfo(20220),
	["Engineering.Goblin"] = GetSpellInfo(20221),
	["First Aid"] = GetSpellInfo(3273),
	["Jewelcrafting"] = GetSpellInfo(25229),
	["Leatherworking.Basic"] = GetSpellInfo(2108),
	["Leatherworking.Dragonscale"] = GetSpellInfo(10657),
	["Leatherworking.Elemental"] = GetSpellInfo(10659),
	["Leatherworking.Tribal"] = GetSpellInfo(10661),
	["Poisons"] = GetSpellInfo(2842),
	["Smelting"] = GetSpellInfo(2575),
	["Tailoring.Basic"] = GetSpellInfo(3908),
	["Tailoring.Mooncloth"] = GetSpellInfo(26798),
	["Tailoring.Shadoweave"] = GetSpellInfo(26801),
	["Tailoring.Spellfire"] = GetSpellInfo(26797),
}

function Mendeleev:GetLinesForTradeskillReagent(skill, reagent)
	if type(skill) ~= "string" or type(reagent) ~= "string" then return end
	local id = reagent:match("^|%x+|Hitem:(%d+):")
	local ret = {}
	local count = 0
	local db = self.db.profile
	for item, num in pairs(self:GetUsedInTable(skill, id) or {}) do
		count = count + 1
		local name = GetItemInfo(item) or item
		if name then
			table_insert(ret, string_format("%s (%s)", name, num))
		end
	end
	if count > 0 then
		return ("%s (%d)"):format(tradeskillNames[skill], count)
	end
	return ret
end

local cacheUsedInFull = {}

local id2skill = setmetatable({}, {__index = function(self, key) local value = -1; self[key] = value; return value end})
--local id2skill = {}

local tradeskills = {
	"Alchemy",
	"Blacksmithing.Armorsmith",
	"Blacksmithing.Basic",
	"Blacksmithing.Weaponsmith.Axesmith",
	"Blacksmithing.Weaponsmith.Basic",
	"Blacksmithing.Weaponsmith.Hammersmith",
	"Blacksmithing.Weaponsmith.Swordsmith",
	"Cooking",
	"Engineering.Basic",
	"Engineering.Gnomish",
	"Engineering.Goblin",
	"First Aid",
	"Jewelcrafting",
	"Leatherworking.Basic",
	"Leatherworking.Dragonscale",
	"Leatherworking.Elemental",
	"Leatherworking.Tribal",
	"Poisons",
	"Smelting",
	"Tailoring.Basic",
	"Tailoring.Mooncloth",
	"Tailoring.Shadoweave",
	"Tailoring.Spellfire",
}

local function SortUsedInTree(a,b)
	if (not a or not b) then
		return true
	end
	if (a[3] > b[3]) then
		return true
	end
	if (a[3] < b[3]) then
		return false
	end
	return (a[2] and b[2] and (a[2] < b[2]))
end

function Mendeleev:GetUsedInFullTable(id)
	if cacheUsedInFull[id] == nil then
		for _, skill in ipairs(tradeskills) do
			local usedin = self:GetUsedInTable(skill, id)
			if usedin then
				for item, num in pairs(usedin) do
					 if not cacheUsedInFull[id] then 
						cacheUsedInFull[id] = {}
					end
					cacheUsedInFull[id][item] = num
				end
			end
		end
		if not cacheUsedInFull[id] then
			cacheUsedInFull[id] = false
		end
	end
	return cacheUsedInFull[id]
end

function Mendeleev:GetUsedInTree(id, history)
	local data = {}
	local skill = id2skill[id] or 0
	local usedin = self:GetUsedInFullTable(id)
	if usedin then
		for k, v in pairs(usedin) do
			if id2skill[k] and ((IsShiftKeyDown() or not self.db.profile.limitUsedInTree) or id2skill[k] >= 0) then
				if history:find(">"..k.."<") then
					table_insert(data, {k, GetItemInfo(k) or false, id2skill[k], "..."})
				else
					local tdata, tskill = self:GetUsedInTree(k, history..">"..k.."<")
					if tskill > skill then
						skill = tskill
					end
					table_insert(data, tdata)
				end
			end
		end
	end
	table_sort(data, SortUsedInTree)
	table_insert(data, 1, id)
	table_insert(data, 2, GetItemInfo(id) or false)
	table_insert(data, 3, skill)
	return data, skill
end

function Mendeleev:GetUsedInList(tree, level, counttable, countmult)
	local colour = {
		[-1] = "|cffff0000",
		[0] = "|cffbbbbbb",
		[1] = "|cff00cc00",
		[2] = "|cffffff00",
		[3] = "|cffff6600",
		[4] = "|cffff0000",
	}

	local UsedInTreeIcons = self.db.profile.UsedInTreeIcons

	local list = {}
	local didpoints = false
	for i = 4, #tree do
		local v = tree[i]
		if level < 2 or v[3] > 0 then
			if UsedInTreeIcons then
				local icontag = GetItemIcon(v[1])
				icontag = icontag and "|T"..icontag..":10|t " or ""
				table_insert(list, string_rep("    ", level).."- "..colour[id2skill[v[1]] or -1]..icontag..(v[2] or v[1]).."|r")
			else
				table_insert(list, string_rep("    ", level).."- "..colour[id2skill[v[1]] or -1]..(v[2] or v[1]).."|r")
			end
			table_insert(list, countmult * counttable[v[1]])
			if type(v[4]) == "table" then
				local slist = self:GetUsedInList(v, level+1, cacheUsedInFull[v[1]], countmult * counttable[v[1]])
				if #slist > 0 then
					if v[3] > 0 then
						for _, line in pairs(slist) do
							table_insert(list, line)
						end
					else
						table_insert(list, string_rep("    ", level+1).."- "..colour[0].."...|r")
						table_insert(list, "")
					end
				end
			elseif v[4] == "..." then
				table_insert(list, string_rep("    ", level+1).."...")
				table_insert(list, "")
			end
		elseif v[3] == 0 and not didpoints then
			table_insert(list, string_rep("    ", level).."- "..colour[0].."...|r")
			table_insert(list, "")
			didpoints = true
		end
	end
	return list
end

local skillquals = {trivial = 0, easy = 1, medium = 2, optimal = 3, difficult = 4}

function Mendeleev:ScanTradeSkill()
	if TradeSkillFrame ~= nil and TradeSkillFrame:IsVisible() then
		for i=1, GetNumTradeSkills() do
			local _, type, _, _ = GetTradeSkillInfo(i)
			if type ~= "header" then
				local item = GetTradeSkillItemLink(i)
				if item then
					local id = string_match(item, "item:(%d+):")
					if id then
						id2skill[tonumber(id)] = skillquals[type]
					end
				end
			end
		end
	end
end

function Mendeleev:ScanCraft()
	if CraftFrame ~= nil and CraftFrame:IsVisible() then
		for i=1, GetNumCrafts() do
			local _, type, _, _ = GetCraftInfo(i)
			if type ~= "header" then
				local item = GetCraftItemLink(i)
				if item then
					local id = string_match(item, "enchant:(%d+):")
					if id then
						id2skill[tonumber(id)] = skillquals[type]
					end
				end
			end
		end
	end
end

function Mendeleev:OnTooltipSetItem(tooltip, ...)
	local item = select(2, tooltip:GetItem())
	if tooltip.Mendeleev_data_added or not item or not GetItemInfo(item) then return self.hooks[tooltip].OnTooltipSetItem(tooltip, ...) end
	local quality,iLevel,_,_,_,stack = select(3, GetItemInfo(item))
	local db = self.db.profile

	if not scanned[item] then
		for _,v in ipairs(MENDELEEV_SETS) do
			if not db.sets[v.setindex] and quality >= v.quality then
				local lines = nil
				local c = v.colour or "|cffffffff"
				for set,desc in pairs(v.sets) do
					local val = PT:ItemInSet(item,set)
					if val then
						if not lines then lines = {} end
						if type(v.descfunc) == "function" then
							local ret = v.descfunc(desc, item, val)
							if type(ret) == "table" then
								for i, v in ipairs(ret) do
									table_insert(lines, c .. ret[i] .. "|r")
								end
							elseif type(ret) == "string" then
								table_insert(lines, c .. ret .. "|r")
							end
						else
							table_insert(lines, c .. desc .. (type(val) ~= "boolean" and v.useval and v.useval(val, link) or "") .. "|r")
						end
					end
				end
				if lines then
					table_sort(lines)
					if not cache[item] then cache[item] = {} end
					cache[item][v.setindex] = {c .. v.header .. "|r", lines}
				end
			end
		end
		scanned[item] = true
	end

	if cache[item] then
		for k, v in pairs(cache[item]) do
			local first = 1
			for i, line in ipairs(v[2]) do
				if first == 1 then
					tooltip:AddDoubleLine(v[1], line)
					first = 0
				else
					tooltip:AddDoubleLine(" ", line)
				end
			end
		end
	end

	if db.showItemCount then
		local count = GetItemCount(item, false)
		local bankcount = GetItemCount(item, true) - count
		if count + bankcount > 0 then
			tooltip:AddDoubleLine(L["You have"], count..(bankcount > 0 and (" (+"..bankcount..")") or ""))
		end
	end

	if stack and stack > 1 and db.showStackSize then
		tooltip:AddDoubleLine(L["Stacksize"], stack)
	end

	if db.showItemID then
		local id = item:match("^|%x+|Hitem:(%d+):")
		if id then
			tooltip:AddDoubleLine(L["Item ID"], id)
		end
	end

	if iLevel and db.showItemLevel then
		tooltip:AddDoubleLine(L["iLevel"], iLevel)
	end

	if db.showUsedInTree then
		local id = item:match("^|%x+|Hitem:(%d+):")
		local t = Mendeleev:GetUsedInTree(id, ">"..id.."<")
		local l = Mendeleev:GetUsedInList(t, 1, cacheUsedInFull[id], 1)
		local header = L["Used in"]
		for i = 1, #l, 2 do
			if header then
				tooltip:AddLine(header)
				header = nil
			end
			tooltip:AddDoubleLine(l[i], l[i+1])
		end
	end

	tooltip.Mendeleev_data_added = true
	return self.hooks[tooltip].OnTooltipSetItem(tooltip, ...)
end

function Mendeleev:OnTooltipCleared(tooltip, ...)
	tooltip.Mendeleev_data_added = nil
	return self.hooks[tooltip].OnTooltipCleared(tooltip, ...)
end
