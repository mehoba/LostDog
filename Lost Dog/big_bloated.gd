extends KinematicBody2D


var velocity = Vector2()
var direction = -1
var speed= 50
export var detect_cliffs= true
onready var bullet = preload("res://bullet.tscn")
var b 

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled= detect_cliffs
	if $VisibilityNotifier2D.is_on_screen():
		$bulletTimer.start()




func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and detect_cliffs and is_on_floor():
		direction= direction * -1
		$bulletTimer.stop()
		$AnimatedSprite.flip_h= not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		if $VisibilityNotifier2D.is_on_screen():
			$bulletTimer.start()
	velocity.y = 100
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)



func shoot():
	get_tree().get_root().add_child(b)
	if direction == -1:
		b.global_position=$bulletPosition.global_position
	elif direction == 1:
		b.global_position=$bulletPosition2.global_position



func _on_top_checker_body_entered(body):
	if body.name=="bullet":
		pass
	$AnimatedSprite.play("death")
	$top_checker.set_collision_layer_bit(5,false)
	$top_checker.set_collision_mask_bit(0,false)
	$side_checker.set_collision_layer_bit(5,false)
	$side_checker.set_collision_mask_bit(0,false)
	set_collision_layer_bit(5,false)
	set_collision_mask_bit(0,false)
	velocity.x=0
	velocity.y=0
	speed=1000
	direction=0
	
	$bulletTimer.stop()




func _on_side_checker_body_entered(body):
	body.hit()
	

func _on_bulletTimer_timeout():
	b=bullet.instance()
	if direction==-1:
		b.directionChange(1)
	else:
		b.directionChange(-1)
	shoot()

func _on_VisibilityNotifier2D_screen_entered():
	$bulletTimer.start()
	b=bullet.instance()
