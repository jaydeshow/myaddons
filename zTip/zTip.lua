--[[
	zTip by Zero Fire from Beijing, China
	配合2.0的种种改变重新实现，面向对象编程。
--]]

local _G = getfenv(0)
local format = string.format
local strfind = string.find
local _, i

local inspectList = {}
local inspectName
local inspectTime = GetTime()

zTip = CreateFrame("Frame",nil,GameTooltip)

function zTip:GetDefault()
	return {
		-- 以下为参数设置
		-- 提示: 取值只有两种 -- 1. 数字 2. true / false
		-- true 表示开启, false表示关闭

		Anchor = 3,			-- Default: 0
		-- [false 使用系统默认位置(屏幕右下角)]
		-- [0为人物信息跟随鼠标，非人物（按钮之类）使用默认位置（屏幕右下角）]
		-- [1为屏幕上方，注意用OffsetX和OffsetY调整相对位置，非人物为默认位置（屏幕右下角）]
		-- [2为跟随鼠标，向上延展，非人物为默认位置]
		-- [3为全部跟随鼠标，非人物(按钮之类)为对象右上]
		-- [4为屏幕上方，注意用OffsetX和OffsetY调整相对位置，非人物为对象右上]
		-- [5为全部跟随鼠标，并向上延展，要正上方，将Offset调为0,0即可]

		OffsetX = 30, OffsetY = 30,	-- 位置偏移值（系统位置无效） Default: 30,30

		OrigPosX = 100, OrigPosY = 160, -- 系统默认位置的偏移值，要使用游戏默认设置为: false, false

		Scale = 1.0,					-- 提示缩放 Default: 1.1 取值：0~N.x		Game's Default: 1.0

		Fade = false,					-- 是否渐隐 Default: false

		DisplayPvPRank = false,		-- 显示军衔[false 不显示 | true 显示] Default: false

		ShowIsPlayer = false,			-- 是否在等级行显示“（玩家）”字样	Default: false

		DisplayFaction = true,		-- 是否显示NPC声望等级。

		PlayerServer = true,			-- 是否显示玩家所属服务器. Default: true

		TargetOfMouse = true,		-- 显示对象的目标. Default: true

		ClassIcon = true,				-- 显示对象玩家的职业图标。Default: true

		VividMask = true,				-- 立体化鼠标提示. Default: true
		ShowTalent = true,			--是否显示玩家天赋
		TargetedBy = true,			--是否显示关注目标
	}
end

zTipSaves = zTip:GetDefault()

-- 公会名和姓名的明暗度调整 Default: 0.86 暗一点（不可超过1！）
zTip.GuildColorAlpha = 0.86

-- 各个职业颜色列表
-- 去掉了

-- localized strings
zTip.locStr = {}

-- record player's factions standingId
zTip.factions = {}

-- translate a color object into hex color string
function zTip:GetHexColor(color)
	if not color then
		return "FFFFFF"
	else
		return format("%2x%2x%2x",color.r*255,color.g*255,color.b*255)
	end
end

-- level color
local lDiff,lRange, r, g, b
function zTip:GetDifficultyColor(level)
	lDiff = level - UnitLevel("player");
	lRange = GetQuestGreenRange()
	if (lDiff >= 0) then
		r = 1.00; b = 0.00;
		if lDiff < 10 then
			g = 1 - (lDiff*0.10)
		else
			g = 0.00
		end
	elseif ( -lDiff < lRange) then
		g = 1.00; b = 0.00;
		r = 1 - (-1.0*lDiff)/lRange
	elseif ( -lDiff == lRange ) then
		r = 0.50; g = 1.00; b = 0.50;
	else
		r = 0.75; g = 0.75; b = 0.75;
	end
	return format("%2x%2x%2x",r*255,g*255,b*255);
end

local coords
function zTip:SetClassIcon(classToken)
	if not self.icon then
		self.icon = GameTooltip:CreateTexture(nil, "OVERLAY")
		self.icon:SetWidth(16); self.icon:SetHeight(16);
		self.icon:SetPoint("LEFT", GameTooltipTextLeft1, 1, 1)
		self.icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
	end
	coords = CLASS_BUTTONS[classToken]
	self.icon:SetTexCoord(coords[1],coords[2],coords[3],coords[4])
	self.icon:Show()
