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
-- Acquire libraries

local L = AceLibrary("AceLocale-2.2"):new("Analyst")

	
----------------------------------------------------------------------
-- Constants

-- Measures
ANALYST_MEASURE_MONEY_GAINED_TOTAL = "MONEY_GAINED_TOTAL"
ANALYST_MEASURE_MONEY_GAINED_QUESTING = "MONEY_GAINED_QUESTING"
ANALYST_MEASURE_MONEY_GAINED_LOOTING = "MONEY_GAINED_LOOTING"
ANALYST_MEASURE_MONEY_GAINED_OPENING = "MONEY_GAINED_OPENING"
ANALYST_MEASURE_MONEY_GAINED_SELLING = "MONEY_GAINED_SELLING"
ANALYST_MEASURE_MONEY_GAINED_AUCTION = "MONEY_GAINED_AUCTION"
ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING = "MONEY_GAINED_GUILD_BANKING"
ANALYST_MEASURE_MONEY_GAINED_TRADING = "MONEY_GAINED_TRADING"
ANALYST_MEASURE_MONEY_GAINED_RECEIVING = "MONEY_GAINED_RECEIVING"
ANALYST_MEASURE_MONEY_GAINED_MISCELLANEOUS = "MONEY_GAINED_MISCELLANEOUS"
ANALYST_MEASURE_MONEY_SPENT_TOTAL = "MONEY_SPENT_TOTAL"
ANALYST_MEASURE_MONEY_SPENT_QUESTING = "MONEY_SPENT_QUESTING"
ANALYST_MEASURE_MONEY_SPENT_BUYING = "MONEY_SPENT_BUYING"
ANALYST_MEASURE_MONEY_SPENT_REPAIRING = "MONEY_SPENT_REPAIRING"
ANALYST_MEASURE_MONEY_SPENT_TRAINING = "MONEY_SPENT_TRAINING"
ANALYST_MEASURE_MONEY_SPENT_PURCHASING = "MONEY_SPENT_PURCHASING"
ANALYST_MEASURE_MONEY_SPENT_TAXI = "MONEY_SPENT_TAXI"
ANALYST_MEASURE_MONEY_SPENT_AUCTION = "MONEY_SPENT_AUCTION"
ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING = "MONEY_SPENT_GUILD_BANKING"
ANALYST_MEASURE_MONEY_SPENT_TRADING = "MONEY_SPENT_TRADING"
ANALYST_MEASURE_MONEY_SPENT_SENDING = "MONEY_SPENT_SENDING"
ANALYST_MEASURE_MONEY_SPENT_MISCELLANEOUS = "MONEY_SPENT_MISCELLANEOUS"
ANALYST_MEASURE_ITEM_CONSUMED_QUESTING = "ITEM_CONSUMED_QUESTING"
ANALYST_MEASURE_ITEM_CONSUMED_CASTING = "ITEM_CONSUMED_CASTING"
ANALYST_MEASURE_ITEM_CONSUMED_USING = "ITEM_CONSUMED_USING"
ANALYST_MEASURE_ITEM_CONSUMED_OPENING = "ITEM_CONSUMED_OPENING"
ANALYST_MEASURE_ITEM_CONSUMED_CRAFTING = "ITEM_CONSUMED_CRAFTING"
ANALYST_MEASURE_ITEM_CONSUMED_SOCKETING = "ITEM_CONSUMED_SOCKETING"
ANALYST_MEASURE_ITEM_CONSUMED_DESTROYING = "ITEM_CONSUMED_DESTROYING"
ANALYST_MEASURE_ITEM_CONSUMED_SENDING = "ITEM_CONSUMED_SENDING"
ANALYST_MEASURE_ITEM_CONSUMED_MISCELLANEOUS = "ITEM_CONSUMED_MISCELLANEOUS"
ANALYST_MEASURE_ITEM_PRODUCED_QUESTING = "ITEM_PRODUCED_QUESTING"
ANALYST_MEASURE_ITEM_PRODUCED_CASTING = "ITEM_PRODUCED_CASTING"
ANALYST_MEASURE_ITEM_PRODUCED_USING = "ITEM_PRODUCED_USING"
ANALYST_MEASURE_ITEM_PRODUCED_OPENING = "ITEM_PRODUCED_OPENING"
ANALYST_MEASURE_ITEM_PRODUCED_CRAFTING = "ITEM_PRODUCED_CRAFTING"
ANALYST_MEASURE_ITEM_PRODUCED_GATHERING = "ITEM_PRODUCED_GATHERING"
ANALYST_MEASURE_ITEM_PRODUCED_LOOTING = "ITEM_PRODUCED_LOOTING"
ANALYST_MEASURE_ITEM_PRODUCED_BATTLEFIELD = "ITEM_PRODUCED_BATTLEFIELD"
ANALYST_MEASURE_ITEM_PRODUCED_RECEIVING = "ITEM_PRODUCED_RECEIVING"
ANALYST_MEASURE_ITEM_PRODUCED_MISCELLANEOUS = "ITEM_PRODUCED_MISCELLANEOUS"
ANALYST_MEASURE_QUESTING_FINISHED = "QUESTING_FINISHED"
ANALYST_MEASURE_QUESTING_MONEY_GAINED = "QUESTING_MONEY_GAINED"
ANALYST_MEASURE_QUESTING_MONEY_SPENT = "QUESTING_MONEY_SPENT"
ANALYST_MEASURE_QUESTING_ITEM_PRODUCED = "QUESTING_ITEM_PRODUCED"
ANALYST_MEASURE_QUESTING_ITEM_CONSUMED = "QUESTING_ITEM_CONSUMED"
ANALYST_MEASURE_LOOTING_MOB = "LOOTING_MOB"
ANALYST_MEASURE_LOOTING_MONEY = "LOOTING_MONEY"
ANALYST_MEASURE_LOOTING_ITEM = "LOOTING_ITEM"
ANALYST_MEASURE_LOOTING_ITEM_VENDOR_VALUE = "LOOTING_ITEM_VENDOR_VALUE"
ANALYST_MEASURE_MERCHANT_MONEY_GAINED = "MERCHANT_MONEY_GAINED"
ANALYST_MEASURE_MERCHANT_MONEY_SPENT_BUYING = "MERCHANT_MONEY_SPENT_BUYING"
ANALYST_MEASURE_MERCHANT_MONEY_SPENT_REPAIRING = "MERCHANT_MONEY_SPENT_REPAIRING"
ANALYST_MEASURE_MERCHANT_ITEM_SOLD = "MERCHANT_ITEM_SOLD"
ANALYST_MEASURE_MERCHANT_ITEM_BOUGHT = "MERCHANT_ITEM_BOUGHT"
ANALYST_MEASURE_MERCHANT_ITEM_SWAPED = "MERCHANT_ITEM_SWAPED"
ANALYST_MEASURE_AUCTION_POSTED = "AUCTION_POSTED"
ANALYST_MEASURE_AUCTION_SOLD = "AUCTION_SOLD"
ANALYST_MEASURE_AUCTION_EXPIRED = "AUCTION_EXPIRED"
ANALYST_MEASURE_AUCTION_CANCELLED = "AUCTION_CANCELLED"
ANALYST_MEASURE_AUCTION_MONEY_GAINED = "AUCTION_MONEY_GAINED"
ANALYST_MEASURE_AUCTION_DEPOSIT_PAID = "AUCTION_DEPOSIT_PAID"
ANALYST_MEASURE_AUCTION_DEPOSIT_CREDITED = "AUCTION_DEPOSIT_CREDITED"
ANALYST_MEASURE_AUCTION_CONSIGNMENT = "AUCTION_CONSIGNMENT"
ANALYST_MEASURE_AUCTION_BID = "AUCTION_BID"
ANALYST_MEASURE_AUCTION_BOUGHT = "AUCTION_BOUGHT"
ANALYST_MEASURE_AUCTION_OUTBID = "AUCTION_OUTBID"
ANALYST_MEASURE_AUCTION_MONEY_SPENT = "AUCTION_MONEY_SPENT"
ANALYST_MEASURE_GUILD_BANKING_MONEY_WITHDRAWN = "GUILD_BANKING_MONEY_WITHDRAWN"
ANALYST_MEASURE_GUILD_BANKING_MONEY_DEPOSITED = "GUILD_BANKING_MONEY_DEPOSITED"
ANALYST_MEASURE_GUILD_BANKING_ITEM_WITHDRAWN = "GUILD_BANKING_ITEM_WITHDRAWN"
ANALYST_MEASURE_GUILD_BANKING_ITEM_DEPOSITED = "GUILD_BANKING_ITEM_DEPOSITED"
ANALYST_MEASURE_TRADING_MONEY_RECEIVED = "TRADING_MONEY_RECEIVED"
ANALYST_MEASURE_TRADING_MONEY_GIVEN = "TRADING_MONEY_GIVEN"
ANALYST_MEASURE_TRADING_ITEM_RECEIVED = "TRADING_ITEM_RECEIVED"
ANALYST_MEASURE_TRADING_ITEM_GIVEN = "TRADING_ITEM_GIVEN"
ANALYST_MEASURE_CRAFTING_TOTAL = "CRAFTING_TOTAL"
ANALYST_MEASURE_CRAFTING_ALCHEMY = "CRAFTING_ALCHEMY"
ANALYST_MEASURE_CRAFTING_BLACKSMITHING = "CRAFTING_BLACKSMITHING"
ANALYST_MEASURE_CRAFTING_COOKING = "CRAFTING_COOKING"
ANALYST_MEASURE_CRAFTING_DISENCHANTING = "CRAFTING_DISENCHANTING"
ANALYST_MEASURE_CRAFTING_ENCHANTING = "CRAFTING_ENCHANTING"
ANALYST_MEASURE_CRAFTING_FIRST_AID = "CRAFTING_FIRST_AID"
ANALYST_MEASURE_CRAFTING_JEWELCRAFTING = "CRAFTING_JEWELCRAFTING"
ANALYST_MEASURE_CRAFTING_LEATHERWORKING = "CRAFTING_LEATHERWORKING"
ANALYST_MEASURE_CRAFTING_PROSPECTING = "CRAFTING_PROSPECTING"
ANALYST_MEASURE_CRAFTING_SMELTING = "CRAFTING_SMELTING"
ANALYST_MEASURE_CRAFTING_TAILORING = "CRAFTING_TAILORING"
ANALYST_MEASURE_GATHERING_TOTAL = "GATHERING_TOTAL"
ANALYST_MEASURE_GATHERING_EXTRACT_GAS = "GATHERING_EXTRACT_GAS"
ANALYST_MEASURE_GATHERING_FISHING = "GATHERING_FISHING"
ANALYST_MEASURE_GATHERING_HERB_GATHERING = "GATHERING_HERB_GATHERING"
ANALYST_MEASURE_GATHERING_MINING = "GATHERING_MINING"
ANALYST_MEASURE_GATHERING_SKINNING = "GATHERING_SKINNING"

