// Legends enemy perk trees (z_perks_tree_enemy_traits.nut) have no descriptions because they are
// assumed not to be used in a background perk tree, so we have to add them for Forsaken dynamic
// perk trees not to crash.
if (!("Descriptions" in ::Const.Perks.AggressiveTree)) {
    ::Const.Perks.AggressiveTree.Descriptions <- [
        "is aggressive",
        "fights with reckless fury",
        "is relentlessly violent",
        "answers everything with force"
    ];
}
