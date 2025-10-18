::TLW.HooksMod.hook("scripts/entity/tactical/player", function ( q ) {
// ALT LOGS HERE
    q.getBarterModifier = @() function()
    {
        local bg = this.getBackground();
        if (bg == null)
        {
            return 0;
        }

        local mod = this.getBackground().getModifiers().Barter;
        local skills = [
            "perk.legend_barter_trustworthy",
            "perk.legend_barter_convincing",
            "perk.legends.legend_off_book_deal",
            "trait.legend_seductive",
            "effects.pov_hexe_mutagen",
            "effects.pov_hexe_mutagen_upgraded",
            "trait.pov_seductive"
        ];

        foreach( s in skills )
        {
            local skill = this.getSkills().getSkillByID(s);

            if (skill != null)
            {
                mod += skill.getModifier();
            }
        }

        return mod;
    }

	q.getTryoutCost = @(__original) function()
	{
		local trymult =  1.0;
		local bros = this.World.getPlayerRoster().getAll();
		foreach(bro in bros)
		{
			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
				trymult *= 0.75; //tryout multiplier, change however u want
				//::TLW.Mod.Debug.printLog("Setting trymult: " + trymult);

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen_upgraded"))
				trymult *= 0.70; //tryout multiplier, change however u want
				//::TLW.Mod.Debug.printLog("Setting trymult: " + trymult);
		}

		//::TLW.Mod.Debug.printLog("Returning tryout cost: " + ::Math.round(__original() * trymult));
		return ::Math.round(__original() * trymult);
	}

	q.getHiringCost = @(__original) function()
	{
		local hiremult = 1.0;
		local bros = this.World.getPlayerRoster().getAll();
		foreach(bro in bros)
		{
			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
				hiremult *= 0.85;	//hire multiplier, change however u want
				//::TLW.Mod.Debug.printLog("Setting hiremult: " + hiremult);

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen_upgraded"))
				hiremult *= 0.80;	//hire multiplier, change however u want
				//::TLW.Mod.Debug.printLog("Setting hiremult: " + hiremult);
		}

		//::TLW.Mod.Debug.printLog("Returning hiring cost: " + ::Math.round(__original() * hiremult));
		return ::Math.round(__original() * hiremult);
	}

});