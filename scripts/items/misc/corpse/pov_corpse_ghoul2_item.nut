this.pov_corpse_ghoul2_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_ghoul2";
		this.m.Name = "Skin Nachzehrer Corpse";
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_ghoul2.png";
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
				image = "consumables/pov_enemy_ghoul2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The skin nachzehrer is larger, faster and more agressive than the normal variety.  The skin nachzehrer has razor sharp tallons that can easily tear through armor.  It isn't entirely clear if this is its own skin or it is wearing the skin of one of its victims.\n\nThis foe has an increadible reach and can attack in a large area, causing severe bleeding wounds.  It also has the ability to consume corpses to heal its wounds and increase its strength."
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

