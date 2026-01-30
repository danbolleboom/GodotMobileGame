extends "res://Scripts/attack_modifier_effect.gd"

@export var startPierceIncrease: int
@export var pierceIncreasePerTier: int;

func ModifyProjectile(data: Node) -> void:
	data.pierce += startPierceIncrease + (pierceIncreasePerTier * tier);

func GetDescription() -> String:
	return "Increases pierce by %d" % (startPierceIncrease + (pierceIncreasePerTier * tier));
