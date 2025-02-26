extends NavigationRegion3D

func _ready():
	# Modify the GridMap dynamically
	$GridMap.set_cell_item(Vector3(0,0,2), 1)
	$GridMap.set_cell_item(Vector3(1,0,2), 1)
	$GridMap.set_cell_item(Vector3(2,0,2), 1)
	$GridMap.set_cell_item(Vector3(3,0,2), 1)
	$GridMap.set_cell_item(Vector3(-3,0,2), 1)
	$GridMap.set_cell_item(Vector3(-4,0,2), 1)
	
	$GridMap.set_cell_item(Vector3(0,0,-2), 1)
	$GridMap.set_cell_item(Vector3(1,0,-2), 1)
	$GridMap.set_cell_item(Vector3(0,0,-2), 1)
	$GridMap.set_cell_item(Vector3(-1,0,-2), 1)
	$GridMap.set_cell_item(Vector3(-2,0,-2), 1)
	$GridMap.set_cell_item(Vector3(-3,0,-2), 1)
	$GridMap.set_cell_item(Vector3(-4,0,-2), 1)
	
	# Ensure baking is complete before setting the target
	await get_tree().process_frame
	bake_navigation_mesh()

func _on_bake_finished() -> void:
	print("finished baking")
