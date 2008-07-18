----------------------------------------------------------------------------------------------------
-- DroodFocus 2.2.20 beta - Core
-- Author : Meranannon - Discordia - Vol'jin (EU)
----------------------------------------------------------------------------------------------------

DroodFocus = {
	Version = "2.2.20b";
	Lock = 1;
	Class = "",
	Registered = false,
};

local DroodFocusFrames = {};
local contener;

local _G = getfenv(0);

local DroodFocus_Energy = {
	Length = 2,
	Alpha = 0.2,
	Start = 0,
	End = 0,
	Mana = nil,
};

local DroodFocusConfig_Default = {
	Enable = true,
	Scale = 1.6,
	Claws = true,
	BloodAlpha = 1.0,
	Locked = true,
	Tracker = true,
	contenerScale = 1.0,
	contenerX = 22,
	contenerY = -190
}

df_Frames = {};
df_Texts = {};
df_Textures = {};

combo_Frames = {};
combo_Textures = {};

griffe_Frames = {};
griffe_Textures = {};

local spell_clearcast = GetSpellInfo(12536); -- id idées claires

local targetId;
local playerId; -- ID du joueur

local clearcastState = 0;
local clearcastScale = 1;
local clearcastScaleAdd = 0.0075;

-- tableau stockant les sorts trackés
local nbSpellsTracker = 40;
SpellsTracker = {};
for i = 1,nbSpellsTracker do
	SpellsTracker[i] = {
		trkTime = -1, -- new
		trkSpell = -1,
		trkTarget = -1,
		trkSource = -1,
		trkStack = 0,
		trkTimer = 0,
		trkAbilite = -1
	    };
end

claws = {};
for i = 1,5 do
	claws[i] = {
		clawX = -96, -- new
		clawY = 100,
		posX = 0,
		posY = 0,
		clawScale = 1,
		clawAlpha = -1,
		clawState=0
	    };
end

claws[1].clawX = -140;
claws[2].clawX = 140;

claws[3].clawX = -250;
claws[3].clawY = 0;

claws[4].clawX = 250;
claws[4].clawY = 0;

claws[5].clawX = 0;
claws[5].clawY = 250;

local clawsOrder = 1;
local bloodOrder = 3;

local comboOffset = 0;

local contener;

----------------------------------------------------------------------------------------------------
-- Widgets Handlers
----------------------------------------------------------------------------------------------------
function DroodFocus:OnLoad()
	
	localizedClass, DroodFocus.Class = UnitClass("player");
	
	DroodFocus.Registered = DroodFocus:RegisterEvents();

	if((not DroodFocusConfig) or (not DroodFocusConfig.Version) or (DroodFocusConfig.Version ~= DroodFocus.Version)) then
		DroodFocusConfig = DroodFocusConfig_Default;
	end

	
	function GetChildrenTree(Frame) --- Walk the frame hierarchy recursively adding children.
		if Frame:GetChildren() then
			for _,child in pairs({Frame:GetChildren()}) do
				if child:IsMouseEnabled() then
					tinsert(DroodFocusFrames,child);
				end
				GetChildrenTree(child);
			end 
		end
	end
	GetChildrenTree(DroodFocusFrame);
	
	DroodFocus:creerIcones();
	DroodFocus:Toggle();
	
	-- It seems that all has gone well till now. Hi there!
	DEFAULT_CHAT_FRAME:AddMessage(DROODFOCUS_WELCOME);

end

