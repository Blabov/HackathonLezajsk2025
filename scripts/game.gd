extends Node2D

var player_health := 3
var bottle_scene = preload("res://scenes/bottle.tscn")

func _ready() -> void:
	GlobalVariables.score = 0
	GlobalVariables.speed = 100

func _process(_delta: float) -> void:
	if player_health <= 0:
		$GameOverScreen.visible = true
	GlobalVariables.speed = 100 + (100 * (0.30 * floor(GlobalVariables.score/10)))
	update_score_visibility()

func _on_bottle_timer_timeout() -> void:
	var bottle = bottle_scene.instantiate()
	$Bottles.add_child(bottle)
	bottle.global_position = $BottlesSpawnPosition.global_position
	if GlobalVariables.score <= 100:
		$BottleTimer.start(1 - GlobalVariables.score / 10)
	else: $BottleTimer.start(0.1)
	

func _on_delivery_place_body_entered(body: Node2D) -> void:
	if body.has_defect:
		damage_player(1)
	body.queue_free()

func _on_bottle_damage_player() -> void:
	damage_player(1)

func damage_player(amount):
	player_health -= amount
	$Gui.set_visible_health(player_health)

func update_score_visibility() -> void:
	$Board/Label.text = str(GlobalVariables.score)
