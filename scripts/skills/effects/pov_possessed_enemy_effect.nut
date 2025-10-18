this.pov_possessed_enemy_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_possessed_enemy";
		this.m.Name = "[color="+ ::Const.UI.Color.povTooltipBlue + "] Possessed! [/color]";
		this.m.Description = "This enemy is possessed by the will to eat pizza!!!";
		this.m.Icon = "skills/pov_geist_possessed.png";
		this.m.IconMini = "pov_mini_geist_possessed";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This enemy is possessed by the will to eat pizza!!!";
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Skibidi rizz[/color], you shouldn\'t be able to see dis!!"
			}
		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();

		// Adds sprite for the mutation effect (glow) (Switched to a blue, larger version)
		if (actor.hasSprite("pov_back_socket"))
		{
			local mutant_glow_sprite = actor.getSprite("pov_back_socket");
			mutant_glow_sprite.setBrush("pov_mutant_glow"); //credit to ROTU mod for base art
			mutant_glow_sprite.Color = this.createColor("#" + this.Math.rand(1,5) + "64edb"); // Blue, slight variance
			mutant_glow_sprite.Saturation = 0.9;
			mutant_glow_sprite.Scale = 1.1;
			mutant_glow_sprite.Visible = true;

			// Adds Effect to animate above sprite
			if (!actor.getSkills().hasSkill("effects.pov_enemy_mutation_effect"))
			{
				actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_effect"));
			}
		}
		// Adds Blu Eyez
		if (actor.hasSprite("permanent_injury_4"))
		{
			local sprite = actor.getSprite("permanent_injury_4");
			sprite.Visible = true;
			sprite.setBrush("pov_possessed_eyes");
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.DamageDirectMult += 0.15;
		_properties.Threat += 5;
		_properties.Bravery += 10;
		_properties.FatigueEffectMult *= 0.40;
		_properties.StaminaMult *= 1.10;
		_properties.MoraleEffectMult = 0.10;
		// Debuffs
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{	
		_properties.DamageReceivedTotalMult *= 0.75;
	}

});
