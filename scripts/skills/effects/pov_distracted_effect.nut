this.pov_distracted_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.pov_distracted";
		this.m.Name = "Sand in the Eyes";
		this.m.Icon = "skills/status_effect_122.png";
		this.m.IconMini = "status_effect_122_mini";
		this.m.Overlay = "status_effect_122";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character was on the receiving end of a dirty trick. With sand in their eyes, they are distracted for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s). Their vision is obscured, making landing strikes much harder, and not hit as hard";
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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color] Melee Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Vision"
			}
		];
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regained his focus thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 1 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_122", this.getContainer().getActor().getTile());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned") && !this.getContainer().hasSkill("effects.dazed"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.DamageTotalMult *= 0.90;
		_properties.MeleeSkillMult *= 0.70;
		_properties.RangedSkillMult *= 0.70;
		_properties.Vision -= 3;

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned") && !this.getContainer().hasSkill("effects.dazed"))
		{
			actor.getSprite("status_stunned").setBrush("bust_distracted");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

