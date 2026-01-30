extends "res://Scripts/attack_modifier_effect.gd"

@export var turnSpeed: float;
var collided: Array[Node3D];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var target: Node3D;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func ProjectileUpdate(projectile: Node3D, delta: float) -> void:
	if target == null:
		for enemy in Constants.gameDirector.get_node("Enemies").get_children():
			if collided.count(enemy) > 0:
				continue;
			
			if target == null || target.position.distance_squared_to(projectile.position) >enemy.position.distance_squared_to(projectile.position):
					target = enemy;
	
	if target != null:
		var targetDir = target.position - projectile.position;
		targetDir.y = 0;
		var newDir: Vector3 = projectile.direction + (targetDir.normalized() * delta * turnSpeed);
		if newDir.length_squared() > 1:
			newDir = newDir.normalized();
		projectile.direction = newDir;

func GetDescription() -> String:
	return "Projectiles will seek enemies";
