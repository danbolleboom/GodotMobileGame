extends Node

@export var startSpawnCooldown: float;
@export var cooldownMultiplierPerLevel: float
@export var startEnemiesPerLevel: int;
@export var enemiesIncreasePerLevel: int;

@onready var spawnCooldown: float = startSpawnCooldown;
@onready var enemiesPerLevel: int = startEnemiesPerLevel;

func UpdateData(_level: int) -> void:
	spawnCooldown = startSpawnCooldown * pow(cooldownMultiplierPerLevel, _level);
	enemiesPerLevel = startEnemiesPerLevel + (enemiesIncreasePerLevel * _level)

func LoadEnemies() -> void:
	pass
