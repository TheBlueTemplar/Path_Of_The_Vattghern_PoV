this.pov_infused_shards_special_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.pov_infused_shards_special_item";
		this.m.Name = "[color="+ ::Const.UI.Color.povSpecialItem + "]Infused Shards[/color]";
		this.m.Description = "Shards splintered from the blade of a Swertgeist, each fragment still hrumming with the unique essence of its former master. They whisper faintly when held too long, as if longing to be made whole again.\n\n Though fragile in form, their cursed energy makes them a prized trophy for those daring enough to pry them from a wraith\'s fading weapon. Additionally, some creative individuals could find use for them... \n\n WIP ITEM, CANNOT CRAFT ANYTHING FROM IT NOW - SELL IT INSTEAD";
		this.m.Icon = "loot/pov_inventory_special_infused_shards.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 800;
	}

	function getTooltip()
	{
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
		return result;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * 1.5 * this.World.State.getCurrentTown().getBuyPriceMult() * this.World.State.getCurrentTown().getBeastPartsPriceMult()));
		}
		else
		{
			return this.Math.ceil(this.getValue());
		}
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseLootSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.World.State.getCurrentTown().getBeastPartsPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue());
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

