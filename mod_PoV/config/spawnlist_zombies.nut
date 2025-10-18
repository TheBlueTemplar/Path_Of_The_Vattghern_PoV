if (!("World" in ::Const))
{
    ::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
    ::Const.World.Spawn <- {};
}

// CREATE NEW, CUSTOM LISTS
::Const.World.Spawn.PovGhosts <-
{
    Name = "PovGhosts",
    IsDynamic = true,
    MovementSpeedMult = 0.9,
    VisibilityMult = 0.8,
    VisionMult = 0.9,
    Body = "figure_zombie_01",
    MaxR = 480,
    MinR = 110,
    Fixed = [
        {
            Type = this.Const.World.Spawn.Troops.SwordGhost,
            Cost = 25,
            Weight = 0,
        },
        {
            Type = this.Const.World.Spawn.Troops.ArmorGhost,
            Cost = 45,
            Weight = 0,
        },
        {
            Type = this.Const.World.Spawn.Troops.PossessedWitchhunter,
            Cost = 20,
            Weight = 0,
        }
    ],
    Troops = [ // should be 38,26,12,8,10,6 (when you add soldiers)
        {
            Weight = 38,
            Types = [ // defaults: 15, 16, 18, 25, 60, 24
                {
                    Type = this.Const.World.Spawn.Troops.PossessedBanditRaider,
                    Cost = 15
                },
                {
                    Type = this.Const.World.Spawn.Troops.PossessedFootman,
                    Cost = 16
                },
                {
                    Type = this.Const.World.Spawn.Troops.PossessedBillman,
                    Cost = 18
                },
                {
                    Type = this.Const.World.Spawn.Troops.PossessedArbalester,
                    Cost = 25
                },
                {
                    Type = this.Const.World.Spawn.Troops.PossessedGreatsword,
                    MinR = 550,
                    Cost = 60
                },
                {
                    Type = this.Const.World.Spawn.Troops.PossessedMercenary,
                    Cost = 24
                }
            ]
        },
        {
            Weight = 26,
            Types = [
                {
                    Type = this.Const.World.Spawn.Troops.Ghost,
                    Cost = 20
                }
            ]
        },
         {
            Weight = 12,
            Types = [
                {
                    Type = this.Const.World.Spawn.Troops.SwordGhost,
                    MinR = 250,
                    Cost = 30
                }
            ]
        },
         {
            Weight = 8,
            Types = [
                {
                    Type = this.Const.World.Spawn.Troops.ArmorGhost,
                    MinR = 400,
                    Cost = 50
                }
            ]
        },
        {
            Weight = 10,
            Types = [
                {
                    Type = this.Const.World.Spawn.Troops.LegendDemonHound,
                    MinR = 200,
                    Cost = 25
                }
            ]
        },
        {
            Weight = 6,
            MinR = 700,
            Types = [
                {
                    Type = this.Const.World.Spawn.Troops.LegendBanshee,
                    Cost = 65
                }
            ]
        }
    ]
};
// EDIT EXISTING LISTS

// TEST with 40 weight, 10 Cost, 50 minR
// Def Values are respectively 2, 125, 45 (change to 2?, 125, 45 -  and 275 , 55)
this.Const.World.Spawn.Zombies.Troops.extend([
    {
        Weight = 2,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 125,
                Cost = 45
            }
        ]
    },
    {
        Weight = 2,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 55
            }
        ]
    }
]);

// ZombiesAndGhosts
this.Const.World.Spawn.ZombiesAndGhosts.Troops.extend([
    {
        Weight = 7,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 150,
                Cost = 30
            }
        ]
    },
    {
        Weight = 4,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 50
            }
        ]
    }
]);

// ZombiesOrZombiesAndGhosts
this.Const.World.Spawn.ZombiesOrZombiesAndGhosts.Troops.extend([
   {
        Weight = 7,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 150,
                Cost = 30
            }
        ]
    },
    {
        Weight = 4,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 50
            }
        ]
    }
]);

// Ghosts
this.Const.World.Spawn.Ghosts.Troops.extend([
    {
        Weight = 16,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 150,
                Cost = 30
            }
        ]
    },
    {
        Weight = 10,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 50
            }
        ]
    }
]);

// Necromancer
this.Const.World.Spawn.Necromancer.Troops.extend([
    {
        Weight = 6,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 150,
                Cost = 30
            }
        ]
    },
    {
        Weight = 4,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 50
            }
        ]
    }
]);

// NecromancerSouthern
this.Const.World.Spawn.NecromancerSouthern.Troops.extend([
    {
        Weight = 6,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 150,
                Cost = 30
            }
        ]
    },
    {
        Weight = 4,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.ArmorGhost,
                MinR = 400,
                Cost = 50
            }
        ]
    }
]);