----------------------------------------------------------------------------------------------------
-- events Handlers
----------------------------------------------------------------------------------------------------
function DroodFocus:OnEvent(eventArg)
	if(not DroodFocus.Registered) then return; end

	if(eventArg == "VARIABLES_LOADED") then
		
		if(DroodFocus.Registered) then

			for key,value in pairs(DroodFocusConfig_Default) do
				cvalue = DroodFocusConfig[key];
				--DEFAULT_CHAT_FRAME:AddMessage("DEFAULT -> "..tostring(key).." : "..tostring(value));
				--DEFAULT_CHAT_FRAME:AddMessage("CURRENT -> "..tostring(cvalue));
				if (not cvalue) then
					DroodFocusConfig[key] = DroodFocusConfig_Default[key];
				end
			end
			

			-- Scaling
			DroodFocusFrame:SetScale(DroodFocusConfig.Scale);
			contener:SetPoint("CENTER", UIparent, "CENTER", DroodFocusConfig.contenerX, DroodFocusConfig.contenerY);
			contener:SetScale(DroodFocusConfig.contenerScale);

			-- Energy ticks
			DroodFocus_Energy.Mana = UnitMana("player");
			
			-- Energy ticks text
			DroodFocusEnergyTickText:SetText("");
			
			--droods
			DroodFocusClearcast:Hide();
			
			
			-- Create slash events
			SLASH_DROODFOCUS1 = "/df";
			SLASH_DROODFOCUS2 = "/droodfocus";
			SlashCmdList["DROODFOCUS"] = function() DroodFocusOptions:Handler(); end;
		end
		
	elseif(eventArg == "PLAYER_REGEN_ENABLE" and DroodFocusConfig.Enable) then
		DroodFocus:UpdateComboBar(0);
		DroodFocus:noBlood();
		DroodFocus:killAllTrackers();

	elseif (eventArg == "PLAYER_AURAS_CHANGED" and DroodFocusConfig.Enable) then
		DroodFocus:checkBuffsDrood();
		DroodFocus:Toggle();
	
	elseif (eventArg == "PLAYER_COMBO_POINTS" and DroodFocusConfig.Enable) then
		DroodFocus:UpdateComboBar(0);
		
	elseif(eventArg == "PLAYER_ENTERING_WORLD" and DroodFocusConfig.Enable) then 
		DroodFocus:hideAbilities();
		DroodFocus:noBlood();
		DroodFocus:Toggle();
		
	elseif(eventArg == "PLAYER_DEAD" and DroodFocusConfig.Enable) then
		DroodFocus:UpdateComboBar(0);
		DroodFocus:hideAbilities();
		DroodFocus:UpdateEnergyBar();
		DroodFocus:noBlood();
		DroodFocus:Toggle();

	elseif(eventArg == "PLAYER_TARGET_CHANGED" and DroodFocusConfig.Enable) then
		DroodFocus:checkDeBuffsDrood();

	elseif(eventArg == "COMBAT_LOG_EVENT_UNFILTERED" and DroodFocusConfig.Enable) then

		-- debug--		
		 --DroodFocus:debugMsg("****************"..tostring(theevent));
		 --DroodFocus:debugMsg("timestamp:"..tostring(arg1));
		 --DroodFocus:debugMsg("event:"..tostring(arg2));
		 --DroodFocus:debugMsg("sourceGUID:"..tostring(arg3));
		 --DroodFocus:debugMsg("sourceName:"..tostring(arg4));
		 --DroodFocus:debugMsg("SourceFlags:"..tostring(arg5));
		 --DroodFocus:debugMsg("destGUID:"..tostring(arg6));
		 --DroodFocus:debugMsg("destName:"..tostring(arg7));
		 --DroodFocus:debugMsg("destFlags:"..tostring(arg8));
		 --DroodFocus:debugMsg("spellId:"..tostring(arg9));
		 --DroodFocus:debugMsg("spellName:"..tostring(arg10));
		 --DroodFocus:debugMsg("spellSchool :"..tostring(arg11));
		 --DroodFocus:debugMsg("amount:"..tostring(arg12));
		 --DroodFocus:debugMsg("school:"..tostring(arg13));
		 --DroodFocus:debugMsg("resisted:"..tostring(arg14));
		 --DroodFocus:debugMsg("blocked:"..tostring(arg15));
		 --DroodFocus:debugMsg("absorbed:"..tostring(arg16));
		 --DroodFocus:debugMsg("critical:"..tostring(arg17));
		 --DroodFocus:debugMsg("glancing :"..tostring(arg18));
		 --DroodFocus:debugMsg("crushing :"..tostring(arg19));

	       	if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_PERIODIC_DAMAGE" or arg2=="SPELL_AURA_APPLIED") then
			-- sort ou debuff appliqué -> lance le trackeur
			DroodFocus:debuffsTracker(arg2,arg1,arg3,arg6,arg10,arg12);
			
			-- une kikoo griffe?
			--[[if (DroodFocusConfig.Claws and arg3==playerId and arg17) then
				-- le joueur a fait un critique sur coup jaunes, on lance une tache de sang
				DroodFocus:newClaw();
				DroodFocus:newBlood();
			end]]

		--[[elseif (DroodFocusConfig.Claws and arg2=="SWING_DAMAGE" and arg3==playerId and arg14) then
			-- le joueur a fait un critique sur coup blanc, on lance une kikoo griffes  
			DroodFocus:newClaw();
			DroodFocus:newBlood();	]]
					
		elseif (arg2=="SPELL_AURA_REMOVED") then
			-- sort ou debuff fade -> le detruire
			DroodFocus:removeAuraDebuff(arg6,arg10);
			DroodFocus:checkDeBuffsDrood();
				
		elseif (arg2=="UNIT_DIED") then
			-- une unité est morte enléve les debuffs la concernant
			DroodFocus:removeAllDebuffs(arg6);
			DroodFocus:checkDeBuffsDrood();

		--[[elseif (arg2=="PARTY_KILL" and arg3==playerId) then
			-- coup de grace du joueur, plein de sang :)
			DroodFocus:newBlood();
			DroodFocus:newBlood();
			DroodFocus:newBlood();]]
		end
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - Création des icones
----------------------------------------------------------------------------------------------------
function DroodFocus:creerIcones()

	contener = CreateFrame("FRAME","DebuffContener",UIparent);
	--contener:SetWidth(9*22);
	contener:SetWidth(9*22);
	contener:SetHeight(32);
	contener:SetPoint("CENTER", UIparent, "CENTER", DroodFocusConfig.contenerX, DroodFocusConfig.contenerY);
	contener.texture = contener:CreateTexture()
	contener.texture:SetAllPoints(contener)
	contener.texture:SetTexture(0,0,0,0)

	-- abilités icones
	for i = 1,nbAbilities do

		abiUseobj = abilities[i].abiUseobj;
		abiObj = abilities[i].abiObj;
		abiImg = abilities[i].abiImg;
		abiX = abilities[i].abiX;
		abiY = abilities[i].abiY;
		abiW = abilities[i].abiW;
		abiH = abilities[i].abiH;
		abiMode = abilities[i].abiMode;

		abilities[i].abiName = GetSpellInfo(abilities[i].abiId);
	
		-- Creation de l'icone

		if (abiUseobj == -1) then
	
			df_Frames[i] = CreateFrame("FRAME",abiObj,contener);
			df_Frames[i]:SetWidth(abiW);
			df_Frames[i]:SetHeight(abiH);
			df_Frames[i]:SetPoint("BOTTOM", contener, "CENTER", abiX, abiY);

    			df_Textures[i] = df_Frames[i]:CreateTexture(nil,"BACKGROUND");
     			df_Textures[i]:SetAllPoints(df_Frames[i]); -- attache la texture a la frame
     			df_Textures[i]:SetTexture(abiImg);
     			df_Textures[i]:SetBlendMode(abiMode);
    			df_Frames[i].texture = df_Textures[i];
 
			df_Texts[i] = df_Frames[i]:CreateFontString("$parentText","ARTWORK","DroodFocusFontDebuffTemplate");
			df_Texts[i]:SetPoint("TOP", abiObj, "BOTTOM", 0, 0 );
			df_Texts[i]:SetJustifyH('CENTER')
			df_Texts[i]:SetShadowColor(0, 0, 0);
			df_Texts[i]:SetShadowOffset(-1, -1);		
		
			df_Frames[i]:Hide();
			df_Texts[i]:SetText("");

			abilities[i].abiUseobj = i;

		end

	end

	-- points de combo
	for i = 1,5 do

		combo_Frames[i] = CreateFrame("FRAME","combo"..i,DroodFocusFrame);
		combo_Frames[i]:SetWidth(20);
		combo_Frames[i]:SetHeight(20);
		combo_Frames[i]:SetPoint("TOPLEFT", DroodFocusFrame, "TOPLEFT", -2+((i-1)*14), 4);

		combo_Textures[i] = combo_Frames[i]:CreateTexture(nil,"BACKGROUND");
		
		combo_Textures[i]:SetTexCoord(0, 1, 0, .25);
		combo_Textures[i]:SetWidth(64);
		combo_Textures[i]:SetHeight(64);
		
		combo_Textures[i]:SetAllPoints(combo_Frames[i]); -- attache la texture a la frame
		combo_Textures[i]:SetTexture("Interface\\AddOns\\DroodFocus\\arts\\combo");
		combo_Frames[i].texture = combo_Textures[i];

		combo_Frames[i]:Show();

	end

	-- griffes
	for i = 1,5 do
		griffe_Frames[i] = CreateFrame("FRAME","griffe"..i,UIParent);
		
		griffe_Frames[i]:SetWidth(256);
		griffe_Frames[i]:SetHeight(256);
		griffe_Frames[i]:SetPoint("CENTER", UIParent, "CENTER", 0, 0);

		griffe_Textures[i] = griffe_Frames[i]:CreateTexture(nil,"BACKGROUND");
		griffe_Textures[i]:SetTexCoord(0, 1, 0, 1);
		griffe_Textures[i]:SetWidth(256);
		griffe_Textures[i]:SetHeight(256);
		griffe_Textures[i]:SetAllPoints(griffe_Frames[i]); -- attache la texture a la frame
		
		if (i==1 or i==2) then
			griffe_Textures[i]:SetTexture("Interface\\AddOns\\DroodFocus\\arts\\scratch");
		elseif (i==3) then
			griffe_Textures[i]:SetTexture("Interface\\AddOns\\DroodFocus\\arts\\blood");
		elseif (i==4) then
			griffe_Textures[i]:SetTexture("Interface\\AddOns\\DroodFocus\\arts\\blood");			
		elseif (i==5) then
			griffe_Textures[i]:SetTexture("Interface\\AddOns\\DroodFocus\\arts\\blood");			
		end
		
		griffe_Textures[i]:SetBlendMode("ADD");
		griffe_Frames[i].texture = griffe_Textures[i];
	
		griffe_Frames[i]:SetPoint("CENTER", UIParent, "CENTER", claws[i].posX, claws[i].posY);
	
		griffe_Frames[i]:Hide();	
	end
	
	griffe_Textures[1]:SetTexCoord(0, 1, 0, 1);
	griffe_Textures[2]:SetTexCoord(1, 0, 0, 1);

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - ecrire dans la frame debug
----------------------------------------------------------------------------------------------------
function DroodFocus:debugMsg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - vidage du tracker 
----------------------------------------------------------------------------------------------------
function DroodFocus:killAllTrackers()
	-- detruit tous les timers
	for i=1,nbSpellsTracker do
		if (SpellsTracker[i].trkTime~=-1) then
			SpellsTracker[i].trkTime = 0; -- maj du timer
			SpellsTracker[i].trkTimer = 0; -- maj du timer		
		end
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - tracking des debuffs 
----------------------------------------------------------------------------------------------------
function DroodFocus:debuffsTracker(theevent,cTime,cSource,cCible,cType,cAmount)

	--
	-- cTime	heure application, non utilisée pour l'instant on utilise le temps écoulé depuis le début de la session GetTime()
	-- cSource	Id d'ou provient le debuff
	-- cCible	Id de l'unité qui recoit le debuff
	-- cType	nom du debuff
	--
	local nouveau = true; -- par defaut c'est un nouveau debuff
	local position = -1;
	local currentTime = GetTime();
	
	local targetId = UnitGUID("target"); -- ID de la cible actuelle
	local sourceId = UnitName(cSource);  -- Nom de l'unité qui a posé le debuff

	if (DroodFocusConfig.Tracker and DroodFocusConfig.Enable) then

		--DroodFocus:debugMsg(	
		--"-->"..tostring(theevent).."\n"
		--.."cTime: "..tostring(cTime).."\n"
		--.."cType: "..tostring(cType).."\n"
		--.."cCible: "..tostring(cCible).."\n"
		--.."cSource: "..tostring(cSource).."\n"
		--.."cAmount: "..tostring(cAmount).."\n"
		--);
		
		-- ajout dans la liste
		-- parcours la liste des abilités possibles
		for ia = 1, nbAbilities do
			
			-- récupére données de l'abilité
			local aEvent = abilities[ia].abiEvent; 		-- nom
			local aType = abilities[ia].abiName; 		-- nom
			local aTimer = abilities[ia].abiTimer; 		-- durée
			local aStack = abilities[ia].abiStack; 		-- stack maxi
			local aCombo = abilities[ia].abiCombo; 		-- abilité a combo? (lacerate)
			local aPersonnal = abilities[ia].abiPersonnal; 	-- debuff perso
			local aUseobj = abilities[ia].abiUseobj;
			local aAbilite = ia; 				-- icone a utilisé
			
			-- abilité a tracké et bon event?
			if (cType == aType and theevent == aEvent) then
	
				-- evenement correspond au type et a l'event
				
				-- petite ruse ici, on regarde si le debuff existe sur la cible et posséde une durée
				-- si c'est le cas, ça signifie qu'on vient de trouver un debuff du joueur
				-- on attribuer d'office a la variable cSource l'id du joueur

				-- si pas de source et debuff perso
				if (sourceId==nil and aPersonnal) then
					-- parcours liste des debuffs
					for deb=1,40 do
						local nTest,_,_,_,_,_,tTest=UnitDebuff("target",deb);
						if (nTest==aType and tTest) then
							-- meme debuff et temps valide, c'est le debuff du joueur
							cSource = playerId;
							break;
						end
					end
				end
				
				-- si debuff commun
				-- ou debuff personnel et venant du joueur
				if (not aPersonnal or (aPersonnal and cSource == playerId)) then

					-- ok debuff commun ou personnel valide
					-- parcours tableau debuffs
					for i=1,nbSpellsTracker do
				
						-- entrée du tableau
						local tTime = SpellsTracker[i].trkTime;
						local tType = SpellsTracker[i].trkSpell;
						local tCible = SpellsTracker[i].trkTarget;
						local tSource = SpellsTracker[i].trkSource;
						local tAbi = SpellsTracker[i].trkAbilite;
						
						-- entrée valide du tableau?
						if (tTime~=-1) then	
								
							-- meme cible?
							if (cCible == tCible) then
								
								-- meme debuff?
								if (cType == tType) then
	
									-- existe deja dans la liste du tracker màj du debuff
									
									nouveau = false; -- le debuff ne sera pas ajouté a la liste
									
									-- maj du timer
									SpellsTracker[i].trkTime = currentTime;
				
									-- maj stack
									SpellsTracker[i].trkStack = SpellsTracker[i].trkStack + 1;
									if (SpellsTracker[i].trkStack > aStack) then
										SpellsTracker[i].trkStack = aStack;
									end
				
									if (aCombo) then
										DroodFocus:UpdateComboBar(SpellsTracker[i].trkStack);	
									end
												
									-- abilité a dot ?
									DroodFocus:SetAbilitiesDamage(tAbi,aUseobj,cAmount)
	
									-- anim	
									if (targetId == tCible) then					
										DroodFocus:setAbilitieMode(aUseobj,1)
									end
								
								end
								
							end
						else
							-- position vide dans le tableau, on sauvegarde la position pour un éventuel nouveau debuff
							if (position == -1) then
								position = i;
							end
						end
						
					end
				
					-- tableau terminé
					-- si nouveau et position valide c'est un nouveau debuff, on peut l'ajouter à la liste
					if (nouveau and position~=-1) then
						
						-- ajout du debuff
						SpellsTracker[position].trkTime = currentTime;
						SpellsTracker[position].trkSpell = cType;
						SpellsTracker[position].trkTarget = cCible;
						SpellsTracker[position].trkSource = cSource;
						SpellsTracker[position].trkStack = 1;
						SpellsTracker[position].trkTimer = aTimer;
						SpellsTracker[position].trkAbilite = aAbilite;
	
						if (aCombo) then
							DroodFocus:UpdateComboBar(1);	
						end
											
						-- abilité a dot,combos,... ?
						DroodFocus:SetAbilitiesDamage(aAbilite,aUseobj,"-")
	
						-- anim	
						if (targetId == cCible) then						
							DroodFocus:setAbilitieMode(aUseobj,1);					
						end
					
					end
				end
				
			end
			
		end
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - retire les debuffs de la cible morte
----------------------------------------------------------------------------------------------------
function DroodFocus:removeAllDebuffs(cCible)

	-- suite a appel de UNIT_DIED
	for i=1,nbSpellsTracker do

		-- entrée du tableau
		local tCible = SpellsTracker[i].trkTarget;
	
		-- meme cible?
		if (cCible == tCible) then

			SpellsTracker[i].trkTime=-1;
			
		end
	end
	
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - retire un debuff "aura" de la liste du tracker
----------------------------------------------------------------------------------------------------
function DroodFocus:removeAuraDebuff(cCible,cType)

	for i=1,nbSpellsTracker do

		-- entrée du tableau
		local tTime = SpellsTracker[i].trkTime;
		local tType = SpellsTracker[i].trkSpell;
		local tCible = SpellsTracker[i].trkTarget;
		local tTimer = SpellsTracker[i].trkTimer;

		-- entrée valide du tableau?
		if (tTime~=-1) then

			-- meme cible?
			if (cCible == tCible) then

				-- meme debuff?
				if (cType == tType and tTimer==-1) then

					-- ok on le retire
					SpellsTracker[i].trkTime = 0; -- maj du timer
					SpellsTracker[i].trkTimer = 0; -- maj du timer
				end
			end
		end
	end

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - Verification des timers des debuffs
----------------------------------------------------------------------------------------------------
function DroodFocus:checkTimers()
	
	-- suite appel depuis ONUPDATE
	if (DroodFocus.Class == "DRUID" and DroodFocusConfig.Enable) then
		local currentTime = GetTime(); -- heure actuelle
		local doCheck = false;
		
		-- parcours le tableau des debuffs
		for i=1,nbSpellsTracker do
			
			local tTime = SpellsTracker[i].trkTime;	-- heure application du debuff
			
			if (tTime~=-1) then
				local tTimer = SpellsTracker[i].trkTimer; -- durée du debuff	
				
				local testTimer = tTimer - (currentTime - tTime); -- temps restant
				
				if (tTimer~=-1) then
					if (testTimer<0) then
				
						-- temps écoulé debuff suprimer
						SpellsTracker[i].trkTime = -1; 
						doCheck = true;
						
					else
						
						num = SpellsTracker[i].trkAbilite;
						realnum = abilities[SpellsTracker[i].trkAbilite].abiUseobj;
						
						-- abilité a compteur?
						if (abilities[num].abiDot) then
	
							-- oui, au lieu d'afficher le compteur, on récupére le temps restant sur la cible
							-- (c'est un debuff du joueur ce qui est autorisé)
							timeOk = -1;
							-- parcours liste des debuffs
							for deb=1,40 do
								local nTest,_,_,_,_,_,tTest=UnitDebuff("target",deb);
								if (nTest==SpellsTracker[i].trkSpell and tTest) then
									-- debuff existant et qui posséde une durée, c'est le bon
									timeOk=tTest;
								end
							end 		
							texte ="";
							
							if (timeOk~=-1) then
								-- on a une durée, on l'affiche
								texte = string.format("%.1f", timeOk);
							
								-- si on posséde une plage de dégats on l'affiche
								if (abilities[realnum].abiAmount) then
									texte = texte.."|n|cFFFFFF00"..tostring(abilities[realnum].abiAmount);
								end
								
							else
								-- pas de durée, on affiche Finish
								texte = string.format("End");
								DroodFocus:setAbilitieMode(realnum,2);	
							end
							
							df_Texts[realnum]:SetText(texte);	
							
						else
							
							-- affiche le timer estimé
							df_Texts[realnum]:SetText(string.format("%.1f", testTimer));	
							
						end
					end
				end
			end
		end
	
		-- du changement, relance une verification des debuffs
		if (doCheck) then
			DroodFocus:checkDeBuffsDrood();
		end
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - desactivation de toutes les abilitées
----------------------------------------------------------------------------------------------------
function DroodFocus:hideAbilities()

	for i = 1, nbAbilities do
		tUseobj = abilities[i].abiUseobj;
		-- si abilités actives on passe au mode desactivation 2
		if (DroodFocus:getAbilitieActive(tUseobj)~=0) then
			DroodFocus:setAbilitieMode(tUseobj,2);
		end	
				
	end

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - changement du mode d'animation
----------------------------------------------------------------------------------------------------
function DroodFocus:setAbilitieMode(num,state)
	
	-- attribue les bonnes valeurs au coef de grossiement de l'icone
	if (abilities[num].abiState == 0 and state == 1) then
		abilities[num].abiScaleAdd = 0.2;
		
	elseif (abilities[num].abiState == 1 and state ==2) then
		abilities[num].abiScaleAdd = -0.075;

	elseif (abilities[num].abiState == 0 and state ==2) then
		abilities[num].abiScaleAdd = -0.075;

	elseif (abilities[num].abiState == 1 and state ==1) then
		abilities[num].abiScaleAdd = 0.2;
	
	elseif (abilities[num].abiState == 2 and state ==1) then
		abilities[num].abiScaleAdd = 0.2;				
	end

	abilities[num].abiState = state;
	
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - return vrai si abilité active
----------------------------------------------------------------------------------------------------
function DroodFocus:getAbilitieActive(num)
	if (abilities[num].abiState==1) then
		return true;
	else
		return false;
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - verification du buff idées claires du joueur
----------------------------------------------------------------------------------------------------
function DroodFocus:checkBuffsDrood()

	local showClearcast = false;

	for i=1,16 do
		local n,_,_,_,_,t=UnitBuff("player",i);
		if (n) then
			if (n==spell_clearcast) then
				showClearcast=true;
			end
		end
	end 	
	
	if (showClearcast) then
	    clearcastScale = 0.15;
	    clearcastScaleAdd = 0.1;
	    clearcastState = 1;
	else
		if (clearcastState>0) then
	    		clearcastScaleAdd = -0.1;
	    		clearcastState = 2;
		end
	end
	
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - animation des debuffs
----------------------------------------------------------------------------------------------------
function DroodFocus:animateDroodsThings()

	if (DroodFocusConfig.Enable) then
		if (DroodFocus.Class == "DRUID") then
			-- anim clearcast
			if (clearcastState>0) then
			
				clearcastScale = clearcastScale + clearcastScaleAdd;
		
				if (clearcastState == 1) then
					if	(clearcastScale>=1.15) then
						clearcastScale=1.15;
						clearcastScaleAdd=-0.0075;
				end
					if	(clearcastScale<=1 and clearcastScaleAdd<0) then
						clearcastScale=1;
						clearcastScaleAdd=0.0075;
					end
				elseif (clearcastState == 2) then
					if	(clearcastScale<=0.15) then
						clearcastState = 0;
						DroodFocusClearcast:Hide();
					end
				end
				
				DroodFocusClearcast:SetScale(clearcastScale);
		
				if (clearcastState>0) then
					DroodFocusClearcast:Show();
				end
				
			end
		
			-- parcours liste abilites
			for i = 1,nbAbilities do
				
				-- donnees de l'abilite
				abiUseobj = abilities[i].abiUseobj;
				
				if (abiUseobj == i) then
					
					-- ok obj a afficher
					-- sinon c'est une abilité qui utilise une autre icone
					abiScale = abilities[i].abiScale;
					abiScaleAdd = abilities[i].abiScaleAdd;
					abiState = abilities[i].abiState;
					abiX = abilities[i].abiX;
					abiY = abilities[i].abiY;
					
					-- si abilité active
					if (abiState ==1 ) then
			
						abiScale = abiScale + abiScaleAdd;
			
						-- gerer animation etat 1
						if (abiScaleAdd>=0.2) then
							
							-- le debuff pop
							if (abiScale>1.25) then
								abiScale = 1.25;
								abiScaleAdd = -0.025;
							end
						else
							-- le debuff pulse
							if (abiScale>1.025 and abiScaleAdd>0) then
								abiScale = 1.025;
								abiScaleAdd = -0.0004;
							elseif (abiScale<1 and abiScaleAdd<0) then
								abiScale = 1;
								abiScaleAdd = 0.19;					
							end				
						end
						
					elseif (abiState == 2) then
						
						abiScale = abiScale + abiScaleAdd;
						
						-- gerer animation etat 2, le debuff disparait au fond
						if (abiScale<0.10) then
							-- anim terminée
							abiScale = 0.10;
							abiScaleAdd = 0;
							abiState = 0;
							
							-- abilité a compteur ?
							DroodFocus:resetAbilities(i);
							
						end				
					end
					
					abilities[i].abiScale = abiScale;
					abilities[i].abiScaleAdd = abiScaleAdd;
					abilities[i].abiState = abiState;
					
					df_Frames[i]:SetScale(abiScale);
					
					if (abiState==1 or abiState==2) then
						df_Frames[i]:Show();
					else
						df_Frames[i]:Hide();
					end
				end
				
			end
		end
		
		-- les kikoo griffes :)
		for i = 1,5 do	
			if (claws[i].clawState==1) then
	
				if (i==1 or i==2) then
					claws[i].clawScale = claws[i].clawScale - 0.0005;
					claws[i].clawAlpha = claws[i].clawAlpha - 0.006;
				else
					claws[i].clawAlpha = claws[i].clawAlpha - 0.0035;
				end
				
				
				if (claws[i].clawAlpha<0.01) then
					claws[i].clawAlpha=0.01;
					claws[i].clawState=0;	
					
				end			
				if (claws[i].clawScale<0.01) then
					claws[i].clawScale=0.01;
				end
				
				griffe_Frames[i]:SetScale(claws[i].clawScale);
				griffe_Frames[i]:SetAlpha(claws[i].clawAlpha);
				
				griffe_Frames[i]:Show();
			else
				griffe_Frames[i]:Hide();	
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - desactive griffes et sang
----------------------------------------------------------------------------------------------------
function DroodFocus:noBlood()

	for i = 1,5 do
		claws[i].clawAlpha=0.01;
		claws[i].clawState=0;
		griffe_Frames[i]:Hide();
	end

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - change l'état d'une griffe
----------------------------------------------------------------------------------------------------
function DroodFocus:newClaw()
	-- changement etat griffe
	claws[clawsOrder].posX = claws[clawsOrder].clawX + (math.random(100)-50);
	claws[clawsOrder].posY = claws[clawsOrder].clawY - math.random(100);
	
	claws[clawsOrder].clawScale = 1.25;
	claws[clawsOrder].clawAlpha = 1;

	griffe_Frames[clawsOrder]:SetPoint("CENTER", UIparent, "CENTER", claws[clawsOrder].posX, claws[clawsOrder].posY);
	claws[clawsOrder].clawState = 1;	

	clawsOrder =  clawsOrder +1;
	if (clawsOrder>2) then
		clawsOrder = 1;
	end 

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - change l'état d'une griffe
----------------------------------------------------------------------------------------------------
function DroodFocus:newBlood()
	-- changement etat sang
	
	local rotation = math.random(4);
	
	claws[bloodOrder].posX = claws[bloodOrder].clawX + (math.random(120)-60);
	claws[bloodOrder].posY = claws[bloodOrder].clawY + (math.random(120)-60);
	
	if (rotation==1) then
		griffe_Textures[bloodOrder]:SetTexCoord(1, 0, 1, 0);
	elseif (rotation==2) then
		griffe_Textures[bloodOrder]:SetTexCoord(0, 1, 1, 0);
	elseif (rotation==3) then
		griffe_Textures[bloodOrder]:SetTexCoord(1, 0, 0, 1);
	elseif (rotation==4) then
		griffe_Textures[bloodOrder]:SetTexCoord(0, 1, 0, 1);
	end			
	
	claws[bloodOrder].clawScale = 1 + (math.random()/2);
	claws[bloodOrder].clawAlpha = DroodFocusConfig.BloodAlpha;

	griffe_Frames[bloodOrder]:SetPoint("CENTER", UIparent, "CENTER", claws[bloodOrder].posX, claws[bloodOrder].posY);
	claws[bloodOrder].clawState = 1;	

	bloodOrder =  bloodOrder +1;
	if (bloodOrder>5) then
		bloodOrder = 3;
	end 

