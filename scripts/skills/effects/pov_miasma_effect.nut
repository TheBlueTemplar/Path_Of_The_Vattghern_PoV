this.pov_miasma_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_miasma";
		this.m.Name = "Miasma Cloud";
		this.m.Description = "The thick unholy miasma has gotten into this character\'s eyes and nostrils, damaging them and lowering their ranged capabilities.";
		this.m.Icon = "skills/pov_miasma_status_effect.png";
		this.m.IconMini = "pov_mini_miasma_status_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The thick unholy miasma has gotten into this character\'s eyes and nostrils, damaging them and lowering their ranged capabilities.";
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
				text = "Gain [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Gain [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Gain [color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Vision."
			}

		];

		if (this.m.TurnsLeft >= 1)
		{
			ret.extend([
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/special.png",
					text = "This effect will last for [color=" + this.Const.UI.Color.NegativeValue + "]"+this.m.TurnsLeft+"[/color] more turns"
				}
			]);
		}

		return ret;
	}

	function onAdded() 
	{
		this.m.TurnsLeft = 1;
		this.spawnIcon("pov_medium_miasma_status_effect", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.Vision -= 3;
		_properties.RangedDefense -= 10;
		_properties.RangedSkill -= 10;
	}

	function onTurnEnd()
	{
		this.m.TurnsLeft -= 1;

		if (this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
