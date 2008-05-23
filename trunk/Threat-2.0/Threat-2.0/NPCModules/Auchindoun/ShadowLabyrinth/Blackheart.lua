local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = tonumber(("$Revision: 70586 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()
	local ThreatLib = _G.ThreatLib
	local BLACKHEART_ID = 18667
	ThreatLib:Debug("Registering Blackheart ID...")
	ThreatLib:GetModule("NPCCore"):RegisterModule(BLACKHEART_ID, function(Blackheart)
		Blackheart:RegisterTranslation("enUS", function() return {
			["Time for fun!"] = "Time for fun!",
		} end)

		Blackheart:RegisterTranslation("deDE", function() return {
			["Time for fun!"] = "Zeit für Spass!",
		} end)

		Blackheart:RegisterTranslation("frFR", function() return {
			["Time for fun!"] = "Rions un peu !",
		} end)

		Blackheart:RegisterTranslation("koKR", function() return {
			["Time for fun!"] = "재미를 볼 시간이다!",
		} end)

		Blackheart:RegisterTranslation("zhTW", function() return {
			["Time for fun!"] = "玩樂的時間到了!",
		} end)

		Blackheart:RegisterTranslation("zhCN", function() return {
			["Time for fun!"] = "有好玩的啦！",
		} end)
		
		local blackheartPhase = Blackheart:GetTranslation("Time for fun!")
		Blackheart:UnregisterTranslations()

		function Blackheart:Init()
			self:RegisterCombatant(BLACKHEART_ID, true)

			self:RegisterChatEvent("yell", blackheartPhase, self.phaseTransition)
			
			-- Register all known War Stomp IDs; with testing we can cut this down to 1 spell.
			local func = function(self, mobGUID, targetGUID, spellId) 
				self.ModifyThreatOnTargetGUID(mobGUID, targetGUID, 0.5, 0)
			end
			self:RegisterSpellHandler(
				"SPELL_DAMAGE",
				func,
				45, 11876, 11593, 16727, 16740, 24375, 25188, 27758, 28125, 28725, 31408, 31480, 31755, 33707, 35238, 36835, 38632, 38750, 38911, 39313, 40936, 41534
			)
		end
		
		function Blackheart:phaseTransition()
			self:WipeRaidThreatOnMob(BLACKHEART_ID)
		end
	end)
end
