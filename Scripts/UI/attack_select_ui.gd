extends Control

var attacks: Array[Node];
@onready var attacksContainer: BoxContainer = $Attacks;
@onready var slotSelection: ColorRect = $SelectionBlocker;
@export var slots: Array[Button];

@export var attackButtonTscn: PackedScene;

var currentSelection: PackedScene = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var packedAttacks = Constants.LoadScenesInFile("Scenes/PlayerAttacks");
	SetAttackButtonsInteractable(false);
	slotSelection.hide();
	slotSelection.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	for attack in packedAttacks:
		var attackLoaded = load(attack.resource_path).instantiate();
		var data = attackLoaded.get_node("AttackData")
		
		var button = attackButtonTscn.instantiate();
		button.SetAttack(attack);
		
		var buttonObject = button.get_child(0);
		buttonObject.icon = data.sprite;
		
		attacks.append(attackLoaded);
		
		attacksContainer.add_child(button);


func SetAttackButtonsInteractable(interactable: bool) -> void:
	for button in slots:
		button.disabled = !interactable;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func StartSelection(_attack: PackedScene) -> void:
	slotSelection.show();
	slotSelection.mouse_filter = Control.MOUSE_FILTER_STOP
	currentSelection = _attack;
	SetAttackButtonsInteractable(true);


func _on_slot_1_button_up() -> void:
	Constants.selectedAttack1 = currentSelection;
	UpdateSelectedAttack(0);


func _on_slot_2_button_up() -> void:
	Constants.selectedAttack2 = currentSelection;
	UpdateSelectedAttack(1);


func _on_slot_3_button_up() -> void:
	Constants.selectedAttack3 = currentSelection;
	UpdateSelectedAttack(2);

func UpdateSelectedAttack(_index: int) -> void:
	var slot = slots[_index];
	if currentSelection == null: 
		slot.icon = null;
	else:
		var attackTemp = load(currentSelection.resource_path).instantiate();
		slot.icon = attackTemp.get_node("AttackData").sprite;
		slot.get_parent().get_child(1).text = attackTemp.get_node("AttackData").attackName;
	
	SetAttackButtonsInteractable(false);
	slotSelection.hide();
	slotSelection.mouse_filter = Control.MOUSE_FILTER_IGNORE
