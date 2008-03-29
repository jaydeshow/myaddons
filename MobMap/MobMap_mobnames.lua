-- mob name database

function MobMap_GetMobNameAndSubtitle(fulltitle)
	if(fulltitle==nil) then return nil; end
	local part1,part2;
	_,_,part1,part2=string.find(fulltitle,"(.*)|(.*)");
	if(part1==nil) then
		part1=fulltitle;
		part2=nil;
	else
		part1=part1;
		part2=part2;
	end
	return part1, part2;
end

mobmap_inverse_mobs=nil;
mobmap_last_mobname_search={name=nil, id=nil};

function MobMap_GetIDForMobName(name)
	if(mobmap_optimize_response_times==true) then
		if(mobmap_inverse_mobs==nil) then
			mobmap_inverse_mobs={};
			local k,v;
			for k,v in pairs(mobmap_mobs) do
				local part1,part2=MobMap_GetMobNameAndSubtitle(v);
				mobmap_inverse_mobs[part1]=k;
			end
		end
		return mobmap_inverse_mobs[name];
	else
		if(name==mobmap_last_mobname_search.name) then
			return mobmap_last_mobname_search.id;
		else
			local k,v;
			for k,v in pairs(mobmap_mobs) do
				local part1,part2=MobMap_GetMobNameAndSubtitle(v);
				if(part1==name) then
					mobmap_last_mobname_search.name=name;
					mobmap_last_mobname_search.id=k;
					return k;
				end;
			end
		end
	end
end

function MobMap_GetMobFullName(mobid)
	return mobmap_mobs[mobid];	
end

function MobMap_GetMobName(mobid)
	local part1,part2=MobMap_GetMobNameAndSubtitle(mobmap_mobs[mobid]);	
	return part1;
end

function MobMap_GetPointerToPositionData(position)
	local data=mobmap_mobdetails[position];
	if(data==nil) then return nil; end
	local zonecode, length, pointer;
	zonecode=MobMap_Mask(data,mobmap_poweroftwo[12]);
	length=MobMap_Mask(data/mobmap_poweroftwo[12],mobmap_poweroftwo[12]);
	pointer=MobMap_Mask(data/mobmap_poweroftwo[24],mobmap_poweroftwo[20]);
	return zonecode, length, pointer;
end

function MobMap_GetMobZone(mobid)
	local zonelist=MobMap_GetMobZonesByMobID(mobid);
	if(zonelist==nil) then return nil; end
	if(table.getn(zonelist)==0) then
		return nil;
	end
	return zonelist[1];	
end

function MobMap_GetMobDetails(position)
	local data=mobmap_mobdetails[position];
	if(data==nil) then return nil; end
	local minlevel, maxlevel, zonecount;
	minlevel=MobMap_Mask(data,mobmap_poweroftwo[8]);
	maxlevel=MobMap_Mask(data/mobmap_poweroftwo[8],mobmap_poweroftwo[8]);
	zonecount=MobMap_Mask(data/mobmap_poweroftwo[16],mobmap_poweroftwo[8]);
	return minlevel, maxlevel, zonecount;
end

function MobMap_GetMobPointer(mobid)
	local data=mobmap_mobpointers[floor((mobid-1)/3)+1];
	if(data==nil) then return; end
	local pointer=MobMap_Mask(data/mobmap_poweroftwo[16*((mobid-1)%3)],mobmap_poweroftwo[16]);
	return pointer;
end

function MobMap_GetMobZones(pointer)
	local minlevel, maxlevel, zonecount = MobMap_GetMobDetails(pointer);
	local zones = {};
	for i=1, zonecount, 1 do
		local zonecode = MobMap_GetPointerToPositionData(pointer+i);
		table.insert(zones, zonecode);
	end
	return zones;
end

function MobMap_GetMobZonesByMobID(mobid)
	if(mobmap_mobs[mobid]==nil) then return nil; end
	return MobMap_GetMobZones(MobMap_GetMobPointer(mobid));	
end

function MobMap_CheckIfMobIsInZone(mobid, zoneid)
	if(mobmap_mobs[mobid]==nil) then return nil; end
	local pointer=MobMap_GetMobPointer(mobid);
	local minlevel, maxlevel, zonecount=MobMap_GetMobDetails(pointer);
	for i=1, zonecount, 1 do
		local zonecode = MobMap_GetPointerToPositionData(pointer+i);
		if(zonecode==zoneid) then return true; end
	end
	return false;
end
