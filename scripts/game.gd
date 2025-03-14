extends Node2D

var bottle_scene = preload("res://scenes/bottle.tscn")

func _on_bottle_timer_timeout() -> void:
	var bottle = bottle_scene.instantiate()
	$Bottles.add_child(bottle)
	bottle.global_position = $BottlesSpawnPosition.global_position
	$BottleTimer.start(1)
	

func _on_delivery_place_body_entered(body: Node2D) -> void:
	body.queue_free()
