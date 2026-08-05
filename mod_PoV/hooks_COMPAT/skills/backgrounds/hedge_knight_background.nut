::TLW.HooksMod.hook("scripts/skills/backgrounds/hedge_knight_background", function (q) {
	q.create = @(__original) function () {
		__original();
		local r = this.Math.rand(1, 3);
		if (r == 1) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.RaiderClassTree,
			]);
		} else if (r == 2) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.ClubClassTree,
			]);
		} else if (r == 3) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.LongswordClassTree,
			]);
		}
	}

	q.getTooltip = @(__original) function () {
		//local ret = __original();
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]."
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Once per turn upon killing an enemy execute an attack of opportunity on an enemy on an adjacent tile for [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] damage"
		});
		return ret;
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		if (this.m.ExecutingAttack) {
			_properties.DamageTotalMult *= 0.25;
		}
	}

	q.onUpdate = @(__original) function (_properties) {
		__original(_properties);
		_properties.Threat += 5;
	}
})
