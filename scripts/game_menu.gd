extends Control

#przyciski
func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
