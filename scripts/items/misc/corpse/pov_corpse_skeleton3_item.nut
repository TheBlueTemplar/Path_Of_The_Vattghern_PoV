this.pov_corpse_skeleton3_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_skeleton3";
		this.m.Name = "Skeleton Priest Headpiece";
		this.m.Description = "The headpiece you found on the skeleton priest is crackling with energy.  It is much more concentrated than the residual energies found in the bones.\n\nSomeone skilled in alchemy may be able to extract something from it.";
		this.m.Icon = "consumables/pov_corpse_skeleton3.png";
		this.m.Value = 125;
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
				image = "consumables/pov_enemy_skeleton3.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The skeleton priests were highly placed in the legions.  While they may not be the origin of the undead curse, they are certainly much closer associated with it.\n\nPriests will stay on the back lines, protected by their honor guard.  They have the ability to cast powerful offensive magics in combat."
		});

		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Energies will dissipate in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});

		return result;

	}

});

