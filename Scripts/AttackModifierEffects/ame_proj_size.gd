extends "res://Scripts/attack_modifier_effect.gd"

@export var sizeIncrease: float;
@export var additionalSizePerTier: float;

func ModifyProjectile(data: Node) -> void:
	var scaleVec = Vector3(1, 1, 1) * (sizeIncrease + (additionalSizePerTier * (tier - 1)));
	data.get_parent().scale += scaleVec;
