::TLW.HooksMod.hook("scripts/skills/actives/thrust", function (q) {

	q.m.IsThrowingWeapon <- false; // add brief descriptions for each of these and what they do
	q.m.IsHeavyThrowingWeapon <- false; // Also, copy legend's gfx and add it to pov
	q.m.IsGun <- false;
	q.m.IsSword <- false;
	q.m.IsGreatSword <- false;
	q.m.IsEstoc <- false;

	q.setItem = @(__original) function (_item) {
		__original(_item);
		if (this.m.IsThrowingWeapon) {
			this.m.Name = "Weak Thrust";
			// Distinct ID so it doesn't collide with spear "actives.thrust" when dual wielding
			this.m.ID = "actives.thrust_throwing";
			this.m.Description += "\n\nA weaker, ligther attack, made by a weapon not meant for melee. Cannot benefit from double grip.";
		} else if (this.m.IsHeavyThrowingWeapon) {
			this.m.Name = "Heavy Thrust";
			this.m.ID = "actives.thrust_heavy_throwing";
			this.m.Description += "\n\nWhile this weapon is not meant for melee, it can be used to deliver a weigthy, strong melee attack.";
			this.m.ActionPointCost = 5;
			this.m.FatigueCost = 16;
		} else if (this.m.IsGun) {
			this.m.Name = "Heavy Thrust";
			this.m.Description += "\n\nThe wielded weapon\'s pointy end allows it to effectively perform a heavy thrust, like a heavy spear.";
			//this.m.ActionPointCost = 5;
			this.m.FatigueCost = 20;
		} else if (this.m.IsSword) {
			this.m.Name = "Halfsword";
			this.m.Description += "\n\n Grip the blade of the sword with one hand and thrust it to an enemy, gaining more control and precision, while aiming at the gaps of the enemy\'s armor. \n\n Can only be used when double gripping a sword, or with certain 2 handed ones.";
			this.m.ActionPointCost = 5;
			this.m.FatigueCost = 20;

			if (_item.getID() == "weapon.pov_vattghern_longsword"
				|| _item.getID() == "weapon.pov_vattghern_sword")
			{
				this.m.Icon = "skills/pov_active_silver_halfsword.png";
				this.m.IconDisabled = "skills/pov_active_silver_halfsword_sw.png";
				this.m.Overlay = "pov_active_silver_halfsword";
			} else {
				this.m.Icon = "skills/active_halfsword.png";
				this.m.IconDisabled = "skills/active_halfsword_bw.png";
				this.m.Overlay = "active_halfsword";
			}

		} else if (this.m.IsGreatSword) {
			this.m.Name = "Heavy Halfsword";
			this.m.Description += "\n\n Grip the blade of the sword with one hand and thrust it to an enemy, gaining more control and precision, while aiming at the gaps of the enemy\'s armor. \n\n Can only be used when double gripping a sword, or with certain 2 handed ones.";
			this.m.ActionPointCost = 7;
			this.m.FatigueCost = 25;

			if (_item.getID() == "weapon.pov_vattghern_longsword"
				|| _item.getID() == "weapon.pov_vattghern_sword")
			{
				this.m.Icon = "skills/pov_active_silver_halfsword.png";
				this.m.IconDisabled = "skills/pov_active_silver_halfsword_sw.png";
				this.m.Overlay = "pov_active_silver_halfsword";
			} else {
				this.m.Icon = "skills/active_halfsword.png";
				this.m.IconDisabled = "skills/active_halfsword_bw.png";
				this.m.Overlay = "active_halfsword";
			}

		}
	}

	q.isUsable = @(__original) function () {
		local item = this.getItem();
		if (item != null
			&& !item.isNull()
			&& item.isItemType(this.Const.Items.ItemType.RangedWeapon)
			&& this.m.IsGun == false)
		{
			return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		} else {
			return this.skill.isUsable();
		}
	}

	q.getAmmo <- function () {
		local item = this.getItem();

		if (item == null || item.isNull()) {
			return 0;
		}

		return item.getAmmo();
	}

	q.canDoubleGrip <- function () {
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null
			|| newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	q.onAfterUpdate = @(__original) function (_properties) {

		if (!this.m.IsSword && !this.m.IsGreatSword) {
			return __original(_properties);
		} else {
			this.m.IsHidden = !this.canDoubleGrip()
				&& !this.m.Item.isItemType(this.Const.Items.ItemType.TwoHanded);
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords
				? this.Const.Combat.WeaponSpecFatigueMult
				: 1.0;
		}
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		if (this.m.IsThrowingWeapon && _skill == this) {
			_properties.DamageTotalMult *= _properties.IsSpecializedInThrowing ? 0.85 : 0.70;
			_properties.DamageDirectMult *= 0.85;
			_properties.MeleeSkill += 20;
		} else if (this.m.IsHeavyThrowingWeapon && _skill == this) {
			_properties.DamageTotalMult *= _properties.IsSpecializedInThrowing ? 0.95 : 0.80;
			_properties.DamageDirectMult *= 0.90;
			_properties.MeleeSkill += 20;
		} else if (this.m.IsGun && _skill == this) {
			_properties.DamageTotalMult *= 0.80;
			_properties.DamageDirectMult *= 1.40;
			_properties.DamageArmorMult *= 0.80;
			_properties.MeleeSkill += 20;
		} else if (this.m.IsSword && _skill == this) {
			_properties.ThresholdToInflictInjuryMult *= 0.85;
			_properties.DamageTotalMult *= 1.08;
			_properties.DamageDirectMult *= 1.40;
			_properties.DamageArmorMult *= 0.65;
			_properties.MeleeSkill += 20;

			if (this.m.IsEstoc) {
				_properties.DamageTotalMult *= 1.12;
			}
		} else if (this.m.IsGreatSword && _skill == this) {
			_properties.ThresholdToInflictInjuryMult *= 0.75;
			_properties.DamageTotalMult *= 1.25;
			_properties.DamageDirectMult *= 1.40;
			_properties.DamageArmorMult *= 0.70;
			_properties.MeleeSkill += 20;

			if (this.m.IsEstoc) {
				_properties.DamageTotalMult *= 1.20;
			}
		} else {
			__original(_skill, _targetEntity, _properties);
		}
	}

});
