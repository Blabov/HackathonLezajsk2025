extends CharacterBody2D

@onready var belt_shake_timer: Timer = $"../Timers/BeltShakeTimer"


var speed = GlobalVariables.speed
var rng = RandomNumberGenerator.new()

signal belt_shake

func _process(delta: float) -> void:
	if GlobalVariables.score > 25 and belt_shake_timer.time_left == 0:
		belt_shake_timer.start(rng.randi_range(30,90))

func _physics_process(_delta: float) -> void:
	speed = GlobalVariables.speed
	velocity.x = speed
	if position.x >= 2040:
		position.x = -3817
	move_and_slide()

func _on_belt_shake_timer_timeout() -> void:
	belt_shake.emit()
