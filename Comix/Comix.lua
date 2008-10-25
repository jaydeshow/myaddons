local CombatLog_Object_IsA = CombatLog_Object_IsA

local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE



function Comix_OnLoad()

	-- Registering Events --
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
	this:RegisterEvent("PLAYER_AURAS_CHANGED")
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	this:RegisterEvent("PLAYER_AURAS_CHANGED")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	this:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
	this:RegisterEvent("CHAT_MSG_EMOTE")
	this:RegisterEvent("CHAT_MSG_YELL")
	this:RegisterEvent("UNIT_HEALTH")
	this:RegisterEvent("UNIT_SPELLCAST_SENT")
	this:RegisterEvent("RESURRECT_REQUEST")
	this:RegisterEvent("PLAYER_ALIVE")
	this:RegisterEvent("PLAYER_UNGHOST")
	this:RegisterEvent("PLAYER_DEAD")
	this:RegisterEvent("READY_CHECK")
	this:RegisterEvent("OnUpdate")
	this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Saying Hello --
	DEFAULT_CHAT_FRAME:AddMessage("Hello you there, this AddOn is enabled by default!",0,0,1);
  
-- Slash Commands --
	SlashCmdList["Comix"] = Comix_Command;
		SLASH_Comix1 = "/Comix";
		SLASH_Comix2 = "/comix";
		SLASH_Comix3 = "/动漫";
		SLASH_Comix4 = "/動漫";
	SlashCmdList["ComixJoke"] = Comix_BadJoke;
		SLASH_ComixJoke1 = "/badjoke";

	dontfireonalive = false;
	loaded = false;
	unghosted = false;
	
-- Setting variables --
	Comix_ShakeEnabled = false;
	Comix_ShakeDuration = 1;
	Comix_ShakeIntensity = 70;
	Comix_x_coord = 0;
	Comix_y_coord = 0;
	Comix_Max_Scale = 2;
	ComixCurrentFrameCt = 1;
	ComixCritCount = 0;
	ComixBuffCount = 0;
	ComixAniSpeed = 1;
	ComixMaxCrits = 3;
	ComixKillCount = 0;
	Comix_CritPercent = 100;
	Comix_CritGap = 0;
	Comix_FinishHimGap = 0.2;
	Comix_CurrentImage = nil;
	Comix_NightfallCt = 0;
	Comix_Frames = {};
	Comix_FramesScale = {}
	Comix_FramesVisibleTime = {}
	Comix_FramesStatus = {}
	Comix_textures = {};
	Comix_CritSoundsEnabled = true;
	Comix_CritHealsEnabled = true;
	Comix_SpecialsEnabled = true;
	Comix_KillCountEnabled = true;
	Comix_DeathSoundEnabled = true;
	ComixKillCountSoundPlayed = false;
	Comix_HuggedNotFound = false;
	Comix_AddOnEnabled = true;
	Comix_SoundEnabled = true;
	Comix_BS_Update = false;
	Comix_BSEnabled = true;
	Comix_DemoShoutEnabled = true;
	Comix_ZoneEnabled = true;
	Comix_FinishTarget = true;
	Comix_BamEnabled = false;
	Comix_ImagesEnabled = true;
	Comix_FinishhimEnabled = true;
	Comix_NightfallProcced = true;
	Comix_NightfallEnabled = true;
	Comix_NightfallAutoTarget = false;
	Comix_NightfallCounter = false;
	Comix_CritGapEnabled = false;
	Comix_OneHit = false;
	Comix_NightfallAnnounce = false;
	Comix_NightfallGotTarget = false;
	Comix_BsShortDuration = true;
	Comix_HealorDmg = true;
	Comix_PlayerClass = UnitClass("player")
	
	Comix_CritFlashEnabled = true;
	Comix_HealFlashEnabled = true;
	Comix_BSSounds = true;
	Comix_DSSounds = true;
	Comix_BounceSoundEnabled = true;
	Comix_JumpCount = 0;
	Comix_ResSoundEnabled = true;
	Comix_ReadySoundEnabled = true;
	
	Comix_AbilitySoundsEnabled = true;
	windfurycheck = false;
  
	forward = false;
	back = false;
	left = false;
	right = false;
  
  -- Hug Counter Variables --
	Comix_Hugs = {}
	Comix_Hugged = {}
	Comix_HugName = {}
	Comix_HugName[1] = UnitName("player")
	Comix_Hugs[1] = 0
	Comix_Hugged[1] = 0
	
	Comix_KillEmoteEnabled = false
	ComixEmoteChannel = "EMOTE"
	ComixEmoteRank = nil
	Comix_KillEmoteShowRank = true
	ComixKillEmotes = {};
	ComixKillEmotes[1] = "正在大杀特杀" 
	ComixKillEmotes[2] = "已经主宰比赛了！" 
	ComixKillEmotes[3] = "已经n人斩了！" 
	ComixKillEmotes[4] = "已经无人能挡！" 
	ComixKillEmotes[5] = "都杀得变态了！" 
	ComixKillEmotes[6] = "MMMMMonsterKILL！！！" 
	ComixKillEmotes[7] = "已经接近神了！" 
	ComixKillEmotes[8] = "已经超越神了！" 
	ComixKillEmotes[9] = "神都囧了！" 
	ComixKillEmotesRanks = {};
	ComixKillEmotesRanks[1] = "大杀特杀" 
	ComixKillEmotesRanks[2] = "主宰比赛" 
	ComixKillEmotesRanks[3] = "n人斩" 
	ComixKillEmotesRanks[4] = "无人能挡" 
	ComixKillEmotesRanks[5] = "变态杀戮" 
	ComixKillEmotesRanks[6] = "妖怪般的杀戮" 
	ComixKillEmotesRanks[7] = "接近神的杀戮" 
	ComixKillEmotesRanks[8] = "超越神的杀戮" 
	ComixKillEmotesRanks[9] = "囧神的杀戮" 
	
  
-- Calling functions to Create Frames and Load The Images/Sounds -- 
	Comix_CreateFrames(); 
	Comix_LoaddaShite();
	TimeSinceLastUpdate = 0;
	local gor = math.random(1,2)
	if gor == 1 then
		Comix_DongSound(ComixSpecialSounds,6);
	else
		Comix_DongSound(ComixSpecialSounds,19);
	end
	ComixDBkill = 0
	ComixTPkill = 0
	ComixLSTKLtime = 0
--	lastkilltime = 0
	ComixKSTime = GetTime()
	if ComixComboTime == nil then
		ComixComboTime = 10
	end
	Comix_SwingCritSilent = true
	ComixHitCount = 0
	Comix_CS_Update = nil
end

function startReadyCheck()

	if Comix_ReadySoundEnabled then
		Comix_DongSound(ComixReadySounds, math.random(1, ComixReadySoundsCt));
	end
end

hooksecurefunc("DoReadyCheck", startReadyCheck)

