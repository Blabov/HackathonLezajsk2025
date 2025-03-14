extends CharacterBody2D

var speed = GlobalVariables.speed

func _physics_process(delta: float) -> void:
	velocity.x = speed
	move_and_slide()

func _on_back_timer_timeout() -> void:
	position.x -= speed * 0.96
