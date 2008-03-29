-- Forte Class Addon v0.984 by Xus 23-03-2008 for Patch 2.3.x

--[[
"frFR": French
"deDE": German
"esES": Spanish
"enUS": American english
"enGB": British english

!! Make sure to keep this saved as UTF-8 format !!

]]

--[[>> still needs translating]]

-- FR 2 missing
if GetLocale() == "frFR" then
	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^Vous utilisez %s, mais"; -- "Vous utilisez Z, mais X résiste."
	FW.L.WAS_EVADED = " évité %s%%.$"; -- "X évite Z."
	FW.L.FAILED_IMMUNE = "^Votre %s rate" -- "Votre Z rate. X y est insensible."
	FW.L.IS_REFLECTED = "^Votre %s est renvoyé"; --"Votre Z est renvoyé par X."

--[[>>]]FW.L.DOT_HIT = "^(.+) suffers .+ damage from your (.+)%.";
--[[>>]]FW.L.DOT_ABSORB = "^Your (.+) is absorbed by (.+)%.";
	FW.L.DIES = " a succombé%."; -- "X a succombé."

	--spell book
	FW.L.RANK = "Rang";
	FW.L.SPELL_RANK = "^Rang (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "Rituel des âmes";

	--items
	FW.L.MINOR_SS = "Pierre d'âme mineure";
	FW.L.LESSER_SS = "Pierre d'âme inférieure";
	FW.L.NORMAL_SS = "Pierre d'âme";
	FW.L.GREATER_SS = "Pierre d'âme supérieure";
	FW.L.MAJOR_SS = "Pierre d'âme majeure";
	FW.L.MASTER_SS = "Pierre d'âme magistrale";

	FW.L.MASTER_HS = "Pierre de soins magistrale";
	FW.L.MAJOR_HS = "Pierre de soins majeure";
	FW.L.GREATER_HS = "Pierre de soins supérieure";
	FW.L.NORMAL_HS = "Pierre de soins";
	FW.L.LESSER_HS = "Pierre de soins inférieure";
	FW.L.MINOR_HS = "Pierre de soins mineure";

	--zones
	FW.L.COILFANG_RESERVOIR = "Caverne du sanctuaire du Serpent";

	--units
	FW.L.HELLFIRE_CHANNELER = "Canaliste des Flammes infernales"
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "Grand astromancien Capernian";
	FW.L.LORD_SANGUINAR = "Seigneur Sanguinar"
	FW.L.MASTER_ENGINEER_TELONICUS = "Maître ingénieur Telonicus";
	FW.L.THALADRED_THE_DARKENER = "Thaladred l'Assombrisseur";
	FW.L.FATHOM_GUARD_SHARKKIS = "Garde-fonds Squallis";
	FW.L.FATHOM_GUARD_CARIBDIS = "Garde-fonds Caribdis";
	FW.L.FATHOM_GUARD_TIDALVESS = "Garde-fonds Marevess";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "Update Now";
FW.L.LAST_CHECK = "\n\nLast check: %d seconds ago.";
FW.L.SCROLL_TO_ = "Scroll to ";

FW.L.POTION = "Potion";
FW.L.POWERUP = "Powerup";
FW.L.ITEM = "Item";
FW.L.PET = "Pet";
FW.L.SPELL = "Spell";
FW.L.HEALTHSTONE_NORMAL = "Healthstone";
FW.L.SOULWELL = "Soulwell";

-- commonly used
FW.L.USE_ = "Use %s";
FW.L.CREATE_ = "Create %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "Left Click to create %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "Right Click to use %s.";

FW.L.MASTER = "Master";
FW.L.MAJOR = "Major";
FW.L.GREATER = "Greater";
FW.L.NORMAL = "Normal";
FW.L.LESSER = "Lesser";
FW.L.MINOR = "Minor";

FW.L.YELLOW_STAR = "<Yellow Star>";
FW.L.ORANGE_CIRCLE = "<Orange Circle>";
FW.L.PRUPLE_DIAMOND = "<Purple Diamond>";
FW.L.GREEN_TRIANGLE = "<Green Triangle>";
FW.L.MOON = "<Moon>";
FW.L.BLUE_SQUARE = "<Blue Square>";
FW.L.CROSS = "<Cross>";
FW.L.SKULL = "<Skull>";

FW.L.FILTER_NONE = "normal";
FW.L.FILTER_IGNORE = "|cffff0000ignore|r";
FW.L.FILTER_COLOR = "|cff00ff00color|r";

FW.L.MODULE_NONE = "|cffff0000None|r";

FW.L.NOTARGET = "<No Target>";
FW.L.UNKNOWN = "<Unknown>";
FW.L.NOBODY = "<Nobody>"

FW.L.ENABLE  = "Enable";
FW.L.LOCK = "Lock (disable option functions)";
FW.L.EXPAND_UP = "Expand up";
FW.L.EXPAND_UP_TT = "Determines if the bar lists should be expanded upwards or downwards.";
FW.L.BAR_SPACING = "Bar spacing"
FW.L.COMBAT_HINT = "Some sizing changes you make here will only apply outside of combat.";
FW.L.ORA_HINT = "For people without ForteWarlock but with oRA, someone with FW has to be promoted.";

FW.L.DEAD = "Dead";
FW.L.OFFLINE = "Offline";
FW.L.CASTING = "Casting";
FW.L.CUSTOMIZE = "Customize";
FW.L.GENERAL = "General Options";
FW.L.ADVANCED = "Advanced Options";
FW.L.BASIC = "Basics";
FW.L.SPECIFIC = "Specifics";
FW.L.CORE = "Core";
FW.L.COLORING_FILTERING = "Coloring/Filtering";
FW.L.APPEARANCE = "Appearance";
FW.L.SIZING = "Sizing";
FW.L.SCALE = "Scale";
FW.L.BAR_HEIGHT = "Bar height";
FW.L.BAR_WIDTH = "Bar width";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "Frame Background";
FW.L.BAR_TEXT = "Bar text";
FW.L.BAR_FONT = "Bar Font";
FW.L.BAR_TEXTURE = "Bar Texture";
FW.L.BAR_COLORING = "Bar Coloring";
FW.L.AUTO_HIDE = "Auto-hide outside party/raid";
FW.L.AUTO_HIDE_TT = "This will automatically hide the frame when not in a party or raid.";
FW.L.AUTO_MINIMIZE = "Auto-minimize outside party/raid";
FW.L.AUTO_MINIMIZE_TT = "This will automatically hide the bars when not in a party or raid.";
FW.L.SHOW_BARS = "Show bars";
FW.L.SHOW_BARS_TT = "Show the bars. You can hide them in case you only want to see the information on the header.";
FW.L.MAX_SHOWN = "Maximum shown";

FW.L.SELF_MESSAGES = "Self Messages";
FW.L.SELF_MESSAGES_HINT1 = "This allows you to display usefull messages to yourself. They are shown in your 'default' chat frame."
FW.L.RAID_MESSAGES = "Party/Raid Messages";
FW.L.RAID_MESSAGES_HINT1 = "This allows you to display messages to others based on spells you cast.";
FW.L.RAID_MESSAGES_HINT2 = "You can disable all messages to party/raid and/or channel, or every message separately.";
FW.L.SHOW_IN_RAID = "Show in party/raid (1st checkboxes)";
FW.L.SHOW_IN_RAID_TT = "Uncheck to stop any messages from being shown in your raid or party.";
FW.L.SHOW_IN_CHANNEL = "Show in channel (2nd checkboxes)";
FW.L.SHOW_IN_CHANNEL_TT = "Set the channel name or number in which you want some of your messages to be displayed. 'say' is also valid. Uncheck to stop any messages being shown in the channel.";

-- standard usage tips to append
FW.L.USE_FILTER = "First type in the item or spell that you want to change (auto-fills). Then you can select if you want to show it normally (normal), hide it (ignore) or change its color (color). If you selected you want to change the color, you get a color picker from clicking square on the right.";
FW.L.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency.";
FW.L.USE_TEXTURE = "Mouse over the left textured bar and select a texture from the dropdown menu. You can also use any other texture by giving its path."
FW.L.USE_FONT = "Mouse over the left font area and select a font from the dropdown menu. The center editbox can be used to change the font size. You can also use any other font by giving its path.";
FW.L.USE_EDITBOX = "Don't forget you have to press enter to confirm changes to the editboxes!";
FW.L.USE_MSG2 = "The first checkbox will enable this message in your party or raid. The second checkbox will enable it in the channel you set above.";

FW.L.DEFAULT = "[default]";
FW.L.DEFAULTS = "[defaults]";
FW.L.POSITION = "[position]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "You will usually not have to change anything here. It's only for problem solving.";
FW.L.ADVANCED_HINT2 = "Changes to 'update intervals' only apply after reloading.";

