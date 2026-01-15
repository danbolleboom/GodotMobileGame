extends Node3D

@export_flags_2d_physics var raycastLayerMask;
@export var movementLimits: Vector2;
@export var maxTilt: float;
@export var tiltReductionSpeed: float;
@export var startPosition: Vector3;
var pointerPosition: float = 0;
var lastPosition: Vector3;
var tilt: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = startPosition;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pointerPosition = ScreenPointToRay().x;
	
	pointerPosition = clamp(pointerPosition, movementLimits.x, movementLimits.y);
	
	lastPosition = position;
	position = startPosition + Vector3(pointerPosition, 0, 0);
	
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
