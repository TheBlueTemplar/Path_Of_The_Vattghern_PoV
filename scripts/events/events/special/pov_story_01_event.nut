this.pov_story_01_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_story_01";
		this.m.Title = "After the battle...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_killed_mutant.png[/img]{ As you are watching over the enemy\'s fallen, you are in awe, while looking at one specific corpse. Its blood and face having an unnatural green hue is the least of your concerns, as this same enemy was quite stronger in battle, overcoming its expected potential. \n\n Between this awe and horror, a sinister thought crosses your mind: What if you could tap into this power...but where to start? While you were thinking about this, a thought crosses your mind, a thought which you could swear was hardly your own. The source of power of these \"mutants\" as you have heard, and various ways to collect it. Finally, you think that you might also need some specialist assistance in this task. \n\n You waste no time pondering on this more, and move out. If you want more of this power, what you need to do is clear now. \n\n [color=" + this.Const.UI.Color.povEvent + "] Unlocked enemy corpse drops, which you can dissect in the crafting menu with the help of specialists in alchemy or surgery. You have also unlocked the ability to obtain mutagens, by dissecting corpses, or from mutants directly. Knowing what you are looking for now, you can also find them on sale in alchemists, and the dark corners of towns. You also unlock a few events that might help.[/color]}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s move on.",
					function getResult( _event )
					{
						::World.Flags.add("FirstMutantKilled");
						return 0;
					}

				}
			],
			function start( _event )
			{
				// What are you looking for...? HUH?
			}

		});
	}

	function isValid() {
		if (::World.Flags.has("FirstMutantKilledEvent") && !::World.Flags.has("FirstMutantKilled"))
		{
			return true;
		} 
		else 
		{
			return false;
		}	
	}

	function canFire() {
		return this.isValid();
	}

});

