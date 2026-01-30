extends "res://Scripts/attack_modifier_effect.gd"

@export var sizeIncrease: float;
@export var additionalSizePerTier: float;

func ModifyProjectile(data: Node) -> void:
	var scaleVec = Vector3(1, 1, 1) * GetVal();
	data.get_parent().scale += scaleVec;

func GetVal() -> float:
	return (sizeIncrease + (additionalSizePerTier * (tier - 1)));

func GetDescription() -> String:
	return "Increase projectile size by %0.1fx" % GetVal();