function PlayBounceSound()

	local boing = false;
	if forward or back or left or right then
		boing = true;
	end

	if IsMounted() then
		if not IsFlying() then
			if boing then
				Comix_JumpCount = Comix_JumpCount + 1;
			end
			if Comix_BounceSoundEnabled and boing then
				Comix_DongSound(ComixSpecialSounds, 8);
			end
		end
	else
			Comix_JumpCount = Comix_JumpCount + 1;
			if Comix_BounceSoundEnabled then
				Comix_DongSound(ComixSpecialSounds, 8);
			end
	end
	
end 

hooksecurefunc("JumpOrAscendStart", PlayBounceSound)

function forwardstart()
	forward = true;
end

hooksecurefunc("MoveForwardStart", forwardstart)

function forwardstop()
	forward = false;
end

hooksecurefunc("MoveForwardStop", forwardstop)

function backstart()
	back = true;
end

hooksecurefunc("MoveBackwardStart", backstart)

function backstop()
	back = false;
end

hooksecurefunc("MoveBackwardStop", backstop)

function leftstart()
	left = true;
end

hooksecurefunc("StrafeLeftStart", leftstart)

function leftstop()
	left = false;
end

hooksecurefunc("StrafeLeftStop", leftstop)

function rightstart()
	right = true;
end

hooksecurefunc("StrafeRightStart", rightstart)

function rightstop()
	right = false;
end

hooksecurefunc("StrafeRightStop", rightstop)


function Comix_OnEvent(event,...)

	if (Comix_AddOnEnabled) then
		local arg1 = select (9,...)
		--团队准备状态确认
		if event == "READY_CHECK" then
			if Comix_ReadySoundEnabled then
				Comix_DongSound(ComixReadySounds, math.random(1, ComixReadySoundsCt));
			end
		end
		if event == "UNIT_HEALTH" then
		-- finish him --
			if Comix_FinishhimEnabled then			
				if UnitIsFriend("player","target") == nil then
					if UnitHealth("target") ~= 0 and UnitHealth("target") > 0 then 
						local TargetHealth = UnitHealth("target")
						if TargetHealth < Comix_FinishHimGap then
							if Comix_FinishTarget then 
								Comix_DongSound(ComixSpecialSounds,12)
								Comix_FinishTarget = false
								Comix_OneHit = true;
								ComixHitCount = 0
							end
						end	
					end  
				end    
			end  
		end
		--选择特定目标时的音效,比如松饼人
		if event == "PLAYER_TARGET_CHANGED" then
			if UnitName("target") == getglobal("COMIX_BIGGLESWORTH") then
				Comix_DongSound(ComixSpecialSounds,5)
				DEFAULT_CHAT_FRAME:AddMessage("[Dr. Evil] yells: That makes me angry and when Dr. Evil gets angry Mr. Bigglesworth gets upset and when Mr. Bigglesworth gets upset...... PPL DIE!!!!!!!!11111oneoneoneoneeleveneleven",1,0,0)
				DEFAULT_CHAT_FRAME:AddMessage("[Venomia] yells: I COMMAND YOU!!! LEAVE THE CAT ALIVE OR YOU GET -50DKP!!!! (rly)",1,0,0)
			elseif UnitName("target") == getglobal("COMIX_REPAIRBOT") then
				Comix_DongSound(ComixSpecialSounds,7)
				DEFAULT_CHAT_FRAME:AddMessage("[Field Repair Bot 74A] says: All your base, r belong to us")
			elseif UnitName("target") == getglobal("COMIX_MUFFIN") then
				Comix_DongSound(ComixSpecialSounds, 10)
				DEFAULT_CHAT_FRAME:AddMessage("Do you know the Muffin Man???", 0,1,0)  
			end
			Comix_FinishTarget = true;
			ComixHitCount = nil;
			Comix_OneHit = false;
		end
		--Extraaaaa Life
		if event == "PLAYER_ALIVE" then

			if UnitIsDeadOrGhost("player") == nil then
				if dontfireonalive == false then
					if loaded then
						if not unghosted then
							if Comix_ResSoundEnabled then
								Comix_DongSound(ComixSpecialSounds, 18);
							end
						else
							unghosted = false;
						end
					else
						loaded = true;
					end
				else
					dontfireonalive = false;
				end
			end
		end
		--挂掉时的音效
		if event == "PLAYER_DEAD" then
			unghosted = false;
			--连续击杀被中止,发出表情
			if Comix_KillEmoteShowRank == true and ComixEmoteRank and ComixEmoteChannel then
				SendChatMessage(ComixEmoteRank.."被中止了，SHIT！",ComixEmoteChannel);
				ComixEmoteRank = nil;
			end
			  -- Oh poor guy ... you died ... noob :P --
		    if Comix_DeathSoundEnabled then
		      --if UnitIsDead("player") and strfind(arg1, getglobal("COMIX_YOUUP")) then
		        Comix_CallPic(ComixDeathImages[math.random(1, ComixDeathImagesCt)]);
				Comix_DongSound(ComixDeathSounds,math.random(1,ComixDeathSoundsCt))
		        ComixKillCount = 0;
		      --end
		    end
		end
  
		if event == "PLAYER_UNGHOST" then
			unghosted = true;  
		end
		--玩家复活你时的音效--
		if event == "RESURRECT_REQUEST" then
			unghosted = false;
			dontfireonalive = true;
			if Comix_ResSoundEnabled then
				Comix_DongSound(ComixSpecialSounds, 18);
			end
		end
  
		-- 切换区域时音效 --
		if event == "ZONE_CHANGED_NEW_AREA" then
		local ininstance, instancetype = IsInInstance();
			if ininstance then
				if instancetype == "party" or instancetype == "raid" then
					if Comix_SpecialsEnabled then
						DEFAULT_CHAT_FRAME:AddMessage("[Dr. Evil] yells: Ladies and Gentlemen, Welcome to my Underground Lair!",1,0,0)
						Comix_DongSound(ComixSpecialSounds, 16); -- if specials are on we want a different sound when entering an instance, whether zone sounds are on or not --
					else
						if Comix_ZoneEnabled then
							Comix_DongSound(ComixZoneSounds,math.random(1,ComixZoneSoundsCt))
						end
					end
				else
					if Comix_ZoneEnabled then
						Comix_DongSound(ComixZoneSounds,math.random(1,ComixZoneSoundsCt))
					end
				end
			else
				if Comix_ZoneEnabled then
					Comix_DongSound(ComixZoneSounds,math.random(1,ComixZoneSoundsCt))
				end
			end
		end
  
		--战斗事件
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...
			local spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing, missType, enviromentalType, amount1, amount2
			local fromMe, toMe
			if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
				fromMe = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
			end
			if (destName and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) ) then
				toMe = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)
			end
			--平砍
			if eventType == "SWING_DAMAGE" then

				critical = select(14, ...)
				amount = select(9,...)
				--一击毙命(指出现FINISHHIM提示后一击即将对方杀死的情况)判定
				if Comix_OneHit and fromMe and amount then
					ComixHitCount = ComixHitCount + 1
