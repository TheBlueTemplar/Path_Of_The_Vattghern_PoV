::TLW.HooksMod.hook("scripts/entity/tactical/enemies/ghost", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Additional Flags
		if (!this.actor.getFlags().has("ghost"))
		this.actor.getFlags().add("ghost")
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.Ghost));
	  	}

		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		//this.m.Skills.add(this.new("scripts/skills/effects/pov_serpentine_agility_effect"));
		
		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)

		// No Mutation For Ghosts Currently

		// Edits of other mods (hooks)
		if (::TLW.hasMC && ::TLW.McTweaks)
		{
			local badThing = this.actor.getSkills().getSkillByID("actives.ghost_possess");
			if (badThing)
			{
				this.actor.getSkills().remove(badThing);
			}
		}

		// I do the meme
		if (this.actor.getSkills().hasSkill("effects.pov_enemy_mutation_hexe"))
		{
			local roll = this.Math.rand(1,100);
			if (roll <= 4)
			{
				this.actor.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]Rizzlergeist[/color]";
			}
		}
	}

});