extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var cube_held = false
var ball_held = false
var triangle_held = false

signal player_took_cube
signal player_took_ball
signal player_took_triangle
signal player_deposited_cube(x, y, z)
signal player_deposited_ball(x, y, z)
signal player_deposited_triangle(x, y, z)
signal erase_cube
signal erase_ball
signal erase_triangle

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_pressed("deposit"):
		if cube_held == true:
			get_node("Pivot/Character/player_cube").visible = false
			cube_held = false
			var x = get_node("Pivot/Character/player_cube").global_transform.origin.x
			var y = get_node("Pivot/Character/player_cube").global_transform.origin.y
			var z = get_node("Pivot/Character/player_cube").global_transform.origin.z
			emit_signal("player_deposited_cube", x, y, z)
			return
		if ball_held == true:
			get_node("Pivot/Character/player_ball").visible = false
			ball_held = false
			var x = get_node("Pivot/Character/player_ball").global_transform.origin.x
			var y = get_node("Pivot/Character/player_ball").global_transform.origin.y
			var z = get_node("Pivot/Character/player_ball").global_transform.origin.z
			emit_signal("player_deposited_ball", x, y, z)
			return
		if triangle_held == true:
			get_node("Pivot/Character/player_triangle").visible = false
			triangle_held = false
			var x = get_node("Pivot/Character/player_triangle").global_transform.origin.x
			var y = get_node("Pivot/Character/player_triangle").global_transform.origin.y
			var z = get_node("Pivot/Character/player_triangle").global_transform.origin.z
			emit_signal("player_deposited_triangle", x, y, z)
			return
		print("Cannot deposit if not holding an item")

func _on_Cube_body_entered(body):
	if cube_held == false && ball_held == false && triangle_held == false:
		get_node("Pivot/Character/player_cube").visible = true
		cube_held = true
		emit_signal("player_took_cube")

func _on_Cube_receiver_body_entered(body):
	if cube_held == true:
		get_node("Pivot/Character/player_cube").visible = false
		cube_held = false
		emit_signal("erase_cube")
		return
	if ball_held == true:
		print("add loss here: ball is no cube")
		return
	if triangle_held == true:
		print("add loss here: triangle is no cube")

func _on_Ball_body_entered(body):
	if cube_held == false && ball_held == false && triangle_held == false:
		get_node("Pivot/Character/player_ball").visible = true
		ball_held = true
		emit_signal("player_took_ball")

func _on_Ball_receiver_body_entered(body):
	if ball_held == true:
		get_node("Pivot/Character/player_ball").visible = false
		ball_held = false
		emit_signal("erase_ball")
		return
	if cube_held == true:
		print("add loss here: cube is no ball")
		return
	if triangle_held == true:
		print("add loss here: triangle is no ball")

func _on_Triangle_body_entered(body):
	if cube_held == false && ball_held == false && triangle_held == false:
		get_node("Pivot/Character/player_triangle").visible = true
		triangle_held = true
		emit_signal("player_took_triangle")

func _on_Triangle_receiver_body_entered(body):
	if triangle_held == true:
		get_node("Pivot/Character/player_triangle").visible = false
		triangle_held = false
		emit_signal("erase_triangle")
		return
	if cube_held == true:
		print("add loss here: cube is no triangle")
		return
	if ball_held == true:
		print("add loss here: ball is no triangle")

