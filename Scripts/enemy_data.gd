extends Node

@export var maxHealth: float;
@export var deathParticles: PackedScene;
@export var contactDamage: float;

@onready var currentHealth: float = maxHealth;

var hitPlayer: bool = false;

func Die() -> void:
	# Death fx
	var particles = deathParticles.instantiate();
	get_tree().root.add_child(particles);
	particles.position = get_parent().position;
	particles.get_node("Particles").emitting = true;
	
	Constants.enemyDeadCallback.call(1);
	
	get_parent().queue_free()

func Damage(_damage: int) -> void:
	currentHealth -= _damage
	
	if currentHealth <= 0:
		Die()


func _on_enemy_area_entered(area: Area3D) -> void:
	if !hitPlayer && area.has_node("PlayerData"):
		area.get_node("PlayerData").Damage(contactDamage);
		hitPlayer = true;
