/////////////////////////////////////////////////////////////////////
// 	               Author: The Blue Templar 		   //
// 	    Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Gameplay Settings 
local page = ::TLW.Mod.ModSettings.addPage("Gameplay");
page.addTitle("title", "Gameplay Settings");
page.addTitle("title2", "Main - Default Values Recommended");
page.addDivider("divider");

/*::TLW.EnableEnemyMutationID <- "EnableEnemyMutation"
local settingEnableEnemyMutation = page.addBooleanSetting(::TLW.EnableEnemyMutationID, true, "Enemy Mutations", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Recommended to keep this on, as it is a core mechanic of PoV.[/color] \n\n All enemies may get various thematic and appropriate mutations, making them stronger and creating interesting adaptive gameplay.\n\n The enemies that get a mutation also have a very low chance to drop relevant mutagens.\n\n Also enables some events, items and traits related to mutated enemies. All chances scale with combat difficulty and enemy strength \n\n [color=" + this.Const.UI.Color.povPainEffect + "] DISABLING THIS WONT CHANGE ANYTHING CURRENTLY [/color] - Enemy mutations will appear normally.");*/
::TLW.EnemyMutationScalingID <- "EnemyMutationScaling"
local settingEnemyMutationScaling = page.addBooleanSetting(::TLW.EnemyMutationScalingID, true, "Enemy Mutations Scaling", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Scales the Enemy Mutations based on passed ingame days. Recommended to keep on, unless you have many other mods making late game more difficult.[/color] \n\n An attempt at keeping the endgame challenging - Enemy Mutations will appear more often on enemies, as the playthrough becomes longer. \n\n With chaos mode enabled, mutations will start appearing much less at the beginning, but over time their frequency will increase by a lot!");
::TLW.ChaosID <- "ChaosMode"
local settingChaos = page.addBooleanSetting(::TLW.ChaosID, false, "Chaos Mode", "[color=" + this.Const.UI.Color.povTooltipBlue + "]PoV is not balanced around this mode, it is only meant as a fun \"Challenge\". Off by default. [/color] \n\n All enemies can have multiple mutations, selected randomly from all of PoV\'s possible effects. Mutagen drop rates from enemy mutants will be lowered. \n\n Recommended to enable \"Enemy Mutations Scaling\" if you enable chaos mode.\n\n [b][color=" + this.Const.UI.Color.NegativeValue + "]MAY CHAOS TAKE THE WORLD![/color][/b]");


page.addTitle("title3", "Customization - Tweaks");
page.addDivider("divider2");

::TLW.McTweaksID <- "McTweaks"
local settingMcTweaks = page.addBooleanSetting(::TLW.McTweaksID, false, "MC Tweaks", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Optional tweaks to the \"Magic Concept\" mod[/color] \n\n Secondary option, off by default. Enables minor tweaks for better balance between MC and PoV, and removes an annoying enemy ability or two. Look at the PoV server for details.\n\n Will only work with the MC mod installed. Not recommended to turn on and off multiple times during a save.");

::TLW.FotnTweaksID <- "FotnTweaks"
local settingFotnTweaks = page.addBooleanSetting(::TLW.FotnTweaksID, false, "FotN Tweaks", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Optional tweaks to the \"Fury of the Northmen\" mod[/color] \n\n Secondary option, off by default. Enables minor tweaks for better balance between PoV and FotN, mainly messing with some new enemies.\n\n Will only work with the FotN mod installed. Not recommended to turn on and off multiple times during a save.");

::TLW.SSUTweaksID <- "SSUTweaks"
local settingSSUTweaks = page.addBooleanSetting(::TLW.SSUTweaksID, false, "SSU Tweaks", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Optional tweaks to the \"Fury of the Northmen\" mod[/color] \n\n Secondary option, off by default. Enables minor tweaks for better balance between PoV and SSU. Removes sequences (drops,shop and effects) from players and enemies. \n\n Will only work with the SSU mod installed. Not recommended to turn on and off multiple times during a save. \n\n [color=" + this.Const.UI.Color.NegativeValue + "]Only toggle in main menu before a new game --- Requires Restart![/color]");

//Callbacks
/*settingEnableEnemyMutation.addCallback(function(_newValue)
{
        // Setting Always Enabled
	::TLW.EnableEnemyMutation = true
})*/
settingEnemyMutationScaling.addCallback(function(_newValue)
{
    ::TLW.EnemyMutationScaling = _newValue
})
settingChaos.addCallback(function(_newValue)
{
        ::TLW.ChaosMode = _newValue
})
settingMcTweaks.addCallback(function(_newValue)
{
    ::TLW.McTweaks = _newValue
})
settingFotnTweaks.addCallback(function(_newValue)
{
    ::TLW.FotnTweaks = _newValue
})
settingSSUTweaks.addCallback(function(_newValue)
{
    ::TLW.SSUTweaks = _newValue
})

// Misc Settings  
local page = ::TLW.Mod.ModSettings.addPage("Misc");
page.addTitle("title", "Misc Settings");
page.addDivider("divider");

::TLW.EnableMainMenuArtID <- "EnableMainMenuArt"
local settingEnableMainMenuArt = page.addBooleanSetting(::TLW.EnableMainMenuArtID, true, "PoV Main Menu Art", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Toggle the display of PoV's main menu art.[/color] \n\n Disable this if you want another mod's or Vanilla art. Immediately works, no restart required. \n\n [color=" + this.Const.UI.Color.povPainEffect + "]Only toggle this while in the main menu screen. It will not work if you toggle ingame.[/color]");

::TLW.EnablePovIntroEventID <- "EnablePovIntroEvent"
local settingEnablePovIntroEvent = page.addBooleanSetting(::TLW.EnablePovIntroEventID, true, "PoV Intro Event", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Toggle PoV\'s Intro event[/color] \n\n On by default. Disable this if you do not want to see PoV\'s intro event into your new playthroughs. Does not affect gameplay in any way.");

//Callbacks
settingEnableMainMenuArt.addAfterChangeCallback(function(_oldValue)
{
    if (_oldValue == getValue()) return;
    local main_menu = ::MSU.Utils.getState("main_menu_state").m.MainMenuScreen;
    if (::MSU.isNull(main_menu) || main_menu.m.JSHandle == null) return;
    main_menu.m.JSHandle.asyncCall("updatePOVBackgroundImage", getValue());
})

settingEnablePovIntroEvent.addCallback(function(_newValue)
{       
        ::TLW.EnablePovIntroEvent = _newValue
})



// Debug Settings 
local page = ::TLW.Mod.ModSettings.addPage("Debug");
page.addTitle("title", "Debug Settings - Advanced");
page.addDivider("divider");

::TLW.LogID <- "Log";
local log = page.addBooleanSetting(::TLW.LogID, false, "Enable Logging", "[color=" + this.Const.UI.Color.povTooltipBlue + "] Recommended to keep this on, when playing Beta versions of PoV.[/color]\n\nCurrently on by default. Enable this for testing, dev, streams or when you want to re-create an error to send a good log. \n\n For modders: Logs may be somewhat flooded");
page.addDivider("divider2");
::TLW.MysteryButtonID <- "MysteryButton";
local mysteryButton = page.addBooleanSetting(::TLW.MysteryButtonID, false, "Mystery Option", "[color=" + this.Const.UI.Color.povTooltipBlue + "]You never know, maybe this will bring you luck? Or...[/color]");

//Callbacks
log.addCallback(function ( _newValue )
{
	::TLW.Mod.Debug.setFlag(::MSU.System.Debug.DefaultFlag, _newValue);
});

// Wiki - Long ass stuff here
local page = ::TLW.Mod.ModSettings.addPage("PoV Wiki");
page.addTitle("title", "Hover over the titles below for info");
page.addTitle("title2", "Toggling them does nothing");
page.addDivider("divider");
page.addTitle("Main", "Main");

local enemyMutationInfo = page.addBooleanSetting(
        "PovVision",
        true,
        "PoV\'s Wiki",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]\"Path of the Vatt\'ghern\" (PoV)[/color], is a witcher-inspired legends submod, adding in a variety of new mechanics both related and unrelated to the witcher theme and universe. PoV also tweaks or reworks many vanilla/legends systems, like the injury system.\n\n Generally, the mod is designed to be intuitive, and most of its mechanics are explained ingame via various means. (item descriptions, events etc.) \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]This page here is meant to be a TLDR wiki of PoV, which you can access during gameplay to keep track of PoV\'s core mechanics. [/color]\n\n For more information, ask around in the PoV doscord server."
    );

local DiffBasedMechanics = page.addBooleanSetting(
        "DiffBasedMechanics",
        true,
        "Game Difficulty",
        "When starting a new game, selecting combat difficulty is crucial for PoV, as combat difficulty affects many of PoV\'s mechanics, like enemy mutants appearance rate, new enemies difficulty, corpse drops and so on.\n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]PoV is balanced around the expert difficulty[/color], with higher difficulties meant to be challenging, and lower ones much easier. \n\n [color=" + this.Const.UI.Color.povPainEffect + "]Most new enemy buffs are not present on the easiest difficulty [/color]\n\n When starting a new game, hover over the difficulty options to see more details."
    );

local RecommendedPovSettings = page.addBooleanSetting(
        "RecommendedPovSettings",
        true,
        "Recommended PoV Settings",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]It is recommended to keep all of PoV\'s core settings at their default values for the most pleasant experience.[/color] You can hover over each of PoV\'s options to see more details. \n\n PoV interacts with some other mods, and some of these interactions are optional (usually for better consistency or balance). Check these settings at the [color=" + this.Const.UI.Color.povPainEffect + "]\"Gameplay\"[/color],  page, at the [color=" + this.Const.UI.Color.povPainEffect + "]\"Customization - Tweaks\"[/color] section - they are all recommended to use, but off by default. \n\n In the same page, you can check chaos mode if you want the additional chaotic challenge. \n\n If you do not want to see PoV\'s main menu art, toggle it in the [color=" + this.Const.UI.Color.povPainEffect + "]\"Misc\"[/color] page, while at the main menu screen."
    );

local RecommendedModSettings = page.addBooleanSetting(
        "RecommendedModSettings",
        true,
        "Recommended Mods Settings",
        "Many core mechanics of PoV heavily relate to crafting, and as such it is recommended to tweak visibility of crafting recipes for your ease, so you wont have to look at wikis all the time. \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]In the Legends Mod Settings, in the Misc tab, change the \"show blueprints when\" to \"One Ingredient Available\"[/color]"
    );

page.addDivider("divider2");
page.addTitle("PlayerVattghern", "Player\'s Vattghern & Crafting");

local whatIsVat = page.addBooleanSetting(
        "whatIsVat",
        true,
        "What is a Vatt\'ghern",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]A \"Vatt\'ghern\" is essentially a Witcher, and this is how PoV refers to them.[/color] \n\n A Vatt\'ghern is able to consume mutagens to get some very strong permanent buffs, along with some interesting passives and/or active abilities. \n\nBeing a vatt\'ghern gives a character various buffs, scaling with the their lifetime kills and active mutations (see below) \n\n Bonuses are to AP, damage, initiative, resolve and Hp regen. Lifetime kills scale up to 200, while active mutagens scaling is unlimited. \n\n A vattghern needs more money to be paid, and [color=" + this.Const.UI.Color.povPainEffect + "]increases enemy scaling[/color] (counting like one and a half bro)"
    );

