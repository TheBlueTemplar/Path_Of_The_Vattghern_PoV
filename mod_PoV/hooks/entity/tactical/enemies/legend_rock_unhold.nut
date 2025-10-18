::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_rock_unhold", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.LegendRockUnhold));
	  	}

	  	// Racial
	  	this.m.Skills.add(this.new("scripts/skills/racial/pov_rock_unhold_racial"));

	  	// Other Drops (If Champion)
	  	if(this.actor.m.IsMiniboss == true)
	  	{
	  		this.actor.m.OnDeathLootTable.push([2,"scripts/items/misc/anatomist/pov_unhold_mutagen_upgrade_item"]);
	  	}
	  	
		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/pov_unhold_waning_fury_effect"));
		}
		
		/// Enemy Mutation System
		// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
		// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
		::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.High,::TLW.EnemyMut.UnholdGroup,false);


		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)


	}

});