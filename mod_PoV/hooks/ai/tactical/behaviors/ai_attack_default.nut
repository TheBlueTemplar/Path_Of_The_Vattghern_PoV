::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_default", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_ghastly_touch",
		"actives.pov_ghost_slash",
		"actives.pov_headbutt",
		"actives.pov_ghost_headbutt",
		"actives.pov_ghost_punch",
		"actives.pov_ghost_kick"
	]);
});