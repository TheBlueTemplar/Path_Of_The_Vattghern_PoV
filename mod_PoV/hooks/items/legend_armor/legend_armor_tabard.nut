::TLW.HooksMod.hook("scripts/items/legend_armor/legend_armor_tabard", function (q) {
	q.create = @(__original) function ()
	{
		__original();
		this.m.Variants.push(1822);
	}

});

