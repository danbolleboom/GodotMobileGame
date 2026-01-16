extends Node

@export var lerpSpeed: float = 10.0;

@onready var levelText = $TopUI/LevelText;
@onready var progressBar: ProgressBar = $ProgressBar
@onready var healthBar: ProgressBar = $HealthBar

@onready var gameDirector = get_tree().root.get_node("World/GameDirector")

var levelValue: float = 0.0;
var healthValue: float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	levelText.text = "Level: %d" % gameDirector.level;
	
	# Lerp values
	progressBar.value = lerp(progressBar.value, levelValue, lerpSpeed * delta);
	healthBar.value = lerp(healthBar.value, healthValue, lerpSpeed * delta); # healthValue is set externally by player_data.gd

func SetLevelProgress(_fill: float) -> void:
	levelValue = _fill * 100;
