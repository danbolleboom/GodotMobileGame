extends Node

@onready var levelText = $TopUI/LevelText;
@onready var progressBar: ProgressBar = $ProgressBar

@onready var gameDirector = get_tree().root.get_node("World/GameDirector")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	levelText.text = "Level: %d" % gameDirector.level; 

func SetLevelProgress(_fill: float) -> void:
	progressBar.value = _fill * 100;
