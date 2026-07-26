this.pov_mutants_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},

	function create() {
		this.m.ID = "scenario.pov_mutants";
		this.m.Name = "(PoV) Mutants";
		this.m.Description = "[p=c][img]gfx/ui/events/pov_mutants_origin.png[/img][/p][p]The world is sick, and you are part of that sickness. You do not care, you have accepted it long ago. After conversing with a man of peculiar expertise, you have decided to set out in the world, together, to find like minded individuals, and get yourself what life did not grant you.\n\n[color=" + this.Const.UI.Color.povOriginGood + "]Mutants:[/color] Start with an anatomist and two battle-ready mutants. Mutants in this origin do not have the penalties of the \"Unstable Mutations\" trait. \n\n[color=" + this.Const.UI.Color.povOriginGood + "]Like-minded individuals:[/color] Mutants, Anatomists, Alchemists, Taxidermists and Inventors can be found more frequently, and are cheaper to recruit and maintain. You can also find Forsaken, a background exclusive to this origin. \n\n[color=" + this.Const.UI.Color.povOriginGood + "]Mutation Expertise:[/color] You cannot get corpse drops. Instead, mutagen drop rate from enemy mutants is increased x2.5 . Enemy mutants appear 20% more often, and you deal 10% more damage to them. You also get 15% more loot. You can still create a Vatt\'ghern normally if you wish, but you will not get the guiding \"story\" events. \n\n[color=" + this.Const.UI.Color.povOriginBad + "]Repulsive:[/color] Start hostile to a random northern and southern faction. Get 10% worse prices overall. All backgrounds for hire not mentioned above are more expensive.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 42;
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets() {
		local roster = this.World.getPlayerRoster();
		local names = [];

		for (local i = 0; i < 3; i = ++i) {
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			if (i == 0) {
				bro.improveMood(1.0, "What did I get myself into?");
			} else {
				bro.improveMood(1.5, "Tackles life head on!");
			}

			while (names.find(bro.getNameOnly()) != null) {
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		// Anatomist
		bros[0].setStartValuesEx([
			"anatomist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{The past does not matter. What does is that this one is now roaming with a bunch of mutants. Sky\'s the limit!}";
		bros[0].setPlaceInFormation(3);
		bros[0].getBaseProperties().Hitpoints += 12;
		bros[0].getBaseProperties().MeleeSkill += 7;
		bros[0].getBaseProperties().MeleeDefense += 4;
		bros[0].getBaseProperties().RangedDefense += 4;
		bros[0].getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bros[0].setVeteranPerks(2);

		// Melee Mutant
		bros[1].setStartValuesEx([
			"pov_mutant_background"
		]);
		bros[1].setPlaceInFormation(5);
		bros[1].getBaseProperties().MeleeSkill += 6;
		bros[1].getBaseProperties().RangedDefense += 3;
		bros[1].getBaseProperties().MeleeDefense += 3;
		bros[1].setVeteranPerks(2);

		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/heater_shield"));

		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 2;

		// Ranged Mutant
		bros[2].setStartValuesEx([
			"pov_mutant_background"
		]);
		bros[2].setPlaceInFormation(13);
		bros[2].getBaseProperties().RangedSkill += 8;
		bros[2].getBaseProperties().RangedDefense += 5;
		bros[2].getBaseProperties().Hitpoints += 6;
		bros[2].setVeteranPerks(2);

		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));

		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;

		// Skip starting story events
		this.World.Flags.add("FirstMutantSpawned");
		this.World.Flags.add("FirstMutantKilledEvent");
		this.World.Flags.add("FirstMutantKilled");
		this.World.Flags.add("GotMutagenEvent");
		this.World.Flags.add("GotMutagen");
		this.World.Flags.add("GotVattghernEvent");
		this.World.Flags.add("GotVattghern");

		// Starting Supplies
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		// Starting Value/Misc Items
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/knife"));
		// Starting Utility
		this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
		// Reputation and Legends flags
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		// Starting Resource Modifiers
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 1.50);
		this.World.Assets.m.Medicine = this.Math.round(this.World.Assets.m.Medicine * 2.00);
		this.World.Assets.m.ArmorParts = this.Math.round(this.World.Assets.m.ArmorParts * 1.40);
		this.World.Assets.m.Ammo = this.Math.round(this.World.Assets.m.Ammo * 1.00);
	}

	function onSpawnPlayer() {
		local randomVillage;

		for (local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i) {
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary()
				&& !randomVillage.isIsolatedFromRoads()
				&& randomVillage.getSize() >= 3
				&& !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do {
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y)) {
			} else {
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean
					|| tile.Type == this.Const.World.TerrainType.Shore
					|| tile.IsOccupied)
				{
				} else if (tile.getDistanceTo(randomVillageTile) <= 1) {
				} else {
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty()) {
						randomVillageTile = tile;
						break;
					}
				}
			}
		} while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		// Test Only!
		//randomVillage.addSituation(this.new("scripts/entity/world/settlements/situations/pov_mutants_visit_settlement_situation"));
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function (_tag) {
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.pov_mutants_intro");
		}, null);

		// Random North n South Factions relation drop!
		local makeHostile = function (_settlements, _factionType) {
			if (_settlements.len() == 0) {
				return;
			}

			local settlement = _settlements[this.Math.rand(0, _settlements.len() - 1)];
			local f = settlement.getFactionOfType(_factionType);

			if (f != null) {
				f.addPlayerRelation(-75.0, "This faction hates Mutants");
			}
		};

		local northern = [];
		local southern = [];

		foreach (settlement in this.World.EntityManager.getSettlements()) {
			if (settlement.isIsolatedFromRoads() || settlement.getSize() < 3) {
				continue;
			}

			if (settlement.isSouthern()) {
				southern.push(settlement);
			} else if (!settlement.isMilitary()) {
				northern.push(settlement);
			}
		}

		// North part
		makeHostile(northern, this.Const.FactionType.NobleHouse);

		// South
		makeHostile(southern, this.Const.FactionType.OrientalCityState);
	}

	function onHiredByScenario(bro) {
		if (bro.getBackground().getID() == "background.pov_mutant"
			|| bro.getBackground().getID() == "background.pov_forsaken")
		{
			bro.improveMood(1.5, "Glad to be amongst their kind");
		} else if (bro.getBackground().getID() == "background.anatomist"
			|| bro.getBackground().getID() == "background.legend_alchemist"
			|| bro.getBackground().getID() == "background.legend_taxidermist"
			|| bro.getBackground().getID() == "background.legend_inventor")
		{
			bro.improveMood(1.0, "Happy to join an interesting cause");
		} else if (bro.getSkills().hasSkill("trait.pov_fear_mutants")
			|| bro.getSkills().hasSkill("trait.pov_hate_mutants"))
		{
			bro.worsenMood(1.5, "Hates being amongst Mutants");
		} else {
			bro.worsenMood(0.5, "Feels weird in a company of Mutants");
		}
	}

	function onUpdateHiringRoster(_roster) {
		// Mutants
		this.addBroToRoster(_roster, "pov_mutant_background", 60);
		this.addBroToRoster(_roster, "pov_mutant_background", 40);
		this.addBroToRoster(_roster, "pov_mutant_background", 20);
		this.addBroToRoster(_roster, "pov_mutant_background", 15);
		// Forsaken
		this.addBroToRoster(_roster, "pov_forsaken_background", 30); //def.30,20,10
		this.addBroToRoster(_roster, "pov_forsaken_background", 20);
		this.addBroToRoster(_roster, "pov_forsaken_background", 10);
		// Anatomists
		this.addBroToRoster(_roster, "anatomist_background", 15);
		// Alchemists
		this.addBroToRoster(_roster, "legend_alchemist_background", 10);
		// Taxidermists
		this.addBroToRoster(_roster, "legend_taxidermist_background", 10);
		// Inventors
		this.addBroToRoster(_roster, "legend_inventor_background", 10);
	}

	function onGenerateBro(bro) {
		if (bro.getBackground().getID() == "background.anatomist"
			|| bro.getBackground().getID() == "background.legend_alchemist"
			|| bro.getBackground().getID() == "background.legend_taxidermist"
			|| bro.getBackground().getID() == "background.legend_inventor"
			|| bro.getBackground().getID() == "background.pov_mutant"
			|| bro.getBackground().getID() == "background.pov_forsaken")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.70);
			bro.getBaseProperties().DailyWageMult *= 0.70;
			bro.getSkills().update();
		} else if (bro.getSkills().hasSkill("trait.pov_fear_mutants")
			|| bro.getSkills().hasSkill("trait.pov_hate_mutants"))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.50);
			bro.getBaseProperties().DailyWageMult *= 1.50;
			bro.getSkills().update();
		} else {
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.30);
			bro.getBaseProperties().DailyWageMult *= 1.30;
			bro.getSkills().update();
		}
	}

	function onInit() {
		this.starting_scenario.onInit();
		this.World.Assets.m.BuyPriceMult = 1.10;
		this.World.Assets.m.SellPriceMult = 0.90;
		this.World.Assets.m.ExtraLootChance = 15;
		//this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		if (this.World.State.getPlayer() != null) //fallback for movespeed multiplier
		{
			// No idea why I did the do like it is done
			//this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		}
	}

});
