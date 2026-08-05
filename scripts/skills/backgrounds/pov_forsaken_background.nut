this.pov_forsaken_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		MutationAdded = false
	},

	function create() {
		// yolo
		this.character_background.create();
		this.m.ID = "background.pov_forsaken";
		this.m.Name = "Forsaken";
		this.m.Icon = "ui/backgrounds/pov_forsaken_background.png";
		this.m.BackgroundDescription = "Almost crazed by mutations, this one is an excellent warrior, if not a bit unhinged.";
		this.m.GoodEnding = "Given purpose and structure within %companyname%, %name% learns to wield %their% mutations with discipline rather than fear. Surrounded by those who judge %them% by action instead of appearance, the burden of instability slowly lessens. In time, %name% becomes not only a reliable mercenary, but proof that even a cursed origin can lead to something earned, steady, and whole. Heck, %they% only refer to %their% mutations as blessings now...";
		this.m.BadEnding = "Without restraint or understanding, %name% pushes %their% mutations beyond what body and mind can bear. What once made %them% valuable to %companyname% becomes unpredictable and dangerous. Eventually, control gives way to collapse—whether through exile, betrayal, or self-destruction—and %name% is remembered not as a mercenary who endured, but as a warning of power left unchecked - a \"forsaken\" -";
		this.m.HiringCost = 400;
		this.m.DailyCost = 40;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			// Removed in 19.3
			// ::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			"trait.pov_fear_mutants",
			"trait.pov_hate_mutants",
			"trait.pov_nyctophobia"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Mad",
			"the Forsaken",
			"the Unnatural",
			"the Beast",
			"the Freak",
			"the Godsforsaken"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn;

		//this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		//this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		//this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		//this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		//this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.005, //plains
			0.020, //swamp
			0.000, //hills
			0.010, //forest
			0.010, //forest
			0.010, //forest_leaves
			0.010, //autumn_forest
			0.005, //mountains
			0.0, // ?
			0.000, //farmland
			0.005, // snow
			0.005, // badlands
			0.005, //highlands
			0.000, //stepps
			0.0, //ocean
			0.005, //desert
			0.0 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				// Removed in 19.3
				// this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.FistsTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.AggressiveTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree
			],
			Class = [], // maybe add "mutant" class, with bonuses here and there?
			Magic = []
		}

		local r = this.Math.rand(1, 3);
		if (r == 1) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.RaiderClassTree,
			]);
		} else if (r == 2) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.ClubClassTree,
			]);
		} else if (r == 3) {
			this.m.PerkTreeDynamic.Class.extend([
				::Const.Perks.WoodaxeClassTree,
			]);
		}
	}

	//Default Male
	function setGender(_gender = -1) {
		if (_gender == -1) {
			_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled"
				? 0
				: ::Math.rand(0, 1);
		}

		if (_gender != 1) {
			return;
		}
		//this.m.Ethnicity = this.Math.rand(0, 2);
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription() {
		return "{Once a simple farmer, %name% learned early how to endure hardship. | Raised among steel and soot, %name% spent years as a blacksmith\'s apprentice. | Born into a family of warriors, %name% was trained in battle before learning mercy. | %name% once lived a quiet life as a hunter, tracking beasts rather than people. | %name% grew up in the shadows of the city, surviving through wit and labor.} {When %their% mutations became impossible to hide, staying was no longer an option. | Fear and whispers followed %name%, until leaving became the only choice. | Once the change revealed itself, %name% was driven away from everything familiar. | %Their% presence unsettled others, and the place %they% called home slowly turned hostile.} { %Their% mutations granted strength beyond the ordinary, and conflict soon followed. | What set %name% apart also made %them% dangerous, drawing %them% into battle. | Survival demanded that %they% learn to fight, and fight well. | Through skirmishes and desperate encounters, %name% refined %their% unnatural abilities.} {For all %their% power, the mutations weighs heavily on %them%. | %They% wields strength at the cost of pain, strain, or control. | Each use of %their% abilities leaves marks unseen by others. | %Name% endures constant tension, as if something inside resists being contained. | It is clear that this power is as much a curse as it is a weapon.} {Now, %they% have lost most of %their% humanity, having become a maddened, dangerous weapon of war.}";
	}

	function onChangeAttributes() {
		/* Base values are:
		Hp 		50 - 60
		Res 	30 - 40
		Fat 	90 - 100
		Msk 	47 - 57
		Rsk 	32 - 42
		Mdf 	0  - 5
		Rdf 	0  - 5
		Ini 	100 - 110
		Values below are additions/substractions
		*/
		local c = {
			Hitpoints = [
				14,
				18
			],
			Bravery = [
				3,
				6
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				10,
				14
			],
			RangedSkill = [
				1,
				3
			],
			MeleeDefense = [
				7,
				10
			],
			RangedDefense = [
				2,
				4
			],
			Initiative = [
				-8,
				-2
			]
		};
		return c;
	}

	function onAdded() {
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		// for possible combat interactions
		if (!actor.getFlags().has("mutant")) {
			actor.getFlags().add("mutant");
		}
		// for player mechanics interactions (eg.mutagens)
		if (!actor.getFlags().has("playerMutant")) {
			actor.getFlags().add("playerMutant");
		}
		// for forsaken limit bonuses
		if (!actor.getFlags().has("playerMutantPlus")) {
			actor.getFlags().add("playerMutantPlus");
		}

		// Add Mutant Trait
		if (!actor.getSkills().hasSkill("trait.pov_unstable_mutant")) {
			actor.getSkills().add(this.new("scripts/skills/traits/pov_unstable_mutant_trait"));
		}

		// Add Mad Trait
		actor.getSkills().add(this.new("scripts/skills/traits/mad_trait"));

		// Add Random Mutation (Weak Version)
		if (this.m.MutationAdded == false) {
			local possibleMutations = ::TLW.PlayerMutationsWeak;
			local randomMutation = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)];
			actor.getSkills().add(this.new(randomMutation));
			actor.getFlags().increment("pov_ActiveMutations");
			this.m.MutationAdded = true;
		}

		// Sound change, slightly lower pitch, varied
		actor.m.SoundPitch = this.Math.rand(75, 85) * 0.01;
	}

	function onSetAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		local head = actor.getSprite("head");

		// Scar 'em up hehe
		if (this.Math.rand(1, 100) <= 75) {
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75) {
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
		// Mutant body hue recolor....PUKESKIN
		// Color options: #a8c470 - Light Effect || #a1bf63 - kinda orky || #b4c754 - in between
		body.Color = this.createColor("#a1bf63");
		body.varyColor(0.07, 0.07, 0.07);
		body.varySaturation(0.05);
		head.Color = this.createColor("#a1bf63");
		head.varyColor(0.07, 0.07, 0.07);
		head.varySaturation(0.05);
		// Adds the mutant effect, same as enemy mutants
		::TLW.MutantEffect.addForsakenEffect(actor);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();
		local r;

		// Equipment (Weapons, Shields)
		// 20% xbow, 20% thrown. 60% melee, with 50% chance for shield (same for thrown)
		// Also gets a knife at bag
		r = this.Math.rand(0, 4);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/two_handed_flail"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/two_handed_mace"));
		} else if (r == 2) {
			items.equip(this.new("scripts/items/weapons/legend_two_handed_club"));
		} else if (r == 3) {
			items.equip(this.new("scripts/items/weapons/warbrand"));
		} else if (r == 4) {
			items.equip(this.new("scripts/items/weapons/billhook"));
		} else if (r == 5) {
			items.equip(this.new("scripts/items/weapons/longaxe"));
		} else if (r == 6) {
			items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		}

		items.addToBag(this.new("scripts/items/weapons/knife"));

		// Equipment (Armor, Helmets)
		local equipmentSets = [
			{
				armor = "forsaken_armor",
				helmet = "forsaken_helmet"
			}
		];

		local r = this.Math.rand(0, equipmentSets.len() - 1);
		local selectedSet = equipmentSets[r];
		items.equip(this.Const.World.Common.pickArmor([
			[1, selectedSet.armor]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, selectedSet.helmet]
		]));

	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]."
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = "Starts with a random [color=" + this.Const.UI.Color.povPerkPurple + "]Mutation[/color]. Such mutations are similar to - but weaker - than Vatt\'ghern ones."
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = "Gets the [color=" + this.Const.UI.Color.povPerkPurple + "]Unstable Mutant[/color] trait, granting access to more mutations.."
		});
		return ret;
	}

	function onUpdate(_properties) {
		this.character_background.onUpdate(_properties);
		_properties.Threat += 10;
	}

	function onSerialize(_out) {
		this.character_background.onSerialize(_out);
		_out.writeBool(this.m.MutationAdded);
	}

	function onDeserialize(_in) {
		this.character_background.onDeserialize(_in);
		this.m.MutationAdded = _in.readBool();
	}
});
