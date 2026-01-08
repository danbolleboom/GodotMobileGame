extends Area3D

@export var speed: float;
@export var xOffsetLimit: int = 2;
@export var yOffset: float;

var pathOffset = 0;

@onready var path = get_tree().root.get_node("Root/MovementPath") as Path3D;
@onready var xOffset: float = randf_range(-xOffsetLimit, xOffsetLimit);
@onready var point1Height = path.curve.get_point_position(0).y
@onready var enemyData = $EnemyData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pathOffset += delta * speed;
	var positionOnPath = path.curve.sample_baked(pathOffset);
	var horizontalOffset = Vector3(xOffset, 0, 0);
	var angle = deg_to_rad(abs(positionOnPath.y) / abs(point1Height) * 90);
	var verticalOffset = Vector3.UP.rotated(Vector3(1, 0, 0), angle) * yOffset;
	
	position = positionOnPath + horizontalOffset + verticalOffset;
	rotation = Vector3(angle, 0, 0);

func Damage(damage: int) -> void:
	enemyData.Damage(damage)