end

----------------------------------------------------------------------------------------------------
-- DroodFocus - remise a zero des dommage pour le sort périodique
----------------------------------------------------------------------------------------------------
function DroodFocus:resetAbilities(num)
	-- oui, remise a zero	
	abilities[num].abiAmount=0;
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - mise a jour des dommage pour le sort périodique
----------------------------------------------------------------------------------------------------
function DroodFocus:SetAbilitiesDamage(reel,num,valeur)
	if (abilities[reel].abiDot) then
		if (valeur=="DEBUFF") then
			valeur="-";
		end
		abilities[num].abiAmount = valeur;
	end	
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - Verification des debuffs de la cible
----------------------------------------------------------------------------------------------------
function DroodFocus:checkDeBuffsDrood()
	
	-- suite evenement PLAYER_TARGET_CHANGED ou si un timer a expiré
	
	-- la cible actuelle
	targetId = UnitGUID("target");
	local combos = 0;

	-- flag abilité gérée, par defaut non
	for i = 1,nbAbilities do
		abilities[i].abiGerer = false;
	end
		
	-- on a une cible valide?
	if (targetId~=nil) then

		-- oui parcours le tableau des debuffs
		for i=1,nbSpellsTracker do
	
			-- entrée temps du tableau
			local tTime = SpellsTracker[i].trkTime;
			
			-- Un debuff a cet ligne du tableau?
			if (tTime~=-1) then	

				-- oui, meme cible?
				local tTarget = SpellsTracker[i].trkTarget;
				
				if (targetId == tTarget) then
					
					-- oui le debuff provient de cette cible
					-- activation de l'icone du debuff

					-- icone a utiliser
					local tAbilite = SpellsTracker[i].trkAbilite;
					local tUseobj = abilities[tAbilite].abiUseobj;
					local tCombo = abilities[tAbilite].abiCombo;
					
					-- on signale que l'abilité est gérée
					abilities[tUseobj].abiGerer = true;
					
					if (tCombo) then
						combos = SpellsTracker[i].trkStack;
					end
					
					-- activation
					if (not DroodFocus:getAbilitieActive(tUseobj)) then
						DroodFocus:setAbilitieMode(tUseobj,1);
					end

				end
			
			end
		end
		
		-- regarde les abilités gérées
		for i = 1, nbAbilities do
			-- si abilités non gérées précédement mais active ca signifie que le debuff a expiré
			-- elle passe en mode desactivation 2
			if (not abilities[i].abiGerer) then
				if (DroodFocus:getAbilitieActive(i)) then
					DroodFocus:setAbilitieMode(i,2);
				end			
			end
		end
		
		DroodFocus:UpdateComboBar(combos);	
	else
		-- pas de cible valide, desactivation de toutes les abilites
		DroodFocus:UpdateComboBar(0);	
		DroodFocus:hideAbilities();
	end
