extends CPUParticles3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !emitting: get_parent().queue_free();

func UpdatePathFollowData(_parent: Node3D) -> void:
	var parent = get_parent();
	parent.speed = _parent.speed;
	parent.pathOffset = _parent.pathOffset;
	parent.yOffset = _parent.yOffset;
	parent.xOffset = _parent.xOffset;
