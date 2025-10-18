this.destroy_geists_location_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "destroy_geists_location_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		/*if (!_faction.isReadyForContract())
		{
			return;
		}*/

		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.destroy_geists_location_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		// Only on (half) pro renown
		if (this.World.Assets.getBusinessReputation() < 525)
		{
			return;
		}

		// Check if vattghern is in party
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				vattghern_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0)
		{
			return;
		}

		if (this.World.getTime().Days <= 10 && this.Math.rand(1, 100) < 50 || this.Math.rand(1, 100) > 30)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements();

			foreach( b in bandits )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 18)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			return;
		}

		// Default 1, I want 2
		this.m.Score = 2;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/destroy_geists_location_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

