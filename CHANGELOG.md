# v0.4.1 Pre-Release

## Changelog V0.4.1 Pre-Release:

### NEW THINGS
* Added a custom new PoV Banner! (With also shield sprites, and all related company stuff)
* Also added a new PoV Tabard (can be painted in tent, variation of the common tabard)

### BALANCE - TWEAKS
* Swertgeister will spawn slightly less often

### FIXES
* Lots of groundword for upcoming dependency updates
* Fixed an issue of PoV attempting to mutate stuff while in world map
* Fix to PoV's brushes (metadata files typos)
* Fixed some hooks when playing with Rotu
* Corpse Items were re-implemented properly (mostly code improvements)
* Fixed 2 of PoV's crafting recipes not working properly (Medallion and ToG)

## Changelog V0.4.0 Pre-Release:

Obviously not save compatible lol
Big, big changelog this time. Things will be divided into many subcategories - Go and look at whichever interests you :)

### NEW ENEMIES
* Added two new "ghost"/spirit type enemies. All with new custom effects, animations, sounds, art, mechanics and drops.
* Both of these enemies can appear wherever you would normally encounter geists, and during undead crisis in any undead party
* Swertgeist (Sword Ghost)
   * A gheist enemy with a twist - its melee. Has single and aoe melee attacks with an atherial 2H Sword. Attacks have high armor penetration.
   * At the same time, it has very high defenses and damage resistance (aetherial effect), until it attacks. 
   * After attacking, it becomes "Corporeal", open to attack. When taking damage while having this effect, it becomes aetherial again.
   * Holy Water and the Concecrated effect make it stay corporeal!
   * Has the fearsome, overwhelm, feint and some other interesting traits.
   * Gets stronger as ingame days pass (stats), and in legendary difficulty
   * Difficulty wise, it is meant to be almost as challenging as the banshee, if not slightly more difficult
* Rustunggheist (Possessed Armor)
   * The other new geist enemy, also with a twist -  its tanky and armored. A spirit possessing a big set of armor, attacking enemies with it, while protecting itself.
   * It has 4 different melee attacks, all using the armor itself (punch,kick,headbutt). Its attack damage depends on its current armor, and the attacks themselves can stagger,baffle,daze or stun, depending on skill and part hit (head/body)
   * The only way to kill it, is to attack one of its 2 body parts when they have less than 10 Armor. So you have to destroy its armor to banish it
   * Instead of damaging it, holy water and concecrated effects reduce its damage done, and increase its damage taken by all sources.
   * Has the fearsome, steel brow, and battleforged perks
   * Gets stronger as ingame days pass (stats), and in legendary difficulty
   * Meant to be a more rare, and challenging encounter

### MUTAGENS REWORK - EMENY MUTATIONS
* Enemy Mutations are now always active - no longer optional.
* Enemy Mutations also now appear appropriately to enemies (they did not do that fully before...)
* Enemy Mutations Scaling: Enemy mutations will appear more often as days pass - optional, on by default. Special interaction with chaos mode -
* Buying mutagens should be slightly cheaper
* Tweaked all player and enemy mutations, adding them unique skills and passives (usable by both player and enemy AI).
   * Purpose is for each mutation to add at least one new skill and/or effect
   * Mutations with new skills/effects: Ghoul,Schrat,Undeath,Vampire,Beast,Hexe,Ifrit,Serpent,Unhold,Donkey
* All mutations and their previous skills/effects were rebalanced, to be more interesting and impactful
* All mutations items and effects text reviewed to be more descriptive
* Added mutation Upgrades!
   * From corpses of legendary monsters (like the white wolf), one may now get a "Mutation Upgrade"
   * These are meant to upgrade existing mutations, so Direwolf Mutagen Upgrade can only be used by one with the Direwolf Mutation
   * Usually these vastly improve the existing mutation, while limiting by a lot its negative aspects
   * Mutation upgrades can also rarely drop from champion monsters (if those exist, like with the MC mod)
