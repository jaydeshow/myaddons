local VERSION = tonumber(("$Revision: 65647 $"):match("%d+"))

local QuestsFu = QuestsFu
local QuestsFu_Details = QuestsFu:NewModule("Details", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")
if QuestsFu.revision < VERSION then
	QuestsFu.version = "r" .. VERSION
	QuestsFu.revision = VERSION
	QuestsFu.date = ("$Date: 2008-03-25 03:23:42 -0400 (Tue, 25 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local tablet = AceLibrary("Tablet-2.0")
local quixote = AceLibrary("Quixote-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("Abacus-2.0")

local L = AceLibrary("AceLocale-2.2"):new("QuestsFu_Details")

QuestsFu_Details.lname = L["Quest details"]
QuestsFu_Details.desc = L["Custom quest details pane"]

function QuestsFu_Details:OnInitialize()
	self.db = QuestsFu:AcquireDBNamespace("Details")
	QuestsFu:RegisterDefaults("Details", "profile", {
		data = {
			fontSizePercent=0.9, detached=true,
		},
		strata = 'HIGH',
		minWidth = 300,
		maxHeight = 800,
	})
	self.menu = {
		type = 'group', name = L["Quest details"], handler = QuestsFu,  --Handler here because we're going to reuse this table later on in the tablet registration.
		desc = L["Custom quest details pane"], order = 99,
		args = {
			strata = QuestsFu.strataOption(self, 'QuestsFu_Detail', 1),
			maxHeight = QuestsFu.maxHeightOption(self, 'QuestsFu_Detail', 2),
			minWidth = QuestsFu.minWidthOption(self, 'QuestsFu_Detail', 3),
			--This one will look a little weird on the tablet right-click menu, as it'll be duplicating native functionality.  But it's totally worth it to stop people complaining.
			lock = QuestsFu.lockOption(self, 'QuestsFu_Detail', 4),
		},
	}
end

function QuestsFu_Details:OnEnable()
	self:RegisterEvent("Quixote_Quest_Lost")
	self:RegisterEvent("Quixote_Leaderboard_Update", "Update")
	self:Hook(QuestsFu, "ShowLog")

	self:Update()
end

function QuestsFu_Details:OnDisable()
	QuestsFu.toggleTablet('QuestsFu_Detail', false)
	tablet:Unregister("QuestsFu_Detail")
end

function QuestsFu_Details:ShowLog(object, questid)
	if self.questid ~= questid then
		self.questid = questid
	else
		self.questid = nil
	end
	self:ScheduleEvent(self.Update, 0, self) --Schedule an event because tablet bugs out otherwise.

	--deliberately don't call the hook
end

function QuestsFu_Details:Quixote_Quest_Lost(name, id)
	if self.questid == id then
		self.questid = nil
		self:Update()
	end
end

do
	local escapeDetector
	local qualitycolors = {
		[0] = "|cff9d9d9d",
		[1] = "|cffffffff",
		[2] = "|cff1eff00",
		[3] = "|cff0070dd",
		[4] = "|cffa335ee",
		[5] = "|cffff8000"
	}

	local questgiverPat = '^' .. L["%s in %s (%d,%d)"]:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1"):gsub("%%%%s", "(.*)"):gsub("%%%%d", "(%%d+)") .. '$'

	local showingDescription = true
	local function itemClick(link)
		if not link then return end
		if IsControlKeyDown() then
			DressUpItemLink(link)
		elseif IsShiftKeyDown() then
			if not ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Show()
			end
			ChatFrameEditBox:Insert(link)
		else
			ShowUIPanel(ItemRefTooltip)
			if not ItemRefTooltip:IsVisible() then
				ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
			end
			ItemRefTooltip:SetHyperlink(link)
		end
	end
	local function itemHover(link)
		if not link then return end
		GameTooltip:SetOwner(_G.this, 'ANCHOR_RIGHT', 7, -18)
		GameTooltip:SetHyperlink(link)
		if IsShiftKeyDown() then
			GameTooltip_ShowCompareItem()
		end
		GameTooltip:Show()
	end
	local function hideQuestDetail()
		QuestsFu_Details.questid = nil
		escapeDetector:Hide()
		QuestsFu_Details:Update()
	end
	local function toggleDescription()
		showingDescription = not showingDescription
		tablet:Refresh('QuestsFu_Detail')
	end
	local function abandonQuestPopup(questid)
		local startingQuestLogSelection = GetQuestLogSelection()
		SelectQuestLogEntry(questid)
		SetAbandonQuest()
		local items = GetAbandonQuestItems()
		if items then
			StaticPopup_Hide("ABANDON_QUEST")
			StaticPopup_Show("ABANDON_QUEST_WITH_ITEMS", GetAbandonQuestName(), items)
		else
			StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
			StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName())
		end
		SelectQuestLogEntry(startingQuestLogSelection)
	end
	
	local directions = L["bunch-of-directions"]
	local colorizeQuestText, populateObjectiveWords, fixWords
	function colorizeQuestText(text, words)
		text = text:gsub("%f[%a%d%|](%d+)%f[^%a%d%|]", "|cff00ff00%1|r") -- Match numbers
		--This is copied in approach from MonkeyQuestLog, note.
		for _,word in ipairs(words) do
			if GetLocale() == "koKR" then
				text = text:gsub(word, "|cffffffff"..word.."|r")
			else
				text = text:gsub(word, "|cffffffff%1|r")
			end
		end
		return text
	end

	function populateObjectiveWords(words, text)
		local last = nil
		for word in text:gmatch("(%S+)") do
			if last and last:find("[%w,%-]$") then
				local clean_word = word:match("(%u[%w'%-]+)")
				if clean_word then
					words[clean_word:lower()] = true
				end
			end
			last = word
		end
	end

	local function ignoreCaseHelper(v)
		return "[" .. v .. v:upper() .. "]"
	end
	local t = {}
	local i_byte = ('i'):byte()
	local apos_byte = ("'"):byte()
	function fixWords(words)
		for word in pairs(words) do
			t[word] = true
			words[word] = nil
		end
		for word in pairs(t) do
			t[word] = nil
			if word ~= "i" and (word:byte(1) ~= i_byte or word:byte(2) ~= apos_byte) then
				if GetLocale() == "koKR" then
					words[#words+1] = word:gsub("%f[%w](%w)", ignoreCaseHelper)
				else
					if not word:find("%?$") then
						if word:find("s$") then
							word = word .. "?"
						else
							word = word .. "s?"
						end
					end
					words[#words+1] = "%f[%w%d%|]" .. word:gsub("%f[%w](%w)", ignoreCaseHelper) .. "%f[^%w%d%|]"
				end
			end
		end
	end

	escapeDetector = CreateFrame("Frame", "QuestsFu_escapeDetector")
	escapeDetector:SetScript("OnHide", hideQuestDetail)
	table.insert(UISpecialFrames, escapeDetector:GetName())

	local words = {}

	function QuestsFu_Details:Update()
		if not tablet:IsRegistered('QuestsFu_Detail') then
			tablet:Register('QuestsFu_Detail', 'detachedData', self.db.profile.data,
				'dontHook', true, 'hideWhenEmpty', true,-- 'showTitleWhenDetached', true,
				'minWidth', self.db.profile.minWidth, 'maxHeight', self.db.profile.maxHeight,
				'strata', self.db.profile.strata, 'cantAttach', true,
				'menu', function() dewdrop:FeedAceOptionsTable(self.menu) end,
				'children', function()
					tablet:SetTitle("Detail")
					if self.questid then
						escapeDetector:Show()
						local startingQuestLogSelection = GetQuestLogSelection()
						SelectQuestLogEntry(self.questid)

						local title, level, tag, suggestedGroup, complete, nObjectives, zone, id = quixote:GetQuest(self.questid)
						local objective, description = quixote:GetQuestText(self.questid)

						--Title and objective:
						if not QuestsFu.db.profile.color.title then title = QuestsFu:Colorize(title, 1, 1, 1) end
						if not QuestsFu.db.profile.color.level then level = QuestsFu:Colorize(questLevel, 1, 1, 1) end
						local color = GetDifficultyColor(level)

						if QuestsFu:IsModuleActive("Givers") and questgiverPat and QuestsFu:GetModule("Givers").db.char.questgivers[title] then
							local giverName, giverZone = QuestsFu:GetModule("Givers").db.char.questgivers[title]:match(questgiverPat)
							if giverName then
								words[giverName:lower()] = true
								words[giverZone:lower()] = true
							end
						end
						populateObjectiveWords(words, objective)
						populateObjectiveWords(words, description)
						for _,v in ipairs(directions) do
							words[v] = true
						end
						if nObjectives > 0 then
							for i = 1, nObjectives do
								local objective = quixote:GetQuestStatusById(self.questid, i)
								if objective then
									words[objective:lower()] = true
								end
							end
						end
						fixWords(words)

						local cat = tablet:AddCategory('columns', 1, 'text', QuestsFu:MakeTag(level, tag, suggestedGroup)..title,
							'textR', (color and color.r) or 1, 'textG', (color and color.g) or 1, 'textB', (color and color.b) or 1,
							'size', tablet:GetHeaderFontSize(), 'justify', 'CENTER',
							'func', QuestsFu.QuestClick, 'arg1', QuestsFu, 'arg2', id) --Do this instead of closing the tablet because it seems permanently blank on its second open otherwise.
						if complete then
							cat:AddLine('text', complete, 'textR', (complete == AceLibrary("AceLocale-2.2"):new("QuestsFu")["(failed)"]) and 1 or 0, 'textG', (complete == AceLibrary("AceLocale-2.2"):new("QuestsFu")["(done)"]) and 1 or 0, 'textB', 0, 'justify', 'CENTER')
						end
						if suggestedGroup and suggestedGroup > 0 then
							cat:AddLine('text', (QUEST_SUGGESTED_GROUP_NUM):format(suggestedGroup), 'justify', 'CENTER')
						end
						cat:AddLine('text', colorizeQuestText(objective, words), 'wrap', true)

						--Leaderboard:
						if nObjectives > 0 then
							cat = tablet:AddCategory('columns', 2)
							for i=1,nObjectives do
								QuestsFu:AddLeaderboardToCategory(cat, self.questid, i, tablet:GetNormalFontSize(), 0)
							end
						end

						--Given by?
						if QuestsFu:IsModuleActive("Givers") then
							local giver = QuestsFu:GetModule("Givers").db.char.questgivers[title]
							if giver then
								cat = tablet:AddCategory('columns', 2, 'text', L["Given by"])
								cat:AddLine('text', colorizeQuestText(giver, words), 'indentation', 2)
							end
						end

						--Requires money?
						if GetQuestLogRequiredMoney() > 0 then
							cat = tablet:AddCategory('columns', 2, 'text', L["Required money: "]..abacus:FormatMoneyFull(GetQuestLogRequiredMoney()), 'showWithoutChildren', true)
						end

						--Requires an item?
						local numRequiredItems = GetNumQuestItems()
						if numRequiredItems > 0 then
							cat:AddLine('text', L["Required item(s):"], 'indentation', 2)
							for i=1, numRequiredItems, 1 do
								local name, texture, numItems, quality, isUsable = GetQuestItemInfo('required', i)
								cat:AddLine('text', (quality and qualitycolors[quality] or '')..'['..(name or L['<not yet cached>'])..']'..((numItems > 1) and (" x"..numItems) or ""), 'indentation', 4,
									'checked', true, 'hasCheck', true, 'checkIcon', texture,
									'func', itemClick, 'arg1', GetQuestLogItemLink('required', i),
									'onEnterFunc', itemHover, 'onEnterArg1', GetQuestLogItemLink('required', i),
									'onLeaveFunc', GameTooltip.Hide, 'onLeaveArg1', GameTooltip)
							end
						end

						--Description:
						cat = tablet:AddCategory('columns', 1, 'text', L["Description"], 'func', toggleDescription, 'showWithoutChildren', true,
							'checked', true, 'hasCheck', true, 'checkIcon', (not showingDescription) and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
						if showingDescription then
							cat:AddLine('text', colorizeQuestText(description, words), 'wrap', true)
						end
						for i in ipairs(words) do
							words[i] = nil
						end

						--Rewards:
						cat = tablet:AddCategory('columns', 2, 'text', L["Rewards"])
						local numChoices = GetNumQuestLogChoices(self.questid) -- The ones you choose from
						local numRewards = GetNumQuestLogRewards(self.questid) -- The ones you always get
						local rewardMoney = GetQuestLogRewardMoney(self.questid) -- Moolah!
						local rewardSpellTexture, rewardSpellName = GetQuestLogRewardSpell() -- Sometimes there's a spell

						if numChoices > 0 or numRewards > 0 or rewardMoney > 0 then
							if numChoices > 0 then
								cat:AddLine('text', L["Choose from:"], 'indentation', 2)
								for i=1, numChoices, 1 do
									local name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(i)
									cat:AddLine('text', (quality and qualitycolors[quality] or '')..'['..(name or L['<not yet cached>'])..']'..((numItems > 1) and (" x"..numItems) or ""), 'indentation', 4,
										'checked', true, 'hasCheck', true, 'checkIcon', texture,
										'func', itemClick, 'arg1', GetQuestLogItemLink('choice', i),
										'onEnterFunc', itemHover, 'onEnterArg1', GetQuestLogItemLink('choice', i),
										'onLeaveFunc', GameTooltip.Hide, 'onLeaveArg1', GameTooltip)
								end
							end
							if numRewards > 0 then
								cat:AddLine('text', L["Always receive:"], 'indentation', 2)
								for i=1, numRewards, 1 do
									local name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i)
									cat:AddLine('text', (quality and qualitycolors[quality] or '')..'['..(name or L['<not yet cached>'])..']'..((numItems > 1) and (" x"..numItems) or ""), 'indentation', 4,
										'checked', true, 'hasCheck', true, 'checkIcon', texture,
										'func', itemClick, 'arg1', GetQuestLogItemLink('reward', i),
										'onEnterFunc', itemHover, 'onEnterArg1', GetQuestLogItemLink('reward', i),
										'onLeaveFunc', GameTooltip.Hide, 'onLeaveArg1', GameTooltip)
								end
							end
							if rewardSpellTexture then
								cat:AddLine('text', L["Spell:"], 'indentation', 2)
								cat:AddLine('text', rewardSpellName, 'indentation', 4,
									'checked', true, 'hasCheck', true, 'checkIcon', rewardSpellTexture)
							end
							if rewardMoney > 0 then
								cat:AddLine('text', L['Money: ']..abacus:FormatMoneyFull(rewardMoney, true), 'indentation', 2)
							end
						else
							cat:AddLine('text', L["Nothing."], 'indentation', 2)
						end

						cat = tablet:AddCategory('columns', 1, 'text', L["Options"])
						--Shareable:
						if GetQuestLogPushable() then
							cat:AddLine('text', L["Share"], 'func', QuestsFu.ShareQuest, 'arg1', QuestsFu, 'arg2', self.questid)
						end
						cat:AddLine('text', L["Abandon"], 'func', abandonQuestPopup, 'arg1', self.questid)
						cat:AddLine('text', L["Close"], 'func', hideQuestDetail, 'textR', 1, 'textG', 0, 'textB', 0, 'justify', 'RIGHT')

						SelectQuestLogEntry(startingQuestLogSelection)
					end
				end)
			tablet:Open('QuestsFu_Detail')
		end
		tablet:Refresh('QuestsFu_Detail')
	end
end