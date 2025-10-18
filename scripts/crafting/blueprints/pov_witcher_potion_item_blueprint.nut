this.pov_witcher_potion_item_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_witcher_potion_item";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/pov_witcher_potion_item_preview");
		this.m.Cost = 450;
		local ingredients = [
			{
				Script = "scripts/items/misc/pov_distilled_alcohol_item",//craftable from 2 alcoholic items
				Num = 1
			},
			{
				Script = "scripts/items/misc/third_eye_item",//drop from alp
				Num = 1
			},
			/*{
				Script = "scripts/items/misc/acidic_saliva_item",//drop from hyena NEW
				Num = 1
			},*/
			{
				Script = "scripts/items/misc/sulfurous_rocks_item",//drop from ifrit NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/poison_gland_item",//drop from spider NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_heart_item",//drop from unhold NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",//drop from direwolf
				Num = 1
			},
			/*{
				Script = "scripts/items/misc/vampire_dust_item",//drop from vampire NEW
				Num = 1
			},*/
			{
				Script = "scripts/items/misc/ghoul_brain_item",//drop from nach
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
		return ::World.Flags.has("GotMutagen");
	}
	
	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
	}

});

