-- (c) 2007 Nymbia.  see LGPLv2.1.txt for full details.
--DO NOT MAKE CHANGES TO THIS FILE BEFORE READING THE WIKI PAGE REGARDING CHANGING THESE FILES
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("InstanceLootHeroic", "$Rev: 77372 $", {
	["InstanceLootHeroic.Auchindoun"]="m,InstanceLootHeroic.Auchenai Crypts,InstanceLootHeroic.Mana-Tombs,InstanceLootHeroic.Shadow Labyrinth,InstanceLootHeroic.Sethekk Halls",
	["InstanceLootHeroic.Auchenai Crypts.Exarch Maladaar"]="29257:196,29244:178,33836:164,27523:129,27871:128,27869:119,27872:104,27867:96,30586:92,30587:89,27870:83,29354:77,30588:77",
	["InstanceLootHeroic.Auchenai Crypts.Shirrak the Dead Watcher"]="27866:142,27845:134,27846:134,27493:124,27865:99,27847:96,30586:37,30587:30,30588:28",

	["InstanceLootHeroic.Magisters' Terrace.Selin Fireheart"]="34601:208,34603:205,34604:199,34602:191,35275:14",
	["InstanceLootHeroic.Magisters' Terrace.Vexallus"]="34607:197,34606:195,34608:179,34605:172,35275:16",
	["InstanceLootHeroic.Magisters' Terrace.Priestess Delrissa"]="35756:207,34471:189,34472:180,34470:179,34473:171,35275:12",
	["InstanceLootHeroic.Magisters' Terrace.Kael'thas Sunstrider"]="34609:208,34614:196,34613:192,34611:191,34612:187,34615:185,34616:184,34610:180,34160:138,35504:60,35275:25,35513:24,35297:9,35298:8,35294:7,35299:7,35308:7,35302:6,35301:6,35309:6,35296:5,35303:4,35295:4,35300:4,35310:4,35306:3,35311:2,35307:2,35304:2,35305:2",

	["InstanceLootHeroic.Mana-Tombs.Nexus-Prince Shaffar"]="29240:184,30535:168,33835:167,29352:146,27831:122,27843:118,27844:117,27828:117,27827:115,27842:110,27840:110,27798:107,27837:105,28400:102,27829:102,27835:101,32082:91,28490:73,30583:71,30585:60,30584:55,22921:24,29252:8",
	["InstanceLootHeroic.Mana-Tombs.Pandemonius"]="27816:163,27818:150,27817:146,27813:119,27814:105,30585:95,27815:85,30584:75,30583:58,28166:3",
	["InstanceLootHeroic.Mana-Tombs.Tavarok"]="27825:145,27824:141,27823:130,27822:130,27821:117,27826:112,30583:69,30585:60,30584:58",

	["InstanceLootHeroic.Shadow Labyrinth.Ambassador Hellmaw"]="27885:163,27887:155,27889:152,27886:143,27884:135,27888:114,30560:63,30559:60,30563:48",
	["InstanceLootHeroic.Shadow Labyrinth.Blackheart the Inciter"]="27468:152,27893:141,27892:139,27890:129,27891:122,28134:118,30808:49,30560:38,30563:37,30559:32,25728:18",
	["InstanceLootHeroic.Shadow Labyrinth.Grandmaster Vorpil"]="27900:184,27775:181,27898:173,27901:149,27897:140,30560:36,30563:35,30559:34,30827:10",
	["InstanceLootHeroic.Shadow Labyrinth.Murmur"]="31722:251,27902:145,28230:142,27909:134,27903:132,27912:128,27910:128,28232:125,27913:119,27778:119,27905:116,29261:115,30532:115,27908:107,29357:102,27803:98,33840:98,30560:62,29353:55,30563:53,30559:47,29241:21,24309:14",
	["InstanceLootHeroic.Sethekk Halls.Darkweaver Syth"]="25461:219,27919:153,27917:152,27918:141,27914:135,27915:134,27916:122,30554:56,30553:52,30552:45,24160:12",
	["InstanceLootHeroic.Sethekk Halls.Talon King Ikiss"]="27991:273,29259:163,29249:159,27925:147,27936:145,27776:131,27838:126,27875:125,27946:122,27981:118,27980:115,32073:108,27948:106,27985:102,33834:101,27986:97,29355:67,30553:65,30554:61,30552:52",
	["InstanceLootHeroic.Sethekk Halls.Anzu"]="32778:205,32781:181,32769:166,32779:157,32780:152,30554:77,30553:77,30552:71,32768:8",

	["InstanceLootHeroic.Caverns of Time"]="m,InstanceLootHeroic.Old Hillsbrad Foothills,InstanceLootHeroic.The Black Morass",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Captain Skarloc"]="28221:104,28217:104,28219:93,28218:91,28220:84,28216:80,27430:63,27424:59,27428:57,22927:34,30590:33,30589:28,30591:23",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Epoch Hunter"]="33847:169,27904:121,28224:106,29246:99,29250:93,28191:89,28223:88,28222:84,30536:83,28344:81,28225:79,27911:78,28227:76,30589:75,28401:75,30534:74,30591:70,28233:69,28226:68,27433:60,27434:55,27440:50,30590:41,24173:11,29357:8",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Lieutenant Drake"]="28214:112,28213:110,28215:106,28211:105,28212:104,28210:98,27423:57,27417:54,30590:35,30591:32,30589:30",
	["InstanceLootHeroic.The Black Morass.Aeonus"]="33858:166,28206:161,28192:158,27977:153,28193:144,27509:143,28190:143,28194:136,27839:135,28188:130,28207:127,28189:126,27873:120,29247:115,29253:114,30531:106,29356:67,30558:40,30555:35,30556:32",
	["InstanceLootHeroic.The Black Morass.Chrono Lord Deja"]="27996:149,27995:147,27993:139,27988:134,27987:124,27994:123,30556:43,30555:39,30558:35,29675:15",
	["InstanceLootHeroic.The Black Morass.Temporus"]="28034:152,28185:145,28184:130,28033:120,28187:119,28186:117,30555:39,30556:37,30558:33",

	["InstanceLootHeroic.Coilfang Reservoir"]="m,InstanceLootHeroic.The Slave Pens,InstanceLootHeroic.The Steamvault,InstanceLootHeroic.The Underbog",
	["InstanceLootHeroic.The Slave Pens.Mennu the Betrayer"]="27545:150,27543:148,27542:136,27544:136,27546:134,27541:126,30605:50,30604:47,30603:40,29674:13",
	["InstanceLootHeroic.The Slave Pens.Quagmirran"]="29242:164,30538:159,27673:133,27800:128,27742:127,32078:123,27713:121,27712:116,27740:115,27796:114,27741:111,27714:109,28337:108,27672:108,27683:98,30604:95,29349:84,30605:82,30603:69,33821:66",
	["InstanceLootHeroic.The Slave Pens.Rokmar the Crackler"]="27550:142,27547:141,28124:130,27551:129,27549:129,27548:126,30605:51,30604:51,30603:45",
	["InstanceLootHeroic.The Slave Pens.Ahune"]="35494:140,35495:60,35496:120,35497:100,35514:40,35498:150,34955:19,35507:80,35508:80,35509:80,35510:80,35511:80,",
	["InstanceLootHeroic.The Steamvault.Hydromancer Thespia"]="27508:178,27783:172,27787:169,27784:158,27789:153,30550:47,30551:45,30549:40,29673:13,30828:7",
	["InstanceLootHeroic.The Steamvault.Mekgineer Steamrigger"]="27791:174,27790:166,27794:164,27792:151,27793:150,30550:53,30549:47,30551:41,23887:17",
	["InstanceLootHeroic.The Steamvault.Warlord Kalithresh"]="31721:188,29243:154,27805:140,27806:138,29463:134,30543:132,27799:132,27737:132,27475:131,27738:131,27795:125,28203:117,27804:113,33827:112,27510:111,27874:110,27801:109,29351:84,30551:74,30550:73,30549:69,24313:14",
	["InstanceLootHeroic.The Underbog.Ghaz'an"]="24246:240,27758:152,27761:141,27759:136,27757:130,27755:127,27760:125,30607:57,30606:55,30608:52",
	["InstanceLootHeroic.The Underbog.Hungarfen"]="27745:150,27743:147,27747:142,27746:128,27744:126,27748:125,24246:66,30608:60,30607:58,30606:53",
	["InstanceLootHeroic.The Underbog.Swamplord Musel'ek"]="27765:147,27763:139,27766:134,27764:128,27767:124,27762:121,30607:58,30608:57,30606:55",
	["InstanceLootHeroic.The Underbog.The Black Stalker"]="24246:219,29265:171,30541:164,27781:123,27896:123,27773:117,29350:114,27780:112,27779:112,27772:112,27769:108,27771:104,27768:104,27938:103,27770:102,33826:101,27907:100,30607:94,30606:91,30608:78,32081:63",

	["InstanceLootHeroic.Hellfire Citadel"]="m,InstanceLootHeroic.Hellfire Ramparts,InstanceLootHeroic.Magtheridon's Lair,InstanceLootHeroic.The Blood Furnace,InstanceLootHeroic.The Shattered Halls",
	["InstanceLootHeroic.Hellfire Ramparts.Nazan"]="33833:625",
	["InstanceLootHeroic.Hellfire Ramparts.Omor the Unscarred"]="27464:153,27477:139,27465:139,27906:132,27466:125,27895:123,27463:117,27478:115,27467:115,27539:109,27462:98,27476:98,30594:83,30593:56",
	["InstanceLootHeroic.Hellfire Ramparts.Vazruden"]="27453:7,27454:7,29238:4,30592:4,27457:4",
	["InstanceLootHeroic.Hellfire Ramparts.Watchkeeper Gargolmar"]="27447:173,27451:169,27448:162,27449:149,27450:146,30594:52,30593:42",
	["InstanceLootHeroic.The Blood Furnace.Broggok"]="27492:161,27491:158,27490:145,27848:141,27489:132,30602:49,30600:45,30601:41",
	["InstanceLootHeroic.The Blood Furnace.Keli'dan the Breaker"]="29239:152,29245:148,33814:145,27495:140,28121:125,27506:121,27514:121,27788:120,27507:116,27512:110,27494:108,30601:105,27522:105,27505:104,30600:93,28264:90,32080:88,27497:88,30602:75,29347:69",
	["InstanceLootHeroic.The Blood Furnace.The Maker"]="27488:191,27485:169,27487:156,27483:150,27484:145,30600:56,30602:51,30601:45",
	["InstanceLootHeroic.The Shattered Halls.Grand Warlock Nethekurse"]="25462:236,27518:174,27520:172,27519:169,27517:163,27521:160,30548:46,30546:46,30547:40,24312:16",
	["InstanceLootHeroic.The Shattered Halls.Warbringer O'mrogg"]="27525:178,27526:166,27868:157,27524:153,27802:152,30546:50,30548:48,30547:41,30829:12",
	["InstanceLootHeroic.The Shattered Halls.Warchief Kargath Bladefist"]="29255:162,27528:138,27536:137,29263:137,33815:131,27534:130,27537:129,27527:129,27540:129,27529:115,27533:114,27538:109,27535:108,29254:108,27531:103,27474:103,30548:68,29348:67,30547:59,30546:57,23723:51",
	["InstanceLootHeroic.The Shattered Halls.Blood Guard Porung"]="30709:195,30707:184,30705:166,30708:159,30710:84,30546:64,30548:60,30547:45",

	["InstanceLootHeroic.Tempest Keep"]="m,InstanceLootHeroic.The Arcatraz,InstanceLootHeroic.The Mechanar,InstanceLootHeroic.The Botanica",
	["InstanceLootHeroic.The Arcatraz.Dalliah the Doomsayer"]="28392:209,28386:160,28391:150,28387:140,28390:137,30575:81,30581:75,30582:68,24308:42",
	["InstanceLootHeroic.The Arcatraz.Harbinger Skyriss"]="33861:187,29248:158,28414:146,29252:138,28416:135,28413:131,28406:129,28231:127,28205:127,28412:125,29241:125,28407:124,28415:122,28419:122,28403:120,28418:104,29360:96,30581:59,30575:59,30582:57,29254:12",
	["InstanceLootHeroic.The Arcatraz.Wrath-Scryer Soccothrates"]="28398:191,28396:184,28394:171,28397:145,28393:132,30575:82,30582:72,30581:46",
	["InstanceLootHeroic.The Arcatraz.Zereketh the Unbound"]="28374:176,28373:172,28384:172,28372:151,28375:129,30581:64,30575:61,30582:57",
	["InstanceLootHeroic.The Botanica.Commander Sarannis"]="28296:186,28306:176,28304:174,28301:162,28311:152,30573:55,30574:53,30572:48",
	["InstanceLootHeroic.The Botanica.High Botanist Freywinn"]="28317:185,28315:177,28318:174,28321:158,28316:152,30573:60,30572:56,30574:54,23617:33,31744:6",
	["InstanceLootHeroic.The Botanica.Laj"]="28328:174,27739:162,28339:160,28340:157,28338:152,30574:66,30573:64,30572:59",
	["InstanceLootHeroic.The Botanica.Thorngrin the Tender"]="28324:190,28322:175,28327:147,28325:146,28323:134,30574:76,30573:75,30572:70,24310:39",
	["InstanceLootHeroic.The Botanica.Warp Splinter"]="33859:227,29258:197,29262:176,28370:142,28371:140,32072:137,28349:130,28343:124,28347:118,28367:117,28342:116,28350:114,28228:113,28348:113,28341:102,28345:102,28229:99,29359:72,31085:71,30572:64,30573:63,30574:57,24311:28",
	["InstanceLootHeroic.The Mechanar.Mechano-Lord Capacitus"]="28253:162,28254:143,28255:132,28257:122,28256:120,35582:85,30564:57,30566:55,30565:54",
	["InstanceLootHeroic.The Mechanar.Nethermancer Sepethrea"]="28259:165,28263:155,28260:152,28258:150,28262:148,30565:79,22920:79,30566:64,30564:57",
	["InstanceLootHeroic.The Mechanar.Pathaleon the Calculator"]="33860:316,29251:224,30533:224,32076:181,28202:162,28285:141,28278:136,28266:131,28267:130,28269:129,27899:129,28286:129,28204:127,28288:111,28275:109,29362:95,28265:87,30566:73,21907:73,30565:70,31086:56,30564:55",
})
