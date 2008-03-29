-----------------------------------------------------------------------------

local Tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_WhisperFu")
local Dewdrop = AceLibrary("Dewdrop-2.0")

WhisperFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

WhisperFu:RegisterDB("WhisperFuDB")
WhisperFu:RegisterDefaults('profile', 
	{
		PlayerLimit		= 10,
		MessageLimit	= 10,
		ShowTimes		= false,
		ShowMenuTimes	= false,
		SendColour		= { 0.5, 0.5, 1.0 },
		ReceiveColour	= { 0.0, 1.0, 0.0 },
		data			= { },
		wrapLength		= 80,
        spamMsgLog      = { },
        timeFormat		= "%H:%M:%S",
        menuTimeFormat	= "--- %H:%M:%S ---",
		ShowHint		= true,
        SpamBlock       = false,
        spamKeys        = nil,
        SpamIntKeys     = nil,
        SpamBlockTally  = 0,
        ShowSpamTallyThisSession = true,
        PlayWhisperSound = true,
        PlaySpamSound = false
	}
)

WhisperFu.version = "r"..("$Revision: 41623 $"):match("%d+")
WhisperFu.date = string.sub("$Date: 2006-09-02 10:55:39 +0930 (Sat, 02 Sep 2006) $", 8, 17)
WhisperFu.hasIcon = false
WhisperFu.defaultPosition = 'LEFT'
WhisperFu.hideWithoutStandby = true
WhisperFu.independentProfile = true
WhisperFu.maxSpamLog = 10
WhisperFu.maxSpamLogMsgsPerName = 10
WhisperFu.SpamTallyThisSession = 0
WhisperFu.SpamIntKeySeperator = "^"

-----------------------------------------------------------------------------

-- Data is stored as an array in self.db.profile.data of
-- .name
-- .messageList array of
--  { .sent, .time, .message }

-----------------------------------------------------------------------------

local dataChangedTime
local menuUpdatedTime = -1	-- Force an update the first time the menu is opened

-----------------------------------------------------------------------------

local dataTablePool = setmetatable({ }, { __mode="k" })

local function new()
	local recycledTable = next(dataTablePool)
	if recycledTable then
		dataTablePool[recycledTable] = nil
		return recycledTable
	else
		return { }
	end
end

local function del(t, recursive)
	for k,v in pairs(t) do
		if recursive and type(v) == "table" then
			del(v, true)
		end
		t[k] = nil
	end
	dataTablePool[t] = true
end

local function copyTable(source)
	local result = new()

	for k,v in pairs(source) do
		if type(v) == "table" then
			result[k] = copyTable(v)
		else
			result[k] = v
		end
	end
	
	return result
end

local function copyOptionsTemplate(source, i)
	local result = new()

	for k,v in pairs(source) do
		if k == "passValue" then
			local passValueTable = new()
			passValueTable[1] = i
			if type(v) == "table" then
				passValueTable[2] = copyTable(v)
			else
				passValueTable[2] = v
			end
			result[k] = passValueTable
		elseif type(v) == "table" then
			result[k] = copyOptionsTemplate(v, i)
		else
			result[k] = v
		end
	end
	
	return result
end

-----------------------------------------------------------------------------

