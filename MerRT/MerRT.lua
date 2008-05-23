---- MerRT by Mermaid 2008-05-20

MerRT = {}
local M = MerRT
M.author = "Mermaid"
M.vision = "3.0.1"

M.bosses = {
	
	["猎手阿图门"] = 0,
	["巫婆"] =	0,
	["朱丽叶"] =	0,
	["贞节圣女"] = 0,
	["莫罗斯"] = 0,
	["虚空幽龙"] = 0,
	["夜之魇"] = 0,
	["玛克扎尔王子"] = 0,
	["埃兰之影"] = 0,
	["特雷斯坦·邪蹄"] = 0,
	["大灰狼"] = 0,
	["馆长"] = 0,

	["埃基尔松"] = 0,
	["哈尔拉兹"] = 0,
	["妖术领主玛拉卡斯"] = 0,
	["加亚莱"] = 0,
	["纳洛拉克"] = 0,
	["祖尔金"] = 0,
		
	["高阶术士奥蕾塞丝"] = 2,
	["布鲁塔卢斯"] = 2,
	["菲米丝"] = 2,
	["卡雷苟斯"] = 2,
	["穆鲁"] = 2,
	["萨洛拉丝女王"] = 2,
	
	["屠龙者格鲁尔"] = 2,
	["莫加尔大王"] = 2,

	["奥"] = 2,
	["大星术师索兰莉安"] = 2,
	["凯尔萨斯·逐日者"] = 2,
	["空灵机甲"] = 2,

	["玛瑟里顿"] = 2,

	["深水领主卡拉瑟拉斯"] = 2,
	["不稳定的海度斯"] = 2,
	["瓦丝琪"] = 2,
	["盲眼者莱欧瑟拉斯"] = 2,
	["莫洛格里·踏潮者"] = 2,
	["鱼斯拉"] = 2,

	["安纳塞隆"] = 2,
	["阿克蒙德"] = 2,
	["阿兹加洛"] = 2,
	["卡兹洛加"] = 2,
	["雷基·冬寒"] = 2,
	["空灵机甲"] = 2,
	["空灵机甲"] = 2,

	---首領级小兵分数写为负数就可
	["先知盲眼"] = -1,
	["克羅斯·火手"] = -1,
	["召喚者莫古"] = -1,
	["巔峰者奇克勒"] = -1,
}

