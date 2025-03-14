extends CharacterBody2D

var speed = GlobalVariables.speed

func _physics_process(_delta: float) -> void:
	speed = GlobalVariables.speed
	velocity.x = speed
	if position.x >= 1976:
		position.x = -3930
	move_and_slide()
