this.pov_distilled_alcohol_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.pov_distilled_alcohol";
		this.m.Name = "Distilled Alcohol";
		this.m.Description = "A bottle of highly distilled alcohol, completely purified of any contaminants, sealed for preservation, and sadly for the men, undrinkable. \n\n Demanding alchemical tasks usually require pure alcohol, and this bottle is just what many would be looking for. Can also fetch a decent price.";
		this.m.Icon = "misc/pov_inventory_distilled_alcohol.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting ;
		this.m.IsDroppedAsLoot = false;
		this.m.Value = 750;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
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

});

