local L = AceLibrary("AceLocale-2.2"):new("FuBar_FactionsFu")

local opts = {
	type = "group", args = {
		["settings_text"] = {
			type = "group", name = L["Text"], desc = L["Text Settings"], args = {
				["show_name"] = {
					type = "toggle", name = L["Show Name"], desc = L["Toggles display of watched faction's name"],
					get = function() return FuBar_FactionsFu.db.profile.text.show_name end,
					set = function(v) FuBar_FactionsFu.db.profile.text.show_name = v; FuBar_FactionsFu:UpdateText() end,
					order = 1,
				},
				["show_standing"] = {
					type = "toggle", name = L["Show Standing"], desc = L["Toggles display of watched faction's current standing"],
					get = function() return FuBar_FactionsFu.db.profile.text.show_standing end,
					set = function(v) FuBar_FactionsFu.db.profile.text.show_standing = v; FuBar_FactionsFu:UpdateText() end,
					order = 2,
				},
				["show_progress"] = {
					type = "toggle", name = L["Show Progress"], desc = L["Toggles display of watched faction's progress toward next standing"],
					get = function() return FuBar_FactionsFu.db.profile.text.show_progress end,
					set = function(v) FuBar_FactionsFu.db.profile.text.show_progress = v; FuBar_FactionsFu:UpdateText() end,
					order = 3,
				},
				["show_percent"] = {
					type = "toggle", name = L["Show Progress (in percent)"], desc = L["Toggles display of watched faction's progress toward next standing (in percent)"],
					get = function() return FuBar_FactionsFu.db.profile.text.show_percent end,
					set = function(v) FuBar_FactionsFu.db.profile.text.show_percent = v; FuBar_FactionsFu:UpdateText() end,
					order = 4,
				},
			}, order = 1,
		},
		["settings_color"] = {
			type = "group", name = L["Color"], desc = L["Color Settings"], args = {
				["name"] = {
					type = "text", name = L["Name"], desc = L["Sets color of the faction name"],
					get = function() return FuBar_FactionsFu.db.profile.color.name end,
					set = function(v) FuBar_FactionsFu.db.profile.color.name = v; FuBar_FactionsFu:UpdateText(); FuBar_FactionsFu:UpdateTooltip() end,
					validate = {["NONE"] = L["None"], ["ATWAR"] = L["War Condition"]},
					order = 1,
				},
				["standing"] = {
					type = "text", name = L["standing"], desc = L["Sets color of the faction standing"],
					get = function() return FuBar_FactionsFu.db.profile.color.standing end,
					set = function(v) FuBar_FactionsFu.db.profile.color.standing = v; FuBar_FactionsFu:UpdateText(); FuBar_FactionsFu:UpdateTooltip() end,
					validate = {["NONE"] = L["None"], ["DEFAULT"] = L["Blizzard's Default"], ["INC"] = L["Incremental"]},
					order = 2,
				},
				["reputation"] = {
					type = "text", name = L["Reputation"], desc = L["Sets color of the faction reputation"],
					get = function() return FuBar_FactionsFu.db.profile.color.reputation end,
					set = function(v) FuBar_FactionsFu.db.profile.color.reputation = v; FuBar_FactionsFu:UpdateText(); FuBar_FactionsFu:UpdateTooltip() end,
					validate = {["NONE"] = L["None"], ["DEFAULT"] = L["Blizzard's Default"], ["INC"] = L["Incremental"]},
					order = 3,
				},
			}, order = 2,
		},
		["settings_other"] = {
			type = "group", name = L["Other"], desc = L["Other Settings"], args = {
				["autozone"] = {
					type = "toggle", name = L["Auto-Zone"], desc = L["Toggles automatical adjustment of watched faction on zone change"],
					get = function() return FuBar_FactionsFu.db.profile.other.autozone end,
					set = function(v) FuBar_FactionsFu.db.profile.other.autozone = v end,
					order = 1,
				},
--[[				["autogain"] = {
					type = "toggle", name = L["Auto-Gain"], desc = L["Toggles automatical adjustment of watched faction on faction gain"],
					get = function() return FuBar_FactionsFu.db.profile.other.autogain end,
					set = function(v) FuBar_FactionsFu.db.profile.other.autogain = v end,
					order = 2,
				}, ]]
			}, order = 3,
		},
	}
}

FuBar_FactionsFu:RegisterChatCommand({"/factionsfu"}, opts)
FuBar_FactionsFu.OnMenuRequest = opts
