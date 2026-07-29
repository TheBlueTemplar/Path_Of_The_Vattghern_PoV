::TLW.HooksMod.hook("scripts/skills/racial/legend_rock_unhold_racial", function (q) {
	q.onTurnStart = @(__original) function () {
		local actor = this.getContainer().getActor();
		local clampArmor = function (_properties) {
			foreach (bodyPart in [::Const.BodyPart.Body, ::Const.BodyPart.Head]) {
				if (_properties.Armor[bodyPart] > _properties.ArmorMax[bodyPart]) {
					_properties.Armor[bodyPart] = _properties.ArmorMax[bodyPart];
				}
			}
		}

		__original();

		clampArmor(actor.getBaseProperties());
	}

	q.onBeforeDamageReceived = @(__original) function (_attacker, _skill, _hitInfo, _properties) {
		__original(_attacker, _skill, _hitInfo, _properties)

		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning) {
			_properties.DamageReceivedRegularMult *= 1.50;
		}
	}
});
