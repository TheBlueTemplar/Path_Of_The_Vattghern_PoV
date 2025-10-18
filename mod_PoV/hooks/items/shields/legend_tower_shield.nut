::TLW.HooksMod.hook("scripts/items/shields/legend_tower_shield", function (q) {
	q.create = @(__original) function ()
	{
		__original();
		this.m.Variants.push(1822);
	}

});

