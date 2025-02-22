extends CharacterBody3D

var path: PackedVector3Array = []
var speed = 5.0

func move_to(target_pos: Vector3):
	var parent = get_parent()
	path = parent.find_path(global_position, target_pos)

func _physics_process(delta):
	if path.size() > 0:
		var next_point = path[0]
		var direction = (next_point - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		if global_position.distance_to(next_point) < 0.5:
			path.remove_at(0)  # Remove reached point
