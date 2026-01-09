extends Area3D

@export var speed: float;
@export var yOffset: float;


@onready var path = get_tree().root.get_node("Root/MovementPath") as Path3D;
@onready var xOffset: float;
@onready var point1Height = path.curve.get_point_position(0).y

var xOffsetLimit: int = 2;
var pathOffset = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Spawn below map so it doesn't pop in at (0, 0, 0)
	position = Vector3(0, -10, 0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pathOffset += delta * speed;
	
	if pathOffset > path.curve.get_baked_length():
		queue_free();
		return;
	
	var positionOnPath = path.curve.sample_baked(pathOffset);
	var horizontalOffset = Vector3(xOffset, 0, 0);
	var angle = deg_to_rad(abs(positionOnPath.y) / abs(point1Height) * 90);
	var verticalOffset = Vector3.UP.rotated(Vector3(1, 0, 0), angle) * yOffset;
	
	position = positionOnPath + horizontalOffset + verticalOffset;
	rotation = Vector3(angle, 0, 0);
