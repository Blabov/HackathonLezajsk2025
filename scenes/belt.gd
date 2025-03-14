extends CharacterBody2D

var speed = GlobalVariables.speed

func _physics_process(_delta: float) -> void:
	speed = GlobalVariables.speed
	velocity.x = speed
	if position.x >= 2040:
		position.x = -3817
	move_and_slide()
