::TLW.HooksMod.hook("scripts/crafting/blueprints/trade/legend_silver_ingot_02_blueprint", function ( q )
{
	// Remove Legends Silver ingots - Keep mine (mueheh)
	q.isValid = @(__original) function()
	{
		return false;
	}
});
