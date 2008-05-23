local CQI = Cartographer_QuestInfo
local L = AceLibrary("AceLocale-2.2"):new("Cartographer_QuestInfo")

local Quixote = LibStub("LibQuixote-2.0")

-------------------------------------------------------------------

local OBJ_CACHE = {}
local OBJ_CACHE_HIT = 0

-------------------------------------------------------------------

function CQI:FindObjectiveData(questid, objective)
	if not Cartographer:IsModuleActive(self) or type(objective) ~= "string" then return end

	local uid = Quixote:GetQuestById(questid)
	local q_key = string.format("%d`%s", uid, objective)
	if OBJ_CACHE[q_key] then return OBJ_CACHE[q_key] end

	local q = self:GetQuest(uid)
	if not q or not q.objs then return end

	for _, obj in pairs(q.objs) do
		if obj.title == objective and obj.npcs then
			if OBJ_CACHE_HIT >= 100 then
				-- try to keep cache small
				local next_key = next(OBJ_CACHE)
				OBJ_CACHE[next_key] = nil
			else
				OBJ_CACHE_HIT = OBJ_CACHE_HIT + 1
			end
			local data = {
				quest = q.title_full,
				obj = obj,
			}
			OBJ_CACHE[q_key] = data
			return data
		end
	end
end

