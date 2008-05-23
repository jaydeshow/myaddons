
local M = MerRT

local function OptionsMenu()
	if MerRT.opt[this.value] then
		MerRT.opt[this.value] = nil
	else
		MerRT.opt[this.value] = true
	end
end
local function ZoneChanged(zone)	
	MerRT.db[this.value].raid_zone = zone
	MerRT.UpdateRaidList()
	HideDropDownMenu(1)
	MerRT_PlayersFrameGatherBox:SetText(zone)
end
local function QualityChanged(key)
	if key == "minquality" then
		MerRT.opt.minquality = tonumber(this.value) or 4
	elseif key == "maxquality" then
		MerRT.opt.maxquality = tonumber(this.value) or 5
	end
end

M.DROPMENU = {
	raidlist = {
		[1] = {
			{
				text = "%1",
				isTitle = true,
			},
			{
				text = "活动地点",
				value = "%1",
				hasArrow = 1,
				func = function()
					MerRT_OpenPopupFrame("edit", "raidzone", this.value, "修改活动地点")
				end,
			},
			{
				text = "活动备注",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "raiddesc", this.value, "添加活动注释")
				end,
			},
			{
				text = "论坛报表",
				value = "%1",
				func = function()
					MerRT_ReportBBS(this.value)
				end,
			},
			{
				text = "DKP字符",
				value = "%1",
				func = function()
					MerRT_ReportXML(this.value)
				end,
			},
			{
				text = DELETE,
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("confirm", "delraid", this.value, "确定删除此活动？")
				end,
			},
			{
				text = CANCEL,
				func = function() HideDropDownMenu(1) end,
			},
		},
		[2] = {
			{
				text = "纳克萨玛斯",
				value = "%1",
				arg1 = "纳克萨玛斯",
				func = ZoneChanged,
			},
			{
				text = "卡拉赞",
				value = "%1",
				arg1 = "卡拉赞",
				func = ZoneChanged,
			},
			{
				text = "戈鲁尔之巢",
				value = "%1",
				arg1 = "戈鲁尔之巢",
				func = ZoneChanged,
			},
			{
				text = "玛瑟里顿的巢穴",
				value = "%1",
				arg1 = "玛瑟里顿的巢穴",
				func = ZoneChanged,
			},
			{
				text = "毒蛇神殿洞穴",
				value = "%1",
				arg1 = "毒蛇神殿洞穴",
				func = ZoneChanged,
			},
			{
				text = "风暴要塞",
				value = "%1",
				arg1 = "风暴要塞",
				func = ZoneChanged,
			},
			{
				text = "海加尔山",
				value = "%1",
				arg1 = "海加尔山",
				func = ZoneChanged,
			},
			{
				text = "黑暗神庙",
				value = "%1",
				arg1 = "黑暗神庙",
				func = ZoneChanged,
			},	
			{
				text = "太阳井高地",
				value = "%1",
				arg1 = "太阳井高地",
				func = ZoneChanged,
			},			
		},
	},
	players = {
		[1] = {
			{
				text = "%1",
				isTitle = true,
			},
			{
				text = "参与BOSS",
				value = "%1",
				hasArrow = 1,
			},
			{
				text = "修改职业",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "playerclass", this.value, "修改成员职业")
				end,
			},
			{
				text = "修改时间",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "playertime", this.value, "修改成员RAID时间")
				end,
			},
			{
				text = "添加注记",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "playernotes", this.value, "添加成员註释")
				end,
			},
			{
				text = "额外调节",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "playerextra", this.value, "调节成员分数")
				end,
			},
			{
				text = DELETE,
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("confirm", "delplayer", this.value, "确定删除此玩家？")
				end,
			},
			{
				text = CANCEL,
				func = function() HideDropDownMenu(1) end,
			},
		},
	},
	loots = {
		[1] = {
			{
				text = "%1",
				isTitle = true,
			},
			{
				text = "设定拾取者",
				value = "%1",
				hasArrow = 1,
				func = function()
					MerRT_OpenPopupFrame("edit", "looter", this.value, "修改物品拾取者")
				end,
			},
			{
				text = "物品单价",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "lootdkp", this.value, "编辑物品单价")
				end,
			},
			{
				text = "编辑数量",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "lootnumber", this.value, "编辑物品数量")
				end,
			},
			{
				text = DELETE,
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("confirm", "delloot", this.value, "确定删除此物品？")
				end,
			},
			{
				text = CANCEL,
				func = function() HideDropDownMenu(1) end,
			},
		},
		[2] = {
			{
				text = "公会仓库",
				value = "%1",
				func = function()
					local id = select(3, strfind(this.value,"(%d+)#"))
					id = tonumber(id)
					MerRT.db[MerRT.tmp.selectid].loots[id].looter = "公会仓库"
					MerRT.db[MerRT.tmp.selectid].loots[id].class = UNKNOWN
					MerRT.UpdateLoots()
					HideDropDownMenu(1)
				end,
			},
			{
				text = "附魔分解",
				value = "%1",
				func = function()
					local id = select(3, strfind(this.value,"(%d+)#"))
					id = tonumber(id)
					MerRT.db[MerRT.tmp.selectid].loots[id].looter = "附魔分解"
					MerRT.db[MerRT.tmp.selectid].loots[id].class = UNKNOWN
					MerRT.UpdateLoots()
					HideDropDownMenu(1)
				end,
			},
			{
				text = " ",
				isTitle = true,
			},
			{
				text = "|cffA39402战士|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "战士",
			},
			{
				text = "|cff00FFFF法师|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "法师",
			},
			{
				text = "|cffFFFF00潜行者|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "潜行者",
			},
			{
				text = "|cff00FF00猎人|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "猎人",
			},
			{
				text = "|cffDFDFDF牧师|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "牧师",
			},
			{
				text = "|cff8D54FB术士|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "术士",
			},
			{
				text = "|cff2459EE萨满祭司|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "萨满祭司",
			},
			{
				text = "|cffFF8A00德鲁伊|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "德鲁伊",
			},
			{
				text = "|cffFF71A8圣骑士|r",
				value = "%1",
				hasArrow = 1,
				arg1 = "圣骑士",
			},
			{
				text = "|cffD0D0D0" .. UNKNOWN .."|r",
				value = "%1",
				hasArrow = 1,
				arg1 = UNKNOWN,
			},
		},
	},
	bosses = {
		[1] = {
			{
				text = "%1",
				isTitle = true,
			},
			{
				text = "核对参与数",
				value = "%1",
				func = function()
					local list = MerRT.db[MerRT.tmp.selectid].bosses[this.value]
					local _, number = gsub(list.attendants, "#","#")
					list.number = number - 1
					MerRT.UpdateBossKilled()
				end,
			},
			{
				text = "查看参与者",
				value = "%1",
				func = function()
					MerRT_BossKillsFrameDetailsFrameDetailsBox:SetText(MerRT.db[MerRT.tmp.selectid].bosses[this.value].attendants)
				end,
			},
			{
				text = "编辑DKP分",
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("edit", "bossdkp", this.value, "编辑此BOSS的DKP分")
				end,
			},
			{
				text = DELETE,
				value = "%1",
				func = function()
					MerRT_OpenPopupFrame("confirm", "delboss", this.value, "确定删除此BOSS？")
				end,
			},
			{
				text = CANCEL,
				func = function() HideDropDownMenu(1) end,
			},
		},
	},
	options = {
		[1] = {
			{
				text = "MerRT",
				isTitle = true,
			},
			{
				text = "开启插件",
				value = "enabled",
				keepShownOnClick  = 1,
				func = function()
					if MerRT.opt[this.value] then
						MerRT.opt[this.value] = nil
						for _, event in ipairs(MerRT.events) do
							MerRT.frame:UnregisterEvent(event)
						end
					else
						MerRT.opt[this.value] = true
						for _, event in ipairs(MerRT.events) do
							MerRT.frame:RegisterEvent(event)
						end
					end
				end,
			},
			{
				text = "自动创建记录",
				value = "autocreate",
				keepShownOnClick  = 1,
				func = OptionsMenu,
			},
			{
				text = "保存物品价格",
				value = "saveitemdkp",
				keepShownOnClick  = 1,
				func = OptionsMenu,
			},
			{
				text = "自动读取物价",
				value = "getitemdkp",
				keepShownOnClick  = 1,
				func = OptionsMenu,
			},
			{
				text = "启用零合制",				
				value = "sum0enabled",
				keepShownOnClick  = 1,
				func = OptionsMenu,
			},
			{
				text = "记录物品品质",
				hasArrow = 1,
				value = "minq",
			},
			{
				text = "分类物品品质",
				hasArrow = 1,
				value = "maxq",
			},
			{
				text = "设置时间分",
				func = function()
					MerRT_OpenPopupFrame("edit", "raidhourdkp", nil, "设置每小时的DKP分")
				end,
			},
			{
				text = "设置集合分",
				func = function()
					MerRT_OpenPopupFrame("edit", "raidgatherdkp", nil, "设置集合分")
				end,
			},
			{
				text = CANCEL,
				func = function() HideDropDownMenu(1) end,
			},
		},
		[2] = {
			{
				text = "|cff9d9d9d劣质|r",
				value = 1,
				func = QualityChanged,
			},
			{
				text = "|cffffffff普通|r",
				value = 2,
				func = QualityChanged,
			},
			{
				text = "|cff1eff00优秀|r",
				value = 3,
				func = QualityChanged,
			},
			{
				text = "|cff0070dd精良|r",
				value = 4,
				func = QualityChanged,
			},
			{
				text = "|cffa335ee史诗|r",
				value = 5,
				func = QualityChanged,
			},
			{
				text = "|cffff8000传説|r",
				value = 6,
				func = QualityChanged,
			},
			{
				text = "|cffe6cc80神话|r",
				value = 7,
				func = QualityChanged,
			},
		},
	},
}

