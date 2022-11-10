extends StaticBody2D 


func _physics_process(delta):
	var node = get_node("/root/MainScene/Player")
	var pause = node.pause
	if pause == false:
		position += Vector2(-2,0)
	
