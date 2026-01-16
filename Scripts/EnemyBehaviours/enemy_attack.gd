extends Node3D

@export var cooldown: float;
@export var projectileScene: PackedScene;

@onready var projectile = load(projectileScene.resource_path);
@onready var projectileParent = get_tree().root.get_node("World/ProjectileParent");

var timer: float = 0.0;

func _process(delta: float) -> void:
	timer += delta;
	if timer >= cooldown:
		timer -= cooldown;
		var newProjectile = projectile.instantiate();
		newProjectile.UpdatePathFollowData(get_parent());
		projectileParent.add_child(newProjectile);
