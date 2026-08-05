::TLW.HooksMod.hook("scripts/skills/traits/fearless_trait", function (q) {
	q.getTooltip = @(__original) function () {
		local ret = __original();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-2[/color]."
		});
		return ret;
	}

	q.onUpdate = @(__original) function (_properties) {
		__original(_properties);
		_properties.Threat += 2;
	}
})
