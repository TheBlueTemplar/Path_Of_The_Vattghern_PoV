::TLW.HooksMod.hook("scripts/entity/tactical/enemies/lindwurm", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.Lindwurm));
	  	}

	  	// Other Drops (If Champion)
	  	if(this.actor.m.IsMiniboss == true)
	  	{
	  		this.actor.m.OnDeathLootTable.push([2,"scripts/items/misc/anatomist/pov_lindwurm_mutagen_upgrade_item"]);
	  	}
	  	
		/// Enemy Mutation System
		// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
		// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
		::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.LindwurmGroup,false);


		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)


	}

});