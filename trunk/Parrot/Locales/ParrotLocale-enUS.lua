-- $Rev: 431 $

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot")
L:AddTranslations("enUS", function() return {
		["Parrot"] = true,
		["Floating Combat Text of awesomeness. Caw. It'll eat your crackers."] = true,
		["Inherit"] = true,
		["Parrot Configuration"] = true,
		["Waterfall-1.0 is required to access the GUI."] = true,
		["General"] = true,
		["General settings"] = true,
		["Game damage"] = true,
		["Whether to show damage over the enemy's heads."] = true,
		["Game healing"] = true,
		["Whether to show healing over the enemy's heads."] = true,
		["|cffffff00Left-Click|r to change settings with a nice GUI configuration."] = true,
		["|cffffff00Right-Click|r to change settings with a drop-down menu."] = true,
		["Show guardian events"] = true,
		["Whether events involving your guardian(s) (totems, ...) should be displayed"] =  true,
}end)

local L_CombatEvents = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents")
L_CombatEvents:AddTranslations("enUS", function() return {
		["[Text] (crit)"] = true,
		["[Text] (crushing)"] = true,
		["[Text] (glancing)"] = true,
		[" ([Amount] absorbed)"] = true,
		[" ([Amount] blocked)"] = true,
		[" ([Amount] resisted)"] = true,
		[" ([Amount] vulnerable)"] = true,
		[" ([Amount] overheal)"] = true,
		["Events"] = true,
		["Change event settings"] = true,
		["Incoming"] = true,
		["Incoming events are events which a mob or another player does to you."] = true,
		["Outgoing"] = true,
		["Outgoing events are events which you do to a mob or another player."] = true,
		["Notification"] = true,
		["Notification events are available to notify you of certain actions."] = true,
		["Event modifiers"] = true,
		["Options for event modifiers."] = true,
		["Color"] = true,
		["Whether to color event modifiers or not."] = true,
		["Damage types"] = true,
		["Options for damage types."] = true,
		["Whether to color damage types or not."] = true,
		["Sticky crits"] = true,
		["Enable to show crits in the sticky style."] = true,
		["Throttle events"] = true,
		["Whether to merge mass events into single instances instead of excessive spam."] = true,
		["Filters"] = true,
		["Filters to be checked for a minimum amount of damage/healing/etc before showing."] = true,
		["Shorten spell names"] = true,
		["How or whether to shorten spell names."] = true,
		["Style"] = true,
		["How or whether to shorten spell names."] = true,
		["None"] = true,
		["Abbreviate"] = true,
		["Truncate"] = true,
		["Do not shorten spell names."] = true,
		["Gift of the Wild => GotW."] = true,
		["Gift of the Wild => Gift of t..."] = true,
		["Length"] = true,
		["The length at which to shorten spell names."] = true,
		["Critical hits/heals"] = true,
		["Crushing blows"] = true,
		["Glancing hits"] = true,
		["Partial absorbs"] = true,
		["Partial blocks"] = true,
		["Partial resists"] = true,
		["Vulnerability bonuses"] = true,
		["Overheals"] = true,
		["<Text>"] = true,
		["Enabled"] = true,
		["Whether to enable showing this event modifier."] = true,
		["What color this event modifier takes on."] = true,
		["Text"] = true,
		["What text this event modifier shows."] = true,
		["Physical"] = true,
		["Holy"] = true,
		["Fire"] = true,
		["Nature"] = true,
		["Frost"] = true,
		["Shadow"] = true,
		["Arcane"] = true,
		["What color this damage type takes on."] = true,
		["Inherit"] = true,
		["Thin"] = true,
		["Thick"] = true,
		["<Tag>"] = true,
		["Uncategorized"] = true,
		["Tag"] = true,
		["Tag to show for the current event."] = true,
		["Color of the text for the current event."] = true,
		["Sound"] = true,
		["What sound to play when the current event occurs."] = true,
		["Sticky"] = true,
		["Whether the current event should be classified as \"Sticky\""] = true,
		["Custom font"] = true,
		["Font face"] = true,
		["Inherit font size"] = true,
		["Font size"] = true,
		["Font outline"] = true,
		["Enable the current event."] = true,
		["Scroll area"] = true,
		["Which scroll area to use."] = true,
		["What timespan to merge events within.\nNote: a time of 0s means no throttling will occur."] = true,
		["What amount to filter out. Any amount below this will be filtered.\nNote: a value of 0 will mean no filtering takes place."] = true,
		["The amount of damage absorbed."] = true,
		["The amount of damage blocked."] = true,
		["The amount of damage resisted."] = true,
		["The amount of vulnerability bonus."] = true,
		["The amount of overhealing."] = true,
		["The normal text."] = true,
}end)