end

----------------------------------------------------------------------------------------------------
-- DroodFocus - Retourne la forme du joueur 0: caster, 1: chat, 2: ours 
----------------------------------------------------------------------------------------------------
function DroodFocus:currentForm()
	local powertype = UnitPowerType("player");
 	if ( powertype == 0 ) then
   		return 0;
	elseif ( powertype == 1 ) then 
		return 2;
	elseif ( powertype == 3 ) then 
		return 1;		
	end
end


----------------------------------------------------------------------------------------------------
-- DroodFocus - OnUpdate handler
----------------------------------------------------------------------------------------------------
function DroodFocus:OnUpdate()
	if(DroodFocus.Registered and DroodFocusConfig.Enable) then

		local currentForm = DroodFocus:currentForm();
		local energy = UnitMana("player")
		local currentTime = GetTime();
		local sparkPosition = 1;
		
		local base, posBuff, negBuff = UnitAttackPower("player");
		local effective = base + posBuff + negBuff;

		if (currentForm==1) then
			local critChance =  string.format("%.2f", GetCritChance());
			local mainSpeed, offSpeed = UnitAttackSpeed("player");
			local vitesse1 =  string.format("%.2f", mainSpeed);
			local puissanceText = effective.." PA | "..critChance.."% | "..vitesse1.." s.";			
			DroodFocusEnergyTickText:SetText(puissanceText);
			
			-- animation tick energy communs druides et voleurs
			if(energy > DroodFocus_Energy.Mana or currentTime >= DroodFocus_Energy.End) then
				DroodFocus_Energy.Mana = energy;
				DroodFocus_Energy.Start = currentTime;
				DroodFocus_Energy.End = currentTime + DroodFocus_Energy.Length;
			else
				if(DroodFocus_Energy.Mana ~= energy) then
					DroodFocus_Energy.Mana = energy;
				end
				sparkPosition = ((currentTime - DroodFocus_Energy.Start) / (DroodFocus_Energy.End - DroodFocus_Energy.Start)) * 76;
			end
			DroodFocusEnergyTickBar:SetMinMaxValues(DroodFocus_Energy.Start, DroodFocus_Energy.End);
			DroodFocusEnergyTickBar:SetValue(currentTime);
			if(sparkPosition < 1) then
				sparkPosition = 1;
			end
			DroodFocusEnergyTickSpark:SetPoint("CENTER", "DroodFocusEnergyTickBar", "LEFT", sparkPosition, 0);
		elseif (currentForm==2) then
			--ours	

			local dodgeChance =  string.format("%.2f", GetDodgeChance());
			local armor =  tostring(GetCritChance());
			local basearmor, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
			local puissanceText = effective.." PA | "..dodgeChance.."% | "..effectiveArmor .." AC.";			
			DroodFocusEnergyTickText:SetText(puissanceText);
			
			DroodFocusEnergyTickBar:SetMinMaxValues(0, 2);
			DroodFocusEnergyTickBar:SetValue(2);
			sparkPosition = 76;
			DroodFocusEnergyTickSpark:SetPoint("CENTER", "DroodFocusEnergyTickBar", "LEFT", sparkPosition, 0);				
		end
		
		DroodFocus:UpdateEnergyBar();
		
		-------------------------------------------
		-- appel functions spécifiques aux druides
		-------------------------------------------
		
		DroodFocus:checkTimers();
		DroodFocus:animateDroodsThings();
			
	end
