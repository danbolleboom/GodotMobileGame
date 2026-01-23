extends Node

@export var choices: int = 3;
@export var upgradeButton: PackedScene;

func LoadUpgrades() -> void:
	var upgrades = Constants.LoadScenesInFile("res://Scenes/AttackModifiers/");
	var usableUpgrades: Array[PackedScene];
	for mod in upgrades:
		var instance = mod.instantiate();
		print(instance.id);
		usableUpgrades.append(mod);
	
	
