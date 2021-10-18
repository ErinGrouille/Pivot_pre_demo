extends Area

func _on_Player_player_took_triangle():
	get_node(".").visible = false

func _on_Player_player_deposited_triangle(x, y, z):
	get_node(".").visible = true
	get_node(".").transform.origin.x = x
	get_node(".").transform.origin.y = y
	get_node(".").transform.origin.z = z

func _on_Player_erase_triangle():
	queue_free()
