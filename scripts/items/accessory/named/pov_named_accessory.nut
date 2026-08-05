this.pov_named_accessory <- ::inherit("scripts/items/accessory/accessory", {
	// Full credits go to necro and MC
	m = {
		PrefixList = [],
		SuffixList = [],
		NameList = [],
		DefaultName = "",
		UseRandomName = false, // i dont wanna hehe

		SpecialValue = 0,
		DamageMult = 1.0,
		ArmorDamageMult = 1.0,
		ExperienceMult = 1.0,
		HeadDamageMult = 1.0,
		Initiative = 0,
		Bravery = 0,
		HeadChance = 0,
		Luck = 0,
		Threat = 0
	},

	function create() {
		this.accessory.create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Named;
		this.m.IsPrecious = true;
		this.randomizeValues();
	}

	function getTooltip() {
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null) {
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		} else {
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		if (this.m.DamageMult > 1.0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + (::Math.floor(this.m.DamageMult * 100) - 100) + "%[/color] Damage to Hitpoints"
			});
		}

		if (this.m.ArmorDamageMult > 1.0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + (::Math.floor(this.m.ArmorDamageMult * 100) - 100) + "%[/color] Damage to Armor"
			});
		}

		if (this.m.Initiative != 0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Initiative + "[/color] Initiative"
			});
		}

		if (this.m.Bravery != 0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Bravery + "[/color] Resolve"
			});
		}

		if (this.m.Luck != 0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/pov_luck.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Luck + "%[/color] Chance to have any attacker require two successful attack rolls in order to hit"
			});
		}

		if (this.m.Threat != 0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.Threat + "[/color]."
			});
		}

		if (this.m.HeadChance != 0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Gain [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.HeadChance + "%[/color] chance to hit the head"
			});
		}

		if (this.m.ExperienceMult > 1.0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "XP Gain increased by [color=" + ::Const.UI.Color.PositiveValue + "]+" + (::Math.floor(this.m.ExperienceMult * 100) - 100) + "%[/color]"
			});
		}

		if (this.m.HeadDamageMult > 1.0) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Deal [color=" + ::Const.UI.Color.PositiveValue + "]+" + (::Math.floor(this.m.HeadDamageMult * 100) - 100) + "%[/color] more damage when hitting the head"
			});
		}

		return result;
	}

	// currently unused, left if I WANT to use it lol hehe xd
	function getRandomCharacterName(_list) {
		local vars = [
			[
				"randomname",
				::MSU.Array.rand(::Const.Strings.CharacterNames)
			],
			[
				"randomsouthernname",
				::MSU.Array.rand(::Const.Strings.SouthernNames)
			],
			[
				"randomtown",
				::MSU.Array.rand(::Const.World.LocationNames.VillageWestern)
			]
		];
		return this.buildTextFromTemplate(::MSU.Array.rand(_list), vars);
	}

	function createRandomName() {
		if (!this.m.UseRandomName || ::Math.rand(1, 100) <= 60) {
			if (this.m.SuffixList.len() == 0 || ::Math.rand(1, 100) <= 60) {
				return ::MSU.Array.rand(this.m.PrefixList) + " " + ::MSU.Array.rand(this.m.NameList);
			} else {
				return ::MSU.Array.rand(this.m.NameList) + " " + ::MSU.Array.rand(this.m.SuffixList);
			}
		} else if (::Math.rand(1, 2) == 1) {
			return this.getRandomCharacterName(::Const.Strings.KnightNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);
		} else {
			return this.getRandomCharacterName(::Const.Strings.BanditLeaderNames) + "\'s " + ::MSU.Array.rand(this.m.NameList);
		}
	}

	function onEquip() {
		this.accessory.onEquip();

		if (this.m.Name.len() == 0) {
			if (::Math.rand(1, 100) <= 30) {
				// set champs name hehe
				this.setName(this.getContainer().getActor().getName());
			} else {
				this.m.DefaultName = "";
				this.setName(this.createRandomName());
			}
		}
	}

	function onAddedToStash(_stashID) {
		if (this.m.Name.len() == 0) {
			this.m.DefaultName = "";
			this.setName(this.createRandomName());
		}
	}

	function setName(_name) {
		if (this.m.DefaultName.len() != 0) {
			this.m.Name = _name + "\'s " + this.m.DefaultName;
			return;
		}

		this.m.Name = _name;
	}

	function randomizeValues() {
		this.m.SpecialValue = ::Math.round(this.m.SpecialValue * ::Math.rand(100, 150) * 0.01);

		local available = [];

		if (this.m.StaminaModifier <= -1) {
			available.push(function (_i) {
				_i.m.StaminaModifier = ::Math.min(0, _i.m.StaminaModifier + ::Math.rand(0, 3));
			});
		}

		if (this.m.DamageMult > 1.0) {
			available.push(function (_i) {
				_i.m.DamageMult = 1.0 + ::Math.round((_i.m.DamageMult - 1.0) * ::Math.rand(120, 200)) * 0.01;
			});
		}

		if (this.m.ArmorDamageMult > 1.0) {
			available.push(function (_i) {
				_i.m.ArmorDamageMult = 1.0 + ::Math.round((_i.m.ArmorDamageMult - 1.0) * ::Math.rand(120, 200)) * 0.01;
			});
		}

		if (this.m.Initiative > 0) {
			available.push(function (_i) {
				_i.m.Initiative = ::Math.round(_i.m.Initiative * ::Math.rand(100, 150) * 0.01);
			});
		}

		if (this.m.Bravery > 0) {
			available.push(function (_i) {
				_i.m.Bravery = ::Math.round(_i.m.Bravery * ::Math.rand(120, 160) * 0.01);
			});
		}

		if (this.m.Luck > 0) {
			available.push(function (_i) {
				_i.m.Luck = ::Math.round(_i.m.Luck * ::Math.rand(110, 140) * 0.01);
			});
		}

		if (this.m.Threat > 0) {
			available.push(function (_i) {
				_i.m.Threat = ::Math.round(_i.m.Threat * ::Math.rand(120, 160) * 0.01);
			});
		}

		if (this.m.HeadChance > 0) {
			available.push(function (_i) {
				_i.m.HeadChance = ::Math.round(_i.m.HeadChance * ::Math.rand(115, 150) * 0.01);
			});
		}

		if (this.m.ExperienceMult > 1.0) {
			available.push(function (_i) {
				_i.m.ExperienceMult = 1.0 + ::Math.round((_i.m.ExperienceMult - 1.0) * ::Math.rand(120, 180)) * 0.01;
			});
		}

		if (this.m.HeadDamageMult > 1.0) {
			available.push(function (_i) {
				_i.m.HeadDamageMult = 1.0 + ::Math.round((_i.m.HeadDamageMult - 1.0) * ::Math.rand(110, 150)) * 0.01;
			});
		}

		local total = this.m.SpecialValue != 0 ? 1 : 2;
		for (local n = total; n != 0 && available.len() != 0; --n) {
			local r = ::Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}

	function onUpdateProperties(_properties) {
		this.accessory.onUpdateProperties(_properties);
		_properties.DamageRegularMult *= this.m.DamageMult;
		_properties.DamageArmorMult *= this.m.ArmorDamageMult;
		_properties.Initiative += this.m.Initiative;
		_properties.Bravery += this.m.Bravery;
		_properties.XPGainMult *= this.m.ExperienceMult;
		_properties.RerollDefenseChance += this.m.Luck;
		_properties.HitChance[this.Const.BodyPart.Head] += this.m.HeadChance;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] *= this.m.HeadDamageMult;
		_properties.Threat += this.m.Threat;
	}

	function onSerialize(_out) {
		_out.writeString(this.m.Name);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeI16(this.m.SpecialValue);
		_out.writeF32(this.m.DamageMult);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeI16(this.m.Initiative);
		_out.writeI16(this.m.Bravery);
		_out.writeI16(this.m.Luck);
		_out.writeI16(this.m.Threat);
		_out.writeI16(this.m.HeadChance);
		_out.writeF32(this.m.ExperienceMult);
		_out.writeF32(this.m.HeadDamageMult);
		this.accessory.onSerialize(_out);
	}

	function onDeserialize(_in) {
		this.m.Name = _in.readString();
		this.m.StaminaModifier = _in.readI8();
		this.m.SpecialValue = _in.readI16();
		this.m.DamageMult = _in.readF32();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.Initiative = _in.readI16();
		this.m.Bravery = _in.readI16();
		this.m.Luck = _in.readI16();
		this.m.Threat = _in.readI16();
		this.m.HeadChance = _in.readI16();
		this.m.ExperienceMult = _in.readF32();
		this.m.HeadDamageMult = _in.readF32();
		this.accessory.onDeserialize(_in);
	}

});
