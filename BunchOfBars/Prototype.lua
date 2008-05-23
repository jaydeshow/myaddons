

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BunchOfBarsPrototype")

L:RegisterTranslations("enUS", function() return {
} end)



----------------------------------
--      Local Declaration      --
----------------------------------

local pairs = pairs
local UnitExists = UnitExists



----------------------------------
--      Module Declaration      --
----------------------------------

BunchOfBars.modulePrototype.core = BunchOfBars

BunchOfBars.modulePrototype.defaultDB = {}



----------------------------------
--      Module Functions        --
----------------------------------

function BunchOfBars.modulePrototype:OnCreate(frame)
	return nil -- do nothing
end

function BunchOfBars.modulePrototype:OnUpdate(frame, mypart)
	-- do nothing
end

function BunchOfBars.modulePrototype:OnInactive(frame, mypart)
	-- do nothing
end


function BunchOfBars.modulePrototype:UpdateAll()
	for _,frame in pairs(self.core.frames) do
		if UnitExists(frame.unit) then
			self:OnUpdate(frame, frame.parts[self.name])
		end
	end
end


function BunchOfBars.modulePrototype:UpdateAllWith(func)
	if type(func) == "function" then
		for _,frame in pairs(self.core.frames) do
			if UnitExists(frame.unit) then
				func(frame, frame.parts[self.name])
			end
		end
	else -- let's just assume it's a strign as it should be
		for _,frame in pairs(self.core.frames) do
			if UnitExists(frame.unit) then
				self[func](self, frame, frame.parts[self.name])
			end
		end
	end
end


function BunchOfBars.modulePrototype:UpdateUnits(units)
	for unit in pairs(units) do
        if self.core.frames[unit] and UnitExists(unit) then
			self:OnUpdate(self.core.frames[unit], self.core.frames[unit].parts[self.name])
		end
    end
end


function BunchOfBars.modulePrototype:UpdateUnit(unit)
	-- maybe use for ... and UnitIsUnit
	if self.core.frames[unit] and UnitExists(unit) then
		self:OnUpdate(self.core.frames[unit], self.core.frames[unit].parts[self.name])
	end
end
