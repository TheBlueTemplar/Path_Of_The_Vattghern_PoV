::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_split", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_ghost_split"
	]);
});