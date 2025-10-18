// New System
::TLW.CorpseDrop <-
{
	getCorpseDrop = function (_actor, _corpse)
	{
		// fallbacks
		if (_actor.getAIAgent() == null)
		{
			return;
		}

		local chance = _corpse.BaseDropChance;

		// Quick way to adjust drop rates, best to keep at 1
		local generalModifier = 1.0;
		chance *= generalModifier;

		// Combat Difficulty Based Modifier
		local difficultyModifier = [1.10, 1.05, 1, 0.85][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;	

		// Scenario Based Modifiers
		if (this.World.Assets.getOrigin().getID() == "scenario.pov_last_witchers" || this.World.Assets.getOrigin().getID() == "scenario.legends_rangers")
		{
			chance *= 1.15;
		} 
		else if (this.World.Assets.getOrigin().getID() == "scenario.pov_solo_last_witchers")
		{
			chance *= 1.20;
		}
		else if (this.World.Assets.getOrigin().getID() == "scenario.beast_hunters" || this.World.Assets.getOrigin().getID() == "scenario.anatomists" || this.World.Assets.getOrigin().getID() == "scenario.rangers")
		{
			chance *= 1.10;
		}	

		// Alchemist Retinue increases corpse drop rates
		local hasAlchemist = this.World.Retinue.hasFollower("follower.alchemist");
		if (hasAlchemist)
		{
			chance *= 1.15;
		}
		
		//chance = 100; //For Testing Only

		// Dont drop corpse before killing first mutant
		if(!::World.Flags.has("FirstMutantKilled"))
		{
			chance = 0;
		}

		::TLW.Mod.Debug.printLog("Rolling for Corpse || Chance: " + chance);
		return [chance, _corpse.Script];
	}
}