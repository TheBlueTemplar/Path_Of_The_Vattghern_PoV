this.pov_corpse_basilisk_drone_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_basilisk_drone";
		this.m.Name = "Basilisk Drone Corpse";
		this.m.Description = "This corpse of a magnificent beast is still in fairly good condition.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_basilisk_drone.png";
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
				image = "consumables/pov_enemy_basilisk_drone.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Basilisk is a cruel joke of nature, a beast that mocks the world with the shape not much different from a chicken but the malice of something far worse.\n\n Its feathers are as hard as lamellar, its eyes gleam with vile cunning, and its jagged beak strikes with the precision of a huntsman’s arrow on the poor pray's head.\n\n While not as big and intimindating as larger basilisk, its lethality should never be underestimated. "
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

