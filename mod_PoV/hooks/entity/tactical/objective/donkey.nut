::TLW.HooksMod.hook("scripts/entity/tactical/objective/donkey", function ( q )
{
	q.onInit = @(__original) function()
	{	
		__original()

		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push([3,"scripts/items/misc/anatomist/pov_donkey_mutagen_item"]);
		}

		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)

	}

});
