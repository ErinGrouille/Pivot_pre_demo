extends Area

func _on_Player_player_took_cube():
	get_node(".").visible = false

func _on_Player_player_deposited_cube(x, y, z):
	get_node(".").visible = true
	get_node(".").transform.origin.x = x
	get_node(".").transform.origin.y = y
	get_node(".").transform.origin.z = z

func _on_Player_erase_cube():
	queue_free()
