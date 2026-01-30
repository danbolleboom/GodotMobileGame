extends Node

@export var damage: int
@export var pierce: int
@export var speed: float
@export var spread: float;

@export var enemyDamageParticles: PackedScene;

var modifiers: Array[Node];

func _ready() -> void:
	get_parent().direction = Vector3(randf_range(-spread, spread), 0, 1).normalized();

func _process(delta: float) -> void:
	delta *= Constants.worldTimeScale;
	
	for modifier in modifiers:
		modifier.ProjectileUpdate(get_parent(), delta);

func _on_projectile_area_entered(area: Area3D) -> void:
	if area.get_parent().has_node("EnemyData"):
		area.get_parent().get_node("EnemyData").Damage(damage);
		
		var particlesObject = enemyDamageParticles.instantiate();
		var particles = particlesObject.get_node("Particles");
		particlesObject.UpdatePathFollowData(area.get_parent());
		particles.emitting = true;
		particlesObject.xOffset = get_parent().position.x;
		particlesObject.speedMultiplier = area.get_parent().speedMultiplier;
		
		get_tree().root.add_child(particlesObject);
	
	if (area.get_parent().has_node("EnemyProjectileData")):
		area.get_parent().get_node("EnemyProjectileData").Damage(damage);
		
	
	pierce -= 1;
	if pierce <= 0:
		for modifier in modifiers:
			modifier.OnProjectileDestroyed(self);
		get_parent().queue_free()
		return

func Modify(modifier: Node) -> void:
	speed = speed * modifier.speedMutliplier;
	damage = damage + modifier.damageAdditive;
	damage = damage * modifier.damageMultiplier as int;
	spread = spread * modifier.spreadMultiplier;
