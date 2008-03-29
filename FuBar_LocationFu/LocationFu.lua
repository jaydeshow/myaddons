local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("FuBar_LocationFu")
local Tourist = Rock("LibTourist-3.0")
local Tablet = AceLibrary("Tablet-2.0")
local Jostle = Rock("LibJostle-3.0")
local bs = Rock("LibBabble-Spell-3.0"):GetLookupTable()

LocationFu = Rock:NewAddon("LocationFu", "LibFuBarPlugin-3.0", "LibRockEvent-1.0", "LibRockTimer-1.0", "LibRockConfig-1.0", "LibRockDB-1.0")

LocationFu.version = "3.0" .. string.sub("$Revision: 59195 $", 12, -3)
LocationFu.date = string.sub("$Date: 2008-01-23 04:20:16 -0500 (Wed, 23 Jan 2008) $", 8, 17)
LocationFu:SetFuBarOption('hasIcon', true)
LocationFu:SetFuBarOption('iconPath', [[Interface\AddOns\FuBar_LocationFu\icon]])
LocationFu:SetFuBarOption('defaultPosition', "RIGHT")
LocationFu:SetFuBarOption('tooltipType', "Tablet-2.0")
LocationFu:SetFuBarOption('clickableTooltip', true)

local table_insert = table.insert

LocationFu:SetDatabase("LocationFuDB")
LocationFu:SetDatabaseDefaults("profile", {
	showCoords = true,
	showSubZoneName = true,
	showZoneName = false,
	showRecZones = true,
	showLevelRange = true,
})

function LocationFu:IsShowingCoords()
	return self.db.profile.showCoords
end

function LocationFu:ToggleShowingCoords()
	self.db.profile.showCoords = not self.db.profile.showCoords
	self:UpdateFuBarText()
end

function LocationFu:IsShowingZoneName()
	return self.db.profile.showZoneName
end

function LocationFu:ToggleShowingZoneName()
	self.db.profile.showZoneName = not self.db.profile.showZoneName
	self:UpdateFuBarText()
end

function LocationFu:IsShowingSubZoneName()
	return self.db.profile.showSubZoneName
end

function LocationFu:ToggleShowingSubZoneName()
	self.db.profile.showSubZoneName = not self.db.profile.showSubZoneName
	self:UpdateFuBarText()
end

function LocationFu:IsShowingLevelRange()
	return self.db.profile.showLevelRange
end

function LocationFu:ToggleShowingLevelRange()
	self.db.profile.showLevelRange = not self.db.profile.showLevelRange
	self:UpdateFuBarText()
end

function LocationFu:IsShowingMinimapBar()
	return self.db.profile.minimapBar
end

function LocationFu:ToggleShowingMinimapBar()
	self.db.profile.minimapBar = not self.db.profile.minimapBar
	if not self.db.profile.minimapBar then
		MinimapBorderTop:Hide()
		MinimapToggleButton:Hide()
		MinimapZoneTextButton:Hide()
	else
		MinimapBorderTop:Show()
		MinimapToggleButton:Show()
		MinimapZoneTextButton:Show()
	end
	Jostle:Refresh()
end

function LocationFu:IsShowingRecommendedZones()
	return self.db.profile.showRecZones
end

function LocationFu:ToggleShowingRecommendedZones()
	self.db.profile.showRecZones = not self.db.profile.showRecZones
	self:UpdateFuBarTooltip()
end

function LocationFu:OnInitialize()
	local options = {
		name = "FuBar_LocationFu",
		desc = self.notes,
		type = 'group',
		args = {
			map = {
				order = 97,
				type = 'execute',
				name = L["Open world map"],
				desc = L["Open world map"],
				func = function() ToggleWorldMap() end
			},
			atlas = {
				order = 98,
				type = 'execute',
				name = L["Open Atlas"],
				desc = L["Open Atlas"],
				func = function() Atlas_Toggle() end,
				hidden = function() return not Atlas_Toggle end,
			},
			["-blank-"] = {
				order = 99,
				type = 'header',
			},
			coords = {
				type = 'toggle',
				name = L["Show coordinates"],
				desc = L["Toggle the coordinates in the text of this plugin"],
				get = "IsShowingCoords",
				set = "ToggleShowingCoords",
			},
			subzone = {
				type = 'toggle',
				name = L["Show subzone name"],
				desc = L["Show subzone name"],
				get = "IsShowingSubZoneName",
				set = "ToggleShowingSubZoneName",
			},
			zone = {
				type = 'toggle',
				name = L["Show zone name"],
				desc = L["Toggle the zone name in the text of this plugin"],
				get = "IsShowingZoneName",
				set = "ToggleShowingZoneName",
			},
			levelRange = {
				type = 'toggle',
				name = L["Show level range"],
				desc = L["Show level range"],
				get = "IsShowingLevelRange",
				set = "ToggleShowingLevelRange",
			},
			minimapBar = {
				type = 'toggle',
				name = L["Show minimap bar"],
				desc = L["Show the bar above the minimap that tells the location and allows you to close minimap"],
				get = "IsShowingMinimapBar",
				set = "ToggleShowingMinimapBar",
			},
			recommend = {
				type = 'toggle',
				name = L["Show recommended zones"],
				desc = L["Show your recommended zones in the tooltip"],
				get = "IsShowingRecommendedZones",
				set = "ToggleShowingRecommendedZones",
			},
		}
	}
	LocationFu:SetConfigTable(options)
