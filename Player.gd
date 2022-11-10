extends KinematicBody2D 

const SPEED = 200
const UP = Vector2(0,-1)
const FLAP = 200
const MAXFALLSPEED = 200

var motion = Vector2()
var Pillar = preload("res://PILLARS.tscn")
var score = 0
var GRAVITY = 10
var pause = false

################################################################################ Main/player physics

func _physics_process(_delta):
	if pause == false:
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
			
		if Input.is_action_just_pressed("FLAP"):
			motion.y = -FLAP
			
		motion = move_and_slide(motion, UP)
		get_parent().get_parent().get_node("MainScene/CanvasLayer/SCORE").text = str(score)
		var Hscore = highscoreREAD()
		if Hscore >= score: 
			get_parent().get_parent().get_node("MainScene/CanvasLayer/HIGHSCORE").text = "highscore: "+ str(Hscore)
		else:
			get_parent().get_parent().get_node("MainScene/CanvasLayer/HIGHSCORE").text = "highscore: "+ str(score)


################################################################################ Pillars Resetter

func Pillar_reset():
	var Pillar_instance = Pillar.instance()
	var number = rand_range(5,50)
	var addsub = rand_range(1,4)
	Pillar_instance.position = Vector2(1080,rand_range(50,300))
	if addsub == 2:
		Pillar_instance.position += Vector2(0, number)	
	else:
		Pillar_instance.position -= Vector2(0, number)
	get_parent().call_deferred("add_child",Pillar_instance)

################################################################################ setget Pause func for Pillars.gd

func getpause(pause):
	return pause

################################################################################ Pillars Reseter - Collision

func _on_Resetter_body_entered(body):
	if body.name == "Pillars":
		body.queue_free()
		Pillar_reset()

################################################################################ Score Collision

func _on_HitBox_area_entered(area):
	if area.name == "Point":
		score += 1

################################################################################ Collision with Pillar Reseter

func _on_HitBox_body_entered(body):
	if body.name == "Pillars":
		highscoreWRITE(score)
		get_tree().reload_current_scene()

################################################################################ Off Screen Resetters

func _on_Lowresetter_body_entered(body):
	if body.name == "Player":
		highscoreWRITE(score)
		get_tree().reload_current_scene()


func _on_UPresetter_body_entered(body):
	if body.name == "Player":
		highscoreWRITE(score)
		get_tree().reload_current_scene()

################################################################################ Pause Button

func _on_Button_pressed():
	if pause == true:
		pause = false
	elif pause == false:
		pause = true 

################################################################################ Highscore- Read,Write

func highscoreREAD():
	var scorefile = File.new() 
	scorefile.open("res://assets/data.txt", File.READ)
	var highscore = int(scorefile.get_as_text())
	scorefile.close()
	return highscore


func highscoreWRITE(score):
	var highscore = highscoreREAD()
	if score > highscore:
		var scorefile = File.new()
		scorefile.open("res://assets/data.txt", File.WRITE)
		score = str(score)
		scorefile.store_string(score)
		scorefile.close()
		print(score, ":", highscore)

################################################################################ 
