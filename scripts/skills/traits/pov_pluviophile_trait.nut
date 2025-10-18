this.pov_pluviophile_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_pluviophile";
		this.m.Name = "Pluviophile";
		this.m.Icon = "ui/traits/pov_pluviophile.png";
		this.m.Description = "Where others see gloom, this character finds renewal. The rain sharpens their senses and steadies their heart.";
		this.m.Excluded = [
			"trait.irrational",
			"trait.paranoid",
			"trait.pessimist",
		];
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]Immunity[/color] To rainfall debuffs."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] initiative when in battle and raining."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve when when in battle and raining."
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}


		if (this.Tactical.getWeather().IsRaining)
		{
			_properties.IsAffectedByRain = false;
			_properties.Bravery += 10;
			_properties.InitiativeMult *= 1.10;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});
