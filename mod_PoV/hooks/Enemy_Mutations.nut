// New System
::TLW.MutagenDrop <-
{
	getMutagenDrop = function (_actor, _mutagen)
	{
		local chance = _mutagen.BaseDropChance;

		// Quick way to adjust drop rates, best to keep at 1
		local generalModifier = 1.0;
		chance *= generalModifier;
		
		// Base Drop chance is 2%. Use diff based var belos as general modifier
		// This means a modifier of 200% (4), 125% (2.5), 100% (2) and 70% (1.4)
		// Keep in mind that in lower diffs, less mutants appear
		local difficultyModifier = [2.0, 1.25, 1.0, 0.70][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;

		if (::TLW.ChaosMode)
		{
			// Chaos mode further cuts the mutagen drop chance by 60%, might reduce it more!
			chance *= 0.4;
		}

		// Scenario Based Modifiers
		if (::World.Assets.getOrigin().getID() == "scenario.pov_last_witchers" || ::World.Assets.getOrigin().getID() == "scenario.legends_rangers")
		{
			chance *= 1.15;
		} 
		else if (::World.Assets.getOrigin().getID() == "scenario.pov_solo_last_witchers")
		{
			chance *= 1.20;
		}
		else if (this.World.Assets.getOrigin().getID() == "scenario.anatomists")
		{
			chance *= 1.10;
		}	

		// Alchemist Retinue increases corpse drop rates
		local hasAlchemist = this.World.Retinue.hasFollower("follower.alchemist");
		if (hasAlchemist)
		{
			chance *= 1.15;
		}

		// Dont drop mutagen before killing first mutant
		if(!::World.Flags.has("FirstMutantKilled"))
		{
			chance = 0;
		}

		//chance = 100; //For Testing Only
		::TLW.Mod.Debug.printLog("Rolling for Mutagen Drop || Chance: " + chance);
		return [chance, _mutagen.Script];
	}
}

// Enemy Mutation Chances Const
::TLW.EnemyMutChance <- 
{
	// old values: 5,7,8,9,10,12,15,20.. (reduced by 1% to 3% - from low to high values)
	SLow = 5, 
	VLow = 6,
	Low = 7,
	Medium = 8,
	Default = 9,
	High = 11,
	VHigh = 13,
	SHigh = 17,
	Test50 = 50,
	Test100 = 100
}

// Enemy Mutations Integration and other functions at the end of this file!
// Enemy Mutatuin System	
::TLW.MutateEntity <- 
{
	// Function that handles actor's name change if he has multiple mutations
	function renameActor(_actor, _oldName)
	{
		//skip check if actor isnt a mutant
		if (!_actor.getFlags().has("mutant"))
		{
			return null;
		}

    local skills = _actor.getSkills();
    if (skills == null) return null; // fallback

    foreach (pair in ::TLW.EnemyMutationNames)
    {
        if (skills.hasSkill(pair[0]) && skills.hasSkill(pair[1]))
        {
        	local newName = pair[2];
					if (newName != null) // fallback
					{
						_actor.m.Name = "[color="+ ::Const.UI.Color.povSpecialEnemyMutation + "]"+newName+"[/color] " + _oldName;
						break;
					}
				}
    }
    return null; // no match found
	}

	// New Enemy Mutation System ('Dynamic')
	// _mutations first has to be a defined array before passed here as an arg
	mutate_entity = function(_actor, _chance, _mutations, _hard)
	{
		// fallbacks
		if (_actor.getAIAgent() == null)
		{
			return;
		}

		// With chaos mode enabled, no mutations can come normally
		// (they are given with add mutation all below instead)
		if (::TLW.ChaosMode)
		{
			return;
		}

		local prevName = _actor.m.Name; // Saves actors original name, can be used in other funcs below
		local possibleMutations = _mutations;	// List of all possible mutations
		// Some debug and fallbacks
		if (possibleMutations == null || possibleMutations.len() <= 0)
		{
    	::TLW.Mod.Debug.printLog("Possible Error: Mutation array is empty. Skipping mutation.");
    	return;
		}
		
		// Mutation Chances Calculations Based on CombatDiff (from ez to legenddary)
		// Fallback (might not even work)
		if (_chance == null) {_chance = ::TLW.EnemyMutChance.Default;}
		// Example for most cases with base chance 10. Actual numbers would be: 5,7,10,20
		local mutationChance = [_chance*0.5, _chance*0.75, _chance, _chance*1.8][::World.Assets.getCombatDifficulty()];
		
		// Mutation Chance further increased by passed days (optional)
		if (::TLW.EnemyMutationScaling)
		{
			local day = this.World.getTime().Days;
			if (day != null)
			{
				// These are defined in mod_PoV_scaling_defs.nut
				// TLDR: every 70 days, +0.12 (*12%) to modifier
				if (day >= ::TLW.Scaling.D.Day) {mutationChance *= ::TLW.Scaling.D.Mult;}
				else if (day >= ::TLW.Scaling.C.Day) {mutationChance *= ::TLW.Scaling.C.Mult;}
				else if (day >= ::TLW.Scaling.B.Day) {mutationChance *= ::TLW.Scaling.B.Mult;}
				else if (day >= ::TLW.Scaling.A.Day) {mutationChance *= ::TLW.Scaling.A.Mult;}
			}
		}

		// Second Mutation Chances Calculation
		local secondMutationChance = mutationChance * 2;
		if (_actor.m.IsMiniboss == true) {secondMutationChance = mutationChance * 3;}

		// Increased Mutation Chance - Until it rolls first ever mutant
		if (!::World.Flags.has("FirstMutantSpawned"))
		{
			mutationChance += 30;
		}

		// Roll a Mutation Number
		local roll = this.Math.rand(1.0, 100.0)
		local mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]
		::TLW.Mod.Debug.printLog("Rolling for mutation: " + roll + " vs " + mutationChance);

		if (roll <= mutationChance)
		{
			// Apply Mutation
			::TLW.Mod.Debug.printLog("Rolled mutation number: " + mutations);
			::TLW.EnemyMut.MutationFactory[mutations](_actor, _hard);

			// Second Mutation
			// Only Possible in non-easy diffs
			if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
			{
				local secondRoll = this.Math.rand(1.0, 100.0)
				::TLW.Mod.Debug.printLog("Rolling for second mutation: " + secondRoll + " vs " + secondMutationChance);
				if (secondRoll <= secondMutationChance)
				{
				    // Remove the mutation previosuly added from the array, to avoid duplication
				    possibleMutations.remove(possibleMutations.find(mutations))
				    // Fallback for second mut
				    if (possibleMutations.len() !=0)
				    {	
				    	// Pick a second mutation from the remaining options
				    	local secondMutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]
					    // Apply the second mutation
					    ::TLW.Mod.Debug.printLog("Rolled second mutation number: " + secondMutations);
					    ::TLW.EnemyMut.MutationFactory[secondMutations](_actor, _hard);
				    }
				}
			}
		}

		// If Multiple mutations present, special name change, if chaos mode true, do it then (if chaos mode, happens later)
		renameActor(_actor, prevName);
	}
}

