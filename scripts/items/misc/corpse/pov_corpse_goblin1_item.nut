this.pov_corpse_goblin1_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_goblin1";
		this.m.Name = "Goblin Corpse";
		this.m.Description = "This corpse is still in fairly good condition.  However, goblin organs hold little value.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_goblin1.png";
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
				image = "consumables/pov_enemy_goblin1.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "Goblins are small humanoids that are very agressive and have a primitive, tribal culture.  In comparisson to a human, they are very agile and have superior eyesight.  They excel at ranged combat and prefer ambush tactics.\n\nLegends say that, long ago,the goblins were a highly advanced and peaceful race."
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

