this.pov_near_ghost_hater_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_near_ghost_hater";
		this.m.Name = "Inspired by Geisthasser";
		this.m.Icon = "ui/traits/pov_hate_ghosts.png";
		this.m.IconMini = "pov_mini_hate_ghosts";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is inspired by a nearby individual, gaining [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] Resolve.";
	}

	function onAdded() 
	{
		this.spawnIcon("pov_medium_hate_ghosts", this.getContainer().getActor().getTile());
	}

	function checkBuff()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return 0;
		}

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local myFaction = actor.getFaction();

		if (myTile == null)
		{
			return 0;
		}

		if (!("Entities" in this.Tactical))
		{
			return 0;
		}

		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local actors = this.Tactical.Entities.getAllInstancesAsArray();
		local count = 0;
		foreach( a in actors )
		{
			if (a == null)
			{
				continue;
			}

			if(!a.isPlacedOnMap())
			{
				continue;
			}

			if (a.getFaction() != myFaction)
			{
				continue;
			}

			if (a.getTile() == null)
			{
				continue;
			}

			if (a.getTile().getDistanceTo(myTile) <= 2 && a.getSkills().hasSkill("trait.pov_hate_ghosts"))
			{
				count += 1;
			}

			if (count == 0)
			{
				this.removeSelf();
			}
		}

	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 5;
		checkBuff();
	}


});