* Because of the increased power of the mutations, enemy mutants will appear slightly less often
* Mutagen drop rates made more reasonable (lowered - mutagens are supposed to be rare)

### STORYTELLING - PROGRESSION
* Added a few events that will guide the player into the PoV mod, in a nice thematic way
* Added an "intro" event that fires at the beginning of any playthrough, giving general information about PoV (can be disabled in options)
* At the beginning of most playthroughs (all non-PoV origins), corpse drops, mutagen drops and sales, and some crafting recipes and unique items will be "locked"
   * Player will have to do specific things, outlined by said events and ambitions to progress
   * Briefly, player's milestones should be: Kill a mutant, get a mutagen, craft the trial of the grasses, get a Vattghern, gather materials for a vattghern sword!
   * Each time such a milestone is complete, an event will inform the player, and guide them to the next step!
   * For example: killing the first mutant in a playthrough unlocks corpse and mutagen drops! as well as related events.
* PoV's origins have all these milestones complete, as you start with a vattghern.

### ORIGINS
* New Vattghern Background -  To flesh out existing and new PoV origins, and tweak starting stats, equipment, perks, and available perks.
* "Path of the Vattghern" Origin tweaked, its penalties made less serious.
* Added 2 New PoV Origins and tweaked the existing one for 3 total, each serving their own purpose
   * PoV Solo origin: Like the Vanilla "Lone Wolf" origin - but you start with a strong vattghern instead. Simple origin for now, with planned features for the future.
   * New Company (PoV): Almost the same with the normal New Company origin, tweaked for more interactivity and storytelling
     * Start with a retired soldier, a woodsman, and a poacher.
     * They start with set talents, slightly boosted stats and specific equipped items. Also start with some very basic supplies.
     * To balance out the additions, start with half the money and 25% less medicine, compared to the normal "New Company" scenario
     * The main idea behind this origin is that I liked playing "the new company" scenario, but did not like the 0 event and camp interactivity of the "companion" backgrounds 
* All PoV Origins (except for the New Company one) also get slightly increased corpse and mutagen drops from enemies (+ 10 - 15%)
   * Rangers, Beast Hunters, Anatomists origins also get a similar bonus

### TRAITS
* Pluviophile - Gain some nice bonuses to resolve and initiative while fighting in rain! (And immunity to rain penalties - if and where those apply)
* Geisthasser - Hate VS Spirits kind of trait, granting a big resolve bonus, and some melee attack. Also slightly buff allies resolve in a 2 cell radius while in battle against geists

### EVENTS & AMBITIONS
* Added a new ambition to craft a vattghern sword - unlocked when you have a vattghern over lvl.11 (the ambition clearly states what is needed to be complete)
* Ambition to get a vattghern now appears more organically, when you would most likely want to go through with it.
* Added a nice little event related to a new crafting item: Distilled Alcohol (see below)
* New Intro events for the new PoV origins (see below, again :p) 

### ITEMS REWORK
* Reworked of the Vatt'ghern Sword (Including new art - again)
   * Generally Buffed, only slightly weaker than a greatsword on paper, but more versalite, and stronger against mutants, undead and monsters
   * Can now get it in any origin, via a special ambition to "craft" it
   * Only the vattghern can properly wield it. Others can too, but will be debuffed while holding it (bringing it down almost to longsword level strength)
* Reworked the Vatt'ghern medallion
   * Can only be equipped by a vattghern
   * Once you get your first one, you also unlock its crafting
     * You need one silver and one iron ingot to craft it

