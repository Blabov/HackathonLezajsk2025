extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var game := get_node("/root/Game")

var speed := GlobalVariables.speed
var state
var cursor_on_object := false
var has_defect := false

var rng = RandomNumberGenerator.new()

signal damage_player

enum states{
	MOVING,
	FALLING
}

func _ready() -> void:
	state = states.MOVING
	self.damage_player.connect(game._on_bottle_damage_player)
	if rng.randf() < 0.33:
		sprite.texture = load("res://textures/defect" + str(rng.randi_range(0,4)) + ".png")
		has_defect = true


func _physics_process(delta: float) -> void:
	if state == states.MOVING:
		velocity.x = speed
		if Input.is_action_just_pressed("Click") and cursor_on_object:
			if !has_defect:
				damage_player.emit()
			$CollisionShape2D.disabled = true
			state = states.FALLING
			velocity.x = rng.randi_range(-150,150)
			velocity.y = -600
			$LifeTimer.start(3)
	if state == states.FALLING:
		velocity += get_gravity() * 2 * delta
	move_and_slide()

func _on_mouse_shape_entered(shape_idx: int) -> void:
	cursor_on_object = true

func _on_mouse_shape_exited(shape_idx: int) -> void:
	cursor_on_object = false

func _on_life_timer_timeout() -> void:
	queue_free()
