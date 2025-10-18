::TLW.HooksMod.hook("scripts/retinue/followers/alchemist_follower", function (q) {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "An Alchemist is knowledgeable in crafting all kinds of things, spotting the right ingredients fot the job, and uses less material to do so.";
		this.m.Effects.push("Increases Corpse and Mutagen drop rates by +15%");
	}

});