-- Measure types
ANALYST_MTYPE_COUNT = "COUNT"
ANALYST_MTYPE_MONEY = "MONEY"
ANALYST_MTYPE_ALIAS = "ALIAS"

-- Drill-down types
ANALYST_DRILLDOWN_NONE = "NONE"
ANALYST_DRILLDOWN_LIST = "LIST"
ANALYST_DRILLDOWN_DETAIL = "DETAIL"
ANALYST_DRILLDOWN_CONSUMED = "CONSUMED"
ANALYST_DRILLDOWN_PRODUCED = "PRODUCED"
ANALYST_DRILLDOWN_CONSUMED_PRODUCED = "CONSUMED_PRODUCED"

-- Reports
ANALYST_REPORT_OVERVIEW = "OVERVIEW"
ANALYST_REPORT_MONEY_GAINED = "MONEY_GAINED"
ANALYST_REPORT_MONEY_SPENT = "MONEY_SPENT"
ANALYST_REPORT_ITEM_CONSUMED = "ITEM_CONSUMED"
ANALYST_REPORT_ITEM_PRODUCED = "ITEM_PRODUCED"
ANALYST_REPORT_QUESTING = "QUESTING"
ANALYST_REPORT_LOOTING = "LOOTING"
ANALYST_REPORT_MERCHANT = "MERCHANT"
ANALYST_REPORT_AUCTION = "AUCTION"
ANALYST_REPORT_GUILD_BANK = "GUILD_BANK"
ANALYST_REPORT_TRADING = "TRADING"
ANALYST_REPORT_CRAFTING = "CRAFTING"
ANALYST_REPORT_GATHERING = "GATHERING"

-- Empty facts
ANALYST_EMPTY_FACTS = {
	value = 0
}


----------------------------------------------------------------------
-- Subsystem