end

function zTip:GetVividMask()
	local mask = _G["GameTooltipMask"]
	if mask then return mask end

	mask = GameTooltip:CreateTexture("GameTooltipMask")
	mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	mask:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -4, -30)
	mask:SetBlendMode("ADD")
	mask:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 1, 1, 1, 0.66)
	mask:Hide()

	return mask
end

--[[
	Events
--]]

--------------------------------------------------------------------------------------------------------
--                                            天赋着色来自TinyTip                                     --
--------------------------------------------------------------------------------------------------------

local function getTalentSpecName(names, nums, colors)
	if nums[1] == 0 and nums[2] == 0 and nums[3] == 0 then
		return _G.NONE, _G.NONE
	else
		local first, second, third, name, text, point
		if nums[1] >= nums[2] then
			if nums[1] >= nums[3] then
				first = 1
				if nums[2] >= nums[3] then second = 2 third = 3 else second = 3	third = 2 end
			else
				first = 3 second = 1 third = 2
			end
		else
			if nums[2] >= nums[3] then
				first = 2
				if nums[1] >= nums[3] then second = 1 third = 3 else second = 3 third = 1 end
			else
				first = 3 second = 2 third = 1
			end
		end
		local first_num = nums[first]
		local second_num = nums[second]
		if first_num*3/4 <= second_num then
			if first_num*3/4 <= nums[third] then
				name = colors[first]:format(names[first]).."/"..colors[second]:format(names[second]).."/"..colors[third]:format(names[third])
				text = names[first].."/"..names[second].."/"..names[third]
			else
				name = colors[first]:format(names[first]).."/"..colors[second]:format(names[second])
				text = names[first].."/"..names[second]
			end
		else
			name = colors[first]:format(names[first])
			text = names[first]
		end
		point = (" |cc8c8c8c8(%s|cc8c8c8c8/%s|cc8c8c8c8/%s|cc8c8c8c8)"):format(colors[1]:format(nums[1]), colors[2]:format(nums[2]), colors[3]:format(nums[3]))
		return name..point, text..(" (%s/%s/%s)"):format(nums[1], nums[2], nums[3])
	end
end

