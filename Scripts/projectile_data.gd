extends Node

@export var damage: int
@export var pierce: int
@export var speed: float

@export var enemyDamageParticles: PackedScene;

func _on_projectile_area_entered(area: Area3D) -> void:
	if area.has_node("EnemyData"):
		area.get_node("EnemyData").Damage(damage);
		
		var particles = enemyDamageParticles.instantiate();
		particles.get_node("Particles").UpdatePathFollowData(area);
		particles.get_node("Particles").emitting = true;
		
		get_tree().root.add_child(particles);
	
	pierce -= 1;
	if pierce <= 0:
		get_parent().queue_free()
		return
