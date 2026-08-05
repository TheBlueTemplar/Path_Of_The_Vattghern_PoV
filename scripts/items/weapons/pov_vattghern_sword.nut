this.pov_vattghern_sword <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 25
	},

	function create() {

		local NameList = ["Gwaed\'thain", "Fen\'aeth", "Zireael", "Gwynbleidd", "Addan\'Anye"];

		this.weapon.create();
		this.m.ID = "weapon.pov_vattghern_sword";
		this.m.Name = "[color=" + ::Const.UI.Color.povLegendaryWeapon + "]" + NameList[this.Math.rand(0, NameList.len() - 1)] + "[/color]";
		this.m.Description = "A silver sword. Much lighter than its counterparts, carefully crafted and perfectly balanced, this sword truly shines when wielded by a vatt\'ghern.\n\nIts reinforced silver structure and coating perfect for fighting anything beastly and supernatural. It is said that such swords inherit the properties of their wielders...\n\n [color=" + this.Const.UI.Color.DamageValue + "]Not as effective when wielded by someone who is not a Vatt\'ghern[/color]";
		this.m.IconLarge = "weapons/melee/pov_witcher_sword.png";
		this.m.Icon = "weapons/melee/pov_witcher_sword_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		//this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = false;
		//this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "pov_icon_witcher_sword";
		this.m.Value = 8500;
		this.m.IsPrecious = true;
		//this.m.ShieldDamage = 12;
		this.m.Condition = 110.0;
		this.m.ConditionMax = 110.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.00;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
	}

	function getTooltip() {
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Skills inflict an additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] damage to monsters and spirits and [color=" + this.Const.UI.Color.DamageValue + "]half[/color] of this bonus against mutants and undead."
		});

		showMutationEffects(result);

		return result;
	}

	function isDroppedAsLoot() {
		return true;
	}

	function onEquip() {
		this.weapon.onEquip();

		local slash = this.new("scripts/skills/actives/slash");
		slash.m.Icon = "skills/pov_active_silver_slash.png";
		slash.m.IconDisabled = "skills/pov_active_silver_slash_sw.png";
		slash.m.Overlay = "pov_active_silver_slash";
		this.addSkill(slash);

		local riposte = this.new("scripts/skills/actives/riposte");
		riposte.m.Icon = "skills/pov_active_silver_riposte.png";
		riposte.m.IconDisabled = "skills/pov_active_silver_riposte_sw.png";
		riposte.m.Overlay = "pov_active_silver_riposte";
		this.addSkill(riposte);

		local lunge = this.new("scripts/skills/actives/lunge_skill");
		lunge.m.Icon = "skills/pov_active_silver_lunge.png";
		lunge.m.IconDisabled = "skills/pov_active_silver_lunge_sw.png";
		lunge.m.Overlay = "pov_active_silver_lunge";
		this.addSkill(lunge);

		local halfsword = this.new("scripts/skills/actives/thrust");
		halfsword.m.IsSword = true;
		// PoV Icons added in hammer.nut
		//halfsword.m.Icon = "skills/pov_active_silver_halfsword.png";
		//halfsword.m.IconDisabled = "skills/pov_active_silver_halfsword_sw.png";
		//halfsword.m.Overlay = "pov_active_silver_halfsword";
		this.addSkill(halfsword);

		local mordhau = this.new("scripts/skills/actives/hammer");
		mordhau.m.IsMordhau = true;
		//mordhau.m.IsGreatMordhau = true;
		// PoV Icons added in hammer.nut
		//mordhau.m.Icon = "skills/pov_active_silver_mordhau.png";
		//mordhau.m.IconDisabled = "skills/pov_active_silver_mordhau_sw.png";
		//mordhau.m.Overlay = "pov_active_silver_mordhau";
		this.addSkill(mordhau);
	}

	function onUpdateProperties(_properties) {
		this.weapon.onUpdateProperties(_properties);
		// Add "weak" skill to anyone whos not vattghern and wielding this
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("trait.pov_witcher")
			&& !actor.getSkills().hasSkill("trait.pov_witcher_enemy"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/pov_non_vattghern_sword_effect"));
		}

		// Unique buffs depending on current mutations
		calculateMutationEffects(actor, _properties);
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		// OLD IMPLEMENTATION = WORKS BUT WITH UI BS
		/*f (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
		{
			_properties.DamageTotalMult *= 1.20;
		}*/
		local actor = this.getContainer().getActor();

		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor")) {
			if (this.Const.EntityType.getDefaultFaction(_targetEntity.getType()) == this.Const.FactionType.Beasts
				|| _targetEntity.getFlags().has("ghost"))
			{
				_properties.DamageTotalMult *= 1.20;
			} else if (_targetEntity.getFlags().has("undead")
				|| _targetEntity.getFlags().has("mutant"))
			{
				_properties.DamageTotalMult *= 1.10;
			}

			if (actor.getSkills().hasSkill("effects.pov_spider_mutagen")) {
				if (_targetEntity.getSkills().getSkillByID("effects.pov_mutant_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.spider_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.goblin_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.legend_basilisk_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_upgraded_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_stench") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_weak_stench") != null)
				{
					_properties.DamageRegularMult *= 1.05;
					_properties.MeleeSkillMult *= 1.05;
				}
			} else if (actor.getSkills().hasSkill("effects.pov_spider_mutagen_upgraded")) {
				if (_targetEntity.getSkills().getSkillByID("effects.pov_mutant_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.spider_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.goblin_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.legend_basilisk_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_upgraded_poison") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_stench") != null
					|| _targetEntity.getSkills().getSkillByID("effects.pov_weak_stench") != null)
				{
					_properties.DamageRegularMult *= 1.08;
					_properties.MeleeSkillMult *= 1.08;
				}
			}
		}
	}

	function calculateMutationEffects(_actor, _properties) {
		if (_actor.getSkills().hasSkill("effects.pov_hexe_mutagen")) {
			_properties.SignIntensity += 0.10;
		} else if (_actor.getSkills().hasSkill("effects.pov_hexe_mutagen_upgraded")) {
			_properties.SignIntensity += 0.15;
		} else {
			_properties.SignIntensity += 0.05;
		}

		if (_actor.getSkills().hasSkill("effects.pov_ghoul_mutagen")) {
			_properties.Threat += 5;
		} else if (_actor.getSkills().hasSkill("effects.pov_ghoul_mutagen_upgraded")) {
			_properties.Threat += 8;
		}

		if (_actor.getSkills().hasSkill("effects.pov_ghost_mutagen")) {
			_properties.DamageDirectAdd += 0.10;
		}

		if (_actor.getSkills().hasSkill("effects.pov_direwolf_mutagen")) {
			_properties.FatigueEffectMult *= 0.92;
		} else if (_actor.getSkills().hasSkill("effects.pov_direwolf_mutagen_upgraded")) {
			_properties.FatigueEffectMult *= 0.85;
		}

		if (_actor.getSkills().hasSkill("effects.pov_alp_mutagen")) {
			_properties.RangedDefenseMult *= 1.10;
			_properties.RangedDefense += 4;
		} else if (_actor.getSkills().hasSkill("effects.pov_alp_mutagen_upgraded")) {
			_properties.RangedDefenseMult *= 1.15;
			_properties.RangedDefense += 6;
		}

		if (_actor.getSkills().hasSkill("effects.pov_basilisk_mutagen")) {
			_properties.HitChance[this.Const.BodyPart.Head] += 5;
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.05;
		}

		if (_actor.getSkills().hasSkill("effects.pov_vampire_mutagen")) {
			if (_actor.getSkills().hasSkill("special.night")) {
				_properties.RangedSkillMult *= 1.05;
				_properties.RangedDefenseMult *= 1.05;
				_properties.MeleeSkillMult *= 1.05;
				_properties.MeleeDefenseMult *= 1.05;
				_properties.InitiativeMult *= 1.05;
				_properties.BraveryMult *= 1.05;
				_properties.StaminaMult *= 1.05;
				_properties.DamageTotalMult *= 1.05;
			}
		}

		if (_actor.getSkills().hasSkill("effects.pov_unhold_mutagen")) {
			_properties.HitpointsMult *= 1.10;
		} else if (_actor.getSkills().hasSkill("effects.pov_unhold_mutagen_upgraded")) {
			_properties.HitpointsMult *= 1.15;
		}

		if (_actor.getSkills().hasSkill("effects.pov_serpent_mutagen")) {
			_properties.Initiative += 10;
		}

		if (_actor.getSkills().hasSkill("effects.pov_sandgolem_mutagen")) {
			_properties.DamageReceivedTotalMult *= 0.94;
		}

		if (_actor.getSkills().hasSkill("effects.pov_schrat_mutagen")) {
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		} else if (_actor.getSkills().hasSkill("effects.pov_schrat_mutagen_upgraded")) {
			_properties.MeleeDefense += 8;
			_properties.RangedDefense += 8;
		}

		if (_actor.getSkills().hasSkill("effects.pov_orc_mutagen")) {
			_properties.DamageTotalMult *= 1.12;
		}

		if (_actor.getSkills().hasSkill("effects.pov_lindwurm_mutagen")) {
			_properties.DamageArmorMult *= 1.15;
		} else if (_actor.getSkills().hasSkill("effects.pov_lindwurm_mutagen_upgraded")) {
			_properties.DamageArmorMult *= 1.25;
		}

		if (_actor.getSkills().hasSkill("effects.pov_goblin_mutagen")) {
			_properties.DamageTotalMult *= 0.82;
			local slash = _actor.getSkills().getSkillByID("actives.slash");
			if (slash != null) {
				slash.m.ActionPointCost -= 1;
			};
			local overhead_strike = _actor.getSkills().getSkillByID("actives.overhead_strike");
			if (overhead_strike != null) {
				overhead_strike.m.ActionPointCost -= 1;
			};
			local split = _actor.getSkills().getSkillByID("actives.split");
			if (split != null) {
				split.m.ActionPointCost -= 1;
			};
			local swing = _actor.getSkills().getSkillByID("actives.swing");
			if (swing != null) {
				swing.m.ActionPointCost -= 1;
			};
			local riposte = _actor.getSkills().getSkillByID("actives.riposte");
			if (riposte != null) {
				riposte.m.ActionPointCost -= 1;
			};
		}

		if (_actor.getSkills().hasSkill("effects.pov_skeleton_mutagen")) {
			_properties.Bravery += 15;
		}

		if (_actor.getSkills().hasSkill("effects.pov_necromancy_mutagen")) {
			_properties.XPGainMult *= 1.10;
		}

		if (_actor.getSkills().hasSkill("effects.pov_rot_mutagen")) {
			_properties.Hitpoints += 10;
		}

	}

	function showMutationEffects(_result) {
		//some checkz
		local actor;
		if (this.getContainer() != null) {
			actor = this.getContainer().getActor();
		}
		// default kinda shit
		if (actor == null) {
			_result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/pov_intensity.png",
				text = "Sign Intensity of the wielder increased by [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]."
			});
			return;
		}

		if (actor.getSkills().hasSkill("effects.pov_hexe_mutagen")) {
			_result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/pov_intensity.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Hexe Mutagen:[/color] Sign Intensity increased by [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]."
			});
		} else if (actor.getSkills().hasSkill("effects.pov_hexe_mutagen_upgraded")) {
			_result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/pov_intensity.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Hexe Mutagen Upgraded:[/color] Sign Intensity increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			});
		} else {
			_result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/pov_intensity.png",
				text = "Sign Intensity of the wielder increased by [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_ghoul_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Nachzehrer Mutagen:[/color] Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]."
			});
		} else if (actor.getSkills().hasSkill("effects.pov_ghoul_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Nachzehrer Mutagen Upgraded:[/color] Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-8[/color]."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_ghost_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Geist Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] (flat) armor penetration."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_direwolf_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Direwolf Mutagen:[/color] Skills cost [color=" + this.Const.UI.Color.PositiveValue + "]8%[/color] less fatigue"
			});
		} else if (actor.getSkills().hasSkill("effects.pov_direwolf_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Direwolf Mutagen Upgraded:[/color] Skills cost [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] less fatigue"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_alp_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Alp Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] plus flat [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] Ranged Defense"
			});
		} else if (actor.getSkills().hasSkill("effects.pov_alp_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Alp Mutagen Upgraded:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] plus flat [color=" + this.Const.UI.Color.PositiveValue + "]6[/color] Ranged Defense"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_basilisk_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Basilisk Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit the head, and [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] damage to it."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_vampire_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/pov_time_of_day.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Vampire Mutagen:[/color] When fighting at [color=" + this.Const.UI.Color.PositiveValue + "]nighttime[/color], all combat stats and damage are increased by an additional [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_unhold_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Unhold Mutagen:[/color] Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] hitpoint bonus"
			});
		} else if (actor.getSkills().hasSkill("effects.pov_unhold_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Unhold Mutagen Upgraded:[/color] Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] hitpoint bonus"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_serpent_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Serpent Mutagen:[/color] Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] initiative"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_sandgolem_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Ifrit Mutagen:[/color] Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]6%[/color] Damage Reduction"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_schrat_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/pov_melee_ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Schrat Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] to defenses"
			});
		} else if (actor.getSkills().hasSkill("effects.pov_schrat_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/pov_melee_ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Schrat Mutagen Upgraded:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+8[/color] to defenses"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_orc_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Orc Mutagen:[/color] Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]12%[/color] Damage Bonus"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_lindwurm_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Lindwurm Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] effectiveness against armor"
			});
		} else if (actor.getSkills().hasSkill("effects.pov_lindwurm_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Lindwurm Mutagen Upgraded:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] effectiveness against armor"
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_goblin_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Goblin Mutagen:[/color] This weapon\'s skills cost [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Points, but do [color=" + this.Const.UI.Color.NegativeValue + "]18%[/color] less damage."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_skeleton_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Undeath Mutagen:[/color] Get [color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Resolve."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_spider_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Spider Mutagen:[/color] Attacks against poisoned enemies get [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Damage and Melee Skill."
			});
		} else if (actor.getSkills().hasSkill("effects.pov_spider_mutagen_upgraded")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Spider Mutagen Upgraded:[/color] Attacks against poisoned enemies get [color=" + this.Const.UI.Color.PositiveValue + "]+8%[/color] Damage and Melee Skill."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_rot_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Rot Mutagen:[/color] Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] hitpoints."
			});
		}

		if (actor.getSkills().hasSkill("effects.pov_necromancy_mutagen")) {
			_result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + ::Const.UI.Color.povPerkPurple + "]Necromancy Mutagen:[/color] Get [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] more XP."
			});
		}

	}

});
