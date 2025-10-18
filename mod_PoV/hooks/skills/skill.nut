// Not Working at all Currently
// Really complicated to implement, I say fuck it
/*::TLW.HooksMod.hook("scripts/skills/skill", function ( q ) {

	while(!("m" in q && "ID" in q.m)) q=q[q.SuperName];

    q.getHitFactors = @(__original) function(_targetTile)
    {
        //__original(_targetTile);
        local ret = __original(_targetTile);
		local user = this.m.Container.getActor();
		local myTile = user.getTile();
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;

		// Resistance to Ranged
        if (this.m.IsAttack && _targetTile.IsOccupiedByActor)
		{
			if (targetEntity.getSkills().hasSkill("effects.pov_enemy_mutation_sandgolem"))
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Increased Damage Resistance"
				});
			}	
		}
        // Resistance to Ranged
        if (this.m.IsAttack && _targetTile.IsOccupiedByActor)
		{
			if (targetEntity.getSkills().hasSkill("effects.pov_enemy_mutation_alp"))
			{
				if (this.m.IsRanged)
				{
					ret.push({
						icon = "ui/tooltips/negative.png",
						text = "Resistance against ranged weapons"
					});
				}
			}	
		}
		// Resistance to Piercing and/or Cutting
		if (this.m.IsAttack && _targetTile.IsOccupiedByActor)
		{
			if (targetEntity.getSkills().hasSkill("effects.pov_enemy_mutation_skeleton"))
			{
				if (this.m.InjuriesOnBody == this.Const.Injury.PiercingBody || this.m.InjuriesOnHead == this.Const.Injury.PiercingBody) 
				{
					ret.push({
						icon = "ui/tooltips/negative.png",
						text = "Resistance against piercing attacks"
					});
				}

				if (this.m.InjuriesOnBody == this.Const.Injury.CuttingBody || this.m.InjuriesOnHead == this.Const.Injury.CuttingBody) 
				{
					ret.push({
						icon = "ui/tooltips/negative.png",
						text = "Low Resistance against cutting attacks"
					});
				}
			}	
		}

		return ret;
    }


});*/
