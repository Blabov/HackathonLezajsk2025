extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var game : Node 

var sticker_scene = preload("res://scenes/falling_sticker.tscn")

var speed := GlobalVariables.speed
var state
var cursor_on_object := false
var has_defect := false


var called := false
var rng = RandomNumberGenerator.new()

signal damage_player

enum states{
	MOVING,
	FALLING
}

func _ready() -> void:
	if get_node("/root/Game") != null:
		game = get_node("/root/Game")
	state = states.MOVING

	if game != null:
		self.damage_player.connect(game._on_bottle_damage_player)
	if rng.randf() < 0.33:
		sprite.texture = load("res://textures/defect" + str(rng.randi_range(0,4)) + ".png")
		has_defect = true
	$AudioStreamPlayer2D.stream = load("res://audio/bottle" + str(rng.randi_range(1,3)) + ".mp3")

func _physics_process(delta: float) -> void:
	if state == states.MOVING:
		velocity.x = speed
		if Input.is_action_just_pressed("Click") and cursor_on_object:
			if has_defect:
				GlobalVariables.score += 1
			else: damage_player.emit()
			$CollisionShape2D.disabled = true
			state = states.FALLING
			velocity.x = rng.randi_range(-150,150)
			velocity.y = -600
			$LifeTimer.start(3)
			$AudioStreamPlayer2D.play()
		if position.x > 0 and !called and !has_defect:
			called = true
			break_with_chance(0.1)
	if state == states.FALLING:
		velocity += get_gravity() * 2 * delta
		
	speed = GlobalVariables.speed
	move_and_slide()

func break_with_chance(chance) -> void:
	if rng.randf() < chance:
		has_defect = true
		sprite.texture = load("res://textures/defect0.png")
		var sticker = sticker_scene.instantiate()
		if get_node("/root/Game/Effects") != null:
			get_node("/root/Game/Effects").add_child(sticker)
	

func _on_mouse_shape_entered(_shape_idx: int) -> void:
	cursor_on_object = true

func _on_mouse_shape_exited(_shape_idx: int) -> void:
	cursor_on_object = false

func _on_life_timer_timeout() -> void:
	queue_free()
