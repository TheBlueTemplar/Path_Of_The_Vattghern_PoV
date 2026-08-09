::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_distract", function (q) {
	q.m.PossibleSkills.extend([
		"actives.pov_throw_dirt",
		"actives.legend_magic_daze",
		"actives.pov_axii"
	]);

	q.getBestTarget = @(__original) function (_entity, _skill, _targets) {
		local usable = [];

		foreach (target in _targets) {
			if (_skill.isUsableOn(target.getTile(), _entity.getTile())) {
				usable.push(target);
			}
		}

		return __original(_entity, _skill, usable);
	}
});
