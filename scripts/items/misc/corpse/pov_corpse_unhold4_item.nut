this.pov_corpse_unhold4_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_unhold4";
		this.m.Name = "Rock Unhold Corpse";
		this.m.Description = "Although indistinguishable from a pile of ordinary rocks, this unhold corpse is still in fairly good condition.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/pov_enemy_unhold4.png";
		this.m.Icon = "consumables/pov_corpse_unhold4.png";
		this.m.Value = 200;
		this.m.GoodForDays = 15;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		result.push({
				id = 3,
				type = "image",
				image = "consumables/pov_enemy_unhold4.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The rock unhold is by far the toughest of all the unholds.  They prefer to live in rocky, mountain regions.  Their skin is often the color and texture of the areas they inhabit, which can make them very difficult to spot.\n\nTheir ability regenerate from any wound is even better than other unhold varieties, being able to regenerate even their own natural armor. \n\n Entire retinues have fallen to these creatures when unprepared"
		});

		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Will decompose in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});

		return result;

	}

});

