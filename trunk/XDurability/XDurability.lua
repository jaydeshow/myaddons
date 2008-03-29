
local IsDebug = false;

local function ShowDebugMsg(msg)
    if IsDebug then
        DEFAULT_CHAT_FRAME:AddMessage(msg or "NULL");
    end
end
----------------------------------------------------------------------------------------------------------------------------

local XD = {Cost = 0, Dur = 0, ItemCntr = 0};


-- 保存装备槽中文字的实例, 这样就无需重复创建了.
local XD_TextInst = {};

-- 各装备槽的名称及ID.
local XD_Slots = {
			["CharacterHeadSlot"] 			= 1, 	-- 头
			["CharacterShoulderSlot"] 		= 3, 	-- 肩
			["CharacterChestSlot"]			= 5, 	-- 胸甲
			["CharacterWristSlot"]			= 9, 	-- 护腕
			["CharacterHandsSlot"]			= 10,	-- 手套
			["CharacterWaistSlot"]			= 6, 	-- 腰带
			["CharacterLegsSlot"]			= 7, 	-- 腿
			["CharacterFeetSlot"]			= 8, 	-- 靴子
			["CharacterMainHandSlot"]		= 16,	-- 主手
			["CharacterSecondaryHandSlot"]	= 17, 	-- 副手
			["CharacterRangedSlot"]			= 18	-- 远程
};

-- 创建匹配字符串
local XD_Pattern = string.gsub(DURABILITY_TEMPLATE, "%%d", "(%%d+)");

----------------------------------------------------------------------------------------------------------------------------
-- 获取文字实例,没有则创建.
local function XD_GetTextInst(name)
	if(not XD_TextInst[name]) then
		XD_TextInst[name] = CreateFrame("Frame", name .. "Durability", getglobal(name), "XDurabilityText");
	end
	return XD_TextInst[name];
end

---------------------------------------------------------------------------
-- 匹配text,若找到则在指定的装备槽上显示耐久度.
local function XD_SetText(text, slotName)
    if(not text) then return end
	
    local _, _, curr, maxVal = string.find(text, XD_Pattern);
	if(curr and maxVal) then -- 包含了maxVal不等于0的条件.
		percent = curr / maxVal;
		local text = getglobal(slotName .. "DurabilityText");
		text:SetTextColor(1 - percent, percent, 0);
		text:SetText(ceil(percent * 100) .. "%");

		XD.Dur = XD.Dur + percent;
		XD.ItemCntr = XD.ItemCntr + 1;
	end
end
-----------------------------------------------------------------------------
-- 创建显示平均耐久度和修理费的Frame.
function XD_CreateFrame()
	local dft = getglobal("XDurabilityFullText");
	local percent = XD.Dur/XD.ItemCntr;
	dft:SetTextColor(1 - percent, percent, 0);
	dft:SetText(ceil(percent*100) .. "%");

	local ct = getglobal("XDurabilityCostText");
	local cost = ceil(XD.Cost/100);
	ct:SetText(cost/100 .. "G");
end
-----------------------------------------------------------------------------
function XD_OnLoad()
    this:RegisterEvent("UNIT_INVENTORY_CHANGED");
    this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--this:RegisterEvent("MERCHANT_UPDATE"); -- 修理不触发此事件！！！
	this:RegisterEvent("MERCHANT_CLOSED"); -- 关闭交易窗口时，更新状态
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("PLAYER_UNGHOST");
end

-----------------------------------------------------------------------------
function XD_OnEvent(event)
	ShowDebugMsg("xdurrability" .. event);
    local tp = XD_Tooltip;
	XD.Cost = 0;
	XD.Dur = 0;
	XD.ItemCntr = 0;
    for i, v in pairs(XD_Slots) do
		tp:SetOwner(this, "ANCHOR_RIGHT");
		-- 为空?,   xx,   修理费
        local has, _, cost = tp:SetInventoryItem("player", v);
		local frame = XD_GetTextInst(i);
		frame:Hide();
        if(has) then
			frame:Show();
            XD.Cost = XD.Cost + cost;
            local cntr = tp:NumLines();
            for line=0, cntr do
                local lineText = getglobal(tp:GetName().."TextLeft"..line);
                if(lineText) then XD_SetText(lineText:GetText(), i); end
            end
        end -- if(has)
    end
	XD_CreateFrame();
	tp:ClearLines();
    tp:Hide();
end
