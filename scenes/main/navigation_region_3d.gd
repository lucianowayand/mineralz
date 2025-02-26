extends NavigationRegion3D
	
var time_start = 0
	
func _on_bake_finished() -> void:
	print("Finished baking, took: ", (Time.get_ticks_msec() - time_start)/1000, "s")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		time_start = Time.get_ticks_msec()
		bake_navigation_mesh()
