extends Node3D

@export_flags_2d_physics var raycastLayerMask;
@export var movementLimits: Vector2;
@export var maxTilt: float;
@export var tiltReductionSpeed: float;
@export var startPosition: Vector3;
@export var entranceSpeed: float = 5.0;
@export var targetZ: float = -1.0;
var pointerPosition: float = 0;
var lastPosition: Vector3;
var tilt: float = 0;

@onready var playerData: Node = $PlayerData;

func _ready() -> void:
	position = startPosition;
	Constants.player = self;
	add_child(Constants.selectedAttack1.instantiate());

func GetHealthRatio() -> float:
	return playerData.currentHealth as float / playerData.maxHealth;

func _process(delta: float) -> void:
	if Constants.worldTimeScale == 0:
		return; # Game is paused
	delta *= Constants.worldTimeScale;
	
	# Lerp to z == 0
	position.z = lerp(position.z, targetZ, entranceSpeed * delta);
	
	pointerPosition = ScreenPointToRay().x;
	
	pointerPosition = clamp(pointerPosition, movementLimits.x, movementLimits.y);
	
	lastPosition = position;
	position = Vector3(pointerPosition, startPosition.y, position.z);
	
	var dif = lastPosition.x - position.x;
	if abs(dif) > abs(tilt): tilt = min(dif, maxTilt);
	else: tilt = lerp(tilt, 0.0, tiltReductionSpeed * delta);
	
	rotation = Vector3(0, 0, (tilt));

func ScreenPointToRay() -> Vector3:
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 200
	var params = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd, raycastLayerMask)
	
	var rayArray = spaceState.intersect_ray(params)
	
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
