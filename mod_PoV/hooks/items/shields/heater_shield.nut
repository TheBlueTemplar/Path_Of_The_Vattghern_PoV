::TLW.HooksMod.hook("scripts/items/shields/heater_shield", function (q) {
	q.create = @(__original) function ()
	{
		__original();
		this.m.Variants.push(1822);
	}

});

