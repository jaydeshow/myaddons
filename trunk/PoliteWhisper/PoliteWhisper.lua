
-----------------------------------------------------------------------------
--                                                                         --
-- PoliteWhisper.lua - Main code for Polite Whisper (Extended) WoW add-on. --
--                                                                         --
-----------------------------------------------------------------------------

-- Version info:
-- $Author: shen $
-- $Date: 2008-01-30 10:57:52 -0500 (Wed, 30 Jan 2008) $
-- $Revision: 59743 $
-- $HeadURL: svn://dev.wowace.com/wowace/trunk/PoliteWhisper/PoliteWhisper.lua $

-- Based on work by gre7g

-- Special thanks to the users of worldofwar.net for their helpful advice.
-- Especially, WoohaDude and steamuk for helping me through stuff that I didn't
-- figure out myself.  To sordid, Highend, and Dreyle for the German
-- translations.  And to TheWrox and Kubik for the French translations.

-- Constants:
PoliteWhisper_WhoDelay            = 5;   -- don't /who more than once every 5s
PoliteWhisper_WhoTimeout          = 10;  -- expect /who to respond within 10s
PoliteWhisper_AFKPesterTimeout    = 300; -- OK to ask AFK's again in 5m
PoliteWhisper_NoRespPesterTimeout = 600; -- OK to ask no responders again in 10
PoliteWhisper_ResetAllTimeout     = 3600; -- 1hr to reset all
PoliteWhisper_MaxListEntries      = 12;  -- 12 items on scroll list maximum
PoliteWhisper_MinListEntries      = 8;   -- 8 items on scroll list minimum
PoliteWhisper_IgnoreListEntries   = 15;  -- 18 items on ignore scroll list
PoliteWhisper_History             = 4;   -- Keep the last 4 messages from users
PoliteWhisper_MaxSliderHeight     = 300; -- Tall slider.
PoliteWhisper_MinSliderHeight     = 200; -- Short slider.
PoliteWhisper_ScrollList          = {};  -- Table of scrolling items
PoliteWhisper_ChatList            = {};  -- Table of scrolling chat text
PoliteWhisper_ClassEnables        = nil; -- Table of CheckButton's
PoliteWhisper_Zones               = {};  -- Non-dungeon/BG zones
PoliteWhisper_ClassDrops          = nil; -- Specialization drop down frames
PoliteWhisper_WrapLen             = 55;  -- Wrap long lines of text
PoliteWhisper_PartyCtrls          = {};  -- Controls on the party panel
PoliteWhisper_MsgHack             = message; -- Because some mods mess this up

-- Globals:
PoliteWhisper_SearchInProg = false; -- Class being searched on
PoliteWhisper_TaskQueue    = {};    -- Table of queued tasks
PoliteWhisper_Users        = {};    -- Table of users we've found/asked
PoliteWhisper_ChatUser     = nil;   -- Current user in chat frame
PoliteWhisper_ListEntries  = 12;    -- 12 items on scroll list
PoliteWhisper_DoNotInvite  = {};    -- Persistent list
PoliteWhisper_Friends      = {};    -- Persistent list
PoliteWhisper_Options      = nil;   -- Persistent options
PoliteWhisper_Loading      = true;  -- Used to prevent glitching of options
PoliteWhisper_Visible      = false; -- Window hidden to start
PoliteWhisper_RestartCP    = false; -- CensusPlus disabled
PoliteWhisper_SavedQuest   = nil;   -- User entered question

-- Reset everything once an hour (ResetAllTimeout value)
function PoliteWhisper_ResetAll()
		PoliteWhisper_SearchInProg = false;
		PoliteWhisper_TaskQueue    = {};
		PoliteWhisper_Users        = {};
		PoliteWhisper_HideChat(true);
end

function PoliteWhisper_UpdateHeroicCheckbox()
	if (UnitLevel("player") < 70) then
		PoliteWhisper_HeroicEnable:Disable();
		PoliteWhisper_HeroicEnable:Hide();
		PoliteWhisper_FinderHC:Hide();
	end;
end

function PoliteWhisper_UpdateLevels()
				-- Set Min to be 4 levels below player
				L = UnitLevel("player");
				X = L - 4;
				if (X < 1) then X = 1; end
				if (PoliteWhisper_HeroicEnable:GetChecked()) then X = 70; end
				PoliteWhisper_MinLevel:SetText(X);

				-- Set Max to be 4 levels above player
				X = L + 4;
				if (X > 70) then X = 70; end
				if (PoliteWhisper_HeroicEnable:GetChecked()) then X = 70; end
				PoliteWhisper_MaxLevel:SetText(X);
end

-- PoliteWhisper_Invoke is called when the user types "/pw"
function PoliteWhisper_Invoke()
		local L, X, Class, Enable, i, Task, Reset;

		-- Update the ignore list
		PoliteWhisper_UpdateIgnore();

		-- Have we run before?
		if (PoliteWhisper_MinLevel:GetText() == "")
		then
				PoliteWhisper_UpdateLevels();
				-- Set the defaults:
				-- Enable each class unless there is one present already in the party.
				-- I actually do this by enabling each class checkbox...
				for Class, Enable in pairs(PoliteWhisper_ClassEnables)
				do
						Enable:SetChecked(true);
				end
				-- ... then unchecking our class...
				PoliteWhisper_ClassEnables[UnitClass("player")]:SetChecked(false);
				-- ... then unchecking our group...
				for i = 1, GetNumPartyMembers()
				do
						PoliteWhisper_ClassEnables[UnitClass("party" ..
								i)]:SetChecked(false);
				end

				-- Perform searches no more than once per hour
				Task =
				{
						Expire = GetTime() + PoliteWhisper_ResetAllTimeout,
						Func   = PoliteWhisper_ResetAll
				};
				table.insert(PoliteWhisper_TaskQueue, Task);

				-- Create drop down menus
				UIDropDownMenu_Initialize(PoliteWhisper_DungeonDrop,
						PoliteWhisper_DungeonInit);
				UIDropDownMenu_SetWidth(255, PoliteWhisper_DungeonDrop);
				UIDropDownMenu_Initialize(PoliteWhisper_OtherDrop,
						PoliteWhisper_OtherInit);
				UIDropDownMenu_SetWidth(140, PoliteWhisper_OtherDrop);
				UIDropDownMenu_SetSelectedValue(PoliteWhisper_OtherDrop, 0);

				-- Initialize stuff
				PoliteWhisper_Loading = true;
				PoliteWhisper_PartyUpdate();
		else
				-- Queue another ResetAll task?
				Reset = true;
				for i, Task in ipairs(PoliteWhisper_TaskQueue)
				do
						if (Task.Func == PoliteWhisper_ResetAll)
						then
								Reset = false;
								break;
						end
				end
				if (Reset)
				then
						Task =
						{
								Expire = GetTime() + PoliteWhisper_ResetAllTimeout,
								Func   = PoliteWhisper_ResetAll
						};
						table.insert(PoliteWhisper_TaskQueue, Task);
				end
		end

		-- Is a Census running?
		if (g_IsCensusPlusInProgress)
		then
				-- Yes, pause it so it won't interfere.
				PoliteWhisper_RestartCP = g_CensusPlusPaused;
				g_CensusPlusPaused = true;
		end

		-- Show the addon's frame
		PoliteWhisper_SetIgnoreScroll();
		PoliteWhisper_Frame:Show();
		PoliteWhisper_GoTab(1);
		PoliteWhisper_Visible = true;
end

