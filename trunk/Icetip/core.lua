------------------------------------------------
--Icetip
--描述: wow提示增强插件.
--作者: 月色狼影
--$Rev: 1088 $
--$Id: core.lua 1088 2008-04-21 09:03:58Z wolftankk $
------------------------------------------------
local _G = getfenv(0)
local strformat, strfind = string.format, string.find
local temp, temp2, temp3
local _,i
local GameTooltip = _G.GameTooltip
local select = select
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local L = IceLocal

svnrev = tonumber(("$Rev: 1088 $"):match("%d+"));
addonRev = GetAddOnMetadata("Icetip", "Version");

--创建gametooltip frame
Icetip = CreateFrame("Frame", nil, GameTooltip)

local inspectName
local inspectList = {};

--颜色设置调用
local ClassColors ={}
for k, v in pairs(_G.RAID_CLASS_COLORS) do
	ClassColors[k] = strformat("%2x%2x%2x", v.r*255, v.g*255, v.b*255)
end

function Icetip:GetDefault()
	return {
		VividMask = true,
		Scale = 1.0,
		Talented = true,
		DisFaction = true,
		DisTarget = true,
		Fade = false,
		Anchor = 0,
		OffsetX = 30, OffsetY = 30,
		OrigPosX = 100, OrigPosY = 160,
		Version = addonRev,
		DisPvpRank = true,
		DisClass = true,
		SexName = false,
		Server = true;
	}
end

IcetipDB = Icetip:GetDefault()

Iceprint = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage(tostring(msg or nil))
end

IcetipTitle = "IceTip "..addonRev.."."..svnrev;

-------
local levDiff, levRange, r, g, b
--GetDifficultyColor 用法: 获取等级,返回 r g b 3种颜色
function Icetip:GetDifficultyColor(level)
	--获取差异等级
	levDiff = level - UnitLevel("player")
	levRange = GetQuestGreenRange()--8
	if (levDiff >=5 or level == -1) then
		r = 1; g = 0.2; b = 0.2;
	elseif (levDiff >= 3) then
		r = 1; g = 0.4; b = 0;
	elseif (levDiff >=-2) then
		r = 1; g = 1; b = 0;
	elseif (-levDiff <= levRange) then
		r = 0; g = 1; b = 0;
	else
		r = 0.53; g = 0.53; b = 0.53
	end
	return strformat("%2x%2x%2x", r*255,g*255,b*255)
end

--立体化
function Icetip:GetVVMask()
	local mask = _G["GameTooltipMask"]
	if mask then return mask end

	mask = GameTooltip:CreateTexture("GameTooltipMask")
	mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	mask:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -4, -30)
	mask:SetBlendMode("ADD")
	--Texture:SetGradientAlpha("orientation", minR, minG, minB, minA, maxR, maxG, maxB, maxA) 
	mask:SetGradientAlpha("VERTICAL", 0,0,0,0,1,1,1,0.76)
	mask:Hide()

	return mask
end

--CLASS
local coords
function Icetip:SetClassFlag(classToken)
	if not self.icon then
		self.icon = GameTooltip:CreateTexture(nil, "OVERLAY")
		self.icon:SetWidth(24); self.icon:SetHeight(24);
		self.icon:SetPoint("LEFT", GameTooltipTextLeft1, 1, 1)
		self.icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
	end
	coords = _G.CLASS_BUTTONS[classToken]
	self.icon:SetTexCoord(coords[1],coords[2],coords[3],coords[4])
	self.icon:Show()
end

