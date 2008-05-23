--[[
Name: SpecialEvents-Mount-2.0
Revision: $Revision: 59594 $
Author: Tekkub Stoutwrithe (tekkub@gmail.com)
Website: http://www.wowace.com/
Description: Special events for mounting
Dependencies: AceLibrary, AceEvent-2.0, Gratuity-2.0, SpecialEvents-Aura-2.0
]]


local vmajor, vminor = "SpecialEvents-Mount-2.0", "$Revision: 59594 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0.") end
if not AceLibrary:HasInstance("Gratuity-2.0") then error(vmajor .. " requires Gratuity-2.0.") end
if not AceLibrary:HasInstance("SpecialEvents-Aura-2.0") then error(vmajor .. " requires SpecialEvents-Aura-2.0.") end

local lib = {}
AceLibrary("AceEvent-2.0"):embed(lib)

local gratuity = AceLibrary("Gratuity-2.0")

local mountSpeed, flightSpeed
do
	local locale = GetLocale()
	
	mountSpeed = locale == "deDE" and "Erh\195\182\ht Tempo um (.+)%%"
		or locale == "koKR" and "이동 속도 ([60|100]+)%%만큼 증가"
		or locale == "frFR" and "Augmente la vitesse de (%d+)%%"
		or locale == "esES" and "Aumenta la velocidad en un (.+)%%"
		or locale == "zhCN" and "^速度提高(.+)%%"
		or locale == "zhTW" and "速度提高(.+)%%"
		or "Increases speed by (.+)%%"

	flightSpeed = locale == "esES" and "Aumenta la velocidad de vuelo en un (.+)%%"
		or locale == "deDE" and "Fluggeschwindigkeit um (.+)%% erh\195\182ht."
		or locale == "frFR" and "Augmente la vitesse de vol de (.+)%%"
		or locale == "koKR" and "비행 속도 (.+)%%만큼 증가"
		or locale == "zhCN" and "^飞行速度提高(.+)%%"
		or locale == "zhTW" and "飛行速度提高(.+)%%"
		or "Increases flight speed by (.+)%%"
end

-- Activate a new instance of this library
function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.vars = oldLib.vars
		oldLib:UnregisterAllEvents()
	else
		self.vars = {}
		for buff, i in AceLibrary("SpecialEvents-Aura-2.0"):BuffIter("player") do
			self:SpecialEvents_PlayerBuffGained(buff, i)
		end
	end

	self:RegisterEvent("SpecialEvents_PlayerBuffGained")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost")

	if oldDeactivate then oldDeactivate(oldLib) end
end


function lib:SpecialEvents_PlayerBuffGained(buff, i)
	if UnitOnTaxi("player") or self.vars.mounted then return end

	gratuity:SetPlayerBuff(GetPlayerBuff(i, "HELPFUL"))
	local txt = gratuity:GetLine(2)
	if not txt then return end
	local speed = txt:match(mountSpeed)

	if speed then
		self.vars.mounted, self.vars.mountspeed, self.vars.flying = buff, speed, nil
		self:TriggerEvent("SpecialEvents_Mounted", buff, speed, i)
	else
		speed = txt:match(flightSpeed)
		if speed and not self.vars.mounted then
			self.vars.mounted, self.vars.mountspeed, self.vars.flying = buff, speed, true
			self:TriggerEvent("SpecialEvents_Mounted", buff, speed, i, true)
		end
	end
end


function lib:SpecialEvents_PlayerBuffLost(buff)
	if buff == self.vars.mounted then
		self:TriggerEvent("SpecialEvents_Dismounted", buff, self.vars.mountspeed, self.vars.flying)
		self.vars.mounted, self.vars.mountspeed, self.vars.flying = nil, nil, nil
	end
end


-----------------------------
--      Query Methods      --
-----------------------------

function lib:PlayerMounted()
	return self.vars.mounted, self.vars.mountspeed
end

function lib:PlayerFlying()
	return self.vars.flying and 1 or nil
end


--------------------------------
--      Load this bitch!      --
--------------------------------
AceLibrary:Register(lib, vmajor, vminor, activate)

