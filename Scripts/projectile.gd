extends Area3D

@export var positionBounds: float;

@onready var projectileData = $ProjectileData;
@onready var speed = projectileData.speed;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var vel = Vector3(0, 0, speed * delta)
	position += vel;
	
	if position.z > 80:
		queue_free()
		return