### NEW ITEMS
* Silver Bars - New "Trade" Item
   * Have high value, and can mainly spawn in settlements with gold mines, and ore smelters
   * Is also craftable, by melting two of Silverware of Silver Bowls, with a bro that has the "Spare Tools" perk (added in perk's description too)
   * Other than trade, they are mightly useful for some new recipes, and ambitions (like to get the vattghern sword)
* Spectral Armor Patch - A new armor attachment, that you can get via a new enemy (Rustunggheist)
   * Gives some good amount of armor, and 30% Damage resistance against spirits, and 10% dr against other undead
   * Can be crafted using an iron ingot and "spectral armor shards" - special loot that you can get by dissecting a Rustunggheist Corpse
* Distilled Alcohol - A new crafting item
   * Can be crafting by combining any of 2 alcoholic items (15 Recipes in total!)
   * Usable for the crafting of important things, like the Trial of the Grasses (thing of it like the "alcohest" from witcher games)
   * You can also buy it from alchemists, or rarely find it as loot from roaming flesh golem parties!

### TRIAL OF THE GRASSES 
* Death Chance lowered across the board by 10%
* Removed the requirement of the Vampire Dust item to craft it
* Replaced it with a requirement for the new "Destilled Alcohol" Item

### MODS INTERACTIONS
* Rotu: Jotunn, Pink & Blue Horrors, now part of the enemy mutation system
* Fotn - optional (In PoV Mod Settings): Some balance tweaks
* SSU - optional (In PoV Mod Settings): 
   * Removed Sequences
   * Remove random sequence effects on enemies 

### PoV WIKI - MOD SETTINGS
* The mod settings page of PoV was re-improved, with much more detailed and clear in what they do settings
* Also added a brand new wiki for the mod, integrated in the settings page (Wiki tab)
   * There, you can find a TLDR of the most important info for PoV

### ART
* Many mutagen items art redone
* Revisited some old event art from early versions
* Improved the Vattghern Eyes
* New icon for "Beastslayer" trait
* New Art for the Vattghern Sword!
* Also new art for all of the sword's skills!
* Some effect arts and icons were improved

### IMPROVEMENTS
* Lots of re-organisation of my code (like y'all care :( )
* Most of pov's active skills now have appropriate overlays
* Misanthropist needs 23 less kill to become a psycho
* Perk descriptions that pov adds should properly appear with any other mod combined (SSU, Fotn etc.)
* Added Perk descriptions to adrenaline and spare tools, for what they do in PoV
* Vattghern trait tooltip now shows available mutations until you hit the limit
* Vattgherns have a higher chance to survive being struck down (+33%)
* Corpse Drops rates reduced across the board - for better balance and to accomondate new changes
* Alchemist retinue no longer prevents corpses from being used when crafting (was too OP)
   * To compensate, it now increases corpse and mutagen drop rates by 15% (multiplicative)
* Antidote now cures new poisons added by PoV (mutant poison, rot etc.)

### FIXES
* As always, a fuckload of typos
* Fixes to some new traits not appearing
* Fixed a crash caused by Rot Bullets
* Fixed wrong sound playing when using A hexe mutagen (sounded like a goblin)
* Fixed a case where the enemy hexe mutation could cause an infinite loop (oops)

### MISC
* Memed, a lot this time. You may see
* Hey sos <3

## Changelog V0.3.15 BETA:

### NEW ADDITIONS
* Added a brand new enemy mutation to the enemy mutations roster: rot! (With now a total of 17 Possible Mutations)
   * Its effect is quite similar to the "Unbearable Stench" passive that I added previously to PoV, granting an melee range aoe debuff to enemies
   * Its drawback is that while it turns an enemy into a strong melee debuffer, it slows it down, reduces its resolve, and slightly reduces its defense, and gives weakness to fire
   * Enemies who bear that mutation have a chance to drop the "Strain" mutagen
   * The player can also obtain this effect, via the "Strain" Mutation
   * Due to this being now a mutation, zombies cannot have a chance to obtain this effect via other means (previously they could get it)
* Expanding the dynamic enemy renaming system from the enemy mutations.
   * Now, other than the default title enemies gain when getting their first mutation (eg.: "cunning" for goblin) now there is also another possibility
   * If an enemy rolls more than one mutation, and two of those happen to belong to a "Set", the enemy will get a more rare, "special" name
     * Example, an enemy with the Sandgolem and Schrat mutations, will now receive the "Impenetrable" title.
     * Currently, there are 20 such combinations and possible titles, and Im looking to expand them, any ideas very appreciated!
* ANIMATIONS!!!
   * Now, the green glow of enemy mutants will be animated (soft fade in and out, with scale change). 
   * Also, enemies with the rot mutation or the unbearable stench effect will also have their "stench" effect in battle animated

### IMPROVEMENTS/TWEAKS
* The green bust sprite that the mutants have, will now be more visible if they are champions, and will show up in the turn order preview!
* Chaos Mode and Enemy Mutations Systems are now more independent from each other
   * With Chaos Mode enabled, now enemies will receive fully random mutations only. Not in addition to what they could roll normally (as it was before)
   * To compensate, mutation chances of the enemy chaos mutations were slightly raised 
* The in battle art of PoV's "Mace/Whip" weapons was improved to be less....weird
* The "Mace Whip" was more appropriately renamed to "Whip Flail"

### BALANCE
* The Scaling of enemy mutations (how often they appear) was tweaked to be more reasonable
* The Stench effect

### FIXES
* Fixed a typo in the "Many corpses" event
* Fixed Schrats not being able to mutate
  
## Changelog V0.3.14 BETA:

### IMPROVEMENTS/TWEAKS
* The PoV Scenario was tweaked
   * Penalties of the origin reduced
   * Other than beast slayers, valas and people with "hates beasts", now the origin also has bonuses when recruiting druids, and people with the "hates mutants" and "hates everything" traits
   * Starting supplies now include one unhold corpse (for thematic reasons, and as an opportunity for experimentation for new PoV players)
* All of PoV's new encounters were properly re-implemented
* All events, encounters and ambitions text reviewed and improved, with fixed typos
   * Respact the genda - All gender references in text should now be accurate
* PoV Settings page further improved. Added better description for some options to avoid issues
   * Added some information in the PoV server, about recommended mod settings
* All mutagen item tooltips improved
* Mutagen items preview in crafting screen should be better (no more text overflow)

### BALANCE
* Vattghern Unhold Mutation Revisited - Added a risk/reward aspect to it
   * Now, when between 75 - 100 %HP, grants linearly scaling bonus damage based on the vattgherns max HP
     * Maximum Damage Bonus is 8% of Vattghern's max HP when on 100% Hp (So A 150HP Vattghern would receive 12% Bonus Damage). Bonus caps at 20% Damage
   * WHen Between 1 - 74 %HP, grants linearly scaling damage penalty, going up to -45% when on 1%HP
     * As an example, a vattghern on 50%HP would receive a -15% Damage Penalty 
* Both Vattghern and Enemy Goblin mutations were buffed. On top of past effects, they also grant +12% Ranged Damage
* The "Foul Stench" effect was slightly nerfed in its severity
* The Damage penalty against humans from the "Beast Slayer" trait was halved

### FIXES
* Vast array of typo corrections
* Fixed a minor error of a missing .png
* Fixed an error with the schrat mutation's "no shield" effect

## Changelog V0.3.13 BETA:

### NEW ADDITIONS
* 2 New Events and 1 New Encounter!
   * Beast Mutated vattghern may now tame a wolf through a camp encounter
   * One event is about the additional scaling PoV adds to its mutations (see below) 
   * The other event might help you gather more of the required materials for the trial of the grasses
* Enemy mutations now appear more often in lategame (starting from day 70). (Optional, can be disabled in PoV Mod Settings)
* A new option was added in PoV Settings "MC Tweaks". Off by default. If enabled and player has the MC mod loaded, it currently tweaks some things for balance, and removes the "Possess" skill from enemy geists (it annoyed me)
* The third eye skill from the Vattghern Alp Mutation now also grants a party wide buff, in addition to its increased vision. Cost more ap and fat though.
* Some of PoV's new effects will now spawn an in battle icon when added in battle (poisoned, rot etc.)
* Memed a bit. Maybe some unhold mutants were mutated *too much*. Also, catapults. 
* The vattghern trait now also shows how many more **normal** mutations the vattghern can get.
* A brand new PoV Title Screen!

### IMPROVEMENTS/TWEAKS
* The PoV Mod Settings page was improved, with more descriptive tooltips and new options.
* Improved some icons and tooltips (art and text).
* The Player mutations system code was made more dynamic 
* Logging was improved. May not flood logs as much

### BALANCE
* Ifrit mutations were slightly reworked to make them more viable for the player, and more dangerous on an enemy.
   * In the past, they gave damage resistance only on direct HP damage. Now they grant total damage resistance, which means they also reduce armor damage
   * Overall armor increase and damage resistance increased for both player and enemy. The penalties were balanced accordingly
* Attempted to make crafting the trial of the grasses a little easier
   * Corpse drops from enemy necrosavants slightly increased
   * Some of the ingredients of the ToG that could be found in some shops will now appear slightly more often, and with a little better prices
   * The aforementioned event
* The Vattghern "weave net" skill from the Spider mutation now costs less AP and fatigue
* Roaming flesh golems should spawn more consistently (and a little bit more often), their parties will also have better loot

### FIXES
* The "Hates Everything" trait now properly changes traits every 7 days (it was 2!!)
* Enemy corpses now drop properly
* Fixed error related to descriptions of Field Triage, and Potion Brewer
* Sounds are now played properly on successful, failed, or prohibited player mutations
* A few typos were also spotted and fixed

## Changelog V0.3.12 BETA:

* Reworked the art of the Orc Mutagen item and relevant effects
* The debuffs of the Undead Pain from Injury effect is now a stronger debuff
* "Color" was renamed to "color" in code
* Color tags are now dynamic in pov (they were made into const)
* Minor fixes to some enemy hooks related to Rotu

## Changelog V0.3.11 BETA:

* On game launch, you will now be notified of PoV updates!
* PoV Origin Assassin should now have correct perks
* Fixed the "Ghastly Touch" skill not having cooldown

## Changelog V0.3.10 BETA:

* Fixed an issue with the enemy vampire mutation dropping its mutagen
* Fixed Ghost mutation not applying properly
* Fixed enemy Alps and Direwolves not getting mutations

## Changelog V0.3.9 BETA:

### NEW ADDITIONS
* A new active skill was added "Ghastly Touch". Does armor ignoring damage, with slightly reduced hit chance, and one turn cooldown.
* This skill is added to both the Vattghern and the Enemy "Spirit" mutation (etherial attacks for the enemy)
### FIXES
* Fixed the Vattghern Serpent Mutation causing a crash when loading a battle.
### BALANCE
* The "Third Eye" active from the vattghern alp mutation was tweaked, now costs more AP and Fatigue. Grants vision in a slightly smaller radius (still very large, 15 hex)
* The HP penalty of the vattghern serpent mutation was slightly reduced
  
## Changelog V0.3.8 BETA:

* Fixed Trial of the grasses not working properly
* Fixed mutations not making the correct sound on successful mutation

## Changelog V0.3.7 BETA:

* Added some new Rotu enemies into the enemy mutation system
* Fixed the enemy mutation system, and fatal errors that it could rarely cause
* Fixed a minor brush error
* Attempt to fix an issue related to the enemy hexe mutation effect
* Restored the mutation limit for the vattghern

## Changelog V0.3.6 BETA:

* Fixed a typo and improved the vattghern goblin mutation tooltip
* Fixed an issue with the racial of frost unholds not appearing

## Changelog V0.3.5 BETA:

### FIXES
* Fixed an error with the Goblin Vattghern mutation, also tweaked its effects
* The effects applied by "coat with acid" and "coat with vattghern poison" were tweaked, so they can apply poison to all targets of an AOE attack.
### BALANCE
* Some enemy mutations were mostly buffed, to make them more interesting on enemies (schrat,lindwurm,ifrit,beast,skeleton,unhold,serpent,ghost,vampire) will explain interesting specifics below
   * Enemies with the schrat mutation will be far more resilient while holding a shield
   * Enemies with the skeleton mutation also have some resistance to cutting damage, in addition to their previous piercing resistance. They have slightly rediced Hp though
   * Enemies with the vampire mutation will receive a decent buff during night battles, but a minor debuff during day battles
### MISC
* Some descriptions of enemy corpse items were improved

## Changelog V0.3.4 BETA:

FIXES
* Actually Fixed an issue with effects adding infinite armor (ifrit, schrat enemy/player mutations) (failed in 0.3.3)
* Added some more fallbakcs in code, to avoid potential issues.
BALANCE
* Number of mutations on the vattghern, now slightly increase their vattghern trait stats!
* Flesh Golem Corpses now no longer have a chance to drop the "large red worm" mutagen component
* Now the "Coat weapon with acid" skill, slightly increases armor damage while active
ART
* Revisited the Vattghern trait icon and the trial of the grasses item icon
* Revisited the Vattghern medallion art
MISC
* Added an encounter, notifying the player for when the enemy golem parties start roaming

## Changelog V0.3.3 BETA:

* Improve the way that the enemy Spider and Orc Mutations add skills to entities. (Did not work correctly)
* Fixed a fatal issue related to the enemy hexe mutation (needs testing)
* Fixed an issue with effects adding infinite armor (ifrit, schrat enemy/player mutations)

## Changelog V0.3.2 BETA:

* Fixed crash when fighting Goblins
* Added a fallback function to the enemy mutation system, to maybe prevent some future shit

## Changelog V0.3.1 BETA:

* Improved the descriptions of all mutagen items
* Improved the Vattghern and Misantrhopist Trait Icons
* Fixed "Hates Everything" Perk incorrectly applying hate perks

## Changelog V0.3.0 BETA:

Oooh Boy, bunch of new stuff were added. This is the biggest update yet, and is the groundwork for my public release.
That said, i will devide what i dit into Categories for this one

### NEW SYSTEMS & ADDITIONS
* Descriptions for some of the mod's systems were improved, mainly:
   * Mutation Sickness Trait now better describes how it works (the more you get, the less they last for)
   * Corpses will hint a little better as to what they need to be dissected
   * The "Field Triage" and "Potion Brewer" perks have now updated tooltips, describing their function in PoV
* Reworked the Flesh Golem Enemy!
   * Buffed so they are much more sturdy, but also slower and weaker in defense. Also weak to fire.
   * Added into the enemy mutation system (with appropriate mutations)
   * They also get the new "Unbearable Stench" ability. A passive AOE poison/debuff
   * They have new corpse drops, with unique new crafting, loot and special items (Grafted Flesh, Ivory Spine Shard, Rot Essence)
   * There is the possibility for enemy roaming parties of flesh golems! (Belong to undead "zombie" faction)
* Special Item Framework
   * Made a framework for a new "loot" item type, special loot. They have their own distinct art effects.
   * These can only be obtained via corpse dissection, with low chances
   * They can be used for special crafting recipes, to get powerful items, or sold at a high price in towns, combining the propertie of crafting and loot drops.
* New Ammunition for handgonnes: "Rotten Flesh Ammo", craftable from the newly added items!
* The mod's injury system was slightly reworked. Now, not all entities will react the same to be injured, namely:
   * All debuffs that are got upon being injured now last for 2 turns instead of 1
   * Most will still just receive the "Severe Pain" Debuff upon injured, but:
   * Orc Bersekrers, and entities with the orc mutation (player and enemy) will receive a buff instead, granting them increased aggression!
   * Undead, if and when they are injuted, will now receive the "Destabilised" debuff, which instead of reducing their damage and action points, it will reduce their defences and increase their damage taken instead!
* The spider mutation was buffed, with the addition of the "Weave Net" Skill. Similar to what the spiders do ingame, Spider Vattghern and enemy mutants can now use this skill too, and from a slightly longer range!
* Enemy mutants with the orc mutation can now use the "Orc Charge" skill, same as with the orc mutated Vattghern
* A new skill was added to the Player vattghern with the lindwurm mutation, "Coat With Acid". By inflicting damage to themselves and their weapon, they coat it with corrosive acid, which can be then used to damage enemies and apply them the corrosive acid debuff, damaging their armor over 3 turns.
* All Wardogs, Warhounds and Warwolves are now part of the enemy mutation system
* All Enemy Mutated Enemies will now have dynamic new names during combat. Think of like a bandit rabble with the orc mutation can be now called "Savage Bandit Rabble"
* Unhold Corpses did not fully work correctrly before, now different unhold types will drop different corpses (frost unhold -> frost corpse). Also, bog unholds now have fire resistance instead of weakness.

### ART
* All of the aforementioned additions have their own new art.
* Full Rework of all of PoV's events art
* Some assets improved in quality. Mainly the "Trial of the Grasses"

### TRAITS
* Added Hates Everyone Trait, every week, the brother gains 2 different hate perks, all available from a pool of all the hate perks ingame (Legends, PoV, and Vanilla). Cannot have the same perks as the previous ones when rerolling
* Upgraded Charming Perk, obtainable via an event

### EVENTS
* A bro who has the hates everyone trait, may interact with a bro who does not have any hate perks, granting them one for free
* An event between the hexe mutant bro and a crusader bro
* A special interaction event between a charming bro and a hexe mutant, upgrading the charming trait of said bro
* With all these additions, the mod now boasts 14 New Events, and 6 New Encounters!!
* Enemy Mutation chances slightly tweaked. Weaker enemies will have slightly lower mutation chances, and stronger enemies slightly higher.

### BALANCING
* Fire resistance of many beasts tweaked, beasts weak to fore damage will also receive more damage to their armor, not just their HP (its their fur that burns after all)
* Enemy Zombies and Undead can now also have the "Unbearable Stench" Effect, which has a medium difficulty based chance to appear on them.
* Slightly increased Vampire corpse drop rates
* Enemy Hexe mutation was nerfed, now should be less punishing
* Enemy Spider, Orc, Beast, Basilisk, Skeleton, and Unhold mutations were buffed, either with better stats or new skills
* Some Player Mutations Buffed: Spider (new skill) , Wurm (new skill), Strain ("Unbearable Stench" Passive), Skeleton (better stats) and Orc (Better Stats).
* The "Nyctophobia" Trait was toned down, now less punishing and grants slight resolve bonus during daytime
* The "Path of the Vattghern" origin was tweaked, with the addition of some useful starting items (more start supplies, medicine, and a random mutagen)
* The "Old" trait that the starting vattghern has was turned into a unique trait, with far less severe penalties.

### MISC
* PoV's mod options were improved (more readable)
* Also, a new option to toggle my main menu art was added (so people could use other art, like ROTU or Vanilla), thanks Necro!
* Hate/fear mutants traits now will not spawn if the enemy mutation system is disabled in options!
* improved Corpse Dissection Tooltips, now more precise with their descriptions, and added new icons to the food and value drops
* Some Corpse autopsies can drop new value items: Hexe (Jade Brooch), Necromancer & Vampires (Ancient Scroll)

### MODDER STUFF
* The Mod's Enemy Mutation System was pretty much rebuilt from the ground up. (That was 220+ files...) Now it is far more dynamic and modular, which means that other mods could now hook into PoV and create their own enemy mutations!
* Autopsy and Corpse Items were fully reorganised into their own respective folders.
* Logging of some of the mod's systems was improved

### TYPOS/FIXES
* As always, a plethora of typos were found and fixed
* Fixed an issue with injuries, that some people had
* Unhold Corpses now drop correctly
* Improved SSU Compatibility
