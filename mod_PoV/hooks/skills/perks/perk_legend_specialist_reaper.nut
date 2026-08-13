::TLW.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_reaper", function (q) {

	q.m.SpecialistWeaponIds.extend([
		"weapon.legend_military_warscythe",
		"weapon.legend_broad_warscythe",
		"weapon.legend_honed_warscythe",
		"weapon.legend_named_military_warscythe",
	]);
	q.m.BonusMelee = 15;
	q.m.BonusDamage = 15;

	q.create = @(__original) function () {
		__original();

		this.m.IconMini = "pov_perk_spec_scythe_mini";
		this.m.Icon = "ui/perks/pov_perk_spec_scythe.png";
		this.m.IconDisabled = "ui/perks/pov_perk_spec_scythe_bw.png";
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		//__original(_skill, _targetEntity, _properties);
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill)) {
			_properties.DamageArmorMult += 0.01 * this.calculateSpecialistBonus(20, _skill.getItem());
			_properties.DamageDirectMult += 0.01 * this.calculateSpecialistBonus(10, _skill.getItem());
		}
	}

	q.onUpdate = @(__original) function (_properties) {
		__original(_properties);
		_properties.Threat += 4;
	}

});
