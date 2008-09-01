--[[
	cargExplorer
]]

-- This hook is needed to prevent all the map revealing addons from delivering wrong data
-- I don't like it, but every of these addons gave the original function another name :(
local origGetNumMapOverlays = GetNumMapOverlays

function GetNumMapOverlays(...)
	return origGetNumMapOverlays(...)
end

-- Now we can start with the code
cargExplorer = CreateFrame("Button", "cargExplorer", WorldMapFrame)

local GAME_LOCALE = GetLocale()
local GetMapZones = GetMapZones
local GetMapContinents = GetMapContinents
local GetCurrentMapContinent = GetCurrentMapContinent
local GetCurrentMapZone = GetCurrentMapZone

local B = LibStub("LibBabble-Zone-3.0") 
local BR = B:GetReverseLookupTable()

if(not ceData) then ceData = {} end

local zoneNr = {}
local contNr = #{GetMapContinents()}
for i=1, contNr do
	zoneNr[i] = #{GetMapZones(i)}
end

-- Helper functions
local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end
	
	local num = select('#', ...) / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

-- Helper functions
local function zoneName(cont, zone)
	return select(zone, GetMapZones(cont))
end

local function contName(cont)
	return select(cont, GetMapContinents())
end

local function IDToEntry(contid, zoneid)
	return BR[contName(contid)], (zoneid and BR[zoneName(contid, zoneid)])
end

local function zoneTotal(cont, zone)
	cont, zone = IDToEntry(cont, zone)
	return (cargExplorer.totaldata[cont] and cargExplorer.totaldata[cont][zone])
end

local function saveData(cont, zone, disc)
	cont, zone = IDToEntry(cont, zone)
	if(not ceData[cont]) then ceData[cont] = {} end
	ceData[cont][zone] = disc
end

local function getData(cont, zone)
	cont, zone = IDToEntry(cont, zone)
	if(not ceData[cont]) then ceData[cont] = {} end
	return ceData[cont][zone]
end

-- Core functions
function cargExplorer:new()
	self:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", -10, -3)
	self:SetWidth(100)
	self:SetHeight(20)
	self:EnableMouse(true)
	self:SetMovable(false)

	self.text = self:CreateFontString(nil, "OVERLAY")
	self.text:SetFontObject(GameFontNormal)
	self.text:SetShadowOffset(1,-1)
	self.text:SetPoint("TOPLEFT")
	self:RegisterForClicks("anyUp")

	self:SetScript("OnEnter", self.enter)
	self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self:SetScript("OnClick", self.StartAutoCycle)
	hooksecurefunc("WorldMapFrame_Update", self.GetOverlayInfo)
end
	
local formattext, perc, r, g, b
function cargExplorer:GetOverlayInfo()
	self = cargExplorer
	local contid = GetCurrentMapContinent()
	local mapid = GetCurrentMapZone()

	-- Check current Zone
	if(not ceData[contid]) then ceData[contid] = {} end

	if(mapid > 0) then
		local mapFileName, textureHeight = GetMapInfo()
		if not mapFileName then return end
		local nrDiscovered = 0
		local pathPrefix = "Interface\\WorldMap\\"..mapFileName.."\\"
		local pathLen = strlen(pathPrefix) + 1

		for i=1, self:GetNumMapOverlays() do
			local texName, texWidth, texHeight, offsetX, offsetY = GetMapOverlayInfo(i)
			texName = strsub(texName, pathLen)
			local texID = texWidth + texHeight * 2^10 + offsetX * 2^20 + offsetY * 2^30
			if texID ~= 0 and texID ~= 131200 and texName ~= "" and strlower(texName) ~= "pixelfix" then
				nrDiscovered = nrDiscovered +1
			end
		end
		saveData(contid, mapid, nrDiscovered)
	end
	
	-- Generate Display
	if(not self.AutoCycle) then
		local perc = self:GetAllInfo(contid, mapid)
		r, g, b = ColorGradient(perc, 1,0,0, 1,1,0, 0,1,0)
		formattext = format("|c00%02x%02x%02x%.0f%%|r", r*255, g*255, b*255, perc*100)
		self.text:SetText(format(ERR_ZONE_EXPLORED, formattext))
	end
