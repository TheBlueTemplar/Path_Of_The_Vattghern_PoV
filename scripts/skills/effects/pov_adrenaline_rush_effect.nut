this.pov_adrenaline_rush_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_adrenaline_rush";
		this.m.Name = "Adrenaline Rush";
		this.m.Description = "The Vatt\'ghern\'s unhold mutation restricts their damage output, if their hp is lower than maximum.";
		this.m.Icon = "skills/pov_direwolf.png";
		this.m.IconMini = "pov_mini_direwolf";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The Vatt\'ghern\'s beast mutation affects their damage potential. As they lose HP, adrenaline rush kicks in and gives them a [color=" + this.Const.UI.Color.PositiveValue + "]damage bonus %[/color] the lower HP they have, capping at 25% bonus damage on 1% hp.";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}

		];

		local dmgMod = getHpDmgMod();

		if (dmgMod >= 1.0)
		{
			dmgMod = this.Math.floor((dmgMod * 100) - 100);
			ret.push({
			    id = 11,
			    type = "text",
			    icon = "ui/icons/health.png",
			    text = "Deals [color=" + this.Const.UI.Color.PositiveValue + "]"+dmgMod+"[/color]% more damage and initiative due to missing health."
			});
		} else 
		{
			ret.push({
			    id = 11,
			    type = "text",
			    icon = "ui/icons/health.png",
			    text = "No current bonus damage. Not low enough HP"
			});
		}

		return ret;
	}

	function getHpDmgMod()
	{
	    local actor = this.getContainer().getActor();
	    // Actor's current hp %, value is from 0.00 - 1.00, so multiply by 100 to get %
	    local currentHpPercent = actor.getHitpointsPct() * 100;

	    if (currentHpPercent < 75)
	    {
	        // 75% → 1% HP: 1.00 → 1.25 (linear), clamped with Math.min
	        // (75 - 1) = 74
	        local scale = 1.0 + 0.25 * ((75.0 - currentHpPercent) / 75.0);
	        return this.Math.minf(1.25, scale);
	    	//return 1.25;
	    }
	    else
	    {
	        // ≥75% HP: no bonus
	        return 1.0;
	    }
	}

	function onUpdate(_properties)
	{
		_properties.InitiativeMult *= getHpDmgMod();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		local isValidRanged = item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && (item.isWeaponType(this.Const.Items.WeaponType.Throwing) || item.isWeaponType(this.Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(this.Const.Items.ItemType.Weapon)))
		{
			_properties.DamageTotalMult *= getHpDmgMod();
		}
	}

});
