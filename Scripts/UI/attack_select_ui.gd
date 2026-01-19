extends Control

var attacks: Array[Node];
@onready var attacksContainer: BoxContainer = $Attacks;
@onready var slotSelection: ColorRect = $SlotSelection;
@export var slots: Array[Button];

@export var attackButtonTscn: PackedScene;

var currentSelection: PackedScene = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var packedAttacks = Constants.LoadScenesInFile("Scenes/PlayerAttacks");
	slotSelection.hide();
	
	for attack in packedAttacks:
		var attackLoaded = load(attack.resource_path).instantiate();
		var data = attackLoaded.get_node("AttackData")
		
		var button = attackButtonTscn.instantiate();
		button.SetAttack(attack);
		
		var buttonObject = button.get_child(0);
		buttonObject.icon = data.sprite;
		
		attacks.append(attackLoaded);
		
		attacksContainer.add_child(button);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func StartSelection(_attack: PackedScene) -> void:
	slotSelection.show();
	currentSelection = _attack;


func _on_slot_1_button_up() -> void:
	Constants.selectedAttack1 = currentSelection;
	UpdateSelectedAttack(0);
	slotSelection.hide();


func _on_slot_2_button_up() -> void:
	Constants.selectedAttack2 = currentSelection;
	UpdateSelectedAttack(1);
	slotSelection.hide();


func _on_slot_3_button_up() -> void:
	Constants.selectedAttack3 = currentSelection;
	UpdateSelectedAttack(2);
	slotSelection.hide();

func UpdateSelectedAttack(_index: int) -> void:
	var slot = slots[_index];
	if currentSelection == null: 
		slot.icon = null;
	else:
		var attackTemp = load(currentSelection.resource_path).instantiate();
		slot.icon = attackTemp.get_node("AttackData").sprite;
