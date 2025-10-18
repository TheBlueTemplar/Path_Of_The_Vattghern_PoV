this.pov_corpse_unhold_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_unhold";
		this.m.Name = "Unhold Corpse";
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/pov_enemy_unhold.png";
		this.m.Icon = "consumables/pov_corpse_unhold.png";
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
				image = "consumables/pov_enemy_unhold.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The unhold is a very large, and very stong creature. While their intelligence is lacking, they are very agressive and territorial. \n\nUnholds are known to be able to crush entire battlelines by charging and throwing people around like they are nothing, but their most notorious trait is the ability to rapidly regenerate from any wound. \n\n Rumors say that the barbarians of the north have even tamed some of these creatures..."
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

