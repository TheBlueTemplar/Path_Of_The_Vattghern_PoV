::TLW.HooksMod.hook("scripts/skills/actives/hammer", function (q) {

	q.m.IsThrowingWeapon <- false; // add brief descriptions for each of these and what they do
	q.m.IsHeavyThrowingWeapon <- false; // Also, copy legend's gfx and add it to pov
	q.m.IsGun <- false;
	q.m.IsSword <- false;
	q.m.IsGreatSword <- false;
	q.m.IsEstoc <- false;

	q.setItem = @(__original) function (_item) {
		__original(_item);
		if (this.m.IsMordhau) {
			this.m.Name = "Mordhau";
			this.m.Description = "Grip your sword by the blade and strike with the guard and pommel for a strike that can be felt through the thickest of armor and will leave a lasting mark.";

			this.m.ActionPointCost = this.m.IsGreatMordhau ? 7 : 5;
			this.m.FatigueCost = this.m.IsGreatMordhau ? 25 : 20;

			if (_item.getID() == "weapon.pov_vattghern_longsword"
				|| _item.getID() == "weapon.pov_vattghern_sword")
			{
				this.m.Icon = "skills/pov_active_silver_mordhau.png";
				this.m.IconDisabled = "skills/pov_active_silver_mordhau_sw.png";
				this.m.Overlay = "pov_active_silver_mordhau";
			} else {
				this.m.Icon = "skills/active_mordhau.png";
				this.m.IconDisabled = "skills/active_mordhau_bw.png";
				this.m.Overlay = "active_mordhau";
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
			return !this.Tactical.isActive() || this.skill.isUsable() && item.getAmmo() > 0;
		} else {
			return this.skill.isUsable();
		}
	}

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		if (this.m.IsGreatMordhau && _skill == this) {
			_properties.DamageMinimum += 10;
			_properties.DamageTotalMult *= 1.16;
			_properties.DamageDirectMult *= 0.60;
			_properties.DamageArmorMult *= 1.45;
			_properties.MeleeSkill += -5;
			this.m.HitChanceBonus = -5;
		} else if (this.m.IsMordhau && _skill == this) {
			_properties.DamageMinimum += 5;
			_properties.DamageTotalMult *= 1.10;
			_properties.DamageDirectMult *= 0.65;
			_properties.DamageArmorMult *= 1.40;
			_properties.MeleeSkill += -5;
			this.m.HitChanceBonus = -5;
		} else {
			__original(_skill, _targetEntity, _properties);
		}
	}

});
