extends Node

@export var maxHealth: float;
@export var deathParticles: PackedScene;

@onready var currentHealth: float = maxHealth;

func Die() -> void:
	# Death fx
	var particles = deathParticles.instantiate();
	get_tree().root.add_child(particles);
	particles.position = get_parent().position;
	particles.get_node("Particles").emitting = true;
	
	get_parent().queue_free()

func Damage(damage: int) -> void:
	currentHealth -= damage
	
	if currentHealth <= 0:
		Die()
