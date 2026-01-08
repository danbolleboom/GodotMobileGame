extends Node3D

@export var startCooldown: float = 0.5;
@export var projectileScene: PackedScene;
var attackTimer: float = 0;

@onready var projectileLoaded = load(projectileScene.resource_path)

@onready var attackSource = $AttackSource;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attackTimer += delta;
	if attackTimer >= startCooldown:
		attackTimer = 0
		Attack()
	pass

func Attack() -> void:
	var newProjectile = projectileLoaded.instantiate();
	newProjectile.position = attackSource.global_position;
	get_tree().root.add_child(newProjectile);
	pass
