::TLW.HooksMod.hook("scripts/skills/backgrounds/gravedigger_background", function (q) {
	q.create = @(__original) function () {
		__original();
		this.m.PerkTreeDynamic.Class.extend([
			::Const.Perks.ShovelClassTree,
		]);
	}

	q.getTooltip = @(__original) function () {
		local ret = __original();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]."
		});
		return ret;
	}

	q.onUpdate = @(__original) function (_properties) {
		__original(_properties);
		_properties.Threat += 3;
	}
})
