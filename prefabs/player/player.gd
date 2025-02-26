extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@export var speed: float = 5

func _physics_process(delta):
	var destination = navigation_agent_3d.get_next_path_position()
	
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * speed
	
	move_and_slide()

func _on_node_3d_move_to(target: Vector3) -> void:
	navigation_agent_3d.set_target_position(target)
