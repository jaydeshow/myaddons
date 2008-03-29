--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2007 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------


if not DcrLoadedFiles or not DcrLoadedFiles["localization.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (localization.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end
-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date: 2008-02-17 17:07:32 -0500 (Sun, 17 Feb 2008) $", "$Revision: 61809 $");

local L = Dcr.L;
local LOC = Dcr.LOC;
L:RegisterTranslations("deDE", function() return {
    --start added in Rc4

    [LOC.CLASS_DRUID]	=	'Druide',
    [LOC.CLASS_HUNTER]	=	'Jäger',
    [LOC.CLASS_MAGE]	=	'Magier',
    [LOC.CLASS_PALADIN]	=	'Paladin',
    [LOC.CLASS_PRIEST]	=	'Priester',
    [LOC.CLASS_ROGUE]	=	'Schurke',
    [LOC.CLASS_SHAMAN]	=	'Schamane',
    [LOC.CLASS_WARLOCK]	=	'Hexenmeister',
    [LOC.CLASS_WARRIOR]	=	'Krieger',

    [LOC.STR_OTHER]	=	'Sonstige',
    [LOC.STR_OPTIONS]	=	'Einstellungen',
    [LOC.STR_CLOSE]	=	'Schließen',
    [LOC.STR_DCR_PRIO]	=	'Decursive Prioritätenliste',
    [LOC.STR_DCR_SKIP]	=	'Decursive Ignorierliste',
    [LOC.STR_QUICK_POP]	=	'Schnellbestücken',
    [LOC.STR_POP]	=	'Bestückungsliste',
    [LOC.STR_GROUP]	=	'Gruppe ',




    [LOC.PRIORITY_SHOW]	=	'P',
    [LOC.POPULATE]	=	'P',
    [LOC.SKIP_SHOW]	=	'S',
    [LOC.CLEAR_PRIO]	=	'C',
    [LOC.CLEAR_SKIP]	=	'C',





    [LOC.PET_FEL_CAST]	=	"Magie verschlingen",
    [LOC.PET_DOOM_CAST]	=	"Magiebannung",

    [LOC.SPELL_POLYMORPH]		  = "Verwandlung", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_DISEASE]	=	'Krankheit heilen', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_DISEASE]	=	'Krankheit aufheben', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURIFY]	=	'Läutern', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CLEANSE]	=	'Reinigung des Glaubens', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_DISPELL_MAGIC]	=	'Magiebannung', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_POISON]	=	'Vergiftung heilen', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_POISON]	=	'Vergiftung aufheben', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_LESSER_CURSE]	=	'Geringen Fluch aufheben', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_CURSE]	=	'Fluch aufheben', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURGE]	=	'Reinigen', -- This translation is for reference only the one used is from the library BabbleSpell

    [BINDING_NAME_DCRSHOW]	=	"Zeige/Verstecke Decursive Main Bar",
    
    [BINDING_NAME_DCRMUFSHOWHIDE] =	BINDING_NAME_DCRMUFSHOWHIDE,

    [BINDING_NAME_DCRPRADD]	=	"Ziel zur Prioritätenliste hinzufügen",
    [BINDING_NAME_DCRPRCLEAR]	=	"Prioritätenliste leeren",
    [BINDING_NAME_DCRPRLIST]	=	"Prioritätenliste ausgeben",
    [BINDING_NAME_DCRPRSHOW]	=	"Zeige/Verstecke die Prioritätenliste UI",

    [BINDING_NAME_DCRSKADD]	=	"Ziel zur Ignorierliste hinzufügen",
    [BINDING_NAME_DCRSKCLEAR]	=	"Ignorierliste leeren",
    [BINDING_NAME_DCRSKLIST]	=	"Ignorierliste ausgeben",
    [BINDING_NAME_DCRSKSHOW]	=	"Zeige/Verstecke die Ignorierliste UI",


    [LOC.PRIORITY_LIST]	=	"Decursive Prioritätenliste",
    [LOC.SKIP_LIST_STR]	=	"Decursive Ignorierliste",
    [LOC.OPTION_MENU]	=	"Decursive Einstellungen",
    [LOC.POPULATE_LIST]	=	"Schnellbestücken der Decursive Liste",
    [LOC.LIST_ENTRY_ACTIONS]	=	LOC.LIST_ENTRY_ACTIONS,
    [LOC.HIDE_MAIN]	=	"Verstecke Decursive Fenster",
    [LOC.TIE_LIVELIST]    = LOC.TIE_LIVELIST,
    [LOC.SHOW_MSG]	=	"Um das Decursive Fenster anzuzeigen, /dcrshow eingeben",
    [LOC.IS_HERE_MSG]	=	"Decursive wurde geladen, kontrolliere bitte die Einstellungen",

    [LOC.PRINT_CHATFRAME]	=	"Nachrichten im Chat ausgeben",
    [LOC.PRINT_CUSTOM]	=	"Nachrichten in Bildschirmmitte ausgeben",
    [LOC.PRINT_ERRORS]	=	"Fehlernachrichten ausgeben",

    [LOC.SHOW_TOOLTIP]	=	"Zeige Tooltips in der Betroffenenliste",
    [LOC.REVERSE_LIVELIST]	=	"Zeige die Live-Liste umgekehrt",
    [LOC.HIDE_LIVELIST]	=	"Verstecke die Live-Liste",

    [LOC.AMOUNT_AFFLIC]	=	"Zeige Anzahl der Betroffenen: ",
    [LOC.BLACK_LENGTH]	=	"Sekunden auf der Blacklist: ",
    [LOC.SCAN_LENGTH]	=	"Sekunden zwischen Live-Scans: ",
    [LOC.ABOLISH_CHECK]	=	"Zuvor überprüfen ob Reinigung nötig",
    [LOC.RANDOM_ORDER]	=	"Reinige in zufälliger Reihenfolge",
    [LOC.CURE_PETS]	=	"Scanne und reinige Pets",
    [LOC.IGNORE_STEALTH]	=	"Ignoriere getarnte Einheiten",
    [LOC.PLAY_SOUND]	=	"Akustische Warnung falls Reinigung nötig",
    [LOC.ANCHOR]	=	"Decursive Textfenster",
    [LOC.DONOT_BL_PRIO]	=	"Keine Namen der Prioritätenliste bannen",


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [LOC.SPELL_FOUND]	=	"Zauber %s gefunden!",


    -- spells and potions
    [LOC.DREAMLESSSLEEP]	= "Traumloser Schlaf",
    [LOC.GDREAMLESSSLEEP]	= "Großer Trank des traumlosen Schlafs",
    [LOC.MDREAMLESSSLEEP]	= LOC.MDREAMLESSSLEEP,
    [LOC.ANCIENTHYSTERIA]	= "Uralte Hysterie",
    [LOC.IGNITE]		= "Mana entzünden",
    [LOC.TAINTEDMIND]	= "Verdorbene Gedanken",
    [LOC.MAGMASHAKLES]	= "Magma Fesseln",
    [LOC.CRIPLES]		= "Verkrüppeln",
    [LOC.DUSTCLOUD]		= "Staubwolke",
    [LOC.WIDOWSEMBRACE]	= "Umarmung der Witwe",
    [LOC.CURSEOFTONGUES]	= "Fluch der Sprachen",  -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SONICBURST]	= "Schallexplosion",
    [LOC.THUNDERCLAP]	= "Donnerknall",
    [LOC.DELUSIONOFJINDO]	= "Fluch der Schatten",


    [LOC.DISEASE] = 'Krankheit',
    [LOC.MAGIC]  = 'Magie',
    [LOC.POISON]  = 'Gift',
    [LOC.CURSE]  = 'Fluch',
    [LOC.MAGICCHARMED] = LOC.MAGICCHARMED,
    [LOC.CHARMED] = LOC.CHARMED,

    [LOC.MUTATINGINJECTION] = LOC.MUTATINGINJECTION,
    [LOC.DEFAULT_MACROKEY] = "NONE", -- Ideally the key just beneath the "escape" key. Leave to "NONE" (do not translate) if you don't set a real key name.
    [LOC.OPT_LIVELIST] = LOC.OPT_LIVELIST,
    [LOC.OPT_LIVELIST_DESC] = LOC.OPT_LIVELIST_DESC,
    [LOC.OPT_HIDELIVELIST_DESC] = LOC.OPT_HIDELIVELIST_DESC,
    [LOC.OPT_SHOWTOOLTIP_DESC] = LOC.OPT_SHOWTOOLTIP_DESC,
    [LOC.OPT_PLAYSOUND_DESC] = LOC.OPT_PLAYSOUND_DESC,
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = LOC.OPT_AMOUNT_AFFLIC_DESC,
    [LOC.OPT_BLACKLENTGH_DESC] = LOC.OPT_BLACKLENTGH_DESC,
    [LOC.OPT_SCANLENGTH_DESC] = LOC.OPT_SCANLENGTH_DESC,
    [LOC.OPT_REVERSE_LIVELIST_DESC] = LOC.OPT_REVERSE_LIVELIST_DESC,
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = LOC.OPT_CREATE_VIRTUAL_DEBUFF,
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC,
    [LOC.OPT_TIE_LIVELIST_DESC] = LOC.OPT_TIE_LIVELIST_DESC,
    [LOC.OPT_MESSAGES] = LOC.OPT_MESSAGES,
    [LOC.OPT_MESSAGES_DESC] = LOC.OPT_MESSAGES_DESC,
    [LOC.OPT_CHATFRAME_DESC] = LOC.OPT_CHATFRAME_DESC,
    [LOC.OPT_PRINT_CUSTOM_DESC] = LOC.OPT_PRINT_CUSTOM_DESC,
    [LOC.OPT_PRINT_ERRORS_DESC] = LOC.OPT_PRINT_ERRORS_DESC,
    [LOC.OPT_ANCHOR_DESC] = LOC.OPT_ANCHOR_DESC,
    [LOC.OPT_MFSETTINGS] = LOC.OPT_MFSETTINGS,
    [LOC.OPT_MFSETTINGS_DESC] = LOC.OPT_MFSETTINGS_DESC,
    [LOC.OPT_DISPLAYOPTIONS] = LOC.OPT_DISPLAYOPTIONS,
    [LOC.OPT_SHOWMFS] = LOC.OPT_SHOWMFS,
    [LOC.OPT_SHOWMFS_DESC] = LOC.OPT_SHOWMFS_DESC,
    [LOC.OPT_GROWDIRECTION] = LOC.OPT_GROWDIRECTION,
    [LOC.OPT_GROWDIRECTION_DESC] = LOC.OPT_GROWDIRECTION_DESC,

    [LOC.OPT_STICKTORIGHT]	= LOC.OPT_STICKTORIGHT,
    [LOC.OPT_STICKTORIGHT_DESC]	= LOC.OPT_STICKTORIGHT_DESC,
    [LOC.OPT_MUFSCOLORS]	= LOC.OPT_MUFSCOLORS,
    [LOC.OPT_MUFSCOLORS_DESC]	= LOC.OPT_MUFSCOLORS_DESC,
    [LOC.MISSINGUNIT]		= LOC.MISSINGUNIT,
    [LOC.COLORALERT]		= LOC.COLORALERT,
    [LOC.COLORSTATUS]		= LOC.COLORSTATUS,

    [LOC.OPT_AUTOHIDEMFS]	    = LOC.OPT_AUTOHIDEMFS,
    [LOC.OPT_AUTOHIDEMFS_DESC]	    = LOC.OPT_AUTOHIDEMFS_DESC,
    [LOC.OPT_HIDEMFS_SOLO]	    = LOC.OPT_HIDEMFS_SOLO,
    [LOC.OPT_HIDEMFS_SOLO_DESC]	    = LOC.OPT_HIDEMFS_SOLO_DESC,
    [LOC.OPT_HIDEMFS_GROUP]	    = LOC.OPT_HIDEMFS_GROUP,
    [LOC.OPT_HIDEMFS_GROUP_DESC]    = LOC.OPT_HIDEMFS_GROUP_DESC,
    [LOC.OPT_HIDEMFS_NEVER]	    = LOC.OPT_HIDEMFS_NEVER,
    [LOC.OPT_HIDEMFS_NEVER_DESC]    = LOC.OPT_HIDEMFS_NEVER_DESC,

    [LOC.OPT_ADDDEBUFFFHIST]		= LOC.OPT_ADDDEBUFFFHIST,
    [LOC.OPT_ADDDEBUFFFHIST_DESC]	= LOC.OPT_ADDDEBUFFFHIST_DESC,

    [LOC.OPT_SHOWBORDER] =  LOC.OPT_SHOWBORDER,
    [LOC.OPT_SHOWBORDER_DESC] =  LOC.OPT_SHOWBORDER_DESC,
    [LOC.OPT_MAXMFS] = LOC.OPT_MAXMFS,
    [LOC.OPT_MAXMFS_DESC] = LOC.OPT_MAXMFS_DESC,
    [LOC.OPT_UNITPERLINES] = LOC.OPT_UNITPERLINES,
    [LOC.OPT_UNITPERLINES_DESC] = LOC.OPT_UNITPERLINES_DESC,
    [LOC.OPT_MFSCALE] = LOC.OPT_MFSCALE,
    [LOC.OPT_MFSCALE_DESC] = LOC.OPT_MFSCALE_DESC,
    [LOC.OPT_LLSCALE] = LOC.OPT_LLSCALE,
    [LOC.OPT_LLSCALE_DESC] = LOC.OPT_LLSCALE_DESC,
    [LOC.OPT_SHOWHELP] = LOC.OPT_SHOWHELP,
    [LOC.OPT_SHOWHELP_DESC] = LOC.OPT_SHOWHELP_DESC,
    [LOC.OPT_MFPERFOPT] = LOC.OPT_MFPERFOPT,
    [LOC.OPT_MFREFRESHRATE] = LOC.OPT_MFREFRESHRATE,
    [LOC.OPT_MFREFRESHRATE_DESC] = LOC.OPT_MFREFRESHRATE_DESC,
    [LOC.OPT_MFREFRESHSPEED] = LOC.OPT_MFREFRESHSPEED,
    [LOC.OPT_MFREFRESHSPEED_DESC] = LOC.OPT_MFREFRESHSPEED_DESC,
    [LOC.OPT_CURINGOPTIONS] = LOC.OPT_CURINGOPTIONS,
    [LOC.OPT_CURINGOPTIONS_DESC] = LOC.OPT_CURINGOPTIONS_DESC,
    [LOC.OPT_ABOLISHCHECK_DESC] = LOC.OPT_ABOLISHCHECK_DESC,
    [LOC.OPT_DONOTBLPRIO_DESC] = LOC.OPT_DONOTBLPRIO_DESC,
    [LOC.OPT_RANDOMORDER_DESC] = LOC.OPT_RANDOMORDER_DESC,
    [LOC.OPT_CUREPETS_DESC] = LOC.OPT_CUREPETS_DESC,
    [LOC.OPT_IGNORESTEALTHED_DESC] = LOC.OPT_IGNORESTEALTHED_DESC,
    [LOC.OPT_CURINGORDEROPTIONS] = LOC.OPT_CURINGORDEROPTIONS,
    [LOC.OPT_MAGICCHECK_DESC] = LOC.OPT_MAGICCHECK_DESC,
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = LOC.OPT_MAGICCHARMEDCHECK_DESC,
    [LOC.OPT_CHARMEDCHECK_DESC] = LOC.OPT_CHARMEDCHECK_DESC,
    [LOC.OPT_POISONCHECK_DESC] = LOC.OPT_POISONCHECK_DESC,
    [LOC.OPT_DISEASECHECK_DESC] = LOC.OPT_DISEASECHECK_DESC,
    [LOC.OPT_CURSECHECK_DESC] = LOC.OPT_CURSECHECK_DESC,
    [LOC.OPT_DEBUFFFILTER] = LOC.OPT_DEBUFFFILTER,
    [LOC.OPT_DEBUFFFILTER_DESC] = LOC.OPT_DEBUFFFILTER_DESC,
    [LOC.OPT_MACROOPTIONS] = LOC.OPT_MACROOPTIONS,
    [LOC.OPT_MACROOPTIONS_DESC] = LOC.OPT_MACROOPTIONS_DESC,
    [LOC.OPT_MACROBIND] = LOC.OPT_MACROBIND,
    [LOC.OPT_MACROBIND_DESC] = LOC.OPT_MACROBIND_DESC,
    [LOC.OPT_RESETOPTIONS] = LOC.OPT_RESETOPTIONS,
    [LOC.OPT_RESETOPTIONS_DESC] = LOC.OPT_RESETOPTIONS_DESC,
    [LOC.OPT_REMOVESKDEBCONF] = LOC.OPT_REMOVESKDEBCONF,
    [LOC.OPT_RESTPROFILECONF] = LOC.OPT_RESTPROFILECONF,
    [LOC.OPT_PROFILERESET] = LOC.OPT_PROFILERESET,
    [LOC.OPT_AFFLICTEDBYSKIPPED] = LOC.OPT_AFFLICTEDBYSKIPPED,
    [LOC.OPT_DEBCHECKEDBYDEF] = LOC.OPT_DEBCHECKEDBYDEF,
    [LOC.OPT_REMOVETHISDEBUFF] = LOC.OPT_REMOVETHISDEBUFF,
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = LOC.OPT_REMOVETHISDEBUFF_DESC,
    [LOC.OPT_RESETDEBUFF] = LOC.OPT_RESETDEBUFF,
    [LOC.OPT_RESETDTDCRDEFAULT] = LOC.OPT_RESETDTDCRDEFAULT,
    [LOC.OPT_USERDEBUFF] = LOC.OPT_USERDEBUFF,
    [LOC.OPT_DEBUFFENTRY_DESC] = LOC.OPT_DEBUFFENTRY_DESC,
    [LOC.OPT_ADDDEBUFF] = LOC.OPT_ADDDEBUFF,
    [LOC.OPT_ADDDEBUFF_DESC] = LOC.OPT_ADDDEBUFF_DESC,
    [LOC.OPT_ADDDEBUFF_USAGE] = LOC.OPT_ADDDEBUFF_USAGE,
    [LOC.OPT_READDDEFAULTSD] = LOC.OPT_READDDEFAULTSD,
    [LOC.OPT_READDDEFAULTSD_DESC1] = LOC.OPT_READDDEFAULTSD_DESC1,
    [LOC.OPT_READDDEFAULTSD_DESC2] = LOC.OPT_READDDEFAULTSD_DESC2,

    [LOC.OPT_LVONLYINRANGE] = LOC.OPT_LVONLYINRANGE,
    [LOC.OPT_LVONLYINRANGE_DESC] = LOC.OPT_LVONLYINRANGE_DESC,

    [LOC.OPT_MFALPHA] = OPT_MFALPHA,
    [LOC.OPT_MFALPHA_DESC] = OPT_MFALPHA_DESC,
    
    [LOC.OPT_LLALPHA] = LOC.OPT_LLALPHA,
    [LOC.OPT_LLALPHA_DESC] = LOC.OPT_LLALPHA_DESC,

    [LOC.OPT_ADVDISP] = LOC.OPT_ADVDISP,
    [LOC.OPT_ADVDISP_DESC] = LOC.OPT_ADVDISP_DESC,
    [LOC.OPT_TIECENTERANDBORDER] = LOC.OPT_TIECENTERANDBORDER,
    [LOC.OPT_TIECENTERANDBORDER_OPT] = LOC.OPT_TIECENTERANDBORDER_OPT,
    [LOC.OPT_BORDERTRANSP] = LOC.OPT_BORDERTRANSP,
    [LOC.OPT_BORDERTRANSP_DESC] = LOC.OPT_BORDERTRANSP_DESC,
    [LOC.OPT_CENTERTRANSP] = LOC.OPT_CENTERTRANSP,
    [LOC.OPT_CENTERTRANSP_DESC] = LOC.OPT_CENTERTRANSP_DESC,
    [LOC.OPT_TIEXYSPACING] = LOC.OPT_TIEXYSPACING,
    [LOC.OPT_TIEXYSPACING_DESC] = LOC.OPT_TIEXYSPACING_DESC,
    [LOC.OPT_XSPACING] = LOC.OPT_XSPACING,
    [LOC.OPT_XSPACING_DESC] = LOC.OPT_XSPACING_DESC,
    [LOC.OPT_YSPACING] = LOC.OPT_YSPACING,
    [LOC.OPT_YSPACING_DESC] = LOC.OPT_YSPACING_DESC,


    [LOC.HLP_LL_ONCLICK_TEXT] = LOC.HLP_LL_ONCLICK_TEXT,
    [LOC.HLP_LEFTCLICK] = LOC.HLP_LEFTCLICK,
    [LOC.HLP_RIGHTCLICK] = LOC.HLP_RIGHTCLICK,
    [LOC.HLP_MIDDLECLICK] = LOC.HLP_MIDDLECLICK,

    [LOC.HLP_NOTHINGTOCURE] = LOC.HLP_NOTHINGTOCURE,
    [LOC.HLP_WRONGMBUTTON] = LOC.HLP_WRONGMBUTTON,
    [LOC.HLP_USEXBUTTONTOCURE] = LOC.HLP_USEXBUTTONTOCURE,

    [LOC.CTRL] = LOC.CTRL,
    [LOC.ALT] = LOC.ALT,
    [LOC.SHIFT] = LOC.SHIFT,

    [LOC.TARGETUNIT] = LOC.TARGETUNIT,
    [LOC.FOCUSUNIT]  = LOC.FOCUSUNIT,

    [LOC.ABSENT] = LOC.ABSENT,
    [LOC.TOOFAR] = LOC.TOOFAR,
    [LOC.NORMAL] = LOC.NORMAL,
    [LOC.STEALTHED] = LOC.STEALTHED,
    [LOC.BLACKLISTED] = LOC.BLACKLISTED,
    [LOC.UNITSTATUS] = LOC.UNITSTATUS,
    [LOC.AFFLICTEDBY] = LOC.AFFLICTEDBY,
    
    [LOC.SUCCESSCAST] = LOC.SUCCESSCAST,
    
    [LOC.HANDLEHELP] = LOC.HANDLEHELP,

    [LOC.MACROKEYALREADYMAPPED] = LOC.MACROKEYALREADYMAPPED,
    [LOC.MACROKEYMAPPINGSUCCESS] = LOC.MACROKEYMAPPINGSUCCESS,
    [LOC.MACROKEYMAPPINGFAILED] = LOC.MACROKEYMAPPINGFAILED,
    [LOC.MACROKEYNOTMAPPED] = LOC.MACROKEYNOTMAPPED,

    [LOC.OPT_NOKEYWARN] = LOC.OPT_NOKEYWARN,
    [LOC.OPT_NOKEYWARN_DESC] = LOC.OPT_NOKEYWARN_DESC,
    [LOC.NOSPELL] = LOC.NOSPELL,
    
    [LOC.FUBARMENU]  = LOC.FUBARMENU,
    [LOC.FUBARMENU_DESC]  = LOC.FUBARMENU_DESC,


} end);

DcrLoadedFiles["localization.de.lua"] = true;
