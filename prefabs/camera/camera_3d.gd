extends Camera3D
var camera_speed = 1.5
var scroll_speed = 0.6
var grid_size

func _ready() -> void:
	grid_size = get_parent_node_3d().grid_size

func _process(_delta):
	if Input.is_action_pressed("front") and position.z > 10:
		position.z -= camera_speed
	if Input.is_action_pressed("down") and position.z < grid_size + 10 :
		position.z += camera_speed
	if Input.is_action_pressed("left") and position.x > 10:
		position.x -= camera_speed
	if Input.is_action_pressed("right") and position.x < grid_size - 10:
		position.x += camera_speed
		
	if Input.is_action_just_pressed("zoom_in") and position.y > 5:
		position.y -= scroll_speed
	if Input.is_action_just_pressed("zoom_out") and position.y < 30:
		position.y += scroll_speed
		
