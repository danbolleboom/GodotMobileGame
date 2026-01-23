extends "res://Scripts/attack_modifier_effect.gd"

@export var speedMultiplier: float;
@export var additionalMultPerTier: float;

func ModifyAttack(attack: Node) -> void:
	attack.cooldown *= speedMultiplier - (additionalMultPerTier * (tier - 1));