end

function LocationFu:OnEnable()
	self:AddEventListener({ZONE_CHANGED=true, ZONE_CHANGED_INDOORS=true, MINIMAP_ZONE_CHANGED=true}, "UpdateFuBarPlugin", 1)
	self:AddEventListener("ZONE_CHANGED_NEW_AREA", "ScheduleUpdater")
	self:AddEventListener("PLAYER_ENTERING_WORLD", "ScheduleUpdater")

	if not self:IsShowingMinimapBar() then
		self.db.profile.minimapBar = not self.db.profile.minimapBar
		self:ToggleShowingMinimapBar()
	end

	self:ScheduleUpdater()
end

function LocationFu:OnDisable()
	if not self:IsShowingMinimapBar() then
		self:ToggleShowingMinimapBar()
		self.db.profile.minimapBar = not self.db.profile.minimapBar
	end
end

function LocationFu:ScheduleUpdater()
	self:UpdateFuBarPlugin()
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType ~= "pvp" then -- instance
		self:AddRepeatingTimer("LocationFu", 60, "UpdateFuBarPlugin")
	else
		self:AddRepeatingTimer("LocationFu", 1, "UpdateFuBarPlugin")
	end
end

local subZoneText, zoneText, pvpType, isArena, _

local t = {}
function LocationFu:OnUpdateFuBarText()
	subZoneText = GetSubZoneText()
	zoneText = GetRealZoneText()
	if subZoneText == "" then
		subZoneText = GetZoneText()
	end
	pvpType,_,isArena = GetZonePVPInfo()
	if Atlas_Toggle and Tourist:IsInstance(zoneText) then
		self:SetFuBarIcon([[Interface\AddOns\Atlas\Images\AtlasIcon]])
	else
		self:SetFuBarIcon([[Interface\AddOns\FuBar_LocationFu\icon]])
	end
	
	local r, g, b = Tourist:GetFactionColor(zoneText)
	if self:IsShowingZoneName() and self:IsShowingSubZoneName() then
		if subZoneText == zoneText then
			table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, zoneText))
		else
			table_insert(t, string.format("|cff%02x%02x%02x%s: %s|r", r*255, g*255, b*255, zoneText, subZoneText))
		end
	elseif self:IsShowingZoneName() then
		table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, zoneText))
	elseif self:IsShowingSubZoneName() then
		table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, subZoneText))
	end
	if self:IsShowingCoords() then
		local x, y = GetPlayerMapPosition("player")
		if x ~= 0 and y ~= 0 then
			table_insert(t, string.format("|cff%02x%02x%02x(%.0f, %.0f)|r", r*255, g*255, b*255, x * 100, y * 100))
		end
	end
	if self:IsShowingLevelRange() then
		local low, high = Tourist:GetLevel(zoneText)
		if low > 0 and high > 0 then
			local r, g, b = Tourist:GetLevelColor(zoneText)
			table_insert(t, string.format("|cff%02x%02x%02x[%d-%d]|r", r*255, g*255, b*255, low, high))
		end
	end
	self:SetFuBarText(table.concat(t, " "))
	for k in pairs(t) do
		t[k] = nil
	end
end

local currentPath = nil
function LocationFu:SetCurrentPath(zone)
	if currentPath == zone then
		currentPath = nil
	else
		currentPath = zone
	end
	self:UpdateFuBarTooltip()
end

