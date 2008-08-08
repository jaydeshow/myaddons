--[[

$Revision: 74221 $

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

L:RegisterTranslations("enUS", function () return {
	-- Slsah commands
	["SLASH_COMMANDS"] = { "/analyst" },
	["ECONOMY"] = "Economy Panel",
	["ECONOMY_DESC"] = "Toggles the Economy panel.",
	["START_DAY_OF_WEEK"] = "Start Day of Week",
	["START_DAY_OF_WEEK_DESC"] = "Sets the start day of the week (1-7), with 1 representing Monday.",
	["SHOW_GOLD"] = "Show Gold Change",
	["SHOW_GOLD_DESC"] = "Sets whether to show the amount of gold gained or spent in the title.",
	["ECONOMY_FRAME_HINT"] = "|cFFFFFF00Click|r to toggle the Economy panel.",

	-- Bindings
	["BINDING_HEADER_ANALYST"] = "Analyst",
	["BINDING_NAME_ECONOMY"] = "Toggle Economy Panel",
	
	-- Crafts
	["Enchanting"] = true, -- Enchanting craft
	
	-- Trade skill lines
	["Alchemy"] = true,
	["Blacksmithing"] = true,
	["Cooking"] = true,
	["First Aid"] = true,
	["Jewelcrafting"] = true,
	["Leatherworking"] = true,
	["Tailoring"] = true,
	
	-- Trade skill spells
	["Extract Gas"] = true, -- Extract gas skill
	["Fishing"] = true, -- Fishing skill
	["Herb Gathering"] = true, -- Herb gathering skill
	["Mining"] = true, -- Mining skill
	["Disenchant"] = true, -- Disenchanting skill
	["Prospecting"] = true, -- Prospecting skill
	["Skinning"] = true, -- Skinning skill
	
	-- Generic spells
	["Opening"] = true, -- Opening
	
	-- Purchases
	["BANK_SLOT"] = "Bank Slot",
	["PETITION"] = "Petition",
	["GUILD_CHARTER"] = "Guild Charter",
	["GUILD_CREST"] = "Guild Crest",
	["STABLE_SLOT"] = "Stable Slot",
	["GUILD_BANK_TAB"] = "Guild Bank Tab",
	
	-- Capture
	["GROUPED"] = "(Grouped)",
	
	-- Measures
	["MONEY_GAINED_TOTAL"] = "Total Gold Gained",
	["MONEY_GAINED_QUESTING"] = "Questing",
	["MONEY_GAINED_LOOTING"] = "Looting",
	["MONEY_GAINED_OPENING"] = "Opening",
	["MONEY_GAINED_SELLING"] = "Vendor Selling",
	["MONEY_GAINED_AUCTION"] = "Auctions",
	["MONEY_GAINED_GUILD_BANKING"] = "Guild Bank",
	["MONEY_GAINED_TRADING"] = "Trading",
	["MONEY_GAINED_RECEIVING"] = "Mail",
	["MONEY_GAINED_MISCELLANEOUS"] = "Miscellaneous",
	["MONEY_SPENT_TOTAL"] = "Total Gold Spent",
	["MONEY_SPENT_QUESTING"] = "Questing",
	["MONEY_SPENT_BUYING"] = "Vendor Buying",
	["MONEY_SPENT_TRAINING"] = "Trainer",
	["MONEY_SPENT_PURCHASING"] = "Purchases",
	["MONEY_SPENT_REPAIRING"] = "Repairing",
	["MONEY_SPENT_TAXI"] = "Flights",
	["MONEY_SPENT_AUCTION"] = "Auctions",
	["MONEY_SPENT_GUILD_BANKING"] = "Guild Bank",
	["MONEY_SPENT_TRADING"] = "Trading",
	["MONEY_SPENT_SENDING"] = "Mail",
	["MONEY_SPENT_MISCELLANEOUS"] = "Miscellaneous",
	["ITEM_CONSUMED_QUESTING"] = "Questing",
	["ITEM_CONSUMED_CASTING"] = "Casting",
	["ITEM_CONSUMED_USING"] = "Using",
	["ITEM_CONSUMED_OPENING"] = "Opening",
	["ITEM_CONSUMED_CRAFTING"] = "Crafting",
	["ITEM_CONSUMED_SOCKETING"] = "Socketing",
	["ITEM_CONSUMED_DESTROYING"] = "Destroyed",
	["ITEM_CONSUMED_SENDING"] = "Sent by Mail",
	["ITEM_CONSUMED_MISCELLANEOUS"] = "Miscellaneous",
	["ITEM_PRODUCED_QUESTING"] = "Questing",
	["ITEM_PRODUCED_CASTING"] = "Casting",
	["ITEM_PRODUCED_USING"] = "Using",
	["ITEM_PRODUCED_OPENING"] = "Opening",
	["ITEM_PRODUCED_CRAFTING"] = "Crafting",
	["ITEM_PRODUCED_GATHERING"] = "Gathering",
	["ITEM_PRODUCED_LOOTING"] = "Looting",
	["ITEM_PRODUCED_BATTLEFIELD"] = "Battleground",
	["ITEM_PRODUCED_RECEIVING"] = "Received by Mail",
	["ITEM_PRODUCED_MISCELLANEOUS"] = "Miscellaneous",
	["QUESTING_FINISHED"] = "Quests Finished",
	["QUESTING_MONEY_GAINED"] = "Gold Gained",
	["QUESTING_MONEY_SPENT"] = "Gold Spent",
	["QUESTING_ITEM_PRODUCED"] = "Items Produced",
	["QUESTING_ITEM_CONSUMED"] = "Items Consumed",
	["LOOTING_MOB"]= "Mobs",
	["LOOTING_MONEY"] = "Gold",
	["LOOTING_ITEM"] = "Items",
	["LOOTING_ITEM_VENDOR_VALUE"] = "Vendor Value",
	["MERCHANT_MONEY_GAINED"] = "Sales",
	["MERCHANT_MONEY_SPENT_BUYING"] = "Buying",
	["MERCHANT_MONEY_SPENT_REPAIRING"] = "Repairing",
	["MERCHANT_ITEM_SOLD"] = "Items Sold",
	["MERCHANT_ITEM_BOUGHT"] = "Items Bought",
	["MERCHANT_ITEM_SWAPED"] = "Items Swaped",
	["AUCTION_POSTED"] = "Auctions Posted",
	["AUCTION_SOLD"] = "Auctions Sold",
	["AUCTION_EXPIRED"] = "Auctions Expired",
	["AUCTION_CANCELLED"] = "Auctions Cancelled",
	["AUCTION_MONEY_GAINED"] = "Gold Gained",
	["AUCTION_DEPOSIT_PAID"] = "Deposit",
	["AUCTION_DEPOSIT_CREDITED"] = "Credit",
	["AUCTION_CONSIGNMENT"] = "Consignment",
	["AUCTION_BID"] = "Auctions Bid",
	["AUCTION_BOUGHT"] = "Auctions Bought",
	["AUCTION_OUTBID"] = "Auctions Outbid",
	["AUCTION_MONEY_SPENT"] = "Gold Spent",
	["GUILD_BANKING_MONEY_WITHDRAWN"] = "Gold Withdrawn",
	["GUILD_BANKING_MONEY_DEPOSITED"] = "Gold Deposited",
	["GUILD_BANKING_ITEM_WITHDRAWN"] = "Items Withdrawn",
	["GUILD_BANKING_ITEM_DEPOSITED"] = "Items Deposited",
	["TRADING_MONEY_RECEIVED"] = "Gold Received",
	["TRADING_MONEY_GIVEN"] = "Gold Given",
	["TRADING_ITEM_RECEIVED"] = "Items Received",
	["TRADING_ITEM_GIVEN"] = "Items Given",
	["CRAFTING_TOTAL"] = "Crafting Activity",
	["CRAFTING_ALCHEMY"] = "Alchemy",
	["CRAFTING_BLACKSMITHING"] = "Blacksmithing",
	["CRAFTING_COOKING"] = "Cooking",
	["CRAFTING_DISENCHANTING"] = "Disenchanting",
	["CRAFTING_ENCHANTING"] = "Enchanting",
	["CRAFTING_FIRST_AID"] = "First Aid",
	["CRAFTING_JEWELCRAFTING"] = "Jewelcrafting",
	["CRAFTING_LEATHERWORKING"] = "Leatherworking",
	["CRAFTING_PROSPECTING"] = "Prospecting",
	["CRAFTING_SMELTING"] = "Smelting",
	["CRAFTING_TAILORING"] = "Tailoring",
	["GATHERING_TOTAL"] = "Gathering Activity",
	["GATHERING_EXTRACT_GAS"] = "Extract Gas",
	["GATHERING_FISHING"] = "Fishing",
	["GATHERING_HERB_GATHERING"] = "Herb Gathering",
	["GATHERING_MINING"] = "Mining",
	["GATHERING_SKINNING"] = "Skinning",
	
	-- Measures
	["AUTOMATED"] = "(Automated)",
	
	-- Reports
	["OVERVIEW"] = "Overview",
	["MONEY_GAINED"] = "Gold Gained",
	["MONEY_SPENT"] = "Gold Spent",
	["ITEM_CONSUMED"] = "Items Consumed",
	["ITEM_PRODUCED"] = "Items Produced",
	["QUESTING"] = "Questing",
	["LOOTING"] = "Looting",
	["MERCHANT"] = "Vendor",
	["AUCTION"] = "Auction House",
	["GUILD_BANK"] = "Guild Bank",
	["TRADING"] = "Trading",
	["CRAFTING"] = "Crafting",
	["GATHERING"] = "Gathering",
	
	-- Measure
	["TALENT_WIPING"] = "Talent Wiping",
	
	-- Periods
	["TODAY"] = "Today",
	["YESTERDAY"] = "Yesterday",
	["THIS_WEEK"] = "This Week",
	["THIS_MONTH"] = "This Month",
	["LAST_7_DAYS"] = "Last 7 Days",
	["LAST_30_DAYS"] = "Last 30 Days",
	
	-- Economy frame
	["ECONOMY_FRAME_TITLE"] = "Economy",
	["ALL_CHARACTERS"] = "All Characters",
	["ALL_CHARACTERS_TOOLTIP"] = "If checked, data is shown for all characters on this account. If unchecked, data is shown for the currently logged in character.",
	["NO_DETAIL_INFO"] = "No detail information available.",
	["CONSUMED"] = "Consumed",
	["PRODUCED"] = "Produced",
} end)
