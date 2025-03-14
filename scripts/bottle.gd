extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

var speed := 100
var state
var cursor_on_object := false

var rng = RandomNumberGenerator.new()

enum states{
	MOVING,
	FALLING
}

func _ready() -> void:
	state = states.MOVING
	randomize_sprite()

func _physics_process(delta: float) -> void:
	if state == states.MOVING:
		velocity.x = speed
		if Input.is_action_just_pressed("Click") and cursor_on_object:
			$CollisionShape2D.disabled = true
			state = states.FALLING
			velocity.x = rng.randi_range(-150,150)
			velocity.y = -600
			$LifeTimer.start(3)
	if state == states.FALLING:
		velocity += get_gravity() * 2 * delta
	move_and_slide()

func randomize_sprite() -> void:
	if rng.randf() < 0.33:
		sprite.texture = load("res://textures/defect" + str(rng.randi_range(0,2)) + ".png")
	

func _on_mouse_shape_entered(shape_idx: int) -> void:
	cursor_on_object = true

func _on_mouse_shape_exited(shape_idx: int) -> void:
	cursor_on_object = false

func _on_life_timer_timeout() -> void:
	queue_free()
