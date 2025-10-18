this.pov_alp_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_alp_mutagen_upgraded";
		this.m.Name = "[color="+ ::Const.UI.Color.povMutationUpgrade + "]Reinforced Mutation: Demon Alp[/color]";
		this.m.Icon = "skills/pov_alp_demon.png";
		this.m.IconMini = "";
		this.m.Overlay = "alp";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Unnatural Vision[/color]: This character\'s eyes have mutated to respond faster and more drastically to low light environments. As a result, they have night vision nearly on par with their sight during the day.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Hardened Skin[/color]: This character appears to have increased resistance against ranged weapon attacks.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Third Eye[/color]: This character has developed the ability to percieve their surroundings. While the character can now peek into the uknown, they suddenly show a struggle to recall some of their memory. \n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Mutated Lungs[/color]: This character\'s lungs have mutated to assist in filtering contaminants in harmful environments. This filtering process stresses the lungs ever so slightly though.";
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
				icon = "ui/icons/pov_time_of_day.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Gain the [color=" + this.Const.UI.Color.PositiveValue + "]Third Eye[/color] skill, and an additional [color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] vision"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only take [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of damage inflicted by harmful miasmas"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] resistance to ranged attacks"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Experience Gain."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue recovery reduced by [color=" + this.Const.UI.Color.NegativeValue + "]-1[/color]."
			}

		];
		return ret;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.6; 
				}
				else
				{					
					if (_skill.isRanged())
					{				
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
						{
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
							{
								_properties.DamageReceivedRegularMult *= 0.6;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm))
							{
								_properties.DamageReceivedRegularMult *= 0.65;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
							{
								if (_skill.getID() == "actives.throw_spear")
								{
									_properties.DamageReceivedRegularMult *= 0.65;
								}
								else
								{
									_properties.DamageReceivedRegularMult *= 0.6;
								}								
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.6;
							}
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.6;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 1;
					}
				}
				break;
		}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.IsAffectedByNight = false;
		_properties.IsResistantToMiasma = true;
		_properties.Vision += 2;
		// Debuffs
		_properties.XPGainMult *= 0.90;
		_properties.FatigueRecoveryRate += -1;

	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function onAdded()
	{

		if (!this.m.Container.hasSkill("actives.pov_thirdeye_skill"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pov_thirdeye_skill"));
		}
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

