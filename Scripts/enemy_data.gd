extends Node

@export var maxHealth: float;
@export var deathParticles: PackedScene;
@export var contactDamage: float;
@export var startLevel: int = 0; # Todo
@export var worth: int = 1;

@onready var currentHealth: float = maxHealth;

func Die() -> void:
	# Death fx
	var particles = deathParticles.instantiate();
	get_tree().root.add_child(particles);
	particles.position = get_parent().position;
	particles.get_node("Particles").emitting = true;
	
	Constants.enemyDeadCallback.call(worth);
	
	get_parent().queue_free()

func Damage(_damage: int) -> void:
	currentHealth -= _damage
	
	if currentHealth <= 0:
		Die()


func _on_area_area_entered(area: Area3D) -> void:
	print("Collide")
	if area.has_node("PlayerData"):
		area.get_node("PlayerData").Damage(contactDamage);
		print("Hit")