local tog = page.addBooleanSetting(
        "tog",
        true,
        "How to get a Vatt\'ghern",
        "To turn a character into a Vatt\'ghern, one needs the [color=" + this.Const.UI.Color.povPainEffect + "]\"Trial of the Grasses\" (ToG)[/color] - a very powerful and dangerous mutagen that must be crafted from various monster parts and items. \n\n The ingredients are: [color=" + this.Const.UI.Color.povPainEffect + "]third eye[/color] (alp), [color=" + this.Const.UI.Color.povPainEffect + "]sulfurous rocks[/color] (ifrit), [color=" + this.Const.UI.Color.povPainEffect + "]poison gland[/color] (spider), [color=" + this.Const.UI.Color.povPainEffect + "]unhold heart[/color] (unhold), [color=" + this.Const.UI.Color.povPainEffect + "]adrenaline gland[/color] (direwolf), [color=" + this.Const.UI.Color.povPainEffect + "]nahrezer brain[/color] (nahrezers) and a new craftable item: [color=" + this.Const.UI.Color.povPainEffect + "]distilled alcohol[/color] (crafted from any two alcololic items) \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]These items can be found by slaying monsters, dissecting corpses (see below), at some rare special events, and rarely sold at alchemists and black markets.[/color]"
    );

local tog2 = page.addBooleanSetting(
        "tog2",
        true,
        "How to use the ToG",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]Using the Trial of the Grasses (ToG - See above), is a perilous process.[/color] \n\n There is a chance that the one using it might [color=" + this.Const.UI.Color.povPainEffect + "]immediately die[/color]. Base death chance is 100% on expert difficulty, reduced by 10% for each level the character has. \n\n Additionally, the chance can be modified by +15% or -15%, for each of the following traits: (-15% death chance: athletic, iron lungs, lucky, strong, tough. +15% death chance: ailing, asthmatic, bleeder, fat, fragile, old) \n\n On top of that, using the ToG causes a [color=" + this.Const.UI.Color.povPainEffect + "]party wide mood debuff[/color], its severity depending on brother\'s resolve and/or traits. \n\n Finally, if successfully used, it causes [color=" + this.Const.UI.Color.povPainEffect + "]\"mutation sickness\"[/color] (see below)."
    );