-- Initializes the measure subsystem
function Analyst:InitializeMeasure ()
	-- Define the measures
	self:DefineMeasures()
	self:DefineReports()
	
	-- Manage facts
	if not self.db.char.facts then
		self.db.char.facts = { }
	end
	local expireBefore = date("%Y%m%d", self:GetDate() - ANALYST_DATA_LIFETIME * 86400)
	for day in pairs(self.db.char.facts) do
		if day < expireBefore then
			self.db.char.facts[day] = nil
		end
	end
end

-- Enable the measure subsystem
function Analyst:EnableMeasure ()
	-- Register
	self:RegisterEvent("ANALYST_EVENT")
end

-- Disables the measure logic
function Analyst:DisableMeasure ()
end

----------------------------------------------------------------------
-- Measures

-- Defines the measures
function Analyst:DefineMeasures ()
	self.measures = { }
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_TOTAL,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_MONEY_GAINED_QUESTING, ANALYST_MEASURE_MONEY_GAINED_LOOTING,
			ANALYST_MEASURE_MONEY_GAINED_OPENING, ANALYST_MEASURE_MONEY_GAINED_SELLING,
			ANALYST_MEASURE_MONEY_GAINED_AUCTION, ANALYST_MEASURE_MONEY_GAINED_TRADING,
			ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING, ANALYST_MEASURE_MONEY_GAINED_RECEIVING,
			ANALYST_MEASURE_MONEY_GAINED_MISCELLANEOUS)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_QUESTING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_LOOTING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_OPENING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_SELLING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_AUCTION,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_AUCTION_MONEY_GAINED, ANALYST_MEASURE_AUCTION_DEPOSIT_CREDITED)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_TRADING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_RECEIVING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_GAINED_MISCELLANEOUS,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_TOTAL,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_MONEY_SPENT_QUESTING, ANALYST_MEASURE_MONEY_SPENT_BUYING,
			ANALYST_MEASURE_MONEY_SPENT_REPAIRING, ANALYST_MEASURE_MONEY_SPENT_TRAINING,
			ANALYST_MEASURE_MONEY_SPENT_PURCHASING, ANALYST_MEASURE_MONEY_SPENT_TAXI,
			ANALYST_MEASURE_MONEY_SPENT_AUCTION, ANALYST_MEASURE_MONEY_SPENT_TRADING,
			ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING, ANALYST_MEASURE_MONEY_SPENT_SENDING,
			ANALYST_MEASURE_MONEY_SPENT_MISCELLANEOUS)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_QUESTING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_BUYING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_REPAIRING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_TRAINING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_PURCHASING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_TAXI,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_AUCTION,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_AUCTION_DEPOSIT_PAID, ANALYST_MEASURE_AUCTION_MONEY_SPENT)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_TRADING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_SENDING,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_NONE)
	self:DefineMeasure(
		ANALYST_MEASURE_MONEY_SPENT_MISCELLANEOUS,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_QUESTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_CASTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_USING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_OPENING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_SOCKETING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_DESTROYING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_CRAFTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_SENDING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_CONSUMED_MISCELLANEOUS,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_QUESTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_CASTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_USING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_OPENING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_CRAFTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_GATHERING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_LOOTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_BATTLEFIELD,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_RECEIVING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_ITEM_PRODUCED_MISCELLANEOUS,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_QUESTING_FINISHED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_QUESTING_MONEY_GAINED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_GAINED_QUESTING)
	self:DefineMeasure(
		ANALYST_MEASURE_QUESTING_MONEY_SPENT,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_SPENT_QUESTING)
	self:DefineMeasure(
		ANALYST_MEASURE_QUESTING_ITEM_PRODUCED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_ITEM_PRODUCED_QUESTING)
	self:DefineMeasure(
		ANALYST_MEASURE_QUESTING_ITEM_CONSUMED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_ITEM_CONSUMED_QUESTING)
	self:DefineMeasure(
		ANALYST_MEASURE_LOOTING_MOB,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_LOOTING_MONEY,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_GAINED_LOOTING)
	self:DefineMeasure(
		ANALYST_MEASURE_LOOTING_ITEM,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_ITEM_PRODUCED_LOOTING)
	self:DefineMeasure(
		ANALYST_MEASURE_LOOTING_ITEM_VENDOR_VALUE,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_MONEY_GAINED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_GAINED_SELLING)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_MONEY_SPENT_BUYING,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_SPENT_BUYING)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_MONEY_SPENT_REPAIRING,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_SPENT_REPAIRING)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_ITEM_SOLD,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_ITEM_BOUGHT,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_MERCHANT_ITEM_SWAPED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_POSTED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_SOLD,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_EXPIRED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_CANCELLED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_MONEY_GAINED,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_DEPOSIT_PAID,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_DEPOSIT_CREDITED,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_CONSIGNMENT,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_BID,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_BOUGHT,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_OUTBID,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_AUCTION_MONEY_SPENT,
		ANALYST_MTYPE_MONEY,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_GUILD_BANKING_MONEY_WITHDRAWN,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING)
	self:DefineMeasure(
		ANALYST_MEASURE_GUILD_BANKING_MONEY_DEPOSITED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING)
	self:DefineMeasure(
		ANALYST_MEASURE_GUILD_BANKING_ITEM_WITHDRAWN,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_GUILD_BANKING_ITEM_DEPOSITED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_TRADING_MONEY_RECEIVED,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_GAINED_TRADING)
	self:DefineMeasure(
		ANALYST_MEASURE_TRADING_MONEY_GIVEN,
		ANALYST_MTYPE_ALIAS,
		ANALYST_MEASURE_MONEY_SPENT_TRADING)
	self:DefineMeasure(
		ANALYST_MEASURE_TRADING_ITEM_RECEIVED,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_TRADING_ITEM_GIVEN,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_DETAIL)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_TOTAL,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_CRAFTING_ALCHEMY, ANALYST_MEASURE_CRAFTING_BLACKSMITHING,
			ANALYST_MEASURE_CRAFTING_COOKING, ANALYST_MEASURE_CRAFTING_DISENCHANTING,
			ANALYST_MEASURE_CRAFTING_ENCHANTING, ANALYST_MEASURE_CRAFTING_FIRST_AID,
			ANALYST_MEASURE_CRAFTING_JEWELCRAFTING, ANALYST_MEASURE_CRAFTING_LEATHERWORKING,
			ANALYST_MEASURE_CRAFTING_PROSPECTING, ANALYST_MEASURE_CRAFTING_SMELTING,
			ANALYST_MEASURE_CRAFTING_TAILORING)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_ALCHEMY,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_BLACKSMITHING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_COOKING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_DISENCHANTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_ENCHANTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_FIRST_AID,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_JEWELCRAFTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_LEATHERWORKING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_PROSPECTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_SMELTING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_CRAFTING_TAILORING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_CONSUMED_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_TOTAL,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_LIST,
			ANALYST_MEASURE_GATHERING_EXTRACT_GAS, ANALYST_MEASURE_GATHERING_FISHING,
			ANALYST_MEASURE_GATHERING_HERB_GATHERING, ANALYST_MEASURE_GATHERING_MINING,
			ANALYST_MEASURE_GATHERING_SKINNING)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_EXTRACT_GAS,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_FISHING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_HERB_GATHERING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_MINING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
	self:DefineMeasure(
		ANALYST_MEASURE_GATHERING_SKINNING,
		ANALYST_MTYPE_COUNT,
		ANALYST_DRILLDOWN_PRODUCED)