function LocationFu:OnUpdateFuBarTooltip()
	local cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	cat:AddLine(
		'text', L["Zone:"],
		'text2', zoneText
	)
	
	if subZoneText ~= zoneText then
		cat:AddLine(
			'text', L["Subzone:"],
			'text2', subZoneText
		)
	end
	
	local text
	local r, g, b = 1, 1, 0
	if isArena == true or pvpType == "arena" then
		text = L["Arena"]
		g, b = 0.1, 0.1
	elseif pvpType == "friendly" then
		text = L["Friendly"]
		r, b = 0.1, 0.1
	elseif pvpType == "contested" then
		text = L["Contested"]
		g = 0.7
	elseif pvpType == "hostile" then
		text = L["Hostile"]
		g, b = 0.1, 0.1
	elseif pvpType == "sanctuary" then
		text = L["Sanctuary"]
		r, g, b = 0.41, 0.8, 0.94
	elseif not pvpType then
		text = UNKNOWN or "?"
	end
	
	cat:AddLine(
		'text', L["Status:"],
		'text2', text,
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	local x, y = GetPlayerMapPosition("player")
	if x > 0 and y > 0 then
		cat:AddLine(
			'text', L["Coordinates:"],
			'text2', string.format("%.0f, %.0f", x*100, y*100)
		)
	end
	
	local continent = Tourist:GetContinent(zoneText)
	cat:AddLine(
		'text', L["Continent:"],
		'text2', continent,
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	)
	
	local low, high = Tourist:GetLevel(zoneText)
	if low >= 1 and high >= 1 then
		local r, g, b = Tourist:GetLevelColor(zoneText)
		cat:AddLine(
			'text', L["Level range:"],
			'text2', low == high and low or string.format("%d-%d", low, high),
			'text2R', r,
			'text2G', g,
			'text2B', b
		)
	end
	
	local minFish = Tourist:GetFishingLevel(zoneText)
	if minFish then
		local numSkills = GetNumSkillLines()
		local r,g,b = 1,0,0
		for i=1, numSkills do
			local _, skillName, skillRank
			skillName, _, _, skillRank, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(i)
			if skillName == bs["Fishing"] and minFish < skillRank then
				r,g,b = 0,1,0
			end
		end
		cat:AddLine(
			'text', L["Fishing:"],
			'text2', minFish,
			'text2R', r,
			'text2G', g,
			'text2B', b
		)
	end
	
	if Tourist:DoesZoneHaveInstances(zoneText) then
		cat = Tablet:AddCategory(
			'columns', 2,
			'text', L["Instances"],
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0
		)
		
		for instance in Tourist:IterateZoneInstances(zoneText) do
			local low, high = Tourist:GetLevel(instance)
			local r, g, b = Tourist:GetLevelColor(instance)
			cat:AddLine(
				'text', instance,
				'text2', low == high and low or string.format("%d-%d", low, high),
				'text2R', r,
				'text2G', g,
				'text2B', b
			)
		end
	end
	if self:IsShowingRecommendedZones() then
		cat = Tablet:AddCategory(
			'columns', 3,
			'text', L["Recommended zones"]
		)
		
		for zone in Tourist:IterateRecommendedZones() do
			local low, high = Tourist:GetLevel(zone)
			local r1, g1, b1 = Tourist:GetFactionColor(zone)
			local r2, g2, b2 = Tourist:GetLevelColor(zone)
			local zContinent = Tourist:GetContinent(zone)
			cat:AddLine(
				'text', zone,
				'textR', r1,
				'textG', g1,
				'textB', b1,
				'text2', low == high and low or string.format("%d-%d", low, high),
				'text2R', r2,
				'text2G', g2,
				'text2B', b2,
				'text3', zContinent,
				'text3R', continent == zContinent and 0 or 1,
				'text3G', 1,
				'text3B', 0,
				'arg1', self,
				'func', "SetCurrentPath",
				'arg2', zone
			)
			if zone == currentPath then
				local c = cat:AddCategory(
					'text', string.format(L["    Walk path from %s to %s:"], zoneText, zone),
					'hideBlankLine', true
				)
				local found = false
				for z in Tourist:IteratePath(zoneText, zone) do
					found = true
					local low, high = Tourist:GetLevel(z)
					local r1, g1, b1 = Tourist:GetFactionColor(z)
					local r2, g2, b2 = Tourist:GetLevelColor(z)
					local zContinent = Tourist:GetContinent(z)
					c:AddLine(
						'text', "    " .. (z == currentPath and z or z .. " ->"),
						'textR', r1,
						'textG', g1,
						'textB', b1,
						'text2', low == 0 and "" or low == high and low or string.format("%d-%d", low, high),
						'text2R', r2,
						'text2G', g2,
						'text2B', b2,
						'text3', zContinent == UNKNOWN and "" or zContinent,
						'text3R', continent == zContinent and 0 or 1,
						'text3G', 1,
						'text3B', 0
					)
				end
				if not found then
					c:AddLine(
						'text', L["    No path found"]
					)
				end
			end
		end
		
		if Tourist:HasRecommendedInstances() then
			cat = Tablet:AddCategory(
				'columns', 4,
				'text', L["Recommended instances"],
				'child_text3R', 1,
				'child_text3G', 1,
				'child_text3B', 0,
				'child_text4R', 1,
				'child_text4G', 1,
				'child_text4B', 0
			)
			
			for instance in Tourist:IterateRecommendedInstances() do
				local low, high = Tourist:GetLevel(instance)
				local r1, g1, b1 = Tourist:GetFactionColor(instance)
				local r2, g2, b2 = Tourist:GetLevelColor(instance)
				local groupSize = Tourist:GetInstanceGroupSize(instance)
				cat:AddLine(
					'text', instance,
					'textR', r1,
					'textG', g1,
					'textB', b1,
					'text2', low == high and low or string.format("%d-%d", low, high),
					'text2R', r2,
					'text2G', g2,
					'text2B', b2,
					'text3', groupSize > 0 and string.format(L["%d-man"], groupSize) or "",
					'text4', Tourist:GetInstanceZone(instance),
					'arg1', self,
					'func', "SetCurrentPath",
					'arg2', instance
				)
				
				if instance == currentPath then
					local c = cat:AddCategory(
						'text', string.format(L["    Walk path from %s to %s:"], zoneText, instance),
						'hideBlankLine', true
					)
					local found = false
					for z in Tourist:IteratePath(zoneText, instance) do
						found = true
						local low, high = Tourist:GetLevel(z)
						local r1, g1, b1 = Tourist:GetFactionColor(z)
						local r2, g2, b2 = Tourist:GetLevelColor(z)
						local zContinent = Tourist:GetContinent(z)
						c:AddLine(
							'text', "    " .. (z == currentPath and z or z .. " ->"),
							'textR', r1,
							'textG', g1,
							'textB', b1,
							'text2', low == 0 and "" or low == high and low or string.format("%d-%d", low, high),
							'text2R', r2,
							'text2G', g2,
							'text2B', b2,
							'text3', zContinent == UNKNOWN and "" or zContinent,
							'text3R', continent == zContinent and 0 or 1,
							'text3G', 1,
							'text3B', 0
						)
					end
					if not found then
						c:AddLine(
							'text', L["    No path found"]
						)
					end
				end
			end
		end
	end
	
	if Atlas_Toggle then
		if Tourist:IsInstance(zoneText) then
			Tablet:SetHint(L["Atlas-hint"] .. L[". "] .. L["Shift-hint"] .. L[". "] .. L["Ctrl-hint"] .. L["."])
		else
			Tablet:SetHint(L["Standard-hint"] .. L[". "] .. L["Shift-hint"] .. L[". "] .. L["Ctrl-Atlas-hint"] .. L["."])
		end
	else
		Tablet:SetHint(L["Standard-hint"] .. L[". "] .. L["Shift-hint"] .. L["."])
	end
end

function LocationFu:OnFuBarClick()
	if IsShiftKeyDown() then
		if ChatFrameEditBox:IsVisible() then
			local x, y = GetPlayerMapPosition("player")
			local message
			local coords = string.format("%.0f, %.0f", x * 100, y * 100)
			if not self:IsShowingZoneName() and not self:IsShowingSubZoneName() then
				message = coords
			elseif self:IsShowingZoneName() and self:IsShowingSubZoneName() then
				if zoneText ~= subZoneText then
					message = string.format("%s: %s (%s)", zoneText, subZoneText, coords)
				else
					message = string.format("%s (%s)", zoneText, coords)
				end
			elseif self:IsShowingZoneName() then
				message = string.format("%s (%s)", zoneText, coords)
			elseif self:IsShowingSubZoneName() then
				message = string.format("%s (%s)", subZoneText, coords)
			end
			ChatFrameEditBox:Insert(message)
		end
	elseif Atlas_Toggle then
		if IsControlKeyDown() then
			if not Tourist:IsInstance(zoneText) then
				Atlas_Toggle()
			else
				ToggleWorldMap()
			end
		else
			if Tourist:IsInstance(zoneText) then
				Atlas_Toggle()
			else
				ToggleWorldMap()
			end
		end
	else
		ToggleWorldMap()
	end
end