local optionsTable =
{
	handler = WhisperFu,
	type = 'group',
	args = 	
	{
		spacer1 = 
		{
			type = 'header',
			order = 101,
		},

		playerlimit =
		{
			type = 'range',
			name = L["Player Limit"],
			desc = L["Maximum number of players to store messages for."],
			max = 20,
			min = 5,
			step = 1,
			order = 102,
			get = function() return WhisperFu.db.profile.PlayerLimit end,
			set = function(value) WhisperFu.db.profile.PlayerLimit = value end
		},
		
		messagelimit =
		{
			type = 'range',
			name = L["Message Limit"],
			desc = L["Maximum number of messages to store per player."],
			max = 20,
			min = 5,
			step = 1,
			order = 103,
			get = function() return WhisperFu.db.profile.MessageLimit end,
			set = function(value) WhisperFu.db.profile.MessageLimit = value end
		},
		
		wrapLength =
		{
			type = 'range',
			name = L["Wrap Length"],
			desc = L["Wrap messages longer than this number of characters."],
			max = 400,
			min = 20,
			step = 1,
			order = 104,
			get = function() return WhisperFu.db.profile.wrapLength end,
			set = function(v) WhisperFu.db.profile.wrapLength = v WhisperFu:UpdateMenu() WhisperFu:UpdateDisplay() end,
		},
				
		colours = 
		{
			type = 'group',
			name = L["Colours"],
			desc = L["Set the Text Colours"],
			order = 104,
			args = 
			{
				SendColour = 
				{
					type = "color",
					name = L["Send Colour"],
					desc = L["Sets the color of text for whispers sent"],
					get = function() return unpack(WhisperFu.db.profile.SendColour) end,
					set = function(r, g, b) WhisperFu.db.profile.SendColour = { r, g, b } WhisperFu:UpdateMenu() end,
				},
				ReceiveColour = 
				{
					type = "color",
					name = L["Receive Colour"],
					desc = L["Sets the color of text for whispers receieved"],
					get = function() return unpack(WhisperFu.db.profile.ReceiveColour) end,
					set = function(r, g, b) WhisperFu.db.profile.ReceiveColour = { r, g, b } WhisperFu:UpdateMenu() end,
				},
			},
		},
        
		showTimes = 
		{
			type = "toggle",
			order = 105,
			name = L["Show Times"],
			desc = L["Show time of whispers in tooltip."],
			get = function() return WhisperFu.db.profile.ShowTimes end,
			set = function(v) 
				WhisperFu.db.profile.ShowTimes = v
				WhisperFu:UpdateTooltip() 
			end
		},

		showMenuTimes = 
		{
			type = "toggle",
			order = 105,
			name = L["Show Menu Times"],
			desc = L["Show time of whispers in menus."],
			get = function() return WhisperFu.db.profile.ShowMenuTimes end,
			set = function(v) 
				WhisperFu.db.profile.ShowMenuTimes = v
				WhisperFu:UpdateMenu()
				if Dewdrop:IsOpen(WhisperFu:GetFrame()) then
					Dewdrop:Close()
					WhisperFu:OpenMenu()
				end
			end
		},
        
		playSoundOnIncWhisper = 
		{
			type = 'toggle',
			order = 106,
			name = L["Play Whisper Sound"],
			desc = L["Play a sound each time you receive a message."],
			get = function() return WhisperFu.db.profile.PlayWhisperSound end,
			set = function(v) WhisperFu.db.profile.PlayWhisperSound = v end
		},
		
		showHint =
		{
			type = "toggle",
			order = 107,
			name = L["Show Hint"],
			desc = L["Show hint at the bottom of the tooltip."],
			get = function() return WhisperFu.db.profile.ShowHint end,
			set = function(v) WhisperFu.db.profile.ShowHint = v WhisperFu:UpdateTooltip() end
		},
		
		spacer2 = 
		{
			type = 'header',
			order = 108,
		},
        
		spamblockedmsgsgroup = 
		{
			type = 'group',
			name = L["Spam"],
			desc = L["View blocked spam messages."],
			order = 109,
			disabled = function() return not next(WhisperFu.OnMenuRequest.args.spamblockedmsgsgroup.args) end,
			args = {}
		},

		spamoptions =
		{
			type = 'group',
			name = L["Spam Options"],
			desc = L["Spam blocking options."],
			order = 110,
			args = 
			{
				spamblocking = 
				{
					type = 'toggle',
					order = 201,
					name = L["Block Spam"],
					desc = L["Block incoming spam messages."],
					get = function() return WhisperFu.db.profile.SpamBlock end,
					set = function(v) WhisperFu.db.profile.SpamBlock = v end
				},
				spamPlaySpamSound = 
				{
					type = 'toggle',
					order = 202,
					name = L["Play Spam Sound"],
					desc = L["Play a sound each time WhisperFu catches a spam message."],
					get = function() return WhisperFu.db.profile.PlaySpamSound end,
					set = function(v) WhisperFu.db.profile.PlaySpamSound = v end
				},
				spamTallyThisSessionToggle = 
				{
					type = 'toggle',
					order = 203,
					name = L["Show Spams This Session"],
					desc = L["Shows a counter in the addon title for spams blocked this session."],
					get = function() return WhisperFu.db.profile.ShowSpamTallyThisSession end,
					set = function(v) WhisperFu.db.profile.ShowSpamTallyThisSession = v WhisperFu:UpdateTooltip() WhisperFu:UpdateMenu() end
				},
				spamtotalsreset = 
				{
					type = 'execute',
					order = 204,
					name = L["Reset Spam Tally"],
					desc = "Resets intercepted spam tally to 0.", -- Should be overwritten when menu is updated
					func = function() 
						WhisperFu.db.profile.SpamBlockTally = 0
						WhisperFu.SpamTallyThisSession = 0
						WhisperFu:UpdateMenu()
						if Dewdrop:IsOpen(WhisperFu:GetFrame()) then
							Dewdrop:Close()
							WhisperFu:OpenMenu()
						end
					end
				},
				spamDeleteLog = 
				{
					type = 'execute',
					order = 205,
					name = L["Delete Spam Log"],
					desc = L["Deletes all of your spam messages"],
					func = function() WhisperFu:PurgeSpamLog() end
				},
				spamKeywordOptions =
				{
					type = 'group',
					name = L["Keyword Options"],
					desc = L["Keyword Options"],
					order = 206,
					args = 
					{
						spamaddkeyword = 
						{
							type = 'execute',
							order = 301,
							name = L["Add Keyword"],
							desc = L["Add a new keyword to ignore."],
							func = function() StaticPopup_Show ("WHISPERFU_ADDSPAMIGNORE_DIALOG") end
						},
						spamreloadkeyworddefaults = 
						{
							type = 'execute',
							order = 302,
							name = L["Reinstate Keyword Defaults"],
							desc = L["This will reinstate the default keywords while keeping any you've added intact."],
							func = function() WhisperFu:ReinstateSpamKeysDefaults() end
						},
						spamkeysgroup = 
						{
							type = 'group',
							name = L["Remove Keyword(s)"],
							desc = "Click a keyword to remove it from the spam list.", -- format(L["Click a keyword to remove it from the spam list.\nCurrent keyword total: %s"],table.getn(WhisperFu.db.profile.spamKeys)),
							order = 303,
							args = {}
						},
						spamkeysdeleteall = 
						{
							type = 'execute',
							order = 304,
							name = L["Delete All Spam Keys"],
							desc = L["|cffff3333!This will purge all spam keys!|r\nYou should not do this unless you are planning on reinstating keyword defaults afterwards."],
							func = function() StaticPopup_Show("WHISPERFU_PURGE_ALLKEYWORDS") end
						},
                        
						spacer = 
						{
							type = 'header',
							order = 305,
						},
                
						spamaddintkeyword = 
						{
							type = 'execute',
							order = 306,
							name = L["Add Keyword Group"],
							desc = L["Add a new keyword group to ignore.\nEx: To ignore any messages with the words: \"join\" and \"guild\" you would enter: \"join^guild^\""],
							func = function() StaticPopup_Show ("WHISPERFU_ADDSPAMINTIGNORE_DIALOG") end
						},
						spamreloadintkeyworddefaults = 
						{
							type = 'execute',
							order = 307,
							name = L["Reinstate Keyword Group Defaults"],
							desc = L["This will reinstate the default keyword groups while keeping any you've added intact."],
							func = function() WhisperFu:ReinstateSpamIntKeysDefaults() end
						},
						spamintkeysgroup = 
						{
							type = 'group',
							name = L["Remove Keyword Group"],
							desc = "Click a keyword group to remove it from the spam list.", -- format(L["Click a keyword group to remove it from the spam list.\nCurrent keyword group total: %s"],table.getn(WhisperFu.db.profile.SpamIntKeys)),
							order = 308,
							args = {}
						},
						spamintkeysdeleteall = 
						{
							type = 'execute',
							order = 309,
							name = L["Delete All Spam Key Groups"],
							desc = L["|cffff3333!This will purge all spam key groups!|r\nYou should not do this unless you are planning on reinstating keyword group defaults afterwards."],
							func = function() StaticPopup_Show("WHISPERFU_PURGE_ALLKEYWORDGROUPS") end
						},
					}
				},
			},
		},
        
		spacer3 = 
		{
			type = 'header',
			order = 111,
		},
        
		purge =	
		{
			type = 'execute',
			name = L["Purge"],
			desc = L["PurgeDesc"],
			order = 112,
			func = function() WhisperFu:PurgeWhispers() end
		},
		
	},
}

