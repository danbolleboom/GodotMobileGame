extends Node

var tier: int;

func GetDescription() -> String:
	return "<no_description>";

func ModifyProjectile(data: Node) -> void:
	pass

func ModifyAttack(attack: Node) -> void:
	pass

func OnProjectileDestroyed(projectile: Node) -> void:
	pass

func Update(delta: float) -> void:
	pass