FW.L.GENERAL_TIPS = "Some Tips";
FW.L.GENERAL_TIPS1 = "Press enter to confirm changes to editboxes. Escape will restore its current setting.";
FW.L.GENERAL_TIPS2 = "You can use the [defaults] button in the headers to restore every default in this category.";
FW.L.GENERAL_TIPS3 = "Left-click frame headers to toggle between display modes. ALT+drag frame headers to move.";
FW.L.GENERAL_TIPS4 = "Some color options also allow for transparency changing. Usually the background colors.";

FW.L.GENERAL_MO = "General Module Options";
FW.L.GENERAL_MO1 = "Right-click headers for options";
FW.L.GENERAL_MO1_TT = "You can right-click the module frame headers to open the options menu at the right position. Will only work for frames that aren't fully locked.";
FW.L.GENERAL_MO2 = "Alternate time format";
FW.L.GENERAL_MO2_TT = "Change the time format from 30m to 29:59.";
FW.L.GENERAL_MO3 = "Enable frame snapping";
FW.L.GENERAL_MO3_TT = "The module frames will allign to each other's borders when dragged.";
FW.L.GENERAL_MO4 = "Frame snapping distance";
FW.L.GENERAL_MO4_TT = "The distance frame borders must be from each other to allign.";
FW.L.GENERAL_MO5 = "Frame spacing";
FW.L.GENERAL_MO5_TT = "The distance to keep between frames when they are alligned.";

FW.L.GENERAL_MA = "General Module Appearance";
FW.L.GENERAL_MA1_TT = "Change the Bar Font for ALL module frames.";
FW.L.GENERAL_MA2_TT = "Change the Bar Texture for ALL module frames.";

FW.L.GENERAL_OA = "Options Appearance";
FW.L.GENERAL_OA1 = "Header Color";
FW.L.GENERAL_OA1_TT = "Change the Header Color of the option frames.";
FW.L.GENERAL_OA2 = "Background Color";
FW.L.GENERAL_OA2_TT = "Change the Background Color of the option frames.";
FW.L.GENERAL_OA3 = "Headers";
FW.L.GENERAL_OA3_TT = "Change the font the options headers are displayed in.";
FW.L.GENERAL_OA4 = "Options";
FW.L.GENERAL_OA4_TT = "Change the font the options are displayed in.";

FW.L.PROFILES = "Profiles";
FW.L.PROFILES_HINT1 = "If you name profiles after your characters, the addon will automatically load the right profile.";
FW.L.PROFILES_CURRENT = "Current Profile";
FW.L.PROFILES_CURRENT_TT = "Select the profile you want to use. [delete current] deletes the profile you are currently using (have selected). [create new] copies your current settings to a new profile with the name you entered or replaces one.";

FW.L.LOADING_DELAY = "Loading delay";
FW.L.UPDATE_INTERVAL_CORE = "Update interval core";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "Update interval animations";


-- DE 0 missing
elseif GetLocale() == "deDE" then
	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^Dein %s wurde widerstanden";
	FW.L.WAS_EVADED = "^Dein %s wurde von .+ ausgewichen";
	FW.L.FAILED_IMMUNE = "^%s ist fehlgeschlagen";
	FW.L.IS_REFLECTED = "^Dein %s wurde von .+ reflektiert";

	FW.L.DOT_HIT = "^(.+) erleidet .+ Schaden von deinem (.+)%.";
	FW.L.DOT_ABSORB = "^Dein (.+) wurde von (.+) absorbiert%.";
	FW.L.DIES = " stirbt.";

	--spell book
	FW.L.RANK = "Rang";
	FW.L.SPELL_RANK = "^Rang (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "Ritual der Seelen";

	--items
	FW.L.MINOR_SS = "Schwacher Seelenstein";
	FW.L.LESSER_SS = "Geringer Seelenstein";
	FW.L.NORMAL_SS = "Seelenstein";
	FW.L.GREATER_SS = "Großer Seelenstein";
	FW.L.MAJOR_SS = "Erheblicher Seelenstein";
	FW.L.MASTER_SS = "Meisterlicher Seelenstein";

	FW.L.MASTER_HS = "Meisterlicher Gesundheitsstein";
	FW.L.MAJOR_HS = "Erheblicher Gesundheitsstein";
	FW.L.GREATER_HS = "Großer Gesundheitsstein";
	FW.L.NORMAL_HS = "Gesundheitsstein";
	FW.L.LESSER_HS = "Geringer Gesundheitsstein";
	FW.L.MINOR_HS = "Schwacher Gesundheitsstein";

	--zones
	FW.L.COILFANG_RESERVOIR = "Höhle des Schlangenschreins";
	--units
	FW.L.HELLFIRE_CHANNELER = "Kanalisierer des Höllenfeuers "
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "Großastronom Capernian";
	FW.L.LORD_SANGUINAR = "Fürst Blutdurst "
	FW.L.MASTER_ENGINEER_TELONICUS = "Meisteringenieur Telonicus";
	FW.L.THALADRED_THE_DARKENER = "Thaladred der Verfinsterer";
	FW.L.FATHOM_GUARD_SHARKKIS = "Tiefenwächter Haikis";
	FW.L.FATHOM_GUARD_CARIBDIS = "Tiefenwächter Caribdis";
	FW.L.FATHOM_GUARD_TIDALVESS = "Tiefenwächter Flutvess";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "Update Now";
FW.L.LAST_CHECK = "\n\nLast check: %d seconds ago.";
FW.L.SCROLL_TO_ = "Scroll to ";

FW.L.POTION = "Potion";
FW.L.POWERUP = "Powerup";
FW.L.ITEM = "Item";
FW.L.PET = "Pet";
FW.L.SPELL = "Spell";
FW.L.HEALTHSTONE_NORMAL = "Healthstone";
FW.L.SOULWELL = "Soulwell";

-- commonly used
FW.L.USE_ = "Use %s";
FW.L.CREATE_ = "Create %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "Left Click to create %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "Right Click to use %s.";

FW.L.MASTER = "Master";
FW.L.MAJOR = "Major";
FW.L.GREATER = "Greater";
FW.L.NORMAL = "Normal";
FW.L.LESSER = "Lesser";
FW.L.MINOR = "Minor";

FW.L.YELLOW_STAR = "<Yellow Star>";
FW.L.ORANGE_CIRCLE = "<Orange Circle>";
FW.L.PRUPLE_DIAMOND = "<Purple Diamond>";
FW.L.GREEN_TRIANGLE = "<Green Triangle>";
FW.L.MOON = "<Moon>";
FW.L.BLUE_SQUARE = "<Blue Square>";
FW.L.CROSS = "<Cross>";
FW.L.SKULL = "<Skull>";

FW.L.FILTER_NONE = "normal";
FW.L.FILTER_IGNORE = "|cffff0000ignore|r";
FW.L.FILTER_COLOR = "|cff00ff00color|r";

FW.L.MODULE_NONE = "|cffff0000None|r";

FW.L.NOTARGET = "<No Target>";
FW.L.UNKNOWN = "<Unknown>";
FW.L.NOBODY = "<Nobody>"

FW.L.ENABLE  = "Enable";
FW.L.LOCK = "Lock (disable option functions)";
FW.L.EXPAND_UP = "Expand up";
FW.L.EXPAND_UP_TT = "Determines if the bar lists should be expanded upwards or downwards.";
FW.L.BAR_SPACING = "Bar spacing"
FW.L.COMBAT_HINT = "Some sizing changes you make here will only apply outside of combat.";
FW.L.ORA_HINT = "For people without ForteWarlock but with oRA, someone with FW has to be promoted.";

FW.L.DEAD = "Dead";
FW.L.OFFLINE = "Offline";
FW.L.CASTING = "Casting";
FW.L.CUSTOMIZE = "Customize";
FW.L.GENERAL = "General Options";
FW.L.ADVANCED = "Advanced Options";
FW.L.BASIC = "Basics";
FW.L.SPECIFIC = "Specifics";
FW.L.CORE = "Core";
FW.L.COLORING_FILTERING = "Coloring/Filtering";
FW.L.APPEARANCE = "Appearance";
FW.L.SIZING = "Sizing";
FW.L.SCALE = "Scale";
FW.L.BAR_HEIGHT = "Bar height";
FW.L.BAR_WIDTH = "Bar width";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "Frame Background";
FW.L.BAR_TEXT = "Bar text";
FW.L.BAR_FONT = "Bar Font";
FW.L.BAR_TEXTURE = "Bar Texture";
FW.L.BAR_COLORING = "Bar Coloring";
FW.L.AUTO_HIDE = "Auto-hide outside party/raid";
FW.L.AUTO_HIDE_TT = "This will automatically hide the frame when not in a party or raid.";
FW.L.AUTO_MINIMIZE = "Auto-minimize outside party/raid";
FW.L.AUTO_MINIMIZE_TT = "This will automatically hide the bars when not in a party or raid.";
FW.L.SHOW_BARS = "Show bars";
FW.L.SHOW_BARS_TT = "Show the bars. You can hide them in case you only want to see the information on the header.";
FW.L.MAX_SHOWN = "Maximum shown";

