::TLW.HooksMod.hook("scripts/scenarios/world/anatomists_scenario", function (q) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description += "[p][color=#bcad8c]Corpse Hunting:[/color] Enemy corpse and mutagen drops have their base drop chance increased by 10%[/p]\n";
	}

});

