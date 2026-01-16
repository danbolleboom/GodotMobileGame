extends Node

@export var maxHealth: int;
@onready var currentHealth = maxHealth;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Constants.uiManager.game.healthValue = currentHealth;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Damage(_damage: int) -> void:
	currentHealth -= _damage;
	if currentHealth <= 0:
		Constants.uiManager.game.healthValue = 0;
		Die();
	else:
		Constants.uiManager.game.healthValue = currentHealth;

func Die() -> void:
	Constants.gameDirector.EndGame();
	Constants.uiManager.PlayerDie();
	get_parent().queue_free();


func _on_player_area_entered(area: Area3D) -> void:
	if area.has_node("EnemyData"):
		Damage(area.get_node("EnemyData").contactDamage);
	else:
		# Todo: powerups/pickups
		pass
