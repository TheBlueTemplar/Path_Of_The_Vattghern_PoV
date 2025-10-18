::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_distract", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_throw_dirt"
	]);
});