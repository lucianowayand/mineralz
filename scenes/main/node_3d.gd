extends Node3D

@export var grid_size = 250
@export var middle_threshold = 5
@onready var camera = $Camera3D
@onready var grid = $NavigationRegion3D/GridMap
var movement_position: Vector3

func spawn_at(vector3d: Vector3):
	var scene = load("res://prefabs/ping/ping.tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
	scene_instance.set_name("movement_spot")
	scene_instance.global_position = vector3d

func _ready() -> void:
	var midpoint = grid_size / 2
	var midpoint_position = Vector3(midpoint, 0, midpoint)
	camera.position = Vector3(midpoint, camera.position.y, midpoint + 15)
	$NavigationRegion3D/Miner.position = midpoint_position
	$NavigationRegion3D/Floor.position = Vector3(midpoint, -0.5, midpoint)
	$NavigationRegion3D/Floor.size = Vector3(grid_size, 1, grid_size)

func _process(_delta: float) -> void:
	var camera_position = camera.position
	$Label.text = "({x},{y},{z})".format({
		"x": ceilf(camera_position.x),
		"y": ceilf(camera_position.y),
		"z": ceilf(camera_position.z)
	})

signal move_to

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var position3D = get_clicked_position()
		var position = get_clicked_position()
		print(grid.get_cell_item(position))
		if position3D and grid.get_cell_item(position) == -1:
			movement_position = position3D
			emit_signal("move_to", movement_position)
			spawn_at(position3D)
			
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var position = get_clicked_position()
		print(grid.get_cell_item(position))
			
func get_clicked_position():
	var position2D = get_viewport().get_mouse_position()
	var dropPlane = Plane(Vector3(0, 1, 0), 0)
	var ray_origin = camera.project_ray_origin(position2D)
	var ray_dir = camera.project_ray_normal(position2D)
	var position3D = dropPlane.intersects_ray(ray_origin, ray_dir)

	return position3D