--事件触发
function Icetip:OnEvent()
	if (event == "PLAYER_LOGIN") then
		self:Init()
		Iceprint("IceTip"..addonRev.."."..svnrev.."加载成功!欢迎访问http://cwowaddon.com获取更多插件信息")
			--设置命令行
		SLASH_ICETIP1 = "/icetip";
		SLASH_ICETIP2 = "/it";
		SlashCmdList["ICETIP"] = function(msg)
			Icetip:SlashCmd(msg)
		end
		if not IcetipDB.Version or tonumber(IcetipDB.Version) < tonumber(addonRev) then
			IcetipDB = Icetip:GetDefault()
			IcetipDB.Version = addonRev
			Iceprint("由于你的版本过旧,已经重置")
		end
		--hook
	elseif (event == "PLAYER_ENTERING_WORLD") then
		inspectList = {}
		GameTooltip:SetScale(IcetipDB.Scale)
	elseif (event == "UPDATE_FACTION") then
		self:UpdatePlayerFaction()
	elseif (event == "INSPECT_TALENT_READY") then
		if inspectName then
			local name = inspectName
			inspectName = nil
			--配点名称及点数
			local name1,_,point1 = GetTalentTabInfo(1,true)
			local name2,_,point2 = GetTalentTabInfo(2,true)
			local name3,_,point3 = GetTalentTabInfo(3,true)
			local color1, color2, color3 = Icetip_talentColor(point1, 61),Icetip_talentColor(point2,61),Icetip_talentColor(point3,61)
			local talent_name, talent_text = getTalentSpecName({name1,name2,name3}, {point1,point2,point3},{color1, color2, color3} )
			if not inspectList[name] or not inspectList[name].talent then
				inspectList[name].talent = talent_name
				inspectList[name].text = talent_text
			end
				--判断是否有目标
			if IcetipDB.Talented and UnitExists("mouseover") and UnitName("mouseover") == name then
				GameTooltip:AddLine(talent_name)
				GameTooltip:Show()--显示天赋
			end
		end
	end
end
Icetip:RegisterEvent("PLAYER_LOGIN")
Icetip:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
Icetip:RegisterEvent("INSPECT_TALENT_READY")--天赋事件注册
Icetip:SetScript("OnEvent", Icetip.OnEvent)


--初始
function Icetip:Init()

	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("INSPECT_TALENT_READY")

	self:SetScript("OnUpdate", self.OnUpdate) --显示位置

	GameTooltip:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 4, right= 4, top=4, bottom=4}
		});
	GameTooltip:SetBackdropBorderColor(0.5, 0.5, 0.5)
	GameTooltip:SetBackdropColor(0.09, 0.09,0.18)

	--立体化显示
	if (IcetipDB.VividMask) then
		Icetip:GetVVMask():Show()
	end

	--script hook
		--unit
	local orig = GameTooltip:GetScript("OnTooltipSetUnit");
	GameTooltip:SetScript("OnTooltipSetUnit", function(self, ...)
			Icetip:OnTooltipSetUnit()
			return orig(self, ...);
	end);

	local b = GameTooltip:GetScript("OnTooltipCleared")
	GameTooltip:SetScript("OnTooltipCleared", function(self, ...)
		GameTooltip_ClearMoney()
		Icetip:OnGameTooltipHide()
		return b(self, ...)
	end)
		
		--item
	local a = GameTooltip:GetScript("OnTooltipSetItem");
	GameTooltip:SetScript("OnTooltipSetItem", function(self, ...)
		if (a) then a(self, ...) end;
		local name, item = self:GetItem()
		if (item) then
			local quality = select(3, GetItemInfo(item));
			if(quality) then
				local r, g, b = GetItemQualityColor(quality)
					self:SetBackdropBorderColor(r, g, b)
					self:SetBackdropColor(0, 0, 0, 1)
			end
		end
	end);


	--hook
	GameTooltip_SetDefaultAnchor = Icetip.SetDefaultAnchor
	GameTooltip_UnitColor = function(unit)
		return self:UnitColor(unit)
	end
end



----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--声望
--
Icetip.factions={}

function Icetip:UpdatePlayerFaction()
--GetNumFactions()获取当前声望数量
	for i =1, GetNumFactions() do
		--获取每个声望的详细信息
		local name,_,standingId,_,_,_,_,_,isHeader,isCollapsed,_ = GetFactionInfo(i)
		if (not isHeader) then
			self.factions[name] = standingId
		end
	end
end

local reaction
local gender = UnitSex("player")

