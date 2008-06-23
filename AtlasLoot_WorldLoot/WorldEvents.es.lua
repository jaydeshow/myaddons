﻿--[[
--AtlasLoot loot tables esES localization
--Maintained by Kurax Kuang (gmmgmm at gmail.com)
--NOTE: This file is auto-generated by a tool, any manually change might be overwritten.
--$Date: 2008-06-23 10:36:22 -0400 (Mon, 23 Jun 2008) $
--]]
if (GetLocale() == "esES") then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootWorldEvents"][category] or #AtlasLoot_Data["AtlasLootWorldEvents"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootWorldEvents"][category][i][3] = data[i] end end data = nil end
Process("ArmbreakerHuffaz",22,{"=q3=Sortija de los Etereum","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("BashirLanding",27,{"","=q1=Frasco inestable del anciano","=q1=Frasco inestable del médico","=q1=Frasco inestable del bandido","=q1=Frasco inestable del soldado","","","=q3=Amatista inestable","=q3=Citrino inestable","=q3=Peridoto inestable","=q3=Zafiro inestable","=q3=Talasita inestable","=q3=Topacio inestable","","","","=q3=Diamante imbuido inestable","=q3=Diamante potente inestable","=q1=Módulo acelerador","=q1=Geoda de metamorfosis de oro pequeña","=q1=Geoda de metamorfosis de plata pequeña","=q1=Geoda de metamorfosis de cobre pequeña","=q1=Geoda de metamorfosis de hierro pequeña","=q1=Geoda de metamorfosis de oro grande","=q1=Geoda de metamorfosis de plata grande","=q1=Geoda de metamorfosis de cobre grande","=q1=Geoda de metamorfosis de hierro grande"})
Process("BashirStasisChambers",22,{"","=q3=Baluarte demoníaco","=q2=Marca del rey-nexo","","","=q3=Sobrehombros de aceropizarra","=q2=Marca del rey-nexo","","","=q3=Sobrehombros sayobruma","=q2=Marca del rey-nexo","","","","","","=q3=Manto del Canalizador de viento","=q2=Marca del rey-nexo","","","=q3=Sobrehombros de acechador celeste","=q2=Marca del rey-nexo"})
Process("Brewfest1",30,{"=q3=Cuñete de la Fiesta de la cerveza","","=q1=Gafas romance de mejora de aspecto de Belbi","=q1=Sombrero de la Fiesta de la cerveza azul","=q1=Sombrero de la Fiesta de la cerveza marrón","=q1=Sombrero de la Fiesta de la cerveza verde","=q1=Sombrero de la Fiesta de la cerveza morado","=q1=Atavío de la Fiesta de la cerveza","=q1=Traje de la Fiesta de la cerveza","=q1=Botas de la Fiesta de la cerveza","=q1=Zapatillas de la Fiesta de la cerveza","","=q1=Sello de \"Cervecero Honorario\"","=q4=Carnero de la Fiesta de la cerveza presto","=q3=Carnero de la Fiesta de la cerveza","=q3=Jarra de la Fiesta de cerveza amarilla","=q3=Jarra Hierro Negro","=q3=Pichel de wolpertinger","","=q2=Vale para la Fiesta de la cerveza","","=q1=Salchichón","=q1=Salchica suculenta","=q1=Salchica sabrosa","=q1=Salchicha en conserva","=q1=Salchica ahumada picante","=q1=El Vínculo Dorado","","=q1=El pretzel, esencial en la Fiesta de la cerveza","=q1=Cerveza de la Fiesta de la cerveza"})
Process("Brewfest2",24,{"","=q1=Cebadiz clara","=q1=Cebadiz ligera","=q1=Cebadiz oscura","","","=q1=Trueno 45","=q1=Cebatruenos rubia","=q1=Cebratruenos negra","","","=q1=Grog de Gordok","=q1=Batido proteico","=q1=Hidromiel ogro","","","=q1=Cerveza del Pasito","=q1=Cerveza del Largo Paseo","=q1=Senda de la Cerveza","","","=q1=Agua de río de la selva","=q1=Magia cervecera","=q1=Cabeza reducida fuerte"})
Process("ChildrensWeek",19,{"","=q1=Collera de cochinillo","=q1=Jaula de ratas","=q1=Carcasa de tortuga","=q1=Pago de Curmudgeon","","","","","","","","","","","","=q3=Huevo de Egbert","=q3=Collera de entrenamiento de elekk","=q3=Willy el Dormilón"})
Process("DarkscreecherAkkarai",12,{"=q3=Guanteletes de hereje","=q2=Garfas de Akkarai","","=q3=Ataduras del Canalizador de viento","=q3=Ceñidor del Canalizador de viento","=q3=Brazales de acechador celeste","=q3=Cordón de acechador celeste","=q3=Brazales sayobruma","=q3=Cinturón sayobruma","=q3=Brazales de aceropizarra","=q3=Faja de aceropizarra","=q3=Sortija de Skettis"})
Process("Dukes",27,{"","=q3=Leotardos de cuero Abisal","=q3=Martillo de guerra de acero endurecido","=q3=Sello Abisal","=q2=Fajín de paño Abisal","=q1=Rescoldo de las brasas","","","=q3=Musleras de malla Abisal","=q3=Espada claymore Rocanegra","=q3=Sello Abisal","=q2=Cinturón de cuero Abisal","","","","","=q3=Pantalones de paño Abisal","=q3=Creador de almas","=q3=Sello Abisal","=q2=Faja de placas Abisales","","","","=q3=Quijotes de placas Abisales","=q3=Varita de cristal chispeante","=q3=Sello Abisal","=q2=Garra de malla Abisal"})
Process("ElementalInvasion",25,{"","=q3=Cetro del barón Charr","=q3=As de Elementales","=q2=Elemental de ascuas","","","=q3=Collar helado de Tempestria","=q3=As de Elementales","=q3=Patrón: guantes de sudario de tormenta","=q2=Anillo gélido","","","","","","","=q3=Pellejo pedregoso de Avalanchion","=q3=As de Elementales","=q2=Sortija de piedra endurecida","","","=q3=Fajín del Atracavientos","=q3=As de Elementales","=q3=Patrón: guantes de sudario de tormenta","=q2=Capa Céfiro"})
Process("FelTinkererZortan",22,{"=q3=Botas sayobruma","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("FishingExtravaganza",23,{"","=q3=Caña de pescar de arcanita","=q3=Anzuelo de Maestro pescador","","","=q2=Pez ángel de Keefer","=q2=Corredor a rayas azules de Brownell","=q2=Pez reina de Dezian","=q2=Potenpez Pielroca","","","","","","","","","","","","=q2=Sombrero de pesca de la suerte","=q2=Botas de pescador extremo de Nat Pagle","=q2=Gran línea de pesca de prueba de eternio"})
Process("Forgosh",22,{"=q3=Torques Etereum","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("GezzaraktheHuntress",12,{"=q3=Colmillo de Gezzarak","=q2=Garras de Gezzarak","","=q3=Ataduras del Canalizador de viento","=q3=Ceñidor del Canalizador de viento","=q3=Brazales de acechador celeste","=q3=Cordón de acechador celeste","=q3=Brazales sayobruma","=q3=Cinturón sayobruma","=q3=Brazales de aceropizarra","=q3=Faja de aceropizarra","=q3=Sortija de Skettis"})
Process("Gulbor",22,{"=q3=Torques Etereum","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("GurubashiArena",17,{"=q3=Guardamuñecas de arena","=q3=Brazales de arena","=q3=Sortijas de arena","=q3=Protegebrazos de arena","","","","","","","","","","","","=q2=Maestro de arena","=q3=Gran maestro de arena"})
Process("Halloween1",28,{"=q3=Calabaza iluminada","=q2=Bolsa de calabazas","","=q1=Piruleta de Styleen","=q1=Caramelo de los disturbios de Arroyo de la Luna","=q1=Barrita de nueces de Bellara","=q1=Golosinas de calabaza de Halloween","","","","","","","","","","=q1=Varita sacralizada: Murciélago","=q1=Varita sacralizada: Fantasma","=q1=Varita sacralizada: Gnomo paria","=q1=Varita sacralizada: Ninja","=q1=Varita sacralizada: Pirata","=q1=Varita sacralizada: Aleatorio","=q1=Varita sacralizada: Esqueleto","=q1=Varita sacralizada: Fuego fatuo","","=q1=Trigo de caramelo","=q1=Caramelo","=q1=Chocolatina"})
Process("Halloween2",24,{"","=q1=Máscara de enano endeble","=q1=Máscara de gnomo endeble","=q1=Máscara de hombre endeble","=q1=Máscara de elfo de la noche endeble","=q1=Máscara de orco endeble","=q1=Máscara de tauren endeble","=q1=Máscara de trol endeble","=q1=Máscara de no-muerto endeble","","","","","","","","=q1=Máscara de enana endeble","=q1=Máscara de gnoma endeble","=q1=Máscara de mujer endeble","=q1=Máscara de elfa de la noche endeble","=q1=Máscara de orco hembra endeble","=q1=Máscara de tauren hembra endeble","=q1=Máscara de trol hembra endeble","=q1=Máscara de no-muerta endeble"})
Process("HarvestFestival",8,{"=q1=Recompensa de la cosecha","=q1=¡Por la Luz!","=q1=El grito del infierno de la Horda","","=q1=Jabalí de la cosecha","=q1=Pez de la cosecha","=q1=Fruta de la cosecha","=q1=Néctar de la cosecha"})
Process("HeadlessHorseman",20,{"=q4=Yelmo de El Jinete","=q4=Anillo de deleite macabro","=q4=Sello de El Jinete","=q4=Sortija de brujas","","=q3=Yelmo sacralizado","=q3=Calabacino siniestro","","=q1=Calabaza iluminada pesada","=q1=Dulce de Halloween","","","","","","=q4=Escoba voladora presta","=q4=Escoba mágica presta","=q3=Escoba voladora","=q3=Vieja escoba mágica","=q2=Escoba mágica destartalada"})
Process("HighCouncil",26,{"","=q4=Sortija de enfoque elemental","=q4=Cetro Abisal","=q3=Brazales de cuero Abisal","=q3=Espaldares de malla Abisal","","","=q4=Collar rompeolas","=q4=Cetro Abisal","=q3=Guardabrazos de cuero Abisal","=q3=Cubrehombros de placas Abisales","","","","","","=q4=Manteo Cortaviento","=q4=Cetro Abisal","=q3=Braciles de paño Abisal","=q3=Sobrehombros de cuero Abisal","","","=q4=Integumento terráneo","=q4=Cetro Abisal","=q3=Amito de paño Abisal","=q3=Protegebrazos de placas Abisales"})
Process("Karrog",12,{"=q3=Fragmento de Karrog","=q2=Espina de Karrog","","=q3=Ataduras del Canalizador de viento","=q3=Ceñidor del Canalizador de viento","=q3=Brazales de acechador celeste","=q3=Cordón de acechador celeste","=q3=Brazales sayobruma","=q3=Cinturón sayobruma","=q3=Brazales de aceropizarra","=q3=Faja de aceropizarra","=q3=Sortija de Skettis"})
Process("LunarFestival1",30,{"=q2=Farol de Elune","","=q1=Vestido de fiesta verde","=q1=Vestido de fiesta rosa","=q1=Vestido de fiesta morado","","=q1=Traje de pantalón de fiesta negro","=q1=Traje de pantalón de fiesta azul","=q1=Traje de pantalón de fiesta con cerceta","","=q1=Albóndigas festivas","","=q1=Vela de Elune","","=q1=Moneda de linaje","","=q1=Cohete azul pequeño","=q1=Cohete verde pequeño","=q1=Cohete rojo pequeño","=q1=Cohete blanco pequeño","=q1=Cohete amarillo pequeño","=q1=Cohete azul grande","=q1=Cohete verde grande","=q1=Cohete rojo grande","=q1=Cohete blanco grande","=q1=Cohete amarillo grande","","","=q1=Traca de cohetes de la suerte","=q1=Piedra lunar de anciano"})
Process("LunarFestival2",28,{"=q2=Esquema: lanzafuegos de artificio","","","=q2=Esquema: cohete azul pequeño","=q2=Esquema: cohete verde pequeño","=q2=Esquema: cohete rojo pequeño","","","=q2=Esquema: cohete azul grande","=q2=Esquema: cohete verde grande","=q2=Esquema: cohete rojo grande","","=q2=Patrón: vestido de fiesta","","","=q2=Esquema: lanzatracas","","","=q2=Esquema: traca de cohetes azules","=q2=Esquema: traca de cohetes verdes","=q2=Esquema: traca de cohetes rojos","","","=q2=Esquema: traca de cohetes azules grandes","=q2=Esquema: traca de cohetes verdes grandes","=q2=Esquema: traca de cohetes rojos grandes","","=q2=Patrón: traje de fiesta"})
Process("MalevustheMad",22,{"=q3=Botas de aceropizarra","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("MidsummerFestival",19,{"","=q3=Llama presa","","=q2=Brazales de ceniza","","=q1=Flores ardientes","=q1=Brebaje festivo ígneo","=q1=Tarta de bayas de saúco","=q1=Pan tostado","=q1=Salchicha de solsticio de verano","=q1=Esmorc tostado","","","","","=q1=Corona del Festival del Fuego","=q1=Manto del Festival del Fuego"}) --Missing: 34683, 34684, 34685, 34686
Process("Noblegarden",7,{"","=q1=Vestido elegante","=q1=Camisa de esmoquin blanca","=q1=Pantalones de esmoquin negro","=q1=Chocolatina","=q1=Onza de chocolate","=q1=Caramelo"})
Process("PorfustheGemGorger",22,{"=q3=Botas del Canalizador de viento","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
Process("ScourgeInvasionEvent1",30,{"=q2=Aceite de zahorí bendito","=q2=Piedra de afilar consagrada","=q1=Tabardo de El Alba Argenta","","=q2=Runa necrótica","","","=q3=Toga de limpieza de no-muertos","=q3=Brazales de limpieza de no-muertos","=q3=Guantes de limpieza de no-muertos","","","=q3=Túnica de Asesino de no-muertos","=q3=Cubremuñecas de Asesino de no-muertos","=q3=Manijas de Asesino de no-muertos","=q1=Marca del Alba inferior","=q1=Marca del Alba","=q1=Marca del Alba superior","","","","","=q3=Coselete de Asesino de no-muertos","=q3=Guardamuñecas de Asesino de no-muertos","=q3=Manoplas de Asesino de no-muerto","","","=q3=Coraza de Asesino de no-muertos","=q3=Brazales de Asesino de no-muertos","=q3=Guanteletes de Asesino de no-muertos"})
Process("ScourgeInvasionEvent2",28,{"","=q3=Pretina de Balzaphon","=q3=Cadenas del Exánime","=q3=Bastón de Balzaphon","","","=q3=Muslo de Bosque Negro","=q3=Hoja de Lord Bosque Negro","=q3=Rodela de Lord Bosque Negro","","","=q3=Capa de Revanchion","=q3=Brazales de alivio","=q3=La garra de las Sombras","","","=q3=La garra helada","=q3=Gargantilla helada de Desdén","=q3=Daga focal de Desdén","","","=q3=Leotardos de piel de abominación","=q3=El hacha de extirpación","","","","=q3=Manto de Lady Falther'ess","=q3=Dedo de Lady Falther'ess"})
Process("Shartuul",27,{"=q4=Sello de corruptor","","=q4=Brazales de paño mermados","=q4=Guanteletes de malla mermados","=q3=Capa mermada","=q3=Anillo mermado","=q3=Insignia mermada","=q3=Daga mermada","=q3=Espada mermada","=q3=Hacha de dos manos mermada","=q3=Maza mermada","=q3=Bastón mermado","","","","=q4=Anillo del sobrestante","","=q4=Brazales de tejido de cristal","=q4=Manoplas de pellejo de cristal","=q3=Manteo de tejido de cristal","=q3=Sortija de onirocristal","=q3=Insignia de Tenacidad","=q3=Chafarote imbuido de cristal","=q3=Espada de cristal forjado","=q3=Cuchilla de ápices","=q3=Maza de cristal de ápices","=q3=Bastón de cuarzo llameante"})
Process("SkettisHazziksPackage",1,{"=q1=Paquete de Hazzik"})
Process("SkettisTalonpriestIshaal",1,{"=q1=Anuario de Ishaal"})
Process("Templars",26,{"","=q3=Estilete con punta de cristal","=q2=Manijas de paño Abisal","=q2=Escarpes de malla Abisal","=q2=Blasón Abisal","","","=q3=Bastón de guerra amatista","=q2=Zapatillas de paño Abisal","=q2=Guanteletes de placas Abisales","=q2=Blasón Abisal","","","","","","=q3=Guja Cortapiedras","=q2=Botas de cuero Abisal","=q2=Manoplas de malla Abisal","=q2=Blasón Abisal","","","=q3=Arco tiro profundo","=q2=Guantes de cuero Abisal","=q2=Grebas de placas Abisales","=q2=Blasón Abisal"})
Process("Terokk",11,{"=q4=Poderío de Terokk","=q4=Sabiduría de Terokk","=q3=Leotardos del Canalizador de viento","=q3=Leotardos de acechador celeste","=q3=Pantalones sayobruma","=q3=Leotardos de aceropizarra","=q3=Don de los sacerdotes de la garra","=q3=Broche del Rey inmortal","=q3=Figurilla tiempo perdido","=q3=Mazo de Terokk","=q3=Mazo de Terokk"})
Process("VakkiztheWindrager",12,{"=q3=Espirales del Furibundo del Viento","","","=q3=Ataduras del Canalizador de viento","=q3=Ceñidor del Canalizador de viento","=q3=Brazales de acechador celeste","=q3=Cordón de acechador celeste","=q3=Brazales sayobruma","=q3=Cinturón sayobruma","=q3=Brazales de aceropizarra","=q3=Faja de aceropizarra","=q3=Sortija de Skettis"}) --Missing: 32718
Process("Valentineday",27,{"=q2=Ramo de rosas rojas","","","=q3=Cesta de picnic romántica","=q1=Vestido negro precioso","=q1=Flecha con astil de veraplata","=q1=Flecha con astil de plata","=q1=Loco de amor","=q1=Puñado de pétalos de rosa","=q1=Bolsa de caramelos","=q1=Cohete del amor","","","","","","=q1=Deseo oscuro","=q1=Crema de frutos cremosa","=q1=Delicia de leche","=q1=Dulce sorpresa","","=q1=Vestido rojo precioso","=q1=Vestido azul precioso","=q1=Vestido morado precioso","=q1=Traje de cena rojo","=q1=Traje de cena azul","=q1=Traje de cena morado"})
Process("Winterviel1",30,{"=q2=Sombrero de invierno verde","=q2=Sombrero de invierno rojo","=q1=Disfraz completo del Festival de Invierno","=q1=Bola de nieve","=q1=Puñado de copos de nieve","=q1=Acebo fresco","=q1=Muérdago","","","=q2=Patrón: botas de invierno","=q2=Patrón: ropa de invierno roja","=q2=Patrón: ropa de invierno verde","=q1=Receta: sidra de manzana caliente","=q1=Receta: ponche de huevo","=q1=Receta: galleta de jengibre","=q1=Caña de caramelo","=q1=Rueda de queso de vacaciones","=q1=Pastel de carne casero de Graccu","=q1=Ternera picante","=q1=Jamón festivo cubierto de miel","=q1=Brebaje de judías mezcladas","=q1=Té de jardín verde","=q1=Sidra de manzana con gas","=q1=Licor de fiestas","=q1=Espíritus burbujeantes de Bonvapor","=q1=Aliento invernal del Padre Invierno","=q1=Especias de vacaciones","=q1=Papel para envolver con lazo azul","=q1=Papel para envolver con lazos verdes","=q1=Papel de envolver con lazos morados"})
Process("Winterviel2",30,{"","=q1=Caja de ayudante verde","=q1=Campanita alegre","=q1=Caja de ayudante roja","=q1=Equipo de muñeco de nieve","","","=q1=Varita de felicidad del recreo","","","=q3=Robot cohete de cuerda","","","=q1=Asado del Festival de Invierno","=q1=Ponche de huevo del Festival de Invierno","","=q2=Grinch mecánico","=q2=Acebo en conserva","=q2=Diseño: Filo del invierno","=q2=Fórmula: encantar arma: poderío del invierno","=q2=Esquema: Señor de las nieves 9000","=q2=Patrón: guantes del Padre Invierno","=q1=Receta: elixir de poder de Escarcha","=q1=Patrón: camisa de vacaciones verde","","","=q1=Galleta de Festival de Invierno","","","=q1=Pastel de macedonia y carne de Graccu"})
Process("WrathbringerLaztarash",22,{"=q3=Esfera forjada con maná","","=q3=Capa oscura","=q3=Capa enigmática","=q3=Capa ígnea","=q3=Capa gélida","=q3=Capa viviente","","=q2=Etiqueta de identificación de prisionero de los etereum","","","","","","","","","=q3=Banda oscura","=q3=Banda enigmática","=q3=Banda ígnea","=q3=Banda frígida","=q3=Banda viviente"})
end