--					DEFAULT_CHAT_FRAME:AddMessage(ComixHitCount)
				end	
				--你被暴击
				if Comix_CritFlashEnabled and critical and toMe then
					UIFrameFlash( Comix_FrameFlash1, 0.5, 0.5, 2, false, 1, 0);	
				--使用一击毙命特效代替普通暴击特效(较为温和的语音)
				elseif Comix_CritGapEnabled and critical and fromMe and Comix_SwingCritSilent then
					amount = select(9,...)
					if amount > Comix_CritGap then
						local wtfbbq = math.random(1,ComixOneHitSoundsCt)
						ShakeScreen();
						Comix_DongSound(ComixOneHitSounds,wtfbbq)
						Comix_Pic(0,0,ComixMortalCombatImages[wtfbbq])
					end
				--普通暴击特效并计算连续暴击数
				elseif critical and fromMe and Comix_SwingCritSilent then
					Comix_CallPic(ComixImages[math.random(1,ComixImagesCt)]);			
					if Comix_CritSoundsEnabled then
						Comix_DongSound(ComixSounds)
					end
					ComixCritCount = ComixCritCount+1
					if ComixCritCount >= ComixMaxCrits then
						Comix_DongSound(ComixSpecialSounds,4)
						Comix_Pic(Comix_x_coord+math.random(-15,15),Comix_y_coord+math.random(-20,20),ComixSpecialImages[3])
						ComixCritCount = 0
--						ShakeScreen();
					end
				else
					ComixCritCount = 0
				end

			end
			--法术
			if eventType == "SPELL_DAMAGE" or "RANGE_DAMAGE" then
				--一击毙命判定
				spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
				if Comix_OneHit and fromMe and amount then
					ComixHitCount = ComixHitCount + 1
--					DEFAULT_CHAT_FRAME:AddMessage(ComixHitCount)
				end
				--使用一击毙命特效代替普通暴击特效
				if Comix_CritGapEnabled and critical and fromMe then
					if amount > Comix_CritGap then
						local wtfbbq = math.random(1,ComixOneHitSoundsCt)
						ShakeScreen();
						Comix_DongSound(ComixOneHitSounds,wtfbbq)
						Comix_Pic(0,0,ComixMortalCombatImages[wtfbbq])
					end
				--暴击
				elseif Comix_CritFlashEnabled and critical and toMe then
					--你被暴击
						UIFrameFlash( Comix_FrameFlash1, 0.5, 0.5, 2, false, 1, 0);
					--对应伤害类型的暴击特效
				elseif Comix_CritFlashEnabled and critical and fromMe then
					if spellSchool == 2 then
						Comix_CallPic(ComixHolyDmgImages[math.random(1,ComixHolyDmgImagesCt)]);
					elseif spellSchool == 4 then
						Comix_CallPic(ComixFireImages[math.random(1,ComixFireImagesCt)]);
					elseif spellSchool == 8 then
						Comix_CallPic(ComixNatureImages[math.random(1,ComixNatureImagesCt)]);
					elseif spellSchool == 16 then
						Comix_CallPic(ComixFrostImages[math.random(1,ComixFrostImagesCt)]);
					elseif spellSchool == 32 then
						local test1 = math.random(1,ComixShadowImagesCt)
						Comix_CallPic(ComixShadowImages[test1]);
					elseif spellSchool == 64 then
						Comix_CallPic(ComixArcaneImages[math.random(1,ComixArcaneImagesCt)]);
					else
						Comix_CallPic(ComixImages[math.random(1,ComixImagesCt)]);
					end
--					ShakeScreen();
					if Comix_CritSoundsEnabled then
						Comix_DongSound(ComixSounds)
					end
					--暴击计数
					ComixCritCount = ComixCritCount+1
					if ComixCritCount >= ComixMaxCrits then
						Comix_DongSound(ComixSpecialSounds,4)
						Comix_Pic(Comix_x_coord+math.random(-15,15),Comix_y_coord+math.random(-20,20),ComixSpecialImages[3])
						ComixCritCount = 0
					end
				else
					ComixCritCount = 0
				end
			end
			--治疗
			if eventType == "SPELL_HEAL" then
				spellId, spellName, spellSchool, amount, critical = select(9, ...)
				--别人对你治疗暴击
				if Comix_HealFlashEnabled and critical and toMe and not fromMe then
					UIFrameFlash( Comix_FrameFlash2, 0.5, 0.5, 2, false, 1, 0);
					Comix_DongSound(ComixHealingSounds,math.random(1,ComixHealingSoundsCt))
				end	
				--你施放的治疗暴击
				if critical and fromMe then
					Comix_CallPic(ComixHolyHealImages[math.random(1,ComixHolyHealImagesCt)])
					if Comix_CritHealsEnabled then
						Comix_DongSound(ComixHealingSounds,math.random(1,ComixHealingSoundsCt))
					end
					ComixCritCount = ComixCritCount+1
					if ComixCritCount >= ComixMaxCrits then
						Comix_DongSound(ComixSpecialSounds,4)
						Comix_Pic(Comix_x_coord+math.random(-15,15),Comix_y_coord+math.random(-20,20),ComixSpecialImages[3])
						ComixCritCount = 0
					end
				else
					ComixCritCount = 0
				end
			end
			--得到BUFF
			if eventType == "SPELL_AURA_APPLIED" then
				spellName = select(10,...)
--			DEFAULT_CHAT_FRAME:AddMessage(destName)
				--冰箱,照明弹,食尸,疾奔(急跑),挫锐(挫志),战吼,萨满之怒
				if Comix_AbilitySoundsEnabled and toMe then
					if spellName == COMIX_ICEBLOCK then
						Comix_DongSound(ComixAbilitySounds, 2);
					elseif spellName == COMIX_FLARE then
						Comix_DongSound(ComixAbilitySounds, 4);
					elseif spellName == COMIX_CANNIBALIZE then
						Comix_DongSound(ComixAbilitySounds, 1);

					elseif spellName == COMIX_SPRINT or spellName == COMIX_DASH then
						Comix_DongSound(ComixSpecialSounds,11)
						
					elseif spellName == COMIX_DS or spellName == COMIX_DR  then
						if Comix_DemoShoutEnabled then
							Comix_Pic(30, 30,ComixSpecialImages[2])
