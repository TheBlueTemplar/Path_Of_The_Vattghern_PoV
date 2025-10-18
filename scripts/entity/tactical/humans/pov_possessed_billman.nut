this.pov_possessed_billman <- this.inherit("scripts/entity/tactical/humans/noble_billman", {
	m = {},
	function create()
	{
		this.noble_billman.create();
		this.m.Type = this.Const.EntityType.PossessedBillman;
		this.m.Name = "Possessed Billman";
		this.m.XP += 40;
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.SoundPitch = this.Math.rand(60, 80) * 0.01;
	}

	function onInit()
	{
		this.noble_billman.onInit();
		// Adds an effect with stat changes and extra visuals
		this.m.Skills.add(this.new("scripts/skills/effects/pov_possessed_enemy_effect"));
		// Adds new perks
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

		// Color Changes
		local head = this.getSprite("head");
		head.Color = this.createColor("#" + this.Math.rand(1,6) + "c9de0"); // Light blue, slight variance
		local body = this.getSprite("body");
		body.Color = this.createColor("#" + this.Math.rand(1,6) + "c9de0"); // Light blue, slight variance
	}

	// Do geist death effect when killed
	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
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
					"bust_ghost_01"
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

		this.noble_billman.onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
