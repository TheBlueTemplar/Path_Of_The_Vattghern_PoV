::TLW.HooksMod.hook("scripts/items/weapons/legend_military_warscythe", function (q) {

	q.create = @(__original) function () {
		__original();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
	}

});
