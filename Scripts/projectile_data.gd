extends Node

@export var damage: int
@export var pierce: int
@export var speed: float
@export var spread: float;

@export var enemyDamageParticles: PackedScene;

var modifiers: Array[Node];

func _ready() -> void:
	get_parent().direction = Vector3(randf_range(-spread, spread), 0, 1).normalized();

func _on_projectile_area_entered(area: Area3D) -> void:
	if area.has_node("EnemyData"):
		area.get_node("EnemyData").Damage(damage);
		
		var particlesObject = enemyDamageParticles.instantiate();
		var particles = particlesObject.get_node("Particles");
		particlesObject.UpdatePathFollowData(area);
		particles.emitting = true;
		particlesObject.xOffset = get_parent().position.x;
		particlesObject.speedMultiplier = area.speedMultiplier;
		
		get_tree().root.add_child(particlesObject);
	
	if (area.has_node("EnemyProjectileData")):
		area.get_node("EnemyProjectileData").Damage(damage);
		
	
	pierce -= 1;
	if pierce <= 0:
		for modifier in modifiers:
			modifier.OnProjectileDestroyed(self);
		get_parent().queue_free()
		return

func Modify(modifiers: Node) -> void:
	speed = speed * modifiers.speedMutliplier;
	damage = damage + modifiers.damageAdditive;
	damage = damage * modifiers.damageMultiplier as int;
	spread = spread * modifiers.spreadMultiplier;
