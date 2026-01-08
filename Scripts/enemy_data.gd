extends Node

@export var maxHealth: float;

@onready var currentHealth: float = maxHealth;

func Die() -> void:
	# Todo: death fx
	get_parent().queue_free()

func Damage(damage: int) -> void:
	currentHealth -= damage
	
	if currentHealth <= 0:
		Die()
