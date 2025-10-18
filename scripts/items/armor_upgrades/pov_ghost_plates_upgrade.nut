this.pov_ghost_plates_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.pov_ghost_plates";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Infused Plates Reinforcement";
		this.m.Description = "Sturdy metal reinforcements, infused with the essense of a rustunggheist. On top of providing additional protection against physiucal attacks, it also helps repel the aetherium, weakening spirit\'s attacks against the wearer. Has a similar - but weaker - effect against other undead. ";
		this.m.ArmorDescription = "Sturdy, infused metal reinforcements have been added to the armor, weakening spirit and undead attacks against the wearer.";
		this.m.Icon = "armor_upgrades/pov_upgrade_ghost_plates.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/pov_icon_upgrade_ghost_plates.png";
		this.m.OverlayIconLarge = "armor_upgrades/pov_inventory_upgrade_ghost_plates.png";
		this.m.SpriteBack = "pov_upgrade_ghost_plates";
		this.m.SpriteDamagedBack = "pov_upgrade_ghost_plates_damaged";
		this.m.SpriteCorpseBack = "pov_upgrade_ghost_plates_dead";

		this.m.Value = 2400;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -5;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage taken from ghost type enemies by [color=" + this.Const.UI.Color.PositiveValue + "]-30%[/color] and by [color=" + this.Const.UI.Color.PositiveValue + "]-15%[/color] for other undead"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage taken from ghost type enemies by [color=" + this.Const.UI.Color.PositiveValue + "]-30%[/color] and by [color=" + this.Const.UI.Color.PositiveValue + "]-15%[/color] for other undead"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo != null && _attacker.getFlags().has("ghost"))
		{
			_properties.DamageReceivedTotalMult *= 0.70;
		} 
		else if (_hitInfo != null && _attacker.getFlags().has("undead"))
		{
			_properties.DamageReceivedTotalMult *= 0.85;
		}
	}

});

