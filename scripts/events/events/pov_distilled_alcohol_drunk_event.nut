this.pov_distilled_alcohol_drunk_event <- this.inherit("scripts/events/event", {
	m = {
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.pov_distilled_alcohol_drunk";
		this.m.Title = "During camp...";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/belly_full_of_mead.png[/img]{Wandering around camp during a routine inspection, you notice %other% lying down next to a supply cart, apparently unconscious. You decide to approach %them_other%, but you did not need to get close to smell the alcohol...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What is it this time...",
					function getResult( _event )
					{
						if (_event.m.OtherGuy.getSkills().hasSkill("trait.drunkard"))
						{
							return "drunk";
						}
						else if(_event.m.OtherGuy.getSkills().hasSkill("trait.dumb"))
						{
							return "dumb";
						}
						else if(_event.m.OtherGuy.getBackground().getID() == "background.wildman")
						{
							return "wild";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "drunk",
			Text = "[img]gfx/ui/events/belly_full_of_mead.png[/img]{%other% stirs as you loom over %them_other%, a sluggish groan escaping from cracked lips. The flask lies beside the cart, still heavy, the faint shine of liquid within betraying how little was actually consumed. Even so, the sharp odor is enough to wrinkle your nose. When you speak, your words come sharp and clipped, but they seem to pierce no deeper than the haze clouding %their_other% mind. %SPEECH_ON% Just a taste... just a sip... thought it\'d be like mead... but oh gods, it burns...%SPEECH_OFF% %They_other% chuckles weakly, trying to sit upright, only to flop back with the grace of a sack of grain. Your scolding bounces off as if the words were no more than wind, the drunkard\'s gaze glassy and unfocused. \n\n At least the damage is not as bad as it first seemed. The flask remains mostly untouched, the distilled spirit still viable for its true purpose in the alchemist\'s kit. For now, the only thing truly wasted is %other%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That will teach %them_other%.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.OtherGuy.worsenMood(1.0, "Pounding Aftermath");
				_event.m.OtherGuy.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));

				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
					text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
				});

				this.List.push({
					id = 10,
					icon = "skills/status_effect_61.png",
					text = _event.m.OtherGuy.getName() + " became drunk! "
				});
			}

		});
		this.m.Screens.push({
			ID = "dumb",
			Text = "[img]gfx/ui/events/belly_full_of_mead.png[/img]{%other% stirs as you loom over %them_other%, blinking slowly, confusion painted across %their_other% face. The flask lies beside the cart, still heavy, the faint shine of liquid within showing that only the smallest sip had been taken. \n\n You demand to know what possessed %them_other% to drink from a vial clearly marked for alchemical use. The answer comes slurred not with drunkenness, but with the fumbling logic of a man who has long since learned nothing sticks. %SPEECH_ON% Thought it was... uh... special mead? Looked shiny, smelled strong. Figured it\'d taste good...%SPEECH_OFF%} %They_other% scratches %their_other% head, as if baffled by your anger, then grins with the vacant satisfaction of a child who has solved nothing. No matter how harshly you scold, the words seem to tumble off without purchase, sliding past dull eyes and into the night air.\n\n At least the damage is not as bad as it first seemed. The flask remains mostly untouched, the distilled spirit still viable for its true purpose in the alchemist’s kit. For now, the only thing truly wasted is your patience.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I don\'t understand how this guy survives",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.OtherGuy.worsenMood(1.0, "Pounding Aftermath");
				_event.m.OtherGuy.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));

				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
					text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
				});

				this.List.push({
					id = 10,
					icon = "skills/status_effect_61.png",
					text = _event.m.OtherGuy.getName() + " became drunk! "
				});
			}

		});
		this.m.Screens.push({
			ID = "wild",
			Text = "[img]gfx/ui/events/belly_full_of_mead.png[/img]{%other% stirs as you loom over %them_other%, lips curled back in a half-snarl, half-grin. The flask lies by the cart, still heavy with its contents, though its stopper bears the marks of crude hands prying it loose. When you ask what possessed %them_other% to drink from a vessel clearly marked for alchemical use, the reply comes in guttural tones, raw and unapologetic. %SPEECH_ON% Fire-water. Wanted to taste the fire. Thought maybe it’d make me stronger. %SPEECH_OFF% %They_other% beats a fist weakly against their chest, then slumps sideways, the bravado cut short by the venom still burning through their gut. Your words of reproach carry no weight... the wildman\'s eyes are already glazed, the lesson lost in the fog of instinct over reason. \n\n At least the damage is not as bad as it first seemed. The flask remains mostly untouched, the distilled spirit still viable for its true purpose in the alchemist’s kit. For now, only %other%’s pride smolders, singed by curiosity.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Should have expected this...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.OtherGuy.worsenMood(1.0, "Pounding Aftermath");
				_event.m.OtherGuy.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));

				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
					text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
				});

				this.List.push({
					id = 10,
					icon = "skills/status_effect_61.png",
					text = _event.m.OtherGuy.getName() + " became drunk! "
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local other_candidates = [];
		local stash = this.World.Assets.getStash().getItems();
		local candidates_items = []; //Not actual candidate, I just check if party has >= 3

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.dumb") || bro.getSkills().hasSkill("trait.drunkard") || bro.getBackground().getID() == "background.wildman")
			other_candidates.push(bro);
		}

		foreach( item in stash )
		{
			if (item != null)
			{
				if (item.getID() == "misc.pov_distilled_alcohol")
				{
					candidates_items.push(item);					
				}
			}
		}

		if (other_candidates.len() == 0 || candidates_items.len() == 0)
		{
			return;
		}

		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		//this.m.Score = 2 + other_candidates.len() * 4 + candidates_items.len() * 4;
		this.m.Score = 9999;
	}

	function onPrepare()
	{

	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"other",
			this.m.OtherGuy.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy.getGender(), "other");
	}

	function onClear()
	{
		this.m.OtherGuy = null;
	}

});

