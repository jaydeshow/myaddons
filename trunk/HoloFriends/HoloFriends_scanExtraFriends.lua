HF_scanningExtras = false
HF_debug = false

local lastScan = 0
local whoCheckInterval = 5.1
local alreadyChecked = {}
local interceptWhoResults = 0
local queryingThisGuy
local HoloFriends_ScanExtraFriends_ChatFrame_MessageEventHandlerOrig = nil;

function HoloFriends_ScanExtraFriends()
   local list = HoloFriends_GetList()
   local checkThisGuy

   for k, entry in pairs(list) do
      local name = entry.name
      if (name ~= "0" and name ~= "1" and not entry.notify) then
         if (not alreadyChecked[name]) then
            alreadyChecked[name] = true
            checkThisGuy = name
            break
         end
      end
   end

   if (checkThisGuy) then
      HF_d("Checking on extra friend: "..checkThisGuy)
      SetWhoToUI(0)
      SendWho('n-"'..checkThisGuy..'"')
      interceptWhoResults = GetTime()
      queryingThisGuy = checkThisGuy
   else
      -- we've checked everybody, stop checking.
      HF_p(HOLOFRIENDS_SCAN_DONEMSG)
      HF_scanningExtras = false
      alreadyChecked = {}
      interceptWhoResults = 0
      queryingThisGuy = nil
      HoloFriendsScanExtrasButton:SetText(HOLOFRIENDS_SCAN)
   end
end

function HoloFriends_ScanExtraFriends_OnLoad()
    -- hook ChatFrame_MessageEventHandler
    -- see http://www.wowwiki.com/HOWTO:_Hook_chat_frames_to_modify_or_suppress_messages
    HoloFriends_ScanExtraFriends_ChatFrame_MessageEventHandlerOrig = ChatFrame_MessageEventHandler
    ChatFrame_MessageEventHandler = HoloFriends_ScanExtraFriends_ChatFrame_MessageEventHandler
end

function HoloFriends_ScanExtraFriends_OnEvent(event)
   HF_d(event)
   if (event == "PLAYER_LOGIN") then

   end
end     

function HoloFriends_ScanExtraFriends_OnUpdate()
   if (not HF_scanningExtras) then
      return
   end
   local now = GetTime()
   if (now > (lastScan + whoCheckInterval)) then
      lastScan = now
      HoloFriends_ScanExtraFriends()
   end
end

function HoloFriends_ScanExtraFriends_ChatFrame_MessageEventHandler(event)
   if (event == "CHAT_MSG_SYSTEM") then
      if (GetTime() < (interceptWhoResults + 3)) then
         if (string.match(arg1, HOLOFRIENDS_WHORESULTFORMAT)) then
            HF_d("Intercepted who result: " .. arg1)
            return true
         elseif (string.match(arg1, HOLOFRIENDS_WHOTOTALFORMAT)) then
            HF_d("Intercepted who total: "..arg1)
            local numWho = GetNumWhoResults()
            if (numWho == 0) then
               local list = HoloFriends_GetList()
               playerIndex = HoloFriendsFuncs_ContainsPlayer(list, queryingThisGuy)
               if (playerIndex) then
                  list[playerIndex].connected = false
               end
            end
            interceptWhoResults = 0
            return true
         end
      end
   end
   return HoloFriends_ScanExtraFriends_ChatFrame_MessageEventHandlerOrig(event)
end

function HoloFriends_ScanExtraFriends_ClickScan()
   if (not HF_scanningExtras) then
      -- start scanning
      local list = HoloFriends_GetList()
      local extraCount = 0
      for k,entry in pairs(list) do
         if (not HoloFriendsFuncs_IsGroup(list, k) and (not entry.notify)) then
            extraCount = extraCount + 1
         end
      end
      local timeToFinish = whoCheckInterval * (extraCount - 1)
      HF_p(format(HOLOFRIENDS_SCAN_STARTMSG, extraCount, timeToFinish));
      HF_scanningExtras = true
      HoloFriendsScanExtrasButton:SetText(HOLOFRIENDS_SCANSTOP)
   else
      -- stop
      HF_p(HOLOFRIENDS_SCAN_STOPMSG)
      HF_scanningExtras = false
      HoloFriendsScanExtrasButton:SetText(HOLOFRIENDS_SCAN)
   end
end


function HF_chat(msg, r, g, b)
   if (not r) then
      r = .8
      g = .3
      b = 1
   end
   DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

function HF_p(msg)
   HF_chat("## HoloFriends: "..msg)
end

function HF_d(msg)
   if (HF_debug) then
      HF_chat("### HoloFriends: "..HF_nonil(msg), .7, .2, .9)
   end
end

function HF_nonil(str)
   if (not str) then
      str = ""
   end
   return str
end

