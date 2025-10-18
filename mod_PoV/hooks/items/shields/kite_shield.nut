::TLW.HooksMod.hook("scripts/items/shields/kite_shield", function (q) {
	q.create = @(__original) function ()
	{
		__original();
		this.m.Variants.push(1822);
	}

});