end

-- Defines a measure
function Analyst:DefineMeasure (name, measureType, drilldown, ...)
	local measure = { }
	measure.name = name
	measure.label = L:GetTranslation(name)
	measure.type = measureType
	measure.drilldown = drilldown
	measure.args = { }
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		table.insert(measure.args, arg)
	end
	self.measures[name] = measure
end

-- Returns a measure
function Analyst:GetMeasure (name)
	return self.measures[name]
end

-- Returns the type of a measure
function Analyst:GetMeasureType (name)
	local measure = self:GetMeasure(name)
	if not measure then
		self:LevelDebug(1, "Unknown measure")
		return nil
	end
	if measure.type == ANALYST_MTYPE_ALIAS then
		return self:GetMeasureType(measure.drilldown)
	else
		return measure.type
	end
end


----------------------------------------------------------------------
-- Reports

-- Defines the reports
function Analyst:DefineReports ()
	self.reports = { }
	self:DefineReport(ANALYST_REPORT_OVERVIEW,
		ANALYST_MEASURE_MONEY_GAINED_TOTAL, ANALYST_MEASURE_MONEY_SPENT_TOTAL,
		ANALYST_MEASURE_QUESTING_FINISHED, ANALYST_MEASURE_AUCTION_POSTED,
		ANALYST_MEASURE_AUCTION_SOLD, ANALYST_MEASURE_CRAFTING_TOTAL,
		ANALYST_MEASURE_GATHERING_TOTAL)
	self:DefineReport(ANALYST_REPORT_MONEY_GAINED,
		ANALYST_MEASURE_MONEY_GAINED_QUESTING, ANALYST_MEASURE_MONEY_GAINED_LOOTING,
		ANALYST_MEASURE_MONEY_GAINED_OPENING, ANALYST_MEASURE_MONEY_GAINED_SELLING,
		ANALYST_MEASURE_MONEY_GAINED_AUCTION, ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING,
		ANALYST_MEASURE_MONEY_GAINED_TRADING, ANALYST_MEASURE_MONEY_GAINED_RECEIVING,
		ANALYST_MEASURE_MONEY_GAINED_MISCELLANEOUS)
	self:DefineReport(ANALYST_REPORT_MONEY_SPENT,
		ANALYST_MEASURE_MONEY_SPENT_QUESTING, ANALYST_MEASURE_MONEY_SPENT_BUYING,
		ANALYST_MEASURE_MONEY_SPENT_TRAINING, ANALYST_MEASURE_MONEY_SPENT_PURCHASING,
		ANALYST_MEASURE_MONEY_SPENT_REPAIRING, ANALYST_MEASURE_MONEY_SPENT_TAXI,
		ANALYST_MEASURE_MONEY_SPENT_AUCTION, ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING,
		ANALYST_MEASURE_MONEY_SPENT_TRADING, ANALYST_MEASURE_MONEY_SPENT_SENDING,
		ANALYST_MEASURE_MONEY_SPENT_MISCELLANEOUS)
	self:DefineReport(ANALYST_REPORT_ITEM_CONSUMED,
		ANALYST_MEASURE_ITEM_CONSUMED_QUESTING, ANALYST_MEASURE_ITEM_CONSUMED_CASTING,
		ANALYST_MEASURE_ITEM_CONSUMED_USING, ANALYST_MEASURE_ITEM_CONSUMED_OPENING,
		ANALYST_MEASURE_ITEM_CONSUMED_CRAFTING, ANALYST_MEASURE_ITEM_CONSUMED_SOCKETING,
		ANALYST_MEASURE_ITEM_CONSUMED_DESTROYING, ANALYST_MEASURE_ITEM_CONSUMED_SENDING,
		ANALYST_MEASURE_ITEM_CONSUMED_MISCELLANEOUS)
	self:DefineReport(ANALYST_REPORT_ITEM_PRODUCED,
		ANALYST_MEASURE_ITEM_PRODUCED_QUESTING, ANALYST_MEASURE_ITEM_PRODUCED_CASTING,
		ANALYST_MEASURE_ITEM_PRODUCED_USING, ANALYST_MEASURE_ITEM_PRODUCED_OPENING,
		ANALYST_MEASURE_ITEM_PRODUCED_CRAFTING,	ANALYST_MEASURE_ITEM_PRODUCED_GATHERING,
		ANALYST_MEASURE_ITEM_PRODUCED_LOOTING, ANALYST_MEASURE_ITEM_PRODUCED_BATTLEFIELD,
		ANALYST_MEASURE_ITEM_PRODUCED_RECEIVING, ANALYST_MEASURE_ITEM_PRODUCED_MISCELLANEOUS)
	self:DefineReport(ANALYST_REPORT_QUESTING,
		ANALYST_MEASURE_QUESTING_FINISHED, ANALYST_MEASURE_QUESTING_MONEY_GAINED,
		ANALYST_MEASURE_QUESTING_MONEY_SPENT, ANALYST_MEASURE_QUESTING_ITEM_PRODUCED,
		ANALYST_MEASURE_QUESTING_ITEM_CONSUMED)
	self:DefineReport(ANALYST_REPORT_LOOTING,
		ANALYST_MEASURE_LOOTING_MOB, ANALYST_MEASURE_LOOTING_MONEY,
		ANALYST_MEASURE_LOOTING_ITEM, ANALYST_MEASURE_LOOTING_ITEM_VENDOR_VALUE)
	self:DefineReport(ANALYST_REPORT_MERCHANT,
		ANALYST_MEASURE_MERCHANT_MONEY_GAINED, ANALYST_MEASURE_MERCHANT_MONEY_SPENT_BUYING,
		ANALYST_MEASURE_MERCHANT_MONEY_SPENT_REPAIRING,	ANALYST_MEASURE_MERCHANT_ITEM_SOLD,
		ANALYST_MEASURE_MERCHANT_ITEM_BOUGHT, ANALYST_MEASURE_MERCHANT_ITEM_SWAPED)
	self:DefineReport(ANALYST_REPORT_AUCTION,
		ANALYST_MEASURE_AUCTION_POSTED, ANALYST_MEASURE_AUCTION_SOLD,
		ANALYST_MEASURE_AUCTION_EXPIRED, ANALYST_MEASURE_AUCTION_CANCELLED,
		ANALYST_MEASURE_AUCTION_MONEY_GAINED, ANALYST_MEASURE_AUCTION_DEPOSIT_PAID,
		ANALYST_MEASURE_AUCTION_DEPOSIT_CREDITED, ANALYST_MEASURE_AUCTION_CONSIGNMENT,
		ANALYST_MEASURE_AUCTION_BID, ANALYST_MEASURE_AUCTION_BOUGHT,
		ANALYST_MEASURE_AUCTION_OUTBID, ANALYST_MEASURE_AUCTION_MONEY_SPENT)
	self:DefineReport(ANALYST_REPORT_GUILD_BANK,
		ANALYST_MEASURE_GUILD_BANKING_MONEY_WITHDRAWN, ANALYST_MEASURE_GUILD_BANKING_MONEY_DEPOSITED,
		ANALYST_MEASURE_GUILD_BANKING_ITEM_WITHDRAWN, ANALYST_MEASURE_GUILD_BANKING_ITEM_DEPOSITED)
	self:DefineReport(ANALYST_REPORT_TRADING,
		ANALYST_MEASURE_TRADING_MONEY_RECEIVED, ANALYST_MEASURE_TRADING_MONEY_GIVEN,
		ANALYST_MEASURE_TRADING_ITEM_RECEIVED, ANALYST_MEASURE_TRADING_ITEM_GIVEN)
	self:DefineReport(ANALYST_REPORT_CRAFTING,
		ANALYST_MEASURE_CRAFTING_ALCHEMY, ANALYST_MEASURE_CRAFTING_BLACKSMITHING,
		ANALYST_MEASURE_CRAFTING_COOKING, ANALYST_MEASURE_CRAFTING_DISENCHANTING,
		ANALYST_MEASURE_CRAFTING_ENCHANTING, ANALYST_MEASURE_CRAFTING_FIRST_AID,
		ANALYST_MEASURE_CRAFTING_JEWELCRAFTING, ANALYST_MEASURE_CRAFTING_LEATHERWORKING,
		ANALYST_MEASURE_CRAFTING_PROSPECTING, ANALYST_MEASURE_CRAFTING_SMELTING,
		ANALYST_MEASURE_CRAFTING_TAILORING)
	self:DefineReport(ANALYST_REPORT_GATHERING,
		ANALYST_MEASURE_GATHERING_EXTRACT_GAS, ANALYST_MEASURE_GATHERING_FISHING,
		ANALYST_MEASURE_GATHERING_HERB_GATHERING, ANALYST_MEASURE_GATHERING_MINING,
		ANALYST_MEASURE_GATHERING_SKINNING)
