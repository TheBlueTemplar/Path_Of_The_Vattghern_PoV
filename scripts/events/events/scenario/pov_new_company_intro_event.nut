this.pov_new_company_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_new_company_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_new_company_intro.png[/img]You soak in the cool morning air. As the sun slowly rises, so does a new chapter in your life begin. After years of bloodying your sword for meager pay, you\'ve saved enough crowns to start your very own mercenary company. With you are a retired soldier, a woodsman, and a poacher: [color=" + this.Const.UI.Color.povEvent + "]%bro1%[/color], [color=" + this.Const.UI.Color.povEvent + "]%bro2%[/color] and [color=" + this.Const.UI.Color.povEvent + "]%bro3%[/color] with whom you\'ve fought before side by side in the shieldwall. You are their commander now, the leader of the [color=" + this.Const.UI.Color.povEvent + "]%companyname%[/color].\n\nThe lands are dangerous these times. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and vile mutants appearing all over the land. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. You are especially intrigued by the newly appearing mutants rumors...\n\nYour men look to you to give a command. They live and die for the [color=" + this.Const.UI.Color.povEvent + "]%companyname%[/color] now.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "HUZZAH!!!",
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
		this.m.Title = "The " + this.World.Assets.getName();
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bro1",
			brothers[0].getName()
		]);
		_vars.push([
			"bro2",
			brothers[1].getName()
		]);
		_vars.push([
			"bro3",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});