FW.L.SELF_MESSAGES = "Self Messages";
FW.L.SELF_MESSAGES_HINT1 = "This allows you to display usefull messages to yourself. They are shown in your 'default' chat frame."
FW.L.RAID_MESSAGES = "Party/Raid Messages";
FW.L.RAID_MESSAGES_HINT1 = "This allows you to display messages to others based on spells you cast.";
FW.L.RAID_MESSAGES_HINT2 = "You can disable all messages to party/raid and/or channel, or every message separately.";
FW.L.SHOW_IN_RAID = "Show in party/raid (1st checkboxes)";
FW.L.SHOW_IN_RAID_TT = "Uncheck to stop any messages from being shown in your raid or party.";
FW.L.SHOW_IN_CHANNEL = "Show in channel (2nd checkboxes)";
FW.L.SHOW_IN_CHANNEL_TT = "Set the channel name or number in which you want some of your messages to be displayed. 'say' is also valid. Uncheck to stop any messages being shown in the channel.";

-- standard usage tips to append
FW.L.USE_FILTER = "First type in the item or spell that you want to change (auto-fills). Then you can select if you want to show it normally (normal), hide it (ignore) or change its color (color). If you selected you want to change the color, you get a color picker from clicking square on the right.";
FW.L.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency.";
FW.L.USE_TEXTURE = "Mouse over the left textured bar and select a texture from the dropdown menu. You can also use any other texture by giving its path."
FW.L.USE_FONT = "Mouse over the left font area and select a font from the dropdown menu. The center editbox can be used to change the font size. You can also use any other font by giving its path.";
FW.L.USE_EDITBOX = "Don't forget you have to press enter to confirm changes to the editboxes!";
FW.L.USE_MSG2 = "The first checkbox will enable this message in your party or raid. The second checkbox will enable it in the channel you set above.";

FW.L.DEFAULT = "[default]";
FW.L.DEFAULTS = "[defaults]";
FW.L.POSITION = "[position]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "You will usually not have to change anything here. It's only for problem solving.";
FW.L.ADVANCED_HINT2 = "Changes to 'update intervals' only apply after reloading.";

FW.L.GENERAL_TIPS = "Some Tips";
FW.L.GENERAL_TIPS1 = "Press enter to confirm changes to editboxes. Escape will restore its current setting.";
FW.L.GENERAL_TIPS2 = "You can use the [defaults] button in the headers to restore every default in this category.";
FW.L.GENERAL_TIPS3 = "Left-click frame headers to toggle between display modes. ALT+drag frame headers to move.";
FW.L.GENERAL_TIPS4 = "Some color options also allow for transparency changing. Usually the background colors.";

FW.L.GENERAL_MO = "General Module Options";
FW.L.GENERAL_MO1 = "Right-click headers for options";
FW.L.GENERAL_MO1_TT = "You can right-click the module frame headers to open the options menu at the right position. Will only work for frames that aren't fully locked.";
FW.L.GENERAL_MO2 = "Alternate time format";
FW.L.GENERAL_MO2_TT = "Change the time format from 30m to 29:59.";
FW.L.GENERAL_MO3 = "Enable frame snapping";
FW.L.GENERAL_MO3_TT = "The module frames will allign to each other's borders when dragged.";
FW.L.GENERAL_MO4 = "Frame snapping distance";
FW.L.GENERAL_MO4_TT = "The distance frame borders must be from each other to allign.";
FW.L.GENERAL_MO5 = "Frame spacing";
FW.L.GENERAL_MO5_TT = "The distance to keep between frames when they are alligned.";

FW.L.GENERAL_MA = "General Module Appearance";
FW.L.GENERAL_MA1_TT = "Change the Bar Font for ALL module frames.";
FW.L.GENERAL_MA2_TT = "Change the Bar Texture for ALL module frames.";

FW.L.GENERAL_OA = "Options Appearance";
FW.L.GENERAL_OA1 = "Header Color";
FW.L.GENERAL_OA1_TT = "Change the Header Color of the option frames.";
FW.L.GENERAL_OA2 = "Background Color";
FW.L.GENERAL_OA2_TT = "Change the Background Color of the option frames.";
FW.L.GENERAL_OA3 = "Headers";
FW.L.GENERAL_OA3_TT = "Change the font the options headers are displayed in.";
FW.L.GENERAL_OA4 = "Options";
FW.L.GENERAL_OA4_TT = "Change the font the options are displayed in.";

FW.L.PROFILES = "Profiles";
FW.L.PROFILES_HINT1 = "If you name profiles after your characters, the addon will automatically load the right profile.";
FW.L.PROFILES_CURRENT = "Current Profile";
FW.L.PROFILES_CURRENT_TT = "Select the profile you want to use. [delete current] deletes the profile you are currently using (have selected). [create new] copies your current settings to a new profile with the name you entered or replaces one.";

FW.L.LOADING_DELAY = "Loading delay";
FW.L.UPDATE_INTERVAL_CORE = "Update interval core";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "Update interval animations";

-- SPANISH - 1 mising  By Intxixu - SPQR - Tyrande
elseif GetLocale() == "esES" then
	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^Tu %s fue resistida";
	FW.L.WAS_EVADED = "^Tu %s fue evadida";
	FW.L.FAILED_IMMUNE = "^Tu %s fallo";
	FW.L.IS_REFLECTED = "^Tu %s es reflejado";

	FW.L.DOT_HIT = "^(.+) sufre .+ dñoa de tu  (.+)%.";
	FW.L.DOT_ABSORB = "^Tu (.+) es absorbido por (.+)%.";
	FW.L.DIES = " muere.";

	--spell book
	FW.L.RANK = "Rango";
	FW.L.SPELL_RANK = "^Rango (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "Ritual de almas";

	--items
	FW.L.MINOR_SS = "Piedra de alma menor";
	FW.L.LESSER_SS = "Piedra de alma inferior";
	FW.L.NORMAL_SS = "Piedra de alma";
	FW.L.GREATER_SS = "Piedra de alma superior";
	FW.L.MAJOR_SS = "Piedra de alma sublime";
	FW.L.MASTER_SS = "Piedra de alma maestra";

	FW.L.MASTER_HS = "Piedra de salud maestra";
	FW.L.MAJOR_HS = "Piedr de salud sublime";
	FW.L.GREATER_HS = "Piedra de salud superior";
	FW.L.NORMAL_HS = "Piedra de salud";
	FW.L.LESSER_HS = "Piedra de salur inferior";
	FW.L.MINOR_HS = "Piedra de salud menor";

	--zones
	FW.L.COILFANG_RESERVOIR = "Caverna Santuario Serpiente";

	--units
	FW.L.HELLFIRE_CHANNELER = "Canalizador Fuego Infernal"
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "Grand Astromancer Capernian";
--[[>>]]FW.L.LORD_SANGUINAR = "Lord Sanguinar"
	FW.L.MASTER_ENGINEER_TELONICUS = "Maestro ingeniero Telonicus";
	FW.L.THALADRED_THE_DARKENER = "Thaladred the Darkener";
	FW.L.FATHOM_GUARD_SHARKKIS = "Guardia de las profundidades de Sharkkis";
	FW.L.FATHOM_GUARD_CARIBDIS = " Guardia de las profundidades de Caribdis";
	FW.L.FATHOM_GUARD_TIDALVESS = " Guardia de las profundidades de Tidalvess";

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "Update Now";
FW.L.LAST_CHECK = "\n\nLast check: %d seconds ago.";
FW.L.SCROLL_TO_ = "Scroll to ";

FW.L.POTION = "Potion";
FW.L.POWERUP = "Powerup";
FW.L.ITEM = "Item";
FW.L.PET = "Pet";
FW.L.SPELL = "Spell";
FW.L.HEALTHSTONE_NORMAL = "Healthstone";
FW.L.SOULWELL = "Soulwell";

-- commonly used
FW.L.USE_ = "Use %s";
FW.L.CREATE_ = "Create %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "Left Click to create %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "Right Click to use %s.";

FW.L.MASTER = "Master";
FW.L.MAJOR = "Major";
FW.L.GREATER = "Greater";
FW.L.NORMAL = "Normal";
FW.L.LESSER = "Lesser";
FW.L.MINOR = "Minor";

