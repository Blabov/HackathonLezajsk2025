extends Node2D

var player_health := 3
var bottle_scene = preload("res://scenes/bottle.tscn")

func _ready() -> void:
	GlobalVariables.score = 0
	GlobalVariables.speed = 100
	if GlobalVariables.high_score > 0:
		$Board/VBoxContainer/HighScore.visible = true

func _process(_delta: float) -> void:
	if player_health <= 0:
		GlobalVariables.high_score = GlobalVariables.score
		$GameOverScreen.visible = true
	GlobalVariables.speed = 100 + (100 * (0.30 * floor(GlobalVariables.score/10)))
	update_score_visibility()

func _on_bottle_timer_timeout() -> void:
	var bottle = bottle_scene.instantiate()
	$Bottles.add_child(bottle)
	bottle.in_main_menu = false
	bottle.global_position = $BottlesSpawnPosition.global_position
	if GlobalVariables.score >= 90:
		$Timers/BottleTimer.start(0.3)
	else: $Timers/BottleTimer.start(1.0 - (float(GlobalVariables.score) / 200.0))

func _on_delivery_place_body_entered(body: Node2D) -> void:
	if body.has_defect and player_health > 0:
		damage_player(1)
		$ScreenEffect.damage_effect()
	body.queue_free()

func _on_bottle_damage_player() -> void:
	damage_player(1)
	$ScreenEffect.damage_effect()

func damage_player(amount):
	player_health -= amount
	$Gui.set_visible_health(player_health)

func update_score_visibility() -> void:
	$Board/VBoxContainer/Score/Score.text = str(GlobalVariables.score)
	$Board/VBoxContainer/HighScore/HighScore.text = str(GlobalVariables.high_score)