--进行声望格式化
local label, str
function Icetip:GetUnitFaction(unit, reaction)
--获取声望具体值
--从憎恨~崇拜  8个等级  4为中立
--1 憎恨 2 敌对 3 冷淡 4 中立 5 友好 6 尊敬 7 崇敬 8.崇拜
	reaction = reaction or UnitReaction(unit, "player")
	--若没有 返回空字符
	if (not reaction) then return "" end

	if (reaction == 7) then
	--GameTooltip:NumLines() 获取 tooltip  line数
		for i = GameTooltip:NumLines(), 3, -1 do
			label = _G["GameTooltipTextLeft"..i]:GetText()
			--获取string
			if label and label ~= PVP and self.factions[label] then
				reaction = self.factions[label]
				break
			end
		end
	end

	str = GetText("FACTION_STANDING_LABEL"..reaction, gender)
	if reaction == 4 then str = strformat("|cff33cc33%s|r", str)
	elseif reaction == 5 then str = strformat("|cff33cc33%s|r", str)
	elseif reaction == 6 then str = strformat("|cff33cccc%s|r", str)
	elseif reaction == 7 then str = strformat("|cffFF6633%s|r", str)
	elseif reaction == 8 then str = strformat("|cffDD33DD%s|r", str)
	end

	return str
end

function Icetip:OnUpdate(elapsed)
	if Icetip.AnchorType then
		x, y =GetCursorPosition()
		uiscale = UIParent:GetScale()
		tipscale = GameTooltip:GetScale()
		x = (x + IcetipDB.OffsetX)/tipscale/uiscale
		GameTooltip:ClearAllPoints()
		if Icetip.AnchorType  == 2 then
			y = (y + IcetipDB.OffsetY)/uiscale/tipscale
			GameTooltip:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x, y)
		else
			y = (y - IcetipDB.OffsetY)/ tipscale / uiscale
			GameTooltip:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT", x, y)
		end
	end

	if UnitExists("mouseover") then
		Icetip:RefreshMouseOverTarget(elapsed)
	elseif Icetip.unit and IcetipDB.Fade then
		GameTooltip:Hide()
	end
end

--tip 格式化
local unit
local bplayer, bdead, tapped
local tip, text, levelline, temp, temp2
local unitrace, unitCreatureType
local guild

--预先格式化
local targetlinenum
local found, truenum

--Note: 在NPC种类上分 NPC和玩家两类.
--NPC细分为 普通 精英 稀有 稀有精英 以及 未知 等5个种类

