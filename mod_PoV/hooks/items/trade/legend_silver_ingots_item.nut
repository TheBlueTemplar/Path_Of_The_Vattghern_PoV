::TLW.HooksMod.hook("scripts/items/trade/legend_silver_ingots_item", function ( q )
{
	// Remove Legends Silver ingots - Keep mine (mueheh)
	// Not done fully, also needs to be done from buildings where this is produced
	// See in hooks, attached_locations
	q.create = @(__original) function()
	{
		__original();
		this.m.ProducingBuildings = [];
		this.m.ResourceValue = 1;
	}

	q.onAddedToStash = @(__original) function(_stashID)
	{
		this.World.Assets.getStash().removeByID("misc.legend_silver_ingots");
	}

});
