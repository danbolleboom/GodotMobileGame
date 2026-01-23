extends Node

@export var id: String;
var tier: int;

var lifetime = 0;
var uptime = 0;

func SetTier(newTier: int) -> void:
	tier = newTier;
	
	for child in get_children():
		child.tier = tier;

func ModifyProjectile(projectile: Node) -> void:
	var data = projectile.get_node("ProjectileData");
	
	for child in get_children():
		child.ModifyProjectile(data);
	
	data.modifiers.append(self);

func ModifyAttack(attack: Node) -> void:
	for child in get_children():
		child.ModifyAttack(attack);

func OnProjectileDestroyed(projectileData: Node) -> void:
	for child in get_children():
		child.OnProjectileDestroyed(projectileData);

func _process(delta: float) -> void:
	uptime += delta;

func RemoveModifier() -> bool:
	if lifetime == 0: return false;
	return uptime >= lifetime;