--							Comix_CallPic(ComixSpecialImages[2])
							if Comix_DSSounds then
								Comix_DongSound(ComixSpecialSounds,math.random(2,3))
							end			
						end
					elseif spellName == COMIX_CS then
						if Comix_BSEnabled and not Comix_CS_Update then 
							Comix_Pic(Comix_x_coord+math.random(-15,15),Comix_y_coord+math.random(-20,20),ComixSpecialImages[1])
							if Comix_BSSounds then
								Comix_DongSound(ComixAbilitySounds,math.random(5,6))
							end
						else
							Comix_CS_Update = nil
						end

					elseif spellName == COMIX_SV then
						if Comix_NightfallAnnounce and Comix_NightfallEnabled then
							SendChatMessage("[COMIX]NIGHTFALL PROCC ON "..UnitName("target"), "YELL",  getglobal("COMIX_LANGUAGE"))
							Comix_Pic(0,0,ComixSpecialImages[4])
							Comix_DongSound(ComixSpecialSounds,14)
							Comix_NightfallProcced = false;      
						end  
					end	
				end
			end
			--成功施放
			if eventType =="SPELL_CAST_SUCCESS" then
				spellName = select(10,...)
				--照明弹,战斗怒吼,挫锐(挫志),命令怒吼
				if spellName == COMIX_FLARE  then
					if Comix_AbilitySoundsEnabled and fromMe then
						Comix_DongSound(ComixAbilitySounds, 4);
					end
				elseif spellName == COMIX_BS then
					if Comix_BSEnabled and fromMe then 
						Comix_Pic(0, 0,ComixSpecialImages[1])
						if Comix_BSSounds then
							Comix_DongSound(ComixSpecialSounds,1)
						end
						Comix_BS_Update = true
					end
					--elseif spellName == COMIX_CANNIBALIZE and fromMe then
					--	Comix_DongSound(ComixAbilitySounds, 1);
				elseif spellName == COMIX_DS or spellName == COMIX_DR  then
					if Comix_DemoShoutEnabled and fromMe then
						Comix_Pic(50,50,ComixSpecialImages[2])
						if Comix_DSSounds then
							Comix_DongSound(ComixSpecialSounds,math.random(2,3))
						end			
					end
				elseif spellName == COMIX_CS then
					if Comix_BSEnabled and fromMe then 
						Comix_Pic(10, 10,ComixSpecialImages[1])
						if Comix_BSSounds then
							Comix_DongSound(ComixAbilitySounds,math.random(5,6))
						end
					end
--					Comix_BS_Update = true
					Comix_CS_Update = true
				end
			end
			--BUFF消失
			if eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_PERIODIC_AURA_REMOVED" then
				spellName = select (10,...)
				if strfind(spellName, getglobal("COMIX_BS")) and toMe then
					Comix_BS_Update = false
					Comix_BsShortDuration = true
				end
			end
			--单位死亡
			if eventType == "UNIT_DIED" then
				if Comix_DeathSoundEnabled and fromMe then
					if UnitIsDead("player") then
						Comix_CallPic(ComixDeathImages[math.random(1, ComixDeathImagesCt)]);
						Comix_DongSound(ComixDeathSounds,math.random(1,ComixDeathSoundsCt))
						ComixKillCount = 0;
					end
				end
			end
			--击杀
			if eventType == "PARTY_KILL"  then
--			DEFAULT_CHAT_FRAME:AddMessage(sourceName.."->"..destName.." "..ComixKillCount.."次")
				if ComixHitCount == 0 and sourceName == UnitName("player") then
					Comix_OneHit = false;
					ShakeScreen();
					local wtfbbq = math.random(1,ComixOneHitSoundsCt)
					Comix_DongSound(ComixOneHitSounds,wtfbbq)
					Comix_Pic(0,0,ComixMortalCombatImages[wtfbbq])
					ComixHitCount = nil;
				else
					Comix_OneHit = false;
					ComixHitCount = nil;
				end
				if Comix_KillCountEnabled and sourceName == UnitName("player") then
					ComixKillCount = ComixKillCount +1;
					ComixKillCountSoundPlayed = false;
					local a, b
					a = (ComixKSTime + ComixComboTime)
					b = (ComixKSTime + 5 )
--				DEFAULT_CHAT_FRAME:AddMessage("a="..a.."-当前时间="..GetTime().."-击杀次数="..ComixKillCount)
					
					if ComixKillCountSoundPlayed == false then
						if ComixKillCount == 1 then
--						Comix_DongSound(ComixKillCountSounds,1)
							ComixKillCountSoundPlayed = true
							ComixKSTime = GetTime();
						elseif ComixKillCount == 2 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,1)
								ComixKillCountSoundPlayed = true
								Comix_ShowEmote(ComixKillCount);
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 3 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,2)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 4 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,3)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
							ComixKillCount = 1
							ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 5 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,4)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 6 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,5)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 7 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,6)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 8 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,7)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true 
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 9 then
							if GetTime() < a then
								Comix_DongSound(ComixKillCountSounds,8)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						elseif ComixKillCount == 10 then
							if GetTime() < b then
								Comix_DongSound(ComixKillCountSounds,9)
								Comix_ShowEmote(ComixKillCount);
								ComixKillCountSoundPlayed = true
								ComixKSTime = GetTime()
							else
								ComixKillCount = 1
								ComixKSTime = GetTime();
							end
						else
							ComixKillCount = 1
							ComixKSTime = GetTime();
						end    
					end
				end
			end
		else
			return;
		end
		if event == "CHAT_MSG_YELL" then
		    if strfind(arg1,"NIGHTFALL PROCC ON ") and strfind(arg1,"COMIX") then
				if Comix_NightfallProcced then
					if Comix_NightfallGotTarget == false then
						Comix_Pic(0,0,ComixSpecialImages[5])
						Comix_DongSound(ComixSpecialSounds,14)  
						if Comix_NightfallAutoTarget then
							local targeto = strsub(arg1,27,strlen(arg1))
							if targeto ~= nil then
								DEFAULT_CHAT_FRAME:AddMessage("[Nightfall] : Autotargetting "..targeto.." by assisting "..arg2)
						        AssistByName(arg2)
						        Comix_NightfallCounter = true
								Comix_NightfallGotTarget = true
								Comix_NightfallCt = 0;
							end  
						end
			        end 
				else
					Comix_NightfallProcced = true;
					Comix_NightfallGotTarget = false;
			    end
		    end     
		end

		-- Special Target Sounds --
	
		-- Hug Coounter .. FU String Manipulation!!! -- 
		if event == "CHAT_MSG_TEXT_EMOTE" then
			if strfind(arg1, getglobal("COMIX_HUG")) or strfind(arg1,getglobal("COMIX_HUGS")) then
				local HuggerNotFound = true
				local HuggedNotFound = true   
				local comix_the_hugged_one = nil
				if strfind(arg1,getglobal("COMIX_HUGS")) then
					if GetLocale() == "frFR" then
						comix_the_hugged_one = strsub(arg1,strfind(arg1,'%a+',13))
					else
						local gappie = tonumber(getglobal("COMIX_HUGGAP")) 
						if arg2 == UnitName("player") then
							gappie = gappie + 3 
						else 
							gappie = gappie + strlen(arg2)
						end     
						comix_the_hugged_one = strsub(arg1,strfind(arg1,'%a+',gappie))
					end 
				elseif strfind(arg1,"vous serre ") then
					comix_the_hugged_one = UnitName("player")     
				elseif strfind(arg1, getglobal("COMIX_HUG")) then        
					local gappie = tonumber(getglobal("COMIX_HUGGAP")) 
					if arg2 == UnitName("player") then
						gappie = gappie + 3 
			        else
						gappie = gappie + strlen(arg2)
			        end
					comix_the_hugged_one = strsub(arg1,strfind(arg1,'%a+',gappie))
				end
				
				if strfind(comix_the_hugged_one, getglobal("COMIX_YOULOW")) then
					comix_the_hugged_one = UnitName("player")
				end

				for i, line in ipairs(Comix_HugName) do
					if comix_the_hugged_one == getglobal("COMIX_YOULOW") then
						comix_the_hugged_one = UnitName("player")
			        end

					if Comix_HugName[i] == arg2 then
						if not strfind(arg1, getglobal("COMIX_NEED")) then
							Comix_Hugs[i] = Comix_Hugs[i]+1
							HuggerNotFound = false
						end      
					end
	          
			        if Comix_HugName[i] == comix_the_hugged_one then
						Comix_Hugged[i] = Comix_Hugged[i]+1    
						HuggedNotFound = false
					end
				end
	    
		        if HuggedNotFound then
					if not strfind(arg1, getglobal("COMIX_NEED")) then
						Comix_HugName[getn(Comix_HugName)+1] = comix_the_hugged_one
						Comix_Hugged[getn(Comix_HugName)] = 1
						Comix_Hugs[getn(Comix_HugName)] = 0
						Comix_HuggedNotFound = false;
					end   
		        end 
	        
		        if HuggerNotFound then
					if not strfind(arg1, getglobal("COMIX_NEED")) then
						Comix_HugName[getn(Comix_HugName)+1] = arg2
						Comix_Hugs[getn(Comix_HugName)] = 1
						Comix_Hugged[getn(Comix_HugName)] = 0
						Comix_HuggedNotFound = false;
					end 
		        end
	         
		        for i,line in ipairs(Comix_HugName) do
					for j, line in ipairs(Comix_HugName) do
						if Comix_Hugged[i] > Comix_Hugged[j] then
							local Comix_TempHugged = Comix_Hugged[j]
							local Comix_TempHugs = Comix_Hugs[j]
							local Comix_TempHugName = Comix_HugName[j]
							Comix_Hugged[j] = Comix_Hugged[i]
							Comix_Hugs[j] = Comix_Hugs[i]
							Comix_HugName[j] = Comix_HugName[i]
							Comix_Hugged[i] = Comix_TempHugged
							Comix_Hugs[i] = Comix_TempHugs
							Comix_HugName[i] = Comix_TempHugName
			            end  
					end
		        end   
			end
		end 

		if event == "CHAT_MSG_EMOTE" then
			if Comix_SpecialsEnabled then
				if strfind(arg1, "senses a bad joke") then
					Comix_DongSound(ComixSpecialSounds, 17);
				end
			end
		end
	end