local L_Display = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Display")
L_Display:AddTranslations("enUS", function() return {
		["None"] = true,
		["Thin"] = true,
		["Thick"] = true,
		["Text transparency"] = true,
		["How opaque/transparent the text should be."] = true,
		["Icon transparency"] = true,
		["How opaque/transparent icons should be."] = true,
		["Enable icons"] = true,
		["Set whether icons should be enabled or disabled altogether."] = true,
		["Master font settings"] = true,
		["Normal font"] = true,
		["Normal font face."] = true,
		["Normal font size"] = true,
		["Normal outline"] = true,
		["Sticky font"] = true,
		["Sticky font face."] = true,
		["Sticky font size"] = true,
		["Sticky outline"] = true,
	
}end)

local L_ScrollAreas = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_ScrollAreas")
L_ScrollAreas:AddTranslations("enUS", function() return {
		["Incoming"] = true,
		["Outgoing"] = true,
		["Notification"] = true,
		["New scroll area"] = true,
		["Inherit"] = true,
		["None"] = true,
		["Thin"] = true,
		["Thick"] = true,
		["Left"] = true,
		["Right"] = true,
		["Disable"] = true,
		["Options for this scroll area."] = true,
		["Name"] = true,
		["Name of the scroll area."] = true,
		["<Name>"] = true,
		["Remove"] = true,
		["Remove this scroll area."] = true,
		["Icon side"] = true,
		["Set the icon side for this scroll area or whether to disable icons entirely."] = true,
		["Test"] = true,
		["Send a test message through this scroll area."] = true,
		["Normal"] = true,
		["Send a normal test message."] = true,
		["Sticky"] = true,
		["Send a sticky test message."] = true,
		["Direction"] = true,
		["Which direction the animations should follow."] = true,
		["Direction for normal texts."] = true,
		["Direction for sticky texts."] = true,
		["Animation style"] = true,
		["Which animation style to use."] = true,
		["Animation style for normal texts."] = true,
		["Animation style for sticky texts."] = true,
		["Position: horizontal"] = true,
		["The position of the box across the screen"] = true,
		["Position: vertical"] = true,
		["The position of the box up-and-down the screen"] = true,
		["Size"] = true,
		["How large of an area to scroll."] = true,
		["Scrolling speed"] = true,
		["How fast the text scrolls by."] = true,
		["Seconds for the text to complete the whole cycle, i.e. larger numbers means slower."] = true,
		["Custom font"] = true,
		["Normal font face"] = true,
		["Normal inherit font size"]  = true,
		["Normal font size"] = true,
		["Normal font outline"] = true,
		["Sticky font face"] = true,
		["Sticky inherit font size"] = true,
		["Sticky font size"] = true,
		["Sticky font outline"] = true,
		["Click and drag to the position you want."]  = true,
		["Scroll area: %s"] = true,
		["Position: %d, %d"] = true,
		["Scroll areas"] = true,
		["Options regarding scroll areas."] = true,
		["Configuration mode"] = true,
		["Enter configuration mode, allowing you to move around the scroll areas and see them in action."] = true,
		["New scroll area"] = true,
		["Add a new scroll area."] = true,
		["Center of screen"] = true,
		["Edge of screen"] = true,
		["Create"] = true,
		["Are you sure?"] = true,
		["Send"] = true,
}end)

