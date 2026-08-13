::TLW.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_miner", function (q) {

	q.m.BonusMelee = 10;
	q.m.BonusDamage = 10;

	q.create = @(__original) function () {
		__original();

		this.m.IconMini = "pov_perk_spec_pickaxe_mini";
		this.m.Icon = "ui/perks/pov_perk_spec_pickaxe.png";
		this.m.IconDisabled = "ui/perks/pov_perk_spec_pickaxe_bw.png";
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		//__original(_skill, _targetEntity, _properties);
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill)) {
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, this.calculateSpecialistBonus(10, _skill.getItem()));
		}
	}

});
