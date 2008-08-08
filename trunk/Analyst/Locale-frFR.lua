--[[

$Revision: 79769 $

(C) Copyright 2007,2008 Bethink (bethink at naef dot com)
(C) Copyright 2008 Laumac

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

L:RegisterTranslations("frFR", function () return {
	-- Slash commands
	["SLASH_COMMANDS"] = { "/analyst" },
	["ECONOMY"] = "Panneau d'\195\169conomie",
	["ECONOMY_DESC"] = "Ouvrir le panneau d'\195\169conomie.",
	["START_DAY_OF_WEEK"] = "Premier jour de la semaine",
	["START_DAY_OF_WEEK_DESC"] = "R\195\169gler le premier jour de la semaine (1-7), avec un lundi.",
	["SHOW_GOLD"] = "Montrer l'\195\169change d'argent",
	["SHOW_GOLD_DESC"] = "R\195\169gler comment afficher le total de gain/perte d'argent dans le titre.",
	["ECONOMY_FRAME_HINT"] = "|cFFFFFF00Cliquer|r pour ouvrir le panneau d'\195\169conomie.",

	-- Bindings
	["BINDING_HEADER_ANALYST"] = "Analyst",
	["BINDING_NAME_ECONOMY"] = "Ouvrir le panneau d'\195\169conomie",

	-- Crafts
	["Enchanting"] = "Enchantement", -- Enchanting craft

	-- Trade skill lines
	["Alchemy"] = "Alchimie",
	["Blacksmithing"] = "Forge",
	["Cooking"] = "Cuisine",
	["First Aid"] = "Secourisme",
	["Jewelcrafting"] = "Joaillerie",
	["Leatherworking"] = "Travail du cuir",
	["Tailoring"] = "Couture",

	-- Trade skill spells
	["Extract Gas"] = "Extraction de gaz", -- Extract gas skill
	["Fishing"] = "P\195\170che", -- Fishing skill
	["Herb Gathering"] = "Herboristerie", -- Herb gathering skill
	["Mining"] = "Minage", -- Mining skill
	["Disenchant"] = "D\195\169senchantement", -- Disenchanting skill
	["Prospecting"] = "Prospection", -- Prospecting skill
	["Skinning"] = "D\195\169pe\195\167age", -- Skinning skill

	-- Generic spells
	["Opening"] = "Ouverture", -- Opening

	-- Purchases
	["BANK_SLOT"] = "Emplacement de banque",
	["PETITION"] = "P\195\169tition",
	["GUILD_CHARTER"] = "Charte de guilde",
	["GUILD_CREST"] = "Blason de guilde",
	["STABLE_SLOT"] = "Emplacement d'\195\169table",
	["GUILD_BANK_TAB"] = "Onglet de de banque de guilde",

	-- Capture
	["GROUPED"] = "(group\195\169)",

	-- Measures
	["MONEY_GAINED_TOTAL"] = "Argent total gagn\195\169",
	["MONEY_GAINED_QUESTING"] = "Qu\195\170te",
	["MONEY_GAINED_LOOTING"] = "Butin",
	["MONEY_GAINED_OPENING"] = "Ouverture",
	["MONEY_GAINED_SELLING"] = "Vendeur",
	["MONEY_GAINED_AUCTION"] = "Hotel de ventes",
	["MONEY_GAINED_GUILD_BANKING"] = "Banque de guilde",
	["MONEY_GAINED_TRADING"] = "Commerce",
	["MONEY_GAINED_RECEIVING"] = "Mail",
	["MONEY_GAINED_MISCELLANEOUS"] = "Divers",
	["MONEY_SPENT_TOTAL"] = "Argent total d\195\169pens\195\169",
	["MONEY_SPENT_QUESTING"] = "Qu\195\170te",
	["MONEY_SPENT_BUYING"] = "Vendeur",
	["MONEY_SPENT_TRAINING"] = "Entraineur",
	["MONEY_SPENT_PURCHASING"] = "Achat",
	["MONEY_SPENT_REPAIRING"] = "R\195\169paration",
	["MONEY_SPENT_TAXI"] = "Vols",
	["MONEY_SPENT_AUCTION"] = "Hotel de ventes",
	["MONEY_SPENT_GUILD_BANKING"] = "Banque de guilde",
	["MONEY_SPENT_TRADING"] = "Commerce",
	["MONEY_SPENT_SENDING"] = "Mail",
	["MONEY_SPENT_MISCELLANEOUS"] = "Divers",
	["ITEM_CONSUMED_QUESTING"] = "Qu\195\170te",
	["ITEM_CONSUMED_CASTING"] = "Lanc\195\169",
	["ITEM_CONSUMED_USING"] = "Utilis\195\169",
	["ITEM_CONSUMED_OPENING"] = "Ouvert",
	["ITEM_CONSUMED_CRAFTING"] = "Cr\195\169\195\169",
	["ITEM_CONSUMED_SOCKETING"] = "Serti",
	["ITEM_CONSUMED_DESTROYING"] = "D\195\169truit",
	["ITEM_CONSUMED_SENDING"] = "Envoy\195\169 par mail",
	["ITEM_CONSUMED_MISCELLANEOUS"] = "Divers",
	["ITEM_PRODUCED_QUESTING"] = "Qu\195\170te",
	["ITEM_PRODUCED_CASTING"] = "Lanc\195\169",
	["ITEM_PRODUCED_USING"] = "Utilis\195\169",
	["ITEM_PRODUCED_OPENING"] = "Ouvert",
	["ITEM_PRODUCED_CRAFTING"] = "Cr\195\169\195\169",
	["ITEM_PRODUCED_GATHERING"] = "R\195\169colt\195\169",
	["ITEM_PRODUCED_LOOTING"] = "Ramass\195\169",
	["ITEM_PRODUCED_BATTLEFIELD"] = "Champs de bataille",
	["ITEM_PRODUCED_RECEIVING"] = "Recu par mail",
	["ITEM_PRODUCED_MISCELLANEOUS"] = "Divers",
	["QUESTING_FINISHED"] = "Qu\195\170te finie",
	["QUESTING_MONEY_GAINED"] = "Argent gagn\195\169",
	["QUESTING_MONEY_SPENT"] = "Argent d\195\169pens\195\169",
	["QUESTING_ITEM_PRODUCED"] = "Objet produit",
	["QUESTING_ITEM_CONSUMED"] = "Objet consomm\195\169",
	["LOOTING_MOB"]= "Monstres",
	["LOOTING_MONEY"] = "Argent",
	["LOOTING_ITEM"] = "Objets",
	["LOOTING_ITEM_VENDOR_VALUE"] = "Prix de vente",
	["MERCHANT_MONEY_GAINED"] = "Ventes",
	["MERCHANT_MONEY_SPENT_BUYING"] = "Achats",
	["MERCHANT_MONEY_SPENT_REPAIRING"] = "R\195\169parations",
	["MERCHANT_ITEM_SOLD"] = "Objets vendus",
	["MERCHANT_ITEM_BOUGHT"] = "Objets achet\195\169s",
	["MERCHANT_ITEM_SWAPED"] = "Objets \195\169chang\195\169s",
	["AUCTION_POSTED"] = "Ench\195\168res post\195\169es",
	["AUCTION_SOLD"] = "Ench\195\168res vendues",
	["AUCTION_EXPIRED"] = "Ench\195\168res expir\195\169es",
	["AUCTION_CANCELLED"] = "Ench\195\168res annul\195\169es",
	["AUCTION_MONEY_GAINED"] = "Argent gagn\195\169",
	["AUCTION_DEPOSIT_PAID"] = "D\195\169pot",
	["AUCTION_DEPOSIT_CREDITED"] = "Cr\195\169dit",
	["AUCTION_CONSIGNMENT"] = "Envoi",
	["AUCTION_BID"] = "Offre aux ench\195\168res",
	["AUCTION_BOUGHT"] = "Ench\195\168res achet\195\169es",
	["AUCTION_OUTBID"] = "Surrench\195\168res",
	["AUCTION_MONEY_SPENT"] = "Argent d\195\169pens\195\169",
	["GUILD_BANKING_MONEY_WITHDRAWN"] = "Argent retir\195\169",
	["GUILD_BANKING_MONEY_DEPOSITED"] = "Argent d\195\169pos\195\169",
	["GUILD_BANKING_ITEM_WITHDRAWN"] = "Objets retir\195\169s",
	["GUILD_BANKING_ITEM_DEPOSITED"] = "Objets d\195\169pos\195\169s",
	["TRADING_MONEY_RECEIVED"] = "Argent recu",
	["TRADING_MONEY_GIVEN"] = "Argent donn\195\169",
	["TRADING_ITEM_RECEIVED"] = "Objets recus",
	["TRADING_ITEM_GIVEN"] = "Objets donn\195\169s",
	["CRAFTING_TOTAL"] = "Activit\195\169 de m\195\169tier",
	["CRAFTING_ALCHEMY"] = "Alchimie",
	["CRAFTING_BLACKSMITHING"] = "Forge",
	["CRAFTING_COOKING"] = "Cuisine",
	["CRAFTING_DISENCHANTING"] = "D\195\169senchantement",
	["CRAFTING_ENCHANTING"] = "Enchantement",
	["CRAFTING_FIRST_AID"] = "Secourisme",
	["CRAFTING_JEWELCRAFTING"] = "Joaillerie",
	["CRAFTING_LEATHERWORKING"] = "Travail du cuir",
	["CRAFTING_PROSPECTING"] = "Prospection",
	["CRAFTING_SMELTING"] = "Fonte",
	["CRAFTING_TAILORING"] = "Couture",
	["GATHERING_TOTAL"] = "Activit\195\169 de r\195\169colte",
	["GATHERING_EXTRACT_GAS"] = "Extraction de gaz",
	["GATHERING_FISHING"] = "P\195\170che",
	["GATHERING_HERB_GATHERING"] = "Herboristerie",
	["GATHERING_MINING"] = "Minage",
	["GATHERING_SKINNING"] = "D\195\169pe\195\167age",

	-- Measures
	["AUTOMATED"] = "(Automatis\195\169)",

	-- Reports
	["OVERVIEW"] = "Vue g\195\169n\195\169rale",
	["MONEY_GAINED"] = "Argent gagn\195\169",
	["MONEY_SPENT"] = "Argent d\195\169pens\195\169",
	["ITEM_CONSUMED"] = "Objets consomm\195\169s",
	["ITEM_PRODUCED"] = "Objets produits",
	["QUESTING"] = "Qu\195\170te",
	["LOOTING"] = "Butin",
	["MERCHANT"] = "Vendeur",
	["AUCTION"] = "Hotel de ventes",
	["GUILD_BANK"] = "Banque de guilde",
	["TRADING"] = "Commerce",
	["CRAFTING"] = "Cr\195\169ation",
	["GATHERING"] = "R\195\169colte",

	-- Measure
	["TALENT_WIPING"] = "Resp\195\169******ation de talent",

	-- Periods
	["TODAY"] = "Aujourd'hui",
	["YESTERDAY"] = "Hier",
	["THIS_WEEK"] = "Cette semaine",
	["THIS_MONTH"] = "Ce mois",
	["LAST_7_DAYS"] = "7 dernier jours",
	["LAST_30_DAYS"] = "30 derniers jours",

	-- Economy frame
	["ECONOMY_FRAME_TITLE"] = "Economie",
	["ALL_CHARACTERS"] = "Tous les persos",
	["ALL_CHARACTERS_TOOLTIP"] = "Si coch\195\169, les donn\195\169es seront affich\195\169es en cumulant les donn\195\169es de tous les persos du compte. Si d\195\169coch\195\169, les donn\195\169es seront en fonction du personnage actuellement connect\195\169.",
	["NO_DETAIL_INFO"] = "Aucune information d\195\169taill\195\169e disponible.",
	["CONSUMED"] = "Consomm\195\169",
	["PRODUCED"] = "Produit",
} end)
