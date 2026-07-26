::TLW.HooksMod.hook("scripts/entity/tactical/actor", function (q) {
	// THERE IS ANOTHER TREE HOOK BELOW!

	// Custom Srprite Layers Addition
	q.onInit = @(__original) function () {
		// Original below and must stay there
		// Add a new Sprite Layer
		local self = this;
		local old_addSprite = self.addSprite;
		self.addSprite = function (_layerID) {
			/*
			if (_layerID == "socket")
			{
				old_addSprite("pov_random_Bullshit");
			}
			return old_addSprite(_layerID);
			*/

			// puts shit over these layers
			// if you want to put shit below layers, do the same above without the ret (see commented out example)
			// The lower additions are added on top of the previous ones
			local ret = old_addSprite(_layerID);

			if (_layerID == "socket") {
				old_addSprite("pov_back_socket"); // Reserved for mutant effect
				old_addSprite("pov_back_socket2");
				old_addSprite("pov_bust_replacement"); // for replacing base busts
				old_addSprite("pov_bust"); // for on-top effects like mutant, vattghern etc.
			}

			if (_layerID == "head") {
				old_addSprite("pov_head_effect");
				//old_addSprite("pov_front_socket");
			}

			//status_rooted (front part, used for Front effects)
			if (_layerID == "status_rooted") {
				old_addSprite("pov_front_socket");
			}

			/*if (_layerID == "bust")
			{
				old_addSprite("pov_bust");
			}*/

			return ret;
			//return old_addSprite(_layerID);
		};
		__original();
		//self.addSprite = old_addSprite;

		// If in battle, add special effects ("special skill" - for all entities)
		// This is FOR ENEMY! See player.nut hook for player!
		if (::World.State.getPlayer() != null && this.Tactical.isActive()) {
			// Balance / Overhaul change. Dont apply when loaded with some mods
			if (!::TLW.hasFOTN) {
				this.getSkills().add(this.new("scripts/skills/special/pov_armor_changes_special"));
			}

			// Rain kinda rework
			this.getSkills().add(this.new("scripts/skills/special/pov_rain_special"));

			// PoV Extra Scaling (optional)
			if (::TLW.EnemyScaling && this.getFaction() != this.Const.Faction.Player) {
				this.m.Skills.add(this.new("scripts/skills/special/pov_scaling_special"));
			}

		}

	}

	// Add some of my own sprite layers, so they dont appear in party screen, turn order images etc.
	q.getImagePath = @(__original) function () {
		if (!this.isPlacedOnMap() || this.isDiscovered()) {
			local result = "tacticalentity(" + this.m.ContentID + "," + this.getID();
			if (this.hasSprite("pov_bust_replacement")) {
				result += ",pov_bust_replacement";
			}
			if (this.hasSprite("socket")) {
				result += ",socket";
			}
			result += ",miniboss,arrow)";
			return result;
		} else {
			return "ui/images/undiscovered_opponent.png";
		}
	}

	// If SSU Tweaks enabled, remove their Armor Encumburance Effect
	// Done in onAfterInit rather than onInit because removeByID calls
	// update() which calls onUpdateInjuryLayer(), and that requires
	// sprites (e.g. "body") that child classes add after actor.onInit()
	q.onAfterInit = @(__original) function () {

		__original();

		if (::TLW.hasSSU && ::TLW.SSUTweaks) {
			if (this.getSkills().hasSkill("effects.ptr_armor_fatigue_recovery")) {
				this.getSkills().removeByID("effects.ptr_armor_fatigue_recovery");
			}
		}

		// Replace various busts with shit I like more
		/*if (this.getSprite("socket").getBrush().Name == "bust_base_beasts")
		{
			this.getSprite("pov_bust_replacement").setBrush("pov_bust_base_beasts")
		}*/

		if (this.hasSprite("socket")
			&& this.hasSprite("pov_bust_replacement")
			&& this.getSprite("socket").HasBrush)
		{
			local socket = this.getSprite("socket");
			local replacement = this.getSprite("pov_bust_replacement");
			local brush = socket.getBrush().Name;

			switch (brush) {
				case "bust_base_assassin":
					replacement.setBrush("pov_bust_base_assassin");
					break;

				case "bust_base_bandits":
					replacement.setBrush("pov_bust_base_bandits");
					break;

				case "bust_base_player":
					replacement.setBrush("pov_bust_base_player");
					break;

				case "bust_base_beasts":
					replacement.setBrush("pov_bust_base_beasts");
					break;

				case "bust_base_beasthunters":
					replacement.setBrush("pov_bust_base_beasthunters");
					break;

				case "bust_base_caravan":
					replacement.setBrush("pov_bust_base_caravan");
					break;

				case "bust_base_crusader":
					replacement.setBrush("pov_bust_base_crusader");
					break;

				case "bust_base_military":
					replacement.setBrush("pov_bust_base_military");
					break;

				case "bust_base_militia":
					replacement.setBrush("pov_bust_base_militia");
					break;

				case "bust_base_nomads":
					replacement.setBrush("pov_bust_base_nomads");
					break;

				case "bust_base_southern":
					replacement.setBrush("pov_bust_base_southern");
					break;

				case "bust_base_troupe":
					replacement.setBrush("pov_bust_base_troupe");
					break;

				case "bust_base_undead":
					replacement.setBrush("pov_bust_base_undead");
					break;

				case "bust_base_wildmen_01":
					replacement.setBrush("pov_bust_base_wildmen_01");
					break;

				case "bust_base_orcs":
					replacement.setBrush("pov_bust_base_orcs");
					break;

				case "bust_base_goblins":
					replacement.setBrush("pov_bust_base_goblins");
					break;
			}
		}

	}

	// Dying while the entity is still moving crashes the game, so we delay it until
	// tactical_state can handle it.
	q.kill = @(__original) function (_killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false) {
		if (this.isAlive()
			&& ("State" in ::Tactical)
			&& ::Tactical.State != null
			&& ::Tactical.getNavigator().isTravelling(this))
		{
			this.m.IsDying = true;
			::Tactical.State.addPendingDeath(this, _killer, _skill, _fatalityType, _silent);
			return;
		}

		__original(_killer, _skill, _fatalityType, _silent);
	}

	q.onDeath = @(__original) function (_killer, _skill, _tile, _fatalityType) {
		// First mutant killed flag
		if (this.getFlags().has("mutant") && !::World.Flags.has("FirstMutantKilledEvent")) {
			::World.Flags.add("FirstMutantKilledEvent");
		}

		// Remove New Sprite Layers on entity death
		if (this.hasSprite("pov_back_socket")) {
			this.getSprite("pov_back_socket").Visible = false;
		}

		if (this.hasSprite("pov_back_socket2")) {
			this.getSprite("pov_back_socket2").Visible = false;
		}

		if (this.hasSprite("pov_head_effect")) {
			this.getSprite("pov_head_effect").Visible = false;
		}

		if (this.hasSprite("pov_front_socket")) {
			this.getSprite("pov_front_socket").Visible = false;
		}

		if (this.hasSprite("pov_bust_replacement")) {
			this.getSprite("pov_bust_replacement").Visible = false;
		}

		__original(_killer, _skill, _tile, _fatalityType);
	}

	// Custom Animations
	q.onRender = @(__original) function () {
		__original();

		// Enemy Mutant Effect Animation
		local mutantEffect = this.getSkills().getSkillByID("effects.pov_enemy_mutation_effect");
		if (mutantEffect != null) {
			mutantEffect.triggerRender();
		}
		// Rot Mutation Effect Animation
		local rotEffect = this.getSkills().getSkillByID("effects.pov_enemy_mutation_rot");
		if (rotEffect != null) {
			rotEffect.triggerRender();
		}
		// Stench Effect Animation (Same as above - for specific enemies and player)
		local rotEffect = this.getSkills().getSkillByID("effects.pov_unbearable_stench_passive");
		if (rotEffect != null) {
			rotEffect.triggerRender();
		}
	}
});
