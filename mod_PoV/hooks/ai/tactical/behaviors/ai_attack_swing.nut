::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_swing", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_ghost_swing",
		"actives.pov_ghost_punch_swing"
	]);
});