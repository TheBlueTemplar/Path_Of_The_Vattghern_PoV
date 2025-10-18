this.pov_sword_ghost <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		DistortTargetA = null,
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
		DistortAnimationStartTimeD = 0
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.SwordGhost;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.SwordGhost.XP;
		this.m.IsEmittingMovementSounds = false;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/pov_ghost_death_01.wav",
			"sounds/enemies/pov_ghost_death_02.wav",
			"sounds/enemies/pov_ghost_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/pov_ghost_idle_01.wav",
			"sounds/enemies/pov_ghost_idle_02.wav",
			"sounds/enemies/pov_ghost_idle_03.wav"
		];
		this.m.SoundPitch = this.Math.rand(90, 110) * 0.01;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 2.00;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 2.00;
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/pov_sword_ghost_agent");
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
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"pov_bust_sword_ghost_01"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		}

		// Necessary shit for droppable loot to work
		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		// no corpse if corpse then remove comment
		//local corpse = this.generateCorpse(_tile, _fatalityType);
		this.dropLoot(_tile, tileLoot, !flip);

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		// INIT BASICS
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SwordGhost);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToFire = true;
		//b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		{
			b.DamageTotalMult *= 1.21;
			b.RangedDefense += 14;
			b.MeleeDefense += 14;
			b.MeleeSkill += 21;
			b.Hitpoints += 100;
		}else if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 140)
		{
			b.DamageTotalMult *= 1.14;
			b.RangedDefense += 8;
			b.MeleeDefense += 8;
			b.MeleeSkill += 14;
			b.Hitpoints += 50;
		}else if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 70)
		{
			b.DamageTotalMult *= 1.07;
			b.RangedDefense += 4;
			b.MeleeDefense += 4;
			b.MeleeSkill += 7;
			b.Hitpoints += 25;
		}
		// On legendary, bonus skills and perks added below

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.m.Items.getAppearance().Body = "pov_bust_sword_ghost_01";
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush("pov_bust_sword_ghost_01");
		body.Saturation = 0.7;
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush("pov_bust_sword_ghost_01");
		head.Saturation = 0.7;
		head.varyColor(0.2, 0.2, 0.2);
		//head.Visible = false;
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("pov_bust_sword_ghost_01");
		blur_1.Saturation = 0.7;
		blur_1.varyColor(0.2, 0.2, 0.2);
		blur_1.Visible = true;
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("pov_bust_sword_ghost_01");
		blur_2.Saturation = 0.7;
		blur_2.varyColor(0.2, 0.2, 0.2);
		blur_2.Visible = true;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.75;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		// Racial
		this.m.Skills.add(this.new("scripts/skills/racial/pov_sword_ghost_racial"));
		// Traits/Perks/Effects
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// Actives
		//this.m.Skills.add(this.new("scripts/skills/actives/ghastly_touch"));
		//this.m.Skills.add(this.new("scripts/skills/actives/horrific_scream"));
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_slash_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_split_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/pov_ghost_swing_skill"));

		// Extra Legendary Buffs n Perks
		if(this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			// Stats
			b.DamageTotalMult *= 1.10;
			b.RangedDefense += 7;
			b.MeleeDefense += 5;
			b.MeleeSkill += 10;
			b.Hitpoints += 50;
			b.Bravery += 25;
			// Perks
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		}

		// Easier on...easy
		if(this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
		{
			// Stats
			b.DamageTotalMult *= 0.90;
			b.RangedDefense -= 5;
			b.MeleeDefense -= 5;
			b.MeleeSkill -= 6;
			b.Hitpoints -= 25;
			b.Bravery -= 20;
		}

		// CORPSE - MUTATION STUFF
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.SwordGhost));
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

	    // HEAD
	    if (this.m.DistortTargetA == null)
	    {
	        this.m.DistortTargetA = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
	    }

	    if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 2.77, this.m.DistortAnimationStartTimeA))
	    {
	        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
	        this.m.DistortTargetPrevA = this.m.DistortTargetA;
	        this.m.DistortTargetA = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	    }

	    // BLUR 1
	    if (this.m.DistortTargetB == null)
	    {
	        this.m.DistortTargetB = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
	    }

	    if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 3.57, this.m.DistortAnimationStartTimeB))
	    {
	        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
	        this.m.DistortTargetPrevB = this.m.DistortTargetB;
	        this.m.DistortTargetB = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	    }

	    // BODY
	    if (this.m.DistortTargetC == null)
	    {
	        this.m.DistortTargetC = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
	    }

	    if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 3.14, this.m.DistortAnimationStartTimeC))
	    {
	        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
	        this.m.DistortTargetPrevC = this.m.DistortTargetC;
	        this.m.DistortTargetC = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	    }

	    // BLUR 2
	    if (this.m.DistortTargetD == null)
	    {
	        this.m.DistortTargetD = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	        this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
	    }

	    if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 4.09, this.m.DistortAnimationStartTimeD))
	    {
	        this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
	        this.m.DistortTargetPrevD = this.m.DistortTargetD;
	        this.m.DistortTargetD = this.createVec(this.Math.rand(0, 12) - 6, this.Math.rand(0, 12) - 6);
	    }
	}

});