M.tmp.SubFrames = {
	"MerRT_BossKillsFrame",
	"MerRT_LootsFrame",
	"MerRT_PlayersFrame",
}

function M.SubFrames_SelectTab(id)
	PanelTemplates_SetTab(MerRTFrame, id)
	for k, v in ipairs(MerRT.tmp.SubFrames) do
		if  k == id  then
			getglobal(v):Show()
			MerRT.SubFrames_Update(k)
		else
			getglobal(v):Hide()
		end
	end
end

function M.SubFrames_Update(id)
	if id == 1 then
		MerRT.UpdateBossKilled()
	elseif id == 2 then
		MerRT.UpdateLoots()
	elseif id == 3 then
		MerRT.UpdatePlayers()
	end
end

function MerRT_RaidList_DropMenu(level)
	if level == 2 then
		if not this.value then return end
		for _, v in ipairs(MerRT.DROPMENU.raidlist[level]) do
			if v.value then
				v.value = this.value
			end
			UIDropDownMenu_AddButton(v,level)
		end
		return
	end	
	if level == 1 then
		for _, v in ipairs(MerRT.DROPMENU.raidlist[level]) do
			if v.value then
				v.value = this.id
			end
			if v.text == "%1" then
				v.text = this.title
				UIDropDownMenu_AddButton(v,level)
				v.text = "%1"
			else
				UIDropDownMenu_AddButton(v,level)
			end
		end
	end
