this.pov_ghost_aetherial_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_ghost_aetherial";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Aetherial[/color]";
		this.m.Description = "This enemy has some properties of an Orc! They are much more agressive, and deal more damage, at the cost of their defences.";
		this.m.Icon = "skills/pov_sword_ghost.png";
		this.m.IconMini = "pov_mini_sword_ghost";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are much more agressive, and deal more damage, at the cost of their defences.";
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
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Gains a [color=" + this.Const.UI.Color.NegativeValue + "]10% + 5[/color] reduction to Ranged Defense."
			}
		];
		return ret;
	}

	function onAdded() 
	{
		this.spawnIcon("pov_medium_sword_ghost", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.MeleeDefense += 30;
		_properties.RangedDefense += 400;
		// Debuffs
		//_properties.InitiativeMult *= 1.00;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 0.30;

		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedTotalMult *= 1.25;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		// for later
	}

});