-----------------------------------------------------------------------------

function WhisperFu:OnInitialize()
    if not self.db.profile.spamKeys then
        self.db.profile.spamKeys = self.spamKeysDefaults
    end
    if not self.db.profile.SpamIntKeys then
        self.db.profile.SpamIntKeys = self.SpamIntKeysDefaults
	end
end

function WhisperFu:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER", "OnReceiveWhisper")
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM", "OnSendWhisper")
	self:UpdateMenu()
end

function WhisperFu:OnDisable()
end

--chat frame whisper suppression
local ORIG_ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler
function ChatFrame_MessageEventHandler(event)
    if event == "CHAT_MSG_WHISPER" and WhisperFu.db.profile.SpamBlock then
        --make sure you aren't ignoring a GM and check if the whisper should be ignored
        if WhisperFu:ParseWhisper(arg1, arg2, arg3, arg6) and arg6~="GM" then
            -- ignore it
        else
            ORIG_ChatFrame_MessageEventHandler(event)
        end
    else
        ORIG_ChatFrame_MessageEventHandler(event)
    end
end

function WhisperFu:GetHexColor(name)
	return string.format("|cff%02x%02x%02x", self.db.profile[name][1] * 255, self.db.profile[name][2] * 255, self.db.profile[name][3] * 255)
end

function WhisperFu:FormatMessage(message, wasSender)
	if wasSender then
		return self:GetHexColor("SendColour")..message
	else
		return self:GetHexColor("ReceiveColour")..message
	end
end

function WhisperFu:CreateMessageEntry(wasSender)
	local data = new()
	data.sent = wasSender
	data.time = time()
	data.message = arg1
	return data
end

function WhisperFu:ParseWhisper(msg, sender,language, status)
	for k,v in pairs(self.db.profile.spamKeys) do
		if string.find(string.upper(msg),string.upper(v)) then
			return true
		end
	end

    for k,v in pairs(self.db.profile.SpamIntKeys) do
        local allKeysMatch = false
        for k2,v2 in pairs(v) do
            if (string.find(string.upper(msg),string.upper(v2))) then
                allKeysMatch = true
            else
                allKeysMatch = false
                break
            end
        end
        if allKeysMatch then
			return true
        end
    end
    
    return false
end

