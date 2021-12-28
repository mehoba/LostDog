extends KinematicBody2D
var direction=1 

func _physics_process(delta):
	position.x+=-10*direction
	
func directionChange(dirPar):
	direction=direction * dirPar
	
func _ready():
	pass # Replace with function body.




func _on_bulletArea_body_entered(body):
	queue_free()


