-- (c) 2007 Nymbia.  see LGPLv2.1.txt for full details.
--DO NOT MAKE CHANGES TO THIS FILE BEFORE READING THE WIKI PAGE REGARDING CHANGING THESE FILES
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("ClassSpell", "$Rev: 75432 $", {
	["ClassSpell.Druid.Balance"]="-5176:1,-8921:4,-467:6,-5177:6,-339:8,-8924:10,-16689:10,-18960:10,-782:14,-5178:14,-8925:16,-1062:18,-770:18,-2637:18,-16810:18,-5570:20,-2912:20,-8926:22,-2908:22,-5179:22,-1075:24,-8949:26,-5195:28,-8927:28,-16811:28,-778:30,-24974:30,-5180:30,-8928:34,-8950:34,-8914:34,-5196:38,-18657:38,-16812:38,-8955:38,-6780:38,-16914:40,-29166:40,-24975:40,-8929:40,-24858:40,-9749:42,-8951:42,-22812:44,-9756:44,-9833:46,-8905:46,-9852:48,-16813:48,-33831:50,-17401:50,-24976:50,-9875:50,-9834:52,-9907:54,-9901:54,-9910:54,-9912:54,-9853:58,-18658:58,-9835:58,-17329:58,-9876:58,-17402:60,-24977:60,-25298:60,-26984:61,-26987:63,-26992:64,-26993:66,-26986:67,-26989:68,-27009:68,-26985:69,-33786:70,-27012:70,-27013:70,-26988:70,-26995:70",
	["ClassSpell.Druid.Feral Combat"]="-5487:10,-99:10,-6795:10,-6807:10,-5229:12,-5211:14,-1066:16,-779:16,-6808:18,-768:20,-1082:20,-1735:20,-16979:20,-5215:20,-1079:20,-5221:22,-1822:24,-780:24,-5217:24,-1850:26,-6809:26,-5209:28,-3029:28,-8998:28,-9492:28,-6798:30,-16857:30,-17390:30,-6800:30,-783:30,-9490:32,-22568:32,-6785:32,-5225:32,-8972:34,-1823:34,-769:34,-22842:36,-9005:36,-9493:36,-6793:36,-5201:38,-8992:38,-9000:40,-9634:40,-20719:40,-22827:40,-6783:40,-9747:42,-17391:42,-9745:42,-6787:42,-1824:44,-9752:44,-9754:44,-8983:46,-9821:46,-22895:46,-9823:46,-9829:46,-9849:48,-22828:48,-9845:48,-33878:50,-33876:50,-9880:50,-9866:50,-9892:52,-9898:52,-9894:52,-17392:54,-9904:54,-9830:54,-9908:54,-22829:56,-22896:56,-9827:56,-9850:58,-33986:58,-33982:58,-9881:58,-9867:58,-31709:60,-31018:60,-9913:60,-9896:60,-9846:60,-27001:61,-26998:62,-22570:62,-24248:63,-27003:64,-26997:64,-33357:65,-26999:65,-27011:66,-33745:66,-27006:66,-27005:66,-27000:67,-26996:67,-27008:67,-33943:68,-33987:68,-33983:68,-27004:69,-27002:70,-40120:70",
	["ClassSpell.Druid.Restoration"]="-5185:1,-1126:1,-774:4,-5186:8,-5232:10,-1058:10,-8936:12,-5187:14,-8946:16,-1430:16,-8938:18,-5188:20,-6756:20,-16864:20,-20484:20,-2090:22,-8939:24,-2782:24,-2893:26,-5189:26,-2091:28,-5234:30,-17116:30,-20739:30,-8940:30,-740:30,-6778:32,-3627:34,-8941:36,-8903:38,-8907:40,-20742:40,-8910:40,-18562:40,-8918:40,-9750:42,-9758:44,-9839:46,-9856:48,-21849:50,-9888:50,-9884:50,-20747:50,-9862:50,-33891:50,-9840:52,-9857:54,-9889:56,-9841:58,-21850:60,-25297:60,-9885:60,-20748:60,-9858:60,-25299:60,-9863:60,-26978:62,-26981:63,-33763:64,-26980:65,-26979:69,-26994:69,-26982:69,-26991:70,-26990:70,-26983:70",
	["ClassSpell.Hunter.Beast Mastery"]="-13163:4,-13165:10,-883:10,-2641:10,-6991:10,-982:10,-1515:10,-136:12,-6197:14,-1002:14,-1513:14,-14318:18,-5118:20,-3111:20,-1462:24,-14319:28,-3661:28,-13161:30,-19577:30,-14326:30,-3662:36,-14320:38,-13159:40,-19574:40,-13542:44,-20043:46,-14327:46,-14321:48,-13543:52,-20190:56,-14322:58,-25296:60,-13544:60,-34074:64,-34026:66,-27044:68,-27045:68,-27046:68",
	["ClassSpell.Hunter.Marksmanship"]="-75:1,-1978:4,-3044:6,-1130:6,-5116:8,-13549:10,-14281:12,-20736:12,-2643:18,-13550:18,-19434:20,-14282:20,-14274:20,-14323:22,-3043:22,-3045:26,-13551:26,-20900:28,-14283:28,-15629:30,-14288:30,-19503:30,-1543:32,-13552:34,-20901:36,-14284:36,-3034:36,-15630:40,-14324:40,-19506:40,-1510:40,-14289:42,-13553:42,-20902:44,-14285:44,-14279:46,-15631:50,-13554:50,-34490:50,-20905:50,-14294:50,-20903:52,-14286:52,-14290:54,-14280:56,-14325:58,-13555:58,-14295:58,-20904:60,-14287:60,-15632:60,-25294:60,-25295:60,-19801:60,-20906:60,-34120:62,-27018:66,-27021:67,-27016:67,-27022:67,-27019:69,-27020:69,-27065:70,-27066:70",
	["ClassSpell.Hunter.Survival"]="-2973:1,-1494:1,-14260:8,-19883:10,-2974:12,-13795:16,-1495:16,-14261:16,-19884:18,-19263:20,-781:20,-1499:20,-14262:24,-19885:24,-14302:26,-19880:26,-13809:28,-19306:30,-5384:30,-14269:30,-14263:32,-19878:32,-14272:34,-13813:34,-14303:36,-14267:38,-14310:40,-14264:40,-19882:40,-19386:40,-20909:42,-14316:44,-14270:44,-14304:46,-14273:48,-14265:48,-23989:50,-19879:50,-24132:50,-20910:54,-14317:54,-14305:56,-14266:56,-14271:58,-14311:60,-14268:60,-24133:60,-27025:61,-27015:62,-27014:63,-27023:65,-27067:66,-34600:68,-34477:70,-36916:70,-27068:70",
	["ClassSpell.Mage.Arcane"]="-1459:1,-5504:4,-587:6,-5143:8,-118:8,-5505:10,-597:12,-604:12,-130:12,-1449:14,-1460:14,-5144:16,-1008:18,-475:18,-1953:20,-5506:20,-12051:20,-1463:20,-12824:20,-32271:20,-3562:20,-3567:20,-32272:20,-3561:20,-3563:20,-8437:22,-990:22,-5145:24,-2139:24,-8450:24,-1461:28,-759:28,-8494:28,-8455:30,-8438:30,-6127:30,-12043:30,-3565:30,-3566:30,-8416:32,-6129:32,-6117:34,-49361:35,-49360:35,-49358:35,-49359:35,-8451:36,-8495:36,-8439:38,-3552:38,-8417:40,-12042:40,-10138:40,-12825:40,-32266:40,-11416:40,-11417:40,-32267:40,-10059:40,-11418:40,-10169:42,-10156:42,-10144:42,-10191:44,-10201:46,-22782:46,-10211:48,-10053:48,-10173:48,-10139:50,-11419:50,-11420:50,-31589:50,-10145:52,-10192:52,-10170:54,-10202:54,-23028:56,-10157:56,-10212:56,-10054:58,-22783:58,-25345:60,-28612:60,-10140:60,-10174:60,-10193:60,-28272:60,-28271:60,-12826:60,-33690:60,-35715:60,-27080:62,-27130:63,-27075:63,-30451:64,-37420:65,-33691:65,-35717:65,-33944:67,-27101:68,-66:68,-27131:68,-33946:69,-38699:69,-27125:69,-27127:70,-27082:70,-27126:70,-38704:70,-33717:70,-27090:70,-43987:70,-30449:70",
	["ClassSpell.Mage.Fire"]="-133:1,-2136:6,-143:6,-145:12,-2137:14,-2120:16,-3140:18,-543:20,-11366:20,-2138:22,-2948:22,-8400:24,-2121:24,-12505:24,-8444:28,-11113:30,-8412:30,-8457:30,-8401:30,-12522:30,-8422:32,-8445:34,-13018:36,-8402:36,-12523:36,-8413:38,-11129:40,-8458:40,-8423:40,-8446:40,-10148:42,-12524:42,-13019:44,-10197:46,-10205:46,-10149:48,-10215:48,-12525:48,-31661:50,-10223:50,-13020:52,-10206:52,-10199:54,-10150:54,-12526:54,-33041:56,-10216:56,-10207:58,-13021:60,-10225:60,-10151:60,-18809:60,-27078:61,-25306:62,-30482:62,-33042:64,-27086:64,-27133:65,-27073:65,-27070:66,-27132:66,-27128:69,-33933:70,-33043:70,-27079:70,-38692:70,-33938:70,-27074:70",
	["ClassSpell.Mage.Frost"]="-168:1,-116:4,-205:8,-7300:10,-122:10,-837:14,-10:20,-7301:20,-7322:20,-12472:20,-6143:22,-120:26,-865:26,-8406:26,-6141:28,-11958:30,-7302:30,-45438:30,-8461:32,-8407:32,-8492:34,-8427:36,-8408:38,-6131:40,-7320:40,-11426:40,-10159:42,-8462:42,-10185:44,-10179:44,-13031:46,-10160:50,-10180:50,-10219:50,-31687:50,-10186:52,-10177:52,-13032:52,-10230:54,-10181:56,-10161:58,-13033:58,-10187:60,-28609:60,-25304:60,-10220:60,-27071:63,-27134:64,-27087:65,-30455:66,-27088:67,-27085:68,-27072:69,-27124:69,-32796:70,-38697:70,-33405:70",
	["ClassSpell.Paladin.Holy"]="-635:1,-21084:1,-639:6,-1152:8,-633:10,-20287:10,-7328:12,-19742:14,-647:14,-20288:18,-26573:20,-879:20,-19750:20,-5502:20,-1026:22,-19850:24,-10322:24,-2878:24,-19939:26,-20289:26,-5614:28,-20116:30,-20216:30,-1042:30,-2800:30,-20165:30,-19852:34,-19940:34,-20290:34,-5615:36,-10324:36,-3472:38,-20166:38,-5627:38,-19977:40,-20922:40,-20473:40,-20347:40,-13819:40,-34769:40,-4987:42,-19941:42,-20291:42,-19853:44,-10312:44,-24275:44,-10328:46,-20929:48,-20772:48,-20356:48,-19978:50,-20923:50,-31842:50,-19942:50,-2812:50,-10310:50,-20348:50,-20292:50,-10313:52,-24274:52,-10326:52,-19854:54,-25894:54,-10329:54,-20930:56,-19943:58,-20293:58,-20357:58,-19979:60,-25290:60,-20924:60,-10314:60,-25890:60,-25918:60,-24239:60,-25292:60,-10318:60,-20773:60,-20349:60,-23214:60,-34767:60,-27135:62,-27174:64,-27142:65,-27143:65,-27137:66,-27155:66,-27166:67,-27138:68,-27180:68,-27144:69,-27145:69,-27139:69,-27154:69,-27160:69,-27173:70,-27136:70,-33072:70",
	["ClassSpell.Paladin.Protection"]="-465:1,-498:6,-853:8,-1022:10,-10290:10,-31789:14,-25780:16,-1044:18,-5573:18,-31785:18,-20217:20,-643:20,-19746:22,-20164:22,-5599:24,-5588:24,-1038:26,-19876:28,-20911:30,-10291:30,-19752:30,-19888:32,-642:34,-19891:36,-10278:38,-20912:40,-1032:40,-5589:40,-20925:40,-19895:40,-19897:44,-6940:46,-19899:48,-31895:48,-31935:50,-20913:50,-10292:50,-1020:50,-20927:50,-19896:52,-20729:54,-10308:54,-19898:56,-32699:60,-20914:60,-10293:60,-19900:60,-25898:60,-25895:60,-25899:60,-20928:60,-27147:62,-27151:63,-33776:66,-27152:68,-32700:70,-27148:70,-27168:70,-27149:70,-27153:70,-27169:70,-27179:70",
	["ClassSpell.Paladin.Retribution"]="-19740:4,-20271:4,-21183:6,-21082:6,-19834:12,-20162:12,-7294:16,-20375:20,-19835:22,-20305:22,-10298:26,-20218:30,-20915:30,-19836:32,-20306:32,-10299:36,-20066:40,-20918:40,-19837:42,-20307:42,-10300:46,-35395:50,-20919:50,-19838:52,-25782:52,-20308:52,-10301:56,-25291:60,-25916:60,-20920:60,-27158:61,-32223:62,-31892:64,-31801:64,-27150:66,-31884:70,-27140:70,-27141:70,-27170:70",
	["ClassSpell.Priest.Discipline"]="-1243:1,-17:6,-10797:10,-32548:10,-588:12,-1244:12,-592:12,-527:18,-600:18,-19296:18,-32676:20,-2651:20,-6346:20,-13896:20,-7128:20,-14751:20,-9484:20,-8129:24,-1245:24,-3747:24,-19299:26,-14752:30,-19271:30,-602:30,-6065:30,-8131:32,-1706:34,-19302:34,-988:36,-2791:36,-6066:36,-14818:40,-19273:40,-1006:40,-10874:40,-10060:40,-9485:40,-10898:42,-19303:42,-10875:48,-10937:48,-10899:48,-21562:48,-14819:50,-19274:50,-10951:50,-33206:50,-19304:50,-10900:54,-10876:56,-19305:58,-27841:60,-19275:60,-10952:60,-10938:60,-10901:60,-21564:60,-27681:60,-10955:60,-25379:63,-25217:65,-25446:66,-25431:69,-25312:70,-25441:70,-25380:70,-32375:70,-25389:70,-25218:70,-25392:70,-32999:70",
	["ClassSpell.Priest.Holy"]="-2050:1,-585:1,-2052:4,-591:6,-139:8,-13908:10,-2053:10,-2006:10,-528:14,-6074:14,-598:14,-2054:16,-19236:18,-44041:20,-2061:20,-14914:20,-15237:20,-6075:20,-2055:22,-2010:22,-984:22,-15262:24,-19238:26,-9472:26,-6076:26,-6063:28,-15430:28,-44043:30,-15263:30,-596:30,-1004:30,-552:32,-9473:32,-6077:32,-19240:34,-6064:34,-10880:34,-15264:36,-15431:36,-9474:38,-6078:38,-6060:38,-44044:40,-2060:40,-724:40,-996:40,-19241:42,-15265:42,-10915:44,-27799:44,-10927:44,-10963:46,-10881:46,-10933:46,-15266:48,-44045:50,-34861:50,-19242:50,-10916:50,-27870:50,-10960:50,-10928:50,-10964:52,-27800:52,-15267:54,-10934:54,-34863:56,-10917:56,-10929:56,-19243:58,-10965:58,-20770:58,-44046:60,-34864:60,-25314:60,-15261:60,-27801:60,-27871:60,-10961:60,-25316:60,-25315:60,-25233:61,-25363:61,-25210:63,-32546:64,-34865:65,-25221:65,-25437:66,-25384:66,-25235:67,-25213:68,-25331:68,-25308:68,-33076:68,-25435:68,-25364:69,-44047:70,-34866:70,-28275:70,-25222:70",
	["ClassSpell.Priest.Shadow Magic"]="-589:4,-586:8,-9035:10,-8092:10,-594:10,-2652:10,-8122:14,-8102:16,-970:18,-2944:20,-9578:20,-19281:20,-15407:20,-453:20,-18137:20,-19261:20,-8103:22,-2096:22,-992:26,-19276:28,-8104:28,-17311:28,-8124:28,-19308:28,-9579:30,-19282:30,-605:30,-976:30,-15487:30,-19262:30,-15286:30,-8105:34,-2767:34,-19277:36,-17312:36,-8192:36,-19309:36,-9592:40,-19283:40,-8106:40,-15473:40,-19264:40,-10888:42,-10957:42,-10892:42,-19278:44,-10911:44,-17313:44,-10909:44,-19310:44,-10945:46,-10941:50,-19284:50,-10893:50,-19265:50,-34914:50,-19279:52,-10946:52,-17314:52,-10953:52,-19311:52,-27683:56,-10890:56,-10958:56,-10947:58,-10912:58,-10894:58,-19280:60,-10942:60,-19285:60,-18807:60,-19312:60,-19266:60,-34916:60,-32379:62,-25372:63,-25367:65,-25429:66,-34433:66,-25596:67,-25467:68,-25387:68,-25433:68,-25477:68,-25375:69,-25470:70,-39374:70,-32996:70,-25368:70,-25461:70,-34917:70",
	["ClassSpell.Rogue.Assassination"]="-2098:1,-6760:8,-5171:10,-8647:14,-703:14,-6761:16,-8676:18,-1943:20,-8631:22,-6762:24,-8724:26,-1833:26,-8649:26,-8639:28,-14177:30,-8632:30,-408:30,-8623:32,-8725:34,-8650:36,-8640:36,-8633:38,-8624:40,-11267:42,-6774:42,-11273:44,-11197:46,-11289:46,-11299:48,-11268:50,-8643:50,-1329:50,-34411:50,-11274:52,-11290:54,-11300:56,-11198:56,-11269:58,-31016:60,-34412:60,-11275:60,-26839:61,-32645:62,-26679:64,-26865:64,-27441:66,-26866:66,-26867:68,-32684:69,-26884:70,-34413:70",
	["ClassSpell.Rogue.Combat"]="-1752:1,-53:4,-1776:6,-1757:6,-5277:8,-2983:10,-2589:12,-1766:12,-1758:14,-1966:16,-1777:18,-2590:20,-14251:20,-1759:22,-1767:26,-2591:28,-6768:28,-13877:30,-1760:30,-8629:32,-8696:34,-8721:36,-8621:38,-13750:40,-8637:40,-1768:42,-11279:44,-11285:46,-11293:46,-26669:50,-11280:52,-11303:52,-11294:54,-1769:58,-11305:58,-11281:60,-25300:60,-25302:60,-11286:60,-26861:62,-27448:64,-38764:67,-26863:68,-38768:69,-5938:70,-26862:70",
	["ClassSpell.Rogue.Subtlety"]="-1784:1,-921:4,-6770:10,-14278:20,-1785:20,-1725:22,-1856:22,-2836:24,-2070:28,-1842:30,-16511:30,-14185:30,-2094:34,-14183:40,-1860:40,-1786:40,-1857:42,-17347:46,-11297:48,-36554:50,-17348:58,-1787:60,-26889:62,-31224:66,-26864:70",
	["ClassSpell.Shaman.Elemental Combat"]="-403:1,-8042:4,-2484:6,-8044:8,-529:8,-5730:8,-8050:10,-3599:10,-1535:12,-370:12,-8045:14,-548:14,-8052:18,-6390:18,-8056:20,-915:20,-6363:20,-8498:22,-8046:24,-943:26,-8190:26,-8053:28,-6391:28,-6364:30,-421:32,-45297:32,-8499:32,-6041:32,-8012:32,-8058:34,-10412:36,-10585:36,-10391:38,-6392:38,-930:40,-16166:40,-10447:40,-6365:40,-11314:42,-10392:44,-10472:46,-10586:46,-2860:48,-10413:48,-10427:48,-15207:50,-10437:50,-30706:50,-11315:52,-10448:52,-10605:56,-15208:56,-10587:56,-10473:58,-10428:58,-10414:60,-29228:60,-10438:60,-25546:61,-25448:62,-25439:63,-25552:65,-25449:67,-25525:67,-2894:68,-25464:68,-25454:69,-25533:69,-25442:70,-25547:70,-25457:70",
	["ClassSpell.Shaman.Enhancement"]="-8017:1,-36591:1,-8071:4,-324:8,-8018:8,-8024:10,-43339:10,-8075:10,-8154:14,-325:16,-8019:16,-8027:18,-8033:20,-2645:20,-131:22,-8181:24,-905:24,-10399:24,-8155:24,-8160:24,-6196:26,-8030:26,-8184:28,-8227:28,-8038:28,-546:28,-556:30,-8177:30,-10595:30,-8232:30,-945:32,-8512:32,-16314:34,-6495:34,-10406:34,-16339:36,-15107:36,-8249:38,-10478:38,-10456:38,-8161:38,-8134:40,-17364:40,-8235:40,-10537:42,-8835:42,-10613:42,-10600:44,-16315:44,-10407:44,-16341:46,-15111:46,-10526:48,-16355:48,-10431:48,-30823:50,-10486:50,-10442:52,-10614:52,-10479:54,-16316:54,-10408:54,-16342:56,-10627:56,-10432:56,-15112:56,-10538:58,-16387:58,-16356:58,-25359:60,-10601:60,-25361:60,-16362:60,-25585:61,-25479:62,-25469:63,-25508:63,-25489:64,-3738:64,-25528:65,-25577:65,-2062:66,-25500:66,-25557:67,-25560:67,-25563:68,-25505:68,-25574:69,-2825:70,-32182:70,-25472:70,-25485:70,-25509:70,-25587:70",
	["ClassSpell.Shaman.Restoration"]="-331:1,-332:6,-2008:12,-547:12,-526:16,-913:18,-8143:18,-5394:20,-8004:20,-2870:22,-8166:22,-20609:24,-939:24,-5675:26,-8008:28,-6375:30,-16188:30,-20608:30,-36936:30,-959:32,-20610:36,-8010:36,-10495:36,-8170:38,-1064:40,-6377:40,-8005:40,-16190:40,-10466:44,-10622:46,-10496:46,-20776:48,-10395:48,-974:50,-10462:50,-25908:50,-10467:52,-10623:54,-10396:56,-10497:56,-20777:60,-32593:60,-10463:60,-25357:60,-10468:60,-25422:61,-24398:62,-25391:63,-25570:65,-25420:66,-25423:68,-25567:69,-33736:69,-32594:70,-25396:70",
	["ClassSpell.Warlock.Affliction"]="-172:4,-702:4,-1454:6,-980:8,-5782:8,-1120:10,-1108:12,-6222:14,-704:14,-689:14,-1455:16,-1014:18,-18288:20,-6205:22,-699:22,-6223:24,-5138:24,-8288:24,-1714:26,-1456:26,-6217:28,-7658:28,-18223:30,-709:30,-18265:30,-1490:32,-7646:32,-6213:32,-7648:34,-6226:34,-11687:36,-11711:38,-7651:38,-8289:38,-18879:38,-18220:40,-5484:40,-7659:42,-11707:42,-6789:42,-11671:44,-17862:44,-11703:44,-11721:46,-11699:46,-11688:46,-11712:48,-18880:48,-11719:50,-18937:50,-17925:50,-30108:50,-11708:52,-11675:52,-11672:54,-11700:54,-11704:54,-17928:54,-11717:56,-17937:56,-6215:56,-11689:56,-11713:58,-17926:58,-18881:58,-25311:60,-603:60,-11722:60,-18938:60,-30404:60,-27224:61,-27219:62,-27221:63,-27264:63,-27216:65,-27218:67,-27229:67,-27217:67,-27223:68,-27222:68,-27226:69,-27228:69,-30909:69,-27220:69,-30910:70,-27265:70,-30908:70,-27243:70,-30911:70,-30405:70",
	["ClassSpell.Warlock.Demonology"]="-687:1,-688:1,-6201:10,-696:10,-697:10,-755:12,-5697:16,-693:18,-706:20,-18708:20,-3698:20,-698:20,-712:20,-6202:22,-126:22,-5500:24,-132:26,-710:28,-6366:28,-3699:28,-20752:30,-1086:30,-18788:30,-1098:30,-691:30,-6229:32,-5699:34,-17951:36,-2362:36,-3700:36,-20755:40,-11733:40,-19028:40,-5784:40,-11739:42,-11725:44,-11693:44,-17952:46,-11729:46,-18647:48,-17727:48,-20756:50,-11734:50,-1122:50,-30146:50,-11694:52,-11740:52,-17953:56,-11730:58,-11726:58,-20757:60,-17728:60,-11735:60,-11695:60,-18540:60,-28610:60,-23161:60,-28176:62,-27250:66,-28172:66,-29858:66,-27259:67,-27230:68,-29893:68,-28189:69,-27238:70,-27260:70",
	["ClassSpell.Warlock.Destruction"]="-348:1,-686:1,-695:6,-707:10,-705:12,-5676:18,-1094:20,-5740:20,-1088:20,-17877:20,-18867:24,-17919:26,-1106:28,-1949:30,-2941:30,-18868:32,-6219:34,-17920:34,-7641:36,-17962:40,-11665:40,-18869:40,-11683:42,-17921:42,-11659:44,-11677:46,-18930:48,-18870:48,-6353:48,-11667:50,-17922:50,-30283:50,-11660:52,-18931:54,-11684:54,-18871:56,-17924:56,-11678:58,-17923:58,-18932:60,-11668:60,-25309:60,-11661:60,-30413:60,-25307:62,-27263:63,-29722:64,-27211:64,-27266:65,-27210:65,-27213:68,-27215:69,-27212:69,-27209:69,-30912:70,-32231:70,-30459:70,-30546:70,-30414:70,-30545:70",
	["ClassSpell.Warrior.Arms"]="-2457:1,-78:1,-100:4,-772:4,-6343:6,-1715:8,-284:8,-6546:10,-7384:12,-285:16,-694:16,-8198:18,-6547:20,-20230:20,-1608:24,-6178:26,-7400:26,-7887:28,-8204:28,-12292:30,-6548:30,-7372:32,-11564:32,-7402:36,-8205:38,-11565:40,-12294:40,-11572:40,-11584:44,-11578:46,-20559:46,-11566:48,-21551:48,-11580:48,-11573:50,-7373:54,-21552:54,-11567:56,-20560:56,-11581:58,-25286:60,-21553:60,-11585:60,-11574:60,-25266:65,-29707:66,-25248:66,-25212:67,-25264:67,-25208:68,-30324:70,-30330:70",
	["ClassSpell.Warrior.Fury"]="-6673:1,-5242:12,-1160:14,-845:20,-12323:20,-6192:22,-5246:22,-6190:24,-5308:24,-1161:26,-2458:30,-7369:30,-20252:30,-1464:30,-12328:30,-11549:32,-18499:32,-20658:32,-11554:34,-1680:36,-6552:38,-8820:38,-23881:40,-11608:40,-20660:40,-11550:42,-20616:42,-11555:44,-11604:46,-23892:48,-20661:48,-11609:50,-29801:50,-1719:50,-11551:52,-20617:52,-23893:54,-11556:54,-11605:54,-20662:56,-6554:58,-25289:60,-23894:60,-20569:60,-30030:60,-25272:61,-25241:61,-25202:62,-34428:62,-25234:65,-25251:66,-25231:68,-469:68,-2048:69,-25275:69,-25242:69,-30335:70,-25203:70,-25236:70,-30033:70",
	["ClassSpell.Warrior.Protection"]="-2687:10,-71:10,-7386:10,-355:10,-72:12,-6572:14,-2565:16,-676:18,-12975:20,-7405:22,-6574:24,-871:28,-12809:30,-1671:32,-7379:34,-8380:34,-23922:40,-11600:44,-11596:46,-23923:48,-20243:50,-1672:52,-11601:54,-23924:54,-11597:58,-30016:60,-25288:60,-23925:60,-25269:63,-29704:64,-23920:64,-25258:66,-25225:67,-30022:70,-3411:70,-30357:70,-30356:70",
})
