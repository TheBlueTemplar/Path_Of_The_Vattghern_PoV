this.pov_story_02_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_story_02";
		this.m.Title = "While in camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_got_mutagen.png[/img]{ You are proud to finally have a mutagen! Earlier, while not knowing what to do with it yet, you decided to store it not in the company\'s stash, but along with your personal belongings to safeguard it. \n\n You are not sure how exactly, but checking your bedside table you find a scambled note next to the mutagen - with instrunctions. You feel unease, you have no idea how anyone could access this space, but the note seems strangely familiar, did you write it? Is there some discreet benefactor trying to help? You decide to read it: %SPEECH_ON% To tap into the potential of the mutagens, you need to make the mythical \"Trial of the Grasses\". To craft it you need: an adrenaline gland, sulfurous rocks, a third eye, a poison gland, a nahrezer\'s brain and an unhold\'s heart, along with distilled alcohol as a catalyst.  %SPEECH_OFF% The list keeps going, getting into the intricate details on how to prepare the potion and the one to ingest it. You do not understand why anyone would help you with this, but it is help all too appreciated. You know know what you need to do next. \n\n [color=" + this.Const.UI.Color.povEvent + "] You have unlocked the recipe for \"The Trial of the Grasses\", along with a new ambition to get a \"Vattghern\". You also unlock some useful events.[/color]}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'ve got things to find",
					function getResult( _event )
					{
						::World.Flags.add("GotMutagen");
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
		if (::World.Flags.has("FirstMutantKilled") && ::World.Flags.has("GotMutagenEvent") && !::World.Flags.has("GotMutagen"))
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