end      

local oldWorldFramePoints = {};
function ShakeScreen()
	if Comix_ShakeEnabled then
		if not IsShaking then
			oldWorldFramePoints = {};
			for i = 1, WorldFrame:GetNumPoints() do
				local point, frame, relPoint, xOffset, yOffset = WorldFrame:GetPoint(i);
				oldWorldFramePoints[i] = {
					["point"] = point,
					["frame"] = frame,
					["relPoint"] = relPoint,
					["xOffset"] = xOffset,
					["yOffset"] = yOffset,
				}
			end
		IsShaking = Comix_ShakeDuration;
		end
	end
end

Comix_UpdateInterval = .01

function Comix_OnUpdate(elapsed)
	local TimeSinceLastUpdate = 0;
	if elapsed == nil then 
		elapsed = 0
	end
 
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 
 
	while (TimeSinceLastUpdate > Comix_UpdateInterval) do
 
	-- ScreenShake
		if type(IsShaking) == "number" then
			IsShaking = IsShaking - elapsed;
			if IsShaking <= 0 then
				IsShaking = false;
				WorldFrame:ClearAllPoints();
				for index, value in pairs(oldWorldFramePoints) do
					WorldFrame:SetPoint(value.point, value.xOffset, value.yOffset);
				end
			else
				WorldFrame:ClearAllPoints();
				local moveBy;
				moveBy = math.random(-100, 100)/(101 - Comix_ShakeIntensity);
				for index, value in pairs(oldWorldFramePoints) do
					WorldFrame:SetPoint(value.point, value.xOffset + moveBy, value.yOffset + moveBy);
				end
			end
		end	
 
	  -- Battleshout Buff Check if Battleshout is active  --
	    if Comix_BS_Update then
			for i = 0,ComixBuffCount do
				local buffTexture = GetPlayerBuffTexture(i)
				if buffTexture ~= nil then
					if string.find(buffTexture,"BattleShout") then
						local timeLeft = tonumber(GetPlayerBuffTimeLeft(i))
						if (timeLeft <= 180.000)and (timeLeft >= 179.990) then
							Comix_BsShortDuration = false
						Comix_Pic(0, 0,ComixSpecialImages[1])
							if Comix_BSSounds then
								Comix_DongSound(ComixSpecialSounds,1)
							end
						elseif Comix_BsShortDuration then
							if (timeLeft <= 120.000)and (timeLeft >= 119.990) then
								Comix_Pic(0, 0,ComixSpecialImages[1])
								if Comix_BSSounds then
									Comix_DongSound(ComixSpecialSounds,1)
								end
							end
						elseif timeLeft < 119.00 then
							Comix_BsShortDuration = true    
						end      
					end
		        end    
			end          
	    end  
	--The Picture Animation
	    for i = 1,5 do
			if Comix_Frames[i] ~= nil then
				if Comix_Frames[i]:IsVisible() then
					if Comix_FramesStatus[i] == 0 then
						Comix_FramesScale[i] = Comix_FramesScale[i]*1.1*ComixAniSpeed 
						Comix_Frames[i]:SetScale(Comix_FramesScale[i])
						if Comix_FramesScale[i] >= Comix_Max_Scale then
							Comix_FramesStatus[i] = 1    
						end
					elseif Comix_FramesStatus[i] == 1 then
						Comix_FramesScale[i] = Comix_FramesScale[i]*0.8
						Comix_Frames[i]:SetScale(Comix_FramesScale[i])
						if Comix_FramesScale[i] >= Comix_Max_Scale*0.4 then
							Comix_FramesStatus[i] = 2
						end
					elseif Comix_FramesStatus[i] == 2 then
						Comix_FramesVisibleTime[i] = Comix_FramesVisibleTime[i] + 0.01
						if Comix_FramesVisibleTime[i] >= 1.0 then
							Comix_FramesStatus[i] = 3
						end  
					elseif Comix_FramesStatus[i] == 3 then
						Comix_FramesScale[i] = Comix_FramesScale[i]*0.5
						Comix_Frames[i]:SetScale(Comix_FramesScale[i])
						if Comix_FramesScale[i] <= 0.2 then
							Comix_Frames[i]:Hide()
							Comix_FramesStatus[i] = 0
							Comix_FramesScale[i] = 0.2
							Comix_FramesVisibleTime[i] = 0
						end
			        end
				end            
			end    
	    end  
		if Comix_NightfallCounter then
			Comix_NightfallCt = Comix_NightfallCt + elapsed
			if Comix_NightfallCt >= 5.0 then
				Comix_NightfallCounter = false;
				Comix_NightfallGotTarget = false;
				TargetLastTarget();
			end
		end 
		TimeSinceLastUpdate = TimeSinceLastUpdate-Comix_UpdateInterval;
	end   
