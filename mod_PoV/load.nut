/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Important objects for compatibility purposes (see how to call a few lines below)
::TLW.hasSSU <- ::mods_getRegisteredMod("mod_sellswords") != null;
::TLW.hasROTU <- ::mods_getRegisteredMod("mod_ROTUC") != null;
::TLW.hasMC <- ::mods_getRegisteredMod("mod_nggh_magic_concept") != null;
::TLW.hasFOTN <- ::mods_getRegisteredMod("mod_fury_of_the_northmen") != null;

// Load all files in High Prio Config Folder
::includeFiles(::IO.enumerateFiles("mod_PoV/!!config"));
// Load all files in Prio Config Folder
::includeFiles(::IO.enumerateFiles("mod_PoV/!config"));
// Load all files in Config Folder
::includeFiles(::IO.enumerateFiles("mod_PoV/config"));
// load register folder
::includeFiles(::IO.enumerateFiles("mod_PoV/register"));
// Load all files in Settings Folder
::includeFiles(::IO.enumerateFiles("mod_PoV/settings"));
// Load all files in Hooks Folder
::includeFiles(::IO.enumerateFiles("mod_PoV/hooks"));

// Load SSU shit, if exists
if (::TLW.hasSSU){::includeFiles(::IO.enumerateFiles("mod_PoV/hooks_SSU"));}
// Load ROTU shit, if exists
if (::TLW.hasROTU){::includeFiles(::IO.enumerateFiles("mod_PoV/hooks_ROTU"));}
// Load MC shit, if exists
if (::TLW.hasMC){::includeFiles(::IO.enumerateFiles("mod_PoV/hooks_MC"));}
// Load FOTN shit, if exists
if (::TLW.hasFOTN){::includeFiles(::IO.enumerateFiles("mod_PoV/hooks_FOTN"));}

// update the perk tooltips (done by legends)
//::Const.Perks.updatePerkGroupTooltips();

// update new armor sets
::Const.LegendMod.Armors <- {};
foreach( i, v in ::Const.LegendMod.ArmorObjs )
	::Const.LegendMod.Armors[v.ID] <- v;

// update new helmet sets
::Const.LegendMod.Helmets <- {};
foreach( i, v in ::Const.LegendMod.HelmObjs )
	::Const.LegendMod.Helmets[v.ID] <- v;

// update new outfit sets
::Const.LegendMod.Outfits <- {};
foreach (i, v in ::Const.LegendMod.OutfitObjs)
    ::Const.LegendMod.Outfits[v.ID] <- v;