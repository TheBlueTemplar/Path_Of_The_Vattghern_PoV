// Check contract_category in legends, !config

// Add my own, new category
//::Const.Contracts.Categories.Vattghern <- "Vatt\'ghern Contract"
::Const.Contracts.Categories.Vattghern <- "Vattghern"

// At each corresponding Settlement Tier, a settlement can have the configured maximum number of open contracts under the corresponding Category (Economic, Location etc)
::Const.Contracts.CategoryLimits.Vattghern <- [1,1,1]

// Add my contracts to existing legends system (can be Economy,Battle,Hunt,Legendary types)
//::Const.Contracts.ContractCategoryMap.destroy_geists_location_contract <- this.Const.Contracts.Categories.Battle;
::Const.Contracts.ContractCategoryMap.destroy_geists_location_contract <- this.Const.Contracts.Categories.Vattghern;

// Map the contract category icons that will be used in the settlement screen
::Const.Contracts.ContractCategoryIconMap.Vattghern <- "ui/icons/contract_type_vattghern"

// Direct Legends Copy, ty
// Use hooks to programmatically set each contract's Category to the configured value in ::Const.Contracts.ContractCategoryMap
// Note: The corresponding faction action scripts that spawn the contracts still need manual coding to input the relevant Category to the isReadyForContract() call
foreach (key, value in ::Const.Contracts.ContractCategoryMap)
{
	local script = "contracts/contracts/" + key;
	local cat = ::Const.Contracts.ContractCategoryMap[key];
	::mods_hookNewObject(script, function(o){
		o.m.Category = cat;
	});
}


