this.pov_miasma_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_miasma";
		this.m.Name = "Disturbing Miasma";
		this.m.Description = "Cast a cursed, foul miasma upon your living enemies, reducing their ranged capabilities and harming them.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Can use once per Battle[/color]";
		this.m.Icon = "skills/pov_active_miasma.png";
		this.m.IconDisabled = "skills/pov_active_miasma_sw.png";
		this.m.Overlay = "pov_active_miasma";
		this.m.SoundOnUse = [
			"sounds/enemies/miasma_spell_01.wav",
			"sounds/enemies/miasma_spell_02.wav",
			"sounds/enemies/miasma_spell_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/humans/human_coughing_01.wav",
			"sounds/humans/human_coughing_02.wav",
			"sounds/humans/human_coughing_03.wav",
			"sounds/humans/human_coughing_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.m.Cooldown >= 1)
		{
			ret.extend([
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/warning.png",
					text = "Skill is on cooldown. Will be available in the [color=" + this.Const.UI.Color.NegativeValue + "]next[/color] battle."
				}
			]);
		}

		return ret;
	}

	function onCombatStarted()
	{
		this.m.Cooldown = 0;
	}

	function isUsable()
	{
		if (this.m.Cooldown <= 0){
			return true;
		}else{
			return false;
		}
	}

	function isViableTarget( _user, _target )
	{
		if (_target.isAlliedWith(_user))
		{
			return false;
		}

		if (_target.getFlags().has("undead"))
		{
			return false;
		}

		if (_target.getTile().Properties.Effect != null)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 999;
		local targets = [];
		targets.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		local p = {
			Type = "miasma",
			Tooltip = "Miasma lingers here, harmful to any living being, and reducing their ranged capabilities.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = false,
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyPovMiasma,
			function Applicable( _a )
			{
				return !_a.getFlags().has("undead");
			}

		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "miasma")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
			}
			else
			{
				if (tile.Properties.Effect != null)
				{
					this.Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.MiasmaParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.MiasmaParticles[i].Brushes, tile, this.Const.Tactical.MiasmaParticles[i].Delay, this.Const.Tactical.MiasmaParticles[i].Quantity, this.Const.Tactical.MiasmaParticles[i].LifeTimeQuantity, this.Const.Tactical.MiasmaParticles[i].SpawnRate, this.Const.Tactical.MiasmaParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
				if (tile.IsOccupiedByActor)
				{
					this.Const.Tactical.Common.onApplyPovMiasma(tile, tile.getEntity());
				}
			}
		}

		return true;
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});

