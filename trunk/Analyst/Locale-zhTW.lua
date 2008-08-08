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

L:RegisterTranslations("zhTW", function () return {
	-- Slsah commands
	["SLASH_COMMANDS"] = { "/analyst" },
	["ECONOMY"] = "經濟分析面板",
	["ECONOMY_DESC"] = "開啟/關閉 經濟分析面板。",
	["START_DAY_OF_WEEK"] = "週起始日",
	["START_DAY_OF_WEEK_DESC"] = "設定週的起始日(1-7)，1 代表週一。",
	["SHOW_GOLD"] = "顯示金錢變化",
	["SHOW_GOLD_DESC"] = "設定是否在標題中顯示金錢獲取/花費之數量。",
	["ECONOMY_FRAME_HINT"] = "|cFFFFFF00點擊|r - 開啟/關閉 經濟分析面板.",

	-- Bindings
	["BINDING_HEADER_ANALYST"] = "經濟活動分析",
	["BINDING_NAME_ECONOMY"] = "開啟/關閉 經濟分析面板",
	
	-- Crafts
	["Enchanting"] = "附魔", -- Enchanting craft
	
	-- Trade skill lines
	["Alchemy"] = "鍊金術",
	["Blacksmithing"] = "鍛造",
	["Cooking"] = "烹飪",
	["First Aid"] = "急救",
	["Jewelcrafting"] = "珠寶設計",
	["Leatherworking"] = "製皮",
	["Tailoring"] = "裁縫",
	
	-- Trade skill spells
	["Extract Gas"] = "提煉氣體雲", -- Extract gas skill
	["Fishing"] = "釣魚", -- Fishing skill
	["Herb Gathering"] = "採集草藥", -- Herb gathering skill
	["Mining"] = "採礦", -- Mining skill
	["Disenchant"] = "分解", -- Disenchanting skill
	["Prospecting"] = "勘探", -- Prospecting skill
	["Skinning"] = "剝皮", -- Skinning skill
	
	-- Generic spells
	["Opening"] = "開啟", -- Opening
	
	-- Purchases
	["BANK_SLOT"] = "銀行欄位",
	["PETITION"] = "申請",
	["GUILD_CHARTER"] = "公會登記表",
	["GUILD_CREST"] = "公會徽章",
	["STABLE_SLOT"] = "寵物存放欄位",
	["GUILD_BANK_TAB"] = "公會銀行欄頁",
	
	-- Capture
	["GROUPED"] = "(隊伍/團隊)",
	
-- Measures
	["MONEY_GAINED_TOTAL"] = "獲得總額",
	["MONEY_GAINED_QUESTING"] = "任務",
	["MONEY_GAINED_LOOTING"] = "拾取",
	["MONEY_GAINED_OPENING"] = "開啟",
	["MONEY_GAINED_SELLING"] = "商人-賣出",
	["MONEY_GAINED_AUCTION"] = "拍賣場",
	["MONEY_GAINED_GUILD_BANKING"] = "公會銀行",
	["MONEY_GAINED_TRADING"] = "交易",
	["MONEY_GAINED_RECEIVING"] = "郵件",
	["MONEY_GAINED_MISCELLANEOUS"] = "雜項",
	["MONEY_SPENT_TOTAL"] = "花費總額",
	["MONEY_SPENT_QUESTING"] = "任務",
	["MONEY_SPENT_BUYING"] = "商人-購入",
	["MONEY_SPENT_TRAINING"] = "訓練師",
	["MONEY_SPENT_PURCHASING"] = "購買",
	["MONEY_SPENT_REPAIRING"] = "修復",
	["MONEY_SPENT_TAXI"] = "空運",
	["MONEY_SPENT_AUCTION"] = "拍賣場",
	["MONEY_SPENT_GUILD_BANKING"] = "公會銀行",
	["MONEY_SPENT_TRADING"] = "交易",
	["MONEY_SPENT_SENDING"] = "郵件",
	["MONEY_SPENT_MISCELLANEOUS"] = "雜項",
	["ITEM_CONSUMED_QUESTING"] = "任務",
	["ITEM_CONSUMED_CASTING"] = "施放", 
	["ITEM_CONSUMED_USING"] = "使用",
	["ITEM_CONSUMED_OPENING"] = "開啟",
	["ITEM_CONSUMED_CRAFTING"] = "專業技能",
	["ITEM_CONSUMED_SOCKETING"] = "寶石插槽", -- need check
	["ITEM_CONSUMED_DESTROYING"] = "摧毀",
	["ITEM_CONSUMED_SENDING"] = "寄送郵件",
	["ITEM_CONSUMED_MISCELLANEOUS"] = "雜項",
	["ITEM_PRODUCED_QUESTING"] = "任務",
	["ITEM_PRODUCED_CASTING"] = "施放", 
	["ITEM_PRODUCED_USING"] = "使用",
	["ITEM_PRODUCED_OPENING"] = "開啟",
	["ITEM_PRODUCED_CRAFTING"] = "專業技能",
	["ITEM_PRODUCED_GATHERING"] = "採集",
	["ITEM_PRODUCED_LOOTING"] = "拾取",
	["ITEM_PRODUCED_BATTLEFIELD"] = "戰場",
	["ITEM_PRODUCED_RECEIVING"] = "接收郵件",
	["ITEM_PRODUCED_MISCELLANEOUS"] = "雜項",
	["QUESTING_FINISHED"] = "完成任務",
	["QUESTING_MONEY_GAINED"] = "獲得金額",
	["QUESTING_MONEY_SPENT"] = "花費金額",
	["QUESTING_ITEM_PRODUCED"] = "拾取物品",
	["QUESTING_ITEM_CONSUMED"] = "消耗物品",
	["LOOTING_MOB"] = "怪物",
	["LOOTING_MONEY"] = "金錢",
	["LOOTING_ITEM"] = "物品",
	["LOOTING_ITEM_VENDOR_VALUE"] = "商人收購價",
	["MERCHANT_MONEY_GAINED"] = "賣出",
	["MERCHANT_MONEY_SPENT_BUYING"] = "購入",
	["MERCHANT_MONEY_SPENT_REPAIRING"] = "修復",
	["MERCHANT_ITEM_SOLD"] = "物品賣出",
	["MERCHANT_ITEM_BOUGHT"] = "物品購入",
	["MERCHANT_ITEM_SWAPED"] = "物品交易",
	["AUCTION_POSTED"] = "拍賣-公告",
	["AUCTION_SOLD"] = "拍賣-賣出",
	["AUCTION_EXPIRED"] = "拍賣-過期",
	["AUCTION_CANCELLED"] = "拍賣-取消",
	["AUCTION_MONEY_GAINED"] = "收款金額",
	["AUCTION_DEPOSIT_PAID"] = "公告保證金",
	["AUCTION_DEPOSIT_CREDITED"] = "退回保證金", 
	["AUCTION_CONSIGNMENT"] = "拍賣費", 
	["AUCTION_BID"] = "拍賣-出價",
	["AUCTION_BOUGHT"] = "拍賣-購入",
	["AUCTION_OUTBID"] = "拍賣-競價",
	["AUCTION_MONEY_SPENT"] = "付費金額",
	["GUILD_BANKING_MONEY_WITHDRAWN"] = "提款",
	["GUILD_BANKING_MONEY_DEPOSITED"] = "存款",
	["GUILD_BANKING_ITEM_WITHDRAWN"] = "提領物品",
	["GUILD_BANKING_ITEM_DEPOSITED"] = "存入物品",
	["TRADING_MONEY_RECEIVED"] = "獲取金額",
	["TRADING_MONEY_GIVEN"] = "贈與金額",
	["TRADING_ITEM_RECEIVED"] = "獲取物品",
	["TRADING_ITEM_GIVEN"] = "贈與物品",
	["CRAFTING_TOTAL"] = "專業技能活動",
	["CRAFTING_ALCHEMY"] = "鍊金術",
	["CRAFTING_BLACKSMITHING"] = "鍛造",
	["CRAFTING_COOKING"] = "烹飪",
	["CRAFTING_DISENCHANTING"] = "分解",
	["CRAFTING_ENCHANTING"] = "附魔",
	["CRAFTING_FIRST_AID"] = "急救",
	["CRAFTING_JEWELCRAFTING"] = "珠寶設計",
	["CRAFTING_LEATHERWORKING"] = "製皮",
	["CRAFTING_PROSPECTING"] = "勘探",
	["CRAFTING_SMELTING"] = "熔煉",
	["CRAFTING_TAILORING"] = "裁縫",
	["GATHERING_TOTAL"] = "採集活動",
	["GATHERING_EXTRACT_GAS"] = "提煉氣體雲",
	["GATHERING_FISHING"] = "釣魚",
	["GATHERING_HERB_GATHERING"] = "採集草藥",
	["GATHERING_MINING"] = "採礦",
	["GATHERING_SKINNING"] = "剝皮",
	
	-- Measures
	["AUTOMATED"] = "(自動化)",
	
	-- Reports
	["OVERVIEW"] = "綜覽",
	["MONEY_GAINED"] = "獲得金額",
	["MONEY_SPENT"] = "花費金額",
	["ITEM_CONSUMED"] = "消耗物品",
	["ITEM_PRODUCED"] = "獲得物品",
	["QUESTING"] = "任務",
	["LOOTING"] = "拾取",
	["MERCHANT"] = "商人",
	["AUCTION"] = "拍賣場",
	["GUILD_BANK"] = "公會銀行",
	["TRADING"] = "交易",
	["CRAFTING"] = "專業技能",
	["GATHERING"] = "採集",
	
	-- Measure
	["TALENT_WIPING"] = "遺忘天賦",
	
	-- Periods
	["TODAY"] = "今天",
	["YESTERDAY"] = "昨天",
	["THIS_WEEK"] = "本週",
	["THIS_MONTH"] = "本月",
	["LAST_7_DAYS"] = "最後 7 天",
	["LAST_30_DAYS"] = "最後 30 天",
	
	-- Economy frame
	["ECONOMY_FRAME_TITLE"] = "經濟活動分析",
	["ALL_CHARACTERS"] = "所有角色",
	["ALL_CHARACTERS_TOOLTIP"] = "如選取，顯示所有角色的帳目資料。如未選取，僅顯示目前角色的帳目資料。",
	["NO_DETAIL_INFO"] = "無可用的詳細資訊。",
	["CONSUMED"] = "消耗",
	["PRODUCED"] = "拾取",
} end)