end

-- Defines a report
function Analyst:DefineReport (name, ...)
	local report = { }
	report.name = name
	report.label = L:GetTranslation(name)
	report.measures = { }
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		table.insert(report.measures, arg)
	end
	table.insert(self.reports, report)
end

-- Returns a report
function Analyst:GetReport (name)
	for i in ipairs(self.reports) do
		if self.reports[i].name == name then
			return self.reports[i]
		end
	end
	return nil
end

-- Returns all reports
function Analyst:GetReports ()
	return self.reports
end


----------------------------------------------------------------------
-- Facts

-- Creates a fact
function Analyst:CreateFact (measureName, day, detail, value)
	-- Get the measure and validate the call
	local measure = self.measures[measureName]
	if not measure then
		self:LevelDebug(1, "Undefined measure")
		return
	end
	if measure.type == ANALYST_MTYPE_ALIAS or measure.drilldown == ANALYST_DRILLDOWN_LIST then
		self:LevelDebug(1, "Cannot create fact for measure " .. measureName)
		return
	end
	if measure.drilldown == ANALYST_DRILLDOWN_NONE and detail then
		self:LevelDebug(1, "Cannot set detail for measure " .. measureName)
		return
	end
	if measure.drilldown == ANALYST_DRILLDOWN_DETAIL and not detail then
		self:LevelDebug(1, "Cannot omit detail for measure " .. measureName)
	end
	
	-- Create the data object
	if not self.db.char.facts[day] then
		self.db.char.facts[day] = { }
	end
	if not self.db.char.facts[day][measureName] then
		self.db.char.facts[day][measureName] = { }
		self.db.char.facts[day][measureName].value = 0
	end
	
	-- Process count
	self.db.char.facts[day][measureName].value =
		self.db.char.facts[day][measureName].value + value
		
	-- Process (optional) detail
	if detail then
		if not self.db.char.facts[day][measureName].detail then
			self.db.char.facts[day][measureName].detail = { }
		end
		if not self.db.char.facts[day][measureName].detail[detail] then
			self.db.char.facts[day][measureName].detail[detail] = 0
		end
		self.db.char.facts[day][measureName].detail[detail] =
			self.db.char.facts[day][measureName].detail[detail] + value
	end
end	

-- Creates a consumed fact
function Analyst:CreateFactConsumed (measureName, day, detail, value)
	-- Get the measure and validate the call
	local measure = self.measures[measureName]
	if not measure then
		self:LevelDebug(1, "Undefined measure " .. measureName)
		return
	end
	if measure.drilldown ~= ANALYST_DRILLDOWN_CONSUMED and
		measure.drilldown ~= ANALYST_DRILLDOWN_CONSUMED_PRODUCED then
		self:LevelDebug(1, "Cannot create consumed fact for measure " .. measureName)
		return
	end
	
	-- Process (optional) detail
	if not self.db.char.facts[day][measureName].consumed then
		self.db.char.facts[day][measureName].consumed = { }
	end
	if not self.db.char.facts[day][measureName].consumed[detail] then
		self.db.char.facts[day][measureName].consumed[detail] = 0
	end
	self.db.char.facts[day][measureName].consumed[detail] =
		self.db.char.facts[day][measureName].consumed[detail] + value
end	

