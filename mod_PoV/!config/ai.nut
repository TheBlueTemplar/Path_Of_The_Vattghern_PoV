// Defining new entity actor ID
::Const.AI.Agent.ID.SwordGhost <- "agent.sword_ghost";
::Const.AI.Agent.ID.ArmorGhost <- "agent.armor_ghost";

// Adding new skillz
local count = ::Const.AI.Behavior.ID.COUNT;
::Const.AI.Behavior.ID.PovKnockBack <- count++;
::Const.AI.Behavior.ID.PovGruesomeFeast <- count++;
::Const.AI.Behavior.ID.COUNT = count;

::Const.AI.Behavior.Name.extend([
	"PovKnockBack",
	"PovGruesomeFeast",
]);

::Const.AI.Behavior.Order.PovKnockBack <- 32;
::Const.AI.Behavior.Order.PovGruesomeFeast <- 50;

::Const.AI.Behavior.Score.PovKnockBack <- 150;
::Const.AI.Behavior.Score.PovGruesomeFeast <- 500;