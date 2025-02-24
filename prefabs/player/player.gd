extends RigidBody3D

var target_pos: Vector3

func _physics_process(_delta):
	var direction: Vector3

func _on_node_3d_move_to(target: Vector3) -> void:
	target_pos = Vector3(target.x, position.y, target.z)
	print(target)
