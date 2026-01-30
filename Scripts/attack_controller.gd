extends Node3D

@export var startCooldown: float = 0.5;
@export var projectileScene: PackedScene;
var attackTimer: float = 0;
var multishot: float = 0.0;

@onready var cooldown = startCooldown;

@onready var projectileLoaded = load(projectileScene.resource_path)

@onready var projectileParent = get_tree().root.get_node("World/ProjectileParent");

var modifiers: Array[Node];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Default();
	
	#AddModifier(load("res://Scenes/AttackModifiers/am_homing.tscn").instantiate());
	
	UpdateModifiers();

func Default() -> void:
	cooldown = startCooldown;
	multishot = 0.0;
	attackTimer = cooldown;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Constants.worldTimeScale == 0:
		return;
	delta *= Constants.worldTimeScale;
	
	for modifier in modifiers:
		modifier.Update(delta);
	
	attackTimer += delta;
	if attackTimer >= cooldown:
		attackTimer = 0
		Attack()
	pass

func Attack() -> void:
	var newProjectile = projectileLoaded.instantiate();
	newProjectile.position = global_position;
	
	# Apply modifiers
	for modifier in modifiers:
		modifier.ModifyProjectile(newProjectile);
	
	projectileParent.add_child(newProjectile);
	pass

func UpdateModifiers() -> void:
	Default();
	for modifier in modifiers:
		modifier.ModifyAttack(self);

func AddModifier(modifier: Node) -> void:
	modifiers.append(modifier);
	UpdateModifiers();
