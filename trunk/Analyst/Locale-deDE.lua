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

L:RegisterTranslations("deDE", function () return {
	-- Slsah commands
	["SLASH_COMMANDS"] = { "/analyst" },
	["ECONOMY"] = "Ökonomie-Panel",
	["ECONOMY_DESC"] = "Blendet das Ökonomie-Panel ein oder aus.",
	["START_DAY_OF_WEEK"] = "Anfangstag der Woche",
	["START_DAY_OF_WEEK_DESC"] = "Bestimmt den Anfangstag der Woche (1-7), wobei 1 für Montag steht.",
	["SHOW_GOLD"] = "Goldveränderung anzeigen",
	["SHOW_GOLD_DESC"] = "Bestimmt, ob das in der Periode verdiente oder ausgegebene Gold im Titel angezeigt wird.",
	["ECONOMY_FRAME_HINT"] = "|cFFFFFF00Klicken|r, um das Ökonomie-Panel ein- oder auszublenden.",
	
	-- Bindings
	["BINDING_HEADER_ANALYST"] = "Analyst",
	["BINDING_NAME_ECONOMY"] = "\195\150konomie-Panel ein- oder ausblenden",
	
	-- Crafts
	["Enchanting"] = "Verzauberkunst", -- Enchanting craft
	
	-- Trade skill lines
	["Alchemy"] = "Alchimie",
	["Blacksmithing"] = "Schmiedekunst",
	["Cooking"] = "Kochen",
	["First Aid"] = "Erste Hilfe",
	["Jewelcrafting"] = "Juwelenschleifen",
	["Leatherworking"] = "Lederverarbeitung",
	["Tailoring"] = "Schneiderei",
	
	-- Trade skill spells
	["Extract Gas"] = "Gas extahieren", -- Extract gas skill
	["Fishing"] = "Fischen", -- Fishing skill
	["Herb Gathering"] = "Kräutersammeln", -- Herb gathering skill
	["Mining"] = "Bergbau", -- Mining skill
	["Disenchant"] = "Entzaubern", -- Disenchanting skill
	["Prospecting"] = "Sondieren", -- Prospecting skill
	["Skinning"] = "Kürschnerei", -- Skinning skill
	
	
	-- Generic spells
	["Opening"] = "Öffnen", -- Opening
	
	-- Purchases
	["BANK_SLOT"] = "Bank-Slot",
	["PETITION"] = "Gesuch",
	["GUILD_CHARTER"] = "Gildensatzung",
	["GUILD_CREST"] = "Gildenwappen",
	["STABLE_SLOT"] = "Stall-Slot",
	["GUILD_BANK_TAB"] = "Gildenbankreiter",
	
	-- Capture
	["GROUPED"] = "(Gruppiert)",
	
	-- Measures
	["MONEY_GAINED_TOTAL"] = "Total Gold verdient",
	["MONEY_GAINED_QUESTING"] = "Questen",
	["MONEY_GAINED_LOOTING"] = "Looten",
	["MONEY_GAINED_OPENING"] = "Öffnen",
	["MONEY_GAINED_SELLING"] = "Händlerverkauf",
	["MONEY_GAINED_AUCTION"] = "Auktionen",
	["MONEY_GAINED_GUILD_BANKING"] = "Gildenbank",
	["MONEY_GAINED_TRADING"] = "Handeln",
	["MONEY_GAINED_RECEIVING"] = "Post",
	["MONEY_GAINED_MISCELLANEOUS"] = "Verschiedenes",
	["MONEY_SPENT_TOTAL"] = "Total Gold ausgegeben",
	["MONEY_SPENT_QUESTING"] = "Questen",
	["MONEY_SPENT_BUYING"] = "Händlerkauf",
	["MONEY_SPENT_TRAINING"] = "Trainer",
	["MONEY_SPENT_PURCHASING"] = "Beschaffung",
	["MONEY_SPENT_REPAIRING"] = "Reparieren",
	["MONEY_SPENT_TAXI"] = "Flüge",
	["MONEY_SPENT_AUCTION"] = "Auktionen",
	["MONEY_SPENT_GUILD_BANKING"] = "Gildenbank",
	["MONEY_SPENT_TRADING"] = "Handeln",
	["MONEY_SPENT_SENDING"] = "Post",
	["MONEY_SPENT_MISCELLANEOUS"] = "Verschiedenes",
	["ITEM_CONSUMED_QUESTING"] = "Questen",
	["ITEM_CONSUMED_CASTING"] = "Wirken",
	["ITEM_CONSUMED_USING"] = "Benutzen",
	["ITEM_CONSUMED_OPENING"] = "Öffnen",
	["ITEM_CONSUMED_CRAFTING"] = "Verarbeitung",
	["ITEM_CONSUMED_SOCKETING"] = "Sockeln",
	["ITEM_CONSUMED_DESTROYING"] = "Zerstört",
	["ITEM_CONSUMED_SENDING"] = "Versandt per Post",
	["ITEM_CONSUMED_MISCELLANEOUS"] = "Verschiedenes",
	["ITEM_PRODUCED_QUESTING"] = "Questen",
	["ITEM_PRODUCED_CASTING"] = "Wirken",
	["ITEM_PRODUCED_USING"] = "Benutzen",
	["ITEM_PRODUCED_OPENING"] = "Öffnen",
	["ITEM_PRODUCED_CRAFTING"] = "Verarbeitung",
	["ITEM_PRODUCED_GATHERING"] = "Sammeln",
	["ITEM_PRODUCED_LOOTING"] = "Looten",
	["ITEM_PRODUCED_BATTLEFIELD"] = "Schlachtfeld",
	["ITEM_PRODUCED_RECEIVING"] = "Erhalten per Post",
	["ITEM_PRODUCED_MISCELLANEOUS"] = "Verschiedenes",
	["QUESTING_FINISHED"] = "Quests abgeschlossen",
	["QUESTING_MONEY_GAINED"] = "Gold verdient",
	["QUESTING_MONEY_SPENT"] = "Gold ausgegeben",
	["QUESTING_ITEM_PRODUCED"] = "Gegenstände hergest.",
	["QUESTING_ITEM_CONSUMED"] = "Gegenstände verbr.",
	["LOOTING_MOB"]= "Mobs",
	["LOOTING_MONEY"] = "Gold",
	["LOOTING_ITEM"] = "Gegenstände",
	["LOOTING_ITEM_VENDOR_VALUE"] = "Händlerwert",
	["MERCHANT_MONEY_GAINED"] = "Verkäufe",
	["MERCHANT_MONEY_SPENT_BUYING"] = "Einkäufe",
	["MERCHANT_MONEY_SPENT_REPAIRING"] = "Reparieren",
	["MERCHANT_ITEM_SOLD"] = "Gegenstände verkauft",
	["MERCHANT_ITEM_BOUGHT"] = "Gegenstände gekauft",
	["MERCHANT_ITEM_SWAPED"] = "Gegenstände getauscht",
	["AUCTION_POSTED"] = "Auktionen erstellt",
	["AUCTION_SOLD"] = "Auktionen verkauft",
	["AUCTION_EXPIRED"] = "Auktionen abgelaufen",
	["AUCTION_CANCELLED"] = "Auktionen abgebrochen",
	["AUCTION_MONEY_GAINED"] = "Gold verdient",
	["AUCTION_DEPOSIT_PAID"] = "Anzahlung",
	["AUCTION_DEPOSIT_CREDITED"] = "Gutschrift",
	["AUCTION_CONSIGNMENT"] = "Gebühr",
	["AUCTION_BID"] = "Auktionen geboten",
	["AUCTION_BOUGHT"] = "Auktionen gekauft",
	["AUCTION_OUTBID"] = "Auktionen überboten",
	["AUCTION_MONEY_SPENT"] = "Gold ausgegeben",
	["GUILD_BANKING_MONEY_WITHDRAWN"] = "Gold entnommen",
	["GUILD_BANKING_MONEY_DEPOSITED"] = "Gold eingelagert",
	["GUILD_BANKING_ITEM_WITHDRAWN"] = "Gegenstände entn.",
	["GUILD_BANKING_ITEM_DEPOSITED"] = "Gegenstände eingel.",
	["TRADING_MONEY_RECEIVED"] = "Gold erhalten",
	["TRADING_MONEY_GIVEN"] = "Gold gegeben",
	["TRADING_ITEM_RECEIVED"] = "Gegenstände erhalten",
	["TRADING_ITEM_GIVEN"] = "Gegenstände gegeben",
	["CRAFTING_TOTAL"] = "Verarbeitungsaktivität",
	["CRAFTING_ALCHEMY"] = "Alchimie",
	["CRAFTING_BLACKSMITHING"] = "Schmiedekunst",
	["CRAFTING_COOKING"] = "Kochen",
	["CRAFTING_DISENCHANTING"] = "Entzaubern",
	["CRAFTING_ENCHANTING"] = "Verzauberkunst",
	["CRAFTING_FIRST_AID"] = "Erste Hilfe",
	["CRAFTING_JEWELCRAFTING"] = "Juwelenschleifen",
	["CRAFTING_LEATHERWORKING"] = "Lederverarbeitung",
	["CRAFTING_PROSPECTING"] = "Sondieren",
	["CRAFTING_SMELTING"] = "Schmelzen",
	["CRAFTING_TAILORING"] = "Schneiderei",
	["GATHERING_TOTAL"] = "Sammelaktivität",
	["GATHERING_EXTRACT_GAS"] = "Gas extrahieren",
	["GATHERING_FISHING"] = "Fischen",
	["GATHERING_HERB_GATHERING"] = "Kräuterkunde",
	["GATHERING_MINING"] = "Bergbau",
	["GATHERING_SKINNING"] = "Kürschnerei",
	
	-- Measures
	["AUTOMATED"] = "(Automatisiert)",
	
	-- Reports
	["OVERVIEW"] = "Übersicht",
	["MONEY_GAINED"] = "Gold verdient",
	["MONEY_SPENT"] = "Gold ausgegeben",
	["ITEM_CONSUMED"] = "Gegenstände verbraucht",
	["ITEM_PRODUCED"] = "Gegenstände hergestellt",
	["QUESTING"] = "Questen",
	["LOOTING"] = "Looten",
	["MERCHANT"] = "Händler",
	["AUCTION"] = "Auktionshaus",
	["GUILD_BANK"] = "Gildenbank",
	["TRADING"] = "Handeln",
	["CRAFTING"] = "Verarbeitung",
	["GATHERING"] = "Sammeln",
	
	-- Measure
	["TALENT_WIPING"] = "Talente löschen",
	
	-- Periods
	["TODAY"] = "Heute",
	["YESTERDAY"] = "Gestern",
	["THIS_WEEK"] = "Diese Woche",
	["THIS_MONTH"] = "Dieser Monat",
	["LAST_7_DAYS"] = "Letzte 7 Tage",
	["LAST_30_DAYS"] = "Letzte 30 Tage",
	
	-- Economy frame
	["ECONOMY_FRAME_TITLE"] = "Ökonomie",
	["ALL_CHARACTERS"] = "Alle Charaktere",
	["ALL_CHARACTERS_TOOLTIP"] = "Wenn angewählt, dann werden die Daten für alle Charaktere auf diesem Konto angezeigt. Wenn abgewählt, dann werden die Daten für eingelogten Charakter angezeigt.",
	["NO_DETAIL_INFO"] = "Keine Detailinformationen verfügbar.",
	["CONSUMED"] = "Verbraucht",
	["PRODUCED"] = "Hergestellt",
} end)