end
	
function Comix_Command(Nerd)
  
	Nerd = strlower(Nerd)
   
	if (Nerd == "create") then 
		DEFAULT_CHAT_FRAME:AddMessage("Me Creates: Hello World")
		Comix_DongSound(ComixSpecialSounds,15)


		--elseif(Nerd == "deathtest") then
		--Comix_CallPic(ComixDeathImages[math.random(1, ComixDeathImagesCt)]);

		--elseif(Nerd == "test1") then
		--UIFrameFlash( Comix_FrameFlash1, 0.5, 0.5, 2, false, 1, 0);	
			
		--elseif(Nerd == "test2") then
		--UIFrameFlash( Comix_FrameFlash2, 0.5, 0.5, 2, false, 1, 0);	
			
		--elseif(Nerd == "test3") then
		--UIFrameFlash( Comix_FrameFlash3, 0.5, 0.5, 2, false, 1, 0);	
		
		--elseif(Nerd == "test4") then
		--UIFrameFlash( Comix_FrameFlash4, 0.5, 0.5, 2, false, 1, 0);	

	elseif (Nerd == "hide") then 
		Comix_Framehide();

	elseif (Nerd == "pic") then 
		Comix_CallPic(ComixImages[math.random(1,ComixImagesCt)]);

	elseif (Nerd == "specialpic") then 
		Comix_CallPic(ComixSpecialImages[math.random(1,ComixSpecialCt)]);

	elseif (Nerd == "on") then
		Comix_AddOnEnabled = true;
		Comix_Frame:Show()
		DEFAULT_CHAT_FRAME:AddMessage("Comix enabled!")

	elseif (Nerd == "off") then
		Comix_AddOnEnabled = false;
		Comix_Frame:Hide()
		DEFAULT_CHAT_FRAME:AddMessage("Comix disabled :'(")

	elseif (Nerd == "sound on") then
		Comix_SoundEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Sound is now turned on")   

	elseif (Nerd == "sound off") then
		Comix_SoundEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Sound is now turned off")  

	elseif (Nerd == "demoshout on") then
		Comix_DemoShoutEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Demo Shout is now turned on")   

	elseif (Nerd == "demoshout off") then
		Comix_DemoShoutEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Demo Shout is now turned off")  
	
	elseif (Nerd == "demoshoutsound on") then
		Comix_DSSounds = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Demo Shout sound is now turned on")   

	elseif (Nerd == "demoshoutsound off") then
		Comix_DSSounds = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Demo Shout sound is now turned off") 

	elseif (Nerd == "bs on") then
		Comix_BSEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Battle Shout is now turned on")   

	elseif (Nerd == "bs off") then
		Comix_BSEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Battle Shout is now turned off")  
	
	elseif (Nerd == "bssound on") then
		Comix_BSSounds = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Battle Shout sound is now turned on")   

	elseif (Nerd == "bssound off") then
		Comix_BSSounds = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Battle Shout sound is now turned off")  

	elseif (Nerd == "zoning on") then
		Comix_ZoneEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Zoning Sounds are now turned on")   

	elseif (Nerd == "zoning off") then
		Comix_ZoneEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Zoning Sound is now turned off")

	elseif (Nerd == "bam on") then
		Comix_BamEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("BAM is now turned on")

	elseif (Nerd == "bam off") then
		Comix_BamEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("BAM is now turned off")

	elseif (Nerd == "images on") then
		Comix_ImagesEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Images are now turned on")

	elseif (Nerd == "images off") then
		Comix_ImagesEnabled = false    
		DEFAULT_CHAT_FRAME:AddMessage("Comix Images are now turned off")

	elseif (Nerd == "finish on") then  
		Comix_FinishhimEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Finish Him is now turned on")

	elseif (Nerd == "finish off") then  
		Comix_FinishhimEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Finish Him is now turned off")
	
	elseif (Nerd == "dsound") then
		if Comix_DeathSoundEnabled then
		Comix_DeathSoundEnabled = false
		DEFAULT_CHAT_FRAME:AddMessage("Comix Death Sound is now turned off")
		else 
		Comix_DeathSoundEnabled = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Death Sound is now turned on")    
		end       
  
	elseif (Nerd == "nfall") then
		if Comix_NightfallAnnounce then
			Comix_NightfallAnnounce = false
			DEFAULT_CHAT_FRAME:AddMessage("Comix Night Fall Announce is now turned off")
		else 
			Comix_NightfallAnnounce = true
		DEFAULT_CHAT_FRAME:AddMessage("Comix Night Fall Announce is now turned on")    
		end 
  
	elseif (Nerd == "KillCount") then
	    if Comix_KillCountEnabled then
	      Comix_KillCountEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Kill Count is now turned off")
	    else 
	      Comix_KillCountEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Kill Count is now turned on")    
	    end
     
	elseif string.find(Nerd,"anispeed") then    
	    local ComixNerd = string.find(Nerd, " ")
	    local buffer = tonumber(string.sub(Nerd, ComixNerd, ComixNerd + 1, string.len(Nerd)))
	    if buffer < 1 or buffer > 3 then
			DEFAULT_CHAT_FRAME:AddMessage("Value not accepted, try smth between 1 and 3")
	    else  
			ComixAniSpeed = buffer;
			DEFAULT_CHAT_FRAME:AddMessage("Animation Speed set to "..ComixAniSpeed)
	    end
     
	elseif string.find(Nerd, "scale") then
	    local ComixNerd = string.find(Nerd, " ")
	    local buffer = tonumber(string.sub(Nerd, ComixNerd, ComixNerd + 1, string.len(Nerd)))
	    if buffer < 1.5 or buffer > 3 then
			DEFAULT_CHAT_FRAME:AddMessage("Value not accepted, try smth between 1.5 and 3")
	    else  
			Comix_Max_Scale = buffer;
			DEFAULT_CHAT_FRAME:AddMessage("Scale set on "..Comix_Max_Scale)
	    end
    
	elseif string.find(Nerd, "crits") then
		local ComixNerd = string.find(Nerd, " ")
		local buffer = tonumber(string.sub(Nerd, ComixNerd, ComixNerd + 1, string.len(Nerd)))
		ComixMaxCrits = buffer;
		DEFAULT_CHAT_FRAME:AddMessage("Amount of crits needed for Impressive set to "..ComixMaxCrits)
  
	elseif string.find(Nerd, "critpercent") then
	    local ComixNerd = string.find(Nerd, " ")
	    local buffer = tonumber(string.sub(Nerd, ComixNerd, ComixNerd + 1, string.len(Nerd)))
	    if buffer <= 100 and buffer >= 0 then 
			Comix_CritPercent = buffer;
			DEFAULT_CHAT_FRAME:AddMessage("Amount of crits needed for Impressive set to "..ComixMaxCrits)
	    else
			DEFAULT_CHAT_FRAME:AddMessage("You can set Crit-Percent only between 0 and 100 -.- anything else would be senseless or not??")
	    end   
  
	elseif (Nerd == "clearhug") then
	    for i, line in ipairs(Comix_HugName) do
		    Comix_HugName[i] = nil ;
		    Comix_Hugged[i] = nil;
		    Comix_Hugs[i] = nil; 
	    end 
		Comix_HugName[1] = UnitName("player")
		Comix_Hugs[1] = 0
		Comix_Hugged[1] = 0 
  
	elseif (Nerd == "showhug") then
	    for i = 1,5 do
		    if Comix_HugName[i] ~= nil then
				DEFAULT_CHAT_FRAME:AddMessage("[Hug Report]: "..Comix_HugName[i].." has been hugged " ..Comix_Hugged[i].." times and Hugged "..Comix_Hugs[i].." times",0,0,1)
		    end
	    end 
  
	elseif (Nerd == "reporthug") then
	    for i = 1,5 do
			if Comix_HugName[i] ~= nil then
	        SendChatMessage("[Hug Report]: "..Comix_HugName[i].." has been hugged " ..Comix_Hugged[i].." times and Hugged "..Comix_Hugs[i].." times", "SAY")
			end
	    end
       
	   
	elseif (Nerd == "clearjump") then
		Comix_JumpCount = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Jump Counter Reset",0,0,1)
  
	elseif (Nerd == "showjump") then
        DEFAULT_CHAT_FRAME:AddMessage("[Jump Report]: "..UnitName("player").." has jumped " ..Comix_JumpCount.." times",0,0,1)
      
  
	elseif (Nerd == "reportjump") then
        SendChatMessage("[Jump Report]: "..UnitName("player").." has jumped " ..Comix_JumpCount.." times", "SAY")
    
    
	   
	elseif (Nerd == "critsound") then
		if Comix_CritSoundsEnabled then
	      Comix_CritSoundsEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Crit Sounds are now turned off")
	    else 
	      Comix_CritSoundsEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Crit Sounds now turned on")    
	    end
	
	
	elseif (Nerd == "healsound") then
		if Comix_CritHealsEnabled then
	      Comix_CritHealsEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Heal Sounds are now turned off")
	    else 
	      Comix_CritHealsEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Heal Sounds now turned on")    
	    end
	
	
	elseif (Nerd == "critflash") then
		if Comix_CritFlashEnabled then
	      Comix_CritFlashEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Crit Flash is now turned off")
	    else 
	      Comix_CritFlashEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Crit Flash now turned on")    
	    end
	

	elseif (Nerd == "healflash") then
		if Comix_HealFlashEnabled then
	      Comix_HealFlashEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Heal Flash is now turned off")
	    else 
	      Comix_HealFlashEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Heal Flash now turned on")    
	    end
	
	elseif (Nerd == "boing") then
		if Comix_BounceSoundEnabled then
	      Comix_BounceSoundEnabled = false
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Boing sound is now turned off")
	    else 
	      Comix_BounceSoundEnabled = true
	      DEFAULT_CHAT_FRAME:AddMessage("Comix Boing sound now turned on")    
	    end
	elseif string.find(Nerd, "combo") then
		if Nerd == "combo" then
			DEFAULT_CHAT_FRAME:AddMessage("当前连击最大间隔时间为"..ComixComboTime.."秒")
		else
			local ComixNerd = string.find(Nerd, " ")
			local buffer = tonumber(string.sub(Nerd, 7,-1,string.len(Nerd)))
			if buffer > 0 then
				ComixComboTime = buffer
				DEFAULT_CHAT_FRAME:AddMessage("连击最大间隔时间设为"..buffer.."秒")
			else
				DEFAULT_CHAT_FRAME:AddMessage("输入有误,必须是一个正的数值")
			end
		end
	elseif (Nerd == "onlyskill") then
		if Comix_SwingCritSilent  then
			Comix_SwingCritSilent = false
			DEFAULT_CHAT_FRAME:AddMessage("平砍暴击特效已关闭")
		else
			Comix_SwingCritSilent = true
			DEFAULT_CHAT_FRAME:AddMessage("平砍暴击特效已开启")
		end
	elseif (Nerd == "killemote") then
		if Comix_KillEmoteEnabled then
			Comix_SwingCritSilent = false
			DEFAULT_CHAT_FRAME:AddMessage("击杀表情已关闭")
		else
			Comix_SwingCritSilent = true
			DEFAULT_CHAT_FRAME:AddMessage("击杀表情已开启")
		end
	elseif (Nerd == "help") then
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix on|off to enable|disable AddOn")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix create to create a cool MSG")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix pic to show a Frame")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix specialpic to show a Frame with a special")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix hide to hide all Frames")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix scale <Value 1.5-3> to scale animation of all Frames")    
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix anispeed <Value 1-3> to set animation speed (popping up of the images)")    
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix sound on|off to turn sound on|off")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix critsound to toggle Crit sounds.")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix healsound to toggle Heal sounds.")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix demoshout on|off to turn Demo Shout/Roar grafix on|off (will also disable sounds if on)") 
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix demoshoutsound on|off to turn Demo Shout/Roar sound on|off")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix bs on|off to turn Battle Shout grafix on|off (will also disable sounds if on)") 
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix bssound on|off to turn Battle Shout sound on|off") 
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix zoning on|off to turn Zoning sounds on|off")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix crits <Value> to set the amount of crits needed for an Impressive")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix images on|off to show or hide the images on specials and crits")          
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix specials on|off to turn specials on or off ( eastereggs cant be turned off though :P )")
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix finish on|off to turn <Finish him>-sound on 20% mob health on or off")          
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix bam on|off to enable BamSound only or hear Comix Sounds on crits!")          
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix showhug to show the Hugs done in your Chat-Frame.") 
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix reporthug to report the Hugging done to /say.") 
	    DEFAULT_CHAT_FRAME:AddMessage("Use /comix clearhug to clear all Hugs done.") 
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix nfall to toggle Nightfall proc announce.")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix dsound to toggle death sound.")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix critflash to toggle Crit flashes.")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix healflash to toggle Heal flashes.")
		DEFAULT_CHAT_FRAME:AddMessage("Use /comix boing to toggle Boing sound.")
  
	else 
		comix_options_frame:Show()
    
	end
  
