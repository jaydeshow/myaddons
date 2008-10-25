--简体中文
local version="0.5.1"

local SUBTYPE_ARROW="箭"
local SUBTYPE_BULLET="弹药"
local JPACK_MAXMOVE_ONCE=3
-- '#XX'代表XX类别,没有'#'代表物品名称，'#',代表其他物品，前面是超级物品，后面是超级垃圾,
--JPACK_ORDER={"炉石","#坐骑","矿工锄","剥皮小刀","#鱼竿","#其它","#武器","#护甲","#","#消耗品","#任务","#材料","肉类","鱼油"}
--JPACK_ORDER={}
--JPACK_DEPOSIT={}
--JPACK_DRAW={}

local TYPEMAP={
--	["箭袋"]=["箭"],
}

--[[
TODO:
PlayerClass 对应 物品类型列表
可用装备(布甲,皮甲,锁甲,板甲,盾牌,)
消耗物,药剂,装置,爆炸物
投射物,灵魂石,("Miscellaneous" - includes Spellstones and Firestones )
材料,商品,其他,宝石
]]--
JPack={
	asc=false,
	--packing=false,
	packingBank=false,
	bankOpened=false,
	deposit=false,
	draw=false,
	bagGroups={},
	packingGroupIndex=1,
	packingBags={}
}
-- 默认按逆序
--JPack.asc=false;
--[[
function i18n()
	if locale == "zhCN" then
	--简体中文
		JPackLocale.TYPE_BAG="容器"
		TYPE_QUEST="任务"
		TYPE_CONSUMABLE="消耗品"
		superItems={"炉石","矿工锄","剥皮小刀","鱼竿"}
	elseif locale == "zhTW" then
	--繁体中文
		JPackLocale.TYPE_BAG="容器"
		TYPE_QUEST="任务"
		TYPE_CONSUMABLE="消耗品"
		superItems={"炉石","矿工锄","剥皮小刀","鱼竿"}
	else
		
	end
end
]]--
local bagSize=0;
local packingBags={}

--TODO: 整理前堆叠物品（将stack > 1,名称相同的物品拿起来，放下去）
--OnUpdate   1. 堆叠中 2.整理背包分组 3移动中
--itemStackCount， GetItemInfo   stack>1 then tryZip
--GetItemCount(itemID or "itemLink", [includeBank]) 
--[[
比较用的字符串,与排序直接相关的函数
]]--
function getCompareStr(item)
	if(not item)then
		return nil
	elseif(not item.compareStr)then
		local _,_,textureType,textureIndex=string.find(item.texture,"\\.*\\([^_]+_?[^_]*_?[^_]*)_?(%d*)")
		if(not item.rarity)then item.rarity='1' end
		item.compareStr= getPerffix(item).." "..item.rarity..item.type.." "..item.subType.." "..textureType.." "
			..string.format("%2d",item.minLevel).." "..string.format("%2d",item.level).." "..(textureIndex or "00")..item.name
	end
	return item.compareStr
end

--[[
return 1xxx 非垃圾 ，0xxx for 垃圾，xxx为（999-JPACK_ORDER中所定的位置）
]]--
function getPerffix(item)
	if(item==nil)then return nil end
	
	--按名称获取顺序
	local i=IndexOfTable(JPACK_ORDER,item.name);
	if(i<=0)then
		--按子类别获取顺序
		i=IndexOfTable(JPACK_ORDER,"#"..item.type.."##"..item.subType);
	else
		--名称匹配直接返回
		return '1'..string.format("%3d",999-i);
	end
	if(i<=0)then
		--按子类别获取顺序
		i=IndexOfTable(JPACK_ORDER,"##"..item.subType);
	end
	if(i<=0)then
		--按类别获取顺序
		i=IndexOfTable(JPACK_ORDER,"#"..item.type);
	end
	if(i<=0)then
		--默认类别顺序
		i=IndexOfTable(JPACK_ORDER,"#");
	end
	if(i<=0)then
		--默认顺序
		i=999;
	end
	local s=string.format("%3d",999-i);
	--灰色物品、可装备的非优秀物品
	if(item.rarity==0)then
		return "00"..s;
	elseif(IsEquippableItem(item.name) and item.type~=JPackLocale.TYPE_BAG) then 
		debug("USEABLE:"..item.name.."="..IsUsableItem(item.name))
		if(item.rarity <= 2 or (not IsUsableItem(item.name))) then
			return '01'..s
		end
	end
	return "1"..s;
	
end