local L_Suppressions = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Suppressions")
L_Suppressions:AddTranslations("enUS", function() return {
		["New suppression"] = true,
		["Edit"] = true,
		["Edit search string"] = true,
		["<Any text> or <Lua search expression>"] = true,
		["Lua search expression"] = true,
		["Whether the search string is a lua search expression or not."] = true,
		["Remove"] = true,
		["Remove suppression"] = true,
		["Suppressions"] = true,
		["List of strings that will be squelched if found."] = true,
		["Add a new suppression."] = true,
		["Create"] = true,
		["Are you sure?"] = true,
}end)

local L_Triggers = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Triggers")
L_Triggers:AddTranslations("enUS", function() return {
		["%s!"] = true,
		["Low Health!"] = true,
		["Low Mana!"] = true,
		["Low Pet Health!"] = true,
		["Free %s!"] = true,
		["Trigger cooldown"] = true,
		["Check every XX seconds"] = true,
		["Triggers"] = true,
		["New trigger"] = true,
		["Create a new trigger"] = true,
		["Inherit"] = true,
		["None"] = true,
		["Thin"] = true,
		["Thick"] = true,
		["Druid"] = true,
		["Rogue"] = true,
		["Shaman"] = true,
		["Paladin"] = true,
		["Mage"] = true,
		["Warlock"] = true,
		["Priest"] = true,
		["Warrior"] = true,
		["Hunter"] = true,
		["Output"] = true,
		["The text that is shown"] = true,
		['<Text to show>'] = true,
		["Icon"] = true,
		["The icon that is shown"] = true,
		['<Spell name> or <Item name> or <Path> or <SpellId>'] = true,
		["Enabled"] = true,
		["Whether the trigger is enabled or not."] = true,
		["Remove trigger"] = true,
		["Remove this trigger completely."] = true,
		["Color"] = true,
		["Color of the text for this trigger."] = true,
		["Sticky"] = true,
		["Whether to show this trigger as a sticky."] = true,
		["Classes"] = true,
		["Classes affected by this trigger."] = true,
		["Scroll area"] = true,
		["Which scroll area to output to."] = true,
		["Sound"] = true,
		["What sound to play when the trigger is shown."] = true,
		["Test"] = true,
		["Test how the trigger will look and act."] = true,
		["Custom font"] = true,
		["Font face"] = true,
		["Inherit font size"] = true,
		["Font size"] = true,
		["Font outline"] = true,
		["Primary conditions"] = true,
		["When any of these conditions apply, the secondary conditions are checked."] = true,
		["New condition"] = true,
		["Add a new primary condition"] = true,
		["Remove condition"] = true,
		["Remove a primary condition"] = true,
		["Secondary conditions"] = true,
		["When all of these conditions apply, the trigger will be shown."] = true,
		["Add a new secondary condition"] = true,
		["Remove a secondary condition"] = true,
		["Create"] = true,
		["Remove"] = true,
		["Are you sure?"] = true,

}end)

