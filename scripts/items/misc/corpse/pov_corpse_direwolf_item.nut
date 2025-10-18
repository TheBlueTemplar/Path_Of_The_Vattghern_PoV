this.pov_corpse_direwolf_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_direwolf";
		this.m.Name = "Direwolf Corpse";
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_direwolf.png";
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
				image = "consumables/pov_enemy_direwolf.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The direwolf is twice the size of an ordinary wolf.  They possesses a thick and durable hide, equivalent to hardened leather armor.  They are very intelligent and are completly loyal if tamed.\n\nSimilar to normal wolves, they hunt in packs and attempt overwhelm their prey with numbers."
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

