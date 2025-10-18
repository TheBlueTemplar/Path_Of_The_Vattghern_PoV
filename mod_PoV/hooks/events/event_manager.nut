::TLW.HooksMod.hook("scripts/events/event_manager", function(q)
{
	q.create = @(__original) function ()
	{
		__original();
		/*local scriptFiles = this.IO.enumerateFiles("scripts/events/events/");

		foreach( i, scriptFile in scriptFiles )
		{
			this.m.Events.push(this.new(scriptFile));
		}*/
		this.addSpecialEvent("event.pov_all_intro");
		this.addSpecialEvent("event.pov_story_01");
		this.addSpecialEvent("event.pov_story_02");
		this.addSpecialEvent("event.pov_story_03");
		this.addSpecialEvent("event.pov_mutant_scaling");
		this.m.LastEventTime = this.Time.getVirtualTimeF();
	}
});