end
function M.RaidListOnClick(button)
	if button == "LeftButton" then		
		MerRT.tmp.selectid = this.id
		for i = 1, 15 do
			getglobal("MerRTFrameFilterButton"..i):UnlockHighlight()
		end
		this:LockHighlight()
		MerRT.UpdateSubFrames()
	elseif button == "RightButton" then
		HideDropDownMenu(1);		
		MerRTFrameDropDown.initialize = MerRT_RaidList_DropMenu			
		MerRTFrameDropDown.displayMode = "MENU"
		ToggleDropDownMenu(1, nil, MerRTFrameDropDown, "cursor")
	end
end

function M.UpdateRaidList()
	local size = getn(MerRT.db)
	FauxScrollFrame_Update(MerRTFrameFilterScrollFrame, size, 15, 20);
	local offset = FauxScrollFrame_GetOffset(MerRTFrameFilterScrollFrame);
	local listid, button, list;		
	for i = 1, 15 do
		listid = i + offset;
		button = getglobal("MerRTFrameFilterButton"..i)
		list = MerRT.db[listid];
		if listid <= size then
			button.id = listid
			button.title = listid .. ") " .. strsub(list.raid_start,1,5) .. " " .. list.raid_zone
			button:SetText(listid .. ") " .. strsub(list.raid_start,1,5) .. " " .. list.raid_zone)
			if  size > 15 then
				button:SetWidth(170)
			else
				button:SetWidth(194)
			end
			if MerRT.db.id == listid then
				getglobal("MerRTFrameFilterButton"..i.."NormalTexture"):SetAlpha(1)
				getglobal("MerRTFrameFilterButton"..i.."NormalTexture"):SetVertexColor(0.2, 1, 0.8)
			else
				getglobal("MerRTFrameFilterButton"..i.."NormalTexture"):SetAlpha(0.5)
				getglobal("MerRTFrameFilterButton"..i.."NormalTexture"):SetVertexColor(1, 1, 1)
			end
			if MerRT.tmp.selectid == listid then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
			button:Show()
		else
			button:Hide()
		end		
	end
end
function M.UpdatePlayers()
	local id = MerRT.tmp.selectid
	if not id or not MerRT.db[id] then
		for i = 1, 17 do
			getglobal("MerRT_PlayersFrameButton"..i):Hide()
		end
		return
	end
	local size = getn(MerRT.db[id].players)
	FauxScrollFrame_Update(MerRT_PlayersFrameScrollFrame, size, 17, 18)
	local offset = FauxScrollFrame_GetOffset(MerRT_PlayersFrameScrollFrame)
	local listid, button, list;	
	for i = 1, 17 do
		listid = i + offset;
		button = getglobal("MerRT_PlayersFrameButton"..i);
		list = MerRT.db[id].players[listid];			
		if listid <= size then
			button.id = listid;
			button.name = list.name;
			getglobal("MerRT_PlayersFrameButton"..i.."Num"):SetText(MerRT_FixZero(listid));
			getglobal("MerRT_PlayersFrameButton"..i.."Name"):SetText(list.name);
			getglobal("MerRT_PlayersFrameButton"..i.."Class"):SetText(list.class);
			getglobal("MerRT_PlayersFrameButton"..i.."Earn"):SetText(MerRT_ColorValue(list.t_earn));			
			getglobal("MerRT_PlayersFrameButton"..i.."Spend"):SetText(MerRT_ColorValue(list.m_loot));
			getglobal("MerRT_PlayersFrameButton"..i.."Surplus"):SetText(MerRT_ColorValue(list.t_earn + list.m_loot));
			local color = MerRT.tmp.classes[list.class] or NORMAL_FONT_COLOR
			getglobal("MerRT_PlayersFrameButton"..i.."Name"):SetTextColor(color.r,color.g,color.b);	
			getglobal("MerRT_PlayersFrameButton"..i.."Class"):SetTextColor(color.r,color.g,color.b);
			getglobal("MerRT_PlayersFrameButton"..i.."bg"):SetVertexColor(color.r,color.g,color.b);
			if  size > 15 then
				button:SetWidth(350)
				getglobal("MerRT_PlayersFrameButton"..i.."bg"):SetWidth(350)
			else
				button:SetWidth(370)
				getglobal("MerRT_PlayersFrameButton"..i.."bg"):SetWidth(370)
			end
			button:Show();
		else
			button:Hide();
		end
	end	
