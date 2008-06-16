--[[
****************************************************************************************

ARLColour.lua

Colouring functions for ARL

$Date: 2008-06-16 01:13:51 -0400 (Mon, 16 Jun 2008) $
$Rev: 76784 $

Code adopted from Crayon library

****************************************************************************************
]]--


local addon = AckisRecipeList

--[[

	Colour constants

]]--

local RED       = "ff0000"
local ORANGE    = "ff7f00"
local YELLOW    = "ffff00"
local GREEN     = "00ff00"
local WHITE     = "ffffff"
local COPPER    = "eda55f"
local SILVER    = "c7c7cf"
local GOLD      = "ffd700"
local PURPLE    = "9980CC"
local BLUE	   = "0000ff"
local CYAN	   = "00ffff"
local BLACK	   = "000000"

--[[

	Text colourization functions

]]--

function addon:RGBtoHEX(r,g,b)
	return string.format("%2x%2x%2x", r*255, g*255, b*255)
end


-- Changes any string of text to the specified hex colour
function addon:Colourize(hexColour, text)

	return "|cff" .. tostring(hexColour or 'ffffff') .. tostring(text) .. "|r"

end

-- Converts text to Red
function addon:Red(text)
	return self:Colourize(RED, text)
end

-- Converts text to Orange
function addon:Orange(text)
	return self:Colourize(ORANGE, text)
end

-- Converts text to Yellow
function addon:Yellow(text)
	return self:Colourize(YELLOW, text)
end

-- Converts text to Green
function addon:Green(text)
	return self:Colourize(GREEN, text)
end

-- Converts text to White
function addon:White(text)
	return self:Colourize(WHITE, text)
end

-- Converts text to Copper
function addon:Copper(text)
	return self:Colourize(COPPER, text)
end

-- Converts text to Silver
function addon:Silver(text)
	return self:Colourize(SILVER, text)
end

-- Converts text to Gold
function addon:Gold(text)
	return self:Colourize(GOLD, text)
end

-- Converts text to Purple
function addon:Purple(text)
	return self:Colourize(PURPLE, text)
end

-- Converts text to Blue
function addon:Blue(text)
	return self:Colourize(BLUE, text)
end

-- Converts text to Cyan
function addon:Cyan(text)
	return self:Colourize(CYAN, text)
end

-- Converts text to Black
function addon:Black(text)
	return self:Colourize(BLACK, text)
end
