extends GridMap

@onready var grid_size = get_parent_node_3d().get_parent_node_3d().grid_size
@onready var middle_threshold = get_parent_node_3d().get_parent_node_3d().middle_threshold
@export var crystal_rarity = 0.01
@export var stone_rarity = 0.2

func _ready() -> void:
	bake_map()
	
func bake_map() -> void:
	var border_wall_thickness = grid_size
	var middle = grid_size / 2
	
	for i in range(grid_size + border_wall_thickness * 2):
		for j in range(grid_size + border_wall_thickness * 2):
			if i < border_wall_thickness or i >= grid_size + border_wall_thickness or \
			   j < border_wall_thickness or j >= grid_size + border_wall_thickness:
				set_cell_item(Vector3(i - border_wall_thickness, 0, j - border_wall_thickness), 6)
	
	
	for i in range(grid_size):
		for j in range(grid_size):
			if abs(i - middle) < middle_threshold or abs(j - middle) < middle_threshold:
				continue 
			
			var tile_index = (i + j) % 2
			var chanceOfSpawning = randf_range(0,1)
			
			if(chanceOfSpawning <= stone_rarity):
				set_cell_item(Vector3(i, 0, j), tile_index)
	
	place_tiles_in_grid(crystal_rarity, 2)
	place_tiles_in_grid(crystal_rarity, 3)
	place_tiles_in_grid(crystal_rarity, 4)
	place_tiles_in_grid(crystal_rarity, 5)
	
func place_tiles_in_grid(spawning_threshold: float, tile_index: int):
	var middle = grid_size / 2
	
	for i in range(grid_size):
		for j in range(grid_size):
			if abs(i - middle) < middle_threshold or abs(j - middle) < middle_threshold:
				continue 
			
			var chanceOfSpawning = randf_range(0,1)
			var grid_bellow = get_cell_item(Vector3(i, 0, j))
			
			if(chanceOfSpawning <= spawning_threshold and grid_bellow == -1):
				set_cell_item(Vector3(i, 0, j), tile_index)
