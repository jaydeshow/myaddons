﻿--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005, 2008 Dan Gilbert
	Email me at loglow@gmail.com

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

--]]

-- Datos de Atlas (Español)
-- Traducido por --> maqjav|Marosth de Tyrande<--
-- maqjav@hotmail.com
-- Última Actualización (last update): 11/03/2008

--]]


if ( GetLocale() == "esES" ) then

AtlasSortIgnore = {"the (.+)"}

ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "Visualizador de Mapas";
ATLAS_DESC = "Atlas es un visor de instances de Mapas.";

ATLAS_OPTIONS_BUTTON = "Opciones";

BINDING_HEADER_ATLAS_TITLE = "Atlas Bindings";
BINDING_NAME_ATLAS_TOGGLE = "Barra del Atlas";
BINDING_NAME_ATLAS_OPTIONS = "Opciones de la Barra";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "opciones";

ATLAS_STRING_LOCATION = "Localización";
ATLAS_STRING_LEVELRANGE = "Rango de nivel";
ATLAS_STRING_PLAYERLIMIT = "Límite de Jugadores";
ATLAS_STRING_SELECT_CAT = "Seleccionar Categoría";
ATLAS_STRING_SELECT_MAP = "Seleccionar Mapa";
ATLAS_STRING_SEARCH = "Buscar";
ATLAS_STRING_CLEAR = "Limpiar";

ATLAS_OPTIONS_TITLE = "Opciones de Atlas";
ATLAS_OPTIONS_SHOWBUT = "Mostrar botón en el minimapa";
ATLAS_OPTIONS_AUTOSEL = "Auto-Seleccionar mazmorra";
ATLAS_OPTIONS_BUTPOS = "Posición del icono";
ATLAS_OPTIONS_TRANS = "Transparencia";
ATLAS_OPTIONS_DONE = "Hecho";
ATLAS_OPTIONS_REPMAP = "Reemplazar mapa del mundo";
ATLAS_OPTIONS_RCLICK = "Botón derecho para mapa del mundo";
ATLAS_OPTIONS_SHOWMAPNAME = "Mostrar nombre del mapa";
ATLAS_OPTIONS_RESETPOS = "Resetear posición";
ATLAS_OPTIONS_ACRONYMS = "Mostrar acrónimos";
ATLAS_OPTIONS_SCALE = "Escala";
ATLAS_OPTIONS_BUTRAD = "Radio del botón";
ATLAS_OPTIONS_CLAMPED = "Ajustar ventana a la pantalla"
ATLAS_OPTIONS_HELP = "Click-izdo para desplazar esta ventana"
ATLAS_OPTIONS_CTRL = "Pulsar control para ver las herramientas"
ATLAS_OPTIONS_COORDS = "Muestra coords. en el mapa del mundo"


ATLAS_BUTTON_TOOLTIP_TITLE = "Atlas";
ATLAS_BUTTON_TOOLTIP_HINT = "Click izquierdo para abrir Atlas.\nClick central para opciones.\nClick derecho y arrastrar para mover el icono.";
ATLAS_TITAN_HINT = "Click izquierdo para abrir Atlas.\nClick central para opciones.\nClick derecho para mostrar el menú.";




ATLAS_HELP = {"Acerca de Atlas\n===========\n\nAtlas es un addon de interfaz para World of Warcraft que proporciona al usuario un número adicional de mapas para guiarse sobre algunas zonas del juego. Introduciendo el comando '/atlas' o clicando en el icono del minimapa se abrirá la ventana del Atlas. En el panel de opciones permite desactivar el icono, mostrar la opción Auto-seleccionar, mostrar la opción Reemplazar Mapa, mostrar la opción Botón-Derecho, cambiar la posición de los iconos, o ajustar la transparencia de la ventana principal. Si la opción Auto-Seleccionar está activada, Atlas automaticamente abrirá el mapa en la instance que estés. Si la opción Reemplazar Mapa está activada, el Atlas se abrirá en vez del World Map cuando estés en una instance. Si la opció Botón Derecho está activada, puedes clicar con el botón derecho en el Atlas para abrir el World Map. Puedes mover el Atlas con el botón derecho y arrastrando la ventana. Utiliza el icono que hay en la esquina superior derecha para blockear el arrastre de la ventana."};


ATLAS_OPTIONS_CATDD = "Ordenar los mapas de mazmorra por:";
ATLAS_DDL_CONTINENT = "Continente";
ATLAS_DDL_CONTINENT_EASTERN = "Mazmorras de los Reinos del Este";
ATLAS_DDL_CONTINENT_KALIMDOR = "Mazmorras de Kalimdor";
ATLAS_DDL_CONTINENT_OUTLAND = "Mazmorras de Terrallende";
ATLAS_DDL_LEVEL = "Nivel";
ATLAS_DDL_LEVEL_UNDER45 = "Mazmorras de nivel inferior a 45";
ATLAS_DDL_LEVEL_45TO60 = "Mazmorras de nivel 45-60";
ATLAS_DDL_LEVEL_60TO70 = "Mazmorras de nivel 60-70";
ATLAS_DDL_LEVEL_70PLUS = "Mazmorras de nivel 70+";
ATLAS_DDL_PARTYSIZE = "Tamaño del grupo";
ATLAS_DDL_PARTYSIZE_5 = "Mazmorras para 5 jugadores";
ATLAS_DDL_PARTYSIZE_10 = "Mazmorras para 10 jugadores";
ATLAS_DDL_PARTYSIZE_20TO40 = "Mazmorras para 20-40 jugadores";
ATLAS_DDL_EXPANSION = "Expansión";
ATLAS_DDL_EXPANSION_OLD = "Antiguas mazmorras del mundo";
ATLAS_DDL_EXPANSION_BC = "Mazmorras de Burning Crusade";

ATLAS_INSTANCE_BUTTON = "Mazmorra";
ATLAS_ENTRANCE_BUTTON = "Entrada";
ATLAS_SEARCH_UNAVAIL = "Buscar no disponible";

AtlasZoneSubstitutions = {
	["The Temple of Atal'Hakkar"]	= "El Templo Hundido";
	["Ahn'Qiraj"] = "Templo de Ahn'Qiraj";
	["Ruins of Ahn'Qiraj"]	= "Ruinas de Ahn'Qiraj";
	["Karazhan"] = "Karazhan [A] (Comienzo)";
	["Black Temple"] = "Templo oscuro [A] (Comienzo)";
}; 

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "      ";

