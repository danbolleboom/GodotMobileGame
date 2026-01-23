extends Control

@onready var traits: Label = $Container/Traits
@onready var affects: Label = $Container/Affects
@onready var affectsIcon: TextureRect = $Container/AffectsIcon
@onready var upgradeName: Label = $Container/VBoxContainer/UpgradeName
@onready var upgradeIcon: TextureRect = $Container/VBoxContainer/UpgradeIcon

var modifier: Node;
var slot: int;

func SetModifier(_slot: int, _modifier: Node) -> void:
	modifier = _modifier;
	slot = _slot;

func _ready() -> void:
	if modifier == null:
		queue_free();
		return;
	
	upgradeName.text = modifier.id;
	traits.text = modifier.GetDescription();
	
	var attackTemp: Node;
	
	if slot == 0: attackTemp = load(Constants.selectedAttack1.resource_path).instantiate();
	elif slot == 1: attackTemp = load(Constants.selectedAttack2.resource_path).instantiate();
	elif slot == 2: attackTemp = load(Constants.selectedAttack3.resource_path).instantiate();
	
	var attackData = attackTemp.get_node("AttackData");
	affects.text = "Affects: " + attackData.attackName;
	affectsIcon.texture = attackData.sprite;


func _on_button_button_up() -> void:
	Constants.player.get_child(3).AddModifier(modifier);
	Constants.uiManager.HideUpgrades();
