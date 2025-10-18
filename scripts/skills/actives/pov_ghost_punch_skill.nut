this.pov_ghost_punch_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_ghost_punch";
		this.m.Name = "Ghost Punch";
		this.m.Description = "A fist area attack that scales with current body armor. Chance to stagger opponents, or baffle them with hits on the head.";
		this.m.KilledString = "Pummeled to death";
		this.m.Icon = "skills/pov_active_ghost_punch.png";
		this.m.IconDisabled = "skills/pov_active_ghost_punch_sw.png";
		this.m.Overlay = "pov_active_ghost_punch";
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
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.125;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
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
			text = "Chance to [color=" + this.Const.UI.Color.NegativeValue + "]stagger[/color] enemies hit, and [color=" + this.Const.UI.Color.NegativeValue + "]baffle[/color] them on head hits."
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		/*if (this.isUsable())
		{
			_properties.DamageRegularMin = 5;
			_properties.DamageRegularMax = 10;
			_properties.DamageArmorMult = 0.5;
		}*/
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
			local damageMin = 15;
			local damageMax = 30;
			//local avgMin = modifier - 5;
			//local avgMax = modifier + 5;

			// Example: on 400 Armor: damage = 55 - 70 (68 - 84 on armor, 0 - 17 ignore armor)
			if (modifier >= 15)
			{
				damageMin += modifier;
				damageMax += modifier;
			}

			// Hardcap on ~800 Armor.
			if (damageMin > 85) {damageMin = 85;}
			if (damageMax > 100) {damageMax = 100;}

			_properties.DamageRegularMin = this.Math.floor(damageMin);
			_properties.DamageRegularMax = this.Math.floor(damageMax);
			_properties.DamageArmorMult = 1.2;
			//_properties.HitChance[this.Const.BodyPart.Head] += 15.0;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local chance = 50;
			local chanceHead = 30;

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				if (this.Math.rand(0,100) <= chanceHead)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));

					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " baffled");
					}
				}
			}
			else if (_bodyPart == this.Const.BodyPart.Body)
			{
				if (this.Math.rand(0,100) <= chance)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " staggered");
					}
				}
			}	
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

