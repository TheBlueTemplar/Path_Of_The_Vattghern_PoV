this.pov_ghost_slash_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_ghost_slash";
		this.m.Name = "Ghost Slash";
		this.m.Description = "A swift slashing attack dealing average damage.";
		this.m.KilledString = "Cut down";
		this.m.Icon = "skills/pov_active_ghost_slash.png";
		this.m.IconDisabled = "skills/pov_active_ghost_swing_sw.png";
		this.m.Overlay = "pov_active_ghost_slash";
		this.m.SoundOnUse = [
			"sounds/combat/pov_ghost_slash_01.wav",
			"sounds/combat/pov_ghost_slash_02.wav",
			"sounds/combat/pov_ghost_slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pov_ghost_slash_hit_01.wav",
			"sounds/combat/pov_ghost_slash_hit_02.wav",
			"sounds/combat/pov_ghost_slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		//this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		//this.m.HitChanceBonus = 10;
		this.m.DirectDamageMult = 0.55;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 50;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		// Base Stats
		//_properties.DamageRegularMin += 50;
		//_properties.DamageRegularMax += 70;
		//_properties.DamageArmorMult *= 0.60;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		/*
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit"
			}
		]);
		*/
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// Base Stats
			_properties.DamageRegularMin += 47;
			_properties.DamageRegularMax += 67;
			_properties.DamageArmorMult *= 0.55;
		}
	}

});

