// Undead Crisis Armies
this.Const.World.Spawn.UndeadScourge.Troops.extend([
     {
        Weight = 8,
        Types = [ // defaults: 15, 16, 18, 25, 60, 28, 20(max1)
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
        Weight = 6,
        Types = [
            {
                Type = this.Const.World.Spawn.Troops.SwordGhost,
                MinR = 180,
                Cost = 35
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