-- Creates a produced fact
function Analyst:CreateFactProduced (measureName, day, detail, value)
	-- Get the measure and validate the call
	local measure = self.measures[measureName]
	if not measure then
		self:LevelDebug(1, "Undefined measure " .. measureName)
		return
	end
	if measure.drilldown ~= ANALYST_DRILLDOWN_PRODUCED and
		measure.drilldown ~= ANALYST_DRILLDOWN_CONSUMED_PRODUCED then
		self:LevelDebug(1, "Cannot create produced fact for measure " .. measureName)
		return
	end
	
	-- Process (optional) detail
	if not self.db.char.facts[day][measureName].produced then
		self.db.char.facts[day][measureName].produced = { }
	end
	if not self.db.char.facts[day][measureName].produced[detail] then
		self.db.char.facts[day][measureName].produced[detail] = 0
	end
	self.db.char.facts[day][measureName].produced[detail] =
		self.db.char.facts[day][measureName].produced[detail] + value
end

-- Returns the facts for the specified measure and day
function Analyst:GetFacts (measureName, day, charID)
	-- Set char ID
	if not charID then
		charID = self:GetCharID()
	end

	-- Get the measure
	local measure = self.measures[measureName]
	if not measure then
		self:LevelDebug(1, "Undefined measure")
		return nil
	end
	
	-- Handle alias
	if measure.type == ANALYST_MTYPE_ALIAS then
		return Analyst:GetFacts(measure.drilldown, day, charID)
	end
	
	-- Handle list
	if measure.drilldown == ANALYST_DRILLDOWN_LIST then
		local facts = { }
		facts.value = 0
		facts.detail = { }
		for i in ipairs(measure.args) do
			local subFacts = self:GetFacts(measure.args[i], day, charID)
			facts.value = facts.value + subFacts.value
			local subMeasure = self.measures[measure.args[i]]
			facts.detail[subMeasure.label] = subFacts.value
		end
		return facts
	end
	
	-- Regular measure
	if not AnalystDB.chars[charID].facts[day] then
		return ANALYST_EMPTY_FACTS
	end
	if not AnalystDB.chars[charID].facts[day][measureName] then
		return ANALYST_EMPTY_FACTS
	end
	return AnalystDB.chars[charID].facts[day][measureName]
end

-- Merges two facts
function Analyst:MergeFacts (target, source)
	if not target.value then
		target.value = 0
	end
	target.value = target.value + source.value
	self:MergeSubFacts(target, source, "detail")
	self:MergeSubFacts(target, source, "consumed")
	self:MergeSubFacts(target, source, "produced")
end

-- Merges details of two facts
function Analyst:MergeSubFacts (target, source, detail)
	if source[detail] then
		if not target[detail] then
			target[detail] = { }
		end
		for name in pairs(source[detail]) do
			if not target[detail][name] then
				target[detail][name] = 0
			end
			target[detail][name] = target[detail][name] + source[detail][name]
		end
	end
end


----------------------------------------------------------------------
-- Event processing

-- Processes an event
function Analyst:ANALYST_EVENT (day, activity, detail, consumed, produced)
	local func = self[activity]
	if func then
		func(self, day, detail, consumed, produced)
		self:TriggerEvent("ANALYST_FACTS_CHANGED")
	else
		self:LevelDebug(1, "No processor for activity")
	end
end

-- Handles ALCHEMY activity
function Analyst:ALCHEMY (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_ALCHEMY,
		day,
		detail,
		consumed,
		produced)
end

-- Handles BATTLEFIELD activity
function Analyst:BATTLEFIELD (day, detail, consumed, produced)
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_BATTLEFIELD,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count);
		end
	end
end

-- Handles BIDING activity
function Analyst:BIDING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_ITEM then
		local consumedObjs = self:ParseObjects(consumed)
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_BID,
					day,
					detailObj.itemName,
					1)
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_MONEY_SPENT,
					day,
					detailObj.itemName,
					consumedObjs[i].copper)
			end
		end
	end
end

-- Handles BLACKSMITHING activity
function Analyst:BLACKSMITHING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_BLACKSMITHING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles BOUGHT activity
function Analyst:BOUGHT (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_INVOICE then
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_BOUGHT,
					day,
					detailObj.itemName,
					1)
			end
		end
	end
end

-- Handles CANCELLED activity
function Analyst:CANCELLED (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_CANCELLED,
					day,
					detailObj.s,
					1)
			end
		end
	end
end

-- Handles CASTING activity
function Analyst:CASTING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local consumedObjs = self:ParseObjects(consumed)
		local first = true
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
				if first then
					self:CreateFact(
						ANALYST_MEASURE_ITEM_CONSUMED_CASTING,
						day,
						detailObj.s,
						1)
					first = false
				end
				self:CreateFactConsumed(
					ANALYST_MEASURE_ITEM_CONSUMED_CASTING,
					day,
					consumedObjs[i].itemName,
					consumedObjs[i].count)
			end
		end
		first = true
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				if first then
					self:CreateFact(
						ANALYST_MEASURE_ITEM_PRODUCED_CASTING,
						day,
						detailObj.s,
						1)
					first = false
				end
				self:CreateFactProduced(
					ANALYST_MEASURE_ITEM_PRODUCED_CASTING,
					day,
					producedObjs[i].itemName,
					producedObjs[i].count)
			end
		end
	end
end

-- Handles COOKING activity
function Analyst:COOKING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_COOKING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles DESTROYING activity
function Analyst:DESTROYING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_DESTROYING,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count);
		end
	end
end

-- Handles DISENCHANTING activity
function Analyst:DISENCHANTING (day, detail, consumed, produced)
	self:ProcessDiscrafting(
		ANALYST_MEASURE_CRAFTING_DISENCHANTING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles ENCHANTING activity
function Analyst:ENCHANTING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_ENCHANTING,
		day,
		detail,
		consumed,
		produced)
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_TRADING,
				day,
				nil,
				producedObjs[i].copper)
		end
	end
end

-- Handles EXPIRED activity
function Analyst:EXPIRED (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_EXPIRED,
					day,
					detailObj.s,
					1)
			end
		end
	end
end

-- Handles EXTRACT_GAS activity
function Analyst:EXTRACT_GAS (day, detail, consumed, produced)
	self:ProcessGathering(
		ANALYST_MEASURE_GATHERING_EXTRACT_GAS,
		day,
		detail,
		consumed,
		produced)
end

-- Handle FIRST_AID event
function Analyst:FIRST_AID (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_FIRST_AID,
		day,
		detail,
		consumed,
		produced)
end

-- Handles FISHING activity
function Analyst:FISHING (day, detail, consumed, produced)
	self:ProcessGathering(
		ANALYST_MEASURE_GATHERING_FISHING,
		day,
		nil,
		consumed,
		produced)
end

