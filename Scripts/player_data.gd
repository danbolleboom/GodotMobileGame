extends Node

@export var maxHealth: int;
@onready var currentHealth = maxHealth;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Damage(_damage: int) -> void:
	currentHealth -= _damage;
	if currentHealth <= 0:
		Die();

func Die() -> void:
	get_tree().reload_current_scene();
