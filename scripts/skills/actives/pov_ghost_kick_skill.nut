this.pov_ghost_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_ghost_kick";
		this.m.Name = "Ghost Kick";
		this.m.Description = "Slam your horned head into the enemy. Damage scales with your current armor. Chance to daze the enemy on a body hit, or stun on a head hit. \n\n Has a cooldown of 2 turns.";
		this.m.KilledString = "Headbutted...to death";
		this.m.Icon = "skills/pov_active_ghost_kick.png";
		this.m.IconDisabled = "skills/pov_active_ghost_kick_sw.png";
		this.m.Overlay = "pov_active_ghost_kick";
		this.m.SoundOnUse = [
			"sounds/combat/pov_armor_ghost_attack_01.wav",
			"sounds/combat/pov_armor_ghost_attack_02.wav",
			"sounds/combat/pov_armor_ghost_attack_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pov_armor_ghost_attack_hit_01.wav",
			"sounds/combat/pov_armor_ghost_attack_hit_02.wav",
			"sounds/combat/pov_armor_ghost_attack_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.15;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage increases by [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] of current body armor"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Chance to [color=" + this.Const.UI.Color.NegativeValue + "]daze[/color] enemies hit."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]Knockbacks[/color] target hit."
		});

		if (this.m.Cooldown >= 1)
		{
			ret.push(
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/warning.png",
					text = "Skill is on cooldown. Turns remaining: [color=" + this.Const.UI.Color.NegativeValue + "]"+this.m.Cooldown+"[/color]"
				}
			);
		}

		return ret;
	}

	function onCombatStarted()
	{
		this.m.Cooldown = 0;
	}

	function onTurnStart()
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local p = actor.getCurrentProperties();
			local mult = p.DamageTotalMult;
			local armor = actor.getArmor(this.Const.BodyPart.Body);
			local modifier = armor * 0.125;
			local damageMin = 10;
			local damageMax = 20;
			//local avgMin = modifier - 5;
			//local avgMax = modifier + 5;

			// Example: on 400 Armor: damage = 50 - 60 (70 - 84 on armor, 0 - 10 ignore armor)
			if (modifier >= 10)
			{
				damageMin += modifier;
				damageMax += modifier;
			}

			// Hardcap on ~700 Armor.
			if (damageMin > 80) {damageMin = 80;}
			if (damageMax > 90) {damageMax = 90;}

			_properties.DamageRegularMin = this.Math.floor(damageMin);
			_properties.DamageRegularMax = this.Math.floor(damageMax);
			_properties.DamageArmorMult = 1.4;
			//_properties.HitChance[this.Const.BodyPart.Head] += 15.0;
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		//this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		this.attackEntity(_user, _targetTile.getEntity());

		local target = _targetTile.getEntity();

		if (target == null)
		{
			return;
		}
		
		if (!target.isAlive() || target.isDying())
		{
			return;
		}

		local success = this.Math.rand(1, 100) <= this.getHitchance(_targetTile.getEntity());

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (!success)
		{
			target.onMissed(this.getContainer().getActor(), this);
		}

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			success = false;
		}

		if (success)
		{
			this.applyFatigueDamage(target, 10);
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			success = false;
		}

		if (!success)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			_user.getSkills().onTargetMissed(this, target);
			return success;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (_user.getSkills().hasSkill("trait.oath_of_fortification") && target.isAlive() && !target.isNonCombatant())
		{
			local stagger = this.new("scripts/skills/effects/staggered_effect");
			target.getSkills().add(stagger);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(target)));
			}
		}

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		_user.getSkills().onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);

		this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local chance = 50;

			if (this.Math.rand(0,100) <= chance)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
				}
			}	
		}
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});
