this.pov_non_vattghern_sword_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_non_vattghern_sword_effect";
		this.m.Name = "Incapable Wielder";
		this.m.Description = "This character is wielding a weapon not meant for their hands - but those of a vatt\'ghern. Penalties will apply to all their skills used while holding this.";
		this.m.Icon = "skills/pov_non_vattghern_effect.png";
		this.m.IconMini = "pov_mini_non_vattghern_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is wielding a weapon not meant for their hands - but those of a vatt\'ghern. [color=" + this.Const.UI.Color.NegativeValue + "]Penalties to damage and fatigue[/color] will apply to all their skills used while holding this.";
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
				icon = "ui/icons/damage_dealt.png",
				text = "This character deals [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "All skills cost [color=" + this.Const.UI.Color.NegativeValue + "]+20%[/color] more fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] chance to hit the head"
			},
		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		//this.m.isActive = false;
		if (this.Tactical.isActive() && actor.isPlacedOnMap())
		{
			this.spawnIcon("pov_medium_non_vattghern_effect", this.getContainer().getActor().getTile());
		}
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.85;
		_properties.FatigueEffectMult *= 1.20;
		_properties.HitChance[this.Const.BodyPart.Head] -= 5;

		local actor = this.getContainer().getActor();
		//local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local mainhand = actor.getMainhandItem();

		if (mainhand != null && mainhand.getID() != "weapon.pov_witcher_longsword" || actor.getSkills().hasSkill("trait.pov_witcher"))
		{
			this.removeSelf();
		}	
	}

});
