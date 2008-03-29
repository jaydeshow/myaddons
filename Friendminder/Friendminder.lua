--libraries
FM = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1")

--saved variables
FM:RegisterDB("FriendminderDB")
FM:RegisterDefaults('realm', {
    friends = {}
})

--slash commands
FM:RegisterChatCommand({"/friendminder", "/fm"}, {
    type = 'group',
    args = {
        sync = {
            type = 'execute',
            name = 'sync',
            desc = 'performs sync action.',
            func = "Sync"
        },
        delete = {
            type = 'text',
            name = 'delete',
            usage = "<name>",
            desc = 'delete friend from datafile.',
            get = false,
            set = function(name)
                if name then
                    FM:Delete(name)
                end
            end
        },
    },
})

--startup function
function FM:OnEnable()
    self:RegisterEvent("FRIENDLIST_UPDATE", "OnFriendListUpdate")
    FM:GetFriends()
    self:Print("Addon Loaded Successfully!")
end

--event handlers
function FM:OnFriendListUpdate()
    FM:GetFriends()
end

--get friends list
function FM:GetFriends()
    local numFriends = GetNumFriends()
    if numFriends == 0 then return; end
    for i = 1, numFriends, 1 do
        local name = GetFriendInfo(i)
        if not self.db.realm.friends[name] then
            self.db.realm.friends[name] = true
        end
    end  
end

--clicked the button
function FM:OnClick()
    FM:Sync()
end

--perform sync
function FM:Sync()
    local numFriends = GetNumFriends()
    for tKey, tValue in pairs(self.db.realm.friends) do
		local match = false
        for i = 1, numFriends, 1 do
            local name = GetFriendInfo(i)
            if name == tKey then
                match = true
            end
        end
        if not match then
            AddFriend(tKey)
        end
    end
end

--perform delete
function FM:Delete(name)
    for tKey, tValue in pairs(self.db.realm.friends) do
		local found = false
        if name == tKey then
            self.db.realm.friends[tKey] = nil
			found = true
		end
	end
	if found == true then
            self:Print("Deleted " .. name .. " from datafile.")
    else
        self:Print(name .. " not found.")
    end
end

--tooltip
function FM:OnEnter()
    
end
function FM:OnLeave()
    
end