end

function cargExplorer:GetNumMapOverlays()
	if(origGetNumMapOverlays()~=0) then
		return origGetNumMapOverlays()
	elseif(Cartographer and Cartographer:IsModuleActive(Cartographer_Foglight)) then
		return Cartographer_Foglight.hooks.GetNumMapOverlays()
	elseif(Mozz_GetNumMapOverlays) then
		return Mozz_GetNumMapOverlays()
	else
		return GetNumMapOverlays()
	end
end

function cargExplorer:enter()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")

	local contid = GetCurrentMapContinent()
	local mapid = GetCurrentMapZone()
	
	local perc, mzones, mnr = self:GetAllInfo(contid, mapid)
	if(mnr and mnr > 0) then
		GameTooltip:AddLine(format("%s: |c00ff5050%d|r", ADDON_MISSING, mnr))
		table.sort(mzones, function(a, b) return a.missing > b.missing end)
		local mzone
		for i, mzone in pairs(mzones) do
			if(i > 10) then break end
			GameTooltip:AddDoubleLine(zoneName(mzone.cont, mzone.map), mzone.missing, 1,1,1, 1,0.3,0.3)
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("\231\130\185\229\135\187\230\155\180\230\150\176\229\133\168\233\131\168\229\156\176\229\155\190\230\149\176\230\141\174")
		GameTooltip:AddLine("\229\143\175\232\131\189\233\128\160\230\136\144\229\129\156\230\173\162\229\147\141\229\186\148\228\184\128\228\184\139!")
		GameTooltip:Show()
	end
end

function cargExplorer:StartAutoCycle()
	if(self.AutoCycle) then return nil end
	self.AutoCycle = true
	for c=1, contNr do
		for z=1, zoneNr[c] do
			SetMapZoom(c, z)
		end
	end
	self.AutoCycle = nil
	SetMapZoom(-1)
	collectgarbage("collect")
end

function cargExplorer:GetAllInfo(contid, mapid)
	local perc, maptype, zonedisc, zonetotal
	local stats = { disc = 0, total = 0, miss = {} }

	if(mapid < 1 and contid > 0) then
		for mapid=1, (zoneNr[contid] or 0) do
			self:GetZoneInfo(contid, mapid, stats)
		end
	elseif(contid == 0) then
		for contid=1, 2 do
			for mapid=1, (zoneNr[contid] or 0) do
				self:GetZoneInfo(contid, mapid, stats)
			end
		end
	elseif(contid == -1) then
		for contid=1, 3 do
			for mapid=1, (zoneNr[contid] or 0) do
				self:GetZoneInfo(contid, mapid, stats)
			end
		end
	else
		self:GetZoneInfo(contid, mapid, stats)
	end
	if(stats.disc == 0 and stats.total == 0) then
		perc = 1
	else
		perc = stats.disc/stats.total
	end
	
	return perc, stats.miss, (stats.total - stats.disc)
end

function cargExplorer:GetZoneInfo(contid, mapid, stats)
	local disc = getData(contid, mapid) or 0
	local total = zoneTotal(contid, mapid) or 0
	if(total - disc > 0) then
		table.insert(stats.miss, { cont = contid, map = mapid, missing = (total-disc) })
	end
	stats.disc = stats.disc + disc
	stats.total = stats.total + total
end

cargExplorer.zoneNr = zoneNr
cargExplorer.zoneName = zoneName
cargExplorer.contName = contName
cargExplorer.zoneTotal = zoneTotal
cargExplorer.IDToEntry = IDToEntry
cargExplorer.saveData = saveData
cargExplorer.getData = getData
cargExplorer:new()