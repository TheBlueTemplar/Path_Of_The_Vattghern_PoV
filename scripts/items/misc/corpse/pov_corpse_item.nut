this.pov_corpse_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ItemType = this.Const.Items.ItemType.Misc; // tis obvious xd
		this.m.Value = 50; // Base Monetary Value (changed for some items)
		this.m.Amount = 50.0; // Ignore, its about food points
		this.m.GoodForDays = 15; // Default days that it lasts for (changed for some items)
		this.m.IsUndesirable = true; // men wont eat it
		this.m.IsAllowedInBag = false; // cant equip it in bag slots
		this.m.MagicNumber = 1821; // prevent re-taking this with alchemist retinue (if number is set to be >25)
	}

	// wont see remaining food in inventory
	function isAmountShown()
	{
		return false;
	}

});

