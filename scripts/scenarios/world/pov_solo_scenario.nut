/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

this.pov_solo_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.pov_solo_last_witchers";
		this.m.Name = "Lone Vatt\'ghern";
		this.m.Description = "[p=c][img]gfx/ui/events/pov_solo_vattghern_origin.png[/img][/p][p] You are an experienced Vatt\'ghern, a professional beastslayer who has come to these lands to further your craft! The challenges are many, as most view you and you as a vile mutant, thus it will be hard to earn the people\'s trust and favor, except for those who also fight against vicious beasts...\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Lone Vatt\'ghern:[/color] Start with an experienced and skilled Vatt\'ghern, who has all the knowledge of mutagen creation and corpse dissection and also some strong gear. He is also well supplied with some decent starting gold and medicine. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Monster Hunter:[/color] Due to your expertise, you can move much faster on the map, and you can spot enemy tracks from much further away. Additionally, beasthunting origins, including some rare ones, will appear more frequently and their skillset will be improved. \n\n[color=" + this.Const.UI.Color.NegativeValue + "]Mutant:[/color] Few people will trust you, and even fewer will want to deal with you. You start with significantly low reputation. Most people will either avoid joining you, or demand exceptionally high wages, save for the few who share your beastslaying interest. Also, you will get 15% worse prices overall. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Spoils Of The Hunt:[/color] 30% Chance for extra drops from monsters, due to your knowledge and techniques. Corpse and enemy mutagen drop rates are also increased by 15%. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Specialist Group:[/color] Cannot have more than 12 brothers in the company. If the player character dies, campagin ends. \n\n[color=" + this.Const.UI.Color.povEvent + "]A combination of the main PoV Origin, with the vanilla lone wolf. Meant to be a \"PoV Flavored\" lone wolf scenario. More features planned about this for the future. [/color][/p]";
		this.m.Difficulty = 3;
		this.m.Order = 38;
		this.m.IsFixedLook = true;
		this.m.StartingBusinessReputation = -100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function isValid()
	{
		return this.Const.DLC.Unhold;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 1; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			bro.improveMood(2.0, "Eager to start an adventure")

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
			i = i;
			i = i;
		}

		local bros = roster.getAll();

		bros[0].setStartValuesEx([
			"pov_vattghern_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% is an experienced Vatt'ghern looking for adventure in a new frontier. Fate has brought them to these lands, which is ripe with monsters and opportunity.";
		//bros[0].setName("Vesemir");
		bros[0].setTitle("The Lone Vatt'ghern");
		bros[0].setPlaceInFormation(4);
		bros[0].getBaseProperties().Hitpoints += 5;
		bros[0].getBaseProperties().MeleeSkill += 4;
		bros[0].getBaseProperties().RangedSkill += 4;
		bros[0].getBaseProperties().MeleeDefense += 2;
		bros[0].getBaseProperties().RangedDefense += 5;
		bros[0].getSkills().add(this.new("scripts/skills/traits/pov_vattghern_trait"));
		bros[0].getFlags().increment("pov_ActiveMutations");
		//bros[0].getSkills().add(this.new("scripts/skills/traits/pov_old_vattghern_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendPotionBrewer);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendFieldTriage);
		//bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
		//bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_field_triage"));

		bros[0].m.PerkPoints = 4;
		bros[0].m.LevelUps = 4;
		bros[0].m.Level = 5;
		bros[0].setVeteranPerks(2);
		bros[0].m.LifetimeStats.Kills = 40;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/weapons/pov_witcher_longsword"));
		items.equip(this.new("scripts/items/accessory/pov_vattghern_medallion_item"));

		// Skip PoV story events (already start with vattghern)
		// Also unlock base PoV mechanics (ToG,corpses,mutagens,events,some ambitions complete)
		this.World.Flags.add("FirstMutantSpawned");
		this.World.Flags.add("FirstMutantKilledEvent");
		this.World.Flags.add("FirstMutantKilled");
		this.World.Flags.add("GotMutagenEvent");
		this.World.Flags.add("GotMutagen");
		this.World.Flags.add("GotVattghernEvent");
		this.World.Flags.add("GotVattghern");
		this.World.Flags.add("GotMedallion");
		// Reputation and Legends flags
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.addBusinessReputation(-100);
		this.World.Flags.set("HasLegendCampCrafting", true);
		// Starting Supplies
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_fish_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		// Starting Utility (+Leg.Sword, and Vattghern Medallion, equipped on the Vattghern)
		this.World.Assets.getStash().add(this.new("scripts/items/tools/holy_water_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/tools/throwing_net"));
		this.World.Assets.getStash().add(this.new("scripts/items/special/pov_silvering_kit"));
		// Starting Vattghern Items
		//this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		//this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		
		// Add A Random Mutagen (re-changed)
		/*local roll = this.Math.rand(1,14);
		switch (roll) 
		{
			case 1: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_alp_mutagen_item")); break;
			case 2: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_direwolf_mutagen_item")); break;
			case 3: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghost_mutagen_item")); break;
			case 4: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghoul_mutagen_item")); break;
			case 5: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_goblin_mutagen_item")); break;
			case 6: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_hexe_mutagen_item")); break;
			case 7: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_lindwurm_mutagen_item")); break;
			case 8: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_vampire_mutagen_item")); break;
			case 9: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_orc_mutagen_item")); break;
			case 10: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_schrat_mutagen_item")); break;
			case 11: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_skeleton_mutagen_item")); break;
			case 12: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_spider_mutagen_item")); break;
			case 13: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_unhold_mutagen_item")); break;
			case 14: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_strain_mutagen_item")); break;
			default: ::TLW.Mod.Debug.printLog("No Mutation found to roll. Roll Number: " + roll);
		}*/
		// Starting Resource Modifiers
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 2.0);
		this.World.Assets.m.Medicine = this.Math.round(this.World.Assets.m.Medicine * 2.0);
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
			{
				break;
			}

			i = ++i;
			i = i;
			i = i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 3), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 3), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(11);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.pov_solo_scenario_intro");
		}, null);
	}


	function onGenerateBro(bro)
	{
		local r;
		r = this.Math.rand(0,6);
		if (bro.getBackground().getID() == "background.beast_slayer")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.85);
			bro.getBaseProperties().DailyWageMult *= 0.85;
			bro.getSprite("socket").setBrush("bust_base_beasthunters");
			bro.getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
			bro.improveMood(1.5, "Found the right band to join!");
		}
		else if (bro.getBackground().getID() == "background.legend_druid")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 0.50;
			bro.getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
			bro.improveMood(1.5, "Feels at one with nature");
		}
		else if (bro.getBackground().getID() == "background.legend_vala")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 0.50;
			bro.getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
			bro.improveMood(1.5, "Feels at one with nature");
		}
		else if (r == 0 || r == 1 || bro.getSkills().hasSkill("trait.hate_beasts"))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.85);
			bro.getBaseProperties().DailyWageMult *= 0.85;
			if (!bro.getSkills().hasSkill("trait.hate_beasts"))
			{
				bro.getSkills().add(this.new("scripts/skills/traits/hate_beasts_trait"));
			}
			bro.improveMood(1.5, "Hates beasts as much as you do");
		}
		else if (bro.getSkills().hasSkill("trait.pov_hate_everything"))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.90);
			bro.getBaseProperties().DailyWageMult *= 0.90;
			bro.improveMood(1.0, "Their hate includes your enemies");
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.50);
			bro.getBaseProperties().DailyWageMult *= 1.50;
			bro.worsenMood(1.5, "Has heard terrifying things about your kind...");
		}

		bro.getSkills().update();
	}


	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.FootprintVision = 1.75;
		this.World.Assets.m.BuyPriceMult = 1.15;
		this.World.Assets.m.SellPriceMult = 0.85;
		this.World.Assets.m.ExtraLootChance = 30;
		this.World.Assets.m.BrothersMax = 12;
		//this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		if (this.World.State.getPlayer() != null)	//fallback for movespeed multiplier
		{
			// No idea why I did the do like it is done
			//this.World.State.getPlayer().m.BaseMovementSpeed = 125;
		}
	}

	function getMovementSpeedMult(){
		return 1.064;
	}

	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "beast_hunter_background", 7);
	}

});