FW.L.YELLOW_STAR = "<Yellow Star>";
FW.L.ORANGE_CIRCLE = "<Orange Circle>";
FW.L.PRUPLE_DIAMOND = "<Purple Diamond>";
FW.L.GREEN_TRIANGLE = "<Green Triangle>";
FW.L.MOON = "<Moon>";
FW.L.BLUE_SQUARE = "<Blue Square>";
FW.L.CROSS = "<Cross>";
FW.L.SKULL = "<Skull>";

FW.L.FILTER_NONE = "normal";
FW.L.FILTER_IGNORE = "|cffff0000ignore|r";
FW.L.FILTER_COLOR = "|cff00ff00color|r";

FW.L.MODULE_NONE = "|cffff0000None|r";

FW.L.NOTARGET = "<No Target>";
FW.L.UNKNOWN = "<Unknown>";
FW.L.NOBODY = "<Nobody>"

FW.L.ENABLE  = "Enable";
FW.L.LOCK = "Lock (disable option functions)";
FW.L.EXPAND_UP = "Expand up";
FW.L.EXPAND_UP_TT = "Determines if the bar lists should be expanded upwards or downwards.";
FW.L.BAR_SPACING = "Bar spacing"
FW.L.COMBAT_HINT = "Some sizing changes you make here will only apply outside of combat.";
FW.L.ORA_HINT = "For people without ForteWarlock but with oRA, someone with FW has to be promoted.";

FW.L.DEAD = "Dead";
FW.L.OFFLINE = "Offline";
FW.L.CASTING = "Casting";
FW.L.CUSTOMIZE = "Customize";
FW.L.GENERAL = "General Options";
FW.L.ADVANCED = "Advanced Options";
FW.L.BASIC = "Basics";
FW.L.SPECIFIC = "Specifics";
FW.L.CORE = "Core";
FW.L.COLORING_FILTERING = "Coloring/Filtering";
FW.L.APPEARANCE = "Appearance";
FW.L.SIZING = "Sizing";
FW.L.SCALE = "Scale";
FW.L.BAR_HEIGHT = "Bar height";
FW.L.BAR_WIDTH = "Bar width";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "Frame Background";
FW.L.BAR_TEXT = "Bar text";
FW.L.BAR_FONT = "Bar Font";
FW.L.BAR_TEXTURE = "Bar Texture";
FW.L.BAR_COLORING = "Bar Coloring";
FW.L.AUTO_HIDE = "Auto-hide outside party/raid";
FW.L.AUTO_HIDE_TT = "This will automatically hide the frame when not in a party or raid.";
FW.L.AUTO_MINIMIZE = "Auto-minimize outside party/raid";
FW.L.AUTO_MINIMIZE_TT = "This will automatically hide the bars when not in a party or raid.";
FW.L.SHOW_BARS = "Show bars";
FW.L.SHOW_BARS_TT = "Show the bars. You can hide them in case you only want to see the information on the header.";
FW.L.MAX_SHOWN = "Maximum shown";

FW.L.SELF_MESSAGES = "Self Messages";
FW.L.SELF_MESSAGES_HINT1 = "This allows you to display usefull messages to yourself. They are shown in your 'default' chat frame."
FW.L.RAID_MESSAGES = "Party/Raid Messages";
FW.L.RAID_MESSAGES_HINT1 = "This allows you to display messages to others based on spells you cast.";
FW.L.RAID_MESSAGES_HINT2 = "You can disable all messages to party/raid and/or channel, or every message separately.";
FW.L.SHOW_IN_RAID = "Show in party/raid (1st checkboxes)";
FW.L.SHOW_IN_RAID_TT = "Uncheck to stop any messages from being shown in your raid or party.";
FW.L.SHOW_IN_CHANNEL = "Show in channel (2nd checkboxes)";
FW.L.SHOW_IN_CHANNEL_TT = "Set the channel name or number in which you want some of your messages to be displayed. 'say' is also valid. Uncheck to stop any messages being shown in the channel.";

-- standard usage tips to append
FW.L.USE_FILTER = "First type in the item or spell that you want to change (auto-fills). Then you can select if you want to show it normally (normal), hide it (ignore) or change its color (color). If you selected you want to change the color, you get a color picker from clicking square on the right.";
FW.L.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency.";
FW.L.USE_TEXTURE = "Mouse over the left textured bar and select a texture from the dropdown menu. You can also use any other texture by giving its path."
FW.L.USE_FONT = "Mouse over the left font area and select a font from the dropdown menu. The center editbox can be used to change the font size. You can also use any other font by giving its path.";
FW.L.USE_EDITBOX = "Don't forget you have to press enter to confirm changes to the editboxes!";
FW.L.USE_MSG2 = "The first checkbox will enable this message in your party or raid. The second checkbox will enable it in the channel you set above.";

FW.L.DEFAULT = "[default]";
FW.L.DEFAULTS = "[defaults]";
FW.L.POSITION = "[position]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "You will usually not have to change anything here. It's only for problem solving.";
FW.L.ADVANCED_HINT2 = "Changes to 'update intervals' only apply after reloading.";

FW.L.GENERAL_TIPS = "Some Tips";
FW.L.GENERAL_TIPS1 = "Press enter to confirm changes to editboxes. Escape will restore its current setting.";
FW.L.GENERAL_TIPS2 = "You can use the [defaults] button in the headers to restore every default in this category.";
FW.L.GENERAL_TIPS3 = "Left-click frame headers to toggle between display modes. ALT+drag frame headers to move.";
FW.L.GENERAL_TIPS4 = "Some color options also allow for transparency changing. Usually the background colors.";

FW.L.GENERAL_MO = "General Module Options";
FW.L.GENERAL_MO1 = "Right-click headers for options";
FW.L.GENERAL_MO1_TT = "You can right-click the module frame headers to open the options menu at the right position. Will only work for frames that aren't fully locked.";
FW.L.GENERAL_MO2 = "Alternate time format";
FW.L.GENERAL_MO2_TT = "Change the time format from 30m to 29:59.";
FW.L.GENERAL_MO3 = "Enable frame snapping";
FW.L.GENERAL_MO3_TT = "The module frames will allign to each other's borders when dragged.";
FW.L.GENERAL_MO4 = "Frame snapping distance";
FW.L.GENERAL_MO4_TT = "The distance frame borders must be from each other to allign.";
FW.L.GENERAL_MO5 = "Frame spacing";
FW.L.GENERAL_MO5_TT = "The distance to keep between frames when they are alligned.";

FW.L.GENERAL_MA = "General Module Appearance";
FW.L.GENERAL_MA1_TT = "Change the Bar Font for ALL module frames.";
FW.L.GENERAL_MA2_TT = "Change the Bar Texture for ALL module frames.";

FW.L.GENERAL_OA = "Options Appearance";
FW.L.GENERAL_OA1 = "Header Color";
FW.L.GENERAL_OA1_TT = "Change the Header Color of the option frames.";
FW.L.GENERAL_OA2 = "Background Color";
FW.L.GENERAL_OA2_TT = "Change the Background Color of the option frames.";
FW.L.GENERAL_OA3 = "Headers";
FW.L.GENERAL_OA3_TT = "Change the font the options headers are displayed in.";
FW.L.GENERAL_OA4 = "Options";
FW.L.GENERAL_OA4_TT = "Change the font the options are displayed in.";

FW.L.PROFILES = "Profiles";
FW.L.PROFILES_HINT1 = "If you name profiles after your characters, the addon will automatically load the right profile.";
FW.L.PROFILES_CURRENT = "Current Profile";
FW.L.PROFILES_CURRENT_TT = "Select the profile you want to use. [delete current] deletes the profile you are currently using (have selected). [create new] copies your current settings to a new profile with the name you entered or replaces one.";

FW.L.LOADING_DELAY = "Loading delay";
FW.L.UPDATE_INTERVAL_CORE = "Update interval core";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "Update interval animations";