local corpses = page.addBooleanSetting(
        "corpses",
        true,
        "Corpse Items",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]Corpses are a new item type, added by PoV.[/color] These are randomly dropped by specific -usually nonhuman- enemies, like undead, orcs and beasts with drop rates being affected by games combat difficulty (higher = lower chance) and starting origin (some get a bonus). \n\n These corpses can by [color=" + this.Const.UI.Color.povPainEffect + "]\"dissected\"[/color] by characters with either the [color=" + this.Const.UI.Color.povPainEffect + "]\"Field Triage\"[/color] or the [color=" + this.Const.UI.Color.povPainEffect + "]\"Potion Brewer\"[/color] perks (depending on the corpse type). \n\n Dissecting them gives a chance to obtain different items that would be the loot of the respective enemy, but also unique drops that can only be obtained via dissection, like [color=" + this.Const.UI.Color.povPainEffect + "]mutagens[/color], and special loot.\n\n Corpses of more powerful enemies have better loot and rates. \n\n Corpses are dissected in the crafting tent, or for a price at a taxidermist. Corpses also expire after some days, and last for 10 days on average."
    );

local mutagens = page.addBooleanSetting(
        "mutagens",
        true,
        "Mutagens",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]Mutagens are rare, special items that can only be used by a Vatt\'ghern, granting them a strong mutagenic effect [/color] (details below). \n\n There are three ways to obtain mutagens: [color=" + this.Const.UI.Color.povPainEffect + "]Corpse dissection[/color] (most reliable option), as very rare [color=" + this.Const.UI.Color.povPainEffect + "]drops from enemy mutants[/color] (very rng), and can be also [color=" + this.Const.UI.Color.povPainEffect + "]bought from Alchemists or Black Markets[/color] (very expensive). \n\n Using a mutagen to a viable character causes \"Mutation Sickness\"."
    );

