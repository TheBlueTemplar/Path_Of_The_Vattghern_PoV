this.pov_hate_ghosts_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_hate_ghosts";
		this.m.Name = "Geisthasser";
		this.m.Icon = "ui/traits/pov_hate_ghosts.png";
		this.m.Description = "\"Nothing to be afraid of when facing these screaming, evasive shits. Wish they could scream for mercy too, hah!\"";
		this.m.Excluded = [
			"trait.weasel",
			"trait.craven",
			"trait.dastard",
			"trait.fainthearted",
			"trait.legend_peaceful"
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Resolve when in a battle against spirits"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Also grants [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Resolve to allies in a 2 Cell Radius, when in a battle against spirits"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill when in a battle against spirits"
			}
		];
	}

	function giveBuff()
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
		local bonus = 0;
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

			if (a.getTile().getDistanceTo(myTile) >= 3)
			{
				continue;
			}

			if (a.getFlags().has("ghost") || a.getSkills().hasSkill(this.m.ID) || a.getSkills().hasSkill("effects.pov_near_ghost_hater"))
			{
				continue;
			}

			a.getSkills().add(this.new("scripts/skills/effects/pov_near_ghost_hater_effect"));
		}

	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingGhosts = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (enemy.getFlags().has("ghost") && !enemy.getFlags().has("mutant"))
			{
				fightingGhosts = true;
				break;
			}
		}

		if (fightingGhosts)
		{
			_properties.Bravery += 20;
			_properties.MeleeSkill += 5;
			giveBuff();
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});