local function talentColor(point, maxValue, order)
	local r,g,b
	local minp, maxp = 0, maxValue
	point = max(0, min(point, maxValue))
	if ( (maxp - minp) > 0 ) then
		point = (point - minp) / (maxp - minp)
	else
		point = 0
	end
	if(point > 0.5) then
		r = 0.1 + (((1-point) * 2)* (1-(0.1)))
		g = 0.9
	else
		r = 1.0
		g = (0.9) - (0.5 - point)* 2 * (0.9)
	end
	r = string.format("%x", (r * 100) * 2.55);
	if ( #r == 1 ) then	r = "0"..r;	end
	g = string.format("%x", (g * 100) * 2.55);
	if ( #g == 1 ) then	g = "0"..g;	end
	b = "18"
	if order then
		return "|cff"..r..g..b.."%s|r"
	else
		return "|cff"..g..r..b.."%s|r"
	end
end

function zTip:OnEvent()
	if event == "PLAYER_LOGIN" then
		self:Init()
	elseif event == "PLAYER_ENTERING_WORLD" then
		GameTooltip:SetScale(zTipSaves.Scale)
	elseif event == "UPDATE_FACTION" then
		self:UpdatePlayerFaction()
	elseif event == "INSPECT_TALENT_READY" then
		if (inspectName) then
			local name = inspectName
			inspectName = nil

			local name1,_,point1 = GetTalentTabInfo(1,true)
			local name2,_,point2 = GetTalentTabInfo(2,true)
			local name3,_,point3 = GetTalentTabInfo(3,true)
			local color1, color2, color3 = talentColor(point1, 61),talentColor(point2,61),talentColor(point3,61)
			local talent_name, talent_text = getTalentSpecName({name1,name2,name3}, {point1,point2,point3},{color1, color2, color3} )

			if (zTipSaves.ShowTalent and talent_name and talent_text) then
				inspectList[name].talent = talent_name
				--inspectList[name].text = talent_text
				if (UnitExists("mouseover") and UnitName("mouseover") == name) then
					GameTooltip:AddLine(zTip.locStr.Talent..talent_name)
					GameTooltip:Show()
				end
			end
		end
	end
end
zTip:RegisterEvent("PLAYER_LOGIN")
--zTip:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
zTip:RegisterEvent("INSPECT_TALENT_READY")
zTip:SetScript("OnEvent",zTip.OnEvent)

--[[
	Initialize
--]]
function zTip:Init()
	-- self initial
	self:Localize()

	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("INSPECT_TALENT_READY")

	self:SetScript("OnUpdate", self.OnUpdate)

	-- setting GameTooltip
	GameTooltip:SetBackdrop( {
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	  tile = true, tileSize = 16, edgeSize = 16,
	  insets = { left = 4, right = 4, top = 4, bottom = 4 } -- this is what we need!
	});
	GameTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);

	-- mask
	if zTipSaves.VividMask then
		zTip:GetVividMask():Show()
	end

	-- mana bar
	--GameTooltipStatusBar.manabar = CreateFrame("StatusBar","GameTooltipManaBar",GameTooltipStatusBar)
	--GameTooltipManaBar:SetPoint("TOPLEFT",GameTooltipStatusBar,"BOTTOMLEFT")
	--GameTooltipManaBar:SetPoint("TOPRIGHT",GameTooltipStatusBar,"BOTTOMRIGHT")
	--GameTooltipManaBar:SetHeight(GameTooltipStatusBar:GetHeight())
	--GameTooltipManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill")
	--UnitFrameManaBar_Initialize("mouseover",GameTooltipManaBar)

	-- Scripts
	GameTooltip:SetScript("OnTooltipSetUnit", zTip.OnTooltipSetUnit)
	GameTooltip:SetScript("OnTooltipCleared", function()
		GameTooltip_ClearMoney()
		zTip:OnGameTooltipHide()
	end)

	-- HOOKs
	GameTooltip_SetDefaultAnchor = zTip.SetDefaultAnchor
	GameTooltip_UnitColor = function(unit)
		return zTip:UnitColor(unit)
	end

	-- Slash
	SLASH_ZTIPSLASH1 = "/ztip"
	SlashCmdList["ZTIPSLASH"] = function(msg)
		zTip:Slash(msg)
	end
end

--[[
	factions
--]]
local name, standingId, isHeader, isCollapsed
function zTip:UpdatePlayerFaction()
	for i = 1, GetNumFactions() do
		name,_,standingId,_,_,_,_,_,isHeader,isCollapsed,_ = GetFactionInfo(i)
		if not isHeader then
			self.factions[name] = standingId
		end
	end
end

local reaction	-- this var used in several functions
local gender = UnitSex("player")

-- get the formated faction name
local label, str
function zTip:GetUnitFaction(unit, reaction)
	reaction = reaction or UnitReaction(unit, "player")
	if not reaction then return "" end

	if reaction == 7 then
		for i = GameTooltip:NumLines(),3,-1 do
			label = _G["GameTooltipTextLeft"..i]:GetText()
			if label and label ~= PVP and self.factions[label] then
				reaction = self.factions[label]
				break
			end
		end
	end
	str = GetText("FACTION_STANDING_LABEL"..reaction, gender)
	if reaction == 5 then str = format("|cff33CC33%s|r", str)
	elseif reaction == 6 then str = format("|cff33CCCC%s|r", str)
	elseif reaction == 7 then str = format("|cffFF6633%s|r", str)
	elseif reaction == 8 then str = format("|cffDD33DD%s|r", str) end

	return str
end

--[[
	Positions
--]]
local x,y,uiscale,tipscale

function zTip:SetDefaultAnchor(parent)
	self:SetOwner(parent, "ANCHOR_NONE");

	if zTipSaves.OrigPosX and zTipSaves.OrigPosY then
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -zTipSaves.OrigPosX - 13, zTipSaves.OrigPosY);
	else
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y);
	end
	--self.default = 1;

	if zTipSaves.Anchor then
		if parent == UIParent then
			-- posiont will be set in update function
			if zTipSaves.Anchor == 0 or zTipSaves.Anchor == 3 then
				zTip.AnchorType = 1
			elseif zTipSaves.Anchor == 2 or zTipSaves.Anchor == 5 then
				zTip.AnchorType = 2
			end
			if UnitExists("mouseover") then
				if zTipSaves.Anchor == 1 or zTipSaves.Anchor == 4 then -- on top
					zTip.AnchorType = nil
					uiscale = UIParent:GetScale()
					tipscale = self:GetScale()
					x = zTipSaves.OffsetX / tipscale / uiscale
					y = zTipSaves.OffsetY / tipscale / uiscale
					self:ClearAllPoints()
					self:SetPoint("TOP",UIParent,"TOP", x, -y)
				else -- follow cursor [0,2,3,5]
				end
			else -- not unit 像是熔炉，信箱
				self:SetOwner(parent, "ANCHOR_CURSOR")
			end
		else -- not a unit tip, buttons or other
			if zTipSaves.Anchor > 2 or parent.unit then
				self:SetOwner(parent,"ANCHOR_RIGHT")
			else -- use default anchor (BottomRight to Screen)

			end
		end
	else -- use deault

	end
