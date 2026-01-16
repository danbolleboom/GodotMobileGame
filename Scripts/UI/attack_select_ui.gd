extends Control

var attacks: Array[Node];
@onready var attacksContainer: BoxContainer = $Attacks

@export var attackButtonTscn: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var packedAttacks = Constants.LoadScenesInFile("Scenes/PlayerAttacks");
	
	for attack in packedAttacks:
		var attackLoaded = load(attack.resource_path).instantiate();
		var data = attackLoaded.get_node("AttackData")
		
		var button = attackButtonTscn.instantiate();
		button.SetAttack(attack);
		
		print("Attack: " + data.attackName + "\n - " + data.attackDescription);
		attacks.append(attackLoaded);
		
		attacksContainer.add_child(button);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
