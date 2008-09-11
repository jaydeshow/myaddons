-- (c) 2007 Nymbia.  see LGPLv2.1.txt for full details.
--DO NOT MAKE CHANGES TO THIS FILE BEFORE READING THE WIKI PAGE REGARDING CHANGING THESE FILES
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Gear", "$Rev: 29953 $", {
	["Gear.Socketed.Back"]="33122,34241,34242,24259,34792",
	["Gear.Socketed.Chest"]="30101,34605,33216,33473,34232,34229,34211,34799,34216,30905,32252,34615,28597,30054,30056,34233,33203,34610,34212,30730,30107,34228,34215,28228,28337,28205,28203,28403,27427,28230,28401,28229,28186,24021,28191,28202,24397,28232,34796,24481,24465,28231,28204,24455,24363,24357,24396,28342,28264,34990,35002,35007,35012,35026,35027,35036,35042,35048,35057,35059,35066,35077,35087,35088,35099,35115,31960,31972,31977,31982,31991,31992,32002,32004,32009,32019,32020,30486,32029,32038,32039,32050,32060,33664,33675,33680,33685,33694,33695,33704,33706,33711,33721,33722,33728,33738,33748,33749,33760,33771,28613,28623,28628,31593,28679,28688,28689,28694,31625,31630,28699,31640,28708,28709,28717,28723,28805,28815,28821,31588,28831,28840,28841,28846,31629,31635,28851,31646,28860,28861,28869,28875,34397,33566,34394,34942,28483,29096,28484,28485,34369,30164,30169,30185,29087,33522,29091,34939,30129,30123,30134,29038,29033,29029,30144,29082,30118,30113,29515,34921,34906,34903,34373,23565,21871,34396,28334,28130,24552,30200,31379,27702,25831,25997,27469,31413,31613,24544,31396,27711,27879,25856,28140,34924,31004,34377,34933,29071,29066,29062,34371,30990,30991,30992,23563,29045,29519,34395,30216,30231,30222,30975,30976,21875,30139,34365,30214,31052,34399,29050,31057,30196,34912,33204,34945,31065,34900,30159,29056,34917,31017,31016,31018,31028,21865,21848,34375,34379,34364,31042,31041,31043,34936,34927,23564,34398,31066,29077,30150,28964,29019,29012,34930,29522,23507,29129,29341,29340,29339,35402,35412,35360,35469,35332,35464,23509,35346,25696,23513,25689,30074,35365,35337,35467,35370,35342,35407,35381,35386,35472,35391,35376,30076,29337,25838,35375,25932,31657,32869,27720",
	["Gear.Socketed.Feet"]="28747,34947,34562,28517,34919,32609,34564,32267,34574,30104,32345,28545,28610,28746,33582,28752,21870,30737,34612,34570,33207,28608,33191,34561,34560,34559,33577,32268,32352,33222,34568,34569,30092,30880,33523,32366,33303,34565,34567,34566,34575,34926,32239,30100,29951,34809,34807,34571,34572,34573,32245,34563,33537,33324,33471,32648,28177,29499,34707,27813,28339,23511,29497,29491,25686,29493,25691,24064,25693,28318,28176,28179,28406,27411,29318,28178,32866,25924",
	["Gear.Socketed.Finger"]="34625,33293,27832,27833,27830,27834",
	["Gear.Socketed.Hands"]="30725,34904,33517,34352,34341,32328,32656,34938,23531,34374,33512,28824,34916,28505,33528,34409,34350,28827,23532,34240,30112,31060,34808,28520,28506,34370,28519,28508,34408,31050,31055,34406,32353,33534,32278,31001,31061,34344,34342,34367,28507,34911,34378,28518,34372,28776,33587,30982,30983,30985,28521,34902,30969,30970,29998,34234,31008,31007,31011,31026,28780,21863,21847,23533,33586,34376,34380,34366,34343,31034,31032,31035,30741,34351,34407,29976,23508,27474,24090,24393,24365,27497,27793,29496,29490,25942,25685,23517,23514,27528,34700,27475,34791,27798,28396,24387,27465,24450,24452,27428,23526,29317,27531,32865",
	["Gear.Socketed.Head"]="33421,34333,33432,32329,34332,34339,29986,32525,34345,32354,32235,34340,34244,28593,30731,32521,30728,32376,33479,32240,34243,33356,32241,32373,33453,33463,33327,33286,33808,28275,28225,28413,28414,28192,34795,28285,28415,27408,28278,28193,25955,27414,28348,27409,28349,28350,28224,34992,34999,35004,35010,35023,35029,35033,35044,35050,35054,35061,35068,35079,35084,35090,35097,35112,31962,31968,31974,31980,31988,31997,31999,32006,32011,32016,32022,30488,32031,32035,32041,32048,32057,33666,33672,33677,33683,33691,33697,33701,33708,33713,33718,33724,33730,33740,33745,33751,33758,33768,28615,28619,28625,31590,28681,28685,28691,28696,31622,31632,28701,31642,28705,28711,28715,28720,28807,28812,28818,31585,28833,28837,28843,28848,31626,31637,28853,31648,28857,28863,28867,28872,33810,34847,29093,24267,30166,30171,30190,29076,34403,34245,31063,32088,32090,30152,31056,30206,34400,29086,30125,30136,30131,29035,29028,29040,32478,30146,29081,30120,30115,32494,32083,32461,32476,28331,28127,24553,30187,31376,27704,25830,25998,27471,31410,31616,24545,31400,27708,27881,25855,28137,31003,34357,34405,23535,34401,32084,31064,30161,30212,31051,35182,29073,29061,29068,32472,35185,29049,30987,30988,30989,34355,32475,32480,32089,33972,32087,34404,34354,29122,29044,30228,30219,30233,23536,30972,30974,32495,35181,35184,34353,30141,34402,31015,31014,31012,31027,29058,24266,29098,23534,32086,32474,34356,32473,31039,31040,31037,28963,29021,29011,32085,24264,32479,35183,32776,35404,35414,35357,35329,31110,29135,28181,31104,35344,28576,28574,28759,28560,28561,28577,28758,28559,28761,28760,28575,29136,23519,23516,28182,28183,35362,35333,28180,35367,31105,35339,35466,35409,35478,35383,35474,35388,35393,31107,35378,31106,31109,35372,25931,25930,27715,32871,31658",
	["Gear.Socketed.Legs"]="34925,33533,24263,33501,30900,31068,34169,34384,30153,30531,30172,30167,30192,34186,34937,30132,30137,30126,34905,30148,30121,30116,28591,33971,34180,34381,30535,30727,34922,29950,30536,31005,34901,28751,33518,34946,34382,32271,34383,30532,31067,34181,30916,32367,30912,30162,30213,34385,34188,31053,34914,30734,31058,30207,34167,28748,34943,34918,30993,30994,30995,30538,33530,30229,30220,30234,30977,30978,34170,34386,28742,33552,30543,32263,30142,28740,34931,34934,30739,28741,31019,31020,31021,31029,24262,34168,30541,30893,34940,29991,34910,31044,31045,31046,28594,29972,34928,33515,30533,29985,24261,28621,30534,28212,27654,27773,29498,27487,29342,28338,27648,28219,23512,29495,29489,25687,23518,29492,24456,27527,29345,29343,29344,25690,27649,28185,24046,24391,29142,34701,27514,24083,27647,27545,27492,25692,27893,28218,24022,27430,27650,24466,27653,27652,29141,29184,27837,27718,27719,25929,27717,32870",
	["Gear.Socketed.Main Hand"]="34199,34611,34335,34331,33495,30723,34790,27846",
	["Gear.Socketed.Neck"]="34360,35132,35133,37929,35134,37928,35135,34358,28245,34359,28244,35290,35291,35292,33067,33065,33068,33066,33920,33921,35317,33922,35319,33923,32508",
	["Gear.Socketed.One Hand"]="28572,34616,33476,34329,23542,28657,33493,27901,32781",
	["Gear.Socketed.Ranged"]="30724,33192,32756,34348,34347,32872",
	["Gear.Socketed.Shield"]="28825,30882,33326,29176,33332,30889,34185,32652",
	["Gear.Socketed.Shoulder"]="34210,30097,34208,34607,30878,30884,30079,28743,34194,34192,33206,30053,30740,34202,30055,34601,34209,34193,27801,27771,34788,27847,27775,27738,27796,27434,27737,24463,27713,27433,27417,24366,27803,27776,27778,27739,27802,24457,27797,34994,35001,35006,35009,35025,35031,35035,35046,35052,35056,35063,35070,35081,35086,35092,35096,35114,31964,31971,31976,31979,31990,31996,32001,32008,32013,32018,32024,30490,32033,32037,32043,32047,32059,33668,33674,33679,33682,33693,33699,33703,33710,33715,33720,33726,33732,33742,33747,33753,33757,33770,28617,28622,28627,31592,28683,28687,28693,28698,31624,31634,28703,31644,28707,28713,28714,28722,28809,28814,28820,31587,28835,28839,28845,28850,31628,31639,28855,31650,28859,28865,28866,28874,28755,30168,30173,30194,30138,30133,30127,29037,29031,29043,30149,29084,34392,30122,30117,34390,21869,28333,28129,24554,30186,31378,27706,25832,25999,27473,31412,31619,24546,31407,27710,27883,25854,28139,33287,31006,29064,29070,29075,29054,30996,30997,30998,31069,29100,30154,30215,31054,31059,30210,29047,30230,30221,30235,30979,30980,34388,29095,33481,29079,33973,30143,29089,31070,34393,31023,31024,31022,31030,29060,21864,34391,34389,31048,31049,31047,28967,29016,29023,30163,35406,35476,35416,35359,35331,35343,35465,35364,35470,35336,35369,33173,35341,35411,35385,35390,35395,35380,29316,35374,25923,32868,25925",
	["Gear.Socketed.Two Hand"]="33494,34247,30722,30732,28774,34337,34182,28800,34608,34183,33490,33492,29993,27986,24461,28222,34797,28393",
	["Gear.Socketed.Waist"]="34935,30888,34527,30038,30040,32519,28799,30042,30106,30046,30034,30036,34541,34929,34557,24257,33211,33331,34932,34528,33480,30064,28566,30879,29516,30030,30897,32342,24256,34944,32333,33446,28779,34941,30096,33524,28750,29984,28828,34549,33279,33483,34487,34485,34488,30044,29520,34546,34547,21873,30032,34543,34542,34545,34558,21846,33559,33536,28778,34554,34555,34556,24255,34923,33583,29524,32769,29500,34793,27985,27760,23510,25695,29494,27755,27743,27478,24388,27672,27843,28124,24395,25694,24063,24458,29319,24091,32867,25922",
	["Gear.Socketed.Wrist"]="33578,33580,30047,28795,30862,34434,30057,30871,34436,30864,34447,32655,34435,30870,30863,33535,29517,34602,30861,33285,33557,28451,28445,28405,31598,28643,28424,28605,28638,28381,28646,28411,28448,34443,35166,35167,35168,35169,35170,35171,35172,35173,35174,35175,35176,35177,35178,35179,35180,30869,32324,34431,34432,34433,28973,28978,28981,31599,28984,28988,28989,28992,28996,28999,29002,29006,33540,29521,34441,34442,30868,32647,34437,34438,34439,34448,34446,34445,34444,30091,28502,29966,33520,32809,32810,32811,32812,32813,32814,32816,32817,32980,32989,32818,32997,32819,32820,32821,33876,33881,33883,33887,33889,33893,33894,33897,33901,33904,33813,33906,33910,33913,33917,29523,33589,23506,28170,34697,24251,34705,24250,34789,34698,25697,23515,28167,28174,28171,24249",
	["Gear.Trinket"]="12846,13347,10725,4397,10645,10723,10720,10716,10587,10727,10577,10585,4396,31360,25620,31615,31617,18706,11122,10455,25787,5079,29776,10779,30542,18984,25996,21758,21777,21756,21748,21769,21763,21760,17690,17905,17906,10418,25619,7506,1490,30293,25786,11905,19141,18637,17759,17774,4381,8663,10576,2820,25628,25634,32694,9149,15867,25994,19120,10659,8703,13171,4130,13544,25995,30340,17691,17900,17901,25937,25936,744,1404,18986,30544,25633,12065,28288,20534,27891,27896,1713,28223,16022,19024,27770,24390,32658,28370,14022,14023,13965,28041,2802,19990,12930,32534,11832,13382,32695,32481,32864,18537,32654,30300,21120,21116,21115,20072,19991,19992,20130,22268,20503,28109,21473,13968,21488,27416,21784,21789,24125,24124,24126,24128,24127,27529,20036,11810,17907,17908,23835,23836,21181,18634,11815,17744,13164,22321,19979,28034,18638,28121,18854,18856,18857,18858,18859,18862,18863,18864,29593,18834,18845,18846,18849,18850,18851,18852,18853,29592,27900,30841,19930,27920,27921,27922,27924,13966,27926,27927,28234,28235,28236,28237,28238,30348,30349,30350,30351,28239,28240,28241,28242,28243,30343,30344,30345,30346,18371,19947,26055,1973,13379,18354,28108,34424,27683,15873,13515,28042,25653,18465,18466,18467,18468,18469,18470,18471,18472,18473,21568,21567,21566,21565,19812,24376,20512,28190,30696,29132,13209,11819,28418,7734,32863,11811,13213,17902,17903,34423,21119,21118,21117,20071,32782,18639,11302,28040,18370,27828,29179,19345,32771,13503,33830,19336,32490,32486,32488,32492,32493,32487,32485,32491,32489,35751,21670,37128,35326,35327,34049,34579,34163,34576,34162,34577,33832,34578,34050,34580,33831,34427,29383,37127,23716,34473,38289,38290,19288,31856,19287,31859,19289,19290,31858,31857,21326,38288,28830,19406,30665,21180,38287,29376,18815,23001,28823,28789,23047,30663,30619,21647,35700,35693,35694,35703,35702,17909,34430,23040,29387,19951,19952,35748,19957,19958,19959,33829,20636,29370,23570,22954,19341,833,30664,23042,32505,23206,23207,37864,37865,32496,19339,28528,19344,19379,18406,28727,23714,21685,30621,35750,19395,19953,19954,28590,28579,19340,21625,30629,19343,30720,30626,32501,34472,21891,17082,17064,34429,32770,23041,30446,35749,30620,34428,17904,19431,22678,18820,25829,24551,30448,19337,23558,18646,18665,28785,14557,23046,32483,34470,29181,34029,33828,30447,30627,21579,19342,34471,31113,30449,23027,30450,19955,19956,19948,19950,19949",
	["Gear.Vendor.Badge of Justice.G'eras"]="33585:75,33810:75,33578:35,29266:33,29373:25,33580:35,35326:75,34049:75,34163:75,34162:75,33832:75,34050:75,29375:25,33566:75,29382:25,29383:41,33501:75,33517:60,33516:35,33296:35,33192:25,33331:60,33522:75,29381:25,35321:60,33304:60,35324:60,32088:50,32090:50,33484:60,33535:35,29376:41,33513:35,29390:15,32083:50,29385:25,33334:35,29270:25,33582:60,33512:60,33557:35,33528:60,33524:60,33532:35,33287:60,29387:41,33974:60,33534:60,33519:60,33965:75,32084:50,33518:75,29370:41,33508:20,33509:20,33510:20,33207:60,30770:20,30774:20,30773:30,30772:30,30779:20,30776:30,30780:20,30778:30,30768:20,30769:30,30767:20,30766:30,30763:20,30764:20,30761:30,30762:30,33279:60,29273:25,33333:60,33503:20,33504:20,33502:20,29388:15,29267:33,33587:60,33386:60,32089:50,29368:25,33972:75,32087:50,33540:35,29268:33,33577:60,33530:75,29374:25,29386:25,33222:60,29272:25,33584:75,33552:75,33514:60,33970:60,33973:60,33531:60,29379:25,29367:25,29384:25,33588:35,33523:60,29269:25,29275:50,33538:75,29369:25,33527:75,33506:20,33593:35,33559:60,33529:35,33507:20,32086:50,33536:60,33586:60,29271:25,29274:25,33505:20,29389:15,33537:60,33324:60,33539:60,33515:75,33520:35,33579:75,33325:35,33291:60,33583:60,33280:60,32085:50,33589:35",
	["Gear.Vendor.Badge of Justice.Smith Hauthaa"]="34925:100,34935:75,34887:60,34890:60,34904:75,34929:75,34894:105,34947:75,34919:75,34942:100,34939:100,34932:75,34937:100,34892:150,34905:100,34921:100,34906:100,34903:100,34938:75,34889:60,34916:75,34896:150,34944:75,34941:75,34924:100,34922:100,34901:100,34911:75,34933:100,34946:100,34914:100,34943:100,34918:100,34902:75,34888:60,34931:100,34934:100,34912:100,34895:150,34945:100,34900:100,34917:100,34926:75,34898:150,34940:100,34949:45,34910:100,34891:150,34952:45,34936:100,34928:100,34927:100,34951:45,34950:45,34893:105,34923:75,34930:100",
})
