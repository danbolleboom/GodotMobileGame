extends Node3D

@export var startCooldown: float = 0.5;
@export var projectileScene: PackedScene;
var attackTimer: float = 0;

@onready var projectileLoaded = load(projectileScene.resource_path)

@onready var projectileParent = get_tree().root.get_node("World/ProjectileParent");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attackTimer += delta;
	if attackTimer >= startCooldown:
		attackTimer = 0
		Attack()
	pass

func Attack() -> void:
	var newProjectile = projectileLoaded.instantiate();
	newProjectile.position = global_position;
	projectileParent.add_child(newProjectile);
	pass
