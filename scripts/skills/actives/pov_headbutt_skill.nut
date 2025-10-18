this.pov_headbutt_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_headbutt";
		this.m.Name = "Headbutt";
		this.m.Description = "Slam your head into the enemy. Damage scales with your current Hp (Softcap 250HP) and is further boosted by muscularity. \n\n Staggers the enemy, and if you have more hp than the enemy, chance to also daze them, scaling with how much more Hp you have. \n\n Has a cooldown of 2 turns.";
		this.m.KilledString = "Headbutted...to death";
		this.m.Icon = "skills/pov_active_headbutt.png";
		this.m.IconDisabled = "skills/pov_active_headbutt_sw.png";
		this.m.Overlay = "pov_active_headbutt";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_01.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_02.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_03.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_04.wav"
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
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local modifier = actor.getHitpoints() * 0.25;
		local damageMin = 5;
		local damageMax = 10;
		local avgMin = modifier - 5;
		local avgMax = modifier + 5;

		if (modifier > 5)
			{
				damageMin += avgMin;
				damageMax += avgMax;
			}

		// Softcap on 250 Hp. Then for every 100 Hp gain ~7 min max Dmg
		// Eg: on 400Hp, damage will be 73 - 94
		if (damageMin > 60) {damageMin = 60 + (modifier * 0.25) - (60 * 0.20);}
		if (damageMax > 80) {damageMax = 80 + (modifier * 0.25) - (80 * 0.15);}

		local ret = this.getDefaultTooltip();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]Staggers[/color] the enemy, and if the user has more HP than the attacked entity, chance to [color=" + this.Const.UI.Color.PositiveValue + "]daze[/color] it. (40% for every 100 Hp difference)"
		});

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] chance to hit the head"
		});

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] chance to hit"
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
			local bodyHealth = actor.getHitpointsMax();
			local modifier = actor.getHitpoints() * 0.25;
			local damageMin = 5;
			local damageMax = 10;
			local avgMin = modifier - 5;
			local avgMax = modifier + 5;

			if (modifier > 5)
				{
					damageMin += avgMin;
					damageMax += avgMax;
				}

			// Softcap on 250 Hp. Then for every 100 Hp gain ~7 min max Dmg
			// Eg: on 400Hp, damage will be 73 - 94
			if (damageMin > 65) {damageMin = 60 + (modifier * 0.25) - (60 * 0.20);}
			if (damageMax > 85) {damageMax = 80 + (modifier * 0.25) - (80 * 0.15);}

			_properties.DamageRegularMin = this.Math.floor(damageMin);
			_properties.DamageRegularMax = this.Math.floor(damageMax);
			_properties.MeleeSkill -= 5;
			_properties.HitChance[this.Const.BodyPart.Head] += 15.0;
		}
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
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

		/*local success = this.Math.rand(1, 100) <= this.getHitchance(_targetTile.getEntity());

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (!success)
		{
			target.onMissed(this.getContainer().getActor(), this);
		}

		if (!success)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			_user.getSkills().onTargetMissed(this, target);
			return success;
		}*/

		local userHp = _user.getHitpoints();
		local targetHp = target.getHitpoints();

		if (userHp > targetHp)
		{
			// For every 100 more Hp -> 40% chance to daze
			local chance = (userHp - targetHp) * 0.40;
			local roll = this.Math.rand(1,100);

			if (roll <= chance)
			{
				local daze = this.new("scripts/skills/effects/dazed_effect");
				target.getSkills().add(daze);
			}
		}

		/*if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}*/

		//_user.getSkills().onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});
