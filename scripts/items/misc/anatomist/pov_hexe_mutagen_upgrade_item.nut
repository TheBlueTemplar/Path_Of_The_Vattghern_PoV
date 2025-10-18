this.pov_hexe_mutagen_upgrade_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_hexe_mutagen_upgrade";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]Hexe Leader Mutagen[/color]";
		this.m.Description = "This mutagen is of a very rare and special kind, only able to be of use to those already attuned to the hexe's mutations. Instead of granting new boons to the Vatt\'ghern, it instead improves their already existing hexe mutation, thanks to the far more potent genes and characteristics of this mutagen. \n\n Expect this process to improve every aspect of the previous mutation, as well as limiting its drawbacks, without limiting the mutagenic potential of the Vatt\'ghern. Make good use of this!";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_hexe_upgrade.png";
		this.m.Value = 2500;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}


		result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing severe sickness"
		});

		result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Must have Witcher Mutation AND the Hexe Mutation to use this mutagen."
		});

		result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Upgrades the Hexe Mutation. Does not count to mutation limit"
		});

		return result;
	}

	function onUse( _actor, _item = null )
	{
		return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.HexeUpgrade);
	}

});