-- PoliteWhisper_OnLoad is called when the GUI is loaded
function PoliteWhisper_OnLoad()
		local i, T, S;

		-- Don't show the frames initially
		PoliteWhisper_Frame:Hide();

		-- Set tabs
		this.elapsed = 0;
		PanelTemplates_SetNumTabs(PoliteWhisper_Frame, 4);
		PanelTemplates_SetTab(PoliteWhisper_Frame, 1);

		-- Okay to drag frame.
		PoliteWhisper_Frame:RegisterForDrag("LeftButton");

		-- Bind slash command
		SlashCmdList["POLITE_WHISPER"] = PoliteWhisper_Invoke;
		SLASH_POLITE_WHISPER1 = PW_SLASH_COMMAND;

		-- Tell user how to start program
		DEFAULT_CHAT_FRAME:AddMessage(PW_STARTUP_TEXT);

		-- Initialize variables
		T = {}
		T[PW_DRUID]   = PoliteWhisper_Druid;
		T[PW_HUNTER]  = PoliteWhisper_Hunter;
		T[PW_MAGE]    = PoliteWhisper_Mage;
		T[PW_PALADIN] = PoliteWhisper_Paladin;
		T[PW_PRIEST]  = PoliteWhisper_Priest;
		T[PW_ROGUE]   = PoliteWhisper_Rogue;
		T[PW_SHAMAN]  = PoliteWhisper_Shaman;
		T[PW_WARLOCK] = PoliteWhisper_Warlock;
		T[PW_WARRIOR] = PoliteWhisper_Warrior;
		PoliteWhisper_ClassEnables = T;

		-- Locate the scrolling items (and hide the buttons)
		for i = 1, PoliteWhisper_ListEntries
		do
				Item =
				{
						Name  = _G["PoliteWhisper_Player" .. i],
						Class = _G["PoliteWhisper_Class" .. i],
						Level = _G["PoliteWhisper_Level" .. i],
						Loc   = _G["PoliteWhisper_Zone" .. i],
						Ask   = _G["PoliteWhisper_Ask" .. i]
				};
				Item.Loc:SetAlphaGradient(24, 10);
				table.insert(PoliteWhisper_ScrollList, Item);
				Item.Ask:Hide();
		end
		for i = 1, PoliteWhisper_History
		do
				table.insert(PoliteWhisper_ChatList, _G["PoliteWhisper_Chat" .. i]);
		end

		-- Locate specializations & populate
		T = {};
		T[PW_DRUID]   = {PoliteWhisper_DruidDrop,   PoliteWhisper_DruidInit};
		T[PW_HUNTER]  = {PoliteWhisper_HunterDrop,  PoliteWhisper_HunterInit};
		T[PW_PALADIN] = {PoliteWhisper_PaladinDrop, PoliteWhisper_PaladinInit};
		T[PW_PRIEST]  = {PoliteWhisper_PriestDrop,  PoliteWhisper_PriestInit};
		T[PW_SHAMAN]  = {PoliteWhisper_ShamanDrop,  PoliteWhisper_ShamanInit};
		T[PW_WARRIOR] = {PoliteWhisper_WarriorDrop, PoliteWhisper_WarriorInit};
		PoliteWhisper_ClassDrops = T;
		for i, S in pairs(PoliteWhisper_ClassDrops) do S[1]:Hide(); end
		for i, S in pairs(PW_SPECIALIZE)
		do
				T = PoliteWhisper_ClassDrops[i];
				UIDropDownMenu_Initialize(T[1], T[2]);
				UIDropDownMenu_SetWidth(70, T[1]);
				UIDropDownMenu_SetSelectedValue(T[1], 1);
				T[1]:Show();
		end

		-- Locate party controls
		for i = 1, 4
		do
				T =
				{
						User   = _G["PoliteWhisper_Party" .. i],
						Notes  = _G["PoliteWhisper_Notes" .. i],
						Rating = _G["PoliteWhisper_Rating" .. i],
						Sad    = _G["PoliteWhisper_Sad" .. i],
						Medium = _G["PoliteWhisper_Medium" .. i],
						Happy  = _G["PoliteWhisper_Happy" .. i]
				};
				table.insert(PoliteWhisper_PartyCtrls, T);
		end

		-- Hide chat pane.
		PoliteWhisper_HideChat();

		-- Configure scroll bars
		PoliteWhisper_ScrollBarText:SetText("");
		PoliteWhisper_ScrollBarLow:SetText("");
		PoliteWhisper_ScrollBarHigh:SetText("");
		PoliteWhisper_ScrollBar:SetValueStep(1);
		PoliteWhisper_ScrollBar:SetValue(0);
		PoliteWhisper_ScrollBar:Hide();
		PoliteWhisper_IgnoreBarText:SetText("");
		PoliteWhisper_IgnoreBarLow:SetText("");
		PoliteWhisper_IgnoreBarHigh:SetText("");
		PoliteWhisper_IgnoreBar:SetValueStep(1);
		PoliteWhisper_IgnoreBar:SetValue(0);
		PoliteWhisper_IgnoreBar:Hide();
		PoliteWhisper_MiniMapAngleText:SetText("");
		PoliteWhisper_MiniMapAngleLow:SetText("");
		PoliteWhisper_MiniMapAngleHigh:SetText("");
		PoliteWhisper_MiniMapAngle:SetValueStep(1);
		PoliteWhisper_MiniMapDistText:SetText("");
		PoliteWhisper_MiniMapDistLow:SetText("");
		PoliteWhisper_MiniMapDistHigh:SetText("");
		PoliteWhisper_MiniMapDist:SetValueStep(1);
		for i = 1, 4
		do
				S = "PoliteWhisper_Rating" .. i;
				--_G[S]:SetText("");
				_G[S .. "Low"]:SetText("");
				_G[S .. "High"]:SetText("");
				_G[S]:SetValueStep(1);
				_G[S]:SetMinMaxValues(-100, 100);
		end

		-- Catch /who events
		PoliteWhisper_Frame:RegisterEvent("WHO_LIST_UPDATE");
		PoliteWhisper_Frame:RegisterEvent("CHAT_MSG_WHISPER");
		PoliteWhisper_Frame:RegisterEvent("CHAT_MSG_AFK");
		PoliteWhisper_Frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
		PoliteWhisper_Frame:RegisterEvent("VARIABLES_LOADED");
end

function PoliteWhisper_TranslateClass(class)
			local tclass=class;
			if (class == PW_DRUID) then
				tclass = PW_D_DRUID;
			end
			if (class == PW_HUNTER) then
				tclass = PW_D_HUNTER;
			end
			if (class == PW_MAGE) then
				tclass = PW_D_MAGE;
			end
			if (class == PW_PALADIN) then
				tclass = PW_D_PALADIN;
			end
			if (class == PW_PRIEST) then
				tclass = PW_D_PRIEST;
			end
			if (class == PW_ROGUE) then
				tclass = PW_D_ROGUE;
			end
			if (class == PW_SHAMAN) then
				tclass = PW_D_SHAMAN;
			end
			if (class == PW_WARLOCK) then
				tclass = PW_D_WARLOCK;
			end
			if (class == PW_WARRIOR) then
				tclass = PW_D_WARRIOR;
			end
			return tclass;
end

-- replace tags in the message with the actual content
function PoliteWhisper_ReplaceTags(message,targetuser)
		local gsubtable = {};

		if (targetuser ~= "$TestUser") then
			--$P = name of target player being whispered
			gsubtable["$P"] = targetuser;
		
			--$L = level of target player being whispered
			gsubtable["$L"] =	PoliteWhisper_Users[targetuser].Level;

			--$C = class of target player being whispered
			local class = PoliteWhisper_Users[targetuser].Class;
			gsubtable["$C"] =	PoliteWhisper_TranslateClass(class);
			

			--$D = name of destination zone/instance
			gsubtable["$D"] = PoliteWhisper_Dungeon:GetText();

			--$R = desired role of whispered player in group, eg. tank, healer, dps etc
			local Class = PoliteWhisper_Users[targetuser].Class;
			local Role = Class;
			if (PW_SPECIALIZE[Class]) then
					-- This class has a specialization!
					local D = PoliteWhisper_ClassDrops[Class][1];
					local S = UIDropDownMenu_GetSelectedValue(D);
					Role = PW_SPECIALIZE[Class][S][2];
			else
					--Class has no listed specialization, so prepend an 'a' to the role (Mage, Warlock, Rogue) for consistancy
					Role = PW_SPECIALIZE_OTHER_PREPEND..PoliteWhisper_TranslateClass(class):lower()..PW_SPECIALIZE_OTHER_APPEND;
			end
			gsubtable["$R"] = Role;
	
			--$N = number of players in group
			gsubtable["$N"] = GetNumPartyMembers()+1;
	
			--$B = name of group leader (boss)
			if (GetNumPartyMembers() > 0) then 
					gsubtable["$B"] = UnitName("party" .. GetPartyLeaderIndex());
			else
					--Group hasn't formed yet. Use name of player instead.
					gsubtable["$B"] = UnitName("player");
			end
	
			--$G = group makeup (classes and levels))
			local GroupMakeup = string.format(PW_PARTY_MAKEUP2, PoliteWhisper_TranslateClass(UnitClass("player")), UnitLevel("player"));
			for i = 1, GetNumPartyMembers() do
					GroupMakeup = GroupMakeup .. string.format(PW_PARTY_MAKEUP3, PoliteWhisper_TranslateClass(UnitClass("party" .. i)), UnitLevel("party" .. i));
			end
			gsubtable["$G"] = GroupMakeup;
		else
			--User is trying out the custom whispers, fill in some test data into the tags
			gsubtable["$P"] = "FooBar";
			gsubtable["$L"] =	70;
			gsubtable["$C"] =	PW_D_HUNTER;
			gsubtable["$D"] = PW_DUNGEONS[24][1];
			gsubtable["$R"] = PW_SPECIALIZE[PW_HUNTER][2][2];		
			gsubtable["$N"] = GetNumPartyMembers()+1;
			if (GetNumPartyMembers() > 0) then 
					gsubtable["$B"] = UnitName("party" .. GetPartyLeaderIndex());
			else
					--Group hasn't formed yet. Use name of player instead.
					gsubtable["$B"] = UnitName("player");
			end
			--$G = group makeup (classes and levels)
			local GroupMakeup = string.format(PW_PARTY_MAKEUP2, PoliteWhisper_TranslateClass(UnitClass("player")), UnitLevel("player"));
			for i = 1, GetNumPartyMembers() do
					GroupMakeup = GroupMakeup .. string.format(PW_PARTY_MAKEUP3, PoliteWhisper_TranslateClass(UnitClass("party" .. i)), UnitLevel("party" .. i));
			end
			gsubtable["$G"] = GroupMakeup;

		end
	
		--Perform the substitution and return the finished message
		return string.gsub(message,"($%w)", gsubtable);
