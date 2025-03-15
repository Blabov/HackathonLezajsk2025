extends Control

var bottle_scene = preload("res://scenes/bottle.tscn")

#przyciski
func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_bottle_timer_timeout() -> void:
	var bottle = bottle_scene.instantiate()
	$Bottles.add_child(bottle)
	bottle.global_position = $BottlesSpawnPosition.global_position
	bottle.get_child(-1).start(14)
