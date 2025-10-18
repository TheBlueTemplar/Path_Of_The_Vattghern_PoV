this.pov_solo_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_solo_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_solo_intro.png[/img] You have finally arrived in this strange, untamed land. You are still not sure about who exactly is the mysterious benefactor who invited you to visit it, but you\'ve ensured that your past is far behind you. It does not take long for you to understand that this is no simple contract, but a land in chaos. \n\n Savages in the north, the undead clawing their way back to life, noble houses locked in endless feuds, religious conflict brewing, whispers of orcish hordes uniting, unspeakable horrors stalking the wilds, and now a new threat, mutants, making their appearance. \n\n You know very well that this is no coincidence, and you can feel something horrible being brewed for the future. \n\n You set forth on [color=" + this.Const.UI.Color.povEvent + "]the Path of the Vatt\'ghern[/color], alone, and maybe with a chosen few in the future. Distrusted by the common folk, yet undeterred, you now want to discover what this land has to offer. Your knowledge of alchemy, war and trust in your own expertise will be your greatest weapons in the days to come.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "New Challenges Await!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Lone Path of the Vatt\'ghern";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bs1",
			brothers[0].getNameOnly()
		]);
	}

	function onClear()
	{
	}

});