end

function Comix_BadJoke()
	SendChatMessage("senses a bad joke", "EMOTE");
end

function Comix_DongSound(SoundTable,Sound)

	if Comix_SoundEnabled then 
		if SoundTable == ComixSounds then  
			if Comix_BamEnabled then
				--PlaySound("GLUESCREENSMALLBUTTONMOUSEDOWN");
				PlaySoundFile("Interface\\AddOns\\Comix\\Sounds\\"..ComixSpecialSounds[13])
			else  
				local randsound = math.random(1,ComixSoundsCt)
				--  PlaySound("GLUESCREENSMALLBUTTONMOUSEDOWN");
				PlaySoundFile("Interface\\AddOns\\Comix\\Sounds\\"..SoundTable[randsound]);
			end
		else 
			--PlaySound("GLUESCREENSMALLBUTTONMOUSEDOWN");
			PlaySoundFile("Interface\\AddOns\\Comix\\Sounds\\"..SoundTable[Sound]);
		end
	end  
end



function Comix_Pic(x,y,Pic)

	if Comix_ImagesEnabled then
-- Resetting Frames animation values --
		if Comix_Frames[ComixCurrentFrameCt]:IsVisible() then
			Comix_Frames[ComixCurrentFrameCt]:Hide()
		end  
		Comix_FramesStatus[ComixCurrentFrameCt] = 0
		Comix_FramesScale[ComixCurrentFrameCt] = 0.2
		Comix_FramesVisibleTime[ComixCurrentFrameCt] = 0 
   
