::TLW.HooksMod.hook("scripts/skills/actives/drink_antidote_skill", function ( q ) {

	q.onUse = @(__original) function(_user, _targetTile)
	{
		local user = _targetTile.getEntity();
		this.spawnIcon("status_effect_97", _targetTile);

		if (_user.getID() == user.getID())
		{
			while (user.getSkills().hasSkill("effects.pov_mutant_poison"))
			{
				user.getSkills().removeByID("effects.pov_mutant_poison");
			}

			while (user.getSkills().hasSkill("effects.pov_stench"))
			{
				user.getSkills().removeByID("effects.pov_stench");
			}

			/*user.getSkills().add(this.new("scripts/skills/effects/antidote_effect"));

			if (!user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " drinks Antidote");
			}

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			this.Const.Tactical.Common.checkDrugEffect(user);*/
		}
		__original(_user, _targetTile);
	}
});	

//dont know how this will work with legends' hook, but should be okay, maybe
//bless u pot, used this shet for sth else