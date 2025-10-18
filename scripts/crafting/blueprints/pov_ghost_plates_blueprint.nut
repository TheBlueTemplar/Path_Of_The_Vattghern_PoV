this.pov_ghost_plates_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_ghost_plates";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/pov_ghost_plates_upgrade");
		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_iron_ingots_item",
				Num = 1
			}
			{
				Script = "scripts/items/loot/pov_ghost_plates_special_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_legend_potion_brewer"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/armor_upgrades/pov_ghost_plates_upgrade"));
	}

});

