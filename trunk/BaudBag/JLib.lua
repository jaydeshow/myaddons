JPACK_STEP=0;--0,not started, 1,start_save_load ,2 start stack,3,stack over 
JPACK_STARTED=1
JPACK_DEPOSITING=2
JPACK_DRAWING=3
JPACK_STACKING=4
JPACK_STACK_OVER=5
JPACK_SORTING=6
JPACK_PACKING=7
JPACK_STOPPED=0

JPACK_DEBUG=false;
if table.getn == nil then
	local fun, err = loadstring("return function(tb) return #tb end")
	table.getn = fun()
end 

function print(msg,r,g,b)
	if (r == nil or g == nil or b == nil) then
		r = 0.36;
		g = 0.74;
		b = 0.74;
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b)
end

function debug(msg)
	if(JPACK_DEBUG)then
		print(msg)
	end
end

function IndexOfTable(t,v)
	for i=1,table.getn(t) do
		if(v==t[i])then
			return i;
		end
	end
	return 0;
end

--继承
function Extend(newType,baseType)
	setmetatable(newType, baseType)
	baseType.__index = baseType
end

--[[
JFrame

f=JFrame:new()
function f:init()
end
function f:OnEvent()
end
]]--

-- look up for `k' in list of tables 'plist'
local function search (k, plist)
	local i=1;
	print("search "..k);
	--for i=1, table.getn(plist) do
	while(plist[i] ~= nil)do
		local v = plist[i][k] -- try 'i'-th superclass
		if v then print("found");return v end
		i = i+1;
	end
end
function createClass (parents)
	local c = {} -- new class
	-- class will search for each method in the list ofits
	-- parents (`arg' is the list of parents)
	setmetatable(c, {__index = function (t, k)
			return search(k, parents)
		end})
	-- prepare `c' to be the metatable of its instances
	c.__index = c
	-- define a new constructor for this new class
	function c:new (o)
	o = o or {}
	setmetatable(o, c)
	return o
	end
	-- return new class
	return c
end


JFrame={}

function JFrame:new(name,_type,parent)
	local o=CreateFrame("Frame",name,UIParent)
	--[[
	setmetatable(o, {__index = function (t, k)
			return search(k, {o,JFrame})
		end})
	o.__index = o;
	]]--
	setmetatable(o, self)
	self.__index = self
	o:RegisterEvent("PLAYER_LOGIN")
	o:SetScript("OnEvent",self.OnJEvent)
	return o;
end

function JFrame:OnJEvent()
	if event == "PLAYER_LOGIN" then
		self:Init()
	else
		self:OnEvent()
		--[[
	elseif event == "PLAYER_ENTERING_WORLD" then
		GameTooltip:SetScale(zTipSaves.Scale)
	elseif event == "UPDATE_FACTION" then
		self:UpdatePlayerFaction()
		]]--
	end
end
