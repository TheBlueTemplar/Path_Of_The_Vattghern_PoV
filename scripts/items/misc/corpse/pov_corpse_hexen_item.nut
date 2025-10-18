this.pov_corpse_hexen_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_hexen";
		this.m.Name = "Hexen Corpse";
		this.m.Description = "The outward appearance of this corpse is that of an ordinary old, very old woman.  Internally, the bones are blackened and have a pungent odor.  A skilled medicus may be able to extract useful materials from this corpse.";
		this.m.Icon = "consumables/pov_corpse_hexe.png";
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
				image = "consumables/pov_enemy_hexe.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The hexen may appear human, but they are more similar to webknecht in their nature, attempting to ensnare their victims and consume them.\n\nThey are often found in the company of spiders, nachzehrer or beasts they have charmed.  Magic seems to be woven into their very bones."
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