end

function zTip:OnUpdate(elapsed)
	-- offset to mouse
	if zTip.AnchorType then
		x,y = GetCursorPosition()
		uiscale = UIParent:GetScale()
		tipscale = GameTooltip:GetScale()
		x = (x + zTipSaves.OffsetX) / tipscale / uiscale
		GameTooltip:ClearAllPoints()
		if zTip.AnchorType == 2 then
			y = (y + zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x, y)
		else
			y = (y - zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT", x, y)
		end
	end

	if UnitExists("mouseover") then
		-- refresh target of mouseover
		zTip:RefreshMouseOverTarget(elapsed)
	elseif zTip.unit and not zTipSaves.Fade then
		GameTooltip:Hide()
	end
end

--[[
	Tip Formatings
--]]
local unit
local bplayer, bdead, tapped
local tip, text, levelline, tmp, tmp2
local unitrace, unitCreatureType
local guild

--[[ Pre Format ]]
local targetlinenum
local found, trueNum
--[[ MouseOver Target ]]
local mouseTarget
function zTip:RefreshMouseOverTarget(elapsed)
	-- timer, refresh every 0.5s
	self.timer = (self.timer or 0.5) + elapsed
	if self.timer < 0.5 then return end
	self.timer = 0

	if not zTipSaves.TargetOfMouse or not targetlinenum then return end

	text = _G["GameTooltipTextLeft"..targetlinenum]
	if not text then return end

	tip, tmp, tmp2 = nil, nil, nil
	if not UnitExists(zTip.unittarget) then
		mouseTarget = nil
		text:SetText()
		GameTooltip:Show()
	else
		name = UnitName(zTip.unittarget)
		if name ~= mouseTarget then
			mouseTarget = name or UNKNOWNOBJECT
			tip = format("|cffFFFF00%s [|r", zTip.locStr.Targeting) -- '['
			-- 指向我自己
			if UnitIsUnit(zTip.unittarget, "player") then
				tip = format("%s |c00FF0000%s|r", tip, zTip.locStr.YOU)
			-- 指向他自己
			elseif UnitIsUnit(zTip.unittarget, zTip.unit) then
				tip = format("%s |cffFFFFFF%s|r", tip, zTip.locStr.Self)
			-- 指向其它玩家
			elseif UnitIsPlayer(zTip.unittarget) then
				tmp, tmp2 = UnitClass(zTip.unittarget)
				if UnitIsEnemy(zTip.unittarget,"player") then
					-- red enemy player
					tip = format("%s |cffFF0000%s|r |cff%s(%s)|r", tip,mouseTarget,
						zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]), tmp)
				else
					-- white friend player
					tip = format("%s |cffFFFFFF%s|r |cff%s(%s)|r", tip,mouseTarget,
						zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]), tmp)
				end
			else
				tip = format("%s |cffFFFFFF%s|r", tip, mouseTarget)
			end
			tip = format("%s |cffFFFF00]|r", tip) -- ']'
			text:SetText(tip)
			GameTooltip:Show()
		end
	end
end

