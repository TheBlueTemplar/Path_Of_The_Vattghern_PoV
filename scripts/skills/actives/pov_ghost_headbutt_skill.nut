this.pov_ghost_headbutt_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_ghost_headbutt";
		this.m.Name = "Ghost Headbutt";
		this.m.Description = "Slam your horned head into the enemy. Damage scales with your current armor. Chance to daze the enemy on a body hit, or stun on a head hit. \n\n Has a cooldown of 2 turns.";
		this.m.KilledString = "Headbutted...to death";
		this.m.Icon = "skills/pov_active_ghost_headbutt.png";
		this.m.IconDisabled = "skills/pov_active_ghost_headbutt_sw.png";
		this.m.Overlay = "pov_active_ghost_headbutt";
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
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 5;
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
			text = "High Chance to [color=" + this.Const.UI.Color.NegativeValue + "]daze[/color] enemies hit, and [color=" + this.Const.UI.Color.NegativeValue + "]stun[/color] them on head hits."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] chance to hit"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit the head"
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
			// Hit Chance Mod
			_properties.MeleeSkill -= 5;

			local actor = this.getContainer().getActor();
			local p = actor.getCurrentProperties();
			local mult = p.DamageTotalMult;
			local armor = actor.getArmor(this.Const.BodyPart.Head);
			local modifier = armor * 0.125;
			local damageMin = 5;
			local damageMax = 20;
			//local avgMin = modifier - 5;
			//local avgMax = modifier + 5;

			// Example: on 400 Armor: damage = 45 - 60 (58 - 78 on armor, 0 - 25 ignore armor)
			// Base Stats: 300 H.Armor: damage = 35 - 50 (45 - 65 on armor, 0 - 22 ignore armor)
			if (modifier >= 5)
			{
				damageMin += modifier;
				damageMax += modifier;
			}

			// Hardcap on ~700 Armor.
			if (damageMin > 75) {damageMin = 75;}
			if (damageMax > 90) {damageMax = 90;}

			_properties.DamageRegularMin = this.Math.floor(damageMin);
			_properties.DamageRegularMax = this.Math.floor(damageMax);
			_properties.DamageArmorMult = 1.3;
			_properties.HitChance[this.Const.BodyPart.Head] += 5.0;
		}
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local chance = 60;
			local chanceHead = 75;

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				if (this.Math.rand(0,100) <= chanceHead)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned");
					}
				}
			}
			else if (_bodyPart == this.Const.BodyPart.Body)
			{
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
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});