-- Simple Chinese
elseif GetLocale() == "zhCN" then

	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^你的%s被.+抵抗了。";
	FW.L.WAS_EVADED = "^你的%s被.+闪避过去了。";
	FW.L.FAILED_IMMUNE = "^你的%s施放失败。.+对此免疫。";
	FW.L.IS_REFLECTED = "^你的%s被.+反弹回来。";

	FW.L.DOT_HIT = "^你的(.+)使(.+)受到了.+伤害";
	FW.L.DOT_ABSORB = "^你的(.+)被(.+)吸收了";
	FW.L.DIES = "%s死亡了。";

	--spell book
	FW.L.RANK = "等级";
	FW.L.SPELL_RANK = "^等级 (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "灵魂仪式";

	--items
	FW.L.MINOR_SS = "初级灵魂石";
	FW.L.LESSER_SS = "次级灵魂石";
	FW.L.NORMAL_SS = "灵魂石";
	FW.L.GREATER_SS = "强效灵魂石";
	FW.L.MAJOR_SS = "特效灵魂石";
	FW.L.MASTER_SS = "极效灵魂石";

	FW.L.MASTER_HS = "极效治疗石";
	FW.L.MAJOR_HS = "特效治疗石";
	FW.L.GREATER_HS = "强效治疗石";
	FW.L.NORMAL_HS = "治疗石";
	FW.L.LESSER_HS = "次级治疗石";
	FW.L.MINOR_HS = "初级治疗石";

	--zones
	FW.L.COILFANG_RESERVOIR = "毒蛇神殿";
	--units
	FW.L.HELLFIRE_CHANNELER = "地狱火导魔者"
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "星术师卡波妮娅";
	FW.L.LORD_SANGUINAR = "萨古纳尔男爵"
	FW.L.MASTER_ENGINEER_TELONICUS = "首席技师塔隆尼库斯";
	FW.L.THALADRED_THE_DARKENER = "亵渎者萨拉德雷";
	FW.L.FATHOM_GUARD_SHARKKIS = "深水卫士沙克基斯";
	FW.L.FATHOM_GUARD_CARIBDIS = "深水卫士卡莉蒂丝";
	FW.L.FATHOM_GUARD_TIDALVESS = "深水卫士泰达维斯";

	FW:RegisterFont("Fonts\\ZYHei.TTF","中易黑");
	FW:RegisterFont("Fonts\\ZYKai_T.TTF","中易楷");
	FW:SetDefaultFont("Fonts\\ZYHei.TTF",10);

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "刷新";
FW.L.LAST_CHECK = "\n\n上次扫描: %d 秒之前.";
FW.L.SCROLL_TO_ = "移动到 ";

FW.L.POTION = "药水";
FW.L.POWERUP = "增强BUFF";
FW.L.ITEM = "物品";
FW.L.PET = "Pet";
FW.L.SPELL = "法术";
FW.L.HEALTHSTONE_NORMAL = "治疗石";
FW.L.SOULWELL = "灵魂井";

-- commonly used
FW.L.USE_ = "使用 %s";
FW.L.CREATE_ = "制作 %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "左键点击制作 %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "右键点击使用 %s.";

FW.L.MASTER = "极效糖";
FW.L.MAJOR = "特效糖";
FW.L.GREATER = "强效糖";
FW.L.NORMAL = "普通糖";
FW.L.LESSER = "次级糖";
FW.L.MINOR = "初级糖";

FW.L.YELLOW_STAR = "<星星标记>";
FW.L.ORANGE_CIRCLE = "<大饼标记>";
FW.L.PRUPLE_DIAMOND = "<菱形标记>";
FW.L.GREEN_TRIANGLE = "<三角标记>";
FW.L.MOON = "<月球标记>";
FW.L.BLUE_SQUARE = "<方块标记>";
FW.L.CROSS = "<十字标记>";
FW.L.SKULL = "<骷髅标记>";

FW.L.FILTER_NONE = "恢复";
FW.L.FILTER_IGNORE = "|cffff0000屏蔽|r";
FW.L.FILTER_COLOR = "|cff00ff00颜色|r";

FW.L.MODULE_NONE = "|cffff0000无|r";

FW.L.NOTARGET = "<没有目标>";
FW.L.UNKNOWN = "<未知>";
FW.L.NOBODY = "<无人>"

FW.L.ENABLE  = "启动";
FW.L.LOCK = "锁定 (禁用右键设置)";
FW.L.EXPAND_UP = "向上扩展";
FW.L.EXPAND_UP_TT = "设置计时条向上/下扩展.";
FW.L.BAR_SPACING = "间距"
FW.L.COMBAT_HINT = "大小设置只在非战斗状态下有效.";
FW.L.ORA_HINT = "很多同志没有装FW,但是装了oRA,装了FW的同志需要取得团队权限(L或A)";

FW.L.DEAD = "挂了";
FW.L.OFFLINE = "掉线";
FW.L.CASTING = "施法";
FW.L.CUSTOMIZE = "自定义";
FW.L.GENERAL = "综合选项";
FW.L.ADVANCED = "高级选项";
FW.L.BASIC = "基本选项";
FW.L.SPECIFIC = "特殊选项";
FW.L.CORE = "核心选项";
FW.L.COLORING_FILTERING = "颜色/过滤";
FW.L.APPEARANCE = "外观";
FW.L.SIZING = "尺寸";
FW.L.SCALE = "缩放";
FW.L.BAR_HEIGHT = "高度";
FW.L.BAR_WIDTH = "宽度";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "框体背景";
FW.L.BAR_TEXT = "文字";
FW.L.BAR_FONT = "字体";
FW.L.BAR_TEXTURE = "材质";
FW.L.BAR_COLORING = "颜色";
FW.L.AUTO_HIDE = "非组队/团队隐藏";
FW.L.AUTO_HIDE_TT = "当不在小队或者团队中自动隐藏";
FW.L.AUTO_MINIMIZE = "非组队/团队最小化";
FW.L.AUTO_MINIMIZE_TT = "当不在小队/团队中,自动隐藏计时条.";
FW.L.SHOW_BARS = "显示计时条";
FW.L.SHOW_BARS_TT = "显示计时条. 如果你只需要从标题栏看见相关信息,可以将计时条隐藏.";
FW.L.MAX_SHOWN = "最大显示数";

FW.L.SELF_MESSAGES = "个人信息";
FW.L.SELF_MESSAGES_HINT1 = "此功能能在聊天窗口向你显示一些有用的信息,此信息只有你能看见."
FW.L.RAID_MESSAGES = "小队/团队信息";
FW.L.RAID_MESSAGES_HINT1 = "此功能向你的队友显示一些关于你施放的法术的信息.";
FW.L.RAID_MESSAGES_HINT2 = "你可以逐条或者全部禁止信息在任何频道对你的队友显示.";
FW.L.SHOW_IN_RAID = "小队/团队频道 (第一个选项)";
FW.L.SHOW_IN_RAID_TT = "关闭此项将会禁止所有信息对你的队友显示.";
FW.L.SHOW_IN_CHANNEL = "在定义频道显示 (第二个选项)";
FW.L.SHOW_IN_CHANNEL_TT = "设定显示信息的频道名字或者序号. 支持'说'(白字). 关闭此项将禁止所有信息在此频道显示.";

-- standard usage tips to append
FW.L.USE_FILTER = "首先键入你想过滤的法术或者物品 (auto-fills). 然后你可以选择设置正常显示 (none选项), 隐藏不显示 (ignore选项) 或改变其颜色 (custom选项). 选择第三项后右边会出现颜色设置按钮.";
FW.L.USE_COLOR_PICKER = "点击颜色设置按钮可以设置颜色,右边如果有一个滑动条,那么你还可以设定透明度.";
FW.L.USE_TEXTURE = "鼠标划过材质条可以在出现菜单中选择材质. 输入材质路径可以设置为其他材质."
FW.L.USE_FONT = "鼠标划过字体框可以在出现菜单中选择字体.中间的编辑框可以设定字体大小.输入字体路径可以设置为其他字体.";
FW.L.USE_EDITBOX = "改变后需要按'回车'键确认更改!!!";
FW.L.USE_MSG2 = "第一个选项向你队友显示信息. 第二个选项在你上面设定的频道中显示信息.";

FW.L.DEFAULT = "[默认]";
FW.L.DEFAULTS = "[默认]";
FW.L.POSITION = "[定位]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "没事/不懂的话,这里的东西不要改变. 这部分是调整整个插件的."
FW.L.ADVANCED_HINT2 = "'更新间隔'选项改变后,必须重载插件才有效.";

FW.L.GENERAL_TIPS = "提示";
FW.L.GENERAL_TIPS1 = "注意!!编辑框中按回车确认更改,按ESC取消更改.";
FW.L.GENERAL_TIPS2 = "按顶部的[defaults]按钮,恢复到默认设置.";
FW.L.GENERAL_TIPS3 = "单击框体标题栏切换显示模式. ALT+拖拽移动框体.";
FW.L.GENERAL_TIPS4 = "颜色选项支持调整透明度,一般是背景颜色才有.";

