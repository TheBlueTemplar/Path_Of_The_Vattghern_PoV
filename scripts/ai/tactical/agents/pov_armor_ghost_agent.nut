this.pov_armor_ghost_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.ArmorGhost;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.1;
		this.m.Properties.TargetPriorityHitchanceMult = 0.4;
		this.m.Properties.TargetPriorityHitpointsMult = 0.3;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.3;
		this.m.Properties.TargetPriorityFleeingMult = 0.4;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 2.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.8;
		this.m.Properties.TargetPriorityArmorMult = 1.25;
		this.m.Properties.TargetPriorityMoraleMult = 1.25;
		this.m.Properties.TargetPriorityBraveryMult = 1.25;
		this.m.Properties.OverallDefensivenessMult = 1.25;
		this.m.Properties.OverallFormationMult = 1.25;
		//this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.30;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.1;
		this.m.Properties.EngageAgainstSpearwallMult = 1.25;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 1.25;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.1;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		//this.m.Properties.EngageRangeMin = 1;
		//this.m.Properties.EngageRangeMax = 2;
		//this.m.Properties.EngageRangeIdeal = 1;
		//this.m.Properties.EngageEnemiesInLinePreference = 2;
		//this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_terror"));
	}

	function onUpdate()
	{
	}

});

