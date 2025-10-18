::TLW.HooksMod.hook("scripts/entity/world/attached_location/surface_iron_vein_location", function(q)
{
	q.create  = @( __original ) function ()
	{
		__original();
		this.m.Description += "Also rarely provides silver ingots.";
	}

	q.onUpdateShopList = @( __original ) function( _id, _list )
	{
		__original(_id,_list);
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 97,
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