FW.L.GENERAL_MO = "综合模块选项";
FW.L.GENERAL_MO1 = "右击标题栏设置框体";
FW.L.GENERAL_MO1_TT = "在框体标题栏右键点击可以在右侧显示设置框体. 框体锁定时无效.";
FW.L.GENERAL_MO2 = "改变时间显示格式";
FW.L.GENERAL_MO2_TT = "将时间格式从30m变成29:59.";
FW.L.GENERAL_MO3 = "自动对齐";
FW.L.GENERAL_MO3_TT = "各模块框体在拖拽到一起时自动对齐.";
FW.L.GENERAL_MO4 = "自动对齐距离";
FW.L.GENERAL_MO4_TT = "自动对齐生效的最大距离.";
FW.L.GENERAL_MO5 = "框体间距";
FW.L.GENERAL_MO5_TT = "框体对齐后之间保持的距离.";

FW.L.GENERAL_MA = "综合模块显示";
FW.L.GENERAL_MA1_TT = "改变所有模块字体.";
FW.L.GENERAL_MA2_TT = "改变所有模块材质.";

FW.L.GENERAL_OA = "选项显示";
FW.L.GENERAL_OA1 = "标题栏颜色";
FW.L.GENERAL_OA1_TT = "改变选项框体标题栏颜色.";
FW.L.GENERAL_OA2 = "背景颜色";
FW.L.GENERAL_OA2_TT = "改变选项框体背景颜色.";
FW.L.GENERAL_OA3 = "标题栏字体";
FW.L.GENERAL_OA3_TT = "设定选项窗口标题栏字体.";
FW.L.GENERAL_OA4 = "选项字体";
FW.L.GENERAL_OA4_TT = "设定选项字体.";

FW.L.PROFILES = "保存设置";
FW.L.PROFILES_HINT1 = "按人物保存设置文件, 插件会自动加载对应设置.";
FW.L.PROFILES_CURRENT = "当前设置文件";
FW.L.PROFILES_CURRENT_TT = "选择设置文件. [delete current] 删除当前设置 (选中).[create new] 将当前设置保存为输入的设置名.";

FW.L.LOADING_DELAY = "正在读入";
FW.L.UPDATE_INTERVAL_CORE = "更新间隔核心";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "更新动画间隔";


-- trdition Chinese
elseif GetLocale() == "zhTW" then

	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^你的%s被.+抵抗了。";
	FW.L.WAS_EVADED = "^你的%s被.+閃避過去了。";
	FW.L.FAILED_IMMUNE = "^你的%s施放失敗。.+對此免疫。";
	FW.L.IS_REFLECTED = "^你的%s被.+反彈回來。";

	FW.L.DOT_HIT = "^你的(.+)使(.+)受到了.+傷害";
	FW.L.DOT_ABSORB = "^你的(.+)被(.+)吸收了";
	FW.L.DIES = "%s死亡了。";

	--spell book
	FW.L.RANK = "等級";
	FW.L.SPELL_RANK = "^等級 (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "靈魂儀式";

	--items
	FW.L.MINOR_SS = "初級靈魂石";
	FW.L.LESSER_SS = "次級靈魂石";
	FW.L.NORMAL_SS = "靈魂石";
	FW.L.GREATER_SS = "強效靈魂石";
	FW.L.MAJOR_SS = "極效靈魂石";
	FW.L.MASTER_SS = " 極強效靈魂石";

	FW.L.MASTER_HS = "極強效治療石";
	FW.L.MAJOR_HS = "特效治療石";
	FW.L.GREATER_HS = "強效治療石";
	FW.L.NORMAL_HS = "治療石";
	FW.L.LESSER_HS = "次級治療石";
	FW.L.MINOR_HS = "初級治療石";
 	

	--zones
	FW.L.COILFANG_RESERVOIR = "毒蛇神殿洞穴";
	--units
	FW.L.HELLFIRE_CHANNELER = "地獄火導魔師"
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "大星術師卡普尼恩";
	FW.L.LORD_SANGUINAR = "桑古納爾領主"
	FW.L.MASTER_ENGINEER_TELONICUS = "工程大師泰隆尼卡斯";
	FW.L.THALADRED_THE_DARKENER = "扭曲預言家薩拉瑞德";
	FW.L.FATHOM_GUARD_SHARKKIS = "深淵守衛沙卡奇斯";
	FW.L.FATHOM_GUARD_CARIBDIS = "深淵守衛卡利迪斯";
	FW.L.FATHOM_GUARD_TIDALVESS = "深淵守衛提達費斯";


	FW:RegisterFont("Fonts\\bLEI00D.TTF","聊天字體");
	FW:RegisterFont("Fonts\\bHEI01B.TTF","戰鬥字體");
	FW:SetDefaultFont("Fonts\\bLEI00D.TTF",10);

-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "刷新";
FW.L.LAST_CHECK = "\n\n上次掃描: %d 秒之前.";
FW.L.SCROLL_TO_ = "移動到 ";

FW.L.POTION = "藥水";
FW.L.POWERUP = "增強BUFF";
FW.L.ITEM = "物品";
FW.L.PET = "Pet";
FW.L.SPELL = "法術";
FW.L.HEALTHSTONE_NORMAL = "治療石";
FW.L.SOULWELL = "靈魂井";

-- commonly used
FW.L.USE_ = "使用 %s";
FW.L.CREATE_ = "製作 %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "左鍵點擊製作 %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "右鍵點擊使用 %s.";

FW.L.MASTER = "極強效糖";
FW.L.MAJOR = "特效糖";
FW.L.GREATER = "強效糖";
FW.L.NORMAL = "普通糖";
FW.L.LESSER = "次級糖";
FW.L.MINOR = "初級糖";

FW.L.YELLOW_STAR = "<星星標記>";
FW.L.ORANGE_CIRCLE = "<大餅標記>";
FW.L.PRUPLE_DIAMOND = "<菱形標記>";
FW.L.GREEN_TRIANGLE = "<三角標記>";
FW.L.MOON = "<月球標記>";
FW.L.BLUE_SQUARE = "<方塊標記>";
FW.L.CROSS = "<十字標記>";
FW.L.SKULL = "<骷髏標記>";

FW.L.FILTER_NONE = "恢復";
FW.L.FILTER_IGNORE = "|cffff0000遮罩|r";
FW.L.FILTER_COLOR = "|cff00ff00顏色|r";

FW.L.MODULE_NONE = "|cffff0000無|r";

FW.L.NOTARGET = "<沒有目標>";
FW.L.UNKNOWN = "<未知>";
FW.L.NOBODY = "<無人>"

FW.L.ENABLE  = "啟動";
FW.L.LOCK = "鎖定 (禁用右鍵設置)";
FW.L.EXPAND_UP = "向上擴展";
FW.L.EXPAND_UP_TT = "設置計時條向上/下擴展.";
FW.L.BAR_SPACING = "間距"
FW.L.COMBAT_HINT = "大小設置只在非戰鬥狀態下有效.";
FW.L.ORA_HINT = "很多同志沒有裝FW,但是裝了oRA,裝了FW的同志需要取得團隊許可權(L或A)";

FW.L.DEAD = "掛了";
FW.L.OFFLINE = "掉線";
FW.L.CASTING = "施法";
FW.L.CUSTOMIZE = "自定義";
FW.L.GENERAL = "綜合選項";
FW.L.ADVANCED = "高級選項";
FW.L.BASIC = "基本選項";
FW.L.SPECIFIC = "特殊選項";
FW.L.CORE = "核心選項";
FW.L.COLORING_FILTERING = "顏色/過濾";
FW.L.APPEARANCE = "外觀";
FW.L.SIZING = "尺寸";
FW.L.SCALE = "縮放";
FW.L.BAR_HEIGHT = "高度";
FW.L.BAR_WIDTH = "寬度";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "框體背景";
FW.L.BAR_TEXT = "文字";
FW.L.BAR_FONT = "字體";
FW.L.BAR_TEXTURE = "材質";
FW.L.BAR_COLORING = "顏色";
FW.L.AUTO_HIDE = "非組隊/團隊隱藏";
FW.L.AUTO_HIDE_TT = "當不在小隊或者團隊中自動隱藏";
FW.L.AUTO_MINIMIZE = "非組隊/團隊最小化";
FW.L.AUTO_MINIMIZE_TT = "當不在小隊/團隊中,自動隱藏計時條.";
FW.L.SHOW_BARS = "顯示計時條";
FW.L.SHOW_BARS_TT = "顯示計時條. 如果你只需要從標題欄看見相關資訊,可以將計時條隱藏.";
FW.L.MAX_SHOWN = "最大顯示數";

