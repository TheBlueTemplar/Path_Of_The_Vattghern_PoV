::TLW.HooksMod.hook("scripts/skills/actives/flail_skill", function (q) {

	q.m.IsThrowingWeapon <- false;

	q.setItem = @(__original) function (_item) {
		__original(_item);
		if (this.m.IsThrowingWeapon) {
			this.m.Name = "Weak Flail";
			this.m.Description += "\n\nA weaker, ligther attack, made by a weapon not meant for melee. Cannot benefit from double grip.";
		}
	}

	q.isUsable = @(__original) function () {
		local item = this.getItem();
		if (item != null
			&& !item.isNull()
			&& item.isItemType(this.Const.Items.ItemType.RangedWeapon))
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

	q.onAnySkillUsed = @(__original) function (_skill, _targetEntity, _properties) {
		if (this.m.IsThrowingWeapon && _skill == this) {
			_properties.DamageTotalMult *= _properties.IsSpecializedInThrowing ? 0.90 : 0.75;
			_properties.DamageArmorMult *= 0.95;
			_properties.FatigueEffectMult *= 0.80;
			_properties.DamageDirectMult *= 0.95;
		} else {
			__original(_skill, _targetEntity, _properties);
		}
	}

});