M.tmp = {}
M.tmp.raidmembers = {}
M.tmp.quality = {
	ff9d9d9d = 1, ffffffff = 2, ff1eff00 = 3, ff0070dd = 4, ffa335ee = 5, ffff8000 = 6, ffe6cc80 = 7,
}
M.tmp.classes = {
	["战士"] 	= { hex = "|cffA39402", r = 0.78, g = 0.61, b = 0.43 },
	["法师"] 	= { hex = "|cff00FFFF", r = 0.41, g = 0.85, b = 0.94 },
	["潜行者"] 	= { hex = "|cffFFFF00", r = 0.95, g = 0.96, b = 0.41 },
	["德鲁伊"] 	= { hex = "|cffFF8A00", r = 0.95, g = 0.49, b = 0.04 },
	["猎人"] 	= { hex = "|cff00FF00", r = 0.67, g = 0.83, b = 0.45 },
	["萨满祭司"] = { hex = "|cff2459EE", r = 0.14, g = 0.35, b = 0.95 },
	["牧师"] 	= { hex = "|cffDFDFDF", r = 0.95, g = 0.95, b = 0.95 },
	["术士"] 	= { hex = "|cff8D54FB", r = 0.58, g = 0.51, b = 0.79 },
	["圣骑士"] 	= { hex = "|cffFF71A8", r = 0.96, g = 0.55, b = 0.73 },
	[UNKNOWN] 	= { hex = "|cffD0D0D0", r = 0.65, g = 0.65, b = 0.65 },
}
M.tmp.specialitems = {	
	--["item:11084"] = true, ----大块微光碎片
	--["item:14344"] = true, ----大块魔光碎片	
	--["item:22446"] = true, ----强效星面精华
	--["item:22447"] = true, ----次級星面精华	
	["item:22448"] = true, ----小块棱光石碎片
	["item:22449"] = true, ----大块棱光碎片
	["item:22450"] = true, ----虛空水晶
	["item:20725"] = true, ----连接水晶	
	["item:32897"] = true, ----伊利达雷印记
        ["item:29434"] = true, --公正徽章
        ["item:30311"] = true, ----迁跃切割者
        ["item:30312"] = true, ----无尽之刃
        ["item:30313"] = true, ----瓦解法杖
        ["item:30314"] = true, ----盾
        ["item:30316"] = true, ----毁灭
        ["item:30317"] = true, ----宇宙灌注者
        ["item:30318"] = true, ----灵弦长弓
        ["item:30319"] = true, ----虚空尖刺
        ["item:32230"] = true, ----紫
        ["item:32227"] = true, ----赤
        ["item:32231"] = true, ----焚
        ["item:32229"] = true, ----狮
        ["item:32249"] = true, ----海
        ["item:32228"] = true, ----蓝
}
M.tmp.battlefield = {
	["战歌峡谷"] 		= true,
	["阿拉希盆地"] 		= true,
	["奥特兰克山谷"]	= true,
	["风暴之眼"] 		= true,
	["洛丹伦废墟"] 		= true,
	["刀锋山竞技场"] 	= true,
	["纳格兰竞技场"] 	= true,
}
M.loc = {
	itemlinkText = "|c(%x+)|H(item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+)|h%[(.-)%]|h|r",
	leftText = "(.+)离开了团队",
	lootText2 = "([^%s]+)%s?获得了物品：|c(%x+)|H(item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+)|h%[(.-)%]|h|r",
	lootText1 = "([^%s]+)%s?获得了物品：|c(%x+)|H(item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+)|h%[(.-)%]|h|rx(%d+)",
	lootText3 = "([^%s]+)得到了物品：|c(%x+)|H(item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+)|h%[(.-)%]|h|rx(%d+)",
	bosskilledText = "(.+)死亡了",
}
M.events = {
	"CHAT_MSG_LOOT",
	"CHAT_MSG_SYSTEM",
	"RAID_ROSTER_UPDATE",
	"UPDATE_MOUSEOVER_UNIT",
	"CHAT_MSG_COMBAT_HOSTILE_DEATH",
	"VARIABLES_LOADED",
	"PLAYER_LOGOUT",
	"PLAYER_TARGET_CHANGED",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_LEAVING_WORLD",
}
M.db = {}
M.itemvalues = {}
M.opt = {
	enabled = true,
	minquality = 4,
	maxquality = 5,
	minimap = 325,
	saveitemdkp = nil,
	getitemdkp = nil,
	autocreate = nil,
	sum0enabled = nil,
	hourdkp = 0,
	gatherdkp = 0,
}

function M:OnEvent(event)
	
	if event == "PLAYER_ENTERING_WORLD" then
		self.frame:RegisterEvent("PLAYER_LEAVING_WORLD")
		return
	end	
	
	if event == "PLAYER_LEAVING_WORLD" then
		if self.tmp.battlefield[GetRealZoneText()] then
			self.opt.enabled = true
		end		
		return
	end
	
	if event == "VARIABLES_LOADED" then
		Mer_RaidTracker = Mer_RaidTracker or {}
		self.db = Mer_RaidTracker.db or self.db
		self.opt = Mer_RaidTracker.opt or self.opt
		self.itemvalues = Mer_RaidTracker.itemvalues or self.itemvalues
		return
	end
	
	if event == "PLAYER_LOGOUT" then
		local id = self.db.id
		self:EndRaid()
		self.db.id = id
		Mer_RaidTracker = Mer_RaidTracker or {}
		Mer_RaidTracker.db = self.db
		Mer_RaidTracker.opt = self.opt
		Mer_RaidTracker.itemvalues = self.itemvalues		
		return
	end
	
	if event == "CHAT_MSG_SYSTEM" then
		if strfind(arg1, self.loc.leftText) then
			local name = select(3, strfind(arg1, self.loc.leftText))
			self:LeftOrOffline(name)
			self.tmp.raidmembers[name] = nil
		end		
		return
	end
	
	if event == "RAID_ROSTER_UPDATE" then		
		self:RAID_ROSTER_UPDATE()
		return
	end
	
	if not self.opt.enabled or GetNumRaidMembers() < 1 then return end
	
	if event == "PLAYER_TARGET_CHANGED" then
		self:CheckTarget("target")
		return
	end
	
	if event == "CHAT_MSG_LOOT" then		
		if strfind(arg1, self.loc.lootText1) then
			local name, color, itemlink, item = select(3, strfind(arg1, self.loc.lootText1))
			if name == YOU then name = UnitName("player") end
			self:CHAT_MSG_LOOT(name, item, color, itemlink, num)
			return
		end
		if strfind(arg1, self.loc.lootText2) then
			local name, color, itemlink, item, num = select(3, strfind(arg1, self.loc.lootText2))
			if name == YOU then name = UnitName("player") end
			self:CHAT_MSG_LOOT(name, item, color, itemlink, num)
			return
		end
		if strfind(arg1, self.loc.lootText3) then
			local name, color, itemlink, item, num = select(3, strfind(arg1, self.loc.lootText3))
			if name == YOU then name = UnitName("player") end
			self:CHAT_MSG_LOOT(name, item, color, itemlink, num)
			return
		end
		return
	end	
	
	if event == "UPDATE_MOUSEOVER_UNIT" then		
		if UnitIsDead("mouseover") and not UnitIsFriend("mouseover","player") then
			self:BossKilled(UnitName("mouseover"))
		end
		return
	end
	
	if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		if strfind(arg1,self.loc.bosskilledText) then
			local boss = select(3, strfind(arg1,self.loc.bosskilledText))
			self:BossKilled(boss)
		end
		return
	end
	
