::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/blackmarket_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		if (::World.Flags.has("FirstMutantKilled"))
		{	
			// VATTGHERN MUTAGENS
			_list.extend([
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_unhold_mutagen_item"
				},
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_strain_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_spider_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_skeleton_mutagen_item"
				},
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_serpent_mutagen_item"
				},
				{
					R = 99,
					P = 50.0,
					S = "misc/anatomist/pov_schrat_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_orc_mutagen_item"
				},
				{
					R = 99,
					P = 50.0,
					S = "misc/anatomist/pov_vampire_mutagen_item"
				},
				{
					R = 99,
					P = 50.0,
					S = "misc/anatomist/pov_lindwurm_mutagen_item"
				},
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_sandgolem_mutagen_item"
				},
				{
					R = 99,
					P = 40.0,
					S = "misc/anatomist/pov_hexe_mutagen_item"
				},
				{
					R = 99,
					P = 40.0,
					S = "misc/anatomist/pov_goblin_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_ghoul_mutagen_item"
				},
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_ghost_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_direwolf_mutagen_item"
				},  
				{
					R = 99,
					P = 45.0,
					S = "misc/anatomist/pov_basilisk_mutagen_item"
				},
				{
					R = 97,
					P = 40.0,
					S = "misc/anatomist/pov_alp_mutagen_item"
				},
			]);
		}
		_list.extend([
			// TOG ITEMS
			/*{
				R = 97,
				P = 4.5,
				S = "misc/vampire_dust_item"
			},*/
			{
				R = 96,
				P = 4.2,
				S = "misc/pov_distilled_alcohol_item"
			},
			{
				R = 97,
				P = 4.5,
				S = "misc/unhold_heart_item"
			},
			{
				R = 98,
				P = 4.5,
				S = "misc/third_eye_item"
			},
			{
				R = 98,
				P = 3.0,
				S = "misc/sulfurous_rocks_item"
			},
			// OTHER ITEMS
			{
				R = 99,
				P = 2.0,
				S = "misc/anatomist/pov_beautiful_potion_item" //those are called by the script path, not ID
				//meme item
			},
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment);
	}

});