--[[
bagIds = {1,3,5}
packIndex ---JPack的index
bagID --- wow 的bagId
slotId ---- wow 的slotId
]]--
function pack()
	if (CursorHasItem() or CursorHasMoney() or CursorHasSpell()) then
		print("JPack: \"请先拿掉你鼠标上的物品.\"",2,0.28,2);
	else
		groupBags();
		JPACK_STEP=JPACK_STARTED;
		JPackFrame:SetScript("OnUpdate",JPackFrame.OnUpdate);
	end
end

function shouldSaveToBank(bag,slot)
	local item=getJPackItem(bag,slot)
	return item~=nil and ((IndexOfTable(JPACK_DEPOSIT,"#"..item.type)>0) or (IndexOfTable(JPACK_DEPOSIT,"##"..item.subType)>0) or (IndexOfTable(JPACK_DEPOSIT,item.name)>0))
end

function shouldLoadFromBank(bag,slot)
	local item=getJPackItem(bag,slot)
	return item~=nil and ((IndexOfTable(JPACK_DRAW,"#"..item.type)>0) or (IndexOfTable(JPACK_DRAW,"##"..item.subType)>0) or (IndexOfTable(JPACK_DRAW,item.name)>0))
end

function getPrevSlot(bags,bag,slot)
	if(slot>1)then
		slot=slot-1
	elseif(bag>1)then
		bag=bag-1
		slot=GetContainerNumSlots(bags[bag])
	else
		bag=-1
	end
	return bag,slot
end

--保存到银行
function saveToBank()
	if(not JPack.bankOpened)then
		return ;
	end
	
	--保存
	for k,v in pairs(JPack.bankSlotTypes) do
		--针对每种不同的背包,k is type,v is slots
		local bkTypes,bagTypes=JPack.bankSlotTypes[k],JPack.bagSlotTypes[k]
		local bkBag,bag=table.getn(bkTypes),table.getn(bagTypes)
		local bkSlot,slot=GetContainerNumSlots(bkTypes[bkBag]),GetContainerNumSlots(bagTypes[bag])
		--保存
		while(true) do
			while(bkBag>0 and GetContainerItemLink(bkTypes[bkBag],bkSlot))do
				--直到找到一个空格
				bkBag,bkSlot=getPrevSlot(bkTypes,bkBag,bkSlot)
			end
			
			while(bag>0 and (not shouldSaveToBank(bagTypes[bag],slot)))do
				bag,slot=getPrevSlot(bagTypes,bag,slot)
			end
			
			if(bkBag<=0 or bag <=0 or bkSlot<=0 or slot<=0)then 
				debug("break to save")
				break;
			end
			if (CursorHasItem() or CursorHasMoney() or CursorHasSpell()) then
				print("JPack: \"鼠标上有物品。整理时不要抓起物品、金钱、法术.\"",2,0.28,2);
			end
			PickupContainerItem(bagTypes[bag],slot);
			PickupContainerItem(bkTypes[bkBag],bkSlot);
			--next
			bkBag,bkSlot=getPrevSlot(bkTypes,bkBag,bkSlot)
			bag,slot=getPrevSlot(bagTypes,bag,slot)
		end
	end
end

--从银行取出
function loadFromBank()
	if(not JPack.bankOpened)then
		return ;
	end
	
	--保存
	for k,v in pairs(JPack.bankSlotTypes) do
		--针对每种不同的背包,k is type,v is slots
		local bkTypes,bagTypes=JPack.bankSlotTypes[k],JPack.bagSlotTypes[k]
		local bkBag,bag=table.getn(bkTypes),table.getn(bagTypes)
		local bkSlot,slot=GetContainerNumSlots(bkTypes[bkBag]),GetContainerNumSlots(bagTypes[bag])
		--保存
		while(true) do
			while(bag>0 and GetContainerItemLink(bagTypes[bag],slot))do
				--直到找到一个空格
				bag,slot=getPrevSlot(bagTypes,bag,slot)
			end
			while(bkBag>0 and (not shouldLoadFromBank(bkTypes[bkBag],bkSlot)))do
				bkBag,bkSlot=getPrevSlot(bkTypes,bkBag,bkSlot)
			end
			
			if(bkBag<=0 or bag <=0 or bkSlot<=0 or slot<=0)then 
				break;
			end
			if (CursorHasItem() or CursorHasMoney() or CursorHasSpell()) then
				print("JPack: \"在整啥？整理时不要抓起物品、金钱、法术.\"",2,0.28,2);
			end
			PickupContainerItem(bkTypes[bkBag],bkSlot);
			PickupContainerItem(bagTypes[bag],slot);
			--next
			bkBag,bkSlot=getPrevSlot(bkTypes,bkBag,bkSlot)
			bag,slot=getPrevSlot(bagTypes,bag,slot)
		end
	end