local L_AnimationStyles = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_AnimationStyles")
L_AnimationStyles:AddTranslations("enUS", function() return {
		["Straight"] = true,
		["Up, left-aligned"] = true,
		["Up, right-aligned"] = true,
		["Up, center-aligned"] = true,
		["Down, left-aligned"] = true,
		["Down, right-aligned"] = true,
		["Down, center-aligned"] = true,
		["Parabola"] = true,
		["Up, left"] = true,
		["Up, right"] = true,
		["Up, alternating"] = true,
		["Down, left"] = true,
		["Down, right"] = true,
		["Down, alternating"] = true,
		["Semicircle"] = true,
		["Pow"] = true,
		["Static"] = true,
		["Rainbow"] = true,
		["Horizontal"] = true,
		["Left"] = true,
		["Right"] = true,
		["Alternating"] = true,
		["Action"] = true,
		["Action Sticky"] = true,
		["Angled"] = true,
		["Sprinkler"] = true,
		["Up, clockwise"] = true,
		["Down, clockwise"] = true,
		["Left, clockwise"] = true,
		["Right, clockwise"] = true,
		["Up, counter-clockwise"] = true,
		["Down, counter-clockwise"] = true,
		["Left, counter-clockwise"] = true,
		["Right, counter-clockwise"] = true,

}end)

local L_Auras = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Auras")
L_Auras:AddTranslations("enUS", function() return {
		["Auras"] = true,
		["Debuff gains"] = true,
		["The name of the debuff gained."] = true,
		["Buff gains"] = true,
		["The name of the buff gained."] = true,
		["Item buff gains"] = true,
		["The name of the item buff gained."] = true,
		["The name of the item, the buff has been applied to."] = true,
		--["The rank of the item buff gained."] = true, -- not used anymore
		["Debuff fades"] = true,
		["The name of the debuff lost."] = true,
		["Buff fades"] = true,
		["The name of the buff lost."] = true,
		["Item buff fades"] = true,
		["The name of the item buff lost."] = true,
		["The name of the item, the buff has faded from."] = true,
		-- ["The rank of the item buff lost."] = true, -- not used anymore
		
		["Self buff gain"] = true,
		["<Buff name>"] = true,
		["Self buff fade"] = true,
		["Self debuff gain"] = true,
		["<Debuff name>"] = true,
		["Self debuff fade"] = true,
		["Self item buff gain"] = true,
		["<Item buff name>"] = true,
		["Self item buff fade"] = true,
		["Target buff gain"] = true,
		["Target debuff gain"] = true,
		["Buff inactive"] = true,
		["Buff active"] = true,
		["Focus buff gain"] = true,
		["Focus debuff gain"] = true,
		["Target buff fade"] = true,
		["Target debuff fade"] = true,
		["Focus buff fade"] = true,
		["Focus debuff fade"] = true,
		["Buff stack gains"] = true,
		["Debuff stack gains"] = true,
		["New Amount of stacks of the buff."] = true,
		["New Amount of stacks of the debuff."] = true,
		["The name of the unit that gained the buff."] = true,
		["Target buff stack gains"] = true,
		["Target buff gains"] = true,
		
}end)