-- Handles GUILD_BANKING activity
function Analyst:GUILD_BANKING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_GUILD_BANKING_ITEM_DEPOSITED,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		elseif consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_GUILD_BANKING,
				day,
				nil,
				consumedObjs[i].copper)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_GUILD_BANKING_ITEM_WITHDRAWN,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_GUILD_BANKING,
				day,
				nil,
				producedObjs[i].copper)
		end
	end
end

-- Handles HERB_GATHERING activity
function Analyst:HERB_GATHERING (day, detail, consumed, produced)
	self:ProcessGathering(
		ANALYST_MEASURE_GATHERING_HERB_GATHERING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles JEWELCRAFTING activity
function Analyst:JEWELCRAFTING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_JEWELCRAFTING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles LEATHERWORKING activity
function Analyst:LEATHERWORKING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_LEATHERWORKING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles LOOTING activity
function Analyst:LOOTING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		self:CreateFact(ANALYST_MEASURE_LOOTING_MOB, day, detailObj.s, 1)
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_ITEM_PRODUCED_LOOTING,
					day,
					producedObjs[i].itemName,
					producedObjs[i].count)
				local vendorValue = GetSellValue(producedObjs[i].itemId)
				if vendorValue then
					self:CreateFact(
						ANALYST_MEASURE_LOOTING_ITEM_VENDOR_VALUE,
						day,
						producedObjs[i].itemName,
						vendorValue * producedObjs[i].count)
				end
			elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_GAINED_LOOTING,
					day,
					detailObj.s,
					producedObjs[i].copper)
			end
		end
	end
end

-- Handles MINING activity
function Analyst:MINING (day, detail, consumed, produced)
	self:ProcessGathering(
		ANALYST_MEASURE_GATHERING_MINING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles OPENING activity
function Analyst:OPENING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_OPENING,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_OPENING,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_OPENING,
				day,
				nil,
				producedObjs[i].copper)
		end
	end
end

-- Handles OUTBID activity
function Analyst:OUTBID (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_OUTBID,
					day,
					detailObj.s,
					1)
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_MONEY_SPENT,
					day,
					detailObj.s,
					- producedObjs[i].copper)
			end
		end
	end
end

-- Handles POSTING activity
function Analyst:POSTING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	local items = self:FilterObjects(consumedObjs, ANALYST_OTYPE_ITEM)
	local money = self:FilterObjects(consumedObjs, ANALYST_OTYPE_MONEY)
	if #items == #money then
		for i = 1, #items do
			self:CreateFact(
				ANALYST_MEASURE_AUCTION_POSTED,
				day,
				items[i].itemName,
				1)
			self:CreateFact(
				ANALYST_MEASURE_AUCTION_DEPOSIT_PAID,
				day,
				items[i].itemName,
				money[i].copper)
		end
	end
end

-- Handles PROSPECTING activity
function Analyst:PROSPECTING (day, detail, consumed, produced)
	self:ProcessDiscrafting(
		ANALYST_MEASURE_CRAFTING_PROSPECTING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles PURCHASING activity
function Analyst:PURCHASING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local consumedObjs = self:ParseObjects(consumed)
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_SPENT_PURCHASING,
					day,
					L:GetTranslation(detailObj.s),
					consumedObjs[i].copper)
			end
		end
	end
end

-- Handles QUESTING activity
function Analyst:QUESTING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		self:CreateFact(
			ANALYST_MEASURE_QUESTING_FINISHED,
			day,
			detailObj.s,
			1)
		local consumedObjs = self:ParseObjects(consumed)
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_ITEM_CONSUMED_QUESTING,
					day,
					consumedObjs[i].itemName,
					consumedObjs[i].count)
			elseif consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_SPENT_QUESTING,
					day,
					detailObj.s,
					consumedObjs[i].copper)
			end
		end
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_ITEM_PRODUCED_QUESTING,
					day,
					producedObjs[i].itemName,
					producedObjs[i].count)
			elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_GAINED_QUESTING,
					day,
					detailObj.s,
					producedObjs[i].copper)
			end
		end
	end
end

-- Handles RECEIVING activity
function Analyst:RECEIVING (day, detail, consumed, produced)
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_RECEIVING,
				day,
				nil,
				producedObjs[i].copper)
		elseif producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_RECEIVING,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		end
	end
end

-- Handles REPAIRING activity
function Analyst:REPAIRING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	local detail = self:ParseObject(detail)
	if detail.s == ANALYST_REPAIRING_PLAYER then
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_SPENT_REPAIRING,
					day,
					nil,
					consumedObjs[i].copper)
			end
		end
	end
end

-- Handles SENDING activity
function Analyst:SENDING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_SENDING,
				day,
				nil,
				consumedObjs[i].copper)
		elseif consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_SENDING,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		end
	end
end

-- Handles SKINNING activity
function Analyst:SKINNING (day, detail, consumed, produced)
	self:ProcessGathering(
		ANALYST_MEASURE_GATHERING_SKINNING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles SMELTING activity
function Analyst:SMELTING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_SMELTING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles SOCKETING activity
function Analyst:SOCKETING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_SOCKETING,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		end
	end
end

-- Handles SOLD activity
function Analyst:SOLD (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_INVOICE then
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_SOLD,
					day,
					detailObj.itemName,
					1)
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_DEPOSIT_CREDITED,
					day,
					detailObj.itemName,
					detailObj.deposit)
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_CONSIGNMENT,
					day,
					detailObj.itemName,
					detailObj.consignment)
				self:CreateFact(
					ANALYST_MEASURE_AUCTION_MONEY_GAINED,
					day,
					detailObj.itemName,
					detailObj.bid)
			end
		end
	end
end

-- Handles TAILORING activity
function Analyst:TAILORING (day, detail, consumed, produced)
	self:ProcessCrafting(
		ANALYST_MEASURE_CRAFTING_TAILORING,
		day,
		detail,
		consumed,
		produced)
end

-- Handles TAXI activity
function Analyst:TAXI (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_TAXI,
				day,
				detailObj.s,
				consumedObjs[i].copper)
		end
	end
end

-- Handles TALENT_TRAINING activity
function Analyst:TALENT_TRAINING (day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_STRING then
		local consumedObjs = self:ParseObjects(consumed)
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
				self:CreateFact(
					ANALYST_MEASURE_MONEY_SPENT_TRAINING,
					day,
					detailObj.s,
					consumedObjs[i].copper)
			end
		end
	end
end

-- Handles TALENT_WIPING activity
function Analyst:TALENT_WIPING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_TRAINING,
				day,
				L:GetTranslation("TALENT_WIPING"),
				consumedObjs[i].copper)
		end
	end
