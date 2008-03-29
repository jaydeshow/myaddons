local L = AceLibrary("AceLocale-2.2"):new("FuBar_WhisperFu")

L:RegisterTranslations("enUS", function() return {
	["On"] = true,
	["Off"] = true,
	["Spam Blocker:"] = true,
	["Blocked Messages:"] = true,

	["Whisper"] = true,

	["Options"] = true,
	["Colours"] = true,
	["Set the Text Colours"] = true,

	["Send Colour"] = true,
	["Sets the color of text for whispers sent"] = true,

	["Receive Colour"] = true,
	["Sets the color of text for whispers receieved"] = true,

	["HintText"] = "|cffeda55fClick|r to start a whisper to this person.\n|cffeda55fAlt-Click|r to invite this person to your group.\n|cffeda55fShift-Click|r to do a who on this person.\n|cffeda55fControl-Click|r to purge all whispers.",
	["PlayerDesc"] = "Whispers sent/received from %s",
	["WhisperDesc"] = "Start a whisper to %s",

	["Purge"] = "Purge all whispers",
	["PurgeDesc"] = "Clears the addon's entire set of whispers stored",

	["Player Limit"] = true,
	["Maximum number of players to store messages for."] = true,

	["Message Limit"] = true,
	["Maximum number of messages to store per player."] = true,

	["Wrap Length"] = true,
	["Wrap messages longer than this number of characters."] = true,

	["Show Times"] = true,
	["Show time of whispers in tooltip."] = true,

	["Show Menu Times"] = true,
	["Show time of whispers in menus."] = true,

	["Play Whisper Sound"] = true,
	["Play a sound each time you receive a message."] = true,

	["Show Hint"] = true,
	["Show hint at the bottom of the tooltip."] = true,

	--["Spam"] = true,
	--["Spam Settings"] = true,

	["Spam"] = true,
	["View blocked spam messages."] = true,

	["Spam Options"] = true,
	["Spam blocking options."] = true,

	["-Report this user-"] = true,
	["Report this user as a spammer and attempt to get justice for their griefing!"] = true,
	["Are you sure you want to report %s?"] = true,

	[" was not found."] = true,
	["I am reporting the user %s for attempting to sell me gold or leveling service for real money.  The following are messages captured, quoting the user's violation of WoW TOS:\n\n"] = true,
	["You already have a GM ticket open."] = true,

	["Block Spam"] = true,
	["Block incoming spam messages."] = true,

	["Play Spam Sound"] = true,
	["Play a sound each time WhisperFu catches a spam message."] = true,

	["Show Spams This Session"] = true,
	["Shows a counter in the addon title for spams blocked this session."] = true,

	["Reset Spam Tally"] = true,
	["Resets intercepted spam tally to 0.\nCurrent tally is %d."] = true,

	["Delete Spam Log"] = true,
	["Deletes all of your spam messages"] = true,
	["Spam Log has been cleared."] = true,

	["Keyword Options"] = true,

	["Add Keyword"] = true,
	["Add a new keyword to ignore."] = true,
	[" already exists."] = true,

	["Add Keyword Group"] = true,
	["Add a new keyword group to ignore.\nEx: To ignore any messages with the words: \"join\" and \"guild\" you would enter: \"join^guild^\""] = true,
	["Enter a keyword group to ignore"] = true,
	["word1^word2^etc^"] = true,
	["That intelligent key group already exists"] = true,
    
    ["Found an old spam message, spam log is being reset to update to new system."] = true,
	["Generating GM ticket for: "] = true,

	["Reinstate Keyword Defaults"] = true,
	["This will reinstate the default keywords while keeping any you've added intact."] = true,

	["Reinstate Keyword Group Defaults"] = true,
	["This will reinstate the default keyword groups while keeping any you've added intact."] = true,

	["Remove Keyword(s)"] = true,
	["Click a keyword to remove it from the spam list.\nCurrent keyword total: %s"] = true,

	["Remove Keyword Group"] = true,
	["Click a keyword group to remove it from the spam list.\nCurrent keyword group total: %s"] = true,

	["Remove keyword: "] = true,
	["Remove keyword group: "] = true,

	["Enter a keyword to ignore"] = true,
	["New Keyword"] = true,
	["Please enter a valid keyword"] = true,

	["Delete All Spam Key Groups"] = true,
	["|cffff3333!This will purge all spam key groups!|r\nYou should not do this unless you are planning on reinstating keyword group defaults afterwards."] = true,
	["Are you sure you want to purge all of your keywords?"] = true,

	["Delete All Spam Keys"] = true,
	["|cffff3333!This will purge all spam keys!|r\nYou should not do this unless you are planning on reinstating keyword defaults afterwards."] = true,
	["Are you sure you want to purge all of your keyword groups?"] = true
} end)
