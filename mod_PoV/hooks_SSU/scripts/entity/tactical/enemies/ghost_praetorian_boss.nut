::TLW.HooksMod.hook("scripts/entity/tactical/enemies/ghost_praetorian_boss", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()

		// Additional Flags
		if (!this.actor.getFlags().has("ghost"))
		this.actor.getFlags().add("ghost")

	}

});