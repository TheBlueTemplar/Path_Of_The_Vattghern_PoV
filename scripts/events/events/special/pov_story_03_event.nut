this.pov_story_03_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_story_03";
		this.m.Title = "While in camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_vattghern_potion.png[/img]{ The trial of the grasses is over. It was a horrifying process, and a difficult one, but you can already feel that it was worth it, despite the devastating sickness that was caused - that will go, and the power will stay. That power of the vattghern grants not only great immediate effects, but it finally allows you to make good use of the mutagens you collected. \n\n But this is not the end. You can feel the potential, there is more to collect, more to discover, the Vat\'ghern\'s power itself yearning for more. For this unnerving power exists to help one face the many horrors of the world. You move on, thinking of what to do next... \n\n [color=" + this.Const.UI.Color.povEvent + "] When your Vatt\'ghern reaches level 11, you will unlock a new ambition to craft a powerful 2 Handed vattghern sword.[/color]}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'ve got things to find",
					function getResult( _event )
					{
						::World.Flags.add("GotVattghern");
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
		if (::World.Flags.has("GotMutagen") && ::World.Flags.has("GotVattghernEvent") && !::World.Flags.has("GotVattghern"))
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

