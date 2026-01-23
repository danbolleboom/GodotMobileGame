extends Node

@export var playerScene: PackedScene;
@export var decorations: Array[PackedScene]

@onready var enemySpawnData = $EnemySpawnData;
@onready var enemiesParent = $Enemies;
@onready var mapData = $MapData;
@onready var decorationSpawnData = $DecorationSpawnData;
@onready var decorationsParent = $Decorations

@onready var player = load(playerScene.resource_path);

var enemies: Array[PackedScene]

var level: int = 0;
var spawnsThisLevel: int = 0;
var spawnTimer: float = 0;

var decorationSpawnTimer: float = 0;

var score: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Constants.enemyDeadCallback = Callable(self, "EnemyDied");
	Constants.gameDirector = self;
	
	# Load enemies
	enemies = Constants.LoadScenesInFile("Scenes/Enemies")

func EnemyDied(_cost: int) -> void:
	spawnsThisLevel += _cost;
	score += _cost;
	
	if spawnsThisLevel >= enemySpawnData.enemiesPerLevel:
		spawnsThisLevel -= enemySpawnData.enemiesPerLevel;
		level += 1;
		enemySpawnData.UpdateData(level);
		Constants.worldTimeScale = 0;
		Constants.uiManager.GetUpgrades();
	
	Constants.uiManager.game.SetLevelProgress(spawnsThisLevel as float / enemySpawnData.enemiesPerLevel);

func StartGame() -> void:
	Constants.gameActive = true;
	get_tree().root.get_node("World").add_child(player.instantiate());
	spawnsThisLevel = 0;
	level = 1;
	spawnTimer = 0;
	enemySpawnData.UpdateData(level);
	score = 0;
	
	Constants.uiManager.game.SetLevelProgress(0);
	
	# Remove old enemies
	for enemy in enemiesParent.get_children():
		enemy.queue_free()
	
	for projectile in get_tree().root.get_node("World/ProjectileParent").get_children():
		projectile.queue_free();
	

func EndGame() -> void:
	Constants.gameActive = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Constants.gameActive: 
		Constants.currentSpeed = lerp(Constants.currentSpeed, Constants.menuSpeed, 1 * delta);
	
	# Decorations
	decorationSpawnTimer += delta * (Constants.currentSpeed / Constants.baseSpeed);
	
	if decorationSpawnTimer > decorationSpawnData.spawnCooldown:
		for i in randi_range(decorationSpawnData.decorationsPerSpawn.x, decorationSpawnData.decorationsPerSpawn.y):
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
		var newEnemy = enemies[randi_range(0, enemies.size() - 1)].instantiate();
		newEnemy.xOffset = randf_range(-mapData.gameWidth / 2, mapData.gameWidth / 2);
		enemiesParent.add_child(newEnemy);
		
		spawnTimer -= enemySpawnData.spawnCooldown;
