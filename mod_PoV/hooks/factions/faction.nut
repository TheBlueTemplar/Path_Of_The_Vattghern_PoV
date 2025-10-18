::TLW.HooksMod.hookTree("scripts/factions/faction", function (q)
{
	q.create = @(__original) function()
	{
		this.m.ContractsByCategory.Vattghern <- [];
		__original();
	}
});
