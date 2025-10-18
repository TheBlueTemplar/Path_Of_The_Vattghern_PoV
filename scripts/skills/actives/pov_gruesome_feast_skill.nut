this.pov_gruesome_feast_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0,
		MaxHp = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_gruesome_feast";
		this.m.Name = "Gruesome Feast";
		this.m.Description = "Feast on a fresh corpse, to Restore 50% of Max Hp, plus 25. If at full HP after healed, also treats one of current non permanent injuries. Feasting also grants one temporary buff, increasing all base stats.\n\n Two turns cooldown \n\n [color=" + this.Const.UI.Color.NegativeValue + "]Using this skill will lower the mood of all nearby bros.[/color]";
		this.m.Icon = "skills/pov_active_feast.png";
		this.m.IconDisabled = "skills/pov_active_feast_sw.png";
		this.m.Overlay = "pov_active_feast";
		this.m.SoundOnUse = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAudibleWhenHidden = false;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
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
	}

	function onCombatStarted()
	{
		this.m.Cooldown = 0;
	}

	function onTurnStart()
	{
		if (this.m.Cooldown >= 2)
		{
			this.m.Cooldown -= 1;
		} else if (this.m.Cooldown == 1)
		{
			this.m.Cooldown = 0;
		}
		
	}

	function isUsable()
	{
		if (this.m.Cooldown <= 0){
			return true;
		}else{
			return false;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (_targetTile.IsEmpty)
		{
			return false;
		}

		if (!_targetTile.IsCorpseSpawned)
		{
			return false;
		}

		if (!_targetTile.Properties.get("Corpse").IsConsumable)
		{
			return false;
		}

		return true;
	}

	function spawnBloodbath( _targetTile )
	{
		for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
		{
			_targetTile.spawnDetail(this.Const.CorpsePart[i]);
		}

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				for( local n = this.Math.rand(0, 2); n != 0; n = --n )
				{
					local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
					tile.spawnDetail(decal);
				}
			}
		}

		local myTile = this.getContainer().getActor().getTile();

		for( local n = 2; n != 0; n = --n )
		{
			local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
			myTile.spawnDetail(decal);
		}
	}

	function onRemoveCorpse( _tag )
	{
		this.Tactical.Entities.removeCorpse(_tag);
		_tag.clear(this.Const.Tactical.DetailFlag.Corpse);
		_tag.Properties.remove("Corpse");
		_tag.Properties.remove("IsSpawningFlies");
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		_targetTile = _user.getTile();

		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
			}
		}

		if (!_user.isHiddenToPlayer())
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
		}
		else
		{
			this.onRemoveCorpse(_targetTile);
		}

		this.spawnBloodbath(_targetTile);
		
		local actor = this.getContainer().getActor();
		local maxHp = actor.getHitpointsMax();
		actor.setHitpoints(this.Math.min(actor.getHitpoints() + maxHp * 0.5 + 25, maxHp));
		local skills = actor.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);
		actor.getSkills().add(this.new("scripts/skills/effects/pov_feasted_effect"));

		foreach( s in skills )
		{
			if(s.isType(this.Const.SkillType.PermanentInjury)) continue;	// Prevents the Legends-Nacho-Mask from healing permanent Injuries.
			s.removeSelf();
			break;
		}

		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (_user.getTile().getDistanceTo(a.getTile()) > 3)
			{
				continue;
			}

			if (a.getFaction() != _user.getFaction())
			{
				continue;
			}

			a.worsenMood(1.0, "Witnessed someone eat a corpse");
		}

		_user.onUpdateInjuryLayer();
		return true;
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});

