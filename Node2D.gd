var velocity = Vector2(0,0)
var gravity = Vector2(0,-25)


func _physics_process(_delta):
	velocity.x = 0
	yield(get_tree().create_timer(1), "timeout")
	velocity.y -= gravity.y
	if Input. is_action_pressed("move_right"):
		velocity.x += SPEED
	if Input. is_action_pressed("move_left"):
		velocity.x -= SPEED
	if Input. is_action_pressed("jump"):
		velocity.y -= 200
		yield(get_tree().create_timer(0.25), "timeout")
		velocity.y = 0
	velocity = move_and_slide(velocity, Vector2.UP)