end

-- PoliteWhisper_Search is called when the user clicks the search button
function PoliteWhisper_Search()
		local Dngn, Min, Max;

		-- Stopping a previous search?
		if (PoliteWhisper_SearchButton:GetText() == PW_STOP_SEARCH)
		then
				-- Remove the timeout event from the task queue.
				for i, Task in ipairs(PoliteWhisper_TaskQueue)
				do
						if (Task.Func == PoliteWhisper_DoNextSearch)
						then
								table.remove(PoliteWhisper_TaskQueue, i);
								break;
						end
				end

				-- Stop intercepting /who queries.
				PoliteWhisper_SearchInProg = false;
				SetWhoToUI(0);

				-- Fix search button text.
				PoliteWhisper_SearchButton:SetText(PW_SEARCH);

				-- Play a sound.
				PlaySound("igCharacterInfoClose");

				return;
		end

		-- Fetch search parameters
		Dngn = PoliteWhisper_Dungeon:GetText();
		Min = tonumber(PoliteWhisper_MinLevel:GetText());
		if (not Min) then Min = 1; end
		Max = tonumber(PoliteWhisper_MaxLevel:GetText());
		if (not Max) then Max = 70; end

		-- Validate search parameters
		if (Dngn == "")
		then
				PoliteWhisper_MsgHack(PW_NO_DUNGEON_ERR);
				return;
		end

		if (not Min) or (Min > 70)
		then
				PoliteWhisper_MsgHack(PW_NO_MIN_ERR);
				return;
		end

		if (not Max) or (Max > 70)
		then
				PoliteWhisper_MsgHack(PW_NO_MAX_ERR);
				return;
		end

		-- Start search
		-- We don't actually want to loop through the searches at this time.
		-- Instead, we launch the first search and allow the search event to launch
		-- each successive search.
		PoliteWhisper_SearchButton:SetText(PW_STOP_SEARCH);
		PoliteWhisper_DoNextSearch();
end

-- PoliteWhisper_DoNextSearch is called to search for a given Class.
function PoliteWhisper_DoNextSearch(Class)
		local Enable, Min, Max, Filter;

		-- Find next class
		Class = next(PoliteWhisper_ClassEnables, Class);
		if (not Class)
		then
				PoliteWhisper_SearchButton:SetText(PW_SEARCH);
				return;
		end

		-- Search on this class?
		Enable = PoliteWhisper_ClassEnables[Class]
		if (Enable:GetChecked())
		then
				-- Yes, start search
				Min = tonumber(PoliteWhisper_MinLevel:GetText());
				if (not Min) then Min = 1; end
				Max = tonumber(PoliteWhisper_MaxLevel:GetText());
				if (not Max) then Max = 70; end
				Filter = "c-\"" .. Class .. "\" " .. Min .. "-" .. Max;
				PoliteWhisper_SearchInProg = Class;
				SetWhoToUI(1);
				SendWho(Filter);

				-- Launch a timeout for the /who in case it doesn't complete.
				Task =
				{
						Expire = GetTime() + PoliteWhisper_WhoTimeout,
						Func   = PoliteWhisper_CancelWho
				};
				table.insert(PoliteWhisper_TaskQueue, Task);
		else
				-- No, skip to next
				PoliteWhisper_DoNextSearch(Class);
		end
end

-- Called if there is not a response to our /who.
function PoliteWhisper_CancelWho()
		-- Stop already?
		if (not PoliteWhisper_SearchInProg) then return; end

		-- Stop intercepting /who queries.
		PoliteWhisper_SearchInProg = false;
		SetWhoToUI(0);

		-- Tell the user that something went wrong.
		PoliteWhisper_MsgHack(PW_NO_RESP_ERR);
end

-- Called by PoliteWhisper_OnEvent in response to a WHO_LIST_UPDATE event.
function PoliteWhisper_OnWho()
		local i, Task, Class, Name, X, Level, PClass, Loc, Guild;

		-- Hide the window
		FriendsFrame:Hide();

		-- Remove the timeout event from the task queue.
		for i, Task in ipairs(PoliteWhisper_TaskQueue)
		do
				if (Task.Func == PoliteWhisper_CancelWho)
				then
						table.remove(PoliteWhisper_TaskQueue, i);
						break;
				end
		end

		-- We're done searching now.  If any more /who events fire, we'll ignore
		-- them.
		Class = PoliteWhisper_SearchInProg;
		PoliteWhisper_SearchInProg = false;
		SetWhoToUI(0);

		-- Save the results.
		for i = 1, GetNumWhoResults()
		do
				Name, Guild, Level, X, PClass, Loc, X = GetWhoInfo(i);
				PoliteWhisper_FoundWho(Name, Level, Class, Loc, Guild);
		end

		-- Continue search by scheduling another /who.
		Task =
		{
				Expire = GetTime() + PoliteWhisper_WhoDelay,
				Func   = PoliteWhisper_DoNextSearch,
				Arg1   = Class
		};
		table.insert(PoliteWhisper_TaskQueue, Task);

		-- Update display list.
		PoliteWhisper_UpdateList();
end

-- Called for each user returned by /who.
function PoliteWhisper_FoundWho(Name, Level, Class, Loc, Guild)
		local i, Status, Dungeon, L;

		-- Is the user on our ignore list?
		for i = 1, GetNumIgnores()
		do
				if (Name == GetIgnoreName(i)) then return; end
		end

		-- Is the user in our party?
		if (Name == UnitName("player")) then return; end
		for i = 1, GetNumPartyMembers()
		do
				if (Name == UnitName("party" .. i)) then return; end
		end

		-- Have we seen this user before?
		if (PoliteWhisper_Users[Name])
		then
				Status = PoliteWhisper_Users[Name].Status;
		else
				-- Nope, create a record for them.
				PoliteWhisper_Users[Name] = { Level = Level, Class = Class,
						Guild = Guild, Log = {"", "", "", ""} };
		end

		-- Is the user in a dungeon?
		Dungeon = not PoliteWhisper_Zones[Loc];

		-- What state should the user be in now?
		if (Status == PW_REASK) and Dungeon
		then
				Status = PW_DUNGEON;
		elseif (not Status) or (Status == PW_ASK) or (Status == PW_DUNGEON) or
				(Status == PW_AFK)
		then
				if (Dungeon)
				then
						Status = PW_DUNGEON;
				else
						Status = PW_ASK;
				end
		end

		-- Save the user's location and status
		PoliteWhisper_Users[Name].Loc    = Loc;
		PoliteWhisper_Users[Name].Status = Status;
