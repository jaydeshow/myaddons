function CritSound_OnLoad()
    this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end

function CritSound_OnEvent(event,...)
	local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...
	local amount, school, resisted, blocked, absorbed, critical, glancing, crushing, missType, enviromentalType
	if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE) then
		-- 技能、法术。
		if (eventType == "SPELL_DAMAGE") then
			spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if critical then
				PlaySoundFile("Interface\\AddOns\\CritSound\\CriticalDamage.mp3");
			end
		-- 伤害护盾，如闪电盾。
		elseif (eventType == "DAMAGE_SHIELD") then
			spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if critical then
				PlaySoundFile("Interface\\AddOns\\CritSound\\Soulshatter.mp3");
			end
		-- 和近战攻击相关。
		elseif (eventType == "SWING_DAMAGE") then
			amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if critical then
				PlaySoundFile("Interface\\AddOns\\CritSound\\Swing.wav");
			end
		-- 和远程攻击相关，如猎人的弓弩射击或术士（法师、牧师）的魔杖攻击。
		elseif (eventType == "RANGE_DAMAGE") then
			spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if critical then
				PlaySoundFile("Interface\\AddOns\\CritSound\\Soulshatter.mp3");
			end
		-- 治疗法术。
		elseif (eventType == "SPELL_HEAL") then
			spellId, spellName, spellSchool, amount, critical = select(9, ...)
			if critical then
				PlaySoundFile("Interface\\AddOns\\CritSound\\CritHeal.mp3");
			end
		else
		return;
		end
	else
		return;
	end
end