end

function M:JoinedOrOnline(name, class, level, online, race)	
	local id = self.db.id
	if not id or not self.db[id] then return end
	local timer = MerRT_GetTime()
	for _, v in ipairs(self.db[id].players) do
		if v.name == name then
			v.online = online
			v.timer_join = timer
			return
		end
	end
	tinsert(self.db[id].players, {
		name = name, class = class, level = level or 70, online = online, race = race,	
		p_boss = 0, p_time = 0, p_gather = 0, p_item = 0, p_added = 0, m_loot = 0,		 
		t_time = 0, t_earn = 0, timer_join = timer, timer_left = timer, boss = "#",
		join = date("%m/%d/%y %H:%M:%S"), left = date("%m/%d/%y %H:%M:%S"),
	})
end

function M:LeftOrOffline(name)
	local id = self.db.id
	if not id or not self.db[id] then return end
	local timer = MerRT_GetTime()
	for _, v in ipairs(self.db[id].players) do
		if v.name == name and v.online then
			v.online = nil
			v.timer_left = timer
			v.left = date("%m/%d/%y %H:%M:%S")
			v.t_time = v.t_time + timer - v.timer_join
			v.p_time = tonumber(format("%.2f", v.t_time * self.opt.hourdkp /60))
			v.t_earn = v.p_boss + v.p_time + v.p_gather + v.p_item + v.p_added
			return
		end
	end
end

function M:EndRaid(id)
	id = id or self.db.id
	if not id or not self.db[id] then return end
	local timer = MerRT_GetTime()
	self.db[id].raid_end = date("%m/%d/%y %H:%M:%S")
	for _, v in ipairs(self.db[id].players) do			
		if v.online then
			v.online = nil
			v.timer_left = timer
			v.left = date("%m/%d/%y %H:%M:%S")
			v.t_time = v.t_time + timer - v.timer_join
			v.p_time = tonumber(format("%.2f", v.t_time * self.opt.hourdkp /60))
			v.t_earn = v.p_boss + v.p_time + v.p_gather + v.p_item + v.p_added
		end
	end	
	self.db.id = nil
end

function M:StartRaid(id)
	if self.db.id == id then return end
	if self.db.id then
		self:EndRaid(self.db.id)
	end
	self.db.id = tonumber(id)
	
	self.tmp.raidmembers = {}
	local timer = MerRT_GetTime()
	for i = 1, GetNumRaidMembers() do
		name, _, _, level, class, _, _, online = GetRaidRosterInfo(i)
		race = UnitRace("raid" .. i)
		if strfind(name,"%-") then
			name = select(3, strfind(name, "(.-)%-"))
		end
		self.tmp.raidmembers[name] = {class=class,level=level,online=online,race=race}
		
		local hadlist;
		for _, v in ipairs(self.db[self.db.id].players) do
			if v.name == name then
				v.timer_join = timer
				v.timer_left = timer
				v.online = online
				hadlist = true
				break
			end
		end
		if not hadlist then
			tinsert(self.db[self.db.id].players, {
			name = name, class = class, level = level or 70, online = online, race = race,	
			p_boss = 0, p_time = 0, p_gather = 0, p_item = 0, p_added = 0, m_loot = 0,		 
			t_time = 0, t_earn = 0, timer_join = timer, timer_left = timer, boss = "#",
			join = date("%m/%d/%y %H:%M:%S"), left = date("%m/%d/%y %H:%M:%S"),
			})
		end		
	end
