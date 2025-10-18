this.pov_new_company_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.pov_new_company";
		this.m.Name = "A New Company (PoV)";
		this.m.Description = "[p=c][img]gfx/ui/events/pov_new_company_origin.png[/img][/p][p]After years of bloodying your sword for meager pay, you\'ve saved enough crowns to start your very own mercenary company. With you are three experienced mercenaries with whom you\'ve fought side by side in the shieldwall before.\n\n[color=" + this.Const.UI.Color.povEvent + "]Similar to the \"A New Company\" Scenario, tweaked for PoV and Legends, to offer more interactivity.[/color]\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Simple Start:[/color] Start with 3 loyal mercenaries, of decent background, stats and equipment, as well as with some simple, basic supplies. To compensate for the additions, starting money and medicine by 30%, compared to the normal New Company scenario.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 2;
		this.m.StartingBusinessReputation = 10;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(1.5, "Started a mercenary company");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"retired_soldier_background"
		]);
		bros[0].getBackground().m.RawDescription = "{You saved %name%\'s life in a battle against brigands, and he returned the favor in an alley ambush by thieves. Given that common criminals are a few levels beneath brigands, you often joke with him that he is still a little behind on the \'saving each other\'s asses\' debt.}";
		bros[0].setPlaceInFormation(3);
		bros[0].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[0].getBaseProperties().Hitpoints += 12;
		bros[0].getBaseProperties().Stamina += 12;
		bros[0].getBaseProperties().RangedDefense += 2;
		bros[0].getBaseProperties().MeleeDefense += 2;
		bros[0].m.PerkPoints = 0;
		bros[0].m.LevelUps = 0;
		bros[0].m.Level = 1;
		bros[0].getBackground().addPerkGroup(::Const.Perks.MilitiaClassTree.Tree);
		bros[0].getBackground().addPerkGroup(::Const.Perks.SpearTree.Tree);
		bros[0].getBackground().m.Excluded.extend(
			[
				"trait.disloyal",
				"trait.dastard",
				"trait.craven",
				"trait.irrational",
				"trait.fainthearted",
				"trait.fragile",
				"trait.tiny",
				"trait.greedy"
			]);
		bros[0].setVeteranPerks(2);

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));

		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;

		bros[1].setStartValuesEx([
			"lumberjack_background"
		]);
		bros[1].getBackground().m.RawDescription = "{Whatever is wrong with %name% you hope he never fixes it. A character with a particular taste for battling, whoring, gambling, singing, dogfighting, skirt chasing, weirdly dish washing, vomiting and, of course, drinking, he has always been a gift to have around. He also just happens to be an excellent fighter in his own right.}";
		bros[1].setPlaceInFormation(5);
		bros[1].getBaseProperties().MeleeSkill += 5;
		//bros[1].getBaseProperties().RangedSkill += 5;
		bros[1].getBaseProperties().RangedDefense += 4;
		bros[1].getBaseProperties().MeleeDefense += 4;
		bros[1].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[1].m.PerkPoints = 0;
		bros[1].m.LevelUps = 0;
		bros[1].m.Level = 1;
		bros[1].getBackground().addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
		bros[1].getBackground().m.Excluded.extend(
			[
				"trait.disloyal",
				"trait.dastard",
				"trait.craven",
				"trait.irrational",
				"trait.fainthearted",
				"trait.fragile",
				"trait.tiny",
				"trait.greedy"
			]);
		bros[1].setVeteranPerks(2);

		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/weapons/woodcutters_axe"));

		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;

		bros[2].setStartValuesEx([
			"poacher_background"
		]);
		bros[2].getBackground().m.RawDescription = "You crossed paths with %name% a number of times prior to his joining the company. First time you were both simple laborers. The second time you were sellswords. And now is the third go of it with him joining your company. If all goes well, he\'ll finally stick around this time and you\'ll both find the riches you seek.";
		bros[2].setPlaceInFormation(13);
		//bros[2].getBaseProperties().MeleeSkill += 5;
		//bros[2].getBaseProperties().RangedSkill += 3;
		bros[2].getBaseProperties().RangedDefense += 4;
		bros[2].getBaseProperties().MeleeDefense += 4;
		bros[2].m.PerkPoints = 0;
		bros[2].m.LevelUps = 0;
		bros[2].m.Level = 1;
		bros[2].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[2].getBackground().m.Excluded.extend(
			[
				"trait.disloyal",
				"trait.dastard",
				"trait.craven",
				"trait.irrational",
				"trait.fainthearted",
				"trait.fragile",
				"trait.greedy"
			]);
		bros[2].setVeteranPerks(2);

		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Initiative] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.RangedSkill] = 2;

		// Starting Supplies
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		// Starting Value/Misc Items
		this.World.Assets.getStash().add(this.new("scripts/items/trade/peat_bricks_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/knife"));
		// Starting Utility
		this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
		// Reputation and Legends flags
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		// Starting Resource Modifiers
		// This IS a reduction (-30%) compared to new company, as that is doing these two *2.00
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 1.40);
		this.World.Assets.m.Medicine = this.Math.round(this.World.Assets.m.Medicine * 1.40);
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

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
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.pov_new_company_intro");
		}, null);
	}

});