::TLW.Chaos <- 
{
	// Full credits to pot here (well, and Chopeks, and myself at that point xd)
	add_mutation_all = function(_actor, _hard)	// _hard argument is just to pass it to other functions
	{
		// fallbacks
		if (_actor.getAIAgent() == null)
		{
			return;
		}

		// Only run with chaos mode
		if (!::TLW.ChaosMode)
		{
			return;
		}
	
		local prevName = _actor.m.Name; // Saves actors original name, can be used in other funcs below
		local roll;
		// Mutation Chance modification based on game's combat diff
		local mutationChance = [3.0, 4.0, 5.0, 8.0][::World.Assets.getCombatDifficulty()];
		//mutationChance = 25.0; // Debug
		
		// Mutation Chance further increased by passed days (optional)
		// Idea is to start from rare -> frequent (intended for longer playthroughs)
		if (::TLW.EnemyMutationScaling)
		{
			local day = this.World.getTime().Days;
			if (day != null)
			{
				// These are defined in mod_PoV_scaling_defs.nut (70 day increment)
				if (day >= ::TLW.Scaling.D.Day) {mutationChance *= 2.25;}
				else if (day >= ::TLW.Scaling.C.Day) {mutationChance *= 1.75;}
				else if (day >= ::TLW.Scaling.B.Day) {mutationChance *= 1.35;}
				else if (day >= ::TLW.Scaling.A.Day) {mutationChance *= 1.0;}
				else if (day < ::TLW.Scaling.A.Day) {mutationChance *= 0.7;}
			}
		}

		// Create a list of all possible mutations (defined below)
		local possibleMutations = ::TLW.EnemyMut.All;

		// Incremental loop, rolls for each of the possible mutations once
		for (local i = 0; i < possibleMutations.len(); i++)
		{
			roll = this.Math.rand(1.0, 100.0);
			if (roll <= mutationChance)
			{
				local mutation = possibleMutations[i];
				::TLW.EnemyMut.MutationFactory[mutation](_actor, _hard);
				::TLW.Mod.Debug.printLog("Mutated with Roll: " + roll + " / " + mutationChance + " Rolled mutation number: " + mutation);
			}
		}

		// If Multiple mutations present, special name change, if chaos mode true, do it then
		::TLW.MutateEntity.renameActor(_actor, prevName);
	}
}

