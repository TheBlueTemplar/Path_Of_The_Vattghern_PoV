this.pov_corpse_ghost4_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_ghost4";
		this.m.Name = "Spectral Armor Remains";
		this.m.Description = "The remains of a fearsome Rustunggheist, battered and broken. Despite the spirit being banished from its deathly armor, you can sense the traces of its essence.  Over time its energies will eventually dissipate, ruining the item in the process.\n\n Someone skilled in alchemy may be able to pry still usable parts of this armor - with enchantments relatively intact.";
		this.m.Icon = "consumables/pov_corpse_ghost4.png";
		this.m.Value = 250;
		this.m.GoodForDays = 30;
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
				image = "consumables/pov_enemy_ghost4.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Rustunggheist is maybe the most unique - and fearsome - of its kind. A hulking mass of rusty, heavy and enchanted armor, yet with no body inside, other than its own haunting essence. Makes you think: what kind of man wore this? \n\n In combat, it is surprisingly in the fore, using the armor itself as its weapon with terrifying efficiency. Expert monster slayers (and common sense) point out that the only real way to banish the spirit, is to destroy the armor harboring it. The usual tools, like holy water still appear to help a lot with weakening it... "
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

