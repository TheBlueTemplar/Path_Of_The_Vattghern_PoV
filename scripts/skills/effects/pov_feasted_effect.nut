this.pov_feasted_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_feasted";
		this.m.Name = "Feasted";
		this.m.Icon = "skills/status_effect_10.png";
		this.m.IconMini = "status_effect_10_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has recently feasted, gaining [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] max HP and Stamina, and [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] to all of their other base stats.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Lasts for two turns[/color]";
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
		_properties.Stamina += 10;
		_properties.MeleeSkill += 4;
		_properties.MeleeDefense += 4;
		_properties.RangedDefense += 4;
		_properties.Bravery += 4;
		_properties.Initiative += 4;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

