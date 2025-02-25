extends Node3D

var grid: GridMap
var grid_size = 250
var middle_threshold = 5
var camera: Camera3D
var movement_position: Vector3

func _ready() -> void:
	camera = $Camera3D

func spawn_at(vector3d: Vector3):
	var scene = load("res://prefabs/ping/ping.tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
	scene_instance.set_name("movement_spot")
	scene_instance.global_position = vector3d

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