local mutagenUps = page.addBooleanSetting(
        "mutagenUps",
        true,
        "Mutagen Upgrades",
        "A much more rare kind of mutagen - mutagen upgrades. These can only be used by one who has already used their \"base\" version before (so alp upgrade, can only be used by one with the alp mutagen). \n\n What they do is upgrade the original mutation that their base version grants, vastly improving its effect and lessening its penalties. \n\n [color=" + this.Const.UI.Color.povPainEffect + "]Mutagen upgrades can only be rarely obtained by dissecting the corpses of very strong opponents, like white direwolves.[/color]"
    );

local mutationSickness = page.addBooleanSetting(
        "mutationSickness",
        true,
        "Mutation Sickness",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]Mutation Sickness is a unique injury, caused by using the ToG or various mutagens.[/color] \n\n It is a serious injury, that renders a person practically incapable of combat, by making them weak and fragile (reduction of all base stats). \n\n It lasts for a long period of time (can be up to 15 days), but this period can be cut by half if the injury is treated (in temple or camp). Effects that reduce injury time also work. \n\n [color=" + this.Const.UI.Color.povPainEffect + "]Every time someone gets this injury, they become more resilient for the next time[/color], so the more mutations one gets, the less time this injury will last for. (~ 1-3 days reduction each time)"
    );

local vattghernContracts = page.addBooleanSetting(
        "vattghernContracts",
        true,
        "Vatt\'ghern Contracts",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]PoV also adds a new unlockable contract category, \"Vatt\'ghern Contracts\"[/color] \n\n These are fights that are against new, rare, unique and powerful enemies. They can appear like normal contracts, and pay pretty well. \n\n [color=" + this.Const.UI.Color.povPainEffect + "]They can only appear if you have at least one Vatt\'ghern in your party, and at least 525 renown.[/color] Each town can have a maximum of 1 Vatt\'ghern contract. \n\n Having your only vattghern die means losing access to them, until you get a new one.)"
    );

page.addDivider("divider3");
page.addTitle("Mutations", "Player & Enemy Mutations");