::TLW.MutantEffect <-
{
	add_mutant_effect = function(_actor)
	{
		// Adds sprite for the mutation effect (glow)
		if (_actor.hasSprite("pov_back_socket"))
		{
			local mutant_glow_sprite = _actor.getSprite("pov_back_socket");
			mutant_glow_sprite.setBrush("pov_mutant_glow"); //credit to ROTU mod for base art
			mutant_glow_sprite.Color = this.createColor("#0" + this.Math.rand(0,9) + this.Math.rand(59,99) + this.Math.rand(0,5) + "a"); // make the 96 part random! (70 - 99?)
			mutant_glow_sprite.Saturation = 0.8;
			mutant_glow_sprite.Scale = 0.9;
			//mutant_glow_sprite.varySaturation(0.1);
			//mutant_glow_sprite.varyColor(0.05, 0.05, 0.05);
			mutant_glow_sprite.Visible = true;

			// Adds Effect to animate above sprite
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_effect"))
			{
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_effect"));
			}
		}

		// Adds sprite for the mutation effect (bust)
		if (_actor.hasSprite("pov_bust"))
		{
			local mutant_bust_sprite = _actor.getSprite("pov_bust");
			mutant_bust_sprite.setBrush("pov_mutant_bust");
			mutant_bust_sprite.Saturation = 0.8;
			mutant_bust_sprite.varySaturation(0.1);
			mutant_bust_sprite.varyColor(0.15, 0.15, 0.15); 
			mutant_bust_sprite.Visible = true;
		}
	}
}

::TLW.EnemyMutations <-
{
	// ALL MUTATIONS REFERENCE
	/*
	::TLW.EnemyMutations.add_mutation_enemy_unhold(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_vampire(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_spider(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_orc(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_lindwurm(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_sandgolem(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_ghost(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_serpent(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_ghoul(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_basilisk(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_direwolf(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_goblin(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_schrat(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_skeleton(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_alp(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_hexe(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_rot(this.actor, false);
	*/

	// Enemy Mutation General Function
	// Arguments: Entity type in files (serpent,ghoul etc.), title in battle, additional tag
	// actor and hard are  handled below
	add_mutation_enemy = function(_name, _title, _tag, _actor, _hard)
	{
		//Summoned entities currently CAN have mutations (no issue with me)
		if (_actor.isResurrected()){return;} //Fallback-Fix for enemies getting mutation when rising from dead

		// Mutant name change!
		// Only works the first time an entity is mutated
		// Names depending on multiple mutations are handled on the end of mutate entity and/or add mutation all
		if (!_actor.getFlags().has("mutant"))
		{
			local prevName = _actor.m.Name;
			_actor.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]"+_title+"[/color] " + prevName;
		}
		// Flag for one having a specific mutation (Part of the old system, not used now)
		if (!_actor.getFlags().has("pov_mutant_"+_name+""))
			_actor.getFlags().add("pov_mutant_"+_name+"")
		// Mutant flag, battle mechanics interactions
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		// Additional Flag, used in cases like "undead", can also be empty
		// If you want to add more than one flag, then do it in funcs below
		if (_tag)
		{
			if (!_actor.getFlags().has(_tag))
			_actor.getFlags().add(_tag)
		}
		// Mutation addition
		if (_hard) 
		{
			// Placeholder, may be used may not be used, we shall see
		}else
		{
			// Enemy mutation added with fallback
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_"+_name+""))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_"+_name+""))
		}

		// If first ever mutant - Take note of it
		if (!::World.Flags.has("FirstMutantSpawned"))
		{
			::World.Flags.add("FirstMutantSpawned");
		}

		// Add the Mutation effect Sprite
		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_serpent = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("serpent", "Agile", null, _actor, _hard);
	}

	add_mutation_enemy_unhold = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("unhold", "Hulking", null, _actor, _hard);
	}

	add_mutation_enemy_vampire = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("vampire", "Vampiric", "undead", _actor, _hard);
	}

	add_mutation_enemy_spider = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("spider", "Poisonous", null, _actor, _hard);
	}

	add_mutation_enemy_orc = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("orc", "Savage", null, _actor, _hard);
	}

	add_mutation_enemy_lindwurm = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("lindwurm", "Wurmblood", null, _actor, _hard);
	}

	add_mutation_enemy_sandgolem = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("sandgolem", "Rockskin", null, _actor, _hard);
	}

	add_mutation_enemy_ghost = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("ghost", "Ghastly", "undead", _actor, _hard);
		// Additional Flag
		if (!_actor.getFlags().has("ghost"))
		_actor.getFlags().add("ghost")
	}

	add_mutation_enemy_ghoul = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("ghoul", "Ghoulish", null, _actor, _hard);
	}

	add_mutation_enemy_basilisk = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("basilisk", "Focused", null, _actor, _hard);
	}

	add_mutation_enemy_direwolf = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("direwolf", "Beastly", null, _actor, _hard);
	}

	add_mutation_enemy_goblin = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("goblin", "Cunning", null, _actor, _hard);
	}

	add_mutation_enemy_schrat = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("schrat", "Barkhide", null, _actor, _hard);
	}

	add_mutation_enemy_skeleton = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("skeleton", "Revenant", "undead", _actor, _hard);
	}

	add_mutation_enemy_alp = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("alp", "Shifting", null, _actor, _hard);
	}

	add_mutation_enemy_hexe = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("hexe", "Cursebearer", null, _actor, _hard);
	}

	add_mutation_enemy_rot = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("rot", "Foul", null, _actor, _hard);
	}
	// ENEMY SPECIFIC MUTATIONS (wtf was this for xd)
}

