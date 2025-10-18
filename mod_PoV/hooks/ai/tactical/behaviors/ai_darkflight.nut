::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_darkflight", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_darkflight"
	]);
});