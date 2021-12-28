extends KinematicBody2D


var velocity = Vector2(0,0)
const SPEED = 200
const GRAVITY= 30
const JUMPFORCE = -600
var direction = 1 
var lifeCounter = 0


func _physics_process(delta):
	if Input.is_action_pressed("right"):
#		if direction == -1: 
#			$Sprite.flip_h = false
		direction = 1 
		velocity.x=SPEED * direction 
		$Sprite.play("run")
		if Input.is_action_pressed("up") and is_on_floor():
			velocity.y= JUMPFORCE
			$Sprite.play("jump")
		elif Input.is_action_pressed("down"):
			velocity.y= -JUMPFORCE
	elif Input.is_action_pressed("left"):
#		if direction == 1: 
#			$Sprite.flip_h= true
		direction = -1 
		velocity.x= SPEED * direction  
		$Sprite.play("run")
		if Input.is_action_pressed("up") and is_on_floor():
			velocity.y= JUMPFORCE
			$Sprite.play("jump")
		elif Input.is_action_pressed("down"):
			velocity.y= -JUMPFORCE
	elif Input.is_action_pressed("up") and is_on_floor():
		velocity.y= JUMPFORCE
		$Sprite.play("jump")
	elif Input.is_action_pressed("down"):
		velocity.y= -JUMPFORCE
	else:
		$Sprite.play("idle")
	velocity= move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.1)
	velocity.y=velocity.y+GRAVITY




func bounce():
	velocity.y = JUMPFORCE * 0.7 
	$Sprite.play("jump")

func hit():
	velocity.x = -SPEED
	velocity.y = JUMPFORCE * 0.7
	if lifeCounter == 0:
		get_tree().change_scene("res://gameOverScreen.tscn")
	$Sprite.modulate = Color(1,0,0)
	$Sprite.play("jump")
	$Timer.start()

func dogFound():
	get_tree().change_scene("res://winScreen.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://Start.tscn")


func _on_levelSwitch_body_entered(body):
	get_tree().change_scene("res://Level2.tscn")
	
func _on_fallZone_body_entered(body):
	get_tree().change_scene("res://Start.tscn")

func _on_fallZoneLevel2_body_entered(body):
	get_tree().change_scene("res://Level2.tscn")
	

