

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBarsCore")

L:RegisterTranslations("enUS", function() return {
	["Visual Options"] = true,
	["Options to control the looks of BunchOfBars."] = true,

	["Module Options"] = true,
	["Options for all enabled modules."] = true,

	["Module Padding"] = true,
	["Padding between module parts."] = true,

	["Position"] = true,
	["The position of this module's frame on the unit frame."] = true,

	["|cffffff00Click|r to lock/unlock unit frames."] = true
}end)
--------------------
--   汉化：iCat   --
--------------------
L:RegisterTranslations("zhCN", function() return {
	["Visual Options"] = "界面选项",
	["Options to control the looks of BunchOfBars."] = "BunchOfBars显示界面的相关设置",

	["Module Options"] = "模块选项",
	["Options for all enabled modules."] = "全部模块的相关设置",

	["Module Padding"] = "模块间距",
	["Padding between module parts."] = "模块相互之间的距离",

	["Position"] = "位置",
	["The position of this module's frame on the unit frame."] = "模块窗体的位置",

	["|cffffff00Click|r to lock/unlock unit frames."] = "|cffffff00点击|r 锁定/解锁 显示窗体"
}end)
--#end

L:RegisterTranslations("koKR", function() return {
	["Visual Options"] = "설정",
	["Options to control the looks of BunchOfBars."] = "프레임 설정",

	["Module Options"] = "모듈 설정",
	["Options for all enabled modules."] = "각 모듈의 설정을 봅니다.",

	["Module Padding"] = "간격",
	["Padding between module parts."] = "각 모듈간 간격을 설정합니다.",

	["Position"] = "위치",
	["The position of this module's frame on the unit frame."] = "각 모듈의 위치를 설정합니다.",

	["|cffffff00Click|r to lock/unlock unit frames."] = "|cffffff00클릭|r하면 프레임을 고정/비고정 합니다."
}end)



----------------------------------
--      Local Declaration      --
----------------------------------



----------------------------------
--      Module Declaration      --
----------------------------------

BunchOfBars = AceLibrary("AceAddon-2.0"):new(
	"AceModuleCore-2.0",
	"AceConsole-2.0",
	"AceEvent-2.0",
	"AceDB-2.0",

	"FuBarPlugin-2.0"
)

BunchOfBars:SetModuleMixins("AceEvent-2.0")

BunchOfBars.revision = tonumber(("$Revision: 53645 $"):match("%d+"))

BunchOfBars.options = {
	type = "group",
	handler = BunchOfBars,
	args = {
		visual = {
			type     = "group",
			name     = L["Visual Options"],
			desc     = L["Options to control the looks of BunchOfBars."],
			disabled = function() return InCombatLockdown() end,
			args     = { }
		},
		module = {
			type = "group",
			name = L["Module Options"],
			desc = L["Options for all enabled modules."],
			args = {
				padding = {
					type  = "range",
					name  = L["Module Padding"],
					desc  = L["Padding between module parts."],
					min   = 0,
					max   = 15,
					step  = 1,
					get   = "GetSetPadding", -- defined in Layout.lua
					set   = "GetSetPadding",
					order = 1
				},

				header2 = { type = "header", name = " ", order = 2 }
			}
		}
	}
}

BunchOfBars.defaults = { }


-- FuBar settings
BunchOfBars:Inject({
	hasIcon                = "Interface\\Icons\\Ability_Druid_TreeofLife",
	hasNoColor             = true,
	defaultMinimapPosition = 60,
	cannotDetachTooltip	   = true,
	hideWithoutStandby     = true,
	blizzardTooltip        = true,
	hasNoText              = true,
	independentProfile	   = true,
	OnMenuRequest          = BunchOfBars.options
})



----------------------------------
--      Module Functions        --
----------------------------------

function BunchOfBars:OnInitialize()
	self:RegisterDB("BunchOfBarsDB")
	self:RegisterDefaults("profile", self.defaults)

	self:RegisterChatCommand({"/bob", "/bunchofbars"}, self.options)
end


function BunchOfBars:OnEnable(first)
	self:HideShowParty()

	ClickCastFrames = ClickCastFrames or {}
	self.frames = {}

	self:RegisterModules()
	self:UpdateLayoutOrder()

	self:ScheduleEvent(self.CreateMaster, 4, self)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "ForceUpdate")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "ForceUpdate")


	for _,module in BunchOfBars:IterateModules() do
		if module.revision > self.revision then
			self.revision = module.revision
		end
	end

	self.version = "r"..self.revision
end


function BunchOfBars:OnClick()
	BunchOfBars.db.profile.visual.locked = not BunchOfBars.db.profile.visual.locked

	self:UpdateTooltip()
end


function BunchOfBars:OnTooltipUpdate()
	GameTooltip:AddLine("BunchOfBars ")
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(LOCKED..":", (BunchOfBars.db.profile.visual.locked and YES or NO), 1, 1, 0, 1, 1, 1) -- LOCKED, YES and NO are defined and translated somewher in blizz code
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L["|cffffff00Click|r to lock/unlock unit frames."], 0.2, 1, 0.2)
end


function BunchOfBars:RegisterModules()
	for name,module in self:IterateModules() do
		if not module.db then
			self:RegisterDefaults(name, "profile", module.defaultDB)
			module.db = self:AcquireDBNamespace(name)
		end

		if module.options or module.db.profile.position then
			self.options.args.module.args[name] = {
				type    = "group",
				handler = module,
				name    = module.options and module.options.name or name,
				desc    = string.format("Options for %s.", module.options and module.options.name or name),
				args    = module.options and module.options.args or {}
			}
		end

		if module.db.profile.position then
			self.options.args.module.args[name].args.position = { -- Nice.
				type = "range",
				name = L["Position"],
				desc = L["The position of this module's frame on the unit frame."],
				min  = 1,
				max  = 10,
				step = 1,
				get  = function() return module.db.profile.position end,
				set  = function(v)
					if module.db.profile.position ~= v then
						module.db.profile.position = v
						BunchOfBars:UpdateLayoutOrder()
						BunchOfBars:UpdateLayouts()
					end
				end
			}
		end

		self:ToggleModuleActive(module, true)
	end
end
