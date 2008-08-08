--[[

$Revision: 75739 $

(C) Copyright 2007,2008 Bethink (bethink at naef dot com)

This file is part of Analyst.

Analyst is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Analyst is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Leser General Public License
along with Analyst. If not, see <http://www.gnu.org/licenses/>.

]]


----------------------------------------------------------------------
-- Initialization

local L = AceLibrary("AceLocale-2.2"):new("Analyst")


----------------------------------------------------------------------
-- Translations

L:RegisterTranslations("zhCN", function () return {
	-- Slsah commands
	["SLASH_COMMANDS"] = { "/analyst" },
	["ECONOMY"] = "经济分析面板",
	["ECONOMY_DESC"] = "开启/关闭 经济分析面板。",
	["START_DAY_OF_WEEK"] = "周起始日",
	["START_DAY_OF_WEEK_DESC"] = "设置周统计起始日(1-7)，1 代表周一。",
	["SHOW_GOLD"] = "显示金钱变化",
	["SHOW_GOLD_DESC"] = "设置是否在标题中显示金钱获取/花费之数量。",
	["ECONOMY_FRAME_HINT"] = "|cFFFFFF00点击|r - 开启/关闭 经济分析面板.",

	-- Bindings
	["BINDING_HEADER_ANALYST"] = "经济活动分析",
	["BINDING_NAME_ECONOMY"] = "开启/关闭 经济分析面板",
	
	-- Crafts
	["Enchanting"] = "附魔", -- Enchanting craft
	
	-- Trade skill lines
	["Alchemy"] = "炼金术",
	["Blacksmithing"] = "锻造",
	["Cooking"] = "烹饪",
	["First Aid"] = "急救",
	["Jewelcrafting"] = "珠宝加工",
	["Leatherworking"] = "制皮",
	["Tailoring"] = "裁缝",
	
	-- Trade skill spells
	["Extract Gas"] = "提炼气体", -- Extract gas skill
	["Fishing"] = "钓鱼", -- Fishing skill
	["Herb Gathering"] = "采集草药", -- Herb gathering skill
	["Mining"] = "采矿", -- Mining skill
	["Disenchant"] = "分解", -- Disenchanting skill
	["Prospecting"] = "选矿", -- Prospecting skill
	["Skinning"] = "剥皮", -- Skinning skill
	
	-- Generic spells
	["Opening"] = "开启", -- Opening
	
	-- Purchases
	["BANK_SLOT"] = "银行栏位",
	["PETITION"] = "申请",
	["GUILD_CHARTER"] = "公会登记表",
	["GUILD_CREST"] = "公会徽章",
	["STABLE_SLOT"] = "宠物存放栏位",
	["GUILD_BANK_TAB"] = "公会银行栏页",
	
	-- Capture
	["GROUPED"] = "(队伍/团队)",
	
-- Measures
	["MONEY_GAINED_TOTAL"] = "获得总额",
	["MONEY_GAINED_QUESTING"] = "任务",
	["MONEY_GAINED_LOOTING"] = "拾取",
	["MONEY_GAINED_OPENING"] = "开启",
	["MONEY_GAINED_SELLING"] = "商人-卖出",
	["MONEY_GAINED_AUCTION"] = "拍卖行",
	["MONEY_GAINED_GUILD_BANKING"] = "公会银行",
	["MONEY_GAINED_TRADING"] = "交易",
	["MONEY_GAINED_RECEIVING"] = "邮件",
	["MONEY_GAINED_MISCELLANEOUS"] = "杂项",
	["MONEY_SPENT_TOTAL"] = "花费总额",
	["MONEY_SPENT_QUESTING"] = "任务",
	["MONEY_SPENT_BUYING"] = "商人-购入",
	["MONEY_SPENT_TRAINING"] = "训练师",
	["MONEY_SPENT_PURCHASING"] = "购买",
	["MONEY_SPENT_REPAIRING"] = "修复",
	["MONEY_SPENT_TAXI"] = "空运",
	["MONEY_SPENT_AUCTION"] = "拍卖行",
	["MONEY_SPENT_GUILD_BANKING"] = "公会银行",
	["MONEY_SPENT_TRADING"] = "交易",
	["MONEY_SPENT_SENDING"] = "邮件",
	["MONEY_SPENT_MISCELLANEOUS"] = "杂项",
	["ITEM_CONSUMED_QUESTING"] = "任务",
	["ITEM_CONSUMED_CASTING"] = "施放", 
	["ITEM_CONSUMED_USING"] = "使用",
	["ITEM_CONSUMED_OPENING"] = "开启",
	["ITEM_CONSUMED_CRAFTING"] = "专业技能",
	["ITEM_CONSUMED_SOCKETING"] = "宝石插槽", -- need check
	["ITEM_CONSUMED_DESTROYING"] = "摧毁",
	["ITEM_CONSUMED_SENDING"] = "寄送邮件",
	["ITEM_CONSUMED_MISCELLANEOUS"] = "杂项",
	["ITEM_PRODUCED_QUESTING"] = "任务",
	["ITEM_PRODUCED_CASTING"] = "施放", 
	["ITEM_PRODUCED_USING"] = "使用",
	["ITEM_PRODUCED_OPENING"] = "开启",
	["ITEM_PRODUCED_CRAFTING"] = "专业技能",
	["ITEM_PRODUCED_GATHERING"] = "采集",
	["ITEM_PRODUCED_LOOTING"] = "拾取",
	["ITEM_PRODUCED_BATTLEFIELD"] = "战场",
	["ITEM_PRODUCED_RECEIVING"] = "接收邮件",
	["ITEM_PRODUCED_MISCELLANEOUS"] = "杂项",
	["QUESTING_FINISHED"] = "完成任务",
	["QUESTING_MONEY_GAINED"] = "获得金额",
	["QUESTING_MONEY_SPENT"] = "花费金额",
	["QUESTING_ITEM_PRODUCED"] = "拾取物品",
	["QUESTING_ITEM_CONSUMED"] = "消耗物品",
	["LOOTING_MOB"] = "怪物",
	["LOOTING_MONEY"] = "金钱",
	["LOOTING_ITEM"] = "物品",
	["LOOTING_ITEM_VENDOR_VALUE"] = "商人收购价",
	["MERCHANT_MONEY_GAINED"] = "卖出",
	["MERCHANT_MONEY_SPENT_BUYING"] = "购入",
	["MERCHANT_MONEY_SPENT_REPAIRING"] = "修复",
	["MERCHANT_ITEM_SOLD"] = "物品卖出",
	["MERCHANT_ITEM_BOUGHT"] = "物品购入",
	["MERCHANT_ITEM_SWAPED"] = "物品交易",
	["AUCTION_POSTED"] = "拍卖-公告",
	["AUCTION_SOLD"] = "拍卖-卖出",
	["AUCTION_EXPIRED"] = "拍卖-过期",
	["AUCTION_CANCELLED"] = "拍卖-取消",
	["AUCTION_MONEY_GAINED"] = "收款金额",
	["AUCTION_DEPOSIT_PAID"] = "公告保证金",
	["AUCTION_DEPOSIT_CREDITED"] = "退回保证金", 
	["AUCTION_CONSIGNMENT"] = "拍卖费", 
	["AUCTION_BID"] = "拍卖-出价",
	["AUCTION_BOUGHT"] = "拍卖-购入",
	["AUCTION_OUTBID"] = "拍卖-竞价",
	["AUCTION_MONEY_SPENT"] = "付费金额",
	["GUILD_BANKING_MONEY_WITHDRAWN"] = "提款",
	["GUILD_BANKING_MONEY_DEPOSITED"] = "存款",
	["GUILD_BANKING_ITEM_WITHDRAWN"] = "提领物品",
	["GUILD_BANKING_ITEM_DEPOSITED"] = "存入物品",
	["TRADING_MONEY_RECEIVED"] = "获取金额",
	["TRADING_MONEY_GIVEN"] = "赠予金额",
	["TRADING_ITEM_RECEIVED"] = "获取物品",
	["TRADING_ITEM_GIVEN"] = "赠予物品",
	["CRAFTING_TOTAL"] = "专业技能活动",
	["CRAFTING_ALCHEMY"] = "炼金术",
	["CRAFTING_BLACKSMITHING"] = "锻造",
	["CRAFTING_COOKING"] = "烹饪",
	["CRAFTING_DISENCHANTING"] = "分解",
	["CRAFTING_ENCHANTING"] = "附魔",
	["CRAFTING_FIRST_AID"] = "急救",
	["CRAFTING_JEWELCRAFTING"] = "珠宝加工",
	["CRAFTING_LEATHERWORKING"] = "制皮",
	["CRAFTING_PROSPECTING"] = "选矿",
	["CRAFTING_SMELTING"] = "熔炼",
	["CRAFTING_TAILORING"] = "裁缝",
	["GATHERING_TOTAL"] = "采集活动",
	["GATHERING_EXTRACT_GAS"] = "提炼气体",
	["GATHERING_FISHING"] = "钓鱼",
	["GATHERING_HERB_GATHERING"] = "采集草药",
	["GATHERING_MINING"] = "采矿",
	["GATHERING_SKINNING"] = "剥皮",
	
	-- Measures
	["AUTOMATED"] = "(自动化)",
	
	-- Reports
	["OVERVIEW"] = "综览",
	["MONEY_GAINED"] = "获得金额",
	["MONEY_SPENT"] = "花费金额",
	["ITEM_CONSUMED"] = "消耗物品",
	["ITEM_PRODUCED"] = "获得物品",
	["QUESTING"] = "任务",
	["LOOTING"] = "拾取",
	["MERCHANT"] = "商人",
	["AUCTION"] = "拍卖行",
	["GUILD_BANK"] = "公会银行",
	["TRADING"] = "交易",
	["CRAFTING"] = "专业技能",
	["GATHERING"] = "采集",
	
	-- Measure
	["TALENT_WIPING"] = "遗忘天赋",
	
	-- Periods
	["TODAY"] = "今天",
	["YESTERDAY"] = "昨天",
	["THIS_WEEK"] = "本周",
	["THIS_MONTH"] = "本月",
	["LAST_7_DAYS"] = "最后 7 天",
	["LAST_30_DAYS"] = "最后 30 天",
	
	-- Economy frame
	["ECONOMY_FRAME_TITLE"] = "经济活动分析",
	["ALL_CHARACTERS"] = "所有角色",
	["ALL_CHARACTERS_TOOLTIP"] = "如选取，显示所有角色的帐目资料。如未选取，仅显示目前角色的帐目资料。",
	["NO_DETAIL_INFO"] = "無可用的详细资讯。",
	["CONSUMED"] = "消耗",
	["PRODUCED"] = "拾取",
} end)