function zTip:OnTooltipSetUnit()
	zTip.unit = zTip:OnMouseOverUnit(GameTooltip:GetUnit())
	zTip.unittarget = zTip.unit.."target"
	GameTooltipStatusBar.unit = zTip.unit
	--GameTooltipManaBar.unit = zTip.unit
	--UnitFrameManaBar_Update(GameTooltipManaBar,zTip.unit)
end

function zTip:OnGameTooltipHide()
	targetlinenum = nil
	trueNum = nil
	mouseTarget = nil
	zTip.AnchorType = nil
	zTip.timer = nil
	zTip.unit = nil
	zTip.unittarget = nil
	if zTip.icon then zTip.icon:Hide() end
end

--[[ Name Color ]]

function zTip:UnitColor(unit, bdead, tapped, reaction)
	bdead = bdead or UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = tapped or UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))
	reaction = reaction or UnitReaction(unit, "player")
--~ 第一行名字上色
	if tapped or bdead then
		r = 0.55;g = 0.55;b = 0.55
	elseif (UnitIsPlayer(unit) or UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			if ( not UnitCanAttack("player", unit) ) then
				--purple, caution, only they can attack
				r = 1.0;g = 0.4;b = 1.0
			else
				-- Hostile players are red
				r = 1.0;g = 0.0;b = 0.0
			end
		elseif ( UnitCanAttack("player", unit) ) then
			-- Players we can attack but which are not hostile are yellow
			r = 1.0;g = 1.0;b = 0.0
		elseif ( UnitIsPVP(unit) ) then
			-- Players we can assist but are PvP flagged are green
			r = 0.0;g = 1.0;b = 0.0
		else
			-- All other players are blue (the usual state on the "blue" server)
			r = 0;g = 0.7;b = 1.0
		end
	elseif reaction then
		-- mob/npc
		if reaction < 4 then -- harm
			r,g,b = 1,0.3,0.22
		elseif reaction > 4 then -- friendly
			r,g,b = 0,1,0
		else -- nature
			r,g,b = 1,1,0
		end
	else -- normal
		r,g,b = 1,1,1
	end

	return r,g,b
end

--[[ Format Unit Tip ]]
--[[
	if on mouse over unit, then first call GameTooltip_UnitColor("mouseover")
	then UPDATE_MOUSEOVER_UNIT triggers
	elseif on a UnitFrame first call GameTooltip_UnitColor("mouseover") too
	then call GameTooltip:SetUnit function
	last UnitFrame will call GameTooltip_UnitColor(this.unit) again but not the "mouseover"
--]]
function zTip:OnMouseOverUnit(name,unit)
	-- hack to fix problems
	if unit == "npc" then unit = "mouseover" end

--[[
	local values and initials
--]]
	bplayer = UnitIsPlayer(unit)
	name = name or UnitName(unit)

	--~ 尸体，排除猎人假死
	bdead = UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))

	-- 1 憎恨 2 敌对 3 冷淡 4 中立 5 友好 6 尊敬 7 崇敬/崇拜
	reaction = UnitReaction(unit, "player")

