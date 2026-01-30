extends Node3D

@export var randomRotation: bool;

@onready var parent = get_parent() as Node3D;

func _ready() -> void:
	if randomRotation: rotation.y = randf_range(0, 360);