end

function isBagReady(bag)
	for i=1,GetContainerNumSlots(bag) do
		local _, _, locked = GetContainerItemInfo(bag,i);
		if(locked)then return false end
	end
	return true
end

function isAllBagReady()
	for i=1,table.getn(JPack.bagGroups) do
		for j=1,table.getn(JPack.bagGroups[i]) do
			if(not isBagReady(JPack.bagGroups[i][j])) then return false; end
		end
	end
	return true;
end

--[[
将背包按类型分组
bagGroups
bankGroups
bagTypes
packingTypeIndex
packingBags
]]--
function groupBags()
	local bagTypes={}
	bagTypes[JPackLocale.TYPE_BAG]={}
	bagTypes[JPackLocale.TYPE_BAG][1]=0
	for i=1,4 do
		local name=GetBagName(i);
		if(name)then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, subType, itemStackCount,
itemEquipLoc, itemTexture = GetItemInfo(name)
			debug("Bag["..i.."]Type："..subType)
			if( i==1 and JPackLocale.locale ~= "zhCN")then
				print("Now only support zhCN well.For "..JPackLocale.locale..",I want you to send \"local="..JPackLocale.locale..";Bag[1]Type="..subType.."\" to guileen@gmail.com to make it better.")
			end
			if(bagTypes[subType]==nil)then
				bagTypes[subType]={}
			end
			local t = bagTypes[subType]
			t[table.getn(t)+1]=i
		end
	end

	local bankSlotTypes={}
	if(JPack.bankOpened)then
		bankSlotTypes[JPackLocale.TYPE_BAG]={}
		bankSlotTypes[JPackLocale.TYPE_BAG][1]=-1
		for i=5,11 do
			local name=GetBagName(i);
			if(name)then
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, subType, itemStackCount,
itemEquipLoc, itemTexture = GetItemInfo(name)
				if(bankSlotTypes[subType]==nil)then
					bankSlotTypes[subType]={}
				end
				local t = bankSlotTypes[subType]
				t[table.getn(t)+1]=i
			end
		end
	end
	JPack.bagSlotTypes=bagTypes;
	JPack.bankSlotTypes=bankSlotTypes;
	local j=1
	for k,v in pairs(bankSlotTypes) do
		JPack.bagGroups[j]=v
		j=j+1
	end
	--local j=table.getn(JPack.bagGroups)+1
	for k,v in pairs(bagTypes) do
		JPack.bagGroups[j]=v
		j=j+1
	end
	
end

function startPack()
	local items,count = getPackingItems()
	bagSize=count;
	local sorted = jsort(items)
	debug("sorted...")
	for i=1,table.getn(sorted) do
		debug(getCompareStr(sorted[i]))
	end
	sortTo(items,sorted)
end

function getJPackItem(bag,slot)
	local link = GetContainerItemLink(bag,slot) 
	if(link == nil)then return nil end
	local item={}
	item={}
	item.slotId=c;
	item.name, item.link, item.rarity, 
	item.level, item.minLevel, item.type, item.subType, item.stackCount,
	item.equipLoc, item.texture = GetItemInfo(link) 
	return item;
end

function getPackingItems()
	local c=1
	local items={}
	if(JPack.asc)then
		for i=1,table.getn(JPack.packingBags) do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			for j = 1,num do
				items[c]=getJPackItem(JPack.packingBags[i],j);
				c = c+1
			end
		end
	else
		for i=table.getn(JPack.packingBags),1,-1 do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			for j = num,1,-1 do
				items[c]=getJPackItem(JPack.packingBags[i],j);
				c = c+1
			end
		end
	end
	return items,c-1;	
end

--[[
将 PackIndex 转换为 BagId,SlotId
]]--
function getSlotId(packIndex)
	local slot=packIndex
	if(JPack.asc==true)then
		for i=1,table.getn(JPack.packingBags) do
			local num=GetContainerNumSlots(JPack.packingBags[i]) 
			if(slot<=num)then
				return JPack.packingBags[i],slot
			end
			slot = slot - num;
		end
	else
		for i=table.getn(JPack.packingBags),1,-1 do
			local num=GetContainerNumSlots(JPack.packingBags[i]) 
			if(slot<=num)then
				return JPack.packingBags[i],1+num-slot
			end
			slot = slot - num;
		end
	end
	return -1,-1
end