local mutEffects = page.addBooleanSetting(
        "mutEffects",
        true,
        "Mutation Effects",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]Mutations are special effects, that can appear on both the player and the enemy.[/color] (see how below)\n\n Their effects are meant to grant specific buffs, but also specific weaknesses, in a thematic way and to encourage tactical gameplay. [color=" + this.Const.UI.Color.povPainEffect + "]All mutations also add at least one passive or active skill[/color] \n\n Example: orc mutation grants increased attack and damage and the charge skill, but reduced defences \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]The effects of mutations on players and enemies are very similar[/color], for consistency (so above example applies both to player and enemy). \n\n Check PoV discord, or mutagen items and traits for a more detailed list on their effects."
    );

local playerMuts = page.addBooleanSetting(
        "playerMuts",
        true,
        "Vatt\'ghern Mutations",
        "Only vatt\'ghern can acquire mutations solely by using mutagens and/or mutagen upgrades. \n\n The effects of the mutagens are meant to be thematic, granting specific strengths and weaknesses to the vatt\'ghern. \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]The vattghern can have a limited amount of mutations, which are: 1, +1 for every 7 Levels.[/color] (So a lvl 8 bro can have 2 mutations). \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]Some mutations are excluded from this limit[/color] (vattghern mutagen -ToG-, mutation upgrades, and some more)"
    );

local enemyMuts = page.addBooleanSetting(
        "enemyMuts",
        true,
        "Enemy Mutations pt.1",
        "A core mechanic of PoV...[color=" + this.Const.UI.Color.povTooltipBlue + "]Almost all enemies can get some semi-random, thematic mutations[/color] when fighting them, their effects very similar to the vattghern ones. \n\n This not only strenghtens enemies, but also adds opportunity for counterplay (eg: anti undead tools, work against one with the undead mutation). \n\n Enemy mutants can be told apart due to unique effects they get in battle, dynamic enemy names, and unique tooltip appearance. \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]For enemy mutations to appear, the \"Enemy Mutations\" setting must be enabled (recommended, on by default).[/color]"
    );

local enemyMuts2 = page.addBooleanSetting(
        "enemyMuts2",
        true,
        "Enemy Mutations pt.2",
        "[color=" + this.Const.UI.Color.povTooltipBlue + "]The appearance chance of enemy mutants heavily depends on combat difficulty [/color](harder = more). \n\n Optionally (on by default), enemy mutants appear more often as more ingame days pass, roughly every 70 days. \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]Killed enemy mutants have a chance to drop their respective mutagen[/color] (so orc mutang would drop orc mutagen).\n\n These chances depend on Combat difficulty (higher diff = lower chance) and selected origion (some get a bonus)"
    );

page.addDivider("divider4");
page.addTitle("PovMechanics", "New & Tweaked Mechanics");

local injurySystem = page.addBooleanSetting(
        "injurySystem",
        true,
        "Injury System",
        "PoV has done a slight rework to the injury system, not by editing existing effects, but adding new ones, for increased tactical gameplay (predictability and interactivity). \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]When injured, on top of whatever injury an entity may receive, they also get the [/color][color=" + this.Const.UI.Color.povPainEffect + "]\"Severe Pain\"[/color][color=" + this.Const.UI.Color.povTooltipBlue + "] effect, reducing their AP and Damage for two turns.[/color]\n\n Some entity types, like orc berserkers, elites and mutants, or undead enemies and mutants, get different unique effects. \n\n Orcs get an attack and damage buff, instead of a debuff, and undead get increased fragility instead. \n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]Entities with the adrenaline effect, are immune to, or are cured of these injury effects when it is active.[/color]"
    );

local fireDamage = page.addBooleanSetting(
        "fireDamage",
        true,
        "Fire Damage",
        "There has been some effort at making fire damage more impactful in PoV (and there will be more interactions with it in the future).\n\n [color=" + this.Const.UI.Color.povTooltipBlue + "]All enemy beasts and undead (and some mutants), now have innate fire resistances or weaknesses.[/color] \n\n Fire resistant enemies: [color=" + this.Const.UI.Color.povPainEffect + "]Ancient Dead, Basilisks, Lindwurms, Ifrits, Serpents, Bog Unholds.[/color] \n\n Weak to fire: [color=" + this.Const.UI.Color.povPainEffect + "]Direwolves, Hyenas, All Undead (not ancient dead), Unholds, Schrats, Spiders, Flesh Golems.[/color] \n\n Most of these damage multipliers are for Hp AND Armor damage."
    );

page.addDivider("divider5");
page.addTitle("moreInfo", "Check PoV Discord for more info!");
page.addDivider("divider6");