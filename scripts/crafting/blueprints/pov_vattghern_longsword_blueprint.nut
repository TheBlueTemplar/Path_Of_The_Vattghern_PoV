this.pov_vattghern_longsword_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.pov_vattghern_longsword";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/weapons/pov_vattghern_longsword");
		this.m.Cost = 175;
		local ingredients = [
			{
				Script = "scripts/items/weapons/pov_vattghern_sword",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	// The sword names embed color tags, and the crafting screen prints the name raw.
	function getName() {
		local name = this.blueprint.getName();
		name = ::MSU.String.replace(name, "[color=" + ::Const.UI.Color.povLegendaryWeapon + "]", "");
		return ::MSU.String.replace(name, "[/color]", "");
	}

	function onCraft(_stash) {
		_stash.add(this.new("scripts/items/weapons/pov_vattghern_longsword"));
	}

});
