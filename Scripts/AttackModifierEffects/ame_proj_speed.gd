extends "res://Scripts/attack_modifier_effect.gd"

@export var speedMultiplier: float;
@export var additionalMultPerTier: float;

func ModifyProjectile(data: Node) -> void:
	data.speed *= speedMultiplier + (additionalMultPerTier * (tier - 1));