end

-- Called in response to a captured event
function PoliteWhisper_OnEvent()
		-- Who event?
		if ((event == "WHO_LIST_UPDATE") and PoliteWhisper_SearchInProg)
		then
				PoliteWhisper_OnWho();
		elseif (event == "CHAT_MSG_WHISPER")
		then
				PoliteWhisper_OnWhisper(arg2, arg1);
		elseif (event == "CHAT_MSG_AFK")
		then
				PoliteWhisper_OnAFK(arg2);
		elseif (event == "PARTY_MEMBERS_CHANGED")
		then
				PoliteWhisper_Loading = true;
				PoliteWhisper_UpdateList();
				PoliteWhisper_TestIgnore();
				PoliteWhisper_PartyUpdate();
		elseif (event == "VARIABLES_LOADED")
		then
				if (not PoliteWhisper_Options)
				then
						PoliteWhisper_Options =
						{
								MiniMapEnable = true;
								MiniMapAngle  = 201;
								MiniMapDist   = 78;
								Show          = PW_ZONE;
						};
				end
				if (not PoliteWhisper_Options.INVITATION_WHISPER)
				then
						PoliteWhisper_ResetCustomWhispers();
				end
				if (not PoliteWhisper_Options.Show)
				then
						PoliteWhisper_Options.Show = PW_ZONE;
				end

				PoliteWhisper_Init();
		end
end

function PoliteWhisper_ResetCustomWhispers()
		PoliteWhisper_Options.INVITATION_WHISPER = PW_INVITATION_WHISPER;
		PoliteWhisper_Options.SPECIAL_INVITE = PW_SPECIAL_INVITE;
		PoliteWhisper_Options.APOLOGY = PW_APOLOGY;
		PoliteWhisper_Options.INVITE_REQUEST = PW_INVITE_REQUEST;
		PoliteWhisper_Options.PARTY_MAKEUP = PW_PARTY_MAKEUP1;
		PoliteWhisper_Options.INVITE_WARNING = PW_INVITE_WARNING;
		PoliteWhisper_Options.SLOT_FULL = PW_SLOT_FULL;
		PoliteWhisper_Options.PARTY_FULL = PW_PARTY_FULL;
		
		PoliteWhisper_Custom1:SetText(PoliteWhisper_Options.INVITATION_WHISPER);
		PoliteWhisper_Custom2:SetText(PoliteWhisper_Options.SPECIAL_INVITE);
		PoliteWhisper_Custom3:SetText(PoliteWhisper_Options.APOLOGY);
		PoliteWhisper_Custom4:SetText(PoliteWhisper_Options.INVITE_REQUEST);
		PoliteWhisper_Custom5:SetText(PoliteWhisper_Options.PARTY_MAKEUP);
		PoliteWhisper_Custom6:SetText(PoliteWhisper_Options.INVITE_WARNING);
		PoliteWhisper_Custom7:SetText(PoliteWhisper_Options.SLOT_FULL);
		PoliteWhisper_Custom8:SetText(PoliteWhisper_Options.PARTY_FULL);

end;

-- PoliteWhisper_OnUpdate is called periodically while the PW frame is visible.
-- We use this to launch any queued tasks.
function PoliteWhisper_OnUpdate()
		-- Loop through all queued tasks.
		local i, T;
		for i, T in ipairs(PoliteWhisper_TaskQueue)
		do
				-- Has task expired?
				if (GetTime() > T.Expire)
				then
						T.Func(T.Arg1, T.Arg2, T.Arg3);
						table.remove(PoliteWhisper_TaskQueue, i);
						return;
				end
		end
end

-- Display an item.
function PoliteWhisper_ShowItem(i, Name, Items)
		local Ctrls, Rating, R, G, B, Notes;
		Ctrls = PoliteWhisper_ScrollList[i];

		-- How well do we know this user?
		if (PoliteWhisper_Friends[Name])
		then
				Rating = PoliteWhisper_Friends[Name].Rating;
				Notes  = PoliteWhisper_Friends[Name].Notes;
		else
				Rating = 0;
				Notes  = "";
		end
		if (Rating < 0)
		then
				R = 1.0; G = 1.0 + (Rating * 0.0075); B = 0.25;
		else
				R = 1.0 - (Rating * 0.01); G = 1.0 - (Rating * 0.0025);
				B = 0.25 - (Rating * 0.0025);
		end

		-- Show the user.
		Ctrls.Name:SetText(Name);
		Ctrls.Class:SetText(Items.Class);
		Ctrls.Level:SetText(Items.Level);
		if (PoliteWhisper_Options.Show == PW_ZONE)
		then
				Ctrls.Loc:SetText(Items.Loc);
		elseif (PoliteWhisper_Options.Show == PW_GUILD)
		then
				Ctrls.Loc:SetText(Items.Guild);
		else
				Ctrls.Loc:SetText(Notes);
		end
		if (Name == PoliteWhisper_ChatUser)
		then
				Ctrls.Ask:SetText(PW_DELETE);
		else
				Ctrls.Ask:SetText(Items.Status);
		end

		-- Set color based on party settings
		Ctrls.Name:SetTextColor(R, G, B, 1);
		Ctrls.Ask:Show();

		-- Remember the user associated with this entry for later.
		Ctrls.User = Name;
end

-- Returns true if this user's items match our filter.
function PoliteWhisper_Filter(Items)
		local Min, Max;
		Min = tonumber(PoliteWhisper_MinLevel:GetText());
		if (not Min) then Min = 1; end
		Max = tonumber(PoliteWhisper_MaxLevel:GetText());
		if (not Max) then Max = 70; end

		return (Items.Level >= Min) and (Items.Level <= Max) and
				PoliteWhisper_ClassEnables[Items.Class]:GetChecked();
end

-- Loop through a part of the user list. Called by PoliteWhisper_UpdateList.
function PoliteWhisper_ShowItems(SortList)
		local Name, Items, ScrollOffset, i, j, InGroup, Offset;
		Offset = 0;

		-- What is the scroll bar set to?
		ScrollOffset = PoliteWhisper_ScrollBar:GetValue();

		-- Loop through list
		for i, Name in ipairs(SortList)
		do
				-- Is this person in our group?
				InGroup = (Name == UnitName("player"));
				for j = 1, GetNumPartyMembers()
				do
						if (UnitName("party" .. j) == Name) then InGroup = true; end
				end

				-- On Ask and Re-Ask entries, we need to filter out users who no longer
				-- match our search criteria.
				Items = PoliteWhisper_Users[Name];
				if (not InGroup) and (not PoliteWhisper_DoNotInvite[Name]) and
						((Items.Status == PW_CHAT) or PoliteWhisper_Filter(Items))
				then
						Offset = Offset + 1;

						-- Show it?
						if (Offset > ScrollOffset) and
								(Offset <= (ScrollOffset + PoliteWhisper_ListEntries))
						then
								PoliteWhisper_ShowItem(Offset - ScrollOffset, Name, Items);
						end
				end
		end

		return Offset;
end

-- Clear out an item.
function PoliteWhisper_ClearItem(i)
		local Ctrls = PoliteWhisper_ScrollList[i];

		Ctrls.Name:SetText("");
		Ctrls.Class:SetText("");
		Ctrls.Level:SetText("");
		Ctrls.Loc:SetText("");
		Ctrls.Ask:Hide();
end

-- Update the ignore list display.
function PoliteWhisper_UpdateIgnore()
		local S, i, N, X;

		-- Loop through list
		i = 0;
		S = PoliteWhisper_IgnoreBar:GetValue();
		for N, X in pairs(PoliteWhisper_DoNotInvite)
		do
				i = i + 1;

				if ((i > S) and (i <= (S + PoliteWhisper_IgnoreListEntries)))
				then
						_G["PoliteWhisper_Ignore" .. (i - S)]:SetText(N);

						-- Any notes to show?
						if (X == true)
						then
								_G["PoliteWhisper_IgnoreN" .. (i - S)]:SetText("");
						else
								_G["PoliteWhisper_IgnoreN" .. (i - S)]:SetText(X);
						end
				end
		end

		-- Blank the rest of the list
		while (i < PoliteWhisper_IgnoreListEntries)
		do
				i = i + 1;
				_G["PoliteWhisper_Ignore" .. i]:SetText("");
				_G["PoliteWhisper_IgnoreN" .. i]:SetText("");
		end