local L_CombatEvents_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatEvents_Data")
L_CombatEvents_Data:AddTranslations("enUS", function() return {
		["Incoming damage"] = true,
		["Melee damage"] = true,
		["Melee"] = true,
		["The name of the enemy that attacked you."] = true,
		["The amount of damage done."] = true,
		[" (%d hit, %d crit)"] = true,
		[" (%d hit, %d crits)"] = true,
		[" (%d hits, %d crit)"] = true,
		[" (%d hits, %d crits)"] = true,
		[" (%d crits)"] = true,
		[" (%d hits)"] = true,
		["Multiple"] = true,
		["Melee misses"] = true,
		["Miss!"] = true,
		["Melee dodges"] = true,
		["Dodge!"] = true,
		["Melee parries"] = true,
		["Parry!"] = true,
		["Melee blocks"] = true,
		["Block!"] = true,
		["Melee absorbs"] = true,
		["Absorb!"] = true,
		["Melee immunes"] = true,
		["Immune!"] = true,
		["Melee evades"] = true,
		["Evade!"] = true,
		["Skills"] = true,
		["Skill damage"] = true,
		["The type of damage done."] = true,
		["The spell or ability that the enemy attacked you with."] = true,
		["DoTs and HoTs"] = true,
		["Skill DoTs"] = true,
		["Reactive skills"] = true,
		["Ability misses"] = true,
		["Ability dodges"] = true,
		["Ability parries"] = true,
		["Ability blocks"] = true,
		["Spell resists"] = true,
		["Resist!"] = true,
		["Skill absorbs"] = true,
		["Skill immunes"] = true,
		["Skill reflects"] = true,
		["Reflect!"] = true,
		["Skill interrupts"] = true,
		["Interrupt!"] = true,
		["Incoming heals"] = true,
		["Heals"] = true,
		["The name of the ally that healed you."] = true,
		["The spell or ability that the ally healed you with."] = true,
		["The amount of healing done."] = true,
		[" (%d heal, %d crit)"] = true,
		[" (%d heal, %d crits)"] = true,
		[" (%d heals, %d crit)"] = true,
		[" (%d heals, %d crits)"] = true,
		[" (%d heals)"] = true,
		["Heals over time"] = true,
		["Environmental damage"] = true,
		["Outgoing damage"] = true,
		["The name of the enemy you attacked."] = true,
		["The spell or ability that you used."] = true,
		["Skill evades"] = true,
		["Outgoing heals"] = true,
		["The name of the ally you healed."] = true,
		["Pet melee"] = true,
		["Pet melee damage"] = true,
		["(Pet) -[Amount]"] = true,
		["(Pet) +[Amount]"] = true,
		["Pet heals"] = true,
		["The name of the enemy your pet attacked."] = true,
		["Pet melee misses"] = true,
		["Pet Miss!"] = true,
		["Pet melee dodges"] = true,
		["Pet Dodge!"] = true,
		["Pet melee parries"] = true,
		["Pet Parry!"] = true,
		["Pet melee blocks"] = true,
		["Pet Block!"] = true,
		["Pet melee absorbs"] = true,
		["Pet Absorb!"] = true,
		["Pet melee immunes"] = true,
		["Pet Immune!"] = true,
		["Pet melee evades"] = true,
		["Pet Evade!"] = true,
		["Pet skills"] = true,
		["Pet skill"] = true,
		["Pet skill damage"] = true,
		["Pet [Amount] ([Skill])"] = true,
		["The ability or spell your pet used."] = true,
		["Pet ability misses"] = true,
		["Pet ability dodges"] = true,
		["Pet ability parries"] = true,
		["Pet ability blocks"] = true,
		["Pet spell resists"] = true,
		["Pet Resist!"] = true,
		["Pet skill absorbs"] = true,
		["Pet skill immunes"] = true,
		["Pet skill reflects"] = true,
		["Pet Reflect!"] = true,
		["Pet skill evades"] = true,
		["Pet heals over time"] = true,
		["Combat status"] = true,
		["Enter combat"] = true,
		["Leave combat"] = true,
		["Power gain/loss"] = true,
		["Power change"] = true,
		["Power gain"] = true,
		["+[Amount] [Type]"] = true,
		["The amount of power gained."] = true,
		["The type of power gained (Mana, Rage, Energy)."] = true,
		["The ability or spell used to gain power."] = true,
		["The character that the power comes from."] = true,
		[" (%d gains)"] = true,
		["Power loss"] = true,
		["-[Amount] [Type]"] = true,
		["The amount of power lost."] = true,
		["The type of power lost (Mana, Rage, Energy)."] = true,
		["The ability or spell take away your power."] = true,
		["The character that caused the power loss."] = true,
		[" (%d losses)"] = true,
		["Combo points"] = true,
		["Combo point gain"] = true,
		["[Num] CP"] = true,
		["The current number of combo points."] = true,
		["Combo points full"] = true,
		["[Num] CP Finish It!"] = true,
		["Honor gains"] = true,
		["The amount of honor gained."] = true,
		["The name of the enemy slain."] = true,
		["The rank of the enemy slain."] = true,
		["Reputation"] = true,
		["Reputation gains"] = true,
		["The amount of reputation gained."] = true,
		["The name of the faction."] = true,
		["Reputation losses"] = true,
		["The amount of reputation lost."] = true,
		["Skill gains"] = true,
		["The skill which experienced a gain."] = true,
		["The amount of skill points currently."] = true,
		["Experience gains"] = true,
		["The name of the enemy slain."] = true,
		["The amount of experience points gained."] = true,
		["Killing blows"] = true,
		["Player killing blows"] = true,
		["Killing Blow!"] = true,
		["The spell or ability used to slay the enemy."] = true,
		["NPC killing blows"] = true,
		["Soul shard gains"] = true,
		["The name of the soul shard."] = true,
		["Extra attacks"] = true,
		["%s!"] = true,
		["The name of the spell or ability which provided the extra attacks."] = true,
		["Self heals"] = true,
		["Self heals over time"] = true,
		["Pet skill DoTs"] = true,
		["Skill you were interrupted in casting"] = true,
		["The spell you interrupted"] = true,
		-- Schools
		["Physical"] = true,
		["Holy"] = true,
		["Fire"] = true,
		["Nature"] = true,
		["Frost"] = true,
		["Shadow"] = true,
		["Arcane"] = true,
		
		["The name of the enemy that attacked your pet."] = true,
		["The spell or ability that the enemy attacked your pet with."] = true,
		["The name of the ally that healed your pet."] = true,
		["The spell or ability that the ally healed your pet with."] = true,
		["The spell or ability that your pet used."] = true,
		["The name of the unit that your pet healed."] = true,
		["The spell or ability that the pet used to heal."] = true,
}end)

