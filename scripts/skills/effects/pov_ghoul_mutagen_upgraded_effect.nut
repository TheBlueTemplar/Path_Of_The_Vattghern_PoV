this.pov_ghoul_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_ghoul_mutagen_upgraded";
		this.m.Name = "[color="+ ::Const.UI.Color.povMutationUpgrade + "]Reinforced Mutation: Skin Ghoul[/color]";
		this.m.Icon = "skills/pov_ghoul_skin.png";
		this.m.IconMini = "";
		//this.m.Overlay = "status_effect_149";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Hyperactive Tissue Growth[/color]: This character\'s body has mutated to regrow skin and muscle tissue at an unnatural pace, vastly increasing regeneration. This, without any serious strain to the user\'s body.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Frenzied Attacks[/color]: The more entities die in a battle, this character\'s movements become increasingly eratic and blidingly fast, vastly increasing ther combat capabilities. This also renders the user almost unable to properly use ranged weapons though, while also slightly lowering their damage output.\n\n [color=" + this.Const.UI.Color.povPerkBlue + "]Horrifying Presence[/color]: Gets the ability to consume corpses for recovery, to the horror of their company. Only the bravest can stand against this character\'s terror.";
	}

	function getTooltip()
	{
		local ret = [
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain a stacking [color=" + this.Const.UI.Color.PositiveValue + "]buff[/color] which increases as more enttities die in a battle, in addition to [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill, Defense and Initiative"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain the [color=" + this.Const.UI.Color.PositiveValue + "]Gruesome Feast[/color] skill, which can be used to consume a corpse and recover HP and from injuries."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Lost health regenerates [color=" + this.Const.UI.Color.PositiveValue + "]5x[/color] faster than normal."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.PositiveValue + "]-18[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-4%[/color] melee damage."
			}
		];
		return ret;
	}

	function onAdded()
	{

		if (!this.m.Container.hasSkill("actives.pov_gruesome_feast"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pov_gruesome_feast_skill"));
		}
	}
	
	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/pov_vattghern_corpse_rush_effect"));
	}

	function onUpdate( _properties )
	{
		// Buffs
		//_properties.InitiativeMult *= 1.2;
		_properties.Threat += 18;
		_properties.HitpointsRecoveryRateMult *= 5.0;
		_properties.MeleeSkill += 5.0;
		_properties.MeleeDefense += 5.0;
		_properties.Initiative += 5.0;
		// Debuffs
		_properties.RangedSkillMult *= 0.20;
		_properties.MeleeDamageMult *= 0.96;
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function inBattleHiddenCheck()
	{
		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return false;
		}

		return true;
	}

});

