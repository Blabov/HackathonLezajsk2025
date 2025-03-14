extends Node2D

var player_health := 3

var bottle_scene = preload("res://scenes/bottle.tscn")

func _on_bottle_timer_timeout() -> void:
	var bottle = bottle_scene.instantiate()
	$Bottles.add_child(bottle)
	bottle.global_position = $BottlesSpawnPosition.global_position
	$BottleTimer.start(1)
	

func _on_delivery_place_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_bottle_damage_player() -> void:
	player_health -= 1
	$Gui.set_visible_health(player_health)
