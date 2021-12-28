extends KinematicBody2D


var velocity = Vector2()

func _on_Area2D_body_entered(body):
	body.dogFound()