end

-- Handles TRADE_SKILL_TRAINING activity
function Analyst:TRADE_SKILL_TRAINING (day, detail, consumed, produced)
	self:TALENT_TRAINING(day, detail, consumed, produced)
end

-- Handles TRADING activity
function Analyst:TRADING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_TRADING_ITEM_GIVEN,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		elseif consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_TRADING,
				day,
				nil,
				consumedObjs[i].copper)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_TRADING_ITEM_RECEIVED,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_TRADING,
				day,
				nil,
				producedObjs[i].copper)
		end
	end
end

-- Handles UNKNOWN activity
function Analyst:UNKNOWN (day, detail, consumed, produced)
	local location = self:ParseObject(detail)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_MISCELLANEOUS,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		elseif consumedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_MISCELLANEOUS,
				day,
				location.s,
				consumedObjs[i].copper)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_MISCELLANEOUS,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		elseif producedObjs[i].objType == ANALYST_OTYPE_MONEY then
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_MISCELLANEOUS,
				day,
				location.s,
				producedObjs[i].copper)
		end
	end
end

-- Handles USING activity
function Analyst:USING (day, detail, consumed, produced)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_CONSUMED_USING,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_USING,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		end
	end
end

-- Handles VENDORING activity
function Analyst:VENDORING (day, detail, consumed, produced)
	-- Filter
	local consumedObjs = self:ParseObjects(consumed)
	local producedObjs = self:ParseObjects(produced)
	local moneySpent = self:FilterObjects(consumedObjs, ANALYST_OTYPE_MONEY)
	local itemsConsumed = self:FilterObjects(consumedObjs, ANALYST_OTYPE_ITEM)
	local moneyGained = self:FilterObjects(producedObjs, ANALYST_OTYPE_MONEY)
	local itemsProduced = self:FilterObjects(producedObjs, ANALYST_OTYPE_ITEM)

	-- Token trades
	if #moneySpent == 0 and #moneyGained == 0 then
		for i = 1, #itemsConsumed do
			self:CreateFact(
				ANALYST_MEASURE_MERCHANT_ITEM_SWAPED,
				day,
				itemsConsumed[i].itemName,
				itemsConsumed[i].count)
		end
		for i = 1, #itemsProduced do
			self:CreateFactProduced(
				ANALYST_MEASURE_MERCHANT_ITEM_SWAPED,
				day,
				itemsProduced[i].itemName,
				itemsProduced[i].count)
		end
		return
	end
	
	-- Selling
	if #moneyGained == #itemsConsumed then
		for i = 1, #moneyGained do
			self:CreateFact(
				ANALYST_MEASURE_MONEY_GAINED_SELLING,
				day,
				itemsConsumed[i].itemName,
				moneyGained[i].copper)
			self:RegisterVendorValue(
				itemsConsumed[i].itemId,
				moneyGained[i].copper / itemsConsumed[i].count);
		end
	else
		local copper = 0
		for i = 1, #moneyGained do
			copper = copper + moneyGained[i].copper
		end
		self:CreateFact(
			ANALYST_MEASURE_MONEY_GAINED_SELLING,
			day,
			L:GetTranslation("AUTOMATED"),
			copper)
	end
	for i = 1, #itemsConsumed do
		self:CreateFact(
			ANALYST_MEASURE_MERCHANT_ITEM_SOLD,
			day,
			itemsConsumed[i].itemName,
			itemsConsumed[i].count)
	end
	
	-- Buying (back)
	if #moneySpent == #itemsProduced then
		for i = 1, #moneySpent do
			self:CreateFact(
				ANALYST_MEASURE_MONEY_SPENT_BUYING,
				day,
				itemsProduced[i].itemName,
				moneySpent[i].copper)
		end
	else
		local copper = 0
		for i = 1, #moneySpent do
			copper = copper + moneySpent[i].copper
		end
		self:CreateFact(
			ANALYST_MEASURE_MONEY_SPENT_BUYING,
			day,
			L:GetTranslation("AUTOMATED"),
			copper)
	end
	for i = 1, #itemsProduced do
		self:CreateFact(
			ANALYST_MEASURE_MERCHANT_ITEM_BOUGHT,
			day,
			itemsProduced[i].itemName,
			itemsProduced[i].count)
	end
end

-- Processes a crafting event
function Analyst:ProcessCrafting (measure, day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj.objType == ANALYST_OTYPE_ENCHANT then
		self:CreateFact(measure, day, detailObj.enchantName, 1)
		local consumedObjs = self:ParseObjects(consumed)
		for i in ipairs(consumedObjs) do
			if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_ITEM_CONSUMED_CRAFTING,
					day,
					consumedObjs[i].itemName,
					consumedObjs[i].count)
				self:CreateFactConsumed(
					measure,
					day,
					consumedObjs[i].itemName,
					consumedObjs[i].count)
			end
		end
		local producedObjs = self:ParseObjects(produced)
		for i in ipairs(producedObjs) do
			if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
				self:CreateFact(
					ANALYST_MEASURE_ITEM_PRODUCED_CRAFTING,
					day,
					producedObjs[i].itemName,
					producedObjs[i].count)
				self:CreateFactProduced(
					measure,
					day,
					producedObjs[i].itemName,
					producedObjs[i].count)
			end
		end
	end
end

-- Processes a discrafting event 
function Analyst:ProcessDiscrafting (measure, day, detail, consumed, produced)
	self:CreateFact(measure, day, nil, 1)
	local consumedObjs = self:ParseObjects(consumed)
	for i in ipairs(consumedObjs) do
		if consumedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFactConsumed(
				measure,
				day,
				consumedObjs[i].itemName,
				consumedObjs[i].count)
		end
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFactProduced(
				measure,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		end
	end
end

-- Processes a crafting event
function Analyst:ProcessGathering (measure, day, detail, consumed, produced)
	local detailObj = self:ParseObject(detail)
	if detailObj then
		self:CreateFact(measure, day, detailObj.s, 1)
	else
		self:CreateFact(measure, day, nil, 1)
	end
	local producedObjs = self:ParseObjects(produced)
	for i in ipairs(producedObjs) do
		if producedObjs[i].objType == ANALYST_OTYPE_ITEM then
			self:CreateFact(
				ANALYST_MEASURE_ITEM_PRODUCED_GATHERING,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
			self:CreateFactProduced(
				measure,
				day,
				producedObjs[i].itemName,
				producedObjs[i].count)
		end
	end
end