FW.L.SELF_MESSAGES = "個人資訊";
FW.L.SELF_MESSAGES_HINT1 = "此功能能在聊天視窗向你顯示一些有用的資訊,此資訊只有你能看見."
FW.L.RAID_MESSAGES = "小隊/團隊信息";
FW.L.RAID_MESSAGES_HINT1 = "此功能向你的隊友顯示一些關於你施放的法術的資訊.";
FW.L.RAID_MESSAGES_HINT2 = "你可以逐條或者全部禁止資訊在任何頻道對你的隊友顯示.";
FW.L.SHOW_IN_RAID = "小隊/團隊頻道 (第一個選項)";
FW.L.SHOW_IN_RAID_TT = "關閉此項將會禁止所有資訊對你的隊友顯示.";
FW.L.SHOW_IN_CHANNEL = "在定義頻道顯示 (第二個選項)";
FW.L.SHOW_IN_CHANNEL_TT = "設定顯示資訊的頻道名字或者序號. 支持'說'(白字). 關閉此項將禁止所有資訊在此頻道顯示.";

-- standard usage tips to append
FW.L.USE_FILTER = "首先鍵入你想過濾的法術或者物品 (auto-fills). 然後你可以選擇設置正常顯示 (none選項), 隱藏不顯示 (ignore選項) 或改變其顏色 (custom選項). 選擇第三項後右邊會出現顏色設置按鈕.";
FW.L.USE_COLOR_PICKER = "點擊顏色設置按鈕可以設置顏色,右邊如果有一個滑動條,那麼你還可以設定透明度.";
FW.L.USE_TEXTURE = "滑鼠劃過材質條可以在出現功能表中選擇材質. 輸入材質路徑可以設置為其他材質."
FW.L.USE_FONT = "滑鼠劃過字體框可以在出現功能表中選擇字體.中間的編輯框可以設定字體大小.輸入字體路徑可以設置為其他字體.";
FW.L.USE_EDITBOX = "改變後需要按'回車'鍵確認更改!!!";
FW.L.USE_MSG2 = "第一個選項向你隊友顯示資訊. 第二個選項在你上面設定的頻道中顯示資訊.";

FW.L.DEFAULT = "[默認]";
FW.L.DEFAULTS = "[默認]";
FW.L.POSITION = "[定位]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "沒事/不懂的話,這裏的東西不要改變. 這部分是調整整個插件的."
FW.L.ADVANCED_HINT2 = "'更新間隔'選項改變後,必須重載插件才有效.";

FW.L.GENERAL_TIPS = "提示";
FW.L.GENERAL_TIPS1 = "注意!!編輯框中按回車確認更改,按ESC取消更改.";
FW.L.GENERAL_TIPS2 = "按頂部的[defaults]按鈕,恢復到默認設置.";
FW.L.GENERAL_TIPS3 = "單擊框體標題欄切換顯示模式. ALT+拖拽移動框體.";
FW.L.GENERAL_TIPS4 = "顏色選項支援調整透明度,一般是背景顏色才有.";

FW.L.GENERAL_MO = "綜合模組選項";
FW.L.GENERAL_MO1 = "右擊標題欄設置框體";
FW.L.GENERAL_MO1_TT = "在框體標題欄右鍵點擊可以在右側顯示設置框體. 框體鎖定時無效.";
FW.L.GENERAL_MO2 = "改變時間顯示格式";
FW.L.GENERAL_MO2_TT = "將時間格式從30m變成29:59.";
FW.L.GENERAL_MO3 = "自動對齊";
FW.L.GENERAL_MO3_TT = "各模組框體在拖拽到一起時自動對齊.";
FW.L.GENERAL_MO4 = "自動對齊距離";
FW.L.GENERAL_MO4_TT = "自動對齊生效的最大距離.";
FW.L.GENERAL_MO5 = "框體間距";
FW.L.GENERAL_MO5_TT = "框體對齊後之間保持的距離.";

FW.L.GENERAL_MA = "綜合模組顯示";
FW.L.GENERAL_MA1_TT = "改變所有模組字體.";
FW.L.GENERAL_MA2_TT = "改變所有模組材質.";

FW.L.GENERAL_OA = "選項顯示";
FW.L.GENERAL_OA1 = "標題欄顏色";
FW.L.GENERAL_OA1_TT = "改變選項框體標題欄顏色.";
FW.L.GENERAL_OA2 = "背景顏色";
FW.L.GENERAL_OA2_TT = "改變選項框體背景顏色.";
FW.L.GENERAL_OA3 = "標題欄字體";
FW.L.GENERAL_OA3_TT = "設定選項視窗標題欄字體.";
FW.L.GENERAL_OA4 = "選項字體";
FW.L.GENERAL_OA4_TT = "設定選項字體.";

FW.L.PROFILES = "保存設置";
FW.L.PROFILES_HINT1 = "按人物保存設置檔, 插件會自動載入對應設置.";
FW.L.PROFILES_CURRENT = "當前設置文件";
FW.L.PROFILES_CURRENT_TT = "選擇設置檔. [delete current] 刪除當前設置 (選中).[create new] 將當前設置保存為輸入的設置名.";

FW.L.LOADING_DELAY = "正在讀入";
FW.L.UPDATE_INTERVAL_CORE = "更新間隔核心";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "更新動畫間隔";



-- ENGLISH
else	-- standard english version
	-- combat log, log string searches with %s spell name
	FW.L.WAS_RESISTED = "^Your %s was resisted";
	FW.L.WAS_EVADED = "^Your %s was evaded";
	FW.L.FAILED_IMMUNE = "^Your %s failed";
	FW.L.IS_REFLECTED = "^Your %s is reflected";

	FW.L.DOT_HIT = "^(.+) suffers .+ damage from your (.+)%.";
	FW.L.DOT_ABSORB = "^Your (.+) is absorbed by (.+)%.";
	FW.L.DIES = " dies.";

	--spell book
	FW.L.RANK = "Rank";
	FW.L.SPELL_RANK = "^Rank (%d+)$";
	
	FW.L.RITUAL_OF_SOULS = "Ritual of Souls";

	--items
	FW.L.MINOR_SS = "Minor Soulstone";
	FW.L.LESSER_SS = "Lesser Soulstone";
	FW.L.NORMAL_SS = "Soulstone";
	FW.L.GREATER_SS = "Greater Soulstone";
	FW.L.MAJOR_SS = "Major Soulstone";
	FW.L.MASTER_SS = "Master Soulstone";

	FW.L.MASTER_HS = "Master Healthstone";
	FW.L.MAJOR_HS = "Major Healthstone";
	FW.L.GREATER_HS = "Greater Healthstone";
	FW.L.NORMAL_HS = "Healthstone";
	FW.L.LESSER_HS = "Lesser Healthstone";
	FW.L.MINOR_HS = "Minor Healthstone";

	--zones
	FW.L.COILFANG_RESERVOIR = "Serpentshrine Cavern";
	--units
	FW.L.HELLFIRE_CHANNELER = "Hellfire Channeler"
	FW.L.GRAND_ASTROMANCER_CAPERNIAN = "Grand Astromancer Capernian";
	FW.L.LORD_SANGUINAR = "Lord Sanguinar"
	FW.L.MASTER_ENGINEER_TELONICUS = "Master Engineer Telonicus";
	FW.L.THALADRED_THE_DARKENER = "Thaladred the Darkener";
	FW.L.FATHOM_GUARD_SHARKKIS = "Fathom-Guard Sharkkis";
	FW.L.FATHOM_GUARD_CARIBDIS = "Fathom-Guard Caribdis";
	FW.L.FATHOM_GUARD_TIDALVESS = "Fathom-Guard Tidalvess";


-- THESE ARE INTERFACE STRINGS ONLY AND TRANSLATING THEM IS OPTIONAL

FW.L.UPDATE_NOW = "Update Now";
FW.L.LAST_CHECK = "\n\nLast check: %d seconds ago.";
FW.L.SCROLL_TO_ = "Scroll to ";

FW.L.POTION = "Potion";
FW.L.POWERUP = "Powerup";
FW.L.ITEM = "Item";
FW.L.PET = "Pet";
FW.L.SPELL = "Spell";
FW.L.HEALTHSTONE_NORMAL = "Healthstone";
FW.L.SOULWELL = "Soulwell";

-- commonly used
FW.L.USE_ = "Use %s";
FW.L.CREATE_ = "Create %s";
FW.L.LEFT_CLICK_TO_CREATE_ = "Left Click to create %s.";
FW.L.RIGHT_CLICK_TO_USE_ = "Right Click to use %s.";

FW.L.MASTER = "Master";
FW.L.MAJOR = "Major";
FW.L.GREATER = "Greater";
FW.L.NORMAL = "Normal";
FW.L.LESSER = "Lesser";
FW.L.MINOR = "Minor";

