this.pov_armor_ghost_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.pov_armor_ghost";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate (_properties)
	{
		_properties.Threat += 8;

		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("effects.holy_water") || actor.getSkills().hasSkill("effects.legend_consecrated_effect"))
		{
			_properties.DamageTotalMult *= 0.80;
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("effects.holy_water") || actor.getSkills().hasSkill("effects.legend_consecrated_effect"))
		{
			_properties.DamageReceivedArmorMult *= 1.30;
			_properties.DamageReceivedDirectMult *= 0.00;
		}

		if (actor.getArmor(_hitInfo.BodyPart) > 10)
		{
			//_hitInfo.DamageDirect = 0;
			//_hitInfo.DamageMinimum = 0;
			//_hitInfo.DamageRegular = 0;
			_properties.DamageReceivedDirectMult *= 0.00;
			_properties.DamageReceivedRegularMult *= 0.00;
			//_properties.DamageReceivedDirectMult *= 0.00;
		}
	}

});