end
function M.UpdateLoots()
	local id = MerRT.tmp.selectid
	if not id or not MerRT.db[id] then
		for i = 1, 10 do
			getglobal("MerRT_LootsFrameButton"..i):Hide()
		end
		return
	end
	local size = getn(MerRT.db[id].loots);
	FauxScrollFrame_Update(MerRT_LootsFrameScrollFrame, size, 10, 30)
	local offset = FauxScrollFrame_GetOffset(MerRT_LootsFrameScrollFrame)
	local listid, button, list;
	for i = 1, 10 do
		listid = i + offset;
		button = getglobal("MerRT_LootsFrameButton"..i);
		list = MerRT.db[id].loots[listid];			
		if listid <= size then
			button.id = listid;
			button.item = list.item;
			button.link = list.link;
			button.color = list.color;
			if  size > 10  then
				getglobal("MerRT_LootsFrameButton"..i.."Right"):SetPoint("LEFT",button,"RIGHT",303,0);
				getglobal("MerRT_LootsFrameButton"..i.."MouseOver"):SetWidth(312);
			else
				getglobal("MerRT_LootsFrameButton"..i.."Right"):SetPoint("LEFT",button,"RIGHT",327,0);
				getglobal("MerRT_LootsFrameButton"..i.."MouseOver"):SetWidth(336);
			end
			getglobal("MerRT_LootsFrameButton"..i.."IconTexture"):SetTexture("Interface\\Icons\\" .. list.icon)
			getglobal("MerRT_LootsFrameButton"..i.."Item"):SetText("|c".. list.color .. list.item .. "|r")
			getglobal("MerRT_LootsFrameButton"..i.."Looter"):SetText(MerRT.tmp.classes[list.class].hex .. list.looter)
			getglobal("MerRT_LootsFrameButton"..i.."Cost"):SetText(MerRT_ColorValue(list.dkp * list.number))
			if list.number > 1 then
				getglobal("MerRT_LootsFrameButton"..i.."Count"):SetText(list.number)
			else
				getglobal("MerRT_LootsFrameButton"..i.."Count"):SetText("")
			end
			button:Show()
		else
			button:Hide()
		end
	end	
end
function M.UpdateBossKilled()
	local id = MerRT.tmp.selectid
	if not id or not MerRT.db[id] then
		for i = 1, 9 do
			getglobal("MerRT_BossKillsFrameButton"..i):Hide()
		end
		return
	end
	local size = getn(MerRT.db[id].bosses)
	FauxScrollFrame_Update(MerRT_BossKillsFrameScrollFrame, size, 9, 18)
	local offset = FauxScrollFrame_GetOffset(MerRT_BossKillsFrameScrollFrame)
	local listid, button, list;
	for i = 1, 9 do
		listid = i + offset;
		button = getglobal("MerRT_BossKillsFrameButton"..i)
		list = MerRT.db[id].bosses[listid]			
		if listid <= size then
			button.id = listid;
			button.boss = list.boss
			if  size > 9  then
				button:SetWidth(350)
			else
				button:SetWidth(370)
			end
			getglobal("MerRT_BossKillsFrameButton"..i.."Num"):SetText(MerRT_FixZero(listid))
			getglobal("MerRT_BossKillsFrameButton"..i.."Name"):SetText(list.boss)
			getglobal("MerRT_BossKillsFrameButton"..i.."Timer"):SetText(date("%m/%d %H:%M",list.timer*60))
			getglobal("MerRT_BossKillsFrameButton"..i.."Number"):SetText(list.number or 0)		
			getglobal("MerRT_BossKillsFrameButton"..i.."DKP"):SetText(MerRT_ColorValue(list.dkp))
			button:Show()
		else
			button:Hide()
		end
	end
end
function M.UpdateSubFrames()
	if MerRT_BossKillsFrame:IsShown() then
		MerRT.UpdateBossKilled()
	end
	if MerRT_LootsFrame:IsShown() then
		MerRT.UpdateLoots()
	end
	if MerRT_PlayersFrame:IsShown() then
		MerRT.UpdatePlayers()
	end
end

function M.SortTable(tab, val)
	local id = MerRT.tmp.selectid
	if not id or not MerRT.db[id] or not val then return end
	if tab == "member" then
		if this.sortway == "desc" then
			this.sortway = "asc";
			table.sort(MerRT.db[id].players, function(a,b) return a[val] > b[val]  end)
		else
			this.sortway = "desc";
			table.sort(MerRT.db[id].players, function(a,b) return a[val] < b[val]  end)
		end
		MerRT.UpdatePlayers()
	elseif tab == "loot" then
		if ( this.sortway == "desc" ) then
			this.sortway = "asc";
			table.sort(MerRT.db[id].loots, function(a,b) return a[val] > b[val]  end)
		else
			this.sortway = "desc";
			table.sort(MerRT.db[id].loots, function(a,b) return a[val] < b[val]  end)
		end
		MerRT.UpdateLoots()
	end
end

function MerRT_Players_DropMenu(level)
	if level == 2 then			
		if not this.value then return end
		for k, v in ipairs(MerRT.db[MerRT.tmp.selectid].bosses) do
			info = {};
			info.text = v.boss;
			info.value = {this.value, k, v.boss};
			info.keepShownOnClick  = 1;
			if strfind(MerRT.db[MerRT.tmp.selectid].players[this.value].boss, "#".. v.boss .."#") then
				info.checked = 1
			end
			info.func = function()
				local id, lid, boss = this.value[1], this.value[2], this.value[3];
				local killedboss = MerRT.db[MerRT.tmp.selectid].bosses[lid] 
				local playerboss = MerRT.db[MerRT.tmp.selectid].players[id]
				if strfind(playerboss.boss, "#".. boss .."#") then
					playerboss.boss = gsub(playerboss.boss, "#".. boss .."#","#")
					killedboss.attendants = gsub(killedboss.attendants,"#".. playerboss.name .."#","#")
				else
					playerboss.boss = playerboss.boss .. boss .."#"
					if not strfind(killedboss.attendants, "#".. playerboss.name .."#") then
						killedboss.attendants = killedboss.attendants .. playerboss.name .."#"
					end
				end
			end
			UIDropDownMenu_AddButton(info,level);					
		end				
		return
	end	
	if level == 1 then
		for _, v in ipairs(MerRT.DROPMENU.players[level]) do
			if v.value then
				v.value = this.id
			end
			if v.text == "%1" then
				v.text = this.name
				UIDropDownMenu_AddButton(v,level)
				v.text = "%1"
			else
				UIDropDownMenu_AddButton(v,level)
			end
		end
	end
