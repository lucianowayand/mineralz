extends RigidBody3D

var path: PackedVector3Array = []
var speed = 5.0
var target_pos: Vector3

func _physics_process(_delta):
	move_and_collide(target_pos)

func _on_node_3d_move_to() -> void:
	target_pos = target_pos
	print(target_pos)