end

function M:CreateRaid()
	tinsert(self.db, {
		raid_start = date("%m/%d/%y %H:%M:%S"),
		raid_zone = "",	raid_desc = "",
		players = {}, loots = {}, bosses = {},
	})
	self.db.id = #self.db
	
	self.tmp.raidmembers = {}
	local timer = MerRT_GetTime()
	for i = 1, GetNumRaidMembers() do
		name, _, _, level, class, _, _, online = GetRaidRosterInfo(i)
		race = UnitRace("raid" .. i)
		if strfind(name,"%-") then
			name = select(3, strfind(name, "(.-)%-"))
		end
		self.tmp.raidmembers[name] = {class=class,level=level,online=online,race=race}
		tinsert(self.db[self.db.id].players, {
			name = name, class = class, level = level or 70, online = online, race = race,	
			p_boss = 0, p_time = 0, p_gather = 0, p_item = 0, p_added = 0, m_loot = 0,		 
			t_time = 0, t_earn = 0, timer_join = timer, timer_left = timer, boss = "#",
			join = date("%m/%d/%y %H:%M:%S"), left = date("%m/%d/%y %H:%M:%S"),
		})
	end
end

function M:DeleteRaid(id)	
	tremove(self.db, id)
	if self.db.id then
		if id == self.db.id then
			self.db.id = nil
		elseif id < self.db.id then
			self.db.id = self.db.id - 1
		end
	end
	self.tmp.selectid = nil
end

function M:SurplusRaid(id)
	if not id or not self.db[id] then return end
	for _, v in ipairs(self.db[id].players) do
		v.p_boss = 0
		for _, vv in ipairs(self.db[id].bosses) do
			if strfind(vv.attendants, "#".. v.name .."#") then
				v.p_boss = v.p_boss + vv.dkp
			end
		end
		v.m_loot, v.p_item = 0, 0
		for _, vv in ipairs(self.db[id].loots) do
			if v.name == vv.looter then
				v.m_loot = v.m_loot - vv.dkp * vv.number
			end
			-- v.p_item = v.p_item + vv.number
			if self.opt.sum0enabled and strfind(vv.attendants, "#".. v.name .."#") then
				v.p_item = v.p_item + vv.dkp * vv.number / max(vv.member,1)
			end
		end
		v.p_item = tonumber(format("%.2f", v.p_item))
		v.p_time = tonumber(format("%.2f", v.t_time * self.opt.hourdkp /60))		
		v.t_earn = v.p_boss + v.p_time + v.p_gather + v.p_item + v.p_added
	end
end

function M:RAID_ROSTER_UPDATE()
	if not self.opt.enabled then return end
	local numMembers = GetNumRaidMembers()	
	if numMembers < 1 then
		self.tmp.raidmembers = {}
		self:EndRaid()
		return
	end	
	if self.opt.autocreate and not self.db.id then
		self:CreateRaid()		
		return
	end
	for i = 1, numMembers do
		name, _, _, level, class, _, _, online = GetRaidRosterInfo(i)
		race = UnitRace("raid" .. i)
		if strfind(name,"%-") then
			name = select(3, strfind(name, "(.-)%-"))
		end
		if not self.tmp.raidmembers[name] then
			self.tmp.raidmembers[name] = {class=class,level=level,online=online,race=race}
			self:JoinedOrOnline(name, class, level, online, race)
		end
		if self.tmp.raidmembers[name].online ~= online then
			self.tmp.raidmembers[name].online = online
			if online then
				self:JoinedOrOnline(name, class, level, online)
			else
				self:LeftOrOffline(name)
			end
		end
	end
end

