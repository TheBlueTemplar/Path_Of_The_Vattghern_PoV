/////////////////////////////////////////////////////////////////////
// 					  Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Credits

// "TLW" left in honor of the OG mod, and my inspiration
// Abyss, JM and their wonderful ideas, and for being absolute bros and getting me into modding 
// Chopeks, Son of Satan, Celestial and Breaky for being patient with and helping me
// Pot and Excalibird for their contribution
// All of the lovely playtesters, and the contributors to PoV!
// Legends and the broader modding community for all their tools, documentation and support

// Included Mods

// Silver Weapons is included and tweaked in PoV, credits to Excalibird
// Pain from injuries is included, tweaked and rewritten in PoV, creadits to Darxo

::TLW <- {
	ID = "mod_PoV",
	Name = "Path of the Vatt\'ghern", //PoV
	Version = "1.0.0",
	//EnableEnemyMutation = true,	//default settings
	EnemyMutationScaling = true,
	ChaosMode = false,
	McTweaks = false,
	FotnTweaks = false,
	SSUTweaks = false,
	EnableMainMenuArt = true,
	EnablePovIntroEvent = true
};

::TLW.HooksMod <- ::Hooks.register(::TLW.ID, ::TLW.Version, ::TLW.Name);
::TLW.HooksMod.require("mod_legends >= 19.1.42", "mod_modern_hooks >= 0.4.0", "mod_msu >= 1.2.7");
::TLW.HooksMod.conflictWith("mod_silver_weapons", "mod_PFI", "mod_TLW", "mod_weapons_updated", "mod_weapons", "mod_reforged"); 

::TLW.HooksMod.queue(">mod_legends", ">mod_msu", ">mod_nggh_magic_concept", ">mod_sellswords", ">mod_ROTUC", function() 
{
	// Register with MSU so people know to update (Public Branch)
	::TLW.Mod <- ::MSU.Class.Mod(::TLW.ID, ::TLW.Version, ::TLW.Name);
	::TLW.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/TheBlueTemplar/Path_Of_The_Vattghern_PoV");
	::TLW.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	// load mod files 
    ::include("mod_PoV/load.nut");
    // load mod settings 
    ::include("mod_PoV/settingsLoad.nut");
});

::TLW.HooksMod.queue(">mod_legends", ">mod_msu", ">mod_nggh_magic_concept", ">mod_sellswords", ">mod_ROTUC", function() {
    // Load all files in afterHooks Folder
	::includeFiles(::IO.enumerateFiles("mod_PoV/afterHooks"));
}, ::Hooks.QueueBucket.AfterHooks);




