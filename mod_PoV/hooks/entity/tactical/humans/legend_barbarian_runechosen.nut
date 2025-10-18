::TLW.HooksMod.hook("scripts/entity/tactical/humans/legend_barbarian_runechosen", function ( q ) {

	q.onInit = @(__original) function()
	{
		__original()

		// Enemy Mutation System
		// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
		// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
		::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.High,::TLW.EnemyMut.MeleeNorth,false);


		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)

		if (this.actor.getSkills().hasSkill("effects.pov_enemy_mutation_direwolf"))
		{
			local roll = this.Math.rand(1,100);
			if (roll <= 4)
			{
				this.actor.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]Furry of the North[/color]";
			}
		}
	}

});