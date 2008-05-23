
local Table1;
local L = TDITEMTIP_LOCALE
local _G = getfenv(0)

if (GetLocale() == "zhCN") then
Table1 = {
	["防御等级"] = 6,
	["躲闪等级"] = 7,
	["格挡等级"] = 9,
	["招架等级"] = 8,
	["法术爆击等级"] = 5,
	["法术爆击命中等级"] = 5,
	["法术爆击等级"] = 5,
	["远程爆击等级"] = 5,
	["远程爆击命中等级"] = 5,
	["远程爆击等级"] = 5,
	["近战爆击等级"] = 5,
	["爆击等级"] = 5,
	["法术命中等级"] = 4,
	["远程命中等级"] = 3,
	["命中等级"] = 3,
	["韧性等级"] = 10,
	["法术急速等级"] = 2,
	["远程急速等级"] = 2,
	["急速等级"] = 2,
	["加速等级"] = 2,
	["武器技能等级"] = 1,
	["技能等级"] = 1,
	["精准等级"] = 11,
	["命中躲闪等级"] = 7,
};
elseif (GetLocale() == "zhTW") then
Table1 = {
	["防禦等級"] = 6,
	["閃躲等級"] = 7,
	["格擋機率等級"] = 9,
	["招架等級"] = 8,
	["法術致命一擊等級"] = 5,
	["遠程攻擊致命一擊等級"]= 5,
	["致命一擊等級"] = 5,
	["法術命中等級"] = 4,
	["遠程命中等級"] = 3,
	["命中等級"] = 3,
	["韌性"] = 10,
	["法術加速等級"] = 2,
	["遠程攻擊加速等級"] = 2,
	["攻擊速度等級"] = 2,
	["加速等級"] = 2,
	["武器技能等级"] = 1,
	["技能等級"] = 1,
	["熟練等級"] = 11,
	["命中迴避率"] = 7,
};
else
Table1 = {
	["defense rating"] = 6,
	["dodge rating"] = 7,
	["block rating"] = 9,
	["parry rating"] = 8,
	["spell critical strike rating"] = 5,
	["spell critical hit rating"] = 5,
	["spell critical rating"] = 5,
	["spell crit rating"] = 5,
	["ranged critical strike rating"] = 5,
	["ranged critical hit rating"] = 5,
	["ranged critical rating"] = 5,
	["ranged crit rating"] = 5,
	["critical strike rating"] = 5,
	["critical hit rating"] = 5,
	["crit rating"] = 5,
	["spell hit rating"] = 4,
	["ranged hit rating"] = 3,
	["hit rating"] = 3,
	["resilience"] = 10,
	["spell haste rating"] = 2,
	["ranged haste rating"] = 2,
	["haste rating"] = 2,
	["speed rating"] = 2,
	["skill rating"] = 1,
	["expertise rating"] = 11,
	["hit avoidance rating"] = 7,
};
end

local Table2 = {2.5, 10, 10, 8, 14, 1.5, 12, 15, 5, 25, 2.5, };
local Table3 = {"+%.2f", "+%.2f%%", "+%.2f%%", "+%.2f%%", "+%.2f%%", "+%.2f", "+%.2f%%", "+%.2f%%", "+%.2f%%", "-%.2f%%", "-%.2f%%", }; 
local Table4 = {};

Table4[string.gsub(ITEM_MOD_HASTE_MELEE_RATING, "%%d", '(%%d+)')] = 2;
Table4[string.gsub(ITEM_MOD_HASTE_RANGED_RATING, "%%d", '(%%d+)')] = 2;
Table4[string.gsub(ITEM_MOD_HASTE_RATING, "%%d", '(%%d+)')] = 2;
Table4[string.gsub(ITEM_MOD_HASTE_SPELL_RATING, "%%d", '(%%d+)')] = 2;
Table4[string.gsub(ITEM_MOD_HIT_MELEE_RATING, "%%d", '(%%d+)')] = 3;
Table4[string.gsub(ITEM_MOD_HIT_RANGED_RATING, "%%d", '(%%d+)')] = 3;
Table4[string.gsub(ITEM_MOD_HIT_RATING, "%%d", '(%%d+)')] = 3;
Table4[string.gsub(ITEM_MOD_HIT_SPELL_RATING, "%%d", '(%%d+)')] = 4;
Table4[string.gsub(ITEM_MOD_CRIT_MELEE_RATING, "%%d", '(%%d+)')] = 5;
Table4[string.gsub(ITEM_MOD_CRIT_RANGED_RATING, "%%d", '(%%d+)')] = 5;
Table4[string.gsub(ITEM_MOD_CRIT_RATING, "%%d", '(%%d+)')] = 5;
Table4[string.gsub(ITEM_MOD_CRIT_SPELL_RATING, "%%d", '(%%d+)')] = 5;
Table4[string.gsub(ITEM_MOD_DEFENSE_SKILL_RATING, "%%d", '(%%d+)')] = 6;
Table4[string.gsub(ITEM_MOD_DODGE_RATING, "%%d", '(%%d+)')] = 7;
Table4[string.gsub(ITEM_MOD_PARRY_RATING, "%%d", '(%%d+)')] = 8;
Table4[string.gsub(ITEM_MOD_BLOCK_RATING, "%%d", '(%%d+)')] = 9;
Table4[string.gsub(ITEM_MOD_RESILIENCE_RATING, "%%d", '(%%d+)')] = 10;
Table4[string.gsub( ITEM_MOD_EXPERTISE_RATING, "%%d", '(%%d+)')] = 11;

