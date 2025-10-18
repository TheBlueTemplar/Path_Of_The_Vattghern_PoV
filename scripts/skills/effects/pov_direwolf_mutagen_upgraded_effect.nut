this.pov_direwolf_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsUsed = {},
		ArmorPenalty = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_direwolf_mutagen_upgraded";
		this.m.Name = "[color="+ ::Const.UI.Color.povMutationUpgrade + "]Reinforced Mutation: Alpha Beast[/color]";
		this.m.Icon = "skills/pov_direwolf_white.png";
		this.m.IconMini = "";
		this.m.Overlay = "werewolf";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Greatly Elasticized Sinew[/color]: This character\'s muscles have mutated to become highly efficient, vastly increasing the character\'s stamina while moving and fighting. This also helps them perform better under the effects of adrenaline, making the vattghern fight better in dire conditions.\n\n [color=" + this.Const.UI.Color.povPerkBlue + "]Enhanced Vision[/color]: This character\'s eyes have mutated to adapt rapidly to low light conditions, halving nighttime penalties.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Rend the flesh[/color]: All attacks can cause strong bleeding. Also, a powerful clotting agent in the skin makes this character immune to bleeding effects.\n\n [color=" + this.Const.UI.Color.povPerkBlue + "]Maladaptive Exoskeleton[/color]: Due to structural mutations in the character's body, effectively using body armor, especially the heavier kinds, is moderately difficult.";
	}

	function getPenalty()
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Body);
		local helmetFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Head);
		local totalPen = armorFatPen + helmetFatPen;
		local penalty = totalPen * 0.2;
		return penalty;
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
				text = "Gets the [color=" + this.Const.UI.Color.PositiveValue + "]\"Adrenaline Rush\"[/color] passive, which increases damage and initiative when low on HP."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "All attacks can cause [color=" + this.Const.UI.Color.PositiveValue + "]Bleeding[/color] equal to [color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] of inflicted damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Movement costs [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] less Fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Skills cost [color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] less fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_time_of_day.png",
				text = "Nighttime penalties are [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to bleeding effects."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The fatigue and initiative penalty from wearing armor is increased by [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color]."
			},
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		// Adrenaline effect
		// Small bleed to all attacks
		_properties.MovementFatigueCostMult *= 0.75;
		_properties.FatigueEffectMult *= 0.70;
		_properties.IsImmuneToBleeding = true;

		if (this.getContainer().hasSkill("special.night") && _properties.IsAffectedByNight)
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
		}
		
		// Debuffs
		_properties.Stamina += this.getPenalty();
		_properties.Initiative += this.getPenalty();
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/pov_adrenaline_rush_effect"));
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}


		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
		}

		//local bleedDamage = ((actor.getCurrentProperties().DamageRegularMin + actor.getCurrentProperties().DamageRegularMaxn) / 2) * 0.10;

		//this.spawnIcon("status_effect_54", _targetEntity.getTile());

		local bleed = _targetEntity.getSkills().getSkillByID("effects.bleeding");
		local bleedAdd = this.new("scripts/skills/effects/bleeding_effect");

		if (bleed != null && bleed.m.Damage < _damageInflictedHitpoints * 0.3)
		{
			bleedAdd.m.Damage = _damageInflictedHitpoints * 0.3;
		}else if (bleed == null)
		{
			bleedAdd.m.Damage = 1 + _damageInflictedHitpoints * 0.3;
		}
		_targetEntity.getSkills().add(bleedAdd);
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