end

-- Format a name
function PoliteWhisper_FormatName(Name)
		return string.upper(string.sub(Name, 1, 1)) ..
				string.lower(string.sub(Name, 2));
end

-- Add a user to the ignore list
function PoliteWhisper_IgnoreAdd()
		local User, N;
		User = PoliteWhisper_FormatName(PoliteWhisper_Ignore:GetText());

		if (User == "")
		then
				PoliteWhisper_MsgHack(PW_NO_USER_ADD_ERR);
				return;
		end

		if (PoliteWhisper_DoNotInvite[User])
		then
				PoliteWhisper_MsgHack(PW_USER_ON_LIST_ERR);
				return;
		end

		-- Update the display
		PlaySound("igCharacterInfoOpen");
		PoliteWhisper_DoNotInvite[User] = PoliteWhisper_Notes:GetText();
		PoliteWhisper_UpdateIgnore();
		PoliteWhisper_SetIgnoreScroll();

		-- Clear out the text
		PoliteWhisper_Ignore:SetText("");
		PoliteWhisper_Notes:SetText("");

		-- Refilter
		PoliteWhisper_UpdateList();
		PoliteWhisper_PartyUpdate();
end

-- Set the scroll bar for the ignore list.
function PoliteWhisper_SetIgnoreScroll()
		local i, K, V;
		i = 0;
		for K, V in pairs(PoliteWhisper_DoNotInvite) do i = i + 1; end
		if (i > PoliteWhisper_IgnoreListEntries)
		then
				PoliteWhisper_IgnoreBar:SetMinMaxValues(0,
						i - PoliteWhisper_IgnoreListEntries);
				PoliteWhisper_IgnoreBar:SetValue(0);
				PoliteWhisper_IgnoreBar:Show();
		else
				PoliteWhisper_IgnoreBar:Hide();
		end
end

-- Delete a user from the ignore list
function PoliteWhisper_IgnoreDelete()
		local User = PoliteWhisper_FormatName(PoliteWhisper_Ignore:GetText());

		if (User == "")
		then
				PoliteWhisper_MsgHack(PW_NO_USER_DEL_ERR);
				return;
		end

		if (not PoliteWhisper_DoNotInvite[User])
		then
				PoliteWhisper_MsgHack(PW_USER_NOT_ON_ERR);
				return;
		end

		-- Remove & update
		PoliteWhisper_DoNotInvite[User] = nil;
		PlaySound("igCharacterInfoClose");
		PoliteWhisper_Ignore:SetText("");
		PoliteWhisper_SetIgnoreScroll();
		PoliteWhisper_UpdateIgnore();

		-- Refilter
		PoliteWhisper_UpdateList();
		PoliteWhisper_PartyUpdate();
end

-- Update the list display.  Called when PoliteWhisper_Users changes.
function PoliteWhisper_UpdateList()
		local i, Items, SortList, User;

		-- Were we chatting with someone who is now a party member?
		for i = 1, GetNumPartyMembers()
		do
				if (UnitName("party" .. i) == PoliteWhisper_ChatUser) then
						-- Hide the chat pane.
						PoliteWhisper_HideChat();
				end
		end

		-- Sort the entries.
		SortList = {};
		for User, Items in pairs(PoliteWhisper_Users)
		do
				if ((Items.Status == PW_CHAT) or (Items.Status == PW_ASK) or
						(Items.Status == PW_REASK))
				then
						table.insert(SortList, User);
				end
		end
		table.sort(SortList, PoliteWhisper_SortComp);

		-- Show the entries.
		Items = PoliteWhisper_ShowItems(SortList);

		-- Clear any remaining items.
		for i = Items + 1, PoliteWhisper_ListEntries
		do
				PoliteWhisper_ClearItem(i);
		end

		-- Do we need a scroll bar?
		if (Items > PoliteWhisper_ListEntries)
		then
				-- Yup, make sure it is showing.
				PoliteWhisper_ScrollBar:Show();

				-- Adjust the limit and refresh.
				PoliteWhisper_ScrollBar:SetMinMaxValues(0,
						Items - PoliteWhisper_ListEntries);
				PoliteWhisper_ScrollBar:SetValue(PoliteWhisper_ScrollBar:GetValue());
		else
				-- Nope, make sure it is hidden.
				PoliteWhisper_ScrollBar:Hide();

				-- Were we scrolled any?
				if (PoliteWhisper_ScrollBar:GetValue() > 0)
				then
						-- Yes, crap, we have to redo the display.
						PoliteWhisper_ScrollBar:SetValue(0);
						PoliteWhisper_UpdateList();
				end
		end
end

-- Called when an ask button is clicked.
function PoliteWhisper_OnAsk(i)
		local Class, D, S, Msg, Task;

		-- Find the user.
		local User = PoliteWhisper_ScrollList[i].User;
		-- Chat window already open with them?  That indicates "Delete".
		if (User == PoliteWhisper_ChatUser)
		then
				PoliteWhisper_Users[User].Status = PW_DELETED;
				PoliteWhisper_HideChat();
				return;
		end

		-- Open the chat window?
		if (PoliteWhisper_Users[User].Status == PW_CHAT)
		then
				-- Start chatting with the user.
				PoliteWhisper_ShowChat(User);
		else
				-- Must be some sort of "ask"

				-- Is there still a dungeon entered?
				if (PoliteWhisper_Dungeon:GetText() == "")
				then
						PoliteWhisper_MsgHack(PW_NO_DUNGEON_ERR);
						return;
				end

				-- Use a special whisper?
				Class = PoliteWhisper_Users[User].Class;
				Msg = PoliteWhisper_Options.INVITATION_WHISPER;
				if (PW_SPECIALIZE[Class])
				then
						-- This class has a specialization!
						Msg = PoliteWhisper_Options.SPECIAL_INVITE;
				end
				PoliteWhisper_SendAndLog(Msg, User);

				-- Remove user from list. Create a chat log in case they reply.
				PoliteWhisper_Users[User].Status = PW_PENDING;
				PoliteWhisper_UpdateList();

				-- It's okay to re-ask this user if they don't reply for 10 minutes.
				Task =
				{
						Expire = GetTime() + PoliteWhisper_NoRespPesterTimeout,
						Func   = PoliteWhisper_Repester,
						Arg1   = User
				};
				table.insert(PoliteWhisper_TaskQueue, Task);
		end
end

-- Called when it is okay to pester someone again.
function PoliteWhisper_Repester(User)
		-- They still in the list?
		if (PoliteWhisper_Users[User])
		then
				-- Yup, add them in as Re-Ask.
				PoliteWhisper_Users[User].Status = PW_REASK;
				PoliteWhisper_UpdateList();
		end
end

-- Called when a user is AFK.
function PoliteWhisper_OnAFK(Name)
		local M, U;

		-- Ignore messages from users we don't know.
		U = PoliteWhisper_Users[User];
		if (not U) then return; end

		-- Reset the pester timeout event to the shorter AFK time.
		for i, Task in ipairs(PoliteWhisper_TaskQueue)
		do
				if (Task.Func == PoliteWhisper_Repester) and (Task.Arg1 == User)
				then
						PoliteWhisper_TaskQueue[i].Expire = GetTime() +
								PoliteWhisper_AFKPesterTimeout;
						break;
				end
		end

		-- Update their status and display.
		if (U.Status == PW_PENDING)
		then
				U.Status = PW_AFK;
				PoliteWhisper_UpdateList();
		end
end

-- Called when a whisper is received.
function PoliteWhisper_OnWhisper(User, Msg)
		local U;

		if (Msg == "QWERTYUIOP") then table.insert(PoliteWhisper_TaskQueue, 5); end

		-- Ignore messages from users we don't know.
		U = PoliteWhisper_Users[User];
		if (not U) then return; end

		-- Remove the pester timeout event from the task queue.
		for i, Task in ipairs(PoliteWhisper_TaskQueue)
		do
				if (Task.Func == PoliteWhisper_Repester) and (Task.Arg1 == User)
				then
						table.remove(PoliteWhisper_TaskQueue, i);
						break;
				end
		end

		-- Update their status and display.
		if (U.Status == PW_PENDING) or (U.Status == PW_AFK)
		then
				U.Status = PW_CHAT;
				PoliteWhisper_UpdateList();
		end

		-- Save the message.
		PoliteWhisper_LogMsg(string.format(PW_INCOME_WHISPER, User, Msg), User);
