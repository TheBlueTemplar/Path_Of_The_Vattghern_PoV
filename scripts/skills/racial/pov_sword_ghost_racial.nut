this.pov_sword_ghost_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.pov_sword_ghost";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAdded()
	{
		// Add aetherial Effect on combat start (add skill)
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/pov_ghost_aetherial_effect"));
	}

	function onUpdate (_properties)
	{
		_properties.Threat += 8;

		// If under the holy water or the consecration effect, lose some m.attack, also lose aetherial
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("effects.holy_water") || actor.getSkills().hasSkill("effects.legend_consecrated_effect"))
		{
			_properties.MeleeSkill -= 5;

			local skillOld = actor.getSkills().getSkillByID("effects.pov_ghost_aetherial");
			local skillNew = this.new("scripts/skills/effects/pov_ghost_corporeal_effect");

			// fallback
			if (skillOld != null && actor != null)
			{
				actor.getSkills().remove(skillOld);
				actor.getSkills().add(skillNew);

				// here, also change sprites (Visible, No Animated)
				local body = actor.getSprite("body");
				body.setBrush("pov_bust_sword_ghost_02");
				body.Saturation = 1.0;
				body.varyColor(0.2, 0.2, 0.2);
				local head = actor.getSprite("head");
				head.setBrush("pov_bust_sword_ghost_02");
				head.Saturation = 1.0;
				head.varyColor(0.2, 0.2, 0.2);
				local blur_1 = actor.getSprite("blur_1");
				blur_1.setBrush("pov_bust_sword_ghost_02");
				blur_1.Saturation = 1.0;
				blur_1.varyColor(0.2, 0.2, 0.2);
				blur_1.Visible = false;
				local blur_2 = actor.getSprite("blur_2");
				blur_2.setBrush("pov_bust_sword_ghost_02");
				blur_2.Saturation = 1.0;
				blur_2.varyColor(0.2, 0.2, 0.2);
				blur_2.Visible = false;
			}
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		// If not aetherial, become aetherial again! (add back skill)
		local actor = this.getContainer().getActor();
		// If under the holy water or the consecration effect, dont become atherial again
		if (actor.getSkills().hasSkill("effects.holy_water") || actor.getSkills().hasSkill("effects.legend_consecrated_effect"))
		{
			return;
		}

		local skillOld = actor.getSkills().getSkillByID("effects.pov_ghost_corporeal");
		local skillNew = this.new("scripts/skills/effects/pov_ghost_aetherial_effect");
		// fallback
		if (skillOld != null && _damageHitpoints > 1)
		{
			actor.getSkills().remove(skillOld);
			actor.getSkills().add(skillNew);

			// here, also change sprites (Transparent, Animated)
			local body = actor.getSprite("body");
			body.setBrush("pov_bust_sword_ghost_01");
			body.Saturation = 0.7;
			body.varyColor(0.2, 0.2, 0.2);
			local head = actor.getSprite("head");
			head.setBrush("pov_bust_sword_ghost_01");
			head.Saturation = 0.7;
			head.varyColor(0.2, 0.2, 0.2);
			//head.Visible = false;
			local blur_1 = actor.getSprite("blur_1");
			blur_1.setBrush("pov_bust_sword_ghost_01");
			blur_1.Saturation = 0.7;
			blur_1.varyColor(0.2, 0.2, 0.2);
			blur_1.Visible = true;
			local blur_2 = actor.getSprite("blur_2");
			blur_2.setBrush("pov_bust_sword_ghost_01");
			blur_2.Saturation = 0.7;
			blur_2.varyColor(0.2, 0.2, 0.2);
			blur_2.Visible = true;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// If skill is attack, lose aetherial effect (remove skill)
		local actor = this.getContainer().getActor();
		local skillOld = actor.getSkills().getSkillByID("effects.pov_ghost_aetherial");
		local skillNew = this.new("scripts/skills/effects/pov_ghost_corporeal_effect");

		// fallback
		if (skillOld != null && _targetEntity != null)
		{
			if (_skill.getID() == "actives.pov_ghost_slash" || _skill.getID() == "actives.pov_ghost_swing" || _skill.getID() == "actives.pov_ghost_split")
			{
				actor.getSkills().remove(skillOld);
				actor.getSkills().add(skillNew);

				// here, also change sprites (Visible, No Animated)
				local body = actor.getSprite("body");
				body.setBrush("pov_bust_sword_ghost_02");
				body.Saturation = 1.0;
				body.varyColor(0.2, 0.2, 0.2);
				local head = actor.getSprite("head");
				head.setBrush("pov_bust_sword_ghost_02");
				head.Saturation = 1.0;
				head.varyColor(0.2, 0.2, 0.2);
				local blur_1 = actor.getSprite("blur_1");
				blur_1.setBrush("pov_bust_sword_ghost_02");
				blur_1.Saturation = 1.0;
				blur_1.varyColor(0.2, 0.2, 0.2);
				blur_1.Visible = true;
				local blur_2 = actor.getSprite("blur_2");
				blur_2.setBrush("pov_bust_sword_ghost_02");
				blur_2.Saturation = 1.0;
				blur_2.varyColor(0.2, 0.2, 0.2);
				blur_2.Visible = true;
			}
		}
	}

});