// Function that Handles Enemy Mutation System
::TLW.EnemyMut <- {
  All = [],
  MutationFactory = [],

  // Add new mutation function
  add = function(_factory) 
  {
    local index = ::TLW.EnemyMut.All.len()+1;
    ::TLW.EnemyMut.All.push(index);
    while(index >= ::TLW.EnemyMut.MutationFactory.len())
    {
      ::TLW.EnemyMut.MutationFactory.push(function(_actor, _hard){});
    }
    ::TLW.EnemyMut.MutationFactory[index] = _factory;
    return index;
  },
  // Helper Function, call the All array and exclude defined stuff
  AllExcept = function (...)
  {
    //return ::TLW.EnemyMut.All.filter(function (_idx, _x) { return !(_x in vargv) });
    return ::TLW.EnemyMut.All.filter(@(_idx, _x) vargv.find(_x) == null);
	},
  // Helper Function, call the All array and include only defined stuff
  Only = function (...)
  {
    return ::TLW.EnemyMut.All.filter(@(_idx, _x) vargv.find(_x) != null);
  }
}

// Enemy Mutations Definition n Integration
// Added to Above Object via Its Function, take EnemyMutations function as arg
::TLW.EnemyMut.Unhold <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_unhold); //1
::TLW.EnemyMut.Vampire <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_vampire); //2
::TLW.EnemyMut.Spider <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_spider); //3
::TLW.EnemyMut.Orc <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_orc); //4
::TLW.EnemyMut.Lindwurm <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_lindwurm); //5
::TLW.EnemyMut.Sandgolem <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_sandgolem); //6
::TLW.EnemyMut.Ghost <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_ghost); //7
::TLW.EnemyMut.Serpent <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_serpent); //8
::TLW.EnemyMut.Ghoul <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_ghoul); //9
::TLW.EnemyMut.Basilisk <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_basilisk); //10
::TLW.EnemyMut.Direwolf <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_direwolf); //11
::TLW.EnemyMut.Goblin <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_goblin); //12
::TLW.EnemyMut.Schrat <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_schrat); //13
::TLW.EnemyMut.Skeleton <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_skeleton); //14
::TLW.EnemyMut.Alp <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_alp); //15
::TLW.EnemyMut.Hexe <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_hexe); //16
::TLW.EnemyMut.Rot <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_rot); //17

// Enemy Mutation Arrays Are Created From The Above Values
// in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)

// You can also use the above as they are, to test enemy mutations, example below:
// ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Test100,[::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Sandgolem],false);

