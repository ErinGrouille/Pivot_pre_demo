extends Label

var score = 0
signal player_won

func _on_Player_erase_cube():
	score += 1
	text = "Score: %s" % score
	if score == 3:
		emit_signal("player_won")

func _on_Player_erase_ball():
	score += 1
	text = "Score: %s" % score
	if score == 3:
		emit_signal("player_won")

func _on_Player_erase_triangle():
	score += 1
	text = "Score: %s" % score
	if score == 3:
		emit_signal("player_won")
