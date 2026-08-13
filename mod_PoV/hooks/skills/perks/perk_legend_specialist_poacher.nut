::TLW.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_poacher", function (q) {

	q.m.SpecialistWeaponIds.extend(["weapon.goblin_bow",]);
	q.m.BonusRanged = 10;
	q.m.BonusDamage = 10;

	q.create = @(__original) function () {
		__original();

		this.m.IconMini = "pov_perk_spec_shortbow_mini";
		this.m.Icon = "ui/perks/pov_perk_spec_shortbow.png";
		this.m.IconDisabled = "ui/perks/pov_perk_spec_shortbow_bw.png";
	}

	q.onAdded = @(__original) function () {
		__original();
		// Actual edit of value in character_background.nut hook
		// Yes, its super hacky, ik
		if (::World.State.getPlayer() != null) {
			local actor = this.getContainer().getActor();
			if (actor.getFaction() == this.Const.Faction.Player) {
				if (actor.getBackground() != null) {
					actor.getBackground().m.Modifiers.Hunting += 0.05;
					//actor.getBackground().onAdded();
				}
			}
		}
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		//__original(_skill, _targetEntity, _properties);
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill)) {
			_properties.DamageRegularMin += this.calculateSpecialistBonus(10, _skill.getItem());
		}
	}

	q.onTargetHit = @(__original) function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		// remove the arrow stuff
	}
});
