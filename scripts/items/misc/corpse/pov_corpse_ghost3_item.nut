this.pov_corpse_ghost3_item <- this.inherit("scripts/items/misc/corpse/pov_corpse_item", {
	m = {},
	function create()
	{
		this.pov_corpse_item.create();
		this.m.ID = "supplies.pov_corpse_ghost3";
		this.m.Name = "Spectral Sword";
		this.m.Description = "The only remains of a fearsome swertgeist, that survived a prior battle. It is rich in an unsettling spectral essence.  Over time its energies will eventually dissipate, ruining the item in the process.\n\n Someone skilled in alchemy may be able to disenchant this sword, or extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_ghost3.png";
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
				image = "consumables/pov_enemy_ghost3.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Swertgeist differs from its kind, for instead of striking horror from afar, it prefers being a terrifying spectre that can charge into battle and easily break unprepared lines. Being almost completely incomporeal, it\'s sword can easily cut through most armor. \n\n It has the capability of sliding in and out of the corporeal plane almost at will, making itself extremely evasive. Expert monster slayers suggest, that if one is not prepared with the right tools, striking at this fell spectre while it itself is attacking is the only choice, as this is when it has to be in the physical plane..."
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