local function get(value, v, level)
	if (level < 10) then
		level = 10;
	end
	local rating = 0;
	if (level <= 60) then
		rating = Table2[value] * (level - 8) / 52;
	elseif (level <= 70) then
		rating = Table2[value] * 82 / (262 - 3 * level);
	else
		rating = Table2[value] * (level + 12) / 52;
	end
	return math.floor(v * 100 / rating ) / 100;
end

local function SetRating(self, ...)
	local level = select(5, GetItemInfo(select(2, self:GetItem()) or ""))
	local playerlevel = UnitLevel("player")
	if not level or level == 0 or level < playerlevel or not tdItemTipDB.locklevel then
		level = playerlevel
	end
	local name = self:GetName().."TextLeft";
	for i = 2, self:NumLines() do
		local text = _G[name..i];
		local str = text:GetText();
		if (str) then
			local forstr = str;
			if (string.find(str, "^" .. ITEM_SPELL_TRIGGER_ONEQUIP)) then
				for key, value in pairs(Table4) do
					if (strfind(forstr, key)) then
						forstr = string.gsub(forstr, "(%d+)",
							function(v)
								local e = get(value, v, level);
								return v .. "|cfffff799(".. string.format(Table3[value], e)..")|r";
							end);
						text:SetText(forstr);
					end
				end
			elseif (strfind(str, "%+(%d+)")) then
				for key, value in pairs(Table1) do
					if (strfind(forstr, "(%d+)" .. " " .. key)) then
						local color = strmatch(string.lower(str), "(\124c%x+)") or "";
						forstr = string.gsub(forstr, "(%d+)" .. " " .. key,
							function(v)
								local e = get(value, v, level);
								return v .. "|cfffff799("..string.format(Table3[value], e)..")|r " .. color .. key;
							end);
						text:SetText(forstr);
					end
				end
			end
		end
	end
end

local texts = {[1] = "", [2] = "", [3] = "",}
local function SetLevel(self, ...)
	local link = select(2, self:GetItem()) or ""
	local id = link:match("item:(%d+)")
	if id then
		local num, level, stack = 0
		link, _, level, _, _, _, stack = select(2, GetItemInfo(id))
		if tdItemTipDB.itemlevel and level then
			num = num + 1
			texts[num] = format(L.ItemLevel, level)
		end
		if tdItemTipDB.itemid then
			num = num + 1
			texts[num] = format(L.ItemID, id)
		end
		if tdItemTipDB.itemstack and stack and stack > 1 then
			num = num + 1
			texts[num] = format(L.ItemStack, stack)
		end
		if num == 3 then
			self:AddDoubleLine(texts[1], texts[2], 0, 1, 0.5, 0, 1, 0.5)
			self:AddLine(texts[3], 0, 1, 0.5)
		elseif num == 2 then
			self:AddDoubleLine(texts[1], texts[2], 0, 1, 0.5, 0, 1, 0.5)
		elseif num == 1 then
			self:AddLine(texts[1], 0, 1, 0.5)
		end
	end
end

local function SetItem(self, ...)
	if tdItemTipDB.rating then
		SetRating(self, ...)
	end
	if tdItemTipDB.itemlevel or tdItemTipDB.itemid or tdItemTipDB.itemstack then
		SetLevel(self, ...)
	end
	self:Show();
end

local function hook(tip, method)
	if not tip or not method then return end
	hooksecurefunc(tip, method, SetItem)
end
tinsert(tdItemTip.hooks, hook)