--[[
	New Way
--]]
	tip, text, levelline, found, tmp, tmp2 = nil

	--[[ Serch and Delete ]]
	trueNum = GameTooltip:NumLines()
	for i = 2, trueNum do
		text = _G[GameTooltip:GetName().."TextLeft"..i]
		tip = text:GetText()
		if tip then
			--~ 查找等级行
			if not levelline and strfind(tip, LEVEL) then
				levelline = i
			-- 删除PVP字符
			elseif tip == PVP then
				text:SetText()
				found = true
			-- 能否驯服
			elseif tip == TAMEABLE then
				text:SetText( format("|cff00FF00%s|r", tip) )
			elseif tip == NOT_TAMEABLE then
				text:SetText( format("|cffFF6035%s|r", tip) )
			end
		end
	end

	-- insert target line
	if zTipSaves.TargetOfMouse then
		targetlinenum = trueNum

		if not found then
			GameTooltip:AddLine("zTip -- target line")
			targetlinenum = targetlinenum + 1
		end

		text = _G["GameTooltipTextLeft"..targetlinenum]
		if text then
			text:SetText()
		else
			targetlinenum = nil
		end
	end

	-- insert talent line
	if (zTipSaves.ShowTalent and UnitIsPlayer(unit)) then
		inspectList[name] = inspectList[name] or {}
		if (inspectList[name].talent) then
			local talentInfo = inspectList[name].talent
			GameTooltip:AddLine(zTip.locStr.Talent..talentInfo)
			--GameTooltip:Show()
		else
			if (not inspectName) then
				inspectName = name
				inspectTime = GetTime()
				NotifyInspect(unit)
			else
				if ((GetTime() - inspectTime) > 2.0) then
					inspectName = nil
				end
			end
		end
	end

	-- Add "Targeted By" line
	if zTipSaves.TargetedBy then
		local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers()
		if (numParty > 0 or numRaid > 0) then
			local players, counter = "", 0
			for i = 1, (numRaid > 0 and numRaid or numParty) do
				local unit1 = (numRaid > 0 and "raid"..i or "party"..i)
				if (UnitIsUnit(unit1.."target",unit)) and (not UnitIsUnit(unit1,"player")) then
					if (mod(counter + 3,6) == 0) then
						players = players.."\n"
					end
					local color = RAID_CLASS_COLORS[select(2,UnitClass(unit1))]
					players = ("%s|cff%.2x%.2x%.2x%s|r, "):format(players,color.r*255,color.g*255,color.b*255,UnitName(unit1))
					counter = (counter + 1)
				end
			end
			if (players ~= "") then
				GameTooltip:AddLine(zTip.locStr.TargetedBy.." (|cffffffff"..counter.."|r): "..players:sub(1,-5))
			end
		end
	end

	--[[ Level Line Rewrite ]]
	if levelline then
		-- level, and corpse if dead
		tmp = UnitLevel(unit)
		tmp2 = ""
		if bdead then
			if tmp > 0 then
				tmp2 = format("|cff888888%d %s|r", tmp, CORPSE)
			else
				tmp2 = format("|cff888888?? %s|r", CORPSE)
			end
		elseif ( tmp > 0 ) then
			-- Color level number
			if UnitCanAttack("player", unit) or UnitCanAttack(unit, "player") then
				tmp2 = format("|cff%s%d|r", zTip:GetDifficultyColor(tmp), tmp)
			else
				-- normal color
				tmp2 = format("|cff3377CC%d|r",tmp)
			end
		else
			-- Target is too high level to tell
			tmp2 = "|cffFF0000 ??|r"
		end

		-- race, class/ creature type/ creature family(pet)
		unitrace = UnitRace(unit)
		unitCreatureType = UnitCreatureType(unit)
		if unitrace and bplayer then
			--race, it is a player
			if UnitFactionGroup(unit) == UnitFactionGroup("player") then
				tmp = "00FF33"
			else
				tmp = "FF3300"  -- 敌对阵营种族为暗红
			end
			tmp2 = format("%s |cff%s%s|r", tmp2, tmp, unitrace)
			-- class
			_, tmp = UnitClass(unit)
			-- class icon
			if zTipSaves.ClassIcon then
				zTip:SetClassIcon(tmp)
			end
			tmp = zTip:GetHexColor(RAID_CLASS_COLORS[(tmp or "")])
			tmp2 = format("%s |cff%s%s|r ", tmp2, tmp, _)
		elseif UnitPlayerControlled(unit) then
			--creature family, its is a pet
			-- 非战斗宠没有物种的用类型
			tmp2 = format("%s %s ",tmp2,(UnitCreatureFamily(unit) or unitCreatureType or "") )
		elseif unitCreatureType then
			--creature type, it is a mob or npc
			if zTipSaves.DisplayFaction and reaction and reaction > 4 then
				tmp2 = format("%s |cffFFFFFF%s|r %s ", tmp2, unitCreatureType, zTip:GetUnitFaction(unit,reaction))
			elseif unitCreatureType == zTip.locStr.NotSpecified then
				tmp2 = format("%s %s ", tmp2, zTip.locStr.Specified)
			else
				tmp2 = format("%s %s ", tmp2, unitCreatureType)
			end
		else
			tmp2 = format("%s %s ",tmp2,UKNOWNBEING)
		end
		tip = tmp2

		-- special info
		tmp = nil
		tmp2 = ""
		if bplayer then
			if zTipSaves.ShowIsPlayer then
				tmp2 = format("(%s)",PLAYER)
			end
		elseif not UnitPlayerControlled(unit) then
			tmp = UnitClassification(unit) -- Elite status
			--if tmp and tmp ~= "normal" and UnitHealth(unit) > 0 then
			if tmp and tmp ~= "normal" then
				if tmp == "elite" then
					tmp2 = format("|cffFFFF33(%s)|r", ELITE)
				elseif tmp == "worldboss" then
					tmp2 = format("|cffFF0000(%s)|r", BOSS)
				elseif tmp == "rare" then
					tmp2 = format("|cffFF66FF(%s)|r", zTip.locStr.Rare)
				elseif tmp == "rareelite" then
					tmp2 = format("|cffFFAAFF(%s%s)|r", zTip.locStr.Rare, ELITE)
				else
					tmp2 = format("(%s)", tmp) -- unknown type
				end
			end
		end
		_G["GameTooltipTextLeft"..levelline]:SetText( format("%s%s",tip,tmp2) )
	end

	--[[ First Line, rewrite name ]]
	if bplayer then
		-- 军衔
		if zTipSaves.ClassIcon then
			tip = "     "
		else
			tip = ""
		end
		if not zTipSaves.DisplayPvPRank then
			GameTooltipTextLeft1:SetText( format("%s%s", tip, name ) )
		else
			GameTooltipTextLeft1:SetText( format("%s%s", tip, (UnitPVPName(unit) or name) ) )
		end
	end

	--[[ Second Line, Rewrite / Insert guild and/or realm name ]]
	tip = nil
	guild = GetGuildInfo(unit)
	if bplayer then
		-- 工会
		if guild then
			tip = "<"..guild..">"
		end
		-- 服务器
		_, tmp = UnitName(unit)
		if zTipSaves.PlayerServer and (tmp or tip) then
			if tmp and tip then
				tmp2 = " @ "
			else
				tmp2 = ""
			end
			tip = format("%s|cff00EEEE%s%s|r", tip or "", tmp2, tmp or "")
		end
		if tip then
			if guild then
				GameTooltipTextLeft2:SetText(tip)
			elseif levelline == 2 then
				tmp = GameTooltip:NumLines()
				GameTooltip:AddLine("zTip -- this is Add Line")
				for i = tmp, 2, -1 do
					_G["GameTooltipTextLeft"..i+1]:SetText(_G["GameTooltipTextLeft"..i]:GetText())
				end
				GameTooltipTextLeft2:SetText(tip)
				if targetlinenum then
					targetlinenum = targetlinenum + 1
				end
			end
		end
	end

	--[[ Colors ]]

