--[[
****************************************************************************************
AckisRecipeList Dataminer
$Date: 2008-07-23 17:20:25 -0400 (Wed, 23 Jul 2008) $
$Rev: 79009 $

Author: Ackis on Illidan US Horde

****************************************************************************************

Require socket.  You can get it from: http://luaforge.net/projects/luasocket/

This is not to be run in WoW.  This is a script which will populate the recipe database from online 
database web-sites like WoWDB.com

****************************************************************************************
]]--
--http://ace.pastey.net/92285
http = require("socket.http")

local RecipeList = nil

-- Parses the Recipe List and creates the lua code for Ackis Recipe List
local function ParseRecipeList()

	local RecipeDBPattern = "self:addTradeSkillSpell(%s, %s, %s) -- %s"

	for i in pairs(RecipeList) do
		print(string.format(RecipeDBPattern,i,RecipeList[i]["Name"],RecipeList[i]["Flags"],RecipeList[i]["Skill Level"]))
	end

end

local function GetAlchemyInfo()

	local professionurl = "http://www.wowdb.com/search.aspx?browse=6.11.171"
	local spellurl = "http://www.wowdb.com/spell.aspx?id="
	local webpagetext = http.request(professionurl)
	local patternmatch = "var cg_json_1=(.+);"
	local recipematch = "{(.-)}"
	local alchemymatch = "id:(%d+),name:'(.+)',school:(%d+),category:(%d+),skillup:(.+),skill:(.+),produces:(.+),rarity:(%d+),reagents:(.+),learned:(%d+)"
	local trainermatch = "id:(%d+),type:(%d+),react:(.+),name:'(.+)',desc:'(.+)',minlevel:(%d+),locs:(.+)"

	-- Get all the entries from the page into a string of just entries.
	local recipestrings = string.sub(string.match(webpagetext,patternmatch),2,-2)

	RecipeList = {}

	-- Parse all the entries, spliting them up
	for x in string.gmatch(recipestrings, recipematch) do

		local spellid,spellname,school,category,skillup,skill,itemid,rarity,reagents,learned = string.match(x, alchemymatch)

		-- If we've got a match
		if (spellid) then

			-- Add the information obtained into the array
			RecipeList[spellid] = {}
			RecipeList[spellid]["Name"] = spellname
			RecipeList[spellid]["Item"]	= itemid
			RecipeList[spellid]["Skill Level"] = learned
			RecipeList[spellid]["Flags"] = ""

			local tempurl = spellurl .. spellid
			local spellpage = http.request(tempurl)
			
			-- Get all the entries from the page into a string of just entries.
			local trainerstrings = string.sub(string.match(spellpage,patternmatch),2,-2)

			for y in string.gmatch(trainerstrings, recipematch) do
				print(y)
				local npcid, npctype, npcreact, npcname, npcdesc, npclevel, npclocs = string.match(y, trainermatch)
				if npcid then print(npcname) end

			end

		end
		--[[
		-- Not a normal recipe, could be a header or speciality
		-- I don't care about this code so commenting it out, may use it in the future
		if (spellid == nil) then

				local alchemyheadermatch = "id:(%d+),name:'(.+)',rank:'(%a+)',school:(%d+),category:(%d+),skill:(.+)"
				spellid,spellname,rank,school,category,skill = string.match(x, alchemyheadermatch)

			-- Not a normal recipe or header
			if (spellid == nil) then

				local alchemyspecialitymatch = "id:(%d+),name:'(.+)',school:(%d+),category:(%d+),skill:(.+)"
				spellid,spellname,school,category,skill = string.match(x, alchemyspecialitymatch)
				rank = ""

			end

			if (spellid ~= nil) then
				--print(string.format(RecipeDB,spellid,"",spellname))
			end
		else
			print(string.format(RecipeDB,spellid,learned,spellname))
		end
		]]--
	end

end

do

	GetAlchemyInfo()
	--ParseRecipeList()

end