-- Setting Texture --
		Comix_textures[ComixCurrentFrameCt]:SetTexture("Interface\\Addons\\Comix\\"..Pic);
		Comix_textures[ComixCurrentFrameCt]:SetAllPoints(Comix_Frames[ComixCurrentFrameCt]);
		Comix_Frames[ComixCurrentFrameCt].texture = Comix_textures[ComixCurrentFrameCt];
   
-- Positioning Frame --
     
		Comix_Frames[ComixCurrentFrameCt]:SetPoint("Center",x,y);
		Comix_Frames[ComixCurrentFrameCt]:Show();

-- Increasing Current Frame or resetting it to 1 --  
	    if ComixCurrentFrameCt == 5 then
			ComixCurrentFrameCt = 1
	    else
			ComixCurrentFrameCt = ComixCurrentFrameCt +1
	    end
	end     
end  

function Comix_LoaddaShite()

-- Counting Normal Images --  
  ComixImagesCt = getn(ComixImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixImagesCt.."個普通效果",0,0,0)

-- Counting Images in Image-Sets --
  ComixFireImagesCt = getn(ComixFireImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixFireImagesCt.."個火焰傷害效果",0,0,1)

  ComixFrostImagesCt = getn(ComixFrostImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixFrostImagesCt.."個冰霜傷害效果",0,1,1)

  ComixShadowImagesCt = getn(ComixShadowImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixShadowImagesCt.."個暗影傷害效果",0,1,0)

  ComixNatureImagesCt = getn(ComixNatureImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixNatureImagesCt.."個自然傷害效果",1,1,0)

  ComixArcaneImagesCt = getn(ComixArcaneImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixArcaneImagesCt.."個秘法傷害效果",1,0,0)

  ComixHolyHealImagesCt = getn(ComixHolyHealImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixHolyHealImagesCt.."個治療法術效果",0,0,0)

  ComixHolyDmgImagesCt = getn(ComixHolyDmgImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixHolyDmgImagesCt.."個神聖傷害效果",0,0,0)
  
  ComixDeathImagesCt = getn(ComixDeathImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixDeathImagesCt.."個死亡效果",0,0,0)

-- Counting Normal Sounds --
  ComixSoundsCt = getn(ComixSounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixSoundsCt.."個普通音效",1,0,1)
  
-- Counting Zone Sounds --
  ComixZoneSoundsCt = getn(ComixZoneSounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixZoneSoundsCt.."個區域切換音效",1,1,1)

-- Counting One hit Sounds --
  ComixOneHitSoundsCt = getn(ComixOneHitSounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixOneHitSoundsCt.."個一擊音效",1,1,1)
  
-- Counting Healing Sounds --   
  ComixHealingSoundsCt = getn(ComixHealingSounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixHealingSoundsCt.."個治療音效",1,1,1)
  

-- Counting Specials --
  ComixSpecialCt = getn(ComixSpecialImages)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixSpecialCt.."個特殊音效",1,0,0)  
  
  -- Counting Ability Sounds --   
  ComixAbilitySoundsCt = getn(ComixAbilitySounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixAbilitySoundsCt.."個技能音效",1,1,1)

  -- Counting Death Sounds --   
  ComixDeathSoundsCt = getn(ComixDeathSounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入"..ComixDeathSoundsCt.."個死亡音效",1,1,1)
  
   -- Counting Ready check Sounds --   
  ComixReadySoundsCt = getn(ComixReadySounds)
  DEFAULT_CHAT_FRAME:AddMessage("已載入 "..ComixReadySoundsCt.." 準備音效",1,1,1)
  
  DEFAULT_CHAT_FRAME:AddMessage("打開圖形化設置界面請輸入: /comix或/ 動漫.獲知更多資訊請輸入: /comix help",0,0,1)
    
end

function Comix_Framehide()
	for i,line in ipairs(Comix_Frames) do
		Comix_Frames[i]:Hide();
		DEFAULT_CHAT_FRAME:AddMessage("Hiding Comix_Frames["..i.."]")
	end
end



function Comix_CallPic(Image)

	if Comix_ImagesEnabled then
-- Creating x,y Coordinates --
	    Comix_x_coord = math.random(-120,120)
	    if Comix_x_coord <= 0 then
			Comix_x_coord = Comix_x_coord -40
	    else
			Comix_x_coord= Comix_x_coord +40
	    end  
	 
	    if (abs(Comix_x_coord)<75) then
			local y_buffer = 50 
			Comix_y_coord = math.random(y_buffer,130)
	    else
			Comix_y_coord = math.random(0,130)   
	    end
  
-- Finally handing over x,y Coords and the image to show --
		Comix_CurrentImage = Image
		Comix_Pic(Comix_x_coord,Comix_y_coord,Image)
	end
	
end

function Comix_CreateFrames()
-- Creating 5 Frames, creating 5 Textures and setting FramesScale, FramesVisibleTime & FramesStatus--
	for i = 1,5 do
	    -- Create Frame --
	    Comix_Frames[i] = CreateFrame("Frame","ComixFrame"..i,UIParent)
	    Comix_Frames[i]:SetWidth(128);
	    Comix_Frames[i]:SetHeight(128);
	    Comix_Frames[i]:Hide()
	    -- Create texture for each frame --
	    Comix_textures[i] = Comix_Frames[i]:CreateTexture(nil,"BACKGROUND")
	    -- Setting FramesScale, FramesVisibleTime & FramesStatus  to 0 --
	    Comix_FramesScale[i] = 0.2
	    Comix_FramesVisibleTime[i] = 0
	    Comix_FramesStatus[i] = 0
	end
  

	Comix_FrameFlash1Texture:SetVertexColor(1,0,0);
	Comix_FrameFlash2Texture:SetVertexColor(0,1,0);
	Comix_FrameFlash3Texture:SetVertexColor(1,0,0);
	Comix_FrameFlash4Texture:SetVertexColor(0,1,0);
end  
function Comix_ShowEmote(ComixKillCount)
	if Comix_KillEmoteEnabled then
		if ComixKillCount >= 2 and ComixKillCount <= 10 then
			local a = ComixKillCount - 1
			local b = ComixKillEmotes[a]
			SendChatMessage(b,ComixEmoteChannel);
			ComixEmoteRank = ComixKillEmotesRanks[a];
		end
		ComixEmoteRank = ""
	end
end
