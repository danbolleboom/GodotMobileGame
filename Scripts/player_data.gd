extends Node

@export var immunityDuration: float;
@export var maxHealth: int;

@export var baseColour: Color;
@export var immuneColour: Color;

@onready var currentHealth = maxHealth;
@onready var mesh = $"../Mesh";

var immunityTimer: float = 0.0;
var immune: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Constants.uiManager.game.healthValue = currentHealth;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if immune:
		immunityTimer += delta;
		if immunityTimer >= immunityDuration:
			immune = false;
			mesh.get_surface_override_material(0).albedo_color = baseColour;

func Damage(_damage: int) -> void:
	if immune: return;
	
	currentHealth -= _damage;
	if currentHealth <= 0:
		Constants.uiManager.game.healthValue = 0;
		Die();
	else:
		Constants.uiManager.game.healthValue = currentHealth;
		immune = true;
		immunityTimer = 0;
		mesh.get_surface_override_material(0).albedo_color = immuneColour;

func Die() -> void:
	Constants.gameDirector.EndGame();
	Constants.uiManager.PlayerDie();
	get_parent().queue_free();