AtlasMaps = {
	RagefireChasm = {
		ZoneName = "Sima Ignea";
		Acronym = "SI";
		Location = "Orgrimmar";
		BLUE.."A) Entrada";
		GREY.."1) Maur Totem Siniestro"; --Bien
		GREY..INDENT.."Ogglesílex <Jefe Furia Ardiente>"; --Bien
		GREY.."2) Taragaman el hambriento"; --Bien
		GREY.."3) Jergosh el Convocador"; --Bien
		GREY..INDENT.."Zelemar el Colérico (Invocar)"; --Bien
		GREY.."4) Bazzalan"; --Bien
	};
	WailingCaverns = {
		ZoneName = "Las Cuevas de los Lamentos";
		Acronym = "CL";
		Location = "Los Baldíos";
		BLUE.."A) Entrada";
		GREY.."1) Discípulo de Naralex"; --Bien
		GREY.."2) Lord Cobrahn <Noble del Colmillo>"; --Bien
		GREY.."3) Lady Anacondra <Noble del Colmillo>"; --Bien
		GREY.."4) Kresh"; --Bien
		GREY.."5) Lord Pythas <Noble del Colmillo>"; --Bien
		GREY.."6) Skum"; --Bien
		GREY.."7) Lord Serpentis <Noble del Colmillo> (Arriba)"; --Bien
		GREY.."8) Verdan el Eterno (Arriba)";
		GREY.."9) Mutanus el Devorador"; --Bien
		GREY..INDENT.."Naralex"; --Bien
		GREY.."10) Dragón Férico descarriado (Raro)"; --Bien
	};
	BlackfathomDeeps = {
		ZoneName = "Cavernas de Brazanegra";
		Acronym = "CB";
		Location = "Vallefresno";
		BLUE.."A) Entrada";
		GREY.."1) Ghamoo-ra"; --Bien
		GREY.."2) Manuscrito de Lorgalis"; --Bien
		GREY.."3) Lady Sarevess"; --Bien
		GREY.."4) Guardia Argenta Thaelrid <El Alba Argenta>"; --Bien
		GREY.."5) Gelihast"; --Bien
		GREY..INDENT.."Santuario de Gelihast"; --Bien
		GREY.."6) Lorgus Jett (Varia)"; --Bien
		GREY.."7) Barón Aquanis"; --Bien
		GREY..INDENT.."Núcleo de las profundidades"; --Bien
		GREY.."8) Señor Crepuscular Kelris";  --Bien
		GREY.."9) Viejo Serra'kis"; --Bien
		GREY.."10) Aku'mai"; --Bien
		GREY..INDENT.."Morriduna"; --Bien
		GREY..INDENT.."Altar de las profundidades"; --Bien
	};
	RazorfenKraul = {
		ZoneName = "Horado Rajacieno";
		Acronym = "HR";
		Location = "Los Baldíos";
		BLUE.."A) Entrada";
		GREY.."1) Roogug"; --Bien
		GREY.."2) Aggem Malaespina <Profeta de los Caramuerte>"; --Bien
		GREY.."3) Médium Jargba <Capitán Caramuerte>"; --Bien
		GREY.."4) Señor Supremo Colmicarnero"; --Bien
		GREY..INDENT.."Cuerolanza de Rajacieno"; --Bien
		GREY.."5) Agathelos el Furioso"; --Bien
		GREY.."6) Cazador ciego (Raro)"; --Bien
		GREY.."7) Charlga Filonavaja <La Bruja>"; --Bien
		GREY.."8) Willix el Importador"; --Bien
		GREY..INDENT.."Heralath Arroyobarbecho"; --Bien
		GREY.."9) Clamor de Tierra Halmgar (Raro)"; --Bien
	};
	RazorfenDowns = {
		ZoneName = "Zahúrda Rajacieno";
		Acronym = "ZR";
		Location = "Los Baldíos";
		BLUE.."A) Entrada";
		GREY.."1) Tuten'kash"; --Bien
		GREY.."2) Henry Stern"; --Bien
		GREY..INDENT.."Belnistrasz"; --Bien
		GREY..INDENT.."Sah'rhee"; --Bien
		GREY.."3) Mordresh Ojo de Fuego"; --Bien
		GREY.."4) Glotón"; --Bien
		GREY.."5) Morrandrajos (Raro, Varia)"; --Bien
		GREY.."6) Amnennar el Gélido"; --Bien
		GREY.."7) Fauzpeste el Putrefacto"; --Bien
	};
	ZulFarrak = {
		ZoneName = "Zul'Farrak";
		Acronym = "ZF";
		Location = "Tanaris";
		ORNG.."Llave: Marra de Zul'Farrak (Gahz'rilla)";
		BLUE.."A) Entrada";
		GREY.."1) Antu'sul <Sobrestante de Sul>"; --Bien
		GREY.."2) Theka el Mártir"; --Bien
		GREY.."3) Médico Brujo Zum'rah"; --Bien
		GREY..INDENT.."Héroe Muerto Zul'Farrak"; --Bien
		GREY.."4) Nekrum Cometripas"; --Bien
		GREY..INDENT.."Sacerdote oscuro Sezz'ziz"; --Bien
		GREY..INDENT.."Ánima de Polvo (Raro)"; --Bien
		GREY.."5) Sargento Bly"; --Bien
		GREY..INDENT.."Weegli Plomofundido"; --Bien
		GREY..INDENT.."Murta Tripuriosa"; --Bien
		GREY..INDENT.."Cuervo"; --Bien
		GREY..INDENT.."Oro Bocojo"; --Bien
		GREY..INDENT.."Ejecutor Furiarena"; --Bien
		GREY.."6) Hidromántica Velratha"; --Bien
		GREY..INDENT.."Gahz'rilla (Invocar)"; --Bien
		GREY..INDENT.."Ancestro Barvacrín (Festival Lunar)"; --Bien
		GREY.."7) Jefe Ukorz Cabellarena"; --Bien
		GREY..INDENT.."Ruuzlu"; --Bien
		GREY.."8) Zerillis (Raro, Pasea)"; --Bien
		GREY.."9) Sandarr Asaltadunas (Raro)"; --Bien
	};
	Maraudon = {
		ZoneName = "Maraudon";
		Acronym = "Mara";
		Location = "Desolace";
		ORNG.."Llave: Cetro de Celebras (Portal)"; --Bien
		BLUE.."A) Entrada (Naranja)";
		BLUE.."B) Entrada (Morada)";
		BLUE.."C) Entrada (Portal)";
		GREY.."1) Veng <El quinto Khan>"; --Bien
		GREY.."2) Noxxion"; --Bien
		GREY.."3) Lativaja"; --Bien
		GREY.."4) Maraudos <El cuarto Khan>"; --Bien
		GREY.."5) Lord Lenguavil"; --Bien
		GREY.."6) Meshlok el Cosechador (Raro)"; --Bien
		GREY.."7) Celebras el Maldito"; --Bien
		GREY.."8) Derrumbio"; --Bien
		GREY.."9) Manitas Gizlock"; --Bien
		GREY.."10) Escamapodrida"; --Bien
		GREY.."11) Princesa Theradras"; --Bien
		GREY.."12) Ancestro Parterroca (Festival Lunar)"; --Bien
	};
	DireMaulEast = {
		ZoneName = "La Masacre (Este)";
		Acronym = "LME";
		Location = "Feralas";
		ORNG.."Llave: Blandón de Invocación"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Entrada";
		BLUE.."C) Entrada";
		BLUE.."D) Salida";
		GREY.."1) Pusillín Comienzo de la Persecución"; --Bien
		GREY.."2) Pusillín Fin de la Persecución"; --Bien
		GREY.."3) Zevrim Pezuñahendida"; --Bien
		GREY..INDENT.."Hidromilecio"; --Bien
		GREY..INDENT.."Lethtendris"; --Bien
		GREY..INDENT.."Pimgib"; --Bien
		GREY.."4) Viejo Cortezaférrea"; --Bien
		GREY.."5) Alzzin el Formaferal"; --Bien
		GREY..INDENT.."Isalien (Invocar)"; --Bien
	};
	DireMaulNorth = {
		ZoneName = "La Masacre (Norte)";
		Acronym = "LMN";
		Location = "Feralas";
		ORNG.."Llave: Llave creciente"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Biblicoteca"; --Bien
		GREY.."1) Guardia Mol'dar"; --Bien
		GREY.."2) Vapuleador Kreeg <El borracho>"; --Bien
		GREY.."3) Guardia Fengus"; --Bien
		GREY.."4) Knot Thimblejack"; --Bien
		GREY..INDENT.."Guardia Slip'kik"; --Bien
		GREY.."5) Capitán Kromcrush"; --Bien
		GREY.."6) Rey Gordok"; --Bien
		GREY..INDENT.."Cho'Rush el Observador"; --Bien
	};
	DireMaulWest = {
		ZoneName = "La Masacre (Oeste)";
		Acronym = "LMO";
		Location = "Feralas";
		ORNG.."Llave: Llave creciente"; --Bien
		ORNG.."Llave: Jarra de J'eevee (Lord Hel'nurath)"; --Bien
		BLUE.."A) Entranda";
		BLUE.."B) Pilones"; --Bien
		GREY.."1) Anciano Shen'dralar"; --Bien
		GREY.."2) Tendris Madeguerra"; --Bien
		GREY..INDENT.."Antiguo espíritu equino"; --Bien
		GREY.."3) Illyanna Roblecuervo"; --Bien
		GREY..INDENT.."Ferra"; --Bien
		GREY.."4) Magister Kalendris"; --Bien
		GREY.."5) Tsu'zee (Raro)"; --Bien
		GREY.."6) Immol'thar"; --Bien
		GREY..INDENT.."Lord Hel'nurath (Invocar)"; --Bien
		GREY.."7) Príncipe Tortheldrin"; --Bien
		GREN.."1') Librería"; --Bien
		GREN..INDENT.."Falrin Tallarbol"; --Bien
		GREN..INDENT.."Tradicionalista Lydros"; --Bien
		GREN..INDENT.."Tradicionalista Javon"; --Bien
		GREN..INDENT.."Tradicionalista Kildrath"; --Bien
		GREN..INDENT.."Tradicionalista Mykos"; --Bien
		GREN..INDENT.."Proveedor Shen'dralar"; --Bien
		GREN..INDENT.."Restos esqueléticos de Kariel Winthalus"; --Bien (comprobar)
	};
	OnyxiasLair = {
		ZoneName = "Guarida de Onyxia";
		Acronym = "Ony";
		Location = "Marjal Revolcafango";
		ORNG.."Armonización Requerida"; --Bien
		ORNG.."Llave: Amuleto Pirodraco"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Guardas de Onyxia"; --Bien
		GREY.."2) Huevos de crías"; --Bien
		GREY.."3) Onyxia"; --Bien
	};
	TheTempleofAhnQiraj = {
		ZoneName = "El Templo de Ahn'Qiraj";
		Acronym = "AQ40";
		Location = "Silithus";
		ORNG.."Reputación: Linaje de Nozdormu"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) El profeta Skeram (Fuera)"; --Bien
		GREY.."2) La Familia Insecto (Opcional)"; --Bien
		GREY..INDENT.."Vem"; --Bien
		GREY..INDENT.."Lord Kri"; --Bien
		GREY..INDENT.."Princesa Yauj"; --Bien
		GREY.."3) Guardia de batalla Sartura"; --Bien
		GREY.."4) Fankriss el Implacable"; --Bien
		GREY.."5) Viscidus (Opcional)"; --Bien
		GREY.."6) Princesa Huhuran"; --Bien
		GREY.."7) Los Emperadores Gemelos"; --Bien
		GREY..INDENT.."Emperador Vek'lor"; --Bien
		GREY..INDENT.."Emperador Vek'nilash"; --Bien
		GREY.."8) Ouro (Opcional)"; --Bien
		GREY.."9) Ojo de C'Thun / C'Thun"; --Bien
		GREN.."1') Andorgos <Camada de Malygos>"; --Bien
		GREN..INDENT.."Vethsera <Camada de Ysera>"; --Bien
		GREN..INDENT.."Kandrostrasz <Camada de Alexstrasza>"; --Bien
		GREN.."2') Arygos"; --Bien
		GREN..INDENT.."Caelestrasz"; --Bien
		GREN..INDENT.."Merithra del Sueño"; --Bien
	};
	TheRuinsofAhnQiraj = {
		ZoneName = "Ruinas de Ahn'Qiraj";
		Acronym = "AQ20";
		Location = "Silithus";
		ORNG.."Reputación: Círculo Cenarion";
		BLUE.."A) Entrada";
		GREY.."1) Kurinnaxx"; --Bien
		GREY..INDENT.."Teniente General Andorov"; --Bien
		GREY..INDENT.."Cuatro Elites Kaldorei"; --Bien
		GREY.."2) General Rajaxx"; --Bien
		GREY..INDENT.."Capitán Condurso"; --Bien
		GREY..INDENT.."Capitán Tuubid"; --Bien
		GREY..INDENT.."Capitán Drenn"; --Bien
		GREY..INDENT.."Capitán Xurrem"; --Bien
		GREY..INDENT.."Mayor Yeggeth"; --Bien
		GREY..INDENT.."Mayor Pakkon"; --Bien
		GREY..INDENT.."Coronel Zerran"; --Bien
		GREY.."3) Moam (Opcional)"; --Bien
		GREY.."4) Buru el Manducador (Opcional)"; --Bien
		GREY.."5) Ayamiss el Cazador (Opcional)"; --Bien
		GREY.."6) Osiro el Sinmarcas"; --Bien
		GREN.."1') Habitación segura"; --Bien
	};
	CoTBlackMorass = {
		ZoneName = "CdT: La Ciénaga Negra"; --Bien
		Location = "Cavernas del Tiempo, Tanaris";
		Acronym = "CdT2";
		PURP.."Evento: Apertura del Portal Oscuro";
		ORNG.."Armonización Requerida"; --Bien
		ORNG.."Reputación: Vigilantes del tiempo"; --Bien
		ORNG.."Llave: Llave del tiempo (Heróico)";
		BLUE.."A) Entrada";
		BLUE..INDENT.."Sa'at <Vigilantes del Tiempo>"; --Bien
		ORNG.."X) Portal (Puntos de Aparición)"; --Bien
		ORNG..INDENT.."Oleada 6: Chronolord Deja"; --Bien
		ORNG..INDENT.."Oleada 12: Temporus"; --Bien
		ORNG..INDENT.."Oleada 18: Aeonus"; --Bien
		GREY.."1) El Portal Oscuro"; --Bien
		GREY..INDENT.."Medivh"; --Bien
	};
	CoTHyjal = {
		ZoneName = "CdT: El Monte Hyjal"; --Bien
		Location = "Cavernas del Tiempo, Tanaris"; --Bien
		Acronym = "MH, CdT3";
		PURP.."Evento: Batalla por el Monte Hyjal";
		ORNG.."Reputación: La Escama de las Arenas";
		BLUE.."A) Base de la Alianza"; --Bien
		BLUE..INDENT.."Lady Jaina Valiente"; --Bien
		BLUE.."B) Campamento de la Horda"; --Bien
		BLUE..INDENT.."Thrall <Jefe de Guerra>"; --Bien
		BLUE.."C) Pueblo de los Elfos de la Noche"; --Bien
		BLUE..INDENT.."Tyrande Susurravientos <Suma sacerdotisa de Elune>"; --Bien
		GREY.."1) Ira Fríoinvierno"; --Bien
		GREY.."2) Anetheron"; --Bien
		GREY.."3) Kaz'rogal"; --Bien
		GREY.."4) Azgalor"; --Bien
		GREY.."5) Archimonde"; --Bien
		GREY.."?) Indormi <Guardián de la antigua Gema Lore>"; --Comprobar
		GREY..INDENT.."Tydormu <Guardián de artefactos perdidos>"; --Comprobar
	};
	CoTOldHillsbrad = {
		ZoneName = "CdT: Laderas de Trabalomas"; --Bien
		Location = "Cavernas del Tiempo, Tanaris"; --Bien
		PURP.."Evento: Escape del Castillo de Durnholde";
		ORNG.."Armonización Requerida"; --Bien
		ORNG.."Reputación: Vigilantes del tiempo";
		ORNG.."Llave: Llave del tiempo (Heróico)";
		BLUE.."A) Entrada";
		BLUE..INDENT.."Erozion"; --Bien
		BLUE..INDENT.."Brazen"; --Bien
		BLUE.."B) Punto de Aterrizaje"; --Bien
		BLUE.."C) Costasur"; --Bien
		BLUE.."D) Molino Tarren"; --Bien
		GREY.."1) Teniente Draco"; --Bien
		GREY.."2) Thrall (Abajo)"; --Bien
		GREY.."3) Capitán Skarloc"; --Bien
		GREY..INDENT.."Segunda parada de Thrall"; --Bien
		GREY.."4) Tercera parada de Thrall"; --Bien
		GREY.."5) Cazador de eras"; --Bien
		GREY..INDENT.."Cuarta parada de Thrall (Arriba)"; --Bien
		GREY..INDENT.."Taretha (Arriba)"; --Bien
		GREY.."6) Jonathan Revah"; --Bien
		GREY..INDENT.."Jerry Carter"; --Bien
		"";
		ORNG.."Viajando"; --Bien
		GREY..INDENT.."Thomas Yance <Vendedor ambulante>"; --Bien
		GREY..INDENT.."Zhaorí Dalaran envejecido"; --Bien
		""; 
		ORNG.."Costasur"; --Bien
		GREY..INDENT.."Kel'Thuzad <Los Kirin Tor>"; --Bien
		GREY..INDENT.."Helcular"; --Bien
		GREY..INDENT.."Granjero Kent"; --Bien
		GREY..INDENT.."Sally Melenablanca"; --Bien
		GREY..INDENT.."Renault Mograine"; --Bien
		GREY..INDENT.."Pequeño Jimmy Vishas"; --Bien
		GREY..INDENT.."Herod el Matón"; --Bien
		GREY..INDENT.."Nat Pagle"; --Bien
		GREY..INDENT.."Hal McAllister"; --Bien
		GREY..INDENT.."Zixil <Aspirante a mercader>"; --Bien
		GREY..INDENT.."Robovigilante Mark 0 <Protector>"; --Bien
		"";
		ORNG.."Posada de Costasur"; --Bien
		GREY..INDENT.."Capitán Edward Hanes"; --Bien
		GREY..INDENT.."Capitán Sanders"; --Bien
		GREY..INDENT.."Comandante Mograine"; --Bien
		GREY..INDENT.."Isillien"; --Bien
		GREY..INDENT.."Abbendis"; --Bien
		GREY..INDENT.."Ribalimpia"; --Bien
		GREY..INDENT.."Tirión Vardín"; --Bien
		GREY..INDENT.."Arcanista Doan"; --Bien
		GREY..INDENT.."Taelan (Arriba)"; --Bien
		GREY..INDENT.."Posadero Kelly <Camarero>"; --Bien
		GREY..INDENT.."Frances Lin <Camarera>"; --Bien
		GREY..INDENT.."Jefe Jessen <Especialidad en carne y bazofia>"; --Bien
		GREY..INDENT.."Stalvan Mantoniebla (Arriba)"; --Bien
		GREY..INDENT.."Phin Odelic <Los Kirin Tor> (Arriba)"; --Bien
		"";
		ORNG.."Ayuntamiento de Costasur"; --Bien
		GREY..INDENT.."Magistrado Henry Maleb"; --Bien
		GREY..INDENT.."Raleigh el Auténtico"; --Bien
		GREY..INDENT.."Nathanos Marris"; --Bien
		GREY..INDENT.."Maestro cervecero Bilger"; --Bien
		"";
		ORNG.."Molino Tarren"; --Bien
		GREY..INDENT.."Tabernera Monica"; --Bien
		GREY..INDENT.."Julie Pozo de Miel"; --Bien
		GREY..INDENT.."Jay Lemieux"; --Bien
		GREY..INDENT.."Joven Blanchy"; --Bien
	};
	BlackrockDepths = {
		ZoneName = "Profundidades de Roca Negra";
		Location = "Montaña Roca Negra"; --Bien
		ORNG.."Llave: Llave Forjatiniebla"; --Bien
		ORNG.."Llave: Llave de Celda de Prisión (Cárcel)";
		ORNG.."Llave: Estandarte de Provocación (Theldren)";
		BLUE.."A) Entrada";
		GREY.."1) Lord Roccor"; --Bien
		GREY.."2) Kharan Martillazo"; --Bien
		GREY.."3) Comandante Gor'shak <Fuerza Expedicionaria de Kargath>"; --Bien
		GREY.."4) Alguacil Windsor"; --Bien
		GREY.."5) Alta Interrogadora Gerstahn <Interrogadora del Martillo Crepuscular>"; --Bien
		GREY.."6) Círculo de la Ley"; --Bien
		GREY..INDENT.."Anub'shiah (Aleatorio)"; --Bien
		GREY..INDENT.."Eviscerador (Aleatorio)"; --Bien
		GREY..INDENT.."Gorosh el Endemoniado (Aleatorio)"; --Bien
		GREY..INDENT.."Grisez (Aleatorio)"; --Bien
		GREY..INDENT.."Hedrum el Trepador (Aleatorio)"; --Bien
		GREY..INDENT.."Ok'thor el Rompedor (Aleatorio)"; --Bien
		GREY..INDENT.."Theldren (Invocar)"; --Bien
		GREY..INDENT.."Lefty"; --No existen (PREGUNTAR)
		GREY..INDENT.."Malgen Longspear"; --No existen (PREGUNTAR)
		GREY..INDENT.."Gnashjaw <Malgen Longspear's Pet>"; --No existen (PREGUNTAR)
		GREY..INDENT.."Colmipútreo"; --Bien
		GREY..INDENT.."Va'jashni"; --Bien
		GREY..INDENT.."Maestro de canes Grebmar (Abajo)"; --Bien
		GREY..INDENT.."Ancestro Alborhondo (Festival Lunar)"; --Bien
		GREY..INDENT.."Alto Justiciero Pedrasiniestra"; --Bien
		GREY.."7) Monumento a Franclorn Forjador"; --Bien
		GREY..INDENT.."Piromántico Cultugrano"; --Bien
		GREY.."8) Cámara Negra"; --Bien
		GREY..INDENT.."Guarda Stilgiss"; --Bien
		GREY..INDENT.."Verek"; --Bien
		GREY..INDENT.."Vigía Presaletal"; --Bien
		GREY.."9) Finoso Virunegro <Arquitecto jefe>"; --Bien
		GREY.."10) El Yunquenegro"; --Bien
		GREY..INDENT.."Lord Incendius"; --Bien
		GREY.."11) Bael'Gar"; --Bien
		GREY.."12) El candado de Forjatiniebla"; --Bien
		GREY.."13) General Forjainquina"; --Bien
		GREY.."14) Señor Gólem Argelmach"; --Bien
		GREY..INDENT.."Esquema: reparación de campo 74A"; --Bien
		GREY..INDENT.."Diseño de herrería"; --Bien
		GREY.."15) Tragapenas"; --Bien
		GREY..INDENT.."Hurley Negrálito"; --Bien
		GREY..INDENT.."Lokhtos Tratoscuro <La Hermandad del torio>"; --Bien
		GREY..INDENT.."Maestra Nagmara"; --Bien
		GREY..INDENT.."Falange"; --Bien
		GREY..INDENT.."Plugger Aropatoso"; --Bien
		GREY..INDENT.."Soldado Sinrroca"; --Bien
		GREY..INDENT.."Ribbly Llavenrosca"; --Bien
		GREY..INDENT.."Coren Brebaje Temible (Feria cerveza)"; --Bien
		GREY.."16) Embajador Latifuego"; --Bien
		GREY.."17) Panzor el Invencible (Raro)"; --Bien
		GREY..INDENT.."Diseño de herrería"; --Bien
		GREY.."18) Tumba del Invocador"; --Bien
		GREY.."19) El Liceo"; --Bien
		GREY.."20) Magmus"; --Bien
		GREY.."21) Emperador Dagran Thaurissan"; --Bien
		GREY..INDENT.."Princesa Moira Barbabronce <Princesa de Forjaz>"; --Bien
		GREY..INDENT.."Alta Sacerdotisa de Thaurissan"; --Bien
		GREY.."22) La Forjanegra"; --Bien 
		GREY.."23) Núcleo de Magma"; --Bien
		GREY..INDENT.."Trozo del Núcleo"; --Bien
		GREY.."24) Maestro Supremo Pyron"; --Bien
		GREY.."25) Diseño de herrería"; --Bien
	};
	BlackrockSpireLower = {
		ZoneName = "Cumbre de Roca Negra (Abajo)"; --Bien
		Location = "Montaña Roca Negra"; --Bien
		ORNG.."Llave: Blandón de Invocación"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Cumbre de Roca Negra (Arriba)";
		BLUE.."C-F) Conexiones";
		GREY.."1) Vaelan (Arriba)"; --Bien
		GREY.."2) Warosh (Rondando)"; --Bien
		GREY..INDENT.."Ancestro Petraforte"; --Bien
		GREY.."3) Pica férrea"; --Bien
		GREY.."4) Carnicero Cumbrerroca (Raro)"; --Bien
 		GREY.."5) Alto Señor Omokk"; --Bien
		GREY.."6) Señor de batalla Cumbrerroca (Raro)"; --Bien
		GREY..INDENT.."Señor Magus Cumbrerroca (Raro)"; --Bien
		GREY.."7) Cazador de las Sombras Vosh'gajin"; --Bien
		GREY..INDENT.."Quinta tablilla Mosh'aru"; --Bien
		GREY.."8) Bijou"; --Bien
		GREY.."9) Maestro de guerra Voone"; --Bien
		GREY..INDENT.."Mor Ruciapezuña (Invocar)"; --Bien
		GREY..INDENT.."Sexta tablilla Mosh'aru"; --Bien
		GREY.."10) Pertenencias de Bijou"; --Bien
		GREY.."11) Restos humanos"; --Bien
		GREY..INDENT.."Guanteletes de placas sin templar"; --Bien
		GREY.."12) Bannok Hachamacabra (Raro)"; --Bien
		GREY.."13) Madre Telabrasada"; --Bien
		GREY.."14) Colmillor de Cristal (Raro)"; --Bien
		GREY.."15) Pila de tributo a Urok"; --Bien
		GREY..INDENT.."Urok Aullapocalipsis (Invocar)"; --Bien
		GREY.."16) Intendente Zigris"; --Bien
		GREY.."17) Halycon"; --Bien
		GREY..INDENT.."Gizrul el Esclavista"; --Bien
		GREY.."18) Ghok Bashguud (Raro)"; --Bien
		GREY.."19) Señor Supremo Vermiothalak"; --Bien
		GREN.."1') Guarda vil ardiente (Raro, Invocar)"; --Bien
	};
	BlackrockSpireUpper = {
		ZoneName = "Cumbre de Roca Negra (Arriba)";
		Location = "Montaña Roca Negra";
		ORNG.."Llave: Sello de Ascensión"; --Bien
		ORNG.."Llave: Blandón de Invocación"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Cumbre de Roca Negra (Inferior)";
		BLUE.."C-E) Conexiones";
		GREY.."1) Piroguardián Brasadivino"; --Bien
		GREY.."2) Solakar Corona de Fuego"; --Bien
		GREY..INDENT.."Padre llama"; --Bien
		GREY.."3) Tablilla de Rocanegra"; --Bien
		GREY..INDENT.."Broche de Equipasino"; --Bien
		GREY.."4) Jed Vigía de las runas (Raro)"; --Bien
		GREY.."5) Goraluk Yunquegrieta"; --Bien
		GREY.."6) Jefe de Guerra Rend Puño Negro"; --Bien
		GREY..INDENT.."Gyth"; --Bien
		GREY.."7) Awbee"; --Bien
		GREY.."8) La Bestia"; --Bien
		GREY..INDENT.."Lord Valthalak (Invocar)"; --Bien
		GREY..INDENT.."Finkle Unicornín"; --Bien
		GREY.."9) General Drakkisath"; --Bien
		GREY..INDENT.."El orbe de orden"; --Bien
		GREY.."10) Guarida Alanegra"; --Bien
	};
	BlackwingLair = {
		ZoneName = "Guarida Alanegra";
		Acronym = "GA";
		Location = "Cumbre de Roca Negra";
		ORNG.."Armonización Requerida";
		BLUE.."A) Entrada";
		BLUE.."B) Pasillo"; --Bien
		BLUE.."C) Pasillo"; --Bien
		GREY.."1) Sangrevaja el Indomable"; --Bien
		GREY.."2) Vaelastrasz el Corrupto"; --Bien
		GREY.."3) Señor de prole Capazote"; --Bien
		GREY.."4) Faucefogo"; --Bien
		GREY..INDENT.."Dracónico para torpes"; --Bien
		GREY.."5) Maestro de los elementos Formacio Krixix";
		GREY.."6) Ebanorroca"; --Bien
		GREY.."7) Flamagor"; --Bien
		GREY.."8) Chromaggus"; --Bien
		GREY.."9) Nefarian"; --Bien
	};
	Gnomeregan = {
		ZoneName = "Gnomeregan"; --Bien
		Location = "Dun Morogh";
		ORNG.."Llave: Llave de taller (Puerta de atrás)"; --Bien
		BLUE.."A) Entrada (Puerta principal)";
		BLUE.."B) Entrada (Puerta de atrás)";
		GREY.."1) Maestro Destructor Emi Plomocorto"; --Bien
		GREY..INDENT.."Grubbis"; --Bien
		GREY..INDENT.."Mastic"; --Bien
		GREY.."2) Habitación limpia"; --Bien
		GREY..INDENT.."Tink Silbadentado"; --Bien
		GREY..INDENT.."El Destellamatic 5200"; --Bien
		GREY..INDENT.."Buzón"; --Bien
		GREY.."3) Kernobee"; --Bien
		GREY..INDENT.."Alarmabomba 2600"; --Bien
		GREY..INDENT.."Perforégrafo Matriz 3005-B"; --Bien
		GREY.."4) Radiactivo viscoso"; --Bien
		GREY.."5) Electrocutor 6000"; --Bien
		GREY..INDENT.."Perforégrafo Matriz 3005-C"; --Bien
		GREY.."6) Golpeamasa 9-60 (Arriba)"; --Bien
		GREY..INDENT.."Perforégrafo Matriz 3005-D"; --Bien
		GREY.."7) Embajador Hierro Negro"; --Bien
		GREY.."8) Mekigeniero Termochufe"; --Bien
	};
	MoltenCore = {
		ZoneName = "Núcleo de Magma"; --Bien
		Acronym = "NM";
		Location = "Profundidades de Roca Negra";
		ORNG.."Armonización Requerida";
		ORNG.."Reputación: Srs. del Agua de Hydraxis"; --Bien
		ORNG.."Llave: Quintaesencia Eterna/de agua (Jefe)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Lucifron"; --Bien
		GREY.."2) Magmadar"; --Bien
		GREY.."3) Gehennas"; --Bien
		GREY.."4) Garr"; --Bien
		GREY.."5) Shazzrah"; --Bien
		GREY.."6) Barón Geddon"; --Bien
		GREY.."7) Golemagg el Incinerador"; --Bien
		GREY.."8) Sulfuron Presagista"; --Bien
		GREY.."9) Mayordomo Executus"; --Bien
		GREY.."10) Ragnaros"; --Bien
	};
	SMLibrary = {
		ZoneName = "Monasterio Escarlata: Librería";
		Location = "ME, Claros de Tirisfal"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Maestro de canes Loksey"; --Bien
		GREY.."2) Arcanista Doan"; --Bien
	};
	SMArmory = {
		ZoneName = "Monasterio Escarlata: Armería";
		Location = "ME, Claros de Tirisfal";
		ORNG.."Llave: La llave Escarlata"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Herod"; --Bien
	};
	SMCathedral = {
		ZoneName = "Monasterio Escarlata: Catedral";
		Acronym = ""; --Bien (Catedral)
		Location = "ME, Claros de Tirisfal";
		ORNG.."Llave: La llave Escarlata";
		BLUE.."A) Entrada";
		GREY.."1) Alto Inquisidor Ribalimpia"; --Bien
		GREY.."2) Comandante Escarlata Mograine"; --Bien
		GREY..INDENT.."Alta Inquisidora Melenablanca"; --Bien
	};
	SMGraveyard = {
		ZoneName = "Monasterio Escarlata: Cementerio";
		Location = "ME, Claros de Tirisfal";
		BLUE.."A) Entrada";
		GREY.."1) Interrogador Vishas"; --Bien
		GREY..INDENT.."Vorrel Sengutz"; --Bien
		GREY.."2) Calabaza Santuario (Halloween)";
		GREY..INDENT.."Jinete decapitado (Invocar)"; --Bien
		GREY.."3) Mago Sangriento Thalnos"; --Bien
		GREN.."1') Dosarcerado (Raro)"; --Bien
		GREN..INDENT.."Azshir el Insomne (Raro)"; --Bien
		GREN..INDENT.."Campeón caído (Raro)"; --Bien
	};
	Scholomance = {
		ZoneName = "Scholomance";
		Acronym = "Scholo";
		Location = "Praderas de la Peste del Oeste";
		ORNG.."Reputación: Alba Argenta"; --Bien
		ORNG.."Llave: Llave esqueleto"; --Bien
		ORNG.."Llave: Llave de la Sala de visión (Sala de visión)"; --Bien
		ORNG.."Llave: Sangre de los Inocentes (Kirtonos)"; --Bien
		ORNG.."Llave: Blandón de Invocación"; --Bien
		ORNG.."Llave: Cristal de adivinación (Atracoscuro)"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Escaleras"; --Bien
		BLUE.."C) Escaleras"; --Bien
		GREY.."1) Administrador de sangre de Kirtonos"; --Bien
		GREY..INDENT.."Las escrituras de Costasur"; --Bien
		GREY.."2) Kirtonos el Heraldo (Invocar)"; --Bien
		GREY.."3) Jandice Barov"; --Bien
		GREY.."4) Las escrituras de Molino Tarren"; --Bien
		GREY.."5) Traquesangre (Abajo)"; --Bien
		GREY..INDENT.."Caballero de la Muerte Atracoscuro (Invocar)"; --Bien
		GREY.."6) Marduz Pozonegro";  --Bien
		GREY..INDENT.."Vectus"; --Bien
		GREY.."7) Ras Levescarcha"; --Bien
		GREY..INDENT.."Las escrituras de Rémol"; --Bien
		GREY..INDENT.."Kormok (Invocar)"; --Bien
		GREY.."8) Instructora Malicia"; --Bien
		GREY.."9) Doctor Theolen Krastinov"; --Bien
		GREY.."10) Tradicionalista Polkelt"; --Bien
		GREY.."11) El Devorador"; --Bien
		GREY.."12) Lord Alexei Barov"; --Bien
		GREY..INDENT.."Las escrituras de Castel Darrow"; --Bien
		GREY.."13) Lady Illucia Barov"; --Bien
		GREY.."14) Maestro oscuro Gandling"; --Bien
		GREN.."1') Antocha palanca"; --Bien
		GREN.."2') Cofre secreto"; --Bien
		GREN.."3') Laboratorio de alquimia"; --Bien
	};
	ShadowfangKeep = {
		ZoneName = "Castillo de Colmillo Oscuro";
		Location = "Bosque de los Argénteos";
		BLUE.."A) Entrada";
		BLUE.."B) Pasillo"; --Bien
		BLUE.."C) Pasillo"; --Bien
		BLUE..INDENT.."Capitán Juramorte (Raro)"; --Bien
		GREY.."1) Rethilgore"; --Bien
		GREY..INDENT.."Hechicero Ashcrombe"; --Bien
		GREY..INDENT.."Mortacechador Adamant"; --Bien
		GREY..INDENT.."Landen Fontana"; --Bien
		GREY.."2) Mortacechador Vincent"; --Bien
		GREY.."3) Corcel vil"; --Bien
		GREY..INDENT.."Martillo de Jordan"; --Bien
		GREY..INDENT.."Cajón de lingotes"; --Bien
		GREY.."4) Zarpador el Carnicero"; --Bien
		GREY.."5) Barón Filargenta"; --Bien
		GREY.."6) Comandante Vallefont"; --Bien
		GREY.."7) Odo el vigía ciego"; --Bien
		GREY.."8) Fenrus el Devorador"; --Bien
		GREY..INDENT.."Abisario de Arugal"; --Bien
		GREY..INDENT.."El libro de Ur"; --Bien
		GREY.."9) Maestro de lobos Nandos"; --Bien
		GREY.."10) Archimago Arugal"; --Bien
	};
	Stratholme = {
		ZoneName = "Stratholme";
		Acronym = "Strat";
		Location = "Praderas de la Peste del Este";
		ORNG.."Reputación: Alba Argenta";
		ORNG.."Llave: La llave Escarlata (Parte de Escarlata)"; --Bien
		ORNG.."Llave: Llave de la ciudad (Partes no-muertos)"; --Bien
		ORNG.."Llave: Llaves de buzones (Malown)"; --Bien
		ORNG.."Llave: Blandón de Invocación"; --Bien
		BLUE.."A) Entrada (Principal)";
		BLUE.."B) Entrada (Lateral)";
		GREY.."1) Skul (Raro, Varia)"; --Bien
		GREY..INDENT.."Mensajero de Stratholme"; --Bien
		GREY..INDENT.."Fras Siabi"; --Bien
		GREY.."2) Atiesh (Invocar)"; --Bien
		GREY.."3) Escupezones Foreste (Varia)"; --Bien
		GREY.."4) El imperdonable"; --Bien
		GREY.."5) Elder Farwhisper (Festival Lunar)"; --No visto (Festival Lunar) (PREGUNTAR)
		GREY.."6) Timmy el Cruel"; --Bien
		GREY.."7) Malor el Entusiasta"; --Bien
		GREY..INDENT.."Medallón de fe"; --Bien
		GREY.."8) Forjamartillos Carmesí (Invocar)"; --Bien
		GREY..INDENT.."Diseño: Serenidad"; --Bien
		GREY.."9) Cañonero Jefe Willey"; --Bien
		GREY.."10) Archivista Galford"; --Bien
		GREY.."11) Gran Cruzado Dathrohan"; --Bien
		GREY..INDENT.."Balnazzar"; --Bien
		GREY..INDENT.."Sothos (Invocar)"; --Bien
		GREY..INDENT.."Jarien (Invocar)"; --Bien
		GREY.."12) Magistrado Barthilas (Varia)"; --Bien
		GREY.."13) Aurius"; --Bien
		GREY.."14) Pidrespina (Raro)"; --Bien
		GREY.."15) Baronesa Anastari"; --Bien
		GREY..INDENT.."Armero Guardia Negra (Invocar)"; --Bien
		GREY..INDENT.."Diseño: Corrupción"; --Bien
		GREY.."16) Nerub'enkan"; --Bien
		GREY.."17) Maleki el Pálido"; --Bien
		GREY.."18) Ramstein el Empachador"; --Bien
		GREY.."19) Barón Osahendido"; --Bien
		GREY..INDENT.."Ysida Harmon"; --Bien
		GREN.."1') Buzón de la Plaza del Cruzado"; --Bien
		GREN.."2') Buzón de la Fila del Mercado"; --Bien
		GREN.."3') Buzón de la calle del Festival"; --Bien
		GREN.."4') Buzón de la Plaza de los Ancianos"; --Bien
		GREN.."5') Buzón de la Plaza del Rey"; --Bien
		GREN.."6') Buzón de Fras Siabi"; --Bien
		GREN.."3rd Caja Abierta: Jefe de correos Gassol"; --Bien
	};
		TheDeadmines = {
		ZoneName = "Las Minas de la Muerte";
		Acronym = "LMM";
		Location = "Páramos de Poniente";
		BLUE.."A) Entrada"; --Bien
		BLUE.."B) Salida"; --Bien
		GREY.."1) Rhahk'Zor"; --Bien
		GREY.."2) Minero Johnson (Raro)"; --Bien
		GREY.."3) Sneed"; --Bien
		GREY..INDENT.."Triturador de Sneed"; --Bien
		GREY.."4) Gilnid"; --Bien
		GREY.."5) Pólvora Defias"; --Bien
		GREY.."6) Capitán Verdepel"; --Bien
		GREY..INDENT.."Edwin VanCleef"; --Bien
		GREY..INDENT.."Don Mamporro"; --Bien
		GREY..INDENT.."El Chef"; --Bien
	};
		TheStockade = {
		ZoneName = "Las Mazmorras";
		Location = "Ventormenta";
		BLUE.."A) Entrada";
		GREY.."1) Targor el Pavoroso (Varia)"; --Bien
		GREY.."2) Kam Furiahonda"; --Bien
		GREY.."3) Hamhock"; --Bien
		GREY.."4) Bazil Thredd"; --Bien
		GREY.."5) Dextren Tutor"; --Bien
		GREY.."6) Bruegal Nudoferro (Raro)"; --Bien
	};
	TheSunkenTemple = {
		ZoneName = "Templo de Atal'Hakkar";
		Acronym = "TAH";
		Location = "Pantano de las Penas";
		ORNG.."Llave: Pergamino de Yeh'kinya's (Avatar de Hakkar)";
		BLUE.."A) Entrada";
		BLUE.."B) Escaleras";
		BLUE.."C) Minijefes Trol (Arriba)"; --Bien
		BLUE..INDENT.."Gasher"; --Bien
		BLUE..INDENT.."Loro"; --Bien
		BLUE..INDENT.."Hukku"; --Bien
		BLUE..INDENT.."Zolo"; --Bien
		BLUE..INDENT.."Mijan"; --Bien
		BLUE..INDENT.."Zul'Lor"; --Bien
		GREY.."1) Altar de Hakkar"; --Bien
		GREY..INDENT.."Atal'alarion"; --Bien
		GREY.."2) Guadañasueños"; --Bien
		GREY..INDENT.."Sastrón"; --Bien
		GREY.."3) Avatar de Hakkar"; --Bien
		GREY.."4) Jammal'an el Profeta"; --Bien
		GREY..INDENT.."Ogom el Desdichado"; --Bien
		GREY.."5) Morphaz"; --Bien
		GREY..INDENT.."Hazzas"; --Bien
		GREY.."6) Sombra de Eranikus"; --Bien
		GREY..INDENT.."Fuente de esencia"; --Bien
		GREY.."7) Engendro de Hakkar (Raro)"; --Bien
		GREY.."8) Ancestro Cantoestelar (Festival Lunar)"; --Bien
		GREN.."1'-6') Orden de activación de estatuas"; --Bien
	};
	Uldaman = {
		ZoneName = "Uldaman";
		Acronym = "Ulda";
		Location = "Tierras Inhóspitas";
		ORNG.."Llave: Basón de Prehistoria (Hierraya)"; --Bien
		BLUE.."A) Entrada (Principal)";
		BLUE.."B) Entrada (Trasera)";
		GREY.."1) Baelog"; --Bien
		GREY..INDENT.."Eric \"El Veloz\""; --Bien
		GREY..INDENT.."Olaf"; --Bien
		GREY..INDENT.."El Cofre de Baelog"; --Bien
		GREY..INDENT.."Urna llamativa"; --Bien
		GREY.."2) Restos de un paladín"; --Bien
		GREY.."3) Revelosh"; --Bien
		GREY.."4) Hierraya"; --Bien
		GREY.."5) Centinela Obsidiano"; --Bien
		GREY.."6) Annora (Maestro Encantador)"; --Bien
		GREY.."7) Vigilante Pétreo Anciano"; --Bien
		GREY.."8) Galgann Flamartillo"; --Bien
		GREY..INDENT.."Tablilla de Voluntad"; --Bien
		GREY..INDENT.."Alijo de Forjatiniebla"; --Bien
		GREY.."9) Grimlok"; --Bien
		GREY.."10) Archaedas (Abajo)"; --Bien
		GREY.."11) Los Discos de Norgannon"; --Bien
		GREY..INDENT.."Tesoro Antiguo (Abajo)"; --Bien
	};
	ZulGurub = {
		ZoneName = "Zul'Gurub";
		Acronym = "ZG";
		Location = "Vega de Tuercespina"; --Bien
		ORNG.."Reputación: Tribu Zandalar"; --Bien
		ORNG.."Llave: Mudskunk Lure (Gahz'ranka)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Suma Sacerdotisa Jeklik (Murciélago)"; --Bien
		GREY.."2) Sumo Sacerdote Venoxis (Serpiente)"; --Bien
		GREY.."3) Zanza el Incansable"; --Bien
		GREY.."4) Suma Sacerdotisa Mar'li (Araña)"; --Bien
		GREY.."5) Señor sangriento Mandokir (Raptor, Opcional)"; --Bien
		GREY..INDENT.."Ohgan"; --Bien
		GREY.."6) Blandón de la locura (Opcional)"; --Bien
		GREY..INDENT.."Gri'lek (Aleatorio)"; --Bien
		GREY..INDENT.."Hazza'rah (Aleatorio)"; --Bien
		GREY..INDENT.."Renataki (Aleatorio)"; --Bien
		GREY..INDENT.."Wushoolay (Aleatorio)"; --Bien
		GREY.."7) Gahz'ranka (Opcional, Invocar)"; --Bien
		GREY.."8) Sumo sacerdote Thekal (Tigre)"; --Bien
		GREY..INDENT.."Zelote Zath"; --Bien
		GREY..INDENT.."Zelote Lor'Khan"; --Bien
		GREY.."9) Suma sacerdotisa Arlokk (Pantera)"; --Bien
		GREY.."10) Jin'do el Aojador (No-muerto, Opcional)"; --Bien
		GREY.."11) Hakkar"; --Bien
		GREN.."1') Aguas Fangosas"; --Bien
	};
	Naxxramas = {
		ZoneName = "Naxxramas";
		Acronym = "Nax";
		Location = "Bosque de la Plaga, T.P.E.";
		ORNG.."Armonización Requerida";
		ORNG.."Reputación: Alba Argenta"; --Bien
		BLUE.."A) Entrada";
		BLUE..INDENT.."Archimago Tarsis Kil-Moldir"; --Bien
		BLUE..INDENT.."Sr. Biguelvalor (Rondando)";	--Bien	
		BLUE.."Ala de las Abominaciones"; --No visto (comprobar)
		BLUE..INDENT.."1) Remendejo"; --Bien
		BLUE..INDENT.."2) Grobbulus"; --Bien
		BLUE..INDENT.."3) Gluth"; --Bien
		BLUE..INDENT.."4) Thaddius"; --Bien
		ORNG.."Ala de las Arañas"; --No visto (comprobar)
		ORNG..INDENT.."1) Anub'Rekhan"; --Bien
		ORNG..INDENT.."2) Gran Viuda Faerlina"; --Bien
		ORNG..INDENT.."3) Maexxna"; --Bien
		_RED.."Ala de los Caballeros Muertos"; --No visto (comprobar)
		_RED..INDENT.."1) Instructor Razuvious"; --Bien
		_RED..INDENT.."2) Gothik el Cosechador"; --Bien
		_RED..INDENT.."3) Los cuatro Caballoshombre"; --Bien
		_RED..INDENT..INDENT.."Thane Korth'azz"; --Bien
		_RED..INDENT..INDENT.."Lady Blaumeux"; --Bien
		_RED..INDENT..INDENT.."Alto Señor Mograine"; --Bien
		_RED..INDENT..INDENT.."Sir Zeliek"; --Bien
		PURP.."Ala de la Plaga"; --Bien
		PURP..INDENT.."1) Noth el Pesteador"; --Bien
		PURP..INDENT.."2) Heigan el Impuro"; --Bien
		PURP..INDENT.."3) Loatheb"; --Bien
		GREN.."Frostwyrm Lair"; --No visto (comprobar)
		GREN..INDENT.."1) Sapphiron"; --Bien
		GREN..INDENT.."2) Kel'Thuzad"; --Bien
	};
	KarazhanStart = {
		ZoneName = "Karazhan (Comienzo)";
		Acronym = "Kara";
		Location = "Paso de la Muerte"; --Bien
		ORNG.."Reputación: Colgante del ojo violeta"; --Bien
		ORNG.."Llave: La llave del maestro"; --Bien
		ORNG.."Llave: Urna ennegrecida (Nocturno)"; --Bien
		BLUE.."A) Entrada principal";
		BLUE.."B) Escaleras al Salón de baile (Moroes)"; --Bien COMPROBAR
		BLUE.."C) Escaleras al Establo superior"; --Bien COMPROBAR
		BLUE.."D) Rampa a Los aposentos de invitados (Maiden)"; --Bien COMPROBAR
		BLUE.."E) Escaleras al nivel de la Opera"; --Bien COMPROBAR
		BLUE.."F) Rampa desde Mezzanine al Balcón"; --Bien COMPROBAR	
		BLUE.."G) Entrada trasera";	
		BLUE.."H) Conexión con: El Bancal del Maestro (Nocturno)"; --Bien		
		BLUE.."I) Camino a las Escaleras rotas"; --Bien COMPROBAR		
		GREY.."1) Hastings <El Custodio>"; --Bien		
		GREY.."2) Hyakiss el Rondador (Raro, Aleatorio)"; --Bien		
		GREY..INDENT.."Rokad el Devastador (Raro, Aleatorio)"; --Bien
		GREY..INDENT.."Shadikith el Planeador (Raro, Aleatorio)"; --Bien COMPROBAR
		GREY.."3) Berthold <El Portero>"; --Bien
		GREY.."4) Calliard <El Hombre de la noche>"; --Bien
		GREY.."5) Attumen el Montero"; --Bien
		GREY..INDENT.."Medianoche"; --Bien
		GREY.."6) Koren <El Herrero>"; --Bien
		GREY.."7) Moroes"; --Bien
		GREY..INDENT.."Baronesa Dorothea Tallolino (Aleatorio, Sacerdote de Sombras)"; --Bien
		GREY..INDENT.."Lady Catriona Von'Indi (Aleatorio, Sacerdote de Curación)"; --Bien
		GREY..INDENT.."Lady Keira Bayadol (Aleatorio, Paladín de Curación)"; --Bien
		GREY..INDENT.."Barón Rafe Dreuger (Aleatorio, Paladín de Reprensión)"; --Bien
		GREY..INDENT.."Lord Robin Daris (Aleatorio, Guerrero de Armas)"; --Bien
		GREY..INDENT.."Lord Crispin Ference (Aleatorio, Guerrero de Protección)"; --Bien
		GREY.."8) Bennett <El Sargento de Armas>"; --Bien
		GREY.."9) Cerranegro <El Noble>"; --Bien
		GREY.."10) Apuntes de Keanna (Misión)"; --Bien
		GREY.."11) Doncella de Virtud"; --Bien
		GREY.."12) Sebastian <El Organista>"; --Bien
		GREY.."13) Barnes <El Director de escena>"; --Bien
		GREY.."14) Evento de la opera"; --Bien
		GREY..INDENT.."Caperucita Roja (Aleatorio)"; --Bien
		GREY..INDENT.."El mago de Oz (Aleatorio)"; --Bien
		GREY..INDENT.."Romeo y Julieta (Aleatorio)"; --Bien
		GREY.."15) El Bancal del Maestro (Misión)"; --Bien
		GREY..INDENT.."Nocturno (Invocar)"; --Bien
	};
	KarazhanEnd = {
		ZoneName = "Karazhan (Final)"; --Bien
		Acronym = "Kara";
		Location = "Paso de la Muerte"; --Bien
		ORNG.."Reputación: Colgante del ojo violeta"; --Bien
		ORNG.."Llave: La llave del maestro"; --Bien
		BLUE.."I) Camino a las Escaleras rotas"; --Bien COMPROBAR
		BLUE.."J) Escaleras rotas"; --Bien COMPROBAR
		BLUE.."K) Rampa a la Biblioteca del Guardián (Sombra de Aran)"; --Bien
		BLUE.."L) Publicaciones sospechosas (Pasaje a Pezuña Enferma)"; --Bien
		BLUE.."M) Subida a la Vista Celestial (Rencor abisal)"; --Bien
		BLUE..INDENT.."Bajada a la Sala de Juegos (Evento del Ajedrez)"; --Bien
		BLUE.."N) Rampa a la Cámara de Medivh"; --Bien
		BLUE.."O) Escaleras de caracol a Rencor Abisal (Príncipe)"; --Bien
		GREY.."16) Curator"; --Bien
		GREY.."17) Wravien <El Mago>"; --Bien
		GREY.."18) Gradav <El Brujo>"; --Bien
		GREY.."19) Kamsis <La Conjuradora>"; --Bien
		GREY.."20) Terestian Pezuña Enferma"; --Bien
		GREY..INDENT.."Kil'rek (Imp)"; --Bien
		GREY.."21) Sombra de Aran"; --Bien
		GREY.."22) Rencor Abisal"; --Bien
		GREY.."23) Ythyar (Reparaciones y consumibles)"; --Bien
		GREY.."24) Eco de Medivh"; --Bien
		GREY.."25) Evento del Ajedrez"; --Bien
		GREY.."26) Príncipe Malchezaar"; --Bien
	};
	HCBloodFurnace = {
		ZoneName = "CFI: El Horno de la Sangre";
		Location = "Ciuda. del Fuego Infernal, Penín. de Fuego";
		Acronym = "HS";
		ORNG.."Reputación: Thrallmar (Horda)"; --Bien
		ORNG.."Reputación: Bastión del Honor (Alianza)"; --Bien
		ORNG.."Llave: Llave de Forjallamas (Heróico)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) El Hacedor"; --Bien
		GREY.."2) Broggok"; --Bien
		GREY.."3) Keli'dan el Ultrajador"; --Bien
	};
	HCTheShatteredHalls = {
		ZoneName = "CFI: Las Salas Arrasadas";
		Location = "Ciuda. del Fuego Infernal, Penín.de Fuego";
		Acronym = "SA"; 
		ORNG.."Reputación: Thrallmar (Horda)"; --Bien
		ORNG.."Reputación: Bastión del Honor (Alianza)"; --Bien
		ORNG.."Llave: Llave de las Salas Arrasadas";
		ORNG.."Llave: Llave de Forjallamas (Heróico)";
		BLUE.."A) Entranda";
		GREY.."1) Randy Whizzlesprocket (Alianza, heróico)"; --FALTA
		GREY..INDENT.."Drisella (Horda, heróico)"; --Bien
		GREY.."2) Brujo supremo Malbisal (Horda, heróico)"; --Bien
		GREY.."3) Guardia de sangre Mano Destrozada (Heróico)"; --Bien
		GREY.."4) Belisario O'mrogg"; --Bien
		GREY.."5) Jefe de Guerra Kargath Garrafilada"; --Bien
		GREY..INDENT.."Ejecutor Mano Destrozada (Heróico)"; --Bien
		GREY..INDENT.."Soldado Jacint (Alianza, heróico)"; --Bien
		GREY..INDENT.."Rifleman Brownbeard (Alianza, heróico)"; --FALTA
		GREY..INDENT.."Capitán Alina (Alianza, heróico)"; --Bien
		GREY..INDENT.."Explorador Orgarr (Horda, heróico)"; --Comprobar
		GREY..INDENT.."Korag Proudmane (Horda, heróico)"; --FALTA
		GREY..INDENT.."Capitán Huesodestrozado (Horda, heróico)"; --Comprobar
	};
	HCHellfireRamparts = {
		ZoneName = "CFI: Murallas del Fuego Infernal";
		Location = "Ciuda. del Fuego Infernal, Penín. de Fuego";
		ORNG.."Reputación: Thrallmar (Horda)"; --Bien
		ORNG.."Reputación: Bastión del Honor (Alianza)"; --Bien
		ORNG.."Llave: Llave de Forjallamas (Heróico)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Guardián vigía Gargolmar"; --Bien
		GREY.."2) Omor el Sinmarcas"; --Bien
		GREY.."3) Vazruden el Heraldo"; --Bien
		GREY..INDENT.."Nazan"; --Bien
		GREY..INDENT.."Cofre de hierro vil reforzado"; --Bien
	};
	HCMagtheridonsLair = {
		ZoneName = "CFI: Guarida de Magtheridon";
		Location = "Ciuda. del Fuego Infernal, Penín. de Fuego";
		ORNG.."Reputación: Thrallmar (Horda)";
		ORNG.."Reputación: Bastión del Honor (Alianza)";
		BLUE.."A) Entrada";
		GREY.."1) Magtheridon"; --Bien
	};
	CFRTheSlavePens = {
		ZoneName = "RCT: Recinto de los Esclavos";
		Location = "Reserva CT, Marisma de Zangar";
		Acronym = "RE";
		ORNG.."Reputación: Excpedición Cenarion";
		ORNG.."Llave: Llave de dóposito (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Mennu el Traidor"; --Bien
		GREY.."2) Desherbador Pulgaverde"; --Bien
		GREY.."3) Skar'this el Herético (Heróico)";
		GREY.."4) Rokmar el Crujidor"; --Bien
		GREY.."5) Naturalista Mordisco"; --Bien
		GREY.."6) Quagmirran"; --Bien
	};
	CFRTheUnderbog = {
		ZoneName = "RCT: La Sotiénaga";
		Location = "Reserva CT, Marisma de Zangar";
		Acronym = "LS";
		ORNG.."Reputación: Excpedición Cenarion";
		ORNG.."Llave: Llave de dóposito (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Hungarfen"; --Bien
		GREY..INDENT.."La Sotoespora"; --Bien
		GREY.."2) Ghaz'an"; --Bien
		GREY.."3) Lingaterra Rayge"; --Bien
		GREY.."4) Señor del pantano Musel'ek"; --Bien
		GREY..INDENT.."Clamavientos Zarpa"; --Bien
		GREY.."5) La acechadora negra"; --Bien
	};
	CFRTheSteamvault = {
		ZoneName = "RCT: La Cámara de Vapor";
		Location = "Reserva CT, Marisma de Zangar";
		Acronym = "LCV";
		ORNG.."Reputación: Excpedición Cenarion";
		ORNG.."Llave: Llave de dóposito (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Hidromántico Thespia"; --Bien
		GREY..INDENT.."Panel de acceso de la cámara principal"; --Bien
		GREY.."2) Contenedor Arcano"; --Bien
		GREY..INDENT.."Guardián del Segundo Fragmento"; --Bien
		GREY.."3) Mekigeniero Vaporino"; --Bien
		GREY..INDENT.."Panel de acceso de la cámara principal"; --Bien
		GREY.."4) Señor de la Guerra Kalithresh"; --Bien
	};
	CFRSerpentshrineCavern = {
		ZoneName = "RCT: Caverna Santuario Serpiente";
		Location = "Reserva CT, Marisma de Zangar";
		ORNG.."Reputación: Excpedición Cenarion";
		BLUE.."A) Entrada";
		GREY.."1) Hydross el Inestable"; --Bien
		GREY.."2) El Rondador de abajo"; --Bien
		GREY.."3) Leotheras el Ciego"; --Bien
		GREY.."4) Señor de la profundidades Karathress"; --Bien
		GREY..INDENT.."Profeta Olum"; --Comprobar
		GREY.."5) Morogrim Levantamareas"; --Bien
		GREY.."6) Lady Vashj"; --Bien
	};
	AuchManaTombs = {
		ZoneName = "Auchindoun: Tumbas de Maná";
		Location = "Auchindoun, El vert. de huesos";
		ORNG.."Reputación: El Consorcio";
		ORNG.."Llave: Llave Auchenai (Heróico)";
		ORNG.."Llave: El ojo de Haramad (Exaltado, Yor)";
		BLUE.."A) Entrada";
		GREY.."1) Pandemonius"; --Bien
		GREY..INDENT.."Señor de las Sombras Xiraxis"; --Bien
		GREY.."2) Embajador Pax'ivi (Heróico)"; --Bien
		GREY.."3) Tavarok"; --Bien
		GREY.."4) Crioingeniero Sha'heen"; --Bien
		GREY..INDENT.."Panel de control del transportador etéreo"; --Bien		
		GREY.."5) Príncipe-nexo Shaffar"; --Bien
		GREY..INDENT.."Yor (Cámara de estasis, invocar, heróico)";
	};
	AuchAuchenaiCrypts = {
		ZoneName = "Auchindoun: Criptas Auchenai";
		Location = "Auchindoun, El vert. de huesos";
		ORNG.."Reputación: Bajo Arrabal";
		ORNG.."Llave: Llave Auchenai (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Shirrak el Vigía de los Muertos"; --Bien
		GREY.."2) Exarca Maladaar"; --Bien
		GREY..INDENT.."Avatar de los Martirizados"; --Bien
		GREY..INDENT.."D'ore"; --Bien
	};
	AuchSethekkHalls = {
		ZoneName = "Auchindoun: Salas Sethekk";
		Location = "Auchindoun, El vert. de huesos";
		ORNG.."Reputación: Bajo Arrabal";
		ORNG.."Llave: Llave Auchenai (Heróico)";
		ORNG.."Llave: Piedra lunar imbuida de esencia (Anzu)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Tejeoscuro Syth"; --Bien
		GREY..INDENT.."Lakka"; --Bien
		GREY.."2) Esbirro de Terokk"; --Bien
		GREY..INDENT.."Anzu (Invocar, heróico)"; --Bien
		GREY.."3) Rey Garra Ikiss"; --Bien
	};
	AuchShadowLabyrinth = {
		ZoneName = "Auchi.: Laberinto de las Sombras";
		Location = "Auchindoun, El vert. de huesos";
		ORNG.."Reputación: Bajo Arrabal";
		ORNG.."Llave: Llave del Laberinto de las Sombras";
		ORNG.."Llave: Llave Auchenai (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Espía To'gun"; --Bien
		GREY.."2) Embajador Faucinferno"; --Bien
		GREY.."3) Negrozón el Incitador"; --Bien
		GREY.."4) Maestro mayor Vorpil"; --Bien
		GREY..INDENT.."El Códice de Sangre"; --Bien
		GREY.."5) Murmur"; --Bien
		GREY.."6) Contenedor Arcano"; --Bien
		GREY..INDENT.."Guardián del Primer Fragmento"; --Bien
	};
	TempestKeepBotanica = {
		ZoneName = "CT: El Invernáculo";
		Location = "El Cast. de la Tempestad, T.Abisal";
		Acronym = "Inver";
		ORNG.."Reputación: Los Sha'tar"; --Bien
		ORNG.."Llave: Llave forjada de distorsión (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Comandante Sarannis"; --Bien
		GREY.."2) Gran Botánico Freywinn"; --Bien
		GREY.."3) Thorngrin el Tierno"; --Bien
		GREY.."4) Laj"; --Bien
		GREY.."5) Disidente de distorsión"; --Bien
	};
	TempestKeepArcatraz = {
		ZoneName = "CT: El Arcatraz";
		Location = "El Cast. de la Tempestad, T.Abisal";
		Acronym = "Arca";
		ORNG.."Reputación: Los Sha'tar"; --Bien
		ORNG.."Llave: Llave de El Arcatraz"; --Bien
		ORNG.."Llave: Llave forjada de distorsión (Heróico)"; --Bien
		BLUE.."A) Entrada";
		GREY.."1) Zereketh el Desatado"; --Bien
		GREY.."2) Contenedor Arcano"; --Bien
		GREY..INDENT.."Guardián del Tercer Fragmento"; --Bien
		GREY.."3) Dalliah la Decidora del Destino"; --Bien
		GREY.."4) Arúspice de cólera Soccothrates"; --Bien
		GREY.."5) El profeta Udalo"; --Bien
		GREY.."6) Presagista Cieloriss"; --Bien
		GREY..INDENT.."Celador Mellichar"; --Bien
		GREY..INDENT.."Molino Tormenta de maná"; --Bien
	};
	TempestKeepMechanar = {
		ZoneName = "CT: El  Mechanar";
		Location = "El Cast. de la Tempestad, T.Abisal";
		Acronym = "Mech";
		ORNG.."Reputación: Los Sha'tar";
		ORNG.."Llave: Llave forjada de distorsión (Heróico)";
		BLUE.."A) Entrada";
		GREY.."1) Vigía de las puertas Giromata"; --Bien
		GREY.."2) Vigía de las puertas Manoyerro"; --Bien
		GREY..INDENT.."Alijo de la Legión"; --Bien
		GREY.."3) Lord-mecano Capacitus"; --Bien
		GREY..INDENT.."Célula de maná sobrecargada"; --Bien
		GREY.."4) Abisálica Sepethrea"; --Bien
		GREY.."5) Pathaleon el Calculator"; --Bien
		};
	TempestKeepTheEye = {
		ZoneName = "CT: Ojo de la Tormenta";
		Location = "El Cast. de la Tempestad, T.Abisal";
		Acronym = "Ojo";
		ORNG.."Reputación: Los Sha'tar";
		ORNG.."Llave: Llave de la Tempestad";
		BLUE.."A) Entrada";
		GREY.."1) Al'ar"; --Bien
		GREY.."2) Atracador del vacío"; --Bien
		GREY.."3) Gran astromántico Solarian"; --Bien
		GREY.."4) Kael'Thas Caminante del Sol"; --Bien
		GREY..INDENT.."Thaladred el Oscurecedor (Guerrero)"; --Bien
		GREY..INDENT.."Maestro Ingeriero Telonicus (Cazador)"; --Bien
		GREY..INDENT.."Gran Astromante Capernian (Mago)"; --Bien
		GREY..INDENT.."Lord Sanguinar (Paladín)"; --Bien
	};
	GruulsLair = {
		ZoneName = "Guarida de Gruul";
		Location = "Montañas Filospada";
		Acronym = "GG";
		BLUE.."A) Entrada";
		GREY.."1) Su majestad Maulgar"; --Bien
		GREY..INDENT.."Kiggler el Enloquecido (Chamán)"; --Bien
		GREY..INDENT.."Ciego el Vidente (Sacerdote)"; --Bien
		GREY..INDENT.."Olm el Invocador (Brujo)"; --Bien
		GREY..INDENT.."Krosh Manofuego (Mago)"; --Bien
		GREY.."2) Gruul el Asesino de Dragones"; --Bien
	};
	BlackTempleStart = {
		ZoneName = "El Templo Oscuro (Comienzo)"; --Bien
		Location = "Valle Sombraluna"; --Bien
		Acronym = "TO";
		ORNG.."Reputación: Juramorte Lengua de Ceniza"; --Bien
		ORNG.."Llave: Medallón de Karabor"; --Bien
		BLUE.."A) Entrada";
		BLUE.."B) Hacia Relicario de Almas"; --Bien
		BLUE.."C) Hacia Teron Sanguino"; --Bien
		BLUE.."D) Hacia Illidan Tempestira"; --Bien
		GREY.."1) Espíritu de Olum"; --Bien
		GREY.."2) Alto Señor de la Guerra Naj’entus"; --Bien
		GREY.."3) Supremus"; --Bien
		GREY.."4) Sombra de Akama"; --Bien
		GREY.."5) Espíritu de Udalo"; --Bien
		GREY..INDENT.."Aluyen (Vendedor de Componentes)"; --Bien
		GREY..INDENT.."Okuno <Provisiones Juramorte Lengua de ceniza>"; --Bien
		GREY..INDENT.."Profeta Kanai"; --Comprobar
	};
	BlackTempleBasement = {
		ZoneName = "El Templo Oscuro (Sótano)"; --Bien
		Location = "Valle Sombraluna"; --Bien
		Acronym = "TO";
		ORNG.."Reputación: Juramorte Lengua de Ceniza"; --Bien
		ORNG.."Llave: Medallón de Karabor"; --Bien
		BLUE.."B) Entrada";
		BLUE.."C) Entrada";
		GREY.."6) Gurtogg Sangre Hirviente"; --Bien
		GREY.."7) Relicario de Almas"; --Bien
		GREY..INDENT.."Esencia de Cólera"; -- Comprobar
		GREY..INDENT.."Esencia de Deseo"; --Bien
		GREY..INDENT.."Esencia de Sufrimiento"; -- Comprobar
		GREY.."8) Teron Sanguino"; --Bien
	};
	BlackTempleTop = {
		ZoneName = "El Templo Oscuro (Arriba)"; --Bien
		Location = "Valle Sombraluna"; --Bien
		Acronym = "TO";
		ORNG.."Reputación: Juramorte Lengua de Ceniza"; --Bien
		ORNG.."Llave: Medallón de Karabor"; --Bien
		BLUE.."D) Entrada";
		GREY.."9) Madre Shahraz"; --Bien
		GREY.."10) Concilio Illidari"; --Bien
		GREY..INDENT.."Lady Malande (Sacerdote)"; --Bien
		GREY..INDENT.."Gathios el Despedazador (Paladín)"; --Bien	
		GREY..INDENT.."Sumo abisálico Zerevor (Mago)"; --Bien
		GREY..INDENT.."Veras Sombra Oscura (Pícaro)"; --Bien
		GREY.."11) Illidan Tempestira"; --Bien
	};
	ZulAman = {
		ZoneName = "Zul'Aman";
		Location = "Tierras Fantasma"; --Bien
		Acronym = "ZA";
		BLUE.."A) Entrada"; --Bien
		BLUE..INDENT.."Harrison Jones"; --Bien
		GREY.."1) Nalorakk (Oso)"; --Bien
		GREY..INDENT.."Tanzar"; --Bien
		GREY..INDENT.."Mapa de Zul'Aman de Budd"; --Bien
		GREY.."2) Akil'zon (Águila)"; --Bien
		GREY..INDENT.."Harkor"; --Bien
		GREY.."3) Jan'alai (Dracohalcón)"; --Bien
		GREY..INDENT.."Kraz"; --Bien
		GREY.."4) Halazzi (Lince)"; --Bien
		GREY..INDENT.."Ashli"; --Bien
		GREY.."5) Zungam"; --Bien
		GREY.."6) Señor aojador Malacrass"; --Bien
		GREY..INDENT.."Thurg (Aleatorio)"; --Bien
		GREY..INDENT.."Gazakroth (Aleatorio)"; --Bien
		GREY..INDENT.."Lord Raadan (Aleatorio)"; --Bien
		GREY..INDENT.."Negrocorazón (Aleatorio)"; --Comprobar
		GREY..INDENT.."Alyson Antille (Aleatorio)"; --FALTA
		GREY..INDENT.."Slither (Aleatorio)"; --Comprobar
		GREY..INDENT.."Fenstalker (Aleatorio)"; --Comprobar
		GREY..INDENT.."Koragg (Aleatorio)"; --Comprobar
		GREY.."7) Zul'jin"; --Bien
		GREN.."1') Las ranas del bosque, se convierten en:";
		GREN..INDENT.."Kyren"; --Bien
		GREN..INDENT.."Gunter"; --Bien
		GREN..INDENT.."Adarrah"; --Bien
		GREN..INDENT.."Brennan"; --Bien
		GREN..INDENT.."Darwen"; --Bien
		GREN..INDENT.."Deez"; --Bien
		GREN..INDENT.."Galathryn"; --Bien
		GREN..INDENT.."Mitzi"; --Bien
		GREN..INDENT.."Mannuth"; --Bien
	};
	MagistersTerrace = {
		ZoneName = "Bancal del Magister"; --Bien
		Location = "Isla de Quel'Danas"; --Bien
		Acronym = "BM";
		BLUE.."A) Entrada";
		GREY.."1) Selin corazón de fuego"; --Comprobar
		GREY..INDENT.."Fel Crystals";
		GREY.."2) Tyrith"; --Comprobar
		GREY.."3) Vexallus"; --Bien
		GREY.."4) Orbe de visión"; --Comprobar
		GREY..INDENT.."Kalecgos"; --Bien
		GREY.."5) Sacerdotisa Delrissa (Abajo)"; --Bien
		GREY.."6) Kael’thas Caminante del Sol"; --Bien
	};
	SunwellPlateau = {
		ZoneName = "Meseta del pozo del Sol"; --Bien
		Location = "Isla de Quel'Danas"; --Bien
		Acronym = "MPS";
		BLUE.."A) Entrada"; 
		GREY.."1) Kalecgos"; --Bien
		GREY..INDENT.."Sathrovarr el Corruptor"; --Bien
		GREY.."2) Madrigosa"; --Bien
		GREY..INDENT.."Brutallus"; --FALTA
		GREY..INDENT.."Brumavil"; --Comprobar
		GREY.."3) Gemelas Eredar (Abajo)"; --Bien
		GREY..INDENT.."Grand Warlock Alythess (Arriba)"; --FALTA
		GREY..INDENT.."Lady Sacrolash (Arriba)"; --FALTA
		GREY..INDENT.."M'uru (Arriba)"; --Bien
		GREY..INDENT.."Entropius (Arriba)"; --FALTA
		GREY.."4) Kil'jaden"; --Bien
	};
};

end