extends "res://Scripts/attack_modifier_effect.gd"

@export var speedMultiplier: float;
@export var additionalMultPerTier: float;

func ModifyProjectile(data: Node) -> void:
	data.speed *= speedMultiplier + (additionalMultPerTier * (tier - 1));

func GetVal() -> float:
	return speedMultiplier + (additionalMultPerTier * (tier - 1));

func GetDescription() -> String:
	return "Increase projectile speed by %0.1fx" % (GetVal() - 1);
