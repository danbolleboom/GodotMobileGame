extends Node

@export var choices: int = 3;
@export var upgradeButton: PackedScene;

@onready var buttonContainer: VBoxContainer = $VBoxContainer

func LoadUpgrades() -> void:
	for child in buttonContainer.get_children():
		child.queue_free();
	
	var upgrades = Constants.LoadScenesInFile("res://Scenes/AttackModifiers/");
	var usableUpgrades: Array[Node];
	for mod in upgrades:
		var instance = mod.instantiate();
		print(instance.id);
		
		var description: String = "";
		
		for child in instance.get_children():
			description += "- " + child.GetDescription() + "\n";
		
		print(description)
		usableUpgrades.append(instance);
	
	var shownUpgrades: Array[Node];
	
	for i in choices:
		var index = randi_range(0, usableUpgrades.size() - 1);
		var upgrade = usableUpgrades[index];
		shownUpgrades.append(upgrade);
		usableUpgrades.remove_at(index);
	
	var buttonScene = load(upgradeButton.resource_path);
	for upgrade in shownUpgrades:
		var button = buttonScene.instantiate();
		button.SetModifier(0, upgrade);
		buttonContainer.add_child(button);