end

-- Update the chat pane.
function PoliteWhisper_UpdateLog()
		local i, Log;

		-- Is the chat pane visible?
		if (PoliteWhisper_ChatUser)
		then
				Log = PoliteWhisper_Users[PoliteWhisper_ChatUser].Log;
				for i = 1, PoliteWhisper_History
				do
						PoliteWhisper_ChatList[i]:SetText(Log[i]);
				end
		end
end

-- Show the chat pane.
function PoliteWhisper_ShowChat(User)
		local i;

		-- Was it hidden?
		if (not PoliteWhisper_ChatUser)
		then
				-- Shrink scroll to minimum.
				PoliteWhisper_ListEntries = PoliteWhisper_MinListEntries;
				PoliteWhisper_UpdateList();
				PoliteWhisper_ScrollBar:SetHeight(PoliteWhisper_MinSliderHeight);
				for i = PoliteWhisper_MinListEntries + 1, PoliteWhisper_MaxListEntries
				do
						PoliteWhisper_ClearItem(i);
				end

				-- Feedback sound.
				PlaySound("igCharacterInfoOpen");
		end

		-- Save user.
		PoliteWhisper_ChatUser = User;

		-- Show stuff.
		PoliteWhisper_Talk:Show();
		PoliteWhisper_Decline:Show();
		PoliteWhisper_Invite:Show();
		PoliteWhisper_OtherDrop:Show();
		PoliteWhisper_UpdateLog();
		PoliteWhisper_UpdateList();

		-- Activate chat bar.
		PoliteWhisper_Talk:SetFocus();
end

-- Hide the chat pane.
function PoliteWhisper_HideChat(Silent)
		local i;

		-- Not chatting with a user anymore.
		PoliteWhisper_ChatUser = nil;

		-- Hide stuff.
		PoliteWhisper_Talk:Hide();
		PoliteWhisper_Decline:Hide();
		PoliteWhisper_Invite:Hide();
		PoliteWhisper_OtherDrop:Hide();
		for i = 1, PoliteWhisper_History
		do
				PoliteWhisper_ChatList[i]:SetText("");
		end

		-- Expand scroll to maximum.
		PoliteWhisper_ListEntries = PoliteWhisper_MaxListEntries;
		PoliteWhisper_UpdateList();
		PoliteWhisper_ScrollBar:SetHeight(PoliteWhisper_MaxSliderHeight);

		-- Feedback sound.
		if (not Silent)
		then
				PlaySound("igCharacterInfoClose");
		end
end

--User declined us
function PoliteWhisper_Declined()
		PoliteWhisper_SendFinal(PoliteWhisper_Options.APOLOGY);
end

-- User wants to send a whisper.
function PoliteWhisper_Speak()
		local Msg, Log;

		-- No action on blank.
		if (PoliteWhisper_Talk:GetText() == "") then return; end

		-- Whisper user.
		PoliteWhisper_SendAndLog(PoliteWhisper_Talk:GetText());

		-- Remove old text.
		PoliteWhisper_Talk:SetText("");
end

-- Last message sent to user.
function PoliteWhisper_SendFinal(Msg)
		-- Send user an "OK" message.
		PoliteWhisper_SendAndLog(Msg);

		-- Remove user.
		PoliteWhisper_Users[PoliteWhisper_ChatUser].Status = PW_DECLINE;
		PoliteWhisper_UpdateList();

		-- Close chat.
		PoliteWhisper_HideChat();
end

-- Invite the user.
function PoliteWhisper_InviteUser()
		local Msg, Items, Leader;

		-- Are we the leader?
		if (GetNumPartyMembers() == 0) or IsPartyLeader("player")
		then
				-- Yes, invite them.
				InviteUnit(PoliteWhisper_ChatUser);
		else
				-- No, ask the leader to invite the user.
--        Items = PoliteWhisper_Users[PoliteWhisper_ChatUser];
				Msg = PoliteWhisper_ReplaceTags(PoliteWhisper_Options.INVITE_REQUEST,PoliteWhisper_ChatUser);
				Leader = UnitName("party" .. GetPartyLeaderIndex());
				SendChatMessage(Msg, "WHISPER", nil, Leader);

				-- Warn the user to expect an invite from someone else.
				PoliteWhisper_SendAndLog(PoliteWhisper_Options.INVITE_WARNING);
		end
end

-- Describe the current party.
function PoliteWhisper_TellParty()
		PoliteWhisper_SendAndLog(PoliteWhisper_Options.PARTY_MAKEUP);
end

-- Close the main frame.
function PoliteWhisper_Close()
		PoliteWhisper_Frame:Hide();
		PoliteWhisper_Visible = false;

		-- Restart a census?
		if (g_IsCensusPlusInProgress)
		then
				-- Yes, un-pause it.
				g_CensusPlusPaused = PoliteWhisper_RestartCP;
		end
end

-- Select a given tab.
function PoliteWhisper_GoTab(N)
		PlaySound("igCharacterInfoOpen");
		PanelTemplates_SetTab(PoliteWhisper_Frame, N);
		if (N == 1)
		then
				PoliteWhisper_Finder:Show();
				--PoliteWhisper_Dungeon:SetFocus();
		else
				PoliteWhisper_Finder:Hide();
		end
		if (N == 2)
		then
				PoliteWhisper_NoInvite:Show();
				PoliteWhisper_Ignore:SetFocus();
		else
				PoliteWhisper_NoInvite:Hide();
		end
		if (N == 3)
		then
				PoliteWhisper_Config:Show();
		else
				PoliteWhisper_Config:Hide();
		end
		if (N == 4)
		then
				PoliteWhisper_Custom:Show();
		else
				PoliteWhisper_Custom:Hide();
		end
		if (N == 5)
		then
				PoliteWhisper_Party:Show();
		else
				PoliteWhisper_Party:Hide();
		end
end

function PoliteWhisper_TestCustom(i)
		local Text = _G["PoliteWhisper_Custom" .. i]:GetText();
		
		--Replace tags in the whisper with the actual content
		Text = PoliteWhisper_ReplaceTags(Text,"$TestUser");
		
		DEFAULT_CHAT_FRAME:AddMessage(">>"..Text.."<<");
end


-- Initialize various things.
function PoliteWhisper_Init()
		local i, j, Zone;

		-- ESC should close our frame.
		table.insert(UISpecialFrames, "PoliteWhisper_Frame");

		-- Create a table of all standard (non-dungeon/bg) zones.
		for i = 1, 3
		do
				for j, Zone in ipairs({ GetMapZones(i) })
				do
						PoliteWhisper_Zones[Zone] = true;
				end
		end

		-- Update configuration panel.
		PoliteWhisper_MiniMapEnable:SetChecked(PoliteWhisper_Options.MiniMapEnable);

		PoliteWhisper_MiniMapAngle:SetMinMaxValues(0, 360);
		PoliteWhisper_MiniMapAngle:SetValue(PoliteWhisper_Options.MiniMapAngle);

		PoliteWhisper_MiniMapDist:SetMinMaxValues(78, 155);
		PoliteWhisper_MiniMapDist:SetValue(PoliteWhisper_Options.MiniMapDist);

		-- Fetch the saved custom whispers.
		PoliteWhisper_Custom1:SetText(PoliteWhisper_Options.INVITATION_WHISPER);
		PoliteWhisper_Custom2:SetText(PoliteWhisper_Options.SPECIAL_INVITE);
		PoliteWhisper_Custom3:SetText(PoliteWhisper_Options.APOLOGY);
		PoliteWhisper_Custom4:SetText(PoliteWhisper_Options.INVITE_REQUEST);
		PoliteWhisper_Custom5:SetText(PoliteWhisper_Options.PARTY_MAKEUP);
		PoliteWhisper_Custom6:SetText(PoliteWhisper_Options.INVITE_WARNING);
		PoliteWhisper_Custom7:SetText(PoliteWhisper_Options.SLOT_FULL);
		PoliteWhisper_Custom8:SetText(PoliteWhisper_Options.PARTY_FULL);

		PoliteWhisper_Loading = false;
		
		-- Configure according to options.
		PoliteWhisper_SetOptions();
end

