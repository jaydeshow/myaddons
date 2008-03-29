local Fights={}
Recount.Fights=Fights

function Fights:MoveFights()
	local ReuseFight
	for i=math.min(#Recount.db.char.FoughtWho,Recount.db.profile.MaxFights-1),1,-1 do
		Recount.db.char.FoughtWho[i+1]=Recount.db.char.FoughtWho[i]
	end
	Recount.db.char.FoughtWho[1]=Recount.FightingWho.." "..Recount.InCombatF.."-"..date("%H:%M:%S")

	for k,v in pairs(Recount.db.char.combatants) do		
		ReuseFight=nil
		if v.FightsSaved==Recount.db.profile.MaxFights then
			ReuseFight=v.Fights["Fight"..v.FightsSaved]
		end
		for i=math.min(v.FightsSaved,Recount.db.profile.MaxFights-1),1,-1 do
			v.Fights["Fight"..i+1]=v.Fights["Fight"..i]
		end
		
		if v.LastFightIn==Recount.FightNum then
			v.Fights["Fight1"]=v.Fights.CurrentFightData		
			if not ReuseFight then
				v.Fights["CurrentFightData"]=Recount:GetTable()
				Recount:InitFightData(v.Fights["CurrentFightData"])
			else
				Recount:ResetFightData(ReuseFight)
				v.Fights["CurrentFightData"]=ReuseFight
			end
		else
			v.Fights["Fight1"]=nil
		end

		if v.FightsSaved<Recount.db.profile.MaxFights then
			v.FightsSaved=v.FightsSaved+1
		end
	end

	--Main Window Display Cache needs to be reset should fix several bugs
	Recount:FullRefreshMainWindow() -- Elsia: Made a function for this as it's also needed for deleting combatants and refreshing when options change
	
	local FightNum=tonumber(string.match(Recount.CurDataSet,"Fight(%d+)"))
	if FightNum then
		Recount.FightName=Recount.db.char.FoughtWho[FightNum]
	end
end

function Fights:RemoveFight(num)
end

function Fights:ChangeFightNum(num)
	
end