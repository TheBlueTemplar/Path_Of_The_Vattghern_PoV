this.pov_autopsy_ghost4_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_ghost4";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_ghost4_item");
		this.m.Cost = 160;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_ghost4_item",
				Num = 1
			},
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
		if (this.Math.rand(1, 100) <= 25)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/pov_ghost_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 20)
			{
				_stash.add(this.new("scripts/items/armor_upgrades/pov_ghost_plates_upgrade"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/loot/pov_old_crest_item"));
			}	

	}

});


