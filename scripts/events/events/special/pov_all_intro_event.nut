this.pov_all_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_all_intro";
		this.m.Title = "Welcome to \"Path of the Vatt\'ghern\" (PoV)";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_testing_intro.png[/img]{ Did you arrive in these lands? Were you always here? Are your intentions good, neutral or evil? Doesn\'t matter. Whatever the case, you now are in a land full of strife, and familiar threats aside, there are new, unnatural enemies on the rise! Will you rise up to the challenge, and if so, will you use their powers against them? Only time will tell...%SPEECH_ON% Welcome to \"Path of the Vatt\'ghern\" (PoV). This is a witcher-themed mod, adding in quite a few new features, including items, events, skills, enemies and so on. The mod also tweaks existing game mechanics, like the injury system. %SPEECH_OFF% [color=" + this.Const.UI.Color.povEvent + "] Many of the mod\'s additions are explained via thematic events and items, but if you want to get brief explanation of the most important additions to this mod, and possibly keep track of some details, there is a Wiki included in PoV\'s mod settings page, in the wiki tab. For more detailed information, check PoV\'s discord server. \n\n If you dont want to see this event in new playthroughs, disable it in PoV\'s misc mod settings.\n\n Enjoy ☺[/color]}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s Go!",
					function getResult( _event )
					{
						::World.Flags.add("PovIntro");
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
		if (::TLW.EnablePovIntroEvent == false)
		{
			return false;
		}
		return !::World.Flags.has("PovIntro");
	}

	function canFire() {
		return this.isValid();
	}

});

