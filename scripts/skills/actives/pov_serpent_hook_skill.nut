this.pov_serpent_hook_skill <- this.inherit("scripts/skills/skill", {
	m = {
		DestinationTile = null,
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_serpent_hook";
		this.m.Name = "Serpentine Hook";
		this.m.Description = "With the great nimbleness that this character possesses, they are able to very quickly pull a nearby enemy, or even an ally, towards them. Staggers enemies. \n\n Useful to surround an enemy, or save an ally from a bad situation. Has a 2 turn cooldown.";
		this.m.Icon = "skills/pov_active_serpent_hook.png";
		this.m.IconDisabled = "skills/pov_active_serpent_hook_sw.png";
		this.m.Overlay = "pov_active_serpent_hook";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/snake_snare_01.wav",
			"sounds/enemies/dlc6/snake_snare_02.wav",
			"sounds/enemies/dlc6/snake_snare_03.wav"
		];
		this.m.Delay = 1000;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.m.Cooldown >= 1)
		{
			ret.push(
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/warning.png",
					text = "Skill is on cooldown. Turns remaining: [color=" + this.Const.UI.Color.NegativeValue + "]"+this.m.Cooldown+"[/color]"
				}
			);
		}

		return ret;
	}

	function setDestinationTile( _t )
	{
		this.m.DestinationTile = _t;
	}

	function onCombatStarted()
	{
		this.m.Cooldown = 0;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		if (this.m.Cooldown <= 0){
			return true;
		}else{
			return false;
		}

		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		return this.getPulledToTile(_userTile, _targetTile);
	}

	function getPulledToTile( _userTile, _targetTile )
	{
		local tiles = this.getPulledToTiles(_userTile, _targetTile);

		if (tiles.len() != 0)
		{
			return tiles[0];
		}
		else
		{
			return null;
		}
	}

	function getPulledToTiles( _userTile, _targetTile )
	{
		local tiles = [];

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_userTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _userTile.getNextTile(i);

				if (tile.Level <= _userTile.Level && tile.IsEmpty && tile.getDistanceTo(_targetTile) <= 2)
				{
					tiles.push(tile);
				}
			}
		}

		return tiles;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted || _targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		local pulledTo = this.getPulledToTile(_originTile, _targetTile);

		if (pulledTo == null)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		local target = _targetTile.getEntity();
		local pullToTile;

		if (this.m.DestinationTile != null)
		{
			pullToTile = this.m.DestinationTile;
			this.m.DestinationTile = null;
		}
		else
		{
			pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);
		}

		if (pullToTile == null)
		{
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " drags in " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()));
		}

		if (!_user.isHiddenToPlayer() || !target.isHiddenToPlayer())
		{
			//local variant = _user.m.Variant;
			local scaleBackup = target.getSprite("status_rooted").Scale;
			//_user.fadeOut(50);
			local rooted_front = target.getSprite("status_rooted");
			rooted_front.Scale = 1.0;
			rooted_front.setBrush("snake_ensnare_front_01");
			rooted_front.Visible = true;
			rooted_front.Alpha = 0;
			rooted_front.fadeIn(50);
			local rooted_back = target.getSprite("status_rooted_back");
			rooted_back.Scale = 1.0;
			rooted_back.setBrush("snake_ensnare_back_01");
			rooted_back.Visible = true;
			rooted_back.Alpha = 0;
			rooted_back.fadeIn(50);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 900, this.onDone, {
				User = _user,
				Target = target,
				ScaleBackup = scaleBackup,
				Skill = this
			});
		}

		local skills = _targetTile.getEntity().getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(pullToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, null, null, true);
		}
		else
		{
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onPulledDown, tag, true);
		}

		local stagger = this.new("scripts/skills/effects/staggered_effect");
		if (!_user.isAlliedWith(target))	
		{
			target.getSkills().add(stagger);
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(target)));
		}

		return true;
	}

	function onPulledDown( _entity, _tag )
	{
		_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
	}

	function onDone( _data )
	{
		//_data.User.fadeIn(50);
		local rooted_front = _data.Target.getSprite("status_rooted");
		rooted_front.fadeOutAndHide(50);
		rooted_front.Scale = _data.ScaleBackup;
		local rooted_back = _data.Target.getSprite("status_rooted_back");
		rooted_back.fadeOutAndHide(50);
		rooted_back.Scale = _data.ScaleBackup;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, _data.Skill.onAfterDone, _data);
	}

	function onAfterDone( _data )
	{
		_data.Target.setDirty(true);
	}

});