-- Configure app according to options.
function PoliteWhisper_SetOptions()
		local Angle, X, Y;

		-- This routine must not be executed at start up or saved values get reset.
		if (PoliteWhisper_Loading) then return; end

		-- Save options in variables.
		PoliteWhisper_Options.MiniMapEnable =
				PoliteWhisper_MiniMapEnable:GetChecked();
		PoliteWhisper_Options.MiniMapAngle = PoliteWhisper_MiniMapAngle:GetValue();
		PoliteWhisper_Options.MiniMapDist  = PoliteWhisper_MiniMapDist:GetValue();

		-- Save the custom whispers.
		PoliteWhisper_Options.INVITATION_WHISPER	= PoliteWhisper_Custom1:GetText();
		PoliteWhisper_Options.SPECIAL_INVITE			= PoliteWhisper_Custom2:GetText();
		PoliteWhisper_Options.APOLOGY							= PoliteWhisper_Custom3:GetText();
		PoliteWhisper_Options.INVITE_REQUEST			= PoliteWhisper_Custom4:GetText();
		PoliteWhisper_Options.PARTY_MAKEUP				= PoliteWhisper_Custom5:GetText();
		PoliteWhisper_Options.INVITE_WARNING			= PoliteWhisper_Custom6:GetText();
		PoliteWhisper_Options.SLOT_FULL						= PoliteWhisper_Custom7:GetText();
		PoliteWhisper_Options.PARTY_FULL					= PoliteWhisper_Custom8:GetText();

		-- Update position of the button.
		if (PoliteWhisper_Options.MiniMapEnable)
		then
				Angle = PoliteWhisper_Options.MiniMapAngle * 0.01745;
				X = math.cos(Angle) * PoliteWhisper_Options.MiniMapDist + 10;
				Y = math.sin(Angle) * PoliteWhisper_Options.MiniMapDist + 20;
				PoliteWhisper_MiniMap:SetPoint("CENTER", "MinimapBackdrop", "CENTER",
						X, Y);
				PoliteWhisper_MiniMap:Show();
		else
				PoliteWhisper_MiniMap:Hide();
		end

		if (PoliteWhisper_HeroicEnable:GetChecked()) then
			PoliteWhisper_MinLevel:SetText("70");
			PoliteWhisper_MaxLevel:SetText("70");
		end

		-- Guild/Zone toggle.
		PoliteWhisper_Zone:SetText(PoliteWhisper_Options.Show);
end

-- Toggle between guild/zone.
function PoliteWhisper_ToggleU()
		if (PoliteWhisper_Options.Show == PW_ZONE)
		then
				PoliteWhisper_Options.Show = PW_GUILD;
		elseif (PoliteWhisper_Options.Show == PW_GUILD)
		then
				PoliteWhisper_Options.Show = PW_NOTES;
		else
				PoliteWhisper_Options.Show = PW_ZONE;
		end
		PoliteWhisper_SetOptions();
		PoliteWhisper_UpdateList();

		-- Feedback sound.
		PlaySound("igChatBottom");
end

-- Populate the dungeon pull-down.
function PoliteWhisper_DungeonInit()
		local Item, i, N, Dungeon, Min, Max;
		Min = tonumber(PoliteWhisper_MinLevel:GetText());
		if (not Min) then Min = 1; end
		Max = tonumber(PoliteWhisper_MaxLevel:GetText());
		if (not Max) then Max = 70; end
		Item      = UIDropDownMenu_CreateInfo();
		Item.func = PoliteWhisper_OnDungeonDrop;

		-- Loop through all dungeons to see which would suit us.
		if (PoliteWhisper_HeroicEnable:GetChecked()) then
			N = 0;
			for i, Dungeon in ipairs(PW_HEROIC_DUNGEONS)
			do
				if (((Min >= Dungeon[2]) and (Min <= Dungeon[3])) or
						((Max >= Dungeon[2]) and (Max <= Dungeon[3])) or
						((Dungeon[2] >= Min) and (Dungeon[2] <= Max)))
				then
						Item.text  = Dungeon[1] .. " (" .. PW_HEROIC_MODE.. ")";
						Item.value = i;
						UIDropDownMenu_AddButton(Item);
						N = N + 1;
				end
			end
		else
			N = 0;
			for i, Dungeon in ipairs(PW_DUNGEONS)
			do
				if (((Min >= Dungeon[2]) and (Min <= Dungeon[3])) or
						((Max >= Dungeon[2]) and (Max <= Dungeon[3])) or
						((Dungeon[2] >= Min) and (Dungeon[2] <= Max)))
				then
						Item.text  = Dungeon[1];
						Item.value = i;
						UIDropDownMenu_AddButton(Item);
						N = N + 1;
				end
			end
		end
		-- Don't show an absurd number of dungeons
		if (N > 40) then return; end
end

-- User selected a dungeon from the drop down.
function PoliteWhisper_OnDungeonDrop()
		if (PoliteWhisper_HeroicEnable:GetChecked()) then
			local Dungeon = PW_HEROIC_DUNGEONS[this.value];
			PoliteWhisper_Dungeon:SetText(Dungeon[1] .. " (" .. PW_HEROIC_MODE.. ")");
			PoliteWhisper_MinLevel:SetText(Dungeon[2]);
			PoliteWhisper_MaxLevel:SetText(Dungeon[3]);

		else
			local Dungeon = PW_DUNGEONS[this.value];
			PoliteWhisper_Dungeon:SetText(Dungeon[1]);
			PoliteWhisper_MinLevel:SetText(Dungeon[2]);
			PoliteWhisper_MaxLevel:SetText(Dungeon[3]);
		end
end

-- Initialize a class drop-down menu.
function PoliteWhisper_ClassInit(Class)
		local Item, i, S;
		Item         = UIDropDownMenu_CreateInfo();
		Item.func    = PoliteWhisper_OnClassDrop;
		Item.owner   = PoliteWhisper_ClassDrops[Class][1];

		for i, S in pairs(PW_SPECIALIZE[Class])
		do
				Item.text    = S[1];
				Item.value   = i;
				Item.checked = (UIDropDownMenu_GetSelectedValue(Item.owner) == i);
				UIDropDownMenu_AddButton(Item);
		end
end

-- Class-specific initialization calls.
function PoliteWhisper_DruidInit()   PoliteWhisper_ClassInit(PW_DRUID);   end
function PoliteWhisper_HunterInit()  PoliteWhisper_ClassInit(PW_HUNTER);  end
function PoliteWhisper_PaladinInit() PoliteWhisper_ClassInit(PW_PALADIN); end
function PoliteWhisper_PriestInit()  PoliteWhisper_ClassInit(PW_PRIEST);  end
function PoliteWhisper_ShamanInit()  PoliteWhisper_ClassInit(PW_SHAMAN);  end
function PoliteWhisper_WarriorInit() PoliteWhisper_ClassInit(PW_WARRIOR); end

-- Handles a change of specialization.
function PoliteWhisper_OnClassDrop()
		UIDropDownMenu_SetSelectedValue(this.owner, this.value);
end

-- Test if we just grouped with someone on our ignore list.
function PoliteWhisper_TestIgnore()
		local i, User, Note;

		for i = 1, GetNumPartyMembers()
		do
				User = UnitName("party" .. i);
				Note = PoliteWhisper_DoNotInvite[User];
				if (Note)
				then
						-- Crap! We're grouped with someone we wanted to ignore.
						if ((Note == true) or (Note == ""))
						then
								PoliteWhisper_MsgHack(string.format(PW_IGNORE_GROUP_WARN1,
										User));
						else
								PoliteWhisper_MsgHack(string.format(PW_IGNORE_GROUP_WARN2,
										User, PoliteWhisper_DoNotInvite[User]));
						end
				end
		end
end

