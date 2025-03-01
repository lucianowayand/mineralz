extends Node3D

var grid: GridMap
@export var grid_size = 250
@export var middle_threshold = 5
var camera: Camera3D
var movement_position: Vector3

func spawn_at(vector3d: Vector3):
	var scene = load("res://prefabs/ping/ping.tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
	scene_instance.set_name("movement_spot")
	scene_instance.global_position = vector3d

func _ready() -> void:
	camera = $Camera3D
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
		var position2D = get_viewport().get_mouse_position()
		var dropPlane = Plane(Vector3(0, 1, 0), 0.5)
		var ray_origin = camera.project_ray_origin(position2D)
		var ray_dir = camera.project_ray_normal(position2D)
		var position3D = dropPlane.intersects_ray(ray_origin, ray_dir)

		if position3D:
			movement_position = position3D
			emit_signal("move_to", movement_position)
			spawn_at(position3D)
