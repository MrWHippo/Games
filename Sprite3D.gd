extends Sprite3D

const UP = Vector3(0 , 0 , 0)

var move = Vector3()



func _physics_process(delta):
	if Input.is_action_just_pressed("FLAP"):
		move.z += 1
	if Input.is_action_just_pressed("move_left"):
		move.x += 1
	if Input.is_action_just_pressed("move_right"):
		move.x += 1


move = move_and_slide(move, UP)