end

----------------------------------------------------------------------------------------------------
-- Events Handlers
----------------------------------------------------------------------------------------------------
function DroodFocus:UpdateComboBar(force)
	
	local c = GetComboPoints();
	
	if (force>0) then
		c=force;
	end
	
	for i = 1, 5 do
		if(i<=c) then
			combo_Textures[i]:SetTexCoord(0, 1, comboOffset+0.25, comboOffset+0.5);
		else
			combo_Textures[i]:SetTexCoord(0, 1, comboOffset+0, comboOffset+0.25);
		end
	end
end

function DroodFocus:UpdateEnergyBar()
	
	local currentForm = DroodFocus:currentForm();
	
	if (currentForm==1) then
		local value, max = UnitMana("player"), UnitManaMax("player");
		local text = value.." / "..max;
		local Frame = _G["DroodFocusEnergyBar"];
		Frame:SetMinMaxValues(0, max);
		Frame:SetValue(value);
		DroodFocusEnergyText:SetText(text);
	elseif (currentForm==2) then
		local value, max = UnitMana("player"), UnitManaMax("player");
		local text = value.." / "..max;
		local Frame = _G["DroodFocusEnergyBar"];
		Frame:SetMinMaxValues(0, max);
		Frame:SetValue(value);
		DroodFocusEnergyText:SetText(text);	
	end
	--DroodFocus:debugMsg("value "..tostring(value));
	
