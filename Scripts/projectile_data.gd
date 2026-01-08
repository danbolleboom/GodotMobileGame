extends Node

@export var damage: int
@export var pierce: int
@export var speed: float

func _on_projectile_area_entered(area: Area3D) -> void:
	if area.has_method("Damage"):
		area.Damage(damage);
	
	pierce -= 1;
	if pierce <= 0:
		queue_free()
		return
