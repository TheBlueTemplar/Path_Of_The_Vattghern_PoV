this.pov_unhold_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_unhold_mutagen_upgraded";
		this.m.Name = "[color="+ ::Const.UI.Color.povMutationUpgrade + "]Reinforced Mutation: Rock Unhold[/color]";
		this.m.Icon = "skills/pov_troll_rock.png";
		this.m.IconMini = "";
		this.m.Overlay = "troll";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Superactive Cell Growth[/color]: This character\'s body has mutated to grow at an unnatural pace. The character has super vitality, while in battle, this causes their wounds to close and heal within mere moments.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Colossal Fury[/color]: The character's increased vigor allows them to channel it into more powerful attacks when healthy. If heavily damaged though, the effect is reversed. Additionally, they can make a powerful attack, scaling with their own vigor.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Normalized Appetite[/color]: Due to how this mutation has stabilized, the Vatt\'ghern no longer requires unusual amounts of food";
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gets the[color=" + this.Const.UI.Color.PositiveValue + "]\"Headbutt\"[/color] skill, dealing damage based on current HP"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]25[/color] hitpoints each turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] hitpoint bonus"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Does [color=" + this.Const.UI.Color.NegativeValue + "]less[/color] damage equal to [color=" + this.Const.UI.Color.NegativeValue + "]half[/color] of missing health %."
			}		
		];
		return ret;
	}


	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.pov_headbutt"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pov_headbutt_skill"));
		}
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

			// ADD UNHOLD MUTAGEN MISSING HP - LESS DMG EFFECT
			// Imagine this is a reverse Muscularity effect
			actor.getSkills().add(this.new("scripts/skills/effects/pov_missing_hp_dmg_effect"));
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();

		if (actor != null && !actor.isNull() && actor.isAlive())
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		// DEFINE HP HEALED
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, 25);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	function onUpdate(_properties)
	{
		// Buffs
		// Regen 25HP
		_properties.HitpointsMult *= 1.60;

		// Debuffs
		// Lower HP% = Less Dmg%
		//_properties.DailyFood += 0.5;
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function inBattleHiddenCheck()
	{
		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return false;
		}

		return true;
	}

});