function WhisperFu:ProcessWhisper(wasSender)
    -- Check that the whisper is from a new person.
    local profile = self.db.profile
	
	for i = 1, profile.PlayerLimit do
		if(not profile.data[i]) then
			break
		end
		if(arg2 == profile.data[i].name) then
			table.insert(profile.data[i].messageList, 1, self:CreateMessageEntry(wasSender))

			for j = profile.MessageLimit+1, #profile.data[i].messageList do
				profile.data[i].messageList[j] = del(profile.data[i].messageList[j], true)
			end

			-- Move to top of list
			local data = table.remove(profile.data, i)
			table.insert(profile.data, 1, data)
			
			self:UpdateMenu()
			return
		end	
	end

	-- Move the list down and add new whisperer to the top
	local newData = new()
	newData.name = arg2
	newData.messageList = new()
	newData.messageList[1] = self:CreateMessageEntry(wasSender)
	table.insert(profile.data, 1, newData)

	for i = profile.PlayerLimit+1, #profile.data do
		profile.data[i] = del(profile.data[i], true)
	end

	self:UpdateMenu()
end

function WhisperFu:OnReceiveWhisper()
    if string.find(arg1, "[[]ItemDB-answer]") or string.find(arg1, "[[]ItemDB-request]") then
        return
	else
		-- Check if we're ignoring the whisper
		if self.db.profile.SpamBlock then
			--check that you aren't talking to a GM and that a keyword has been found
			if WhisperFu:ParseWhisper(arg1, arg2, arg3, arg6) and arg6~="GM" then
				self.db.profile.SpamBlockTally = self.db.profile.SpamBlockTally+1
				WhisperFu.SpamTallyThisSession = WhisperFu.SpamTallyThisSession+1
				local foundSpammer = 0
				for k,v in pairs(self.db.profile.spamMsgLog) do
					if (v.name==arg2) then
						foundSpammer = k
						break
					end
				end
				
				local newMessage = new()
				newMessage.message = arg1
				newMessage.time = time()
				newMessage.id = arg11
				
				if (foundSpammer > 0) then
					local spammerData = self.db.profile.spamMsgLog[foundSpammer]
					
					table.insert(spammerData.messageList, 1, newMessage)
					
					for i=self.maxSpamLogMsgsPerName+1, #spammerData.messageList do
						spammerData.messageList[i] = del(spammerData.messageList)
					end
				else
					local spammerData = new()
					spammerData.name = arg2
					spammerData.messageList = new()
					spammerData.messageList[1] = newMessage
				
					table.insert(self.db.profile.spamMsgLog, 1, spammerData)

					for i=self.maxSpamLog+1, #self.db.profile.spamMsgLog do
						self.db.profile.spamMsgLog = del(self.db.profile.spamMsgLog, true)
					end
				end
                if self.db.profile.PlaySpamSound then
                    PlaySoundFile("Interface\\AddOns\\FuBar_WhisperFu\\Sounds\\SpamCaught.mp3")
                end
				self:UpdateTooltip()
				self:UpdateMenu()
				return
			end
		end
        if self.db.profile.PlayWhisperSound then
            PlaySoundFile("Interface\\AddOns\\FuBar_WhisperFu\\Sounds\\WhisperInbound.mp3")
        end
        self:ProcessWhisper(false)
    end
end

function WhisperFu:OnSendWhisper()
    if string.find(arg1, "[[]ItemDB-answer]") or string.find(arg1, "[[]ItemDB-request]") then
		return
	else
        self:ProcessWhisper(true)
    end
end

-----------------------------------------------------------------------------

function WhisperFu:OnTextUpdate()
	if self.db.profile.data[1] then
        if self.db.profile.ShowSpamTallyThisSession then
            self:SetText( self:FormatMessage( self.db.profile.data[1].name, self.db.profile.data[1].messageList[1].sent ).." : "..WhisperFu.SpamTallyThisSession)
        else
            self:SetText( self:FormatMessage( self.db.profile.data[1].name, self.db.profile.data[1].messageList[1].sent ) )
        end
	else
		self:SetText("WhisperFu")
	end
end

