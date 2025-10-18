this.pov_donkey_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_donkey_kick";
		this.m.Name = "Powerful Kick";
		this.m.Description = "The main attack of a donkey, more for defense than attack. Maximum damage is the average of your hitpoints and initiative minus 85.";
		this.m.KilledString = "Kicked to death";
		this.m.Icon = "skills/horse_kick.png";
		this.m.IconDisabled = "skills/horse_kick_bw.png";
		this.m.Overlay = "horse_kick";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
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
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local average = (actor.getInitiative() +  bodyHealth) / 2;
		local damageMin = 5;
		local damageMax = 10;
		local avgMin = average - 100;
		local avgMax = average - 85;

		if ((average - 100) > 0)
			{
			damageMin += avgMin;
			}

		if ((average - 90) > 0)
			{
			damageMax += avgMax;
			}

		if (damageMin > 60) {damageMin = 60;}
		if (damageMax > 80) {damageMax = 80;}

		local damage_regular_min = this.Math.floor(damageMin * p.DamageRegularMult * p.DamageTotalMult);
		local damage_regular_max = this.Math.floor(damageMax * p.DamageRegularMult * p.DamageTotalMult);
		local damage_Armor_min = this.Math.floor(damageMin * p.DamageArmorMult * p.DamageTotalMult);
		local damage_Armor_max = this.Math.floor(damageMax * p.DamageArmorMult * p.DamageTotalMult);
		local damage_direct_max = this.Math.floor(damageMax * this.m.DirectDamageMult);
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
		{
			local muscularity = this.Math.floor(bodyHealth * 0.1);
			 damage_regular_max += muscularity;
			 damage_Armor_max += muscularity;
			 damage_direct_max += muscularity;
		}

		if(mult != 1.0)
		{
			damage_regular_min = this.Math.floor(damage_regular_min * mult);
			damage_regular_max = this.Math.floor(damage_regular_max * mult);
			damage_Armor_min = this.Math.floor(damage_Armor_min * mult);
			damage_Armor_max = this.Math.floor(damage_Armor_max * mult);
			damage_direct_max = this.Math.floor(damage_direct_max * mult);
		}

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
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts damage based on hitpoints and initiative [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage, up to [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] damage can ignore armor"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_max + "[/color] armor damage"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Knocks Targets back, removing their shieldwall, spearwall and riposte"
		});

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] chance to hit"
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
			local mult = p.MeleeDamageMult;
			local bodyHealth = actor.getHitpointsMax();
			local average = (actor.getInitiative() +  bodyHealth) / 2;
			local damageMin = 5;
			local damageMax = 10;
			local avgMin = average - 100;
			local avgMax = average - 85;

			if ((average - 100) > 0)
				{
				damageMin += avgMin;
				}

			if ((average - 90) > 0)
				{
				damageMax += avgMax;
				}

			if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
			{
				local muscularity = this.Math.floor(bodyHealth * 0.1);
				damageMax += muscularity;
			}

			if (damageMin > 60) {damageMin = 60;}
			if (damageMax > 80) {damageMax = 80;}

			_properties.DamageRegularMin = this.Math.floor(damageMin);
			_properties.DamageRegularMax = this.Math.floor(damageMax);
			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.6 : 0.3;
			_properties.DamageArmorMult = _properties.IsSpecializedInFists ? 1.2 : 1.0;
		}
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 1;
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

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});
