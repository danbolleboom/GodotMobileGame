extends Node

@export var enemies: Array[PackedScene]
@export var decorations: Array[PackedScene]

@onready var enemySpawnData = $EnemySpawnData;
@onready var enemiesParent = $Enemies;
@onready var mapData = $MapData;
@onready var decorationSpawnData = $DecorationSpawnData;
@onready var decorationsParent = $Decorations

var level: int = 0;
var spawnsThisLevel: int = 0;
var spawnTimer: float = 0;

var decorationSpawnTimer: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Enemies
	spawnTimer += delta;
	
	if spawnTimer >= enemySpawnData.spawnCooldown:
		var newEnemy = enemies[0].instantiate();
		newEnemy.xOffset = randf_range(-mapData.gameWidth / 2, mapData.gameWidth / 2);
		enemiesParent.add_child(newEnemy);
		spawnsThisLevel += 1;
		
		if spawnsThisLevel >= enemySpawnData.enemiesPerLevel:
			level += 1;
			enemySpawnData.UpdateData(level);
		
		spawnTimer -= enemySpawnData.spawnCooldown;
	
	# Decorations
	decorationSpawnTimer += delta;
	
	if decorationSpawnTimer > decorationSpawnData.spawnCooldown:
		for i in randi_range(decorationSpawnData.decorationsPerSpawn.x, decorationSpawnData.decorationsPerSpawn.x):
			var newDecoration = decorations[randi_range(0, decorations.size() - 1)].instantiate();
			var spawnOffset = randf_range((mapData.gameWidth / 2) + mapData.gameBorderPadding, mapData.decorationAreaWidth / 2 - mapData.gameBorderPadding);
			if randi_range(0, 1) == 1:
				spawnOffset = -spawnOffset;
			
			newDecoration.xOffset = spawnOffset
			newDecoration.pathOffset = randf_range(0, decorationSpawnData.pathOffsetRange);
			decorationsParent.add_child(newDecoration)
		
		decorationSpawnTimer -= decorationSpawnData.spawnCooldown;