function moveTo(oldIndex,newIndex)
	PickupContainerItem(getSlotId(oldIndex));
	PickupContainerItem(getSlotId(newIndex));
end

--[[
比较两个物品
return 1 a 在前
return -1 b 在前
]]--
local function compare(a, b)
	local ret=0;
	if(a==b)then
		ret= 0
	elseif(a==nil)then
		ret= -1
	elseif(b==nil)then
		ret= 1
	elseif(a.name==b.name)then
		ret= 0
	else
		local sa = getCompareStr(a)
		local sb = getCompareStr(b)
		if(sa>sb)then
			--debug(sa.." compare to "..sb.." 1")
			ret= 1
		elseif(sa<sb) then
			--debug(sa.." compare to "..sb.." -1")
			ret= -1
		end
		--debug(sa.." compare to "..sb.." 0")
	end
	--print(JPack.asc);
	--ret=0-ret;
	--print(ret);
	return ret;
	--[[
	if(a.v>b.v)then
	    return 1
	elseif(a.v==b.v)then
	    return 0
	else
	    return -1
	end
	]]--
end

--Item[] itemsInBag = Item:new[64];

local function swap(items,i,j)
	local y=items[i];
	items[i]=items[j];
	items[j]=y;
end

local function qsort(items,from,to)

	local i,j=from,to;
	local ix=items[i];
	local x=i;
	while(i<j) do
		while(j>x) do
			if(compare(items[j], ix)==1)then
				swap(items,j,x);
				x=j;
      		else
   				j=j-1
			end
  		end
		while(i<x)do
			if(compare(items[i], ix)==-1)then
				swap(items,i,x);
				x=i;
			else
   				i=i+1
			end
  		end
 	end
	if(x-1 > from) then
		qsort(items,from,x-1)
	end
	if(x+1 < to) then
		qsort(items,x+1,to);
	end
end

function jsort(items)
	local clone = {};--Item:new[items.length];
	for i=1,bagSize do
		clone[i] = items[i];
	end
	qsort(clone,1,bagSize);
	return clone;
end

local current,to,lockedSlots;
function isLocked(index)
	local il=IndexOfTable(lockedSlots,index);
	local texture, itemCount, locked, quality, readable = GetContainerItemInfo(getSlotId(index));
	if(texture==nil)then
		--TODO:检查本地 locked,空格也可能被锁定
		locked= il >0
	elseif(il>0)then
		--lockedSlots[il]=nil
		table.remove(lockedSlots,il)
	end
	return locked
end

--[[
获取最后一个非移动物品的索引
]]--
function GetLastItemIndex(items,key)
	local i=bagSize;
	while(i>0)do
		--if(items[i] ~= nil and not items[i].moving and items[i].name == key)then
		if(items[i] ~= nil and not isLocked(i) and items[i].name == key)then
			return i;
		end
		i= i-1
	end
	return -1;
end

--[[
移动一次
]]--
function moveOnce()
	local continue=false;
	local i=1;
	local lockCount=0;
	while(to[i] ~=nil)do
		local locked=isLocked(i)
		if(locked==nil)then locked=false end
		if(locked)then
			lockCount=lockCount+1
		end
		if(lockCount>JPACK_MAXMOVE_ONCE)then
			return true;
		end
		--debug("to"..i.."="..to[i].name)
		--if(current[i] == nil or (to[i].name ~= current[i].name and not current[i].moving))then
		if(current[i] == nil or to[i].name ~= current[i].name)then
			continue = true
			if(not locked)then
				local slot =GetLastItemIndex(current, to[i].name);
				if(slot ~= -1)then
					--debug("move "..to[i].name.." from "..slot .." to "..i);
					moveTo(slot,i) -- 移动物品
					local x=current[slot];
					current[slot]=current[i];
					current[i]=x;
					if(current[slot]==nil)then
						--锁定空格
						lockedSlots[table.getn(lockedSlots)+1]=i
					end
				end
			end
			
		end
		i=i+1
	end
	--debug("move once. lockCount = "..lockCount)
	return continue or lockCount>0
end

JPackFrame=CreateFrame("Frame",nil,UIParent)

local moving=false;
function sortTo(_current, _to)
	current=_current
	to=_to
	lockedSlots={}
	JPACK_STEP=JPACK_PACKING;
end

PackOnBagOpen=true
function JPackFrame:OnEvent()
	debug(event)
	if(event=="VARIABLES_LOADED")then
		self:Init();
	elseif(event=="BAG_OPEN")then
		if(PackOnBagOpen)then
			pack()
		end
	elseif(event=="BANKFRAME_OPENED")then
		JPack.bankOpened=true
		debug("bank opened")
	elseif(event=="BANKFRAME_CLOSED")then
		JPack.bankOpened=false
		debug("bank closed")
	end
