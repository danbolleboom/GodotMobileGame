extends "res://Scripts/attack_modifier_effect.gd"

@export var speedMultiplier: float;
@export var additionalMultPerTier: float;

func ModifyAttack(attack: Node) -> void:
	attack.cooldown *= GetMult();

func GetMult() -> float:
	return speedMultiplier - (additionalMultPerTier * (tier - 1));

func GetDescription() -> String:
	return "%s attack by %0.0f percent" % [ "Increase" if speedMultiplier > 1 else "Reduce", abs((1 - GetMult()) * 100)];
