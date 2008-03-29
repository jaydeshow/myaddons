-- options we expose to the players
local options = { 
    type='group',
    args = {
        keyword = {
            type = 'text',
            name = 'keyword',
            desc = 'Keyword someone can whisper for an invite',
            usage = "<Keyword to send invite>",
            get = 'GetInviteKeyword',
            set = 'SetInviteKeyword',
        },
        active = {
            type = 'toggle',
            name = 'active',
            desc = 'Whether or not this mod is enabled',
            get = 'GetInviteEnabled',
            set = 'SetInviteEnabled',
        },
    },
}

-- setup our object
RaidInviteHelper = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")
RaidInviteHelper:RegisterChatCommand("/raidinvitehelper", "/rih", options)

-- setup defaults
RaidInviteHelper:RegisterDB("RaidInviteHelperDB", "RaidInviteHelperDBPC")
RaidInviteHelper:RegisterDefaults("profile", {
    keyword = "invite",
    enabled = true,
})

function RaidInviteHelper:OnInitialize()
    -- nothing to do in the initialize... do I even need to declare an
    -- empty function?  not sure...
end

function RaidInviteHelper:OnEnable()
    -- now setup our events
    self:RegisterEvent("CHAT_MSG_WHISPER");
    self:RegisterEvent("InviteUnit");
end

function RaidInviteHelper:OnDisable()
    -- addon disabled, our events are automatically unregistered
end

function RaidInviteHelper:CHAT_MSG_WHISPER(message, player)
    -- bail if we're not active (perhaps setting 'active' to false should
    -- unregister the event?)
    if not self.db.profile.active then return end

    -- only if they give us the keyword exactly...
    if string.lower(message) == string.lower(self.db.profile.keyword) then
        -- raid conversion if necessary
        if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 4 then
            -- must convert to raid, and then invite this guy in a few seconds to
            -- prevent the problem when the user is invited to a group, it turns
            -- into a raid, and they can't join (thanks to oRA2 for this code)
            ConvertToRaid()
            self:ScheduleEvent("InviteUnit", 3, player)
        elseif GetNumRaidMembers() == 40 then
            -- we're full, sorry
            -- FIXME: make an option for 'max raid size'?
            -- FIXME: send whispers to players when they don't get an invite
        else
            -- immediate invite, GO!
            InviteUnit(player)
        end
    end
end

function RaidInviteHelper:InviteUnit(unit)
    -- this processes for a delayed invite
    InviteUnit(unit)
end

function RaidInviteHelper:GetInviteKeyword()
    return self.db.profile.keyword
end

function RaidInviteHelper:SetInviteKeyword(newValue)
    self.db.profile.keyword = newValue
end

function RaidInviteHelper:GetInviteEnabled()
    return self.db.profile.active
end

function RaidInviteHelper:SetInviteEnabled(newValue)
    self.db.profile.active = newValue
end