FW.L.YELLOW_STAR = "<Yellow Star>";
FW.L.ORANGE_CIRCLE = "<Orange Circle>";
FW.L.PRUPLE_DIAMOND = "<Purple Diamond>";
FW.L.GREEN_TRIANGLE = "<Green Triangle>";
FW.L.MOON = "<Moon>";
FW.L.BLUE_SQUARE = "<Blue Square>";
FW.L.CROSS = "<Cross>";
FW.L.SKULL = "<Skull>";

FW.L.FILTER_NONE = "normal";
FW.L.FILTER_IGNORE = "|cffff0000ignore|r";
FW.L.FILTER_COLOR = "|cff00ff00color|r";

FW.L.MODULE_NONE = "|cffff0000None|r";

FW.L.NOTARGET = "<No Target>";
FW.L.UNKNOWN = "<Unknown>";
FW.L.NOBODY = "<Nobody>"

FW.L.ENABLE  = "Enable";
FW.L.LOCK = "Lock (disable option functions)";
FW.L.EXPAND_UP = "Expand up";
FW.L.EXPAND_UP_TT = "Determines if the bar lists should be expanded upwards or downwards.";
FW.L.BAR_SPACING = "Bar spacing"
FW.L.COMBAT_HINT = "Some sizing changes you make here will only apply outside of combat.";
FW.L.ORA_HINT = "For people without ForteWarlock but with oRA, someone with FW has to be promoted.";

FW.L.DEAD = "Dead";
FW.L.OFFLINE = "Offline";
FW.L.CASTING = "Casting";
FW.L.CUSTOMIZE = "Customize";
FW.L.GENERAL = "General Options";
FW.L.ADVANCED = "Advanced Options";
FW.L.BASIC = "Basics";
FW.L.SPECIFIC = "Specifics";
FW.L.CORE = "Core";
FW.L.COLORING_FILTERING = "Coloring/Filtering";
FW.L.APPEARANCE = "Appearance";
FW.L.SIZING = "Sizing";
FW.L.SCALE = "Scale";
FW.L.BAR_HEIGHT = "Bar height";
FW.L.BAR_WIDTH = "Bar width";
FW.L.BAR = "Bar";
FW.L.FRAME_BACKGROUND = "Frame Background";
FW.L.BAR_TEXT = "Bar text";
FW.L.BAR_FONT = "Bar Font";
FW.L.BAR_TEXTURE = "Bar Texture";
FW.L.BAR_COLORING = "Bar Coloring";
FW.L.AUTO_HIDE = "Auto-hide outside party/raid";
FW.L.AUTO_HIDE_TT = "This will automatically hide the frame when not in a party or raid.";
FW.L.AUTO_MINIMIZE = "Auto-minimize outside party/raid";
FW.L.AUTO_MINIMIZE_TT = "This will automatically hide the bars when not in a party or raid.";
FW.L.SHOW_BARS = "Show bars";
FW.L.SHOW_BARS_TT = "Show the bars. You can hide them in case you only want to see the information on the header.";
FW.L.MAX_SHOWN = "Maximum shown";

FW.L.SELF_MESSAGES = "Self Messages";
FW.L.SELF_MESSAGES_HINT1 = "This allows you to display usefull messages to yourself. They are shown in your 'default' chat frame."
FW.L.RAID_MESSAGES = "Party/Raid Messages";
FW.L.RAID_MESSAGES_HINT1 = "This allows you to display messages to others based on spells you cast.";
FW.L.RAID_MESSAGES_HINT2 = "You can disable all messages to party/raid and/or channel, or every message separately.";
FW.L.SHOW_IN_RAID = "Show in party/raid (1st checkboxes)";
FW.L.SHOW_IN_RAID_TT = "Uncheck to stop any messages from being shown in your raid or party.";
FW.L.SHOW_IN_CHANNEL = "Show in channel (2nd checkboxes)";
FW.L.SHOW_IN_CHANNEL_TT = "Set the channel name or number in which you want some of your messages to be displayed. 'say' is also valid. Uncheck to stop any messages being shown in the channel.";

-- standard usage tips to append
FW.L.USE_FILTER = "First type in the item or spell that you want to change (auto-fills). Then you can select if you want to show it normally (normal), hide it (ignore) or change its color (color). If you selected you want to change the color, you get a color picker from clicking square on the right.";
FW.L.USE_COLOR_PICKER = "Click the colored square to open up the color picker. If there's a slider on the right, you can also change the transparency.";
FW.L.USE_TEXTURE = "Mouse over the left textured bar and select a texture from the dropdown menu. You can also use any other texture by giving its path."
FW.L.USE_FONT = "Mouse over the left font area and select a font from the dropdown menu. The center editbox can be used to change the font size. You can also use any other font by giving its path.";
FW.L.USE_EDITBOX = "Don't forget you have to press enter to confirm changes to the editboxes!";
FW.L.USE_MSG2 = "The first checkbox will enable this message in your party or raid. The second checkbox will enable it in the channel you set above.";

FW.L.DEFAULT = "[default]";
FW.L.DEFAULTS = "[defaults]";
FW.L.POSITION = "[position]";

-- all the other text and tips belonging to core itself
FW.L.ADVANCED_HINT1 = "You will usually not have to change anything here. It's only for problem solving.";
FW.L.ADVANCED_HINT2 = "Changes to 'update intervals' only apply after reloading.";

FW.L.GENERAL_TIPS = "Some Tips";
FW.L.GENERAL_TIPS1 = "Press enter to confirm changes to editboxes. Escape will restore its current setting.";
FW.L.GENERAL_TIPS2 = "You can use the [defaults] button in the headers to restore every default in this category.";
FW.L.GENERAL_TIPS3 = "Left-click frame headers to toggle between display modes. ALT+drag frame headers to move.";
FW.L.GENERAL_TIPS4 = "Some color options also allow for transparency changing. Usually the background colors.";

FW.L.GENERAL_MO = "General Module Options";
FW.L.GENERAL_MO1 = "Right-click headers for options";
FW.L.GENERAL_MO1_TT = "You can right-click the module frame headers to open the options menu at the right position. Will only work for frames that aren't fully locked.";
FW.L.GENERAL_MO2 = "Alternate time format";
FW.L.GENERAL_MO2_TT = "Change the time format from 30m to 29:59.";
FW.L.GENERAL_MO3 = "Enable frame snapping";
FW.L.GENERAL_MO3_TT = "The module frames will allign to each other's borders when dragged.";
FW.L.GENERAL_MO4 = "Frame snapping distance";
FW.L.GENERAL_MO4_TT = "The distance frame borders must be from each other to allign.";
FW.L.GENERAL_MO5 = "Frame spacing";
FW.L.GENERAL_MO5_TT = "The distance to keep between frames when they are alligned.";

FW.L.GENERAL_MA = "General Module Appearance";
FW.L.GENERAL_MA1_TT = "Change the Bar Font for ALL module frames.";
FW.L.GENERAL_MA2_TT = "Change the Bar Texture for ALL module frames.";

FW.L.GENERAL_OA = "Options Appearance";
FW.L.GENERAL_OA1 = "Header Color";
FW.L.GENERAL_OA1_TT = "Change the Header Color of the option frames.";
FW.L.GENERAL_OA2 = "Background Color";
FW.L.GENERAL_OA2_TT = "Change the Background Color of the option frames.";
FW.L.GENERAL_OA3 = "Headers";
FW.L.GENERAL_OA3_TT = "Change the font the options headers are displayed in.";
FW.L.GENERAL_OA4 = "Options";
FW.L.GENERAL_OA4_TT = "Change the font the options are displayed in.";

FW.L.PROFILES = "Profiles";
FW.L.PROFILES_HINT1 = "If you name profiles after your characters, the addon will automatically load the right profile.";
FW.L.PROFILES_CURRENT = "Current Profile";
FW.L.PROFILES_CURRENT_TT = "Select the profile you want to use. [delete current] deletes the profile you are currently using (have selected). [create new] copies your current settings to a new profile with the name you entered or replaces one.";

FW.L.LOADING_DELAY = "Loading delay";
FW.L.UPDATE_INTERVAL_CORE = "Update interval core";
FW.L.UPDATE_INTERVAL_ANIMATIONS = "Update interval animations";



end
--[[
if GetLocale() == "zhCN" then
	FW:RegisterFont("Fonts\\ZYHei.TTF","???");
	FW:RegisterFont("Fonts\\ZYKai_T.TTF","???");
	FW:SetDefaultFont("Fonts\\ZYHei.TTF",10);

elseif GetLocale() == "zhTW" then
	FW:RegisterFont("Fonts\\bLEI00D.TTF","????");
	FW:RegisterFont("Fonts\\bHEI01B.TTF","????");
	FW:SetDefaultFont("Fonts\\bLEI00D.TTF",10);
end
]]



FW:LocalizedData();