--~ color name
	r,g,b = zTip:UnitColor(unit, bdead, tapped, reaction)
	GameTooltipTextLeft1:SetTextColor(r,g,b)

--~ 给第二行上色
	if tip or (levelline and levelline > 2) then
		if bdead or tapped then -- 尸体或已被攻击
			GameTooltipTextLeft2:SetTextColor(0.55,0.55,0.55)
		else
			GameTooltipTextLeft2:SetTextColor(r*zTip.GuildColorAlpha,g*zTip.GuildColorAlpha,b*zTip.GuildColorAlpha)
		end
	end
--~ 标记本工会为亮色
	if bplayer and guild == GetGuildInfo("player") then
		GameTooltipTextLeft2:SetTextColor(0.9, 0.5, 0.9)
	end

--[[
	done
--]]
	GameTooltip:Show()

	return unit
end

--[[
	Slash Command
--]]

function zTip:Slash(msg)
	local param1 = string.lower(msg)
	if (param1 == "cc") then
		inspectList = {}
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r 天赋缓存已被清空", 1,1,0)
	else
		if not zTipOption then return end
		if not zTipOption.ready then zTipOption:Init() end
		if not zTipOption:IsShown() then zTipOption:Show() end
		UpdateAddOnMemoryUsage()
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r Toggle Option Window", 1,1,0)
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r "..format("%.2f",GetAddOnMemoryUsage("zTip")).." KB", 1,1,0)
	end

end