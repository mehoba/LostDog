extends KinematicBody2D


var velocity = Vector2()
var direction = -1
var speed= 100
export var detect_cliffs= true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled= detect_cliffs
	
func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and detect_cliffs and is_on_floor():
		direction= direction * -1
		$AnimatedSprite.flip_h= not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y = 50
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)



func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("death")
	speed=0
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
	body.bounce()



func _on_side_checker_body_entered(body):
	body.hit()
	