end

function JPackFrame:OnUpdate()
	--debug("JPACK_STEP="..JPACK_STEP)
	if(JPACK_STEP==JPACK_STARTED)then
		if(isAllBagReady())then
			debug("JPACK准备完毕,JPack_STEP="..JPACK_STEP);
			if(JPack.deposit)then
				saveToBank()
			end
			JPACK_STEP=JPACK_DEPOSITING
		end
	elseif(JPACK_STEP==JPACK_DEPOSITING)then
		if(isAllBagReady())then
			debug("保存物品完毕,JPack_STEP="..JPACK_STEP);
			if(JPack.draw)then
				loadFromBank()
			end
			JPACK_STEP=JPACK_DRAWING
		end
	elseif(JPACK_STEP==JPACK_DRAWING)then
		if(isAllBagReady())then
			debug("提取物品完毕,JPack_STEP="..JPACK_STEP);
			JPACK_STEP=JPACK_STACKING
			Stackpack_Command("start")
		end
	elseif(JPACK_STEP==JPACK_STACK_OVER)then
		debug("堆叠完毕,开始整理,JPACK_STEP="..JPACK_STEP)
		if(isAllBagReady)then
			--groupBags()
			JPack.packingGroupIndex=1
			JPack.packingBags=JPack.bagGroups[1]
			--计算排序
			startPack();
			JPACK_STEP=JPACK_PACKING
		end
	elseif(JPACK_STEP==JPACK_PACKING)then
		--排序结束
		--移动物品
		local oncePacking=moveOnce()
		if(not oncePacking)then
			JPack.packingGroupIndex=JPack.packingGroupIndex + 1
			debug("index"..JPack.packingGroupIndex)
			JPack.packingBags=JPack.bagGroups[JPack.packingGroupIndex]
			debug("JPack.bagGroups . size = "..table.getn(JPack.bagGroups))
			for i=1,table.getn(JPack.bagGroups) do
				for j=1,table.getn(JPack.bagGroups[i]) do
					debug("i"..i.."j"..j..":"..JPack.bagGroups[i][j])
				end
			end
			if(JPack.packingBags==nil)then
				--整理结束
				JPACK_STEP=JPACK_STOPPED;
				JPack.bagGroups={}
				print("Pack up complete...")
				JPackFrame:SetScript("OnUpdate",nil);
				current=nil
				to=nil
			else
				debug("Packing "..JPack.packingGroupIndex)
				startPack()
			end
		end
	end
end

--JPackFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
JPackFrame:RegisterEvent("VARIABLES_LOADED")
JPackFrame:RegisterEvent("UPDATE_FACTION")

JPackFrame:SetScript("OnEvent",JPackFrame.OnEvent);

function JPackFrame:Init()
	print("已加载JPack "..version..". 输入'/jpack help'获取帮助.");
	JPackFrame:RegisterEvent("BAG_OPEN")
	JPackFrame:RegisterEvent("BANKFRAME_OPENED")
	JPackFrame:RegisterEvent("BANKFRAME_CLOSED")	
	SlashCmdList["JPACK"] = JPackFrame_Slash
	SLASH_JPACK1 = "/jpack"
	SLASH_JPACK2 = "/jp"
end

function JPackFrame_Slash(msg)
	local a,b,c=strfind(msg, "(%S+)");
	if(a~=nil)then
		--debug('a='..a..' b='..b..' c='..c);
	end
	
	JPack.deposit=false
	JPack.draw=false
	
	if(c=="asc")then
		JPack.asc=true
	elseif(c=="desc")then
		JPack.asc=false
	elseif(c=="deposit" or c=="save")then
		JPack.deposit=true
	elseif(c=="draw" or c=="load")then
		JPack.draw=true
	elseif(c=="debug")then
		JPACK_DEBUG=true
		return;
	elseif(c=="nodebug")then
		JPACK_DEBUG=false
		return;
	elseif(c=="help")then
		print("你可以修改Interface/Addons/JPack/JPackConfig.lua来调整物品整理顺序");
		print("/jpack /jp 按上一次的整理顺序整理");
		print("/jp asc 正序整理");
		print("/jp desc 逆序整理");
		print("/jp deposit 或 save 保存到银行");
		print("/jp draw 或 load 从银行取出");
		print("/jp debug 显示调试信息，用于查看背包及物品分类信息");
		print("/jp nodebug 关闭调试信息");
		return;
	end
	pack();
end
