// For Adding new entites, also check global.nut and relevant faction.nut

// GHOST FACTION
::Const.World.Spawn.Troops.SwordGhost <- {
	ID = this.Const.EntityType.SwordGhost,
	Variant = 0,
	Strength = 40,
	Cost = 35,
	Row = 2,
	Script = "scripts/entity/tactical/enemies/pov_sword_ghost"
};

// 0,55,45
::Const.World.Spawn.Troops.ArmorGhost <- {
	ID = this.Const.EntityType.ArmorGhost,
	Variant = 0,
	Strength = 55,
	Cost = 45,
	Row = 2,
	Script = "scripts/entity/tactical/enemies/pov_armor_ghost"
};

// 0,20,15
::Const.World.Spawn.Troops.PossessedBanditRaider <- {
	ID = this.Const.EntityType.PossessedBanditRaider,
	Variant = 0,
	Strength = 20,
	Cost = 15,
	Row = 1,
	Script = "scripts/entity/tactical/enemies/pov_possessed_bandit_raider"
};

// 0,23,16
::Const.World.Spawn.Troops.PossessedFootman <- {
	ID = this.Const.EntityType.PossessedFootman,
	Variant = 0,
	Strength = 23,
	Cost = 16,
	Row = 1,
	Script = "scripts/entity/tactical/humans/pov_possessed_footman"
};

// 0,25,18
::Const.World.Spawn.Troops.PossessedBillman <- {
	ID = this.Const.EntityType.PossessedBillman,
	Variant = 0,
	Strength = 25,
	Cost = 18,
	Row = 2,
	Script = "scripts/entity/tactical/humans/pov_possessed_billman"
};

// 0,30,25
::Const.World.Spawn.Troops.PossessedArbalester <- {
	ID = this.Const.EntityType.PossessedArbalester,
	Variant = 0,
	Strength = 30,
	Cost = 25,
	Row = 3,
	Script = "scripts/entity/tactical/humans/pov_possessed_arbalester"
};

// 0,70,55
::Const.World.Spawn.Troops.PossessedGreatsword <- {
	ID = this.Const.EntityType.PossessedGreatsword,
	Variant = 0,
	Strength = 70,
	Cost = 55,
	Row = 1,
	Script = "scripts/entity/tactical/humans/pov_possessed_greatsword"
};

// 0,70,55
::Const.World.Spawn.Troops.PossessedMercenary <- {
	ID = this.Const.EntityType.PossessedMercenary,
	Variant = 0,
	Strength = 40,
	Cost = 28,
	Row = 1,
	Script = "scripts/entity/tactical/humans/pov_possessed_mercenary"
};

// 0,70,55
::Const.World.Spawn.Troops.PossessedWitchhunter <- {
	ID = this.Const.EntityType.PossessedWitchhunter,
	Variant = 0,
	Strength = 40,
	Cost = 28,
	Row = 3,
	Script = "scripts/entity/tactical/humans/pov_possessed_witchhunter"
};

/*
::Const.World.Spawn.Troops.LesserFleshGolem <- {
	ID = this.Const.EntityType.LesserFleshGolem,
	Variant = 1,
	Strength = 15,
	Cost = 20,
	Row = 1,
	Script = "scripts/entity/tactical/enemies/lesser_flesh_golem"
};

::Const.World.Spawn.Troops.GreaterFleshGolem <- {
	ID = this.Const.EntityType.GreaterFleshGolem,
	Variant = 1,
	Strength = 40,
	Cost = 50,
	Row = 1,
	Script = "scripts/entity/tactical/enemies/greater_flesh_golem"
};

::Const.World.Spawn.Troops.FaultFinder <- {
	ID = this.Const.EntityType.FaultFinder,
	Variant = 1,
	Strength = 40,
	Cost = 40,
	Row = 2,
	Script = "scripts/entity/tactical/enemies/fault_finder"
};
*/