function M:CHAT_MSG_LOOT(name, item, color, itemlink, num)
	num = tonumber(num) or 1
	if not self.db.id or not self.db[self.db.id] then return end
	if (self.tmp.quality[color] and self.tmp.quality[color] >= self.opt.minquality) or self.tmp.specialitems[select(3,strfind(itemlink,"(item:%d+)"))] then
	
	if self.tmp.quality[color] < self.opt.maxquality or self.tmp.specialitems[select(3,strfind(itemlink,"(item:%d+)"))] then
		for _, v in ipairs(self.db[self.db.id].loots) do
			if v.item == item and v.looter == name then
				v.number = v.number + num
				return
			end
		end
	end	
	local timer, itemid, texture, class, itemvalue, attendants;
	timer = MerRT_GetTime()
	itemid = select(3, strfind(itemlink,"item:(%d+):%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+"))
	texture = select(10, GetItemInfo(itemid))
	texture = select(3, strfind(texture, "%a+\\%a+\\([%w_]+)"))	
	--zone = GetRealZoneText()	
	if self.tmp.raidmembers[name] then
		class = self.tmp.raidmembers[name].class
	else
		class = UNKNOWN
	end
	itemvalue = MerRT_GetItemValue(item)
	attendants = "#"
	if self.opt.sum0enabled then
		for i = 1, GetNumRaidMembers() do
			attendants = attendants .. UnitName("raid"..i) .. "#"
		end
	end
	tinsert(self.db[self.db.id].loots, {
		item = item, link = itemlink, icon = texture, color = color, member = GetNumRaidMembers(),
		looter = name, class = class, number = num, dkp = itemvalue, timer = timer, attendants = attendants,
	})
	
	end
end

function M:BossKilled(boss)
	if not self.db.id or not self.db[self.db.id] then return end
	if self.bosses[boss] and self.bosses[boss] >= 0 then
		for _, v in ipairs(self.db[self.db.id].bosses) do
			if v.boss == boss then return end
		end
		local list, name = "#", ""
		for i = 1, GetNumRaidMembers() do
			name = GetRaidRosterInfo(i)
			if strfind(name,"%-") then
				name = select(3, strfind(name, "(.-)%-"))
			end
			list = list .. name .. "#"
			for _, v in ipairs(self.db[self.db.id].players) do
				if v.name == name then
					v.boss = v.boss .. boss .. "#"
					v.p_boss = v.p_boss + self.bosses[boss]
					break
				end
			end
		end
		tinsert(self.db[self.db.id].bosses, {
			boss = boss, timer = MerRT_GetTime(), attendants = list, dkp = self.bosses[boss], number = GetNumRaidMembers(),
		})
		MerRT_Debug(boss .. " killed")
	end
end

function M:CheckTarget(target)
	local class = UnitClassification(target)
	if class and class == "worldboss" and not self.bosses[UnitName(target)] then
		self.bosses[UnitName(target)] = 0
	end
end

function MerRT_GetTime()
	return floor(time() / 60)
end

function MerRT_FixZero(num)
	if num < 10 then
		return "0" .. num
	else
		return num
	end
end

function MerRT_ColorValue(val)
	if not val then
		return "";
	elseif tonumber(val) > 0 then
		return "|cff3fff3f" .. val .. "|r";
	elseif tonumber(val) < 0 then
		return "|cffff3f3f" .. val .. "|r";
	else 
		return "|cffafafaf" .. val .. "|r";
	end
end

function MerRT_UCFirst(name)
	name = strlower(name)
	if strfind(name, "^%a") then
		name = strupper(strsub(name,1,1)) .. strsub(name,2,-1)
	end	
	return name
end

function MerRT_GetItemValue(item)
	if MerRT.opt.getitemdkp then
		return MerRT.itemvalues[item] or 0
	end
	return 0
end

function MerRT_Debug(msg)
	msg = msg or "DEBUG ERROR"
	DEFAULT_CHAT_FRAME:AddMessage("|cfffeba33<MerRT>|r " .. msg, 1, 0.85, 0, 1)
end

M.frame = CreateFrame("Frame", nil, UIParent)
for _, event in ipairs(M.events) do
	M.frame:RegisterEvent(event)
end
M.frame:SetScript("OnEvent", function() MerRT:OnEvent(event) end)

StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnAccept = function(data)
	MerRT.opt.enabled = false
	if MerRT.tmp.battlefield[GetRealZoneText()] then
		MerRT.frame:UnregisterEvent("PLAYER_LEAVING_WORLD")
	end
	if ( not AcceptBattlefieldPort(data, 1) ) then
		return 1;
	end	
end
