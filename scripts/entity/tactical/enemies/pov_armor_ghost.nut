this.pov_armor_ghost <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		/*DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		DistortTargetD = null,
		DistortTargetPrevD = this.createVec(0, 0),
		DistortAnimationStartTimeD = 0*/
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.ArmorGhost;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.ArmorGhost.XP;
		this.m.IsEmittingMovementSounds = true;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/combat/armor_halfplate_impact_01.wav",
			"sounds/combat/armor_halfplate_impact_02.wav",
			"sounds/combat/armor_halfplate_impact_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/pov_ghost_death_01.wav",
			"sounds/enemies/pov_ghost_death_02.wav",
			"sounds/enemies/pov_ghost_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/pov_armor_ghost_idle_01.wav",
			"sounds/enemies/pov_armor_ghost_idle_02.wav",
			"sounds/enemies/pov_armor_ghost_idle_03.wav"
		];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 2.50;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 2.00;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] = 2.00;
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/pov_armor_ghost_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(1, 100) < 50; // Necessary shit for droppable loot to work

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("OvercomingFear", 1, 1);
		}

		if (_tile != null)
		{
			_tile.spawnDetail("pov_bust_armor_ghost_dead", this.Const.Tactical.DetailFlag.Corpse, false);
		}

		// Necessary shit for droppable loot to work
		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		// no corpse if corpse then remove comment
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);
		this.dropLoot(_tile, tileLoot, !flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "A " + this.getName();
		corpse.Value = 1.0;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsResurrectable = false;
		corpse.IsHeadAttached = true;

		if (_tile != null)
		{
			corpse.Tile = _tile;
		}

		return corpse;
	}

	function onInit()
	{
		// INIT BASICS
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ArmorGhost);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToKnockBackAndGrab = false;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToFire = true;
		//b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		{
			b.DamageTotalMult *= 1.15;
			b.RangedDefense += 12;
			b.MeleeDefense += 12;
			b.MeleeSkill += 17;
			b.Bravery += 30;
			b.Armor[this.Const.BodyPart.Head] += 225;
			b.ArmorMax[this.Const.BodyPart.Head] += 225;
			b.Armor[this.Const.BodyPart.Body] += 225;
			b.ArmorMax[this.Const.BodyPart.Body] += 225;
		}else if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 140)
		{
			b.DamageTotalMult *= 1.10;
			b.RangedDefense += 7;
			b.MeleeDefense += 7;
			b.MeleeSkill += 12;
			b.Bravery += 20;
			b.Armor[this.Const.BodyPart.Head] += 125;
			b.ArmorMax[this.Const.BodyPart.Head] += 125;
			b.Armor[this.Const.BodyPart.Body] += 125;
			b.ArmorMax[this.Const.BodyPart.Body] += 125;
		}else if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 70)
		{
			b.DamageTotalMult *= 1.05;
			b.RangedDefense += 4;
			b.MeleeDefense += 4;
			b.MeleeSkill += 6;
			b.Bravery += 10;
			b.Armor[this.Const.BodyPart.Head] += 50;
			b.ArmorMax[this.Const.BodyPart.Head] += 50;
			b.Armor[this.Const.BodyPart.Body] += 50;
			b.ArmorMax[this.Const.BodyPart.Body] += 50;
		}
		// On legendary, bonus skills and perks added below

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		//this.m.Items.getAppearance().Body = "pov_bust_armor_ghost";
		this.addSprite("socket").setBrush("bust_base_undead");
		//this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush("pov_bust_armor_ghost_0" + this.Math.rand(0,2));
		//body.varySaturation(0.1);
		//body.varyColor(0.1, 0.1, 0.1);

		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 1.25;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		// Racial
		this.m.Skills.add(this.new("scripts/skills/racial/pov_armor_ghost_racial"));
		// Traits/Perks/Effects
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// Actives
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_punch_skill")); 		// punch (normal atk - stagger)
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_punch_swing_skill")); 	// wide punch (3tile atk - stagger)
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_headbutt_skill")); 	// headbutt (piercing - can baffle)
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_kick_skill"));		 	// kick (knockback - daze)

		// In all non-easy diffs
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			// Traits/Perks/Effects
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_push_the_advantage"));
		}

		// Extra Legendary Buffs n Perks
		if(this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			// Stats
			b.DamageTotalMult *= 1.10;
			b.RangedDefense += 4;
			b.MeleeDefense += 4;
			b.MeleeSkill += 8;
			//b.Hitpoints += 50;
			b.Bravery += 15;
			b.Armor[this.Const.BodyPart.Head] += 75;
			b.ArmorMax[this.Const.BodyPart.Head] += 75;
			b.Armor[this.Const.BodyPart.Body] += 75;
			b.ArmorMax[this.Const.BodyPart.Body] += 75;
			// Perks
			//this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
			// ? Custom effect, chance for knockback n daze on all skills ?
		}

		// Easier on...easy
		if(this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
		{
			// Stats
			b.DamageTotalMult *= 0.90;
			b.RangedDefense -= 4;
			b.MeleeDefense -= 4;
			b.MeleeSkill -= 6;
			//b.Hitpoints += 50;
			b.Bravery -= 20;
			b.Armor[this.Const.BodyPart.Head] -= 50;
			b.ArmorMax[this.Const.BodyPart.Head] -= 50;
			b.Armor[this.Const.BodyPart.Body] -= 50;
			b.ArmorMax[this.Const.BodyPart.Body] -= 50;
		}

		// CORPSE - MUTATION STUFF
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.ArmorGhost));
			//this.m.OnDeathLootTable.extend(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.SwordGhost));
	  	}

		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		//this.m.Skills.add(this.new("scripts/skills/effects/pov_serpentine_agility_effect"));
		
		// Chaos Mutation
		::TLW.Chaos.add_mutation_all(this.actor, false)

		// No Normal Mutation For Ghosts Currently
	}

	function onRender()
	{
	    this.actor.onRender();

	}

});

