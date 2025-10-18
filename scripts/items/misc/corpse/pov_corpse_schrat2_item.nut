this.pov_corpse_schrat2_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_schrat2";
		this.m.Name = "Greenwood Schrat Corpse";
		this.m.Description = "This outer layers of the schrat corpse are very similar to ordinary wood.  On the inside, there are components that similar to organs.\n\nSomeone skilled in alchemy may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_schrat2.png";
		this.m.Value = 150;
		this.m.GoodForDays = 20;
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
				image = "consumables/pov_enemy_schrat2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The greenwood schrat is the living heart of the forest.  They are nearly immortal and can only be killed by extreme trauma.  Usually very calm and peaceful, they have been growing increasingly agressive in recent years to anyone entering their forests.\n\nAny damage done to them will result in immediate growth smaller clones from the removed wood chips and sap."
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

