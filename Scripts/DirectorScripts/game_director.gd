extends Node

@export var playerScene: PackedScene;
@export var enemies: Array[PackedScene]
@export var decorations: Array[PackedScene]

@export var test: Dictionary = { "key": "value" }

@onready var enemySpawnData = $EnemySpawnData;
@onready var enemiesParent = $Enemies;
@onready var mapData = $MapData;
@onready var decorationSpawnData = $DecorationSpawnData;
@onready var decorationsParent = $Decorations

@onready var player = load(playerScene.resource_path);

var level: int = 0;
var spawnsThisLevel: int = 0;
var spawnTimer: float = 0;

var decorationSpawnTimer: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Constants.enemyDeadCallback = Callable(self, "EnemyDied");
	Constants.gameDirector = self;

func EnemyDied(_cost: int) -> void:
		spawnsThisLevel += _cost;
		
		if spawnsThisLevel >= enemySpawnData.enemiesPerLevel:
			spawnsThisLevel -= enemySpawnData.enemiesPerLevel;
			level += 1;
			enemySpawnData.UpdateData(level);
		
		Constants.uiManager.game.SetLevelProgress(spawnsThisLevel as float / enemySpawnData.enemiesPerLevel);

func StartGame() -> void:
	Constants.gameActive = true;
	get_tree().root.get_node("World").add_child(player.instantiate());
	spawnsThisLevel = 0;
	level = 1;
	spawnTimer = 0;
	Constants.uiManager.game.SetLevelProgress(0);
	
	# Remove old enemies
	for enemy in enemiesParent.get_children():
		enemy.queue_free()
	

func EndGame() -> void:
	Constants.gameActive = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Constants.gameActive: 
		Constants.currentSpeed = lerp(Constants.currentSpeed, Constants.menuSpeed, 1 * delta);
	
	# Decorations
	decorationSpawnTimer += delta * (Constants.currentSpeed / Constants.baseSpeed);
	
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
	
	if !Constants.gameActive: return;
	
	Constants.currentSpeed = lerp(Constants.currentSpeed, Constants.baseSpeed, 1 * delta);
	# Enemies
	spawnTimer += delta;
	
	if spawnTimer >= enemySpawnData.spawnCooldown:
		var newEnemy = enemies[0].instantiate();
		newEnemy.xOffset = randf_range(-mapData.gameWidth / 2, mapData.gameWidth / 2);
		enemiesParent.add_child(newEnemy);
		
		spawnTimer -= enemySpawnData.spawnCooldown;