end
function M.PlayersOnClick(button)
	if button == "LeftButton" then
		if ChatFrameEditBox:IsVisible() then
			local list = MerRT.db[MerRT.tmp.selectid].players[this.id]
			ChatFrameEditBox:Insert(list.name .. ":" .. (list.t_earn + list.m_loot) .. " DKP（" .. list.t_time .."分鐘）")
		end
	elseif button == "RightButton" then
		HideDropDownMenu(1);		
		MerRTFrameDropDown.initialize = MerRT_Players_DropMenu
		MerRTFrameDropDown.displayMode = "MENU"
		ToggleDropDownMenu(1, nil, MerRTFrameDropDown, "cursor")
	end
end
function M.PlayersOnMouseOver()
	if not MerRT_PlayersFrameMouseOverCheck:GetChecked() then return end
	local list = MerRT.db[MerRT.tmp.selectid].players[this.id]
	GameTooltip:SetOwner(this,"ANCHOR_TOPRIGHT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(MerRT.tmp.classes[list.class].hex .. list.name, 1, 1, 0)
	GameTooltip:AddLine("等级: ".. list.level .."    职业: ".. MerRT.tmp.classes[list.class].hex .. list.class, 0.9, 0.9, 0.4);
	GameTooltip:AddLine("入团时间: |cff22ff22".. list.join .."|r", 0.8, 1, 0.4)
	GameTooltip:AddLine("离团时间: |cffdddd22".. list.left .."|r", 0.8, 1, 0.4)
	GameTooltip:AddLine("RAID时间: ".. MerRT_ColorValue(list.t_time) .." 分鐘", 0.8, 1, 0.4)
	if list.notes then
		GameTooltip:AddLine("成员备注: ".. list.notes, 0.8, 0.8, 0.4)
	end
	
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("分数情况: ", 0.8, 0.8, 0.4)
	GameTooltip:AddLine("       集合分: ".. MerRT_ColorValue(list.p_gather) .."   时间分: ".. MerRT_ColorValue(list.p_time), 1, 0.8, 0.4)
	GameTooltip:AddLine("       BOSS分: ".. MerRT_ColorValue(list.p_boss) .."   额外分: ".. MerRT_ColorValue(list.p_added), 1, 0.8, 0.4)
	GameTooltip:AddLine("       物品分: ".. MerRT_ColorValue(list.p_item) .."   拾取分: ".. MerRT_ColorValue(list.m_loot), 1, 0.8, 0.4)
	
	if list.boss ~= "#" then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("参与BOSS: ", 0.8, 0.8, 0.4)			
		for boss in string.gmatch(list.boss,"[^#]+") do
			GameTooltip:AddLine("       - " .. boss, 1, 0.8, 0.5)
		end
	end
	GameTooltip:Show()	
end

function MerRT_Loots_DropMenu(level)
	if level == 3 then
		if not this.value then return end
		local id, class = select(3, strfind(this.value,"(%d+)#(.+)"))
		id = tonumber(id)
		for _, v in ipairs(MerRT.db[MerRT.tmp.selectid].players) do
			if v.class == class then
			info = {}
			info.text = MerRT.tmp.classes[v.class].hex .. v.name
			info.value = id
			info.arg1 = v.name
			info.arg2 = v.class
			info.func = function(name, class)
				MerRT.db[MerRT.tmp.selectid].loots[this.value].looter = name
				MerRT.db[MerRT.tmp.selectid].loots[this.value].class = class
				MerRT.UpdateLoots()
				HideDropDownMenu(1)				
			end
			UIDropDownMenu_AddButton(info,level)
			end
		end
		return
	end
	if level == 2 then
		if not this.value then return end
		for _, v in ipairs(MerRT.DROPMENU.loots[level]) do
			if v.value then
				v.value = this.value .. "#" .. (v.arg1 or "")
			end
			UIDropDownMenu_AddButton(v,level)
		end
		return
	end
	if level == 1 then
		for _, v in ipairs(MerRT.DROPMENU.loots[level]) do
			if v.value then
				v.value = this:GetParent().id
			end
			if v.text == "%1" then
				v.text = "|c" .. this:GetParent().color .. this:GetParent().item
				UIDropDownMenu_AddButton(v,level)
				v.text = "%1"
			else
				UIDropDownMenu_AddButton(v,level)
			end
		end
	end
end
function M.LootsOnClick(button)
	if button == "RightButton" then
		HideDropDownMenu(1);		
		MerRTFrameDropDown.initialize = MerRT_Loots_DropMenu
		MerRTFrameDropDown.displayMode = "MENU"
		ToggleDropDownMenu(1, nil, MerRTFrameDropDown, "cursor")
	end
end

function MerRT_Bosses_DropMenu(level)
	if level == 1 then
		for _, v in ipairs(MerRT.DROPMENU.bosses[level]) do
			if v.value then
				v.value = this.id
			end
			if v.text == "%1" then
				v.text = this.boss
				UIDropDownMenu_AddButton(v,level)
				v.text = "%1"
			else
				UIDropDownMenu_AddButton(v,level)
			end
		end
	end
end
function M.BossesOnClick(button)
	if button == "RightButton" then
		HideDropDownMenu(1);		
		MerRTFrameDropDown.initialize = MerRT_Bosses_DropMenu
		MerRTFrameDropDown.displayMode = "MENU"
		ToggleDropDownMenu(1, nil, MerRTFrameDropDown, "cursor")
	end
end

function MerRT_Options_DropMenu(level)
	if level == 2 then
		if not this.value then return end
		for _, v in ipairs(MerRT.DROPMENU.options[level]) do
			if this.value == "minq" then
				v.arg1 = "minquality"
				if MerRT.opt.minquality == v.value then
					v.checked = 1
				else
					v.checked = nil
				end
			elseif 	this.value == "maxq" then
				v.arg1 = "maxquality"
				if MerRT.opt.maxquality == v.value then
					v.checked = 1
				else
					v.checked = nil
				end
			end
			UIDropDownMenu_AddButton(v,level)
		end
		return
	end
	if level == 1 then
		for _, v in ipairs(MerRT.DROPMENU.options[level]) do
			if v.value then
				if MerRT.opt[v.value] then
					v.checked = 1
				else
					v.checked = nil
				end
			end
			UIDropDownMenu_AddButton(v,level)
		end
	end
end
function M.OptionsOnClick()
	HideDropDownMenu(1);		
	MerRTFrameDropDown.initialize = MerRT_Options_DropMenu
	MerRTFrameDropDown.displayMode = "MENU"
	ToggleDropDownMenu(1, nil, MerRTFrameDropDown, "cursor")
end

function MerRT_OpenPopupFrame(action, key, id, txt)
	MerRT_PopupFrame.action = action
	MerRT_PopupFrame.key = key
	MerRT_PopupFrame.id = id
	MerRT_PopupFrame:Show()
	MerRT_PopupFrameText:SetText(txt)
	MerRT_PopupFrameEditBox:SetText(UnitName("target") or "")
	if action == "confirm" then
		MerRT_PopupFrameEditBox:Hide()
		MerRT_PopupFrameAlertIcon:Show()
	else
		MerRT_PopupFrameEditBox:Show()
		MerRT_PopupFrameAlertIcon:Hide()
	end
end
function MerRT_SubmitPopupFrame(action, key, id)
	if action == "confirm" then
		if key == "delraid" then
			MerRT:DeleteRaid(id)
			MerRT.UpdateRaidList()			
		elseif key == "delplayer" then
			for boss in string.gmatch(MerRT.db[MerRT.tmp.selectid].players[id].boss,"[^#]+") do
				for _, v in ipairs(MerRT.db[MerRT.tmp.selectid].bosses) do				
					if boss == v.boss then
						v.attendants = gsub(v.attendants,"#".. MerRT.db[MerRT.tmp.selectid].players[id].name .."#","#")
					end
				end
			end
			tremove(MerRT.db[MerRT.tmp.selectid].players, id)
		elseif key == "delloot" then
			tremove(MerRT.db[MerRT.tmp.selectid].loots, id)
		elseif key == "delboss" then			
			for _, v in ipairs(MerRT.db[MerRT.tmp.selectid].players) do
				v.boss = gsub(v.boss,"#".. MerRT.db[MerRT.tmp.selectid].bosses[id].boss .."#","#")
			end
			tremove(MerRT.db[MerRT.tmp.selectid].bosses, id)
		end
		MerRT.UpdateSubFrames()
	elseif action == "edit" then
		local text = MerRT_PopupFrameEditBox:GetText()
		if key == "raiddesc" then
			MerRT.db[id].raid_desc = text
		elseif key == "raidzone" then
			MerRT.db[id].raid_zone = text
			MerRT.UpdateRaidList()
		elseif key == "playernotes" then
			MerRT.db[MerRT.tmp.selectid].players[id].notes = text
		elseif key == "playerclass" then
			if MerRT.tmp.classes[text] then
				MerRT.db[MerRT.tmp.selectid].players[id].class = text
				MerRT.UpdateSubFrames()
			end
		elseif key == "playerextra" then
			MerRT.db[MerRT.tmp.selectid].players[id].p_added = tonumber(text) or 0
		elseif key == "playertime" then
			if not tonumber(text) then return end
			MerRT.db[MerRT.tmp.selectid].players[id].t_time = tonumber(text) or 0
		elseif key == "lootnumber" then
			MerRT.db[MerRT.tmp.selectid].loots[id].number = tonumber(text) or 1
			MerRT.UpdateSubFrames()
		elseif key == "lootdkp" then
			MerRT.db[MerRT.tmp.selectid].loots[id].dkp = tonumber(text) or 0
			MerRT.UpdateSubFrames()
			if MerRT.opt.saveitemdkp then
				local list = MerRT.db[MerRT.tmp.selectid].loots[id]
				MerRT.itemvalues[list.item] = list.dkp
			end
		elseif key == "looter" then
			MerRT.db[MerRT.tmp.selectid].loots[id].looter = MerRT_UCFirst(text)
			MerRT.UpdateSubFrames()
		elseif key == "bossdkp" then
			MerRT.db[MerRT.tmp.selectid].bosses[id].dkp = tonumber(text) or 0
			MerRT.UpdateSubFrames()
		elseif key == "raidhourdkp" then
			MerRT.opt.hourdkp = tonumber(text) or 0
		elseif key == "raidgatherdkp" then
			MerRT.opt.gatherdkp = tonumber(text) or 0
		end
	end
end

function MerRT_ReportBBS(id)
	id = id or MerRT.tmp.selectid
	if not id or not MerRT.db[id] then return end
	local outtext = "开团时间：" .. MerRT.db[id].raid_start .."\n"
	if MerRT.db[id].raid_end then
		outtext = outtext .. "结束时间：" .. MerRT.db[id].raid_end .."\n"
	end
	outtext = outtext .. "活动地点：" .. MerRT.db[id].raid_zone .."\n"
	if getn(MerRT.db[id].bosses) > 0  then
		outtext = outtext .. "推倒BOSS：";
		for _, v in ipairs(MerRT.db[id].bosses) do
			outtext = outtext .. v.boss .. "  ";
		end
		outtext = outtext .. "\n";
	end
	if MerRT.db[id].raid_desc ~= "" then
		outtext = outtext .. "活动説明：" .. MerRT.db[id].raid_desc .."\n"
	end
	outtext = outtext .. "\n\n"
	outtext = outtext .. " 参与人员[" .. getn(MerRT.db[id].players) .."]\n"
	for class, _ in pairs(MerRT.tmp.classes) do
		local num, txt = 0, ""
		for _, v in ipairs(MerRT.db[id].players) do
			if v.class == class then
				txt = txt .. v.name .."  "
				num = num + 1
			end
		end
		if num > 0 then		
			outtext = outtext .. "\n " .. class .. "[".. num .. "]： ";
			outtext = outtext .. txt .. "\n";
		end
	end
	if getn(MerRT.db[id].loots) > 0  then
		outtext = outtext .. "\n\n BOSS掉落及物品获得者\n\n"
		for _, v in ipairs(MerRT.db[id].loots) do
			if v.number > 1 then
				outtext = outtext .. "[".. v.item .. "]x" .. v.number .. "    获得者：" .. v.looter
			else
				outtext = outtext .. "[".. v.item .. "]      获得者：" .. v.looter				
			end
			if v.dkp ~= 0 then
				outtext = outtext .. " (-" .. v.dkp * v.number .."PT)"
			end
			outtext = outtext .. "\n";
		end
	end
	MerRT_ReportFrame:Show()
	MerRT_ReportFrameScrollFrameChild:SetText(outtext)
	MerRT_ReportFrameScrollFrameChild:HighlightText()
end
function MerRT_ReportXML(id)
	id = id or MerRT.tmp.selectid
	if not id or not MerRT.db[id] then return end
	local outtext = "<RaidInfo>"
	local players = ""
	outtext = outtext .. "<key>" .. MerRT.db[id].raid_start .. "</key>"
	outtext = outtext .. "<start>" .. MerRT.db[id].raid_start .. "</start>"
	outtext = outtext .. "<end>" .. (MerRT.db[id].raid_end or MerRT.db[id].raid_start) .. "</end>"
	outtext = outtext .. "<zone>" .. MerRT.db[id].raid_zone .. "</zone>"
	outtext = outtext .. "<Note><![CDATA[" .. MerRT.db[id].raid_zone .. "]]></Note>"
	
	outtext = outtext .. "<PlayerInfos>"
	for i, v in ipairs(MerRT.db[id].players) do
		outtext = outtext .. "<key" .. i .. ">"
		outtext = outtext .. "<name>" .. v.name .. "</name>"
		outtext = outtext .. "<class>" .. v.class .. "</class>"
		outtext = outtext .. "<level>" .. v.level .. "</level>"
		outtext = outtext .. "<race>" .. (v.race or UNKNOWN) .. "</race>"
		outtext = outtext .. "</key" .. i .. ">"
		players = players .. "<key" .. i .. "><player>" .. v.name .. "</player><time>" .. v.join .. "</time></key" .. i .. ">"
	end
	outtext = outtext .. "</PlayerInfos>"

	outtext = outtext .. "<BossKills>"
	for i, v in ipairs(MerRT.db[id].bosses) do
		outtext = outtext .. "<key" .. i .. "><name>" .. v.boss .. "</name>"
		outtext = outtext .. "<time>" .. date("%m/%d/%y %H:%M:%S",v.timer*60) .. "</time><attendees>"
		local j = 1
		for player in string.gmatch(v.attendants,"[^#]+") do
			outtext = outtext .. "<key".. j .."><name>".. player .."</name></key".. j ..">"
			j = j + 1
		end
		outtext = outtext .. "</attendees></key" .. i .. ">"
	end
	outtext = outtext .. "</BossKills>"
		
	outtext = outtext .. "<Join>" .. players .. "</Join>"
	outtext = outtext .. "<Leave>" .. players .. "</Leave>"	
	
	outtext = outtext .. "<Loot>"
	for i, v in ipairs(MerRT.db[id].loots) do
		outtext = outtext .. "<key" .. i .. ">"
		outtext = outtext .. "<ItemName>" .. v.item .. "</ItemName>"
		outtext = outtext .. "<ItemID>" .. select(3,strfind(v.link,"item:(%d+)")) .. "</ItemID>"
		outtext = outtext .. "<Icon>" .. v.icon .. "</Icon>"
		outtext = outtext .. "<Class></Class><SubClass></SubClass>"
		outtext = outtext .. "<Color>" .. v.color .. "</Color>"
		outtext = outtext .. "<Count>" .. v.number .. "</Count>"
		outtext = outtext .. "<Player>" .. v.looter .. "</Player>"
		outtext = outtext .. "<Costs>" .. (v.dkp * v.number) .. "</Costs>"
		outtext = outtext .. "<Time>" ..  date("%m/%d/%y %H:%M:%S",v.timer*60) .. "</Time>"
		outtext = outtext .. "<Zone></Zone>"
		outtext = outtext .. "<Boss></Boss>"
		outtext = outtext .. "<Note></Note>"
		outtext = outtext .. "</key" .. i .. ">"
	end
	outtext = outtext .. "</Loot>"
	
	outtext = outtext .. "</RaidInfo>"
	
	MerRT_ReportFrame:Show()
	MerRT_ReportFrameScrollFrameChild:SetText(outtext)
	MerRT_ReportFrameScrollFrameChild:HighlightText()
end

function M.UpdateGather()
	if not MerRT.tmp.selectid or not MerRT.db[MerRT.tmp.selectid] then return end	
	local text = MerRT_PlayersFrameGatherBox:GetText()
	if text == "" then return end
	for i = 1, GetNumRaidMembers() do
		name, _, _, _, _, _, zone = GetRaidRosterInfo(i)
		if zone == text then
			for _, v in ipairs(MerRT.db[MerRT.tmp.selectid].players) do
				if v.name == name then
					v.p_gather = MerRT.opt.gatherdkp
					v.t_earn = v.p_boss + v.p_time + v.p_gather + v.p_item + v.p_added
					break
				end
			end
		end
	end
	MerRT_PlayersFrameGatherBox:SetText("")
	MerRT_PlayersFrameGatherBox:ClearFocus()
	MerRT.UpdatePlayers()
end
function M.AddPlayer()
	if not MerRT.tmp.selectid or not MerRT.db[MerRT.tmp.selectid] then return end	
	local timer = MerRT_GetTime()
	local text = MerRT_PlayersFrameInputBox:GetText()
	if text == "" or strfind(text,"%s") then return end
	text = MerRT_UCFirst(text)
	for _, v in ipairs(MerRT.db[MerRT.tmp.selectid].players) do
		if v.name == text then	return	end
	end
	tinsert(MerRT.db[MerRT.tmp.selectid].players, {
		name = text, class = UNKNOWN, level = 70,
		p_boss = 0, p_time = 0, p_gather = 0, p_item = 0, p_added = 0, m_loot = 0,		 
		t_time = 0, t_earn = 0, timer_join = timer, timer_left = timer, boss = "#",
		join = date("%m/%d/%y %H:%M:%S"), left = date("%m/%d/%y %H:%M:%S"),
	})
	MerRT_PlayersFrameInputBox:SetText("")
	MerRT_PlayersFrameInputBox:ClearFocus()
	MerRT.UpdatePlayers()
end
function M.AddItem()
	if not MerRT.tmp.selectid or not MerRT.db[MerRT.tmp.selectid] then return end
	local text = MerRT_LootsFrameInputBox:GetText()
	local color, itemlink, item = select(3, strfind(text, MerRT.loc.itemlinkText))
	if not itemlink then return end
	local itemid, texture, itemvalue, attendants
	itemid = select(3, strfind(itemlink,"item:(%d+):%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+"))
	texture = select(10, GetItemInfo(itemid))
	texture = select(3, strfind(texture, "%a+\\%a+\\([%w_]+)"))
	itemvalue = MerRT_GetItemValue(item)
	attendants = "#"	
	if MerRT.opt.sum0enabled and MerRT_LootsFrameCheckButton:GetChecked() then
		for i = 1, GetNumRaidMembers() do
			attendants = attendants .. UnitName("raid"..i) .. "#"
		end
	end
	tinsert(MerRT.db[MerRT.tmp.selectid].loots,1,{
		item = item, link = itemlink, icon = texture, color = color, member = GetNumRaidMembers(),
		looter = UNKNOWN, class = UNKNOWN, number = 1, dkp = itemvalue, timer = MerRT_GetTime(),
		attendants = attendants,
	})
	MerRT_LootsFrameInputBox:SetText("")
	MerRT_LootsFrameInputBox:ClearFocus()
	MerRT.UpdateLoots()
end
function M.AddBoss()
	if not MerRT.tmp.selectid or not MerRT.db[MerRT.tmp.selectid] then return end
	local boss = MerRT_BossKillsFrameInputBox:GetText()
	local text = MerRT_BossKillsFrameDetailsFrameDetailsBox:GetText()
	if boss == "" then return end
	MerRT_BossKillsFrameInputBox:SetText("")
	MerRT_BossKillsFrameInputBox:ClearFocus()
	MerRT_BossKillsFrameDetailsFrameDetailsBox:SetText("")
	MerRT_BossKillsFrameDetailsFrameDetailsBox:ClearFocus()
	local attendants = "#"
	if MerRT_BossKillsFrameCheckButton:GetChecked() then
		for i = 1, GetNumRaidMembers() do
			attendants = attendants .. UnitName("raid"..i) .. "#"
		end
		tinsert(MerRT.db[MerRT.tmp.selectid].bosses, {
			boss = boss, timer = MerRT_GetTime(), attendants = attendants, dkp = 0, number = GetNumRaidMembers(),
		})
		MerRT.UpdateBossKilled()
		return
	end
	text = "#" .. text .. "#"
	text = gsub(text, "\n", "")
	text = gsub(text, "##+", "#")
	local _, number = gsub(text, "#", "#")
	tinsert(MerRT.db[MerRT.tmp.selectid].bosses, {
			boss = boss, timer = MerRT_GetTime(), attendants = text, dkp = 0, number = number - 1,
	})
	MerRT.UpdateBossKilled()
end

hooksecurefunc("SetItemRef", function(link, text, button)
	if IsShiftKeyDown() and MerRT_LootsFrame:IsVisible() then
		MerRT_LootsFrameInputBox:Insert(text)
	end
end )

SlashCmdList["MerRT"] = function(txt)
	txt = strlower(txt)
	if txt == "on" then
		MerRT.opt.enabled = true
	elseif txt == "off" then
		MerRT:EndRaid()
		MerRT.opt.enabled = nil
	elseif txt == "start" then
		MerRT.opt.enabled = true
		MerRT:CreateRaid()
	elseif txt == "end" then
		MerRT:EndRaid()
	else
		MerRTFrame:Show()
	end
end
SLASH_MerRT1 = "/mrt"
SLASH_MerRT2 = "/merrt"