-- Initialize the "other" drop-down menu.
function PoliteWhisper_OtherInit()
		local Item;
		Item         = UIDropDownMenu_CreateInfo();
		Item.func    = PoliteWhisper_OnOtherDrop;
		Item.text    = PW_OTHER_LABEL;
		Item.value   = 0;
		Item.checked = true;
		UIDropDownMenu_AddButton(Item);

		Item.text    = PW_WHO_DO_WE_HAVE;
		Item.value   = 1;
		Item.checked = false;
		UIDropDownMenu_AddButton(Item);

		Item.text    = PW_SLOT_LABEL;
		Item.value   = 2;
		UIDropDownMenu_AddButton(Item);

		Item.text    = PW_PARTY_LABEL;
		Item.value   = 3;
		UIDropDownMenu_AddButton(Item);

		Item.text    = PW_REMEMBER_QUEST;
		Item.value   = 4;
		UIDropDownMenu_AddButton(Item);

		-- Is there a saved question?
		if (PoliteWhisper_SavedQuest ~= nil)
		then
				Item.text    = string.sub(PoliteWhisper_SavedQuest, 1, 20) .. "...";
				Item.value   = 5;
				UIDropDownMenu_AddButton(Item);
		end
end

-- Handles an "other" selection.
function PoliteWhisper_OnOtherDrop()
		if (this.value == 1)
		then
				PoliteWhisper_TellParty();
		elseif (this.value == 2)
		then
				PoliteWhisper_SendFinal(PoliteWhisper_Options.SLOT_FULL);
		elseif (this.value == 3)
		then
				PoliteWhisper_SendFinal(PoliteWhisper_Options.PARTY_FULL);
		elseif (this.value == 4)
		then
				if (PoliteWhisper_Talk:GetText() == "")
				then
						PoliteWhisper_MsgHack(PW_NO_QUEST);
						return;
				end
				PoliteWhisper_SavedQuest = PoliteWhisper_Talk:GetText();
		elseif (this.value == 5)
		then
				PoliteWhisper_SendAndLog(PoliteWhisper_SavedQuest);
		end
end

-- Send and log a whisper.
function PoliteWhisper_SendAndLog(Text, User)
		-- Did they specify a user?
		if (not User) then User = PoliteWhisper_ChatUser; end
		
		--Replace tags in the whisper with the actual content
		Text = PoliteWhisper_ReplaceTags(Text,User);

		-- Log the message.
		PoliteWhisper_LogMsg(string.format(PW_OUTGOING_WHISPER, User, Text), User);

		-- Whisper user.
		SendChatMessage(Text, "WHISPER", nil, User);
--DEFAULT_CHAT_FRAME:AddMessage(PoliteWhisper_ReplaceTags("player '$P', level '$L', class '$C', destination '$D', role '$R', leader '$B', group makeup '$G', members in group '$N'",User));
--DEFAULT_CHAT_FRAME:AddMessage(Text);
end



-- Put text string in chat log and wrap text if it's long.
function PoliteWhisper_LogMsg(Msg, User)
		local Log, i, S, C;

		-- Add the message to their log.
		while (Msg ~= "")
		do
				i = PoliteWhisper_WrapLen;
				while (true)
				do
						C = string.sub(Msg, i, i);
						if ((C == " ") or (C == "-") or (C == "")) then break; end
						i = i - 1;
						if (i == 0) then
								i = PoliteWhisper_WrapLen;
								break;
						end
				end
				S = string.sub(Msg, 1, i);
				Msg = string.sub(Msg, string.len(S) + 1);

				Log = PoliteWhisper_Users[User].Log;
				table.insert(Log, S)
				table.remove(Log, 1);
		end

		-- Update display.
		PoliteWhisper_UpdateLog();
end

-- Update the party list.
function PoliteWhisper_PartyUpdate()
		local i, User, Ctrls;

		-- Loop through each slot.
		for i, Ctrls in ipairs(PoliteWhisper_PartyCtrls)
		do
				-- Do we have a party member to put in the slot?
				if (i <= GetNumPartyMembers())
				then
						-- Yes, display them.
						Ctrls.Sad:Show();
						User = UnitName("party" .. i);
						Ctrls.User:SetText(User);
						Ctrls.Notes:Show();

						-- Is the user on our do not invite list?
						if (PoliteWhisper_DoNotInvite[User])
						then
								-- Yes, let's simplify it.  Disable stuff and show the notes.
								if (PoliteWhisper_DoNotInvite[User] == true)
								then
										Ctrls.Notes:SetText("");
								else
										Ctrls.Notes:SetText(PoliteWhisper_DoNotInvite[User]);
								end
								Ctrls.Rating:Hide();
								Ctrls.Medium:Hide();
								Ctrls.Happy:Hide();
						else
								-- Just a regular group member.  Show stuff.
								Ctrls.Rating:Show();
								Ctrls.Medium:Show();
								Ctrls.Happy:Show();

								-- Have we created a table for them yet?
								if (not PoliteWhisper_Friends[User])
								then
										PoliteWhisper_Friends[User] = {Rating=0, Notes=""};
								end
								Ctrls.Rating:SetValue(PoliteWhisper_Friends[User].Rating);
								Ctrls.Notes:SetText(PoliteWhisper_Friends[User].Notes);
						end
				else
						-- No,  blank space at the end of the list.  Hide it.
						Ctrls.User:SetText("");
						Ctrls.Notes:Hide();
						Ctrls.Rating:Hide();
						Ctrls.Sad:Hide();
						Ctrls.Medium:Hide();
						Ctrls.Happy:Hide();
				end
		end

		PoliteWhisper_Loading = false;
end

-- User changed something in the party pane, so grab everything.
function PoliteWhisper_UpdateParty()
		local i, User, Ctrls;

		-- This routine must not be executed at start up or saved values get reset.
		if (PoliteWhisper_Loading) then return; end

		-- Loop through each slot.
		for i, Ctrls in ipairs(PoliteWhisper_PartyCtrls)
		do
				-- Do we have a party member to put in the slot?
				if (i <= GetNumPartyMembers())
				then
						User = UnitName("party" .. i);

						-- On our do not invite list?
						if (PoliteWhisper_DoNotInvite[User])
						then
								PoliteWhisper_DoNotInvite[User] = Ctrls.Notes:GetText();
						else
								PoliteWhisper_Friends[User].Rating = Ctrls.Rating:GetValue();
								PoliteWhisper_Friends[User].Notes  = Ctrls.Notes:GetText();
						end
				end
		end
		PoliteWhisper_UpdateIgnore();
end

-- User is changing how we sort.
function PoliteWhisper_SortOn(Column)
		-- Clicking on the same column as before will toggle order, otherwise it
		-- will change the sort by and revert the sort order to true (default).
		if (PoliteWhisper_Options.SortOn == Column)
		then
				PoliteWhisper_Options.SortOrder = not PoliteWhisper_Options.SortOrder;
		else
				PoliteWhisper_Options.SortOrder = true;
		end
		PoliteWhisper_Options.SortOn = Column;

		-- Update the display
		PoliteWhisper_UpdateList();
end

-- Sort comparison function.
function PoliteWhisper_SortComp(A, B)
		local X, Y;
		X = PoliteWhisper_Users[A];
		Y = PoliteWhisper_Users[B];

		-- Sanity check
		if (not X) then message(A); end
		if (not Y) then message(B); end

		-- Regardless of the type of sort chosen, we will always sort chat before
		-- ask before re-ask!
		if (X.Status ~= Y.Status)
		then
				if (X.Status == PW_CHAT) then return true; end
				if (Y.Status == PW_REASK) then return true; end
				return false;
		end

		-- The status is equal, so now we must look at the sort order the user has
		-- selected.  This can be either "Name", "Class" , or "Level".
		if (PoliteWhisper_Options.SortOn == "Name")
		then
				-- Sort by name
				return (A < B) ~= (not PoliteWhisper_Options.SortOrder);
		elseif (PoliteWhisper_Options.SortOn == "Level")
		then
				-- Sort by level, then class, then name
				if (X.Level == Y.Level)
				then
						if (X.Class == Y.Class)
						then
								return (A < B) ~= (not PoliteWhisper_Options.SortOrder);
						else
								return (X.Class < Y.Class) ~=
										(not PoliteWhisper_Options.SortOrder);
						end
				else
						return (X.Level < Y.Level) ==
								(not PoliteWhisper_Options.SortOrder);
				end
		else
				-- Sort by class, then level, then name
				if (X.Class == Y.Class)
				then
						if (X.Level == Y.Level)
						then
								return (A < B) ~= (not PoliteWhisper_Options.SortOrder);
						else
								return (X.Level < Y.Level) ==
										(not PoliteWhisper_Options.SortOrder);
						end
				else
						return (X.Class < Y.Class) ~=
								(not PoliteWhisper_Options.SortOrder);
				end
		end
end
