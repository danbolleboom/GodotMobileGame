extends Node

@export var id: String;
@export var legendary: bool; # Todo: Legendary upgrades are rare, and you can only get one of them
@export var specificAttacks: Array[String]; # Todo: Upgrades for specific attacks, e.g. extra lightning chains
@export var blacklistedAttacks: Array[String]; # Todo: In case an ugprade causes a buggy interaction with an attack, or just does nothing
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

func Update(delta: float) -> void:
	uptime += delta;
	for child in get_children():
		child.Update(delta);

func RemoveModifier() -> bool:
	if lifetime == 0: return false;
	return uptime >= lifetime;

func GetDescription() -> String:
	var desc = "";
	for child in get_children():
		desc += "- " + child.GetDescription() + "\n";
	
	return desc;

func ProjectileUpdate(projectile: Node3D, delta: float):
	for child in get_children():
		child.ProjectileUpdate(projectile, delta);
