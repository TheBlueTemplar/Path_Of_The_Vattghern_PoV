this.pov_vattghern_sword_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.pov_vattghern_sword";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "Maybe it is about time to get a weapon fitting for \'Vatt\'ghern\'... \nWe shall gather the necessary materials, and craft a special sword!";
		this.m.RewardTooltip = "You\'ll be awarded a [color="+ ::Const.UI.Color.povTooltipBlue + "]legendary sword[/color], fit for a Vatt\'ghern!";
		this.m.UIText = "Gather the materials for a \'Vatt'ghern\' sword";
		this.m.TooltipText = "You will need [color="+ ::Const.UI.Color.povTooltipRed + "]2 Silver ingots, 1 distilled alcohol, and 6000 crowns[/color] (will spend half of them). \n\n With these materials, [color="+ ::Const.UI.Color.povTooltipRed + "]approach any town with a weaponsmith[/color]. You\'ll also need space enough in your inventory for a new item.";
		this.m.SuccessText = "[img]gfx/ui/events/pov_vattghern_sword.png[/img] You arrive at a town just large enough to offer the services you seek: a weapon worthy of a vatt\'ghern. After a round of rigorous haggling with the local smith - and testing his mettle to be sure he was fit for the task - you hand over the required materials and wait... \n\n Hours later, the smith himself approaches, the weapon cradled in his hands. A few villagers trail behind him, trying far too hard to look like cutthroats, clearly pressed into service as his \"protection.\" %SPEECH_ON% I\'ll not lie, this was near the best I could manage. Might be the finest weapon I\'ve forged. My only regret is for whatever poor soul finds it pointed their way. %SPEECH_OFF% He passes you the blade, and you study it closely. It is among the finest you\'ve ever seen. No gaudy ornamentation, as it was not built for show, yet the hilt bears engravings and subtle details you never asked for. You do not complain. The balance is flawless, the edge bites deep. \n\n You press a few extra coins into the smith\'s hand before taking your leave. The weight of the weapon is reassuring, and you can hardly wait to see it tested... against monsters most of all.";
		this.m.SuccessButtonText = "That is one glorious weapon!";
	}

	function onUpdateScore()
	{
		local valid = false;
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				if (bro.getLevel() >= 5)
				{
					valid = true;
				}
			}
		}

		if (valid == false)
		{
			return;
		}

		// Enable only if has special event story_02 done, or PoV origin
		if (!::World.Flags.has("GotVattghern"))
		{
			return;
		}

		this.m.Score = 50;
	}

	function onCheckSuccess()
	{
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return false;
		}

		if (this.World.Assets.getMoney() <= 6000)
		{
			return false;
		}

		local items = this.World.Assets.getStash().getItems();
		local ingots = 0;
		local alcohest = false;
		foreach( item in items )
		{
			if (item != null)
			{
				if (item.getID() == "misc.pov_distilled_alcohol")
				{
					alcohest = true;
				}
				else if (item.getID() == "misc.pov_silver_ingots")
				{
					ingots += 1;
				}
			}
		}

		if (alcohest == false && ingots < 2)
		{
			return false;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 2 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		//fallback
		if (town == null)
		{
			return false;
		}

		if (nearTown  && town.hasBuilding("building.weaponsmith") || town.hasBuilding("building.weaponsmith_oriental"))
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		local stash = this.World.Assets.getStash();
		local items = stash.getItems();
		local ingots = 0;
		local alcohest = false;
		foreach( item in items )
		{
			if (item != null)
			{
				if (item.getID() == "misc.pov_distilled_alcohol" && alcohest == false)
				{
					alcohest = true;
					stash.remove(item);
					this.m.SuccessList.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You lose " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
				else if (item.getID() == "misc.pov_silver_ingots" && ingots < 2)
				{
					ingots += 1;
					stash.remove(item);
					this.m.SuccessList.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You lose " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}

		this.World.Assets.addMoney(-3000);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/asset_money.png",
			text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]3,000[/color] Crowns"
		});

		local item = this.new("scripts/items/weapons/pov_witcher_longsword");
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;
		local bestSergeant;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher") && bro.getCurrentProperties().getBravery() > highestBravery)
			{
				bestSergeant = bro;
				highestBravery = bro.getCurrentProperties().getBravery();
			}
		}

		_vars.push([
			"sergeantbrother",
			bestSergeant.getNameOnly()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, bestSergeant.getGender(), "sergeantbrother");
		_vars.push([
			"sergeantbrotherfull",
			bestSergeant.getName()
		]);
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

