this.pov_silver_ingot_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_silver_ingot_02";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/trade/pov_silver_ingots_item");
		this.m.Cost = 180;
		local ingredients = [
			{
				Script = "scripts/items/loot/silver_bowl_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_legend_tools_spares"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/trade/pov_silver_ingots_item"));
	}

});