local function CreateMessageList(message)
	local wrapLength = WhisperFu.db.profile.wrapLength

	local messageList = new()
	
	if #message <= wrapLength then
		messageList[1] = message
		return messageList
	end

	local startIndex = 1
	while startIndex <= #message do
		local endIndex = startIndex + wrapLength
		if endIndex > #message then
			messageList[#messageList+1] = message:sub(startIndex)
			break
		end
		while message:byte(endIndex) ~= 32 do
			endIndex = endIndex - 1
			if endIndex == startIndex then
				endIndex = startIndex + wrapLength
				break
			end
		end
		messageList[#messageList+1] = message:sub(startIndex, endIndex)
		startIndex = endIndex+1
	end

	return messageList
end

function WhisperFu:OnTooltipUpdate()
    local cat
    local profile = self.db.profile
    
	if profile.data[1] then
		local data = profile.data[1]
	
		if profile.ShowTimes then
			cat = Tablet:AddCategory('text', data.name,
									 'columns', 2)

		else
			cat = Tablet:AddCategory('text', data.name,
									 'columns', 1)
		end
        
        for i=#data.messageList,1,-1 do
			local messageEntry = data.messageList[i] 
		
			local colour
			if messageEntry.sent then 
				colour = profile.SendColour 
			else
				colour = profile.ReceiveColour
			end
			
			local messageList = CreateMessageList(messageEntry.message)
			
			for i=1,#messageList do
				cat:AddLine('text', messageList[i],
							'textR', colour[1],
							'textG', colour[2],
							'textB', colour[3],
							i == 1 and 'text2' or nil, i == 1 and self:FormatMessage(date(profile.timeFormat, tonumber(messageEntry.time)), messageEntry.sent) or nil)
			end
			
			del(messageList)
		end
	end
    cat = Tablet:AddCategory("text", L["Spam"]..":",
							 "columns", 2,
							 "child_textR", 0,
							 "child_textG", 1,
							 "child_textB", 0,
							 "child_text2R", r,
							 "child_text2G", g,
							 "child_text2B", b
							)

    cat:AddLine("text", L["Spam Blocker:"], "text2", self.db.profile.SpamBlock and L["On"] or L["Off"])
    cat:AddLine("text", L["Blocked Messages:"], "text2", self.db.profile.SpamBlockTally)
    
	if self.db.profile.ShowHint then
		Tablet:SetHint(L["HintText"])
	end
end

local function StartWhisper(player)
	SetItemRef("player:"..player, "|Hplayer:"..player.."|h["..player.."|h", "LeftButton")
end

function WhisperFu:OnClick()
	if self.db.profile.data[1] then
		local playerName = self.db.profile.data[1].name
		if IsAltKeyDown() then
            InviteUnit(playerName)
		elseif IsShiftKeyDown() then
			SendWho("n-"..playerName)
		elseif IsControlKeyDown() then
        	self:PurgeWhispers()
		else
			StartWhisper(playerName)
		end
	end
end

function WhisperFu:PlayerMenu(playerIndex)
	local playerData = self.db.profile.data[playerIndex]

	local playerMenu = new()
	 
	playerMenu.type = 'group'
	playerMenu.name = self:FormatMessage(playerData.name, playerData.messageList[1].sent)
	playerMenu.desc = string.format(L["PlayerDesc"], playerData.name)
	playerMenu.order = playerIndex
	
	local args = new()
	playerMenu.args = args	
	
	local whisper = new()
	args.whisper = whisper
	whisper.type = 'execute'
	whisper.name = L["Whisper"]
	whisper.desc = string.format(L["WhisperDesc"], playerData.name)
	whisper.order = 1
	whisper.func = StartWhisper
	whisper.passValue = playerData.name
	
	local spacer = new()
	args.spacer = spacer
	spacer.type = 'header'
	spacer.order = 2

	for i=1,self.db.profile.MessageLimit do
		if not playerData.messageList[i] then break end
		
		local messageList = CreateMessageList(playerData.messageList[i].message)
		
		if self.db.profile.ShowMenuTimes then
			local timeData = new()
			args["time"..i] = timeData
			timeData.type = 'header'
			timeData.name = self:FormatMessage(date(self.db.profile.menuTimeFormat, tonumber(playerData.messageList[i].time)), playerData.messageList[i].sent)
			timeData.order = 9999-(i*2)
		end

		for j=1,#messageList do
			local messageData = new()
			args[("message:%0d%02d"):format(i, j)] = messageData
			
			messageData.type = 'header'
			messageData.name = self:FormatMessage(messageList[j], playerData.messageList[i].sent)
			messageData.order = 10000-i*2+j/100
		end
		
		del(messageList)		
	end
	
	return playerMenu
end

function WhisperFu:SpamKeyAddition(newKey)
    if (newKey=="") then
        self:Print(L["Please enter a valid keyword"])
    else
        --check if it exists already
        for k,v in pairs(self.db.profile.spamKeys) do
            if (string.upper(v)==string.upper(newKey)) then
                self:Print(newKey..L[" already exists."])
                return
            end
        end
        table.insert(self.db.profile.spamKeys, newKey)
        self:UpdateMenu()
        if Dewdrop:IsOpen(self:GetFrame()) then
            Dewdrop:Close()
            self:OpenMenu()
        end
    end
end

function WhisperFu:SpamKeyRemover(keyToRemove)
    for k,v in pairs(self.db.profile.spamKeys) do
        if (v==self.db.profile.spamKeys[keyToRemove]) then
            --found key to remove, removing
            table.remove(self.db.profile.spamKeys,k)
            break
        end
    end
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
		Dewdrop:Close()
		self:OpenMenu()
	end
end

function WhisperFu:SpamIntKeyRemover(keyGroupToRemove)
    for k,v in pairs(self.db.profile.SpamIntKeys) do
        if (v==self.db.profile.SpamIntKeys[keyGroupToRemove]) then
            table.remove(self.db.profile.SpamIntKeys,k)
            break
        end
    end
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
		Dewdrop:Close()
		self:OpenMenu()
	end
end

function WhisperFu:SpamIntKeyAddition(newKey)
    --make sure the user entered something
    if (newKey == "") then
        self:Print(L["Please enter a valid keyword"])
    else
        --break up entry into separate strings with WhisperFu.SpamIntKeySeperator as a seperator
        --awesome!  http://lua-users.org/wiki/StringRecipes
        local fields = {}
        newKey:gsub("([^"..self.SpamIntKeySeperator.."]*)"..self.SpamIntKeySeperator, function(c) table.insert(fields, string.lower(c)) end)
        for k,v in pairs(self.db.profile.SpamIntKeys) do
            if table.getn(v) == table.getn(fields) then
                local completeMatch = false
                for k2,v2 in pairs(v) do
                    local foundSubmatch = false
                    for k3,v3 in pairs(fields) do
                        if (v3==v2) then
                            foundSubmatch = true
                        end
                    end
                    if not foundSubmatch then
                        completeMatch = false
                        break
                    else
                        completeMatch = true
                    end
                end
                if completeMatch then
                    self:Print(L["That intelligent key group already exists"])
                    return
                end
            end
        end
        table.insert(self.db.profile.SpamIntKeys,fields)
        self:UpdateMenu()
        if Dewdrop:IsOpen(self:GetFrame()) then
            Dewdrop:Close()
            self:OpenMenu()
        end
    end
end

function WhisperFu:PopupReportUser(userToReport)
    local dialog = StaticPopup_Show("WHISPERFU_REPORTUSER_YESNO", userToReport)
    if(dialog) then
        dialog.data = userToReport
    end
end

function WhisperFu:ReportUser(userToReport)
    if PETITION_QUEUE_ACTIVE == nil then
        self:Print(HELP_TICKET_QUEUE_DISABLED)
        return
    end
    if (not HelpFrameOpenTicket.hasTicket) then
        local foundUserToReport = 0
        local oldMessageFound = false
        for k,v in pairs(self.db.profile.spamMsgLog) do
            if (v.name == userToReport) then
                if v["messageList"][1].id then
                    foundUserToReport = k
                    break
                else
                    oldMessageFound = true
                    break
                end
            end
        end
        if (oldMessageFound) then
            self:Print(L["Found an old spam message, spam log is being reset to update to new system."])
            self:PurgeSpamLog()
        elseif (foundUserToReport > 0) then
            self:Print(L["Generating GM ticket for: "]..userToReport)
            --self:Print(self.db.profile.spamMsgLog[foundUserToReport]["messageList"][1].id)
            ComplainChat(self.db.profile.spamMsgLog[foundUserToReport]["messageList"][1].id)
            --NewGMTicket(2, format(L["I am reporting the user %s for attempting to sell me gold or leveling service for real money.  The following are messages captured, quoting the user's violation of WoW TOS:\n\n"],userToReport)..reportMsgHolder)
        else
            self:Print(userToReport..L[" was not found."])
        end
    else
        self:Print(L["You already have a GM ticket open."])
    end
end

local function popupReportUser(name) WhisperFu:PopupReportUser(name) end
function WhisperFu:GenerateSpammerLog()
    local spammerData = self.db.profile["spamMsgLog"]
    local spammerMenu = new()
    for i=1,table.getn(spammerData) do
		local data = new()
		spammerMenu[i] = data
		
		data.type = 'group'
		data.name = self:FormatMessage(spammerData[i].name, true)
		data.desc = spammerData[i].name
		data.order = i
		
		local args = new()
		data.args = args
		
		local report = new()
		args.report = report
		
		report.type = 'execute'
		report.name = L["-Report this user-"]
		report.desc = L["Report this user as a spammer and attempt to get justice for their griefing!"]
		report.order = 1
		report.func = popupReportUser
		report.passValue = spammerData[i].name

		local spacer = new()
		args.spacer = spacer
				
		spacer.type = 'header'
		spacer.order = 2
    end
    for i=1,table.getn(spammerData) do
        for j=1,table.getn(spammerData[i].messageList) do
            if self.db.profile.ShowMenuTimes then
				local timeData = new()
				spammerMenu[i]["args"]["time"..j] = timeData

				timeData.type = 'header'
				timeData.name = self:FormatMessage(date(self.db.profile.menuTimeFormat, tonumber(spammerData[i]["messageList"][j].time)), true)
				timeData.order = 9999-(j*2)
            end
            
			local messageData = new()
			spammerMenu[i]["args"]["message"..j] = messageData
			
			messageData.type = 'header'
			messageData.name = self:FormatMessage(spammerData[i]["messageList"][j].message, true)
			messageData.order = 10000-j*2
        end
	end
    return spammerMenu
end

local function spamKeyRemover(i) WhisperFu:SpamKeyRemover(i) end
function WhisperFu:GenerateSpamKeyTable()
    local spamKeyTable = new()
    for i=1,table.getn(self.db.profile.spamKeys) do
		local data = new()
		spamKeyTable[i] = data
		
		data.type = 'execute'
		data.name = self.db.profile.spamKeys[i]
		data.desc = L["Remove keyword: "]..self.db.profile.spamKeys[i]
		data.func = spamKeyRemover
		data.passValue = i
    end
    return spamKeyTable
end

local function spamIntKeyRemover(i) WhisperFu:SpamIntKeyRemover(i) end
function WhisperFu:GenerateSpamIntKeyTable()
    local spamKeyTable = new()
    for i=1,table.getn(self.db.profile.SpamIntKeys) do
        local tableToString = ""
        for k,v in pairs(self.db.profile.SpamIntKeys[i]) do
            if (k==table.getn(self.db.profile.SpamIntKeys[i])) then
                tableToString = tableToString.."\""..v.."\""
            else
                tableToString = tableToString.."\""..v.."\", "
            end
        end
        local data = new()
        spamKeyTable[i] = data
        
		data.type = 'execute'
		data.name = tableToString
		data.desc = L["Remove keyword group: "]..tableToString
		data.func = spamIntKeyRemover
		data.passValue = i
    end
    return spamKeyTable
end

function WhisperFu:ReinstateSpamKeysDefaults()
    local tempKeyTable = self.db.profile.spamKeys
    for k,v in pairs(self.spamKeysDefaults) do
        local foundMatch = false
        for k2,v2 in pairs(self.db.profile.spamKeys) do
            if (string.upper(v)==string.upper(v2)) then
                foundMatch = true
                break
            end
        end
        if (foundMatch == false) then
            table.insert(tempKeyTable,v)
        end
    end
    self.db.profile.spamKeys = tempKeyTable
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
        Dewdrop:Close()
        self:OpenMenu()
    end
end

function WhisperFu:CheckForInnerMatch(tableToCheck)
    local foundMatch = false
    for i=1, table.getn(self.db.profile.SpamIntKeys) do
        for k,v in pairs(self.db.profile.SpamIntKeys[i]) do
            if (table.getn(tableToCheck)==table.getn(self.db.profile.SpamIntKeys[i])) then
                for k2,v2 in pairs(tableToCheck) do
                    if (v2 == v) then
                        foundMatch = true
                        break
                    else
                        foundMatch = false
                    end
                end
                if not foundMatch then
                    break
                end
            end
        end
        if foundMatch then
            return foundMatch
        end
    end
    return foundMatch
end

function WhisperFu:ReinstateSpamIntKeysDefaults()
    local tempKeyTable = self.db.profile.SpamIntKeys
    for i=1, table.getn(self.SpamIntKeysDefaults) do
        if not self:CheckForInnerMatch(self.SpamIntKeysDefaults[i]) then
            table.insert(tempKeyTable, self.SpamIntKeysDefaults[i])
        end
    end
    self.db.profile.SpamIntKeys = tempKeyTable
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
        Dewdrop:Close()
        self:OpenMenu()
    end
end

function WhisperFu:UpdateMenuOptionsTable()
	for k in pairs(optionsTable.args) do
		if string.find(k, "player%d+") then
			optionsTable.args[k] = del(optionsTable.args[k], true)
		end
	end

	for i=1,self.db.profile.PlayerLimit do
		if not self.db.profile.data[i] then break end
		optionsTable.args["player"..i] = self:PlayerMenu(i)
	end

	local spamArgs = optionsTable.args.spamoptions.args
	spamArgs.spamtotalsreset.desc = format(L["Resets intercepted spam tally to 0.\nCurrent tally is %d."], self.db.profile.SpamBlockTally)
	
	spamArgs.spamKeywordOptions.args.spamkeysgroup.desc = format(L["Click a keyword to remove it from the spam list.\nCurrent keyword total: %s"],table.getn(WhisperFu.db.profile.spamKeys))
	del(spamArgs.spamKeywordOptions.args.spamkeysgroup.args, true)
	spamArgs.spamKeywordOptions.args.spamkeysgroup.args = self:GenerateSpamKeyTable()

	spamArgs.spamKeywordOptions.args.spamintkeysgroup.desc = format(L["Click a keyword group to remove it from the spam list.\nCurrent keyword group total: %s"],table.getn(WhisperFu.db.profile.SpamIntKeys))
	del(spamArgs.spamKeywordOptions.args.spamintkeysgroup.args, true)
	spamArgs.spamKeywordOptions.args.spamintkeysgroup.args = self:GenerateSpamIntKeyTable()

	del(optionsTable.args.spamblockedmsgsgroup.args, true)
	optionsTable.args.spamblockedmsgsgroup.args = self:GenerateSpammerLog()
end

function WhisperFu:UpdateMenu()
	dataChangedTime = GetTime()
    
	-- Force a menu update.. is there a better way?
	Dewdrop:Unregister(self:GetFrame())
	
	-- UpdateMenu also indicates a need to update tooltip/display
	self:UpdateDisplay()
	
end

function WhisperFu:PurgeWhispers()
	del(self.db.profile.data, true)
	self.db.profile.data = new()
	self:UpdateMenu()
	
	-- This code could be part of the usual UpdateMenu(), but this introduces 'instability' when trying to
	-- view the menus during incoming whispers
	if Dewdrop:IsOpen(self:GetFrame()) then
		Dewdrop:Close()
		self:OpenMenu()
	end
end

function WhisperFu:PurgeSpamLog()
	del(self.db.profile.spamMsgLog, true)
	self.db.profile.spamMsgLog = new()
	self:UpdateMenu()
	if Dewdrop:IsOpen(self:GetFrame()) then
		Dewdrop:Close()
		self:OpenMenu()
	end
	self:Print(L["Spam Log has been cleared."])
end

function WhisperFu:PurgeAllKeywordGroups()
	del(self.db.profile.SpamIntKeys, true)
    self.db.profile.SpamIntKeys = new()
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
        Dewdrop:Close()
        self:OpenMenu()
    end
end

function WhisperFu:PurgeAllKeywords()
	del(self.db.profile.spamKeys, true)
    self.db.profile.spamKeys = new()
    self:UpdateMenu()
    if Dewdrop:IsOpen(self:GetFrame()) then
        Dewdrop:Close()
        self:OpenMenu()
    end
end

function WhisperFu:OnProfileEnable()
	self:UpdateMenu()
	
	-- This code could be part of the usual UpdateMenu(), but this introduces 'instability' when trying to
	-- view the menus during incoming whispers
	if Dewdrop:IsOpen(self:GetFrame()) then
		Dewdrop:Close()
		self:OpenMenu()
	end
end

StaticPopupDialogs["WHISPERFU_ADDSPAMIGNORE_DIALOG"] = {
    text = L["Enter a keyword to ignore"],
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 255,
    OnAccept = function()
        local editBox = getglobal(this:GetParent():GetName().."EditBox")
        WhisperFu:SpamKeyAddition(editBox:GetText())
    end,
    OnShow = function()
        getglobal(this:GetName().."EditBox"):SetText(L["New Keyword"])
        getglobal(this:GetName().."EditBox"):HighlightText()
        getglobal(this:GetName().."EditBox"):SetFocus()
    end,
    OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
    EditBoxOnEnterPressed = function()
        local editBox = getglobal(this:GetParent():GetName().."EditBox")
        WhisperFu:SpamKeyAddition(editBox:GetText())
        this:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function()
		this:GetParent():Hide()
	end,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1
}

StaticPopupDialogs["WHISPERFU_ADDSPAMINTIGNORE_DIALOG"] = {
    text = L["Enter a keyword group to ignore"],
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 255,
    OnAccept = function()
        local editBox = getglobal(this:GetParent():GetName().."EditBox")
        WhisperFu:SpamIntKeyAddition(editBox:GetText())
    end,
    OnShow = function()
        getglobal(this:GetName().."EditBox"):SetText(L["word1^word2^etc^"])
        getglobal(this:GetName().."EditBox"):HighlightText()
        getglobal(this:GetName().."EditBox"):SetFocus()
    end,
    OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
    EditBoxOnEnterPressed = function()
        local editBox = getglobal(this:GetParent():GetName().."EditBox")
        WhisperFu:SpamIntKeyAddition(editBox:GetText())
        this:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function()
		this:GetParent():Hide()
	end,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1
}

StaticPopupDialogs["WHISPERFU_REPORTUSER_YESNO"] = {
    text = L["Are you sure you want to report %s?"],
    button1 = ACCEPT,
    button2 = CANCEL,
    --hasEditBox = 1,
    --maxLetters = 25,
    OnAccept = function(data)
        --local userToReport = unpack(data)
        local userToReport = data
        WhisperFu:ReportUser(userToReport)
    end,
    timeout = 0,
    exclusive = 0,
    whileDead = 1,
    hideOnEscape = 1
}

StaticPopupDialogs["WHISPERFU_PURGE_ALLKEYWORDS"] = {
    text = L["Are you sure you want to purge all of your keywords?"],
    button1 = ACCEPT,
    button2 = CANCEL,
    --hasEditBox = 1,
    --maxLetters = 25,
    OnAccept = function()
        WhisperFu:PurgeAllKeywords()
    end,
    timeout = 0,
    exclusive = 0,
    whileDead = 1,
    hideOnEscape = 1
}

StaticPopupDialogs["WHISPERFU_PURGE_ALLKEYWORDGROUPS"] = {
    text = L["Are you sure you want to purge all of your keyword groups?"],
    button1 = ACCEPT,
    button2 = CANCEL,
    --hasEditBox = 1,
    --maxLetters = 25,
    OnAccept = function()
        WhisperFu:PurgeAllKeywordGroups()
    end,
    timeout = 0,
    exclusive = 0,
    whileDead = 1,
    hideOnEscape = 1
}

-----------------------------------------------------------------------------

-- Metatable for args
local menuMetaTable =
{
	__index = function(self, key)
		if key == "args" then
			if menuUpdatedTime ~= dataChangedTime then
				menuUpdatedTime = dataChangedTime
				WhisperFu:UpdateMenuOptionsTable()
			end
		end
		return rawget(optionsTable, key)
	end
}

WhisperFu.OnMenuRequest = setmetatable({}, menuMetaTable)

-----------------------------------------------------------------------------
