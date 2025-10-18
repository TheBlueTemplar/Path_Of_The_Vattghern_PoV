::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		if (::World.Flags.has("FirstMutantKilled"))
		{	
			// VATTGHERN MUTAGENS
			_list.extend([
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_unhold_mutagen_item"
				},
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_strain_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_spider_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_skeleton_mutagen_item"
				},
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_serpent_mutagen_item"
				},
				{
					R = 98,
					P = 42.0,
					S = "misc/anatomist/pov_schrat_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_orc_mutagen_item"
				},
				{
					R = 98,
					P = 42.0,
					S = "misc/anatomist/pov_vampire_mutagen_item"
				},
				{
					R = 98,
					P = 33.0,
					S = "misc/anatomist/pov_lindwurm_mutagen_item"
				},
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_sandgolem_mutagen_item"
				},
				{
					R = 98,
					P = 42.0,
					S = "misc/anatomist/pov_hexe_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_goblin_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_ghoul_mutagen_item"
				},
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_ghost_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_direwolf_mutagen_item"
				},
				{
					R = 97,
					P = 38.0,
					S = "misc/anatomist/pov_basilisk_mutagen_item"
				},
				{
					R = 96,
					P = 33.0,
					S = "misc/anatomist/pov_alp_mutagen_item"
				}
			]);
		}

		_list.extend([
			// TOG ITEMS
			/*{
				R = 97,
				P = 4.0,
				S = "misc/vampire_dust_item"
			},*/
			{
				R = 95,
				P = 3.6,
				S = "misc/pov_distilled_alcohol_item"
			},
			{
				R = 98,
				P = 3.0,
				S = "misc/unhold_heart_item"
			},
			{
				R = 98,
				P = 3.0,
				S = "misc/third_eye_item"
			},
			{
				R = 97,
				P = 1.8,
				S = "misc/sulfurous_rocks_item"
			},
			// OTHER ITEMS
			{
				R = 98,
				P = 1.25,
				S = "misc/anatomist/pov_beautiful_potion_item" //those are called by the script path, not ID
				//meme item
			},
		]);
		
		__original( _list, _stash, _priceMult, _allowDamagedEquipment);
		
		// Remove SSU Sequences from shops (ingame option)
		if (::TLW.hasSSU && ::TLW.SSUTweaks)
		{
			for (local i = _list.len() - 1; i >= 0; i--)
			{
			    local s = _list[i].S;
			    if (s == "misc/anatomist/alp_sequence_item" ||
			        s == "misc/anatomist/direwolf_sequence_item" ||
			        s == "misc/anatomist/goblin_sequence_item" ||
			        s == "misc/anatomist/nachzehrer_sequence_item" ||
			        s == "misc/anatomist/orc_sequence_item" ||
			        s == "misc/anatomist/serpent_sequence_item" ||
			        s == "misc/anatomist/unhold_sequence_item" ||
			        s == "misc/anatomist/webknecht_sequence_item")
			    {
			        _list.remove(i);
			    }
			}
		}
		
	}

});