end

function DroodFocus:Toggle()
	-- vérification de la forme
	local currentForm = DroodFocus:currentForm();
	playerId = UnitGUID("player"); -- ID du joueur
	if (currentForm==1) then
		-- chat
		DroodFocusEnergyBar:SetStatusBarColor(1, 0.8, 0);
		DroodFocusEnergyBarBg:SetStatusBarColor(0.40, 0.20, 0);
		comboOffset = 0;
		DroodFocus:UpdateComboBar(0);
		if DroodFocusConfig.Enable then
			DroodFocusFrame:Show();
			contener:Show();
		else
			DroodFocusFrame:Hide();
			contener:Hide();
		end
	elseif (currentForm==2) then
		-- ours
		DroodFocusEnergyBar:SetStatusBarColor(1.0, 0, 0);
		DroodFocusEnergyBarBg:SetStatusBarColor(0.30, 0.10, 0);
		comboOffset = 0.5;
		if DroodFocusConfig.Enable then
			DroodFocusFrame:Show();
			contener:Show();
		else
			DroodFocusFrame:Hide();
			contener:Hide();
		end
	else
		-- aucune
		DroodFocusFrame:Hide();
		DroodFocus:noBlood();
		contener:Hide();
	end

	-- check lock status and enable/disable mouse.
	if DroodFocusFrame:IsVisible() then
		if DroodFocusConfig.Locked then
			DroodFocusFrame:EnableMouse(false);
			for _,childframe in pairs (DroodFocusFrames) do
				childframe:EnableMouse(false);
			end
		else
			DroodFocusFrame:EnableMouse(true);
			for _,childframe in pairs (DroodFocusFrames) do
				childframe:EnableMouse(true);
			end		
		end
	end
		
	
