this.pov_lindwurm_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_lindwurm_mutagen_upgraded";
		this.m.Name = "[color="+ ::Const.UI.Color.povMutationUpgrade + "]Reinforced Mutation: Lindwurm[/color]";
		this.m.Icon = "skills/pov_lindwurm_stollwurm.png";
		//this.m.IconMini = "status_effect_140_mini";
		this.m.Overlay = "lindwurm";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Acidic blood[/color]: This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray. This same acid slighlty reduces healing speed.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Acidic Reinforcement[/color]: By slightly infusing their weapons with their own acid, the Vatt\'ghern does extra damage to enemy armor. During combat, they can also strengthen this infusion. \n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Draconic Cockiness[/color]: The Vatt\'ghern is full of himself with an unnatural assurance and ego, disregarding his own defense, and demanding even more pay than usual. Despite this, maybe that ego is not unfunded, as there doesn\'t apper to have such a negative effect on them. Their attacks against armor are sundering!";
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
				text = "This character gains the [color=" + this.Const.UI.Color.PositiveValue + "]\"Coat With Acid\"[/color] skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "This character\'s blood burns with [color=" + this.Const.UI.Color.PositiveValue + "]acid[/color], damaging adjacent attacker's armor whenever they deal hitpoint damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to acid."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Do [color=" + this.Const.UI.Color.PositiveValue + "]40% + 25[/color] more damage to armor."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "This character\'s lost health recovers [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color] slower."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "This character\'s melee defense is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+10[/color]% Daily Wage"
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.DamageArmorMult *= 1.4;
		_properties.DamageArmorMult += 0.25;
		// Also causes acid effect on attackers
		// Also gets coat with acid skill

		// Debuffs
		_properties.DailyWageMult *= 1.10;
		_properties.HitpointsRecoveryRateMult *= 0.8;
		_properties.MeleeDefenseMult *= 0.90;
	}

	function onAdded()
	{
		this.m.Container.getActor().getFlags().add("body_immune_to_acid");
		this.m.Container.getActor().getFlags().add("head_immune_to_acid");
	
		if (!this.m.Container.hasSkill("actives.pov_coat_with_acid"))
		{
			local acidCoat = this.new("scripts/skills/actives/pov_coat_with_acid_skill");
			this.m.Container.add(acidCoat);
		}
	
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints <= 0)
		{
			return;
		}

		if (_attacker == null || !_attacker.isAlive())
		{
			return;
		}

		if (_attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}

		if (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			return;
		}

		if (_attacker.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _attacker.getSkills().getSkillByID("effects.lindwurm_acid");

		if (poison == null)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		}
		else
		{
			poison.resetTime();
		}

		this.spawnIcon("status_effect_78", _attacker.getTile());
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

