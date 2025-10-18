this.pov_vattghern_medallion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_vattghern_medallion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/pov_vattghern_medallion_item");
		this.m.Cost = 240;
		local ingredients = [
			{
				Script = "scripts/items/trade/pov_silver_ingots_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/legend_iron_ingots_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	// Enable crafting via special event - and pov origins
	function isCraftable()
	{
		// Default isCraftable function (Legends) - needs to be here
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		foreach( c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num < c.Num)
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];

			foreach( s in c.Instances )
			{
				ids.push(s.getID());
			}

			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		//return true;
		return ::World.Flags.has("GotMedallion");
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/pov_vattghern_medallion_item"));
	}

});

