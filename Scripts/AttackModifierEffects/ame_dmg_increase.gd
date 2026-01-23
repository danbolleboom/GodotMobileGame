extends "res://Scripts/attack_modifier_effect.gd"

@export var damageAdditive: float;
@export var extraPerTier: float;

func ModifyProjectile(data: Node) -> void:
	data.damage += damageAdditive + (extraPerTier * tier);

func GetDmg() -> float:
	return damageAdditive + (extraPerTier * tier);

func GetDescription() -> String:
	return "Increase damage by %d per hit" % GetDmg();
