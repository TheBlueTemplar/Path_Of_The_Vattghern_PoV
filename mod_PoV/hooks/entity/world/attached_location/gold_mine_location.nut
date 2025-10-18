::TLW.HooksMod.hook("scripts/entity/world/attached_location/gold_mine_location", function(q)
{
	q.onUpdateProduce = @( __original ) function( _list )
	{
		__original(_list);
		_list.push("trade/pov_silver_ingots_item");

		// Remove uneeded items
		for (local i = _list.len() - 1; i >= 0; i--) 
		{
		    if (_list[i] == "trade/legend_silver_ingots_item") {
		        _list.remove(i);
		    }
		}
	}

	q.create  = @( __original ) function ()
	{
		__original();
		this.m.Description = "A deep mine built atop a gold ore vein. This rare metal has a tendency to bring out the worst in people. Contributes gold and silver ingots, miners, caravan hands, sellswords and thieves to the local town";
	}

	q.onUpdateShopList = @( __original ) function( _id, _list )
	{
		__original(_id,_list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 94,
				P = 1.0,
				S = "trade/pov_silver_ingots_item"
			});
		}

		// Remove uneeded items
		for (local i = _list.len() - 1; i >= 0; i--) 
		{
		    if (_list[i].S == "trade/legend_silver_ingots_item") {
		        _list.remove(i);
		    }
		}
	}

});
