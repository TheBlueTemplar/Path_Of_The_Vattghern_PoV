this.pov_vattghern_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		// Mutations OP
		// Beat my meat solo
		this.character_background.create();
		this.m.ID = "background.pov_vattghern";
		this.m.Name = "Experienced Vatt\'ghern";
		this.m.Icon = "ui/backgrounds/pov_vattghern_background.png";
		this.m.BackgroundDescription = "An expert monster hunter, though what is considered a monster these days can be broad...";
		this.m.GoodEnding = "%name% has achieved something noone from their kind has easily done - mercenary or vattghern - and that is a peaceful retirement. Noone knows of their whereabouts, and noone really dares, or cares enough to look into it. What is sure, is that they have left a shining legacy behind in the %companyname%, and now are likely enjoying some great wine in a comfortable cottage, in a lush green field...";
		this.m.BadEnding = "Not much was known of %name% and what happened to them, other than to assume a fate most common. Last time anyone saw %name%, they were tracking an especially vicious beast, a \"bruxa\", which might have been their last...";
		this.m.HiringCost = 700;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
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
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			"trait.pov_fear_mutants",
			"trait.pov_nyctophobia"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Mutant",
			"the Wolf",
			"the Hound",
			"Silverwielder",
			"the BeastSlayer",
			"the Freak",
			"the Wise",
			"the Vatt\'ghern"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(3, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Combat;

		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.005, //plains
			0.025, //swamp
			0.005, //hills
			0.020, //forest
			0.020, //forest
			0.020, //forest_leaves
			0.020, //autumn_forest
			0.010, //mountains
			0.0, // ?
			0.00, //farmland
			0.010, // snow
			0.015, // badlands
			0.015, //highlands
			0.010, //stepps
			0.0, //ocean
			0.010, //desert
			0.0 //oasis
		];

		this.m.PerkTreeDynamic = {
			Weapon = [
				// Removed in 19.3
				// this.Const.Perks.TwoHandedTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.IntelligentTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree,
				this.Const.Perks.BeastTree,
				this.Const.Perks.OccultTree,
				this.Const.Perks.GreenskinTree,
				this.Const.Perks.UndeadTree
			],
			Class = [
				this.Const.Perks.LongswordClassTree,
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.HerbalistProfessionTree,
			],
			Magic = [
				this.Const.Perks.VattghernMagicTree
			]
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
		return "{Little is known of where the vattghern comes from. | %They% never speak of %their% origins, and few dare to ask. | Rumors surround %their% past, each more uncertain than the last. | Whatever life %they% lived before, it has long since been abandoned. | Even among witchers, %their% beginnings remain obscure.} {%Their% movements defy common training, sharp and unnervingly precise. | %They% react faster than thought, as if instinct has replaced hesitation. | There is something unnatural in the way %they% fight, beyond talent alone. | Steel seems to follow %their% will without conscious effort. | Watching %them% in combat feels like witnessing something engineered rather than taught.} {Such ability was not born - it was carved through relentless discipline. | %They% have subjected mind and body to trials few could survive. | Countless hours of training hardened %them% beyond exhaustion. | Pain, repetition, and focus shaped %them% into what %they% are now. | Every motion reflects years of refinement, not chance.} {%They% specialize in threats others refuse to name. | Creatures of curse, spirit, and nightmare fall to %their% blade. | %They% understand the unnatural, not as myth, but as prey. | From twisted beasts to metaphysical horrors, %they% know how to kill what should not exist. | Where superstition fails, %their% knowledge prevails.} {Even so, %their% limits remain untested. | There is a sense that %they% are far from finished. | Experience has tempered %them%, but not exhausted %their% growth. | What %they% have mastered so far may only be the foundation. | In time, %they% could become something even legends struggle to describe.}";
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
				13,
				16
			],
			Bravery = [
				8,
				13
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				12,
				14
			],
			RangedSkill = [
				7,
				11
			],
			MeleeDefense = [
				10,
				13
			],
			RangedDefense = [
				6,
				8
			],
			Initiative = [
				7,
				12
			]
		};
		return c;
	}

	// enables relationships
	// the only relationship that was enabled was between me and alcohol...for me to find out that this trait made wage = 0
	function onAdded() {
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		//::Legends.Traits.grant(this, ::Legends.Trait.LegendLWRelationship); // fu,trait

		// Add Vattghern Trait
		if (!actor.getSkills().hasSkill("trait.pov_witcher")) {
			actor.getSkills().add(this.new("scripts/skills/traits/pov_vattghern_trait"));
			actor.getFlags().increment("pov_ActiveMutations");
		}
	}

	function onSetAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 60) {
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 60) {
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment() {
		//---
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		this.getContainer().getActor().fillTalentValues(3, true);
		//---

		local items = this.getContainer().getActor().getItems();
		local r;

		// Equipment (Weapons, Shields)
		r = this.Math.rand(0, 2);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/oriental/polemace"));
		} else if (r == 2) {
			items.equip(this.new("scripts/items/weapons/bardiche"));
		}

		// Equipment (Armor, Helmets)
		local equipmentSets = [
			{
				armor = "vattghern_armor_01",
				helmet = "vattghern_helmet_01"
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

		//items.equip(this.Const.World.Common.pickArmor([[ 1, "vattghern_armor_01" ]]));
		//items.equip(this.Const.World.Common.pickHelmet([[ 1, "vattghern_helmet_01" ]]));
	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]."
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gets the [color=" + this.Const.UI.Color.povPerkBurgundy + "]Field Triage[/color] and the [color=" + this.Const.UI.Color.povPerkBurgundy + "]Potion Brewer[/color] perks."
		});
		return ret;
	}

	function onUpdate(_properties) {
		this.character_background.onUpdate(_properties);
		_properties.Threat += 5;
	}
});