end

----------------------------------------------------------------------------------------------------
-- Main
----------------------------------------------------------------------------------------------------
function DroodFocus:RegisterEvents()
	if(DroodFocus.Class ~= "ROGUE" and DroodFocus.Class ~= "DRUID") then
		this:UnregisterEvent("PLAYER_COMBO_POINTS");
		this:UnregisterEvent("PLAYER_AURAS_CHANGED");
		this:UnregisterEvent("UNIT_ENERGY");
		this:UnregisterEvent("UNIT_MAXENERGY");
		this:UnregisterEvent("UNIT_AURA");
		this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		this:UnregisterEvent("PLAYER_REGEN_ENABLED");
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		this:UnregisterEvent("PLAYER_DEAD");
		this:UnregisterEvent("VARIABLES_LOADED");
		this:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		this:UnregisterEvent("PLAYER_TARGET_CHANGED");
		return false;
	else
		this:RegisterForDrag("LeftButton");
		this:RegisterEvent("PLAYER_COMBO_POINTS");
		this:RegisterEvent("PLAYER_AURAS_CHANGED");
		this:RegisterEvent("UNIT_ENERGY");
		this:RegisterEvent("UNIT_MAXENERGY");
		this:RegisterEvent("UNIT_AURA");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_DEAD");
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		return true;
	end
end