local L_Cooldowns = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Cooldowns")
L_Cooldowns:AddTranslations("enUS", function() return {
		["Cooldowns"] = true,
		["Skill cooldown finish"] = true,
		["[[Skill] ready!]"] = true,
		["The name of the spell or ability which is ready to be used."] = true,
		["Traps"] = true,
		["Shocks"] = true,
		["Divine Shield"] = true,
		["%s Tree"] = true,
		["Spell ready"] = true,
		["Spell usable"] = true,
		["<Spell name>"] = true,
}end)

local L_Loot = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_Loot")
L_Loot:AddTranslations("enUS", function() return {
		["Loot"] = true,
		["Loot items"] = true,
		["Loot [Name] +[Amount]([Total])"] = true,
		["The name of the item."] = true,
		["The amount of items looted."] = true,
		["The total amount of items in inventory."] = true,
		["Loot money"] = true,
		["Loot +[Amount]"] = true,
		["The amount of gold looted."] = true,

}end)

local L_TriggerConditions_Data = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_TriggerConditions_Data")
L_TriggerConditions_Data:AddTranslations("enUS", function() return {
	-- Parrot_TriggerConditions_Data
		["Enemy target health percent"] = true,
		["Friendly target health percent"] = true,
		["Self health percent"] = true,
		["Self mana percent"] = true,
		["Pet health percent"] = true,
		["Pet mana percent"] = true,
		["Incoming block"] = true,
		["Incoming crit"] = true,
		["Incoming dodge"] = true,
		["Incoming parry"] = true,
		["Outgoing block"] = true,
		["Outgoing crit"] = true,
		["Outgoing dodge"] = true,
		["Outgoing parry"] = true,
		["Outgoing cast"] = true,
		["<Skill name>"] = true,
		["Incoming cast"] = true,
		["Minimum power amount"] = true,
		["Warrior stance"] = true,
		["Not in warrior stance"] = true,
		["Druid Form"] = true,
		["Not in Druid Form"] = true,
}end)

local L_CombatStatus = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Parrot_CombatStatus")
L_CombatStatus:AddTranslations("enUS", function() return {
		["Combat status"] = true,
		["Enter combat"] = true,
		["+Combat"] = true,
		["Leave combat"] = true,
		["-Combat"] = true,
		["In combat"] = true,
		["Not in combat"] = true,
}end)