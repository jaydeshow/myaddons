﻿--[[

ARL-Vendor.lua

Vendor data for all of AckisRecipeList

$Date: 2008-09-15 17:22:49 +0000 (Mon, 15 Sep 2008) $
$Rev: 868 $

]]--

local L			= LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")
local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZONE		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()

local addon = AckisRecipeList

function addon:InitVendor()

	self:addVendorList(1, L["Wrahk"], BFAC["Horde"], BZONE["The Barrens"], "52, 32")
	self:addVendorList(2, L["Valdaron"], BFAC["Alliance"], BZONE["Darkshore"], "38, 41")
	self:addVendorList(3, L["Constance Brisboise"], BFAC["Horde"], BZONE["Tirisfal Glades"], "52, 56")
	self:addVendorList(4, L["Tharynn Bouden"], BFAC["Alliance"], BZONE["Elwynn Forest"], "42, 67")
	self:addVendorList(5, L["Borya"], BFAC["Horde"], BZONE["Orgrimmar"], "63, 51")
	self:addVendorList(6, L["Andrew Hilbert"], BFAC["Horde"], BZONE["Silverpine Forest"], "43, 40")
	self:addVendorList(7, L["Gina MacGregor"], BFAC["Alliance"], BZONE["Westfall"], "57, 54")
	self:addVendorList(8, L["Rathis Tomber"], BFAC["Horde"], BZONE["Ghostlands"], "47, 28")
	self:addVendorList(9, L["Mahu"], BFAC["Horde"], BZONE["Thunder Bluff"], "43, 44")
	self:addVendorList(10, L["Drake Lindgren"], BFAC["Alliance"], BZONE["Elwynn Forest"], "82, 66")
	self:addVendorList(11, L["Elynna"], BFAC["Alliance"], BZONE["Darnassus"], "64, 22")
	self:addVendorList(12, L["Ranik"], BFAC["Neutral"], BZONE["Ratchet"], "61, 38")
	self:addVendorList(13, L["Amy Davenport"], BFAC["Alliance"], BZONE["Redridge Mountains"], "29, 47")
	self:addVendorList(14, L["Jennabink Powerseam"], BFAC["Alliance"], BZONE["Wetlands"], "8, 55")
	self:addVendorList(15, L["Kiknikle"], BFAC["Neutral"], BZONE["The Barrens"], "41, 38")
	self:addVendorList(16, L["Millie Gregorian"], BFAC["Horde"], BZONE["Undercity"], "71, 28")
	self:addVendorList(17, L["Rann Flamespinner"], BFAC["Alliance"], BZONE["Loch Modan"], "36, 46")
	self:addVendorList(18, L["Yonada"], BFAC["Horde"], BZONE["The Barrens"], "44, 59")
	self:addVendorList(19, L["Zixil"], BFAC["Neutral"], BZONE["Hillsbrad Foothills"], "Patrols")
	self:addVendorList(20, L["Sheri Zipstitch"], BFAC["Alliance"], BZONE["Duskwood"], "75, 45")
	self:addVendorList(21, L["Danielle Zipstitch"], BFAC["Alliance"], BZONE["Duskwood"], "75, 45")
	self:addVendorList(22, L["Brienna Starglow"], BFAC["Alliance"], BZONE["Feralas"], "88, 45")
	self:addVendorList(23, L["Jun'ha"], BFAC["Horde"], BZONE["Arathi Highlands"], "72.7, 36.4")
	self:addVendorList(24, L["Kireena"], BFAC["Horde"], BZONE["Desolace"], "51, 53")
	self:addVendorList(25, L["Wenna Silkbeard"], BFAC["Alliance"], BZONE["Wetlands"], "25, 25")
	self:addVendorList(26, L["Mallen Swain"], BFAC["Horde"], BZONE["Hillsbrad Foothills"], "61.9, 21.0")
	self:addVendorList(27, L["Xizk Goodstitch"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 76")
	self:addVendorList(28, L["Ghok'kah"], BFAC["Horde"], BZONE["Dustwallow Marsh"], "35, 31")
	self:addVendorList(29, L["Micha Yance"], BFAC["Alliance"], BZONE["Hillsbrad Foothills"], "50, 56")
	self:addVendorList(30, L["Narkk"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 74")
	self:addVendorList(31, L["Vizzklick"], BFAC["Neutral"], BZONE["Tanaris"], "51, 27")
	self:addVendorList(32, L["Asarnan"], BFAC["Neutral"], BZONE["Netherstorm"], "44, 34")
	self:addVendorList(33, L["Dealer Malij"], BFAC["Neutral"], BZONE["Netherstorm"], "44, 34")
	self:addVendorList(34, L["Egomis"], BFAC["Alliance"], BZONE["The Exodar"], "40, 39")
	self:addVendorList(35, L["Erilia"], BFAC["Horde"], BZONE["Eversong Woods"], "55, 54")
	self:addVendorList(36, L["Felannia"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "52, 36")
	self:addVendorList(37, L["Jessara Cordell"], BFAC["Alliance"], BZONE["Stormwind City"], "43, 64")
	self:addVendorList(38, L["Johan Barnes"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "53, 66")
	self:addVendorList(39, L["Kania"], BFAC["Neutral"], BZONE["Silithus"], "52, 39")
	self:addVendorList(40, L["Kithas"], BFAC["Horde"], BZONE["Orgrimmar"], "53, 38")
	self:addVendorList(41, L["Leo Sarn"], BFAC["Horde"], BZONE["Silverpine Forest"], "53, 82")
	self:addVendorList(42, L["Lilly"], BFAC["Horde"], BZONE["Silverpine Forest"], "43, 50")
	self:addVendorList(43, L["Lyna"], BFAC["Horde"], BZONE["Silvermoon City"], "69, 24")
	self:addVendorList(44, L["Madame Ruby"], BFAC["Neutral"], BZONE["Shattrath City"], "63, 70")
	self:addVendorList(45, L["Nata Dawnstrider"], BFAC["Horde"], BZONE["Thunder Bluff"], "45, 39")
	self:addVendorList(46, L["Thaddeus Webb"], BFAC["Horde"], BZONE["Undercity"], "62, 60")
	self:addVendorList(47, L["Tilli Thistlefuzz"], BFAC["Alliance"], BZONE["Ironforge"], "60, 44")
	self:addVendorList(48, L["Vaean"], BFAC["Alliance"], BZONE["Darnassus"], "58, 14")
	self:addVendorList(49, L["Yurial Soulwater"], BFAC["Neutral"], BZONE["Shattrath City"], "44, 97")
	self:addVendorList(50, L["Outfitter Eric"], BFAC["Alliance"], BZONE["Ironforge"], "43, 29")
	self:addVendorList(51, L["Cowardly Crosby"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "26, 82")
	self:addVendorList(52, L["Alexandra Bolero"], BFAC["Alliance"], BZONE["Stormwind City"], "43, 74")
	self:addVendorList(53, L["Qia"], BFAC["Neutral"], BZONE["Winterspring"], "61, 37")
	self:addVendorList(54, L["Shen'dralar Provisioner"], BFAC["Neutral"], BZONE["Dire Maul"], "Dire Maul Library")
	self:addVendorList(55, L["Darnall"], BFAC["Neutral"], BZONE["Moonglade"], "51, 33")
	self:addVendorList(56, L["Lorelae Wintersong"], BFAC["Neutral"], BZONE["Moonglade"], "48, 40")
	self:addVendorList(57, L["Mishta"], BFAC["Neutral"], BZONE["Silithus"], "49, 36")
	self:addVendorList(58, L["Deynna"], BFAC["Horde"], BZONE["Silvermoon City"], "55, 51")
	self:addVendorList(59, L["Eiin"], BFAC["Neutral"], BZONE["Shattrath City"], "65, 67")
	self:addVendorList(60, L["Neii"], BFAC["Alliance"], BZONE["The Exodar"], "64, 68")
	self:addVendorList(61, L["Mathar G'ochar"], BFAC["Horde"], BZONE["Nagrand"], "56, 37")
	self:addVendorList(62, L["Arrond"], BFAC["Neutral"], BZONE["Shadowmoon Valley"], "55, 58")
	self:addVendorList(63, L["Muheru the Weaver"], BFAC["Alliance"], BZONE["Zangarmarsh"], "40, 28")
	self:addVendorList(64, L["Zurai"], BFAC["Horde"], BZONE["Zangarmarsh"], "85, 54")
	self:addVendorList(65, L["Gidge Spellweaver"], BFAC["Neutral"], BZONE["Shattrath City"], "66, 68")
	self:addVendorList(66, L["Andrion Darkspinner"], BFAC["Neutral"], BZONE["Shattrath City"], "66, 67")
	self:addVendorList(67, L["Fradd Swiftgear"], BFAC["Alliance"], BZONE["Wetlands"], "26, 27")
	self:addVendorList(68, L["Jinky Twizzlefixxit"], BFAC["Neutral"], BZONE["Thousand Needles"], "77, 77")
	self:addVendorList(69, L["Namdo Bizzfizzle"], BFAC["Alliance"], BZONE["Gnomeregan"], "???")
	self:addVendorList(70, L["Sovik"], BFAC["Horde"], BZONE["Orgrimmar"], "75, 25")
	self:addVendorList(71, L["Crazk Sparks"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 76")
	self:addVendorList(72, L["Gagsprocket"], BFAC["Neutral"], BZONE["The Barrens"], "62, 36")
	self:addVendorList(73, L["Darian Singh"], BFAC["Alliance"], BZONE["Stormwind City"], "29, 67")
	self:addVendorList(74, L["Gearcutter Cogspinner"], BFAC["Alliance"], BZONE["Ironforge"], "67, 43")
	self:addVendorList(75, L["Rizz Loosebolt"], BFAC["Neutral"], BZONE["Alterac Mountains"], "47, 35")
	self:addVendorList(76, L["Kzixx"], BFAC["Neutral"], BZONE["Duskwood"], "83, 20")
	self:addVendorList(77, L["Veenix"], BFAC["Neutral"], BZONE["Stonetalon Mountains"], "58, 51")
	self:addVendorList(78, L["Mazk Snipeshot"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 75")
	self:addVendorList(79, L["Gnaz Blunderflame"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "50, 35")
	self:addVendorList(80, L["Ruppo Zipcoil"], BFAC["Neutral"], BZONE["The Hinterlands"], "34, 37")
	self:addVendorList(81, L["Zan Shivsproket"], BFAC["Neutral"], BZONE["Alterac Mountains"], "86, 80")
	self:addVendorList(82, L["Yuka Screwspigot"], BFAC["Neutral"], BZONE["Burning Steppes"], "66, 22")
	self:addVendorList(83, L["Knaz Blunderflame"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "50, 35")
	self:addVendorList(84, L["Blizrik Buckshot"], BFAC["Neutral"], BZONE["Tanaris"], "50, 27")
	self:addVendorList(85, L["Jubie Gadgetspring"], BFAC["Neutral"], BZONE["Azshara"], "45, 91")
	self:addVendorList(86, L["Zorbin Fandazzle"], BFAC["Neutral"], BZONE["Feralas"], "44, 43")
	self:addVendorList(87, L["Xizzer Fizzbolt"], BFAC["Neutral"], BZONE["Winterspring"], "60, 38")
	self:addVendorList(88, L["Viggz Shinesparked"], BFAC["Neutral"], BZONE["Shattrath City"], "64, 69")
	self:addVendorList(89, L["Daggle Ironshaper"], BFAC["Alliance"], BZONE["Shadowmoon Valley"], "36, 54")
	self:addVendorList(90, L["Mixie Farshot"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "61, 81")
	self:addVendorList(91, L["Captured Gnome"], BFAC["Neutral"], BZONE["Zangarmarsh"], "32, 48")
	self:addVendorList(92, L["Feera"], BFAC["Alliance"], BZONE["The Exodar"], "53, 912")
	self:addVendorList(93, L["Wind Trader Lathrai"], BFAC["Neutral"], BZONE["Shattrath City"], "72, 31")
	self:addVendorList(94, L["Yatheon"], BFAC["Horde"], BZONE["Silvermoon City"], "75, 40")
	self:addVendorList(95, L["Lebowski"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "55, 65")
	self:addVendorList(96, L["Mavralyn"], BFAC["Alliance"], BZONE["Darkshore"], "37, 41")
	self:addVendorList(97, L["Kalldan Felmoon"], BFAC["Neutral"], BZONE["Wailing Caverns"], "???")
	self:addVendorList(98, L["Clyde Ranthal"], BFAC["Alliance"], BZONE["Redridge Mountains"], "88, 70")
	self:addVendorList(99, L["Harlown Darkweave"], BFAC["Alliance"], BZONE["Ashenvale"], "18, 59")
	self:addVendorList(100, L["Bombus Finespindle"], BFAC["Alliance"], BZONE["Ironforge"], "39, 33")
	self:addVendorList(101, L["Tamar"], BFAC["Horde"], BZONE["Orgrimmar"], "62, 45")
	self:addVendorList(102, L["George Candarte"], BFAC["Horde"], BZONE["Hillsbrad Foothills"], "91, 38")
	self:addVendorList(103, L["Joseph Moore"], BFAC["Horde"], BZONE["Undercity"], "70, 58")
	self:addVendorList(104, L["Saenorion"], BFAC["Alliance"], BZONE["Darnassus"], "63, 21")
	self:addVendorList(105, L["Jangdor Swiftstrider"], BFAC["Horde"], BZONE["Feralas"], "74, 42")
	self:addVendorList(106, L["Pratt McGrubben"], BFAC["Alliance"], BZONE["Feralas"], "30, 42")
	self:addVendorList(107, L["Androd Fadran"], BFAC["Alliance"], BZONE["Arathi Highlands"], "45, 46")
	self:addVendorList(108, L["Tunkk"], BFAC["Horde"], BZONE["Arathi Highlands"], "74, 34")
	self:addVendorList(109, L["Blixrez Goodstitch"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 77")
	self:addVendorList(110, L["Christoph Jeffcoat"], BFAC["Horde"], BZONE["Hillsbrad Foothills"], "62, 19")
	self:addVendorList(111, L["Hammon Karwn"], BFAC["Alliance"], BZONE["Arathi Highlands"], "46, 47")
	self:addVendorList(112, L["Jandia"], BFAC["Horde"], BZONE["Thousand Needles"], "46, 51")
	self:addVendorList(113, L["Keena"], BFAC["Horde"], BZONE["Arathi Highlands"], "74.1, 32.7")
	self:addVendorList(114, L["Lardan"], BFAC["Alliance"], BZONE["Ashenvale"], "34, 49")
	self:addVendorList(115, L["Rikqiz"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 76")
	self:addVendorList(116, L["Helenia Olden"], BFAC["Alliance"], BZONE["Dustwallow Marsh"], "66, 51")
	self:addVendorList(117, L["Nioma"], BFAC["Alliance"], BZONE["The Hinterlands"], "13, 43")
	self:addVendorList(118, L["Zannok Hidepiercer"], BFAC["Neutral"], BZONE["Silithus"], "81, 17")
	self:addVendorList(119, L["Leonard Porter"], BFAC["Alliance"], BZONE["Western Plaguelands"], "43, 84")
	self:addVendorList(120, L["Werg Thickblade"], BFAC["Horde"], BZONE["Tirisfal Glades"], "83, 70")
	self:addVendorList(121, L["Masat T'andr"], BFAC["Neutral"], BZONE["Swamp of Sorrows"], "26, 31")
	self:addVendorList(122, L["Blimo Gadgetspring"], BFAC["Neutral"], BZONE["Azshara"], "45, 90")
	self:addVendorList(123, L["Plugger Spazzring"], BFAC["Neutral"], BZONE["Blackrock Depths"], "???")
	self:addVendorList(124, L["Gigget Zipcoil"], BFAC["Neutral"], BZONE["The Hinterlands"], "34, 38")
	self:addVendorList(125, L["Nergal"], BFAC["Neutral"], BZONE["Un'Goro Crater"], "43, 7")
	self:addVendorList(126, L["Haferet"], BFAC["Alliance"], BZONE["The Exodar"], "66, 73")
	self:addVendorList(127, L["Zaralda"], BFAC["Horde"], BZONE["Silvermoon City"], "84, 78")
	self:addVendorList(128, L["Cro Threadstrong"], BFAC["Neutral"], BZONE["Shattrath City"], "66, 67")
	self:addVendorList(129, L["Thomas Yance"], BFAC["Neutral"], BZONE["Old Hillsbrad Foothills"], "Patrols")
	self:addVendorList(130, L["Defias Profiteer"], BFAC["Neutral"], BZONE["Westfall"], "43, 66")
	self:addVendorList(131, L["Hagrus"], BFAC["Horde"], BZONE["Orgrimmar"], "46, 45")
	self:addVendorList(132, L["Xandar Goodbeard"], BFAC["Alliance"], BZONE["Loch Modan"], "82, 63")
	self:addVendorList(133, L["Hula'mahi"], BFAC["Horde"], BZONE["The Barrens"], "51, 30")
	self:addVendorList(134, L["Ulthir"], BFAC["Alliance"], BZONE["Darnassus"], "56, 24")
	self:addVendorList(135, L["Harklan Moongrove"], BFAC["Alliance"], BZONE["Ashenvale"], "50, 67")
	self:addVendorList(136, L["Kor'geld"], BFAC["Horde"], BZONE["Orgrimmar"], "55, 34")
	self:addVendorList(137, L["Soolie Berryfizz"], BFAC["Alliance"], BZONE["Ironforge"], "66, 54")
	self:addVendorList(138, L["Bliztik"], BFAC["Neutral"], BZONE["Duskwood"], "18, 54")
	self:addVendorList(139, L["Nasmara Moonsong"], BFAC["Neutral"], BZONE["Shattrath City"], "66, 67")
	self:addVendorList(140, L["Montarr"], BFAC["Horde"], BZONE["Thousand Needles"], "45, 50")
	self:addVendorList(141, L["Jeeda"], BFAC["Horde"], BZONE["Stonetalon Mountains"], "47, 61")
	self:addVendorList(142, L["Nandar Branson"], BFAC["Alliance"], BZONE["Hillsbrad Foothills"], "50, 57")
	self:addVendorList(143, L["Drovnar Strongbrew"], BFAC["Alliance"], BZONE["Arathi Highlands"], "46, 47")
	self:addVendorList(144, L["Glyx Brewright"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 78")
	self:addVendorList(145, L["Alchemist Pestlezugg"], BFAC["Neutral"], BZONE["Tanaris"], "50, 26")
	self:addVendorList(146, L["Bronk"], BFAC["Horde"], BZONE["Feralas"], "76, 43")
	self:addVendorList(147, L["Logannas"], BFAC["Alliance"], BZONE["Feralas"], "32, 43")
	self:addVendorList(148, L["Bro'kin"], BFAC["Neutral"], BZONE["Alterac Mountains"], "38, 38")
	self:addVendorList(149, L["Algernon"], BFAC["Horde"], BZONE["Undercity"], "51, 74")
	self:addVendorList(150, L["Maria Lumere"], BFAC["Alliance"], BZONE["Stormwind City"], "46, 78")
	self:addVendorList(151, L["Nina Lightbrew"], BFAC["Alliance"], BZONE["Blasted Lands"], "66, 18")
	self:addVendorList(152, L["Rartar"], BFAC["Horde"], BZONE["Swamp of Sorrows"], "45, 56")
	self:addVendorList(153, L["Borto"], BFAC["Alliance"], BZONE["Nagrand"], "53, 71")
	self:addVendorList(154, L["Alchemist Gribble"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "53, 65")
	self:addVendorList(155, L["Altaa"], BFAC["Alliance"], BZONE["The Exodar"], "28, 62")
	self:addVendorList(156, L["Apothecary Antonivich"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "52, 36")
	self:addVendorList(157, L["Daga Ramba"], BFAC["Horde"], BZONE["Blade's Edge Mountains"], "51, 57")
	self:addVendorList(158, L["Melaris"], BFAC["Horde"], BZONE["Silvermoon City"], "66, 19")
	self:addVendorList(159, L["Leeli Longhaggle"], BFAC["Alliance"], BZONE["Terokkar Forest"], "57, 53")
	self:addVendorList(160, L["Seer Janidi"], BFAC["Horde"], BZONE["Zangarmarsh"], "32, 51")
	self:addVendorList(161, L["Haalrun"], BFAC["Alliance"], BZONE["Zangarmarsh"], "67, 48")
	self:addVendorList(162, L["Quartermaster Davian Vaclav"], BFAC["Alliance"], BZONE["Nagrand"], "41, 44")
	self:addVendorList(163, L["Quartermaster Jaffrey Noreliqe"], BFAC["Horde"], BZONE["Nagrand"], "41, 44")
	self:addVendorList(164, L["Skreah"], BFAC["Neutral"], BZONE["Shattrath City"], "45, 19")
	self:addVendorList(165, L["Balai Lok'Wein"], BFAC["Horde"], BZONE["Dustwallow Marsh"], "36, 30")
	self:addVendorList(166, L["Deneb Walker"], BFAC["Alliance"], BZONE["Arathi Highlands"], "26, 59")
	self:addVendorList(167, L["Aresella"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "26, 62")
	self:addVendorList(168, L["Burko"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "22, 39")
	self:addVendorList(169, L["Bale"], BFAC["Horde"], BZONE["Felwood"], "34, 53")
	self:addVendorList(170, L["Malygen"], BFAC["Alliance"], BZONE["Felwood"], "62, 24")
	self:addVendorList(171, L["Jannos Ironwill"], BFAC["Alliance"], BZONE["Arathi Highlands"], "45, 47")
	self:addVendorList(172, L["Jazzrik"], BFAC["Neutral"], BZONE["Badlands"], "42, 52")
	self:addVendorList(173, L["Muuran"], BFAC["Horde"], BZONE["Desolace"], "55, 56")
	self:addVendorList(174, L["Jutak"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "27, 77")
	self:addVendorList(175, L["Kaita Deepforge"], BFAC["Alliance"], BZONE["Stormwind City"], "56, 17")
	self:addVendorList(176, L["Sumi"], BFAC["Horde"], BZONE["Orgrimmar"], "82, 24")
	self:addVendorList(177, L["Zarena Cromwind"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 75")
	self:addVendorList(178, L["Jaquilina Dramet"], BFAC["Alliance"], BZONE["Stranglethorn Vale"], "35, 10")
	self:addVendorList(179, L["Vharr"], BFAC["Horde"], BZONE["Stranglethorn Vale"], "32, 27")
	self:addVendorList(180, L["Krinkle Goodsteel"], BFAC["Neutral"], BZONE["Tanaris"], "51, 28")
	self:addVendorList(181, L["Gharash"], BFAC["Horde"], BZONE["Swamp of Sorrows"], "45, 51")
	self:addVendorList(182, L["Harggan"], BFAC["Alliance"], BZONE["The Hinterlands"], "13, 44")
	self:addVendorList(183, L["Aaron Hollman"], BFAC["Neutral"], BZONE["Shattrath City"], "64, 71")
	self:addVendorList(184, L["Arras"], BFAC["Alliance"], BZONE["The Exodar"], "61, 88")
	self:addVendorList(185, L["Eriden"], BFAC["Horde"], BZONE["Silvermoon City"], "80, 36")
	self:addVendorList(186, L["Krek Cragcrush"], BFAC["Horde"], BZONE["Shadowmoon Valley"], "29, 30")
	self:addVendorList(187, L["Loolruna"], BFAC["Alliance"], BZONE["Zangarmarsh"], "68, 50")
	self:addVendorList(188, L["Mari Stonehand"], BFAC["Alliance"], BZONE["Shadowmoon Valley"], "36, 55")
	self:addVendorList(189, L["Rohok"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "53, 38")
	self:addVendorList(190, L["Arred"], BFAC["Alliance"], BZONE["The Exodar"], "44, 26")
	self:addVendorList(191, L["Daniel Bartlett"], BFAC["Horde"], BZONE["Undercity"], "64, 37")
	self:addVendorList(192, L["Gelanthis"], BFAC["Horde"], BZONE["Silvermoon City"], "90, 73")
	self:addVendorList(193, L["Mythrin'dir"], BFAC["Alliance"], BZONE["Darnassus"], "60, 17")
	self:addVendorList(194, L["Neal Allen"], BFAC["Alliance"], BZONE["Wetlands"], "10, 56")
	self:addVendorList(195, L["Dalria"], BFAC["Alliance"], BZONE["Ashenvale"], "35, 51")
	self:addVendorList(196, L["Kulwia"], BFAC["Horde"], BZONE["Stonetalon Mountains"], "45, 59")
	self:addVendorList(197, L["Banalash"], BFAC["Horde"], BZONE["Swamp of Sorrows"], "44.8, 56.6")
	self:addVendorList(198, L["Rungor"], BFAC["Horde"], BZONE["Terokkar Forest"], "48, 46")
	self:addVendorList(199, L["Vodesiin"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "24, 38")
	self:addVendorList(200, L["Innkeeper Biribi"], BFAC["Alliance"], BZONE["Terokkar Forest"], "56, 53")
	self:addVendorList(201, L["Edna Mullby"], BFAC["Alliance"], BZONE["Stormwind City"], "58, 60")
	self:addVendorList(202, L["Felika"], BFAC["Horde"], BZONE["Orgrimmar"], "Patrols")
	self:addVendorList(203, L["Felicia Doan"], BFAC["Horde"], BZONE["Undercity"], "64, 50")
	self:addVendorList(204, L["Aged Dalaran Wizard"], BFAC["Neutral"], BZONE["Old Hillsbrad Foothills"], "Patrols")
	self:addVendorList(205, L["Nerrist"], BFAC["Horde"], BZONE["Stranglethorn Vale"], "32, 29")
	self:addVendorList(206, L["Shadi Mistrunner"], BFAC["Horde"], BZONE["Thunder Bluff"], "40, 63")
	self:addVendorList(207, L["Jase Farlane"], BFAC["Neutral"], BZONE["Eastern Plaguelands"], "80, 57")
	self:addVendorList(208, L["Kalaen"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "56, 37")
	self:addVendorList(209, L["Tatiana"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "54, 63")
	self:addVendorList(210, L["Aldraan"], BFAC["Alliance"], BZONE["Nagrand"], "42, 42")
	self:addVendorList(211, L["Coreiel"], BFAC["Horde"], BZONE["Nagrand"], "42, 42")
	self:addVendorList(212, L["Burbik Gearspanner"], BFAC["Alliance"], BZONE["Ironforge"], "46, 27")
	self:addVendorList(213, L["Jabbey"], BFAC["Neutral"], BZONE["Tanaris"], "66, 22")
	self:addVendorList(214, L["Gretta Ganter"], BFAC["Alliance"], BZONE["Dun Morogh"], "31, 44")
	self:addVendorList(215, L["Harn Longcast"], BFAC["Horde"], BZONE["Mulgore"], "47, 55")
	self:addVendorList(216, L["Khara Deepwater"], BFAC["Alliance"], BZONE["Loch Modan"], "40, 39")
	self:addVendorList(217, L["Lizbeth Cromwell"], BFAC["Horde"], BZONE["Undercity"], "81, 30")
	self:addVendorList(218, L["Martine Tramblay"], BFAC["Horde"], BZONE["Tirisfal Glades"], "65, 59")
	self:addVendorList(219, L["Nyoma"], BFAC["Alliance"], BZONE["Teldrassil"], "57, 61")
	self:addVendorList(220, L["Sewa Mistrunner"], BFAC["Horde"], BZONE["Thunder Bluff"], "55, 47")
	self:addVendorList(221, L["Abigail Shiel"], BFAC["Horde"], BZONE["Tirisfal Glades"], "60, 51")
	self:addVendorList(222, L["Landraelanis"], BFAC["Horde"], BZONE["Eversong Woods"], "48, 47")
	self:addVendorList(223, L["Kriggon Talsone"], BFAC["Alliance"], BZONE["Westfall"], "36, 90")
	self:addVendorList(224, L["Nessa Shadowsong"], BFAC["Alliance"], BZONE["Teldrassil"], "56, 92")
	self:addVendorList(225, L["Tansy Puddlefizz"], BFAC["Alliance"], BZONE["Ironforge"], "48, 6")
	self:addVendorList(226, L["Zansoa"], BFAC["Horde"], BZONE["Durotar"], "56, 73")	
	self:addVendorList(227, L["Grimtak"], BFAC["Horde"], BZONE["Durotar"], "51, 42")
	self:addVendorList(228, L["Wunna Darkmane"], BFAC["Horde"], BZONE["Mulgore"], "46, 58")
	self:addVendorList(229, L["Drac Roughcut"], BFAC["Alliance"], BZONE["Loch Modan"], "35, 49")
	self:addVendorList(230, L["Laird"], BFAC["Alliance"], BZONE["Darkshore"], "36, 44")
	self:addVendorList(231, L["Killian Sanatha"], BFAC["Horde"], BZONE["Silverpine Forest"], "32, 19")
	self:addVendorList(232, L["Naal Mistrunner"], BFAC["Horde"], BZONE["Thunder Bluff"], "51, 52")
	self:addVendorList(233, L["Heldan Galesong"], BFAC["Alliance"], BZONE["Darkshore"], "36, 56")
	self:addVendorList(234, L["Kilxx"], BFAC["Neutral"], BZONE["The Barrens"], "62, 38")
	self:addVendorList(235, L["Ronald Burch"], BFAC["Horde"], BZONE["Undercity"], "62, 43")
	self:addVendorList(236, L["Shankys"], BFAC["Horde"], BZONE["Orgrimmar"], "69, 29")
	self:addVendorList(237, L["Stuart Fleming"], BFAC["Alliance"], BZONE["Wetlands"], "8, 58")
	self:addVendorList(238, L["Master Chef Mouldier"], BFAC["Horde"], BZONE["Ghostlands"], "48, 31")
	self:addVendorList(239, L["Cookie McWeaksauce"], BFAC["Alliance"], BZONE["Azuremyst Isle"], "46, 70")
	self:addVendorList(240, L["Derak Nightfall"], BFAC["Horde"], BZONE["Hillsbrad Foothills"], "62, 20")
	self:addVendorList(241, L["Emrul Riknussun"], BFAC["Alliance"], BZONE["Ironforge"], "60, 37")
	self:addVendorList(242, L["Erika Tate"], BFAC["Alliance"], BZONE["Stormwind City"], "75, 36")
	self:addVendorList(243, L["Fyldan"], BFAC["Alliance"], BZONE["Darnassus"], "48, 21")
	self:addVendorList(244, L["Gloria Femmel"], BFAC["Alliance"], BZONE["Redridge Mountains"], "26, 43")
	self:addVendorList(245, L["Jim Saltit"], BFAC["Neutral"], BZONE["Shattrath City"], "63, 68")
	self:addVendorList(246, L["Kelsey Yance"], BFAC["Neutral"], BZONE["Stranglethorn Vale"], "28, 74")
	self:addVendorList(247, L["Otho Moji'ko"], BFAC["Horde"], BZONE["The Hinterlands"], "79, 79")
	self:addVendorList(248, L["Phea"], BFAC["Alliance"], BZONE["The Exodar"], "54, 26")
	self:addVendorList(249, L["Quelis"], BFAC["Horde"], BZONE["Silvermoon City"], "69, 70")
	self:addVendorList(250, L["Tarban Hearthgrain"], BFAC["Horde"], BZONE["The Barrens"], "55, 32")
	self:addVendorList(251, L["Wulan"], BFAC["Horde"], BZONE["Desolace"], "26, 69")
	self:addVendorList(252, L["Xen'to"], BFAC["Horde"], BZONE["Orgrimmar"], "57, 53")
	self:addVendorList(253, L["Kendor Kabonka"], BFAC["Alliance"], BZONE["Stormwind City"], "74, 37")
	self:addVendorList(254, L["Tari'qa"], BFAC["Horde"], BZONE["The Barrens"], "51, 30")
	self:addVendorList(255, L["Nula the Butcher"], BFAC["Horde"], BZONE["Nagrand"], "58, 35")
	self:addVendorList(256, L["Uriku"], BFAC["Alliance"], BZONE["Nagrand"], "56, 73")
	self:addVendorList(257, L["Lindea Rabonne"], BFAC["Alliance"], BZONE["Hillsbrad Foothills"], "49, 61")
	self:addVendorList(258, L["Ulthaan"], BFAC["Alliance"], BZONE["Ashenvale"], "50, 66")
	self:addVendorList(259, L["Vendor-Tron 1000"], BFAC["Neutral"], BZONE["Desolace"], "60, 38")
	self:addVendorList(260, L["Super-Seller 680"], BFAC["Neutral"], BZONE["Desolace"], "40, 79")
	self:addVendorList(261, L["Ogg'marr"], BFAC["Horde"], BZONE["Dustwallow Marsh"], "36, 30")
	self:addVendorList(262, L["Wik'Tar"], BFAC["Horde"], BZONE["Ashenvale"], "11, 34")
	self:addVendorList(263, L["Corporal Bluth"], BFAC["Alliance"], BZONE["Stranglethorn Vale"], "37, 3")
	self:addVendorList(264, L["Sheendra Tallgrass"], BFAC["Horde"], BZONE["Feralas"], "74, 42")
	self:addVendorList(265, L["Vivianna"], BFAC["Alliance"], BZONE["Feralas"], "31,43")
	self:addVendorList(266, L["Janet Hommers"], BFAC["Alliance"], BZONE["Desolace"], "66, 6")
	self:addVendorList(267, L["Uthok"], BFAC["Horde"], BZONE["Stranglethorn Vale"], "31, 28")
	self:addVendorList(268, L["Himmik"], BFAC["Neutral"], BZONE["Winterspring"], "61, 39")
	self:addVendorList(269, L["Gikkix"], BFAC["Neutral"], BZONE["Tanaris"], "66, 22")
	self:addVendorList(270, L["Dirge Quikcleave"], BFAC["Neutral"], BZONE["Tanaris"], "52, 28")
	self:addVendorList(271, L["Innkeeper Fizzgrimble"], BFAC["Neutral"], BZONE["Tanaris"], "52, 27")
	self:addVendorList(272, L["Truk Wildbeard"], BFAC["Alliance"], BZONE["The Hinterlands"], "14, 42")
	self:addVendorList(273, L["Cookie One-Eye"], BFAC["Horde"], BZONE["Hellfire Peninsula"], "54, 41")
	self:addVendorList(274, L["Sid Limbardi"], BFAC["Alliance"], BZONE["Hellfire Peninsula"], "54, 63")
	self:addVendorList(275, L["Doba"], BFAC["Alliance"], BZONE["Zangarmarsh"], "42, 28")
	self:addVendorList(276, L["Gambarinka"], BFAC["Horde"], BZONE["Zangarmarsh"], "31, 49")
	self:addVendorList(277, L["Juno Dufrain"], BFAC["Neutral"], BZONE["Zangarmarsh"], "78, 66")
	self:addVendorList(278, L["Innkeeper Grilka"], BFAC["Horde"], BZONE["Terokkar Forest"], "48, 45")
	self:addVendorList(279, L["Supply Officer Mills"], BFAC["Alliance"], BZONE["Terokkar Forest"], "55, 53")
	self:addVendorList(280, L["Narj Deepslice"], BFAC["Alliance"], BZONE["Arathi Highlands"], "45, 47")
	self:addVendorList(281, L["Fazu"], BFAC["Alliance"], BZONE["Bloodmyst Isle"], "53, 56")
	self:addVendorList(282, L["Zargh"], BFAC["Horde"], BZONE["The Barrens"], "52, 29")
	self:addVendorList(283, L["Smudge Thunderwood"], BFAC["Neutral"], BZONE["Alterac Mountains"], "86, 79")
	self:addVendorList(284, L["Sassa Weldwell"], BFAC["Alliance"], BZONE["Blade's Edge Mountains"], "61, 68")
	self:addVendorList(285, L["Catherine Leland"], BFAC["Alliance"], BZONE["Stormwind City"], "45, 58")
	self:addVendorList(286, L["Haughty Modiste"], BFAC["Neutral"], BZONE["Tanaris"], "66, 23")

end
