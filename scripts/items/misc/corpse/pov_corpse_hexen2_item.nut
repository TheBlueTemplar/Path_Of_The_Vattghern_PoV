this.pov_corpse_hexen2_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_hexen2";
		this.m.Name = "Coven Leader Corpse";
		this.m.Description = "The coven leader is obiously not human. Every aspect of their appearance is demonic.  A skilled medicus may be able to extract useful materials from this corpse.";
		this.m.Icon = "consumables/pov_corpse_hexe2.png";
		this.m.GoodForDays = 10;
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
				image = "consumables/pov_enemy_hexe2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The coven leader is an ancient and powerful hexen.  While they meet infrequently and are solitary creatures, all hexen will follow a coven leaders commands without question.\n\nThey are much more adept in all forms of magic than other hexen, having proven themselves over many centuries."
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

