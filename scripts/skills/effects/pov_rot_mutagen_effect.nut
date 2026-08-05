this.pov_rot_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		this.m.ID = "effects.pov_rot_mutagen";
		this.m.Name = "Mutation: Rot";
		this.m.Icon = "skills/pov_flesh_golem.png";
		this.m.IconMini = "";
		this.m.Overlay = "necro";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription() {
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Corpse-Mancy[/color]: This character has the ability to make corpses come to life. But that life comes in the form of a violent explosion, damaging and debuffing anyone nearby.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Rotten Stench[/color]: This character is embraced by rot, allowing them to poison, debuff and test the resolve of any enemy that dares approach them, while also benefitting from increased constitution.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Compromised Reflexes[/color]: Rot is all about entropy, thus weakening this character\'s speed and reflexes, making them more vulnerable in battle.";
	}

	function getTooltip() {
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
				text = "Gain the [color=" + this.Const.UI.Color.povTooltipBlue + "]Corpse Explosion[/color] skill in battle, allowing to blow up corpses."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain the [color=" + this.Const.UI.Color.povTooltipBlue + "]Unbearable Stench[/color] passive effect in battle, and gain [color=" + this.Const.UI.Color.PositiveValue + "]Immunity[/color] to rot."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Maximum HP increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Suffer from [color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Initiative"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_melee_ranged_defense.png",
				text = "Defenses decreased by [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]40%[/color] more damage from fire attacks."
			}
		];
		return ret;
	}

	function onCombatStarted() {
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/pov_unbearable_stench_passive_effect"));
	}

	function onUpdate(_properties) {
		// Buffs
		_properties.HitpointsMult *= 1.15;
		_properties.Threat += 5;
		// Debuffs
		_properties.MeleeDefenseMult *= 0.90;
		_properties.RangedDefenseMult *= 0.90;
		_properties.InitiativeMult *= 0.75;
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning) {
			_properties.DamageReceivedRegularMult *= 1.4;
		}
	}

	function onAdded() {
		if (!this.m.Container.hasSkill("actives.pov_corpse_explosion")) {
			this.m.Container.add(::new("scripts/skills/actives/pov_corpse_explosion_skill"));
		}
	}

	function isHidden() {
		return this.inBattleHiddenCheck();
	}

	function inBattleHiddenCheck() {
		if (!("State" in this.Tactical) || this.Tactical.State == null) {
			return false;
		}

		return true;
	}

});
