local VERSION = tonumber(("$Revision: 54590 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Comments = QuestsFu:NewModule("Comments", "AceHook-2.1", "AceEvent-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2007-11-13 21:58:00 -0500 (Tue, 13 Nov 2007) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local tablet = AceLibrary("Tablet-2.0")
local quixote = AceLibrary("Quixote-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Comments")

QuestsFu_Comments.lname = L["Comments"]
QuestsFu_Comments.desc = L["Display quest comments"]

function QuestsFu_Comments:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Comments")
	QuestsFu:RegisterDefaults("Comments", "profile", {
		lightheaded = true,
		data = {},
		strata = "HIGH",
		minWidth = 300,
		maxHeight = 800,
	})
	self.menu = {
		name = L["Comments"],
		desc = L["Display quest comments"],
		type = "group",
		args = {
			lightheaded = {
				name = L["LightHeaded"],
				desc = L["LightHeaded"],
				type = 'toggle',
				get = function() return self.db.profile.lightheaded end,
				set = function(t) self.db.profile.lightheaded = t end,
				disabled = function() return not (LightHeaded and LightHeaded.IterateQuestComments) end
			},
			strata = QuestsFu.strataOption(self, 'QuestsFu_Comments', 1),
			maxHeight = QuestsFu.maxHeightOption(self, 'QuestsFu_Comments', 2),
			minWidth = QuestsFu.minWidthOption(self, 'QuestsFu_Comments', 3),
			--This one will look a little weird on the tablet right-click menu, as it'll be duplicating native functionality.  But it's totally worth it to stop people complaining.
			lock = QuestsFu.lockOption(self, 'QuestsFu_Comments', 4),
		},
	}
end

function QuestsFu_Comments:OnEnable()
	if QuestsFu:IsModuleActive('Details') then
		self:Hook(QuestsFu, "ShowLog")
		self:Hook(QuestsFu:GetModule('Details'), "Update", "UpdateQuestDetail")
	end
end

function QuestsFu_Comments:OnDisable()
	QuestsFu.toggleTablet('QuestsFu_Comments', false)
	tablet:Unregister('QuestsFu_Comments')
end

function QuestsFu_Comments:ShowLog(object, questid)
	--self.questid = questid
	self.hooks[object].ShowLog(object, questid)
	if questid and LightHeaded and LightHeaded.IterateQuestComments and self.db.profile.lightheaded and QuestsFu:IsModuleActive('Details') then
		self:ScheduleEvent(self.Update, 0, self) --Schedule an event because tablet bugs out otherwise.
	end
end

function QuestsFu_Comments:UpdateQuestDetail(object)
	self.hooks[object].Update(object)
	self:Update()
end

do
	local detail = QuestsFu:GetModule('Details')
	local function urlClick(url)
		ChatFrameEditBox:Show()
		ChatFrameEditBox:SetText(url)
		ChatFrameEditBox:SetFocus()
	end
	local function npcClick(npcid)
		if QuestsFu_Comments.npcid == npcid then
			QuestsFu_Comments.npcid = nil
		else
			QuestsFu_Comments.npcid = npcid
		end
		QuestsFu_Comments:Update()
	end
	local function addNpcLocs(cat, id, name)
		if LightHeaded:LoadNPCData(id) then
			for c,z,x,y in LightHeaded:IterateNPCLocs(id) do
				cat:AddLine('text', '|cFF0066FF['..x..', '..y..']|r', 'func', LightHeaded.OnHyperlinkClick, 'arg1', LightHeaded, 'arg2', 'lhref:zcoord:'..c..':'..z..':'..x..':'..y..':'..name, 'indentation', 10)
			end
		else
			cat:AddLine('text', L['Location unknown'], 'indentation', 10)
		end
	end

	function QuestsFu_Comments:Update()
		if not tablet:IsRegistered('QuestsFu_Comments') then
			tablet:Register('QuestsFu_Comments', 'detachedData', self.db.profile.data, 'cantAttach', true, 'dontHook', true,
				'hideWhenEmpty', true, 'showTitleWhenDetached', true, 'strata', self.db.profile.strata,
				'minWidth', self.db.profile.minWidth, 'maxHeight', self.db.profile.maxHeight,
				'menu', function() dewdrop:FeedAceOptionsTable(self.menu) end,
				'children', function()
					-- Much of this was taken from LightHeaded itself.
					if detail.questid and LightHeaded and LightHeaded.IterateQuestComments then
						local title, level, tag = quixote:GetQuestById(detail.questid)
						for qid,sharable,_,reqlev,stype,sname,sid,etype,ename,eid,exp,rep,series in LightHeaded:IterateQuestInfo(title, level) do
							
							tablet:SetTitle(L["Comments"])
							
							local cat = tablet:AddCategory('text', L['LightHeaded Info'], 'columns', 1, 'wrap', true, 'justify', 'CENTER')
							
							cat:AddLine('text', L['Quest ID: ']..'|cffffffff'..qid, 'func', urlClick, 'arg1', 'http://www.wowhead.com/?quest='..qid)
							cat:AddLine('text', L['Shareable: ']..'|cffffffff'..(shareable and L['Yes'] or L['No']))
							cat:AddLine('text', L['Level: ']..'|cffffffff'..level)
							if reqlev ~= '' then cat:AddLine('text', L['Required Level: ']..'|cffffffff'..reqlev) end
							if stype ~= '' and sname ~= '' then
								if stype=='npc' then
									cat:AddLine('text', L['Starts: ']..'|cFF0066FF['..sname..']|r', 'func', npcClick, 'arg1', sid) end
								else
									cat:AddLine('text', L['Starts: ']..'|cffffffff'..sname)
								end
							if sid == self.npcid then addNpcLocs(cat, sid, sname) end
							if etype ~= '' and ename ~= '' then
								if etype == 'npc' then
									cat:AddLine('text', L['Ends: ']..'|cFF0066FF['..ename..']|r', 'func', npcClick, 'arg1', eid) end
								else
									cat:AddLine('text', L['Ends: ']..'|cffffffff'..ename)
								end
							if eid == self.npcid then addNpcLocs(cat, eid, ename) end
							if exp ~= '' then cat:AddLine('text', L['Experience: ']..'|cffffffff'..exp) end
							if rep ~= '' then
								-- Might want to do an inline category here with columns...
								cat:AddLine('text', L['Reputation:'])
								
								for name,value in rep:gmatch("([^\029]+)\029([^\029]+)") do
									cat:AddLine('text', '|cffffd100' .. name .. ' - ' .. value, 'indentation', 10)
								end
							end
							
							if series ~= "" then
								cat:AddLine('text', L['Quest Series:'])
								
								for step,id in series:gmatch("([^\029]+)\029([^\029]+)") do
									local name = ""
									LightHeaded:LoadQIDData(id)
									if not LH_QuestData then
										name = L["Quest "] .. id
									else
										id = tonumber(id)
										name = LightHeaded:QIDToTitleLevel(id)
									end
									cat:AddLine('text', '|cffffd100'..step..'|r: '..name, 'indentation', 10)
								end
							end
						end
						
						cat = tablet:AddCategory('text', L['LightHeaded Comments'], 'columns', 1, 'wrap', true, 'justify', 'CENTER')
						if LightHeaded:GetNumQuestComments(title, level) then
							for idx, qid, cid, rating, indent, parent, date, poster, comment in LightHeaded:IterateQuestComments(title, level) do
								cat:AddLine('indentation', indent*10, 'text', ("|cFF66FF66[%s - %s - %s]|r"):format(poster, date, rating), 'wrap', true)
								cat:AddLine('indentation', indent*10, 'text', comment, 'wrap', true)
								cat:AddLine('text', ' ') -- spacer.
							end
						else
							cat:AddLine('text', L["No comments found..."])
						end
						
						cat:AddLine('text', L["Comments are all from WowHead"], 'hasCheck', true, 'checked', true, 'checkIcon', 'Interface\\Addons\\LightHeaded\\images\\wh_icon', 'func', urlClick, 'arg1', 'http://www.wowhead.com')
					end
				end)
			tablet:Open('QuestsFu_Comments')
		end
		tablet:Refresh('QuestsFu_Comments')
	end
end