--鼠标指定的目标
--3种情况 目标为你 目标:xxx  自身
--参数 IcetipDB.DisTarget
local mouseTarget
function Icetip:RefreshMouseOverTarget(elapsed)
	--设置刷新时间
	self.timer = (self.timer or 0.5) + elapsed
	if (self.timer < 0.5) then return end
	self.timer = 0

	if not IcetipDB.DisTarget or not targetlinenum then return end

	text = _G["GameTooltipTextLeft"..targetlinenum]
	if (not text) then return end

	tip, temp, temp2 = nil, nil, nil
	--获取是否存在目标
	if (not UnitExists(Icetip.unittarget)) then
		mouseTarget = nil
		text:SetText()
		GameTooltip:Show()
	else
		name = UnitName(Icetip.unittarget)--获取目标名字
		if (name ~= mouseTarget) then
			mouseTarget = name or UNKNOWNOBJECT
			tip = strformat("|cffFFFF00%s:  [|r", L.TARGET)--显示[ 当前目标
			
			--**目标指向你
			if UnitIsUnit(Icetip.unittarget, "player") then
				tip = strformat("%s |c00ff0000** %s **|r", tip, L.YOU)
			--**指向目标自己本身
			elseif UnitIsUnit(Icetip.unittarget, Icetip.unit) then
				tip = strformat("%s |cffFFFFFF** %s **|r", tip, L.SELF)
			--**目标
			elseif UnitIsPlayer(Icetip.unittarget) then
				temp, temp2 = UnitClass(Icetip.unittarget)--获取职业信息
				--是否为敌对目标
				if UnitIsEnemy(Icetip.unittarget, "player") then
				--如果为敌对 则显示红色
					tip = strformat("%s |cffFF0000** %s **|r |cff%s(%s)|r",tip, mouseTarget, (ClassColors[(temp2 or "")]), temp)--tip 鼠标目标 颜色代码 职业代号
				else
				--如果为友方 则显示白色
					tip = strformat("%s |cffFFFFFF** %s **|r |cff%s(%s)|r",tip, mouseTarget, (ClassColors[(temp2 or "")]), temp)
				end
			else
				tip = strformat("%s |cffFFFF00** %s **|r",tip, mouseTarget)
			end
		tip = strformat("%s |cffFFFF00]|r", tip)
		text:SetText(tip)
		GameTooltip:Show()
		end
	end
end

function Icetip:OnTooltipSetUnit()
	Icetip.unit = self:OnMouseOverUnit(GameTooltip:GetUnit())
	Icetip.unittarget = Icetip.unit .. "target";
	GameTooltipStatusBar.unit = Icetip.unit;
end

function Icetip:OnGameTooltipHide()
	targetlinenum = nil;
	truenum = nil;
	mouseTarget = nil;
	Icetip.AnchorType = nil;
	Icetip.Timer = nil;
	Icetip.unit = nil;
	Icetip.unittarget = nil;
	if Icetip.icon then Icetip.icon:Hide() end
end

function Icetip:ShowGUI()
	InterfaceOptionsFrame_OpenToFrame(IcetipTitle)
end


--着色 目标名字着色
function Icetip:UnitColor(unit, bdead, tapped, reaction)
	bdead = bdead or UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	--tapped
	tapped = tapped or UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))
	reaction = reaction or UnitReaction(unit, "player")

	--第一排
	--如果死亡显示灰色
	if tapped or bdead then
		r = 0.55; g = 0.55; b = 0.55
	elseif (UnitIsPlayer(unit) or UnitPlayerControlled(unit) ) then
		if (UnitCanAttack(unit, "player")) then
			if (not UnitCanAttack("player", unit)) then--不可攻击显示
				r=1.0; g=0.4; b=0.9
			else
				--敌对为红色
				r=1.0; g=0.0; b =0.0
			end
		elseif (UnitCanAttack("player", unit)) then--玩家可攻击 黄色
			r= 1.0; g=1.0; b=0
		elseif (UnitIsPVP(unit)) then--PVP状态 绿色
			r = 0.0; g = 1.0; b = 0.0
		else
			r = 0.8; g = 0.7; b = 0.9
		end
	elseif reaction then--NPC显示
		if reaction < 4 then
			r,g,b =1,0.3,0.22
		elseif reaction > 4 then
			r,g,b = 0,1,0
		else --中立
			r,g,b = 1,1,0
		end
	else --normal白色
		r, g, b =1, 1, 1
	end

	return r,g,b
end

--****************************
function Icetip:OnMouseOverUnit(name, unit)
	--获取鼠标指定人物的类型
	if unit == "Npc" then unit = "mouserover" end

	bplayer = UnitIsPlayer(unit)
	name = name or UnitName(unit)

	--死尸
	bdead = UnitHealth(unit) < 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))

	--faction
	reaction = UnitReaction(unit,"player")
	--提示背景颜色设置
	Icetip:setBackdropColor(unit)

