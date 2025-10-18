this.pov_distilled_alcohol_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_distilled_alcohol_02";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/pov_distilled_alcohol_item");
		this.m.Cost = 125;
		local ingredients = [
			{ 
				Script = "scripts/items/supplies/mead_item", 
				Num = 1 
			},
			{ 
				Script = "scripts/items/supplies/wine_item", 
				Num = 1 
			}
		];
		this.init(ingredients);
	}

	function onCraft(_stash)
	{
		_stash.add(this.new("scripts/items/misc/pov_distilled_alcohol_item"));
	}
});
