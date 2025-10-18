this.pov_corpse_vampire2_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_vampire2";
		this.m.Name = "Necrosavant Lord Corpse";
		this.m.Description = "The moment this necrosavant was slain, it burst into flames and fell to the ground in a heap of ash and bone.  There are slight traces of organic matter still intact.\n\nSomeone skilled in alchemy may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_vampire2.png";
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
				image = "consumables/pov_enemy_vampire2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The necrosavant lord is older and much stronger than a typical necrosavant.  They tend to be very reclusive, as their batlike features have become prominent\n\nNecrosavants have the ability to transform into bats to move very quickly."
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

