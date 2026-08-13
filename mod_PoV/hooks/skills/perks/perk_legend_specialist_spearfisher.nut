::TLW.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_spearfisher", function (q) {

	q.m.BonusRanged = 10;
	q.m.BonusDamage = 10;

	q.create = @(__original) function () {
		__original();

		this.m.IconMini = "pov_perk_spec_javelin_mini";
		this.m.Icon = "ui/perks/pov_perk_spec_javelin.png";
		this.m.IconDisabled = "ui/perks/pov_perk_spec_javelin_bw.png";
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		//__original(_skill, _targetEntity, _properties);
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill)) {
			_properties.DamageRegularMin += this.calculateSpecialistBonus(6, _skill.getItem());
		}
	}

});
