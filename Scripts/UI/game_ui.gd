extends Node

@onready var levelText = $TopUI/LevelText;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func UpdateLevel(_level: int) -> void:
	levelText.text = "Level: %d" % _level; 
