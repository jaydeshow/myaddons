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

Dcr:SetDateAndRevision("$Date: 2008-04-22 17:44:42 -0400 (Tue, 22 Apr 2008) $", "$Revision: 70967 $");

-- Acelocal register for esES // {{{
local L = Dcr.L;
local LOC = Dcr.LOC;
L:RegisterTranslations("esES", function() return {

    [LOC.DISEASE]	=	'Enfermedad',
    [LOC.MAGIC]	=	'Magia',
    [LOC.POISON]	=	'Veneno',
    [LOC.CURSE]	=	'Maldición',
    [LOC.MAGICCHARMED]=	LOC.MAGICCHARMED,
    [LOC.CHARMED]	  =	LOC.CHARMED,

    -------------------------------------------------------------------------------
    -- English localization (Default)
    -------------------------------------------------------------------------------

    --start added in Rc4

    [LOC.CLASS_DRUID]	=	'Druida',
    [LOC.CLASS_HUNTER]	=	'Cazador',
    [LOC.CLASS_MAGE]	=	'Mago',
    [LOC.CLASS_PALADIN]	=	'Paladín',
    [LOC.CLASS_PRIEST]	=	'Sacerdote',
    [LOC.CLASS_ROGUE]	=	'Pícaro',
    [LOC.CLASS_SHAMAN]	=	'Chamán',
    [LOC.CLASS_WARLOCK]	=	'Brujo',
    [LOC.CLASS_WARRIOR]	=	'Guerrero',

    [LOC.STR_OTHER]		=	'Otro',
    [LOC.STR_OPTIONS]	=	'Opciones',
    [LOC.STR_CLOSE]		=	'Cerrar',
    [LOC.STR_DCR_PRIO]	=	'Prioridad decursive',
    [LOC.STR_DCR_SKIP]	=	'No decursear',
    [LOC.STR_QUICK_POP]	=	LOC.STR_QUICK_POP,
    [LOC.STR_POP]		=	LOC.STR_POP,
    [LOC.STR_GROUP]		=	LOC.STR_GROUP,




    [LOC.PRIORITY_SHOW]	=	LOC.PRIORITY_SHOW,
    [LOC.POPULATE]		=	LOC.POPULATE,
    [LOC.SKIP_SHOW]		=	LOC.SKIP_SHOW,
    [LOC.CLEAR_PRIO]	=	LOC.CLEAR_PRIO,
    [LOC.CLEAR_SKIP]	=	LOC.CLEAR_SKIP,

    [LOC.PET_FEL_CAST]	=	"Devorar magia",
    [LOC.PET_DOOM_CAST]	=	"Disipar magia",

    [BINDING_NAME_DCRSHOW]	=	BINDING_NAME_DCRSHOW,

    [BINDING_NAME_DCRPRADD]	=	BINDING_NAME_DCRPRADD,
    [BINDING_NAME_DCRPRCLEAR]	=	BINDING_NAME_DCRPRCLEAR,
    [BINDING_NAME_DCRPRLIST]	=	BINDING_NAME_DCRPRLIST,
    [BINDING_NAME_DCRPRSHOW]	=	BINDING_NAME_DCRPRSHOW,

    [BINDING_NAME_DCRSKADD]	=	BINDING_NAME_DCRSKADD,
    [BINDING_NAME_DCRSKCLEAR]	=	BINDING_NAME_DCRSKCLEAR,
    [BINDING_NAME_DCRSKLIST]	=	BINDING_NAME_DCRSKLIST,
    [BINDING_NAME_DCRSKSHOW]	=	BINDING_NAME_DCRSKSHOW,



    [LOC.PRIORITY_LIST]	    =	LOC.PRIORITY_LIST,
    [LOC.SKIP_LIST_STR]	    =	LOC.SKIP_LIST_STR,
    [LOC.OPTION_MENU]	    =	LOC.OPTION_MENU,
    [LOC.POPULATE_LIST]	    =	LOC.POPULATE_LIST,
    [LOC.LIST_ENTRY_ACTIONS]    =	LOC.LIST_ENTRY_ACTIONS,
    [LOC.HIDE_MAIN]		    =	LOC.HIDE_MAIN,
    [LOC.SHOW_MSG]		    =	LOC.SHOW_MSG,
    [LOC.IS_HERE_MSG]	    =	LOC.IS_HERE_MSG,

    [LOC.PRINT_CHATFRAME]	=	LOC.PRINT_CHATFRAME,
    [LOC.PRINT_CUSTOM]	=	LOC.PRINT_CUSTOM,
    [LOC.PRINT_ERRORS]	=	LOC.PRINT_ERRORS,

    [LOC.SHOW_TOOLTIP]	=	LOC.SHOW_TOOLTIP,
    [LOC.REVERSE_LIVELIST]	=	LOC.REVERSE_LIVELIST,
    [LOC.TIE_LIVELIST]	=	LOC.TIE_LIVELIST,
    [LOC.HIDE_LIVELIST]	=	LOC.HIDE_LIVELIST,

    [LOC.AMOUNT_AFFLIC]	=	LOC.AMOUNT_AFFLIC,
    [LOC.BLACK_LENGTH]	=	LOC.BLACK_LENGTH,
    [LOC.SCAN_LENGTH]	=	LOC.SCAN_LENGTH,
    [LOC.ABOLISH_CHECK]	=	LOC.ABOLISH_CHECK,
    [LOC.RANDOM_ORDER]	=	LOC.RANDOM_ORDER,
    [LOC.CURE_PETS]		=	LOC.CURE_PETS,
    [LOC.IGNORE_STEALTH]	=	LOC.IGNORE_STEALTH,
    [LOC.PLAY_SOUND]	=	LOC.PLAY_SOUND,
    [LOC.ANCHOR]		=	LOC.ANCHOR,
    [LOC.DONOT_BL_PRIO]	=	LOC.DONOT_BL_PRIO,

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [LOC.SPELL_FOUND]	=	LOC.SPELL_FOUND,

    
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

    [LOC.OPT_STICKTORIGHT]	= LOC.OPT_STICKTORIGHT,
    [LOC.OPT_STICKTORIGHT_DESC]	= LOC.OPT_STICKTORIGHT_DESC,
    [LOC.OPT_MUFSCOLORS]	= LOC.OPT_MUFSCOLORS,
    [LOC.OPT_MUFSCOLORS_DESC]	= LOC.OPT_MUFSCOLORS_DESC,
    [LOC.MISSINGUNIT]		= LOC.MISSINGUNIT,
    [LOC.COLORALERT]		= LOC.COLORALERT,
    [LOC.COLORSTATUS]		= LOC.COLORSTATUS,
    [LOC.COLORCHRONOS]		= LOC.COLORCHRONOS,
    [LOC.COLORCHRONOS_DESC]	= LOC.COLORCHRONOS_DESC,

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

    [LOC.OPT_GROWDIRECTION_DESC] = LOC.OPT_GROWDIRECTION_DESC,
    [LOC.OPT_SHOWBORDER] =  LOC.OPT_SHOWBORDER,
    [LOC.OPT_SHOWBORDER_DESC] =  LOC.OPT_SHOWBORDER_DESC,
    [LOC.OPT_SHOWCHRONO] = LOC.OPT_SHOWCHRONO,
    [LOC.OPT_SHOWCHRONO_DESC] = LOC.OPT_SHOWCHRONO_DESC,
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

-- // }}}

DcrLoadedFiles["localization.es.lua"] = true;