---------------------------[[******************]]----------------------
	tip, text, levelline, found, temp, temp2, temp3 = nil
	--进行改造
	--首先获取tooltip 行数
	truenum = GameTooltip:NumLines()
	--从2开始
	for i = 2, truenum do
		text = _G[GameTooltip:GetName().."TextLeft"..i]--将从2~xx的table导入到text下
		tip = text:GetText()--获取文字信息
		if tip then
			--等级
			if (not levelline) and strfind(tip, LEVEL) then
				levelline = i
			elseif (tip == PVP) then
				text:SetText()
				found = true
			elseif (tip == TAMEABLE) then
				text:SetText(strformat("|cff00FF00%s|r", tip))
			elseif (tip == NOT_TAMEABLE) then
				text:SetText(strformat("|cffFF6035%s|r", tip))
			end
		end
	end

		--插入目标行
	if IcetipDB.DisTarget then
		targetlinenum = truenum
		if not found then
			GameTooltip:AddLine("--------")
			targetlinenum = targetlinenum + 1
		end
		text = _G["GameTooltipTextLeft"..targetlinenum]
		if text then
			text:SetText()
		else
			targetlinenum = nil
		end
	end
	--天赋
	if IcetipDB.Talented then
		name = UnitName(unit)
		if not inspectList[name] then
			inspectList[name] = {};
		end
		if not inspectList[name].report then
			if UnitCanAttack("player", unit) then
				inspectList[name].report = 1
			else
				inspectList[name].report = 0
			end
		end
		if UnitIsVisible(unit) and UnitIsPlayer(unit) and UnitIsConnected(unit) then
			if inspectList[name].talent then
				GameTooltip:AddLine(inspectList[name].talent)

			elseif not inspectName then
				inspectName = name
				if not inspectList[name].class then
					inspectList[name].class,inspectList[name].eClass = UnitClass(unit)
				end
				if not inspectList[name].race then
					inspectList[name].race = UnitRace(unit)
				end
				if not inspectList[name].raceColor then
					if UnitCanAttack("player", unit) then
						inspectList[name].raceColor = "|cffc81e00"
					else
						inspectList[name].raceColor = "|cff1ec800"
					end
				end
				lastInspectTime = time()
				NotifyInspect(unit)
			elseif time() - lastInspectTime > 2 then
				inspectName = nil
			end
		end
	end
	
--等级行改写
	if levelline then
		--等级,如果目标死亡则显示尸体
		temp = UnitLevel(unit)
		temp2 = ""
		if bdead then
			if temp > 0 then
				temp2 = "Lv."..(strformat(" |cff888888%d %s|r", temp, CORPSE))
			else--?? 尸体
				temp2 = "Lv."..(strformat(" |cff888888?? %s|r", CORPSE))
			end
		elseif (temp > 0) then
			--等级颜色
			if UnitCanAttack("player", unit) or UnitCanAttack(unit,"player") then
				temp2 = "Lv."..(strformat(" |cff%s%d|r", Icetip:GetDifficultyColor(temp), temp))
			else
			--普通颜色
				temp2 = "Lv."..strformat(" |cff3377CC%d|r",temp)
			end
		else
			temp2 = "Lv."..(strformat(" |cffFF0000 ??|r"))
		end

		--种族 职业/ 人物类型/ 宠物种类
		unitrace = UnitRace(unit)
		unitCreatureType = UnitCreatureType(unit)

		if unitrace and bplayer then
			if UnitFactionGroup(unit) == UnitFactionGroup("player") then
				temp = "00FF33"
			else
				temp = "FF3300"
			end

			temp2 = strformat("%s |cff%s%s|r", temp2, temp, unitrace)
			--职业
			_, temp = UnitClass(unit)
			if IcetipDB.DisClass then
				Icetip:SetClassFlag(temp)
			end			
			--职业着色
			temp = ClassColors[(temp or "")]
			temp2 = strformat("%s |cff%s%s|r", temp2, temp, _)
		elseif UnitPlayerControlled(unit) then
			temp2 = strformat("%s %s", temp2,(UnitCreatureFamily(unit) or unitCreatureType or ""))
		elseif unitCreatureType then
			if IcetipDB.DisFaction and reaction and reaction > 4 then
				temp2 = strformat("%s |cffFFFFFF%s|r (%s)", temp2, unitCreatureType, Icetip:GetUnitFaction(unit, reaction))
			elseif unitCreatureType == L.SPEC then--未指定
				temp2 = strformat("%s %s",temp2, _G.UNKNOWN)
			else
				temp2 = strformat("%s %s", temp2, unitCreatureType)
			end
		else
			temp2 = strformat("%s %s",temp2, _G.UKNOWNBEING)
		end
		tip = temp2

		--信息
		temp = nil
		temp2 = ""
		
		if bplayer then
			temp2 = strformat(" (%s)", _G.PLAYER)
		elseif not UnitPlayerControlled(unit) then
			temp = UnitClassification(unit)
			if temp and temp ~= "normal" and UnitHealth(unit) > 0 then
				if temp == "elite" then
					temp2 = strformat("|cffFFFF33(%s)|r", _G.ELITE)
				elseif temp == "worldboss" then
					temp2 = strformat("|cffFF0000(%s)|r", _G.BOSS)
				elseif temp == "rare" then
					temp2 = format("|cffFF66FF(%s)|r", L.Rare)
				elseif temp == "rareelite" then
					temp2 = format("|cffFFAAFF(%s %s)|r",L.Rare, _G.ELITE)
				else
					temp2 = strformat("(%s)", temp)
				end
			end
		end
		_G["GameTooltipTextLeft"..levelline]:SetText( strformat("%s%s", tip, temp2))
	end

	--军衔显示 使用UnitPVPName(unit) 获取pvprank PlayerName
	if bplayer then
		if IcetipDB.DisClass then
			tip = "      ";
		else
			tip = "";
		end
		
		if IcetipDB.SexName then
			temp3 = nil
			temp3 = UnitSex("mouseover")
			tmprank = UnitLevel("mouseover")
			if tmprank < 70 then
				if temp3 == 2 then
					temp3 = L.NickName1;
				elseif temp3 == 3 then
					temp3 = L.NickName2
				end			
			else
				if temp3 == 2 then
					temp3 = L.NickName3
				elseif temp3 == 3 then
					temp3 = L.NickName4
				end
			end
		else
			temp3 = ""
		end

		if not IcetipDB.DisPvpRank then
			GameTooltipTextLeft1:SetText(strformat("%s%s %s",tip, name, temp3))
		else
			GameTooltipTextLeft1:SetText(strformat("%s%s %s", tip, (UnitPVPName(unit) or name), temp3))
		end
	end
	
