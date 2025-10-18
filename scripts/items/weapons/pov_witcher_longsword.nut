this.pov_witcher_longsword <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 25
	},
	function create()
	{

		local NameList = ["Gwaed\'thain","Fen\'aeth","Zireael","Gwynbleidd","Addan\'Anye"];

		this.weapon.create();
		this.m.ID = "weapon.pov_witcher_longsword";
		this.m.Name = "[color="+ ::Const.UI.Color.povLegendaryWeapon + "]" + NameList[this.Math.rand(0, NameList.len() - 1)] + "[/color]";
		this.m.Description = "A long silver sword. Much lighter than its counterparts, carefully crafted and perfectly balanced, ideal for slaying monsters.\n\nIts reinforced silver structure and coating perfect for fighting anything beastly and supernatural.";
		this.m.IconLarge = "weapons/melee/pov_witchersword.png";
		this.m.Icon = "weapons/melee/pov_witchersword_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "pov_icon_witchersword";
		this.m.Value = 10000;
		this.m.IsPrecious = true;
		//this.m.ShieldDamage = 12;
		this.m.Condition = 160.0;
		this.m.ConditionMax = 160.0;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 82;
		this.m.RegularDamageMax = 92;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 12;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Skills inflict an additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] damage to monsters and spirits and [color=" + this.Const.UI.Color.DamageValue + "]half[/color] of this bonus against mutants and undead."
		});
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Not as [color=" + this.Const.UI.Color.DamageValue + "]effective[/color] when wielded by someone who is not a vatt\'ghern"
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local slash = this.new("scripts/skills/actives/slash");
		slash.m.Icon = "skills/pov_active_silver_slash.png";
		slash.m.IconDisabled = "skills/pov_active_silver_slash_sw.png";
		slash.m.Overlay = "pov_active_silver_slash";
		this.addSkill(slash);

		local overhead = this.new("scripts/skills/actives/overhead_strike");
		overhead.setStunChance(this.m.StunChance);
		overhead.m.Icon = "skills/pov_active_silver_overhead.png";
		overhead.m.IconDisabled = "skills/pov_active_silver_overhead_sw.png";
		overhead.m.Overlay = "pov_active_silver_overhead";
		this.addSkill(overhead);

		local split = this.new("scripts/skills/actives/split");
		split.m.Icon = "skills/pov_active_silver_split.png";
		split.m.IconDisabled = "skills/pov_active_silver_split_sw.png";
		split.m.Overlay = "pov_active_silver_split";
		this.addSkill(split);

		local swing = this.new("scripts/skills/actives/swing");
		swing.m.Icon = "skills/pov_active_silver_swing.png";
		swing.m.IconDisabled = "skills/pov_active_silver_swing_sw.png";
		swing.m.Overlay = "pov_active_silver_swing";
		this.addSkill(swing);

		local riposte = this.new("scripts/skills/actives/riposte");
		riposte.m.Icon = "skills/pov_active_silver_riposte.png";
		riposte.m.IconDisabled = "skills/pov_active_silver_riposte_sw.png";
		riposte.m.Overlay = "pov_active_silver_riposte";
		this.addSkill(riposte);
	}

	function onUpdateProperties(_properties)
	{
		this.weapon.onUpdateProperties(_properties);
		// Add "weak" skill to anyone whos not vattghern and wielding this
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("trait.pov_witcher"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/pov_non_vattghern_sword_effect"));
		}	
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties)
	{
		// OLD IMPLEMENTATION = WORKS BUT WITH UI BS
		/*f (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
		{
			_properties.DamageTotalMult *= 1.20;
		}*/

		if (_targetEntity != null)
		{
			if(this.Const.EntityType.getDefaultFaction(_targetEntity.getType()) == this.Const.FactionType.Beasts || _targetEntity.getFlags().has("ghost"))
			{
				_properties.DamageTotalMult *= 1.20;
			}else if(_targetEntity.getFlags().has("undead") || _targetEntity.getFlags().has("mutant"))
			{
				_properties.DamageTotalMult *= 1.10;
			}
		}
	}

});

