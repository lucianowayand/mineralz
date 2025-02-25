extends CharacterBody3D

var should_move: bool = false
var target_pos: Vector3
var direction: Vector3
var acceleration: float = 10
var speed: float = 2

func _ready() -> void:
	target_pos = global_position
	velocity = Vector3()

func _physics_process(delta):
	direction = target_pos - global_position
	direction = direction.normalized()

	if target_pos.distance_to(global_position) > 0.1 and should_move:
		velocity  = velocity.lerp(direction * speed, delta * acceleration)
	else:
		should_move = false
		velocity = Vector3()
		
	move_and_slide()

func _on_node_3d_move_to(target: Vector3) -> void:
	target_pos = target
	should_move = true