--buff print
	--Icetip:getBuffIcon("mouseover")


--GUILD
	tip = nil
	guild, guildrank = GetGuildInfo(unit)
	if bplayer then
		if guild then
			tip = "< "..guild.." > - "..guildrank
		end
		_, temp = UnitName(unit)
		if (IcetipDB.Server) and (temp or tip) then
			if (temp and tip) then
				temp2 = " @ "
			else
				temp2 = ""
			end
			tip = strformat("%s|cffFFAA50%s%s|r", tip or "", temp2, temp or "")
		end
		if tip then
			if guild then
				GameTooltipTextLeft2:SetText(tip)
			elseif levelline == 2 then
				temp3 = GameTooltip:NumLines()
				for i = temp3, 2, -1 do
					_G["GameTooltipTextLeft"..i+1]:SetText(_G["GameTooltipTextLeft"..i]:GetText())
				end
				GameTooltipTextLeft2:SetText(tip)
				if targetlinenum then
					targetlinenum = targetlinenum + 1
				end
			end
		end
	end

---color
 --给第一行Unit字体上色
	r,g,b = Icetip:UnitColor(unit,bdead,tapped, reaction)
	GameTooltipTextLeft1:SetTextColor(r,g,b)
	
	--第二行
	if tip or (levelline or levelline > 2) then
		if bdead or tapped then
			GameTooltipTextLeft2:SetTextColor(0.55,0.55,0.55)
		else
			GameTooltipTextLeft2:SetTextColor(r*0.86,g*0.86,b*0.86)
		end
	end
	
	if bplayer then
		if guild == GetGuildInfo("player") then
			GameTooltipTextLeft2:SetTextColor(0.9,0.45,0.7)
		else
			GameTooltipTextLeft2:SetTextColor(0.8,0.8,0.8)
		end
	end
	
	GameTooltip:Show()
	return unit
end