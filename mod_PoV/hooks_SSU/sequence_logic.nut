// SSU Sequences incompat with PoV Mutations
local checkSequence = ::Mod_Sellswords.checkSequence;
::Mod_Sellswords.checkSequence = function (_actor, _flag) 
{
    if (_actor.getFlags().getAsInt("pov_ActiveMutations") >= 1)
    {
        _actor.getItems().transferToStash(::World.Assets.getStash());
        _actor.getSkills().onDeath(::Const.FatalityType.Suicide);
        ::Legends.addFallen(_actor, "Died to Conflicting Mutations");
        ::World.getPlayerRoster().remove(_actor);
        return;
    }
    checkSequence(_actor, _flag);
}

// FROM HERE BELOW: REMOVE SSU SEQUENCES (OPTIONAL)
// Also similar shit on alchemist_building.nut

local doPotionDrop = ::Mod_Sellswords.doPotionDrop;
::Mod_Sellswords.doPotionDrop = function (_killer, _skill, _tile, _fatalityType, chance, item)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
}

local doHostileSequencePotionDrop = ::Mod_Sellswords.doHostileSequencePotionDrop;
::Mod_Sellswords.doHostileSequencePotionDrop = function(_killer, _skill, _tile, _fatalityType, _actor)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, _actor);
}

local add_direwolf = ::Mod_Sellswords.add_direwolf;
::Mod_Sellswords.add_direwolf = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_direwolf(_actor,complete);
}

local add_serpent = ::Mod_Sellswords.add_serpent;
::Mod_Sellswords.add_serpent = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_serpent(_actor,complete);
}

local add_ghoul = ::Mod_Sellswords.add_ghoul;
::Mod_Sellswords.add_ghoul = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_ghoul(_actor,complete);
}

local add_spider = ::Mod_Sellswords.add_spider;
::Mod_Sellswords.add_spider = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_spider(_actor,complete);
}

local add_unhold = ::Mod_Sellswords.add_unhold;
::Mod_Sellswords.add_unhold = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_unhold(_actor,complete);
}

local add_orc = ::Mod_Sellswords.add_orc;
::Mod_Sellswords.add_orc = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_orc(_actor,complete);
}

local add_necrosavant = ::Mod_Sellswords.add_necrosavant;
::Mod_Sellswords.add_necrosavant = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_necrosavant(_actor,complete);
}

local add_goblin = ::Mod_Sellswords.add_goblin;
::Mod_Sellswords.add_goblin = function (_actor, complete)
{
	if (::TLW.hasSSU && ::TLW.SSUTweaks)
	{
		return;
	}
	add_goblin(_actor,complete);
}

// MY METHOD (WRONG)
/*::TLW.HooksMod.hook("mod_sellswords/config/sequence_logic", function(q) {
	// Failed attempt for now
	q.checkSequence = @(__original) function (_actor, _flag)
	{

		if (_actor.getFlags().getAsInt("pov_ActiveMutations") >= 1)
		{
			_actor.getItems().transferToStash(this.World.Assets.getStash());
			_actor.getSkills().onDeath(this.Const.FatalityType.None);
			::Legends.addFallen(_actor, "The Vattghern mutations are not compatible with others. Bro learned this the hard way :(");
			this.World.getPlayerRoster().remove(_actor);
		}

		return __original(_actor, _flag);
	}

});*/